

## 目标

与非门定义如下：

![与非门](/img/ch01_Nand.png)

接下来基于与非门，构建以下逻辑门：

| 基础逻辑门  | 16位版本 | 多通道版本 |
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

注：每个门可能有多种不同的实现。

+ 非门：Not、Not16

	![Not](/img/ch01_Not.png)
	![Not16](/img/ch01_Not16.png)

+ 与门：And、And16

+ 或门：Or、Or16、Or8Way

+ 异或门：Xor

+ 选择器：Mux、Mux16、Mux4Way16、Mux8Way16

+ 反向选择器：DMux、DMux4Way、DMux8Way


