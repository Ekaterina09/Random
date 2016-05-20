#!/bin/sh
ps=./mexico.ps
gpssta="try.txt"
gpssta1="try.txt1"
gpssta2="try.txt2"
GMT pscoast -R-118/-86/14/33 -Jm0.5c -K -B5 -I1/1p,blue -N1/0.25p,-I2/0.25p,blue -W0.25p,white -Ggreen -Sblue -P -V > $ps
GMT psxy $gpssta -R -J -O -K -Si0.25c -Gred -V >> $ps
GMT pstext $gpssta -R -J -O -K -X-0.05 -Dj0.0/0.1 -V >> $ps
GMT pstext $gpssta1 -R -J -O -K -X-0.05 -Dj0.0/-0.2 -V >> $ps
GMT pstext $gpssta2 -R -J -O -X+0.2 -Dj-0.2/0.0 -V >> $ps
GMT ps2raster -Tef -V $ps

