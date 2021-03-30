#Distribuições de Probabilidade Discretas - Poisson

#Exemplo Poisson
#O número de acidentes que acontecem na ponte Rio Niterói segue uma 
#distribuição de Poisson com média de 3 por hora.

#a) Calcule a probabilidade de 2 acidentes em uma hora.
#b) Calcule a probabilidade de pelo menos 2 acidentes em 2 horas.

#a)
#Como a taxa solicitada está em 1 hora, manteremos o nosso lambda
lambda=3

#Utilizando a função massa de probabilidade aplicado para X=2: P(X=2)
dpois(2,lambda)

#Utilizando a função de distribuição acumulada P(X<=2)-P(X<=1)= P(X=2)
ppois(2,lambda)-ppois(1,lambda)

#Na "mão"
(3^2)*exp(-3)/factorial(2)


#b)
#Como o a taxa solicitada está em 2 horas, ajustaremos o lambda proporcionalmente para 6.
lambda=6

#Calculando o complementar da probabilidade solicitada ou seja: 
      #1 - P(X<=1) = 1 - (P(X=0) + P(X=1)) = 1 - P(X<2) = P(X>=2)
1 - ppois(1,lambda)

#Na "mão"
1 - (exp(-6)+6*exp(-6))
