;# basic script for Test Bench under Modelsim
;# more info on my VHDL book or www.amos.eguru-il.com  

transcript off
echo "------- START OF MACRO -------"
onerror abort

vcom pkg_rom_p_enc.vhd
vcom ram_p_enc.vhd
vcom tb_ram_p_enc.vhd
vsim tb_ram_p_enc -msgmode both

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