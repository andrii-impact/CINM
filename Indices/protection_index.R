# indicator 2


concerns_severe_ls <- c('K_4_concerns_property/damaged_housing','K_4_concerns_property/looting_of_private_property','K_4_concerns_property/mortgage_payments_for_conflictaffected_housing',
                        'K_4_concerns_property/damage_or_destroyed_property_other_than_residential_real_estate','K_4_concerns_property/lack_of_documents_proving_ownership_of_housing',
                        'K_4_concerns_property/inadequate_living_conditions_in_collective_centers','K_4_concerns_property/eviction_from_collective_centers',
                        'K_4_concerns_property/eviction',
                        'K_4_concerns_property/destroyed_housing','K_4_concerns_property/land_contaminated_with_mines_uxo',
                        'K_4_concerns_property/property_is_unlawfully_occupied_by_others','K_4_concerns_property/housing_and_or_land_is_used_for_military_purposes',
                        'K_4_concerns_property/property_owners_do_not_have_an_access_to_it_due_to_the_military_restrictions')

concerns_stress_ls <- c('K_4_concerns_property/rental_disputes_landlord_tenant_problems','K_4_concerns_property/no_social_housing_available_in_the_area',
                        'K_4_concerns_property/no_affordable_housing_for_rent_available_in_the_area','K_4_concerns_property/rules_and_processes_on_housing_and_land_not_clear_or_changing')

concerns_na_ls <- c('K_4_concerns_property/prefer_not_to_answer','K_4_concerns_property/other') #changed



# indicator 3
# 
# raions_caa_list <- c('UA7410','UA7402','UA7406','UA1206','UA1208','UA1214','UA1412','UA1416','UA1404',
#                      'UA6302','UA6314','UA6304','UA6312','UA6308','UA6502','UA3210','UA4802','UA4806',
#                      'UA5902','UA5904','UA5910','UA5908','UA2306')

raions_caa_list <- c("UA1402","UA6502","UA6314","UA1408","UA1406","UA6312","UA6510","UA1412","UA6308",
                     "UA1208","UA7406","UA1208","UA2310","UA5910","UA4412","UA5908","UA4410","UA2304",
                     "UA1404") ## CHANGED


safety_concerns_super_extreme_ls <- c('K_6_concerns_security/presence_of_landmines_uxo','K_6_concerns_security/armed_violence_shelling',
                                      'K_6_concerns_security/attacks_on_civilian_facilities_schools_hospitals','K_6_concerns_security/abduction_or_forced_disappearance')

safety_concerns_extreme_ls <- c('K_6_concerns_security/property_is_unlawfully_occupied_by_others',
                                'K_6_concerns_security/housing_and_land_is_used_for_military_purposes')

safety_concerns_severe_ls <-  c('K_6_concerns_security/arbitrary_arrest_and_or_detention',
                                'K_6_concerns_security/looting_of_private_property')


safety_concerns_stress_ls <- c('K_6_concerns_security/insecure_environment_due_to_crime','K_6_concerns_security/harassment_to_disclose_information',
                               'K_6_concerns_security/social_tension_in_the_community')


# indicator 4

legal_services_severe_ls <- c('K_18_legal_assistance_requirement/yes_to_apply_for_compensation_for_damaged_or_destroyed_property',
                              'K_18_legal_assistance_requirement/yes_to_access_pensions','K_18_legal_assistance_requirement/yes_to_access_social_benefits',
                              'K_18_legal_assistance_requirement/yes_to_obtain_civil_documents_birth_death_marriage_divorce',
                              'K_18_legal_assistance_requirement/yes_to_obtain_identity_documents','K_18_legal_assistance_requirement/yes_to_obtain_property_documentation')


legal_services_stress_ls <- c('K_18_legal_assistance_requirement/yes_to_apply_for_subsidies','K_18_legal_assistance_requirement/other')

legal_services_na_ls <- c('K_18_legal_assistance_requirement/prefer_not_to_answer',
                               'K_18_legal_assistance_requirement/dont_know')

# non critical 1

services_lack_ls <-  c('K_16_services_mhpss/mental_health_and_psychosocial_support_services_for_girls_and_boys',
                       'K_16_services_mhpss/social_services_for_girls_and_boys','K_16_services_mhpss/supportive_group_activities')

services_barriers_stress_ls <- c('K_17_services_mhpss_barriers/social_workers_from_state_institutions_do_not_visit_settlement_often',
                                 'K_17_services_mhpss_barriers/the_quality_of_services_is_not_good','K_17_services_mhpss_barriers/services_are_not_accessible_to_children_with_disabilities_uascs',
                                 'K_17_services_mhpss_barriers/safety_and_security_concerns_on_the_road','K_17_services_mhpss_barriers/safety_and_security_concerns_fear_of_reprisals',
                                 'K_17_services_mhpss_barriers/safety_and_privacy_concern_do_not_trust_the_staff','K_17_services_mhpss_barriers/feel_discriminated_against',
                                 'K_17_services_mhpss_barriers/services_are_not_always_functional_opened','K_17_services_mhpss_barriers/difficulties_to_reach',
                                 'K_17_services_mhpss_barriers/financial_constraints','K_17_services_mhpss_barriers/lack_of_civil_documentation_to_access_these_service',
                                 'K_17_services_mhpss_barriers/distance_lack_of_transportation_cannot_afford_transportation','K_17_services_mhpss_barriers/lack_of_information_on_services')

