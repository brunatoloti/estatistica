#Distribuições de Probabilidade Contínuas - Exponencial


#Exemplo Exponencial
#O tempo de espera em uma fila segue uma distribuiÃ§Ã£o exponencial. 
#Se o tempo médio esperado pelo cliente é de 10 minutos para ser atendido, qual a probabilidade:

#a) De que um cliente demore menos do que 12 minutos para ser atendido. 
#b) De que um cliente demore entre 7 e 12 minutos para ser atendido.

#a)
#Utilizando a função de distribuição acumulada P(X<12)
#Valor esperado=1/lambda => 10=1/lambda  => lambda=1/10
pexp(12,rate=1/10)

#Exponencial na "Mão"
1-exp(-1.2)  #a acumulada da exponencial é dada por: 1-e^(-lambda*x), para x >=0

#b)
#Utilizando a função de distribuição acumulada P(X<12)-P(X<7)
pexp(12,rate=1/10) - pexp(7,rate=1/10)

#Exponencial na "Mão"
1 - exp(-1.2) - (1- exp(-0.7)) 
#ou
exp(-0.7) - exp(-1.2)

