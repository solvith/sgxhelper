###############################################################################
# Install Systematic Investor Toolbox (SIT) package
# github.com/systematicinvestor/SIT
###############################################################################
library(curl)
curl_download('http://www.systematicportfolio.com/SIT.tar.gz', 'sit',mode = 'wb',quiet=T)
install.packages('sit', repos = NULL, type='source')

library(SIT)
load.packages('quantmod')

tickers = nasdaq.100.components()
tickers = sp500.components()$tickers


data = env()
getSymbols.extra(tickers, src = 'yahoo', from = '1970-01-01', env = data, auto.assign = T)

#Get all Stocks
#http://54.254.221.141/sgx/search?callback=jQuery111001200784060638398_1429771730075&json=%7B%22criteria%22%3A%5B%5D%7D&_=1429771730079

#get individual stocks
#http://54.254.221.141/sgx/company?callback=jQuery111007156689828261733_1429864044658&json=%7B%22id%22%3A%22MS7%22%7D&_=1429864044659

#Get financials
#http://54.254.221.141/sgx/company/financials?callback=remove&json=%7B%22id%22%3A%22MS7%22%7D&_=1429855452486

#Get price history
#http://54.254.221.141/sgx/company/priceHistory?callback=jQuery111007156689828261733_1429864044661&json=%7B%22id%22%3A%22MS7%22%7D&_=1429864044662

require(RCurl)
require(rjson)
require(data.table)

#GEt list of all stocks in SGX

getSGXStocks<-function(){
allstocks<-getURL("http://54.254.221.141/sgx/search?callback=jQuery111001200784060638398_1429771730075&json=%7B%22criteria%22%3A%5B%5D%7D")
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





#Testit
allstocks<-getSGXStocks()
