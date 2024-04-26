import requests
import schedule
import time

def get_weather_data():
    locations = ['Zurich', 'London', 'Miami', 'Tokyo', 'Singapore']
    temperatures = {}

    for location in locations:
        try:
            response = requests.get(f'https://wttr.in/{location}?format=%C+%t')
            weather_condition, temperature = response.text.strip().split('+')
            temperatures[location] = (weather_condition, temperature)
        except requests.exceptions.RequestException as e:
            print(f'Weather report: not found for {location}')
            temperatures[location] = ('N/A', 'N/A')

    for location, (weather_condition, temperature) in temperatures.items():
        print(f'Weather condition in {location}: {weather_condition}, Temperature: {temperature}°C')

# Schedule the task
schedule.every().hour.do(get_weather_data)

# Keep the script running
while True:
    schedule.run_pending()
    time.sleep(1)
