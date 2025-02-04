% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/basF.R
\name{spd.plot}
\alias{spd.plot}
\title{Plot spatial data or Variogram.}
\usage{
spd.plot(object,type="data",p.lbls=NULL,key.unit=NULL,
                x.unit=NULL,y.unit=NULL,na=NULL,
                color.p=NULL,mtitle=NULL)
}
\arguments{
\item{object}{Aim dataset.}

\item{type}{Type of dataset, default value is "data", when "Variogram" for Variogram.plot in spatial analysis in ASReml-R.}

\item{p.lbls}{Extra labels in figure title.}

\item{key.unit}{The unit of key, default value is 1.}

\item{x.unit}{Axis x least unit, default value is 1.}

\item{y.unit}{Axis y least unit, default value is 1.}

\item{na}{Transform NA to 0(na=0) or keep NA (default).}

\item{color.p}{Parameters of the colors for figures, default value is terrain.colors, it could be rainbow, heat.colors, cm.colors and topo.colors.}
}
\description{
\code{spd.plot} This function plots spatial data or Variogram.
}
\examples{
\dontrun{
library(AFEchidna)

######## example 1 plot regular spatial data
data(barley)

aim.trait<-subset(barley,select=c(Row,Column,yield))
spd.plot(aim.trait)
spd.plot(aim.trait,color.p=topo.colors)
spd.plot(aim.trait,key.unit="Kg")
spd.plot(aim.trait,p.lbls="barley",x.unit=2,y.unit=1)


#AR1XAR1--asreml V3.0
barley1.asr<-asreml(yield~Variety, rcov =~ ar1(Row):ar1(Column), data=barley)

summary(barley1.asr)$Varcomp
plot(Variogram(barley1.asr),main="M1")

aa=Variogram(barley1.asr)
spd.plot(aa,type="Variogram",color.p=topo.colors)

######## example 2 plot spatial data with NA's
data(ir.sp)

ir.sp2<-ir.sp[,5:16] # order: Row,Col,h05,cw05,...
#ir.sp2<-subset(ir.sp,select=c(Row,Col,h05,cw05))

sp1<-ir2r.sp(ir.sp2,row.max=10,col.max=20)

aim.trait=subset(sp1,select=c(Row,Col,d10))
spd.plot(aim.trait,key.unit="cm")
spd.plot(aim.trait,color.p=topo.colors,na=0)
spd.plot(aim.trait,na=0,x.unit=3)
}


}
\references{
Yuanzhen Lin. R & ASReml-R Statistics. China Forestry Publishing House. 2016
AFfR website:https://github.com/yzhlinscau/AFfR
}
\author{
Yuanzhen Lin <yzhlinscau@163.com>
}
