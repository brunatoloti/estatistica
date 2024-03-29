#Distribui��es de Probabilidade Discretas - Geom�trica

#Exemplo Geom�trica com segunda parametriza��o (pois n�o h� a primeira parametriza��o, que come�a em 1, no R)
#A probabilidade de ser detectada uma pe�a defeituosa em uma linha de produ��o � 2/3. 
#Se um funcion�rio deve testar as pe�as do lote at� que se detecte pela primeira vez uma pe�a defeituosa, 
#qual a probabilidade de que sejam necess�rias exatamente 8 testagens?

#Utilizando a fun��o massa de probabilidade aplicando para X=7: P(X=x) (momento anterior � detec��o - segunda parametriza��o)
dgeom(7,2/3)

#Utilizando a fun��o de distribui��o acumulada P(X<=7)-P(X<=6)= P(X=7)
pgeom(7,2/3)-pgeom(6,2/3)
