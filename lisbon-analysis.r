## Load libraries
library(readr)
library(dplyr)
library(ggplot2)
library(ggmap)

## Preparing datasets
#### Load the dataset
airbnb_lisbon_data = read_csv("~/Downloads/s3_files/lisbon/tomslee_airbnb_lisbon_1480_2017-07-27.csv")

#### Filtering noise from dataset (Hotels and Hostels)
airbnb_lisbon_data = filter(airbnb_lisbon_data,!grepl("hostel|HOSTEL|Hostel|hotel|HOTEL|Hotel", name))

#### Creating a dataset to remove price outliers
airbnb_lisbon_data_price500 = filter(airbnb_lisbon_data, price < 500)

#### Creating a dataset to remove room type outliers
airbnb_lisbon_data_no_sharedrooms = filter(airbnb_lisbon_data, room_type != "Shared room")

#### Filtering appartements with no reviews or score equals 0
airbnb_lisbon_data_only_reviewed_listings = filter(airbnb_lisbon_data, reviews > 0, overall_satisfaction > 0)

## Connecting simple data

#### Graph connecting bedrooms in a listing vs price - Points

qplot(
  x = bedrooms,
  y = price,
  data = airbnb_lisbon_data,
  geom = c("point"),
  colour = "red"
) + theme(legend.position = "none") + ggtitle("Bedrooms vs Price") + xlab("Bedrooms") + ylab("Price $") + ylim(0,1500)

#### Graph connecting bedrooms in a listing vs price - Smooth
qplot(
  x = bedrooms,
  y = price,
  data = airbnb_lisbon_data,
  geom = c("smooth"),
  colour = "red"
) + theme(legend.position = "none") + ggtitle("Bedrooms vs Price") + xlab("Bedrooms") + ylab("Price $")

#### Comparing room type vs price
qplot(
  room_type,
  price,
  data = airbnb_lisbon_data,
  geom = "boxplot",
  fill = "red",
  colour = "red"
) + ylim(0, 300) + ggtitle("Room type vs Price") + xlab("Room type") + ylab("Price $") + theme(legend.position = "none", text = element_text(size = 12))

## Calculating the number of room types in Lisbon
nr_room_types = count(airbnb_lisbon_data, room_type)

#### Renaming columns
names(nr_room_types)[2] = "total_listing"

#### Plot the graph for number of listing according to room type

ggplot(data = nr_room_types) + geom_bar(
  mapping = aes(x = room_type, y = total_listing),
  stat = "identity",
  fill = "red"
) + ggtitle("Number of listings vs Room type") + xlab("Room type") + ylab("Number of listings")

## Calculating number of listings per neighborhood
nr_listing_neighborhood = count(airbnb_lisbon_data, neighborhood)

#### Renaming columns
names(nr_listing_neighborhood)[2] = "total_listing"

#### Reordering according highest number of listings per neighborhood
nr_listing_neighborhood = nr_listing_neighborhood[order(-nr_listing_neighborhood$total_listing), ]

#### Plot the graph of number of listings per neighborhood
ggplot(data = nr_listing_neighborhood) + geom_bar(
  mapping = aes(x = reorder(neighborhood, -total_listing), y = total_listing),
  fill = "red",
  stat = "identity"
) + ggtitle("Number of listings per neighbourhood") + xlab("Neighbourhood") + ylab("Listings")  + theme(text = element_text(size = 10),
                                                                                                      axis.text.x = element_text(angle = 35, hjust = 1))

## Calculating average price per room type
average_price_room_type = aggregate(airbnb_lisbon_data$price,
                                    by = list(airbnb_lisbon_data$room_type),
                                    mean)

#### Renaming columns
names(average_price_room_type)[1] = "room_type"
names(average_price_room_type)[2] = "average_price"

#### Plot the graph of number of listings per neighborhood
ggplot(data = average_price_room_type) + geom_bar(
  mapping = aes(x = room_type, y = average_price),
  stat = "identity",
  fill = "red"
)

## Calculating the average price per neighborhood
average_price_neighborhood = aggregate(airbnb_lisbon_data$price,
                                       by = list(airbnb_lisbon_data$neighborhood),
                                       mean)
#### Renaming columns
names(average_price_neighborhood)[1] = "neighborhood"
names(average_price_neighborhood)[2] = "average_price"

#### Reordering according most expensive and cheapest accommodating neighborhood

average_price_neighborhood = average_price_neighborhood[order(-average_price_neighborhood$average_price), ]

most_expensive_neighborhoods = average_price_neighborhood[1:7, ]

average_price_neighborhood = average_price_neighborhood[order(average_price_neighborhood$average_price), ]

cheapest_neighborhoods = average_price_neighborhood[1:7, ]

