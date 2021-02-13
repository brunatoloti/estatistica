#Variáveis Quantitativas
install.packages(c("scales","tidyverse"))
require(ggplot2)
require(dplyr)
require(scales)
require(plotly)
require(gridExtra)
require(tidyverse)

#ggplot geral
#Elementos de um gráfico ggplot:

#1. Base de dados que será utilizada
#2. Geometria que será utilizada (Tipo de gráfico)
#3. Aesthetic mapping (A parte estética do gráfico, eixos, cores, tamanhos, textos)- Depende da geometria (tipo de gráfico) escolhido
#4. Escala (formato, unidade de medida)
#5. Rótulos, títulos, legendas, etc..


#Gráfico Histograma
View(iris)
dados=iris
grafico_hist = ggplot(dados,aes(x=Sepal.Length)) + 
  geom_histogram(color="black",fill="lightblue",bins=30)+
  ggtitle("Gráfico histograma do tamanho da Sépala das Plantas")+
  xlab("Tamanho das Sépalas") +
  ylab("Frequência simples") +
  theme()

grafico_hist
ggplotly(grafico_hist)

#Gráfico Box-Plot
dados=iris
grafico_boxplot = ggplot(dados, aes(x=Sepal.Length, y=Petal.Length,fill=Species)) + 
  geom_boxplot()+
  ggtitle("Gráfico de Box-plot do tamanho das Sépalas vs o tamanho das Pétalas das Plantas")+
  xlab("Tamanho das Sépalas") +
  ylab("Tamanho das Pétalas")
grafico_boxplot

#Gráfico de Dispersão - cor espécies
dados=iris
grafico_dispersao_cor = ggplot(dados, aes(x=Sepal.Length, y=Petal.Length,col=Species)) + 
                       geom_point(size=4)+
                       ggtitle("Gráfico de Dispersão do tamanho das Sépalas vs o tamanho das Pétalas das Plantas")+
                       xlab("Tamanho das Sépalas") +
                       ylab("Tamanho das Pétalas")
grafico_dispersao_cor
ggplotly(grafico_dispersao_cor)

#Gráfico de Dispersão - cor espécies e tamanho espécies
dados=iris
grafico_dispersao_tamanho = ggplot(dados, aes(x=Sepal.Length, y=Petal.Length,col=Species)) + 
  geom_point(aes(size=Species))+
  ggtitle("Gráfico de Dispersão do tamanho das Sépalas vs o tamanho das Pétalas das Plantas")+
  xlab("Tamanho das Sépalas") +
  ylab("Tamanho das Pétalas")

grafico_dispersao_tamanho
ggplotly(grafico_dispersao_tamanho)

#Gráfico de Dispersão por Espécie
dados=iris
grafico_dispersao_especie = ggplot(dados, aes(x=Sepal.Length, y=Petal.Length,col=Species)) + 
                       geom_point(size=4)+
                       ggtitle("Gráfico de Dispersão do tamanho da Sépala vs o tamanho das Pétalas das Plantas")+
                       xlab("Tamanho das Sépalas") +
                       ylab("Tamanho das Pétalas") +
                       facet_wrap(~Species)
grafico_dispersao_especie


#Gráfico de linhas do desemprego nos Estados Unidos de 1967 a 2015 - Economics
dados2=economics
View(dados2)
grafico_linhas=ggplot(economics, aes(x=date, y=unemploy)) + 
                      geom_line(col="red") + 
                      xlab("Ano") + 
                      ylab("Desemprego (em milhares)") + 
                      ggtitle("Desemprego nos Estados Unidos de 1967 a 2015 - Economics")
grafico_linhas               
ggplotly(grafico_linhas)

#Agrupando os gráficos na mesma janela com ggplot2
grid.arrange(
             grafico_hist,
             grafico_boxplot,
             grafico_dispersao_cor,
             grafico_dispersao_tamanho,
             grafico_dispersao_especie,
             grafico_linhas,
             nrow=3,ncol=2)



#Gráficos Estatísticos Drag and Drop (Point and Click)
install.packages('esquisse')
require(esquisse)

#Abrindo o esquisser no browser (se quero no R Studio, não coloco nada de parâmetro)
esquisser(viewer = 'browser')

