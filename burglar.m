clc;
clear all;
close all;
burglary=[0.001 0.999];
earthquake=[0.002 0.998];
alarm=[0.95 0.05;0.94 0.06;0.29 0.71;0.001 0.999];
john=[0.9 0.1;0.05 0.95];
mary=[0.7 0.3;0.01 0.99];
[P,M]=FPD(burglary,earthquake,alarm,john,mary)
sum(P)

% P(J=1,M=1/B=1)= P(J=1,M=1,B=1)/P(B=1)
kk = (M(:,1)==1);
den = sum(P(kk));
kk = and(and((M(:,4)==1),(M(:,5)==1)),(M(:,1)==1));
num = sum(P(kk));
inf1 = num/den

% P(J=1,M=1,A=0/B=1)= P(J=1,M=1,A=0,B=1)/P(B=1)
kk = (M(:,1)==1);
den = sum(P(kk));
kk = and(and(and((M(:,4)==1),(M(:,5)==1)),((M(:,3)==2))),(M(:,1)==1));
num = sum(P(kk));
inf2 = num/den

%P(E=1|A=1)
kk = (M(:,3)==1);
den = sum(P(kk));
kk = and((M(:,2)==1),(M(:,3)==1));
num = sum(P(kk));
inf3 = num/den %prob of earthquake given alarm=  0.2310

%P(B=1|A=1)=P(B=1,A=1)/P(A=1)
kk = (M(:,3)==1);
den = sum(P(kk));
kk = and((M(:,1)==1),(M(:,3)==1));
num = sum(P(kk));
inf4 = num/den %prob of burglar given alarm =   0.3736

%P(A=1|B=0,E=0,J=1,M=1)
%kk = and(and((M(:,1)==2),(M(:,2)==2)),and((M(:,4)==1),(M(:,5)==1)));
kk = (M(:,3)==1);
den = sum(P(kk));
kk = and(and(and((M(:,1)==2),(M(:,2)==2)),and((M(:,4)==1),(M(:,5)==1))),M(:,3)==1);
num = sum(P(kk));
inf5 = num/den

function [P,M] = FPD(burglary,earthquake,alarm,john,mary)
%     a = size(burglary);
%     b = size(earthquake); 
%     c = size(alarm); 
%     d = size(john); 
%     e = size(mary); 
    P = zeros(32,1);
    A=fullfact([2 2 2 2 2]);
    M=A(:,(end:-1:1));   
    size(M)
    id=[1 2;3 4];     
    for k=1:length(P)
        burg=M(k,1);     
        earq=M(k,2);
        ala=M(k,3);
        jc=M(k,4);
        mc=M(k,5);
        %P(b,e,a,j,m)=P(b)P(e)P(a|b,e)P(j|a)P(m|a)             
        tempprob=burglary(burg)*earthquake(earq); 
        idind=id(burg,earq);
        tempprob=tempprob*alarm(idind,ala); %comb of burg and eq in row,alarm in col     
        tempprob=tempprob*john(ala,jc); %alarm in row, john in col
        tempprob=tempprob*mary(ala,mc); %alarm in row, mary in col
        P(k)=tempprob;
    end 
end