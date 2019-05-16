rules_t <- apriori(transactions, 
                   parameter = list(support = 0.0001, confidence = 0.01, minlen=2, maxlen=5, ext=TRUE ), 
                   control = list(verbose=TRUE))

rules_table<-data.table(lhs=labels(lhs(rules_t)), rhs=(labels(rhs(rules_t))), quality(rules_t))

#itemFreq<-sqldf("select Name,count(Name) as count from SaleItems group by Name")
#itemFreq_table <- data.table(itemFreq)
AllItemsFreq$FrequencyPercentage <- AllItemsFreq$FrequencyPercentage*100

ProductRevenue <- sqldf("Select ItemID, Sum(Amount) as Revenue from SaleSummary group by ItemID ")
Total <- sum(ProductRevenue$Revenue)
ProductRevenue$Space_Percent <- ProductRevenue$Revenue/Total
ProductRevenue$Space_Percent <- ProductRevenue$Space_Percent * 100
ProductRevenue <- sqldf("Select ProductRevenue.ItemID, AllItemsFreq.Name, 
                        ProductRevenue.Revenue, ProductRevenue.Space_Percent From AllItemsFreq
                        inner join ProductRevenue on AllItemsFreq.ID = ProductRevenue.ItemID")
ProductRevenue <- data.table(ProductRevenue)

SaleSummdf <- sqldf("select strftime('%Y-%m-%d', SaleDate ) as SaleDate, Amount FROM SaleSummary ")
SaleSummdf <- sqldf("Select SaleDate, Sum(Amount) AS Amount FROM SaleSummdf GROUP BY SaleDate ")

c1=head(CustomerTotal,10)
I=head(AllItemsFreq ,120)
set.seed(600)
sample1=c(sample(1:nrow(I),10))
sample2=c(c1$CustomerID)
CustomerOffer <- data.frame(sample2,sample1)
sample1 <- "Item_no"
sample2 <- "Customer_id"
names(CustomerOffer)<-c("Customer_id","Item_no")
CustomerOffer=sqldf('Select CustomerOffer.Customer_id, AllItemsFreq.Name from CustomerOffer inner join AllItemsFreq on AllItemsFreq.No==CustomerOffer.Item_no')

set.seed(25)
myts <- ts(SaleSummdf, start = c(2016, 92), end = c(2017, 277), frequency = 365)
inds <- seq(as.Date("2016-04-01"), as.Date("2017-10-04"), by = "day")

###DATA TRANSFORMATIONS:

#k<- read.csv("C:\\Users\\Aarshiya\\Desktop\\BEProject\\HeatMapData.csv")
#b<- dcast(k, SaleDate ~ Name, value.var="Quantity",fun.aggregate = sum)
#write.csv(b,file="C:\\Users\\Aarshiya\\Desktop\\BEProject\\TransformedHeatmapData.csv")

#write.csv(datapre,file="C:\\Users\\Aarshiya\\Desktop\\BEProject\\data.csv")
datacombo<-read.csv("C:\\Users\\Aarshiya\\Desktop\\BEProject\\data.csv")
newdata <- datacombo[order(datacombo$count),]

newdata1 <- datacombo[order(datacombo$count,decreasing = TRUE),]
least10<-newdata[1:10,]
top10<-newdata1[1:10,]
top10$count<-NULL
least10$count<-NULL

Combo<-crossing(top10, least10)
write.csv(Combo,file="C:\\Users\\Aarshiya\\Desktop\\BEProject\\combo.csv")
temp<-read.csv("C:\\Users\\Aarshiya\\Desktop\\BEProject\\combo.csv")

names(temp)<-c("No","X","Name","X1","Name1")
sample1=c(sample(1:nrow(temp),10))

df<-data.frame(sample1)
names(df)<-c("Number")

df=sqldf('select temp.Name as HighestSelling,temp.Name1 as LeastSelling from temp inner join df on temp.No=df.Number')

#write.csv(df,file="C:\\Users\\Aarshiya\\Desktop\\BEProject\\combo_display.csv")
comboOffers<-read.table("C:\\Users\\Aarshiya\\Desktop\\BEProject\\combo_display.csv",header = T,sep=",")
comboOffer_table <-data.table(comboOffers)

