function a=frensnellens(slmwidth,slmheight,focal_length,wavelength)
%生成的是球面菲尼尔反射镜，因此焦距等于反射镜球面半径的一半。

%slmrwidth是使用的SLM宽度的分辨率
%slmheight是使用的SLM高度的分辨率
%focal_length菲尼尔镜的焦距，是负数的时候，是等价于凹面镜，光束会汇聚，而正数时候等价于凸面镜，光束会发散。单位是mm，比如焦距为800mm的菲尼尔镜，就输入800
%wavelength 为波长，输入的时候单位是nm，比如800nm光，就输入800
%a为生成相位图的元数据

pixelsize=25*10^(-3);
a=zeros(slmheight,slmwidth);
wavelength=wavelength/10^6;%convert from nm to mm
R=2*abs(focal_length);% radial length of the mirror 
mirror=zeros(slmheight,slmwidth);
for l=1:slmwidth;
    for m=1:slmheight;
        mirror(m,l)=R-sqrt(R^2-((l-slmwidth/2)^2+(m-slmheight/2)^2)*pixelsize^2);
    end
end
mirror=max(max(mirror))-mirror;

a=mirror/wavelength*2*pi;
a=mod(a,2*pi);
a=255*a/max(max(a));
a=uint8(a);
if focal_length<=0
imwrite(a,'fresnellens.bmp');
else  if focal_length>0
        a=255-a;
        imwrite(a,'fresnellens.bmp');
    end
end 
    
end