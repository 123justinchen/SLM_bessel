
A=imread('Target.bmp');% 读取目标强度图像Target.bmp，要求格式是8bit bmp图像
C=double(A); %将uint8格式转化为double格式，好进行后续的处理
C1=abs(C); %得到目标强度分布的幅度值
for p=1:100;  %设置迭代循环次数
    C=fftshift(C);  %在处理之前，进行fftshift处理
    D=ifft2(C);       %首先是对目标图像进行反向傅里叶变化处理，即我ppt中推荐的方法2
    D=fftshift(D); %反向傅里叶变换之后，再进行fftshift处理，从而得到入射面（SLM面）上的幅度和相位分布，其中幅度是=abs（D），相位是angle(D);
    D2=angle(D); %得到SLM上入射面的相位分布
    D=ones(size(A)).*exp(i.*D2);    %将SLM入射面的幅度替换为入射光的强度，这里入射光强度假设为均匀分布。效果一般也不错，如果有有需要，将ones(sizes(A))替换为入射光强的图像就可以了。
    D=fftshift(D); %然后进行从入射面到傅里叶平面的傅里叶变换，首先也是进行fftshift处理
    C=fft2(D);       %进行fft2处理
    C=fftshift(C);  %然后ffthisft
    C2=angle(C);  %得到相位
    C=C1.*exp(i.*C2);   %然后对傅里叶平面，相位把持不变，幅值替换为目标强度分布的幅值
    p=p+1;% 循环次数+1
end
    C=fftshift(C);  %因为循环结束是得到的傅里叶平面的强度和相位，所以需要再进行一次ift变换，从而得到SLM上的相位 
    D=ifft2(C);       
    D=fftshift(D);
    D=angle(D);  %这个就是SLM上最终相位
     
    for l=1:size(D,1);
        for m=1:size(D,2);
            if D(l,m)<0;
                D(l,m)=D(l,m)+2*pi;  %因为angle函数输出不是0-2pi，采用这个部分，将其转化为0-2pi。
            end
        end
    end
    
                
                 D=128/pi*D;%将0-2pi转化为0-255
                 D=uint8(D); %转化为8bit 格式
                 D=repmat(D,10,10);
                 D=D(1:1024,1:1272);
    imwrite(D,'CGH.bmp'); %存储为8bit bmp
figure,imshow(D)



%如何粗略模拟计算的CGH的结果
c=imread('CGH.bmp');
c=double(c);
a=exp(i.*c*2*pi/255);
d=fft2(a);
d=fftshift(d);
d=abs(d);
imagesc(d)


