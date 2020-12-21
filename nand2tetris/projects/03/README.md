

## 目标

DFF（D触发器）定义如下：

![DFF](/img/ch03_DFF.png)

接下来基于DFF和与非门以及ch01-02中已经构建好的逻辑门，构建以下存储芯片：

| 名称  | 备注 |
| ----- | ----- |
| Bit | 1位寄存器 |
| Register | 16位宽寄存器 |
| RAM8 | 16位宽RAM，大小：8 |
| RAM64 | 16位宽RAM，大小：64 | 
| RAM512 | 16位宽RAM，大小：512 |
| RAM4K | 16位宽RAM，大小：4K |
| RAM16K | 16位宽RAM，大小：16K |
| PC | 16位宽程序计数器 |

注：DFF可以通过Nand门，使用带反馈回路的逻辑来构建。

## 背景知识

+ 时序芯片的输出：时序芯片的当前输出总是滞后一个时钟周期，即out(t)=out(t-1)；
+ 组合逻辑芯片（门）会产生垃圾值的问题：对于任何一个组合逻辑芯片（门），显而易见的，其输入一旦发生变化，其输出也会立即产生变化，故对于一个计算机系统内部，比如ALU，其不同引脚的数据信号（受传输线路的距离、随机噪声等等印象），很难保证在同一时刻到达，进而产生正确的输出，而在这之前，其输出是不符合预期的垃圾值。
+ 时序芯片保证整个计算机系统同步的策略：时序芯片通过引入一个时钟输入引脚，来决定该芯片的最终输出。只需要保证，设计的计算机时钟周期长度比1个比特在计算系系统内部两个物理距离最长的芯片之间传输时间稍长，那么对于时序芯片的下一个时钟周期输出就是稳定的、符合预期的。这样，整个计算机系统在同一个时钟信号的指挥下，便可保证同步。
+ 寄存器宽度：bit的数量，常用字表示；
+ RAM大小和宽度：通常RAM由n个寄存器组成的阵列构成，故，RAM宽度=寄存器宽度，RAM大小=n；现代计算机通常采用32位宽或64位宽的RAM；


## 实现

注：每个存储芯片 可能有多种不同的实现，下面的实现，会尽可能的使用已经构建好的元件，以体现抽象、模块化、封装的理念。

### 1位-寄存器：Bit

![Bit](/img/ch03_Bit.png)

### 16位-寄存器：Register

![Register](/img/ch03_Register.png)

### 16位-RAM8

![RAM8](/img/ch03_RAM8.png)

### 16位-RAMn

![RAMn](/img/ch03_RAMn.png)

这里我们总是基于已经构建好的RAM和选择器与反向选择器去构建存储更大的RAM。n和RAM的address引脚宽度k的关系如图所示，即以2为底的指数关系。

RAM的表现描述如下（牢记这一点，可在之后构建CPU时有助于理解逻辑）：
- load=0，给定RAM的address输入，总是输出RAM内部对应地址位置的Register上存储的数据；
- load=1，给定RAM的address输入，RAM内部对应地址位置的Register上存储in输入给出的数据，并在下一个时钟周期输出；

### 16位-程序计数器：PC

![PC](/img/ch03_PC.png)


## 小结