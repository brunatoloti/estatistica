#Distribui��es de Probabilidade Discretas - Hipergeom�trica

#Exemplo Hipergeom�trica
#Em uma elei��o, suponha que 300 dos 1000 habitantes de um munic�pio s�o
#eleitores de um candidato A. Toma-se uma amostra de 10 eleitores.
#Qual a probabilidade de que exatamente 5 deles pretendam votar no candidato A?

#Portanto, temos:
# 1) Uma popula��o de 1000, ou seja, N=1000
# 2) Dentre esses 1000, 300 querem votar no candidato A, ou seja, r=300
# 3) Dessa forma, N-r=1000-300=700 n�o querem votar em A
# 4) Um grupo de 10 elementos � escolhido ao acaso, ou seja, n=10
# 5) Queremos calcular a probabilidade de que 5 elementos desse grupo queiram votar em A

#Utilizando a fun��o massa de probabilidade aplicando para X=5: P(X=5)
#dhyper(x, r, N-r, n)
dhyper(5, 300, 700, 10)

#Utilizando a fun��o de distribui��o acumulada P(X<=5) - P(X<=4) = P(X=5)
#phyper(x, r, N-r, n) - phyper(x-1, r, N-r, n)
phyper(5, 300, 700, 10) - phyper(4, 300, 700, 10)

#Fazendo manualmente
choose(300,5)*choose(700,5)/choose(1000,10)
