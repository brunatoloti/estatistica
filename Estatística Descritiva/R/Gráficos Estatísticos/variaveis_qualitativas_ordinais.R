#Variáveis qualitativas ordinais
#Exemplos: Classe social, grau de instrução e estágio da doença. 


classe_social=c("A","B","C","D","E")
grau_instrucao=c("Ensino fundamental","Ensino médio","Ensino superior")
estagio_doenca=c("Estágio inicial","Estágio intermediário","Estágio terminal")
meses=c("Janeiro","Fevereiro","Março")
ranking=c("Primeiro","Segundo","Terceiro")

#Criando amostras aleatórias simples com reposição
a_classe_social=sample(classe_social,size=100, replace=TRUE)
a_grau_intrucao=sample(grau_instrucao,size=100, replace=TRUE)
a_estagio_doenca=sample(estagio_doenca,size=100, replace=TRUE)
a_meses=sample(meses,size=100, replace=TRUE)
a_ranking=sample(ranking,size=100, replace=TRUE)

#Criando um dataframe com essas amostras aleatórias criadas
variaveis_categoricas_ordinais=data.frame(a_classe_social,
                                          a_grau_intrucao,
                                          a_estagio_doenca,
                                          a_meses,a_ranking)
variaveis_categoricas_ordinais
View(variaveis_categoricas_ordinais)

#Gráfico de pizza de frequência simples

#Criando um dataframe com as frequências simples (frequências calculadas com table)
df_pizza_tab=table(variaveis_categoricas_ordinais$a_classe_social)
df_pizza=as.data.frame(df_pizza_tab) #Passando para dataframe
df_pizza

#Criando o gráfico em si
pie(df_pizza$Freq,
    labels=paste(df_pizza$Var1,df_pizza$Freq),
     main="Gráfico de pizza do número de pessoas por classe social")

#Gráfico de pizza de frequência relativa

#Criando um dataframe com as frequências relativas
#Frequências calculadas com prop.table - proporção das frequências simples
df_pizza_percent=prop.table(df_pizza_tab)
df_pizza_percent=as.data.frame(df_pizza_percent)
df_pizza_percent

#Criando o gráfico em si
pie(df_pizza_percent$Freq,
    labels=paste(df_pizza_percent$Var1,df_pizza_percent$Freq*100,"%"),
     main="Gráfico de pizza - Frequência relativa classe social (%)")

#Usando a biblioteca plotly para criar um gráfico de pizza
#Aqui, dando a frequência simples, ele já nos dá a frequência relativa.
#Temos aqui, além de um gráfico iterativo, as frequências simples e relativa
grafico_pizza_iterativo = plot_ly(df_pizza, 
             labels = ~Var1, 
             values = ~Freq, 
             type = 'pie') %>%
             layout(title = 'Frequência Relativa da Classe Social (%) ')

grafico_pizza_iterativo


#ggplot geral
#Elementos de um gráfico ggplot:

#1. Base de dados que será utilizada
#2. Geometria que será utilizada (Tipo de gráfico)
#3. Aesthetic mapping (A parte estética do gráfico, eixos, cores, tamanhos, textos)- Depende da geometria (tipo de gráfico) escolhido
#4. Escala (formato, unidade de medida)
#5. Rótulos, títulos, legendas, etc..

#Gráfico de Colunas ou Barras Verticais
grafico_coluna=ggplot(variaveis_categoricas_ordinais,aes(x=a_classe_social)) + 
  geom_bar(position = "dodge") +
  ggtitle("Número de pessoas por classe social")+
  xlab("Classe social") +
  ylab("Número de pessoas (Frequência Simples)")

ggplotly(grafico_coluna)

#Gráfico de Colunas ou Barras Verticais com frequência relativa
grafico_coluna_percent=ggplot(variaveis_categoricas_ordinais,aes(x=a_classe_social)) + 
  geom_bar(aes(y = (..count..)/sum(..count..))) +
  ggtitle("Número de pessoas por classe social") +
  scale_y_continuous(labels=percent) +
  xlab("Classe social") +
  ylab("Proporção de pessoas % (Frequência Relativa)")

ggplotly(grafico_coluna_percent)

#Gráfico de Colunas ou Barras Verticais Empilhadas com frequência relativa por grau de instrução e classe social
grafico_coluna_empilhada=ggplot(variaveis_categoricas_ordinais,aes(x=a_classe_social,fill=a_grau_intrucao)) + 
  geom_bar(position = 'fill',show.legend = FALSE) +
  ggtitle("Número de pessoas por classe social")+
  scale_y_continuous(labels=percent) +
  xlab("Classe social") +
  ylab("Proporção de pessoas % (Frequência Relativa)")

ggplotly(grafico_coluna_empilhada)

#Gráfico de Colunas ou Barras Verticais com frequência relativa por grau de instrução
grafico_coluna_percent_por_grau_instrucao=ggplot(variaveis_categoricas_ordinais,aes(x=a_classe_social,fill=a_grau_intrucao)) + 
  geom_bar(aes(y = (..count..)/sum(..count..)),show.legend = FALSE) +
  ggtitle("Número de pessoas por classe social") +
  scale_y_continuous(labels=percent) +
  xlab("Classe social") +
  ylab("Número de pessoas (Frequência simples)") +
  facet_grid(~a_grau_intrucao) #Um gráfico para cada grau de instrução

ggplotly(grafico_coluna_percent_por_grau_instrucao)

#Colocando todos os gráficos em um gráfico só
grid.arrange(grafico_coluna,
             grafico_coluna_percent, 
             grafico_coluna_percent_por_grau_instrucao,
             grafico_coluna_empilhada, 
             nrow=2,ncol=2 )


