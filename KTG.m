clear all; close all; clc;
%% Original FHR signal
signal = load('data_FHR.mat');
signal = signal.fhr;
fs = 4;
tm = ((0:numel(signal)-1)/fs);
figure(1); hold on;
plot(tm/60,signal); axis tight;
title('FHR signal');xlabel('Time (min)');ylabel('fHRV (bpm)');
%% interpolation
signal1 = signal(signal>0);
tm1 = tm(signal>0);
signal1 = pchip(tm1,signal1,tm);
plot(tm/60,signal1, 'r'); legend('raw FHR', 'Filtered and interpolated FHR','Location','southwest');
hold off;
%% 1. baseline estimate
fc = 0.008;
[b,a] = butter(3,fc/(fs/2));

signalB = filtfilt(b,a,signal1);
figure(2); subplot(4,1,1);
hold on;
plot(tm/60,signal1);
plot(tm/60,signalB, 'g',"LineWidth",2); hold off;
title('1. estimate of baseline');xlabel('Time (min)');ylabel('fHRV (bpm)');

%% 2. baseline estimate
signal2 = signal1(signal1<signalB+5 & signal1>signalB-5);
tm2 = tm(signal1<signalB+5 & signal1>signalB-5);
signal2 = pchip(tm2,signal2,tm);
subplot(4,1,2); 
hold on;
plot(tm/60,signal1);

signalB2 = filtfilt(b,a,signal2);
plot(tm/60,signalB2,'g','LineWidth',2);hold off;
title('2. estimate of baseline');xlabel('Time (min)');ylabel('fHRV (bpm)');

%% 3. baseline estimate
signal3 = signal1(signal1<signalB2+5 & signal1>signalB2-5);
tm3 = tm(signal1<signalB2+5 & signal1>signalB2-5);
signal3 = pchip(tm3,signal3,tm);
subplot(4,1,3); 
hold on;
plot(tm/60,signal1);

signalB3 = filtfilt(b,a,signal3);
plot(tm/60,signalB3,'g','LineWidth',2);hold off;
title('3. estimate of baseline');xlabel('Time (min)');ylabel('fHRV (bpm)');

%% 4. baseline estimate
fc = 0.006;
[b1,a1] = butter(3,fc/(fs/2));

signal4 = signal1(signal1<signalB3+5 & signal1>signalB3-5);
tm4 = tm(signal1<signalB3+5 & signal1>signalB3-5);
signal4 = pchip(tm4,signal4,tm);
subplot(4,1,4); 
hold on;
plot(tm/60,signal1);

signalB4 = filtfilt(b1,a1,signal4);
plot(tm/60,signalB4,'g','LineWidth',2);hold off;
title('4. estimate of baseline');xlabel('Time (min)');ylabel('fHRV (bpm)');

%% plot dec 4.
tmd = tm/60;
figure(3);
hold on;axis tight;
plot(tmd,signal1);
plot(tmd,signalB4,'g','LineWidth',2);
title('Detection of dec and acc with 4.baseline');xlabel('Time (min)');ylabel('fHRV (bpm)');

[decStarts4,decEnds4] = decDet(signal1,signalB4,fs);
for j = 1:length(decStarts4)
    x1 = tmd(decStarts4(j));
    x2 = tmd(decEnds4(j));
    y = signal1(decStarts4(j));
    plot([x1,x2],[y,y],'r','LineWidth',3);
end
[accStarts4,accEnds4] = accDet(signal1,signalB4,fs);
for k = 1:length(accStarts4)
    x1 = tmd(accStarts4(k));
    x2 = tmd(accEnds4(k));
    y = signal1(accStarts4(k));
    plot([x1,x2],[y,y],'k','LineWidth',3);
end
legend('FHR signal', 'Baseline','Decelerations','Location','southwest');
hold off;

%% plot dec 3.
figure(4);
hold on;axis tight;
plot(tmd,signal1);
plot(tmd,signalB3,'g','LineWidth',2);
title('Detection of dec and acc with 3.baseline');xlabel('Time (min)');ylabel('fHRV (bpm)');
[decStarts3,decEnds3] = decDet(signal1,signalB3,fs);
for j = 1:length(decStarts3)
    x1 = tmd(decStarts3(j));
    x2 = tmd(decEnds3(j));
    y = signal1(decStarts3(j));
    plot([x1,x2],[y,y],'r','LineWidth',3);
end
[accStarts3,accEnds3] = accDet(signal1,signalB3,fs);
for k = 1:length(accStarts3)
    x1 = tmd(accStarts3(k));
    x2 = tmd(accEnds3(k));
    y = signal1(accStarts3(k));
    plot([x1,x2],[y,y],'black','LineWidth',3);
end
legend('FHR signal', 'Baseline','Decelerations','Location','southwest');
hold off;
%% plot dec 2.
figure(5);
hold on;axis tight;
plot(tmd,signal1);
plot(tmd,signalB2,'g','LineWidth',2);
title('Detection of dec and acc with 2.baseline');xlabel('Time (min)');ylabel('fHRV (bpm)');
[decStarts2,decEnds2] = decDet(signal1,signalB2,fs);
for j = 1:length(decStarts2)
    x1 = tmd(decStarts2(j));
    x2 = tmd(decEnds2(j));
    y = signal1(decStarts2(j));
    plot([x1,x2],[y,y],'r','LineWidth',3);
