clc;
clear;

X= [4795, 1687, 2062, 2539, 9064, 8721, 5906, 13913, 22953, 10778, 200, 2509, 5726, 5759, 739, 21290, 29351, 24040, 29741,22053,21441]
Y= [0.75,0.71,0.63,0.38,0.08,0.42,0.88,0.71,3.21,0.96, 0.75,0.5, 0.71, 0.38,0.21,0.67,2.21,1.92,4.38,1.96,1.13]

%SSC
X=[1430,1192,2524,2351,8708,15575,13143,6760,8666,19287,28739,18224,9720,24199,34542,10714,9555,13440,22867,29617,18761,24322,17946,24061,12279,17712,22654,24520,29349,397,10718,17962,340,1499,1452]
Y=[0,0,0,0,0,0.83,0.33,0,0.5,1.17,4,3,0.5,2.17,5.5,0,0.33,0.67,2.5,5.5,1.17,2.5,2.17,1.83,0.83,2.33,2.17,1.83,5.5,0,0.33,0,0,0,0]

%PFC
X= [4736,2012,11699,3836,13515,3769,3096,4453,605,2847,8973,10566,9549,20914,26645,29212,9650,13144,22248,1790,20311,10300,14545,20026,24066]
Y= [0,0,0,0,0,0,0,0,0,0,0,0.33,0,0.5,2.67,2.33,0.33,0.17,2.5,0,1.33,0,1,1.67,1.67]

%% Sigmoid
ft1 = fittype( 'a/(exp(-b*(x-c))+1)+d', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [1 0 -2 0];
opts.StartPoint = [10 0.0001 10000 0];
opts.Upper = [100 1 Inf 1];

[fitresult1, gof] = fit( X', Y', ft1, opts );

figure; hold on;
plot( fitresult1,'k', X', Y','ko')
legend off; xlabel('cell No.'); ylabel('Seizure frequency (/day)')
disp(['R^2 = ',num2str(gof.rsquare)])
disp(['a = ',num2str(fitresult1.a)])
disp(['b = ',num2str(fitresult1.b)])
disp(['c = ',num2str(fitresult1.c)])
disp(['d = ',num2str(fitresult1.d)])


%% Hyperbolic tangent
ft2 = fittype( 'a*tanh(b*(x-c))+d', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [1 0 0 1];
opts.StartPoint = [3 0.0001 10000 1];
opts.Upper = [10 0.1 Inf 10];

[fitresult2, gof] = fit( X', Y', ft2, opts );

figure; hold on;
plot( fitresult1, X', Y')
plot( fitresult2, X', Y')
legend off; xlabel('cell No.'); ylabel('Seizure frequency (/day)')
disp(['R^2 = ',num2str(gof.rsquare)])
disp(['a = ',num2str(fitresult2.a)])
disp(['b = ',num2str(fitresult2.b)])
disp(['c = ',num2str(fitresult2.c)])
disp(['d = ',num2str(fitresult2.d)])

%% Arctangent 
ft3 = fittype( 'a*atan(b*(x-c))+d', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [1 0 0 1];
opts.StartPoint = [3 0.0001 10000 1];
opts.Upper = [10 0.1 Inf 10];

[fitresult, gof] = fit( X', Y', ft3, opts );
figure; hold on;
plot (X', Y','ko')
set(groot,'defaultLineLineWidth',5)
set(gca, 'Fontsize', 14)

plot( fitresult1,'r')
set(groot,'defaultLineLineWidth',1.5)
plot( fitresult,'b')
plot( fitresult2,'g')
set(groot,'defaultLineLineWidth',1.5)
plot (X', Y','ko')
legend off;
xlim([0 40000]);
ylim([0 8]);
xticks([0 10000 20000 30000 40000]);
xticklabels({'0','1','2','3','4'});
xlabel('Cell count (10^4)'); 
yticks([0 2 4 6 8]);
ylabel('Spike frequency (/day)');
disp(['R^2 = ',num2str(gof.rsquare)])
disp(['a = ',num2str(fitresult.a)])
disp(['b = ',num2str(fitresult.b)])
disp(['c = ',num2str(fitresult.c)])
disp(['d = ',num2str(fitresult.d)])

%% ReLU
%%ft = fittype( 'a*max(x-b,0)', 'independent', 'x', 'dependent', 'y' );
%%opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
%%opts.Display = 'Off';
%%opts.Lower = [0 0];
%%opts.StartPoint = [0 0];
%%opts.Upper = [inf inf];

%%[fitresult, gof] = fit( X', Y', ft, opts );

%%figure; hold on;
%%plot( fitresult, X', Y')
%%legend off; xlabel('cell No.'); ylabel('Seizure frequecny (/day)')
%%disp(['% R^2 = ',num2str(gof.rsquare)])
%%disp(['%% a = ',num2str(fitresult.a)])
%%disp(['%% b = ',num2str(fitresult.b)])