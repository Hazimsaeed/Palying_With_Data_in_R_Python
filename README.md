# Project Name
## Palying With Data in Python and R

## Introduction

In this project I tried to go throw the data science most important functions in R and python language. 
The data set used in this project is about Ties. The data set has different brand and type of ties each tie had its own attribute such as price, name, material …etc. All the information about ties is store as CSV file. 
This project has six Stages.
The first stage is loading the CSV data set. In Stage two I tried to describe the data by reading the header of the data set to know the description provided, then show the length of the data by counting rows. After that I print the total value of the ties by summation the prices of all ties in the data set. Additionally, I calculate the average price of all ties, then I calculated the average price of the first half of the data set and the second half of the data set.
In the second stage I calculated the Highest Priced and Lowest Priced, to know what most expensive tie is and what the cheapest tie is. In the third stage also I cleaned the data by adding Boolean field, then I filter the data base on the brand name, material and prices. Finally, in this stage I grouped the data by calculating the highest price for specific brands and the average price by type using grepl function in R and of course numpy in python. Stage four I used different type and method to export data sets in different shape, type and style. In stage five I created different types of graphs form the data such as: Line, Bar, Tables graphs. I also listed all some brand average price with the lowest price to give idea if there is a discount for the brand.
The final Stage, Stage six I export some graphs to a PDF file as a report and I edit the titles and axes labels.


## Requirment:


for the R project I installed the following packages:

	1- xlsx -- to export to excel.
	2- ggplot2 -- to plot table.
	
for the python project I installed the following packages:

	1- numpy
	2- matplotlib
	

## Stages:
I will try to explain the project stages by highlighting code blocks, so it will be fun to compare R code with Python code.
Note: R code and Python code give same output.
  
1. Stage one: set working dir and global output formate and import requier library


```R
#R code:
setwd("C:\\Users\\Habdelrahman\\Downloads\\Project")
#set options to round output
options(digits = 3, warn = -1)
```
```python
#Python code:
from my_utils import *
from numpy_utils import *
from my_utils import open_with_csv
from numpy_utils import load_data
```

2. Stage two: Describing Data

 - A. Loading raw data into data structure(s)
	
```R
#R code:
sample_file = 'data.csv' 
## 1. read in the data captured using the R CSV module
data_from_csv = read.csv(sample_file, encoding = "UTF-8", sep = "\t")
```	

```python
#Python code:
sample_file = 'data.csv' 
## read in the data captured using numpy
my_csv = load_data(sample_file)
```	


 - B. Calculate descriptive Stats Max, Min, Median, Mean, Sums and Totals
		

	

```R
#R code:

cat(paste("\t\tLength: ", nrow(data_from_csv)+1, "rows in", sample_file, "including header"))

# Sums of all the prices
cat("\n\t B.2 Calculating Sum")
cat(paste("\n\t\tThe Sum: $", sum(data_from_csv$priceLabel)))

# Average of all the prices
cat("\n\t B.3 Calculating Average")
cat(paste("\n\t\tThe Average:", mean(data_from_csv$priceLabel)))

# The Max and the Min Tie prices
cat("\n\t B.4 Calculating the Max and the Min")
cat(paste("\n\t\tHighest Priced Tie: $", max(data_from_csv$priceLabel), 
          "\n\t\tLowest Priced Tie: $", min(data_from_csv$priceLabel) ))


```

```python
#Python code:

# show length using numpy array
from numpy_utils import size
size(my_csv)

# Sums of all the prices
from my_utils import calculate_sum
the_sum = calculate_sum(data_from_csv)
print("\n\t\tThe Sum: $", the_sum)

# Average of all the prices
from my_utils import find_average
print("\n\t\tAverage:", find_average(data_from_csv, True))

# The Max and the Min Tie prices
from numpy_utils import numpy_max, numpy_min
print("(Numpy) Highest Priced Tie: $", numpy_max(price_in_float), "// Lowest Priced Tie: $", numpy_min(price_in_float) )


```

### Output Screenshot


![Alt text](/img/01.jpg)



3. Stage three: Cleaning data
 
 A. Cleaning Data
	
```R
#R code:

# find cashmere ties
my_improved_csv = grepl("cashmere", as.character(data_from_csv$desc))
cat("\t",sum(as.numeric(my_improved_csv)), "ties made with cashmere")

# add boolean fields
number_cashmere_ties = data_from_csv[my_improved_csv,11]
cat("\tFiltering for correct count by counting boolean fields:\n\t",length( number_cashmere_ties),"ties made with cashmere")
```

```python
#Python code:

my_improved_csv = create_bool_field_from_search_term(data_from_csv, "cashmere")
print(number_of_records(my_improved_csv), "ties made with cashmere")

# add boolean fields
print("Filtering for correct count...")
number_cashmere_ties = filter_col_by_bool(my_improved_csv, 11)
```

 B. Filtering Rows
	
