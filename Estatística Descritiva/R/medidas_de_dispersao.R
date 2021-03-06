#Dataframe
iris
View(iris)

#Amostra 0
a0=iris$Sepal.Length
length(a0)

#Amplitude amostral (medida mais simples de dispers�o -> M�ximo - M�nimo)
h0= diff(range(a0)) #range nos d� o valor m�ximo e o m�nimo; diff nos d� a diferen�a dos valores retornados por range

#Vari�ncia amostral
var0=var(a0)

#Desvio padr�o amostral
sd0=sd(a0)
#Ou, podemos fazer
sqrt(var0)

#Coeficiente de varia��o amostral
cv0=sd(a0)/mean(a0)*100

#Amostra 1
a1=iris$Petal.Length

#Amplitude amostral
h1= diff(range(a1))

#Vari�ncia amostral
var1=var(a1)

#Desvio padr�o amostral
sd1=sd(a1)

#Coeficiente de varia��o amostral
cv1=sd(a1)/mean(a1)*100

#Lembrando que, se o coeficiente de varia��o amostral for:
# < 25%, os dados s�o mais homog�neos, ou seja, variam menos em rela��o a m�dia
# > 25%, os dados s�o mais heterog�neos, ou seja, variam mais em rela��o a m�dia

#Compara��o
c(h0,h1)
c(var0,var1)
c(sd0,sd1)
c(cv0,cv1)
c(mean(a0),mean(a1))

# Compara��o gr�fica
plot(a0)
abline(h=mean(a0)) #Plotando uma reta na m�dia

plot(a1)
abline(h=mean(a1)) #Plotando uma reta na m�dia


     