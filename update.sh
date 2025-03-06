rm oci_cells.csv.gz
wget -O oci_cells.csv.gz "https://download.unwiredlabs.com/ocid/downloads?token=pk.b3962295d51013cd924ddea0eead2a78&file=cell_towers.csv.gz"

date > update.html

systemctl stop cell-geolocation.service

cat oci_import.sql | sqlite3 oci_cells.sqlite
cat oci_cells-cleanup.sql | sqlite3 oci_cells.sqlite

systemctl start cell-geolocation.service

scp update.html root@192.168.88.238:/var/www/html/opencellid.gps4pets.de/update.html
