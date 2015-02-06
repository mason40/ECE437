onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/nRST
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/DUT/prif/ramREN
add wave -noupdate /system_tb/DUT/prif/ramWEN
add wave -noupdate /system_tb/DUT/prif/ramaddr
add wave -noupdate /system_tb/DUT/prif/ramstore
add wave -noupdate /system_tb/DUT/prif/ramload
add wave -noupdate /system_tb/DUT/prif/ramstate
add wave -noupdate /system_tb/DUT/CPU/DP/ruif/rdata
add wave -noupdate /system_tb/DUT/CPU/DP/ruif/iload
add wave -noupdate /system_tb/DUT/CPU/DP/ruif/dload
add wave -noupdate /system_tb/DUT/CPU/DP/ruif/ihit
add wave -noupdate /system_tb/DUT/CPU/DP/ruif/dhit
add wave -noupdate /system_tb/DUT/CPU/DP/ruif/iaddr
add wave -noupdate /system_tb/DUT/CPU/DP/ruif/daddr
add wave -noupdate /system_tb/DUT/CPU/DP/ruif/dstore
add wave -noupdate /system_tb/DUT/CPU/DP/ruif/iREN
add wave -noupdate /system_tb/DUT/CPU/DP/ruif/dREN
add wave -noupdate /system_tb/DUT/CPU/DP/ruif/dWEN
add wave -noupdate /system_tb/DUT/CPU/DP/RF/rfile
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/halt
add wave -noupdate /system_tb/DUT/CPU/DP/RU/ihit
add wave -noupdate /system_tb/DUT/CPU/DP/RU/dhit
add wave -noupdate /system_tb/DUT/CPUCLK
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {651587 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
WaveRestoreZoom {567500 ps} {975 ns}
