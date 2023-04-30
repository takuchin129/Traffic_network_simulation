yalmip('clear')
clear all
close all
clc

% Model data
load('A.mat','A');
load('M.mat','M');
load('Av.mat','Av');
load('W.mat','W');
load('W2.mat','W2');
N = 3;

%-----------------------------------------------------------------------------------------

%without tolling
%initial condition
x = [50 50 50 40 40 40 30 30 30].'; 
icount = 0;
state1 = x(1); state2 = x(2); state3 = x(3); state4 = x(4); state5 = x(5); state6 = x(6); state7 = x(7); state8 = x(8); state9 = x(9);
q = zeros(9,1);
p = zeros(9,1);
price1 = [p(1)]; price2 = [p(2)];
t = 5;
for i = 1:t
  x = A*x + kron(eye(size(A)),q.')*M*Av*x + W; 
  icount = [icount;3*i];
  state1 = [state1;x(1)]; state2 = [state2;x(2)]; state3 = [state3;x(3)]; state4 = [state4;x(4)]; state5 = [state5;x(5)]; state6 = [state6;x(6)];
  state7 = [state7;x(7)]; state8 = [state8;x(8)]; state9 = [state9;x(9)]; 
  price1 = [price1;p(1)]; price2 = [price2;p(2)];
end

%with tolling
%toll setting
b0 = 4;
b1 = 1/200*b0;
q = [0.5831 0.6130 0.5831 0.2738 0.3243 0.2738 0.3649 0.2856 0.3649].';
p = [];
for j = 1:N^2
    pnew = 1/b1*(b0+log((q(j)+exp(-b0))/(1-q(j))));
    p = [p;pnew];
end
%impose
for i = t+1:2*t
  %q = zeros(9,1);
  %p = zeros(9,1);
  x = A*x + kron(eye(size(A)),q.')*M*Av*x + W;
  icount = [icount;3*i];
  state1 = [state1;x(1)]; state2 = [state2;x(2)]; state3 = [state3;x(3)]; state4 = [state4;x(4)]; state5 = [state5;x(5)]; state6 = [state6;x(6)];
  state7 = [state7;x(7)]; state8 = [state8;x(8)]; state9 = [state9;x(9)]; 
  price1 = [price1;p(1)]; price2 = [price2;p(2)]; 
end

%without tolling
q = zeros(9,1);
p = zeros(9,1);
for i = 2*t+1:3*t
  x = A*x + kron(eye(size(A)),q.')*M*Av*x + W2; 
  icount = [icount;3*i];
  state1 = [state1;x(1)]; state2 = [state2;x(2)]; state3 = [state3;x(3)]; state4 = [state4;x(4)]; state5 = [state5;x(5)]; state6 = [state6;x(6)];
  state7 = [state7;x(7)]; state8 = [state8;x(8)]; state9 = [state9;x(9)]; 
  price1 = [price1;p(1,1)]; price2 = [price2;p(2,1)];
end

%with tolling
%toll setting
b0 = 4;
b1 = 1/200*b0;
q = [0.1713 0.1492 0.1713 0.4837 0.4063 0.4837 0.2704 0.3209 0.2704].';
p = [];
for j = 1:N^2
    pnew = 1/b1*(b0+log((q(j)+exp(-b0))/(1-q(j))));
    p = [p;pnew];
end
%impose
for i = 3*t+1:4*t
  %q = zeros(9,1);
  %p = zeros(9,1);
  x = A*x + kron(eye(size(A)),q.')*M*Av*x + W2;
  icount = [icount;3*i];
  state1 = [state1;x(1)]; state2 = [state2;x(2)]; state3 = [state3;x(3)]; state4 = [state4;x(4)]; state5 = [state5;x(5)]; state6 = [state6;x(6)];
  state7 = [state7;x(7)]; state8 = [state8;x(8)]; state9 = [state9;x(9)]; 
  price1 = [price1;p(1)]; price2 = [price2;p(2)]; 
end

%---------------------------------------------------------------------------------------------

%plot
plot(icount,state2,'r','LineWidth',5);
grid on; hold on;
plot(icount,state4,'g','LineWidth',3);
grid on; hold on;
legend('$x_2$','$x_4$','Interpreter','latex')
legend('Fontsize',10)
xlabel('$t$ [min]','Fontname','Times New Roman','Fontsize',16,'Interpreter','latex')
xticks([0 15 30 45 60])
ylabel('$x$','Fontsize',15,'Interpreter','latex')
ylim([30 80])
h_axes = gca;
h_axes.XAxis.FontSize = 14;
h_axes.YAxis.FontSize = 14;
figure;

price2 = [0 0 0 0 0 0 224 224 224 224 224 224 0 0 0 0 0 0 118 118 118 118 118 118];
price4 = [0 0 0 0 0 0 154 154 154 154 154 154 0 0 0 0 0 0 199 199 199 199 199 199];
icount = [0 3 6 9 12 15 15 18 21 24 27 30 30 33 36 39 42 45 45 48 51 54 57 60];

plot(icount,price2,'r','LineWidth',5)
hold on;grid on;
plot(icount,price4,'g','LineWidth',3);
legend('$p_2$','$p_4$','Interpreter','latex')
legend('Fontsize',12)
xlabel('$t$ [min]','Fontname','Times New Roman','Fontsize',16,'Interpreter','latex')
xticks([0 15 30 45 60])
ylabel('$p$ [yen]','Fontsize',15,'Interpreter','latex')
ylim([0 250])
h_axes = gca;
h_axes.XAxis.FontSize = 14;
h_axes.YAxis.FontSize = 14;

%heatmap
i = 21;%maxは21
data =([state1(i);state2(i);state3(i);state4(i);state5(i);state6(i);state7(i);state8(i);state9(i)]);
xdata = [1;2;3;1;2;3;1;2;3];
ydata = [1;1;1;2;2;2;3;3;3];
tbl = table(data,xdata,ydata);
h = heatmap(tbl,'xdata','ydata','ColorVariable','data','ColorLimits',[20 80],'FontSize',28)
h.Title = '';
h.XLabel = '';
h.YLabel = '';
h.XDisplayLabels = {'','',''};
h.YDisplayLabels = {'','',''};
c = autumn;
c = flipud(c);
colormap(c)
dataset = [state1(i);state2(i);state3(i);state4(i);state5(i);state6(i);state7(i);state8(i);state9(i)];
S = std(dataset,1)
