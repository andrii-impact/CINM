cat("\nCalculating LSGs for each Sector using the make_lsg function ...\n")

main <- data.list$main



main$lsg_education <- make_lsg(main,
                               crit_to_4 = c("crit_education_1")) ##changed





# Shelter/NFI

main$lsg_shelter_nfi <- make_lsg(main,
                                 crit_to_4plus = "crit_shelternfi_2",
                                 crit_to_4 = c("crit_shelternfi_1",
                                               "crit_shelternfi_3",
                                               "crit_shelternfi_4"))

# WASH


main$lsg_wash <- make_lsg(main,
                          crit_to_4plus = c("crit_wash_1",
                                            "crit_wash_2",
                                            "crit_wash_3"),
                          crit_to_2 = "crit_wash_4")

# Livelihoods



main$lsg_livelihoods <- make_lsg(main,
                                 crit_to_4 = c("income_source",
                                               "income_quantity"
                                               )
                                 )

# Health

main$lsg_health <- make_lsg(main,
                            crit_to_4 = c("crit_health_1"))

# Protection

non_critical_protection <- c("non_crit_prot_1",
                             "non_crit_prot_2",
                             "non_crit_prot_3",
                             "non_crit_prot_4")


# we don't have non-critical this year
# main <- main %>%
#   mutate(noncrit_prot_total = case_when(is.na(non_crit_prot_1) | is.na(non_crit_prot_2) | 
#                                           is.na(non_crit_prot_3) | is.na(non_crit_prot_4)  ~ NA_real_,
#                                         rowSums(across(non_critical_protection, .fns = as.numeric), na.rm =T)/4 >= 0.66 ~ 3,
#                                         rowSums(across(non_critical_protection, .fns = as.numeric), na.rm =T)/4 >= 0.33 ~ 2,
#                                         rowSums(across(non_critical_protection, .fns = as.numeric), na.rm =T)/4 >= 0 ~ 1,
#                                         TRUE ~ NA_real_))
# 
# main$lsg_protection <- make_lsg(main,
#                                 crit_to_4plus = c("crit_prot_3"),
#                                 crit_to_4 = c("crit_prot_1"),
#                                 crit_to_3 = c('crit_prot_2','crit_prot_4'),
#                                 non_crit = "noncrit_prot_total")


## Food Security
food_security <- readxl::read_excel("resources/MSNA23_clean_with_CARI_230829_1.xlsx", col_types = "text") %>% 
  select(uuid,cari_lvl,CARI_current_status, ec_vulnerability, coping_strategy) %>% 
  rename(lsg_food_security = "cari_lvl")

food_security$lsg_food_security <- factor(food_security$lsg_food_security, levels = c('Food secure','Marginally food secure',
                                                                                      'Moderately food insecure','Severely food insecure'), ordered = T)

main <- main %>% 
  left_join(food_security, by = "uuid") %>% 
  mutate(lsg_food_security = as.numeric(lsg_food_security))


col <- c("lsg_protection",
         "lsg_health",
         "lsg_livelihoods",
         "lsg_wash",
         "lsg_shelter_nfi",
         "lsg_education",
         "lsg_food_security")
library(expss)
main <- main %>%
  rowwise() %>% 
  mutate(MSNI = max(across(col), na.rm = T)) %>% 
  ungroup()

data.list$main <- main
cat("Finish Calculating LSGs and MSNI\n")


