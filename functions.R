# Produce content and functions for ui and server

  #---------------------------------------
  
  # Load packages (only matters for publishing on shiny.io)
  library(pacman)
  library(ggplot2)
  library(gfonts)
  library(formattable)
  library(shiny)
  library(tidyverse)
  library(lubridate)
  library(shinyjs)
  library(readxl)
  library(rsconnect)
  library(DT)
  library(htmltools)
  library(readtext)

  #----------------------------------------

  # Fonts, Colors, and Icons 

    #Set up font
    use_font("roboto", "www/css/roboto.css")
    
    #Set up colors: first action, then days
    notstarted_color <- "whiteSmoke"
    progress_color <- "#fdb927"
    complete_color <- "#199eb4"
    remaining_color <- "whiteSmoke"
    current_color <- "#fdb927"
    past_color <- "DimGrey"
    
    #Create icons for priority areas
    gicon <- function(x) as.character(icon(x))
    safety <- gicon("ambulance")
    finance <- gicon("money-check-alt")
    education <- gicon("chalkboard-teacher")
    health <- gicon("hospital-user")
    governance <- gicon("landmark")
    equity1 <- gicon("hands-helping")
    
    #Create icons for the app layout
    see_more <- gicon("chevron-down")
    contact_us <- gicon("envelope")
    download <- gicon("file-download")
    
    #Create color palettes for trackers
    ggpalette1 <- cbind(
      c(complete_color,progress_color,notstarted_color),
      c("Complete","In Progress","Not Yet Started")
    )
    
    ggpalette2 <- cbind(
      c(past_color,current_color,remaining_color),
      c("Past","Current","Remaining")
    )

    #------------------------------------
    
    # Create Functions & Definitions
    
    # Creating a function for the days remaining graphic
    past <- function(date) {
     ifelse(date > today(), "Remaining", ifelse(date == today(), "Current","Past"))
    }
    
    # Progress bar unit style
    progressUnitStyle <- "float:left;margin-left:1px;width:14px;height:14px;padding-bottom:0px;margin-top:2px;"
    
    # Function for determining status symbol
    symbolColor <- function(status) {
      return(ifelse(tolower(status) == "in progress", 
        progress_color,
        ifelse(tolower(status) == "complete",
          complete_color,
          notstarted_color)))
    }
    
    # Function for returning an HTML div with a color-coded square for status plus status text
    symbol <- function(status) {
      tempDiv <- paste0("<div style=\"", progressUnitStyle,"background-color:", symbolColor(status),"\"></div>")
      return(paste(tempDiv, status))
    }
    
    # Function for creating progress bar for each priority area
    priorityAreaProgressBar <- function(data) {
      tempData <- paste(unlist(paste0(sapply(sapply(sapply(data, "[[", 2), FUN=strsplit, "</div>"), "[[", 1), "</div>")), collapse='')
      return(tempData)
    }
