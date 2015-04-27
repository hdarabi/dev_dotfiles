na0    = function(x){ x[is.na(x)] = 0; x }
sna    = function(x){ sum(is.na(x)) }
str1   = function(x){ str(x, max.level=1)}
str2   = function(x){ str(x, max.level=2)}
str3   = function(x){ str(x, max.level=3)}

rmwarn = function(){ assign("last.warning", NULL, envir = baseenv()) }