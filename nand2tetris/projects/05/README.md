

## 目标

现代计算机的定义如下：

![Computer](/img/ch05_Computer.png)

接下来基于ch01-03中已经构建好的芯片和ch04中的CPU指令设计，构建以下芯片，最后构建完整的计算机硬件平台：

| 名称  | 备注 |
| ----- | ----- |
| CPU | CPU芯片 |
| Screen | 屏幕I/O映像 |
| Keyboard | 键盘I/O映像 |
| Memory | 数据内存 |
| ROM32K | 指令内存 |
| Computer | 计算机 |


并在完成的计算机硬件平台上，测试以下机器语言程序：

| 机器语言程序文件  | 备注 |
| ----- | ----- |
| Add.hack | 实现两个常数相加 |
| Max.hack | 比较最大值 |
| Rect.hack | 屏幕左上角绘出黑色矩形框 |


## 背景知识

+ 存储程序理念：
+ 冯·诺伊曼体系结构：
+ 通用/专用计算机：
+ 读取-执行循环（read-execute cyle）：
+ 复杂/精简指令集：


## 实现

注：每个芯片可能有多种不同的实现，下面的实现，会尽可能的使用已经构建好的元件，以体现抽象、模块化、封装的理念。

### CPU芯片

CPU芯片指令集设计如下：

![CPU_Instruction](/img/ch05_CPU_Instruction.png)

CPU芯片实现如下：

![CPU](/img/ch05_CPU.png)

### 屏幕I/O映像：Screen

使用内建的Screen芯片，映射为8K的RAM存储单元：

![Screen](/img/ch05_Screen.png)

### 键盘I/O映像：Keyboard

使用内建的Keyboard芯片，映射为16bit的RAM存储单元，即一个16位寄存器：

![Keyboard](/img/ch05_Keyboard.png)

### 数据内存：Memory

![Memory](/img/ch05_Memory.png)

### 指令内存：ROM32K

使用内建的ROM32K芯片，内部机制常见前面设计的RAMn芯片，不同的是，ROM是只读内存：

![ROM32K](/img/ch05_ROM32K.png)

### Computer

![Computer_Impl](/img/ch05_Computer_Impl.png)

### 机器语言测试

增加以下汇编代码、编译之后的二进制机器码及测试文件：

```
ComputerHello.tst
Hello.asm          // 实现在屏幕左上角显示大些字母H的功能
Hello.hack
```

## 小结

	