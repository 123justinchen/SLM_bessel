function a=divide(slmwidth,slmheight,grayvalue1,grayvalue2)
%生成的是左右一半灰度不同的图像。grayvalue1是左半测图像的灰度。grayvalue2是右侧图像的灰度
%slmrwidth是使用的SLM宽度的分辨率
%slmheight是使用的SLM高度的分辨率
%grayvalue，是两块区域的灰度
%a为生成相位图的元数据
a=zeros(slmheight,slmwidth);
a(:,1:slmwidth/2)=grayvalue1;
a(:,slmwidth/2+1:slmwidth)=grayvalue2;
a=uint8(a);
imwrite(a,'dividescreen.bmp');

end