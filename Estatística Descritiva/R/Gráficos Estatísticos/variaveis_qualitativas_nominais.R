#Uma boa forma de iniciar uma análise descritiva adequada é verificar os tipos de variáveis disponíveis.
#

#Variáveis qualitativas nominais
#Exemplos: Sexo, cor dos olhos, fumante/não fumante, doente/sadio e dicotômicas(casado ou solteiro)

install.packages(c("scales","tidyverse"))
install.packages("plotly")
require(ggplot2)
require(dplyr)
require(scales)
require(plotly)
require(gridExtra)

sexo=c("M","F")
cor=c("Preto","Castanho","Azul","Verde")
cigarro=c("Fumante","Não Fumante")
doente=c("Doente","Sadio")
estado_civil=c("Solteiro(a)","Casado(a)")

#Criando amostras aleatórias simples com reposição
a_sexo=sample(sexo,size=100, replace=TRUE)
a_cor_olhos=sample(cor,size=100, replace=TRUE)
a_fumante=sample(cigarro,size=100, replace=TRUE)
a_doente=sample(doente,size=100, replace=TRUE)
a_estado_civil=sample(estado_civil,size=100, replace=TRUE)
a_dummy_estado_civil=ifelse(a_estado_civil=="Solteiro(a)","1","0")

#Criando um dataframe com essas amostras aleatórias criadas
variaveis_categoricas_nominais=data.frame(a_sexo,
                                          a_cor_olhos,
                                          a_fumante,
                                          a_doente,
                                          a_estado_civil,
                                          a_dummy_estado_civil)
variaveis_categoricas_nominais

View(variaveis_categoricas_nominais)

#ggplot geral
#Elementos de um gráfico ggplot:

#1. Base de dados que será utilizada
#2. Geometria que será utilizada (Tipo de gráfico)
#3. Aesthetic mapping (A parte estética do gráfico, eixos, cores, tamanhos, textos)- Depende da geometria (tipo de gráfico) escolhido
#4. Escala (formato, unidade de medida)
#5. Rótulos, títulos, legendas, etc..

#Gráfico de Colunas ou Barras Verticais
grafico_coluna_geral=ggplot(variaveis_categoricas_nominais,aes(a_cor_olhos)) + 
  geom_bar(position = "dodge",fill="red") +
  ggtitle("Número de alunos por cor dos olhos")+
  xlab("Cor dos olhos") +
  ylab("Frequência simples (Quantidade de alunos)") 
  
ggplotly(grafico_coluna_geral)

#Gráfico de Colunas ou Barras Verticais por sexo
grafico_coluna=ggplot(variaveis_categoricas_nominais,aes(a_cor_olhos,fill=a_sexo)) + 
               geom_bar(position = "dodge") +
               ggtitle("Número de alunos por cor dos olhos e sexo")+
               labs(fill="Sexo")+
               xlab("Cor dos olhos") +
               ylab("Frequência simples (Quantidade de alunos)") 
               
ggplotly(grafico_coluna)

#Gráfico de Colunas ou Barras Verticais (%)
grafico_coluna_percent=ggplot(variaveis_categoricas_nominais,aes(a_cor_olhos,fill=a_sexo)) + 
  geom_bar(position = "dodge",aes(y = (..count..)/sum(..count..))) +
  ggtitle("Número de alunos por cor dos olhos e sexo (%)")+
  scale_y_continuous(labels=percent)+
  labs(fill="Sexo")+
  xlab("Cor dos olhos") +
  ylab("Frequência simples (Quantidade de alunos)")

ggplotly(grafico_coluna_percent)

#Gráfico de Colunas ou Barras Verticais Empilhadas (%)
grafico_colunas_empilhadas=ggplot(variaveis_categoricas_nominais,aes(a_cor_olhos,fill=a_sexo)) + 
  geom_bar(position = 'fill') +
  ggtitle("Número de alunos por cor dos olhos e sexo")+
  scale_y_continuous(labels=percent) +
  labs(fill="Sexo")+
  xlab("Cor dos olhos") +
  ylab("Frequência simples (Quantidade de alunos)")

ggplotly(grafico_colunas_empilhadas)

#Gráfico de Barras Horizontais
grafico_barras_horizontais=grafico_coluna + coord_flip() 

ggplotly(grafico_barras_horizontais)

#Gráfico de Barras Horizontais separado por Sexo
grafico_barras_horizontais_por_sexo=grafico_coluna + coord_flip() + facet_grid(~a_sexo)

ggplotly(grafico_barras_horizontais_por_sexo)

#Colocando todos os gráficos em um gráfico só
grid.arrange(grafico_coluna_geral,
             grafico_coluna,
             grafico_coluna_percent,
             grafico_barras_horizontais,
             grafico_barras_horizontais_por_sexo,
             grafico_colunas_empilhadas, nrow=3,ncol=2)

