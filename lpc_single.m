function [axis_scaler spectrum_p] = lpc_single(pos,sp,fs)
% 说明：
% 给定通过audioread函数提取的语音信号和基频，以及时间轴横坐标时间点
% 返回该语音样本在该时间点的LPC分析结果。

% [sp fs]=audioread('aaa.wav');
if pos<length(sp)-256 && pos>255 
    sp=sp(pos-255:pos+256,1);
elseif pos>=length(sp)-256
    sp=sp(pos-511:pos,1);
elseif pos<=255
    sp=sp(pos:pos+511,1);
end
%如果坐标选在两个边界，就不能从两边各取256了，设置一个判断。

fftpnt=512;
lpc_order=10;

lpc_coe=lpc(sp,lpc_order)';%coefficient 系数;
fft_coe=fft(lpc_coe,fftpnt);
spectrum_p=10*log10(abs(fft_coe))*-1;
spectrum_p=spectrum_p(1:fftpnt/2,1);

max_p=max(spectrum_p);
min_p=ceil(min(spectrum_p));

for i=1:fftpnt/2
    axis_scaler(i)=i*((fs/2)/(fftpnt/2));
end

plot(axis_scaler,spectrum_p); 

% 画共振峰 单帧lpc包络 lpc三维语图

end

