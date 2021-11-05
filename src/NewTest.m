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

%main robot loop
while 2 > 1
    %3 refers to port 3. Also, the unit returned is in centimeters  
    distance = brick.UltrasonicDist(3);
    
    if distance <= 30
    %If it's obstructed, first turn right, then try moving forward.
    %If you still can't move forward, turn 180, and then try again.
        %fprintf("Turn 90 right");
        brick.MoveMotor('A', -30 * ACONST);
        brick.MoveMotor('B', -30 * BCONST);
        
        brick.MoveMotor('A', -45 * ACONST);
        brick.MoveMotor('B', 45 * BCONST);
        
        %3 refers to port 3. Also, the unit returned is in centimeters  
        distance = brick.UltrasonicDist(3);
        if ~(distance <= 30)
            brick.MoveMotor('A', -30 * ACONST);
            brick.MoveMotor('B', -30 * BCONST);
        
            brick.MoveMotor('A', -90 * ACONST);
            brick.MoveMotor('B', 90 * BCONST);
        end
    else
        brick.MoveMotor('A', 100 * ACONST);
        brick.MoveMotor('B', 100 * BCONST);
    end    
end