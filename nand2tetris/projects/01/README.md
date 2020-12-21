

## 目标

与非门定义如下：

![与非门](/img/ch01_Nand.png)

接下来基于与非门，构建以下逻辑门：

| 基础逻辑门  | 16位逻辑门 | 多通道逻辑门 |
| ----- | ----- | ----- |
| Not | Not16 | |
| And | And16 | |
| Or | Or16 | Or8Way |
| Xor | | 
| Mux | Mux16 | Mux4Way16 <br> Mux8Way16 |
| DMux | | DMux4Way <br> DMux8Way |


## 背景知识

+ 逻辑门输入/输出管脚：基础逻辑门为1位（1bit），16位逻辑门为16位（16bit）。对于大于1位的管脚，这里以数组的形式表示：比如，管脚a表示1位，a[16]表示16位，即a[n]表示n位；
+ 多通道逻辑门：比如，基础逻辑门Or有两个输入管脚，每个管脚为1位，那么对于多通道版本的Or8Way，有8个输入管脚，每个管脚为1位；
+ 总线(bus)宽度：通常我们将1bit看作1位，对于32位、64位计算机指的是其数据总线宽度为32位、64位，即32bit、64bit。


## 实现

注：每个门可能有多种不同的实现，下面的实现，会尽可能的使用已经构建好的逻辑门组件，以体现抽象、模块化、封装的理念。

+ 非门：Not、Not16

	![Not](/img/ch01_Not.png)

	16位版本的实现，可以由16个Not门组成的阵列构建，每个Not门独立地处理各自对应的1位，示例如下：

	![Not16](/img/ch01_Not16.png)

+ 与门：And、And16

	![And](/img/ch01_And.png)

	16位版本的实现，可参考上面Not16。

+ 或门：Or、Or16、Or8Way

	![Or](/img/ch01_Or.png)

	16位版本的实现，可参考上面Not16。Or8Way实现如下：

	![Or8Way](/img/ch01_Or8Way.png)

+ 异或门：Xor

	![Xor](/img/ch01_Xor.png)

+ 选择器：Mux、Mux16、Mux4Way16、Mux8Way16

	![Mux](/img/ch01_Mux.png)

	16位版本的实现，可参考上面Not16。Mux4Way16的实现，参考下图真值表，考虑如下：
	- 对于sel1=1和sel0=1时，使用一个Mux16，那么可以在d与abc之间作出选择；
	- 此时，忽略sel1，对于sel0的变化，使用一个Mux16在b与ac之间作出选择;
	- 此时，忽略sel0，ac的选择，正好对应sel1的变化；

	这样，Mux4Way16的实现如下：

	![Mux4Way16](/img/ch01_Mux4Way16.png)

	同样的思路，基于已经实现的Mux4Way16逻辑门，Mux8Way16的实现如下：

	![Mux8Way16](/img/ch01_Mux8Way16.png)

+ 反向选择器：DMux、DMux4Way、DMux8Way

	![DMux](/img/ch01_DMux.png)

	DMux4Way的实现，参考下图真值表，忽略sel0时，考虑如下：
	- sel1=0时，in的输入经过DMux后，输出对应为a和b；
	- sel1=1是，in的输入经过DMux后，输出对应为c和d；
	
	而忽略sel1时，考虑如下：
	- sel0=0时，in的输入经过DMux后，输出对应为a和c；
	- sel0=1是，in的输入经过DMux后，输出对应为b和d；
	
	这样，对于以上4种输出的And组合，便可以得到a、b、c、d，实现如下：

	![DMux4Way](/img/ch01_DMux4Way.png)

	同样的思路，基于已经实现的DMux4Way逻辑门，DMux8Way的实现如下：

	![DMux8Way](/img/ch01_DMux8Way.png)


