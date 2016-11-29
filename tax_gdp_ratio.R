library(WDI)
require(countrycode)
inds <- c("GC.TAX.TOTL.GD.ZS","GC.XPN.TOTL.GD.ZS")
indNames <- c("Tax.GDP.Ratio","Expense.GDP.Ratio")
this.year <- format(Sys.Date(), "%Y")

wdiData <- WDI(country=c("BD","IN","PK","LK"), 
               indicator=inds,start=this.year, 
               end=this.year, 
               extra=FALSE)
save(wdiData,file="wdiData.RData")
colnum <- match(inds,names(wdiData))
names(wdiData)[colnum] <- indNames
wdiData.sm <- wdiData[ wdiData$year>2004 & wdiData$year <2011,]
qplot( year,Tax.GDP.Ratio, data = wdiData.sm, colour = country,size=Tax.GDP.Ratio)
qplot( year,Tax.GDP.Ratio, data = wdiData.BD, colour = country,size=I(10))
qplot( year,Tax.GDP.Ratio, data = wdiData.sm, colour = country,geom="line",size=I(3))

# Now If I want to used stack bar then following code may help
ggplot(wdiData.sm,aes(x=year,y=Tax.GDP.Ratio,fill=country))+geom_bar(stat='identity')

ggplot(wdiData.sm,aes(x=year,y=Tax.GDP.Ratio,fill=country))+geom_bar(stat='identity',position="dodge")+scale_fill_brewer(palette="Greys")
ggplot(wdiData.sm,aes(x=year,y=Tax.GDP.Ratio,fill=country))+geom_bar(stat='identity',position="dodge") + scale_fill_manual(values=c("#005A1C","#83B2DC","#C3E04A","#2267C4")) #according to flag color,adding coord_flip() does not work well

# expense budget ratio
ggplot(wdiData.sm,aes(x=year,y=Expense.GDP.Ratio,fill=country))+geom_bar(stat='identity',position="dodge") + scale_fill_manual(values=c("#005A1C","#83B2DC","#C3E04A","#2267C4"))

# following will have individual country
ggplot(wdiData.sm,aes(x=year,y=Tax.GDP.Ratio,fill=country))+geom_bar(stat='identity')+facet_wrap(~ country)

# Now I want to use just one year data

# I can use the rainbow palette
vivcol <- rainbow(10)
ggplot(wdiData[wdiData$year==2011,],aes(y=Expense.GDP.Ratio,x=country,fill=country))+geom_bar(stat='identity',position="dodge") + scale_fill_manual(values=vivcol)

# Or I can use a colorbrewer palette
ggplot(wdiData[wdiData$year==2011,],aes(y=Expense.GDP.Ratio,x=country,fill=country))+geom_bar(stat='identity',position="dodge") + scale_fill_brewer(palette="BrBG")+theme(legend.position="none")