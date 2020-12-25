## 现代计算机那点事儿（一）如何从零构建计算机



![nand2computer](https://raw.githubusercontent.com/xsddz/notes.nand2tetris/main/img/nand2computer.png)

这是一个新系列，我们将从基础的与非门元件出发，一步一步构建现代计算机的硬件平台和软件体系，这对理解计算机原理很有裨益。设想一下，用你自己亲手设计的编程语言编写程序，然后运行在你自己亲手设计的硬件平台上...

![the-big-picture](https://github.com/xsddz/notes.nand2tetris/raw/main/img/the-big-picture.png)

本文为这个系列的硬件平台部分，目录如下：

[toc]


### 1. 组合逻辑门

#### 1.1 目标

与非门定义如下（左侧为封装好的元件示意图，右侧为真值表）：

![与非门](https://raw.githubusercontent.com/xsddz/notes.nand2tetris/main/img/ch01_Nand.png)

接下来基于与非门，构建以下逻辑门：

| 基础逻辑门  | 16位逻辑门 | 多通道逻辑门 | 备注 |
| ----- | ----- | ----- | ----- |
| Not | Not16 | | 非门 |
| And | And16 | | 与门 |
| Or | Or16 | Or8Way | 或门 |
| Xor | | | 异或门 |
| Mux | Mux16 | Mux4Way16 <br> Mux8Way16 | 选择器 |
| DMux | | DMux4Way <br> DMux8Way | 反向选择器 |

并在上面的基础之上，逐步构建以下元件：

| 名称  | 备注 |
| ----- | ----- |
| HalfAdder | 半加器 |
| FullAdder | 全加器 |
| Add16 | 16位加法器 |
| Inc16 | 16位增量器 | 
| ALU | 算术逻辑单元 |

#### 1.2 背景知识

+ 基础逻辑门：从与非门开始，我们逐步构建了与门、或门、非门等基础逻辑门元件，它们的输入/输出管脚数据位数为1位，即1bit，管脚名字用字母和数字组成的符号表示，比如a、b、in、out、sel0、sel1等。

+ 16位逻辑门：输入/输出管脚数据位数为16位，即16bit，而对于数据位数大于1位的管脚，这里以数组的形式表示，比如，a[16]、b[16]、out[16]等，即name[N]表示管脚名为name，数据位数为N位。

+ 多通道逻辑门：以Or门来讲，有两个输入管脚和一个输出管脚，而多通道的版本Or8Way，则有8个输入管脚和一个输出管脚，每个管脚的数据位数为1位；同理，Mux4Way16/Mux8Way16的输入管脚为4个/8个，每个管脚的数据位数为16位，而DMux4Way/DMux8Way的输出管脚为4个/8个，每个管脚的数据位数为1位。

+ 真值表：枚举元件输入/输入对应关系的一张表格。

+ 总线(bus)宽度：我们描述计算机时，通常会说32位计算机、64位计算机，这里通常指的是其数据总线宽度为32位、64位，即32bit、64bit。

+ 二进制加法：参考生活中的十进制加法，不难理解二进制加法。

+ 十进制中正数/负数的二进制表示：
    - 二进制编码中，负数首位为1，正数为0；
    - -x的二进制码为定义为：x的二进制码所有位取反，再加1。

+ 一些算数公式的推导与理解（假定：~为取反操作，即所有位取反）：
    - -1 = ~0
    - 1 = ~(~0 + ~0)
    - -x = ~(x + ~0)
    - x+1 = ~(~x + ~0)
    - x-y = x + (-y) = ~(~x + y) = ...
	
    比如：
	
    ```
    -1 = ~1 + 1  ➮  -1 = ~0

    // 以4位二进制来讲，此时，
    // a. 1的二进制码为0001，
    // b. 故，~1的二进制码为1110，
    // c. 因此，~1 + 1的二进制码为1111，即~0，因为0的二进制码为0000
    // d. 因此，-1的二进制码和～0的二进制码是一致的，于是 -1 = ~0
    ```

#### 1.3 实现

注：每个元件均可能有多种不同的实现，下面只是其中的一种实现，会尽可能的使用已经构建好的逻辑门元件，以体现抽象、模块化、封装的理念。

+ 非门：Not、Not16

 ![Not](https://raw.githubusercontent.com/xsddz/notes.nand2tetris/main/img/ch01_Not.png)

 16位版本的实现，可以由16个Not门组成的阵列构建，每个Not门独立地处理各自对应的1位，示例如下：

 ![Not16](https://raw.githubusercontent.com/xsddz/notes.nand2tetris/main/img/ch01_Not16.png)

+ 与门：And、And16

 ![And](https://raw.githubusercontent.com/xsddz/notes.nand2tetris/main/img/ch01_And.png)

 16位版本的实现，可参考上面Not16的实现。

+ 或门：Or、Or16、Or8Way

 ![Or](https://raw.githubusercontent.com/xsddz/notes.nand2tetris/main/img/ch01_Or.png)

 16位版本的实现，可参考上面Not16的实现。Or8Way实现如下：

 ![Or8Way](https://raw.githubusercontent.com/xsddz/notes.nand2tetris/main/img/ch01_Or8Way.png)

+ 异或门：Xor

 ![Xor](https://raw.githubusercontent.com/xsddz/notes.nand2tetris/main/img/ch01_Xor.png)

+ 选择器：Mux、Mux16、Mux4Way16、Mux8Way16。根据选择控制位，在多个输入中选择一个输出。

 ![Mux](https://raw.githubusercontent.com/xsddz/notes.nand2tetris/main/img/ch01_Mux.png)

 16位版本的实现，可参考上面Not16的实现。Mux4Way16的实现如下：

 ![Mux4Way16](https://raw.githubusercontent.com/xsddz/notes.nand2tetris/main/img/ch01_Mux4Way16.png)

 参考上图真值表，这里的考虑如下：

 a. 对于sel1=1和sel0=1时，使用一个Mux16，那么可以在d与abc之间作出选择；
 b. 此时，忽略sel1（把sel1列捂住），对于sel0的变化，使用一个Mux16在b与ac之间作出选择;
 c. 此时，忽略sel0（把sel0列捂住），ac的选择，正好对应sel1的变化；

 同样的思路，基于已经实现的Mux4Way16逻辑门，Mux8Way16的实现如下：

 ![Mux8Way16](https://raw.githubusercontent.com/xsddz/notes.nand2tetris/main/img/ch01_Mux8Way16.png)

+ 反向选择器：DMux、DMux4Way、DMux8Way。根据选择控制位，从多个输出中选择一个，将输入输出。

 ![DMux](https://raw.githubusercontent.com/xsddz/notes.nand2tetris/main/img/ch01_DMux.png)

 DMux4Way的实现如下：

 ![DMux4Way](https://raw.githubusercontent.com/xsddz/notes.nand2tetris/main/img/ch01_DMux4Way.png)

 参考上图真值表，考虑如下：

 a. 忽略sel0时（把sel0列捂住）：
    - sel1=0时，对于一个DMux，in的输入，输出对应为a和b；
    - sel1=1时，对于同一个DMux，in的输入，输出对应为c和d；

 b. 忽略sel1时（把sel1列捂住）：
    - sel0=0时，对于一个DMux，in的输入，输出对应为a和c；
    - sel0=1时，对于同一个DMux，in的输入，输出对应为b和d；

 这样，对于以上4种输出的And门组合，便可以得到a、b、c、d。同样的思路，基于已经实现的DMux4Way逻辑门，DMux8Way的实现如下：

 ![DMux8Way](https://raw.githubusercontent.com/xsddz/notes.nand2tetris/main/img/ch01_DMux8Way.png)

+ 半加器：HalfAdder。对2个1位的数据输入执行加法运算，sum为1位结果，carry为进位标识。

 ![HalfAdder](https://raw.githubusercontent.com/xsddz/notes.nand2tetris/main/img/ch02_HalfAdder.png)

+ 全加器：FullAdder。对3个1位的数据输入执行加法运算，sum为1位结果，carry为进位标识。

 ![HalfAdder](https://raw.githubusercontent.com/xsddz/notes.nand2tetris/main/img/ch02_FullAdder.png)

+ 16位加法器：Add16。对2个16位的数据输入执行加法运算，out为16位结果，忽略溢出情况。

 ![HalfAdder](https://raw.githubusercontent.com/xsddz/notes.nand2tetris/main/img/ch02_Add16.png)

+ 16位增量器：Inc16。对1个16位的数据输入执行加1运算，忽略溢出情况。

 ![HalfAdder](https://raw.githubusercontent.com/xsddz/notes.nand2tetris/main/img/ch02_Inc16.png)

+ 算术逻辑单元：ALU。对2个16位的数据输入x、y，执行对应的算数或逻辑运算，忽略溢出情况。

 ![HalfAdder](https://raw.githubusercontent.com/xsddz/notes.nand2tetris/main/img/ch02_ALU.png)

 注1：这里给出了尝试的两种实现。
 注2：留意这个真值表的作用，后面在设计CPU指令和实现CPU时非常有用。

#### 1.4 小结

二进制、二进制下正/负数的设计、以及背后完善的计算理论，奠定了现代计算机基础。现代计算机，一般采用电学中高、低电平两种状态来表示二进制的两种数值1、0，然后通过能够传导电信号的金属导线来构建现代计算机的各种基础元件，进而构建现代计算机。实际上，任何具有这种状态转换和状态传导的技术，在同一套理论的支持下，都是可以一步一步完成计算机的构建。如今，量子计算理论是一个历史趋势。


### 2 时序芯片

#### 2.1 目标

DFF（D触发器）定义如下（左侧为封装好的元件示意图，右侧为真值表）：

![DFF](https://raw.githubusercontent.com/xsddz/notes.nand2tetris/main/img/ch01_Nand.png)

接下来我们将基于DFF和前面已经构建好的组合逻辑元件，构建以下存储芯片：

| 名称  | 备注 |
| ----- | ----- |
| Bit | 1位宽寄存器 |
| Register | 16位宽寄存器 |
| RAM8 | 16位宽RAM，大小：8 |
| RAM64 | 16位宽RAM，大小：64 | 
| RAM512 | 16位宽RAM，大小：512 |
| RAM4K | 16位宽RAM，大小：4K |
| RAM16K | 16位宽RAM，大小：16K |
| PC | 16位宽程序计数器 |

注：DFF也可以通过前面的Nand门，使用带反馈回路的逻辑来构建，这里我们把它同Nand门一样，当作基础元件。

#### 2.2 背景知识

+ 时序芯片：时序芯片均有一个三角形符号，代表时钟输入。由组合逻辑元件和时序芯片构建的新芯片，同样为时序芯片。时序芯片的当前输出总是滞后一个时钟周期，即out(t)=out(t-1)。

+ 组合逻辑元件的问题：对于任何一个组合逻辑元件，显而易见的，其输入一旦发生变化，输出也会立即产生变化。对于一个计算机系统内部，比如ALU，其不同引脚的数据信号（受传输线路的距离、随机噪声等等影响），很难保证在同一时刻到达，产生正确的输出，这样，在所有输入数据未同时到达时，显然输出了不符合预期的垃圾值。

+ 时序芯片的作用：时序芯片通过引入一个时钟输入引脚，来决定芯片的最终输出。只需要保证，设计的计算机时钟周期长度比1个比特在计算系系统内部两个物理距离最长的芯片之间传输时间稍长，那么对于时序芯片的下一个时钟周期输出就是符合预期的。这样，整个计算机系统在同一个时钟信号的指挥下，便可以保证同步。

+ 寄存器（Register）宽度：bit的数量，常用字表示。

+ RAM大小和宽度：RAM通常由n个w位宽的寄存器组成阵列构建，故，RAM宽度为w，RAM大小为n；现代计算机通常采用32位宽或64位宽的RAM。

#### 2.3 实现

注：每个存储芯片可能有多种不同的实现，下面只是其中的一种实现，会尽可能的使用已经构建好的元件，以体现抽象、模块化、封装的理念。

+ 1位-寄存器：Bit

 ![Bit](https://raw.githubusercontent.com/xsddz/notes.nand2tetris/main/img/ch03_Bit.png)

+ 16位-寄存器：Register

 ![Register](https://raw.githubusercontent.com/xsddz/notes.nand2tetris/main/img/ch03_Register.png)

+ 16位-RAM8

 ![RAM8](https://raw.githubusercontent.com/xsddz/notes.nand2tetris/main/img/ch03_RAM8.png)

+ 16位-RAMn

 ![RAMn](https://raw.githubusercontent.com/xsddz/notes.nand2tetris/main/img/ch03_RAMn.png)

 这里我们总是基于已经构建好的RAM和选择器、反向选择器去构建存储更大的RAM。n和RAM的address引脚宽度k的关系如图中表格所示，即以2为底的指数关系。

 RAM的表现描述如下（牢记这一点，在之后构建CPU时，助于理解CPU操作逻辑）：

 a. load=0，给定RAM的address输入，总是输出RAM内部对应地址位置的Register上存储的数据；
 b. load=1，给定RAM的address输入，RAM内部对应地址位置的Register上存储in输入给出的数据，并在下一个时钟周期输出；

+ 16位-程序计数器：PC

 ![PC](https://raw.githubusercontent.com/xsddz/notes.nand2tetris/main/img/ch03_PC.png)

#### 2.4 小结

这里，我们基于DFF构建了计算机的RAM存储元件。现代计算机的存储设备，还可以由其他技术实现，比如机械硬盘，使用磁。但总的来讲，这里构建的RAM元件，已经满足了我们将要构建的现代计算机要求。


### 3 计算机体系结构

#### 3.1 目标

现代计算机的定义如下（典型的台式机示例）：

![Computer](https://raw.githubusercontent.com/xsddz/notes.nand2tetris/main/img/ch05_Computer.png)

接下来基于已经构建好的元件和RAM存储芯片，构建以下组装计算机需要的芯片，最后搭建完整的计算机硬件平台：

| 名称  | 备注 |
| ----- | ----- |
| CPU | CPU芯片 |
| Screen | 屏幕I/O映像 |
| Keyboard | 键盘I/O映像 |
| Memory | 数据内存 |
| ROM32K | 指令内存 |
| Computer | 计算机 |

#### 3.2 背景知识

+ 寻址方式：
    - 直接寻址：符号或数值被当作某个具体内存单元的地址，那么对符号或数值的使用，就是直接操作该内存单元；
    - 立即寻址：数值就是数值，没有其他意思，常用来把该数值加载进寄存器或内存单元；
    - 间接寻址：常用于指针，符号或数值被当作某个指针，其对应内存单元中存储的数值为目标内存单元的地址。

+ I/O映像（memory-mapped I/O）：计算机对I/O设备进行操作的一种实现方式，通过对I/O设备进行二进制仿真，将其映射到一段连续的内存区域，这样计算机直接操作该段内存区域的二进制编码以实现对I/O设备的操作。比如屏幕，可以将屏幕每一个像素映射为1bit，这样对于256x512像素大小的屏幕，就可以映射为一段连续的、大小为8K的内存单元。

+ 存储程序理念：
    1. 基于特定硬件构建的计算机平台，能够执行一组特定的指令，又叫指令集；
    2. 与计算机底层硬件一样，指令集也被视为计算机的一种构件；
    3. 利用指令集这种构件，我们可以编排出一组满足我们特定目的的操作，我们这组操作打包，叫做程序；
    4. 我们可以把这种程序和数据一样，存储起来，供计算机平台读取执行，并把它叫做软件；
    5. 这样，如果把一种软件替换为另一种，那么基于特定硬件构建的计算机平台就可以读取执行另一种的软件的逻辑，进而实现不同的功能。

+ 冯·诺伊曼体系结构：如下图所示，为冯·诺伊曼体系结构概念，是典型的存储程序理念体现。CPU为该体系结构核心，
    1. 它与内存单元（分为指令内存和数据内存两种，分别用于存储数据和指令）进行交互；
    2. 它从输入设备接收数据；
    3. 它向输出设备发送数据；

    ![Feng](https://raw.githubusercontent.com/xsddz/notes.nand2tetris/main/img/ch05_Feng.png)

+ 读取-执行循环（read-execute cycle）：
    1. 从指令内存读取下一条指令；
    2. 解码指令；
    3. 执行指令对应的计算/逻辑操作;
    4. goto 1。

+ 通用/专用计算机：
    + 通用计算机内存可以动态加载不同的一组指令，去实现各种各样的功能；
    + 专用计算机内存被烧写进一组指令，只能读取执行，如果要实现其他的功能，需要更换内存，比如早期的小霸王游戏机。


#### 3.3 实现

注：每个芯片可能有多种不同的实现，下面只是其中的一种实现，会尽可能的使用已经构建好的元件，以体现抽象、模块化、封装的理念。

Computer结构定义如下

![Computer_Impl](https://raw.githubusercontent.com/xsddz/notes.nand2tetris/main/img/ch05_Computer_Impl.png)

下面是该Computer各个元件的实现。

+ CPU芯片

 CPU芯片指令集设计如下（共两条指令）：

 ![CPU_Instruction](https://raw.githubusercontent.com/xsddz/notes.nand2tetris/main/img/ch05_CPU_Instruction.png)

 CPU芯片实现如下：

 ![CPU](https://raw.githubusercontent.com/xsddz/notes.nand2tetris/main/img/ch05_CPU.png)

+ 屏幕I/O映像：Screen

 使用内建的Screen芯片，映射为8K的RAM存储单元：

 ![Screen](https://raw.githubusercontent.com/xsddz/notes.nand2tetris/main/img/ch05_Screen.png)

+ 键盘I/O映像：Keyboard

 使用内建的Keyboard芯片，映射为16bit的RAM存储单元，即一个16位寄存器：

 ![Keyboard](https://raw.githubusercontent.com/xsddz/notes.nand2tetris/main/img/ch05_Keyboard.png)

+ 数据内存：Memory

 我们将一个前面构建的RAM16K、Screen和Keyboard组合在一起，便形成了我们需要的数据内存：

 ![Memory](https://raw.githubusercontent.com/xsddz/notes.nand2tetris/main/img/ch05_Memory.png)

+ 指令内存：ROM32K

 使用内建的ROM32K芯片，内部实现见RAMn芯片的实现，不同的是，ROM是只读内存，因此是有一个address输入引脚。ROM中的机器指令通常会烧录进去。

 ![ROM32K](https://raw.githubusercontent.com/xsddz/notes.nand2tetris/main/img/ch05_ROM32K.png)

#### 3.4 小结

到这里，我们的现代计算机硬件平台已经构建完成了，和我们常说的32位、64位计算机不同的是，我们构建的计算机为16位的。

现代计算机通常会区分复杂指令集、精简指令集，他们之间的区别在于，前者注重性能，提供了丰富、详细的指令集，后者注重硬件速度，提供了简单的指令集。我们这里实现的计算机CPU指令集，非常简单，不站队。


### 参考资料

+ The elements of computing systems: building a modern computer from first principles (2008, MIT Press)


