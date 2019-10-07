clear all;
format long;
cd ..
cd ..
cd Data
load AirSAR_Flevoland_Enxuto.mat
[nrows, ncols, nc] = size(S);
cd ..
cd Code/Code_matlab
for i =1: nrows
	for j = 1: ncols
     		I11(i, j)   = S(i, j, 1);
     		I22(i, j)   = S(i, j, 2);
     		I33(i, j)   = S(i, j, 3);
     		SS(i, j, 1)  = sqrt(S(i, j, 4)^2 + S(i, j, 7)^2);
     		SS(i, j, 2)  = sqrt(S(i, j, 5)^2 + S(i, j, 8)^2);
     		SS(i, j, 3)  = sqrt(S(i, j, 6)^2 + S(i, j, 9)^2);
	end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
II = show_Pauli(S, 1, 0);
%%%%%%%%%%%%%%%%%%%i%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ev_hh = load('/home/aborba/git_ufal_mack/Data/evid_real_flevoland_1.txt');
ev_hv = load('/home/aborba/git_ufal_mack/Data/evid_real_flevoland_2.txt');
ev_vv = load('/home/aborba/git_ufal_mack/Data/evid_real_flevoland_3.txt');
%ev_hh_hv = load('/home/aborba/git_ufal_mack/Data/evid_real_flevoland_produto_1.txt');
%ev_hh_vv = load('/home/aborba/git_ufal_mack/Data/evid_real_flevoland_produto_2.txt');
%ev_hv_vv = load('/home/aborba/git_ufal_mack/Data/evid_real_flevoland_produto_3.txt');
xc = load('/home/aborba/git_ufal_mack/Data/xc_flevoland.txt');
yc = load('/home/aborba/git_ufal_mack/Data/yc_flevoland.txt');
num_radial = 100;
for i = 1: num_radial 
ev(i, 1) = round(ev_hh(i, 3));
ev(i, 2) = round(ev_hv(i, 3));
ev(i, 3) = round(ev_vv(i, 3));
%ev(i, 4) = round(ev_hh_hv(i, 3));
%ev(i, 5) = round(ev_hh_vv(i, 3));
%ev(i, 6) = round(ev_hv_vv(i, 3));
end
nc = 3;
m = 750;
n = 1024;
%x0 = m / 2 + 10;
%y0 = n / 2 + 80;
%x0 = m / 2 - 140;
%y0 = n / 2 - 200;
for i = 1: nc
	IM = zeros(m, n, nc);
end
for canal = 1 : nc
	for i = 1: num_radial
        		ik =  ev(i, canal); 
			IM( yc(i, ik), xc(i, ik), canal) = 1;
	end
end
%figure(1), imshow(I255);
%figure(2), imshow(IG);
%[IF] = fus_media(IM, m, n, nc);
%[IF] = fus_pca(IM, m, n, nc);
%[IF] = fus_swt(IM, m, n, nc);
[IF] = fus_roc(IM, m, n, nc);
%%%%%%%%%%% ROIs %%%%%%%%%%%%%%%%%%
x0 = m / 2 - 140;
y0 = n / 2 - 200;
lex = x0 - 20;
lrx = x0 + 180;
hty = y0 - 210;
hby = y0 + 60;

IM_hh = IM(lex: lrx, hty: hby ,1);
IM_hv = IM(lex: lrx, hty: hby ,2);
IM_vv = IM(lex: lrx, hty: hby ,3);
IF_crop = IF(lex: lrx, hty: hby);

imshow(II)
axis on
hold on;

for i=1: nrows
	for j=1: ncols
		if IF(i, j) ~= 0
			plot(j,i,'ro',...
    				'LineWidth',1,...
    				'MarkerSize',3.5,...
    				'MarkerEdgeColor',[0.85 0.325 0.089],...
    				'MarkerFaceColor', [0.85 0.325 0.089])
		end
	end
end