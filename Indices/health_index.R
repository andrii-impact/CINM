na_list <- c('prefer_not_to_answer','dont_know')


healthcare_barrier_specific <- c("J_10_healthcare_barriers_prevented_access/no_functional_health_facility_nearby",
                                 "J_10_healthcare_barriers_prevented_access/specific_service_sought_unavailable",
                                 "J_10_healthcare_barriers_prevented_access/long_waiting_time_for_the_service",
                                 "J_10_healthcare_barriers_prevented_access/could_not_afford_cost_of_consultation_service",
                                 "J_10_healthcare_barriers_prevented_access/no_means_of_transport",
                                 "J_10_healthcare_barriers_prevented_access/could_not_afford_transportation_to_health_facility",
                                 "J_10_healthcare_barriers_prevented_access/disability","J_10_healthcare_barriers_prevented_access/insecurity_at_health_facility",                              
                                 "J_10_healthcare_barriers_prevented_access/insecurity_while_travelling_to_health_facility",
                                 "J_10_healthcare_barriers_prevented_access/not_enough_or_no_appropriately_trained_staff_at_health_facility",
                                 "J_10_healthcare_barriers_prevented_access/fear_or_distrust_of_health_workers_examination_or_treatment",
                                 "J_10_healthcare_barriers_prevented_access/fear_of_stigma_or_prejudice")

medication_barrier_specific <-  c("J_14_medicines_bariiers/specific_medicine_sought_unavailable" ,"J_14_medicines_bariiers/could_not_afford_cost_of_medication",
                                  "J_14_medicines_bariiers/could_not_afford_transportation_to_pharmacy","J_14_medicines_bariiers/disability",
                                  "J_14_medicines_bariiers/no_means_of_transport_to_reach_the_closest_pharmacy","J_14_medicines_bariiers/not_safe_insecurity_at_the_pharmacy",
                                  "J_14_medicines_bariiers/not_safe_insecurity_while_travelling_to_pharmacy","J_14_medicines_bariiers/fear_of_stigma_or_prejudice",
                                  "J_14_medicines_bariiers/could_not_take_time_off_work_from_caring_for_children","J_14_medicines_bariiers/lack_of_medicine_in_pharmacy",
                                  "J_14_medicines_bariiers/lack_of_necessary_documents")


data_loop_2_ind <- data.list$healthcare %>% 
  mutate(
    na_column = ifelse(J_1_healthcare_services_access_intention %in% na_list | 
                         J_9_healthcare_services_not_obtained %in% na_list |
                         as.numeric(`J_10_healthcare_barriers_prevented_access/prefer_not_to_answer`) ==1 | 
                         as.numeric(`J_10_healthcare_barriers_prevented_access/dont_know`) ==1 ,1,0),
    health_seek_na = ifelse(J_3_healthcare_services_seeked %in% c('dont_know','prefer_not_to_answer'),1,0), ## changed (remove no)
    health_seek = ifelse(J_3_healthcare_services_seeked == "yes", 1, 0),##changed
    health_need = ifelse(J_1_healthcare_services_access_intention == 'yes',1,0),
    met_need = ifelse(J_9_healthcare_services_not_obtained == 'yes',1,0),
    unmet_need = ifelse(J_9_healthcare_services_not_obtained == 'no',1,0),
    barriers_reported = ifelse(rowSums(across(all_of(healthcare_barrier_specific), .fns = as.numeric), na.rm = T) > 0, 1,0),
    medicine_barrier_det = ifelse(rowSums(across(all_of(medication_barrier_specific), .fns = as.numeric), na.rm = T) > 0 |
                                         J_14_medicines_bariiers_other == 'There is no pharmacy', 1,0),
    heath_barrier_reported = ifelse(`J_10_healthcare_barriers_prevented_access/no_barriers_experienced` %in% c(1,NA) ,0,1),
    medicine_barrier_reported = ifelse(`J_14_medicines_bariiers/no_barriers_experienced` %in% c(1,NA) ,0,1)
  ) %>% 
  group_by(uuid) %>% 
  summarise(across(health_seek_na:medicine_barrier_reported, ~ na_max(.x)),##changed
            na_column = na_min(na_column)) %>% 
  ungroup()

loop_1_na_col <- data.list$hh_members %>% 
  mutate(na_column_1 = ifelse(
    A_19_wg_vis_ss %in% c('dont_know','prefer_not_to_answer') |
      A_20_wg_hear_ss %in% c('dont_know','prefer_not_to_answer') |
      A_21_wg_mob_ss %in% c('dont_know','prefer_not_to_answer')|
      A_22_wg_cog_ss %in% c('dont_know','prefer_not_to_answer') |
      A_23_wg_sc_ss %in% c('dont_know','prefer_not_to_answer') |
      A_24_wg_com_ss %in% c('dont_know','prefer_not_to_answer'),1,0)) %>% 
  group_by(uuid) %>% 
  summarise(na_column_1 = na_min(na_column_1)) %>% ungroup()

data.list$main <- data.list$main %>% 
  left_join(data_loop_2_ind) %>% 
  left_join(loop_1_na_col) %>% 
  rowwise() %>% 
  mutate(na_final = max(na_column_1,na_column, na.rm = T)) %>% ##changed
  ungroup() %>% 
  mutate(
    crit_health_1 = 
      case_when(
        (unmet_need == 1 & barriers_reported ==1 ) | medicine_barrier_det ==1 & disability_level_3_4 == "Disabled HH" ~ 4, 
        (unmet_need == 1 | heath_barrier_reported == 1 | medicine_barrier_reported == 1) | 
          (met_need == 1 & (heath_barrier_reported == 0 | medicine_barrier_reported == 0) & disability_level_3_4 == "Disabled HH") ~ 3,
        (unmet_need == 0 & heath_barrier_reported == 0 & medicine_barrier_reported == 0)  |
          (health_need == 1 & health_seek == 0) ~ 2, ##changed
        health_need == 0  ~ 1, 
        na_final == 1 ~ NA,
        TRUE ~ NA_real_
  )
  )








