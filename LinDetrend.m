%% linear detrending
% Step 1) Make vector 'conc' containing calcium intensity axis
% Step 2) Make vector 'time' containing time axis
% * c and t should have the same length

dt = 0.375; % time interval in sec
time = [0:dt:dt*(length(conc)-1)]';

scatter(time,conc,'b*'); % Input calcium trace

ind1 = [1:8]; % baseline index 1
ind2 = [60:91]; % baseline index 2

P = polyfit(time([ind1,ind2]),conc([ind1,ind2]),1);
cfit = P(1)*time+P(2);
hold on;

plot(time,cfit,'r-.'); % Linear trend
plot(time,conc-cfit+P(2),'r*'); % Detrended calcium trace
result = conc-cfit+P(2);