############################
## Iris dataset analysis   #
############################

#Loading internal R dataset
data(iris)

print(head(iris))
print(table(iris$Species))
print(summary(iris))

#Graphics
library(ggplot2)
p2 = ggplot(iris, aes(x=Species, y=Sepal.Width)) +
  geom_point(aes(fill=Species), size=5, shape=21, colour="grey20",
             position=position_jitter(width=0.2, height=0.1)) +
  geom_boxplot(outlier.colour=NA, aes(fill=Species), colour="grey20", alpha=0.3) +
  ggtitle("Sepal width")
print(p2)

#T test
res1 = t.test(iris$Sepal.Width[which(iris$Species == "setosa")], iris$Sepal.Width[which(iris$Species == "versicolor")])
print(res1)

res2 = t.test(iris$Sepal.Width[which(iris$Species == "versicolor")], iris$Sepal.Width[which(iris$Species == "virginica")])
print(res2)

#New graph
df1 <- data.frame(a = c(1,1,2,2), b = c(4.5, 4.6,4.6,4.5))
df2 <- data.frame(a = c(2,2,3,3), b = c(3.9, 4,4,3.9))
p3 = p2 + geom_line(data = df1, aes(x = a, y = b)) + annotate("text", x = 1.5, y = 4.65, label = "***", size = 8) +
  geom_line(data = df2, aes(x = a, y = b)) + annotate("text", x = 2.5, y = 4.05, label = "*", size = 8) 

pdf("sepalWidth.pdf")
print(p3)
dev.off()
