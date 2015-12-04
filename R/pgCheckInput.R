# Constructor function for the class
library(Biobase)
library(reshape)
pgError <- function(title, msg = "", url = "", msgFun = NULL)  {
  # Do something here with x, args and put in something
  object <- list(title = title, url = url, msgFun = msgFun)   
  class(object) <- "pgError"
  return (object)
}

check = function(object, data, ...){
  UseMethod("check", object)  
}

check.pgError = function(object, x, ...){
  msg = object$msgFun(x, ...)
  if(!is.null(msg)){
      stop(paste(object$title,": ", msg, " Check the PamCloud for more information on this error message."))
  }  
}

openURL= function(object){
  UseMethod("openURL", object)  
}
openURL.pgError = function(object){
  browseURL(object$url)  
}

#defined checks
EmptyCells   = pgError(title = "Missing values are not allowed",
                       url = "https://pamcloud.pamgene.com/wiki/Wiki.jsp?page=Missing%20values%20are%20not%20allowed",
                       msgFun = function(aCube){
                         msg = "The data contains missing values, 
                                make sure that the Cross-tab Window does 
                                not contain any empty Data Cells."
                         
                         aFrame = pData(aCube)
                         X = cast(aFrame, rowSeq ~ colSeq, value = "value")
                         if(any(is.na(X))){
                           return(msg)
                         }else{
                           return(NULL)
                         }
                         
                       })

MultipleValuesPerCell = pgError(title = "Multiple values per Data Cell are not allowed",
                                msgFun = function(aCube){
                                  msg = "make sure that every Data Cell in the Cross-tab Window contains not more than a single value."
                                  count = cast(pData(aCube), rowSeq~colSeq, value = "value", fun.aggregate = length)
                                    if(any(count>1)){
                                      return(msg)
                                    } else {
                                      return(NULL)
                                    }
                                  },
                                url = "https://pamcloud.pamgene.com/wiki/Wiki.jsp?page=Multiple%20values%20per%20Data%20Cell%20are%20not%20allowed"
                          )

ExactNumberOfFactors = pgError(title = "Incorrect number of factors",
                                  msgFun = function(aCube, groupingType, nFactors = 1, altGroupingName = NULL){
                                    metaData <- varMetadata(aCube)
                                    factors =  colnames(pData(aCube))[metaData$groupingType== groupingType]
                                    if (length(factors) != nFactors){
                                      if (is.null(altGroupingName)){
                                        groupingName = groupingType
                                      } else {
                                        groupingName = altGroupingName
                                      }                                   
                                      msg = paste("Exactly ", nFactors, " factor(s) are required for: ", groupingName,".", sep ="")
                                    } else {
                                      msg = NULL
                                    }
                                    return(msg)
                                   }, url = "https://pamcloud.pamgene.com/wiki/Wiki.jsp?page=Incorrect%20Number%20of%20Factors")
                               



