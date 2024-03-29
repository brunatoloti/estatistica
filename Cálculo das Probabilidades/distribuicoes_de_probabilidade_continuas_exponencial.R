#Distribui��es de Probabilidade Cont�nuas - Exponencial


#Exemplo Exponencial
#O tempo de espera em uma fila segue uma distribuição exponencial. 
#Se o tempo m�dio esperado pelo cliente � de 10 minutos para ser atendido, qual a probabilidade:

#a) De que um cliente demore menos do que 12 minutos para ser atendido. 
#b) De que um cliente demore entre 7 e 12 minutos para ser atendido.

#a)
#Utilizando a fun��o de distribui��o acumulada P(X<12)
#Valor esperado=1/lambda => 10=1/lambda  => lambda=1/10
pexp(12,rate=1/10)

#Exponencial na "M�o"
1-exp(-1.2)  #a acumulada da exponencial � dada por: 1-e^(-lambda*x), para x >=0

#b)
#Utilizando a fun��o de distribui��o acumulada P(X<12)-P(X<7)
pexp(12,rate=1/10) - pexp(7,rate=1/10)

#Exponencial na "M�o"
1 - exp(-1.2) - (1- exp(-0.7)) 
#ou
exp(-0.7) - exp(-1.2)

