function a=randomimage(slmwidth,slmheight)
%生成的是随机图像
%slmrwidth是使用的SLM宽度的分辨率
%slmheight是使用的SLM高度的分辨率
%gamma随机图像的平均值
%a为生成相位图的元数据
a=rand(slmheight,slmwidth);
a=255*a/max(max(a));
a=uint8(a);

imwrite(a,'randomimage.bmp');

end