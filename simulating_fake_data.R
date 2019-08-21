x_1 <- rnorm(1000, 5, 7) #simulate a normal distribution of 1000 values with a mean of 5, and a standard deviation of 7
hist(x_1, col="grey")
true_error <- rnorm(1000,0,2)
true_beta_0 <- 1.1
true_beta_1 <- -8.2
y <- true_beta_0 + true_beta_1*x_1 + true_error 
hist(y) # plot p(y)
plot(x_1,y, pch=20,col="red") # plot p(x,y)

# Build a regression model based on y to get the same Bs values
model <- lm(y ~ x_1)
summary(model)
coefs <- coef(model)
plot(x_1, y, pch=0, col="green") 
abline(coefs[1], coefs[2]) # Looks similar to the first plot.

# Make a Gamma Distribution
x_2 <- rgamma(1000, 1, 1)
hist(x_2)
true_beta_3 <- 7.9
y_2 <- true_beta_0 + true_beta_1 * x_1 + true_beta_3 * (x_2 ^ 2) + true_error
plot(x_2, y_2, col="blue")