services_barriers_minimal_ls <- c('K_17_services_mhpss_barriers/none','K_17_services_mhpss_barriers/parents_do_not_allow_them',
                                  'K_17_services_mhpss_barriers/they_are_busy_with_hh_chore', 'K_17_services_mhpss_barriers/always_too_many_people_too_long_to_wait')



# non critical indicators 2

services_list <- c('K_14_services_women/violence_against_women_hotline','K_14_services_women/survivors_of_violence_against_womens_relief_center',
                   'K_14_services_women/psychosocial_support_for_women_and_girls','K_14_services_women/psychosocial_support_for_men_and_boys',
                   'K_14_services_women/recreational_activities_organized_for_women_and_girls_at_safe_spaces','K_14_services_women/reproductive_health_services_for_women_and_girls',
                   'K_14_services_women/services_offered_for_women_and_girls_men_and_boys_if_they_experience_violence','K_14_services_women/legal_services')



barriers_women_stress_ls <- c('K_15_services_women_barriers/women_and_girls_are_too_busy_with_household_chores_to_access_these_services',
                              'K_15_services_women_barriers/travel_to_these_services_is_difficult','K_15_services_women_barriers/these_services_are_too_busy_with_long_waiting_times',
                              'K_15_services_women_barriers/there_are_financial_constraints_to_access_these_services',
                              'K_15_services_women_barriers/the_quality_of_services_is_not_good','K_15_services_women_barriers/travel_to_these_services_is_unsafe',
                              'K_15_services_women_barriers/parents_do_not_allow_girls_to_access_these_services','K_15_services_women_barriers/dont_know_how_to_access_services',
                              'K_15_services_women_barriers/women_and_girls_feel_discriminated_against_social_stigma_while_accessing_these_services',
                              'K_15_services_women_barriers/services_are_not_always_functional')


# non critical indicators 3


concerns_women_ls <- c('K_11_concerns_women/being_sent_abroad_to_find_work','K_11_concerns_women/being_sent_abroad_for_protection',
                       'K_11_concerns_women/being_injured_killed_by_an_explosive_hazard_including_mine_uxo','K_11_concerns_women/being_kidnapped',
                       'K_11_concerns_women/being_robbed','K_11_concerns_women/suffering_from_physical_harassment_or_violence_not_sexual',
                       'K_11_concerns_women/suffering_from_sexual_harassment_or_violence','K_11_concerns_women/suffering_from_verbal_harassment',
                       'K_11_concerns_women/suffering_from_economic_violence','K_11_concerns_women/discrimination_or_persecution',
                       'K_11_concerns_women/being_killed','K_11_concerns_women/being_injured','K_11_concerns_women/being_detained',
                       'K_11_concerns_women/being_exploited')

# non critical indicators 4

concerns_children_ls <- c('K_13_concerns_children/being_sent_abroad_to_find_work','K_13_concerns_children/being_sent_abroad_for_protection',
                          'K_13_concerns_children/being_injured_killed_by_an_explosive_hazard_including_mine_uxo','K_13_concerns_children/being_recruited_by_armed_forces',
                          'K_13_concerns_children/being_kidnapped',
                          'K_13_concerns_children/being_robbed','K_13_concerns_children/suffering_from_physical_harassment_or_violence_not_sexual',
                          'K_13_concerns_children/suffering_from_sexual_harassment_or_violence','K_13_concerns_children/suffering_from_verbal_harassment',
                          'K_13_concerns_children/suffering_from_economic_violence','K_13_concerns_children/discrimination_or_persecution',
                          'K_13_concerns_children/being_killed','K_13_concerns_children/being_injured','K_13_concerns_children/being_detained',
                          'K_13_concerns_children/being_exploited')




