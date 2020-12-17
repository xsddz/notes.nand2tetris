// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/05/ComputerRect.tst

load Computer.hdl,

ROM32K load Hello.hack,

echo "Make sure that 'No Animation' is selected. Then, select the keyboard, press any key for some time, and inspect the screen.";

set RAM16K[0] 36,
set RAM16K[1] 12,
set RAM16K[2] 24,
repeat 100000 {
  tick, tock;
}
