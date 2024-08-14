
na_list <- c('prefer_not_to_answer','dont_know')

ls_c6_barriers <- c('schools_damaged_destroyed','remote_learning_is_the_only_available_hh_do_not_have_equipment','regular_electricity_power_cuts_prevent_access',
                    'connectivity_to_internet_barrier','disability','education_is_not_a_priority','not_able_to_enrol_child_in_the_school','language_issues','cannot_afford_educationrelated_costs')


ls_c8_issues <-  c('C_8_school_travel_barriers/security_concerns_of_child_travelling_to_school','C_8_school_travel_barriers/schools_attack',
                 'C_8_school_travel_barriers/genderbased_or_sexual_violence_abuse','C_8_school_travel_barriers/verbal_bullying_or_discrimination',
                 'C_8_school_travel_barriers/physical_bullying_between_students','C_8_school_travel_barriers/unsafe_infrastructure',
                 'C_8_school_travel_barriers/discrimination_of_the_child')

ls_c10_issues <-  c('C_10_learning_conditions_barriers/internet_is_not_reliable','C_10_learning_conditions_barriers/equipment_need_to_be_shared_between_children_in_hh',
                  'C_10_learning_conditions_barriers/no_secure_transportation_to_school_available','C_10_learning_conditions_barriers/curriculum_is_not_adapted_for_distance_learning')



