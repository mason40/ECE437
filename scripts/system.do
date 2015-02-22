onerror {resume}
quietly virtual signal -install /system_tb/DUT/CPU/DP/HU { (context /system_tb/DUT/CPU/DP/HU )&{memwbout_opcode_5 , memwbout_opcode_4 , memwbout_opcode_3 , memwbout_opcode_2 , memwbout_opcode_1 , memwbout_opcode_0 }} memwb_op
quietly virtual signal -install /system_tb/DUT/CPU/DP/HU { (context /system_tb/DUT/CPU/DP/HU )&{idexout_opcode_5 , idexout_opcode_4 , idexout_opcode_3 , idexout_opcode_2 , idexout_opcode_1 , idexout_opcode_0 }} idex_op
quietly virtual signal -install /system_tb/DUT/CPU/DP/HU { (context /system_tb/DUT/CPU/DP/HU )&{exmemout_opcode_5 , exmemout_opcode_4 , exmemout_opcode_3 , exmemout_opcode_2 , exmemout_opcode_1 , exmemout_opcode_0 }} exmem_op
quietly virtual signal -install /system_tb/DUT/CPU/DP/HU { (context /system_tb/DUT/CPU/DP/HU )&{exmemout_branch_1 , exmemout_branch_0 }} br
quietly virtual signal -install /system_tb/DUT/CPU/DP/FD { (context /system_tb/DUT/CPU/DP/FD )&{ifidout_iload_31 , ifidout_iload_30 , ifidout_iload_29 , ifidout_iload_28 , ifidout_iload_27 , ifidout_iload_26 , ifidout_iload_25 , ifidout_iload_24 , ifidout_iload_23 , ifidout_iload_22 , ifidout_iload_21 , ifidout_iload_20 , ifidout_iload_19 , ifidout_iload_18 , ifidout_iload_17 , ifidout_iload_16 , ifidout_iload_15 , ifidout_iload_14 , ifidout_iload_13 , ifidout_iload_12 , ifidout_iload_11 , ifidout_iload_10 , ifidout_iload_9 , ifidout_iload_8 , ifidout_iload_7 , ifidout_iload_6 , ifidout_iload_5 , ifidout_iload_4 , ifidout_iload_3 , ifidout_iload_2 , ifidout_iload_1 , ifidout_iload_0 }} ifid_iload
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/nRST
add wave -noupdate /system_tb/CLK
add wave -noupdate -expand -group HU /system_tb/DUT/CPU/DP/HU/memwb_op
add wave -noupdate -expand -group HU /system_tb/DUT/CPU/DP/HU/lw
add wave -noupdate -expand -group HU /system_tb/DUT/CPU/DP/HU/ifid_en
add wave -noupdate -expand -group HU /system_tb/DUT/CPU/DP/HU/ri_enable
add wave -noupdate -expand -group HU /system_tb/DUT/CPU/DP/HU/pcpause
add wave -noupdate -expand -group HU /system_tb/DUT/CPU/DP/HU/idex_op
add wave -noupdate -expand -group HU /system_tb/DUT/CPU/DP/HU/idex_en
add wave -noupdate -expand -group HU /system_tb/DUT/CPU/DP/HU/exmem_op
add wave -noupdate -expand -group HU /system_tb/DUT/CPU/DP/HU/br
add wave -noupdate -expand -group HU /system_tb/DUT/CPU/DP/HU/exmem_flush
add wave -noupdate -expand -group HU /system_tb/DUT/CPU/DP/HU/exmem_en
add wave -noupdate /system_tb/DUT/CPU/DP/FD/ifid_iload
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {651373 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 202
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {961793 ps}
