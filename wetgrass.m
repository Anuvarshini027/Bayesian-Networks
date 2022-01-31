clc;
clear all;
close all;
rain=[0.2;0.8];
sprinkler=[0.1;0.9];
jack=[1 0;0.2 0.8];
tracey=[1 0;1 0;0.9 0.1;0 1];
[P,M]=FPD(rain,sprinkler,jack,tracey)
sum(P)

% P(S=1/T=1)= P(S=1,T=1)/P(T=1) Probability of Sprinkler on given that
% Tracey grass is wet
kk = (M(:,4)==1);
den = sum(P(kk));
kk = and((M(:,2)==1),(M(:,4)==1));
num = sum(P(kk));
inf1 = num/den %ans=0.3382

% P(S=1/T=1,J=1)= P(S=1,T=1,J=1)/P(T=1,J=1) Probability of Sprinkler on given that
% both Tracey and Jack grass is wet
kk = and((M(:,4)==1),(M(:,3)==1));
den = sum(P(kk));
kk = and((M(:,2)==1),and((M(:,4)==1),(M(:,3)==1)));
num = sum(P(kk));
inf2 = num/den 
%ans=0.1604 the fact that the sprinkler was on is explained away by including Jack grass is wet, 
%which means the prob that the grass is wet due to rain is high.


function [P,M] = FPD(rain,sprinkler,jack,tracey) 
    P = zeros(16,1);
    A=fullfact([2 2 2 2]);
    M=A(:,(end:-1:1));   
    size(M)
    id=[1 2;3 4];     
    for k=1:length(P)
        r=M(k,1);     
        s=M(k,2);
        j=M(k,3);
        t=M(k,4);
        %P(r,s,j,t)=P(r)P(s)P(j|r)P(t|r,s)             
        tempprob=rain(r)*sprinkler(s);
        tempprob=tempprob*jack(r,j); 
        idind=id(r,s); %mapping
        tempprob=tempprob*tracey(idind,t);
        P(k)=tempprob;
    end 
end