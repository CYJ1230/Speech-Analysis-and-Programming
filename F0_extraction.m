function F0_p=F0_extraction(sig,fs)
% ˵����
% ����ͨ��audioread������ȡ�������źźͻ�Ƶ�� 
% ��������ط������ظ����������Ļ�Ƶ��

original_signal_len=length(sig);%���ʱ��
frame_len=round((fs/1000)*20);%֡��Ϊ20ms
frame_step=round((fs/1000)*5);%����Ϊ5ms

frame_num=floor((original_signal_len-frame_len)/frame_step);%��Ż�Ƶ���ݵĹ�ģ��ԭʼ�źų��ȼ�ȥһ��֡���ٳ��Բ���
sub_len=floor(frame_len/2);%֡��ȡ��

filter_len=600;%�˲�������
[h]=remez(filter_len,[0 150/(fs/2) 300/(fs/2) 1],[1 1 0 0],[1 1]);%���ɵ�ͨ�˲���
low_pass_signal_temp=conv(h,filter([1 -0.9375],1,sig));%ִ�е�ͨ�˲�
original_signal=low_pass_signal_temp(filter_len/2:filter_len/2+original_signal_len-1,1)/max(abs(low_pass_signal_temp));%ʱ���ع��ʼʱ��&��һ��
% ���֮���źŻ�䳤��һ��һ�������ƣ�ÿһ��������599������������ܳ��ȶ���600.

%�ӿ�ʼ�����Ļ�Ƶ�����㣬ִ��ѭ��
%��enframe��֡
frame_signal=enframe(original_signal,frame_len,frame_step);
for i=1:frame_num
    single_frame_signal=frame_signal(i,:)';
    max_p=max(abs(single_frame_signal));
    single_frame_signal=single_frame_signal/max_p;
    max_temp1=max(single_frame_signal(1:sub_len,1));
    max_temp2=max(single_frame_signal(sub_len+1:frame_len,1));
    frame_min=min(max_temp1,max_temp2);
    
    delta=0.6; %�������������ķ���
    k=frame_min-(frame_min*delta);
    
    for j=1:frame_len %��ÿһ֡��������
        if single_frame_signal(j)>=k
            single_frame_signal(j)=single_frame_signal(j)-k;
        elseif abs(single_frame_signal(j))<k
            single_frame_signal(j)=0;
        elseif single_frame_signal(j)<=-k
            single_frame_signal(j)=single_frame_signal(j)+k;
        end
    end
% ����ƽ����
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
%���������
    xcorr_p=xcorr(single_frame_signal,single_frame_signal_b);
    xcorr_len=length(xcorr_p);
    xcorr_center=ceil(xcorr_len/2);
    %plot(xcorr_p,'k');%����ص���

    %�����ֵ����һ��������ź�
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
    
%��Ƶ���
    [val point_len]=max(xcorr_p_b(30:200));
    F0_p(i,1)=fix(fs/(point_len+29));
%     plot(F0_p);
end



% �������enframe��֡�Ļ�
% for i=1:frame_num
%     %����ÿһ֡�źţ��У�
%     frame_signal(1:frame_len,1)=original_signal((i*frame_step-frame_step)+1:(i*frame_step-frame_step)+frame_len,1);%��ԭʼ�źŰ�֡�����һ���µ�����
%     max_p=max(abs((frame_signal)));%ȡ���ֵ
%     frame_signal=frame_signal/max_p;%��һ��
%     
%     max_temp1=max(frame_signal(1:sub_len,1));
%     max_temp2=max(frame_signal(sub_len+1:frame_len,1));
%     frame_min=min(max_temp1,max_temp2);
%     
%     delta=0.6; %�������������ķ���
%     k=frame_min-(frame_min*delta);
%     
%     for j=1:frame_len %��ÿһ֡��������
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