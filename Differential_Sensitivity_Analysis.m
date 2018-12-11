%Differential Sensitivity Analysis or One at a Time Sensitivity Analysis
tic();
clear all;

m=3;                        %Number of input variables
n=101;                      %Number of samples

x1= linspace(0,10,n)';      %Input variable 1
x2= linspace(1,1000,n)';    %Input variable 2
x3= linspace(0,5,n)';       %Input variable 3

f= @(x) 100*x(:,1)+ log(x(:,2)) + 10.^x(:,3)      %Objective function (100*X1 + log(X2) + 10^ X3)

b_x1= 5;                    %Base Value variable 1
b_x2= 50;                   %Base Value variable 2
b_x3= 2;                    %Base Value variable 3

%If the increments are known, they can be used and input variable vectors
%can be generated afterwards.
%del_x1= 0.5;                %Increment in variable 1
%del_x2= 100;                %Increment in variable 2
%del_x3= 0.5;                 %Increment in variable 3

Base_f= b_x1 + log(b_x2) + 10^(b_x3);   %Base Functional Value


x=[x1 repmat(b_x2,[n 1]) repmat(b_x3, [n 1])];
del_f_x1= f(x)-repmat(Base_f,[n 1]);        
del_1_total=sqrt(sum(del_f_x1.^2));     %Total Sensitivity in x1

x=[repmat(b_x1,[n 1]) x2 repmat(b_x3, [n 1])];
del_f_x2= f(x)-repmat(Base_f,[n 1]);
del_2_total=sqrt(sum(del_f_x2.^2));     %Total Sensitivity in x2

x=[repmat(b_x1,[n 1]) repmat(b_x2, [n 1]) x3];
del_f_x3= f(x)-repmat(Base_f,[n 1]);
del_3_total=sqrt(sum(del_f_x3.^2));     %Total Sensitivity in x3

figure;
%Scatter Plot for individual parameter sensitivity 
subplot(3,1,1);
scatter(x1,del_f_x1);                   %Scatter Plot for Parameter 1
title('Sensitivity in X1');
xlabel('X1');
ylabel('Sensitivty');

subplot(3,1,2);
scatter(x2,del_f_x2);                   %Scatter Plot for Parameter 2
title('Sensitivity in X2');
xlabel('X2');
ylabel('Sensitivty');

subplot(3,1,3);
scatter(x3,del_f_x3);                   %Scatter Plot for Parameter 3
title('Sensitivity in X3');
xlabel('X3');
ylabel('Sensitivty');

figure;
var = {'x1','x2','x3'};
hB=bar([del_1_total del_2_total del_3_total]);      % Bar graph of total sensitivities of variable
title('Sensitivity of variables: 100*X1 + log(X2) + 10^ X3');
ylabel('Sensitivty');

toc();
%END of CODE