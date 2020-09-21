####################################################################
# hreyes September 2020
# plot-venn-4phenotypes.R
#
# Plot a venn diagram where sets are phenotypes and elements
# are genes.
####################################################################
# if the library is not found within installed packages, install it
#
if(!("VennDiagram" %in% installed.packages())) {
  install.packages("VennDiagram")
  message("VennDiagram is installed.")
} else {
  message("VennDiagram is installed.")
}
#
# load the library
library(VennDiagram)
#
####################################################################
# create 4 sets (phenotypes) with genes as elements
#
myPhenotypes = list(
  COFS = c("ERCC1", "ERCC2"),
  CS = c("ERCC6", "ERCC8"),
  XP = c("XPA", "ERCC3", "XPC", "ERCC2", "DDB2", "ERCC4", "ERCC5", "POLH"),
  CXPSC = c("ERCC2", "ERCC3", "ERCC4", "ERCC5")
)
# obtain length of each phenotype to use for name
#
names(myPhenotypes) = paste0(names(myPhenotypes), " (", unlist(lapply(myPhenotypes, length)), ")")

#
####################################################################
# en esta pagina https://coolors.co/generate se pueden generar paletas de 
# colores que combinan bien entre ellos
#
# crear vector con mis colores (un color para cada conjunto)
#
myColors = c("#2F4B26", "#E7BB41", "#FF0054", "#68C3D4")
#
####################################################################
# call the venn diagram function
#
myVenn <- venn.diagram(
  x = myPhenotypes,
  filename = NULL,
  
  # title
  main = "ERCC1-related phenotypes",
  main.fontface = "bold",
  main.fontfamily = "serif",
  main.cex = 2,

  # format of the set circles
  lwd = 0.75,
  #lty = 'blank',
  fill = myColors,
  col = rep("black", 4),
  
  # format of the set numbers
  cex = 1.25,
  fontface = "bold",
  fontfamily = "serif",

  # format set names
  cat.cex = c(rep(1.5, 3), 1.75),
  cat.fontface = c(rep("plain", 3), "bold"),
  cat.fontfamily = rep("serif", 4)
)
####################################################################
# Write to file
png(filename = "fenotipos_4grupos_leo_septiembre2020.png", height = 10, width = 11.5, units = "in", res = 300)

grid.draw(myVenn)

dev.off()

####################################################################
####################################################################
####################################################################










