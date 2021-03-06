clear all;
format long;
%%%%%%%%%%%%%%%%%%%i%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ev_vv = load('/home/aborba/ufal_mack/Data/evid_real_flevoland_hh_vv_param_razao.txt');
ev_hh = load('/home/aborba/ufal_mack/Data/evid_real_flevoland_1_param_L_mu_14_pixel.txt');
ev_hv = load('/home/aborba/ufal_mack/Data/evid_real_flevoland_2_param_L_mu_14_pixel.txt');
ev_vv = load('/home/aborba/ufal_mack/Data/evid_real_flevoland_3_param_L_mu_14_pixel.txt');
xc = load('/home/aborba/ufal_mack/Data/xc_flevoland.txt');
yc = load('/home/aborba/ufal_mack/Data/yc_flevoland.txt');
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
for i = 1: nc
	IM = zeros(m, n, nc);
end
for canal = 1 : nc
	for i = 1: num_radial
        		ik =  ev(i, canal); 
			IM( yc(i, ik), xc(i, ik), canal) = 1;
	end
end
[IF1] = fus_media(IM, m, n, nc);
[IF2] = fus_pca(IM, m, n, nc);
[IF3] = fus_swt(IM, m, n, nc);
[IF4] = fus_dwt(IM, m, n, nc);
[IF5] = fus_roc(IM, m, n, nc);
[IF6] = fus_svd(IM, m, n, nc);
GT = zeros(m, n);
cd ..
cd ..
cd Data
GT = load('gt_flevoland.txt');
cd ..
cd Code/Code_matlab
TESTE = zeros(m, n);
r = 120;
%for j=1: num_radial
%	for i = 1: r
%		if (yc(j, i) && xc(j, i)) > 0 
%		 TESTE( yc(j, i), xc(j, i)) = IF1(yc(j, i), xc(j, i));
%	 	end;
%	end
%end
%TESTE1 = zeros(m, n);
%for j=1: num_radial
%	for i = 1: r
%		if (yc(j, i) && xc(j, i)) > 0 
%		 TESTE1( yc(j, i), xc(j, i)) = GT(yc(j, i), xc(j, i));
%	 	end;
%	end
%end
erro_gt = 0;
nk = 10;
for j = 1: num_radial
	cont_f1 = 0;
	for i = 1: r
		if (yc(j, i) && xc(j, i)) > 0 
			if  GT(yc(j, i), xc(j, i)) > 0
				erro_gt = sqrt(yc(j, i)^2 + xc(j, i)^2);
			end
			if  IF1(yc(j, i), xc(j, i)) > 0
				cont_f1 = cont_f1 + 1;
				erro_aux_f1(cont_f1) = sqrt(yc(j, i)^2 + xc(j, i)^2);
			end
		end
	        minimo_f1 = 100; 
		for c=1: cont_f1
 			d = abs(erro_aux_f1(c) - erro_gt);
			minimo_f1 = min(d, minimo_f1);
		end
	end
	erro_f1(j) = minimo_f1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	cont_f2 = 0;
	for i = 1: r
		if (yc(j, i) && xc(j, i)) > 0 
			if  GT(yc(j, i), xc(j, i)) > 0
				erro_gt = sqrt(yc(j, i)^2 + xc(j, i)^2);
			end
			if  IF2(yc(j, i), xc(j, i)) > 0
				cont_f2 = cont_f2 + 1;
				erro_aux_f2(cont_f2) = sqrt(yc(j, i)^2 + xc(j, i)^2);
			end
		end
	        minimo_f2 = 100; 
		for c=1: cont_f2
 			d = abs(erro_aux_f2(c) - erro_gt);
			minimo_f2 = min(d, minimo_f2);
		end
	end
	erro_f2(j) = minimo_f2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	cont_f3 = 0;
	for i = 1: r
		if (yc(j, i) && xc(j, i)) > 0 
			if  GT(yc(j, i), xc(j, i)) > 0
				erro_gt = sqrt(yc(j, i)^2 + xc(j, i)^2);
			end
			if  IF3(yc(j, i), xc(j, i)) > 0
				cont_f3 = cont_f3 + 1;
				erro_aux_f3(cont_f3) = sqrt(yc(j, i)^2 + xc(j, i)^2);
			end
		end
	        minimo_f3 = 100; 
		for c=1: cont_f3
 			d = abs(erro_aux_f3(c) - erro_gt);
			minimo_f3 = min(d, minimo_f3);
		end
	end
	erro_f3(j) = minimo_f3;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	cont_f4 = 0;
	for i = 1: r
		if (yc(j, i) && xc(j, i)) > 0 
			if  GT(yc(j, i), xc(j, i)) > 0
				erro_gt = sqrt(yc(j, i)^2 + xc(j, i)^2);
			end
			if  IF4(yc(j, i), xc(j, i)) > 0
				cont_f4 = cont_f4 + 1;
				erro_aux_f4(cont_f4) = sqrt(yc(j, i)^2 + xc(j, i)^2);
			end
		end
	        minimo_f4 = 100; 
		for c=1: cont_f4
 			d = abs(erro_aux_f4(c) - erro_gt);
			minimo_f4 = min(d, minimo_f4);
		end
	end
	erro_f4(j) = minimo_f4;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	cont_f5 = 0;
	for i = 1: r
		if (yc(j, i) && xc(j, i)) > 0 
			if  GT(yc(j, i), xc(j, i)) > 0
				erro_gt = sqrt(yc(j, i)^2 + xc(j, i)^2);
			end
			if  IF5(yc(j, i), xc(j, i)) > 0
				cont_f5 = cont_f5 + 1;
				erro_aux_f5(cont_f5) = sqrt(yc(j, i)^2 + xc(j, i)^2);
			end
		end
	        minimo_f5 = 100; 
		for c=1: cont_f5
 			d = abs(erro_aux_f5(c) - erro_gt);
			minimo_f5 = min(d, minimo_f5);
		end
	end
	erro_f5(j) = minimo_f5;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	cont_f6 = 0;
	for i = 1: r
		if (yc(j, i) && xc(j, i)) > 0 
			if  GT(yc(j, i), xc(j, i)) > 0
				erro_gt = sqrt(yc(j, i)^2 + xc(j, i)^2);
			end
			if  IF6(yc(j, i), xc(j, i)) > 0
				cont_f6= cont_f6 + 1;
				erro_aux_f6(cont_f6) = sqrt(yc(j, i)^2 + xc(j, i)^2);
			end
		end
	        minimo_f6 = 100; 
		for c=1: cont_f6
 			d = abs(erro_aux_f6(c) - erro_gt);
			minimo_f6 = min(d, minimo_f6);
		end
	end
	erro_f6(j) = minimo_f6;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nk = 10;
