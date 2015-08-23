library(shiny)
library(UsingR)

shinyServer ( function ( input , output ) {
  
  #
  # * This variable will be a communication channel between renderers.
  #   The initial value is not crucial.
  #
  
  x0 <- 0
  
  get_x0 <- function ( )
  {
    x0
  }
  
  set_x0 <- function ( x1 )
  {
    x0 <<- x1
  }
  
  output$values <- renderTable ( {
    
    M0 <- 2 ^ ( as.numeric ( input$M ) )
    L0 <- 2 ^ ( as.numeric ( input$L ) )
    lambda0 <- as.numeric ( input$lambda )
    
    data.frame (
      Name = c ( "Nick name" , "Sample size" , "Number of Experiments", "Rate parameter" ) ,
      Value = as.character( c ( input$nick  , M0 , L0 , lambda0 ) ) ,
      stringsAsFactors = FALSE
    )
  } )
  
    
  output$sampleMean <- renderPlot ( {
    
    M0 <- 2 ^ ( as.numeric ( input$M ) )
    L0 <- 2 ^ ( as.numeric ( input$L ) )
    lambda0 <- as.numeric ( input$lambda )
    
    rvexp <- t ( matrix ( rexp ( M0 * L0 , rate = lambda0 ) , nrow = M0 , ncol = L0 ) )
    
    smean <- apply ( rvexp , 1 , mean )
    
    t_hist <- "Sample mean vs theoretical mean"
    xl <- "val."
    yl <- "rel. freq."
    a <- min ( smean ) ; b <- max ( smean ) ; Num <- 128 ; d <- ( b - a ) / Num
    x <- seq ( a , b , d )
    y <- dnorm ( x , mean = ( 1 / lambda0 ) , sd = ( 1 / sqrt ( lambda0 * M0 ) ) )
    mean_smean <- mean ( smean )
    
    set_x0 ( mean_smean )
    
    colors <- c ( "black" , "red" , "blue" , "green" )
    leg <- c ( "Rel. freq." , "Theoretical mean" , "Normal distribution" , "mean of sample means" )
    
    hist ( smean , freq = FALSE , breaks = 40 , main = t_hist , xlab = xl , ylab = yl )
    abline ( v = ( 1 / lambda0 ) , col = "red" , lwd = 1 )
    abline ( v = mean_smean , col = "green" , lwd = 1 )
    lines ( x , y , col = "blue" , lwd = 0.5 , type = "o" , cex = 0.25 )
    legend ( "topright" , pch = 1 , col = colors , leg , cex = 1  )
  }
  )
  
  output$calculated <- renderTable ( {
    
    M0 <- 2 ^ ( as.numeric ( input$M ) )
    L0 <- 2 ^ ( as.numeric ( input$L ) )
    lambda0 <- as.numeric ( input$lambda )
    
    data.frame (
      Name = c ( "Population mean" , "Mean of sample mean" , "Theoretical mean" , "Theoretical standard deviation" ) ,
      Value = as.character ( c ( 1 / lambda0 , get_x0 ( ) , 1 / lambda0 , 1 / sqrt ( lambda0 * M0 ) ) ) ,
      stringsAsFactors = FALSE
    )
    
  } )
  
} )