#Distribuições de Probabilidade Discretas - Bernoulli e Binomial

#Exemplo Bernoulli
#Suponha que X="O aluno acertar uma questão na prova", sendo que a prova só tem uma questão, contendo certo ou errado. 
#Portanto, podemos entender que o aluno tem uma resposta favorável em duas possíveis, ou seja, 50% de chance de acertar a questão.
pbinom(1,size=1,p=0.5)-pbinom(0,size=1,p=0.5)


#Exemplo Binomial
#Suponha que X="O aluno acertar uma questão na prova", sendo que a prova tem três questões, contendo certo ou errado. 
#Portanto, podemos entender que o aluno tem uma resposta favorável em  duas possíveis, 50% de chance de acertar a questão (para cada questão)
pbinom(1,size=3,p=0.5)-pbinom(0,size=3,p=0.5)


#Exemplo 2 Binomial
#Considere um exame de múltipla escolha com 20 questões e 5 alternativas pra cada pergunta. 
#Caso o aluno não estude e "chute" todas as respostas, qual a probabilidade de acertar 30% da prova? E qual seu número esperado de acertos? 

n=20
p=0.2 #ou 1/5, que é a probabilidade de marcar a alternativa correta pra cada questão
#x segue uma binomial(20,1/5)
pbinom(6,size=n,p)-pbinom(5,size=n,p)

valor_esperado=n*p
valor_esperado