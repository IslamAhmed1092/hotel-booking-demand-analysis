library("ggplot2")
library(randomcoloR)
library(party)
install.packages(tidyverse)
library(tidyverse)
setwd("D:\\Study\\Fourth year\\second term\\big data\\hotel-booking-demand-analysis")
c <- "hello"
data <- read.csv("hotel_bookings.csv")

purple <- "#AE57FF"
red <- "#a45530"
colors <- c(purple, red)

class(data$arrival_date_month)

levels(data$arrival_date_month) = list(Jan = "January",
                                       Feb = "February",
                                       Mar = "March",
                                       Apr = "April",
                                       May = "May",
                                       Jun = "June",
                                       Jul = "July",
                                       Aug = "August",
                                       Sept = "September",
                                       Oct = "October",
                                       Nov = "November",
                                       Dec = "December")
levels(data$arrival_date_month)
table(data$arrival_date_month)

colors <- c("#8300fd", "#fbff7b")


hotel <- table(data$hotel)

labels <- c("not cancelled", "cancelled")

hotel_cancel <- t(table(data$hotel, data$is_canceled))

barplot(hotel_cancel, legend.text = labels, col = colors)

pie_percent<- round(100*hotel/sum(hotel), 1)
pie(hotel, labels=pie_percent, col = colors)
legend("topright", legend=c("City", "Resort"),
       col=c("#8300fd", "#c12525"), lty=c(1,1))


hotel_cancel

hotel_month <- table(data$hotel, data$arrival_date_month)
hotel_month

months = c("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December")

city_month = table(factor(data[data$hotel=='City Hotel',]$arrival_date_month, levels = months))
resort_month = table(factor(data[data$hotel=='Resort Hotel',]$arrival_date_month, levels = months))

plot(city_month, type="l", col = "#8300fd")
lines(resort_month, col = "red", type="l")
legend("topleft", legend=c("City", "Resort"),
       col=c("#8300fd", "red"), lty=c(1,1))


hotel_labs <- c("City", "Resort")
barplot(hotel_month, legend.text=hotel_labs, col=colors)




xd <- t(table(data$meal, data$is_canceled))

barplot(xd, col=colors)
barplot(xd[, -c(2, 5)], legend.text = labels, col=colors)
barplot(xd[, c(2, 5)], legend.text = labels, col=colors)

hotel_repeted <- table(data$is_repeated_guest, data$hotel)

repeated <- table(data$is_repeated_guest)

pie(repeated, labels=c("new","repeated"), col=c("#6612af","#1d36d6"))


barplot(hotel_repeted, legend.text = c("new","repeated"), col=colors)


pie(table(data$previous_bookings_not_canceled)[-c(1, 2)])

barplot(table(data$previous_bookings_not_canceled)[-1])

month_cancel <- table(data$is_canceled, data$arrival_date_month)
month_cancel

g <- ggplot(data, aes(x = factor(arrival_date_month, levels = months) , fill = factor(is_canceled)))

g + geom_bar(position = position_dodge()) + 
labs(title = "Number of cancellations from each month\n", x = "Month", y = "Number of bookings")+
scale_fill_discrete(name="", labels=c("Not Cancelled", "Cancelled"))


country_city <- table(data[data$hotel == "City Hotel",]$country)

country_city

pie(country_city)

color = grDevices::colors()[grep('gr(a|e)y', grDevices::colors(), invert = T)]
cols <- sample(color, 178)

country_city <- as.data.frame(country_city)
country_city
ggplot(country_city, aes(x = "", y = sort(Freq), colour=Var1, fill= Var1))+
 geom_col(color = "transparent", width = NULL) +
  scale_fill_manual(values = sample(color, 178))+
  coord_polar("y", start = 0) +
  theme_void()



# NOT RUN {
## assign individual levels
x <- gl(2, 4, 9)
x <- as.data.frame(x)
levels(x$x) <- list(xd = "low", fd = "2")
levels(x$x)[1] <- "low"
levels(x)[2] <- "high"
x$x
levels(x$x)

lis <- list(                           Jan = "January",
                                       Feb = "February",
                                       Mar = "March",
                                       Apr = "April",
                                       May = "May",
                                       Jun = "June",
                                       Jul = "July",
                                       Aug = "August",
                                       Sep = "September",
                                       Oct = "October",
                                       Nov = "November",
                                       Dec = "December")
lis              
levels(x$x) <- lis
x
## or as a group
y <- gl(2, 4, 8)
levels(y) <- c("low", "high")
y

## combine some levels
z <- gl(3, 2, 12, labels = c("apple", "salad", "orange"))
z
levels(z) <- c("fruit", "veg", "fruit")
z

## same, using a named list
z <- gl(3, 2, 12, labels = c("apple", "salad", "orange"))
z
levels(z) <- list("fruit" = c("apple","orange"),
                  "veg"   = "salad")
z

## we can add levels this way:
f <- factor(c("a","b"))
levels(f) <- c("c", "a", "b")
f

f <- factor(c("a","b"))
levels(f) <- list(C = "C", A = "a", B = "b")
f
# }


colnames(data %>% select_if(is.character))

is.character(data$hotel)


library(party)

# Create the input data frame.
input.dat <- readingSkills[c(1:105),]

# Give the chart file a name.
png(file = "decision_tree.png")

# Create the tree.
  output.tree <- ctree(
  nativeSpeaker ~ age + shoeSize + score, 
  data = input.dat)

# Plot the tree.
plot(output.tree)

# Save the file.
dev.off()