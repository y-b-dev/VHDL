;# Basic script under Modelsim. For more info
;# look in my book(s) or www.aztech.co.il or www.amos.eguru-il.com

transcript off
onerror abort
echo "------- START OF SCRIPT -------"

restart -force
noview *

add wave *                         
#add wave -r *                      ;# all internal signals too
#add wave -ports -radix unsigned *  ;# more options: -in -out -color gold

# optional
#view signals
#add list *
#configure list -delta collapse

;# ============== start of stimulus section ==============

force din 10000110
run 100ns

force din 01110011
run 100ns



;# =============== end of stimulus section ===============

puts "choosing a zoom-full timing range:"
wave zoomfull
#.wave.tree zoomfull ;# with some versions of modelsim 
echo "---------------------- END OF SCRIPT ------------------------"
echo "The time now is $now [ string trim $resolution 01 ] "
