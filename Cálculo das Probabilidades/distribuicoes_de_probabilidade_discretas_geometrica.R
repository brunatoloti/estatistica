#Distribuições de Probabilidade Discretas - Geométrica

#Exemplo Geométrica com segunda parametrização (pois não há a primeira parametrização, que começa em 1, no R)
#A probabilidade de ser detectada uma peça defeituosa em uma linha de produção é 2/3. 
#Se um funcionário deve testar as peças do lote até que se detecte pela primeira vez uma peça defeituosa, 
#qual a probabilidade de que sejam necessárias exatamente 8 testagens?

#Utilizando a função massa de probabilidade aplicando para X=7: P(X=x) (momento anterior à detecção - segunda parametrização)
dgeom(7,2/3)

#Utilizando a função de distribuição acumulada P(X<=7)-P(X<=6)= P(X=7)
pgeom(7,2/3)-pgeom(6,2/3)
