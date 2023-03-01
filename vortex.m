function a_wo_grating=vortex(slmwidth,slmheight,lnumber)
%slmrwidth��ʹ�õ�SLM��ȵķֱ���
%slmheight��ʹ�õ�SLM�߶ȵķֱ���
%lnumber�������˵����
%a_wo_grating����������l���˵���������������λͼ
%a_width_grating����������l���˵������������Ĳ��ҵ����˹�դ����λͼ

angle=zeros(slmheight,slmwidth);
a_wo_grating=zeros(slmheight,slmwidth);
for l=1:slmwidth
for m=1:slmheight
      if l>=slmwidth/2&m<=slmheight/2; 
angle(m,l)=atan((slmheight/2-m)/(l-slmwidth/2));
else if l<slmwidth/2&m<slmheight/2; 
angle(m,l)=pi-atan((slmheight/2-m)/(slmwidth/2-l));
else if l<=slmwidth/2&m>=slmheight/2;
angle(m,l)=pi+atan((m-slmheight/2)/(slmwidth/2-l));
else if l>=slmwidth/2&m>=slmheight/2;
angle(m,l)=2*pi-atan((m-slmheight/2)/(l-slmwidth/2));
end;
end;
end;
end;
end;
end;
a_wo_grating=mod(angle*lnumber,2*pi);
a_wo_grating=255*a_wo_grating/max(max(a_wo_grating));
a_wo_grating=uint8(a_wo_grating);
imwrite(a_wo_grating,'vortex.bmp');
end