```R
#R code:

# Look at ties of brand Hermes vs JCrew
hermes_ties = data_from_csv[grepl('Hermes', as.character(data_from_csv$brandName)),]
jcrew_ties = data_from_csv[grepl('J.Crew', as.character(data_from_csv$brandName)),]
cat("\n\t\tFound ", nrow(hermes_ties), "Hermes Ties")
cat("\n\t\tFound ", nrow(jcrew_ties), "J.Crew Ties")

# Look at ties < $20 vs ties over $100
under_20_dollars = data_from_csv[which(data_from_csv$priceLabel<=20),]
over_100_dollars = data_from_csv[which(data_from_csv$priceLabel>100),]
cat(paste("\n\t\tFound ", nrow(under_20_dollars), " ties < $20"))
cat(paste("\n\t\tFound ", nrow(over_100_dollars), " ties > $100"))


```

```python
#Python code:

# Look at ties of brand Hermes vs JCrew
from my_utils import filter_col_by_string, filter_col_by_float

# Look at ties of brand Hermes vs JCrew
hermes_ties = filter_col_by_string(data_from_csv, "brandName", "Hermes")
jcrew_ties = filter_col_by_string(data_from_csv, "brandName", "J.Crew")
print("\n\t\tFound ", len(hermes_ties), "Hermes Ties")
print("\n\t\tFound ", len(jcrew_ties), "J.Crew Ties")

# Look at ties < $20 vs ties over $100
under_20_dollars = filter_col_by_float(data_from_csv, "priceLabel", "<=", 20)
over_100_dollars = filter_col_by_float(data_from_csv, "priceLabel", ">=", 100)
print("\n\t\tFound ", len(under_20_dollars), " ties < $20")
print("\n\t\tFound ", len(over_100_dollars), " ties < $100")

```

### Output Screenshot


![Alt text](/img/02.jpg)

	
```R
#R code:

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
```

```python
#Python code:

max_hermes_tie_price = find_max(hermes_ties[1:], 2)
max_jcrew_tie_price = find_max(jcrew_ties[1:], 2)
print("Maximum Hermes Tie Price is: ", '{:03.2f}'.format(max_hermes_tie_price))
print("Maximum J.Crew Tie Price is: ", '{:03.2f}'.format(max_jcrew_tie_price))

# Printed vs Solid. Are the printed ties cheaper?
avg_print_ties = find_average(filter_col_by_string(data_from_csv, "striped", "_print"))
avg_paisley_ties = find_average(filter_col_by_string(data_from_csv, "striped", "_paisley"))
avg_striped_ties = find_average(filter_col_by_string(data_from_csv, "striped", "_striped"))
avg_solid_ties = find_average(filter_col_by_string(data_from_csv, "striped", "_solid"))
print("Avg Print $", avg_print_ties)
print("Avg Paisley $", avg_paisley_ties)
print("Avg Stripes $", avg_striped_ties)
print("Avg Solid $", avg_solid_ties)
```

### Output Screenshot


![Alt text](/img/03.jpg)

	
	
4. Stage four: Exporting

 A. Exporting CSV Files
 
```R
#R code:

if(!exists("./data")) dir.create("./data")
write.csv(hermes_ties, "./data/hermes.csv", row.names = FALSE)
cat("\n\t hermes.csv Export in folder named 'data'")
#Export two columns
write.csv(hermes_ties[, c("brandId", "priceLabel")], "./data/hermes_brandId_priceLabel.csv", row.names = FALSE)
cat("\n\t hermes_brandId_priceLabel.csv Exported in folder named 'data'")
write.csv(hermes_ties[which(hermes_ties$priceLabel == max(hermes_ties$priceLabel) | hermes_ties$priceLabel == min(hermes_ties$priceLabel)),], 
                      './data/min_max.csv', row.names = FALSE)
# bind jcrew max and min price to existing CSV		  
write.csv(rbind(read.csv('./data/min_max.csv'), jcrew_ties[
		which(jcrew_ties$priceLabel == max(jcrew_ties$priceLabel) | jcrew_ties$priceLabel == min(jcrew_ties$priceLabel)),]),
			'./data/min_max.csv', row.names = FALSE)
```	

```python
#Python code:

from my_utils import write_brand_and_price_to_file
write_brand_and_price_to_file('data/test.csv', hermes_ties)
write_two_cols('data/write_two_cols.csv', hermes_ties[1:], 3, 7)
from my_utils import write_min_max_csv, write_two_cols, write_append_file
write_min_max_csv('data/write_min_max.csv', hermes_ties[1:])

```
### Output Screenshot


![Alt text](/img/04.jpg)


 B. Exporting to Excel
	
```R
#R code:

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

```

```python
#Python code:

kiton_ties = filter_col_by_string(data_from_csv, "brandName", "Kiton")
#Import save_spreadsheet
from my_utils import save_spreadsheet
#load xlsx
save_spreadsheet('data/kiton.xlsx', kiton_ties)

```
### Output Screenshot


