# Load datasets

library(readr)
library(ggplot2)
airbnb_lisbon_2017_07_27 = read_csv("Downloads/s3_files/lisbon/tomslee_airbnb_lisbon_1480_2017-07-27.csv")
airbnb_lisbon_2017_06_19 = read_csv("Downloads/s3_files/lisbon/tomslee_airbnb_lisbon_1352_2017-06-19.csv")
airbnb_lisbon_2017_05_15 = read_csv("Downloads/s3_files/lisbon/tomslee_airbnb_lisbon_1228_2017-05-15.csv")
airbnb_lisbon_2017_04_27 = read_csv("Downloads/s3_files/lisbon/tomslee_airbnb_lisbon_1148_2017-04-27.csv")
airbnb_lisbon_2017_03_30 = read_csv("Downloads/s3_files/lisbon/tomslee_airbnb_lisbon_1002_2017-03-30.csv")
airbnb_lisbon_2017_02_21 = read_csv("Downloads/s3_files/lisbon/tomslee_airbnb_lisbon_0894_2017-02-21.csv")
airbnb_lisbon_2017_01_21 = read_csv("Downloads/s3_files/lisbon/tomslee_airbnb_lisbon_0811_2017-01-21.csv")
airbnb_lisbon_2016_12_26 = read_csv("Downloads/s3_files/lisbon/tomslee_airbnb_lisbon_0716_2016-12-26.csv")
airbnb_lisbon_2016_09_12 = read_csv("Downloads/s3_files/lisbon/tomslee_airbnb_lisbon_0558_2016-09-12.csv")
airbnb_lisbon_2016_06_02 = read_csv("Downloads/s3_files/lisbon/tomslee_airbnb_lisbon_0446_2016-06-02.csv")
airbnb_lisbon_2016_03_20 = read_csv("Downloads/s3_files/lisbon/tomslee_airbnb_lisbon_0359_2016-03-20.csv")
airbnb_lisbon_2015_03_18 = read_csv("Downloads/s3_files/lisbon/tomslee_airbnb_lisbon_0107_2015-03-18.csv")

# Clean datasets

airbnb_lisbon_2017_07_27 = filter(airbnb_lisbon_2017_07_27,!grepl("hostel|HOSTEL|Hostel|hotel|HOTEL|Hotel", name))
airbnb_lisbon_2017_06_19 = filter(airbnb_lisbon_2017_06_19,!grepl("hostel|HOSTEL|Hostel|hotel|HOTEL|Hotel", name))
airbnb_lisbon_2017_05_15 = filter(airbnb_lisbon_2017_05_15,!grepl("hostel|HOSTEL|Hostel|hotel|HOTEL|Hotel", name))
airbnb_lisbon_2017_04_27 = filter(airbnb_lisbon_2017_04_27,!grepl("hostel|HOSTEL|Hostel|hotel|HOTEL|Hotel", name))

# Creating the vectors

date = c(
  "2017-07-27",
  "2017-06-19",
  "2017-05-15",
  "2017-04-27",
  "2017-03-30",
  "2017-02-21",
  "2017-01-21",
  "2016-12-26",
  "2016-09-12",
  "2016-03-20",
  "2015-03-18"
)

total_listings = c(
  count(airbnb_lisbon_2017_07_27),
  count(airbnb_lisbon_2017_06_19),
  count(airbnb_lisbon_2017_05_15),
  count(airbnb_lisbon_2017_04_27),
  count(airbnb_lisbon_2017_03_30),
  count(airbnb_lisbon_2017_02_21),
  count(airbnb_lisbon_2017_01_21),
  count(airbnb_lisbon_2016_12_26),
  count(airbnb_lisbon_2016_09_12),
  count(airbnb_lisbon_2016_03_20),
  count(airbnb_lisbon_2015_03_18)
)

# Format the total_listings to a vector
total_listings = unlist(total_listings)

# Create the dataframe

nr_listings_evolution_lisbon = data.frame(date, total_listings)

# Plot the graph

ggplot(nr_listings_evolution_lisbon, aes(date, total_listings)) + geom_bar(stat = "identity", fill = "red") + ggtitle("Evolution of nr. of Airbnb listings in Lisbon") + xlab("Date") + ylab("Nr. of Listings") + theme(text = element_text(size = 10),
                                                                                                                                                                                                                        axis.text.x = element_text(angle = 35, hjust = 1))
