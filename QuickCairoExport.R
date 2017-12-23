## Custom function to export anti-aliased graphics
QuickCairoExport <- function(plotVar, filename, type = "png") {
  require(rstudioapi)
  filepath <- dirname(getSourceEditorContext()$path)
  setwd(filepath)
  
  dev.off()
  
  Cairo(width = 1240, 
        heigth = 1750, 
        file = paste(filename, ".png", sep = ""), 
        type = "png", 
        bg = "white")
  
  plotVar
  
  dev.off()
}
