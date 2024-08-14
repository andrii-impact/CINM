setwd(dirname(rstudioapi::getActiveDocumentContext()$path))


## SET FILENAMES AND OTHER STRINGS  --------------------------------------------

# strings <- c(
#   dataset.name = "MSNI Ukraine 2023 final overlaps",      # provide a full name for the title of output documents (e.g. "[POL] Post-Distribution Monitoring")
#   dataset.name.short = "MSNI UKR final overlaps",   # provide a short name for filenames of output documents (e.g. "POL_PDM")
#   dataset.date = "September 2023",       # this string is only used for creating titles for output documents
#   out_date = stringr::str_sub(stringr::str_remove_all(Sys.Date(), '-'), 3),      # this one is appended to the end of filenames,
#   filename.data = "data/MSNA2403_2024_final_anonymized_data_19July2024_weighted.xlsx",      # the filename of your data for analysis
#   # filename.data.labeled = "data/???_labeled.xlsx",      # same as above, but ending with '_labeled'
#   filename.tool = "resources/MSNA_2023_Questionnaire_Final_CATI_cleaned.xlsx",  
#   filename.daf.tabular = "resources/UKR_MSNA_MSNI_DAF_inters - Copy.xlsx", # filename of your kobo tool  # filename of your DAP
#   filename.labels.oblasts = 'resources/oblast_name.xlsx'
#   # filename.dap.visual = "resources/???Visual_DAP???.xlsx",      # filename of your visual DAP
# )
# 
# 
# # ADDITIONAL PARAMETERS WHICH MAY NEED TO BE CHANGED
# 
# params  <- c(
#     fix_sheet_names_to_match = "data",     # this should be one of "tool", "data", or "none"
#     combine_folder = "temp/combine/"
# )

## TABULAR  -------------------------------------------------------------------

# rmarkdown::render('analysis_tabular.Rmd',
#                   output_file = paste0("output/", strings['dataset.name.short'], "Tabular_Analysis_", strings['out_date'],".html"))
# cat("\n> tabular analysis completed!")

# ------------------------------------------------------------------------------
#write.xlsx(data.list, "data/UKR2308_MSNA_LSGs_added.xlsx")

