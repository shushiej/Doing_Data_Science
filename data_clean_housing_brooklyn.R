require(gdata)
require(dplyr)
require(ggplot2)

bk <- read.xls('./Dev/Doing_Data_Science/dds_datasets/dds_ch2_rollingsales/rollingsales_brooklyn.xls', pattern = "BOROUGH")
summary(bk)

bk$SALE.PRICE.N <- as.numeric(gsub("[^[:digit:]]", "", bk$SALE.PRICE))
count(is.na(bk$SALE.PRICE.N))

names(bk) <- tolower(names(bk))

bk$gross.sqft <- as.numeric(gsub("[^[:digit:]]","",
                                 bk$gross.square.feet))
bk$land.sqft <- as.numeric(gsub("[^[:digit:]]","",
                                bk$land.square.feet))
bk$sale.date <- as.Date(bk$sale.date)
bk$year.built <- as.numeric(as.character(bk$year.built))

attach(bk)
hist(sale.price.n)
hist(sale.price.n[sale.price.n>0])
hist(gross.sqft[sale.price.n==0])
detach(bk)

bk.sale <- bk[bk$sale.price.n!=0,]
plot(bk.sale$gross.sqft,bk.sale$sale.price.n)
plot(log(bk.sale$gross.sqft),log(bk.sale$sale.price.n))

bk.homes <- bk.sale[which(grepl("FAMILY",
                                bk.sale$building.class.category)),]
plot(log(bk.homes$gross.sqft),log(bk.homes$sale.price.n))

bk.homes[which(bk.homes$sale.price.n<100000),] [order(bk.homes[which(bk.homes$sale.price.n<100000),]
       $sale.price.n),]
## remove outliers that seem like they weren't actual sales
bk.homes$outliers <- (log(bk.homes$sale.price.n) <=5) + 0
bk.homes <- bk.homes[which(bk.homes$outliers==0),]
plot(log(bk.homes$gross.sqft),log(bk.homes$sale.price.n))