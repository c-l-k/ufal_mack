# Autor: AAB    versão 1.0 data: 14/11/2018
# O programa le uma imagem 400 X 400 (canais hh, hv e vv) encontra a funcao l(j) para cada linha da imagem, e calcula o ponto de max/min (evidencia de borda) pelo método GenSA.
# O programa imprime um vetor de tamanho 400 com as evidencias de bordas para cada linha da imagem em uma arquivo *.txt
# obs: 1) Trocar os canais nos arquivos de entrada e saida.
#      2) Progama preparado para rodar amostras em duas metades com sigmas propostos me \cite{nhfc} e \cite{gamf}.
#      3) Desabilitei o print em arquivo depois de rodar os testes de interesse com o intuito de não modificar arquivos indevidamente.
rm(list = ls())
require(ggplot2)
require(latex2exp)
require(GenSA)
require(maxLik)
#
source("func_obj_l_L_mu_razao.r")
source("func_obj_l_razao_inten.r")
source("func_obj_l_razao_inten_tau.r")
source("loglike_razao.r")
source("loglikd_razao.r")
source("loglike_razao_tau.r")
source("loglikd_razao_tau.r")
# Programa principal
setwd("../..")
setwd("Data")
# canais hh, hv, and vv
mat1 <- scan('Phantom_nhfc_0.000_1_2_1.txt')
mat2 <- scan('Phantom_nhfc_0.000_1_2_2.txt')
setwd("..")
setwd("Code/Code_r")
r <- 400
mat1 <- matrix(mat1, ncol = r, byrow = TRUE)
mat2 <- matrix(mat2, ncol = r, byrow = TRUE)
d <- dim(mat1)
nrows <- d[1]
N  <- d[2]
# Loop para toda a imagem
evidencias          <- rep(0, nrows)
evidencias_valores  <- rep(0, nrows)
xev  <- seq(1, nrows, 1 )
#for (k in 1 : nrows){# j aqui varre o número de radiais
for (k in 1 : 1){# k aqui varre o número de radiais
  print(k)
  z1 <- rep(0, N)
	z2 <- rep(0, N)
	zaux <- rep(0, N)
  z1 <- mat1[k, 1: N] 
  z2 <- mat2[k, 1: N]
	conta = 0
  for (i in 1 : N){
	  if (z2[i] > 0){
      conta <- conta + 1
		  zaux[conta] <- z1[i] / z2[i]
	  }
	}
	indx      <- which(zaux != 0)
	N         <- length(indx)
	z         <- rep(0, N)
	tau       <- rep(0, N)
	z[1: N]   <- zaux[1: N]
	tau[1: N] <- zaux[1: N]
	matdf1 <- matrix(0, nrow = N, ncol = 2)
	matdf2 <- matrix(0, nrow = N, ncol = 2)
	for (j in 1 : N){
    r1 <- 1
	  r2 <- 0.00005
	  res1 <- maxBFGS(loglike_razao_tau, start=c(r1, r2))
	  matdf1[j, 1] <- res1$estimate[1]
	  matdf1[j, 2] <- res1$estimate[2]
	  r1 <- 1
    r2 <- 0.00005
	  res2 <- maxBFGS(loglikd_razao_tau, start=c(r1, r2))
	  if (j < N){
	    matdf2[j, 1] <- res2$estimate[1]
	    matdf2[j, 2] <- res2$estimate[2]
	  }
	}
	cf <- 14
	lower <- as.numeric(cf) 
	upper <- as.numeric(N - cf)
	out   <- GenSA(lower = lower, upper = upper, fn = func_obj_l_razao_inten_tau, control=list( maxit =200))
	evidencias[k] <- out$par
	evidencias_valores[k] <- out$value
}
x <- seq(N - 1)
lobj <- rep(0, (N - 1))
for (j in 1 : (N - 1) ){
  lobj[j] <- func_obj_l_razao_inten(j)
}
df <- data.frame(x, lobj)
p <- ggplot(df, aes(x = x, y = lobj, color = 'darkred')) + geom_line() + xlab(TeX('Pixel $j$')) + ylab(TeX('$l(j)$')) + guides(color=guide_legend(title=NULL)) + scale_color_discrete(labels= lapply(sprintf('$\\sigma_{hh} = %2.0f$', NULL), TeX))
print(p)
# imprime em arquivo no diretorio  ~/Data/
#dfev <- data.frame(xev, evidencias)
#names(dfev) <- NULL
#setwd("../..")
#setwd("Data")
#sink("evid_real_flevoland_hh_vh_param_razao.txt")
#print(dfev)
#sink()
#setwd("..")
#setwd("Code/Code_r")
