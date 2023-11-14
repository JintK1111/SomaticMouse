%%%%parameter(custom input)
% enter value : (1) channel no. (2) timezone (ms) 60000=1min
cur_channel = 3
time_zone = 60000; %(ms, 1s=1000)
time_start = (59-24)*60000+(60-18)*1000; %(60000: starting min, 1000:starting sec)

%%%%threshold
ch1 = amplifier_data(cur_channel,:);
TS = 1:length(ch1);
%TS = t_amplifier*10005
dTS = diff(TS);
ACdelay = 360;
ACtime = (TS(1)+ACdelay):120:TS(end);
% ACtime = ACtime/60000;
nUnit = 120; % 100ms for each blcok
totUnit = floor(length(ch1)/nUnit);
reData = reshape(ch1(1:nUnit*totUnit),nUnit,totUnit);
% reData = [reData(:,1:end-1); reData(:,2:end)];
HighValue = max(reData);
HighBdry = max([HighValue(2:end-1);HighValue(3:end)]);
HV = min([HighValue(1:end-2);HighBdry]);
LowValue = min(reData);
LowBdry = min([LowValue(2:end-1);LowValue(3:end)]);
LV = max([LowValue(1:end-2);LowBdry]);
autoCorr = HV-LV;
N_AC = 30; % N_AC units were used to calculate AutoCorr.
    % Current setting: N_AC*nUnit = 30*100 = 3 sec
tmp_ac = conv(ones(N_AC,1),autoCorr);
AmpCorr = tmp_ac(1:length(autoCorr))/N_AC;
fs = 1000; % sampling rate = 1kHz
mean_ac = mean(AmpCorr);
th_ac =2*mean_ac+0*std(AmpCorr) ;

%%%% execute
y_int = amplifier_data(cur_channel,time_start:time_start+time_zone);
y_int_2 = amplifier_data(cur_channel,:);
y2=mspeaks([0:time_zone], abs(y_int), 'HeightFilter', 2*mean_ac);
y3= bandpass(y_int, [5 80],fs);

plot(0:time_zone,y_int,'b',y2(:,1),y2(:,2),'ro')%, 0:time_zone ,y_3,'g',"LineWidth",1, 'MarkerFaceColor','r', 'MarkerSize', 10)
yline(mean_ac,'-','mean-ac', 'LineWidth', 1);
yline(-mean_ac,'-','mean-ac', 'LineWidth', 1);
PEAK = y2(:,2)
TIME = y2(:,1)/1000
N=nnz(PEAK)
