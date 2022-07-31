# Offline coding test

## Instructions
- Run the command:
`cat <input> | swift run ElementTask <time>`
    - input - path to the input file. Input data example is provided below. You can use `input.txt` for checking it.
    - time - simulated current time in format **HH:mm**


## Input example
```
30 1 /bin/run_me_daily
45 * /bin/run_me_hourly
* * /bin/run_me_every_minute
* 19 /bin/run_me_sixty_times
```

## Output example
```
1:30 tomorrow - /bin/run_me_daily 
16:45 today - /bin/run_me_hourly 
16:10 today - /bin/run_me_every_minute 
19:00 today - /bin/run_me_sixty_times
```
