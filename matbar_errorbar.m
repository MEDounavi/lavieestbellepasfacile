function [ h,chroma ] = matbar_errorbar( mat_mean, mat_std,varargin )
%Code to add automatically errorbars in barplots when the input is a matrix
%Mat_mean = mean matrix, mat_std = the corresponding standard deviations
% The function uses a random color generator, if you liked the resulting
% color combination you can choose to output its value and reuse it as an
% input to enhance reproducibility of the graphs.
%Many thanks to Avgoustinos Vouros for his contribution.

% Code written by Marialena Dounavi

MarkerSize = 4;MarkerEdgeColor = 'red';MarkerFaceColor = 'red';LineWidth = 1;

if (nargin<2)
 disp('ERROR: not enough input arguments!');
 return;
end % if

mat_mean=[mat_mean zeros(size(mat_mean,1),1)]; %additional zeros to create a gap 
mat_std=[mat_std zeros(size(mat_std,1),1)];

[m n]=size(mat_mean);
temp=reshape(mat_mean',m*n,1);temp2=reshape(mat_std',m*n,1); %vectors

if nargin==2
y=zeros(n-1,m);chroma=zeros(n-1,3);
    for meas=1:n-1
        y(meas,:)=meas:n:m*n;
        chroma(meas,:)=round(rand(1,3),1); %generation of colormaps
    end
else
    y=zeros(n-1,m);
    for meas=1:n-1
        y(meas,:)=meas:n:m*n;
    end
    chroma=varargin{1};
end
figure,

for i=1:numel(temp)
    
    h=bar(i,temp(i));
    hold on
    [obs1 obs2]=find(y==i);
    if isempty(obs1)==1
        continue
    else
        set(h, 'FaceColor',[chroma(obs1,1) chroma(obs1,2) chroma(obs1,3)])
    
    end
end
%
hold on
E=errorbar(temp,temp2,'r.');
set(E,'MarkerSize',MarkerSize,'MarkerEdgeColor',MarkerEdgeColor,...
        'MarkerFaceColor',MarkerFaceColor,'LineWidth',LineWidth);

end

