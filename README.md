</h1> # homeautomation </h1>
Home automation refers to the ability of your home to make its own decisions depending on environment conditions and give you the option to control it from a remote location. In one of our previous tutorial on the ESP8266 WiFi Module, we examined how NodeMCU or any of the other ESP8266 based boards can be used to build a web server through which all the GPIOs of the board can be controlled over WiFi. Today, we are going to put that web server in use and control home appliances with it.

The heart of today’s project is the WiFi enabled board that needs no introduction; the ESP8266 based NodeMCU development board. It is an open source platform for developing WiFi based embedded systems and it is based on the popular ESP8266 WiFi Module, running the Lua based NodeMCU firmware. NodeMCU was born out of the desire to overcome the limitations associated with the first versions of the ESP8266 module which was not compatible with breadboards, it was difficult to power and even more difficult to program. The NodeMCU board is easy to use, low cost and that quickly endeared it to the heart of makers and it is one of the most popular boards today.For today’s tutorial, we will add a 2-channel relay module to the ESP8266 board. The project flow involves the control of NodeMCU’s GPIOs from a webpage on any device connected on the same network as the board. The status of the GPIOs control the coils of the relays and that causes the relay to alternate between normally open (NO) and normally closed (NC) condition depending on the state of the GPIO, thus, effectively turning the connected appliance “ON” or “OFF”.It’s important to note that, connecting the appliances to the relay involves interaction with AC voltages which could be dangerous. Ensure you have experience interacting with AC voltages and do so in a safe manner.
REQUIRED COMPONENTS
The following components are required to build this project:NodeMCU (ESP8266-12E)2-Channel Relay ModuleBreadboardJumper WireFor those who don’t have access to a relay module, you can use 2x single channel relay modules or single relays with the supporting transistor circuitry. For that purpose you will additionally need:5v Relays (2)2n222 Transistor (2)1n4007 Diode (2)220 ohms resistor (2)5V battery/PSU

<h3>NodeMCU – Relay Module</h3
3.3V - VCC
GND - GND
D1 - D1
D2 - D2
D3 - D3
D4 - D4
If you are using the ordinary relays without the module supporting circuit, connect the relays to the NodeMCU as shown below. Ensure the relay’s coils are rated 5v or change the 5v supply to match your relay’s rated coil voltage. 
Schematics 2
With the schematics done, we can then move forward to write the code for the project.
CODE
One of the easiest way to program NodeMCU is via the Arduino IDE. This, however, requires setting up the Arduino IDE by installing the board support file for NodeMCU. If you are using the Arduino IDE to program the NodeMCU for the first time, you need to do this first before proceeding with this tutorial. Follow the detailed tutorial “Getting Started with the NodeMCU” to learn how to set up your Arduino IDE to program ESP8266 based boards.The code for today’s tutorial is a modified version of the code from the last article “NodeMCU ESP8266 WebServer Tutorial“. The code is based on the ESP8266WiFi.h library which allows the easy use of WiFi functionalities of the board. It contains all we need to create or join a WiFi access point and also create a server and client which are all important for today’s project. The library comes attached with the NodeMCU board files for the Arduino, so there is no need to install it once the board files have been installed.The code for today’s tutorial will enable us to control appliances connected to the GPIOs (via relays) of the NodeMCU board remotely.To start with, we include the library that we will use for the project, which in this case, is the ESP8266WiFi.h library.
#include <ESP8266WiFi.h>
Next, we add the credentials of the WiFi access point to which the NodeMCU will be connected. Ensure the username and password are between the double quotes. We also specify the port through which the system will communicate and create a variable to hold requests.
// Add wifi access point credentiaals
const char* ssid     = "xxxxx";
const char* password = "xxxx";
WiFiServer server(80);// Set port to 80
Next, we declare the pins of the Nodemcu to which the relay pins are connected and create variables to hold the state of each relay.
// Declare the pins to which the appliances are connected via relays
int app1 = D1; //appliance 1
int app2 = D2; //appliance 2`
