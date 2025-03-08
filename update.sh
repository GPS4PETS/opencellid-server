rm  /root/cell-geolocation/oci_cells.csv.gz
echo "DOWNLOAD FILE"
wget -O /root/cell-geolocation/oci_cells.csv.gz "https://download.unwiredlabs.com/ocid/downloads?token=pk.b3962295d51013cd924ddea0eead2a78&file=cell_towers.csv.gz"

date > /root/cell-geolocation/update.html

echo "STOPPING SERVICE"
systemctl stop cell-geolocation.service

cd  /root/cell-geolocation/
echo "CAT IMPORT"
cat  /root/cell-geolocation/oci_import.sql | sqlite3  /root/cell-geolocation/oci_cells.sqlite
echo "CAT CLEANUP"
cat  /root/cell-geolocation/oci_cells-cleanup.sql | sqlite3  /root/cell-geolocation/oci_cells.sqlite

echo "START SERVICE"
systemctl start cell-geolocation.service

echo "SCP UPDATE.HTML"
scp /root/cell/geolocation/update.html root@192.168.88.238:/var/www/html/opencellid.gps4pets.de/update.html
