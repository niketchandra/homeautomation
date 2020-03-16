<?php
define('BROKER', 'localhost');
define('PORT', 1883);
define('test', "pubclient_" + getmypid());

$client = new Mosquitto\Client(CLIENT_ID);
$client->onConnect('connect');
$client->onDisconnect('disconnect');
$client->onSubscribe('subscribe');
$client->onMessage('message');
$client->connect(BROKER, PORT, 60);
$client->subscribe('#', 1); // Subscribe to all messages

$client->loopForever();

function connect($r) {
	echo "Received response code {$r}\n";
}

function subscribe() {
	echo "Subscribed to a topic\n";
}

function message($message) {
	printf("Got a message on topic %s with payload:\n%s\n", $message->topic, $message->payload);
}

function disconnect() {
	echo "Disconnected cleanly\n";
}
?>