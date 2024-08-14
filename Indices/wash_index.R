


improved_sources_ls <- c('F_1_main_source_drinking_water/piped_water_in_household','F_1_main_source_drinking_water/public_tap_standpipe',
                         'F_1_main_source_drinking_water/personal_protected_borehole_or_well_private_access','F_1_main_source_drinking_water/public_potected_well_or_boreholes_shared_access',
                         'F_1_main_source_drinking_water/trucked_in_water_by_municipality_truck_with_a_tank','F_1_main_source_drinking_water/trucked_in_water_private_paid_service_truck_with_a_tank',
                         'F_1_main_source_drinking_water/water_kiosk','F_1_main_source_drinking_water/bottled_water')

unimproved_sources_ls_extr <- c('F_1_main_source_drinking_water/open_uncovered_well','F_1_main_source_drinking_water/rainwater_collection',
                                     'F_1_main_source_drinking_water/river_pond_or_lake_water')


improved_sanitation_ls <- c('F_8_sanitation_facility/flush_to_piped_sewer_system','F_8_sanitation_facility/flush_to_septic_tank',
                            'F_8_sanitation_facility/flush_to_pit_latrine','F_8_sanitation_facility/pit_latrine_with_slab',
                            'F_8_sanitation_facility/composting_toilet')

unimproved_sanitation_ls <- c('F_8_sanitation_facility/flush_to_open_drain','F_8_sanitation_facility/flush_to_elsewhere',
                              'F_8_sanitation_facility/flush_to_dont_know_where','F_8_sanitation_facility/pit_latrine_without_slab_open_pit',
                              'F_8_sanitation_facility/plastic_bag','F_8_sanitation_facility/bucket','F_8_sanitation_facility/hanging_toilet_hanging_latrine')

water_treatment_ls <- c('F_3_water_treatment/yes_with_a_filter_at_the_tap_connected_to_piped_water',
                        'F_3_water_treatment/yes_with_a_filter_we_fill_ceramic_candle_etc','F_3_water_treatment/yes_by_letting_it_settle',
                        'F_3_water_treatment/yes_by_boiling','F_3_water_treatment/yes_by_adding_bleach_or_a_pill','F_3_water_treatment/other')

water_treatment_stress_ls <- c('F_3_water_treatment/yes_with_a_filter_at_the_tap_connected_to_piped_water',
                        'F_3_water_treatment/yes_with_a_filter_we_fill_ceramic_candle_etc','F_3_water_treatment/yes_by_letting_it_settle',
                        'F_3_water_treatment/yes_by_boiling','F_3_water_treatment/yes_by_adding_bleach_or_a_pill','F_3_water_treatment/no_no_need_to_treat_the_water','F_3_water_treatment/other')


water_treatment_extreme_ls <- c('F_3_water_treatment/no_cant_find_in_market','F_3_water_treatment/no_cant_afford_to')

water_sufficiency_list <- c('F_7_water_sufficiency/drinking','F_7_water_sufficiency/cooking','F_7_water_sufficiency/personal_hygiene_washing_or_bathing',
                            'F_7_water_sufficiency/other_domestic_purposes_cleaning_house_floor')


hygiene_items_list <- c('F_18_hygiene_items_availability_soap/soap','F_18_hygiene_items_availability_soap/feminine_hygiene_products',
                        'F_18_hygiene_items_availability_soap/baby_diapers','F_18_hygiene_items_availability_soap/toothpaste',
                        'F_18_hygiene_items_availability_soap/toothbrush','F_18_hygiene_items_availability_soap/adult_diapers',
                        'F_18_hygiene_items_availability_soap/cloth_washing_soap','F_18_hygiene_items_availability_soap/shampoo',
                        'F_18_hygiene_items_availability_soap/water_containers_jurcans_bottle_tank','F_18_hygiene_items_availability_soap/water_treatment_chemicals_eg_chlorine_aquatabs',
                        'F_18_hygiene_items_availability_soap/water_treatments_equipment_eg_filters')

