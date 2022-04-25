## March 21

Looked at available data sets for public health data. Looked at preexisting shiny apps on rstudio to get ideas.

## March 23 Beginning of Class

Decided on project idea. Pulled data and previous wrangling code.

## March 23 End of Class

imported data set with longitude and latitude data for all hospitals, filled in missing or incorrect values and tidied data a bit. created leaflet map that displays where hospitals are and creates popup for hospital name, troubleshot a problem where markers weren't appearing. wrote down ideas that came out of classmate conversation for shiny tabs

## March 28 Beginning of Class

Worked on creating a leaflet visualization that changes based on which variable is selected that will be used in the shiny app. Created static scatterplots that change based on variable/years selected to later be used in shiny app. Started building ui for shiny and got stuck trying to figure out how to have the sidebar change for different tabs on app.

## March 28 End of Class

Created a static line plot for the second tab, finished ui side of shiny app and began working on server side, made sure state data was not in full data set.

## March 30 Beginning of Class

Began creating outputs on the server side of the app. Got stuck for a while figuring out how to reference variables in my reactive data set for the Leaflet tab. Started working on the line plot tab as well.

## March 30 End of Class

Figured out how to display both leaflet and line plot tabs. Working to create a reactive line plot to display a hospital in a different color when its marker is clicked on in Leaflet.

## April 4 Beginning of Class

Tried to make line plot reactive to an additional Leaflet on line plot tab, got very stuck and ended up just allowing user to filter by county. Added plots to both scatterplot tabs, have problems with first scatterplot tab that need to be worked through. Added submit button to first tab.

## April 4 End of Class

Got second scatterplot tab to be working fine. Ran into issue where lon/lat coordinates for many hospitals were the same when they shouldn't be so fixed those by hand. Figured out (with Emil's help) why plotly version of second scatterplot wasn't working. Added leaflet with hospital names to line plot tab to continue working on reactive line plot. Need to continue on line plot tab and figure out why first scatterplot tab isn't working.

## April 6 Beginning of Class

Worked on figuring out error for first scatterplot ("Error in UseMethod: no applicable method for 'filter' applied to an object of class "c('reactiveExpr', 'reactive', 'function')""). Tried many ways to fix but haven't figured it out yet. Tried to make reactive lineplot from leaflet click, have some more errors to work out on that.

## April 6 End of Class

Figured out error on first scatterplot, working through reactive line plot. Stuck where variable does not change based on input, no red line shows when using singular observation, and no data stored in `map_marker_click`. Also need to fix a few hospitals that have incorrect lat/lon.

## April 11 Beginning of Class

Figured out map marker click tab! Fixed incorrect lat/lon values for some hospitals in hospitalsgeocode.csv. Line plot tab only works with submit button so need to fix that. 

## April 18 Beginning of Class

Worked on some theme/visualization parts of the app. Having a difficult time figuring out how to make first and second tabs work without submit button on either tab, also want to change icon markers in leaflets.

## April 18 End of Class

Figured out app without submit button, working on creating custom icons for the leaflets. Also want to have a line plot show up on line tab before user selects a hospital - need either base line plot or line plot with hospital already selected.

## April 20 Beginning of Class

Figured out custom icons! Need to work on line plot that appears when tab is opened.

## April 20 End of Class

Spent a while figuring out how to get Git back on R after a computer update, figured that out and now working on line plot tab.

## April 25 Beginning of Class

Working on line plot tab. Tried a few different filter options and some if and if/else statements.