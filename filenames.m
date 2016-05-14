clear all;
close all;
clc

NS = glob('*.dat1'); #NS is a cell array with filenames with NS component
EW = glob('*.dat2');
UD = glob('*.dat3');

for i = 1:2 #length(NS)
	fid = fopen(NS{i},'rt');	#get permission to read a chosen file
	hdr = fscanf(fid,'%s',19);	#skip header
	NS1 = fscanf(fid,'%f',[3,Inf]) .'; #store data from the file into a matrix NS1
	
	fid2 = fopen(EW{i},'rt');
	hdr2 = fscanf(fid2,'%s',19);
	EW1 = fscanf(fid2,'%f',[3,Inf]) .';

	figure(i)
	plot(NS1(:,1),100*NS1(:,2),'o','markersize',4);
	xlabel ('Time, year','fontsize',20); 
	ylabel ('Displacement, mm','fontsize',20);
	title (NS{i},'fontsize',20);
	
	fclose(fid);
	fclose(fid2);
end



