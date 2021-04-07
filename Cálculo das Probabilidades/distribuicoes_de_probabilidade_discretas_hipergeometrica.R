#Distribuições de Probabilidade Discretas - Hipergeométrica

#Exemplo Hipergeométrica
#Em uma eleição, suponha que 300 dos 1000 habitantes de um município são
#eleitores de um candidato A. Toma-se uma amostra de 10 eleitores.
#Qual a probabilidade de que exatamente 5 deles pretendam votar no candidato A?

#Portanto, temos:
# 1) Uma população de 1000, ou seja, N=1000
# 2) Dentre esses 1000, 300 querem votar no candidato A, ou seja, r=300
# 3) Dessa forma, N-r=1000-300=700 não querem votar em A
# 4) Um grupo de 10 elementos é escolhido ao acaso, ou seja, n=10
# 5) Queremos calcular a probabilidade de que 5 elementos desse grupo queiram votar em A

#Utilizando a função massa de probabilidade aplicando para X=5: P(X=5)
#dhyper(x, r, N-r, n)
dhyper(5, 300, 700, 10)

#Utilizando a função de distribuição acumulada P(X<=5) - P(X<=4) = P(X=5)
#phyper(x, r, N-r, n) - phyper(x-1, r, N-r, n)
phyper(5, 300, 700, 10) - phyper(4, 300, 700, 10)

#Fazendo manualmente
choose(300,5)*choose(700,5)/choose(1000,10)
