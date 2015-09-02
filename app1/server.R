#server.R

app_dir<-"./app1"

load("data/grams.RData", envir=.GlobalEnv)
source("app_script.R")
library(data.table)


pred <- function(sentence, lang) {
        if (lang == "en_us") {
                return(backoff(sentence))
        } else if (lang == "german") {
                return("ich bin ein berliner")
        } else if (lang == "italian") {
                return("belle parole non pascon i gatti")
        } else if(lang=="spanish"){
                return("a buen entendedor, pocas palabras bastan")
        } else if(lang=="french"){
                return("les violons de l'automne")
        }
        
}

shinyServer(function(input, output) {
        
        phraseGo <- eventReactive(input$goButton, {
                input$sentence1
        })
        output$info1 <- renderText({
                nwords <- length(strsplit(input$sentence1," ")[[1]])
                nchars <- nchar(input$sentence1)
                paste(nwords, " words and ", nchars, "characters")
        })
        output$pred1 <- renderText({
                result <- pred(phraseGo(), input$lang)

                paste0(result)
        })
        output$info2 <- renderText({
                nwords <- length(strsplit(input$sentence2," ")[[1]])
                nchars <- nchar(input$sentence2)
                paste(nwords, " words and ", nchars, "characters")
        })
        output$pred2 <- renderText({
                result <- pred(input$sentence2, input$lang)
                paste0(result)
        })
        
})