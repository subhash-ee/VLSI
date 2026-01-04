#Read cells from liberty file as modules into current design

read_liberty -lib -ignore_miss_dir -setattr blackbox /mnt/d/VLSI/Projects/NangateOpenCellLibrary_typical.lib

#Load modules from a verilog file to the current design

read_verilog CSA.v

#check, expand and clean up design hierarchy (Elaborate the design hierarchy)

hierarchy -check -top csa_16

#Convert "processes" (the internal representation of behavioral Verilog code) into multiplexers and registers

proc

#Perform some basic optimizations and cleanups

opt

#Analyze and optimize finite state machine

fsm

#Perform some basic optimizations and cleanups

opt

#Analyze memories and create circuits to implement them

memory

#Perform some basic optimizations and cleanups

opt

#Map coarse-grain RTL cells (adders,etc.) to fine-grain logic gates, (AND, OR, NOT, etc.)

techmap

#Perform some basic optimizations and cleanups

opt

#Map registers to available hardware flip-flops and cleanups

dfflibmap -liberty /mnt/d/VLSI/Projects/NangateOpenCellLibrary_typical.lib

#Perform some basic optimizations and cleanups

opt

#Map logic to available hardware gates

abc -liberty /mnt/d/VLSI/Projects/NangateOpenCellLibrary_typical.lib

#flatten design

flatten

#replace undef values with defined constants

setundef -zero

#remove unused cells and wires

clean -purge

#technology mapping of i/o pads (or buffers)

iopadmap -outpad BUF_X2 A:Z -bits

#Perform some basic optimizations and cleanups

opt

#remove unused cells and wires

clean

#print some statistics 

stat -liberty /mnt/d/VLSI/Projects/NangateOpenCellLibrary_typical.lib

#rename object in the design 
#Assign short auto-generated names to all selected wires and cells with private names

rename -enumerate

#Write design to Verilog file (gate level design)

write_verilog -noattr CSA_gate_level.v

#Write design to BLIF file

write_blif -buf BUF_X2 A Z CSA_gate_level_mapped_withbuf.blif

#generate schematics using graphviz

show -stretch




















 




