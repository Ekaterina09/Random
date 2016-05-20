clear all;
close all;
clc

NS = glob('*.dat1'); #NS is a cell array with filenames with NS component
EW = glob('*.dat2');
UD = glob('*.dat3');

for i = 1:length(NS)
	fid = fopen(NS{i},'rt');	#get permission to read a chosen file
	hdr = fscanf(fid,'%s',19);	#skip header
	NS1 = fscanf(fid,'%f',[3,Inf]) .'; #store data from the file into a matrix NS1
	
	fid2 = fopen(EW{i},'rt');
	hdr2 = fscanf(fid2,'%s',19);
	EW1 = fscanf(fid2,'%f',[3,Inf]) .';

#least squares linear regression
	x_NS = NS1(:,1);	#time in years		
	y_NS = 1000*NS1(:,2);	#displacement in mm
	m = length(x_NS);
	X_NS = [ones(m,1) x_NS];
	theta1 = (pinv(X_NS'*X_NS))*X_NS'*y_NS;	#returns [y-intersec;slope] of the linear fit (normal eq)
	vel_NS(i,1) = theta1(2);		#store velocities
	
	x_EW = EW1(:,1);		
	y_EW = 1000*EW1(:,2);
	X_EW = [ones(m,1) x_EW];
	theta2 = (pinv(X_EW'*X_EW))*X_EW'*y_EW;	
	vel_EW(i,1) = theta2(2);	

	vel_hor(i,1) = sqrt((vel_NS(i))^2+(vel_EW(i))^2); #total horizontal velocity

#plot NS-component
	#figure(i)
	#plot(NS1(:,1),1000*NS1(:,2),'rx','markersize',4);
	#xlabel ('Time, year','fontsize',20); 
	#ylabel ('Displacement, mm','fontsize',20);
	#title (NS{i},'fontsize',20);
	#hold on
	#plot(x_NS,X_NS*theta1,'-','linewidth',3);
	#legend('{\fontsize{12} Data}','{\fontsize{12} Linear fit}');

#plot EW-component
	#figure(i+2)
	#plot(EW1(:,1),1000*EW1(:,2),'rx','markersize',4);
	#xlabel ('Time, year','fontsize',20); 
	#ylabel ('Displacement, mm','fontsize',20);
	#title (EW{i},'fontsize',20);
	#hold on
	#plot(x_EW,X_EW*theta2,'-','linewidth',3);
	#legend('{\fontsize{12} Data}','{\fontsize{12} Linear fit}');

	fclose(fid);
	fclose(fid2);
end

velo = [vel_NS vel_EW vel_hor];
fid3 = fopen('mex.velo','w');
fprintf(fid3,'%f %f %f\n',velo');
fclose(fid3);

movefile ('mex.velo','../');




