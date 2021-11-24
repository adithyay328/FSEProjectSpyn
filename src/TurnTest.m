

for i = 1:10
    turnGyro(brick, 180);
end

function turnGyro(brick, degrees)
    %Calibrating gyro
    brick.GyroCalibrate(4);
    brick.GyroAngle(4);
    
    brick.MoveMotor('A', abs(degrees) / degrees * 50);
    brick.MoveMotor('B', -1 * abs(degrees) / degrees * 50);
    
    %This is just going to block until the gyro angle error reaches a good
    %accuracy
    while abs(brick.GyroAngle(4) - degrees) > 10

    end
    
    brick.StopMotor('A', 'Brake');
    brick.StopMotor('B', 'Brake');
    
    pause(0.5);
    
    turnAngle = brick.GyroAngle(4) * 0.08;
    
    brick.MoveMotorAngleRel('A', -40, turnAngle, 'Brake');
    brick.MoveMotorAngleRel('B', 40, turnAngle, 'Brake');
end