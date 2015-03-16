df <- read.csv("train.csv")
head(df)
str(df$datetime)
tail(df)
nrow(df)
names(df)
#Finding the missing rows:
library(lubridate)

class(df$datetime)
df$datetime <- ymd_hms(df$datetime)
class(df$datetime)
head(df$datetime)
problemRows <- c()
#gap <- list()
for (i in 2:nrow(df)){
        if ((as.numeric(df$datetime[i]-df$datetime[i-1], units="hours")>1) & 
                    (as.numeric(df$datetime[i]-df$datetime[i-1], units="hours")< 14)) {
                problemRows <- c(problemRows,i)
                #gap[[i]]<-(df$datetime[i]-df$datetime[i-1])
        }
}
problemRows
#finding the gap at the problem rows
gap <- list()

for (i in problemRows){
        #print(i)
        gap[[as.character(i)]]<-(as.numeric(df$datetime[i]-df$datetime[i-1], units="hours"))
        
}
gap[[1]]
gap[[2]]
head(gap, length(problemRows))
#the class of the difference is

class(df$datetime[31]-df$datetime[30])
min(df$count)
for (i in problemRows){
        print(i)
        print(gap[[as.character(i)]])
        print(df[i-1,1])
        print(df[i, 1])
        
}
df$datetime[396]
df$datetime[397]
df[3723,]
df[3724,]
as.numeric(df$datetime[3724]-df$datetime[3723], units="hours")
for (i in problemRows){
        new_row<-df[(i-1),]
        new_row$temp <- as.numeric(mean(df$temp[(i-1):i]))
        new_row$atemp <- as.numeric(mean(df$atemp[(i-1):i]))
        new_row$windspeed <- as.numeric(mean(df$windspeed[(i-1):i]))
        new_row$humidity <- as.integer(mean(df$humidity[(i-1):i]))
        new_row$casual <- 0
        new_row$registered <- 0
        new_row$count <- 0
        for (j in 1 : (gap[[as.character(i)]]-1)){
                new_row$datetime <- new_row$datetime +hms("1 0 0") 
                df <- rbind(df, new_row)
                
        }
        
        
}
library(dplyr)
complete_df <- arrange(df, datetime)
tail(df, 50)
tail(complete_df)
Jan2011 <- filter(complete_df, datetime < ymd_hms("2011-02-01 00:00:00"))
Jan2011