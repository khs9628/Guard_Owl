#include <Servo.h>
Servo myservo;
int servo = 3;
int angle = 0;
char isChanged = '0';
char message = 'F';

void setup() {
  Serial.begin(115200);
  myservo.attach(servo);
}

void loop() {
  
  while(Serial.available()){
    isChanged = Serial.read();
    if(isChanged == 'T'){
      angle = 90;
      myservo.write(angle);
      delay(5000);
    }
    angle = 0;
    myservo.write(angle);
  }
  
   isChanged = '0';
 
}
