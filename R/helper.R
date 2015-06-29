#' Helper Function
#' @import jsonlite
#'@return something
#'@export


asJSON.zoo<-function(x){
  return(jsonlite::asJSON(data.frame(x)))
  
  
}