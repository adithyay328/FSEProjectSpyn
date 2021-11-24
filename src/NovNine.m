import keyboard.*;

brick.SetColorMode(1, 4);
ACONST = 1.0;
BCONST = 1.0;

%leftMotor = motor(brick, 'A');
%rightMotor = motor(brick, 'B');

%Returns a tuple with r g and b values
%color_rgb = brick.ColorRGB(4);

%red = color_rgb(1);
%green = color_rgb(2);
%blue = color_rgb(3);

disp(methods(brick))

global key
InitKeyboard();

%main robot loop
while 2 > 1
    
    %3 refers to port 3. Also, the unit returned is in centimeters  
    distance = brick.UltrasonicDist(3);
    
    if distance < 15
    %If it's obstructed, first turn right, then try moving forward.
    %If you still can't move forward, turn 180, and then try again.
        %fprintf("Turn 90 right");
        brick.MoveMotor('A', 50 * ACONST);
        brick.MoveMotor('B', 47 * BCONST);
    else
        %Right turn
        brick.MoveMotor('A', -27 * ACONST);
        brick.MoveMotor('B', 27 * BCONST);
        pause(0.875);
        
        brick.StopMotor('A');
        brick.StopMotor('B');
        
        distance = brick.UltrasonicDist(3);
        disp(distance);
    end    
end