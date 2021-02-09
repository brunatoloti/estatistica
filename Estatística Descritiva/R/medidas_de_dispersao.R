#Dataframe
iris
View(iris)

#Amostra 0
a0=iris$Sepal.Length
length(a0)

#Amplitude amostral (medida mais simples de dispersão -> Máximo - Mínimo)
h0= diff(range(a0)) #range nos dá o valor máximo e o mínimo; diff nos dá a diferença dos valores retornados por range

#Variância amostral
var0=var(a0)

#Desvio padrão amostral
sd0=sd(a0)
#Ou, podemos fazer
sqrt(var0)

#Coeficiente de variação amostral
cv0=sd(a0)/mean(a0)*100

#Amostra 1
a1=iris$Petal.Length

#Amplitude amostral
h1= diff(range(a1))

#Variância amostral
var1=var(a1)

#Desvio padrão amostral
sd1=sd(a1)

#Coeficiente de variação amostral
cv1=sd(a1)/mean(a1)*100

#Lembrando que, se o coeficiente de variação amostral for:
# < 25%, os dados são mais homogêneos, ou seja, variam menos em relação a média
# > 25%, os dados são mais heterogêneos, ou seja, variam mais em relação a média

#Comparação
c(h0,h1)
c(var0,var1)
c(sd0,sd1)
c(cv0,cv1)
c(mean(a0),mean(a1))

# Comparação gráfica
plot(a0)
abline(h=mean(a0)) #Plotando uma reta na média

plot(a1)
abline(h=mean(a1)) #Plotando uma reta na média


     