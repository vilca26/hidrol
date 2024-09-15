#install.packages("easypackages")
#install.packages("xts")
#install.packages("lattice")
#install.packages("ggplot2")
#install.packages("zoo")
library(zoo)
library(easypackages) 
library(xts) 
library(lattice) 
library(ggplot2)
#ruta de carga archivo datos 3. Analisis_diario_varias
pdiaria <- read.csv(file.choose(),header=TRUE, check.names = F, stringsAsFactors = F) 
str(pdiaria) #para verificar la estructura del objeto
idx <- as.Date(pdiaria[,1]) #formato fecha a la 1era columna
data.matrix <- pdiaria[,-1] #formato matriz al resto de columnas a excepcion de la 1era columna 
data.xts <- xts(data.matrix, order.by = idx ) #crear un objeto xts (eXtended time series) 
#str(data.xts)
par(mar=c(1,1,1,1))
plot(data.xts) 
plot(data.matrix[,1], type="l") 
plot(data.xts[,2])

# convertir a un objeto zoo que almacene varias estaciones a la vez 
data.zoo <- as.zoo(data.xts)
str(data.zoo)
plot(data.zoo, main = "Series de tiempo de precipitación") 
summary(data.zoo)
max(data.zoo, na.rm = T)
plot(data.zoo, main = "Series de tiempo de precipitación", ylim = c(0,80)) 
xyplot(data.xts,xlab = "Fecha",ylab = "Precipitación [mm/dia]",ylim=c(0,100)) 
autoplot(data.xts[,1:2]) +theme_bw()+xlab('Fecha')+ylab('Precipitación [mm/dia]') 
boxplot(coredata(data.xts))
hist(coredata(data.xts[,1]), freq = T) # cantidad de datos por clase 
histogram(coredata(data.xts[,1])) # porcentaje de datos por clase
