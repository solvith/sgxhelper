#' Get prices from yahoo
#' @import xts
#' @import quantmod
#'@return a environment . to access , e.g., getYahooPrice$INTC
#'@export
#'
#'
#'
getYahooPrice<-function (env,Symbols,
          from = "2007-01-01", to = Sys.Date(), ...) 
{
  getSymbols.yahoo(Symbols,env = env,from = from,to=to)
 
  return(env)
  
}


