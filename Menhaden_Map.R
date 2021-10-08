library(ggplot2)
library(maps)
library(dplyr)
library(usmap)
library(scales)
library(tidyverse)
library(unikn)
setwd("G:/My Drive/Menhaden_CEP_Paper")
Quota <- read.csv(file = 'G:/My Drive/Menhaden_CEP_Paper/Menhaden_Map.csv')
MainStates <- map_data("state")
East_Coast <- subset(MainStates, region %in%  
              c("connecticut","delaware","florida","new hampshire",
              "maine","maryland","massachusetts","new jersey", 
              "new york", "north carolina","rhode island","virginia", "georgia", 
              "south carolina", "pennsylvania", "west virginia", "alabma", "tennessee",
              "kentucky", "ohio", "indiana", "alabama", "mississippi", "vermont"
              ))

colnames(Quota)[1] <- 'region'
Data_Final <- inner_join(East_Coast,Quota, by = "region")
Data_AllStates = inner_join(MainStates,Quota, by = "region")



gg <- ggplot()
gg <- gg + geom_polygon(data=MainStates, aes(x=long,y=lat,group=group),
      color="white", fill="grey")
gg <- gg + geom_polygon(data=Data_AllStates, aes(x=long,y=lat,group=group, 
      fill=Percent), color="white") 
gg <- gg + scale_fill_viridis_c(option = "C")
gg


gg <- ggplot()
gg <- gg + geom_polygon(data=MainStates, aes(x=long,y=lat,group=group),
                        color="white", fill="grey")
gg <- gg + geom_polygon(data=Data_AllStates, aes(x=long,y=lat,group=group, 
                                                 fill=as.factor(Percent)), color="white") 
gg



Data_AllStates$Quota <- as.numeric(Data_AllStates$Quota)


filter(Data_AllStates, !is.na(Quota)) 
gg <- ggplot()
gg <- gg + geom_polygon(data=East_Coast, aes(x=long,y=lat,group=group),
                        color="white", fill="grey")
gg <- gg + geom_polygon(data=Data_AllStates, aes(x=long,y=lat,group=group, 
      fill=as.factor(Quota)), color="white") 
gg <- gg + scale_fill_discrete(na.translate=FALSE)
gg <- gg + labs(fill = "Quota (LBS)")
gg <- gg + labs(caption = "Note: The PRFC was allotted the remaining 2,545,595 lbs of the quota.")
gg 
ggsave("QuotaPounds.png")


gg <- ggplot()
gg <- gg + geom_polygon(data=East_Coast, aes(x=long,y=lat,group=group),
                        color="white", fill="grey")
gg <- gg + geom_polygon(data=Data_AllStates, aes(x=long,y=lat,group=group, 
      fill=as.factor(Percent)), color="white") 
gg <- gg + scale_fill_manual(name="Percent",labels = c("0.00", "0.01","0,02","0.04","0.06","0.49","0.84","1.61","11.16","85.11"), 
      values = c("#fecc5c","#fecc5c","#fecc5c","#fecc5c","#fecc5c","#fecc5c","#fecc5c",
                 "#fd8d3c","#f03b20", "#bd0026"))
gg
ggsave("QuotaPercent.png")



gg2 <- ggplot()
gg2 <- gg2 + geom_polygon(data=East_Coast, aes(x=long,y=lat,group=group),
                        color="black", fill="white")
gg2 <- gg2 + geom_polygon(data=Data_AllStates, aes(x=long,y=lat,group=group, 
                                                 fill=as.factor(Percent)), color="black") 
gg2 <- gg2 + scale_fill_manual(name="Percent", labels = c("0.00", "0.01","0,02","0.04","0.06","0.49","0.84","1.61","11.16","85.11"), 
                             values = c("#bdd7e7","#bdd7e7","#bdd7e7","#bdd7e7","#bdd7e7","#bdd7e7","#bdd7e7",
                                        "#3182bd","#08519c", "#c51b8a"))
gg2
ggsave("QuotaPercent2.png")
