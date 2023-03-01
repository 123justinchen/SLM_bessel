function a=sinegrating(slmwidth,slmheight,period,angle)
%���ɵ���axicon lens��λ��ʹ������Ϊ�������������ھ���͸���Ժ󣬿�������Բ��

%slmrwidth��ʹ�õ�SLM��ȵķֱ���
%slmheight��ʹ�õ�SLM�߶ȵķֱ���
%period �����ҹ�դ������
%angleΪ��դ��ˮƽ˳ʱ����ת�Ƕȣ���Χ��0-180��

%aΪ������λͼ��Ԫ����


a=zeros(slmheight,slmwidth);

for l=1:slmwidth;
    for m=1:slmheight;
        a(m,l)=127.5+127.5*sin(2*pi/period*cos(atan(m/l)-angle*pi/180)*sqrt(l^2+m^2));
        
    end
end


a=uint8(a);

imwrite(a,'sinegrating.bmp');

end