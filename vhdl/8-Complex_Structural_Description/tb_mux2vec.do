;# basic script for Test Bench under Modelsim
;# more info on my VHDL book or www.amos.eguru-il.com  

transcript off
echo "------- START OF MACRO -------"
onerror abort

vcom mux2vec.vhd
vcom tb_mux2vec.vhd
vsim tb_mux2vec

restart -force
noview *
add wave *
#add wave -r

# optional additions
#add list *
#configure list -delta collapse
#view signals

run 300 ns
wave zoomfull

echo "------- END OF MACRO -------"
echo "The time now is $now [ string trim $resolution 01 ] "