
A=imread('Target.bmp');% ��ȡĿ��ǿ��ͼ��Target.bmp��Ҫ���ʽ��8bit bmpͼ��
C=double(A); %��uint8��ʽת��Ϊdouble��ʽ���ý��к����Ĵ���
C1=abs(C); %�õ�Ŀ��ǿ�ȷֲ��ķ���ֵ
for p=1:100;  %���õ���ѭ������
    C=fftshift(C);  %�ڴ���֮ǰ������fftshift����
    D=ifft2(C);       %�����Ƕ�Ŀ��ͼ����з�����Ҷ�仯��������ppt���Ƽ��ķ���2
    D=fftshift(D); %������Ҷ�任֮���ٽ���fftshift�����Ӷ��õ������棨SLM�棩�ϵķ��Ⱥ���λ�ֲ������з�����=abs��D������λ��angle(D);
    D2=angle(D); %�õ�SLM�����������λ�ֲ�
    D=ones(size(A)).*exp(i.*D2);    %��SLM������ķ����滻Ϊ������ǿ�ȣ����������ǿ�ȼ���Ϊ���ȷֲ���Ч��һ��Ҳ�������������Ҫ����ones(sizes(A))�滻Ϊ�����ǿ��ͼ��Ϳ����ˡ�
    D=fftshift(D); %Ȼ����д������浽����Ҷƽ��ĸ���Ҷ�任������Ҳ�ǽ���fftshift����
    C=fft2(D);       %����fft2����
    C=fftshift(C);  %Ȼ��ffthisft
    C2=angle(C);  %�õ���λ
    C=C1.*exp(i.*C2);   %Ȼ��Ը���Ҷƽ�棬��λ�ѳֲ��䣬��ֵ�滻ΪĿ��ǿ�ȷֲ��ķ�ֵ
    p=p+1;% ѭ������+1
end
    C=fftshift(C);  %��Ϊѭ�������ǵõ��ĸ���Ҷƽ���ǿ�Ⱥ���λ��������Ҫ�ٽ���һ��ift�任���Ӷ��õ�SLM�ϵ���λ 
    D=ifft2(C);       
    D=fftshift(D);
    D=angle(D);  %�������SLM��������λ
     
    for l=1:size(D,1);
        for m=1:size(D,2);
            if D(l,m)<0;
                D(l,m)=D(l,m)+2*pi;  %��Ϊangle�����������0-2pi������������֣�����ת��Ϊ0-2pi��
            end
        end
    end
    
                
                 D=128/pi*D;%��0-2piת��Ϊ0-255
                 D=uint8(D); %ת��Ϊ8bit ��ʽ
                 D=repmat(D,10,10);
                 D=D(1:1024,1:1272);
    imwrite(D,'CGH.bmp'); %�洢Ϊ8bit bmp
figure,imshow(D)



%��δ���ģ������CGH�Ľ��
c=imread('CGH.bmp');
c=double(c);
a=exp(i.*c*2*pi/255);
d=fft2(a);
d=fftshift(d);
d=abs(d);
imagesc(d)


