install.packages("ISLR")
library("ISLR")
print(head(College,100))
?apply
maxs <- apply(College[,2:18], 2, max)
mins <- apply(College[,2:18], 2, min)

# Use scale() and convert the resulting matrix to a data frame
scaled.data <- as.data.frame(scale(College[,2:18],center = mins, scale = maxs - mins))

# Check out results
print(head(scaled.data,2))


# Convert Private column from Yes/No to 1/0
Private = as.numeric(College$Private)-1
data = cbind(Private,scaled.data)

install.packages("caTools")
library(caTools)
set.seed(101)

# Create Split (any column is fine)
split = sample.split(data$Private, SplitRatio = 0.7)
?sample.split
# Split based off of split Boolean Vector
train = subset(data, split == TRUE)

train
feats <- names(scaled.data)
feats
# Concatenate strings
f <- paste(feats,collapse=' + ')
f <- paste('Private ~',f)
f
# Convert to formula
f <- as.formula(f)
f
install.packages('neuralnet')
library(neuralnet)
nn <- neuralnet(f,train,hidden=c(10,10,10),linear.output=FALSE)

predicted.nn.values <- compute(nn,test[2:18])
predicted.nn.values


print(head(predicted.nn.values$net.result))

