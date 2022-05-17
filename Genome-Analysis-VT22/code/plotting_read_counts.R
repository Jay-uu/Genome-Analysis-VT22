#Refined code for plotting expression
#Ran in rstudio locally
#For both sites I have excel files with sheets for each bin that passed the evaluation
#containing the locus tag and read count
#install.packages("readxl")                             # Install & load readxl package
library("readxl")
setwd("D:/Plugg/Genome Anlaysis/07_htseq")

sheet_names <- excel_sheets("D1_sorted_counts.xlsx")           # Get sheet names
#sheet_names                                            # Print sheet names
list_all <- lapply(sheet_names, function(x) {          # Read all sheets to list
  as.data.frame(read_excel("D1_sorted_counts.xlsx", sheet = x)) } )
names(list_all) <- sheet_names 

#Extracting only the read counts to a list
all_counts <- c()
print(all_counts)
i <-  1
for (sheet in list_all) {
  #comments were for testing
  #print('Loop: ')
  #print(i)
  new_list <- sheet$read_count
  old_list <- all_counts
  all_counts <- append(old_list, new_list)
  #str(all_counts)
  #i <- i +1
}
# convert to table, this will give me how many genes have the same amount of reads mapping back to them
count_table <- table(all_counts)
print(count_table) #for example, 7385 genes had no reads map back to them
#plot as a barplot because that was easiest to interpret visually
barplot(count_table, col = "palegreen3", xlab = "Read counts", ylab = "Number of genes", main = "Read expression of D1 bins")

# It could be easier to interpret it if I log-transform
log_count_table <- log(count_table+1) #because there's at least one gene for each frequency
barplot(log_count_table, col = "palegreen3", xlab = "Read counts", ylab = "Log amount of genes", main = "Log genes with read expression of D1 bins")

# wait that transforms number of genes
log_all_counts <- log(all_counts+1) #+1 to not have zeros
log_all_counts_table <- table(log_all_counts)
print(log_all_counts_table)
barplot(log_all_counts_table, col = "palegreen3", xlab = "Log read counts", ylab = "Number of genes", main = "Log read expression of D1 bins")


## Now for the D3 bins
# I should actually write functions for these steps, but time...
sheet_names <- excel_sheets("D3_sorted_counts.xlsx")           # Get sheet names
#sheet_names                                            # Print sheet names
list_all <- lapply(sheet_names, function(x) {          # Read all sheets to list
  as.data.frame(read_excel("D3_sorted_counts.xlsx", sheet = x)) } )
names(list_all) <- sheet_names 

#Extracting only the read counts to a list
all_counts <- c()
print(all_counts)
for (sheet in list_all) {
  new_list <- sheet$read_count
  old_list <- all_counts
  all_counts <- append(old_list, new_list)
}
# convert to table, this will give me how many genes have the same amount of reads mapping back to them
count_table <- table(all_counts)
print(count_table) #for example, 20917 genes had no reads map back to them
#plot as a barplot because that was easiest to interpret visually
barplot(count_table, col = "lightblue2", xlab = "Read counts", ylab = "Number of genes", main = "Read expression of D3 bins")

# It could be easier to interpret it if I log-transform
log_count_table <- log(count_table+1) #because there's at least one gene for each frequency
barplot(log_count_table, col = "lightblue2", xlab = "Read counts", ylab = "Log amount of genes", main = "Log genes with read expression of D3 bins")

# wait that transforms number of genes
log_all_counts <- log(all_counts+1) #+1 to not have zeros
log_all_counts_table <- table(log_all_counts)
print(log_all_counts_table)
barplot(log_all_counts_table, col = "lightblue2", xlab = "Log read counts", ylab = "Number of genes", main = "Log read expression of D3 bins")
