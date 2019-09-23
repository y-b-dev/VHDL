;# basic script for Test Bench under Modelsim
;# more info on my VHDL book or www.amos.eguru-il.com  

transcript off
echo "------- START OF MACRO -------"
onerror abort

vcom dffx.vhd
vcom pipe.vhd
vcom tff.vhd
vcom vgasync.vhd
vcom timer.vhd
vcom traffic_sm.vhd
vcom s_r_ff.vhd
vcom controller.vhd
vcom traffic_lights.vhd
vcom dup10.vhd
vcom test_traffic.vhd

#vsim _ -msgmode both

#restart -force
noview *
add wave *
#add wave -r

#run 1000 ns

# optional additions
#add list *
#configure list -delta collapse
#view signals

echo "------- END OF MACRO -------"
echo "The time now is $now [ string trim $resolution 01 ] "