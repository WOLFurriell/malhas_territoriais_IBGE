# ------------------------------------------------------------------------------------
# - Download dos shapefiles do IBGE --------------------------------------------------
# ------------------------------------------------------------------------------------

rm(list=ls())

library(RCurl)
library(utils)
library(memisc) 
library(downloader)

# ------------------------------------------------------------------------------------

ano        <- "2000"                                #ESCOLHA O ANO QUE DESEJA BAIXAR E
cbind(ano)
mainDir    <-"C:/Users/Furriel/Downloads/"          #SELECIONE O DIRETORIO PRINCIPAL
subDir     <-paste("shape_",ano,sep = "")           #CRIA UMA PASTA
arquivozip <- paste(mainDir,subDir,sep ="")

dir.create(file.path(mainDir, subDir))              # CRIANDO A PASTA
setwd(file.path(mainDir, subDir))
# ------------------------------------------------------------------------------------

url <- "ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_municipais/municipio_2000/"
filenames <- getURL(url,tp.use.epsv = FALSE,dirlistonly = TRUE) 
filenames
aux <- getURL(url,verbose=TRUE,ftp.use.epsv=TRUE,
            dirlistonly = TRUE)
arquivos  <- unlist(strsplit(aux, "\r\n"));arquivos # ADEQUANDO OS NOMES

ordemArquivos   <- order(arquivos)
arquivosEmOrdem <- arquivos[ordemArquivos]            # ORDENANDO O NOME DOS ARQUIVOS
# ------------------------------------------------------------------------------------

shapes <- list(length(arquivos))
nome   <- c()

download<-paste(url,arquivos,"/",arquivos,"_municipios.zip",sep = "")
for(i in 1:length(arquivos)){
    nome[i] <- paste(arquivos[i],"_municipios.zip",sep = "")
    download.file(download[i],nome[i],mode="wb","auto",cacheOK=TRUE,quiet=F)
}                               # REALIZANDO OS DOWNLOADS

zips    <-list.files(arquivozip)
zipasta <-paste(arquivozip,zips,sep="/")
# ------------------------------------------------------------------------------------

for(i in 1:length(zipasta)){ 
  unzip(zipasta[i])           # DESCOMPACTAR OS ARQUIVOS
  file.remove(zipasta[i])     # DESCOMPACTAR OS ARQUIVOS
}


