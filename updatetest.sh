systemctl stop cell-geolocation.service

cat oci_import.sql | sqlite3 oci_cells.sqlite
cat oci_cells-cleanup.sql | sqlite3 oci_cells.sqlite

systemctl start cell-geolocation.service
