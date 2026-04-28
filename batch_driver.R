# looking at how to do batch processing on multi-files
# 4/28/26
# Hannah Grace McNulty

#########################################
# use in terminal to make folders
# add_folder()
# add_folder("CleanedData/ToyDataFiles")

#build_function("create_toy_data_files")

#build_function("crunch_data")

#build_function("file_batch_r")


# load libraries
library(upscaler)
library(ggplot2)

set_up_log()

# load functions into memory - all at the same time
source_batch(folder = "Functions")

# create data
create_toy_data_files(nrow = 15, ncol = 10, nfiles = 8)

# create global variables
file_names <- as.list(list.files(pattern="\\.csv$",
           path="CleanedData/ToyDataFiles",
           full.names=TRUE))

crunch_cols <- list(4,5)
param_names <- list("avg","skew","weird")

#########
# use lapply to run it all with two lines of code
z <- lapply(file_names, read.table, sep = ",")
lapply(z, crunch_data)

# do the work in a for loop
output_df <- as.data.frame(matrix(rep(NA,length(file_names)*length(param_names)),nrow=length(file_names),ncol=length(param_names)))
names(output_df)=param_names
nobs <- rep(NA,length(file_names)) # empty vector for row counts
for (i in 1:length(file_names)) {
  df <- read.table(file=file_names[[i]],
                   header=TRUE,
                   sep=",")
  . <- crunch_data(df=df,
                   crunch_cols=unlist(crunch_cols),
                   param_names=param_names)

  output_df[i,] <- .
  nobs[i] <- nrow(df)
}
output_df
# add initial metadata columns (ID,filename,nobs)
output_df <- cbind(ID=1:length(file_names),file=basename(unlist(file_names)),nobs=nobs,output_df)

output_df
######


# this function will do everything the four loop and lapply did
filebatchr(file_names=file_names,
                fun=crunch_data,
                crunch_cols=crunch_cols,
                param_names=param_names)

