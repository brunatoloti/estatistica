install.packages("e1071")
require(e1071)

#Declarando a amostra 0
c0=c(2,3,6,9)

#Calculando a média
mean(c0)

#Calculando a mediana
median(c0)

#Calculando a moda 
as.numeric(names(table(c0))[table(c0) == max(table(c0))])
#Amodal

#Resumo dos resultados 
summary(c0)

#Fazendo gráficos para termos uma visualização melhor da distribuição
par(mfrow=c(2,2))
barplot(c0)
hist(c0) #Frequência simples
hist(c0,probability = T)
lines(density(c0))
skewness(c0) #Assimetria
kurtosis(c0) 

#Pelo R, temos que
#k>0, Leptocúrtica
#k=0, Mesocúrtica
#k<0, Platicúrtica


#Declarando a amostra 1
c1=c(7,1,5,2,3,1,6)

#Calculando a média
mean(c1)

#Calculando a mediana
median(c1)

#Calculando a moda
as.numeric(names(table(c1))[table(c1) == max(table(c1))])

#Fazendo gráficos para termos uma visualização melhor da distribuição
barplot(c1)
hist(c1)
hist(c1,probability = T)
lines(density(c1))
skewness(c1)
kurtosis(c1)

#Resumo dos resultados
summary(c1)


#Declarando a amostra 2
c2=c(1,2,3,8,7,8,9)

#Calculando a média
mean(c2)

#Calculando a mediana
median(c2)

#Calculando a moda
as.numeric(names(table(c2))[table(c2) == max(table(c2))])

#Fazendo gráficos para termos uma visualização melhor da distribuição
barplot(c2)
hist(c2)
hist(c2,probability = T)
lines(density(c2))
skewness(c2)
kurtosis(c2)

#Resumo dos resultados
summary(c2)
