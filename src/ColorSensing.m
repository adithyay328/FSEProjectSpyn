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

%brick.playTone(100, 800, 500);

%v = myev3.GetBattVoltage();

%colorSens = colorSensor("ROCKET", 3);

brick.SetColorMode(1, 4);

while 2 > 1
    color_rgb = brick.ColorRGB(4);
    %fprintf("\tRed %d\n", color_rgb(1));
    %fprintf("\tGreen %d\n", color_rgb(2));
    %fprintf("\tBlue %d\n", color_rgb(3));
    
    red = color_rgb(1);
    green = color_rgb(2);
    blue = color_rgb(3);
    
    fprintf("red" + ": %d\n", red);
    fprintf("green" + ": %d\n", green);
    fprintf("blue" + ": %d\n", blue);
    
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