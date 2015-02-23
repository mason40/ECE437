onerror {resume}
quietly virtual signal -install /system_tb/DUT/CPU/DP/HU { (context /system_tb/DUT/CPU/DP/HU )&{memwbout_opcode_5 , memwbout_opcode_4 , memwbout_opcode_3 , memwbout_opcode_2 , memwbout_opcode_1 , memwbout_opcode_0 }} memwb_op
quietly virtual signal -install /system_tb/DUT/CPU/DP/HU { (context /system_tb/DUT/CPU/DP/HU )&{idexout_opcode_5 , idexout_opcode_4 , idexout_opcode_3 , idexout_opcode_2 , idexout_opcode_1 , idexout_opcode_0 }} idex_op
quietly virtual signal -install /system_tb/DUT/CPU/DP/HU { (context /system_tb/DUT/CPU/DP/HU )&{exmemout_opcode_5 , exmemout_opcode_4 , exmemout_opcode_3 , exmemout_opcode_2 , exmemout_opcode_1 , exmemout_opcode_0 }} exmem_op
quietly virtual signal -install /system_tb/DUT/CPU/DP/HU { (context /system_tb/DUT/CPU/DP/HU )&{exmemout_branch_1 , exmemout_branch_0 }} br
quietly virtual signal -install /system_tb/DUT/CPU/DP/FD { (context /system_tb/DUT/CPU/DP/FD )&{ifidout_iload_31 , ifidout_iload_30 , ifidout_iload_29 , ifidout_iload_28 , ifidout_iload_27 , ifidout_iload_26 , ifidout_iload_25 , ifidout_iload_24 , ifidout_iload_23 , ifidout_iload_22 , ifidout_iload_21 , ifidout_iload_20 , ifidout_iload_19 , ifidout_iload_18 , ifidout_iload_17 , ifidout_iload_16 , ifidout_iload_15 , ifidout_iload_14 , ifidout_iload_13 , ifidout_iload_12 , ifidout_iload_11 , ifidout_iload_10 , ifidout_iload_9 , ifidout_iload_8 , ifidout_iload_7 , ifidout_iload_6 , ifidout_iload_5 , ifidout_iload_4 , ifidout_iload_3 , ifidout_iload_2 , ifidout_iload_1 , ifidout_iload_0 }} ifid_iload
quietly virtual signal -install /system_tb/DUT/CPU/DP/RF { (context /system_tb/DUT/CPU/DP/RF )&{\rfile[15][31]~q , \rfile[15][30]~q , \rfile[15][29]~q , \rfile[15][28]~q , \rfile[15][27]~q , \rfile[15][26]~q , \rfile[15][25]~q , \rfile[15][24]~q , \rfile[15][23]~q , \rfile[15][22]~q , \rfile[15][21]~q , \rfile[15][20]~q , \rfile[15][19]~q , \rfile[15][18]~q , \rfile[15][17]~q , \rfile[15][16]~q , \rfile[15][15]~q , \rfile[15][14]~q , \rfile[15][13]~q , \rfile[15][12]~q , \rfile[15][11]~q , \rfile[15][10]~q , \rfile[15][9]~q , \rfile[15][8]~q , \rfile[15][7]~q , \rfile[15][6]~q , \rfile[15][5]~q , \rfile[15][4]~q , \rfile[15][3]~q , \rfile[15][2]~q , \rfile[15][1]~q , \rfile[15][0]~q }} rf_15
quietly virtual signal -install /system_tb/DUT/CPU/DP/RF { (context /system_tb/DUT/CPU/DP/RF )&{\rfile[9][31]~q , \rfile[9][30]~q , \rfile[9][29]~q , \rfile[9][28]~q , \rfile[9][27]~q , \rfile[9][26]~q , \rfile[9][25]~q , \rfile[9][24]~q , \rfile[9][23]~q , \rfile[9][22]~q , \rfile[9][21]~q , \rfile[9][20]~q , \rfile[9][19]~q , \rfile[9][18]~q , \rfile[9][17]~q , \rfile[9][16]~q , \rfile[9][15]~q , \rfile[9][14]~q , \rfile[9][13]~q , \rfile[9][12]~q , \rfile[9][11]~q , \rfile[9][10]~q , \rfile[9][9]~q , \rfile[9][8]~q , \rfile[9][7]~q , \rfile[9][6]~q , \rfile[9][5]~q , \rfile[9][4]~q , \rfile[9][3]~q , \rfile[9][2]~q , \rfile[9][1]~q , \rfile[9][0]~q }} rf_9
quietly virtual signal -install /system_tb/DUT/CPU/DP/RF { (context /system_tb/DUT/CPU/DP/RF )&{\rfile[2][9]~q , \rfile[2][8]~q , \rfile[2][7]~q , \rfile[2][6]~q , \rfile[2][5]~q , \rfile[2][4]~q , \rfile[2][3]~q , \rfile[2][31]~q , \rfile[2][30]~q , \rfile[2][2]~q , \rfile[2][29]~q , \rfile[2][28]~q , \rfile[2][27]~q , \rfile[2][26]~q , \rfile[2][25]~q , \rfile[2][24]~q , \rfile[2][23]~q , \rfile[2][22]~q , \rfile[2][21]~q , \rfile[2][20]~q , \rfile[2][1]~q , \rfile[2][19]~q , \rfile[2][18]~q , \rfile[2][17]~q , \rfile[2][16]~q , \rfile[2][15]~q , \rfile[2][14]~q , \rfile[2][13]~q , \rfile[2][12]~q , \rfile[2][11]~q , \rfile[2][10]~q , \rfile[2][0]~q }} rf_2
quietly virtual signal -install /system_tb/DUT/CPU/DP/RF { (context /system_tb/DUT/CPU/DP/RF )&{\rfile[8][9]~q , \rfile[8][8]~q , \rfile[8][7]~q , \rfile[8][6]~q , \rfile[8][5]~q , \rfile[8][4]~q , \rfile[8][3]~q , \rfile[8][31]~q , \rfile[8][30]~q , \rfile[8][2]~q , \rfile[8][29]~q , \rfile[8][28]~q , \rfile[8][27]~q , \rfile[8][26]~q , \rfile[8][25]~q , \rfile[8][24]~q , \rfile[8][23]~q , \rfile[8][22]~q , \rfile[8][21]~q , \rfile[8][20]~q , \rfile[8][1]~q , \rfile[8][19]~q , \rfile[8][18]~q , \rfile[8][17]~q , \rfile[8][16]~q , \rfile[8][15]~q , \rfile[8][14]~q , \rfile[8][13]~q , \rfile[8][12]~q , \rfile[8][11]~q , \rfile[8][10]~q , \rfile[8][0]~q }} rf_8
quietly virtual signal -install /system_tb/DUT/CPU/DP/RF { (context /system_tb/DUT/CPU/DP/RF )&{\rfile[6][31]~q , \rfile[6][30]~q , \rfile[6][29]~q , \rfile[6][28]~q , \rfile[6][27]~q , \rfile[6][26]~q , \rfile[6][25]~q , \rfile[6][24]~q , \rfile[6][23]~q , \rfile[6][22]~q , \rfile[6][21]~q , \rfile[6][20]~q , \rfile[6][19]~q , \rfile[6][18]~q , \rfile[6][17]~q , \rfile[6][16]~q , \rfile[6][15]~q , \rfile[6][14]~q , \rfile[6][13]~q , \rfile[6][12]~q , \rfile[6][11]~q , \rfile[6][10]~q , \rfile[6][9]~q , \rfile[6][8]~q , \rfile[6][7]~q , \rfile[6][6]~q , \rfile[6][5]~q , \rfile[6][4]~q , \rfile[6][3]~q , \rfile[6][2]~q , \rfile[6][1]~q , \rfile[6][0]~q }} rf_6
quietly virtual signal -install /system_tb/DUT/CPU/DP/RF { (context /system_tb/DUT/CPU/DP/RF )&{\rfile[5][31]~q , \rfile[5][30]~q , \rfile[5][29]~q , \rfile[5][28]~q , \rfile[5][27]~q , \rfile[5][26]~q , \rfile[5][25]~q , \rfile[5][24]~q , \rfile[5][23]~q , \rfile[5][22]~q , \rfile[5][21]~q , \rfile[5][20]~q , \rfile[5][19]~q , \rfile[5][18]~q , \rfile[5][17]~q , \rfile[5][16]~q , \rfile[5][15]~q , \rfile[5][14]~q , \rfile[5][13]~q , \rfile[5][12]~q , \rfile[5][11]~q , \rfile[5][10]~q , \rfile[5][9]~q , \rfile[5][8]~q , \rfile[5][7]~q , \rfile[5][6]~q , \rfile[5][5]~q , \rfile[5][4]~q , \rfile[5][3]~q , \rfile[5][2]~q , \rfile[5][1]~q , \rfile[5][0]~q }} rf_5
quietly virtual signal -install /system_tb/DUT/CPU/DP/RF { (context /system_tb/DUT/CPU/DP/RF )&{\rfile[4][31]~q , \rfile[4][30]~q , \rfile[4][29]~q , \rfile[4][28]~q , \rfile[4][27]~q , \rfile[4][26]~q , \rfile[4][25]~q , \rfile[4][24]~q , \rfile[4][23]~q , \rfile[4][22]~q , \rfile[4][21]~q , \rfile[4][20]~q , \rfile[4][19]~q , \rfile[4][18]~q , \rfile[4][17]~q , \rfile[4][16]~q , \rfile[4][15]~q , \rfile[4][14]~q , \rfile[4][13]~q , \rfile[4][12]~q , \rfile[4][11]~q , \rfile[4][10]~q , \rfile[4][9]~q , \rfile[4][8]~q , \rfile[4][7]~q , \rfile[4][6]~q , \rfile[4][5]~q , \rfile[4][4]~q , \rfile[4][3]~q , \rfile[4][2]~q , \rfile[4][1]~q , \rfile[4][0]~q }} rf_4
quietly virtual signal -install /system_tb/DUT/CPU/DP/RF { (context /system_tb/DUT/CPU/DP/RF )&{\rfile[3][31]~q , \rfile[3][30]~q , \rfile[3][29]~q , \rfile[3][28]~q , \rfile[3][27]~q , \rfile[3][26]~q , \rfile[3][25]~q , \rfile[3][24]~q , \rfile[3][23]~q , \rfile[3][22]~q , \rfile[3][21]~q , \rfile[3][20]~q , \rfile[3][19]~q , \rfile[3][18]~q , \rfile[3][17]~q , \rfile[3][16]~q , \rfile[3][15]~q , \rfile[3][14]~q , \rfile[3][13]~q , \rfile[3][12]~q , \rfile[3][11]~q , \rfile[3][10]~q , \rfile[3][9]~q , \rfile[3][8]~q , \rfile[3][7]~q , \rfile[3][6]~q , \rfile[3][5]~q , \rfile[3][4]~q , \rfile[3][3]~q , \rfile[3][2]~q , \rfile[3][1]~q , \rfile[3][0]~q }} rf_3
quietly virtual signal -install /system_tb/DUT/CPU/DP/XM { (context /system_tb/DUT/CPU/DP/XM )&{out_aluout31 , out_aluout30 , out_aluout29 , out_aluout28 , out_aluout27 , out_aluout26 , out_aluout25 , out_aluout24 , out_aluout23 , out_aluout22 , out_aluout21 , out_aluout20 , out_aluout19 , out_aluout18 , out_aluout17 , out_aluout16 , out_aluout15 , out_aluout14 , out_aluout13 , out_aluout12 , out_aluout11 , out_aluout10 , out_aluout9 , out_aluout8 , out_aluout7 , out_aluout6 , out_aluout5 , out_aluout4 , out_aluout3 , out_aluout2 , out_aluout1 , out_aluout }} aluout
quietly virtual signal -install /system_tb/DUT/CPU/DP/DX { (context /system_tb/DUT/CPU/DP/DX )&{out_rs4 , out_rs3 , out_rs2 , out_rs1 , out_rs }} idex_rs
quietly virtual signal -install /system_tb/DUT/CPU/DP/DX { (context /system_tb/DUT/CPU/DP/DX )&{out_rt4 , out_rt3 , out_rt2 , out_rt1 , out_rt }} idex_rt
quietly virtual signal -install /system_tb/DUT/CPU/DP/DX { (context /system_tb/DUT/CPU/DP/DX )&{out_rd4 , out_rd3 , out_rd2 , out_rd1 , out_rd }} idex_rd
quietly virtual signal -install /system_tb/DUT/CPU/DP/DX { (context /system_tb/DUT/CPU/DP/DX )&{out_imm31 , out_imm30 , out_imm29 , out_imm28 , out_imm27 , out_imm26 , out_imm25 , out_imm24 , out_imm23 , out_imm22 , out_imm21 , out_imm20 , out_imm19 , out_imm18 , out_imm17 , out_imm16 , out_imm15 , out_imm14 , out_imm13 , out_imm12 , out_imm11 , out_imm10 , out_imm9 , out_imm8 , out_imm7 , out_imm6 , out_imm5 , out_imm4 , out_imm3 , out_imm2 , out_imm1 , out_imm }} idex_imm
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
add wave -noupdate /system_tb/DUT/CPU/DP/RF/rf_15
add wave -noupdate /system_tb/DUT/CPU/DP/RF/rf_9
add wave -noupdate /system_tb/DUT/CPU/DP/RF/rf_2
add wave -noupdate /system_tb/DUT/CPU/DP/RF/rf_8
add wave -noupdate /system_tb/DUT/CPU/DP/RF/rf_6
add wave -noupdate /system_tb/DUT/CPU/DP/RF/rf_5
add wave -noupdate /system_tb/DUT/CPU/DP/RF/rf_4
add wave -noupdate /system_tb/DUT/CPU/DP/RF/rf_3
add wave -noupdate /system_tb/DUT/CPU/DP/XM/aluout
add wave -noupdate -label idex_rs /system_tb/DUT/CPU/DP/DX/idex_rs
add wave -noupdate /system_tb/DUT/CPU/DP/DX/idex_rt
add wave -noupdate /system_tb/DUT/CPU/DP/DX/idex_rd
add wave -noupdate /system_tb/DUT/CPU/DP/DX/idex_imm
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {300000 ps} 0}
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
WaveRestoreZoom {0 ps} {2100 ns}
