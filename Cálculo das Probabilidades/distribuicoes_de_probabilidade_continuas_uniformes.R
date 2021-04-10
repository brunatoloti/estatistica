#Distribuições de Probabilidade Contínuas - Uniforme

#Exemplo Uniforme
#Seja a variável aleatória contínua x a corrente medida em um fio delgado de cobre 
#em miliamperes.Considere que a faixa de x seja [0 ; 10mA] e suponha que a 
#função de densidade de probabilidade de x seja f(x) =0,10, para a mesma faixa acima.

#a) Qual é a probabilidade de a medida da corrente estar entre 5 e 10 miliamperes? 
#b) Determine a média e a variância da distribuição.

#a)
#Utilizando a função de densidade de probabilidade P(X<=10)-P(X<=5) = P(5<=X<=10) -> acumulada até 10 - acumulada até 5
punif(10,min=0,max=10)-punif(5,min=0,max=10) #min=0 e max=10, pois a x segue uma uniforme de 0 a 10

#Uniforme na "mão"
a=0
b=10
(10-5)*1/(b-a)

#b)
#Média e variância
a=0
b=10
media=(b+a)/2        #Integral de x*f(x) no intervalo [a, b], onde f(x) = 1/(b-a)
variancia=(b-a)^2/12 #(Integral de (x^2)*f(x) no intervalo [a, b]) - (Integral de x*f(x) no intervalo [a, b]),
                     #onde f(x) = 1/(b-a)
