# --------------------------------------
# FUNCTION filebatchr
# required packages: none
# description: use for loop for batch processing
# inputs: file_names = list of file names
#         crunch_cols = list of columns to analyze in df
#         param_names = list of names of output objects
#.        fun = name of operations function
# outputs: output_df with rows for each data file
########################################
filebatchr <- function(file_names=NULL,
                          fun=NULL,
                          crunch_cols=NULL,
                          param_names=NULL){

  if(is.null(file_names)) return(print("no input"))
  
output_df <- as.data.frame(matrix(rep(NA,length(file_names)*length(param_names)),nrow=length(file_names),ncol=length(param_names)))
names(output_df)=param_names
  
  nobs <- rep(NA,length(file_names))
  for (i in 1:length(file_names)) {
    df <- read.table(file=file_names[[i]],
                     header=TRUE,
                     sep=",")
    . <- fun(df=df,
             crunch_cols=unlist(crunch_cols),
             param_names=param_names)
    
    output_df[i,] <- .
    nobs[i] <- nrow(df)
  }
  output_df
  # add initial metadata columns (ID,filename,nobs)
  output_df <- cbind(ID=1:length(file_names),file=basename(unlist(file_names)),nobs=nobs,output_df)
  




return(output_df)

} # end of function filebatchr
# --------------------------------------
 # filebatchr(file_names=file_names,
               # fun=crunch_data,
               # crunch_cols=crunch_cols,
               # param_names=param_names)