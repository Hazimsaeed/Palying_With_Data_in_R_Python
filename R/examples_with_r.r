#In this project I try to use as much function as possible of R langauge
#This project has six Stages.
#The frist stage is loading a CSV data set.
#The data set has information about ties such as: Brand, Price, Material..ect
#In Stage two I tried to describe the data by reading the header of the data set to 
#know the describtion provided, then show the length of the data by counting rows.
#After that I print the total value of the ties by summation the prices of all ties in the data set. 
#Additinally, I calculate the avarage price for all ties, then I calculated the avarage price 
#for the first half of the data set and the second half of the data set.
#To rap up the the second stage I calcualted the Highest Priced and Lowest Priced.
#In the second stage I cleaned the data by adding boolean field, then I filter 
# the data base on the brand name, material and prices.Finally I grouped the data 
# by calculating the highest price for spacific brands and the avarage price by type using grepl function.
#Stage four I tried to the different type and method to export data sets in different shape and style.
#In stage five I export the data in different types of graghs such as : Line, Bar, Tables graghs. 
#I also listed all some barnd avarage price with th lowest price to give idea if there is a discount for the brand.
#The final Stage, Stage six I export the some graphs to PDF file and edit the titles and axes labels.
  
#Requirment:
#for the R project I installed the following packages:
#1- xlsx -- to export to excel. 
#2- ggplot2 -- to plot table.
#for the python project I installed the following packages:
#1- numpy
#2- matplotlib
 
cat("\n Projects has four stages as below:\n")
cat("\n\t>>>STAGE 1 \n")
cat("\n\t>>>STAGE 2: Describing Data\n")
cat("\n\t>>>STAGE 3: Cleaning data\n")
cat("\n\t>>>STAGE 4: Exporting\n")
cat("\n\t>>>STAGE 5: Creating Charts and Tables\n")
cat("\n\t>>>STAGE 6: Creating PDF Reports\n")

cat("\n>>>STAGE 1 \n")
cat("\t- set working dir and global output formate")
# Stage 1: set working dir and global output formate
# #
# Set working dir
# --------------------------------------
setwd("C:\\Users\\Habdelrahman\\Downloads\\Project\\R")
#set options to round output
options(digits = 3, warn = -1)

cat("\n>>>STAGE 2: Describing Data\n")
cat("\t- A. Loading raw data into data structure(s)\n")
cat("\t- B. Calculate descriptive Stats \n\t(Max, Min, Median, Mean, Sums and Totals)")
# --------------------------------------

# Stage 2: Describing Data
# # 
# A. Loading raw data into data structure(s)
# B. Calculate descriptive Stats
# - Max, Min, Median, Mean, Sums and Totals


### Loading data 
cat("\nPart A. Loading the data ")

sample_file = 'data.csv' 

## 1. read in the data captured using the R CSV module
data_from_csv = read.csv(sample_file, encoding = "UTF-8", sep = "\t")
cat("\n\tThe header contains these fields: \n\t", colnames(data_from_csv))

cat("\nPart B. describe data")
cat("\n\t B.1. Show size of dataset\n")
# Calculating descriptive stats by showing the length of a list
# How many rows are there? 

cat(paste("\t\tLength: ", nrow(data_from_csv)+1, "rows in", sample_file, "including header"))

# Sums of all the prices
cat("\n\t B.2 Calculating Sum")
cat(paste("\n\t\tThe Sum: $", sum(data_from_csv$priceLabel)))

# Average of all the prices
cat("\n\t B.3 Calculating Average")
cat(paste("\n\t\tThe Average:", mean(data_from_csv$priceLabel)))

# Average of first half and last half
midpoint = round(nrow(data_from_csv)/2)
cat(paste("\n\t\tThe Average of first half", mean(data_from_csv$priceLabel[1:midpoint])))
cat(paste("\n\t\tThe Average of last half", mean(data_from_csv$priceLabel[-c(1:midpoint)])))

# The Max and the Min Tie prices
cat("\n\t B.4 Calculating the Max and the Min")
cat(paste("\n\t\tHighest Priced Tie: $", max(data_from_csv$priceLabel), 
          "\n\t\tLowest Priced Tie: $", min(data_from_csv$priceLabel) ))

		  
cat("\n>>>STAGE 3: Cleaning data\n")
cat("\t- A. Cleaning Data\n")
cat("\t- B. Filtering Rows\n")
cat("\t- C. Grouping columns\n")
# --------------------------------------
# Stage 3: Cleaning data
# 
# A. Cleaning Data
# B. Filtering Rows
# C. Grouping columns
###

