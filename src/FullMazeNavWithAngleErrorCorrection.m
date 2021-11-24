theoreticalDegreesTurned = 0;
actualDegreesTurned = 0;

brick.SetColorMode(2, 2);

%Main bot loop
while 2 > 1
    %3 refers to port 3. Also, the unit returned is in centimeters  
    distance = brick.UltrasonicDist(3);
    
    %Turn code:
    if distance <= 20
        brick.StopMotor('A', 'Coast');
        brick.StopMotor('B', 'Coast');
        pause(1);
        %Turn solution: Turn 90 degrees right.
        % If it's still obstructed, turn 180 degrees and continue
        %[theoreticalDegreesTurned, actualDegreesTurned] = turn(brick, 90, theoreticalDegreesTurned, actualDegreesTurned);
        
        %turnRaw(brick, 90);
        turnGyro(brick, 90);
        %brick.MoveMotor('A', 27);
        %brick.MoveMotor('B', -27);
        
        %pause(2);
        
        %brick.StopMotor('A', 'Coast');
        %brick.StopMotor('B', 'Coast');
        
        %3 refers to port 3. Also, the unit returned is in centimeters  
        distance = brick.UltrasonicDist(3);
        
        if distance <= 20
            %[theoreticalDegreesTurned, actualDegreesTurned] = turn(brick, 180, theoreticalDegreesTurned, actualDegreesTurned);
            %turnRaw(brick, 180);
            turnGyro(brick, 180);
            
        %Calibrating gyro
        brick.GyroCalibrate(4);
        brick.GyroAngle(4);
        end
    
    %Else we're moving forward
    else
        %Calibrating gyro
        brick.GyroCalibrate(4);
        brick.GyroAngle(4);
        
        distance = brick.UltrasonicDist(3);
        while distance > 20
            %All the red sections are on the straight segments, so we're
            %checking for a red color in front of our sensor in this front
            %move logic
            if brick.ColorCode(2) == 5
                brick.StopMotor('A', 'Coast');
                brick.StopMotor('B', 'Coast');
                pause(1);
            end
            
            distance = brick.UltrasonicDist(3);
            
            error = brick.GyroAngle(4);
            errorRad = deg2rad(error);
            
            aPower = 1.0;
            bPower = 1.0;
            
            %Below is a function to calculate our error compensation
            C = 0.001;
            errorCompensation = 1 - ( abs(sin(abs(errorRad))) * C );
            
            %If we're erroring right, subtract from left motor
            if(error > 3)
                aPower = aPower - errorCompensation;
            %Otherwise, take off of right motor
            elseif(error < -3)
                bPower = bPower - errorCompensation;
            end
            
            FORWARDSPEED = 75;
            brick.MoveMotor('A', aPower * FORWARDSPEED);
            brick.MoveMotor('B', bPower * FORWARDSPEED);
            
        end
    end
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