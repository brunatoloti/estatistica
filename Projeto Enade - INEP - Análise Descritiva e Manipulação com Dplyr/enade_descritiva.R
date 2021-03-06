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

#Direcionando a pasta no diret�rio, para o R
setwd("C:\\Users\\Admin\\Documents\\Curso de Estat�stica\\Projeto Enade - INEP - An�lise Descritiva e Manipula��o com Dplyr")

getwd()

#Carregando o banco de dados

#Op��o 1: Base do R (Mais flex�vel e menor performance de velocidade)
microdados_enade <- read.table("MICRODADOS_ENADE_2017.txt",
                               header = TRUE, 
                               sep=";", 
                               dec = ",", 
                               colClasses=c(NT_OBJ_FG="numeric"))

#Visualiando o banco de dados
View(microdados_enade)

#Verificando as dimens�es
dim(microdados_enade)

#Op��o 2: library readr (Menos flex�vel e maior perfomance de velocidade)
enade2017 = read_csv2("MICRODADOS_ENADE_2017.txt") 

#Visualiando o banco de dados
View(enade2017)

#Verificando as dimens�es
dim(enade2017)

#Verificando a quantidade de linhas
dim(enade2017)[1]

#Verificando a quantidade de colunas
dim(enade2017)[2]


#Selecionando as vari�veis desejadas (usando o select do dplyr)
microdados_enade_filtrados= enade2017 %>% dplyr::select(CO_GRUPO,CO_REGIAO_CURSO,NU_IDADE,
                                                 TP_SEXO,CO_TURNO_GRADUACAO,NT_GER,QE_I01,QE_I02,
                                                 QE_I08,QE_I21,QE_I23,
                                                 NT_OBJ_FG, 
                                                 NT_OBJ_CE
  )      



#Vendo o nome das colunas do dataframe filtrado
names(microdados_enade_filtrados)

#Verificando as dimens�es do dataframe filtrado
dim(microdados_enade_filtrados)

#Dicion�rio:
#QE_I01: Qual o seu estado civil?	
#QE_I02: Qual a sua cor ou ra�a?	
#QE_I08: Qual a renda total de sua fam�lia, incluindo seus rendimentos?
#QE_I21: Algu�m em sua fam�lia concluiu um curso superior?
#QE_I23: Quantas horas por semana, aproximadamente, voc� dedicou aos estudos, excetuando as horas de aula?
#CO_GRUPO: Curso (Matem�tica, estat�stica, psicologia..)
#CO_REGIAO_CURSO: C�digo da regi�o de funcionamento do curso (Norte, nordeste, sul..)
#CO_TURNO_GRADUACAO:	C�digo do turno de gradua��o	
#TP_SEXO: (Masculino/Feminino)

 
#Filtrando os dados s� para os profissionais de an�lise e desenvolvimento de sistemas (t.i)
microdados_ti = microdados_enade_filtrados %>% filter(CO_GRUPO==72) 

#Verificando as dimens�es
dim(microdados_ti)

#Certificando que o filtro funcionou
table(microdados_ti$CO_GRUPO)


#BLOCO: TRANSFORMANDO AS VARI�VEIS NO BASE E NO DPLYR

#Criando categorias no dplyr para que facilite a nossa An�lise Descritiva

#Um pequeno exemplo para entender CASE_WHEN e IFELSE
professor=c("THIAGO MARQUES","ADRIANA SILVA","OUTRO","OUTRO2")
ifelse(professor=="THIAGO MARQUES" | professor=="ADRIANA SILVA" ,"AULA LEGAL","AULA CHATA")
case_when(professor=="THIAGO MARQUES" ~ "AULA LEGAL",
          professor=="ADRIANA SILVA" ~ "AULA LEGAL",
          TRUE ~"AULA CHATA")

#Usando ifelse no BASE para criar uma nova vari�vel a partir dos valores de uma outra vari�vel
microdados_ti$estado_civil = ifelse(microdados_ti$QE_I01=="A","Solteiro(a)",
                                  ifelse(microdados_ti$QE_I01=="B","Casado(a)",
                                         ifelse(microdados_ti$QE_I01=="C","Separado(a)",
                                                ifelse(microdados_ti$QE_I01=="D","Vi�vo(a)","Outro"
                                                ))))

