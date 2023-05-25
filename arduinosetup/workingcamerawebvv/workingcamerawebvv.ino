#include "esp_camera.h"
#include <WiFi.h>
#include <WebServer.h>
#include <ArduinoWebsockets.h>

// Select camera model
#define CAMERA_MODEL_AI_THINKER

#include "camera_pins.h"

const char* ssid = "Hasib";
const char* password = "hasib123";
const int serverPort = 80;

const char* websocket_server_host = "34.171.93.214";
const uint16_t websocket_server_port = 65080;

WebServer server(serverPort);
using namespace websockets;
WebsocketsClient client;

void handleRoot() {
  // Handle root URL request
  server.send(200, "text/plain", "Hello from ESP32!");
}

void handleCameraFeed() {
  // Capture an image from the camera
  camera_fb_t* fb = esp_camera_fb_get();
  if (!fb) {
    server.send(500, "text/plain", "Camera capture failed");
    return;
  }

  if (fb->format != PIXFORMAT_JPEG) {
    server.send(500, "text/plain", "Non-JPEG data not implemented");
    return;
  }

  // Send image data as response
  server.sendHeader("Content-Type", "image/jpeg");
  server.sendHeader("Content-Length", String(fb->len));
  server.sendContent_P((const char*)fb->buf, fb->len);
  server.client().stop();

  esp_camera_fb_return(fb);
}


void setup() {
  Serial.begin(115200);
  Serial.setDebugOutput(true);
  Serial.println();

  camera_config_t config;
  config.ledc_channel = LEDC_CHANNEL_0;
  config.ledc_timer = LEDC_TIMER_0;
  config.pin_d0 = Y2_GPIO_NUM;
  config.pin_d1 = Y3_GPIO_NUM;
  config.pin_d2 = Y4_GPIO_NUM;
  config.pin_d3 = Y5_GPIO_NUM;
  config.pin_d4 = Y6_GPIO_NUM;
  config.pin_d5 = Y7_GPIO_NUM;
  config.pin_d6 = Y8_GPIO_NUM;
  config.pin_d7 = Y9_GPIO_NUM;
  config.pin_xclk = XCLK_GPIO_NUM;
  config.pin_pclk = PCLK_GPIO_NUM;
  config.pin_vsync = VSYNC_GPIO_NUM;
  config.pin_href = HREF_GPIO_NUM;
  config.pin_sscb_sda = SIOD_GPIO_NUM;
  config.pin_sscb_scl = SIOC_GPIO_NUM;
  config.pin_pwdn = PWDN_GPIO_NUM;
  config.pin_reset = RESET_GPIO_NUM;
  config.xclk_freq_hz = 10000000;
  config.pixel_format = PIXFORMAT_JPEG;
  //init with high specs to pre-allocate larger buffers
  if(psramFound()){
    config.frame_size = FRAMESIZE_VGA;
    config.jpeg_quality = 40;
    config.fb_count = 2;
  } else {
    config.frame_size = FRAMESIZE_SVGA;
    config.jpeg_quality = 12;
    config.fb_count = 1;
  }


  // camera init
  esp_err_t err = esp_camera_init(&config);
  if (err != ESP_OK) {
    Serial.printf("Camera init failed with error 0x%x", err);
    return;
  }

 

  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println();
  Serial.println("WiFi connected");

  // Configure web server routes
  server.on("/", handleRoot);
  server.on("/camera_feed", handleCameraFeed);

  // Start the web server
  server.begin();
  Serial.println("Web server started");

  // Connect to WebSocket server
  while (!client.connect(websocket_server_host, websocket_server_port, "/")) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("WebSocket Connected!");
}

void loop() {
  // Handle incoming client requests
  server.handleClient();

  // Your code logic here...

  // Capture an image from the camera
  camera_fb_t* fb = esp_camera_fb_get();
  if (!fb) {
    Serial.println("Camera capture failed");
    return;
  }

  if (fb->format != PIXFORMAT_JPEG) {
    Serial.println("Non-JPEG data not implemented");
    return;
  }

  // Send image data to WebSocket server
  client.sendBinary((const char*)fb->buf, fb->len);
  esp_camera_fb_return(fb);
}