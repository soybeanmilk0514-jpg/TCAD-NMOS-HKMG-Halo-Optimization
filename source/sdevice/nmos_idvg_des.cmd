# ============================================================
# nMOSFET electrical simulation setup
# Id-Vg extraction under two drain bias conditions
# Transcribed from the submitted code PDF.
# ============================================================
# @Gate_WF@   = 4.6
# @Vd_linear@ = 0.05
# @Vd_sat@    = 1.0
# @Vg_stop@   = 2.0

File {
  Grid = "@tdr@"
  Plot = "@tdrdat@"
  Current = "@plot@"
  Output = "@log@"
}

Electrode {
  { Name= "source" Voltage= 0.0 }
  { Name= "drain" Voltage= 0.0 }
  { Name= "gate" Voltage= 0.0 Workfunction= @Gate_WF@ }
  { Name= "substrate" Voltage= 0.0 }
}

Physics {
  EffectiveIntrinsicDensity( OldSlotboom )
}

Physics (Material= "Silicon") {
  Mobility ( PhuMob HighFieldSaturation Enormal )
  Recombination ( SRH( DopingDependence ) )
}

Plot {
  eDensity hDensity
  eCurrent hCurrent
  ElectricField/Vector
  Potential
  Doping eMobility
}

Math {
  Extrapolate
  Iterations= 20
  Notdamped= 50
  Method= ParDiSo
  RelErrControl
  ExitOnFailure
}

Solve {
  Coupled (Iterations= 100) { Poisson }
  Coupled { Poisson Electron Hole }

  Quasistationary (
    InitialStep= 0.1 Increment= 1.5
    MinStep= 1e-5 MaxStep= 0.5
    Goal { Name= "drain" Voltage= @Vd_linear@ }
  ) { Coupled { Poisson Electron Hole } }

  NewCurrentPrefix= "IdVg_Vdlinear_"
  Quasistationary (
    DoZero
    InitialStep= 0.01 Increment= 1.5
    MinStep= 1e-5 MaxStep= 0.05
    Goal { Name= "gate" Voltage= @Vg_stop@ }
  ) {
    Coupled { Poisson Electron Hole }
    CurrentPlot ( Time= (Range= (0 1) Intervals= 30) )
  }

  NewCurrentPrefix= "reset_"
  Quasistationary (
    InitialStep= 0.05 Increment= 1.3
    MinStep= 1e-5 MaxStep= 0.1
    Goal { Name= "gate" Voltage= 0.0 }
  ) { Coupled { Poisson Electron Hole } }

  Quasistationary (
    InitialStep= 0.05 Increment= 1.3
    MinStep= 1e-5 MaxStep= 0.2
    Goal { Name= "drain" Voltage= @Vd_sat@ }
  ) { Coupled { Poisson Electron Hole } }

  NewCurrentPrefix= "IdVg_Vdsat_"
  Quasistationary (
    DoZero
    InitialStep= 0.01 Increment= 1.5
    MinStep= 1e-5 MaxStep= 0.05
    Goal { Name= "gate" Voltage= @Vg_stop@ }
  ) {
    Coupled { Poisson Electron Hole }
    CurrentPlot ( Time= (Range= (0 1) Intervals= 30) )
  }
}
