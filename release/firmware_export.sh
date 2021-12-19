
rm jffs2.img flashimg.bin

mkfs.jffs2 -s 0x100 -e 0x10000 -p 0xAF0000 -d rootfs/ -o jffs2.img

dd if=/dev/zero of=flashimg.bin bs=1M count=16
dd if=u-boot-sunxi-with-spl.bin of=flashimg.bin bs=1K conv=notrunc
dd if=suniv-f1c100s-licheepi-nano.dtb of=flashimg.bin bs=1K seek=1024  conv=notrunc
dd if=zImage of=flashimg.bin bs=1K seek=1088  conv=notrunc
# mkdir rootfs
# tar -xzvf $YOUR_ROOTFS_FILE -C ./rootfs &&\
# cp -r $YOUR_MOD_FILE  rootfs/lib/modules/ &&\
# 为根文件系统制作jffs2镜像包
# --pad参数指定 jffs2大小
# 由此计算得到 0x1000000(16M)-0x10000(64K)-0x100000(1M)-0x400000(4M)=0xAF0000
# mkfs.jffs2 -s 0x100 -e 0x10000 --pad=0xAF0000 -d rootfs/ -o jffs2.img &&\
dd if=jffs2.img of=flashimg.bin  bs=1K seek=5184  conv=notrunc

sudo sunxi-fel -p spiflash-write 0 flashimg.bin
