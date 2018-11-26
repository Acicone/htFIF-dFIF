% Test Example
%
% Paper Iterative Filtering as a direct method for the decomposition
%  of nonstationary signals
% 
%  Example # 1
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

clear all
close all
clc

dt = 0.001;
t=-0.4:dt:0.4;
z=sin(4*pi*t)+0.5*cos(50*pi*abs(t)-40*pi*t.^2);

x1=sin(4*pi*t);
x2=0.5*cos(50*pi*abs(t)-40*pi*t.^2);

fig=figure;
plot(t,z,'k','linewidth',2) 
set(fig,'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
set(gca,'fontsize', 36)

fig=plot_imf_v8([x2;x1],t);
set(fig,'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
set(gca,'fontsize', 36)


%% 

opts=Settings_IF_v1('IF.NIMFs',1,'IF.alpha',1,'IF.Xi',4,'verbose',1);%,'IF.MaxInner',1);
tic
[IMF_old] = FIF_v1(z,opts);
time_FIF=toc
%% 

opts=Settings_IF_v1('IF.NIMFs',1,'IF.alpha',1,'IF.Xi',4,'verbose',1);%,'IF.MaxInner',1);
tic
IMF_ht = htFIF_v1(z,0.9,opts);
time_htFIF=toc
tic
IMF_d = dFIF_v1(z,0.98,0.56,opts);
time_dFIF=toc
%%
fig=figure;
plot(t,IMF_old(1,:),'g','linewidth',2)
hold on
plot(t,IMF_d(1,:),'k--','linewidth',2)
plot(t,IMF_ht(1,:),'r','linewidth',2)
ll=legend('IMF using FIF','IMF using dFIF','IMF using htFIF');
set(fig,'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
set(gca,'fontsize', 36)
set(ll,'Interpreter','latex')
