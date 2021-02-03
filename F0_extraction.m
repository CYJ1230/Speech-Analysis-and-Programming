function F0_p=F0_extraction(sig,fs)
% 说明：
% 给定通过audioread函数提取的语音信号和基频， 
% 利用自相关法，返回该语音样本的基频。

original_signal_len=length(sig);%存放时长
frame_len=round((fs/1000)*20);%帧长为20ms
frame_step=round((fs/1000)*5);%步长为5ms

frame_num=floor((original_signal_len-frame_len)/frame_step);%存放基频数据的规模，原始信号长度减去一个帧长再除以步长
sub_len=floor(frame_len/2);%帧长取半

filter_len=600;%滤波器阶数
[h]=remez(filter_len,[0 150/(fs/2) 300/(fs/2) 1],[1 1 0 0],[1 1]);%生成低通滤波器
low_pass_signal_temp=conv(h,filter([1 -0.9375],1,sig));%执行低通滤波
original_signal=low_pass_signal_temp(filter_len/2:filter_len/2+original_signal_len-1,1)/max(abs(low_pass_signal_temp));%时长回归初始时长&归一化
% 卷积之后信号会变长，一个一个往后移，每一个点后后面599个点做卷积，总长度多了600.

%从开始到最后的基频测量点，执行循环
%用enframe分帧
frame_signal=enframe(original_signal,frame_len,frame_step);
for i=1:frame_num
    single_frame_signal=frame_signal(i,:)';
    max_p=max(abs(single_frame_signal));
    single_frame_signal=single_frame_signal/max_p;
    max_temp1=max(single_frame_signal(1:sub_len,1));
    max_temp2=max(single_frame_signal(sub_len+1:frame_len,1));
    frame_min=min(max_temp1,max_temp2);
    
    delta=0.6; %中心削波削减的幅度
    k=frame_min-(frame_min*delta);
    
    for j=1:frame_len %对每一帧中心削波
        if single_frame_signal(j)>=k
            single_frame_signal(j)=single_frame_signal(j)-k;
        elseif abs(single_frame_signal(j))<k
            single_frame_signal(j)=0;
        elseif single_frame_signal(j)<=-k
            single_frame_signal(j)=single_frame_signal(j)+k;
        end
    end
% 三电平处理
    for j=1:frame_len
        if single_frame_signal(j)>0
            single_frame_signal_b(j)=1;
        elseif single_frame_signal(j)<0
            single_frame_signal_b(j)=-1;
        else
            single_frame_signal_b(j)=0;
        end
    end
    %plot(frame_signal_b,'k')
%计算自相关
    xcorr_p=xcorr(single_frame_signal,single_frame_signal_b);
    xcorr_len=length(xcorr_p);
    xcorr_center=ceil(xcorr_len/2);
    %plot(xcorr_p,'k');%自相关的线

    %从最大值导出一段自相关信号
    l=0;
    for j=xcorr_center:2*frame_len-1;
        l=l+1;
        if xcorr_p(j)<0
            xcorr_p_b(l)=0;
        else
            xcorr_p_b(l)=xcorr_p(j);
        end
    end
    len=length(xcorr_p_b);
    %plot(xcorr_p_b,'r');
    
%基频检测
    [val point_len]=max(xcorr_p_b(30:200));
    F0_p(i,1)=fix(fs/(point_len+29));
%     plot(F0_p);
end



% 如果不用enframe分帧的话
% for i=1:frame_num
%     %对于每一帧信号，有：
%     frame_signal(1:frame_len,1)=original_signal((i*frame_step-frame_step)+1:(i*frame_step-frame_step)+frame_len,1);%把原始信号按帧存放在一个新的数组
%     max_p=max(abs((frame_signal)));%取最大值
%     frame_signal=frame_signal/max_p;%归一化
%     
%     max_temp1=max(frame_signal(1:sub_len,1));
%     max_temp2=max(frame_signal(sub_len+1:frame_len,1));
%     frame_min=min(max_temp1,max_temp2);
%     
%     delta=0.6; %中心削波削减的幅度
%     k=frame_min-(frame_min*delta);
%     
%     for j=1:frame_len %对每一帧中心削波
%         if frame_signal(j)>=k
%             frame_signal(j)=frame_signal(j)-k;
%         elseif abs(frame_signal(j))<k
%             frame_signal(j)=0;
%         elseif frame_signal(j)<=-k
%             frame_signal(j)=frame_signal(j)+k;
%         end
%     end
% end
% plot(frame_signal);