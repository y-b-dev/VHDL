;# basic script with NO Test Bench under Modelsim
;# more info on my VHDL book or www.amos.eguru-il.com

transcript off
echo "------- START OF MACRO -------"
onerror abort

restart -force
noview *
add wave *

# optional
#add list *
#configure list -delta collapse
#view signals

;# ====== start of stimulus section ======

force  resetN  0 , 1 100 ns
force  clk 0 , 1  50 ns -r 100 ns

force din 0
run 200 ns
force din 1
run 400 ns
force din 0
run 300 ns

;# ======= end of stimulus section=======
echo "------- END OF MACRO -------"
echo "The time now is $now [ string trim $resolution 01 ] "