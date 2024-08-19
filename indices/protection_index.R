safety_f2_lvl1 <- c(
  "F_2_gen_safety_concerns/none",
  "F_2_gen_safety_concerns/stray_animals"
)

safety_f2_conflict <- c(
  "F_2_gen_safety_concerns/violence_related_to_the_conflict_impacting_public_infrastructure",
  "F_2_gen_safety_concerns/violence_related_to_the_conflict_impacting_private_infrastructure",
  "F_2_gen_safety_concerns/violence_related_to_the_conflict_impacting_civilians",
  "F_2_gen_safety_concerns/presence_of_landmines_uxos"
)

safety_f2_lvl2 <- c(
  "F_2_gen_safety_concerns/conscription",
  "F_2_gen_safety_concerns/being_robbed",
  "F_2_gen_safety_concerns/presence_of_military_actors",
  "F_2_gen_safety_concerns/other"
)

safety_f2_lvl3 <- c(
  "F_2_gen_safety_concerns/violence_and_harassment_not_related_conflict_in_public_spaces",
  "F_2_gen_safety_concerns/violence_and_harassment_not_related_conflict_in_private_spaces",
  "F_2_gen_safety_concerns/discrimination",
  "F_2_gen_safety_concerns/exploitation",
  "F_2_gen_safety_concerns/social_tension_in_the_community"
)

safety_f2_lvl4 <- c(
  "F_2_gen_safety_concerns/arbitrary_arrest_detention",
  "F_2_gen_safety_concerns/kidnapping_forced_disappearance"
)

safety_f2_undef <- c(
  "F_2_gen_safety_concerns/dont_know",
  "F_2_gen_safety_concerns/prefer_not_to_answer"
)

#=====

barriers_k202_lvl2 <- c(
  "K_20_2_govern_barriers/yes_social_workers_from_state_institutions_not_visit_location_often",
  "K_20_2_govern_barriers/yes_lack_information_about_available_services",
  "K_20_2_govern_barriers/yes_quality_of_services_not_adequate",
  "K_20_2_govern_barriers/yes_services_not_always_functional",
  "K_20_2_govern_barriers/yes_fear_of_conscription",
  "K_20_2_govern_barriers/other"
)

barriers_k202_lvl3 <- c(
  "K_20_2_govern_barriers/yes_lack_of_available_services",
  "K_20_2_govern_barriers/yes_insufficient_number_social_workers_provide_services",
  "K_20_2_govern_barriers/yes_limited_services_for_people_with_disability",
  "K_20_2_govern_barriers/yes_distance_lack_or_cost_for_transportation_relevant_facilities",
  "K_20_2_govern_barriers/yes_discrimination_against_specific_social_groups"
)


protection <- data.list$main %>%
  mutate(
    f2_lvl1_cnt = rowSums(across(safety_f2_lvl1, as.numeric),na.rm = TRUE),
    f2_conflict_cnt = rowSums(across(safety_f2_conflict, as.numeric),na.rm = TRUE),
    f2_lvl2_cnt = rowSums(across(safety_f2_lvl2, as.numeric),na.rm = TRUE),
    f2_lvl3_cnt = rowSums(across(safety_f2_lvl3, as.numeric),na.rm = TRUE),
    f2_lvl4_cnt = rowSums(across(safety_f2_lvl4, as.numeric),na.rm = TRUE),
    f2_undef_cnt = rowSums(across(safety_f2_undef, as.numeric),na.rm = TRUE),
    safety = case_when(
      (
        (as.numeric(`30km_fl_rb`) == 1) &
        (f2_conflict_cnt > 0)
      ) ~ 5,
      (
        f2_lvl4_cnt > 0
      ) ~ 4,
      (
        f2_lvl3_cnt > 0
      ) ~ 3,
      (
        (
          (as.numeric(`30km_fl_rb`) == 0) &
          (f2_conflict_cnt > 0)
        ) | f2_lvl2_cnt > 0
      ) ~ 2,
      (
        f2_lvl1_cnt > 0
      ) ~ 1,
      f2_undef_cnt > 0 | is.na(`F_2_gen_safety_concerns/none`) | is.na(`30km_fl_rb`) ~ NA,
      TRUE ~ -1,
    ),
    k202_lvl2_cnt = rowSums(across(barriers_k202_lvl2, as.numeric),na.rm = TRUE),
    k202_lvl3_cnt = rowSums(across(barriers_k202_lvl3, as.numeric),na.rm = TRUE),
    barriers = case_when(
      (
        K_20_1_govern_services == "yes" &
        k202_lvl3_cnt > 0
      ) ~ 3,
      (
        K_20_1_govern_services == "yes" &
        k202_lvl2_cnt > 0
      ) ~ 2,
      (
        K_20_1_govern_services == "no" |
        (K_20_1_govern_services == "yes" & as.numeric(`K_20_2_govern_barriers/none`) == 1)
      ) ~ 1,
      (
        as.numeric(`K_20_2_govern_barriers/prefer_not_to_answer`) == 1 |
        K_20_1_govern_services %in% c("dont_know", "prefer_not_to_answer") |
        is.na(K_20_1_govern_services) |
        (K_20_1_govern_services == "yes" & k202_lvl2_cnt+k202_lvl3_cnt == 0)
      ) ~ NA,
      TRUE ~ -1,
    )
  ) %>%
  select(uuid, safety, K_20_1_govern_services, barriers_k202_lvl2, barriers_k202_lvl3, barriers)

data.list$main <- data.list$main %>%
  left_join(protection, by = "uuid")
