na0    = function(x){ x[is.na(x)] = 0; x }
sna    = function(x){ sum(is.na(x)) }
str1   = function(x){ str(x, max.level=1)}
str2   = function(x){ str(x, max.level=2)}
str3   = function(x){ str(x, max.level=3)}
rmwarn = function(){ assign("last.warning", NULL, envir = baseenv()) }
fch    = function(x){ levels(x)[x] }
getlines = function(x){ length(strsplit(inside_file, "\n")[[1]]) }

TwoTSCompare = function(data, DateVariable, First, Second){
  library(ggplot2)
  library(gtable)
  library(grid)
  LocalSubset = data[ , c(DateVariable, First, Second)]
  names(LocalSubset) = c("Date", "First", "Second")
  
  p1 = ggplot(aes(x = Date, y = First), data = LocalSubset) + geom_line(color = "blue") + 
    ylim(0, max(LocalSubset$First)) + ggtitle(First) + theme_bw()
  p2 = ggplot(aes(x = Date, y = Second), data = LocalSubset) + geom_line(colour = "red") +
    theme(panel.background = element_rect(fill = NA)) 
  
  g1 <- ggplot_gtable(ggplot_build(p1))
  g2 <- ggplot_gtable(ggplot_build(p2))
  pp <- c(subset(g1$layout, name == "panel", se = t:r))
  g <- gtable_add_grob(g1, g2$grobs[[which(g2$layout$name == "panel")]], pp$t, 
                       pp$l, pp$b, pp$l)
  
  # axis tweaks
  ia <- which(g2$layout$name == "axis-l")
  ga <- g2$grobs[[ia]]
  ax <- ga$children[[2]]
  ax$widths <- rev(ax$widths)
  ax$grobs <- rev(ax$grobs)
  ax$grobs[[1]]$x <- ax$grobs[[1]]$x - unit(1, "npc") + unit(0.15, "cm")
  g <- gtable_add_cols(g, g2$widths[g2$layout[ia, ]$l], length(g$widths) - 1)
  g <- gtable_add_grob(g, ax, pp$t, length(g$widths) - 1, pp$b)
  
  grid.draw(g)
}

getColsInData <- function(cols, data){
  cols[ sapply(cols, function(x) x %in% names(data)) ]  
}

getColsNotInData <- function(cols, data){
  cols[ sapply(cols, function(x) !x %in% names(data)) ]  
}

LabelMaker = function(x){
  y = gsub("000000$","M",x)
  y = gsub("000$", "K", y)
  y
}

multiplot = function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  require(grid)
  
  # Make a list from the ... arguments and plotlist
  print( class(plotlist))
  if(class(plotlist) != "list"){
    plots <- c(list(...), plotlist)
  }else{
    plots <- plotlist
  }
  numPlots = length(plots)
  
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }
  
  if (numPlots==1) {
    print(plots[[1]])
    
  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    
    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}

createEmptyDataFrame = function(columnNames, numberOfRows = 0, stringsAsFactors = FALSE){
  emptyDataFrame = data.frame(matrix(NA, ncol = length(columnNames), nrow = numberOfRows), stringsAsFactors = stringsAsFactors)
  names( emptyDataFrame ) = columnNames
  emptyDataFrame
}

function findLatitudeLogitude(GeographyString){
    library(RSelenium)
    startServer()
    remDr <- remoteDriver(remoteServerAddr = "localhost",
                          port = 4444,
                          browserName = "chrome")
    remDr$open()
    remDr$getStatus()
    result = list()
    remDr$navigate("http://www.latlong.net/")
    Sys.sleep(10)    
    result = list()
    for(i in 1:length(GeographyString)){
        lat = NA
        lng = NA
        Geo = GeographyString[i]
        webElem <- remDr$findElement(using = "id", "gadres")
        webElem$clearElement()
        webElem$sendKeysToElement(list(paste(Geo), key = "enter"))
        Sys.sleep(5)
        webElem2 <- remDr$findElement(using = "id", "lat")
        lat = webElem2$getElementAttribute("value")[[1]]
        webElem2 <- remDr$findElement(using = "id", "lng")
        lng = webElem2$getElementAttribute("value")[[1]]
        result[[i]] = list(lat = lat, lng = lng)    
    }
    df = data.frame(do.call(rbind, result))
    df$lat = unlist(df$lat)
    df$lng = unlist(df$lng)
    df$Geography = TotalSearch$GeographyString
    return(df)
}