clear all
close all

N = 3;
A = zeros(N^2,N^2);
A(1,1) = 0.2; A(2,2) = 0.2; A(3,3) = 0.2; 
A(4,4) = 0.15; A(5,5) = 0.15; A(6,6) = 0.15; 
A(7,7) = 0.1; A(8,8) = 0.1; A(9,9) = 0.1; 

for j = 1:N^2
    if j <= N %top row
        if mod(j,N) == 1%left column
            A(j+1,j) = (1-A(j,j))*0.35;
            A(j+N,j) = (1-A(j,j))*0.2;
        elseif mod(j,N) == 0%right column
            A(j-1,j) = (1-A(j,j))*0.35;
            A(j+N,j) = (1-A(j,j))*0.2;
        else %middle column
                A(j-1,j) = (1-A(j,j))*0.3;
                A(j+1,j) = (1-A(j,j))*0.3;
                A(j+N,j) = (1-A(j,j))*0.25;
        end
    elseif j > N*(N-1) %bottom row
         if mod(j,N) == 1%left column
            A(j+1,j) = (1-A(j,j))*0.2;
            A(j-N,j) = (1-A(j,j))*0.3;
        elseif mod(j,N) == 0%right column
            A(j-1,j) = (1-A(j,j))*0.2;
            A(j-N,j) = (1-A(j,j))*0.3;
         else %middle column
                A(j-N,j) = (1-A(j,j))*0.3;
                A(j-1,j) = (1-A(j,j))*0.2;
                A(j+1,j) = (1-A(j,j))*0.2; 
         end
    else %middle row
          if mod(j,N) == 1%left column
                A(j+1,j) = (1-A(j,j))*0.25;
                A(j-N,j) = (1-A(j,j))*0.3;
                A(j+N,j) = (1-A(j,j))*0.2;
        elseif mod(j,N) == 0%right column
                A(j-1,j) = (1-A(j,j))*0.25;
                A(j-N,j) = (1-A(j,j))*0.3;
                A(j+N,j) = (1-A(j,j))*0.2;
          else %middle column
                A(j-1,j) = (1-A(j,j))*0.25;
                A(j+1,j) = (1-A(j,j))*0.25;
                A(j-N,j) = (1-A(j,j))*0.3;
                A(j+N,j) = (1-A(j,j))*0.2;
          end
    end
end

W = [22;15;22;10;0;10;15;8;15];%disturbance in the first cycle
W2 = [13;8;13;20;0;20;13;8;13];%disturbance in the second cycle
