function residue=lpc_pre_inversefilter(data,lpcorder,seg_length)
% data_temp=filter([1 -0.98],1,data);
segments=ceil(length(data)/seg_length);
% data1=[data_temp(:);zeros((seg_length*segments-length(data)),1)];
% data1=[data(:);zeros((seg_length*segments-length(data)),1)];
data1=[data(:);zeros((seg_length*segments-length(data)),1)];

seg_range=1:seg_length;
data2(seg_range,1)=filter([1 -0.98],1,data1(seg_range,1));
lpc_coef=lpc(data2(seg_range,1),lpcorder);
lpc_coef=real(lpc_coef);
    %invers filtering
residue(seg_range,1)=filter(lpc_coef,1,data1(seg_range));
    
for segs=2:segments
    seg_range1=((segs-1)*seg_length+1):(segs*seg_length);
    seg_range2=((segs-1)*seg_length+1-lpcorder):(segs*seg_length);
    data2=data1(seg_range2);
    data3=filter([1 -0.98],1,data2);
    lpc_coef=lpc(data3,lpcorder);
    lpc_coef=real(lpc_coef);
    a(:,1)=filter(lpc_coef,1,data2);
    residue(seg_range1,1)=a((lpcorder+1):length(a),1);
end

residue=residue(1:length(data),1);

