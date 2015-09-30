### Functions
### for analyzing gapminder data
### Andrew (your name here)
### September 29th

cal_CV <- function(x){
  mean_x <- mean(x)
  sd_x <- sd(x)
  CV <- sd_x/mean_x
  return(CV)
}