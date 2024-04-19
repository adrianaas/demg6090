

equation1=function(x){308745538*exp(0.007095736*(x))}
equation2=function(x){308745538 + (((331449281 - 308745538)/10) * x)}

par(mfrow = c(1, 2))
curve(equation1, from=4, to=6, xlab="Time In Years Since 2010", ylab="Population", 
      col="blue", lwd=1, main="Exponential vs. Linear Growth" )
curve(equation2, from=4, to=6, n=300, add=TRUE, xlab="X", ylab="Y", col="red",lwd=1)
legend(x="topright", legend=c("exp", "linear"), lty = c(1,2), col=c("blue","red"))

curve(equation1, from=-100, to=100, xlab="Time In Years Since 2010", ylab="Population", 
      col="blue", lwd=1, main="Exponential vs. Linear Growth" )
curve(equation2, from=-100, to=100, n=300, add=TRUE, xlab="X", ylab="Y", col="red",lwd=1)
legend(x="topright", legend=c("exp", "linear"), lty = c(1,2), col=c("blue","red"))