#### Plot the graph of most expensive neighborhoods
ggplot(data = most_expensive_neighborhoods) + geom_bar(
  mapping = aes(x = reorder(neighborhood, -average_price), y = average_price),
  stat = "identity",
  fill = "red"
) + ggtitle("Most expensive neighborhoods in Lisbon") + xlab("Neighborhood") + ylab("Average Price") + theme(text = element_text(size = 10),
                                                                                                             axis.text.x = element_text(angle = 35, hjust = 1))

#### Plot the graph of cheapest neighborhoods
ggplot(data = cheapest_neighborhoods) + geom_bar(
  mapping = aes(x = reorder(neighborhood, +average_price), y = average_price),
  stat = "identity",
  fill = "red"
) + ggtitle("Cheapest neighborhoods in Lisbon") + xlab("Neighborhood") + ylab("Average Price") + theme(text = element_text(size = 10),
                                                                                                       axis.text.x = element_text(angle = 35, hjust = 1))

## Calculating the number of people each neighborhood can accommodate
nr_people_neighborhood_accommodates = aggregate(airbnb_lisbon_data$accommodates,
                                                by = list(airbnb_lisbon_data$neighborhood),
                                                sum)

#### Renaming columns
names(nr_people_neighborhood_accommodates)[1] = "neighborhood"
names(nr_people_neighborhood_accommodates)[2] = "total_accommodates"

#### Order per highest accommodating neighborhoods
nr_people_neighborhood_accommodates = nr_people_neighborhood_accommodates[order(-nr_people_neighborhood_accommodates$total_accommodates), ]

highest_accommodating_neighborhood = nr_people_neighborhood_accommodates[1:7, ]

#### Order per highest and lowest accommodating neighborhoods

nr_people_neighborhood_accommodates = nr_people_neighborhood_accommodates[order(nr_people_neighborhood_accommodates$total_accommodates), ]

lowest_accommodating_neighborhood = nr_people_neighborhood_accommodates[1:7, ]

#### Plot the graph of number of people accommodates per neighborhood
ggplot(data = nr_people_neighborhood_accommodates) + geom_bar(
  mapping = aes(reorder(neighborhood, -total_accommodates), y = total_accommodates),
  stat = "identity",
  fill = "red"
) + ggtitle("Neighborhoods vs number of people accommodating") + xlab("Neighborhood") + ylab("Total Capacity") + theme(text = element_text(size = 10),
                                                                                                                       axis.text.x = element_text(angle = 35, hjust = 1))
#### Plot the graph of highest accomodating neighborhoods
ggplot(data = highest_accommodating_neighborhood) + geom_bar(
  mapping = aes(
    x = reorder(neighborhood, -total_accommodates),
    y = total_accommodates
  ),
  stat = "identity",
  fill = "red"
) + ggtitle("Neighborhoods accommodating more people") + xlab("Neighborhood") + ylab("Number of people") + theme(text = element_text(size = 10),
                                                                                                                 axis.text.x = element_text(angle = 35, hjust = 1))
#### Plot the graph of lowest accomodating neighborhoods
ggplot(data = lowest_accommodating_neighborhood) + geom_bar(
  mapping = aes(
    x = reorder(neighborhood, +total_accommodates),
    y = total_accommodates
  ),
  stat = "identity",
  fill = "red"
) + ggtitle("Neighborhoods accommodating less people") + xlab("Neighborhood") + ylab("Number of people") + theme(text = element_text(size = 10),
                                                                                                                 axis.text.x = element_text(angle = 35, hjust = 1))
## Calculating the number of airbnb listings per host

#### Creating a data frame
nr_listing_host = data.frame(as.numeric(airbnb_lisbon_data$room_id),
                             as.numeric(airbnb_lisbon_data$host_id))

#### Renaming columns
names(nr_listing_host)[1] = "room_id"
names(nr_listing_host)[2] = "host_id"

#### Counting the number of airbnb listings per host
nr_listing_host = count(nr_listing_host, host_id)
nr_listing_host = rle(sort(nr_listing_host$n))

#### Converting to a data frame
nr_listing_host = data.frame(number = nr_listing_host$values, n = nr_listing_host$lengths)

#### Renaming columns
names(nr_listing_host)[1] = "nr_listings_airbnb"
names(nr_listing_host)[2] = "total_number_hosts"

#### Plot the graph of the number of airbnb listings per host
ggplot(data = nr_listing_host) + geom_bar(
  mapping = aes(x = nr_listings_airbnb, y = total_number_hosts),
  stat = "identity",
  fill = "red"
) + ggtitle("How many listing each host has in Airbnb?") + xlab("Nr. of Airbnb listings per host") + ylab("Nr of Hosts") + xlim(0, 15)

