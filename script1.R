

#Script1 : loading the files, preprocessing and sampling

#Loading the libraries
lapply(c("tm","ggplot2","data.table"),require,character.only=TRUE)
options(java.parameters = "-Xmx8000m") #Increase Java heap size
Sys.setenv(JAVA_HOME="C:\\Program Files\\Java\\jre6")
lapply(c("RWeka","NLP","openNLP"),require,character.only=TRUE)

#Working directory
wd<-"C:/Users/Sarah/Desktop/Data Science/Data Science Specialization/Capstone Project"
setwd(wd)

#Loading the files
#They should have been already downloaded and extracted in the working directory
twitter<-"./final/en_US/en_US.twitter.txt"
news<-"./final/en_US/en_US.news.txt"
blogs<-"./final/en_US/en_US.blogs.txt"



#Preprocessing
preprocess<-function(file1,file2,file3,sample=0.05,seed=1306){ 
        
        files<-list(readLines(file1,encoding="utf-8",warn=F),
                    readLines(file2,warn=F),
                    readLines(file3,warn=F))
        
        data<-unlist(sapply(files,function(x){
                
                seed<-set.seed(seed)#for reproducibility
                
                pz<-sample.int(n=length(x),size=sample*length(x))#random sample of sample%
                
                x<-x[pz]
                
                return(x)
        }
        ))
        
        #Fix encoding issues
        data<-iconv(data,"latin1","ASCII",sub="")
        
        #Upper to lower cases
        data<-tolower(data)
        
        
        #Handling english contractions, expanding them
        
        data<-gsub("i[[:space:]]*([[:alnum:]]*)ain't","I am not",data)#I ain't going there
        data<-gsub("can't","cannot",data) #can't-->cannot
        data<-gsub("([[:alnum:]]*)\\1n't","\\1 not",data) #(is, are)n't-->(is,are) not
        data<-gsub("([[:alnum:]]*)\\1've","\\1 have",data) #(I, they...)'ve--> (I, they...) have
        
        data<-gsub("([[:alnum:]]*)\\1'd","\\1 would",data) #(I, they)'d--> (I, they...) 
        #Approx. : "would"is more used than "had"
        
        data<-gsub("([[:alnum:]]*)\\1'll","\\1 will",data)#(I, they...)'ll-->(I, they...)will 
        #Ditto : "will" and "shall"
        
        data<-gsub("i'm","i am",data)#I'm-->I am
        data<-gsub("im","i am",data)#Im-->I am
        
        data<-gsub("let's","let us",data)#let's-->let us
        data<-gsub("([[:alnum:]]*)\\1's","\\1 is",data)#(He, that...)'s-->(He, that...)is 
        data<-gsub("([[:alnum:]]*)\\1're","\\1 are",data) #'re---> are 
        
        #Remove URL's
        data<-gsub("(https?)?(://)?(www.)?[[:alnum:]]*(.com|.org|.fr)","",data)
        
        #Remove email adresses and public replies
        data<-gsub("([[:graph:]]*)?@([[:alnum:]]*)?(.com|.org|.fr)?","",data)
        
        #Remove hashtags
        data<-gsub("#[[:alnum:]]*","",data)
        
        #Remove Numbers
        data<-gsub("[[:digit:]]","",data)
        
        #Remove Punctuation
        data<-gsub("-", " ", data)
        
        #Remove words with more than 2 same letters
        data<-gsub("([[:alnum:]])\\1{2,}","\\1",data)
        
        #remove extra-whitespaces
        data<-gsub("\\s+"," ",data)
        
        return(data) 
        
        
}  

sample_data<-preprocess(file1=blogs,file2=news,file3=twitter,sample=0.05,seed=1306)


#Save the sampled data in a directory called "data_app"
if(!dir.exists("./data_app")){dir.create("./data_app")}

if(!exists("./data_app/sample_data.txt")){
conn<-file("./data_app/sample_data.txt")
writeLines(sample_data,conn)
close(conn)}

