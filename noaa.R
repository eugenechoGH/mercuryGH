library(rnoaa)
library(data.table)
library(lubridate)
library(devtools)
library(stringr)
# token: WMfLumOaZKcCSkuyMiPzdssqTTSnnkaR

ncdc(datasetid = "PRECIP_HLY", locationid = "ZIP:28801", datatypeid = "HPCP",
     limit = 5, token = "WMfLumOaZKcCSkuyMiPzdssqTTSnnkaR")
ncdc_stations(token="WMfLumOaZKcCSkuyMiPzdssqTTSnnkaR")$data
str.station<-'Mercury Challenge/code and data/Data/ghcnd-stations.txt'
vec.station<-unlist(str_split(readChar(str.station,nchars=file.info(str.station)$size),pattern = '\r\n'))

dt.station<-data.table()
dt.station<-
  data.table(ID=trimws(substr(vec.station,start=1,stop = 11)),
             Latitude=as.numeric(substr(vec.station,start=13,stop = 20)),
             Longitude=as.numeric(substr(vec.station,start=22,stop = 30)),
             ELEVATION=as.numeric(substr(vec.station,start=32,stop = 37)),
             STATE=trimws(substr(vec.station,start=39,stop = 40)),
             NAME=trimws(substr(vec.station,start=42,stop = 71)),
             `GSN FLAG`=trimws(substr(vec.station,start=73,stop = 75)),
             `HCN/CRN FLAG`=trimws(substr(vec.station,start=77,stop = 79)),
             `WMO ID`=trimws(substr(vec.station,start=81,stop = 85)))
fwrite(dt.station,'Mercury Challenge/code and data/Data/ghcnd-stations.csv')

# EGYPT stations
vec.egy_stations<-dt.station[substr(ID,start = 1,stop = 2)=='EG']$ID
ghcnd(stationid = vec.egy_stations[1])
