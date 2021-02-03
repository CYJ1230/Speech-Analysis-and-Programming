function [axis_scaler spectrum_p] = lpc_single(pos,sp,fs)
% ˵����
% ����ͨ��audioread������ȡ�������źźͻ�Ƶ���Լ�ʱ���������ʱ���
% ���ظ����������ڸ�ʱ����LPC���������

% [sp fs]=audioread('aaa.wav');
if pos<length(sp)-256 && pos>255 
    sp=sp(pos-255:pos+256,1);
elseif pos>=length(sp)-256
    sp=sp(pos-511:pos,1);
elseif pos<=255
    sp=sp(pos:pos+511,1);
end
%�������ѡ�������߽磬�Ͳ��ܴ����߸�ȡ256�ˣ�����һ���жϡ�

fftpnt=512;
lpc_order=10;

lpc_coe=lpc(sp,lpc_order)';%coefficient ϵ��;
fft_coe=fft(lpc_coe,fftpnt);
spectrum_p=10*log10(abs(fft_coe))*-1;
spectrum_p=spectrum_p(1:fftpnt/2,1);

max_p=max(spectrum_p);
min_p=ceil(min(spectrum_p));

for i=1:fftpnt/2
    axis_scaler(i)=i*((fs/2)/(fftpnt/2));
end

plot(axis_scaler,spectrum_p); 

% ������� ��֡lpc���� lpc��ά��ͼ

end

