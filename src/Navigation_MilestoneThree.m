import Brick.*;
import brick.*;
import keyboard.*;
import colorSensor.*;
import bluetooth.*;
import wfBrickIO.*;
import usbBrickIO.*;
import btBrickIO.*;
import ConnectBrick.*;
import .*;

%All the different brick connection schemes
%brick = Brick('ioType','wifi','wfAddr','127.0.0.1','wfPort',5555,'wfSN','0016533dbaf5');
brick = ConnectBrick("ROCKET")
%brick = legoev3('Bluetooth','COM6');
%brick = legoev3("Bluetooth");
%brick = legoev3("USB");

global key
InitKeyboard();

myev3 = brick;
disp(methods(brick));

class(brick)

brick.SetColorMode(1, 4);

%leftMotor = motor(brick, 'A');
%rightMotor = motor(brick, 'B');

%Returns a tuple with r g and b values
%color_rgb = brick.ColorRGB(4);

%red = color_rgb(1);
%green = color_rgb(2);
%blue = color_rgb(3);

%main robot loop
while 2 > 1
    %3 refers to port 3. Also, the unit returned is in centimeters
    distance = brick.UltrasonicDist(3);
    
    if distance <= 14
    %If it's obstructed, first turn right, then try moving forward.
    %If you still can't move forward, turn 180, and then try again.
        %fprintf("Turn 90 right");
        turnRightNinety();
       
        if ~robotIsNotObstructed()
            turnOneEighty();
        end
    end
end 

function yn = robotIsNotObstructed()
    dist = readDistance();
    
    yn = ( dist <= 14 );
end
function dist = readDistance()
    dist = brick.UltrasonicDist(3);
end

function turnRightNinety()
    %brick.MoveMotor('A', -30);
    %brick.MoveMotor('B', 30);
    
    %leftMotor.Speed = 30;
    %rightMotor.Speed = -30;
    
    brick.MoveMotorAngleRel('A', 100, 90, 'Brake');
end

function turnOneEighty()
    %brick.MoveMotor('A', -30);
    %brick.MoveMotor('B', 30);
    
    %leftMotor.Speed = 30;
    %rightMotor.Speed = -30;
end