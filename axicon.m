function a=axicon(slmwidth,slmheight,radius)
%���ɵ���axicon lens��λ��ʹ������Ϊ�������������ھ���͸���Ժ󣬿�������Բ��

%slmrwidth��ʹ�õ�SLM��ȵķֱ���
%slmheight��ʹ�õ�SLM�߶ȵķֱ���
%radius ����λͼ������Բ�İ뾶����λΪ���ظ���

%aΪ������λͼ��Ԫ����


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