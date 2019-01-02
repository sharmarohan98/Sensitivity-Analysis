%First order and total sensitivity index calculator

N= 1000;                %Data points
k=8;                    %2* Dimensions

%Halton Quasi Random Number Generation
p=haltonset(k, 'Skip',1e3, 'Leap',1e2);
X=net(p,N);

A=X(:,(1:k/2));             %First set of quasi random numbers
B=X(:,((k/2)+1:end));       %Second set of quasi random numbers

%% If range of the numbers are given
range=diag([1000 1 1 50]);
lower_bound=repmat([0 5 0.1 50],N,1);

A =A*range+ lower_bound;
B =B*range+ lower_bound;

%% Function
f= @(x) x(1) + exp(x(2).^2 + x(3)) + 3*x(4)
%% Initialization of solution vectors
f_A=zeros(N,1);
f_B=zeros(N,1);
f_A_b=zeros(N,1);
S=zeros((k/2),1);
ST=zeros((k/2),1);

for i=1:(k/2)
    for j=1:N
        f_A(j)= f(A(j,:));
        f_B(j)= f(B(j,:));
        
        A1=A;
        A1(:,i) = B(:,i);
        f_A_b(j)= f(A1(j,:));
        
    end
    f_o=(1/N)*sum(f_A);
    S(i)= (((1/N)*sum(f_A.^2 - f_o.^2)) - ((1/(2*N))*sum((f_B - f_A_b).^2)) ) / ((1/N)*(sum(f_A.^2 - f_o.^2)));        %First order index
    ST(i)= ((1/(2*N))*sum((f_A - f_A_b).^2))/((1/N)*(sum(f_A.^2 - f_o.^2)));     %Total sensitivity index    
end

%% Visualization of Results
figure;
bar(S);     %First order index of each variable
figure;
bar(ST);    %Total sensitivity index of each variable
