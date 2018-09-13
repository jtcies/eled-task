library(here)
library(rmarkdown)

source(here("1_download_data.R"))

source(here("2_tidy.r"))

render(here("ciesielski_joseph_el_task.Rmd"))
