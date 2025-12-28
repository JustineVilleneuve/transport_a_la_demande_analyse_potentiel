import pandas as pd

freq_details = pd.read_csv(r"C:\Users\justi\OneDrive\Je-deviens-Data-Analyst\JEDHA\00_Certif\bloc_6\02_cleaning_python\star_freq_details.csv")

freq_details_sample = freq_details.sample(n = 100_000, random_state = 42)

freq_details_sample.to_csv(
    "freq_details_sample.csv",
    index = False
)