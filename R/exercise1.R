# ------------------------------------------------------------------------------
# Coding basic

# R as a calculator ------------------------------------------------------------
2 + 2                # addition
2 - 2                # subtraction
2 * 2                # multiplication
2 / 2                # division
2^2                  # a to the power b
# using inbuilt functions
exp(1)               # e to the power 2
log(5)               # natural logaritm (ln) of 5
log10(5)             # base 10 log of 5

# Get help on functions --------------------------------------------------------
?log

# Data types -------------------------------------------------------------------
class(1.2)           # number
class("A")           # string
class(TRUE)          # logical
class(factor('A'))   # factor

# Creating data object ---------------------------------------------------------
x <- 1 + 1           # save the result of a calculation as an object
# "assignment" shortcut: Alt minus sign (Alt+ -)
x                    # inspect an object by typing its name

# Vectors ----------------------------------------------------------------------
1:10                 # A vector from 1 to 10
c(1:10)              # same
10:1                 # reverse
length(1:10)         # length of a vector
sort(10:0)           # sorts a vector into ascending
rep(2, 3)            # makes a vector that contains 2, 3 times

# transforming vectors ---------------------------------------------------------
x <- 1:10
x + 1
x - 20
x * 2
x / 2
x^2
log(x)

# Subsetting: selecting parts of vectors ---------------------------------------
x <- c(1:10)
x[1]                 # get the first element of a vector
x[c(1, 2)]           # get the first and second element
x[-1]                # get every element except the first one
x[-c(1, 8)]          # get every element except 1 and 2

# Logical statements -----------------------------------------------------------
a <- 10
b <- -20
a == b               # a is equal to b
a != b               # a is not equal to b
a > b                # a is greater than b
a >= b               # a is greater or equal to b
a < b                # a is less than b
a <= b               # a is less or equal to b
a & b                # a and b
a | b                # a or b
is.na(a)             # is a equal to NA (missing)

# Selecting parts of vectors using logical statements --------------------------
x <- c(1:10)
x < 3
x[x < 3]
x[x != 3 & x < 5]    # all elements that not equal to 3 and <5
x[is.na(x)]          # all elements that are NA
x[!is.na(x)]         # all elements that are not NA

# Summary statistics
x <- rnorm(n = 50, mean = 20, sd = 4)
x
# check out ?rnorm
mean(x)       # mean
median(x)     # median
quantile(x)   # quantiles
summary(x)    # depends on what we feed it with...
sd(x)         # standard deviation
var(x)        # variance
range(x)      # range
min(x)        # smallest value
max(x)        # largest value

# Dataframes - similar to database tables --------------------------------------

d <- data.frame(x = c(1:10),
                y = c(10:1),
                z = letters[1:10],
                stringsAsFactors = FALSE)  # will explain this later
d
class(d)
# accessing columns:
d$x               # by name
d[,3]             # by column position
d[, c("y", "z")]
# accessing rows
d[2,]             # by row position
# accessing both rows and columns
d[2, 3]
d[2, "z"]
d[2:4, "z"]

# subsetting data.frame via logical argument -----------------------------------
d[d$x >= 7,]              # only rows where x is greater than or equal to 7
d[d$x >= 7 & d$y >= 9,]   # rows where x >= 7 and y >= 9
d[d$x >= 7 | d$y >= 10,]  # rows where x >=7   or y >= 9

# dataframe information --------------------------------------------------------
dim(d)            # number of rows and number of columns
nrow(d)           # number of rows
ncol(d)           # number of columns
str(d)            # structure of any object, here the dataframe

# General information & orientataion -------------------------------------------
getwd()           # where is my working directory?
dir()             # what is in it?
dir("..")         # what is in the parent directory?
dir("../..")      # what is in the grandparent directory?

ls()              # what objects are in the global environment (pos = 1)?
ls(2)             # what objects are in the second environment*
search()          # what environments (packages) are loaded?


# Changing working directories -------------------------------------------------
#    Note: We strongly recomend not to use this, particularily not if you are
#          writing reproducable code and documents in rmarkdown
dir()
oldwd <- getwd()
oldwd

setwd("..")   # move one directory up
getwd()       # where am I?
dir()         # what is in here?

setwd(oldwd)  # get back to base
