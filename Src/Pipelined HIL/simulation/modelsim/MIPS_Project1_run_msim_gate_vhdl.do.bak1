transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vcom -93 -work work {MIPS_Project1.vho}

vcom -93 -work work {C:/Users/PC/Desktop/Fundamentals Pipeline/Testbenches/top_level_tb.vhd}

vsim -t 1ps -L altera -L altera_lnsim -L fiftyfivenm -L gate_work -L work -voptargs="+acc"  top_level_tb

add wave *
view structure
view signals
run 50 ns
