# ============================================================
# 60 nm class nMOSFET process flow
# Parameterized gate stack and junction engineering conditions
# Transcribed from the submitted code PDF.
# ============================================================
# @Lg@          = 0.06
# @NWell@       = 1e15
# @IL_tox@      = 0.0006
# @HK_tox@      = 0.0020
# @HK_mat@      = HfO2
# @LDD_dose@    = 5e13
# @LDD_energy@  = 10
# @Halo_dose@   = 1e13
# @Halo_energy@ = 20
# @Halo_tilt@   = 25

line x location= 0 spacing= 0.001 tag= top
line x location= 0.02 spacing= 0.005
line x location= 0.20 spacing= 0.02 tag= bottom
line y location= 0.0 spacing= 0.1*@Lg@ tag= left
line y location= 0.5*@Lg@ spacing= 0.05*@Lg@
line y location= 2*@Lg@ spacing= @Lg@ tag= right
region Silicon xlo= top xhi= bottom ylo= left yhi= right

init concentration= @NWell@ field= Boron slice.angle= 180 !DelayFullD
pdbSet Silicon Dopant DiffModel ChargedFermi
implant Boron dose= 2e13 energy= 80 tilt= 0
diffuse time= 10<min> temperature= 1000

pdbSet Oxide Grid perp.add.dist 0.0001
deposit material= {Oxide} type= isotropic thickness= @IL_tox@
deposit material= {@HK_mat@} type= isotropic thickness= @HK_tox@
deposit material= {TiN} type= isotropic thickness= 0.010
deposit material= {PolySilicon} type= anisotropic thickness= 0.100

mask name= gate left= -@Lg@/2 right= @Lg@/2
etch PolySilicon type= anisotropic thickness= 0.12 mask= gate
etch TiN type= anisotropic thickness= 0.012 mask= gate
etch @HK_mat@ type= anisotropic thickness= @HK_tox@+0.001 mask= gate
etch Oxide type= anisotropic thickness= @IL_tox@+0.0002 mask= gate

implant Boron dose= @Halo_dose@ energy= @Halo_energy@ tilt= @Halo_tilt@ rotation= 0
implant Boron dose= @Halo_dose@ energy= @Halo_energy@ tilt= @Halo_tilt@ rotation= 90
implant Boron dose= @Halo_dose@ energy= @Halo_energy@ tilt= @Halo_tilt@ rotation= 180
implant Boron dose= @Halo_dose@ energy= @Halo_energy@ tilt= @Halo_tilt@ rotation= 270

implant Arsenic dose= @LDD_dose@ energy= @LDD_energy@ tilt= 0

deposit material= {Nitride} type= isotropic thickness= 0.030
etch material= {Nitride} type= anisotropic thickness= 0.035

implant Arsenic dose= 5e15 energy= 30 tilt= 0
diffuse time= 10<s> temperature= 1050

deposit Aluminum type= anisotropic thickness= 0.05
mask name= contact left= @Lg@*1.2
etch Aluminum type= anisotropic thickness= 0.10 mask= contact

transform reflect left
contact name= substrate bottom
contact name= source point y= -@Lg@*1.5 x= -0.010 replace
contact name= drain point y= @Lg@*1.5 x= -0.010 replace
contact name= gate point y= 0 x= -0.050

struct tdr= n@node@ !Gas !interfaces
