#Distribui��es de Probabilidade Discretas - Bernoulli e Binomial

#Exemplo Bernoulli
#Suponha que X="O aluno acertar uma quest�o na prova", sendo que a prova s� tem uma quest�o, contendo certo ou errado. 
#Portanto, podemos entender que o aluno tem uma resposta favor�vel em duas poss�veis, ou seja, 50% de chance de acertar a quest�o.
pbinom(1,size=1,p=0.5)-pbinom(0,size=1,p=0.5)


#Exemplo Binomial
#Suponha que X="O aluno acertar uma quest�o na prova", sendo que a prova tem tr�s quest�es, contendo certo ou errado. 
#Portanto, podemos entender que o aluno tem uma resposta favor�vel em  duas poss�veis, 50% de chance de acertar a quest�o (para cada quest�o)
pbinom(1,size=3,p=0.5)-pbinom(0,size=3,p=0.5)


#Exemplo 2 Binomial
#Considere um exame de m�ltipla escolha com 20 quest�es e 5 alternativas pra cada pergunta. 
#Caso o aluno n�o estude e "chute" todas as respostas, qual a probabilidade de acertar 30% da prova? E qual seu n�mero esperado de acertos? 

n=20
p=0.2 #ou 1/5, que � a probabilidade de marcar a alternativa correta pra cada quest�o
#x segue uma binomial(20,1/5)
pbinom(6,size=n,p)-pbinom(5,size=n,p)

valor_esperado=n*p
valor_esperado