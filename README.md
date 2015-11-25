The aim of this project is to buy an app which accepts an input string and predicts the next word., as proposed by SwiftKey.

The present repository contains :
   - the initial scripts needed to get, clean and shape the data 
   - the code for building the app
   - a presentation of the app
   - a milestone report

The data used for the project is from the HC Corpora.   
Download HC Corpora : http://www.corpora.heliohost.org/download.html   
More information about the corpora :  http://www.corpora.heliohost.org/aboutcorpus.html   

The initial scripts 'script1', 'script2', 'script3' have to be executed in this order.   
'script1' is interested in loading, sampling and cleaning the documents.  
'script2' generates the n-grams which will be later used for the model.   
'script3' saves the environment with the data needed for the model and app.

Then, 'ui.R' and 'server.R' and 'app_script' perform the creation of the app. The app is optimized for mobiles and can be loaded in any browser.
It is available here : https://dahssarah.shinyapps.io/app1



