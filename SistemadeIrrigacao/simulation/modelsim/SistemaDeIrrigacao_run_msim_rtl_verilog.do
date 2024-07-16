transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/Dev/Verilog/SistemadeIrrigacao {D:/Dev/Verilog/SistemadeIrrigacao/d_flip_flop.v}
vlog -vlog01compat -work work +incdir+D:/Dev/Verilog/SistemadeIrrigacao {D:/Dev/Verilog/SistemadeIrrigacao/reversible_master_slave_d_flip_flop.v}

