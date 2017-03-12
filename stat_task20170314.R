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
typeof(df);class(df);summary(df)
