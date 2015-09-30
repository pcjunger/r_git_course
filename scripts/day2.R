## R course day 2
## 29 Sept 2015
## that was awesome
# load packages -----------------------------------------------------------

library(ggplot2)

# load gapminder data -----------------------------------------------------

gapminder <- read.csv("data/gapminder.csv")


# load functions ----------------------------------------------------------

source("scripts/functions.R")
# # subsetting review -----------------------------------------------------

#methods of subsetting
# x[a] for vectors

x <- c(10:1)
x
x[3]

# x[a, b] matrices, data.frames, not lists

x <- list(c(1:10), c(10:20))
x
x[1,2]

# x["a"] or x["a",] vector, data frame or matrix with names

x <- list(c(1:10), c(10:20))
x
x[[1]]

# x$a

names(x) <- c("one", "two")
x
x$two

## more complex subsetting
# >, <, ==

gapminder[gapminder$country == "Brazil", ]

x <- c(1:10)
x
x[x > 7]
x[x < 3]

# %in%

x <- c(1:10)
names(x) <- letters[1:10]


x==c(4,5,6)#this doesn't work

#so you need to use the %in% operator

x[x %in% c(4, 5, 6)]

x[names(x) %in% c("d", "e", "f")]

##CHALLENGE 1!

# 1.
#incorrect 
gapminder[gapminder$year = 1957,]
#correct
gapminder[gapminder$year == 1957,]
#2.
#incorrect

#correct
head(gapminder [,-c(1:4)])
#3. 
gapminder[gapminder$lifeExp > 80,]
#4. 
gapminder[1, c(4,5)]
#5. 
#incorrect
gapminder[gapminder$year == 2002 | 2007,]
#correct
gapminder[gapminder$year == 2002 | gapminder$year == 2007,]
gapminder[gapminder$year %in% c(2002, 2007),]

# prefix/infix ------------------------------------------------------------

##prefix
sum(2, 3)
## infix
2 + 3
## infix como um prefix
'+'(2, 3)

# protting review ---------------------------------------------------------

ggplot(data = gapminder, aes(x = lifeExp, y = gdpPercap, 
                             color = continent, group=country))+
  geom_line()+
  geom_point(color="yellow", size=2)+
  scale_y_log10()

#change the colour

#density plots
ggplot(data = gapminder, aes(gdpPercap, fill=continent))+
  geom_density(alpha = 0.4)+
  scale_x_log10()+
  facet_wrap(~year, scales = "free")+
  theme_light() + facet_grid(~continent)

#saving a plot
## first way of saving a file
ggsave("figures/density_plot.pdf") 
## another way of saving a file
pdf(file= "figures/pdf_density_plot", height = 3)
ggplot(data = gapminder, aes(gdpPercap, fill=continent))+
  geom_density(alpha = 0.4)+
  scale_x_log10()+
  theme_light() + facet_grid(~continent)

ggplot(data = gapminder, aes(gdpPercap, fill=continent))+
  geom_density(alpha = 0.4)+
  scale_x_log10()+
  facet_wrap(~year, scales = "free")+
  theme_light()


dev.off()

#multiplot
##grid.arrage
###gridExtra

#Working with data frames

# add a new column

iris$Family  <- "Iridaceae"
head(iris)

# add a column using data from the data frame
iris$Petal.Area <- iris$Petal.Width * iris$Petal.Length
head(iris)

iris$Sepal.Area <- with(iris, Sepal.Width * Sepal.Length)
head(iris)

#summary stats
mean(iris$Petal.Width)
sd(iris$Petal.Width)
median(iris$Petal.Width)

#Challenge!
m.sl <- mean(iris$Sepal.Length)
sd.sl <- sd(iris$Sepal.Length)
cv <- sd.sl/m.sl
cv

#DRY - Don't repeat yourself


# R functions! ------------------------------------------------------------

cal_CV(iris$Sepal.Length)
cal_CV(iris$Sepal.Width)
cal_CV(iris$Petal.Area)
cal_CV(gapminder$gdpPercap)
cal_CV(rnorm(2000))
## area of a circle

diam1 <- circum_to_diameter(4)
circum_to_diameter(3)

## Challenge: Write a function that calculates the radius from the diameter!

radius <- diameter_to_radius(diam1)

radius_to_area(radius)

area_from_circum(40)

# make a data.frame

circs <- data.frame(xs= 10:200)
head(circs)

circs$areas <- area_from_circum(circum = circs$xs)
head(circs)

ggplot(circs, aes(x=xs, y = areas)) +
  geom_line()


# Saving data -------------------------------------------------------------

brazil <- gapminder[gapminder$country == "Brazil",]
brazil
?write.table
write.table(x=brazil, file="cleaned_data/brazil_data.csv", sep = ",")

write.table(x=brazil, file="cleaned_data/brazil_data.csv", sep = ";",
            row.names = FALSE,
            quote= FALSE
              )

write.table(x=brazil, file="cleaned_data/brazil_data.csv", sep = "\t",
            row.names = FALSE,
            quote= FALSE
)

?read.table


##CHALLENGE 3!!

y90 <- gapminder[gapminder$year >= 1990,]
head(y90)

write.table(x=y90, file="cleaned_data/1990_data.csv", sep=";",
            row.names = FALSE,
            quote = FALSE
            )