brick.MoveMotor('A', 50);

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
    distance = brick.UltrasonicDist(3)
    
    if distance <= 30
    %If it's obstructed, first turn right, then try moving forward.
    %If you still can't move forward, turn 180, and then try again.
        %fprintf("Turn 90 right");
        brick.MoveMotor('A', -90);
        brick.MoveMotor('B', 90);
       
        if ~(distance <= 30)
            brick.MoveMotor('A', -180);
            brick.MoveMotor('B', 180);
        end
    else
        brick.MoveMotor('A', 100);
        brick.MoveMotor('B', 100);
    end
    
    pause(0.5);
    brick.StopMotor('A');
    brick.StopMotor('B');
    
end

function dist = readDistance()
    dist = brick.UltrasonicDist(3);
end