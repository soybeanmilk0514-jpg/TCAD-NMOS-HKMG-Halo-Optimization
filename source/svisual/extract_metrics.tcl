#setdep @node|sdevice@
# Transcribed from the submitted code PDF.

set n @node|sdevice@
set status @[gproject::GetNodeStatus @node|sdevice@]@

if {[llength [list_plots Plot_IdVg]] == 0} {
  create_plot -1d -name Plot_IdVg
  select_plots Plot_IdVg
  set_plot_prop -hide_title -show_legend
  set_axis_prop -title_font_size 16 -scale_font_size 14
  set_axis_prop -axis x -title "Gate Voltage (V)" -type linear
  set_axis_prop -axis y -title "Drain Current (A/um)" -type log
  set_legend_prop -label_font_size 14 -location bottom_right
}

load_file @[relpath IdVg_Vdlin_n@node|sdevice@_des.plt]@ -name PLTlin($n)
load_file @[relpath IdVg_Vdsat_n@node|sdevice@_des.plt]@ -name PLTsat($n)
create_curve -name IdVg_lin($n) -dataset PLTlin($n) -axisX "gate InnerVoltage" -axisY "drain TotalCurrent"
create_curve -name IdVg_sat($n) -dataset PLTsat($n) -axisX "gate InnerVoltage" -axisY "drain TotalCurrent"
set_curve_prop IdVg_lin($n) -color blue -line_width 3 -line_style solid
set_curve_prop IdVg_sat($n) -color red -line_width 3 -line_style solid

proc findVgAtId { vList iList targetI } {
  set N [llength $vList]
  for { set k 0 } { $k < [expr {$N-1}] } { incr k } {
    set i0 [lindex $iList $k]
    set i1 [lindex $iList [expr {$k+1}]]
    set v0 [lindex $vList $k]
    set v1 [lindex $vList [expr {$k+1}]]
    set lo [expr {$i0 < $i1 ? $i0 : $i1}]
    set hi [expr {$i0 < $i1 ? $i1 : $i0}]
    if { $targetI >= $lo && $targetI <= $hi } {
      if { $i1 == $i0 } { return $v0 }
      return [expr {$v0 + ($v1-$v0) * ($targetI-$i0) / ($i1-$i0)}]
    }
  }
  return ""
}

proc safeVth { v i tag } {
  set varname Vt_$tag
  if { ![catch { ext::ExtractVtgm out= $varname name= $varname v= $v i= $i } err] } {
    upvar #0 $varname VtVar
    if { [info exists VtVar] } { return [list gm_para $VtVar] }
  }
  if { ![catch { ext::ExtractVtgm out= $varname name= $varname v= $v i= $i -method newton } err2] } {
    upvar #0 $varname VtVar
    if { [info exists VtVar] } { return [list gm_newton $VtVar] }
  }
  set Vth_cc [findVgAtId $v $i 1e-7]
  if { $Vth_cc != "" } { return [list cc_1e-7 $Vth_cc] }
  return [list FAIL -999.0]
}

if { $status == "done" } {
  load_library extract

  set Vg_lin [get_variable_data "gate OuterVoltage" -dataset PLTlin($n)]
  set Id_lin [get_variable_data "drain TotalCurrent" -dataset PLTlin($n)]
  set res_lin [safeVth $Vg_lin $Id_lin lin]
  set method_lin [lindex $res_lin 0]
  set Vt_lin [lindex $res_lin 1]
  catch { ext::ExtractSS out= SS_lin name= SS_lin v= $Vg_lin i= $Id_lin vo= [expr {abs($Vt_lin)/3.0 + 0.01}] }
  if { ![info exists SS_lin] } { set SS_lin -999.0 }
  catch { ext::ExtractExtremum out= Idmax_l name= Idmax_l x= $Vg_lin y= $Id_lin type= max }
  if { ![info exists Idmax_l] } { set Idmax_l 0.0 }

  set Vg_sat [get_variable_data "gate OuterVoltage" -dataset PLTsat($n)]
  set Id_sat [get_variable_data "drain TotalCurrent" -dataset PLTsat($n)]
  set res_sat [safeVth $Vg_sat $Id_sat sat]
  set method_sat [lindex $res_sat 0]
  set Vt_sat [lindex $res_sat 1]
  catch { ext::ExtractSS out= SS_sat name= SS_sat v= $Vg_sat i= $Id_sat vo= [expr {abs($Vt_sat)/3.0 + 0.01}] }
  if { ![info exists SS_sat] } { set SS_sat -999.0 }
  catch { ext::ExtractExtremum out= Idmax_s name= Idmax_s x= $Vg_sat y= $Id_sat type= max }
  catch { ext::ExtractExtremum out= Idmin_s name= Idmin_s x= $Vg_sat y= $Id_sat type= min }
  if { ![info exists Idmax_s] } { set Idmax_s 0.0 }
  if { ![info exists Idmin_s] } { set Idmin_s 1e-30 }

  set DIBL [expr {1000.0 * ($Vt_lin - $Vt_sat) / (1.0 - 0.05)}]
  set Ion_Ioff [expr {abs($Idmax_s) / (abs($Idmin_s) + 1e-30)}]

  catch { ext::ExtractValue -out SWB_Vt_lin -name Vt_lin -value $Vt_lin }
  catch { ext::ExtractValue -out SWB_Vt_sat -name Vt_sat -value $Vt_sat }
  catch { ext::ExtractValue -out SWB_DIBL -name DIBL_mVpV -value $DIBL }
  catch { ext::ExtractValue -out SWB_SS_lin -name SS_lin -value $SS_lin }
  catch { ext::ExtractValue -out SWB_SS_sat -name SS_sat -value $SS_sat }
  catch { ext::ExtractValue -out SWB_Idmax -name Idmax -value $Idmax_s }
  catch { ext::ExtractValue -out SWB_Ion_Ioff -name Ion_Ioff -value $Ion_Ioff }
  catch { ext::ExtractValue -out SWB_tox -name tox -value 0.0026 }
  catch { ext::ExtractValue -out SWB_Vtgm -name Vtgm -value $Vt_lin }
  catch { ext::ExtractValue -out SWB_Id -name Id -value $Idmax_l }
  catch { ext::ExtractValue -out SWB_SS -name SS -value $SS_lin }
  catch { ext::ExtractValue -out SWB_gm -name gm -value 0.0 }
}

if {[info exists runVisualizerNodesTogether]} {
  set_curve_prop IdVg_lin($n) -label "Vd=0.05 $legend" -line_style $line
  set_curve_prop IdVg_sat($n) -label "Vd=1.0 $legend" -line_style $line
}
