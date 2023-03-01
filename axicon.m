function a=axicon(slmwidth,slmheight,radius)
%生成的是axicon lens相位，使光束变为贝塞尔光束。在经过透镜以后，可以生成圆环

%slmrwidth是使用的SLM宽度的分辨率
%slmheight是使用的SLM高度的分辨率
%radius 是相位图中中心圆的半径，单位为像素个数

%a为生成相位图的元数据


a=zeros(slmheight,slmwidth);

for l=1:slmwidth;
    for m=1:slmheight;
        a(m,l)=-sqrt((l-slmwidth/2)^2+(m-slmheight/2)^2)*2*pi/radius;
    end
end

a=mod(a,2*pi);
a=255*a/max(max(a));
a=uint8(a);

imwrite(a,'axicon.bmp');

end