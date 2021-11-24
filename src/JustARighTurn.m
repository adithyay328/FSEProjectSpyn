while 2 > 1
    if brick.UltrasonicDist(3) <= 20
        brick.StopMotor('A');
        brick.StopMotor('B');
        pause(1.5);

        turnGyro(brick, 90);
        
        pause(1.5);
        
        if brick.UltrasonicDist(3) <= 50
            turnGyro(brick, 180);
            
            pause(1.5);
        end
    else
        brick.MoveMotor('A', 50);
        brick.MoveMotor('B', 50);
    end
end

function turnGyro(brick, degrees)
    %Calibrating gyro
    brick.GyroCalibrate(4);
    disp(brick.GyroAngle(4));
    
    brick.MoveMotor('A', abs(degrees) / degrees * 50);
    brick.MoveMotor('B', -1 * abs(degrees) / degrees * 50);
    
    %This is just going to block until the gyro angle error reaches a good
    %accuracy
    while abs(brick.GyroAngle(4) - degrees) > 10
        %disp(abs(brick.GyroAngle(4) - degrees));
    end
    
    brick.StopMotor('A', 'Brake');
    brick.StopMotor('B', 'Brake');
    
    pause(0.5);
    
    turnAngle = brick.GyroAngle(4) * 0.08;
    disp(turnAngle);
    
    brick.MoveMotorAngleRel('A', -40, turnAngle, 'Brake');
    brick.MoveMotorAngleRel('B', 40, turnAngle, 'Brake');
end