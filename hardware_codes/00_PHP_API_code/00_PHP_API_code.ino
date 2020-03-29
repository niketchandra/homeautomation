#include <WiFi.h>
#include <ArduinoJson.h>
 
const char* ssid     = "Airtel";
const char* password = "12345678";
const char* host = "52.187.123.97"; //replace it with your webhost url
String device= "101";
String url;
int count = 0;
void setup() {
  Serial.begin(115200);
  Serial.print("Connecting to ");
  Serial.println(ssid);
  
  WiFi.begin(ssid, password); 
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
 
  Serial.println("");
  Serial.println("WiFi connected");  
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());
  Serial.print("Netmask: ");
  Serial.println(WiFi.subnetMask());
  Serial.print("Gateway: ");
  Serial.println(WiFi.gatewayIP());
}
 void loop() {

  Serial.print("connecting to ");
  Serial.println(host);

  WiFiClient client;
  const int httpPort = 80;
  if (!client.connect(host, httpPort)) {
    Serial.println("connection failed");
    return;
  }
  url = "/homeautomation//hardware/device/deviceon.php?id=";
  Serial.print("Requesting URL: ");
  Serial.println(url);
  
  client.print(String("GET ") + url + device + " HTTP/1.1\r\n" +
               "Host: " + host + "\r\n" + 
               "Connection: close\r\n\r\n");
  delay(60000);
}
