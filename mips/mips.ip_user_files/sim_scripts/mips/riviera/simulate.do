onbreak {quit -force}
onerror {quit -force}

asim +access +r +m+mips -L xil_defaultlib -L xlslice_v1_0_2 -L xlconstant_v1_1_7 -L xlconcat_v2_1_4 -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.mips xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {mips.udo}

run -all

endsim

quit -force
