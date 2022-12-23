%% Acoustics Assignment: Experiment 3 Part 2

%% Plots
% Defining the range of theta
theta = 0 : 0.001 : 2*pi;

% Defining the four mic patterns
subCardioid    = 0.7 + 0.3*cos(theta);
cardioid       = 0.5 + 0.5*cos(theta);
superCardioid  = 0.37 + 0.73*cos(theta);
hyperCardioid  = 0.25 + 0.75*cos(theta);

% Plotting (Linear)
figure
plot(theta, subCardioid)
figure
plot(theta, cardioid)
figure
plot(theta, superCardioid)
figure
plot(theta, hyperCardioid)

% Plotting (Polar - Normal)
figure
polarplot(theta, subCardioid)
figure
polarplot(theta, cardioid)
figure
polarplot(theta, superCardioid)
figure
polarplot(theta, hyperCardioid)

% Plotting (Polar - dB)
figure
Polar_dB(theta,10*log10(abs(subCardioid)),[-30 10],5,'k',1)
figure
Polar_dB(theta,10*log10(abs(cardioid)),[-30 10],5,'k',1)
figure
Polar_dB(theta,10*log10(abs(superCardioid)),[-30 10],5,'k',1)
figure
Polar_dB(theta,10*log10(abs(hyperCardioid)),[-30 10],5,'k',1)

%% Pros and Cons for Each Type
% 1. Sub-Cardioid: 
% Pros: Provides a transparent sound with less proximity effect; hence,
% more natural low-end
% Cons: Picks up more noise and is more likely to trigger feedback loop
% 2. Cardioid:
% Pros: Provides good sound quality with good noise cancellation (good choice for recording)
% and quite affordable - also perfect noise cancellation from the back (avoids feedback loops)
% Cons: susceptible to wind, proximity effect and plosives due to its large
% pick-up radius
% 3. Supercardioid: 
% Pros: Narrower pattern allows a better level of noise cancellation + achieving a better isolation while minimizing the bleed between two nearby sound sources
% Cons: added sensitivity to the sounds coming from the rear
% 4. Hypercardioid:
% Pros: offers an even narrower picking pattern than supercardioid + more
% sensitive to the sounds coming from the rear + picking sound from behind
% can be used to amplify sound (feedback)
% Cons: susceptible to noise from the back + avoid placing any sound source
% behind it

% Source: https://bit.ly/3HUgF4N

%% Function to Plot Polar - dB (Not Mine - Credits to Owner)
% Mazin Mustafa (2022). Polar_dB (https://www.mathworks.com/matlabcentral/fileexchange/67721-polar_db)
function []=Polar_dB(theta,data,range,Ntick,Line,option)
%   function [] = Polar_dB(theta,data,range,Ntick,Line,option)
%   Polar_dB plots the data in dB 'data' vs 'theta' is polar fashion. 
%
%  	theta 	: in radian
%   data   	: in dB
%   range   : e.g. [ min max ], default [-40 0] 
%   Ntick   : No. of radial ticks, default 5
% 	Line    : Line properties e.g. '--b', defaul 'k'
% 	option  : 1) Full circle 2) Half circle display, defaul 1 
%%
switch nargin
    case 2
        range 			=	[-40 round(max(data))]; % default
        Ntick 			= 	5;
		Line 			= 	'k';
		option 			= 	1;
	case 3
        Ntick 			= 	5;
		Line 			= 	'k';
		option 			= 	1;
	case 4
		Line 			= 	'k';
		option 			= 	1;
    case 5
		option 			= 	1;
end
data(isnan(data))       =   min(range);
data(data < min(range))	=   min(range);
polarplot(theta,data,Line,'LineWidth',1)
rlim(range)
%% 
if option == 1
thetaticks(0:15:345)
thetaticklabels({'0^\circ',' ','30^\circ',' ','60^\circ',' ','90^\circ',' ','120^\circ',' ','150^\circ',' ','180^\circ',' ','-150^\circ',' ','-120^\circ',' ','-90^\circ',' ','-60^\circ',' ','-30^\circ'})
end
%% 
if option == 2
thetalim([-90 90])
thetaticks(-90:15:90)
thetaticklabels({'-90^\circ',' ','-60^\circ',' ','-30^\circ',' ','0^\circ',' ','30^\circ',' ','60^\circ',' ','90^\circ'})
end
%%
range_                  =   linspace(min(range),max(range),Ntick); 
rticks(range_)
Labels                  =   cell(1,Ntick);
for i=1:Ntick
    if i==Ntick
        Labels{1,i}  	=   strcat(num2str(round(range_(i),2)),' dB');
    else
        Labels{1,i}    	=   num2str(round(range_(i),2));
    end
end
rticklabels(Labels)
%%
pax = gca;
pax.RAxisLocation   =   0;
pax.ThetaDir = 'clockwise';
pax.ThetaZeroLocation = 'top';
end