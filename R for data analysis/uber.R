
#set working directory
setwd("d:/OneDrive/LEARNING/S1 2018/graduate project/bi/r/uber")
# read data from csv file
data= read.csv('uber.csv')

# activate library for group by function used later 
library(magrittr)
library(dplyr)
#activate plot libary 
library('ggplot2')

#check fist rows of data
head(data)

#set columns name for data
colnames(data)<-c('MemberID','MemberID','FName','LName','Email','Gender','Pass','Phone',
                  'RouteID','PickupLocation','Destination','Distance','Cost','Discount',
                  'FinalCost','ServiceRequest' ,'Coupon','MemberRiderID','RideID',
                  'StartTime' ,	'Endtime','Actual','Evaluation','Payment','MemberDriverID',
                  'RouteID','MemberID','City','InviteCode','CarModel'	,'Type','Licience',
                  'Availability',	'Location')
#set required columns 

newcol <- c('MemberID','FName','LName','Email','Gender','Pass','Phone',
            'RouteID','PickupLocation','Destination','Distance','Cost','Discount',
            'FinalCost','ServiceRequest' ,'Coupon','MemberRiderID','RideID',
            'StartTime' ,	'Endtime','Actual','Evaluation','Payment','MemberDriverID',
            'RouteID','City','InviteCode','CarModel'	,'Type','Licience',
            'Availability',	'Location')

# set data based on requried coumns 
uber <-data[newcol]

#add column named "Year" from "StartTime column"
uber$Year<- substring(uber$StartTime,1,4)

#check first 2 rows of uber data
head(uber$Year,2)
str(uber)

#install.packages('ggplot2')

# average evaluation by gender and year.

  #set up data group by Year and Gender for average Evaluation.
grEvaluation <- uber %>% 
  group_by(Year,Gender) %>% 
  summarise(Final = mean(Evaluation))
grEvaluation
  
  #plot for all gender
ggplot(data = grEvaluation,aes(x=Year,y=Final,color= Gender )) +
      geom_point(color='Red') +
facet_grid(Gender~.) + coord_cartesian(ylim = c(2.8,3.1))
  
#plot for Males, the counting number of each evaluation
ggplot(data = uber[uber$Gender=='Males',],aes(x=Evaluation )) +
  geom_histogram(binwidth = 1,color='Red' ) 

#plot for Total cost by Year and Gender
gd <- uber %>% 
  group_by(Year,Gender) %>% 
  summarise(Final = sum(FinalCost))
gd

ggplot(data = gd,aes(x=Year,y=Final,colour = Gender,size=Final))+
  geom_bar(stat = "identity")

# Plot for average Actual time by City and Year 
grActual <- uber %>% 
group_by(Year,City) %>% 
summarise(Final = mean(Actual))

ggplot(data = grActual,aes(x=City,y=Final,size=Final,color=Year))+
  geom_bar(stat = "identity")+
facet_grid(Year~.)

# Plot for total revenue by Payment Method and Year
grPayment <- uber %>% 
  group_by(Payment,Year) %>% 
  summarise(Final = sum(FinalCost))

ggplot(data = grPayment,aes(x=Payment,y=Final,color=Year))+
  geom_bar(stat = "identity")
  facet_grid(Year~.)
  
# Plot for total revenue by Payment Method and Type of service request 
grservice <- uber %>% 
group_by(Payment,ServiceRequest) %>% 
summarise(Final = sum(FinalCost))
  
  ggplot(data = grservice,aes(x=Payment,y=Final,color=ServiceRequest))+
    geom_bar(stat = "identity") + ylab("Total Revenue")
  facet_grid(Year~.)
  
  # Plot for total revenue by Payment Method and Type of service request 
  grCity <- uber %>% 
    group_by(City) %>% 
    summarise(Final = sum(FinalCost))
  
  ggplot(data = grCity,aes(x=City,y=Final))+
    geom_bar(stat = "identity") + ylab("Total Revenue")
  facet_grid(Year~.)


install_github("dkahle/ggmap")

install.packages('ggmap') 
install.packages('ggalt')
library(ggmap)
library(ggalt)
# get longitude and latitude
chennai <-  geocode("Chennai")
# Open Street Map
chennai_osm_map <- qmap("chennai", zoom=12, source = "osm")
chennai_ggl_hybrid_map <- qmap("chennai", zoom=12, source = "google", maptype="hybrid") 
chennai_ggl_road_map <- qmap("chennai", zoom=12, source = "google", maptype="roadmap") 
levels(uber$City)

chennai_places <- c("Auckland,","Christchurch","Gisborne","Hamilton",
                    "Nelson","New Plymouth","Palmerston North","Rotorua",
                    "Tauranga","Wellington","Whanganui")

places_loc <- geocode(chennai_places)

chennai_ggl_road_map + geom_point(aes(x=lon, y=lat),
                                  data = places_loc, 
                                  alpha = 0.7, 
                                  size = 7, 
                                  color = "tomato") + 
  geom_encircle(aes(x=lon, y=lat),
                data = places_loc, size = 2, color = "blue")

p1 <- plot_ly(
  type = 'scatter',
  x = uber$Year,
  y = sum(uber$FinalCost),
  
  hoverinfo = 'text',
  mode = 'markers',
  transforms = list(
    list(
      type = 'groupby',
      groups = uber$Year,
      styles = list(
        list(target = 4, value = list(marker =list(color = 'blue'))),
        list(target = 6, value = list(marker =list(color = 'red'))),
        list(target = 8, value = list(marker =list(color = 'black')))
      )
    )
  )
)
p1

text = paste("Year: ", rownames(mtcars),
             "<br>hp: ", mtcars$hp,
             "<br>qsec: ", mtcars$qsec,
             "<br>Cyl: ", mtcars$cyl),



uber$Date<- substring(uber$StartTime,1,4)
head(uber,3)

grActual <- uber %>% 
  group_by(Year,Gender) %>% 
  summarise(Final = sum(FinalCost))
  
  grActual
  sum(uber$FinalCost)

