;# basic script for Test Bench under Modelsim
;# more info on my VHDL book or www.amos.eguru-il.com  

transcript off
echo "------- START OF MACRO -------"
onerror abort

vcom dffx.vhd
vcom pipe.vhd
vcom mili_sec_gen.vhd
vcom reg_ena.vhd
vcom tff.vhd
vcom vgasync.vhd
vcom c_counter.vhd
vcom rescolor.vhd
vcom vga_auto_color_change.vhd
vcom test_sync_vga.vhd

#vsim _ -msgmode both

#restart -force
#noview *
#add wave *
#add wave -r

#run 1000 ns

# optional additions
#add list *
#configure list -delta collapse
#view signals

echo "------- END OF MACRO -------"
echo "The time now is $now [ string trim $resolution 01 ] "