// Put your code here.
	@RENDER
	0;JMP   // goto RENDER
(END)
	@END
	0;JMP   // goto END

//  0 |  1 |  2 | .... | 31
// 32 | 33 | 34 | .... | 63
// 64 | ...
(RENDER)
	@2
	D=A
	@col_third
	M=D

	@30
	D=A
	@col_rest
	M=D

	@SCREEN
	D=A
	@addr
	M=D      // addr=SCREEN

	@0
	D=A
	@i
	M=D      // i=0

(LOOP_H)
	@i
	D=M
	@R0
	D=D-M
	@END
	D;JEQ    // i==R0, goto END

	@addr
	D=M
	A=D
	M=-1     // current row: RAM[addr] = -1

	@i
	D=M
	@R2
	D=D-M
	@COL_THIRD
	D;JGE    // if i>=R2, goto COL_THIRD

	@i
	D=M
	@R1
	D=D-M
	@COL_THIRD
	D;JLT    // if i<R1, goto COL_THIRD

	@addr
	D=M+1
	A=D
	M=-1     // current row: RAM[addr+1] = -1

(COL_THIRD)
	@addr
	D=M
	@col_third
	D=D+M
	A=D
	M=-1     // current row: RAM[addr+col_third] = -1

	@col_rest
	D=D+M
	@addr
	M=D      // next row start: addr=addr+col_rest

	@i
	M=M+1    // i++
	@LOOP_H
	0;JMP