### Cleaning data
cat("\npart A. Cleaning data")

# find cashmere ties
my_improved_csv = grepl("cashmere", as.character(data_from_csv$desc))
cat("\t",sum(as.numeric(my_improved_csv)), "ties made with cashmere")

# add boolean fields
number_cashmere_ties = data_from_csv[my_improved_csv,11]
cat("\tFiltering for correct count by counting boolean fields:\n\t",length( number_cashmere_ties),"ties made with cashmere")


cat("\npart B. Filtering rows")

### Filtering Ties by string
cat("\n\tpart B.1 Filtering rows by brand")

# Look at ties of brand Hermes vs JCrew
hermes_ties = data_from_csv[grepl('Hermes', as.character(data_from_csv$brandName)),]
jcrew_ties = data_from_csv[grepl('J.Crew', as.character(data_from_csv$brandName)),]
cat("\n\t\tFound ", nrow(hermes_ties), "Hermes Ties")
cat("\n\t\tFound ", nrow(jcrew_ties), "J.Crew Ties")

cat("\n\tpart B.2 Filtering rows by material")
# Only look at rows of "silk" ties or only "wool"
silk_ties = data_from_csv[grepl('silk', as.character(data_from_csv$material)),]
wool_ties = data_from_csv[grepl('wool', as.character(data_from_csv$material)),]
cat(paste("\n\t\tFound ", nrow(silk_ties), "Silk Ties"))
cat(paste("\n\t\tFound ", nrow(wool_ties), "Wool Ties"))

# Look at ties < $20 vs ties over $100
cat("\n\tpart B.3 Filtering rows by price")
under_20_dollars = data_from_csv[which(data_from_csv$priceLabel<=20),]
over_100_dollars = data_from_csv[which(data_from_csv$priceLabel>100),]
cat(paste("\n\t\tFound ", nrow(under_20_dollars), " ties < $20"))
cat(paste("\n\t\tFound ", nrow(over_100_dollars), " ties > $100"))

cat("\npart C. Grouping rows")
# Compare Maximum Prices
max_hermes_tie_price = max(hermes_ties$priceLabel)
max_jcrew_tie_price = max(jcrew_ties$priceLabel)
cat(paste("\n\tMaximum Hermes Tie Price is: ", max_hermes_tie_price))
cat(paste("\n\tMaximum J.Crew Tie Price is: ", max_jcrew_tie_price))

# Printed vs Solid. Are the printed ties cheaper? 
avg_print_ties = mean(data_from_csv[grepl("_print", as.character(data_from_csv$striped)), "priceLabel"])
avg_paisley_ties = mean(data_from_csv[grepl("_paisley", as.character(data_from_csv$striped)), "priceLabel"])
avg_striped_ties = mean(data_from_csv[grepl("_striped", as.character(data_from_csv$striped)), "priceLabel"])
avg_solid_ties = mean(data_from_csv[grepl("_solid", as.character(data_from_csv$striped)), "priceLabel"])
cat(paste("\n\tAvg Print ties price $", avg_print_ties))
cat(paste("\n\tAvg Paisley ties price $", avg_paisley_ties))
cat(paste("\n\tAvg Stripes ties price $", avg_striped_ties))
cat(paste("\n\tAvg Solid ties price $", avg_solid_ties))


cat("\n>>>STAGE 4: Exporting\n")
cat("\t- A. Exporting data base on type\n")
cat("\t- B. Exporting some columns from the data\n")
cat("\t- C. Exporting data based on Min and Max\n")
cat("\t- D. Exporting data sorted\n")
cat("\t- E. Exporting to Excel\n")
cat("\t\t- 1. Install packages 'xlsx' \n")
cat("\t\t- 2. load library 'xlsx' \n")
cat("\t\t- 3. Export and write .xlsx file \n")
# --------------------------------------
###
# Stage 4: Exporting
# 
# CSV or TSV
# Excel
###

# Exporting CSV Files
cat("\npart A. Exporting CSV Files for hermes and jcrew")
## Export Hermes Ties
if(!exists("./data")) dir.create("./data")
write.csv(hermes_ties, "./data/hermes.csv", row.names = FALSE)
cat("\n\t hermes.csv Export in folder named 'data'")
## Export JCrew Ties
write.csv(jcrew_ties, "./data/jcrew.csv", row.names = FALSE)
cat("\n\t jcrew.csv Exported in folder named 'data'")

