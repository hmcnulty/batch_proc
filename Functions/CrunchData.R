# --------------------------------------
# FUNCTION crunch_data
# required packages: none
# description: operate on a single data frame
# inputs: df = dataframe
#         crunch_cols = numeric list of columns to use
#.        param_names = character list of output labels
# outputs: results = list of output values 
########################################
crunch_data <- function(df=NULL,
                        crunch_cols=NULL,
                        param_names=NULL){

# assign parameter defaults
if (is.null(df) | is.null(crunch_cols) | is.null(param_names)) {
  df <- data.frame(runif(10),runif(10),runif(10))
  crunch_cols <- list(2,3)
  param_names <- list("avg","skew","weird")
}

# function body

avg <- mean(df[,crunch_cols[[1]]])
skew <- sum(df[,crunch_cols[[1]]] - avg)^3/nrow(df)
weird <- sum(df[,crunch_cols[[1]]]) + 
  sum(df[,crunch_cols[[2]]]) + pi

results <- list(avg,skew,weird)
names(results) <- param_names

return(results)

} # end of function crunch_data
# --------------------------------------
   # crunch_data()