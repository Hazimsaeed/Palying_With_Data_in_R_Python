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
# --------------------------------------
 
from my_utils import *
from numpy_utils import *

# --------------------------------------

print("\n Projects has four stages as below:\n")
print("\n\t>>>STAGE 1 \n")
print("\n\t>>>STAGE 2: Describing Data\n")
print("\n\t>>>STAGE 3: Cleaning data\n")
print("\n\t>>>STAGE 4: Exporting\n")
print("\n\t>>>STAGE 5: Creating Charts and Tables\n")
print("\n\t>>>STAGE 6: Creating PDF Reports\n")

print("\n>>>STAGE 1 \n")
print("\t- set working dir and global output formate")
# we're using these functions
from my_utils import open_with_csv
from numpy_utils import load_data
 

print("\n>>>STAGE 2: Describing Data\n")
print("\t- A. Loading raw data into data structure(s)\n")
print("\t- B. Calculate descriptive Stats \n\t(Max, Min, Median, Mean, Sums and Totals)")
# --------------------------------------

# Stage 2: Describing Data
# #
# A. Loading raw data into data structure(s)
# B. Calculate descriptive Stats
# - Max, Min, Median, Mean, Sums and Totals

### Loading data into a data structure (list of lists)
print("\nPart A. Loading the data ")
# sample filename
sample_file = 'data.csv' 

## 1. read in the data captured using the python CSV module
data_from_csv = open_with_csv(sample_file)
print("The header contains these fields: \n", data_from_csv[0])
## 2. read in the data captured using numpy
my_csv = load_data(sample_file)


print("\nPart B. describe data")
print("\n\t B.1. Show size of dataset\n")
# Calculating descriptive stats by showing the length of a list
# How many rows are there?

from my_utils import number_of_records
print("Length: ", number_of_records(data_from_csv), "rows in", sample_file, "including header")

# show length using numpy array
from numpy_utils import size
size(my_csv)

# Sums of all the prices
print("\n\t B.2 Calculating Sum")
# Sums of all the prices
from my_utils import calculate_sum
the_sum = calculate_sum(data_from_csv)
print("\n\t\tThe Sum: $", the_sum)

# Format the output to show up to two decimal points
from numpy_utils import calculate_numpy_sum
price = my_csv['priceLabel']
my_sum = calculate_numpy_sum(price)
print("The Sum (numpy): $", my_sum)

# Average of all the prices
print("\n\t B.3 Calculating Average")
from my_utils import find_average
print("\n\t\tAverage:", find_average(data_from_csv, True))

# Average of first half and last half
midpoint = round(len(data_from_csv)/2)
print("\n\t\tAverage of first half", find_average(data_from_csv[:midpoint], True))
print("\n\t\tAverage of last half", find_average(data_from_csv[midpoint+1:], True))

price_in_float = [float(item) for item in price]
print("Average (numpy):", find_numpy_average(price_in_float))

# The Max and the Min Tie prices
print("\n\t B.4 Calculating the Max and the Min")
from my_utils import find_max, find_min, find_max_min
print("Highest Priced Tie: $", find_max(data_from_csv[1:], 2), "// Lowest Priced Tie: $", find_min(data_from_csv[1:], 2) )

from numpy_utils import numpy_max, numpy_min
print("(Numpy) Highest Priced Tie: $", numpy_max(price_in_float), "// Lowest Priced Tie: $", numpy_min(price_in_float) )


print("\n>>>STAGE 3: Cleaning data\n")
print("\t- A. Cleaning Data\n")
print("\t- B. Filtering Rows\n")
print("\t- C. Grouping columns\n")
# --------------------------------------
# Stage 3: Cleaning data
#
# A. Cleaning Data
# B. Filtering Rows
# C. Grouping columns
###

### Cleaning data
print("\npart A. Cleaning data")

# find cashmere ties
my_improved_csv = create_bool_field_from_search_term(data_from_csv, "cashmere")
print(number_of_records(my_improved_csv), "ties made with cashmere")

# add boolean fields
print("Filtering for correct count...")
number_cashmere_ties = filter_col_by_bool(my_improved_csv, 11)


print("\npart B. Filtering rows")

