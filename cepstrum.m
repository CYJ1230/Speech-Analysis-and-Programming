function [cepstrum_result f0_max f0_max_p f0_temp]=cepstrum(pos,sp,fs)
% ˵����
% ����ͨ��audioread������ȡ�������źźͻ�Ƶ���Լ���ͼ�ν�����ѡ����ʱ��������꣬ 
% ���ظ�����������Ӧʱ���ĵ��ס�

if pos<length(sp)-256 && pos>255 
    sp=sp(pos-255:pos+256,1);
elseif pos>=length(sp)-256
    sp=sp(pos-511:pos,1);
elseif pos<=255
    sp=sp(pos:pos+511,1);
end
%�������ѡ�������߽磬�Ͳ��ܴ����߸�ȡ256�ˣ�����һ���жϡ�

win_p=blackman(512);
sp_win=sp.*win_p;
pow_spec=abs(fft(sp_win,512));
pow_spec=20*log(pow_spec(1:256));
% plot(pow_spec);
cep_p=dct(pow_spec);%����
cepstrum_result=cep_p;
[f0_max f0_max_p]=max(cep_p(50:124,1));
f0_temp=round(fs/(49+f0_max_p));