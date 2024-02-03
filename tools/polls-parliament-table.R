library(tidyverse)
parliaments_ordered <- c(
  "Bundestag", "Europäisches Parlament",
  setdiff(unique(dawum_df$Parliament_Shortcut)[order(unique(dawum_df$Parliament_Shortcut))],
          c("Bundestag", "Europäisches Parlament")))
parliaments_ordered_stub <- c("Bundestag", "EU", "BW", "BY", "BE", "BB", "HB", "HH", "HE", "MV", "NI",
  "NRW", "RP", "SL", "SN", "ST", "SH", "TH")
dawum_df %>%
  distinct(Institute_Name, Parliament_Shortcut, ID) %>%
  mutate(Institute_Name_grp = fct_lump_lowfreq(Institute_Name),
         Parliament_Shortcut = factor(
           Parliament_Shortcut, levels = parliaments_ordered, labels = parliaments_ordered_stub)) %>%
  count(Institute_Name_grp, Parliament_Shortcut) %>%
  arrange(Institute_Name_grp, Parliament_Shortcut) %>%
  pivot_wider(id_cols = Institute_Name_grp, names_from = "Parliament_Shortcut",
              values_from = "n", values_fill = 0) %>%
  select(Institute_Name_grp, all_of(parliaments_ordered_stub)) %>% 
  knitr::kable() %>%
  clipr::write_clip()
