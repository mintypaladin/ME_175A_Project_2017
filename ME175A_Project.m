% ME175A F2017 Project
% Daniel Lui 

% Case 1: Patent Attorney w/ JD Degree 
% Case 2: Missionary in Africa or something
% Case 3: High School Physics Teacher yay physics
% Case 4: Software Developer bc it's cool now

% All of the salary values were taken from Payscale

% Teaching Credential values are for UCR
% Law School tuition values are for UCLA (UCR doesn't have a law school)
% Software Engineer nanodegree values are for 'App Academy'

format bank % $$$

marr = 0.05; % marr
d = 0.5; % deviation


% Simulation thing (generates a Gaussian distribution)

x = 0; y = 0;

n=1000;
for a=1:n
    x(a)=rand; y(a)=rand;
end

i = d*((x+y)-1);

new_marr = marr.*(1+i);

% Each of the 4 scenarios 
pv1=0; pv2=0; pv3=0; pv4=0; % Initialize all present values as 0

salary1 = 150000; tuition1 = 45338;  
salary2 = 31600; 
salary3e = 68268; salary3t = 50188; tuition3 = 17178; 
salary4 = 120000; 

% Present Value Calbulation without MARR variation

% Patent Lawyer
pv1a = f1('P/F',0.06,0,4)*(salary1*f1('P/A1',0.06,0.03,40)) - tuition1*f1('P/F',0.06,0,1)*f1('P/A',0.06,0,3);
% Missionary
pv2a = salary2*f1('P/A',0.06,0,50);
% Physics Teacher
pv3a = salary3e*f1('P/A1',0.06,0.03,20) + salary3t*f1('P/F',0.06,0,20)*f1('P/A',0.06,0,28) - tuition3*f1('P/A',0.06,0,2);        
% Nanodegree>Software Developer
pv4a = -2000 + f1('P/F',0.06,0,1)*(salary4*f1('P/A',0.06,0,47) - 0.15*salary4*f1('P/A',0.06,0,3));

% Simulation with MARR +/- deviation (50%)

for b=1:n
    % Patent Lawyer
    pv1(b) = f1('P/F',new_marr(b),0,4)*(salary1*f1('P/A1',new_marr(b),0.03,40)) - tuition1*f1('P/F',new_marr(b),0,1)*f1('P/A',new_marr(b),0,3);
    % Missionary
    pv2(b) = salary2*f1('P/A',new_marr(b),0,50);
    % Physics Teacher
    pv3(b) = salary3e*f1('P/A1',new_marr(b),0.03,20) + salary3t*f1('P/F',new_marr(b),0,20)*f1('P/A',new_marr(b),0,28) - tuition3*f1('P/A',new_marr(b),0,2);        
    % Nanodegree>Software Developer
    pv4(b) = -2000 + f1('P/F',0.06,0,1)*(salary4*f1('P/A',new_marr(b),0,47) - 0.15*salary4*f1('P/A',new_marr(b),0,3));
end

% output cell

out1={'Patent Lawyer' , pv1a ; 'Missionary', pv2a ; 'Physics Teacher' , pv3a; 'Developer', pv4a};


out2 = {'Patent Lawyer' , mean(pv1) , '±', 1.96*std(pv1); 'Missionary', mean(pv2) , '±', 1.96*std(pv2); 'Physics Teacher' mean(pv3) , '±', 1.96*std(pv3); 'Software Dev' mean(pv4) , '±', 1.96*std(pv4)};


diary out.m % output to a text file

disp(datetime('now')) % timestamp
disp(out1) % raw calculation cell
disp(out2) % sensitivity analysis cell

diary off



