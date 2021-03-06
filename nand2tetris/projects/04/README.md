

## 目标

理解Hack机器语言，实现以下汇编程序：

| 文件名  | 备注 |
| ----- | ----- |
| fill/Fill.asm | 通过任意按键控制屏幕变黑/白 |
| mult/mult.asm | 实现R2=R0*R1 |

注：可与ch05同时进行，以加深Hack机器语言设计的理解。在设计完ch05中的计算机之后，再来进行汇编程序的编写会更容易上手。


## 背景知识

+ 寻址方式：
	- 直接寻址：符号或数值被当作某个具体内存单元的地址，那么对符号或数值的使用，就是直接操作该内存单元；
	- 立即寻址：数值就是数值，没有其他意思，常用来把该数值加载进寄存器或内存单元；
	- 间接寻址：常用于指针，符号或数值被当作某个指针，其对应内存单元中存储的数值为目标内存单元的地址；
+ I/O映像（memory-mapped I/O）：计算机对I/O设备进行操作的一种实现方式，通过对I/O设备进行二进制仿真，将其映射到一段连续的内存区域，这样计算机直接操作该段内存区域的二进制编码实现对I/O设备的操作。比如屏幕，可以将屏幕每一个像素映射为1bit，这样对于256x512像素大小的屏幕，就可以映射为一段连续的、大小为8K的内存单元。


## 实现

参见对应代码文件。


## 小结

