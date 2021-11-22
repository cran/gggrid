## -----------------------------------------------------------------------------
library(grid)
label <- textGrob("Label", 
                  x=unit(1, "npc") - unit(5, "mm"),
                  y=unit(1, "npc") - unit(5, "mm"),
                  just=c("right", "top"))

## ----fig.width=5, fig.height=3------------------------------------------------
library(gggrid)
ggplot(mtcars) + 
    geom_point(aes(disp, mpg)) +
    grid_panel(label)

## ----fig.width=5, fig.height=3------------------------------------------------
rug <- function(data, coords) {
    segmentsGrob(unit(1, "npc"),
                 coords$y,
                 unit(1, "npc") - unit(2, "mm"),
                 coords$y,
                 gp=gpar(lwd=2, col=rgb(0,0,0,.5)))
}
ggplot(mtcars, aes(x=disp, y=mpg)) +
    geom_point() +
    grid_panel(rug)

## ----fig.width=5, fig.height=3------------------------------------------------
ggplot(mtcars, aes(x=disp, y=mpg)) +
    geom_point() +
    grid_panel(rug) +
    facet_wrap("am")

## ----fig.width=5, fig.height=3------------------------------------------------
rugGroup <- function(data, coords) {
    segmentsGrob(unit(1, "npc"),
                 coords$y,
                 unit(1, "npc") - unit(2, "mm"),
                 coords$y,
                 gp=gpar(lwd=2, col=adjustcolor(data$colour, alpha=.5)))
}
ggplot(mtcars, aes(x=disp, y=mpg, colour=as.factor(am))) +
    geom_point() +
    grid_group(rugGroup)

## ----fig.width=5, fig.height=2------------------------------------------------
minard <- read.table("minard-troops.txt", header=TRUE)
library(vwline)
path <- function(data, coords) {
    vwlineGrob(coords$x, coords$y, w=unit(coords$size, "in"),
               gp=gpar(col=coords$colour[1],
                       fill=adjustcolor(coords$colour[1], alpha=.5)))
}
ggplot(minard, 
       aes(x=long, y=lat, size=survivors, colour=direction, 
           group=interaction(group, direction))) + 
    scale_size(range=c(.01, .5)) +
    coord_fixed(2, clip="off") +
    grid_group(path)

