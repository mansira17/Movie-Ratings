getwd()
setwd("C:\\Users\\mansira\\Desktop\\UMich\\Summer\\R")
getwd()


movies <- read.csv("P2-Movie-Ratings.csv")
head(movies)
colnames(movies) <- c("Film", "Genre", "CriticRating", "AudienceRating", "BudgetMillions", "Year")
str(movies)

movies$Film <- as.factor(movies$Film)
levels(movies$Film)

movies$Genre <- as.factor(movies$Genre)
levels(movies$Genre)

summary(movies)

movies$Year <- factor(movies$Year)


# Aesthetics : how your data maps to what you want to see

library(ggplot2)

ggplot(data = movies, aes(x = CriticRating, y = AudienceRating))

# adding geometry

ggplot(data = movies, aes(x = CriticRating, y = AudienceRating)) +
  geom_point()

# adding colour

ggplot(data = movies, aes(x = CriticRating, y = AudienceRating, 
                          colour = Genre)) +
  geom_point() 

# adding size - misleading because size has nothing to do with better genre

ggplot(data = movies, aes(x = CriticRating, y = AudienceRating, 
                          colour = Genre, size = Genre)) +
  geom_point()

# adding size - better way

ggplot(data = movies, aes(x = CriticRating, y = AudienceRating, 
                          colour = Genre, size = BudgetMillions)) +
  geom_point() 


# Plot 1 for the story (needs improvization)

# Plotting with layers

#object

p <- ggplot(data = movies, aes(x = CriticRating, y = AudienceRating, 
                               colour = Genre, size = BudgetMillions))  
p

p + geom_point()

# p + geom_line()


# Overriding aesthetics

q <- ggplot(data = movies, aes(x = CriticRating, y = AudienceRating, 
                               colour = Genre, size = BudgetMillions))   # mapping aesthetics

q + geom_point()

# overriding aes

q + geom_point(aes(size = CriticRating))   
q + geom_point(aes(colour = BudgetMillions))

# renaming axis : xlab, ylab

# reducing the line size

q + geom_line(size = 0) + geom_point()   # setting aesthetics

# Plot 2

q + geom_point(aes(x = BudgetMillions)) + 
  xlab("Budget Millions $$$")

# Indicates the budget does not really affect the rating given by
# the audience. 

# Mapping vs Setting

r <- ggplot(data = movies, aes(x = CriticRating, y = AudienceRating))
r + geom_point()

# adding colour by mapping

r + geom_point(aes(colour = Genre))

# adding colour by setting

r + geom_point(colour = "DarkGreen")

# error

#r + geom_point(aes(colour = "DarkGreen"))

# Mapping

r + geom_point(aes(size = BudgetMillions))

# Setting

r + geom_point(size = 1)


# Histograms and density charts

s <- ggplot(data = movies, aes(x = BudgetMillions))
s + geom_histogram(binwidth = 10)

# adding colour

s + geom_histogram(binwidth = 10, aes(fill = Genre))

# adding border

# Plot 3 (needs improvization)
s + geom_histogram(binwidth = 10, aes(fill = Genre), colour = "Black")

# Density charts

s + geom_density(aes(fill = Genre), position = "stack")


# Starting Layer Tips

t <- ggplot(data = movies, aes(x = AudienceRating))
t + geom_histogram(binwidth = 10,
                   fill = "White", colour = "Blue")

# another way

# Plot 4

t <- ggplot(data = movies)
t + geom_histogram(binwidth = 10,
                   aes(x = AudienceRating),
                   fill = "White", colour = "Blue")

# The plot indicates normal distribution.

# Plot 5

t + geom_histogram(binwidth = 10,
                   aes(x = CriticRating),
                   fill = "White", colour = "Blue")

# The critic rating is different than the audience rating. It indicates
# uniform distribution. It is mostly because they don't have bias since
# it's their profession unlike the audience.

# Statistical transformations

u <- ggplot(data = movies, aes(x = CriticRating, y = AudienceRating, 
                               colour = Genre))

u + geom_point() + geom_smooth(fill = NA)

# boxplots

u <- ggplot(data = movies, aes(x = Genre,y = AudienceRating, 
                               colour = Genre))

