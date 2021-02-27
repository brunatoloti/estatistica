vetor_pacotes=c("readr","ggplot2","plotly","e1071",
                "dplyr","Hmisc","esquisse","gridExtra")
install.packages(vetor_pacotes)
library(readr)
library(ggplot2)
library(plotly)
library(e1071)
require(dplyr)
require(Hmisc)
require(esquisse)
#require(devtools)
require(gridExtra)

# BLOCO: CARREGANDO O BANCO E FAZENDO SUBCONJUNTOS (SUBSETS)

#Direcionando a pasta no diretório, para o R
setwd("C:\\Users\\Admin\\Documents\\Curso de Estatística\\Projeto Enade - INEP - Análise Descritiva e Manipulação com Dplyr")

getwd()

#Carregando o banco de dados

#Opção 1: Base do R (Mais flexível e menor performance de velocidade)
microdados_enade <- read.table("MICRODADOS_ENADE_2017.txt",
                               header = TRUE, 
                               sep=";", 
                               dec = ",", 
                               colClasses=c(NT_OBJ_FG="numeric"))

#Visualiando o banco de dados
View(microdados_enade)

#Verificando as dimensões
dim(microdados_enade)

#Opção 2: library readr (Menos flexível e maior perfomance de velocidade)
enade2017 = read_csv2("MICRODADOS_ENADE_2017.txt") 

#Visualiando o banco de dados
View(enade2017)

#Verificando as dimensões
dim(enade2017)

#Verificando a quantidade de linhas
dim(enade2017)[1]

#Verificando a quantidade de colunas
dim(enade2017)[2]


#Selecionando as variáveis desejadas (usando o select do dplyr)
microdados_enade_filtrados= enade2017 %>% dplyr::select(CO_GRUPO,CO_REGIAO_CURSO,NU_IDADE,
                                                 TP_SEXO,CO_TURNO_GRADUACAO,NT_GER,QE_I01,QE_I02,
                                                 QE_I08,QE_I21,QE_I23,
                                                 NT_OBJ_FG, 
                                                 NT_OBJ_CE
  )      



#Vendo o nome das colunas do dataframe filtrado
names(microdados_enade_filtrados)

#Verificando as dimensões do dataframe filtrado
dim(microdados_enade_filtrados)

#Dicionário:
#QE_I01: Qual o seu estado civil?	
#QE_I02: Qual a sua cor ou raça?	
#QE_I08: Qual a renda total de sua família, incluindo seus rendimentos?
#QE_I21: Alguém em sua família concluiu um curso superior?
#QE_I23: Quantas horas por semana, aproximadamente, você dedicou aos estudos, excetuando as horas de aula?
#CO_GRUPO: Curso (Matemática, estatística, psicologia..)
#CO_REGIAO_CURSO: Código da região de funcionamento do curso (Norte, nordeste, sul..)
#CO_TURNO_GRADUACAO:	Código do turno de graduação	
#TP_SEXO: (Masculino/Feminino)

 
#Filtrando os dados só para os profissionais de análise e desenvolvimento de sistemas (t.i)
microdados_ti = microdados_enade_filtrados %>% filter(CO_GRUPO==72) 

#Verificando as dimensões
dim(microdados_ti)

#Certificando que o filtro funcionou
table(microdados_ti$CO_GRUPO)


#BLOCO: TRANSFORMANDO AS VARIÁVEIS NO BASE E NO DPLYR

#Criando categorias no dplyr para que facilite a nossa Análise Descritiva

#Um pequeno exemplo para entender CASE_WHEN e IFELSE
professor=c("THIAGO MARQUES","ADRIANA SILVA","OUTRO","OUTRO2")
ifelse(professor=="THIAGO MARQUES" | professor=="ADRIANA SILVA" ,"AULA LEGAL","AULA CHATA")
case_when(professor=="THIAGO MARQUES" ~ "AULA LEGAL",
          professor=="ADRIANA SILVA" ~ "AULA LEGAL",
          TRUE ~"AULA CHATA")

#Usando ifelse no BASE para criar uma nova variável a partir dos valores de uma outra variável
microdados_ti$estado_civil = ifelse(microdados_ti$QE_I01=="A","Solteiro(a)",
                                  ifelse(microdados_ti$QE_I01=="B","Casado(a)",
                                         ifelse(microdados_ti$QE_I01=="C","Separado(a)",
                                                ifelse(microdados_ti$QE_I01=="D","Viúvo(a)","Outro"
                                                ))))

