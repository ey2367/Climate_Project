# Lesotho Climate Project
The purpose of this project is to create an RShiny dashbaord to help the government of Lesotho make more informed climate decisions.

**Graphs**
1. The Gantt Chart ('<Gantt Chart/gantt.R>')
- This Gantt Chart provides a visual representation of the TIMELINE and FORCAST, aiding decision-makers in understanding Lesotho's drought conditions.
    [To use this chart, you'll need to download the 'all1.xlsx' and 'left.xlsx' files]
2. Line Graph ('<Graphs/Line Graph (Rain Forecast & History).R>')
- The Line Graph displays both rain forecast and historical data for Lesotho, offering insights into precipitation trends.
3. Population in Lesotho by District ('<Graphs/Population by district (Bar).R>')
- This graph illustrates the population distribution across districts in Lesotho.
    [need to download the 'lesotho_pop_short1.csv' file]
4. Food Insecurity Graph ('<Graphs/Food Insecuirty of Lesotho.R>')
- The Food Insecurity Graph provides an overview of the food security situation in Lesotho, helping to assess and address issues related to food security. 
    [need to download the 'FoodSecurity Data.csv' file]
    
**Dashboard**
1. All files not included in “Gantt Chart” & “Graphs” files are map sources;
2. Trigger dashboard map;
3. Break up population numbers into 5 sections and assign 5 colors;
4. Show trigger according to severity and months.