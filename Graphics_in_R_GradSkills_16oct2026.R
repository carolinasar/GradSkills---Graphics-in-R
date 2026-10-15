### Graphics in R ####

setwd("~/Library/CloudStorage/Box-Box/Carolina/USF_Help/Luanna/Grad_skills_2026/Graphics in R") # set yours

# Basic commands for plotting ####
# plot()                       # create a new plot of any type
# hist()                       # create a histogram
# lines()                      # add straight lines to an existing plot
# points()                     # add points to an existing plot.
# abline()                     # add a line of the form ax + b to an existing plot.
# segments(), arrows(), rect(), polygon() # Add (a sequence of) line segments, arrows, or rectangles to an existing plot.
# legend()                     # add a legend to an existing plot
# pairs()                      # Produce a matrix of scatter plots

#1. Make a simple plot ####
plot(1:100, 1:100,     #define x and y axes 
     type = "n",       #type of plot ("n" for no plotting)
     axes = F)         #Draw no axes

#Add some text to the plot
text(50, 50,          #specify x,y position of the text
     "Graphics in R", #your text (in quotation marks)
     cex = 3)         #size of your text, relative to default (1)
#add more text
text(50, 25, "Carolina Sarmiento, 10/16/2026", cex = 2)

#2. Point Types ----
# Demonstrate how to change default settings
plot(
  x    = rep(1:5, 4),        # set x positions  #check the help file for rep() 
  y    = rep(1:4, each = 5), # set y positions
  pch  = 1:20,               # set point types
  main = "Point Types",      # provide a main title
  col  = rainbow(20),        # set colors for the points
  xlim = c(0, 6),            # set limits on the x-axis
  ylim = c(0, 5),            # set limits on the y-axis
  xlab = "",                 # no label for x-axis
  ylab = "",                 # no label for y-axis
  cex  = 2,                  # set expansion of plotting characters (symbol size)
  las = 1)                   # set the style of axis labels to "always horizontal"

text(rep(1:5, 4), rep(1:4, each = 5), 1:20, pos = 4) # label each point with its pch value

# 3. Anscombe's quartet *** ----
data <- anscombe
head(data)

#Select x and y values
xval <- data[,c(1:4)]
yval <- data[,c(5:8)]

#Regressions (fit a linear model to each group of data)
lm1 <- lm(yval[,1]~xval[,1])
lm2 <- lm(yval[,2]~xval[,2])
lm3 <- lm(yval[,3]~xval[,3])
lm4 <- lm(yval[,4]~xval[,4])

# Anscombe's Figure
# pdf(file="Figures/Anscombe.pdf", family="Times", paper="special", width=7,height=7) #open a PDF graphical device to be saved on my Figures folder on my Working Directory

#set graphical PARameters (?par)
par(mfrow=c(2,2),   #Subsequent figures will be drawn in an n.row-by-n.col [c(nr,nc)]
    mar=c(4,4,0,0), #margins for each plot in number of lines
    oma=c(1,1,2,2), #outer margins in lines of text
    pty="s"         #type of plot region ("s" = square)
)
# Plot 1
plot(xval[,1], yval[,1],            #Define x and y
     las=1,                         #par: style of axis labels (1 = always horizontal)
     ylim = c(3,14),                #set the limits of y axis
     xlim = c(3,20),                #set the limits of y axis
     pch = 19,                      #type of point (or symbol)
     col= "black",                  #color
     ylab = expression(bold("Y")),  #Y axis label
     xaxt="n",                      #x axis type: "n" suppresses plotting of the axis 
     xlab = ""                      #No lable for x axis
)
axis(side = 1,at = c(4,6,8,10,12,14,16,18),labels = F, tick = TRUE) #add axis
text(4,13, expression(bold("1.")), las =1, xpd=NA, cex=1.2)       #add text
abline(lm1, col="grey",lty=2)                                     #add regression line

# Plot 2
plot(xval[,2], yval[,2],
     las=1,
     ylim = c(3,14),
     xlim = c(3,20),
     pch = 19,
     col= "black",
     ylab = "",
     xlab = "",
     xaxt="n",
     yaxt="n"
)
axis(side = 1,at = c(4,6,8,10,12,14,16,18),labels = F, tick = TRUE)
axis(side = 2,at = c(4,6,8,10,12,14),labels = F, tick = TRUE)
text(4,13, expression(bold("2.")), las =1, xpd=NA, cex=1.2)
abline(lm2, col="grey",lty=2)

