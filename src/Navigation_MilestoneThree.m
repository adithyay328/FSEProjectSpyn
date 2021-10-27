import Brick.*;
import keyboard.*;
import colorSensor.*;
import bluetooth.*;
import wfBrickIO.*;
import usbBrickIO.*;

%All the different brick connection schemes
%brick = Brick('ioType','wifi','wfAddr','127.0.0.1','wfPort',5555,'wfSN','0016533dbaf5');
brick = ConnectBrick("ROCKET")
%brick = legoev3('Bluetooth','COM6');
%brick = legoev3("Bluetooth");
%brick = legoev3("USB");

global key
InitKeyboard();

myev3 = brick;
class(brick)

while 2 > 1
    %3 refers to port 3. Also, the unit returned is in centimeters
    distance = brick.UltrasonicDist(3)
    if distance < 10
        disp("YOU ARE REALLY CLOSE TO ME");
    end
end

brick.SetColorMode(1, 4);

while 2 > 1
    %Returns a tuple with r g and b values
    color_rgb = brick.ColorRGB(4);
    
    red = color_rgb(1);
    green = color_rgb(2);
    blue = color_rgb(3);
    
    colorList = [red,green,blue];
    sorted = sort(colorList);
    
    highestValue = sorted(2);
    
    color = "";
    if highestValue == red
        color = "red";
    elseif highestValue == blue
        color = "blue";
    else
        color = "green";
    end
       
    fprintf(color + ": %d\n", highestValue);
end
