import pandas as pd
from ydata_profiling import ProfileReport

df_bank = pd.read_csv('bank.csv')
df_cars = pd.read_csv('car_prices.csv')

profile_bank = ProfileReport(df_bank, title="Profiling Report Bank", explorative=True)
profile_cars = ProfileReport(df_cars, title="Profiling Report Cars", explorative=True)

profile_bank.to_file('report_bank_html')
profile_cars.to_file('report_cars_html')


