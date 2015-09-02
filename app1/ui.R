

#ui.R

library(shiny)
library(shinythemes)




shinyUI(fluidPage(
        theme=shinytheme("flatly"),
        
        titlePanel(h1("Word Guesser", align="center"),
                   windowTitle = "Data Science Capstone Project"),
        h4("(reading in your thoughts)", align="center"),
        br(),
        
        fluidRow(
                
                column(6, offset=3,
                       
                       tabsetPanel(type = "tabs",
                                   tabPanel("Standard",
                                            
                                            textInput("sentence1", label = "", value = ""),
                                            tags$head(tags$style(type="text/css", "#sentence1 {width: 600px;}")),
                                            
                                            fluidRow(
                                                    column(6,
                                                           actionButton("goButton", "Guess!"),
                                                           br(), br(),br()
                                                    ),
                                                    column(6,
                                                           p(textOutput("info1")),
                                                           h3(textOutput("pred1"))
                                                    )
                                            )
                                            
                                   ),
                                   tabPanel("Dynamic",
                                            
                                            textInput("sentence2", label = "", value = ""),
                                            tags$head(tags$style(type="text/css", "#sentence2 {width: 600px;}")),
                                            
                                            fluidRow(
                                                    column(6,
                                                           br(),br(),br()
                                                    ),
                                                    column(6,
                                                           p(textOutput("info2")),
                                                           h3(textOutput("pred2"))
                                                    )
                                            )
                                   )
                       )
                )
        ),
        
        
        br(),br(),
        
        fluidRow(
                column(5, offset=1,
                       
                       wellPanel(
                               h4("Instructions"),
                               
                               p("Just write something in the text box."),
                               p("In 'standard' mode, click on the button. In 'dynamic' mode, 
                                 the suggestion appears automatically."),
                               p("At this stage, english (US) is the only available language. Spanish, french,
                                 and german will be proposed soon.")
                              
                       )
                       
                ),
                column(5,
                       selectInput("lang",
                                   label = "Language",
                                   choices = list("English (US)" = "en_us",
                                                  "German" = "german",
                                                  "Italian" = "italian",
                                                  "French"= "french"),
                                   selected = "en_us")
                       
                       
                      
                      
                       
                       
                       
                )
        )
))