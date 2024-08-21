j27_social <- c(
  "J_27_income_sources/pension",
  "J_27_income_sources/other_government_social_benefits_or_assistance"
)
j27_assistance <- c(
  "J_27_income_sources/idp_benefits",
  "J_27_income_sources/humanitarian_aid",
  "J_27_income_sources/loans_or_support_from_family_and_friends_within_ukraine",
  "J_27_income_sources/loans_support_or_charitable_donations_from_community_members"
)

j27_irregular <- c(
  "J_27_income_sources/casual_or_daily_labour",
  "J_27_income_sources/other"
)

j27_regular <- c(
  "J_27_income_sources/salaried_work",
  "J_27_income_sources/income_from_own_business_or_regular_trade",
  "J_27_income_sources/income_from_rent",
  "J_27_income_sources/income_from_own_production",
  "J_27_income_sources/money_transfers_from_abroad_from_family_and_friends"
)

j27_undefined <- c(
  "J_27_income_sources/dont_know",
  "J_27_income_sources/prefer_not_to_answer"
)

median_inc <- 5865
new_magic_number = 6471.4
new_magic_number_3 = 9707.1
small_magic_number = 2324

livelihoods <- data.list$main %>%
  mutate(
    soc = rowSums(across(j27_social, as.numeric),na.rm = TRUE),
    ass = rowSums(across(j27_assistance, as.numeric),na.rm = TRUE),
    irr = rowSums(across(j27_irregular, as.numeric),na.rm = TRUE),
    reg = rowSums(across(j27_regular, as.numeric),na.rm = TRUE),
    non = as.numeric(data.list$main$`J_27_income_sources/none`),
    undef = rowSums(across(j27_undefined, as.numeric),na.rm = TRUE),
    income_source = case_when(
      ( (ass > 0 & (soc+reg+irr+non+undef) == 0 ) | (non > 0 & (soc+reg+irr+ass+undef) == 0) ) ~ 4,
      ( ( (reg+soc+irr) > 0 & ass > 0  & (non+undef) == 0 ) | ( (irr) > 0 & (soc+reg+ass+non+undef) == 0 ) ) ~ 3,
      ( (soc+irr) > 0 & (ass+non+undef) == 0 ) ~ 2,
      (reg > 0 & (soc+ass+irr+non+undef) == 0) ~ 1,
      undef > 0 ~ NA,
      TRUE ~ NA
    ),
    income_quantity = case_when(
      (as.numeric(total_inc_per_capita) <= 0.4 * median_inc) ~ 4,
      (((as.numeric(total_inc_per_capita) > 0.4 * median_inc & as.numeric(total_inc_per_capita) <= 0.6 * median_inc))) ~ 3,
      ((as.numeric(total_inc_per_capita) > 0.6 * median_inc & as.numeric(total_inc_per_capita) <= 0.8 * median_inc)) ~ 2,
      (as.numeric(total_inc_per_capita) > 0.8 * median_inc) ~ 1,
      is.na(total_inc_per_capita) | I_11_struggle_enough_money %in% c("dont_know", "prefer_not_to_answer") ~ NA,
      TRUE ~ -1
    ),
    income_quantity_v2 = case_when(
      as.numeric(total_inc_per_capita) <= new_magic_number ~ 3,
      as.numeric(total_inc_per_capita) > new_magic_number ~ 1,
      TRUE ~ NA
    ),
    income_quantity_v3 = case_when(
      as.numeric(total_inc_per_capita) <= new_magic_number / 2 ~ 4,
      as.numeric(total_inc_per_capita) <= new_magic_number & as.numeric(total_inc_per_capita) > new_magic_number / 2  ~ 3,
      as.numeric(total_inc_per_capita) <= new_magic_number_3 & as.numeric(total_inc_per_capita) > new_magic_number  ~ 2,
      as.numeric(total_inc_per_capita) > new_magic_number_3 ~ 1,
      TRUE ~ NA
    ),
    income_quantity_v4 = case_when(
      as.numeric(total_inc_per_capita) <= small_magic_number ~ 4,
      as.numeric(total_inc_per_capita) <= new_magic_number & as.numeric(total_inc_per_capita) > small_magic_number  ~ 3,
      as.numeric(total_inc_per_capita) <= new_magic_number_3 & as.numeric(total_inc_per_capita) > new_magic_number  ~ 2,
      as.numeric(total_inc_per_capita) > new_magic_number_3 ~ 1,
      TRUE ~ NA
    ),
    income_quantity_v5 = case_when(
      as.numeric(total_exp_per_capita) <= small_magic_number ~ 4,
      as.numeric(total_exp_per_capita) <= new_magic_number & as.numeric(total_exp_per_capita) > small_magic_number  ~ 3,
      as.numeric(total_exp_per_capita) <= new_magic_number_3 & as.numeric(total_exp_per_capita) > new_magic_number  ~ 2,
      as.numeric(total_exp_per_capita) > new_magic_number_3 ~ 1,
      TRUE ~ NA
    ),
    coping = case_when(
      lcsi_score == "Emergency" ~ 4,
      lcsi_score == "Crisis" ~ 3,
      lcsi_score == "Stress" ~ 2,
      lcsi_score == "No coping" ~ 1,
      is.na(lcsi_score) ~ NA,
      TRUE ~ -1
    )
  ) %>% 
  select(uuid, income_source, income_quantity, income_quantity_v2, income_quantity_v3, income_quantity_v4, income_quantity_v5, coping)

data.list$main <- data.list$main %>%
  left_join(livelihoods, by = "uuid")
