#' Get prices from google including intraday
#' @import quantmod
#' @import xts
#' @import TTR
#'@return a data table of all the financials data
#'@export

#intraday (15 mins delay)
getGooglePrice<- function(symbol, freq=60, period='1d',exchng='SGX',tz='Asia/Singapore') {
  base.url <- 'http://www.google.com/finance/getprices?'
  options.url <- paste('i=', freq, '&p=', period, '&f=d,o,h,l,c,v&df=cpct&q=', symbol,'&x=',exchng,sep = '')
  full.url <- paste(base.url, options.url, sep = '')
  
  data <- read.csv(full.url, skip = 7, header = FALSE, stringsAsFactors = FALSE)
  
  starting.times.idx <- which(substring(data$V1, 1, 1) == 'a')
  ending.seconds.idx <- c(starting.times.idx[-1] - 1, nrow(data))
  r.str.idx.use <- paste(starting.times.idx, ':', ending.seconds.idx, sep = '')
  
  starting.times <- as.numeric(substring(data[starting.times.idx, 1], 2))
  
  data[starting.times.idx, 1] <- 0
  clean.idx <- do.call(c, lapply(seq(1, length(r.str.idx.use)),
                                 function(i) {
                                   starting.times[i] + freq * as.numeric(data[eval(parse(text = r.str.idx.use[i])), 1])
                                 })
  )
  
  if (all(is.na(data[1,-1]))){
    data.xts <- xts(data[2:nrow(data),-1], as.POSIXct(clean.idx, origin = '1970-01-01', tz = 'GMT'))
    
  }else{
    data.xts <- xts(data[,-1], as.POSIXct(clean.idx, origin = '1970-01-01', tz = 'GMT'))
  }
  indexTZ(data.xts) <- tz
  colnames(data.xts) <- c('Open', 'High', 'Low', 'Close', 'Volume')
  
  return(data.xts)
}