
#Script2 : generating n-grams


#Load sample_data
if(!exists("sample_data")){sample_data<-readLines("./data_app/sample_data.txt")}


#Function for n-gram generation
termfreq<-function(data,min=1,max=1,lower=1){
        
        data<-PlainTextDocument(data)
        control<-list(tokenize=function(x)NGramTokenizer(x,Weka_control(min=min,max=max)))
        
        data<-sort(termFreq(data,control=control),decreasing=T)
        data<-data[data>=lower]
        
        data<-data.table(data.frame(gram=attr(data,"dimnames"),freq=data))
        
        return(data)
        
}

gram_1<-termfreq(sample_data,min=1,max=1,lower=1)
gram_2<-termfreq(sample_data,min=2,max=2,lower=2)
gram_3<-termfreq(sample_data,min=3,max=3,lower=2)
gram_4<-termfreq(sample_data,min=4,max=4,lower=2)
gram_5<-termfreq(sample_data,min=5,max=5,lower=2)
gram_6<-termfreq(sample_data,min=6,max=6,lower=2)


#Save n-grams frequencies in data_app
write.csv(gram_1,"./data_app/gram_1.csv",row.names=F)
write.csv(gram_2,"./data_app/gram_2.csv",row.names=F)
write.csv(gram_3,"./data_app/gram_3.csv",row.names=F)
write.csv(gram_4,"./data_app/gram_4.csv",row.names=F)
write.csv(gram_5,"./data_app/gram_5.csv",row.names=F)
write.csv(gram_6,"./data_app/gram_6.csv",row.names=F)
