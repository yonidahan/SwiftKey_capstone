

#script3 : saving the environment image

rm(list=ls())

dir_new<-"./data_app"

wd<-"C:/Users/Sarah/Desktop/Data Science/Data Science Specialization/Capstone Project"

setwd(dir_new)



if(!exists("gram_1")){gram_1<-read.csv("gram_1.csv",stringsAsFactors=F)}

if(!exists("gram_2")){gram_2<-read.csv("gram_2.csv",stringsAsFactors=F)}

if(!exists("gram_3")){gram_3<-read.csv("gram_3.csv",stringsAsFactors=F)}

if(!exists("gram_4")){gram_4<-read.csv("gram_4.csv",stringsAsFactors=F)}

if(!exists("gram_5")){gram_5<-read.csv("gram_5.csv",stringsAsFactors=F)}

if(!exists("gram_6")){gram_6<-read.csv("gram_6.csv",stringsAsFactors=F)}
        
setwd(wd);rm(dir_new);rm(wd)


#Save environment in a directory called app1, which will be used as 
#the shiny app directory
if(!dir.exists("./app1")){dir.create("./app1")}
if(!dir.exists("./app1/data")){dir.create("./app1/data")}

save.image("./app1/data/grams.RData")