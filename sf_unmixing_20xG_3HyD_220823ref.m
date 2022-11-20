function [unmixData]=sf_unmixing_20xG_3HyD_220823ref(fn)
% load xycz image
[Data,Scale,dim,metadata]=mnl_Load4Dimage;
for i=1:size(Data, 3)
    Data_ch(i).Data=Data(:,:,i,:);
    Data_ch(i).Data=squeeze(Data_ch(i).Data);
    Data_ch(i).Data=double(Data_ch(i).Data);
end

%% Reference matrises for 20xG 3HyD protocol
%ex405nm (HyD1 for B, HyD3 for T, HyD4 for A)
ref405=[1	0.100536459	0.017466627
0.743722065	1	0.042971998
0.101142246	0.297283067	1];
InvRef405=inv(ref405);
%ex488nm (HyD3 for N, HyD4 for Y)
ref488=[1	0.980845594
0.320778651	1];
InvRef488=inv(ref488);
%ex552nm (HyD3 for R, HyD4 for K)
ref552=[1	0.231101239
0.660377125	1];
InvRef552=inv(ref552);

%% Unmixing calculation   
Ch1=(InvRef405(1,1)*Data_ch(1).Data)+(InvRef405(1,2)*Data_ch(2).Data)+(InvRef405(1,3)*Data_ch(3).Data);
Ch2=(InvRef405(2,1)*Data_ch(1).Data)+(InvRef405(2,2)*Data_ch(2).Data)+(InvRef405(2,3)*Data_ch(3).Data);
Ch3=(InvRef405(3,1)*Data_ch(1).Data)+(InvRef405(3,2)*Data_ch(2).Data)+(InvRef405(3,3)*Data_ch(3).Data);
Ch4=(InvRef488(1,1)*Data_ch(4).Data)+(InvRef488(1,2)*Data_ch(5).Data);
Ch5=(InvRef488(2,1)*Data_ch(4).Data)+(InvRef488(2,2)*Data_ch(5).Data);
Ch6=(InvRef552(1,1)*Data_ch(6).Data)+(InvRef552(1,2)*Data_ch(7).Data);
Ch7=(InvRef552(2,1)*Data_ch(6).Data)+(InvRef552(2,2)*Data_ch(7).Data);

unmixData_all=zeros(dim(1),dim(2),dim(4),dim(3));
    unmixData_all = cat(4,Ch1,Ch2,Ch3,Ch4,Ch5,Ch6,Ch7);

unmixData_all=permute(unmixData_all,[1 2 4 3]);
k = unmixData_all<0;
unmixData_all(k)=0;
unmixData_all=round(unmixData_all);
unmixData_all=uint16(unmixData_all);

%save as multi-tiff
fn=sprintf('%s%s',fn,'_unmix','.tiff');
bfsave(unmixData_all, fn, 'dimensionOrder','XYCZT','metadata', metadata);
%    Examples:
%
%        bfsave(zeros(100, 100), outputPath)
%        bfsave(zeros(100, 100, 2, 3, 4), outputPath)
%        bfsave(zeros(100, 100, 20), outputPath, 'dimensionOrder', 'XYTZC')
%        bfsave(zeros(100, 100), outputPath, 'Compression', 'LZW')
%        bfsave(zeros(100, 100), outputPath, 'BigTiff', true)
%        bfsave(zeros(100, 100), outputPath, 'metadata', metadata)
%
%fn=sprintf('%s%s',fn,'_unmix');
%Nested_mnl_CreateImage(unmixData,fn)
end
