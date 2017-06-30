##R --vanilla
require(rjson)
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


##documentation at http://www.biodiversitylibrary.org/api2/docs/docs.html
  ##SubjectSearch
for (j in slc) {
  cat(sprintf("Especie %s :;:\n",j))
  aa <- sprintf("%s/BHLlist_%s.json",target,gsub(" ","_",j))
  if (file.exists(aa)) {
    bhl <- fromJSON(file=aa)
    if (length(bhl$Result)>4) {
      if (length(bhl$Result$Titles)>0) {
        for (k in 1:length(bhl$Result$Titles)) {
          if (length(bhl$Result[[5]][[k]]$Items)>0) {
            for (h in  1:length(bhl$Result[[5]][[k]]$Items)) {
              pps <- unlist(lapply(bhl$Result[[5]][[k]]$Items[[h]]$Pages,
                                   function(x) x$PageID))
              for (pid in pps) {
                ee <- sprintf("%s/BHLocr/Page%s.txt",target,pid)
                if (!file.exists(ee))
                  system(  sprintf("wget 'http://www.biodiversitylibrary.org/api2/httpquery.ashx?op=GetPageOcrText&pageid=%s&apikey=%s&format=json' --output-document=%s ",pid,apikey,ee))
            
              }
            }
          }
        }
      }
    }
  } else {
    cat(sprintf("Archivo %s no encontrado\n",aa))
  }
}
system("tar -cjvf ../data/BHLocrPages.tar.bz -C ../data/ BHLocr/") 

