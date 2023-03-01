function a=sinegrating(slmwidth,slmheight,period,angle)
%生成的是axicon lens相位，使光束变为贝塞尔光束。在经过透镜以后，可以生成圆环

%slmrwidth是使用的SLM宽度的分辨率
%slmheight是使用的SLM高度的分辨率
%period 是正弦光栅的周期
%angle为光栅从水平顺时针旋转角度，范围是0-180度

%a为生成相位图的元数据


a=zeros(slmheight,slmwidth);

for l=1:slmwidth;
    for m=1:slmheight;
        a(m,l)=127.5+127.5*sin(2*pi/period*cos(atan(m/l)-angle*pi/180)*sqrt(l^2+m^2));
        
    end
end


a=uint8(a);

imwrite(a,'sinegrating.bmp');

end