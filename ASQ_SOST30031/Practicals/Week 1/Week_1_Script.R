setwd("C:/Users/kanec/OneDrive - The University of Manchester/Uni Work/Year 3/Semester 1/Answering Social Research Questions/Practicals/Week 1")
getwd()
2+2
2+5
3-2
18/6
4*7
(5-3)^2/4
9^(1/2)*4
x <- 5
y <- 6
x+y
z=x*y
x< -5
y< -6
ls()
sqrt(144)
log10(8)
log10(100)
log(100)
exp(1)
pi
sin(pi/2)
abs(-7)
factorial(3)
exp(x)
log(y,2)
z <- x*y
trunc(x^2 + z/y)
log((100*x-y^2)/z)
round(exp(x), 2)
p <- abs(floor(log((100*x-y^2)/exp(z))))
p
?lm()
x <-  1:10
x
x <-  rep(1,10)
x
x <- c(2,6,4,2,3,7,1,5,9,8)
x
seq(1,10,0.2)
x <- rep(1,10)
y <-  1:10
x
y
c(x,y)
x+y
x+2/y
x^2/y
z <-  (x+y)/2
z
z <- c(z,rep(1,3),c(100,200,300))+1
z
p <-  2.5
z*p
x <- c(9,3,7,2,9,2,1,5,4,6)
x
x[4]
y <- c(4,1,0,8,1,x)
max(y)
range(y)
mean(y)
var(y)
sort(y)
cumsum(y)
z <- c(5,8,2)
z[10]
y <- c(9,3,7,2,9,2,1,5,4,6)
y[y >10]
y[y != 2]
ma1 <- matrix(c(1,0,-20,0,1,-15,1,-1,0),
              nrow=3,ncol=3,
              byrow=TRUE)
ma1
dim(ma1)
ma1 <- matrix(c(4,10,130,0,8,-7,9,11,-2,7,-5,4),
              nrow=3, ncol=4)
ma1
ma1[2,3]
ma1[1,]
ma1[,4]

x1 <- c(1,4,7,9,11,12,13,15,18)
x2 <- c(1,1,1,2,2,2,3,3,3)
x2-x1
x3 <- x1+x2
mean(x3)
var(x3)
median(x1)
median(x2)
median(x3)
m1 <- matrix(c(1,5,9,2,6,10,3,7,11,4,8,12), nrow=4, ncol=3, byrow=TRUE)
x1[2]
x2[2]
m1[2,3]
x1[5] + m1[1,1]
mean(x3[x3<13])