% Test Example
%
% Paper Iterative Filtering as a direct method for the decomposition
%  of nonstationary signals
% 
%  Example # 4
%
%
%  Ref: A. Cicone, J. Liu, H. Zhou. 'Adaptive Local Iterative Filtering for
%  Signal Decomposition and Instantaneous Frequency analysis'. Applied and
%  Computational Harmonic Analysis, Volume 41, Issue 2, September 2016,
%  Pages 384-411. doi:10.1016/j.acha.2016.03.001
%  ArXiv http://arxiv.org/abs/1411.6051
%
%  A. Cicone. 'Nonstationary signal decomposition for dummies'.
%  Chapter in the book: Advances in Mathematical Methods and High
%  Performance Computing. Springer, 2019
%  ArXiv https://arxiv.org/abs/1710.04844
%
%  A. Cicone, H. Zhou. 'Numerical Analysis for Iterative Filtering with
%  New Efficient Implementations Based on FFT'
%  ArXiv http://arxiv.org/abs/1802.01359
%
%  A. Cicone. 'Iterative Filtering as a direct method for the decomposition
%  of nonstationary signals'
%  ArXiv http://arxiv.org/abs/1811.03536
%
% Dataset available at http://hpiers.obspm.fr/eoppc/eop/eopc04/eopc04.62-now
 
clear all
close all
clc

load LOD_up_to_09_2018
LOD=table2array(eopc04(9:end-1,8));
t=1:length(LOD);

fig=figure;
plot(t,LOD,'k','linewidth',2)
set(fig,'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
set(gca,'fontsize', 36)
axis([-Inf Inf -Inf Inf])

%%

opts=Settings_IF('IF.NIMFs',30,'IF.alpha','Almost_min','IF.Xi',1.8,'verbose',0,'IF.extensionType','p');%,'IF.MaxInner',1);
tic
[IMF_IF] = IF_v6_2(LOD,opts);
time_IF=toc

%%

opts=Settings_IF_v1('IF.NIMFs',30,'IF.alpha','Almost_min','IF.Xi',1.8,'verbose',0);%,'IF.MaxInner',1);
tic
[IMF_fif] = FIF_v1(LOD,opts);
time_FIF=toc

plot_imf_v8(IMF_fif)

%%
opts=Settings_IF_v1('IF.NIMFs',22,'IF.alpha','Almost_min','IF.Xi',1.8,'verbose',0);%,'IF.MaxInner',1);
tic
IMF_ht = htFIF_v1(LOD,0.9,opts);
time_htFIF=toc
tic
IMF_d = dFIF_v1(LOD,0.98,0.56,opts);
time_dFIF=toc

plot_imf_v8(IMF_ht)

plot_imf_v8(IMF_d)
