function a=frensnellens(slmwidth,slmheight,focal_length,wavelength)
%���ɵ��������������侵����˽�����ڷ��侵����뾶��һ�롣

%slmrwidth��ʹ�õ�SLM��ȵķֱ���
%slmheight��ʹ�õ�SLM�߶ȵķֱ���
%focal_length��������Ľ��࣬�Ǹ�����ʱ���ǵȼ��ڰ��澵���������ۣ�������ʱ��ȼ���͹�澵�������ᷢɢ����λ��mm�����罹��Ϊ800mm�ķ��������������800
%wavelength Ϊ�����������ʱ��λ��nm������800nm�⣬������800
%aΪ������λͼ��Ԫ����

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