# Plot 3
plot(xval[,3], yval[,3],
     las=1,
     ylim = c(3,14),
     xlim = c(3,20),
     pch = 19,
     col= "black",
     ylab = expression(bold("Y")),
     xlab = expression(bold("X")),
     xaxt="n"
)
axis(side = 1,at = c(4,6,8,10,12,14,16,18),labels = T, tick = TRUE)
text(4,13, expression(bold("3.")), las =1, xpd=NA, cex=1.2)
abline(lm3, col="grey",lty=2)

# Plot 4
plot(xval[,4], yval[,4],
     las=1,
     ylim = c(3,14),
     xlim = c(3,20),
     pch = 19,
     col= "black",
     ylab = "",
     xlab = expression(bold("X")),
     xaxt="n",
     yaxt="n"
)
axis(side = 1,at = c(4,6,8,10,12,14,16,18),labels = T, tick = TRUE)
axis(side = 2,at = c(4,6,8,10,12,14),labels = F, tick = TRUE)
text(4,13, expression(bold("4.")), las =1, xpd=NA, cex=1.2)
abline(lm4, col="grey",lty=2)

#dev.off() # close the current device (opened with function pdf() in line 59) and saves it

# 4. ggplot2 -----
# This cheat sheet might be useful:
# https://rstudio.com/wp-content/uploads/2015/12/ggplot2-cheatsheet-2.0.pdf

#First, install the package and its dependencies, it comes also in the tidyverse package ---> Check the packages window. 

#Then load the package
library(ggplot2)

#1. Set up your plot:
ggplot(iris)  # if only the data set is known.
ggplot(iris, aes(x=Sepal.Width))# if only X-axis is known. The Y-axis can be specified in respective geoms.
p <- ggplot(iris, aes(x=Sepal.Width, y=Sepal.Length))  # if both X and Y axes are fixed for all layers.
p
#note that this does not plot anything yet (only defines x and y axes)

#Now add some layers:
p <- p + geom_point()
#For a complete list of layers: https://ggplot2.tidyverse.org/reference/
p

#Add or change the labels:
p <- p + geom_point() +
     labs(title = "Scatterplot", 
       x = "Sepal Width (cm)", 
       y = "Sepal Length (cm)")
p

#Change the theme: you can override all settings with a complete theme like theme_bw(), or choose to tweak individual settings by using theme()
#install and load package ggthemes
library(ggthemes) #Extra Themes, Scales and Geoms for 'ggplot2'
p <- p + geom_point() +
     labs(title = "Scatterplot", 
       x = "Sepal Width (cm)", 
       y = "Sepal Length (cm)") +
     theme_economist() #use the style of "The Economist" graphics
p

#Display the data in facets:
p <- p + geom_point() + 
  labs(title = "Scatterplot", 
       x = "Sepal Width (cm)", 
       y = "Sepal Length (cm)") +
  theme_economist() + #use the style of "The Economist" graphics 
  facet_wrap(~Species, ncol = 3)
p

#Save your plot
ggsave("Figures/Iris_plot.pdf") #saves the last plot

#5. Let's do a plot in base R - work in pairs if possible:

#We will work on the iris data set (again!) and make a scatter plot of Sepal width (y-axis) vs. sepal length (x-axis). We will look at differences among species using points with different colors.

#A. Check the colorbrewer website (https://colorbrewer2.org) and use what we saw today to pick three colors (make a note (comment) on the script with the #HEX code)

#B. create an object to store the data:
mydata <- iris

#C. Subset the data set by species (e.g. each subset = a species, assign each subset to a different object)

#D. Create an empty plot: using the original data and set the argument type ="n", modify parameters to have the desired look.

#E. Add points, use a different color for each species - use the function points()

#F. Add a legend, using the function legend() - make sure to check the help file

# For advanced students, perhaps work on a plot with your data or try a new plot in ggplot. 

#Check ?ggthemes
# Explore the tvthemes and ThemePark packages
# Explore new color palettes (e.g., https://github.com/karthik/wesanderson)