#!/usr/bin/php
<?php

$files = array('detskiy', 'euro', 'iplus', 'rusill', 'zoo');
date_default_timezone_set('Europe/Moscow');
foreach($files as $f) {
	convert_age($f . '.csv', $f . '_out.csv');
}

function convert_age($in, $out) {
	echo "Converting from $in to $out\n";
	$output = array();
	$rownum = 0;
	if (($handle = fopen($in, 'r'))!==FALSE) {
		while (($data = fgetcsv($handle, 1000, ','))!==FALSE) {
			$rownum++;
			
			$num = count($data);
			$row[0] = trim($data[0]);
			if ($row[0]==='') continue;
			if ($rownum!==1) $row[1] = convert_date(trim($data[1]));
			else $row[1] = trim($data[1]);
			$row[2] = trim($data[2]);
			$row[3] = preg_replace('/\.$/', '', trim($data[3])) . ' (' . trim($data[4]) . ')';
			$row[4] = trim($data[5]);
			$output[] = $row;
		}
		fclose($handle);
	}
	else die('Cannot open input file ' . $in);

	$output = clean_unaccepted_chars($output);

	if (($handle = fopen($out, 'w'))!==FALSE) {
		foreach($output as $row) {
			fputcsv($handle, $row);
		}
		fclose($handle);
	}

	else die('Cannot open output file ' . $out);
}


function convert_date($date) {
	// Good date format: 2012-09-01
	// Bad date format: 01.09.2012

	// Detect date format
	if (preg_match('/20[0-9][0-9]-[0-9][0-9]-[0-3][0-9]/', $date)) {
		// Good format already
		return $date;
	}
	$d = date_parse_from_format('j.n.Y', $date);
	return date('Y-m-d', mktime(0,0,0,$d['month'], $d['day'], $d['year']));
}


function clean_unaccepted_chars($data) {
	for($i=0; $i<sizeof($data); $i++) {
		for ($y=0; $y<sizeof($data[$i]); $y++) {
			$data[$i][$y] = preg_replace('/\'/', '`', $data[$i][$y]);
		}
	}
	return $data;
}