#Usando case_when no Dplyr para criar uma nova variável a partir dos valores de uma outra variável
microdados_ti = microdados_ti %>% mutate(estado_civil2 = case_when( QE_I01 == "A" ~ "Solteiro(a)",
                                                                    QE_I01 == "B" ~ "Casado(a)",
                                                                    QE_I01 == "C" ~ "Separado(a)",
                                                                    QE_I01 == "D" ~ "Viúvo(a)",
                                                                    QE_I01 == "E" ~ "Outro"
                                                                    )) 

microdados_ti = microdados_ti %>% mutate(regiao = case_when( CO_REGIAO_CURSO == 1 ~ "Norte",
                                                             CO_REGIAO_CURSO == 2 ~ "Nordeste",
                                                             CO_REGIAO_CURSO == 3 ~ "Sudeste",
                                                             CO_REGIAO_CURSO == 4 ~ "Sul",
                                                             CO_REGIAO_CURSO == 5 ~ "Centro-Oeste"
                                                               )) 

#sexo
microdados_ti = microdados_ti %>% mutate(sexo = case_when( TP_SEXO == "M" ~ "Masculino",
                                                           TP_SEXO == "F" ~ "Feminino"
                                                           )) 

microdados_ti = microdados_ti %>% mutate(hestudos = case_when( QE_I23 == "A" ~ "Nenhuma, apenas assisto Às aulas",
                                                               QE_I23 == "B" ~ "De uma a três",
                                                               QE_I23 == "C" ~ "De quatro a sete",
                                                               QE_I23 == "D" ~ "De oito a doze",
                                                               QE_I23 == "E" ~ "Mais de doze"
                                                               )) 

#Removendo as variáveis que estão 'sobrando' 
microdados_ti = subset(microdados_ti, select = -c(estado_civil2, QE_I01,
                                                  CO_REGIAO_CURSO, TP_SEXO,
                                                  QE_I23))

#Verificando os nomes das colunas
names(microdados_ti)

#Verificando a classe das variáveis
class(microdados_ti$estado_civil)
class(microdados_ti$regiao)
class(microdados_ti$sexo)
class(microdados_ti$hestudos)
class(microdados_ti$NT_OBJ_CE)


#BLOCO: ANÁLISE DESCRITIVA DAS VARIÁVEIS

#Resumindo os dados
s=summary(microdados_ti)  
d=describe(microdados_ti)

#Selecionando apenas os resumos de interesse
d$sexo
d$regiao$values
d$regiao$values$frequency/sum(d$regiao$values$frequency) #Frequência relativa
s[1:2,1:4] #Pegando o summary de uma faixa de variáveis. Aqui, duas primeiras linhas e 4 primeiras colunas

#Obtendo as frequências simples das variáveis de outra forma
t=table(microdados_ti$regiao)
#Obtendo as frequências relativas
p=prop.table(t)

#Resumo da variável estado civil
describe(microdados_ti$estado_civil)
unique(microdados_ti$estado_civil) #Categorias únicas da variável

#Total, agrupado por Estado civil
microdados_ti %>% 
  select(estado_civil) %>% 
  group_by(estado_civil) %>% 
  summarise(total = n()) %>%
  arrange(desc(total))

#Média, agrupada por Estado civil
microdados_ti %>% 
  select(estado_civil,NT_OBJ_FG) %>% 
  group_by(estado_civil) %>% 
  summarise(media = mean(NT_OBJ_FG,na.rm = T)) %>%
  arrange(desc(media))

#Removendo  NAs de todas as variáveis que possuem NA
microdados_ti_sem_NA=microdados_ti %>% na.omit()

resumo_nas=microdados_ti_sem_NA %>%
  select(everything()) %>%  
  summarise_all(list(~sum(is.na(.))))

View(resumo_nas)

#Quantas linhas foram removidas com essa exclusão de valores NAs?
#Quatidade de linhas do dataframe original
dim(microdados_ti)[1]
#Quatidade de linhas do dataframe sem os NAs
dim(microdados_ti_sem_NA)[1]

#Total de linhas removidas que continham NAs
total_linhas_excluidas=dim(microdados_ti)[1]-dim(microdados_ti_sem_NA)[1]


#Bloco: Estatísticas descritivas da variável NOTA

#Calulando o tamanho do vetor de notas
quantidade_de_notas=length(microdados_ti_sem_NA$NT_OBJ_CE)

#Calculando a média
media=mean(microdados_ti_sem_NA$NT_OBJ_CE)