u + geom_boxplot()
u + geom_boxplot(size = 1.2)
u + geom_boxplot(size = 1.2) + geom_point()
u + geom_boxplot(size = 1.2) + geom_jitter()
u + geom_jitter() + geom_boxplot(size = 1.2, alpha = 0.5)

# Thriller - highest audience rating because the box is narrow i.e low variance


# Using facets

v <- ggplot(data = movies, aes(x = BudgetMillions))
v + geom_histogram(binwidth = 10, aes(fill = Genre), 
                   colour = "Black")

# facets

v + geom_histogram(binwidth = 10, aes(fill = Genre), 
                   colour = "Black") +
  facet_grid(Genre~., scales = "free")     # rows

v + geom_histogram(binwidth = 10, aes(fill = Genre), 
                   colour = "Black") +
  facet_grid(.~Genre, scales = "free")     # columns

# scatter plots

w <- ggplot(data = movies, aes(x = CriticRating, y = AudienceRating,
                               colour = Genre))

w + geom_point(size = 2)
w + geom_point(size = 2) + facet_grid(Genre ~ .)
w + geom_point(size = 2) + facet_grid(. ~ Year)
w + geom_point(size = 2) + facet_grid(Genre ~ Year)
w + geom_point(size = 2) + geom_smooth() + facet_grid(Genre ~ Year)
w + geom_point(aes(size = BudgetMillions)) + geom_smooth() + 
  facet_grid(Genre ~ Year)


# Coordinates

m <- ggplot(data = movies, aes(x = CriticRating, y = AudienceRating,
                               size = BudgetMillions,
                               colour = Genre))

m + geom_point()

# 50-100 CriticRating and 50-100 AudienceRating

m + geom_point() + 
  xlim(50,100) + 
  ylim(50,100)

# does not work properly always as required. Why?

n <- ggplot(data = movies, aes(x = BudgetMillions))
n + geom_histogram(binwidth = 10, aes(fill = Genre), colour = "Black")
n + geom_histogram(binwidth = 10, aes(fill = Genre), colour = "Black") + 
  ylim(0,50)

# cuts off the data. We want to zoom in.

n + geom_histogram(binwidth = 10, aes(fill = Genre), colour = "Black") +
  coord_cartesian(ylim = c(0,50))

# Improvized plot 1

w + geom_point(aes(size = BudgetMillions)) + geom_smooth() + 
  facet_grid(Genre ~ Year) +
  coord_cartesian(ylim = c(0, 100))

# Theme

o <- ggplot(data = movies, aes(x = BudgetMillions))
h <- o + geom_histogram(binwidth = 10, aes(fill = Genre), colour = "Black")

# adding axis label

h
h + xlab("Money Axis") +
  ylab("No. of Movies")

# label formatting

h + xlab("Money Axis") +
  ylab("No. of Movies") +
  theme(axis.title.x = element_text(colour = "DarkGreen", size = 30),
        axis.title.y = element_text(colour = "Red", size = 30))

# tick mark formatting

h + xlab("Money Axis") +
  ylab("No. of Movies") +
  theme(axis.title.x = element_text(colour = "DarkGreen", size = 15),
        axis.title.y = element_text(colour = "Red", size = 15),
        axis.text.x = element_text(size = 10),
        axis.text.y = element_text(size = 10))

# legend formatting

h + xlab("Money Axis") +
  ylab("No. of Movies") +
  theme(axis.title.x = element_text(colour = "DarkGreen", size = 10),
        axis.title.y = element_text(colour = "Red", size = 10),
        
        axis.text.x = element_text(size = 10),
        axis.text.y = element_text(size = 10),
        
        legend.title = element_text(size = 10),
        legend.text = element_text(size = 10),
        legend.position = c(1, 1),
        legend.justification = c(1, 1))

# adding title

h + xlab("Money Axis") +
  ylab("No. of Movies") +
  ggtitle("Movie Budget Distribution") +
  theme(axis.title.x = element_text(colour = "DarkGreen", size = 10),
        axis.title.y = element_text(colour = "Red", size = 10),
        
        axis.text.x = element_text(size = 10),
        axis.text.y = element_text(size = 10),
        
        legend.title = element_text(size = 10),
        legend.text = element_text(size = 10),
        legend.position = c(1, 1),
        legend.justification = c(1, 1),
        
        plot.title = element_text(colour = "DarkBlue", size = 15, family = "Courier"))