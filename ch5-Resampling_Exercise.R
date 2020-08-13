
## Resampling Review


# Load the packages and data
library(boot)
load("data\\5.R.RData")


# Train a linear model
my_model <- lm(y~X1+X2, data=Xy)

# Check it's summary to get the SE for out estimate of the coefficient for X1
summary(my_model)



# Plot the variables against each other
# Each line is a column from Xy
matplot(Xy,type="l")



## Bootstrapping

# Create a function that returns the estimate for the coefficient of X1
# The index variable is used to create the data subset
my_func2 <- function(my_data, index){
  my_model <- lm(y~X1+X2, data=my_data[index,])
  my_model$coefficients[2]
}

# Apply this function on 100 resampled subsets
my_boot <- boot(Xy, my_func2, R=100)
my_boot
# The std error of this estimate is higher than the std error from the lm
# Why is this?




## Block Bootstrapping
# Here we split data into 100 row chunks, then pick 10 chucks with replacement
# Easiest done by using tsboot (time series boot)
block_boot <- tsboot(tseries = Xy, my_func2, R=100, 
                   # L is the block size, sim = fixed means used fixed block lengths
                   l = 100, sim = "fixed")
block_boot
# The std error here is much higher than when selecting data at random




