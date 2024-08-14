

shelter_1_ls <- c("D_3_living_conditions_issues/unable_to_wash_dry_clothes", "D_3_living_conditions_issues/insufficient_privacy_no_partitions_doors",
                  "D_3_living_conditions_issues/does_not_feel_protected_in_the_shelter", "D_3_living_conditions_issues/unable_to_perform_general_personal_hygiene",
                  "D_3_living_conditions_issues/unable_to_adequately_wash","D_3_living_conditions_issues/unable_to_store_water","D_3_living_conditions_issues/lack_of_cooking_facilities",
                  "D_3_living_conditions_issues/at_least_one_member_of_the_household_has_to_sleep_outside")

shelter_2_ls <- c("D_2_conflict_damages/minor_damage_to_roof_cracks_openings", "D_2_conflict_damages/damage_to_floors",
                  "D_2_conflict_damages/damage_to_walls", "D_2_conflict_damages/lack_of_privacy_inside_the_shelter_no_partitions_doors",
                  "D_2_conflict_damages/lack_of_space_inside_shelter","D_2_conflict_damages/lack_of_insulation_from_cold_heat",
                  "D_2_conflict_damages/limited_ventilation_no_air_circulation","D_2_conflict_damages/leaks_during_rain",
                  "D_2_conflict_damages/unable_to_lock_the_shelter","D_2_conflict_damages/lack_of_lighting_inside_or_outside_the_shelter")

shelter_3_ls <- c("D_15_utility_services_interruption/central_heating","D_15_utility_services_interruption/sewage",
                  "D_15_utility_services_interruption/centralized_hot_water_supply","D_15_utility_services_interruption/centralized_cold_water_supply",
                  "D_15_utility_services_interruption/mains_electricity","D_15_utility_services_interruption/centralized_gas")


shelter_4_ls <- c("D_9_missing_nfi/winter_jacket","D_9_missing_nfi/winter_boots","D_9_missing_nfi/winter_clothes",
                  "D_9_missing_nfi/winter_underwear","D_9_missing_nfi/item_mattress","D_9_missing_nfi/item_bedsheets",
                  "D_9_missing_nfi/item_towel_set","D_9_missing_nfi/item_blanket","D_9_missing_nfi/kitchen_utensils",
                  "D_9_missing_nfi/powerbank_lamps")

shelter_4_ls_ext <- c("D_9_missing_nfi/winter_jacket","D_9_missing_nfi/winter_boots","D_9_missing_nfi/winter_clothes",
                      "D_9_missing_nfi/winter_underwear")


data.list$main <- data.list$main %>% 
  mutate(
    crit_shelternfi_1 = case_when(
      rowSums(across(shelter_1_ls, .fns = as.numeric), na.rm = T) >=4 | 
        as.numeric(`D_3_living_conditions_issues/unable_to_keep_warm_or_cool`) ==1 ~ 4,
      rowSums(across(shelter_1_ls, .fns = as.numeric), na.rm = T) ==3 ~ 3,
      rowSums(across(shelter_1_ls, .fns = as.numeric), na.rm = T) %in% c(1,2) ~ 2,
      as.numeric(`D_3_living_conditions_issues/none`) == 1 ~ 1,  
        (as.numeric(`D_3_living_conditions_issues/prefer_not_to_answer`) == 1 |
        as.numeric(`D_3_living_conditions_issues/other`) ==1) ~ NA,
      TRUE ~ NA_real_
    ),
    crit_shelternfi_2 = case_when(
      as.numeric(`D_2_conflict_damages/total_collapse_or_shelter`)==1 ~ 5,
      rowSums(across(shelter_2_ls, .fns = as.numeric), na.rm = T) >=4 | 
        as.numeric(`D_2_conflict_damages/major_damage_to_roof_with_risk_of_collapse`) == 1 ~ 4,
      rowSums(across(shelter_2_ls, .fns = as.numeric), na.rm = T) %in% c(2,3) | 
        as.numeric(`D_2_conflict_damages/damage_to_windows_and_or_doors`) == 1  ~ 3,
      rowSums(across(shelter_2_ls, .fns = as.numeric), na.rm = T) == 1  ~ 2,
      as.numeric(`D_2_conflict_damages/no_damage_or_noticeable_issue`) == 1 ~ 1 ,
        (as.numeric(`D_2_conflict_damages/dont_know`) == 1 |  as.numeric(`D_2_conflict_damages/prefer_not_to_answer`) == 1 | 
                 as.numeric(`D_2_conflict_damages/other`) == 1) ~ NA, ## CHANGED
      TRUE ~ NA_real_
    ),
    crit_shelternfi_3 = case_when(
      D_14_main_heating_source %in% c('no_heating') | (D_14_main_heating_source %in% c('central_heating','electricity','centralized_gas','individual_gas') & 
                                                         rowSums(across(shelter_3_ls, .fns = as.numeric), na.rm = T) >=4 ) ~ 4,
      
      D_14_main_heating_source %in% c('central_heating','electricity','centralized_gas','individual_gas') & 
        rowSums(across(shelter_3_ls, .fns = as.numeric), na.rm = T) >=2 ~ 3,
      
      D_14_main_heating_source %in% c('central_heating','electricity','centralized_gas','individual_gas') & 
        rowSums(across(shelter_3_ls, .fns = as.numeric), na.rm = T) ==1 ~ 2,
      
      (D_14_main_heating_source %in% c('central_heating','electricity','centralized_gas','individual_gas') & 
        (as.numeric(`D_15_utility_services_interruption/no_interruptions_experienced`) ==1 | 
            as.numeric(`D_15_utility_services_interruption/wired_internet`) == 1)) ~ 1, 
        D_14_main_heating_source %in% c('wood','coal','briquettes_coal','briquettes_not_coal') ~ 1,
         D_14_main_heating_source %in% c('dont_know','other') |
                 as.numeric(`D_15_utility_services_interruption/dont_know`) == 1 | 
                 as.numeric(`D_15_utility_services_interruption/prefer_not_to_answer`) == 1 ~ NA, ## CHANGED
      TRUE ~ NA_real_
      ),
    crit_shelternfi_4 = case_when(
      rowSums(across(shelter_4_ls, .fns = as.numeric), na.rm = T)>=7 |
        rowSums(across(shelter_4_ls_ext, .fns = as.numeric), na.rm = T) ==4 |
        ( as.numeric(`D_9_missing_nfi/heating_appliances_fuel_coal_gas`)==1 &
            as.numeric(`D_9_missing_nfi/fuel_for_heating_coal_firewood_liquid_gas`)==1) ~ 4,
      
      rowSums(across(shelter_4_ls, .fns = as.numeric), na.rm = T)>= 6 |  
        as.numeric(`D_9_missing_nfi/heating_appliances_fuel_coal_gas`)==1 |
                     as.numeric(`D_9_missing_nfi/fuel_for_heating_coal_firewood_liquid_gas`)==1 ~ 3,
      
      rowSums(across(shelter_4_ls, .fns = as.numeric), na.rm = T) >= 1  ~ 2,
      as.numeric(`D_9_missing_nfi/none`)==1 ~ 1, 
        (as.numeric(`D_9_missing_nfi/prefer_not_to_answer`)==1 |  as.numeric(`D_9_missing_nfi/other`) == 1 | 
                 as.numeric(`D_9_missing_nfi/dont_know`) ==1) ~ NA, ## CHANGED
      TRUE ~ NA_real_
    )
  )