![Alt text](/img/05.jpg)

	
5. Stage five: Charts and Tables

 A. Line Charts

```R
#R code:

png("./charts/line_hermes.png")
#plot chart into png file  
plot(sort(hermes_ties$priceLabel), type = 's,S', 
     main ="Distribution of Prices for Hermes Ties", xlab = 'Tie Price ($)', ylab = 'Number of Ties', col = 'blue', lwd = 2)
# To write the ploting in the .png file	 
dev.off()

```

```python
#Python code:

from my_utils import create_line_chart
#craete line_hermes.png to handel the chart
create_line_chart(hermes_ties[1:], "Distribution of Prices for Hermes Ties", "charts/line_hermes.png")
print(".\n\t line_hermes.png created")

```
### Output Screenshot


![Alt text](/img/06.jpg)

 B. Bar Charts

```R
#R code:

columns = c("$0-50", "$50-100", "$100-150", "$150-200", "$200-250", "$250+")
#craete price_in_groups.png to handel the chart
png("./charts/price_in_groups.png")
#plot chart into png file
barplot(table(cut(data_from_csv$priceLabel, breaks = c(seq(0, 250, by = 50), Inf), labels = columns)),  main ="Distribution of Prices for all Ties by ranges", 
        xlab = 'Tie Prices in groups ($)', ylab = 'Number of Ties', col = 1:6)
# write the ploting in the .png file
dev.off()

```

```python
#Python code:

from my_utils import create_bar_chart, group_prices_by_range
price_groups = group_prices_by_range(price_in_float)
create_bar_chart(price_groups, "_charts/price_in_groups.png")

```

### Output Screenshot


![Alt text](/img/07.jpg)


 C. Tables
	
```R
#R code:

if(!"ggplot2" %in% installed.packages()) install.packages("ggplot2")
# Load ggplot2
library(ggplot2)
# intstall gridExtra if not installed
if(!"gridExtra" %in% installed.packages()) install.packages("gridExtra")
# Load gridExtra
library(gridExtra)
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

```

```python
#Python code:

from my_utils import create_table
brands = my_csv['brandName']
columns = ["$0-50", "$50-100", "$100-150", "$150-200", "$200-250", "$250+"]
write_brand_and_price_to_file("_data/tempTableFile.csv", data_from_csv)
brand_and_price_data = open_with_csv("_data/tempTableFile.csv", d=',')
create_table(brand_and_price_data, price_groups, brands, columns, "_charts/prices_in_table.png")
print("created _charts/prices_in_table.png")

```
### Output Screenshot


![Alt text](/img/08.jpg)

 D. List Avg of list of brands and the min tie price for each brand

```R
#R code:

my_list = c("Burberry", "Dolce & Gabbana", "Gucci", "Yves Saint Laurent")
for (x in my_list){
  cat(paste("\n\t\tBrand:", x, "\n\t\t\tAvg$:", mean(data_from_csv[which(data_from_csv$brandName == x), "priceLabel"]), "\n\t\t\tMin:$", min(data_from_csv[which(data_from_csv$brandName == x), "priceLabel"])))
}

```

```python
#Python code:

my_list = ["Burberry", "Dolce & Gabbana", "Gucci", "Yves Saint Laurent"]
for x in my_list:
    print_brand_avg_min(x, data_from_csv)

```

### Output Screenshot


![Alt text](/img/09.jpg)

6. Stage six Creating Reports, Export a chart as image, Edit title and axes labels

```R
#R code:

pdf("./charts/report.pdf")
plot(sort(hermes_ties$priceLabel), type = 'l', 
     main ="Chart1. \nDistribution of Prices for Hermes Ties", xlab = 'Tie Price ($)', ylab = 'Number of Ties', col = 'blue', lwd = 2)
plot(data_from_csv$priceLabel,  main ="Chart2. \nDistribution of Prices for all Ties", 
     xlab = 'Tie Price ($)', ylab = 'Number of Prices', type = 'h')
barplot(table(cut(data_from_csv$priceLabel, breaks = c(seq(0, 250, by = 50), Inf), labels = columns)),  main ="Chart 3. \nDistribution of Prices for all Ties by ranges", 
        xlab = 'Tie Price ($)', ylab = 'Number of Ties', col = 1:6)
dev.off()
}
```
```python
#Python code:

labels = ["$0-50", "$50-100", "$100-150", "$150-200", "$200-250", "$250+"]
plot1 = plot_minimal_graph(price_in_groups, labels)
table_text = build_table_text(data_sample, brand_names)
table_text = build_table_text(brand_and_price_data, brands)
plot2 = plot_graph_with_table(table_text[0], table_text[1], labels)


pp = PdfPages('foo.pdf')
pp.savefig(plot1, bbox_inches='tight')
pp.savefig(plot2, bbox_inches='tight')
pp.close()

```

### Output Screenshot


![Alt text](/img/10.jpg)



