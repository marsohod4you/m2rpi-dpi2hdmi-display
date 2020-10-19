## Generated SDC file "M2rpi.sdc"

## Copyright (C) 2020  Intel Corporation. All rights reserved.
## Your use of Intel Corporation's design tools, logic functions 
## and other software and tools, and any partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Intel Program License 
## Subscription Agreement, the Intel Quartus Prime License Agreement,
## the Intel FPGA IP License Agreement, or other applicable license
## agreement, including, without limitation, that your use is for
## the sole purpose of programming logic devices manufactured by
## Intel and sold by Intel or its authorized distributors.  Please
## refer to the applicable agreement for further details, at
## https://fpgasoftware.intel.com/eula.


## VENDOR  "Altera"
## PROGRAM "Quartus Prime"
## VERSION "Version 20.1.0 Build 711 06/05/2020 SJ Lite Edition"

## DATE    "Wed Oct 14 21:48:20 2020"

##
## DEVICE  "EP4CE6E22C8"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {OSC} -period 10.000 -waveform { 0.000 5.000 } [get_ports {OSC}]


#**************************************************************
# Create Generated Clock
#**************************************************************

create_generated_clock -name {clk74} -source [get_ports {OSC}] -multiply_by 37 -divide_by 50 -master_clock {OSC} [get_nets {mypll_inst|altpll_component|auto_generated|wire_pll1_clk[0]}] 
create_generated_clock -name {clk370} -source [get_ports {OSC}] -multiply_by 37 -divide_by 10 -master_clock {OSC} [get_nets {mypll_inst|altpll_component|auto_generated|wire_pll1_clk[1]}] 


#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************



#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************



#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

