function out= f1(factor,i,j,n)

% Present Value Factors

if strcmp(factor,'P/A')==1
    out=(1-(1+i)^-n)/i;
elseif strcmp(factor,'P/G')==1
    out=(1-(1+n*i)*(1+i)^-n)/(i^2);
elseif strcmp(factor,'P/A1')==1
    out=(1-((1+j)^n)*(1+i)^-n)/(i-j);
elseif strcmp(factor,'P/F')==1
    out=(1+i)^n;
else
    disp('Error')
end
