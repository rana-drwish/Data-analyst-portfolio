# Bellabeat Smart Device Usage Analysis (Excel-SQL-Tableau)

# Introduction
This case study was completed as part of the Google Data Analytics Professional Certificate. 

# ASK
# Business Task
Analyze FitBit smart device usage data to discover behavioral trends among users,
then apply those insights to the Bellabeat Leaf tracker to guide Bellabeat's marketing strategy.

# Key Questions
-	What are some trends in smart device usage?
-	How could these trends apply to Bellabeat customers?
-	How could these trends help influence Bellabeat's marketing strategy?

# PREPARE
# Data Source
The FitBit Fitness Tracker Dataset was used, obtained from Kaggle

# Files Used
- daily_activity
- Sleep_day
- hourly_steps
- hourly_intensities

# PROCESS
# Tools Used
- Microsoft Excel — data cleaning and formatting
- Microsoft SQL Server (SSMS) — data analysis and querying
- Tableau Public — data visualization and dashboard creation

# Cleaning Steps
-	Removed duplicate rows from all 4 tables (sleep_day had notable duplicates)
-	Fixed date formatting — converted ActivityDate and SleepDay columns to proper DATE format
-	Renamed all column headers to lowercase with underscores for SQL compatibility
-	Added day_of_week column to dailyActivity using Excel TEXT formula
-	Split datetime columns into separate date and hour columns for hourly tables
-	Converted all data to CSV format for MySQL import

# ANALYZE
# Key finding
1	Average daily steps	7,637 steps (below 10,000 recommended)
2	Average daily calories burned	2,303 calories
3	Average sedentary time	991 minutes (~16.5 hours/day)
4	Average sleep duration	6 hours (below 8 hours recommended)
5	Most active day	Tuesday & Saturday (8,125 and 8,152 steps)
6	Least active day	Sunday (6,933 steps)
7	High sedentary users sleep	6 hours vs 8 hours for low sedentary users
8	Sedentary/Low Active users	51.5% of all users


# SHARE
# Visualizations Created in Tableau
•	Key Metrics Overview — KPI table showing avg steps, calories, sedentary minutes
•	User Activity Categories — Pie chart showing distribution of activity levels with percentages
•	Average Steps by Day of Week — Bar chart showing weekly activity patterns
•	Average Sleep vs Time in Bed — Bar chart with 8-hour reference line
•	Sleep Hours: High vs Low Sedentary — Bar chart comparing sleep by sedentary group
•	Steps vs Sleep Quality by User — Scatter plot with trend line and sedentary color coding

# ACT
# Recommendation 
Launch a 'Move More, Sleep Better' Campaign
- Insight:	High sedentary users sleep 2 fewer hours than low sedentary users
- Action:	Market the Leaf tracker as a sleep improvement tool
- Target Audience:	The 51.5% of sedentary/low active users
- Message:	Move more during the day, sleep better at night
- Channel:	Instagram, YouTube, and in-app notifications
  
# CONCLUSION
This analysis reveals that the majority of smart device users are under-active and sleep-deprived. 
With over half of users falling into the sedentary or low-active category, and average sleep well below recommended levels, 
there is a clear opportunity for Bellabeat to position the Leaf tracker as an essential wellness tool.
By targeting these behavioral gaps through personalized notifications, step challenges, and sleep awareness campaigns,
Bellabeat can differentiate itself in the competitive wearables market while genuinely improving users' health outcomes.

<img width="1828" height="699" alt="Tableau Dashboard" src="https://github.com/user-attachments/assets/afd5982a-5f42-4702-83f5-fcee4484261d" />


