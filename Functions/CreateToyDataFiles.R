# --------------------------------------
# FUNCTION create_toy_data_files
# required packages: none
# description: build set of toy .csv files
# inputs: number of files,max rows,max col
# outputs: a set of .csv files in a new subfolder
########################################
create_toy_data_files <- function(nrow=NULL,
                               ncol=NULL,
                               nfiles=NULL){
  
  # assign parameter defaults
  if (is.null(nrow) | is.null(ncol) | is.null(nfiles)){
    nrow=10
    ncol=9
    nfiles=6
  }
  
  # build file labels
  file_labels <- upscaler::create_padded_labels(n=nfiles,
                                      string="Toy_Data",
                                      suffix=".csv") 
  
  # run for loop
  
  for (i in 1:nfiles) {
    df <- as.data.frame(matrix(runif(nrow*ncol),
                               nrow=nrow,
                               ncol=ncol))
    write.table(df,file=paste("CleanedData/ToyDataFiles/",
                              file_labels[i],sep=""),
                              sep=",")
    
  }
  
  
  
  
  return()
  
} # end of function CreateToyDataFiles
# --------------------------------------
# create_toy_data_files()