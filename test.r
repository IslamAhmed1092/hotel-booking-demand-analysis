library("ggplot2")
setwd("D:\\Study\\Fourth year\\second term\\big data\\hotel-booking-demand-analysis")
c <- "hello"
data <- read.csv("hotel_bookings.csv")

colors <- c("#8300fd", "#c12525")


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
