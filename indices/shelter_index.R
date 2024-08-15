shelter_type_g2_lvl_1 <- c(
  "individual_shelter",
  "individual_shelter_shared"
)

shelter_type_g2_lvl_2 <- c(
  "hosted_by_friends_relatives",
  "hosting_at_least_one_other_household_in_own_home"
)

shelter_type_g2_lvl_3 <- c(
  "collective_site"
)

shelter_type_g2_lvl_5 <- c(
  "no_shelter"
)

shelter_type_g2_lvl_undef <- c(
  "other",
  "dont_know",
  "prefer_not_to_answer"
)

#===

shelter_type_g3_lvl_1 <- c(
  "house",
  "finished_apartment"
)

shelter_type_g3_lvl_3 <- c(
  "unfinished"
)

shelter_type_g3_lvl_4 <- c(
  "tent",
  "makeshift"
)

shelter_type_g3_lvl_undef <- c(
  "other",
  "dont_know",
  "prefer_not_to_answer"
)

#=====

shelter_issues_g8 <- c(
  "G_8_shelter_issues/lack_of_privacy",
  "G_8_shelter_issues/lack_of_space_inside_dwelling_shelter",
  "G_8_shelter_issues/it_is_often_too_hot_or_too_cold_inside_dwelling_shelter",
  "G_8_shelter_issues/limited_ventilation_inside_dwelling_shelter",
  "G_8_shelter_issues/leaks_when_it_rains",
  "G_8_shelter_issues/unable_to_lock_the_dwelling_shelter",
  "G_8_shelter_issues/lack_of_lighting_inside_the_dwelling_shelter",
  "G_8_shelter_issues/lack_of_lighting_outside_the_dwelling_shelter",
  "G_8_shelter_issues/some_members_have_difficulties_moving_inside_or_outside_the_house",
  "G_8_shelter_issues/other"
)
shelter_issues_g8_undef <- c(
  "G_8_shelter_issues/dont_know",
  "G_8_shelter_issues/prefer_not_to_answer"
)

#===

shelter_issues_g9 <- c(
  "G_9_curr_shelter_damage/roof",
  "G_9_curr_shelter_damage/walls",
  "G_9_curr_shelter_damage/windows",
  "G_9_curr_shelter_damage/doors",
  "G_9_curr_shelter_damage/other"
)
shelter_issues_g9_undef <- c(
  "G_9_curr_shelter_damage/dont_know",
  "G_9_curr_shelter_damage/prefer_not_to_answer"
)

#===

shelter_issues_g10_lvl2 <- c(
  "insignificant",
  "minor"
)

shelter_issues_g10_lvl3 <- c(
  "moderate",
  "major"
)

shelter_issues_g10_lvl4 <- c(
  "catastrophic_complete"
)

shelter_issues_g10_undef <- c(
  "dont_know",
  "prefer_not_to_answer"
)

#=====

security_tenure_g6_low <- c(
  "owned_property",
  "rented"
)

security_tenure_g6_high <- c(
  "hosted_for_free",
  "no_occupancy_agreement_squatting"
)

security_tenure_g6_undef <- c(
  "dont_know",
  "prefer_not_to_answer"
)

snfi <- data.list$main %>%
  mutate(
    shelter_type = case_when(
      (
        G_2_shelter_situation %in% shelter_type_g2_lvl_5
      ) ~ 5,
      (
        G_3_shelter_type %in% shelter_type_g3_lvl_4
      ) ~ 4,
      (
        (G_2_shelter_situation %in% shelter_type_g2_lvl_3) |
        (G_3_shelter_type %in% shelter_type_g3_lvl_3)
      ) ~ 3,
      (
        (G_2_shelter_situation %in% shelter_type_g2_lvl_2) &
        (G_3_shelter_type %in% shelter_type_g3_lvl_1)
      ) ~ 2,
      (
        (G_2_shelter_situation %in% shelter_type_g2_lvl_1) |
        (G_3_shelter_type %in% shelter_type_g3_lvl_1)
      ) ~ 1,
      (
        (G_2_shelter_situation %in% shelter_type_g2_lvl_undef) |
        (G_3_shelter_type %in% shelter_type_g3_lvl_undef)
      ) ~ NA,
      TRUE ~ -1
    ),
    issue_g8_cnt = rowSums(across(shelter_issues_g8, as.numeric),na.rm = TRUE),
    g8_undef_cnt = rowSums(across(shelter_issues_g8_undef, as.numeric),na.rm = TRUE),
    shelter_issues_1 = case_when(
      (
        as.numeric(`G_8_shelter_issues/none`) == 1
      ) ~ 1,
      (
        (issue_g8_cnt > 0) & (issue_g8_cnt < 3)
      ) ~ 2,
      (
        (issue_g8_cnt > 2) & (issue_g8_cnt < 11)
      ) ~ 3,
      g8_undef_cnt > 0 | issue_g8_cnt == 0 ~ NA,
      TRUE ~ -1
    ),
    issue_g9_cnt = rowSums(across(shelter_issues_g9, as.numeric),na.rm = TRUE),
    g9_undef_cnt = rowSums(across(shelter_issues_g9_undef, as.numeric),na.rm = TRUE),
    shelter_issues_2 = case_when(
      (
        G_10_shelter_assess %in% shelter_issues_g10_lvl4
      ) ~ 5,
      (
        as.numeric(`G_9_curr_shelter_damage/none`) == 1
      ) ~ 1,
      (
        (issue_g9_cnt > 2 & issue_g9_cnt < 6) &
        (G_10_shelter_assess %in% shelter_issues_g10_lvl3)
      ) ~ 4,
      (
        (
          (issue_g9_cnt > 2 & issue_g9_cnt < 6) &
          (G_10_shelter_assess %in% shelter_issues_g10_lvl2)
        ) |
        (
          (issue_g9_cnt > 0 & issue_g9_cnt < 3) &
          (G_10_shelter_assess %in% shelter_issues_g10_lvl3)
        )
      ) ~ 3,
      (
        (issue_g9_cnt > 0 & issue_g9_cnt < 3) &
        (G_10_shelter_assess %in% shelter_issues_g10_lvl2)
      ) ~ 2,
      TRUE ~ -1
    ),
    security_tenure = case_when(
      (G_6_occupancy_arrang %in% security_tenure_g6_high) ~ 3,
      (
        (G_6_occupancy_arrang %in% security_tenure_g6_low) &
        (G_7_evict_risk == "yes")
      ) ~ 2,
      (
        (G_6_occupancy_arrang %in% security_tenure_g6_low) &
        (G_7_evict_risk == "no")
      ) ~ 1,
      (
        (G_6_occupancy_arrang %in% security_tenure_g6_undef) |
        (G_7_evict_risk %in% c("dont_know", "prefer_not_to_answer")) |
        is.na(G_6_occupancy_arrang) | is.na(G_7_evict_risk)
      ) ~ NA,
      TRUE ~ -1
    )
  ) %>%
  select(uuid, shelter_type, shelter_issues_1, shelter_issues_2, security_tenure)
