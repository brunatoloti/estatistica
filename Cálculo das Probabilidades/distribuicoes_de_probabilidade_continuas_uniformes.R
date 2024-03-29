#Distribui��es de Probabilidade Cont�nuas - Uniforme

#Exemplo Uniforme
#Seja a vari�vel aleat�ria cont�nua x a corrente medida em um fio delgado de cobre 
#em miliamperes.Considere que a faixa de x seja [0 ; 10mA] e suponha que a 
#fun��o de densidade de probabilidade de x seja f(x) =0,10, para a mesma faixa acima.

#a) Qual � a probabilidade de a medida da corrente estar entre 5 e 10 miliamperes? 
#b) Determine a m�dia e a vari�ncia da distribui��o.

#a)
#Utilizando a fun��o de densidade de probabilidade P(X<=10)-P(X<=5) = P(5<=X<=10) -> acumulada at� 10 - acumulada at� 5
punif(10,min=0,max=10)-punif(5,min=0,max=10) #min=0 e max=10, pois a x segue uma uniforme de 0 a 10

#Uniforme na "m�o"
a=0
b=10
(10-5)*1/(b-a)

#b)
#M�dia e vari�ncia
a=0
b=10
media=(b+a)/2        #Integral de x*f(x) no intervalo [a, b], onde f(x) = 1/(b-a)
variancia=(b-a)^2/12 #(Integral de (x^2)*f(x) no intervalo [a, b]) - (Integral de x*f(x) no intervalo [a, b]),
                     #onde f(x) = 1/(b-a)
