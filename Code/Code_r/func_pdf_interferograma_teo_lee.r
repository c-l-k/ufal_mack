# Le duas amostras de um dos arquivos em /Data/Phantom_****_0.000_1_2_*.txt
#
# Obs: (1) Trocar os nomes dos arquivos de entrada,
#      (2) trocar os nomes dos arquivos de saida,
#      (3) os arquivos de saida ficarao comentados para não alterar as figuras
rm(list = ls())
require(ggplot2)
require(latex2exp)
require(plyr)
# Programa principal
dim <- 1 / 100
x <- seq(0, 2, by = dim)
#############################################################
#sig <- sum(mat) / (dimdf)
rho  <- abs(0.8)
rho2 <- rho^2
L2 <- 2
L3 <- 3
L4 <- 4
L8 <- 8
##### realizar o plot usando o ggplot #######################
look_1 <- (4 * L2^(L2 + 1) * x^L2)/(gamma(L2) * (1 - rho2)) * besselI((2 * rho * L2 * x) / (1 - rho2), 0) * besselK((2 * L2 * x) / (1 - rho2) , L2 - 1)  
look_2 <- (4 * L3^(L3 + 1) * x^L3)/(gamma(L3) * (1 - rho2)) * besselI((2 * rho * L3 * x) / (1 - rho2), 0) * besselK((2 * L3 * x) / (1 - rho2) , L3 - 1)  
look_3 <- (4 * L4^(L4 + 1) * x^L4)/(gamma(L4) * (1 - rho2)) * besselI((2 * rho * L4 * x) / (1 - rho2), 0) * besselK((2 * L4 * x) / (1 - rho2) , L4 - 1)  
look_4 <- (4 * L8^(L8 + 1) * x^L8)/(gamma(L8) * (1 - rho2)) * besselI((2 * rho * L8 * x) / (1 - rho2), 0) * besselK((2 * L8 * x) / (1 - rho2) , L8 - 1)  
##### realizar o plot usando o ggplot #######################
df <- data.frame(x, look_1, look_2, look_3, look_4, fix.empty.names = TRUE)
#data_look <- data.frame(x, look_1, look_2, look_3,fix.empty.names = TRUE)
pp <- ggplot(df, aes(x = x, color = Visadas) )                 +
       # geom_histogram(position = 'stack', stat = 'bin', binwidth = 0.0005, alpha = 0.7, color = "lightblue", fill = "darkblue")                 +
     	geom_line(aes(y = look_1, col= "Visada 2"), size = 1)    +
     	geom_line(aes(y = look_2, col= "Visada 3"), size = 1)    +
     	geom_line(aes(y = look_3, col= "Visada 4"), size = 1)    +
     	geom_line(aes(y = look_4, col= "Visada 8"), size = 1)    +
       	xlab(TeX('Interferograma normalizado'))                +
      	ylab(TeX('Função densidade de probabilidade (PDF)'))     +
       	ggtitle(TeX('Distribuição interferograma multiplas visadas'))+
       	coord_cartesian(ylim=c(0, 1.3))
# escrita no diretorio /Text/Dissertacao/figura
setwd("../..")
setwd("Text/Dissertacao/figuras")
ggsave("dist_interferograma_multi_visadas.pdf")
setwd("../../..")
setwd("Code/Code_r")
# retornou ao diretorio /Code/Code_r
print(pp)