data_loop_ind <- data.list$hh_members %>% 
  mutate(
    count_age_6_17 = ifelse((as.numeric(A_14_hh_member_age) %_>=_% 6) & (as.numeric(A_14_hh_member_age) %_<=_% 17), 1, 0),
    
    crit_education_1 = case_when( ##changed
      (as.numeric(count_age_6_17) == 1 & C_1_children_enrolled == 'no') |
      (as.numeric(count_age_6_17) == 1 & ( (C_3_children_attending_open_schools == 'no' | 
                                             C_4_1_children_disctance_learning_access =='no' |
                                              C_4_children_disctance_learning_access == 'no') & 
                                            C_6_children_reason_not_accessing %in% c('protection_risks_while_at_school','protection_risks_while_commuting_to_school'))) |
        
        (rowSums(across(all_of(ls_c8_issues), .fns = as.numeric), na.rm = T) >0  &  as.numeric(count_age_6_17) == 1) ~ 4,
      
        
        (as.numeric(count_age_6_17) == 1 & ((C_3_children_attending_open_schools == 'no' | C_4_children_disctance_learning_access == 'no' |
                                            C_4_1_children_disctance_learning_access == 'no') & C_6_children_reason_not_accessing %in% ls_c6_barriers))  ~ 3,
      
      ((C_4_children_disctance_learning_access == 'yes' | C_4_1_children_disctance_learning_access == 'yes') &
         C_9_learning_conditions == 'no' &
         rowSums(across(all_of(ls_c10_issues), .fns = as.numeric), na.rm = T) >0) &  as.numeric(count_age_6_17) == 1 ~ 2,
    
      (as.numeric(count_age_6_17) == 1  & (C_1_children_enrolled == 'yes' & (C_3_children_attending_open_schools == 'yes' | C_4_children_disctance_learning_access == 'yes' |
                                                                              C_4_1_children_disctance_learning_access == 'yes'))) | 
        ((C_7_school_travel =='yes' | 
            rowSums(across(c(`C_8_school_travel_barriers/lack_of_referal_mechanism_at_the_school`,
                             `C_8_school_travel_barriers/lack_of_teaching_staff_qualified_in_providing_psychosocial_support`),
                           .fns = as.numeric), na.rm = T) > 0) &  as.numeric(count_age_6_17) == 1)|
        C_9_learning_conditions == 'yes'  ~ 1,
      
      C_1_children_enrolled %in% na_list | C_2_learning_modality %in% na_list |
        C_3_children_attending_open_schools %in% na_list | C_4_children_disctance_learning_access %in% na_list |
        C_4_1_children_disctance_learning_access %in% na_list  | C_6_children_reason_not_accessing %in% c(na_list, 'other') |
        C_7_school_travel %in% na_list |
        as.numeric(`C_8_school_travel_barriers/other`) == 1  | 
        as.numeric(`C_8_school_travel_barriers/prefer_not_to_answer`) == 1 |
        ( 
            (C_9_learning_conditions %in% na_list |  as.numeric(`C_10_learning_conditions_barriers/other`) == 1  |
               as.numeric(`C_10_learning_conditions_barriers/prefer_not_to_answer`) == 1)) ~ NA,
    TRUE ~ NA_real_
  )
  
  # ,
  # crit_education_2 = case_when(
  #   (as.numeric(count_age_6_17) == 1 & C_1_children_enrolled == 'no') |
  #     (rowSums(across(all_of(ls_c8_issues), .fns = as.numeric), na.rm = T) >0  &  as.numeric(count_age_6_17) == 1)  ~ 4,
  #  
  #    (as.numeric(count_age_6_17) == 1  & (C_1_children_enrolled == 'yes' & (C_3_children_attending_open_schools == 'yes' | C_4_children_disctance_learning_access == 'yes' |
  #                                                                            C_4_1_children_disctance_learning_access == 'yes'))) | C_1_children_enrolled %in% na_list | C_2_learning_modality %in% na_list |
  #     C_3_children_attending_open_schools %in% na_list | C_4_children_disctance_learning_access %in% na_list |
  #     C_4_1_children_disctance_learning_access %in% na_list  | C_6_children_reason_not_accessing %in% c(na_list, 'other') & ## ???
  #     
  #   ((C_7_school_travel =='yes' | 
  #     rowSums(across(c(`C_8_school_travel_barriers/lack_of_referal_mechanism_at_the_school`,
  #                      `C_8_school_travel_barriers/lack_of_teaching_staff_qualified_in_providing_psychosocial_support`),
  #                    .fns = as.numeric), na.rm = T) > 0) &  as.numeric(count_age_6_17) == 1) | 
  #   C_7_school_travel %in% na_list |
  #   as.numeric(`C_8_school_travel_barriers/other`) == 1  | 
  #   as.numeric(`C_8_school_travel_barriers/prefer_not_to_answer`) == 1 ~ 1,
  #   TRUE ~ NA_real_
  # )
  # ,
  
  # non_crit_education_1 = case_when(
  #   
  #   
  #   ((C_4_children_disctance_learning_access == 'yes' | C_4_1_children_disctance_learning_access == 'yes') &
  #      C_9_learning_conditions == 'no' &
  #    rowSums(across(all_of(ls_c10_issues), .fns = as.numeric), na.rm = T) >0) &  as.numeric(count_age_6_17) == 1  ~1,
  #   
  #   ((C_9_learning_conditions == 'yes' & (C_4_children_disctance_learning_access == 'yes' |
  #      C_4_1_children_disctance_learning_access == 'yes'))  &  as.numeric(count_age_6_17) == 1) | 
  #     (C_9_learning_conditions %in% na_list |  as.numeric(`C_10_learning_conditions_barriers/other`) == 1  |
  #     as.numeric(`C_10_learning_conditions_barriers/prefer_not_to_answer`) == 1) ~ 0,
  #   TRUE ~ NA_real_
  # ),
  # non_crit_education_2 = case_when(
  #   C_11_ecd_attendance == 'no' & (as.numeric(`C_12_ecd_barriers/lack_of_secure_preschool_infrustructure_shelters`) == 1 |
  #                                    as.numeric(`C_12_ecd_barriers/kindergardens_are_occupied_by_idps` == 1)) ~ 1,
  #   C_11_ecd_attendance == "yes" ~ 0,
  #   TRUE ~ NA_real_
  # )
  ) %>% 
  group_by(uuid) %>% 
  summarise(across(count_age_6_17:crit_education_1, ~ na_max(.x))) %>% 
  ungroup() %>%  # add 1 for HH with no children
  mutate(crit_education_1 = ifelse(count_age_6_17== 0 , 1 , crit_education_1)) %>% 
  select(uuid, crit_education_1)

data.list$main <- data.list$main %>% 
  left_join(data_loop_ind)

rm(data_loop_ind)
