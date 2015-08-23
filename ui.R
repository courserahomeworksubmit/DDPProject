library(shiny)

shinyUI ( pageWithSidebar ( 
     headerPanel ( "Slider labels" ) , 
     sidebarPanel ( 
         h5 ( "First Input your nick name!") ,
         textInput ( "nick" , "Nick name" , value = "" ) ,
         h5 ( "Sample size is denoted by M." ) ,
         h5 ( "The number of experiments is denoted by L." ) ,
         sliderInput ( "M" , "log2 ( M )" , min = 1 , max = 16 , value = 5 , step = 1, ticks = TRUE ) , 
         sliderInput ( "L" , "log2 ( L )" , min = 1 , max = 16 , value = 14, step = 1, ticks = TRUE ) , 
         sliderInput ( "lambda", "the rate" , value = 0.25 , min = 0.25, max = 4, step = 0.25 ) ,
         submitButton ( "Submit" ) ,
         p ( ) ,
         h2 ( "Description" ) ,
         p ( "This app is meant to simulate the central limit 
             theorem using samples from the exponential distribution.") ,
         h2 ( "Inputs" ) ,
         p ("There is a text input for your nick name. There are three slider inputs for this app:
            M: the sample size, L: the number of experiments, 
            the rate: the rate parameter for the exponential distribution.
            Allowed values of M and L are powers of 2. The rate parameter moves by 0.25.") ,
         h2 ( "The outputs") ,
         p ( "There is a table output consisting of the input parameters.
             A plot is generated to illustrate the central limit theorem consisting of
             relative histogram of sample mean, p.d.f. of approximating normal random variable
             mean of sample mean and theoretical mean. Some calculations will be shown to compare the
             experiment and theory.
             The outputs are regenerated whenever any of the inputs is changed." )
       ) , 
    mainPanel ( 
         h4 ( "Input parameters") ,
         br ( ) ,
         tableOutput ( "values" ) ,
         h4 ( "Distribution of sample mean") ,
         br ( ) ,
         plotOutput ( "sampleMean" ) ,
         h4 ( "Calculated values") ,
         br ( ) ,
         tableOutput ( "calculated" ) 
       ) 
 ) 
) 

