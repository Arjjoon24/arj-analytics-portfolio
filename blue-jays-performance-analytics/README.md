![Cover](assets/bluejays_cover.png)

# ⚾ Blue Jays Performance Analytics

End-to-end analysis of the **Toronto Blue Jays** using **SQL + Python (pandas/matplotlib)**. This project explores player trends, bullpen strength, lineup efficiency, attendance patterns, and game-level outcomes, and presents the findings in a clean web page (`index.html`) with exportable charts.

---

## 🎯 Objectives / Key Questions
- Which lineups generate the most runs per game and why?  
- How does bullpen usage impact late-inning run prevention?  
- Which players are the biggest drivers of win probability swings?  
- How do performance patterns change vs. division rivals?  
- Do home attendance levels move with performance streaks and marquee series?  

---

## 🛠 Tools & Methods
- **SQL** — extract and aggregate player/game stats for season trends  
- **Python (pandas, matplotlib)** — clean data and generate visuals  
- **HTML/CSS** — polished presentation page for a recruiter-friendly view  

---

## 📊 Visuals

### Batting Average – Top Hitters
![Batting Average](assets/chart1_batting_avg.png)

### Home Run Leaders
![Home Run Leaders](assets/chart2_hr_leaders.png)

### Pitcher Strikeouts – Rotation & Bullpen
![Pitcher Strikeouts](assets/chart3_pitcher_strikeouts.png)

### Runs Scored by Month
![Runs by Month](assets/chart4_runs_by_month.png)

### Attendance Trend
![Attendance](assets/chart5_attendance.png)

### Team Comparison – Division Snapshot
![Team Comparison](assets/chart6_team_comparison.png)

---

## 🔑 Highlights / Early Insights
- **Contact + power balance drives scoring:** High-contact hitters keep innings alive, while HR bursts (see *Home Run Leaders*) turn them into big run innings — visible in *Runs by Month*.  
- **Strikeout arms stabilize games:** Relief pitchers with strong K-rates limit damage in late innings (*Pitcher Strikeouts*), preserving win probability.  
- **Run production rhythm:** Monthly scoring shows peaks when lineups are consistent, troughs when contact or power slumps — a key factor for team momentum.  
- **Rivalry pressure shows gaps:** Division comparisons highlight where Jays match rivals (pitching) and where they lag (sustained scoring).  
- **Fan demand mirrors performance:** Attendance spikes line up with win streaks and marquee rival series, and dip after quiet offensive stretches.  

---

## ✅ Answers to the Key Questions (Based on Mock Data)

1. **Which lineups generate the most runs per game and why?**  
   Lineups that stack high-contact hitters ahead of power bats produce the most runs. Consistency is shown in *Batting Average – Top Hitters*, while bursts in *Home Run Leaders* convert those baserunners into runs, reflected in *Runs by Month*.  

2. **How does bullpen usage impact late-inning run prevention?**  
   Stability improves when high-strikeout relievers are used consistently. *Pitcher Strikeouts – Rotation & Bullpen* highlights arms that minimize scoring threats and protect narrow leads.  

3. **Which players are the biggest drivers of win probability swings?**  
   Players with strong on-base skills and power output show the largest WPA impact. *Batting Average* keeps innings alive, while *Home Run Leaders* shows who delivers decisive swings.  

4. **How do performance patterns change vs. division rivals?**  
   The *Team Comparison* chart shows Jays pitching compares well in strikeouts but offensive output lags behind rivals, underlining why close games can tilt away in the standings.  

5. **Do home attendance levels move with performance streaks and marquee series?**  
   Yes. *Attendance Trend* peaks line up with higher-scoring months in *Runs by Month* and rivalry series in *Team Comparison*. This suggests fan demand rises when performance is strong and opponents are marquee, and dips during quieter stretches.  

---

## 📂 Project Structure  
```
blue-jays-performance-analytics/
│── assets/
│ ├── bluejays_cover.png
│ ├── chart1_batting_avg.png
│ ├── chart2_hr_leaders.png
│ ├── chart3_pitcher_strikeouts.png
│ ├── chart4_runs_by_month.png
│ ├── chart5_attendance.png
│ └── chart6_team_comparison.png
│── index.html # Showcase page with charts & summary
│── README.md # This file
│── SQL_Queries.sql # Reproducible query set
│── BlueJays_CaseStudy_MockData.xlsx
```

---

## ▶️ How to View
- Open `index.html` in this folder (or via your GitHub Pages link) to see a clean, scrollable summary with all six charts.  

---

## ✨ Notes
Built from scratch (SQL ➜ Python ➜ HTML/CSS). Designed to demonstrate an **end-to-end analytics workflow** and clear storytelling for decision makers.  