#Usando case_when no Dplyr para criar uma nova vari�vel a partir dos valores de uma outra vari�vel
microdados_ti = microdados_ti %>% mutate(estado_civil2 = case_when( QE_I01 == "A" ~ "Solteiro(a)",
                                                                    QE_I01 == "B" ~ "Casado(a)",
                                                                    QE_I01 == "C" ~ "Separado(a)",
                                                                    QE_I01 == "D" ~ "Vi�vo(a)",
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

microdados_ti = microdados_ti %>% mutate(hestudos = case_when( QE_I23 == "A" ~ "Nenhuma, apenas assisto �s aulas",
                                                               QE_I23 == "B" ~ "De uma a tr�s",
                                                               QE_I23 == "C" ~ "De quatro a sete",
                                                               QE_I23 == "D" ~ "De oito a doze",
                                                               QE_I23 == "E" ~ "Mais de doze"
                                                               )) 

#Removendo as vari�veis que est�o 'sobrando' 
microdados_ti = subset(microdados_ti, select = -c(estado_civil2, QE_I01,
                                                  CO_REGIAO_CURSO, TP_SEXO,
                                                  QE_I23))

#Verificando os nomes das colunas
names(microdados_ti)

#Verificando a classe das vari�veis
class(microdados_ti$estado_civil)
class(microdados_ti$regiao)
class(microdados_ti$sexo)
class(microdados_ti$hestudos)
class(microdados_ti$NT_OBJ_CE)


#BLOCO: AN�LISE DESCRITIVA DAS VARI�VEIS

#Resumindo os dados
s=summary(microdados_ti)  
d=describe(microdados_ti)

#Selecionando apenas os resumos de interesse
d$sexo
d$regiao$values
d$regiao$values$frequency/sum(d$regiao$values$frequency) #Frequ�ncia relativa
s[1:2,1:4] #Pegando o summary de uma faixa de vari�veis. Aqui, duas primeiras linhas e 4 primeiras colunas

#Obtendo as frequ�ncias simples das vari�veis de outra forma
t=table(microdados_ti$regiao)
#Obtendo as frequ�ncias relativas
p=prop.table(t)

#Resumo da vari�vel estado civil
describe(microdados_ti$estado_civil)
unique(microdados_ti$estado_civil) #Categorias �nicas da vari�vel

#Total, agrupado por Estado civil
microdados_ti %>% 
  select(estado_civil) %>% 
  group_by(estado_civil) %>% 
  summarise(total = n()) %>%
  arrange(desc(total))

#M�dia, agrupada por Estado civil
microdados_ti %>% 
  select(estado_civil,NT_OBJ_FG) %>% 
  group_by(estado_civil) %>% 
  summarise(media = mean(NT_OBJ_FG,na.rm = T)) %>%
  arrange(desc(media))

#Removendo  NAs de todas as vari�veis que possuem NA
microdados_ti_sem_NA=microdados_ti %>% na.omit()

resumo_nas=microdados_ti_sem_NA %>%
  select(everything()) %>%  
  summarise_all(list(~sum(is.na(.))))

View(resumo_nas)

#Quantas linhas foram removidas com essa exclus�o de valores NAs?
#Quatidade de linhas do dataframe original
dim(microdados_ti)[1]
#Quatidade de linhas do dataframe sem os NAs
dim(microdados_ti_sem_NA)[1]

#Total de linhas removidas que continham NAs
total_linhas_excluidas=dim(microdados_ti)[1]-dim(microdados_ti_sem_NA)[1]


#Bloco: Estat�sticas descritivas da vari�vel NOTA

#Calulando o tamanho do vetor de notas
quantidade_de_notas=length(microdados_ti_sem_NA$NT_OBJ_CE)

#Calculando a m�dia
media=mean(microdados_ti_sem_NA$NT_OBJ_CE)

#Calculando a mediana
#De forma direta
mediana=median(microdados_ti_sem_NA$NT_OBJ_CE)
#Teoria
#Como temos n par = 9636, teremos duas posi��es centrais: (n/2) e (n/2+1)
#9636/2=4818 e mediana=(obs4818+obs4819)/2
#Calculando teoricamente
(sort(microdados_ti_sem_NA$NT_OBJ_CE)[4818]+sort(microdados_ti_sem_NA$NT_OBJ_CE)[4819])/2

#Calculando a Moda - Passo a passo
#Primeira etapa: Calcular as frequ�ncias simples
fs=table(microdados_ti_sem_NA$NT_OBJ_CE)
#Calcular o m�ximo das frequ�ncias simples
maximo=max(fs)
#Trazer os nomes que correspondem �s observa��es das fs
nomes=names(fs)
#Trazer os nomes que satisfazem a compara��o l�gica
moda_texto=nomes[fs==maximo]
#Transformar em n�mero
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


#Logo temos que a m�dia(42.09)>mediana(40)=moda(40), logo n�o podemos afirmar que a distribui��o � sim�trica, pois apresenta
#uma leve assimetria, que s� poderemos afirmar pelo c�lculo do coeficiente de assimetria de pearson.

#Para calcular a assimetria:
assimetria=skewness(microdados_ti_sem_NA$NT_OBJ_CE)

#Coefieciente de assimetria de pearson>0, logo ter� assimetria positiva e concentra��o a esquerda dos maiores valores. Nesse caso, uma leve assimetria.

#A curtose que o R calcula, � padronizada, tirando -3, comparada a da normal
curtose=kurtosis(microdados_ti_sem_NA$NT_OBJ_CE)

consolidado_notas_completo=cbind(consolidado_notas,assimetria, curtose)
#Lembrand que, pelo R, temos que se 
#k>0, leptoc�rtica
#k=0, Mesoc�rtica
#k<0, Platic�rtica
#Consideramos ent�o, nesse nosso caso, platic�rtica.


#FAZENDO ALGUNS GR�FICOS PARA IDENTIFICAR O QUE CONSTANTAMOS

#Gr�fico histograma das notas dos alunos com a frequ�ncia relativa das notas - Lembrando que as notas s�o valores discretos, n�o cont�nuos
g_hist=ggplot(microdados_ti_sem_NA,aes(x=NT_OBJ_CE)) + 
              geom_histogram(color = "black",fill="lightblue",bins =50,aes(y=(..count..)/sum(..count..)))+
              ggtitle("Histograma da nota dos alunos de an�lise e desenvolvimento de sistemas")+
              xlab("nota") +
              ylab("Frequ�ncia relativa")
g_hist

g_densidade=ggplot(microdados_ti_sem_NA,aes(x=NT_OBJ_CE))+
                   geom_density(col=2,size = 1, aes(y = 27 * (..count..)/sum(..count..))) +
                   ggtitle("Curva de densidade da nota dos alunos de an�lise e desenvolvimento de sistemas") +
                   xlab("nota") +
                   ylab("Frequ�ncia relativa")
g_densidade
ggplotly(g_densidade)

g_hist_densidade = ggplot(microdados_ti_sem_NA,aes(x=NT_OBJ_CE)) + 
                          geom_histogram(color = "black",fill="lightblue",bins =50,aes(y=(..count..)/sum(..count..)))+
                          geom_density(col=2,size = 1, aes(y = 27 * (..count..)/sum(..count..))) +
                          ggtitle("Histograma e curva de densidade da nota dos alunos de an�lise e desenvolvimento de sistemas")+
                          xlab("nota") +
                          ylab("Frequ�ncia relativa")
g_hist_densidade
ggplotly(g_hist_densidade)

grid.arrange( g_hist,
              g_densidade,
              g_hist_densidade,
              nrow=3,ncol=1)


#BLOCO: CONTINUA��O DA AN�LISE DESCRITIVA DAS VARI�VEIS

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

#Tabula��o cruzada
table(microdados_ti_sem_NA$estado_civil,microdados_ti_sem_NA$sexo)

#Tabula��o cruzada propor��o
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
  ggtitle("Gr�fico histograma da nota por estado civil") +
  xlab("Notas") +
  ylab("Frequ�ncia simples") +
  facet_grid(~estado_civil)

ggplotly(grafico_histograma1)

#Boxplot da nota por estado civil e sexo
dados=microdados_ti_sem_NA
grafico_boxplot1 = ggplot(dados, aes(x=estado_civil,y=NT_GER,fill=estado_civil)) + 
  geom_boxplot() +
  ggtitle("Gr�fico de Boxplot da nota por estado civil e sexo")+
  xlab("Estado civil") +
  ylab("Notas") +
  facet_grid(~sexo)

ggplotly(grafico_boxplot1)

#Comparar as m�dias por sexo e regi�o
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

#Tabula��o cruzada
table(microdados_ti_sem_NA$regiao,microdados_ti_sem_NA$sexo)

#Tabula��o cruzada propor��o
prop.table(table(microdados_ti_sem_NA$regiao,microdados_ti_sem_NA$sexo))

#Histograma da nota por regi�o e sexo
dados=microdados_ti_sem_NA
grafico_histograma2 = ggplot(dados, aes(x=NT_GER,fill=regiao)) + 
  geom_histogram()+
  ggtitle("Gr�fico histograma da nota por regi�o e sexo" )+
  xlab("Notas") +
  ylab("Frequ�ncia simples") +
  facet_grid(~sexo)

ggplotly(grafico_histograma2)

#Boxplot da nota por regi�o e sexo
dados=microdados_ti_sem_NA
grafico_boxplot2 = ggplot(dados, aes(x=regiao,y=NT_GER,fill=regiao)) + 
  geom_boxplot() +
  ggtitle("Gr�fico boxplot da nota por regi�o e sexo")+
  ylab("Notas") +
  facet_grid(~sexo)

ggplotly(grafico_boxplot2)

grid.arrange( grafico_histograma1,
              grafico_boxplot1,
              grafico_histograma2,
              grafico_boxplot2,
              nrow=2,ncol=2)

#BLOCO: GR�FICOS POINT CLICK POR MEIO DO ESQUISSE

#An�lises gr�ficas point click
#microdados_ti_mod= microdados_ti_sem_NA %>% 
#  select(estado_civil,NT_OBJ_FG,regiao,hestudos,sexo) %>% 
#  group_by(estado_civil,regiao,hestudos,sexo) %>% 
#  summarise(media = mean(NT_OBJ_FG,na.rm = T))

#install.packages('esquisse')
#require(esquisse)
#esquisser(viewer = "browser")