#Calculando a mediana
#De forma direta
mediana=median(microdados_ti_sem_NA$NT_OBJ_CE)
#Teoria
#Como temos n par = 9636, teremos duas posições centrais: (n/2) e (n/2+1)
#9636/2=4818 e mediana=(obs4818+obs4819)/2
#Calculando teoricamente
(sort(microdados_ti_sem_NA$NT_OBJ_CE)[4818]+sort(microdados_ti_sem_NA$NT_OBJ_CE)[4819])/2

#Calculando a Moda - Passo a passo
#Primeira etapa: Calcular as frequências simples
fs=table(microdados_ti_sem_NA$NT_OBJ_CE)
#Calcular o máximo das frequências simples
maximo=max(fs)
#Trazer os nomes que correspondem às observações das fs
nomes=names(fs)
#Trazer os nomes que satisfazem a comparação lógica
moda_texto=nomes[fs==maximo]
#Transformar em número
moda_numero=as.numeric(moda_texto)

#Segunda maneira de calcular a moda - Dplyr
microdados_ti_sem_NA %>% select(NT_OBJ_CE)  %>% 
                         table()            %>%
                         which.max ()       %>% 
                         names ()           %>%  
                         as.numeric()

#Terceira maneira de calcular a moda
moda=as.numeric (names(table(microdados_ti_sem_NA$NT_OBJ_CE))[table(microdados_ti_sem_NA$NT_OBJ_CE) == max(table(microdados_ti_sem_NA$NT_OBJ_CE))])

#Consolidando nossos resultados em um dataframe
consolidado_notas=data.frame("Quantidade_de_notas"=quantidade_de_notas,
                       "Media"=media,
                       "Mediana"=mediana,
                       "Moda"=moda_numero)


#Logo temos que a média(42.09)>mediana(40)=moda(40), logo não podemos afirmar que a distribuição é simétrica, pois apresenta
#uma leve assimetria, que só poderemos afirmar pelo cálculo do coeficiente de assimetria de pearson.

#Para calcular a assimetria:
assimetria=skewness(microdados_ti_sem_NA$NT_OBJ_CE)

#Coefieciente de assimetria de pearson>0, logo terá assimetria positiva e concentração a esquerda dos maiores valores. Nesse caso, uma leve assimetria.

#A curtose que o R calcula, é padronizada, tirando -3, comparada a da normal
curtose=kurtosis(microdados_ti_sem_NA$NT_OBJ_CE)

consolidado_notas_completo=cbind(consolidado_notas,assimetria, curtose)
#Lembrand que, pelo R, temos que se 
#k>0, leptocúrtica
#k=0, Mesocúrtica
#k<0, Platicúrtica
#Consideramos então, nesse nosso caso, platicúrtica.


#FAZENDO ALGUNS GRÁFICOS PARA IDENTIFICAR O QUE CONSTANTAMOS

#Gráfico histograma das notas dos alunos com a frequência relativa das notas - Lembrando que as notas são valores discretos, não contínuos
g_hist=ggplot(microdados_ti_sem_NA,aes(x=NT_OBJ_CE)) + 
              geom_histogram(color = "black",fill="lightblue",bins =50,aes(y=(..count..)/sum(..count..)))+
              ggtitle("Histograma da nota dos alunos de análise e desenvolvimento de sistemas")+
              xlab("nota") +
              ylab("Frequência relativa")
g_hist

g_densidade=ggplot(microdados_ti_sem_NA,aes(x=NT_OBJ_CE))+
                   geom_density(col=2,size = 1, aes(y = 27 * (..count..)/sum(..count..))) +
                   ggtitle("Curva de densidade da nota dos alunos de análise e desenvolvimento de sistemas") +
                   xlab("nota") +
                   ylab("Frequência relativa")
g_densidade
ggplotly(g_densidade)

g_hist_densidade = ggplot(microdados_ti_sem_NA,aes(x=NT_OBJ_CE)) + 
                          geom_histogram(color = "black",fill="lightblue",bins =50,aes(y=(..count..)/sum(..count..)))+
                          geom_density(col=2,size = 1, aes(y = 27 * (..count..)/sum(..count..))) +
                          ggtitle("Histograma e curva de densidade da nota dos alunos de análise e desenvolvimento de sistemas")+
                          xlab("nota") +
                          ylab("Frequência relativa")
g_hist_densidade
ggplotly(g_hist_densidade)

grid.arrange( g_hist,
              g_densidade,
              g_hist_densidade,
              nrow=3,ncol=1)


#BLOCO: CONTINUAÇÃO DA ANÁLISE DESCRITIVA DAS VARIÁVEIS