### Filtering Ties by string
print("\n\tpart B.1 Filtering rows by brand")

# Look at ties of brand Hermes vs JCrew
from my_utils import filter_col_by_string, filter_col_by_float

# Look at ties of brand Hermes vs JCrew
hermes_ties = filter_col_by_string(data_from_csv, "brandName", "Hermes")
jcrew_ties = filter_col_by_string(data_from_csv, "brandName", "J.Crew")
print("\n\t\tFound ", len(hermes_ties), "Hermes Ties")
print("\n\t\tFound ", len(jcrew_ties), "J.Crew Ties")

print("\n\tpart B.2 Filtering rows by material")
# Only look at rows of "silk" ties or only "wool"
silk_ties = filter_col_by_string(data_from_csv, "material", "_silk")
wool_ties = filter_col_by_string(data_from_csv, "material", "_wool")
print("\n\t\tFound ", len(silk_ties), "Silk Ties")
print("\n\t\tFound ", len(wool_ties), "Wool Ties")

# Look at ties < $20 vs ties over $100
print("\n\tpart B.3 Filtering rows by price")
under_20_dollars = filter_col_by_float(data_from_csv, "priceLabel", "<=", 20)
over_100_dollars = filter_col_by_float(data_from_csv, "priceLabel", ">=", 100)
print("\n\t\tFound ", len(under_20_dollars), " ties < $20")
print("\n\t\tFound ", len(over_100_dollars), " ties < $100")

print("\npart C. Grouping rows")
# Compare Maximum Prices
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

print("\n>>>STAGE 4: Exporting\n")
print("\t- A. Exporting data base on type\n")
print("\t- B. Exporting some columns from the data\n")
print("\t- C. Exporting data based on Min and Max\n")
print("\t- D. Exporting data sorted\n")
print("\t- E. Exporting to Excel\n")
print("\t\t- 1. Install packages 'xlsx' \n")
print("\t\t- 2. load library 'xlsx' \n")
print("\t\t- 3. Export and write .xlsx file \n")
# --------------------------------------
###
# Stage 4: Exporting
#
# CSV or TSV
# Excel
###
import os
directory = "data"
if not os.path.exists(directory):
    os.makedirs(directory)

# Exporting CSV Files
print("\npart A. Exporting CSV Files for hermes and jcrew")
## Export Hermes Ties



# Exporting CSV Files
from my_utils import write_to_file
## Export Hermes Ties
write_to_file("data/hermes.csv", hermes_ties)
print("\n\t hermes.csv Export in folder named 'data'")

## Export JCrew Ties
write_to_file("data/jcrew.csv", jcrew_ties)
print("\n\t jcrew.csv Exported in folder named 'data'")

print("\npart B.1 Exporting CSV Files have column brandId, priceLabel for hermes")
#save two columns
from my_utils import write_brand_and_price_to_file
write_brand_and_price_to_file('data/test.csv', hermes_ties)
print("\n\t hermes_brandId_priceLabel.csv Exported in folder named 'data'")

print("\npart B.2 Exporting CSV Files have column name, desc for hermes")
#save two columns uuseing different method
write_two_cols('data/write_two_cols.csv', hermes_ties[1:], 3, 7)
print("\n\t hermes_name_desc.csv Exported in folder named 'data'")

print("\npart C. Exporting CSV hermes and jcrew ties that match max and min price for each ")
#max and min price for hermes
from my_utils import write_min_max_csv, write_two_cols, write_append_file
write_min_max_csv('data/write_min_max.csv', hermes_ties[1:])
print("\n\t Hermes min, max exported in min_max.csv in folder named 'data'")

# bind jcrew max and min price to existing CSV
write_append_file('data/write_min_max.csv', jcrew_ties[1:])
print("\n\t jcrew min, max append to min_max.csv in folder named 'data'")

print("\npart D. Exporting sorted jcrew CSV by pricelable")
# write jcrew ties in CSV sorted by pricelable
from my_utils import write_sorted_prices, write_sorted_prices
write_sorted_prices('data/write_sorted_price.csv', jcrew_ties[1:], "ascending")
print("\n\t jcrew_sorted_by_price.csv Exported in folder named 'data'")