data.list$main <- data.list$main %>% 
  mutate(
    crit_prot_1 = case_when(
      as.numeric(`K_3_child_outside_hh_reason/married_with_partner_and_left_the_house`)== 1 |
        as.numeric(`K_3_child_outside_hh_reason/left_the_house_to_engage_with_the_army_or_armed_groups`)== 1 |
        as.numeric(`K_3_child_outside_hh_reason/kidnapped_abducted`)== 1 | 
        as.numeric(`K_3_child_outside_hh_reason/missing`) == 1 |
        as.numeric(`K_3_child_outside_hh_reason/arbitrarily_detained`) == 1~ 4 ,
      
      as.numeric(`K_3_child_outside_hh_reason/left_the_house_to_seek_employment`) == 1 ~ 3 ,
      
      (as.numeric(`K_3_child_outside_hh_reason/married_with_partner_and_left_the_house`)==  0 |
         K_1_child_outside_hh == 'no' )  ~ 1,
      (K_1_child_outside_hh %in% c('prefer_not_to_answer','dont_know') |
         as.numeric(`K_3_child_outside_hh_reason/prefer_not_to_answer`)== 1  |
         as.numeric(`K_3_child_outside_hh_reason/dont_know`)== 1) ~ NA
    ),
    crit_prot_2 = case_when(

      rowSums(across(concerns_severe_ls, .fns = as.numeric), na.rm = T)>0 ~ 3,
      rowSums(across(concerns_stress_ls, .fns = as.numeric), na.rm = T)>0 ~ 2,
      as.numeric(`K_4_concerns_property/none`) == 1 ~ 1,
      rowSums(across(concerns_na_ls, .fns = as.numeric), na.rm = T)>0 ~ NA,
      TRUE ~ NA_real_
    ),
    crit_prot_3 = case_when(
      rowSums(across(safety_concerns_super_extreme_ls, .fns = as.numeric), na.rm = T)>0 &
        raion_full %in% raions_caa_list ~ 5, 
      rowSums(across(safety_concerns_extreme_ls, .fns = as.numeric), na.rm = T)>0 |
        (rowSums(across(safety_concerns_super_extreme_ls, .fns = as.numeric), na.rm = T)>0 &
           ! raion_full %in% raions_caa_list )  ~ 4,
      
      (rowSums(across(safety_concerns_severe_ls, .fns = as.numeric), na.rm = T)>0) ~ 3, 
      rowSums(across(safety_concerns_stress_ls, .fns = as.numeric), na.rm = T)>0 ~ 2,
      (as.numeric(`K_6_concerns_security/no_safety_and_security_concern`)== 1 | 
         as.numeric(`K_6_concerns_security/presence_of_military_actors`)== 1) ~ 1, 
      (as.numeric(`K_6_concerns_security/dont_know`)== 1|  
         as.numeric(`K_6_concerns_security/prefer_not_to_answer`)== 1 |
         as.numeric(`K_6_concerns_security/other`)== 1)~  NA,
      TRUE ~ NA_real_
    ),
    crit_prot_4 = case_when(
      K_12_government_social_services %in% c('yes','no')  &
          rowSums(across(legal_services_severe_ls, .fns = as.numeric), na.rm = T)>0 ~ 3,
      K_12_government_social_services ==c('yes','no')  &
          rowSums(across(legal_services_stress_ls, .fns = as.numeric), na.rm = T>0
      ) ~ 2,
      as.numeric(`K_18_legal_assistance_requirement/no`) ==1 | 
        K_12_government_social_services %in% c('no')~ 1,
      K_12_government_social_services %in% c('prefer_not_to_answer','yes') | 
        rowSums(across(legal_services_na_ls, .fns = as.numeric), na.rm = T)>0  ~ NA,
      TRUE ~ NA_real_  
    ),
    non_crit_prot_1 = case_when(
      as.numeric(`K_16_services_mhpss/none`)== 1 |  as.numeric(`K_16_services_mhpss/dont_know`)== 1 | 
        (rowSums(across(services_lack_ls, .fns = as.numeric), na.rm = T)>0 &
           rowSums(across(services_barriers_stress_ls, .fns = as.numeric), na.rm = T)>0 ) ~ 1,
      
      rowSums(across(services_lack_ls, .fns = as.numeric), na.rm = T)>0 &
        rowSums(across(services_barriers_minimal_ls, .fns = as.numeric), na.rm = T)>0  ~ 0
    ),
    non_crit_prot_2 = case_when(
      as.numeric(`K_14_services_women/none`) ==1 |  as.numeric(`K_14_services_women/dont_know`)== 1 |
        rowSums(across(barriers_women_stress_ls, .fns = as.numeric), na.rm = T)>0 ~ 1,
      
      rowSums(across(services_list, .fns = as.numeric), na.rm = T) >= 1| 
        as.numeric(`K_15_services_women_barriers/none`)== 1  ~ 0
    ),
    
    non_crit_prot_3 = case_when(
      rowSums(!across(c(K_11_concerns_women), is.na))==0 ~ NA,
      rowSums(across(concerns_women_ls, .fns = as.numeric), na.rm = T)>0 ~ 1,
      as.numeric(`K_11_concerns_women/none`)== 1 ~ 0,
      as.numeric(`K_11_concerns_women/dont_know`) ==1  |
        as.numeric(`K_11_concerns_women/other`) == 1 | 
        as.numeric(`K_11_concerns_women/prefer_not_to_answer`)==1 ~ NA,
    ),
    non_crit_prot_4 = case_when(
      rowSums(!across(c(K_13_concerns_children), is.na))==0 ~ NA,
      rowSums(across(concerns_children_ls, .fns = as.numeric), na.rm = T)>0 ~ 1,
      as.numeric(`K_13_concerns_children/none`)== 1 ~ 0,
      as.numeric(`K_13_concerns_children/dont_know`)== 1 |
        as.numeric(`K_13_concerns_children/other`) ==1|
        as.numeric(`K_13_concerns_children/prefer_not_to_answer`) ==1~ NA
    )
  )










