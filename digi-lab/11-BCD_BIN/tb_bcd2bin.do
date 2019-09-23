;# basic script for Test Bench under Modelsim
;# more info on my VHDL book or www.amos.eguru-il.com  

transcript off
echo "------- START OF MACRO -------"
onerror abort

vcom bcd2bin.vhd
vcom tb_bcd2bin.vhd
vsim tb_bcd2bin

restart -force
noview *
add wave *
#add wave -r

# optional additions
#add list *
#configure list -delta collapse
#view signals

run 300 ns

echo "------- END OF MACRO -------"
echo "The time now is $now [ string trim $resolution 01 ] "