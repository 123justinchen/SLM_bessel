function a=randomimage(slmwidth,slmheight)
%���ɵ������ͼ��
%slmrwidth��ʹ�õ�SLM��ȵķֱ���
%slmheight��ʹ�õ�SLM�߶ȵķֱ���
%gamma���ͼ���ƽ��ֵ
%aΪ������λͼ��Ԫ����
a=rand(slmheight,slmwidth);
a=255*a/max(max(a));
a=uint8(a);

imwrite(a,'randomimage.bmp');

end