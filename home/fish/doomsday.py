#!/usr/bin/env python3
from datetime import date
import random
import calendar

start_date = date.today().replace(day=1, month=1, year=1900)
end_date = date.today().replace(day=31, month=12, year=2099)

print("\033[2J\033[H")
print("\033[33mDoomsday Test: Get 3 correct in a row to pass")
print()
streak = 0
while streak < 3:
    random_day = date.fromordinal(random.randint(start_date.toordinal(), end_date.toordinal()))

    if random.randint(0, 1) == 0:
        print(random_day.strftime("\033[37m%B %-d %Y"))
    else:
        print(random_day.strftime("\033[37m%d/%m/%Y"))

    answer = random_day.strftime("%A").lower()

    response = ''
    while len(response.strip()) == 0:
        response = input().lower()

    if len(response) != 0 and response not in ('t', 's') and answer.startswith(response):
        streak += 1
        print("\033[92mCorrect! Streak:", streak)
    else:
        streak = 0
        print("\033[91mIncorrect (answer was {}), streak reset".format(answer))
    print()
print('\033[0m')
