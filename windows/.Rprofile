##################################################################
# Name        : .Rprofile
# Description : This is my handy functions list.
# Version     : 0.0.6
# Created On  : 2016-01-07
# Modified On : 2016-01-12
# Author      : Hamid R. Darabi, Ph.D.
##################################################################

options(scipen=100)
unlink(".RData")
cat("\014")
library("utils")
library("stats")
library(vimcom)
options(vimcom.verbose = 1)
df  = read.csv("c:\\users\\hamid.darabi\\documents\\quotes.csv", stringsAsFactors=FALSE)
rnd = 1 + floor( runif( 1, 1, nrow(df) ) )

if( as.POSIXlt(Sys.time())$hour < 12 ){ 
    timeStr = "Good Morning,"
}else{ 
    timeStr = "Good afternoon,"
}

print( paste( df[rnd,"quote"]) )
print( paste("Hi Hamid!", timeStr ) )
rm(list = ls())
na0    = function(x){ x[is.na(x)] = 0; x }
sna    = function(x){ sum(is.na(x)) }
str1   = function(x){ print(deparse(substitute(x))); str(x, max.level=1)}
str2   = function(x){ print(deparse(substitute(x))); str(x, max.level=2)}
str3   = function(x){ print(deparse(substitute(x))); str(x, max.level=3)}
rmwarn = function(){ assign("last.warning", NULL, envir = baseenv()) }
fch    = function(x){ levels(x)[x] }
l      = function(x){ length(x) }
getlines  = function(x){
    content = readLines(x)
    print( length(content) )
}

sc     = function(x){ sapply(x, class) }
g      = function(pattern, folder = ".", rec = TRUE){
    filesList = dir(folder, pattern = ".R$|.r$", recursive = rec)
    whichLines = NULL
    for(fileName in filesList){
        content = readLines(paste0(folder, "/", fileName))
        whichLines = grep(pattern, content)
        for(anyLine in whichLines){
            print(paste(fileName, "-", anyLine, ":", content[anyLine] ))
        }
    }
    if(is.null(whichLines)) print("No match found.")
}

getLast = function(x){
        if(class(x) == "data.frame")
                return(x[, NCOL(x), drop = TRUE])
        if(class(x) %in% c("numeric", "character", "integer", "factor"))
                return(x[length(x)])
}

mytags  = function(folder = ".", rec = TRUE, ofile = "TAGS"){
    filesList = dir(folder, pattern = ".R$|.r$", recursive = rec)
    sink(ofile)
    header = paste0('!_TAG_FILE_FORMAT	2\n',
                    '!_TAG_FILE_SORTED	0\n',
                    '!_TAG_PROGRAM_AUTHOR Hamid R. Darabi\n',
                    '!_TAG_PROGRAM_NAME	HamidRScript\n',
                    '!_TAG_PROGRAM_URL	http://hamid.darabi.org\n',
                    '!_TAG_PROGRAM_VERSION	1.0\n\n')
    cat(header)
    for(fileName in filesList){
        path = paste0(folder, "/", fileName)
        # cat(paste0(path, "\n"))
        content = readLines(paste0(folder, "/", fileName))
        pattern = '([ \t]*)+?([.A-Za-z][.A-Za-z0-9_]*)?([ \t])*(<-|=)([ \t])*function|setMethod'
        whichLines = grep(pattern, content)
        for(anyLine in whichLines){
            lineContent = content[anyLine]
            if(! grepl('([ \t])*\\#|error', lineContent)){
                if(grepl("setMethod", lineContent)){
                    tagName = gsub('\\"\\,.*', '', gsub('setMethod([ \t])*\\(([ \t])*\\"', '', lineContent))
                }else{
                    tagName = gsub('([ \t]*)' , '', gsub('([ \t])*(<-|=)([ \t])*function.*', '', lineContent))
                }
                tagAddress = paste0("norm! ", anyLine, "G", regexpr(tagName, lineContent)[1], "|")
                cat(paste0(tagName, "\t", path, "\t", tagAddress, "\n"))
            }
        }
        cat("\n")
    }
    sink()
    sink()
}

strCount = function(x, pattern, split){
    unlist(lapply(strsplit(x, split),
                  function(z) na.omit(length(grep(pattern, z)))
                  )
    )
}

trim = function (x) gsub("^\\s+|\\s+$", "", x)

getVarName = function(selections, ID){
    i = as.numeric(selections[ID, "curLevel"])
    curPath = character(i)
    for(j in ID:1){
        if(selections[j, "curLevel"] == i){
            curPath[i] = selections[j, "curName"]
            i = i - 1
        }
    }
    curPath = gsub("\\$\\$", "$", paste0(curPath, collapse = "$"))
    curPath = gsub("\\$$", "", curPath)
    curPath = gsub("@\\$", "@", curPath)
    curPath = gsub("\\$\\[", "[", curPath)
    curPath
}

# This function finds a variable name in a complex class
vf = function(var, pattern, first = TRUE){
    res = capture.output(str(var))
    n = length(res)
    selections = data.frame(curLevel = character(n), curName = character(n), stringsAsFactors = FALSE)
    curPath = list()
    var1 = as.character(match.call()[2])
    inList = FALSE
    j = 0
    for(i in 1:n){
        curLine = res[i]
        curLevel = strCount(curLine, "\\.\\.", " ") + 1
        curName = trim(substr(curLine, regexpr("\\$|@", curLine)[1]+1, regexpr(":", curLine)[1]-1))
        if(curName == "" & grepl("class", curLine)) curName = "@"
        if(curName == "" & grepl("List", curLine)) curName = "[[]]$"
        selections[i,"curLevel"] = curLevel
        selections[i, "curName"] = curName
    }
    mat = grep(paste0("\\$([ \t]*)", pattern, "([ \t]*):"), res)
    if(length(mat) == 0){
        return ("Variable not found. Please make sure you loaded class definition.")
    }
    if(first){
        print(paste0(var1, getVarName(selections, mat[1])))
    }else{
        for(ID in mat){
            print(paste0(var1, getVarName(selections, ID)))
        }
    }
}
