function para=function_amplitude(sp,Fs);
% 说明：
% 给定通过audioread函数提取的语音信号和基频，返回该段语音样本的振幅。


sp_len=length(sp);%结果是4871
sp_win=300;
sp_step=round(Fs*0.001*10); %round四舍五入 floor向下四舍五入 ceil向上四舍五入

sp=sp*32767; %去归一化，回归声压
sp_power=sp.*sp;%功率
% sp_amp=10*log(sp_power);%振幅

sp_frame=enframe(sp_power,sp_win,sp_step);% 分帧。平滑。 人的发音识别步长一般情况是5ms-15ms之间。如10ms就是fs*0.01
% plot(sp_amp);
% axis([1 sp_len -32768 32767]);
frame_size=size(sp_frame);% 42×300 读取参数长度
f1=frame_size(1);
f2=frame_size(2);
for i=1:f1
    para(i)=10*log10(mean(sp_frame(i,1:sp_win)));%第一行，第二行，一直到300行平均。log变成振幅
end