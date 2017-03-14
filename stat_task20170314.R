install.packages('plyr')
library(plyr)
#help(ddply); help(summarize); baseball[1:5,]

df <- read.csv('data10.csv', stringsAsFactors = F, sep = c(","))
var1 <- c('CountryName',
          'Year',
          'InfMort',
          'under5mort',
          'Trade2GDP',
          'M22GDP',
          'CPI',
          'ln_RealGDPPercap_PPP',
          'percenturban',
          'M22GDPGW',
          'Trade2GDPGW',
          'literacy',
          'literacyGW',
          'ln_hexppcppp_2011',
          'DALY_r_ipol',
          'DHS_NoCov_ipol',
          'DHS_8Cov_ipol',
          'DHS_InfMort',
          'DHS_under5mort',
          'DHS_8Cov',
          'DHS_NoCov',
          'DHS_InfMort_ipol',
          'DHS_under5mort_ipol',
          'DALY_r'
)
df <- df[,var1]

fix_dot <- function(vari){
  vari[vari == '.'] <- NA
  as.numeric(vari)
}

df[, 3:24] <- lapply(df[, 3:24], fix_dot)
#typeof(df);class(df);summary(df)

# Testing on adding statistical summary using variable 'InfMort' before generalizing 

#ix <- !is.na(df['InfMort'])

#InfMort_tab <- ddply(df[ix, 1:3], "CountryName", summarise,
#                     begin = min(Year),
#                     end   = max(Year),
#                     duration = end-begin+1,
#                     check_big = max(InfMort)
#)

#summary_InfMort <- summarise(InfMort_tab,
#                             eariest = min(begin), 
#                             latest = max(end),
#                             tot_obs = sum(duration)
#)

# QA Checking
#InfMort_tab[c(1:5,100,184),]
#summary_InfMort



subset_data <- lapply(var1[3:24], function(x){
  df[!is.na(df[x]), c('CountryName','Year',x)]
}
)

#subset_data[[1]][1:5,];subset_data[[2]][1:5,];subset_data[[22]][1:5,]
#lapply(subset_data, function(x) x[1,])


lapply(subset_data, function(x) x[1,1:3])
All_tab <- lapply(subset_data, ddply, "CountryName", summarise,
                  begin = min(Year),
                  end   = max(Year),
                  duration = length(Year)

)


summary_all <- lapply(All_tab, summarise, eariest = min(begin), 
                                          latest = max(end),
                                          tot_obs = sum(duration)
)


#all(summary_InfMort[] == summary_all[[1]])

summary_all <- do.call(rbind.data.frame, summary_all)
row.names(summary_all) <-  var1[3:24]

write.csv(summary_all, file = "summary_table.csv", row.names = T)

