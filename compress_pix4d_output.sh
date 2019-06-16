my_array=()
while IFS= read -r line; do
    my_array+=( "$line" )
done < <( find . ! -name '*ycbr*' ! -name '*dsm*' |grep tif )

for original_file in "${my_array[@]}"; do 
	filename=$(basename "$original_file" .tif);
#	echo $original_file $filename;

	my_command="gdal_translate -co COMPRESS=JPEG -co PHOTOMETRIC=YCBCR -co TILED=YES -b 1 -b 2 -b 3 -mask 4 --config GDAL_TIFF_INTERNAL_MASK YES $original_file ${filename}_ycbr.tif"
	echo $my_command
	eval $my_command
done
