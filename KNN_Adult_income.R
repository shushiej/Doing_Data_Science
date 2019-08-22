require(dplyr)
require(class)

data <- read.csv('/Users/joshishushruth/Dev/Doing_Data_Science/dds_datasets/adult.csv')
df = select(data, age, fnlwgt, hours.per.week, income)

nrows <- nrow(df)
sampling_rate <- 0.8
num.test.set.labels <- nrows * (1 - sampling_rate)

training <- sample(1:nrows, sampling_rate * nrows, replace=FALSE)
train <- subset(df[training,], select = c(age, fnlwgt, hours.per.week))

testing <- setdiff(1:nrows, training)
test <- subset(df[testing, ], select = c(age, fnlwgt, hours.per.week))

cl <- df$income[training] #classification labels
true.labels <- df$income[testing] #true labels

for (k in 1:20){
  print(k)
  predicted.labels <- knn(train, test, cl, k)
  num.incorrect.labels <- sum(predicted.labels != true.labels)
  misclassfication.rate <- num.incorrect.labels / num.test.set.labels
  print(misclassfication.rate)
}

#test the new k value on test set.
test_2 <- c(23,134446,54)
knn(train, test_2, cl, k=20)
