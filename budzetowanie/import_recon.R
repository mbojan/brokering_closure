library(googlesheets)
library(dplyr)

gs_ls() %>%
  filter(sheet_title == "Budżet") %>%
  select(updated, sheet_key) %>%
  arrange(updated)

s <- gs_key("1zUMbl2cMIJDdGuAuAEwoNFHZoDz7uwKXJWWOR1ugUGg")

recon <- gs_read(s, "Operacje") %>%
  rename(plan=`plan czy wydatek`)

budzet <- recon %>%
  filter( plan == "budżet") %>%
  group_by(rok, zadanie, osoba) %>%
  summarise(kwota = sum(kwota)) %>%
  ungroup() %>%
  filter( kwota != 0)

wydatki <- recon %>%
  filter( plan == "wydatek", rok <= 2015)


save(recon, budzet, wydatki, file="recon.rda")
