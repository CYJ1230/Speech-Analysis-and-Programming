function pow_spectrum=fft_single(pos,sp,fs)
% ˵����
% ����ͨ��audioread������ȡ�������źźͻ�Ƶ���Լ�ʱ�����ϵĺ�����
% ���ظ���������ָ��ʱ���Ĺ����ס�

% sp=audioread('shehui.wav');
% sp=sp(4000:4000+511,1);%�ӵ�4000���źſ�ʼѡ512����
if pos<length(sp)-256 && pos>255 
    sp=sp(pos-255:pos+256,1);
elseif pos>=length(sp)-256
    sp=sp(pos-511:pos,1);
elseif pos<=255
    sp=sp(pos:pos+511,1);
end
win=blackman(512); %black��һ��������
sp_win=sp.*win;
fft_co=fft(sp_win,512);%fft��ϵ��
% plot(fft_co);
sp_fft=10*log(abs(fft_co));
% plot(sp_fft);%ʵ��������ֻ��Ҫ���ͼ��һ��
pow_spectrum=sp_fft(1:512/2,1);
% plot(pow_spectrum);%����һ��Ĺ�����
% ��������һ����ѭ�� һ��һ��ȥ����