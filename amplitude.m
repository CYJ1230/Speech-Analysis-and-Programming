function para=function_amplitude(sp,Fs);
% ˵����
% ����ͨ��audioread������ȡ�������źźͻ�Ƶ�����ظö����������������


sp_len=length(sp);%�����4871
sp_win=300;
sp_step=round(Fs*0.001*10); %round�������� floor������������ ceil������������

sp=sp*32767; %ȥ��һ�����ع���ѹ
sp_power=sp.*sp;%����
% sp_amp=10*log(sp_power);%���

sp_frame=enframe(sp_power,sp_win,sp_step);% ��֡��ƽ���� �˵ķ���ʶ�𲽳�һ�������5ms-15ms֮�䡣��10ms����fs*0.01
% plot(sp_amp);
% axis([1 sp_len -32768 32767]);
frame_size=size(sp_frame);% 42��300 ��ȡ��������
f1=frame_size(1);
f2=frame_size(2);
for i=1:f1
    para(i)=10*log10(mean(sp_frame(i,1:sp_win)));%��һ�У��ڶ��У�һֱ��300��ƽ����log������
end