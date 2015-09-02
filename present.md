Word Guesser
========================================================
author: Yoni DAHAN
date: 08/12/2015
transition: zoom

Description   
========================================================   
   
   



- An application which tries to read in your thoughts
- It accepts a sentence (e.g. "I need to think about")
- And suggests you the most probable next word ("it")  
- You can try it [here](https://dahssarah.shinyapps.io/app1)

Instructions
========================================================

- Choose either "Standard" or "Dynamic"
- Type a phrase in the text box
- In 'standard' mode, click on the 'Guess!' button
- The suggested word appears on the right
- English language only is available 


========================================================
![alt text](word_guesser.png)


About the Underlying Algorithm
========================================================
- Uses a *backoff* approach
- Looks for the most frequent corresponding *n-gram* (e.g. "I need to think about") 
- Then outputs the most probable word which follows ("it")
- If no *n-gram* is observed, it tries without the first word 
(e.g. "need to think about")
- Repeatedly, it suppresses context until finding 
- If no word is found, it outputs the most common one, "the"





