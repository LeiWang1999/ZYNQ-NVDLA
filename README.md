<h1 align="center">ZYNQ-NVDLA</h1>

Here is my final year project for Bachelor，NVDLA Xilinx FPGA Mapping！

[Technical Post](https://leiblog.wang/NVDLA-Xilinx-FPGA-Mapping)

[Graduation Paper](https://leiblog.wang/static/2021-05-30/%E6%9C%AC%E7%A7%91%E6%AF%95%E4%B8%9A%E8%AE%BE%E8%AE%A1%E8%AE%BA%E6%96%87.pdf)

## System Design

![系统设计](http://leiblog.wang/static/image/2021/5/SystemDesign.png)

## File Tree of WorkSpace

```
RTL/ nvdla small rtl (include wrapper.v)
kmd/ kernel mode drive for petalinux (include zynq7000 / zynq MPSoc)
paper/ Latex paper for Bachelor degree
reports/ Timing、Power、Resource、Execution reports
sdk_sanity/ sdk sanity Test for NVDLA
umd/ User Mode code
```

## Test

![](http://leiblog.wang/static/image/2021/5/DNkWv2.png)

## Reference

1. https://vvviy.github.io/2018/09/12/nv_small-FPGA-Mapping-Workflow-I/
2. https://vvviy.github.io/2018/09/17/nv_small-FPGA-Mapping-Workflow-II/
3. [http://leiblog.wang/NVDLA-int8-%E9%87%8F%E5%8C%96%E7%AC%94%E8%AE%B0/](http://leiblog.wang/NVDLA-int8-量化笔记/)
4. http://leiblog.wang/NVDLA-Parser-Loadable-Analysis/
5. http://nvdla.org/primer.html
6. http://leiblog.wang/Embedding-board-internet-via-PC-Ethernet/
7. https://github.com/SameLight/ITRI-OpenDLA
8. https://gitee.com/starrynightzyq/njtech-Thesis