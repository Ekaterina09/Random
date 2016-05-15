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
	
	#fid2 = fopen(EW{i},'rt');
	#hdr2 = fscanf(fid2,'%s',19);
	#EW1 = fscanf(fid2,'%f',[3,Inf]) .';

#least squares linear regression
	x_NS = NS1(:,1);		
	y_NS = 100*NS1(:,2);
	m = length(x_NS);
	X_NS = [ones(m,1) x_NS];
	theta = (pinv(X_NS'*X_NS))*X_NS'*y_NS; #returns [y-intersection; slope] of the linear fit
		
	figure(i)
	plot(NS1(:,1),100*NS1(:,2),'rx','markersize',4);
	xlabel ('Time, year','fontsize',20); 
	ylabel ('Displacement, mm','fontsize',20);
	title (NS{i},'fontsize',20);
	hold on
	plot(x_NS,X_NS*theta,'-','linewidth',3);
	legend('{\fontsize{12} Data}','{\fontsize{12} Linear fit}');

	fclose(fid);
	#fclose(fid2);
end



