

#app_script
#transform the input string
#perform a backoff selection


#process : normalize input
process<-function(string){
        
        string<-tolower(string)
        
        string<-gsub("i[[:space:]]*([[:alnum:]]*)ain't","I am not",string)
        
        string<-gsub("can't","cannot",string) #can't-->cannot
        
        string<-gsub("([[:alnum:]]*)\\1n't","\\1 not",string) #(is, are)n't-->(is,are) not
        
        string<-gsub("([[:alnum:]]*)\\1've","\\1 have",string) #(I, they...)'ve--> (I, they...) have
        
        string<-gsub("([[:alnum:]]*)\\1'd","\\1 would",string) #(I, they)'d--> (I, they...) 
        #Approx. : "would"is more used than "had"
        
        string<-gsub("([[:alnum:]]*)\\1'll","\\1 will",string)#(I, they...)'ll-->(I, they...)will 
        #Ditto : "will" and "shall"
        
        string<-gsub("i'm","i am",string)#I'm-->I am
        
        string<-gsub("let's","let us",string)#let's-->let us
        
        string<-gsub("([[:alnum:]]*)\\1's","\\1 is",string)#(He, that...)'s-->(He, that...)is 
        
        string<-gsub("([[:alnum:]]*)\\1're","\\1 are",string) #'re---> are 
        
        #Remove URL's
        string<-gsub("(https?)?(://)?(www.)?[[:alnum:]]*(.com|.org|.fr)","",string)
        
        #Remove email adresses and public replies
        string<-gsub("([[:graph:]]*)?@([[:alnum:]]*)?(.com|.org|.fr)?","",string)
        
        #Remove hashtags
        string<-gsub("#[[:alnum:]]*","",string)
        
        #Remove Numbers
        string<-gsub("[[:digit:]]","",string)
        
        #Remove Punctuation
        #Preserve intra-word dashes and apostrophes
        string<-gsub("(\\w['-]\\w)|[[:punct:]]", "\\1", string)
        
        #Remove words with more than 2 same letters
        string<-gsub("-"," ",string)
        
        #remove extra-whitespaces
        string<-gsub("\\s+"," ",string)
        
        return(string)
        
}


#Decompose input in strings
decomp<-function(string,l){
        decomp<-tail(unlist(strsplit(string," ")),l)
        decomp<-paste0(decomp,collapse=" ")
        decomp<-paste0("^",decomp)
        return(decomp)
}



#Backoff algorithm
backoff<-function(string){
        
        string<-process(string)
        
        l<-length(unlist(strsplit(string," ")))
        
        dec_str<-c()
        
        for(i in 1:l){dec_str<-c(dec_str,decomp(string,i))}
        
        
        
        if(l>=5){
                
                data_match<-data.table(index=1:5,rbind(gram_2[grep(dec_str[1],gram_2$txt),][1,],
                                                       gram_3[grep(dec_str[2],gram_3$txt),][1,],
                                                       gram_4[grep(dec_str[3],gram_4$txt),][1,],
                                                       gram_5[grep(dec_str[4],gram_5$txt),][1,],
                                                       gram_6[grep(dec_str[5],gram_6$txt),][1,]))
                
                index<-which.max(data_match[data_match$freq>=1,]$index)
                
                prediction<-as.character(data_match$txt[index])
                
                prediction<-tail(unlist(strsplit(prediction," ")),1)
                
                if(is.null(prediction)){
                        
                        prediction<-"the"
                        return(prediction)
                }
                return(prediction)
                
        }
        
        
        if(l==4){
                
                
                
                
                data_match<-data.table(index=1:4,rbind(gram_2[grep(dec_str[1],gram_2$txt),][1,],
                                                       gram_3[grep(dec_str[2],gram_3$txt),][1,],
                                                       gram_4[grep(dec_str[3],gram_4$txt),][1,],
                                                       gram_5[grep(dec_str[4],gram_5$txt),][1,]))
                
                index<-which.max(data_match[data_match$freq>=1,]$index)
                
                prediction<-as.character(data_match$txt[index])
                
                prediction<-tail(unlist(strsplit(prediction," ")),1)
                
                
                if(is.null(prediction)){
                        
                        prediction<-"the" 
                        return(prediction)
                }
                
                return(prediction)
        }
        
        if(l==3){
                
                
                data_match<-data.table(index=1:3,rbind(gram_2[grep(dec_str[1],gram_2$txt),][1,],
                                                       gram_3[grep(dec_str[2],gram_3$txt),][1,],
                                                       gram_4[grep(dec_str[3],gram_4$txt),][1,]))
                
                index<-which.max(data_match[data_match$freq>=1,]$index)
                
                prediction<-as.character(data_match$txt[index])
                
                prediction<-tail(unlist(strsplit(prediction," ")),1)
                
                if(is.null(prediction)){
                        
                        prediction<-"the"
                        return(prediction)
                }
                
                return(prediction)
                
        }
        
        if(l==2){
                
                data_match<-data.table(index=1:2,rbind(gram_2[grep(dec_str[1],gram_2$txt),][1,],
                                                       gram_3[grep(dec_str[2],gram_3$txt),][1,]))
                
                index<-which.max(data_match[data_match$freq>=1,]$index)
                
                prediction<-as.character(data_match$txt[index])
                
                prediction<-tail(unlist(strsplit(prediction," ")),1)
                
                
                if(is.null(prediction)){
                        
                        prediction<-"the" 
                        return(prediction)
                }
                
                return(prediction)
                
                
        }
        
        if(l==1){
                
                data_match<-data.table(index=1,rbind(gram_2[grep(dec_str[1],gram_2$txt),][1,]))
                
                index<-which.max(data_match[data_match$freq>=1,]$index)
                
                prediction<-as.character(data_match$txt[index])
                
                prediction<-tail(unlist(strsplit(prediction," ")),1)
                
                if(is.null(prediction)){
                        
                        prediction<-"the" 
                        return(prediction)
                }
                return(prediction)
                
                
        }
        
}
