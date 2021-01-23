install.packages("Hmisc")
install.packages("dplyr")
require(Hmisc)
require(dplyr)

#Primeira forma de criar o vetor
idade=c(10,10,10,10,30,30,30,30,30,30,30,30,50,50,50,50,70,70,70,90)

#Segunda forma de criar o vetor
idade=c(rep(10,4),rep(30,8),rep(50,4),rep(70,3),90)

#Calculando frequência simples
frequencia_simples=table(idade)

#Criando dataframe
dados_simples=data.frame(frequencia_simples)

# Calculando frequência acumulada
frequencia_acumulada=cumsum(frequencia_simples)

#Adicionando coluna de frequência acumulada ao dataframe 
dados_simples$frequencia_acumulada=frequencia_acumulada

#Calculando frequência relativa simples
frequencia_relativa_simples=frequencia_simples/sum(frequencia_simples)

#Adicionando coluna de frequência relativa simples ao dataframe
dados_simples$frequencia_relativa_simples=frequencia_relativa_simples

#Calculando frequência relativa acumulada
frequencia_relativa_acumulada=cumsum(frequencia_relativa_simples)

#Adicionando coluna de frequência relativa acumulada ao dataframe
dados_simples$frequencia_relativa_acumulada=frequencia_relativa_acumulada

#Obtendo automaticamente a frequência simples e relativa simples
describe(idade)


#Criando o dataframe com o dplyr e ótica tidyverse

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
