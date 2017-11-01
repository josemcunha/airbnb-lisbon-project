# Load datasets

library(readr)
library(ggplot2)

airbnb_rome_2017_07_19 = read_csv("Downloads/s3_files/rome/tomslee_airbnb_rome_1470_2017-07-19.csv")
airbnb_barcelona_2017_07_23 = read_csv("Downloads/s3_files/barcelona/tomslee_airbnb_barcelona_1477_2017-07-23.csv")
airbnb_madrid_2017_03_11 = read_csv("Downloads/s3_files/madrid/tomslee_airbnb_madrid_0981_2017-03-11.csv")
airbnb_lisbon_2017_07_27 = read_csv("Downloads/s3_files/lisbon/tomslee_airbnb_lisbon_1480_2017-07-27.csv")
airbnb_florence_2017_06_22 = read_csv("Downloads/s3_files/florence/tomslee_airbnb_florence_1366_2017-06-22.csv")
airbnb_porto_2017_07_22 = read_csv("Downloads/s3_files/porto/tomslee_airbnb_porto_1517_2017-07-22.csv")


# Clean datasets

airbnb_barcelona_2017_07_23 = filter(
  airbnb_barcelona_2017_07_23,
  !grepl(
    "hostel|HOSTEL|Hostel|hotel|HOTEL|Hotel|Hoteles|Hostal|HOSTAL|hostal",
    name
  )
)
airbnb_lisbon_2017_07_27 = filter(
  airbnb_lisbon_2017_07_27,
  !grepl(
    "hostel|HOSTEL|Hostel|hotel|HOTEL|Hotel|Hoteles|Hostal|HOSTAL|hostal",
    name
  )
)

# Creating the vectors

cities = c("Rome", "Barcelona", "Madrid", "Lisbon", "Porto", "Florence")
total_listings = c(
  count(airbnb_rome_2017_07_19),
  count(airbnb_barcelona_2017_07_23),
  count(airbnb_madrid_2017_03_11),
  count(airbnb_lisbon_2017_07_27),
  count(airbnb_porto_2017_07_22),
  count(airbnb_florence_2017_06_22)
)

# Format the total_listings to a vector
total_listings = unlist(total_listings)

# Create the dataframe
southern_europe_overview = data.frame(cities, total_listings)

# Plot the graph
ggplot(southern_europe_overview, aes(cities, total_listings)) + geom_bar(stat = "identity", fill = "red") + ggtitle("Evolution of nr. of Airbnb listings in Lisbon") + xlab("City") + ylab("Nr. of Listings") + theme(text = element_text(size = 10), axis.text.x = element_text(angle = 35, hjust = 1))
