function a=blazegrating(slmwidth,slmheight,period,angle)
%生成的是axicon lens相位，使光束变为贝塞尔光束。在经过透镜以后，可以生成圆环

%slmrwidth是使用的SLM宽度的分辨率
%slmheight是使用的SLM高度的分辨率
%period
%是正弦光栅的周期,因为闪耀光栅，period*sin(seta)=wavelength,所以锯齿最大值就是2pi，然后滨松自带软件会把他转换为所需要波长的phase
%angle为光栅从水平顺时针旋转角度，范围是0-180度

%a为生成相位图的元数据


a=zeros(slmheight,slmwidth);

for l=1:slmwidth;
    for m=1:slmheight;
        a(m,l)=mod(round(cos(atan((m-1)/(l-1))-angle*pi/180)*sqrt((l-1)^2+(m-1)^2)),period);
            end

end
a=255*a*(period-1)/period/max(max(a));

a=uint8(a);



end