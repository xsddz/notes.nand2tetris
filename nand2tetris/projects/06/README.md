

## 目标

实现汇编器，完成以下汇编程序的编译，最后在前面搭建的计算机硬件平台上运行编译之后的二进制机器指令代码：

| 汇编程序文件  | 编译之后的文件 | 说明 |
| ----- | ----- | ----- |
| add/Add.asm | add/Add.hack | 实现R0=3+2 |
| max/Max.asm <br> max/MaxL.asm | max/Max.hack <br> max/MaxL.hack | 实现R2=max(R0,R1) |
| rect/Rect.asm <br> rect/RectL.asm | rect/Rect.hack <br> rect/RectL.hack | 实现屏幕左上角画一个矩形 |
| pong/Pong.asm <br> pong/PongL.asm | pong/Pong.hack <br> pong/PongL.hack | 单人乒乓球游戏 |


## 背景知识

+ 汇编器：
	- 机器语言有汇编形式（D=D+A）和二进制形式（1110000010010000）；
	- 计算机硬件能够读懂的机器语言为二进制形式，但是对于编写机器语言代码的人们来讲，二进制形式并不友好，人们也不擅长记忆长数字；
	- 将二进制指令按功能进行拆解，并用约定的符号表述不同的功能，由这些符号组合起来的机器语言形式即为汇编形式，而人们也比较擅长记忆符号；
	- 汇编器的作用是将机器语言由汇编形式转换为二进制形式。
+ 指令内存存储模型：这里我们假定指令代码总是从指令内存地址0处开始加载。

我们的汇编程序符合以下约定：
+ 文件名后缀：汇编形式为.asm，编译之后的二进制形式为.hack，
+ 机器指令：参见05章节设计cpu时的A指令和C指令，及约定的助记符。
+ 伪指令：形式为`(symbol)`，声明一个代码位置，symbol可供goto语句使用。
+ 符号（symbol）：以字母、数字、下划线组成的字符序列，且不能以数字开头。有以下几种：
	- 预定义符号：R0-R15表示RAM内存地址为0到15的储存单元，RAM内存地址为0到4的储存单元还可以表示为：SP、LCL、ARG、THIS、THAT，SCREEN表示屏幕I/O映像后的RAM起始地址（值为16384），KBD表示好键盘I/O映像后的RAM地址（值为24576）；
	- 标签符号：伪指令`(symbol)`中的symbol，且只能在伪指令处被定义一次，值为出现该伪指令的下一条指令在指令内存的地址。
	- 变量符号：非以上符号的其他符号，第一次出现时，值从RAM内存地址16开始依次分配，一旦分配之后，值不再变化。
+ 常数：十进制的非负数。
+ 注释：双斜线（//）开始的文本，不参与编译。
+ 空格/空行：空格字符和空行不参与编译。
+ 大小写：指令助记符必须大写，其他符号区分大小写，一般的习惯为，标签符号大写，变量符号小写。


## 实现

这里将汇编器拆分为parser、code和symbol table三个模块，完整代码实现参见：https://github.com/xsddz/Advanced-Golang-Programming/tree/master/tinyassembler。

### 语法分析器：parser

对输入汇编代码文件进行语法分析，接口定义如下：

```
type Parser interface {
	// 打开输入文件或输出流，为语法解析作准备
	// New(file string)

	// 输入中还有更多命令吗
	HasMoreCommands() bool

	// 从输入中读取下一条命令，将其当作“当前命令”，
	// 仅当HasMoreCommands()为真时，才能调用该方法，
	// 最初始的时候，没有“当前命令”
	Advance()

	// 返回当前命令的类型：
	// - ACommand 当@xxx中的xxx是符号或者十进制数字时
	// - CCommand 用于dest=comp;jump
	// - LCommand 伪指令，当(xxx)中的xxx是符号时
	CommandType() CommandT

	// 返回形如@xxx或(xxx)的当前命令的符号或十进制值，
	// 仅当CommandType()是ACommand或LCommand时才能调用
	Symbol() string

	// 返回当前C指令的dest助记符（共有8种形式），
	// 仅当CommandType()是CCommand时才能调用
	Dest() string
	// 返回当前C指令的comp助记符（共有28种形式），
	// 仅当CommandType()是CCommand时才能调用
	Comp() string
	// 返回当前C指令的jump助记符（共有8种形式），
	// 仅当CommandType()是CCommand时才能调用
	Jump() string
}
```

### 符号编码器：code

将所有汇编命令助记符翻译为对应的二进制码，接口定义如下：

```
type Code interface {
	// 返回dest助记符对应的二进制码，3bits
	Dest(string) string
	// 返回comp助记符对应的二进制码，7bits
	Comp(string) string
	// 返回jump助记符对应的二进制码，3bits
	Jump(string) string
}
```

### 符号表：symbol table

在符号标签和数字地址之间建立关联，接口定义如下：

```
type SymbolTable interface {
	// 创建空的符号表
	// New()

	// 将(symbol, address)配对加入符号表
	AddEntry(symbol string, address int)

	// 符号表是否包含指定的symbol
	Contains(symbol string) bool

	// 返回与symbol关联的地址
	GetAddress(symbol string) int
}
```

## 小结