cat("\npart B.1 Exporting CSV Files have column brandId, priceLabel for hermes")
#save two columns
write.csv(hermes_ties[, c("brandId", "priceLabel")], "./data/hermes_brandId_priceLabel.csv", row.names = FALSE)
cat("\n\t hermes_brandId_priceLabel.csv Exported in folder named 'data'")

cat("\npart B.2 Exporting CSV Files have column name, desc for hermes")
#save two columns uuseing different method
write.csv(hermes_ties[, c(4, 8)], './data/hermes_name_desc.csv', row.names = FALSE)
cat("\n\t hermes_name_desc.csv Exported in folder named 'data'")

cat("\npart C. Exporting CSV hermes and jcrew ties that match max and min price for each ")
#max and min price for hermes
write.csv(hermes_ties[which(hermes_ties$priceLabel == max(hermes_ties$priceLabel) | hermes_ties$priceLabel == min(hermes_ties$priceLabel)),], 
                      './data/min_max.csv', row.names = FALSE)
cat("\n\t Hermes min, max exported in min_max.csv in folder named 'data'")

# bind jcrew max and min price to existing CSV		  
write.csv(rbind(read.csv('./data/min_max.csv'), jcrew_ties[
		which(jcrew_ties$priceLabel == max(jcrew_ties$priceLabel) | jcrew_ties$priceLabel == min(jcrew_ties$priceLabel)),]),
			'./data/min_max.csv', row.names = FALSE)
cat("\n\t jcrew min, max append to min_max.csv in folder named 'data'")

cat("\npart D. Exporting sorted jcrew CSV by pricelable")
# write jcrew ties in CSV sorted by pricelable
write.csv(jcrew_ties[order(jcrew_ties$priceLabel, decreasing = FALSE),], './data/jcrew_sorted_by_price.csv', row.names = FALSE)
cat("\n\t jcrew_sorted_by_price.csv Exported in folder named 'data'")

# Exporting to Excel
cat("\npart E. Exporting kiton ties to Excel")

cat("\t 1. Install packages 'xlsx' \n")
#install xlsx packages if not installed 
if(!"xlsx" %in% installed.packages()) install.packages("xlsx")
cat("\t\tpackage installed... \n")

cat("\t- 2. load library 'xlsx' \n")
#load xlsx library
library("xlsx")
cat("\t\tlibrary loaded... \n")

cat("\t- 3. Export and write .xlsx file \n")
# reusing a function before to grab a new data sample
kiton_ties = data_from_csv[which(data_from_csv$brandName == 'Kiton'),]
write.xlsx(kiton_ties, './data/kiton.xlsx', row.names = FALSE)
cat("\n\t\t kiton.xlsx Exported in folder named 'data'")


cat("\n>>>STAGE 5: Creating Charts and Tables\n")
cat("\t- A. Line charts\n")
cat("\t- B. Bar charts\n")
cat("\t- C. Tables\n")
cat("\t\t- 1. Install packages 'ggplot2' \n")
cat("\t\t- 2. load library 'ggplot2' \n")
cat("\t\t- 3. Install packages 'gridExtra' \n")
cat("\t\t- 4. load library 'gridExtra' \n")
cat("\t\t- 5. Craete Table has all brand and quintaty grouped by price' \n")
cat("\t- D. List Avg of list of brands and the min tie price for each brand \n")
# --------------------------------------
# ###
# Stage 5: Charts and Tables
# Line Charts
# Bar Charts
# Tables
###

# Line charts
cat("\npart A. Line Charts")

# create dirctory charts if not exist
if(!exists("./charts")) dir.create("./charts")

#craete line_hermes.png to handel the chart 
png("./charts/line_hermes.png")
#plot chart into png file  
plot(sort(hermes_ties$priceLabel), type = 's,S', 
     main ="Distribution of Prices for Hermes Ties", xlab = 'Tie Price ($)', ylab = 'Number of Ties', col = 'blue', lwd = 2)
# To write the ploting in the .png file	 
dev.off()
cat(".\n\t line_hermes.png created")

#craete line_jcrew.png to handel the chart
png("./charts/line_jcrew.png")
#plot chart into png file  
plot(sort(hermes_ties$priceLabel), type = 'o', 
     main ="Distribution of Prices for J.Crew Ties",  xlab = 'Tie Price ($)', ylab = 'Number of Ties', col = 'blue', lwd = 2)
