function a=divide(slmwidth,slmheight,grayvalue1,grayvalue2)
%���ɵ�������һ��ҶȲ�ͬ��ͼ��grayvalue1������ͼ��ĻҶȡ�grayvalue2���Ҳ�ͼ��ĻҶ�
%slmrwidth��ʹ�õ�SLM��ȵķֱ���
%slmheight��ʹ�õ�SLM�߶ȵķֱ���
%grayvalue������������ĻҶ�
%aΪ������λͼ��Ԫ����
a=zeros(slmheight,slmwidth);
a(:,1:slmwidth/2)=grayvalue1;
a(:,slmwidth/2+1:slmwidth)=grayvalue2;
a=uint8(a);
imwrite(a,'dividescreen.bmp');

end