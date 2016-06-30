authors:  	Bram Mulder, Ferry Liekens
version:  	1.0
since:    	2016-06-12
copyright:	Anyone can use it for non-commercial purposes

Description:
A flooding application in Rotterdam
Draws black points on the canvas with different heights, dark being small and light being tall

Note: This code uses a CSV file with Rijksdriehoekcoordinates of Rotterdam (x,y,z) (location + height) as input

Controls:
To Start:
B - Draws a 1000x1000 area around (92800,437000) Rijksdriehoekcoordinates
S - Draws a 500x500 area

After the map has been drawn:
Z - Slowly floods the City
	Times Pressed:
	1. 10M
	2. 20M
	3. 30M
	4. 50M
	5. 70M
	6. 70m or more

R - Resets the canvas to remove the water
I - Takes a snapshot of what is on the canvas at that moment and saves it to the program's library as a .png file
