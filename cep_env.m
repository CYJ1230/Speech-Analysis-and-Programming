function cep_env_result=cep_nev(pos,sp,fs)
% 说明：
% 给定通过audioread函数提取的语音信号和基频，以及在图形界面中选定的时间轴横坐标， 
% 返回该语音样本对应时间点的谱包络。

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
pow_spec=10*log(pow_spec(1:256));
% plot(pow_spec);
cep_p=dct(pow_spec);%倒谱
cep_z=cep_p;
cep_z(25:512/2)=0;
% plot(cep_p);
cep_env_result=idct(cep_z);%做了反变换，把剩下的只有的共鸣信息反变回来
% plot(cep_env_result);
% scale_p=[1:(fs/2)/(512/2):fs/2]';%步长是fftpoint/2 从1到fs/2
% plot(scale_p,cep_env);
% max_p=max(cep_env);
% min_p=min(cep_env);
% axis([1 fs/2 min_p max_p*1.4]);
% xlabel('Frequency(Hz)');

% 我们要做一个谱包络和功率谱叠加在一起的谱 功率谱-倒谱-谱包络 合在一起的谱 选取一个点，plot出来。
% 再做一个用倒谱法提基频的函数