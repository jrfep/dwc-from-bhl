##R --vanilla

##BHL api
source("../apikeys.R") ## with a variable called "apikey"
##documentation at http://www.biodiversitylibrary.org/api2/docs/docs.html
  ##SubjectSearch
target <- "../data"
## example with Agraulis vanillae
slc <- "Agraulis vanillae"
for (j in slc) {
  aa <- sprintf("%s/BHLlist_%s.json",target,gsub(" ","_",j))
  if (!file.exists(aa)) {
    system(  sprintf("wget 'http://www.biodiversitylibrary.org/api2/httpquery.ashx?op=NameGetDetail&name=%s&apikey=%s&format=json' --output-document=%s ",gsub(" ","+",j),apikey,aa))
  } else {
    if (file.info(aa)$size==0) {
system(  sprintf("wget 'http://www.biodiversitylibrary.org/api2/httpquery.ashx?op=NameGetDetail&name=%s&apikey=%s&format=json' --output-document=%s ",gsub(" ","+",j),apikey,aa))
    }
  }
}
