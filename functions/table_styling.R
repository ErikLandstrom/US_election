### table_styling.R
### Author: Erik Ländström
### Date: 200130

# Style options for printing kable tables.

# Required packages: knitr, kableExtra

# df = tibble to be printed
# scroll_box = boolean, whether table should be scrollable vertically
#              default is FALSE


table_styling <- function(df, scroll_box = FALSE){
  
  library(knitr)
  library(kableExtra)
  
  if (scroll_box == TRUE) {
    df %>% 
      kable() %>% 
      kable_styling(
        bootstrap_options = c("striped", "hoover"),
        fixed_thead = TRUE
      )
  } else{
    df %>% 
      kable() %>% 
      kable_styling(
        bootstrap_options = c("striped", "hoover"),
        fixed_thead = TRUE
      ) %>% 
      scroll_box(width = "100%", height = "100%")
  }
}