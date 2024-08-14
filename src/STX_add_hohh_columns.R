

hohh_rating <- data.list$hh_members %>%
  mutate(A_9_1_money_rank = ifelse(A_9_1_hohh_decision_making_money == "yes", 0.5, 0),
         A_9_2_healthcare_rank = ifelse(A_9_2_hohh_decision_making_healthcare == "yes", 0.3, 0),
         A_9_3_migration_rank = ifelse(A_9_3_hohh_decision_making_migration == "yes", 0.2, 0),
         hohh_rating = rowSums(across(c("A_9_1_money_rank","A_9_2_healthcare_rank","A_9_3_migration_rank")),na.rm = TRUE))

max_hohh_rating <- hohh_rating %>%
  select(c("uuid","hohh_rating")) %>%
  group_by(uuid) %>%
  summarise(max_hohh_rating = max(hohh_rating))

hohh_rating <- hohh_rating %>% 
  left_join(max_hohh_rating,by="uuid") %>%
  mutate(is_hohh = ifelse(hohh_rating %==% max_hohh_rating, 1, 0))



hohh_sex <- data.list$main%>%
  filter(A_3_respondent_hohh == "yes") %>%
  select(c("uuid","A_2_respondent_sex")) %>%
  right_join(select(data.list$main,uuid),by="uuid")

multiple_hohh_sex <- hohh_rating %>%
  select(c("uuid","is_hohh","A_16_hh_member_sex")) %>%
  pivot_wider(names_from = "A_16_hh_member_sex", values_from = "is_hohh", values_fill = 0, values_fn=sum)

hohh_sex <- hohh_sex %>%
  left_join(multiple_hohh_sex, by="uuid") %>%
  mutate(hohh_sex = case_when(!is.na(A_2_respondent_sex) & (A_2_respondent_sex == "male") ~ "Male",
                              !is.na(A_2_respondent_sex) & (A_2_respondent_sex == "female") ~ "Female",
                              female > 0 & male == 0 ~ "Female",
                              male > 0 & female == 0 ~ "Male",
                              TRUE ~ "unknown"))



multiple_hohh_age_60 <- hohh_rating %>%
  mutate(age_group_60 = case_when(A_14_hh_member_age %_<_% 18 ~ "<18",
                                  A_14_hh_member_age %_<=_% 59 ~ "18-59",
                                  A_14_hh_member_age %_>=_% 60 ~ "60+",
                                  TRUE ~ NA)) %>%
  select(c("uuid","is_hohh","age_group_60")) %>%
  pivot_wider(names_from = "age_group_60", values_from = "is_hohh", values_fill = 0, values_fn=sum)

hohh_age_group_60 <- data.list$main %>%
  filter(A_3_respondent_hohh == "yes") %>%
  select(c("uuid","A_1_respondent_age")) %>%
  right_join(select(data.list$main,uuid),by="uuid") %>%
  left_join(multiple_hohh_age_60, by="uuid") %>%
  mutate(hohh_age = case_when((!is.na(A_1_respondent_age)) & (A_1_respondent_age %_<=_% 59) ~ "18-59 y.o.",
                              (!is.na(A_1_respondent_age))  ~ "60+ y.o.",
                              (`18-59` > 0) & (`60+` == 0) ~ "18-59 y.o.",
                              (`60+` > 0) & (`18-59` == 0) ~ "60+ y.o.",
                              TRUE ~ "unknown"
  ))

hoh_char <- hohh_sex %>% 
  select(uuid,hohh_sex) %>% 
  inner_join(hohh_age_group_60 %>% 
               select(uuid, hohh_age)) %>% 
  tibble()

data.list$main <- inner_join(data.list$main,hoh_char)

