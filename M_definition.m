N = 3;
M = zeros(N^4,N^4);


for j = 1:N^2
    if j <= N %top row 
        if mod(j,N) == 1%left column
           for i = 1:N^2 
                if (i == j+1) || (i == j+N)
                    %Initialize dummy and one
                    dummy = zeros(N^2);
                    one = zeros(N^2);
                    %Redine dummy and one
                    dummy(j+1,j+1) = 1/3;
                    dummy(j+N,j+N) = 1/3;
                    dummy(i,i) = -1;
                    one(i,j) = 1;
                    M = M + kron(one,dummy);
                end
           end 
        elseif mod(j,N) == 0%right column
           for i = 1:N^2 
                if (i == j-1) || (i == j+N)
                    %Initialize dummy and one
                    dummy = zeros(N^2);
                    one = zeros(N^2);
                    %Redifne dummy and one
                    dummy(j-1,j-1) = 1/3;
                    dummy(j+N,j+N) = 1/3;
                    dummy(i,i) = -1;
                    one(i,j) = 1;
                    M = M + kron(one,dummy);
                end
           end %end right column
        else
           for i = 1:N^2 %middle column
                if (i == j-1) || (i == j+1) || (i == j+N)
                    %Initialize dummy and one
                    dummy = zeros(N^2);
                    one = zeros(N^2);
                    %Redifne dummy and one
                    dummy(j-1,j-1) = 1/3;
                    dummy(j+1,j+1) = 1/3;
                    dummy(j+N,j+N) = 1/3;
                    dummy(i,i) = -1;
                    one(i,j) = 1;
                    M = M + kron(one,dummy);
                end
           end 
        end
    elseif j > N*(N-1) %bottom low
        if mod(j,N) == 1%left column
           for i = 1:N^2 
                if (i == j-N) || (i == j+1)
                    %Initialize dummy and one
                    dummy = zeros(N^2);
                    one = zeros(N^2);
                    %Redifne dummy and one
                    dummy(j-N,j-N) = 1/3;
                    dummy(j+1,j+1) = 1/3;
                    dummy(i,i) = -1;
                    one(i,j) = 1;
                    M = M + kron(one,dummy);
                end
           end 
        elseif mod(j,N) == 0%right column
           for i = 1:N^2 
                if (i == j-N) || (i == j-1)
                    %Initialize dummy and one
                    dummy = zeros(N^2);
                    one = zeros(N^2);
                    %Redifne dummy and one
                    dummy(j-N,j-N) = 1/3;
                    dummy(j-1,j-1) = 1/3;
                    dummy(i,i) = -1;
                    one(i,j) = 1;
                    M = M + kron(one,dummy);
                end
           end 
        else
           for i = 1:N^2 %middle column
                if (i == j-N) || (i == j-1) || (i == j+1)
                    %Initialize dummy and one
                    dummy = zeros(N^2);
                    one = zeros(N^2);
                    %Redifne dummy and one
                    dummy(j-N,j-N) = 1/3;
                    dummy(j-1,j-1) = 1/3;
                    dummy(j+1,j+1) = 1/3;
                    dummy(i,i) = -1;
                    one(i,j) = 1;
                    M = M + kron(one,dummy);
                end
           end 
         end
    else %middle row
        if mod(j,N) == 1%left column
           for i = 1:N^2 
                if (i == j-N) || (i == j+1) || (i == j+N)
                    %Initialize dummy and one
                    dummy = zeros(N^2);
                    one = zeros(N^2);
                    %Redifne dummy and one
                    dummy(j-N,j-N) = 1/3;
                    dummy(j+1,j+1) = 1/3;
                    dummy(j+N,j+N) = 1/3;
                    dummy(i,i) = -1;
                    one(i,j) = 1;
                    M = M + kron(one,dummy);
                end
           end 
        elseif mod(j,N) == 0%right column
           for i = 1:N^2 
                if (i == j-N) || (i == j-1) || (i == j+N)
                    %Initialize dummy and one
                    dummy = zeros(N^2);
                    one = zeros(N^2);
                    %Redifne dummy and one
                    dummy(j-N,j-N) = 1/3;
                    dummy(j-1,j-1) = 1/3;
                    dummy(j+N,j+N) = 1/3;
                    dummy(i,i) = -1;
                    one(i,j) = 1;
                    M = M + kron(one,dummy);
                end
           end
        else %middle column
           for i = 1:N^2 
                if (i == j-N) || (i == j-1) || (i == j+1) || (i == j+N)
                    %Initialize dummy and one
                    dummy = zeros(N^2);
                    one = zeros(N^2);
                    %Redifne dummy and one
                    dummy(j-N,j-N) = 1/3;
                    dummy(j-1,j-1) = 1/3;
                    dummy(j+1,j+1) = 1/3;
                    dummy(j+N,j+N) = 1/3;
                    dummy(i,i) = -1;
                    one(i,j) = 1;
                    M = M + kron(one,dummy);
                end
           end
        end
    end
end
