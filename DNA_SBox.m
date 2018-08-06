clc
imr=imread('cameraman.tif');

GenBankData = genbankread('sequence.gb');
b_00='C';
b_01='T';
b_10='A';
b_11='G';

[m,n]=size(imr);
seq0=GenBankData.Sequence;
count=1;
rowIn=1;
s_box=[];

%% DNA Sequence Based S_Box Generation 16x16 %%
while (count>0)
    count=count+1;
    tempText=seq0(rowIn:rowIn+3);
    temp=upper(tempText);
    
    binary0='';
    
    for i=1:4
        if temp(i)=='T'
            binary0=[binary0,'01'];
        elseif temp(i)=='C'
            binary0=[binary0,'00'];
        elseif temp(i)=='A'
            binary0=[binary0,'10'];
        elseif temp(i)=='G'
            binary0=[binary0,'11'];
        end
        
    end
    
    tempDec=bin2dec(binary0);
    rowIn=rowIn+3;
    
    if ~isempty(s_box)
        if (sum(s_box==tempDec)==0)&&sum(s_box<256)>0
            s_box=[s_box,tempDec];
            
        end
    else
        s_box=tempDec;
    end
    
    if max(size(s_box))==256
        break;
    end
    
end

%% inverse s_box generation %%
inverse_sbox=zeros(1,256);
for i=1:256
    inverse_sbox(s_box(i)+1)=i-1;
end