# Exporting to Excel
print("\npart E. Exporting kiton ties to Excel")

# reusing a function before to grab a new data sample
kiton_ties = filter_col_by_string(data_from_csv, "brandName", "Kiton")

print("\t 1. Import 'save_spreadsheet' \n")
#Import save_spreadsheet
from my_utils import save_spreadsheet
print("\t- 2. load library 'xlsx' \n")
#load xlsx
save_spreadsheet('data/kiton.xlsx', kiton_ties)
print("\n\t\t kiton.xlsx Exported in folder named 'data'")


print("\n>>>STAGE 5: Creating Charts and Tables\n")
print("\t- A. Line charts\n")
print("\t- B. Bar charts\n")
print("\t- C. Tables\n")
print("\t\t- 1. Install packages 'ggplot2' \n")
print("\t\t- 2. load library 'ggplot2' \n")
print("\t\t- 3. Install packages 'gridExtra' \n")
print("\t\t- 4. load library 'gridExtra' \n")
print("\t\t- 5. Craete Table has all brand and quintaty grouped by price' \n")
print("\t- D. List Avg of list of brands and the min tie price for each brand \n")
# --------------------------------------
# ###
# Stage 5: Charts and Tables
# Line Charts
# Bar Charts
# Tables
###

# Line charts
print("\npart A. Line Charts")

# create dirctory charts if not exist
import os
directory = "charts"
if not os.path.exists(directory):
    os.makedirs(directory)


from my_utils import create_line_chart
#craete line_hermes.png to handel the chart
create_line_chart(hermes_ties[1:], "Distribution of Prices for Hermes Ties", "charts/line_hermes.png")
print(".\n\t line_hermes.png created")

#craete line_jcrew.png to handel the chart
create_line_chart(jcrew_ties(['priceLabel']), "Distribution of Prices for J.Crew Ties", "charts/line_jcrew.png")
print(".\n\t line_jcrew.png created")

#craete line_kiton.png to handel the chart
create_line_chart(kiton_ties['priceLabel']), "Distribution of Prices for Kiton Ties", "charts/line_kiton.png")
print(".\n\t line_kiton.png created")

# Bar charts
print("\npart B. Bar charts")
#craete all_prices.png to handel the chart
from numpy_utils import plot_all_bars
plot_all_bars(price_in_float,  "_charts/all_prices.png")
print(".\n\t all_prices.png created")

from my_utils import create_bar_chart, group_prices_by_range
price_groups = group_prices_by_range(price_in_float)
create_bar_chart(price_groups, "_charts/price_in_groups.png")
print("created _charts/price_in_groups.png")


print("5.c Tables")
from my_utils import create_table
brands = my_csv['brandName']
columns = ["$0-50", "$50-100", "$100-150", "$150-200", "$200-250", "$250+"]
write_brand_and_price_to_file("_data/tempTableFile.csv", data_from_csv)
brand_and_price_data = open_with_csv("_data/tempTableFile.csv", d=',')
create_table(brand_and_price_data, price_groups, brands, columns, "_charts/prices_in_table.png")
print("created _charts/prices_in_table.png")

print("5.d quickly check to see if there might be discounted items for these brands...")
my_list = ["Burberry", "Dolce & Gabbana", "Gucci", "Yves Saint Laurent"]
for x in my_list:
    print_brand_avg_min(x, data_from_csv)

print("\n>>> SHOWING STAGE 6 EXAMPLES")

"""
Stage 6: Creating Reports

Export a chart as image
Edit title and axes labels
Code Challenge - save chart image with certain resolution and labels
"""

labels = ["$0-50", "$50-100", "$100-150", "$150-200", "$200-250", "$250+"]
plot1 = plot_minimal_graph(price_in_groups, labels)
table_text = build_table_text(data_sample, brand_names)
table_text = build_table_text(brand_and_price_data, brands)
plot2 = plot_graph_with_table(table_text[0], table_text[1], labels)


pp = PdfPages('foo.pdf')
pp.savefig(plot1, bbox_inches='tight')
pp.savefig(plot2, bbox_inches='tight')
pp.close()

'''
