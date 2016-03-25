clear;

M = csvread('vdebt.csv',1,0);
princ = M(:,2);
periods = M(:,3);
pay = M(:,4);

n = length(pay);
% make_dpopt('zeror');
p = [];
p.options.NumThreads=8;
p.options.ObjGoal='zero';
p.options.Algorithm='rtsafe';
p.options.TolX=1e-14;
p.lb=0.0001*ones(1,n);
p.ub=ones(1,n);
p.x0=0.01*ones(1,n);
p.data = [princ(:)'./pay(:)';periods(:)'];
p.idx = zeros(1,n);
[ir,f,v,b] = dpopt_zeror(p);
ir = ir*12;

dlmwrite('ir.csv',[M(:,1) ir'],'delimiter',',','precision',8);