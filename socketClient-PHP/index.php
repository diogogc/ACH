<?php
	$host    = "127.0.0.1";//PUT HERE your public IP You can get it http://ping.eu
	$port    = 80;//Using port 80, to avoid problems on host servers

	$action = $_REQUEST['action'];

	$message = $action."\n";

	echo "Message to Arduino :".$message;
	// create socket
	$socket = socket_create(AF_INET, SOCK_STREAM, 0) or die("Couldn't create a socket!\n");
	// connect server
	$result = socket_connect($socket, $host, $port) or die("Couldn't connect\n");  
	// send data
	socket_write($socket, $message, strlen($message)) or die("Couldn't send\n");
	// get response
	$result = socket_read ($socket, 1024) or die("Couldn;t recive response\n");
	echo "Resposta  :".$result;
	// close connection
	socket_close($socket);
?>