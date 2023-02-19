function FreqRespData = FreqRespInt(DataIn,w,Parameters)
%Datain First column is Input, 2nd is Current, 3rd is Output Voltage
%Parameter is an array [Fs D LowerLimit UpperLimit Amp]
Amp = 1/Parameters(5);
D = Parameters(2);
Ts = Parameters(1);
win = w;
textra = (1)/win;
Vtemp = DataIn(:,1);
Vtemp2 = DataIn(:,3);
Itemp = DataIn(:,2);


inds = find(Vtemp > Parameters(3) & Vtemp < Parameters(4),1,'first');
indf = inds + round(textra*Ts);
delt = inds:indf;

%         plot(delt,Vtemp(delt)-mean(Vtemp(delt)),delt,Vtemp2(delt)-mean(Vtemp2(delt)),delt,Itemp(delt)-mean(Itemp(delt)))
%         figure(2)
%         plot(delt,Vtemp(delt),delt,Vtemp(delt + round(2500*textra)))
VinNoBias = Vtemp(delt)-mean(Vtemp(delt));
VinNoBiasS = Vtemp(delt + round(Ts/4*textra))-mean(Vtemp(delt + round(Ts/4*textra)));
VoutNoBias = Vtemp2(delt)-mean(Vtemp2(delt));

IoutNoBias = Itemp(delt)-mean(Itemp(delt));

%         plot(delt/10000,VinNoBias,delt/10000,VoutNoBias)
% %         %     figure(2)
% %         plot(VcSim)
%         figure(2)
% %         plot(IlSim)
%         plot(delt/5000,VinNoBias,delt/5000,VinNoBiasS)
% %
mv1 = trapz(delt/Ts,VinNoBias.*VoutNoBias)/textra;
mv2 = trapz(delt/Ts,VinNoBiasS.*VoutNoBias)/textra;
%
FreqRespData(2) = Amp^2*2*(mv1+mv2*j);

%

%         % figure(3)
% plot(delt/5000,VinNoBias,delt/5000,IoutNoBias)
%
%
mi1 = trapz(delt/Ts,VinNoBias.*IoutNoBias)/textra;
mi2 = trapz(delt/Ts,VinNoBiasS.*IoutNoBias)/textra;

FreqRespData(1) = Amp^2*2*(mi1+mi2*j);


%  