data.list$main <- data.list$main %>% 
  mutate(
    crit_wash_1 = case_when( ## CHANGED
    (rowSums(across(unimproved_sources_ls_extr, .fns = as.numeric), na.rm = T)>0 &
      F_2_water_safety %in% c('no') &
      rowSums(across(water_treatment_extreme_ls, .fns = as.numeric), na.rm = T)>0) |
      (rowSums(across(unimproved_sources_ls_extr, .fns = as.numeric), na.rm = T)>0 & 
      F_2_water_safety %in% c('yes_but_not_for_long_periods_of_time','yes_but_not_always') &
      rowSums(across(water_treatment_extreme_ls, .fns = as.numeric), na.rm = T)>0)~ 5, ##changed
    
    (rowSums(across(unimproved_sources_ls_extr, .fns = as.numeric), na.rm = T)>0 & 
      F_2_water_safety %in% c('no') &
      rowSums(across(water_treatment_ls, .fns = as.numeric), na.rm = T)>0) |
      (rowSums(across(unimproved_sources_ls_extr, .fns = as.numeric), na.rm = T)>0 & 
         F_2_water_safety %in% c('yes')) | 
      (rowSums(across(unimproved_sources_ls_extr, .fns = as.numeric), na.rm = T)>0 &
         F_2_water_safety %in% c('yes_but_not_for_long_periods_of_time','yes_but_not_always') &
         rowSums(across(water_treatment_ls, .fns = as.numeric), na.rm = T)>0) |
      (rowSums(across(unimproved_sources_ls_extr, .fns = as.numeric), na.rm = T)>0 &
         F_2_water_safety %in% c('no') &
         rowSums(across(water_treatment_ls, .fns = as.numeric), na.rm = T)>0)~ 4,##changed
    
    rowSums(across(improved_sources_ls, .fns = as.numeric), na.rm = T)>0 &
      ((as.numeric(F_5_1_fetch_water_time_estimated) %_>_% 30) | 
         (F_5_fetch_water_time == "dont_know" & 
            (F_6_fetch_water_time_dont_know %in% c("more_than_30_minutes_but_less_than_1_hour","more_than_1_hour"))))~ 3,
     # & 
     #  F_2_water_safety %in% c('yes')) |
     #  (rowSums(across(improved_sources_ls, .fns = as.numeric), na.rm = T)>0 &
     #  ((as.numeric(F_5_1_fetch_water_time_estimated) %_>_% 30)|
     #     (F_5_fetch_water_time == "dont_know" & (F_6_fetch_water_time_dont_know %in% c("more_than_30_minutes_but_less_than_1_hour","more_than_1_hour"))))& 
     #  F_2_water_safety %in% c('yes_but_not_for_long_periods_of_time','yes_but_not_always','no')&
     #  rowSums(across(water_treatment_stress_ls, .fns = as.numeric), na.rm = T)>0)##changed
     # 
    rowSums(across(improved_sources_ls, .fns = as.numeric), na.rm = T)>0 &
      ((as.numeric(F_5_1_fetch_water_time_estimated) %_<=_% 30) |
         (F_5_fetch_water_time == "dont_know" & (F_6_fetch_water_time_dont_know %in% c("30_minutes_or_less","dont_know"))))| 
       ((as.numeric(`F_1_main_source_drinking_water/piped_water_in_household`) == 1 | 
           F_5_fetch_water_time == "members_do_not_collect") & 
          F_2_water_safety %in% c('yes_but_not_for_long_periods_of_time','yes_but_not_always','no'))~ 2,
     # & 
     #  F_2_water_safety %in% c('yes')) |
     # (rowSums(across(improved_sources_ls, .fns = as.numeric), na.rm = T)>0 &
     #    ((as.numeric(F_5_1_fetch_water_time_estimated) %_<=_% 30) |
     #    (F_5_fetch_water_time == "dont_know" & (F_6_fetch_water_time_dont_know %in% c("30_minutes_or_less")))) & 
     #    F_2_water_safety %in% c('yes_but_not_for_long_periods_of_time','yes_but_not_always','no') &
     #    rowSums(across(water_treatment_stress_ls, .fns = as.numeric), na.rm = T)>0)  ##changed
   
   (rowSums(across(improved_sources_ls, .fns = as.numeric), na.rm = T)>0 &
     (as.numeric(`F_1_main_source_drinking_water/piped_water_in_household`) == 1 |
        F_5_fetch_water_time == "members_do_not_collect") &
     F_2_water_safety %in% c('yes')) ~ 1, 
     ( as.numeric(`F_1_main_source_drinking_water/other`) == 1 |  as.numeric(`F_1_main_source_drinking_water/dont_know`) ==1 |
         as.numeric(`F_3_water_treatment/dont_know`) == 1 |  as.numeric(`F_3_water_treatment/prefer_not_to_answer`) == 1) ~ NA,
   TRUE ~ NA_real_
  ),
  crit_wash_2 = case_when(
    F_4_insufficient_drinking_water == 'always_more_than_20_times' ~ 5,
    F_4_insufficient_drinking_water == 'often_11_20_times' ~ 4,
    F_4_insufficient_drinking_water == 'sometimes_3_10_times' ~ 3,
    F_4_insufficient_drinking_water == 'rarely_1_2_times' ~ 2,
    F_4_insufficient_drinking_water == 'never_0_times' ~ 1,
    F_4_insufficient_drinking_water == 'dont_know' ~ NA,
    TRUE ~ NA_real_
  ),
  crit_wash_3 = case_when(
    as.numeric(`F_8_sanitation_facility/no_facility_bush_field`) == 1 ~ 5,
    
    rowSums(across(unimproved_sanitation_ls, .fns = as.numeric), na.rm = T) %_>_% 0  | ( 
      rowSums(across(improved_sanitation_ls, .fns = as.numeric), na.rm = T) & 
        F_9_shared_sanitation_facility == 'yes') &
      as.numeric(F_10_shared_sanitation_facility_number) %_>=_% 17  ~4,
    
    rowSums(across(improved_sanitation_ls, .fns = as.numeric), na.rm = T) > 0 & F_9_shared_sanitation_facility == 'yes' &
      as.numeric(F_10_shared_sanitation_facility_number) %_>=_% 6 & as.numeric(F_10_shared_sanitation_facility_number) %_<=_% 16  ~ 3,
    
    rowSums(across(improved_sanitation_ls, .fns = as.numeric), na.rm = T) > 0 & F_9_shared_sanitation_facility == 'yes' 
    &  as.numeric(F_10_shared_sanitation_facility_number) %_<_% 6 ~ 2,
    
    rowSums(across(improved_sanitation_ls, .fns = as.numeric), na.rm = T) > 0 & F_9_shared_sanitation_facility  == 'no'  ~ 1,
      F_9_shared_sanitation_facility  %in% c('prefer_not_to_answer','dont_know') | 
      (as.numeric(`F_8_sanitation_facility/other`) == 1) ~  NA,
    TRUE ~ NA_real_
  ),
  crit_wash_4 = case_when(
    F_17_handwashing_facility_availability %in% c( 'no_handwashing_facility','yes_handwashing_facility_with_only_soap',
                                                 'yes_handwashing_facility_with_only_water' ,'yes_handwashing_facility_without_water_and_soap') ~ 2,
    F_17_handwashing_facility_availability == 'yes_handwashing_facility_with_water_and_soap' ~ 1,
    F_17_handwashing_facility_availability == 'dont_know' ~ NA,
    TRUE ~ NA_real_
  )
  )

