#include <OneWire.h>
#include <DallasTemperature.h>

// GPIO where the DS18B20 is connected
#define ONE_WIRE_BUS 4

// Set up a oneWire instance
OneWire oneWire(ONE_WIRE_BUS);

// Pass oneWire to DallasTemperature
DallasTemperature sensors(&oneWire);

void setup() {
  Serial.begin(115200);
  sensors.begin();
}

void loop() {
  sensors.requestTemperatures();  // Send the command to get temperatures

  float tempC = sensors.getTempCByIndex(0);  // Read temperature from the first sensor

  if (tempC == DEVICE_DISCONNECTED_C) {
    Serial.println("Error: DS18B20 not found");
  } else {
    //Serial.print("Temperature: ");
    Serial.println(tempC);
    //Serial.println(" °C");
  }

  delay(1000);  // Wait 1 second before repeating
}
