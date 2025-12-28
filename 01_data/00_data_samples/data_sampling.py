import pandas as pd

# stop_times sample
stop_times = pd.read_csv(r"C:\Users\justi\OneDrive\Je-deviens-Data-Analyst\JEDHA\00_Certif\bloc_6\01_data\01_data_bronze\GTFS_STAR_BUS_METRO_EN_COURS\stop_times.txt")

stop_times_sample = stop_times.sample(n=100_000, random_state=42)

stop_times_sample.to_csv(
    "stop_times_sample.csv",
    index = False
)

# freq details sample
freq = pd.read_csv(r"C:\Users\justi\OneDrive\Je-deviens-Data-Analyst\JEDHA\00_Certif\bloc_6\01_data\01_data_bronze\freq_detail_data\CLO.FREQ.EXTRACT.FREQ-DETAIL_202207.csv")

freq_sample = freq.sample(n=100_000, random_state=42)

freq_sample.to_csv(
    "CLO.FREQ.EXTRACT.FREQ-DETAIL_202207_sample.csv",
    index = False
)

# int_freq_last_year
freq_last_year = pd.read_csv(r"C:\Users\justi\OneDrive\Je-deviens-Data-Analyst\JEDHA\00_Certif\bloc_6\01_data\02_data_silver\int_freq_last_year.csv")

freq_last_year_sample = freq_last_year.sample(n=100_000, random_state=42)

freq_last_year_sample.to_csv(
    "int_freq_last_year_sample.csv",
    index = False
)