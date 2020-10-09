#setwd("~/Library/Mobile Documents/com~apple~CloudDocs/UVA/20Spring_STAT6130/Final")

seoul <- read.csv("seoul.csv")
seoul$code <- factor(seoul$code)
seoul$latitude <- factor(seoul$latitude)
seoul$longitude <- factor(seoul$longitude)

seq8 <- seq(1, 647511, 8)
seoul8 <- seoul[seq8,]

#########################################################################################


###################################
###  Multivariate Regression 1  ###
###################################

## Multivariate Regression Model
lm1 <- lm(cbind(date,code,latitude,longitude) ~ SO2+NO2+O3+CO+PM10+PM2.5, data=seoul8)

## Residuals vs. Fitted Values
library(MASS)
fitted <- fitted(lm1)
studres <- studres(lm1)
plot(fitted, studres, xlab='Fitted Values', ylab='Studentized Residuals')
abline(h=0, lty=2)
identify(fitted, studres, row.names(seoul8))


## Multivariate Regression Model
lm2 <- lm(cbind(date,code,latitude,longitude) ~ 
            I(exp(-SO2))+I(exp(-NO2))+I(exp(-O3))+I(exp(-CO))+PM10+PM2.5, data=seoul8)

## Fit Plot
fitted2 <- fitted(lm2)
studres2 <- studres(lm2)
plot(fitted2, studres2, xlab='Fitted Values', ylab='Studentized Residuals')
abline(h=0, lty=2)
identify(fitted2, studres2, row.names(seoul8))

lm2$coefficients
summary(lm2)


#########################################################################################

#################################
###  Hypothesis Testing  ###
#################################

library(car)

C1 <- matrix(c(0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0), nrow=2, ncol=7)
linearHypothesis(model=lm2, hypothesis.matrix=C1)
# Since all p-values are very small and close to 0, the null hypothesis is rejected, and
# at least one coefficient of the two is not zero.

C2 <- matrix(c(0, 1, 0, 0, 0, 0, 0), nrow=1, ncol=7)
linearHypothesis(model=lm2, hypothesis.matrix=C2)
# Since all p-values are very small and close to 0, the null hypothesis is rejected, and
# beta1 is not zero.

C3 <- matrix(c(0, 0, 0, 1, 0, 0, 0), nrow=1, ncol=7)
linearHypothesis(model=lm2, hypothesis.matrix=C3)
# Since all p-values are very small and close to 0, the null hypothesis is rejected, and
# beta3 is not zero.


#########################################################################################


###################################
###  Multivariate Regression 2  ###
###################################

## Multivariate Regression Model
lm3 <- lm(cbind(PM10,PM2.5) ~ SO2+NO2+O3+CO, data=seoul8)

## Residuals vs. Fitted Values
fitted3 <- fitted(lm3)
studres3 <- studres(lm3)
plot(fitted3, studres3, xlab='Fitted Values', ylab='Studentized Residuals')
abline(h=0, lty=2)
identify(fitted3, studres3, row.names(seoul8))

lm3$coefficients
summary(lm3)


#########################################################################################

###################################
###  Exploratory Data Analysis  ###
###################################

library(ggplot2)


## Plot SO2
ggplot(seoul8) + 
  geom_jitter(aes(SO2,PM10), colour="red") + 
  geom_jitter(aes(SO2,PM2.5), colour="black") + 
  labs(x = "SO2", y = "PM10 & PM2.5")

## Plot NO2
ggplot(seoul8) + 
  geom_jitter(aes(NO2,PM10), colour="red") + 
  geom_jitter(aes(NO2,PM2.5), colour="black") + 
  labs(x = "NO2", y = "PM10 & PM2.5")

## Plot O3
ggplot(seoul8) + 
  geom_jitter(aes(O3,PM10), colour="red") + 
  geom_jitter(aes(O3,PM2.5), colour="black") + 
  labs(x = "O3", y = "PM10 & PM2.5")

## Plot CO
ggplot(seoul8) + 
  geom_jitter(aes(CO,PM10), colour="red") + 
  geom_jitter(aes(CO,PM2.5), colour="black") + 
  labs(x = "CO", y = "PM10 & PM2.5")

## Interestingly high PM10 values
highPM10 <- seoul8[(seoul8$PM10>1500),]
table(highPM10$code)

lm4 <- lm(PM10 ~ SO2+NO2+O3+CO+code+PM2.5, data=highPM10)
summary(lm4)


#########################################################################################

####################
###  Clustering  ###
####################

new_seoul8 <- seoul8[!(seoul8$PM10>1500),]

library(mclust)

pollutants <- seoul8[,6:9]
seoul8_clust <- Mclust(pollutants)
summary(seoul8_clust)


##### unreasonable method
### Misclassification Rate
#table(Class, seoul_clust$classification)

## Demension Reduction
seoul8_DR <- MclustDR(seoul8_clust, lambda=1)
summary(seoul8_DR)

## Plot clusters
plot(seoul8_DR, what="contour")
Class <- factor(seoul8$code)
seoul8_mis <- classError(seoul8_clust$classification, Class)$missclassified
points(seoul8_DR$dir[seoul8_mis,], pch=1, cex=2)

length(seoul8_mis)


####### New dataset by 1 week
seq168 <- seq(1, 647511, 168)
seoul168 <- seoul[seq168,]

new_pollutants <- seoul168[,6:9]

seoul168_clust <- Mclust(new_pollutants)

## Demension Reduction
seoul168_DR <- MclustDR(seoul168_clust, lambda=1)
summary(seoul168_DR)

## Plot clusters
plot(seoul168_DR, what="contour")

library(cluster)

## 3 Clusters
seoul168_scale <- scale(new_pollutants)
seoul168_clust3 <- kmeans(seoul168_scale, centers=3, nstart=20)
seoul168_dist <- dist(seoul168_scale, method="euclidean")
seoul168_sil3 <- silhouette(seoul168_clust3$cluster, dist=seoul168_dist)
plot(seoul168_sil3, main="Three Clusters")

## 5 Clusters
seoul168_scale <- scale(new_pollutants)
seoul168_clust5 <- kmeans(seoul168_scale, centers=5, nstart=20)
seoul168_dist <- dist(seoul168_scale, method="euclidean")
seoul168_sil5 <- silhouette(seoul168_clust5$cluster, dist=seoul168_dist)
plot(seoul168_sil5, main="Five Clusters")

## 7 Clusters
seoul168_scale <- scale(new_pollutants)
seoul168_clust7 <- kmeans(seoul168_scale, centers=7, nstart=20)
seoul168_dist <- dist(seoul168_scale, method="euclidean")
seoul168_sil7 <- silhouette(seoul168_clust7$cluster, dist=seoul168_dist)
plot(seoul168_sil7, main="Seven Clusters")

Class <- factor(seoul168$code)
seoul168_mis3 <- classError(seoul168_clust3$cluster, Class)$missclassified
length(seoul168_mis3)
plot(seoul168_scale, col=seoul168_clust3$cluster, main="Three Clusters")