## Calculating the average review score by neighborhood
average_review_score_neighborhood = aggregate(
  airbnb_lisbon_data_only_reviewed_listings$overall_satisfaction,
  by = list(airbnb_lisbon_data_only_reviewed_listings$neighborhood),
  mean
)

#### Renaming columns
names(average_review_score_neighborhood)[1] = "neighborhood"
names(average_review_score_neighborhood)[2] = "average_review_score"

#### Plot the graph of average review score per neighborhood
ggplot(data = average_review_score_neighborhood) + geom_bar(
  mapping = aes(
    x = reorder(neighborhood, -average_review_score),
    y = average_review_score
  ),
  stat = "identity",
  fill = "red"
) + ggtitle("Average Review Score vs Neighborhoods") + xlab("Neighborhoods") + ylab("Average Review Score") + theme(text = element_text(size = 10),
                                                                                                                    axis.text.x = element_text(angle = 35, hjust = 1))

## Map visualisations
#### Creating Functions

create_map_geom_point = function(variable1, variable2, variable3) {
  variable1 = get_map(
    location = variable2,
    zoom = variable3,
    maptype = "roadmap",
    source = "google"
  )
  
  ggmap(variable1) + geom_point(data = airbnb_lisbon_data, aes(x = longitude, y = latitude, color = "Red")) + ggtitle(variable2) + xlab("Longitude") + ylab("Latitude") + theme(legend.position = "none")
}

create_map_stat_density2d = function(variable1, variable2, variable3) {
  variable1 = get_map(
    location = variable2,
    zoom = variable3,
    maptype = "roadmap",
    source = "google"
  )
  
  ggmap(variable1) + stat_density2d(
    data = airbnb_lisbon_data,
    aes(
      x = longitude,
      y = latitude,
      fill = ..level..,
      alpha = ..level..,
      size = 1,
      color = "Red"
    )
  ) + ggtitle(variable2) + xlab("Longitude") + ylab("Latitude") + theme(legend.position = "none")
}

create_map_stat_density2d_roomtype = function(variable1, variable2, variable3) {
  variable1 = get_map(
    location = variable2,
    zoom = variable3,
    maptype = "roadmap",
    source = "google"
  )
  
  ggmap(variable1) + stat_density2d(
    data = airbnb_lisbon_data,
    aes(
      x = longitude,
      y = latitude,
      fill = ..level..,
      alpha = ..level..,
      color = as.factor(room_type),
      size = 1
    )
  ) + ggtitle(variable2) + xlab("Longitude") + ylab("Latitude") + theme(legend.position = "right")
}

create_map_stat_density2d_roomtype_adjusted = function(variable1, variable2, variable3) {
  variable1 = get_map(
    location = variable2,
    zoom = variable3,
    maptype = "roadmap",
    source = "google"
  )
  
  ggmap(variable1) + stat_density2d(
    data = airbnb_lisbon_data_no_sharedrooms,
    aes(
      x = longitude,
      y = latitude,
      fill = ..level..,
      alpha = ..level..,
      color = as.factor(room_type),
      size = 1
    )
  ) + ggtitle(variable2) + xlab("Longitude") + ylab("Latitude") + theme(legend.position = "right")
}

#### Plot the map graphs
create_map_geom_point(lisbon, "Lisbon, Portugal", 14)
create_map_stat_density2d(lisbon, "Lisbon, Portugal", 14)
create_map_stat_density2d_roomtype(lisbon, "Lisbon, Portugal", 14)
create_map_stat_density2d(campo_de_ourique, "Campo de Ourique", 16)
create_map_stat_density2d(chiado, "Chiado, Lisbon", 15)
create_map_stat_density2d(lapa, "Lapa, Lisbon", 16)
create_map_stat_density2d(alfama, "Alfama, Lisbon", 16)
create_map_stat_density2d(avenidas_novas, "Avenidas Novas, Lisbon", 16)
create_map_stat_density2d(baixa, "Baixa, Lisbon", 16)
create_map_stat_density2d(ajuda, "Ajuda, Lisbon", 16)
create_map_stat_density2d(belem, "Mosteiro dos Jerónimos, Lisbon", 15)
create_map_stat_density2d(principe_real, "Jardim Fialho de Almeida, Lisbon", 17)
create_map_stat_density2d(intendente, "Largo do Intendente Pina Manique, Lisbon", 16)
create_map_stat_density2d(saldanha, "Saldanha, Lisbon", 16)
create_map_stat_density2d(marques_do_pombal, "Parque Eduardo VII, Lisbon", 16)
create_map_stat_density2d(bairro_alto, "Bairro Alto, Lisbon", 17)
create_map_geom_point(bairro_alto, "Bairro Alto, Lisbon", 17)
create_map_geom_point(alfama, "Alfama, Lisbon", 16)
create_map_geom_point(lapa, "Lapa, Lisbon", 16)
