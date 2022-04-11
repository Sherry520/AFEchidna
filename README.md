[![DOI](https://zenodo.org/badge/115507374.svg)](https://zenodo.org/badge/latestdoi/115507374)

update: 11th-04-2022

# AFEchidna
Added functions for Echidna in R

## 1 About AFEchidna

 This package AFEchidna adds some R functions for Echidna v-1.62. AFEchidna builds on the Echidna software. AFEchidna is for non-commercial academic use. Echidna is targeted for use in animal and plant breeding contexts by Arthur Gilmour. The primary software of Echidna could be downloaded from website (https://www.echidnamms.org/). Echidna is free and a powerful tool for mixed models. AFEchidna is developed to run Echidna in R and similar to asreml at some extent.           
  The latest version of Echidna is V-1.62 (https://www.echidnamms.org/downloads/). Updated: 2022-Mar-22th.

## 2 Install AFEchidna package
``` r
remotes::install_github('yzhlinscau/AFEchidna')

AFEchidna::checkPack()  # check depended R packages
``` 

## 3 First user of AFEchidna or Echidna
 If Echidna software is first time for user, user should register an email address as the method supplied in the manual (https://github.com/yzhlinscau/AFEchidna/blob/master/inst/doc/AFEchidna.Man.pdf).

## 4 How to update new version of Echidna for AFEchidna
If AFEchidna does not have new version, while there is a new version of Echidna, user could download the  new version from Echidna website, and then copy the soft path to the fucntion loadsoft() to update Echidna for AFEchidna. A simple case as following:

``` r
soft.path <- r"(D:\softs\Echidna\Echidna157\BIN)"
AFEchidna::loadsoft(update=TRUE,soft.path=soft.path)
```

## 5 AFEchidna function

  - echidna() to run mixed model or batch analysis;
  - pin() to calculate heritability or corr with se;
  - model.comp() to run model comparisons;
  - met.corr() to get cov/var/corr matrix for FA models;
  - met.plot() to plot MET data;
  - met.biplot() to run biplot for MET factor analytic results;
  - plot(), coef(), IC(), update(), predict(), ...

## 6 DEMO functions
``` r
library(AFEchidna)

demo('run.echidna')

```

## 7 AFEchidna workflow
- (1) generate temple .es0 file;
- (2) specify the mixed model;
- (3) run program and check the results.


## 8 More examples

### 8.1 Single trait
``` r
# generate .es0 file
# get.es0.file(dat.file='fm.csv') # .es file
# get.es0.file(es.file='fm.es') # .es0 file
# file.edit('fm.es0') # check and edit .es0 file

res11<-echidna(h3~1+Rep,
               random=~Fam,
               residual=NULL,
               es0.file="fm.es0")

# variance componets
Var(res11)

# only one parameter
pin11(res11,h2~V2*4/(V1+V2))

# model diagnosis
plot(res11)

## get solutions for fixed and random effects
fix.eff<-coef(res11)$fixed
head(fix.eff)

ran.eff<-coef(res11)$random
head(ran.eff)
tail(ran.eff)

## get predictions 
res11p<-update(res11,predict='Fam')
pred<-predict(res11p)

pred$heads
head(pred$pred$pred1)
pred$ased
```

### 8.2 Single trait--batch analysis
``` r
res21<-echidna(trait=~h3+h4+h5,
               fixed=~1+Rep,
               random=~Fam,
               residual=~units,
               batch=TRUE,#run.purrr=TRUE,
               es0.file='fm.es0')

names(res21)

res21b<-b2s(res21)
lapply(res21b,Var)

# second method--based on res11
res11.bth <- update(res11,
                    trait=~h1+h2+h3,
                    batch=TRUE)

Var(res11.bth)

pin(res11.bth,mulp=c(h2~V2*4/(V2+V1),
                 Vp~V2+V1),signif=TRUE)

```

### 8.3 two trait
``` r
res12<-echidna(cbind(h3,h4)~Trait+Trait:Rep,
               random=~us(Trait):Fam,
               residual=~units.us(Trait),
               predict='Fam',mulT=TRUE,
               qualifier = '!filter Spacing !select 1',
               es0.file="fm.es0")
# variance componets
Var(res12)

# model diagnosis
plot(res12,mulT=T)

# for more than 2 parameters  
pin(res12,mulp=c(gcor~V3/sqrt(V2*V4),
                     ecor~V6/sqrt(V5*V7),
                     h2A~V2*4/(V2+V5),
                     VpA~V2+V5),signif=TRUE)

```

### 8.4 two trait--batch analysis
``` r
res22<-echidna(trait=~h2+h3+h4+h5,fixed=~Trait+Trait:Rep,
                   random=~us(Trait):Fam,
                   residual=~units:us(Trait),
                   predict='Fam',
                   batch=TRUE,mulT=TRUE,
                   #run.purrr=TRUE,
                   es0.file='fm.es0')

names(res22)

res22b<-b2s(res22)
lapply(res22b,Var)

```

### 8.5 multi-G structure analysis
``` r
res23<-echidna(es0.file="fm.es0",
             fixed=h5~1+Rep,
             random=c(G1~Fam,G2~Fam+Plot),
             residual=~units,
             batch.G=TRUE,#run.purrr=TRUE,
             trace=TRUE)


res23b<-b2s(res23)
lapply(res23b, Var)

```

### 8.6 multi-R structure analysis
``` r
res24<-echidna(es0.file="MET.es0", 
             fixed=yield~1+Loc,
             random=~Genotype:Loc,
             residual=c(R1~sat(Loc):ar1(Col):ar1(Row),
                        R2~sat(Loc):units), 
             batch.R=TRUE, #run.purrr=TRUE,
             met=TRUE)

res24b<-b2s(res24)
lapply(res24b, Var)

```

### 8.7 spatial analysis
``` r
m2a<-echidna(yield~1,
             random=~Variety+units,
            residual=~ar1(Row):ar1(Column),
            predict=c('Variety'),
            es0.file="barley.es0")

Var(m2a)
plot(m2a)

m2b<-update(m2a,random=~Variety) 

model.comp(m2a,m2b,LRT=TRUE)

```


### 8.8 binomial trait
``` r
# parent model
bp.esr<-echidna(lt ~ 1, random =~ Mum, 
                family = esr_binomial(), 
                es0.file = 'dfm2.es0' )

Var(bp.esr)
pin(bp.esr)
pin11(bp.esr,h2~4*V2/(V1+V2)) 
plot(bp.esr)

bp2.esr<-echidna(cbind(lt,dis) ~ Trait, 
                 random =~ us(Trait):Mum,
                 residual=~ units:us(Trait),
                family = c(esr_binomial(),esr_binomial()), 
                mulT=TRUE,
                es0.file = 'dfm2.es0' )

Var(bp2.esr)

bp3.esr<-echidna(cbind(h5,lt) ~ Trait, 
                 random =~ us(Trait):Mum,
                 residual=~ units:us(Trait),
                 family = c(esr_gaussian(),esr_binomial()), 
                 mulT=TRUE,
                 es0.file = 'dfm2.es0' )

Var(bp3.esr)

# tree model
bt.esr<-echidna(lt~1, random =~ nrm(TreeID), 
                 family = esr_binomial(),
                 es0.file = 'dfm2.es0' )

Var(bt.esr)
pin11(bt.esr,h2~V2/(V1+V2)) 


bt2.esr<-echidna(cbind(lt,dis) ~ Trait, 
                 random =~ us(Trait):nrm(TreeID),
                 residual=~ units:us(Trait),
                 family = c(esr_binomial(),esr_binomial()), 
                 mulT=TRUE,
                 es0.file = 'dfm2.es0' )

Var(bt2.esr)

bt3.esr<-echidna(cbind(h5,lt) ~ Trait, 
                 random =~ us(Trait):nrm(TreeID),
                 residual=~ units:us(Trait),
                 family = c(esr_gaussian(),esr_binomial()), 
                 mulT=TRUE,
                 es0.file = 'dfm2.es0' )

Var(bt3.esr)

```

### 8.9 gblup
``` r
G.marker<-read.csv(file="G.marker.csv",header=TRUE)
GOF<-GenomicRel( G.marker,1, Gres=TRUE)
write.csv(GOF,file='GOF.grm',row.names=F,quote=F)


get.es0.file(dat.file='G.data.csv')
get.es0.file(es.file='G.data.es')

ablup<-echidna(t1~1+Site,random=~nrm(ID),
            residual=~units,
            predict=c('ID'),
            es0.file="G.data.es0")

Var(ablup)

gblup<-update(ablup,random=~grm(ID))

Var(gblup)

## batch--Gblup
# Gblup.mG<-update(ablup, random=c(G1~grm1(ID),
#                                  G2~grm2(ID),
#                                  G3~grm3(ID),
#                                  G4~grm4(ID),
#                                  G5~grm5(ID)),
#                  batch.G=TRUE)
# 
# Gblup.mG2<-b2s(Gblup.mG)
# lapply(Gblup.mG2, Var)

```

### 8.10 selfing model

``` r
# A traditional model
sfm<-echidna(height~1+Prov,
             random=~ nrm(Treeid)+Block,
             es0.file='pine_provenance.es0')
Var(sfm)

# A self=0.1 model
sfm.s1<-update(sfm,selfing=0.1)
Var(sfm.s1)

``` 

### 8.11 Complex model

``` r
pm2<-echidna(weanwt~year+sex+weanage,
             random=~str(~nrm(pig)+nrm(dam),~us(2):nrm(pig)),
             es0.file='pig_data.es0')

Var(pm2)

pm3<-echidna(fixed = cbind(weanwt,weight)~Trait:(year+sex+weanage+pen),            
             random=~str(~Trait:nrm(pig)+Trait:dam,~us(4):nrm(pig)),
             residual=~idv(units):us(Trait),
             mulT = TRUE,
             es0.file='pig_data.es0')

```

More examples will be updated in the future....

## 9 Citation
Gilmour, A.R. (2021) Echidna Mixed Model Software www.EchidnaMMS.org                     
Zhang WH, Wei RY, Liu Y, Lin YZ.(2021) AFEchidna is a R package for genetic evaluation of plant and animal breeding datasets. BioRxiv. DOI:10.1101/2021.06.24.449740.
