<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>about</title>
</head>
<body>
	<h1>about <?= $first ?> </h1>
	<h1>about {{ $first }} </h1>
	<div>{{ $last }}</div>
	<div>{!! $last !!} </div>
	<div>{{ $first }} , {{ $last }} </div>
	<p><a href="https://www.laravist.com" target="_blank">laravist.com</a></p>
</body>
</html>
