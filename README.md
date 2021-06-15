# README

This project is a scheduling grid for technicians and work orders. This project uses three different databases include one about work orders, locations, and technician data. It is then manipulated to create the scheduling grid. 
How to run

      Clone git repo
      cd to lib/tasks
      rake csv_import:location_data 
      rake csv_import:technician_data
      rake csv_import:work_orders_data
      rails db:migrate
      rails s



## Designing
This scheduling grid cannot be structured in terms of a regular table. The Y Axis is time starting from the earlier hour the work orders start from to the latest hour the work orders start from. The X Axis are the different technicians. In each cell, there is information about a corresponding work order including location city, name, starting hour time and price of the work order. If the cell has no work order, users are allowed to click on a button showing how much time between the previous and next work order. If there has not been a previous order, the calculations use the overall earliest work hour hour. If there has not been a next order, the calculations use the latest possible hour which is 1 hour more than the latest work order.

To create a table like grid, rows and columns had to be intrically positioned. The data structure used most were arrays. Each technician had its own array and each element would correspond to a work order at a given hour - the index of the array indicated the hour. In this way, the table structure could be maintained. 

When a user clicks the button, a pop up window will appear showing how much time between the previous and next work order. This mechanism is precomputed with each empty cell rendering a div that contains this data but is hidden. Using javascript, the id is fetched and the appropriate pop up window with the correct time difference will appear.
## Problems during Project
Initially there were issues with how the database and how the tables would be structured and connected. Tables of work orders, locations and technicians are linked together by foreign keys of their corresponding id. In the controller, they are joined so that the data spanning across tables can be used for further manipulation. There were also issues with time and how time would be viewed. Initially, the field was stored as a string, but the string compoment complicated manipulation and calculating time differences. The time zone could impact how the difference was calculated so measures were created to make sure each time was in the same time zone.
## Future Improvements
Future improvements including a user sign up page so a technician could add a work_order to the calender. If future appointments occur in the same cell, it would display all appointments or render an error as one technician most likely could not finish multiple work orders in an hour. Instead of a pop up window, clicking the button would link to a new page where more details about the work order can be read or added to. Another improvement is to allow appointments to be canceled. 