freq_f1 = zeros(1, nk + 1); 
freq_f2 = zeros(1, nk + 1); 
freq_f3 = zeros(1, nk + 1); 
for k= 1: nk
	contador_f1 = 0;
	for j = 1: num_radial
		if (erro_f1(j) < k)
			contador_f1 = contador_f1 + 1;
		end
	end
	freq_f1(k + 1) = contador_f1 / num_radial;
	contador_f2 = 0;
	for j = 1: num_radial
		if (erro_f2(j) < k)
			contador_f2 = contador_f2 + 1;
		end
	end
	freq_f2(k + 1) = contador_f2 / num_radial;
	contador_f3 = 0;
	for j = 1: num_radial
		if (erro_f3(j) < k)
			contador_f3 = contador_f3 + 1;
		end
	end
	freq_f3(k + 1) = contador_f3 / num_radial;
	contador_f4 = 0;
	for j = 1: num_radial
		if (erro_f4(j) < k)
			contador_f4 = contador_f4 + 1;
		end
	end
	freq_f4(k + 1) = contador_f4 / num_radial;
	contador_f5 = 0;
	for j = 1: num_radial
		if (erro_f5(j) < k)
			contador_f5 = contador_f5 + 1;
		end
	end
	freq_f5(k + 1) = contador_f5 / num_radial;
	contador_f6 = 0;
	for j = 1: num_radial
		if (erro_f6(j) < k)
			contador_f6 = contador_f6 + 1;
		end
	end
	freq_f6(k + 1) = contador_f6 / num_radial;
end
cd ..
cd ..
cd Data
       fname = sprintf('metricas_fusao_flevoland.txt', canal);
       fid = fopen(fname,'w');
       for i = 1: nk
                fprintf(fid,'%f ', freq_f1(i));
        end
	fprintf(fid,'\n');
       	for i = 1: nk
        	fprintf(fid,'%f ', freq_f2(i));
        end
	fprintf(fid,'\n');
       	for i = 1: nk
                fprintf(fid,'%f ', freq_f3(i));
        end
	fprintf(fid,'\n');
       	for i = 1: nk
                fprintf(fid,'%f ', freq_f4(i));
        end
	fprintf(fid,'\n');
       	for i = 1: nk
                fprintf(fid,'%f ', freq_f5(i));
        end
	fprintf(fid,'\n');
       	for i = 1: nk
                fprintf(fid,'%f ', freq_f6(i));
        end
	fprintf(fid,'\n');
        fclose(fid);       
cd ..
cd Code/Code_matlab