# To write the ploting in the .png file	
dev.off()
cat(".\n\t line_jcrew.png created")
#craete line_kiton.png to handel the chart
png("./charts/line_kiton.png")
#plot chart into png file
plot(sort(kiton_ties$priceLabel), type = 'o', 
     main ="Distribution of Prices for Kiton Ties",  xlab = 'Tie Price ($)', ylab = 'Number of Ties', col = 'blue', lwd = 2)
# To write the ploting in the .png file
dev.off()
cat(".\n\t line_kiton.png created")


# Bar charts
cat("\npart B. Bar charts")
#craete all_prices.png to handel the chart
png("./charts/all_prices.png")
#plot chart into png file
plot(data_from_csv$priceLabel,  main ="Distribution of Prices for all Ties", 
        xlab = 'Tie Price ($)', ylab = 'Number of Prices', type = 'h')
# To write the ploting in the .png file
dev.off()
cat(".\n\t all_prices.png created")

# create the group or prices 
columns = c("$0-50", "$50-100", "$100-150", "$150-200", "$200-250", "$250+")
#craete price_in_groups.png to handel the chart
png("./charts/price_in_groups.png")
#plot chart into png file
barplot(table(cut(data_from_csv$priceLabel, breaks = c(seq(0, 250, by = 50), Inf), labels = columns)),  main ="Distribution of Prices for all Ties by ranges", 
        xlab = 'Tie Prices in groups ($)', ylab = 'Number of Ties', col = 1:6)
# write the ploting in the .png file
dev.off()
cat(".\n\t price_in_groups.png created")


# Tables
cat("\npart C. Tables")
cat("\t\t- 1. Install packages 'ggplot2' \n")
# intstall ggplot2 if not installed
if(!"ggplot2" %in% installed.packages()) install.packages("ggplot2")

cat("\t\t- 2. load library 'ggplot2' \n")
# Load ggplot2
library(ggplot2)

cat("\t\t- 3. Install packages 'gridExtra' \n")
# intstall gridExtra if not installed
if(!"gridExtra" %in% installed.packages()) install.packages("gridExtra")

cat("\t\t- 4. load library 'gridExtra' \n")
# Load gridExtra
library(gridExtra)


cat("\t\t- 5. Craete Table has all brand and quintaty grouped by price' \n")
# real all brandName from the CSV file
brands = data_from_csv[,'brandName']
# create the group or prices 
columns = c("$0-50", "$50-100", "$100-150", "$150-200", "$200-250", "$250+")
# select the brandName and priceLabel and put them in variable
brand_and_price_data = (data_from_csv[, c("brandName", "priceLabel")])
# select the quintaty or ties base in the group of prices
brand_and_price_data$priceLabel <- cut(brand_and_price_data$priceLabel, breaks = c(seq(0, 250, by = 50), Inf), labels = columns)
t <- table(brand_and_price_data$brandName, brand_and_price_data$priceLabel)
#craete table.png to handel the chart
png("./charts/table.png", height=3700, width=600)
#plot chart into png file
p<-tableGrob(t)
grid.arrange(p)
dev.off()
cat(".\n\t\t table.png created")

cat("\t- D. List Avg of list of brands and the min tie price for each brand \n")

my_list = c("Burberry", "Dolce & Gabbana", "Gucci", "Yves Saint Laurent")
for (x in my_list){
  cat(paste("\n\t\tBrand:", x, "\n\t\t\tAvg$:", mean(data_from_csv[which(data_from_csv$brandName == x), "priceLabel"]), "\n\t\t\tMin:$", min(data_from_csv[which(data_from_csv$brandName == x), "priceLabel"])))
}
  


cat("\n>>>STAGE 6: Creating PDF Reports\n")
###
# Stage 6: Creating Reports
# 
# Export a chart as image
# Edit title and axes labels
###

pdf("./charts/report.pdf")
plot(sort(hermes_ties$priceLabel), type = 'l', 
     main ="Chart1. \nDistribution of Prices for Hermes Ties", xlab = 'Tie Price ($)', ylab = 'Number of Ties', col = 'blue', lwd = 2)
plot(data_from_csv$priceLabel,  main ="Chart2. \nDistribution of Prices for all Ties", 
     xlab = 'Tie Price ($)', ylab = 'Number of Prices', type = 'h')
barplot(table(cut(data_from_csv$priceLabel, breaks = c(seq(0, 250, by = 50), Inf), labels = columns)),  main ="Chart 3. \nDistribution of Prices for all Ties by ranges", 
        xlab = 'Tie Price ($)', ylab = 'Number of Ties', col = 1:6)
dev.off()

