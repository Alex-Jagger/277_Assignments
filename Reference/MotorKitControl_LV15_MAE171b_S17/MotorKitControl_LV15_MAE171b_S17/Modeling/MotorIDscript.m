clear all
clc

load('MotorIDinv')
AllData =[MotorData];

Amp = 35;

wgp = [.1:.1:15];


Fs = 200;
LoLim = Amp -5;
UpLim = Amp + 5;




Dataf = AllData;
Names = {Dataf.Data.MeasuredData.Name};
for ii = 1:length(wgp)
    w = wgp(ii);
    indy = find(ismember(Names,['data' num2str(w*10)]));
    
    Vtemp2 = detrend(Dataf.Data.MeasuredData(indy+1).Data,'constant');
    Vtemp = dtrend(Dataf.Data.MeasuredData(indy+2).Data,'constant');
    Itemp = detrend(Dataf.Data.MeasuredData(indy+3).Data,'constant');
    ComplexNum = FreqRespInt([Vtemp Itemp Vtemp2],w,[Fs 1 LoLim UpLim Amp]);
    FreqRespGPIC(ii,2) = ComplexNum(2);
    FreqRespGPIC(ii,1) = ComplexNum(1);
end

 figure(1)
subplot(2,1,1)
semilogx(wgp,20*log10(abs(FreqRespGPIC(:,1))))
title('Frequency Response Setpoint to Duty')
subplot(2,1,2)
semilogx(wgp,angle(FreqRespGPIC(:,1))*(180/pi))
 figure(2)
subplot(2,1,1)
semilogx(wgp,20*log10(abs(FreqRespGPIC(:,2))))
title('Frequency Response Setpoint to Counts') 
subplot(2,1,2)
semilogx(wgp,angle(FreqRespGPIC(:,2))*(180/pi))

C = tf([3e-5, .002, .0001],[0 1 0]);%tf([3e-5, .002, .0001],[0 1 0])tf([0, .0001, .0001],[0 1 0]);
H = freqresp(C,wgp,'Hz');

G = FreqRespGPIC(:,2);
G2 = FreqRespGPIC(:,1);
Gti = G./G2;
P = G./((1-G).*squeeze(H));

figure(3)
subplot(2,1,1)
semilogx(wgp,20*log10(abs(P)),wgp,20*log10(abs(Gti)))
title('Open Loop Freq Resp')
subplot(2,1,2)
semilogx(wgp,angle(P)*(180/pi),wgp,angle(Gti)*(180/pi))
% 
% % 
[b a] = invfreqs(Gti,2*pi*wgp,0,2)
% % % s = tf('s')
Pol = tf(b,a);
Polw = squeeze(freqresp(Pol,wgp,'Hz'));
 figure(4)
subplot(2,1,1)
semilogx(wgp,20*log10(abs(Polw)),wgp,20*log10(abs(Gti)))
subplot(2,1,2)
semilogx(wgp,angle(Polw)*(180/pi),wgp,angle(Gti)*(180/pi))
legend('fit','open loop')
