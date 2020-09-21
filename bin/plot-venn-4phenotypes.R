#########################################################################
#
# hreyes September 2020
# plot-venn-4phenotypes.R
#
# Plot a venn diagram where sets are phenotypes and elements
# are genes.
# This script plots a Venn diagram with 4 phenotypes.
#
#########################################################################
################## DATOS PARA QUE LEO RELLENE ###########################
# GENES EN CADA FENOTIPO
fenotiposVenn = list(
  COFS = c("ERCC1", "ERCC2"),
  CS = c("ERCC6", "ERCC8"),
  XP = c("XPA", "ERCC3", "XPC", "ERCC2", "DDB2", "ERCC4", "ERCC5", "POLH"),
  CXPSC = c("ERCC2", "ERCC3", "ERCC4", "ERCC5")
)
#
# TITULO PARA LA GRAFICA
tituloVenn = "ERCC1-related phenotypes"
#
# COLORES PARA LA GRAFICA
coloresVenn = c("#2F4B26", "#E7BB41", "#FF0054", "#68C3D4")
#
# en esta pagina https://coolors.co/generate se pueden generar paletas de 
# colores que combinan bien entre ellos
#
# NOMBRE DEL ARCHIVO
nombreArchivo = "ERCC1-venn-septiembre2020"
#
#########################################################################
#########################################################################
# if the libraries are not found within installed packages, install them
if(!("VennDiagram" %in% installed.packages())) {
  install.packages("VennDiagram")
  message("VennDiagram is installed.")
} else {
  message("VennDiagram is installed.")
}
if(!("magrittr" %in% installed.packages())) {
  install.packages("magrittr")
  message("magrittr is installed.")
} else {
  message("magrittr is installed.")
}
# load the libraries
library(VennDiagram)
library(magrittr)
#
#########################################################################
# declare plotting function
plot_myVenn <- function(pheno.list, venn.title, pheno.colors) {
  
  venn.diagram(x = pheno.list, filename = NULL,
  
  # title
  main = venn.title,
  main.fontface = "bold",
  main.fontfamily = "serif",
  main.cex = 2,
  
  # format of the set circles
  lwd = 0.75,
  #lty = 'blank',
  fill = pheno.colors,
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
}
#
#########################################################################
# obtain length of each phenotype to use for name
#
fenotiposVenn %>% lapply(length) %>%
  unlist %>%
  paste0(names(fenotiposVenn), " (", ., ")") -> names(fenotiposVenn)
#
#########################################################################
# call the venn diagram function
#
myVenn <- plot_myVenn(pheno.list = fenotiposVenn, 
                      venn.title = tituloVenn,
                      pheno.colors = coloresVenn)

# Write to file
png(filename = paste0(nombreArchivo, "-numeros.png"), 
    height = 10, width = 11.5, units = "in", res = 300)

grid.draw(myVenn)

dev.off()
#
#########################################################################
############### create a venn diagram that displays labels ##############
#########################################################################
# copy the venn object
myVenn.withLabels <- myVenn

# calculate overlaps between phenotypes
fenotiposVenn %>% calculate.overlap() %>%
  rev -> overlaps

overlaps %>% names() %>%
  gsub(pattern = "a", replacement = "") %>%
  as.numeric() -> posOverlap

# edit the venn to show gene labels
for (i in 1:length(overlaps)){
  pos = posOverlap[i]
  myVenn.withLabels[[pos+8]]$label <- paste(overlaps[[i]], collapse = "\n")
}

# Write to file
png(filename = paste0(nombreArchivo, "-nombres.png"), 
    height = 10, width = 11.5, units = "in", res = 300)

grid.draw(myVenn.withLabels)

dev.off()
