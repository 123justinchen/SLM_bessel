function a=blazegrating(slmwidth,slmheight,period,angle)
%���ɵ���axicon lens��λ��ʹ������Ϊ�������������ھ���͸���Ժ󣬿�������Բ��

%slmrwidth��ʹ�õ�SLM��ȵķֱ���
%slmheight��ʹ�õ�SLM�߶ȵķֱ���
%period
%�����ҹ�դ������,��Ϊ��ҫ��դ��period*sin(seta)=wavelength,���Ծ�����ֵ����2pi��Ȼ������Դ���������ת��Ϊ����Ҫ������phase
%angleΪ��դ��ˮƽ˳ʱ����ת�Ƕȣ���Χ��0-180��

%aΪ������λͼ��Ԫ����


a=zeros(slmheight,slmwidth);

for l=1:slmwidth;
    for m=1:slmheight;
        a(m,l)=mod(round(cos(atan((m-1)/(l-1))-angle*pi/180)*sqrt((l-1)^2+(m-1)^2)),period);
            end

end
a=255*a*(period-1)/period/max(max(a));

a=uint8(a);



end