#Uma boa forma de iniciar uma an�lise descritiva adequada � verificar os tipos de vari�veis dispon�veis.
#

#Vari�veis qualitativas nominais
#Exemplos: Sexo, cor dos olhos, fumante/n�o fumante, doente/sadio e dicot�micas(casado ou solteiro)

install.packages(c("scales","tidyverse"))
install.packages("plotly")
require(ggplot2)
require(dplyr)
require(scales)
require(plotly)
require(gridExtra)

sexo=c("M","F")
cor=c("Preto","Castanho","Azul","Verde")
cigarro=c("Fumante","N�o Fumante")
doente=c("Doente","Sadio")
estado_civil=c("Solteiro(a)","Casado(a)")

#Criando amostras aleat�rias simples com reposi��o
a_sexo=sample(sexo,size=100, replace=TRUE)
a_cor_olhos=sample(cor,size=100, replace=TRUE)
a_fumante=sample(cigarro,size=100, replace=TRUE)
a_doente=sample(doente,size=100, replace=TRUE)
a_estado_civil=sample(estado_civil,size=100, replace=TRUE)
a_dummy_estado_civil=ifelse(a_estado_civil=="Solteiro(a)","1","0")

#Criando um dataframe com essas amostras aleat�rias criadas
variaveis_categoricas_nominais=data.frame(a_sexo,
                                          a_cor_olhos,
                                          a_fumante,
                                          a_doente,
                                          a_estado_civil,
                                          a_dummy_estado_civil)
variaveis_categoricas_nominais

View(variaveis_categoricas_nominais)

#ggplot geral
#Elementos de um gr�fico ggplot:

#1. Base de dados que ser� utilizada
#2. Geometria que ser� utilizada (Tipo de gr�fico)
#3. Aesthetic mapping (A parte est�tica do gr�fico, eixos, cores, tamanhos, textos)- Depende da geometria (tipo de gr�fico) escolhido
#4. Escala (formato, unidade de medida)
#5. R�tulos, t�tulos, legendas, etc..

#Gr�fico de Colunas ou Barras Verticais
grafico_coluna_geral=ggplot(variaveis_categoricas_nominais,aes(a_cor_olhos)) + 
  geom_bar(position = "dodge",fill="red") +
  ggtitle("N�mero de alunos por cor dos olhos")+
  xlab("Cor dos olhos") +
  ylab("Frequ�ncia simples (Quantidade de alunos)") 
  
ggplotly(grafico_coluna_geral)

#Gr�fico de Colunas ou Barras Verticais por sexo
grafico_coluna=ggplot(variaveis_categoricas_nominais,aes(a_cor_olhos,fill=a_sexo)) + 
               geom_bar(position = "dodge") +
               ggtitle("N�mero de alunos por cor dos olhos e sexo")+
               labs(fill="Sexo")+
               xlab("Cor dos olhos") +
               ylab("Frequ�ncia simples (Quantidade de alunos)") 
               
ggplotly(grafico_coluna)

#Gr�fico de Colunas ou Barras Verticais (%)
grafico_coluna_percent=ggplot(variaveis_categoricas_nominais,aes(a_cor_olhos,fill=a_sexo)) + 
  geom_bar(position = "dodge",aes(y = (..count..)/sum(..count..))) +
  ggtitle("N�mero de alunos por cor dos olhos e sexo (%)")+
  scale_y_continuous(labels=percent)+
  labs(fill="Sexo")+
  xlab("Cor dos olhos") +
  ylab("Frequ�ncia simples (Quantidade de alunos)")

ggplotly(grafico_coluna_percent)

#Gr�fico de Colunas ou Barras Verticais Empilhadas (%)
grafico_colunas_empilhadas=ggplot(variaveis_categoricas_nominais,aes(a_cor_olhos,fill=a_sexo)) + 
  geom_bar(position = 'fill') +
  ggtitle("N�mero de alunos por cor dos olhos e sexo")+
  scale_y_continuous(labels=percent) +
  labs(fill="Sexo")+
  xlab("Cor dos olhos") +
  ylab("Frequ�ncia simples (Quantidade de alunos)")

ggplotly(grafico_colunas_empilhadas)

#Gr�fico de Barras Horizontais
grafico_barras_horizontais=grafico_coluna + coord_flip() 

ggplotly(grafico_barras_horizontais)

#Gr�fico de Barras Horizontais separado por Sexo
grafico_barras_horizontais_por_sexo=grafico_coluna + coord_flip() + facet_grid(~a_sexo)

ggplotly(grafico_barras_horizontais_por_sexo)

#Colocando todos os gr�ficos em um gr�fico s�
grid.arrange(grafico_coluna_geral,
             grafico_coluna,
             grafico_coluna_percent,
             grafico_barras_horizontais,
             grafico_barras_horizontais_por_sexo,
             grafico_colunas_empilhadas, nrow=3,ncol=2)

