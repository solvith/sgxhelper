#' Get prices from yahoo
#' @import XML
#' @import data.table
#'@return a data table of all the financials data
#'@export
#'
#'
#'


getWSJFinancials<-function(ticker,interval="quarter"){
  
  download<-readHTMLTable(paste("http://quotes.wsj.com/SG/",ticker,"/financials/",interval,"/cash-flow",sep = ""))
  
  
  rtable<-data.table()
  
  for (j in length(download)){
    
    table<-download[[j]]
    
    for(i in 1:(length(download[[1]])-2)){
      month<-colnames(table[i+1])
      table[i+1]<-setNames(table[i+1],"")
      
      row<-data.table(ticker,setNames(table[1],""),table[i+1],month)
      setNames(row,c("ticker","variable","value","quarter"))
      
      
      rtable<-rbind(rtable,row)
      
    }
    
    
  }
  
  download<-readHTMLTable(paste("http://quotes.wsj.com/SG/",ticker,"/financials/",interval,"/income-statement",sep = ""))
  
  for (j in length(download)){
    
    table<-download[[j]]
    
    for(i in 1:(length(download[[1]])-2)){
      month<-colnames(table[i+1])
      table[i+1]<-setNames(table[i+1],"")
      
      row<-data.table(ticker,setNames(table[1],""),table[i+1],month)
      setNames(row,c("ticker","variable","value","quarter"))
      
      
      rtable<-rbind(rtable,row)
      
    }
    
    
  }
  
  
  download<-readHTMLTable(paste("http://quotes.wsj.com/SG/",ticker,"/financials/",interval,"/balance-sheet",sep = ""))
  
  for (j in length(download)){
    
    table<-download[[j]]
    
    for(i in 1:(length(download[[1]])-2)){
      month<-colnames(table[i+1])
      table[i+1]<-setNames(table[i+1],"")
      
      row<-data.table(ticker,setNames(table[1],""),table[i+1],month)
      setNames(row,c("ticker","variable","value","quarter"))
      
      
      rtable<-rbind(rtable,row)
      
    }
    
    
  }
 
  return(rtable)
  
}


