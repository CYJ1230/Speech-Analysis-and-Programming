function pow_spectrum=fft_single(pos,sp,fs)
% 说明：
% 给定通过audioread函数提取的语音信号和基频，以及时间轴上的横坐标
% 返回该语音样本指定时间点的功率谱。

% sp=audioread('shehui.wav');
% sp=sp(4000:4000+511,1);%从第4000个信号开始选512个点
if pos<length(sp)-256 && pos>255 
    sp=sp(pos-255:pos+256,1);
elseif pos>=length(sp)-256
    sp=sp(pos-511:pos,1);
elseif pos<=255
    sp=sp(pos:pos+511,1);
end
win=blackman(512); %black是一个窗函数
sp_win=sp.*win;
fft_co=fft(sp_win,512);%fft的系数
% plot(fft_co);
sp_fft=10*log(abs(fft_co));
% plot(sp_fft);%实际上我们只需要这个图的一半
pow_spectrum=sp_fft(1:512/2,1);
% plot(pow_spectrum);%保留一半的功率谱
% 接下来做一个大循环 一阵一阵去读。