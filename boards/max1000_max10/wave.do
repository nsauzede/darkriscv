onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /dut_tb/dut1/BOARD_CK
add wave -noupdate /dut_tb/dut1/INIT_FILE
add wave -noupdate /dut_tb/dut1/rx
add wave -noupdate /dut_tb/dut1/tx
add wave -noupdate /dut_tb/dut1/leds
add wave -noupdate /dut_tb/dut1/reset
add wave -noupdate /dut_tb/dut1/clk
add wave -noupdate /dut_tb/dut1/count
add wave -noupdate /dut_tb/dut1/addr
add wave -noupdate /dut_tb/dut1/IADDR
add wave -noupdate /dut_tb/dut1/IDATA
add wave -noupdate /dut_tb/dut1/IDACK
add wave -noupdate /dut_tb/dut1/XATAO
add wave -noupdate /dut_tb/dut1/XDACK
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {531000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {0 ps} {231 ns}
