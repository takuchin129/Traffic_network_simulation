yalmip('clear')
close all
clear all

% Model data
load('A.mat','A');
load('M.mat','M');
load('Av.mat','Av');
load('W.mat','W');
load('W2.mat','W2');
N = 3;

%determine a disturbance port
%W or W2 are selected
B = diag(W2);

%determine a control port
C = zeros(N^2,N^2);
for j = 1:N^2
    if (j == 4) || (j == 5) || (j == 6)
        C(j,j) = 1;
    end
end

D = zeros(N^2,N^2);

%set the variable
myu = sdpvar(N^2,1);
gzai = sdpvar(N^2,1);
gamma = sdpvar(1); 
Theta = [];
for j = 1:N^2
    theta_j = M(((j-1)*N^2 + 1):j*N^2,1:N^4)*Av*gzai;
    Theta = [Theta theta_j];
end

%Formulate and solve LP
matinf1 = [(A - eye(size(A)))*gzai + myu + B*ones(N^2,1);
            C*gzai + D*ones(N^2,1) - gamma*ones(N^2,1)];
matinf2 = [myu.' - 0.8*ones(N^2,1).'*Theta];
LMIinf = [matinf1<0; matinf2>0; myu<=0;  gzai>0; gamma>0];
solvesdp(LMIinf,gamma-0.01*ones(1,N^2)*(Theta-2*diag(diag(Theta)))*ones(N^2,1)-0.5*ones(1,N^2)*myu)

%Result output
Theta = value(Theta)
isstable(ss(Theta))
inv(Theta)
myu = value(myu)
gzai = value(gzai)
q = myu'/(Theta)
