#'Get list of all stocks in SGX
#'Returns a datatable
#'@return a datatable of all SGX stocks
#'@export
#'@import RCurl
#'@import rjson
#'@import data.table

getSGXStocks<-function(){
  

  allstocks<-getURL("http://sgx-api.wealthmsi.com/sgx/search?callback=jQuery111001200784060638398_1429771730075&json=%7B%22criteria%22%3A%5B%5D%7D")
  allstocks<-gsub("jQuery111001200784060638398_1429771730075\\(|\\);","",allstocks)
  allstocks<-fromJSON(allstocks)
  stocksdata<-list()
  lapply(1:length(allstocks$companies)
         ,function(index){
           
           row<-allstocks$companies[[index]]
           dt<-data.frame(row)
           
           stocksdata[[index]]<<-dt
           
           
           return(row$tickerCode)
         })
  
  
  return(rbindlist(stocksdata,fill = T))
}

