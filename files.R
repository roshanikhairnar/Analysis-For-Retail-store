SaleItemsFiltered <-read.table("C:\\Users\\Aarshiya\\Desktop\\BEProject\\value.csv",header=T, sep=",")
SaleItems <-read.table("C:\\Users\\Aarshiya\\Desktop\\BEProject\\value_with.csv",header=T, sep=",")
CustomerTotal <- read.table("C:\\Users\\Aarshiya\\Desktop\\BEProject\\customer_Total.csv",header=T, sep=",")
TotalCollectionsPerDay <- read.csv("C:\\Users\\Aarshiya\\Desktop\\BEProject\\Total_Collection_Per_Day.csv")
AllItemsFreq <- read.table("C:\\Users\\Aarshiya\\Desktop\\BEProject\\ItemFreq.csv",header=T, sep=",")
ProductSales <- read.csv("C:\\Users\\Aarshiya\\Desktop\\BEProject\\Product_Sales_Data.csv")
SaleSummary <-read.table("C:\\Users\\Aarshiya\\Desktop\\BEProject\\SaleSummary.csv",header=T, sep=",")
datacombo<-read.csv("C:\\Users\\Aarshiya\\Desktop\\BEProject\\data.csv")
data <- read.csv("C:\\Users\\Aarshiya\\Desktop\\BEProject\\TransformedHeatmapData.csv")

transactions<-read.transactions("C:\\Users\\Aarshiya\\Desktop\\BEProject\\value.csv", 
                                format='single',
                                cols=c("SaleID","Name"),
                                sep=",")
allitemstransactions<-read.transactions("C:\\Users\\Aarshiya\\Desktop\\BEProject\\value_with.csv", 
                                        format='single',
                                        cols=c("SaleID","Name"),
                                        sep=",")
