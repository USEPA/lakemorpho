#Function to create a lakeMorpho class - this is input to all other methods
#May need to be done as a method (i.e. no need to @export)
#TO DO:
#Add null place holders for all possible lakeMorpho metrics (eg various lines)
lakeMorpho<-function(inLake,inElev,inCatch,inLakeDist,lakeOnEdge=F)
{
  lmorpho<-list(lake=inLake,
                elev=inElev,
                surround=inCatch,
                lakeDistance=inLakeDist,
                lakeOnEdge=lakeOnEdge)
  class(lmorpho)<-"lakeMorpho"
  return(lmorpho)
}