#Comparar as medianas por sexo e estado civil
microdados_ti_mod2 = microdados_ti_sem_NA %>% 
        select(estado_civil,NT_GER,sexo) %>% 
             group_by(sexo,estado_civil) %>% 
             summarise(  quantidade=n(),
                         media = mean(NT_GER,na.rm = T),
                         mediana = median(NT_GER,na.rm = T),
                         cv=sd(NT_GER,na.rm=T)/media*100,
                         amplitude_interquartil=IQR(NT_GER)) %>% 
             arrange(desc(mediana))

#Tabulação cruzada
table(microdados_ti_sem_NA$estado_civil,microdados_ti_sem_NA$sexo)

#Tabulação cruzada proporção
prop.table(table(microdados_ti_sem_NA$estado_civil,microdados_ti_sem_NA$sexo))

require(e1071)
#Assimetria e curtose - Agrupando apenas por estado civil

dados_casados = microdados_ti_sem_NA %>% 
         select(estado_civil,NT_GER) %>% 
              group_by(estado_civil) %>% 
              #filter(estado_civil=="Casado(a)") %>% 
              summarise(  quantidade=n(),
                          media = mean(NT_GER),
                          mediana = median(NT_GER),
                          cv=sd(NT_GER)/media*100,
                          amplitude_interquartil=IQR(NT_GER),
                          assimetria=skewness(NT_GER),
                          curtose=kurtosis(NT_GER)
                          ) %>% 
              arrange(desc(cv))

#Histograma das notas por estado civil
dados=microdados_ti_sem_NA 
grafico_histograma1 = ggplot(dados, aes(x=NT_GER,fill=estado_civil)) + 
  geom_histogram() +
  ggtitle("Gráfico histograma da nota por estado civil") +
  xlab("Notas") +
  ylab("Frequência simples") +
  facet_grid(~estado_civil)

ggplotly(grafico_histograma1)

#Boxplot da nota por estado civil e sexo
dados=microdados_ti_sem_NA
grafico_boxplot1 = ggplot(dados, aes(x=estado_civil,y=NT_GER,fill=estado_civil)) + 
  geom_boxplot() +
  ggtitle("Gráfico de Boxplot da nota por estado civil e sexo")+
  xlab("Estado civil") +
  ylab("Notas") +
  facet_grid(~sexo)

ggplotly(grafico_boxplot1)

#Comparar as médias por sexo e região
microdados_ti_mod3= microdados_ti_sem_NA %>% 
  select(estado_civil,NT_GER,regiao,hestudos,sexo) %>% 
  group_by(sexo,regiao) %>% 
  summarise(quantidade=n(),
            media = mean(NT_GER),
            mediana = median(NT_GER),
            cv=sd(NT_GER)/media*100,
            amplitude_interquartil=IQR(NT_GER),
            assimetria=skewness(NT_GER),
            curtose=kurtosis(NT_GER)) %>% 
  arrange(desc(media))

#Tabulação cruzada
table(microdados_ti_sem_NA$regiao,microdados_ti_sem_NA$sexo)

#Tabulação cruzada proporção
prop.table(table(microdados_ti_sem_NA$regiao,microdados_ti_sem_NA$sexo))

#Histograma da nota por região e sexo
dados=microdados_ti_sem_NA
grafico_histograma2 = ggplot(dados, aes(x=NT_GER,fill=regiao)) + 
  geom_histogram()+
  ggtitle("Gráfico histograma da nota por região e sexo" )+
  xlab("Notas") +
  ylab("Frequência simples") +
  facet_grid(~sexo)

ggplotly(grafico_histograma2)

#Boxplot da nota por região e sexo
dados=microdados_ti_sem_NA
grafico_boxplot2 = ggplot(dados, aes(x=regiao,y=NT_GER,fill=regiao)) + 
  geom_boxplot() +
  ggtitle("Gráfico boxplot da nota por região e sexo")+
  ylab("Notas") +
  facet_grid(~sexo)

ggplotly(grafico_boxplot2)

grid.arrange( grafico_histograma1,
              grafico_boxplot1,
              grafico_histograma2,
              grafico_boxplot2,
              nrow=2,ncol=2)

#BLOCO: GRÁFICOS POINT CLICK POR MEIO DO ESQUISSE

#Análises gráficas point click
#microdados_ti_mod= microdados_ti_sem_NA %>% 
#  select(estado_civil,NT_OBJ_FG,regiao,hestudos,sexo) %>% 
#  group_by(estado_civil,regiao,hestudos,sexo) %>% 
#  summarise(media = mean(NT_OBJ_FG,na.rm = T))

#install.packages('esquisse')
#require(esquisse)
#esquisser(viewer = "browser")
