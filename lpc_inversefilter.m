function residue=lpc_inversefilter(data,lpcorder,seg_length)

segments=ceil(length(data)/seg_length);
data1=[data(:);zeros((seg_length*segments-length(data)),1)];

seg_range=1:seg_length;
lpc_coef=lpc(data1(seg_range,1),lpcorder);
lpc_coef=real(lpc_coef);
%invers filtering
residue(seg_range,1)=filter(lpc_coef,1,data1(seg_range));
    
for segs=2:segments
    seg_range1=((segs-1)*seg_length+1):(segs*seg_length);
    seg_range2=((segs-1)*seg_length+1-lpcorder):(segs*seg_length);
    data2=data1(seg_range2);
    lpc_coef=lpc(data2,lpcorder);
    lpc_coef=real(lpc_coef);    
    a(:,1)=filter(lpc_coef,1,data2);
    residue(seg_range1,1)=a((lpcorder+1):length(a),1);
end

residue=residue(1:length(data),1);
