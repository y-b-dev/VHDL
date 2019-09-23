##############################################
# Clean-Up and template Renewal TCL script   #
# Creators: Pavel Efros & Amos Zaslavsky     #
# Date: 8/12/01  Version: 1.0                #
# Checked under: wish,tclsh,modelsim,quartus #
##############################################
# this script is a loose canon because
# it will destroy everything anywhare
# so we make it active only in the c:\vhd directory 
if { [ string tolower [ pwd ] ] != "c:/vhd" } {
   puts "Current directory is: [ pwd ] "
   puts "This script can only be run under c:/vhd"
} else {
puts "------------------------------------------"
puts "Starting the clean template script ... "
#listing the current directory
set files [ string tolower [glob -nocomplain *] ]
if { $files != "" } {
   foreach filename $files {
      #Division to files and subdirectories
      if { [file isdirectory $filename] != 0 } {
         # Deleting of all subdirectories
         puts "Deleting directory: $filename"
         file delete -force $filename
      } else {
         # making the global deliting of files more selective
         # Deleting of all files that are not *.tcl
         # and readonly and not hidden
         if { [file extension $filename] != ".tcl"} {
            if { [file attributes $filename -readonly] != 1 } {
               if { [file attributes $filename -hidden] != 1 } {
                  # files that can not be deleted because
                  # of file sharing are left untouced skipping
                  # the error and not truncating the script
                  set err [catch {file delete $filename} ]
                  if {$err != 0} {
                     puts "Error: deleting old file $filename"
                  } else {
                     puts "Deleting old file : $filename" }
                  }
               }
            }
         }
      }
   }

##copy a fresh modelsim.tcl file to current directory
#puts "Overwriting  file : modelsim.tcl ... "
#set filesource [ file join c:/ vhd_clean modelsim.tcl]
#set filetarget [ file join c:/ vhd       modelsim.tcl]
## if file exist
#if { [file exist $filetarget] == 1} then {
#   file attributes $filetarget -hidden   0
#   file attributes $filetarget -readonly 0
#   file attributes $filetarget -archive  0
#}
#file copy -force $filesource $filetarget
#file attributes $filetarget -archive  1
#file attributes $filetarget -readonly 1
#file attributes $filetarget -hidden   1
#
##copy a fresh work directory & contents to current directory
#puts "Re-Newing library : work ... "
#set filesource [ file join c:/ vhd_clean work]
#set filetarget [ file join c:/ vhd       work]
#file copy -force $filesource $filetarget
#
##copy a fresh modelsim.ini file
#puts "Re-Freshing file  : Modelsim.ini ... "
#set filesource [ file join c:/ vhd_clean modelsim.ini]
#set filetarget [ file join c:/ vhd       modelsim.ini]
#file copy -force $filesource $filetarget
## I want the Modelsim.ini file have the folowing parameters
#
## NoIndexCheck = 0
## RangeCheck = 1
#
## Resolution = ns
## VHDL93 = 1
## RunLength = 100
## BreakOnAssertion = 3
#
##copy a fresh setup.do file
#puts "Re-Freshing file  : setup.do (VGA) ... "
#set filesource [ file join c:/ vhd_clean setup.do]
#set filetarget [ file join c:/ vhd       setup.do]
#file copy -force $filesource $filetarget

##copy a fresh vga.tcl file
#puts "Re-Freshing file  : vga.tcl ... "
#set filesource [ file join c:/ vhd_clean vga.tcl]
#set filetarget [ file join c:/ vhd       vga.tcl]
#file copy -force $filesource $filetarget

##copy a fresh warp.pfg file
#puts "Re-Freshing file  : warp.pfg ... "
#set filesource [ file join c:/ vhd_clean warp.pfg]
#set filetarget [ file join c:/ vhd       warp.pfg]
#file copy -force $filesource $filetarget

# ---------------------------
# creating the temp.vhd file
# ---------------------------
set file_string {-- a simple template file in VHDL
-- more useful info in my VHDL book or www.amos.eguru-il.com
library ieee ;
use ieee.std_logic_1164.all ;
-- use ieee.std_logic_unsigned.all ;
entity TEMP is
   port ( din,clk,resetN : in  std_logic ;
          dout           : out std_logic ) ;
end TEMP ;
architecture arc_TEMP of TEMP is
   signal sampled1 , sampled2 : std_logic ;
begin
    process ( clk , resetN )
    begin
       if resetN = '0' then
          sampled1 <= '0' ;
          sampled2 <= '0' ;
       elsif clk'event and clk = '1' then
          sampled1 <= din      ;
          sampled2 <= sampled1 ;
       end if ;
    end process ;
    dout <= sampled1 and not sampled2 ;
end arc_TEMP ;}

set file_handle [open temp.vhd w]
puts "Creating new file : temp.vhd ... "
puts $file_handle $file_string
close $file_handle
#----------------------------------------------------

# --------------------------
# creating the temp.do file
# --------------------------
set file_string {# basic script with NO Test Bench under Modelsim
# more info on my VHDL book or www.amos.eguru-il.com

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

# ====== start of stimulus section ======

force  resetN  0 , 1 100 ns
force  clk 0 , 1  50 ns -r 100 ns

force din 0
run 200 ns
force din 1
run 400 ns
force din 0
run 300 ns

# ======= end of stimulus section=======
echo "------- END OF MACRO -------"
echo "The time now is $now [ string trim $resolution 01 ] "}

set file_handle [open temp.do w]
puts "Creating new file : temp.do ... "
puts $file_handle $file_string
close $file_handle
#----------------------------------------------------


# --------------------------
# creating the rv_temp.do file
# --------------------------
set file_string {# basic script with NO Test Bench under Riviera-Pro
# more info on my VHDL book or www.amos.eguru-il.com 

transcript off
echo "------- START OF MACRO -------"
onerror abort

restart
framework.documents.closeall
add wave *
#add wave -r

# ====== start of stimulus section ======

force  resetN  0 , 1 100 ns
force  clk 0 , 1  50 ns -r 100 ns

force din 0
run 200 ns
force din 1
run 400 ns
force din 0
run 300 ns

# ======= end of stimulus section =======
wv.zoom.fit
echo "------- END OF MACRO -------"
echo "The time now is $now [ string trim $resolution 01 ]"}

set file_handle [open rv_temp.do w]
puts "Creating new file : rv_temp.do ... "
puts $file_handle $file_string
close $file_handle
#----------------------------------------------------


# --------------------------
# creating the tb_temp.vhd file
# --------------------------
set file_string {-- a simple template of test bench file in VHDL
-- more useful info in my VHDL book or www.amos.eguru-il.com
library ieee ;
use ieee.std_logic_1164.all ;
entity tb_TEMP is
   -- test bench with no ports
end tb_TEMP ;
architecture arc_tb_TEMP of tb_TEMP is
   component TEMP
      port ( din,clk,resetN : in  std_logic ;
             dout           : out std_logic ) ;
   end component ;
   signal din, clk, resetN : std_logic ;
   signal dout             : std_logic ;
begin
   eut: TEMP port map ( din , clk , resetN , dout ) ;
   -- active low reset pulse
   resetN <= '0' , '1' after 100 ns ;
   -- clock process
   process
   begin
      clk <= '0' ;  wait for 50 ns ;
      clk <= '1' ;  wait for 50 ns ;
   end process ;
   din <= '0' , '1' after 200 ns , '0' after 600 ns ;
end arc_tb_TEMP ;}

set file_handle [open tb_temp.vhd w]
puts "Creating new file : tb_temp.vhd ... "
puts $file_handle $file_string
close $file_handle
#----------------------------------------------------


# --------------------------
# creating the tb_temp.do file
# --------------------------
set file_string {# basic script for Test Bench under Modelsim
# more info on my VHDL book or www.amos.eguru-il.com  

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
echo "The time now is $now [ string trim $resolution 01 ] "}

set file_handle [open tb_temp.do w]
puts "Creating new file : tb_temp.do ... "
puts $file_handle $file_string
close $file_handle
#----------------------------------------------------



# --------------------------
# creating the rv_tb_temp.do file
# --------------------------
set file_string {# basic script for Test Bench under Riviera-Pro
# more info on my VHDL book or www.amos.eguru-il.com  

transcript off
echo "------- START OF MACRO -------"
onerror abort

vcom -dbg temp.vhd
vcom -dbg tb_temp.vhd
vsim tb_temp

restart
framework.documents.closeall
add wave *

run 1000 ns

wv.zoom.fit

echo "------- END OF MACRO -------"
echo "The time now is $now [ string trim $resolution 01 ]"}

set file_handle [open rv_tb_temp.do w]
puts "Creating new file : rv_tb_temp.do ... "
puts $file_handle $file_string
close $file_handle
#----------------------------------------------------


##----------------------------------------------------

##---------------------------
## creating the temp.v file
## ---------------------------
#set file_string {// a simple template file in Verilog
#module temp (din, clk, resetN, dout);
#   input  din,clk,resetN ;
#   output dout           ;
#   reg  sampled1 ;
#   reg  sampled2 ;
#   wire dout     ;
#// description of behavior goes here
#always @(posedge clk or negedge resetN)
#   begin
#   if ( ~resetN )
#      begin
#         sampled1 <= 1'b0 ;
#         sampled2 <= 1'b0 ;
#      end
#   else
#      begin
#         sampled1 <= din ;
#         sampled2 <= sampled1 ;
#      end
#   end
#   assign dout = sampled1 & ~sampled2 ;
#endmodule  // tempe}
#set file_handle [open temp.v w]
#puts "Creating new file : temp.v ... "
#puts $file_handle $file_string
#close $file_handle
##----------------------------------------------------

## ---------------------------
## creating the temp.abl file
## ---------------------------
#set file_string {// a simple template file in ABEL
#module temp
#declarations
#   //temp              device ; // only with DOS versions
#   din , clk , resetN  pin  ; // inputs
#   dout                pin  ; // outputs
#   [sample1..sample2]  node ;
#   [sample1..sample2]  istype 'reg,buffer' ;
#   z , c , x = .z. , .c. , .x. ;
#equations
#   sample1.d    =  din    ;
#   sample1.clk  =  clk    ;
#   sample1.aclr = !resetN ;
#   sample2.d    =  sample1.q ;
#   sample2.clk  =  clk       ;
#   sample2.aclr = !resetN    ;
#   dout = sample1.q & ! sample2.q ;
#//test_vectors
#//   ([resetN,clk,din] -> dout )
#//    [  0   , x , x ] ->   0  ;
#//    [  1   , c , 0 ] ->   0  ;
#//    [  1   , c , 1 ] ->   1  ;
#//    [  1   , c , 1 ] ->   0  ;
#//    [  1   , c , 1 ] ->   0  ;
#end // temp}

#set file_handle [open temp.abl w]
#puts "Creating new file : temp.abl ... "
#puts $file_handle $file_string
#close $file_handle
##----------------------------------------------------

# ---------------------------
# creating the temp.tdf file
# ---------------------------
#set file_string {-- a simple template file in AHDL
#subdesign temp
#(
#   din , clk , resetN : input  ;
#   dout               : output ;
#)
#variable
#   sample1 , sample2 : dff ;
#begin
#   sample1.d    = din    ;
#   sample1.clk  = clk    ;
#   sample1.clrn = resetN ;
#   sample2.d    = sample1.q ;
#   sample2.clk  = clk       ;
#   sample2.clrn = resetN    ;
#   dout = sample1.q & ! sample2.q ;
#end ; -- temp }
#set file_handle [open temp.tdf w]
#puts "Creating new file : temp.tdf ... "
#puts $file_handle $file_string
#close $file_handle


# ---------------------------
# creating the temp.mif file
# ---------------------------
set file_string {-- a simple mif file
WIDTH =   8 ;   -- Memory depth and width are required
DEPTH = 256 ;  % Enter in decimal number %

ADDRESS_RADIX = DEC ; -- address & data radixes rquired
DATA_RADIX    = DEC ; -- Enter BIN, DEC(UNS) , HEX, or OCT

CONTENT BEGIN
   0         :   255       ;   % Single address with data 255 (FF) %
   1         :   11 22 33  ;   -- range starting from specific address 1 (2,3)
   [4..255]  :   69        ;   -- range (evry address) from 4 to 255
END ; }
set file_handle [open temp.mif w]
puts "Creating new file : temp.mif ... "
puts $file_handle $file_string
close $file_handle



##----------------------------------------------------
## ---------------------------
## creating the hello.c file
## ---------------------------
#set x hhh
#set file_string "// a simple example
#int main(void)
#   \x7b
#   printf (\x22\\nHello World.\\n\x22);
#   \x7d"
#set file_handle [open hello.c w]
#puts "Creating new file : hello.c ... "
#puts $file_handle $file_string
#close $file_handle
##----------------------------------------------------

puts "------------------------------------------"
puts "You have create a new library \"work\" !"
puts "------------------------------------------"

puts "Done !"
} ;# end of protection if
puts "Please press ENTER !"
gets stdin
