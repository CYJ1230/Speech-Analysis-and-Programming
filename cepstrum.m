function [cepstrum_result f0_max f0_max_p f0_temp]=cepstrum(pos,sp,fs)
% 说明：
% 给定通过audioread函数提取的语音信号和基频，以及在图形界面中选定的时间轴横坐标， 
% 返回该语音样本对应时间点的倒谱。

if pos<length(sp)-256 && pos>255 
    sp=sp(pos-255:pos+256,1);
elseif pos>=length(sp)-256
    sp=sp(pos-511:pos,1);
elseif pos<=255
    sp=sp(pos:pos+511,1);
end
%如果坐标选在两个边界，就不能从两边各取256了，设置一个判断。

win_p=blackman(512);
sp_win=sp.*win_p;
pow_spec=abs(fft(sp_win,512));
pow_spec=20*log(pow_spec(1:256));
% plot(pow_spec);
cep_p=dct(pow_spec);%倒谱
cepstrum_result=cep_p;
[f0_max f0_max_p]=max(cep_p(50:124,1));
f0_temp=round(fs/(49+f0_max_p));