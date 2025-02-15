a <- c(1,2,3)
print(a)

a <- 1:3
print(a)

print(a[2])
print(a[2:3])
print(a[c(2:3)])

print(a2<-c("A","B","C"))

b <- matrix(c(1,2,3,4,5,6), nrow=2, ncol=3)
print(b)
print(t(b))

c <- matrix(c(1,2,3,4), nrow=2, ncol=2)
print(c)
print(solve(c))
print(det(c))

print(c %*% b)

d<-data.frame(x=c(10,20,30), y=c("A","B","C"))
print(d)
print(d$x)
print(d[2,])
print(d[2,1])
print(names(d))
print(names(d)<-c("num","text"))

e<-list(a2, b, d)
print(e)