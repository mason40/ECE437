onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/nRST
add wave -noupdate /system_tb/CLK
add wave -noupdate -expand -group RAM /system_tb/DUT/prif/ramREN
add wave -noupdate -expand -group RAM /system_tb/DUT/prif/ramWEN
add wave -noupdate -expand -group RAM /system_tb/DUT/prif/ramaddr
add wave -noupdate -expand -group RAM /system_tb/DUT/prif/ramstore
add wave -noupdate -expand -group RAM /system_tb/DUT/prif/ramload
add wave -noupdate -expand -group RAM /system_tb/DUT/prif/ramstate
add wave -noupdate /system_tb/DUT/CPU/DP/idex/out_opcode
add wave -noupdate /system_tb/DUT/CPUCLK
add wave -noupdate -expand -group IF/ID /system_tb/DUT/CPU/DP/ifid/out_iload
add wave -noupdate -expand -group IF/ID /system_tb/DUT/CPU/DP/ifid/out_cpc
add wave -noupdate -expand -group IF/ID /system_tb/DUT/CPU/DP/FD/nop
add wave -noupdate -expand -group IF/ID /system_tb/DUT/CPU/DP/FD/en
add wave -noupdate -group ID/EX /system_tb/DUT/CPU/DP/idex/out_cpc
add wave -noupdate -group ID/EX /system_tb/DUT/CPU/DP/idex/out_aluop
add wave -noupdate -group ID/EX /system_tb/DUT/CPU/DP/idex/out_branch
add wave -noupdate -group ID/EX /system_tb/DUT/CPU/DP/idex/out_dren
add wave -noupdate -group ID/EX /system_tb/DUT/CPU/DP/idex/out_dwen
add wave -noupdate -group ID/EX /system_tb/DUT/CPU/DP/idex/out_jump
add wave -noupdate -group ID/EX /system_tb/DUT/CPU/DP/idex/out_memtoReg
add wave -noupdate -group ID/EX /system_tb/DUT/CPU/DP/idex/out_regWrite
add wave -noupdate -group ID/EX /system_tb/DUT/CPU/DP/idex/out_halt
add wave -noupdate -group ID/EX /system_tb/DUT/CPU/DP/idex/out_regDst
add wave -noupdate -group ID/EX /system_tb/DUT/CPU/DP/idex/out_alusrc
add wave -noupdate -group ID/EX /system_tb/DUT/CPU/DP/idex/out_shift
add wave -noupdate -group ID/EX /system_tb/DUT/CPU/DP/idex/out_lui
add wave -noupdate -group ID/EX /system_tb/DUT/CPU/DP/idex/out_rdat1
add wave -noupdate -group ID/EX /system_tb/DUT/CPU/DP/idex/out_rdat2
add wave -noupdate -group ID/EX /system_tb/DUT/CPU/DP/idex/out_imm
add wave -noupdate -group ID/EX /system_tb/DUT/CPU/DP/idex/out_rt
add wave -noupdate -group ID/EX /system_tb/DUT/CPU/DP/idex/out_rd
add wave -noupdate -group ID/EX /system_tb/DUT/CPU/DP/idex/out_shamt
add wave -noupdate -group ID/EX /system_tb/DUT/CPU/DP/idex/out_jaddr
add wave -noupdate -group ID/EX /system_tb/DUT/CPU/DP/idex/out_opcode
add wave -noupdate -group EX/MEM /system_tb/DUT/CPU/DP/exmem/out_cpc
add wave -noupdate -group EX/MEM /system_tb/DUT/CPU/DP/exmem/out_regWrite
add wave -noupdate -group EX/MEM /system_tb/DUT/CPU/DP/exmem/out_memtoReg
add wave -noupdate -group EX/MEM /system_tb/DUT/CPU/DP/exmem/out_halt
add wave -noupdate -group EX/MEM /system_tb/DUT/CPU/DP/exmem/out_branch
add wave -noupdate -group EX/MEM /system_tb/DUT/CPU/DP/exmem/out_zflag
add wave -noupdate -group EX/MEM /system_tb/DUT/CPU/DP/exmem/out_dren
add wave -noupdate -group EX/MEM /system_tb/DUT/CPU/DP/exmem/out_dwen
add wave -noupdate -group EX/MEM /system_tb/DUT/CPU/DP/exmem/out_jump
add wave -noupdate -group EX/MEM /system_tb/DUT/CPU/DP/exmem/out_aluout
add wave -noupdate -group EX/MEM /system_tb/DUT/CPU/DP/exmem/out_writeData
add wave -noupdate -group EX/MEM /system_tb/DUT/CPU/DP/exmem/out_imm
add wave -noupdate -group EX/MEM /system_tb/DUT/CPU/DP/exmem/out_regtarget
add wave -noupdate -group EX/MEM /system_tb/DUT/CPU/DP/exmem/out_wsel
add wave -noupdate -group EX/MEM /system_tb/DUT/CPU/DP/exmem/out_jaddr
add wave -noupdate -group EX/MEM /system_tb/DUT/CPU/DP/exmem/out_opcode
add wave -noupdate -group MEM/WB /system_tb/DUT/CPU/DP/memwb/out_regWrite
add wave -noupdate -group MEM/WB /system_tb/DUT/CPU/DP/memwb/out_memtoReg
add wave -noupdate -group MEM/WB /system_tb/DUT/CPU/DP/memwb/out_halt
add wave -noupdate -group MEM/WB /system_tb/DUT/CPU/DP/memwb/out_opcode
add wave -noupdate -group MEM/WB /system_tb/DUT/CPU/DP/memwb/out_readData
add wave -noupdate -group MEM/WB /system_tb/DUT/CPU/DP/memwb/out_aluout
add wave -noupdate -group MEM/WB /system_tb/DUT/CPU/DP/memwb/out_cpc
add wave -noupdate -group MEM/WB /system_tb/DUT/CPU/DP/memwb/out_regtarget
add wave -noupdate -group MEM/WB /system_tb/DUT/CPU/DP/memwb/out_jaddr
add wave -noupdate -group MEM/WB /system_tb/DUT/CPU/DP/memwb/out_jump
add wave -noupdate -group MEM/WB /system_tb/DUT/CPU/DP/memwb/out_wsel
add wave -noupdate -group RF /system_tb/DUT/CPU/DP/rfif/WEN
add wave -noupdate -group RF -expand /system_tb/DUT/CPU/DP/RF/rfile
add wave -noupdate -group RF /system_tb/DUT/CPU/DP/rfif/wsel
add wave -noupdate -group RF /system_tb/DUT/CPU/DP/rfif/rsel1
add wave -noupdate -group RF /system_tb/DUT/CPU/DP/rfif/rsel2
add wave -noupdate -group RF /system_tb/DUT/CPU/DP/rfif/wdat
add wave -noupdate -group RF /system_tb/DUT/CPU/DP/rfif/rdat1
add wave -noupdate -group RF /system_tb/DUT/CPU/DP/rfif/rdat2
add wave -noupdate -group DP /system_tb/DUT/CPU/DP/dpif/ihit
add wave -noupdate -group DP /system_tb/DUT/CPU/DP/dpif/imemREN
add wave -noupdate -group DP /system_tb/DUT/CPU/DP/dpif/imemload
add wave -noupdate -group DP /system_tb/DUT/CPU/DP/dpif/imemaddr
add wave -noupdate -group DP /system_tb/DUT/CPU/DP/dpif/dhit
add wave -noupdate -group DP /system_tb/DUT/CPU/DP/dpif/dmemREN
add wave -noupdate -group DP /system_tb/DUT/CPU/DP/dpif/dmemWEN
add wave -noupdate -group DP /system_tb/DUT/CPU/DP/dpif/dmemload
add wave -noupdate -group DP /system_tb/DUT/CPU/DP/dpif/dmemstore
add wave -noupdate -group DP /system_tb/DUT/CPU/DP/dpif/dmemaddr
add wave -noupdate -group FU /system_tb/DUT/CPU/DP/fuif/ri_enable
add wave -noupdate -group FU /system_tb/DUT/CPU/DP/fuif/write
add wave -noupdate -group FU /system_tb/DUT/CPU/DP/fuif/idex_rs
add wave -noupdate -group FU /system_tb/DUT/CPU/DP/fuif/idex_rt
add wave -noupdate -group FU /system_tb/DUT/CPU/DP/fuif/exmem_rd
add wave -noupdate -group FU /system_tb/DUT/CPU/DP/fuif/exmem_regW
add wave -noupdate -group FU /system_tb/DUT/CPU/DP/fuif/memwb_rd
add wave -noupdate -group FU /system_tb/DUT/CPU/DP/fuif/memwb_regW
add wave -noupdate -group FU /system_tb/DUT/CPU/DP/fuif/alu1
add wave -noupdate -group FU /system_tb/DUT/CPU/DP/fuif/alu2
add wave -noupdate -expand -group HU /system_tb/DUT/CPU/DP/huif/ihit
add wave -noupdate -expand -group HU /system_tb/DUT/CPU/DP/huif/dhit
add wave -noupdate -expand -group HU /system_tb/DUT/CPU/DP/huif/ifid_op
add wave -noupdate -expand -group HU /system_tb/DUT/CPU/DP/huif/idex_op
add wave -noupdate -expand -group HU /system_tb/DUT/CPU/DP/huif/exmem_op
add wave -noupdate -expand -group HU /system_tb/DUT/CPU/DP/huif/memwb_op
add wave -noupdate -expand -group HU /system_tb/DUT/CPU/DP/huif/ifid_en
add wave -noupdate -expand -group HU /system_tb/DUT/CPU/DP/huif/idex_en
add wave -noupdate -expand -group HU /system_tb/DUT/CPU/DP/huif/exmem_en
add wave -noupdate -expand -group HU /system_tb/DUT/CPU/DP/huif/memwb_en
add wave -noupdate -expand -group HU /system_tb/DUT/CPU/DP/huif/idex_flush
add wave -noupdate -expand -group HU /system_tb/DUT/CPU/DP/huif/exmem_flush
add wave -noupdate -expand -group HU /system_tb/DUT/CPU/DP/huif/memwb_flush
add wave -noupdate -expand -group HU /system_tb/DUT/CPU/DP/huif/ifid_flush
add wave -noupdate -expand -group HU /system_tb/DUT/CPU/DP/huif/pcpause
add wave -noupdate -expand -group HU /system_tb/DUT/CPU/DP/huif/branch
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/aluif/aluop
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/aluif/porta
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/aluif/portb
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/aluif/portout
add wave -noupdate -expand -group PC /system_tb/DUT/CPU/DP/pcif/cpc
add wave -noupdate -expand -group PC /system_tb/DUT/CPU/DP/pcif/pcen
add wave -noupdate -expand -group PC /system_tb/DUT/CPU/DP/pcif/npc
add wave -noupdate -expand -group CU /system_tb/DUT/CPU/DP/cuif/opcode
add wave -noupdate -expand -group CU /system_tb/DUT/CPU/DP/cuif/func
add wave -noupdate -expand -group CU /system_tb/DUT/CPU/DP/CU/v
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1339222 ps} 0}
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
WaveRestoreZoom {0 ps} {3150 ns}
