@echo off

setlocal enableDelayedExpansion

set port=%portNumber%

set lane=0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15

set gen1=1
set gen2=1
set gen3=1
set preset=1


set wfm_path=%WaveformPath%
set sigtest_path=C:\"Program Files (x86)"\"SigTest 3.2.11"\

set sigtest=SigTest

set template1=PCIE_CEM_SYS_1_1\TX_SYS_CON.DAT
set template2=PCIE_2_0_SYS\DUAL_PORT_SYS_CON_225_PAT_CHK.dat
set template3=PCIE_3_0_SYS\PCIE_3_8GB_CEM_DUAL_PORT.dat



cd %sigtest_path%

echo start conversion, please wait...


:loop


if defined %port% call echo port detected && goto:SigTesting 



:SigTesting   
for %%A in (!port!) do (
  for %%B in (!lane!) do (

  rem echo N%%A_P01_d_LANE%%B


      IF NOT "%preset%"=="" @(
			      if exist %wfm_path%\port%%A\N%%A_P01_d_LANE%%B.wfm %sigtest% /P /d %wfm_path%\port%%A /s 
			      if exist %wfm_path%\port%%A\N%rd%_P01_d_LANE%%B_Math2.wfm %sigtest% /P /d %wfm_path%\port%%A /s
			     )

      IF NOT "%gen1%"=="" @(
			    if exist %wfm_path%\port%%A\N%%A_GEN1_LANE%%B.wfm  %Sigtest% /d %wfm_path%\port%%A /s N%%A_GEN1_LANE%%B.wfm /t %template1% /o port%%A.txt 
			    if exist %wfm_path%\port%%A\N%%A_GEN1_LANE%%B_Math2.wfm  %Sigtest% /d %wfm_path%\port%%A /s N%%A_GEN1_LANE%%B_Math2.wfm /t %template1% /o port%%A.txt
			   )  

      IF NOT "%gen2%"=="" @(
                            if exist %wfm_path%\port%%A\N%%A_GEN2_LANE%%B_35.wfm  %Sigtest% /d %wfm_path%\port%%A /s N%%A_GEN2_LANE%%B_35.wfm /cs CLOCK.wfm /t %template2% /o port%%A.txt 
                            if exist %wfm_path%\port%%A\N%%A_GEN2_LANE%%B_6.wfm   %Sigtest% /d %wfm_path%\port%%A /s N%%A_GEN2_LANE%%B_6.wfm /cs CLOCK.wfm /t %template2% /o port%%A.txt
                            if exist %wfm_path%\port%%A\N%%A_GEN2_LANE%%B.wfm   %Sigtest% /d %wfm_path%\port%%A /s N%%A_GEN2_LANE%%B.wfm /cs CLOCK.wfm /t %template2% /o port%%A.txt
			    if exist %wfm_path%\port%%A\N%%A_GEN2_LANE%%B_35_Math2.wfm  %Sigtest% /d %wfm_path%\port%%A /s N%%A_GEN2_LANE%%B_35_Math2.wfm /cs N%%A_GEN2_LANE%%B_35_Math1.wfm /t %template2% /o port%%A.txt 
                            if exist %wfm_path%\port%%A\N%%A_GEN2_LANE%%B_6_Math2.wfm   %Sigtest% /d %wfm_path%\port%%A /s N%%A_GEN2_LANE%%B_6_Math2.wfm /cs N%%A_GEN2_LANE%%B_6_Math1.wfm /t %template2% /o port%%A.txt
                            if exist %wfm_path%\port%%A\N%%A_GEN2_LANE%%B_Math2.wfm   %Sigtest% /d %wfm_path%\port%%A /s N%%A_GEN2_LANE%%B_Math2.wfm /cs N%%A_GEN2_LANE%%B_Math1.wfm /t %template2% /o port%%A.txt
                           )


      IF NOT "%gen3%"=="" @(
                     if exist %wfm_path%\port%%A\N%%A_P00_d_LANE%%B.wfm  %Sigtest% /d %wfm_path%\port%%A /s N%%A_P00_d_LANE%%B.wfm /cs CLOCK.wfm /t %template3% /o port%%A.txt 
                     if exist %wfm_path%\port%%A\N%%A_P07_d_LANE%%B.wfm  %Sigtest% /d %wfm_path%\port%%A /s N%%A_P07_d_LANE%%B.wfm /cs CLOCK.wfm /t %template3% /o port%%A.txt 
                     if exist %wfm_path%\port%%A\N%%A_P08_d_LANE%%B.wfm  %Sigtest% /d %wfm_path%\port%%A /s N%%A_P08_d_LANE%%B.wfm /cs CLOCK.wfm /t %template3% /o port%%A.txt 
                     if exist %wfm_path%\port%%A\N%%A_GEN3_LANE%%B.wfm  %Sigtest% /d %wfm_path%\port%%A /s N%%A_GEN3_LANE%%B.wfm /cs CLCOK.wfm /t %template3% /o port%%A.txt
                     if exist %wfm_path%\port%%A\N%%A_GEN3_LANE%%B_P00.wfm  %Sigtest% /d %wfm_path%\port%%A /s N%%A_GEN3_LANE%%B_P00.wfm /cs CLOCK.wfm /t %template3% /o port%%A.txt
                     if exist %wfm_path%\port%%A\N%%A_GEN3_LANE%%B_P07.wfm  %Sigtest% /d %wfm_path%\port%%A /s N%%A_GEN3_LANE%%B_P07.wfm /cs CLOCK.wfm /t %template3% /o port%%A.txt
                     if exist %wfm_path%\port%%A\N%%A_GEN3_LANE%%B_P08.wfm  %Sigtest% /d %wfm_path%\port%%A /s N%%A_GEN3_LANE%%B_P08.wfm /cs CLOCK.wfm /t %template3% /o port%%A.txt
                     if exist %wfm_path%\port%%A\N%%A_P00_d_LANE%%B_Math2.wfm  %Sigtest% /d %wfm_path%\port%%A /s N%%A_P00_d_LANE%%B_Math2.wfm /cs N%%A_P00_d_LANE%%B_Math1.wfm /t %template3% /o port%%A.txt 
                     if exist %wfm_path%\port%%A\N%%A_P07_d_LANE%%B_Math2.wfm  %Sigtest% /d %wfm_path%\port%%A /s N%%A_P07_d_LANE%%B_Math2.wfm /cs N%%A_P07_d_LANE%%B_Math1.wfm /t %template3% /o port%%A.txt 
                     if exist %wfm_path%\port%%A\N%%A_P08_d_LANE%%B_Math2.wfm  %Sigtest% /d %wfm_path%\port%%A /s N%%A_P08_d_LANE%%B_Math2.wfm /cs N%%A_P08_d_LANE%%B_Math1.wfm /t %template3% /o port%%A.txt 
                     if exist %wfm_path%\port%%A\N%%A_GEN3_LANE%%B_Math2.wfm  %Sigtest% /d %wfm_path%\port%%A /s N%%A_GEN3_LANE%%B_Math2.wfm /cs N%%A_GEN3_LANE%%B_Math1.wfm /t %template3% /o port%%A.txt
                     if exist %wfm_path%\port%%A\N%%A_GEN3_LANE%%B_P00_Math2.wfm  %Sigtest% /d %wfm_path%\port%%A /s N%%A_GEN3_LANE%%B_P00_Math2.wfm /cs N%%A_GEN3_LANE%%B_P00_Math1.wfm /t %template3% /o port%%A.txt
                     if exist %wfm_path%\port%%A\N%%A_GEN3_LANE%%B_P07_Math2.wfm  %Sigtest% /d %wfm_path%\port%%A /s N%%A_GEN3_LANE%%B_P07_Math2.wfm /cs N%%A_GEN3_LANE%%B_P07_Math1.wfm /t %template3% /o port%%A.txt
                     if exist %wfm_path%\port%%A\N%%A_GEN3_LANE%%B_P08_Math2.wfm  %Sigtest% /d %wfm_path%\port%%A /s N%%A_GEN3_LANE%%B_P08_Math2.wfm /cs N%%A_GEN3_LANE%%B_P08_Math1.wfm /t %template3% /o port%%A.txt 
                          )
      

   )
   
)



:end


rem pause