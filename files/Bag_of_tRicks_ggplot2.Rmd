---
title: 'Bag of tRicks: gglpot2'
author: "Susi Zajitschek"
date: "2025-04-05"
output: html_document
editor_options: 
  chunk_output_type: console
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## R basic plots


```{r}
data(iris)
str(iris)
```


## Histogram (one continuous variable)
```{r}
 	hist(iris$Sepal.Length)
```

## Two continuous (scatterplot)
plot(y ~ x, data = df)

```{r}
plot(Petal.Length ~ Sepal.Length, data = iris)

```


## Modifications

plot(y ~ x, data = df, xlab = “X axis name (unit)", ylab = “Y axis name(unit)", main = “Figure title“, ylim = c(0, 80))

```{r}
plot(Petal.Length ~ Sepal.Length, data = iris, xlab = "Sepal Length (cm)", ylab = "Petal Length (cm)", main = "Iris Flower measurements", ylim = c(0, 10))

```

## GGPLOT 2

```{r}
library(ggplot2)
```

```{r}

ggplot(iris, aes(Sepal.Length, Petal.Length)) +
  geom_point() +
  labs(y = "Petal length (cm)", x = "Sepal length (cm)")
```
So That's basically the same as the base R plot

## Reminder: Titles and Axes Labels

### Adding a title
Add the code `+ggtitle("Your Title Here")` Don't forget quotation marks at the start and end! 

### Changing axis labels
To alter the labels on the axis, add the code `+labs(y= "y axis name", x = "x axis name")` to your line of basic ggplot code.


```{r echo=TRUE}
ggplot(iris, aes(Sepal.Length, Petal.Length)) +
  geom_point() +
  labs(y = "Petal length (cm)", x = "Sepal length (cm)") +
   ggtitle("Petal and sepal length of iris")
```


Let's modify, add colours by factor: 
```{r}
ggplot(iris, aes(Sepal.Length, Petal.Length, colour = Species)) +
  geom_point() +
  labs(y = "Petal length (cm)", x = "Sepal length (cm)")
```
 
### Themes
 
 Modify how your plot looks
```{r}
ggplot(iris, aes(Sepal.Length, Petal.Length, colour = Species)) +
  geom_point() +
  theme_bw() +
  labs(y = "Petal length (cm)", x = "Sepal length (cm)")
```
 
 Play around, for example with

  
  theme_light, theme_dark, theme_minimal, theme_classic
```{r}
ggplot(iris, aes(Sepal.Length, Petal.Length, colour = Species)) +
  geom_point() +
  theme_classic() +
  labs(y = "Petal length (cm)", x = "Sepal length (cm)")
```
  
  
ggplot2 is very customisable, you can remove parts from themes, or write your own theme (not fully covered here)
```{r}
ggplot(iris, aes(Sepal.Length, Petal.Length, colour = Species)) +
  geom_point() +
  theme(axis.ticks = element_blank()) +
  labs(y = "Petal length (cm)", x = "Sepal length (cm)")

ggplot(iris, aes(Sepal.Length, Petal.Length, colour = Species)) +
  geom_point() +
  theme(panel.background = element_blank()) +
  labs(y = "Petal length (cm)", x = "Sepal length (cm)")
```

or change the font (size etc), location of you legend:
```{r}
ggplot(iris, aes(Sepal.Length, Petal.Length, colour = Species)) +
  geom_point() +
  theme(panel.background = element_blank()) +
  theme(legend.position = "bottom", legend.text = element_text(size = 14),
  legend.title = element_text(size = 18, face = "bold" ), axis.title= element_text(size = 20))+
    labs(y = "Petal length (cm)", x = "Sepal length (cm)") 
  
```

Instead of COLOUR, change the shape (and/or size of your "points")
```{r}
ggplot(iris, aes(Sepal.Length, Petal.Length, shape = Species)) +
  geom_point(size = 2.5, alpha = 0.6) +
  theme(panel.background = element_blank()) +
  theme(legend.position = "bottom", legend.text = element_text(size = 14),
  legend.title = element_text(size = 18, face = "bold" ), axis.title= element_text(size = 20))+
    labs(y = "Petal length (cm)", x = "Sepal length (cm)") 
  
```

Or customise your colours:

```{r}
ggplot(iris, aes(Petal.Length, Sepal.Length)) +
  geom_point(color="red") 

```

  
If gradients are useful -e.g. a third variable is added into the picture (don't forget to specify which variable defines the gradient!)

```{r}
ggplot(iris, aes(Petal.Length, Sepal.Length, colour = Sepal.Width)) +
  geom_point() + scale_colour_gradient(low = "black", high = "white")+
  theme_classic()


ggplot(iris, aes(Petal.Length, Sepal.Length, colour = Sepal.Width)) +
  geom_point() + scale_colour_gradient(low = "pink", high = "blue")

```

### Additional useful functions

adding trendlines:

```{r}
irispoint <- ggplot(data = iris, aes(x = Petal.Width, y = Petal.Length)) +
geom_point(aes(colour = Species), size = 5, alpha = 0.3) +
geom_line(stat="smooth", method = "lm", alpha = 0.3) +
geom_line(aes(group = Species, colour = Species), stat="smooth", method =
"lm", lwd = 0.5) +
theme_bw()

irispoint
```

#### Splitting by factors: 
facet_wrap()  

```{r}
ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width, colour = Species)) +
geom_point( size = 5, alpha = 0.3) +
geom_line(stat="smooth", method = "lm", alpha = 2) +
  facet_wrap("Species")+
theme_bw()

```

BOXPLOTS
```{r}
ggplot(iris, aes(x = Species, y = Petal.Length)) +
    geom_boxplot() +
    theme_bw()

```


Visualising the spread of your data: VIOLINPLOTS
particularly useful together with JITTER (rather than geom_point)
```{r}
ggplot(data = iris, aes(x = Species, y = Petal.Length)) +
geom_violin(trim = F) + 
geom_jitter(col = "purple", size = 2, alpha = 0.2) +
stat_summary(fun.data = "mean_se", col = "green") +
theme_bw()
```

If you want to add info on your median: add a boxplot
```{r}
ggplot(data = iris, aes(x = Species, y = Petal.Length)) +
geom_violin(trim = F) + 
  
  geom_boxplot() +
  
geom_jitter(col = "purple", size = 2, alpha = 0.2) +
stat_summary(fun.data = "mean_se", col = "green") +
theme_bw() 
```


#### Assign colours from a pre-made pallette
using `+ scale_colour_brewer()` or `+ scale_fill_brewer`. Install the package [RColorBrewer](https://cran.r-project.org/web/packages/RColorBrewer/index.html) and load in R.

here's what there is:
https://r-graph-gallery.com/38-rcolorbrewers-palettes.html

```{r, echo= TRUE, warning=F}
library(RColorBrewer)
```


I saved one of the scatterplots above as "irispoint", so instead of re-running the full block of code I can now modify the existing object:

```{r}
print(irispoint + scale_colour_brewer(palette = "Dark2"))

print(irispoint + scale_colour_brewer(palette = "RdPu"))

```
  



Help on all the ggplot functions can be found at the [The master ggplot help site](https://ggplot2.tidyverse.org).

