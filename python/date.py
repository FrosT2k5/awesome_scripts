from datetime import datetime, timedelta

# Python script to calculate whatsapp streak and days using chat export
# still under development

def read_dates_from_file(file_path):
    with open(file_path, 'r') as file:
        dates = [datetime.strptime(line.strip(), '%d/%m/%y') for line in file]
    return dates

def find_missing_dates(dates):
    missing_dates = []
    max_consecutive_days = 0
    current_streak = 1
    max_start_date = dates[0]
    max_end_date = dates[0]
    current_start_date = dates[0]
    
    for i in range(1, len(dates)):
        diff = (dates[i] - dates[i-1]).days
        if diff == 1:
            current_streak += 1
        else:
            if current_streak > max_consecutive_days:
                max_consecutive_days = current_streak
                max_start_date = current_start_date
                max_end_date = dates[i-1]
            current_streak = 1
            current_start_date = dates[i]

            for j in range(1, diff):
                missing_date = dates[i-1] + timedelta(days=j)
                missing_dates.append(missing_date.strftime('%d/%m/%y'))
    
    # Check the last streak
    if current_streak > max_consecutive_days:
        max_consecutive_days = current_streak
        max_start_date = current_start_date
        max_end_date = dates[-1]
    
    return missing_dates, max_consecutive_days, max_start_date, max_end_date

def main(file_path):
    dates = read_dates_from_file(file_path)
    missing_dates, max_consecutive_days, max_start_date, max_end_date = find_missing_dates(dates)
    
    if missing_dates:
        print("Missing dates:")
        for date in missing_dates:
            print(date)
    else:
        print("No missing dates found.")
    
    print(f"Highest number of consecutive days: {max_consecutive_days}")
    print(f"Start date of the longest streak: {max_start_date.strftime('%d/%m/%y')}")
    print(f"End date of the longest streak: {max_end_date.strftime('%d/%m/%y')}")

# Replace 'path_to_your_file.txt' with the actual file path
file_path = 'datesfinal.txt'
main(file_path)
