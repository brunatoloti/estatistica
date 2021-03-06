#Vari�veis qualitativas ordinais
#Exemplos: Classe social, grau de instru��o e est�gio da doen�a. 


classe_social=c("A","B","C","D","E")
grau_instrucao=c("Ensino fundamental","Ensino m�dio","Ensino superior")
estagio_doenca=c("Est�gio inicial","Est�gio intermedi�rio","Est�gio terminal")
meses=c("Janeiro","Fevereiro","Mar�o")
ranking=c("Primeiro","Segundo","Terceiro")

#Criando amostras aleat�rias simples com reposi��o
a_classe_social=sample(classe_social,size=100, replace=TRUE)
a_grau_intrucao=sample(grau_instrucao,size=100, replace=TRUE)
a_estagio_doenca=sample(estagio_doenca,size=100, replace=TRUE)
a_meses=sample(meses,size=100, replace=TRUE)
a_ranking=sample(ranking,size=100, replace=TRUE)

#Criando um dataframe com essas amostras aleat�rias criadas
variaveis_categoricas_ordinais=data.frame(a_classe_social,
                                          a_grau_intrucao,
                                          a_estagio_doenca,
                                          a_meses,a_ranking)
variaveis_categoricas_ordinais
View(variaveis_categoricas_ordinais)

#Gr�fico de pizza de frequ�ncia simples

#Criando um dataframe com as frequ�ncias simples (frequ�ncias calculadas com table)
df_pizza_tab=table(variaveis_categoricas_ordinais$a_classe_social)
df_pizza=as.data.frame(df_pizza_tab) #Passando para dataframe
df_pizza

#Criando o gr�fico em si
pie(df_pizza$Freq,
    labels=paste(df_pizza$Var1,df_pizza$Freq),
     main="Gr�fico de pizza do n�mero de pessoas por classe social")

#Gr�fico de pizza de frequ�ncia relativa

#Criando um dataframe com as frequ�ncias relativas
#Frequ�ncias calculadas com prop.table - propor��o das frequ�ncias simples
df_pizza_percent=prop.table(df_pizza_tab)
df_pizza_percent=as.data.frame(df_pizza_percent)
df_pizza_percent

#Criando o gr�fico em si
pie(df_pizza_percent$Freq,
    labels=paste(df_pizza_percent$Var1,df_pizza_percent$Freq*100,"%"),
     main="Gr�fico de pizza - Frequ�ncia relativa classe social (%)")

#Usando a biblioteca plotly para criar um gr�fico de pizza
#Aqui, dando a frequ�ncia simples, ele j� nos d� a frequ�ncia relativa.
#Temos aqui, al�m de um gr�fico iterativo, as frequ�ncias simples e relativa
grafico_pizza_iterativo = plot_ly(df_pizza, 
             labels = ~Var1, 
             values = ~Freq, 
             type = 'pie') %>%
             layout(title = 'Frequ�ncia Relativa da Classe Social (%) ')

grafico_pizza_iterativo


#ggplot geral
#Elementos de um gr�fico ggplot:

#1. Base de dados que ser� utilizada
#2. Geometria que ser� utilizada (Tipo de gr�fico)
#3. Aesthetic mapping (A parte est�tica do gr�fico, eixos, cores, tamanhos, textos)- Depende da geometria (tipo de gr�fico) escolhido
#4. Escala (formato, unidade de medida)
#5. R�tulos, t�tulos, legendas, etc..

#Gr�fico de Colunas ou Barras Verticais
grafico_coluna=ggplot(variaveis_categoricas_ordinais,aes(x=a_classe_social)) + 
  geom_bar(position = "dodge") +
  ggtitle("N�mero de pessoas por classe social")+
  xlab("Classe social") +
  ylab("N�mero de pessoas (Frequ�ncia Simples)")

ggplotly(grafico_coluna)

#Gr�fico de Colunas ou Barras Verticais com frequ�ncia relativa
grafico_coluna_percent=ggplot(variaveis_categoricas_ordinais,aes(x=a_classe_social)) + 
  geom_bar(aes(y = (..count..)/sum(..count..))) +
  ggtitle("N�mero de pessoas por classe social") +
  scale_y_continuous(labels=percent) +
  xlab("Classe social") +
  ylab("Propor��o de pessoas % (Frequ�ncia Relativa)")

ggplotly(grafico_coluna_percent)

#Gr�fico de Colunas ou Barras Verticais Empilhadas com frequ�ncia relativa por grau de instru��o e classe social
grafico_coluna_empilhada=ggplot(variaveis_categoricas_ordinais,aes(x=a_classe_social,fill=a_grau_intrucao)) + 
  geom_bar(position = 'fill',show.legend = FALSE) +
  ggtitle("N�mero de pessoas por classe social")+
  scale_y_continuous(labels=percent) +
  xlab("Classe social") +
  ylab("Propor��o de pessoas % (Frequ�ncia Relativa)")

ggplotly(grafico_coluna_empilhada)

#Gr�fico de Colunas ou Barras Verticais com frequ�ncia relativa por grau de instru��o
grafico_coluna_percent_por_grau_instrucao=ggplot(variaveis_categoricas_ordinais,aes(x=a_classe_social,fill=a_grau_intrucao)) + 
  geom_bar(aes(y = (..count..)/sum(..count..)),show.legend = FALSE) +
  ggtitle("N�mero de pessoas por classe social") +
  scale_y_continuous(labels=percent) +
  xlab("Classe social") +
  ylab("N�mero de pessoas (Frequ�ncia simples)") +
  facet_grid(~a_grau_intrucao) #Um gr�fico para cada grau de instru��o

ggplotly(grafico_coluna_percent_por_grau_instrucao)

#Colocando todos os gr�ficos em um gr�fico s�
grid.arrange(grafico_coluna,
             grafico_coluna_percent, 
             grafico_coluna_percent_por_grau_instrucao,
             grafico_coluna_empilhada, 
             nrow=2,ncol=2 )


