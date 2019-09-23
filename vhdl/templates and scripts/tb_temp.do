;# basic script for Test Bench under Modelsim
;# more info on my VHDL book or www.amos.eguru-il.com  

transcript off
echo "------- START OF MACRO -------"
onerror abort

vcom temp.vhd
vcom tb_temp.vhd
vsim tb_temp

restart -force
noview *
add wave *
#add wave -r

# optional additions
#add list *
#configure list -delta collapse
#view signals

run 1000 ns

echo "------- END OF MACRO -------"
echo "The time now is $now [ string trim $resolution 01 ] "