na0    = function(x){ x[is.na(x)] = 0; x }
sna    = function(x){ sum(is.na(x)) }
str1   = function(x){ str(x, max.level=1)}
str2   = function(x){ str(x, max.level=2)}
str3   = function(x){ str(x, max.level=3)}

rmwarn = function(){ assign("last.warning", NULL, envir = baseenv()) }

gline  = function(df){
        col = rainbow(ncol(df)-1)
        library(ggplot2)
        g = ggplot(data=df, aes(x=data[,1],y=data[,2])) + geom_line(color=col[1])
        for( i in 3:ncol(df)){
                g = g + geom_line(data=data, aes(y=data[,i]), color=col[i-1])       
        }
        g
}