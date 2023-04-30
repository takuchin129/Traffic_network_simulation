yalmip('clear')
clear all
close all

% Model data
load('A.mat','A');
load('M.mat','M');
load('Av.mat','Av');
load('W.mat','W');
load('W2.mat','W2');
N = 3;

%-----------------------------------------------------------------------------------------
%without control
x_w = [50 50 50 40 40 40 30 30 30].';  % initial state
icount_w = [];
state1_w = []; state2_w = []; state3_w = []; state4_w = []; state5_w = []; state6_w = []; state7_w = []; state8_w = []; state9_w = [];
price1_w = []; price2_w = [];
q_w = zeros(9,1);
p_w = zeros(9,1);

for i = 1:6
  icount_w = [icount_w;3*(i-1)];
  state1_w = [state1_w;x_w(1)]; state2_w = [state2_w;x_w(2)]; state3_w = [state3_w;x_w(3)]; state4_w = [state4_w;x_w(4)]; state5_w = [state5_w;x_w(5)]; state6_w = [state6_w;x_w(6)];
  state7_w = [state7_w;x_w(7)]; state8_w = [state8_w;x_w(8)]; state9_w = [state9_w;x_w(9)]; 
  price1_w = [price1_w;p_w(1,1)]; price2_w = [price2_w;p_w(2,1)];
  x_w = A*x_w + kron(eye(size(A)),q_w.')*M*Av*x_w + W; 
end
%-----------------------------------------------------------------------------------------
%with control
x = [50 50 50 40 40 40 30 30 30].'; 
icount = [];
state1 = []; state2 = []; state3 = []; state4 = []; state5 = []; state6 = []; state7 = []; state8 = []; state9 = [];
price1 = []; price2 = [];
%no price
q = zeros(9,1);
p = zeros(9,1);
for i = 1:1
  icount = [icount;3*(i-1)];
  state1 = [state1;x(1)]; state2 = [state2;x(2)]; state3 = [state3;x(3)]; state4 = [state4;x(4)]; state5 = [state5;x(5)]; state6 = [state6;x(6)];
  state7 = [state7;x(7)]; state8 = [state8;x(8)]; state9 = [state9;x(9)]; 
  price1 = [price1;p(1,1)]; price2 = [price2;p(2,1)];
  x = A*x + kron(eye(size(A)),q.')*M*Av*x + W; 
end

%price setting
b0 = 4;
b1 = 1/200*b0;
%q = zeros(9,1);
q = [0.5831 0.6130 0.5831 0.2738 0.3243 0.2738 0.3649 0.2856 0.3649].';
p = [];
for j = 1:N^2
    pnew = 1/b1*(b0+log((q(j)+exp(-b0))/(1-q(j))));
    p = [p;pnew];
end

%impose price
for i = 1:5
  icount = [icount;3*i];
  state1 = [state1;x(1)]; state2 = [state2;x(2)]; state3 = [state3;x(3)]; state4 = [state4;x(4)]; state5 = [state5;x(5)]; state6 = [state6;x(6)];
  state7 = [state7;x(7)]; state8 = [state8;x(8)]; state9 = [state9;x(9)]; 
  price1 = [price1;p(1,1)]; price2 = [price2;p(2,1)];
  x = A*x + kron(eye(size(A)),q.')*M*Av*x + W;
end
%{
%---------------------------------------------------------------------------------------------
%plot
plot(icount,state1,'b','LineWidth',5);
grid on; hold on;
plot(icount_w,state1_w,'b','LineWidth',5,linestyle = '-.');
grid on; hold on;
plot(icount,state2,'r','LineWidth',3);
grid on; hold on;
plot(icount_w,state2_w,'r','LineWidth',3,linestyle = '-.');
legend('$x_1$ (with tolling)','$x_1$ (without tolling)','$x_2$ (with tolling)','$x_2$ (without tolling)','Fontsize',11,'Interpreter','latex')
xticks([0 3 6 9 12 15])
xlabel('$t$ [min]','Fontname','Times New Roman','Fontsize',16,'Interpreter','latex')
ylabel('$x$','Fontsize',15,'Interpreter','latex')
ylim([40 80])
h_axes = gca;
h_axes.XAxis.FontSize = 14;
h_axes.YAxis.FontSize = 14;
figure;

price1 = [0 0 218 218 218 218 218];
price2 = [0 0 224 224 224 224 224];
icount = [0 3 3 6 9 12 15];



plot(icount,price1,'b','LineWidth',5)
hold on;grid on;
plot(icount,price2,'r','LineWidth',3);
legend('$p_1$','$p_2$','Fontsize',12,'Interpreter','latex')
legend('Fontsize',12)
xlabel('$t$ [min]','Fontname','Times New Roman','Fontsize',16,'Interpreter','latex')
xticks([0 3 6 9 12 15])
ylabel('$p$ [yen]','Fontsize',15,'Interpreter','latex')
ylim([0 250])
h_axes = gca;
h_axes.XAxis.FontSize = 14;
h_axes.YAxis.FontSize = 14;
%}
%heatmap
i = 6;
data =([state1_w(i);state2_w(i);state3_w(i);state4_w(i);state5_w(i);state6_w(i);state7_w(i);state8_w(i);state9_w(i)]);
%data =([state1(i);state2(i);state3(i);state4(i);state5(i);state6(i);state7(i);state8(i);state9(i)]);
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
