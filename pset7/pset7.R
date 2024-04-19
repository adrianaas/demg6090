#install.packages("tidyverse")
#library(readxl)
#install.packages("writexl")
#library(writexl)

data <- read_excel("6090-2023-ps7-data.xlsx", range="A8:D29")
options(digits=20)
population <- data[,2]
lifetable <- data[,3]
fertility <- data[,4]


#COHORT_COMPONENT_METHOD_FUNCTION
cohort_component_method <- function(population, lifetable, fertility) {
  
  population_new <- update_population(population, lifetable)
  births<-births(population,lifetable,fertility, population_new)
  unlist_births<-unlist(births)
  total_births<-sum(unlist_births)
  fiveLzero <- lifetable[1,1]
  population_new[1] <-total_births*(fiveLzero/(5*100000))
  return(population_new)
}

#UPDATE_POPULATION_FUNCTION
update_population <- function(population, lifetable) {
  population_new <- matrix(nrow = 21, ncol = 1)
      for (x in 2:20) {
        fiveNxminusfive <- population[x-1,]
        fiveLx <- lifetable[x,]
        fiveLxminusfive <- lifetable[x-1,]
        #print(fiveNx)
        #print(fiveLx)
        #print(fiveLxminusfive)
        fiveNx_new <- fiveNxminusfive*(fiveLx/fiveLxminusfive)
        population_new[x] <-fiveNx_new
      }
  
  population_new[21]<-(population[20,]+population[21,])*(lifetable[21,]/(lifetable[20,]+lifetable[21,]))
  
  return(population_new)
}

#CALCULATE_BIRTHS
births <- function(population,lifetable,fertility, population_new){
  births=0
   #iterate through reproductive ages x=15 to x=45
  for (x in 4:10) {
  fiveFx=fertility[x,]
  fiveNx=population[x,]
  fiveNx_new=population_new[x]
  fiveBx = 5*fiveFx*((fiveNx+fiveNx_new)/2)
  births[x]<-fiveBx/2.05
  }
  
  return(births)
}

#PROJECTION_FUNCTION: times are in 5 year periods and time 0 is 2010-2014

projection<-function(population, lifetable, fertility, times){
  population_new<-population
  for (x in 1:times){
    population_new[,1]<-unlist(cohort_component_method(population_new, lifetable, fertility))
  }
  return(population_new)
}

pop2020<-projection(population,lifetable,fertility,1)
pop2025<-projection(population,lifetable,fertility,2)
pop2030<-projection(population,lifetable,fertility,3)
projections<-cbind(pop2020, pop2025, pop2030)
#write_xlsx(projectionslong, path="C:/Users/adriana/Documents/penn/DEMG basic methods/projections.xlsx")

#test the following longterm projections, export, calculate nCx and mean annualized growth rate
poplong<-projection(population,lifetable,fertility,196)
poplonger<-projection(population,lifetable,fertility,195)
projectionslong<-cbind(poplong, poplonger)
#write_xlsx(projectionslong, path="C:/Users/adriana/Documents/penn/DEMG basic methods/projectionslong.xlsx")

#projections-replacementlevel
fertility_r<-fertility
for (i in 4:10){
  fertility_r[i,]=fertility[i,]/.81
}
poplong_r<-projection(population,lifetable,fertility_r,500)
momentum <- sum(poplong_r)/sum(population)
