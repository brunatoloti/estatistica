install.packages("prob")
library(prob) 

#Exemplo de espaço amostral:
#Lançamento de um dado e observar qual número sairá em sua face voltada para cima.

#Rolando o dado
dado=rolldie(1, makespace = F)  #makespacte=T cria uma coluna com as probabilidades

#Selecionando apenas as faces pares ( O operador %% representa o resto da divisão)
subset(dado, X1%%2==0)


#Considerando os eventos A e B definidos a seguir:
#A: "Aparecer faces pares ao rolar o dado": {2, 4, 6}
#B: "Aparecer faces maiores que 3 ao rolar o dado": {4, 5, 6}
#Vamos calcular a união dos eventos e a intersecção  entre eles.

#Criando os eventos
A=subset(rolldie(1,makespace = F), X1%%2==0)
B=subset(rolldie(1,makespace = F), X1>3)

#União
uniao=union(A,B)
#Intersecção
interseccao=intersect(A,B)


#Considerando o evento: Obter duas caras no lançamento de 3 moedas.  
#Vamos calcular a probabilidade da ocorrência do evento (ou sejam ocorrer duas caras).

#Criando o espaço amostral para um lançamento de 3 moedas.
#H=head (cara)
#T=tail (coroa)
moedas=tosscoin(3, makespace = F)
duas_caras=moedas[c(2,3,5),] #Pegando as linhas de moedas que possuem a ocorrência de duas caras (manualmente)
#Pegando as linhas de moedas que possuem a ocorrência de duas caras de forma não manual:
require(dplyr)
moedas = moedas %>% mutate(x1 = case_when( toss1 == "H" & toss2 == "H" & toss3 == "H" ~ 0,
                                           toss1 == "H" & toss2 == "H" & toss3 == "T" ~ 1,
                                           toss1 == "H" & toss2 == "T" & toss3 == "H" ~ 1,
                                           toss1 == "T" & toss2 == "H" & toss3 == "H" ~ 1,
                                           toss1 == "H" & toss2 == "T" & toss3 == "T" ~ 0,
                                           toss1 == "T" & toss2 == "H" & toss3 == "T" ~ 0,
                                           toss1 == "T" & toss2 == "T" & toss3 == "H" ~ 0,
                                           toss1 == "T" & toss2 == "T" & toss3 == "T" ~ 0
)) 
duas_caras2 = moedas %>% filter(x1 == 1)
duas_caras2 = subset(duas_caras2, select = -c(x1))

dim(duas_caras)[1]/dim(moedas)[1] #Número de linhas de duas_caras (o que quero) dividido pelo número de linhas de moedas (o que tenho)
dim(duas_caras2)[1]/dim(moedas)[1] #Note que é igual

#Exemplo de probabilidade da união

#Uma empresa precisa analisar a propensão de compra de um certo produto para dois clientes. 
#Baseado em dados históricos da empresa, o cliente A tem propensão de compra de 30%, já o cliente B possui 28%. 
#Juntos, tem a propensão de compra de 24% . 
#Qual a probabilidade de que o mesmo seja comprado por pelo menos um dos clientes?
  
PA=0.30
PB=0.28
PAinterB=0.24
PAuniaoB=PA+PB-PAinterB

