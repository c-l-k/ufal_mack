function [phantom] = Generate_PolSAR_two_classes_phantom_flor(S, L, m, n, img, rows, cols)
%Phantom_generator function
% 
% To generate 500 x 500 PolSAR phantoms
% S:        vector of matrices with the valid S for each class
%           valid S:S must be definite positive
% L:        scalar with an unique L value
% m:        height of the phantom
% n:        width of the phantom
% This version is not parametrized, so use always m = n = 500.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script works wiht the main script:
% Polsar_two_classes_phantom_Convex_sum.m
% Used to get results in the publication:
%     L. Gomez, L. Alvarez, L. Mazorra and, A.C. Frery
%     "Fully PolSAR image classification using machine learning techniques and
%      reaction-difusion systems,", Neurocomputing, 2016 (under revision)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     Please, refer to the publication when publishing results obtained
%            with this code or variations of it
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Coded to Matlab by Luis Gomez, CTIM, Universidad de Las Palmas de Gran
% Canaria, January 2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AAB - Adaptado para a phantom em coordenadas polares para a flor.                     Data:  21/11/2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ns = n/2;
ns = n;
phantom = zeros(m,n,9);
aux     = zeros(m,n,9);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Regions:
% class 1
class_1_samples = m*ns;
% class 2
class_2_samples = m*ns;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Class 1:
% Sigma
% We take a valid sigma matrix
Sigma1 = S(:,:,1);
Sigma2 = S(:,:,2);
[S_class_1] = cwishart_variates(Sigma1,L,class_1_samples);
% Class 2:
[S_class_2] = cwishart_variates(Sigma2,L,class_2_samples);
%background rose outside
phantom(1:m, 1:n,1) = reshape(S_class_1(1,1,:),m, n);
phantom(1:m, 1:n,2) = reshape(S_class_1(2,2,:),m, n);
phantom(1:m, 1:n,3) = reshape(S_class_1(3,3,:),m, n);
phantom(1:m, 1:n,4) = reshape(real(S_class_1(1,2,:)),m, n);
phantom(1:m, 1:n,5) = reshape(imag(S_class_1(1,2,:)),m, n);
phantom(1:m, 1:n,6) = reshape(real(S_class_1(1,3,:)),m, n);
phantom(1:m, 1:n,7) = reshape(imag(S_class_1(1,3,:)),m, n);
phantom(1:m, 1:n,8) = reshape(real(S_class_1(2,3,:)),m, n);
phantom(1:m, 1:n,9) = reshape(imag(S_class_1(2,3,:)),m, n);
%background rose inside
[S_class_2] = cwishart_variates(Sigma2,L,class_2_samples);
aux(1:m,1:n,1) = reshape(S_class_2(1,1,:),m,n);
aux(1:m,1:n,2) = reshape(S_class_2(2,2,:),m,n);
aux(1:m,1:n,3) = reshape(S_class_2(3,3,:),m,n);
aux(1:m,1:n,4) = reshape(real(S_class_2(1,2,:)),m,n);
aux(1:m,1:n,5) = reshape(imag(S_class_2(1,2,:)),m,n);
aux(1:m,1:n,6) = reshape(real(S_class_2(1,3,:)),m,n);
aux(1:m,1:n,7) = reshape(imag(S_class_2(1,3,:)),m,n);
aux(1:m,1:n,8) = reshape(real(S_class_2(2,3,:)),m,n);
aux(1:m,1:n,9) = reshape(imag(S_class_2(2,3,:)),m,n);
L1 = length(rows);
L2 = length(cols);
for i= 1: L1
	phantom(rows(i), cols(i),1) = phantom(rows(i), cols(i),1) ;
	phantom(rows(i), cols(i),2) = phantom(rows(i), cols(i),1) ;
	phantom(rows(i), cols(i),3) = phantom(rows(i), cols(i),1) ;
	phantom(rows(i), cols(i),4) = phantom(rows(i), cols(i),1) ;
	phantom(rows(i), cols(i),5) = phantom(rows(i), cols(i),1) ;
	phantom(rows(i), cols(i),6) = phantom(rows(i), cols(i),1) ;
	phantom(rows(i), cols(i),7) = phantom(rows(i), cols(i),1) ;
	phantom(rows(i), cols(i),8) = phantom(rows(i), cols(i),1) ;
	phantom(rows(i), cols(i),9) = phantom(rows(i), cols(i),1) ;
end
%imshow(img)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Coded to Matlab by Luis Gomez, CTIM, Universidad de Las Palmas de Gran
% Canaria, January 2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     L. Gomez, L. Alvarez, L. Mazorra and, A.C. Frery
%     "Fully PolSAR image classification using machine learning techniques and
%      reaction-difusion systems,", Neurocomputing, 2016 (under revision)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     Please, refer to the publication when publishing results obtained
%            with this code or variations of it
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
