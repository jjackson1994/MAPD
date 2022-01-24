# MAPD
As a rule of thumb the project code we have added will be found in 
project_name.src/sim or /sources  
Might be better this way in order to track changes and share code

UART VIDEO
https://www.youtube.com/watch?v=Vh0KdoXaVgU

My drive folder share link

https://drive.google.com/drive/folders/1Z0kCZoW8L592DAKeTI74q2IeYicK0AAL?usp=sharing

Walters Drive link

https://drive.google.com/drive/folders/1dASbZEi4LeBrDj1fY94hjEhq4YMwwaAf

Our board will be either

xc7a35tcsg324-1 or xc7a100tcsg324-1

Other resources
http://freerangefactory.org/pdf/df344hdh4h8kjfh3500ft2/free_range_vhdl.pdf

Constraint master file

https://github.com/Digilent/digilent-xdc/blob/master/Arty-A7-35-Master.xdc

https://github.com/Digilent/digilent-xdc/blob/master/Arty-A7-100-Master.xdc

Git (keeping it simple, can add personal dev branches if need be) 

git pull 
git push -u origin master

lectures merged together
https://drive.google.com/file/d/1P3LB5ojx_66RQ6HVGliAnE0oEJpF-Wg7/view?usp=sharing

Pin Maps and board info:
https://digilent.com/reference/programmable-logic/arty-a7/reference-manual

How to look at internal signals in a test bench
Hi Daniel,

in simulation you can look at all the internal signals, not only at the ports on the top.
In the tab "Scope" you should find a hierarchy of the simulation entities. There is the top entity of the testbench and then the DUT and also other instances in case there are other components inside the DUT. If you click on a particular component (for instance on DUT) you should find in the window "Object" all the list of internal signals of that component. Then you can drag and drop a signal on the waveform window under the column "Name". Finally you can relaunch the simulation clicking on the icon with the circular arrow.
I hope to have been clear. In case I was not, please let me know.

Best,


