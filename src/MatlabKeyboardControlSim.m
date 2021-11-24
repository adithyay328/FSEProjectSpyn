import Brick.*;
import keyboard.*;
import colorSensor.*;
import bluetooth.*;
import wfBrickIO.*;
import usbBrickIO.*;

%brick = Brick('ioType','wifi','wfAddr','127.0.0.1','wfPort',5555,'wfSN','0016533dbaf5');
%brick = ConnectBrick("ROCKET")
%brick = legoev3('Bluetooth','COM6');
%brick = legoev3("Bluetooth");
%brick = legoev3("USB");

global key
InitKeyboard();

myev3 = brick;
class(brick)

%brick.playTone(100, 800, 500);

%v = myev3.GetBattVoltage();

%colorSens = colorSensor('ROCKET', 3);

%disp(v);

leftMotor = motor(myev3, 'A');
rightMotor = motor(myev3, 'B');

while 1
    pause(0.1);
    
    switch key
        case 'uparrow'
            disp("Up Arrow pressed!");
            brick.MoveMotor('A', 50);
            brick.MoveMotor('B', 50);
            %leftMotor.Speed = 10;
            %rightMotor.Speed = 10;
        case 'downarrow'
            disp("Down Arrow Pressed!");
            brick.MoveMotor('A', -50);
            brick.MoveMotor('B', -50);
        case 'leftarrow'
            disp("Left Arrow Pressed!");
            brick.MoveMotor('A', 50);
            brick.MoveMotor('B', -50);
        case 'rightarrow'
            disp("Right Arrow Pressed!");
            brick.MoveMotor('A', -50);
            brick.MoveMotor('B', 50);
        case 0
            disp("No Key Pressed!");
        case "q"
            break;
     end
end
CloseKeyboard();
