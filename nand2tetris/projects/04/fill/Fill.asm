// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.
(LOOP)
	@KBD
	D=M     // read keyboard value
	@WHITE
	D;JEQ   // if D==0 goto WHITE
	@BLACK
	D;JGT   // if D>0 goto BLACK
	@LOOP
	0;JMP   // goto LOOP

(WHITE)
	@render_value
	M=0
	@RENDER
	0;JMP

(BLACK)
	@render_value
	M=-1
	@RENDER
	0;JMP

(RENDER)
	@SCREEN
	D=A
	@addr
	M=D     // addr -> SCREEN

	@KBD
	D=A
	@n
	M=D     // n -> KBD

	@addr
	D=M
	@i
	M=D    // i = addr

	(LOOP_SCREEN)
		@i
		D=M
		@n
		D=D-M
		@LOOP
		D;JGE  // if i>=n goto LOOP 

		@render_value
		D=M    // get render value
		@i
		A=M
		M=D    // RAM[i] = -1 or 0

		@i
		M=M+1  // i++
		@LOOP_SCREEN
		0;JMP  // goto LOOP_SCREEN
