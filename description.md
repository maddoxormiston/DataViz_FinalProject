## Description

For my SYE, I used data made public from New York's Maternity Information Law to investigate county-level relationships with demographics. However, this data was available at a hospital level spanning 10 years. I wanted to use the data in a different way so as to create visualizations across time for the variables. In total, there are 31 measures that were recorded. There are 146 hospitals who reported their data and the data is from 2008 to 2017.
The Leaflets created employ the ideas of good mapping visualizations made interactive. The aspect ratio appropriately portrays the map of New York state and the popups show the data selected. Because maps do not do a good job at showing data when time is involved, the second tab makes use of an additional line plot to demonstrate the changes in usage of measures throughout the years. This tab allows the user to investigate both hospitals of interest and trendlines of interest. The choice to leave the data as raw counts instead of percentages allows for variability to be seen in the data. Percentages would not allow for a user to understand sample sizes and could lead to misleading visualizations.
The icons on the Leaflets being changed to a hospital logo makes it more obvious to the user what they are looking at. Minimal themes used on the graphs allow for little distraction from investigation. The scatterplot tabs have clear instructions on how to use each graph and what relationships to investigate. Plotly makes them interactive and to show the name of the hospital hovered on and the county it is in. Points colored by county show trends within certain counties, such as the counties around new York City having higher values for all measures. A Loess model for the trendlines allows the user to see any nonlinear relationships between variables or years. No visualization excludes any data and there is nothing misleading about the graph limits or scales.
While I worked with the data that was public, I would love to expand this project to all states in the US to see if there are any in particular that have over- or under-use of certain measures. A large limitation to this data is that it relies on hospitals to report their own data. Because of this, there are many hospitals that are not represented in the app and might have interesting trends to look at.