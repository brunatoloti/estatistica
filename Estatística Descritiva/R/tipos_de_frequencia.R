install.packages("Hmisc")
install.packages("dplyr")
require(Hmisc)
require(dplyr)

#Primeira forma de criar o vetor
idade=c(10,10,10,10,30,30,30,30,30,30,30,30,50,50,50,50,70,70,70,90)

#Segunda forma de criar o vetor
idade=c(rep(10,4),rep(30,8),rep(50,4),rep(70,3),90)

#Calculando frequ�ncia simples
frequencia_simples=table(idade)

#Criando dataframe
dados_simples=data.frame(frequencia_simples)

# Calculando frequ�ncia acumulada
frequencia_acumulada=cumsum(frequencia_simples)

#Adicionando coluna de frequ�ncia acumulada ao dataframe 
dados_simples$frequencia_acumulada=frequencia_acumulada

#Calculando frequ�ncia relativa simples
frequencia_relativa_simples=frequencia_simples/sum(frequencia_simples)

#Adicionando coluna de frequ�ncia relativa simples ao dataframe
dados_simples$frequencia_relativa_simples=frequencia_relativa_simples

#Calculando frequ�ncia relativa acumulada
frequencia_relativa_acumulada=cumsum(frequencia_relativa_simples)

#Adicionando coluna de frequ�ncia relativa acumulada ao dataframe
dados_simples$frequencia_relativa_acumulada=frequencia_relativa_acumulada

#Obtendo automaticamente a frequ�ncia simples e relativa simples
describe(idade)


#Criando o dataframe com o dplyr e �tica tidyverse

#base FOG
#f(g(x))
head(dados_simples)

#tidyverse GOF
#g(f(x))
dados_simples %>% head()

dados_simples_tidy = dados_simples %>% 
                      mutate(frequencia_acumulada = cumsum(Freq),
                             frequencia_relativa_simples = Freq/sum(Freq),
                             frequencia_relativa_acumulada = cumsum(frequencia_relativa_simples))
