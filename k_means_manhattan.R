require(gdata)
require(class)

mt <- read.xls("/Users/joshishushruth/Dev/Doing_Data_Science/dds_datasets/dds_ch2_rollingsales/rollingsales_manhattan.xls", pattern="BOROUGH", stringsAsFactors = FALSE)
names(mt) <- tolower(names(mt))
mt$sale.price.n <- as.numeric(gsub("[^[:digit:]]", "", mt$sale.price))
sum(is.na(mt$sale.price.n))
sum(mt$sale.price.n == 0)

mt$gross.sqft <- as.numeric(gsub("[^[:digit:]]", "", mt$gross.square.feet))
mt$land.sqft <- as.numeric(gsub("[^[:digit:]]", "", mt$land.square.feet))
mt$sale.date <- as.Date(mt$sale.date)
mt$year.built <- as.numeric(as.character(mt$year.built))
mt$zip.code <- as.character(mt$zip.code)

## - standardize data (set year built start to 0; land and gross sq ft; sale price 
## (exclude $0 and possibly others);
min_price <- 10000
mt <- mt[which(mt$sale.price.n >= min_price), ]
n_obs <- dim(mt)[1]
mt$address.noapt <- gsub("[,][[:print:]]*", "", gsub("[ ]+", " ", trim(mt$address)))
mt_add <- unique(data.frame(mt$address.noapt, mt$zip.code, stringsAsFactors = FALSE))
names(mt_add) <- c("address.noapt", "zip.code")
mt_add <- mt_add[order(mt_add$address.noapt), ]

# find duplicate address with different zip codes
dup <- duplicated(mt_add$address.noapt)
dup_add <- mt_add[mt_add$dup, 1]
mt_add <- mt_add[(mt_add$address.noapt != dup_add[1] & mt_add$address.noapt != dup_add[2]) ,]