%% Homework #3
% Problem 1
% Alec Hoyland
% 2018-11-20 14:09

pHeader;
tic

%% Load the data

[t, y] 		= textread('problem1_data.txt', ' %f%f ', 'headerlines', 1);

%% 1.1 Residual contour terrain

step 			= 0:0.1:2;
[X, Y] 		= meshgrid(step, step);

residual 	= NaN;
res_norm 	= NaN(length(step));
for ii = 1:length(step)
	for qq = 1:length(step)
		residual					= y - t .* exp(-step(ii) * t) .* sin(step(qq) * t);
		res_norm(ii, qq) 	= sum(residual.^2);
	end
end

figure('OuterPosition',[0 0 1200 1200],'PaperUnits','points','PaperSize',[1200 1200]); hold on
contour(X, Y, res_norm)
xlabel('\alpha')
ylabel('\omega')
title('norm-squared residual of alpha-sinusoid fit')

prettyFig()

if being_published
	snapnow
	delete(gcf)
end




%% Version Info
% The file that generated this document is called:
disp(mfilename)


%%
% and its md5 hash is:
Opt.Input = 'file';
disp(dataHash(strcat(mfilename,'.m'),Opt))


%%
% This file should be in this commit:
[status,m]=unix('git rev-parse HEAD');
if ~status
	disp(m)
end

time = toc;


%%
% This file has the following external dependencies:
showDependencyHash(mfilename);


%%
% This document was built in:
disp(strcat(oval(time,3),' seconds.'))
