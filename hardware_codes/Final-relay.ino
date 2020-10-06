#include <ESP8266WiFi.h>
#include <PubSubClient.h>

const char* ssid = "Airtel_7415045756";
const char* password = "air81485";
const char* mqtt_server = "192.168.1.10"; 

const int stateMessageEverySec = 5;

#define LEFT_SWITCH 4
const char* leftControlTopic = "urgn/switch/left/control";
const char* leftStateTopic = "urgn/switch/left/state";

#define RIGHT_SWITCH 5
const char* rightControlTopic = "urgn/switch/right/control";
const char* rightStateTopic = "urgn/switch/right/state";


WiFiClient espClient;
PubSubClient client(espClient);

void setupWiFi() {
  delay(10);
  Serial.println(); Serial.print("Connecting to "); Serial.println(ssid);
  
  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500); Serial.print(".");
  }
  
  randomSeed(micros());

  Serial.println("");
  Serial.println("WiFi connected");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());
}

void reconnectMQTT() {
  // Loop until we're reconnected
  while (!client.connected()) {
    Serial.print("Attempting MQTT connection...");
    // Create a random client ID
    String clientId = "ESP8266Client-";
    clientId += String(random(0xffff), HEX);
    // Attempt to connect
    if (client.connect(clientId.c_str())) {
      Serial.println("connected");
      // Once connected, publish an announcement...
      client.publish("urgn/testOut", "hello world");
      // ... and resubscribe
      client.subscribe(leftControlTopic);
      client.subscribe(rightControlTopic);
    } else {
      Serial.print("failed, rc=");
      Serial.print(client.state());
      Serial.println(" try again in 5 seconds");
      // Wait 5 seconds before retrying
      delay(5000);
    }
  }
}

void publishRelayState(const char* relayTopic, int relayCode) {
  char* message;
  
  if (digitalRead(relayCode) == HIGH) {
    message = "OFF";
  } else {
    message = "ON";
  }
  
  client.publish(relayTopic, message);
}

void processRelayCallback(const char* controlTopic, const char* stateTopic, int relayCode, char* topic, char* command) {
    if (strcmp(controlTopic, topic) == 0) {
     if (strcmp(command, "ON") == 0) {
        Serial.println("ON");
        digitalWrite(relayCode, LOW);
        publishRelayState(stateTopic, relayCode);
     } else if (strcmp(command, "OFF") == 0) {
        Serial.println("OFF");
        digitalWrite(relayCode, HIGH);
        publishRelayState(stateTopic, relayCode);
     } else {
         Serial.println("Unknown command");
     }
  }
}

void callback(char* topic, byte* payload, unsigned int length) {
  Serial.print("Message arrived [");
  Serial.print(topic);
  Serial.print("] ");
  payload[length] = '\0';
  char *cstring = (char *) payload;
  Serial.print(cstring);
  Serial.println();

  processRelayCallback(leftControlTopic, leftStateTopic, LEFT_SWITCH, topic, cstring);
  processRelayCallback(rightControlTopic, rightStateTopic, RIGHT_SWITCH, topic, cstring);
}

void setup() {
  pinMode(LEFT_SWITCH, OUTPUT); 
  pinMode(RIGHT_SWITCH, OUTPUT);
   
  Serial.begin(9600);
  
  setupWiFi();
  client.setServer(mqtt_server, 1883);
  client.setCallback(callback);

  digitalWrite(LEFT_SWITCH, HIGH);
  digitalWrite(RIGHT_SWITCH, HIGH);
}

unsigned long lastMsg = 0;
void loop() {
  if (!client.connected()) {
    reconnectMQTT();
  }
  client.loop();

  unsigned long now = millis();
  if (now - lastMsg > stateMessageEverySec * 1000) {
    lastMsg = now;
    publishRelayState(leftStateTopic, LEFT_SWITCH);
    publishRelayState(rightStateTopic, RIGHT_SWITCH);
  }
}