end
[accStarts2,accEnds2] = accDet(signal1,signalB2,fs);
for k = 1:length(accStarts2)
    x1 = tmd(accStarts2(k));
    x2 = tmd(accEnds2(k));
    y = signal1(accStarts2(k));
    plot([x1,x2],[y,y],'black','LineWidth',3);
end
legend('FHR signal', 'Baseline','Decelerations','Location','southwest');
hold off;
%% plot dec 1.
figure(6);
hold on;axis tight;
plot(tmd,signal1);
plot(tmd,signalB,'g','LineWidth',2);
title('Detection of dec and acc with 1.baseline');xlabel('Time (min)');ylabel('fHRV (bpm)');
[decStarts1,decEnds1] = decDet(signal1,signalB,fs);
for j = 1:length(decStarts1)
    x1 = tmd(decStarts1(j));
    x2 = tmd(decEnds1(j));
    y = signal1(decStarts1(j));
    plot([x1,x2],[y,y],'r','LineWidth',3);
end
[accStarts1,accEnds1] = accDet(signal1,signalB,fs);
for k = 1:length(accStarts1)
    x1 = tmd(accStarts1(k));
    x2 = tmd(accEnds1(k));
    y = signal1(accStarts1(k));
    plot([x1,x2],[y,y],'black','LineWidth',3);
end
legend('FHR signal', 'Baseline','Decelerations','Location','southwest');
hold off;

%% params baseline 1
b1Params.meanBaseL = mean(signalB);
b1Params.sdBaseL = std(signalB);

b1Params.numberOfDec = length(decStarts1);
b1Params.avgDecDur = mean((decEnds1 - decStarts1)*1/fs);
b1Params.sdDecDur = std((decEnds1 - decStarts1)*1/fs);
b1Params.maxDecDur = max((decEnds1 - decStarts1)*1/fs);
b1Params.minDecDur = min((decEnds1 - decStarts1)*1/fs);

b1Params.numberOfAcc = length(accStarts1);
b1Params.avgAccDur = mean((accEnds1 - accStarts1)*1/fs);
b1Params.sdAccDur = std((accEnds1 - accStarts1)*1/fs);
b1Params.maxAccDur = max((accEnds1 - accStarts1)*1/fs);
b1Params.minAccDur = min((accEnds1 - accStarts1)*1/fs);
disp("1. baseline estimate parameters")
disp(b1Params);
%% params baseline 2
b2Params.meanBaseL = mean(signalB2);
b2Params.sdBaseL = std(signalB2);

b2Params.numberOfDec = length(decStarts2);
b2Params.avgDecDur = mean((decEnds2 - decStarts2)*1/fs);
b2Params.sdDecDur = std((decEnds2 - decStarts2)*1/fs);
b2Params.maxDecDur = max((decEnds2 - decStarts2)*1/fs);
b2Params.minDecDur = min((decEnds2 - decStarts2)*1/fs);

b2Params.numberOfAcc = length(accStarts2);
b2Params.avgAccDur = mean((accEnds2 - accStarts2)*1/fs);
b2Params.sdAccDur = std((accEnds2 - accStarts2)*1/fs);
b2Params.maxAccDur = max((accEnds2 - accStarts2)*1/fs);
b2Params.minAccDur = min((accEnds2 - accStarts2)*1/fs);

disp("2. baseline estimate parameters")
disp(b2Params);
%% params baseline 3
b3Params.meanBaseL = mean(signalB3);
b3Params.sdBaseL = std(signalB3);

b3Params.numberOfDec = length(decStarts3);
b3Params.avgDecDur = mean((decEnds3 - decStarts3)*1/fs);
b3Params.sdDecDur = std((decEnds3 - decStarts3)*1/fs);
b3Params.maxDecDur = max((decEnds3 - decStarts3)*1/fs);
b3Params.minDecDur = min((decEnds3 - decStarts3)*1/fs);

b3Params.numberOfAcc = length(accStarts3);
b3Params.avgAccDur = mean((accEnds3 - accStarts3)*1/fs);
b3Params.sdAccDur = std((accEnds3 - accStarts3)*1/fs);
b3Params.maxAccDur = max((accEnds3 - accStarts3)*1/fs);
b3Params.minAccDur = min((accEnds3 - accStarts3)*1/fs);

disp("3. baseline estimate parameters")
disp(b3Params);
%% params baseline 4
b4Params.meanBaseL = mean(signalB4);
b4Params.sdBaseL = std(signalB4);

b4Params.numberOfDec = length(decStarts4);
b4Params.avgDecDur = mean((decEnds4 - decStarts4)*1/fs);
b4Params.sdDecDur = std((decEnds4 - decStarts4)*1/fs);
b4Params.maxDecDur = max((decEnds4 - decStarts4)*1/fs);
b4Params.minDecDur = min((decEnds4 - decStarts4)*1/fs);

b4Params.numberOfAcc = length(accStarts4);
b4Params.avgAccDur = mean((accEnds4 - accStarts4)*1/fs);
b4Params.sdAccDur = std((accEnds4 - accStarts4)*1/fs);
b4Params.maxAccDur = max((accEnds4 - accStarts4)*1/fs);
b4Params.minAccDur = min((accEnds4 - accStarts4)*1/fs);

disp("4. baseline estimate parameters")
disp(b4Params);


