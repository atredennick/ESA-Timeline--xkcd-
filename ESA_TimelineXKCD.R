rm(list=ls())
setwd("/Users/atredenn/Documents/NREL EcoPress/ESA-Timeline/")

##Packages needed; uncomment if you need to install
# install.packages("ggplot2", dependencies=TRUE)
# install.packages("reshape2")
# install.packages("xkcd")

##Import the Humor Sans font after you install it on your computer
# font_import(pattern="Humor Sans")

#Read in data
data <- read.csv("ESA_Timeline.csv", header=TRUE)
#Convert to data frame
data <- as.data.frame(data)

#Make new dataframe just for the "base" line curve
data.base <- data.frame(Time=data$Time,
                        Base=data$Base)

#Melt the dataframe for plotting
require(reshape2)
df.m <- melt(data, id.vars="Time")

#Set colors, these were retrieved from "I Want Hue", http://tools.medialab.sciences-po.fr/iwanthue/
cols <- c("#389AD6",
          "#E17317",
          "#52F47C",
          "#4A002A",
          "#416603",
          "#742992",
          "#B61F32",
          "#C46606")

#Set x and y range for axes
xrange <- range(data$Time)
yrange <- range(data$Base)

#Make the plot
require(ggplot2)
require(xkcd)
ggplot()+
  geom_smooth(data=df.m, se=FALSE, aes(x=Time, y=value, color=variable), position="jitter") +
  geom_smooth(se=FALSE,data=data.base, aes(x=Time, y=Base), color="white", size=6, position="jitter")+
  geom_smooth(se=FALSE,data=data.base, aes(x=Time, y=Base), color="black", size=2) +
  scale_y_continuous(limits=c(0,100))+
  scale_color_manual(values=cols) +
  ylab("'Liveliness'")+ xlab("Hour of the Day")+
  ggtitle("Liveliness at ESA Throughout The Day")+
  theme_xkcd() +
  xkcdaxis(xrange,yrange) +
  guides(color=FALSE) #Toggle this on and off (and '+' above) to see legend


