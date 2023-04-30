close all
clear all
load('A.mat','A');
N = 3;
Av = zeros(N^4,N^2);
for i = 1:N^2
    %initialize one
    one = zeros(N^2);
    %Redifne dummy and one
    dummy = A(1:N^2,i);
    one(i,i) = 1;
    Av = Av + kron(one,dummy);
end