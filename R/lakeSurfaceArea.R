#function to return lake area of an inLakeMorpho Class
#TO DO:
#Add test for null lake
lakeSurfaceArea<-function(inLakeMorpho)
{
  return(gArea(inLakeMorpho$lake))
}