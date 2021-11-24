%Main robot loop
while 2 > 1
    brick.GyroCalibrate(4);
    
    %While we're going in a straight line
    while brick.TouchPressed(1) == 0 || brick.TouchPressed(3) == 0
        %brick.MoveMotor('A', 25);
        %brick.MoveMotor('B', 25);
        %pause(0.01);
        
        aPower = 1.0;
        bPower = 1.0;
        
        %We don't want to run this every time, so the actual error
        %correction only runs once every couple loops
        PERCENTCHANCEOFERRORCORRECTION = 20;
        
        FORWARDSPEED = 30;
        
        if rand() * 100 > (100 - PERCENTCHANCEOFERRORCORRECTION)
            error = brick.GyroAngle(4);
            errorRad = deg2rad(error);

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
            
        end
        
        brick.MoveMotor('A', aPower * FORWARDSPEED);
        brick.MoveMotor('B', bPower * FORWARDSPEED);
    end
    
    disp("Wall detected.");
    
    brick.StopMotor('A');
    brick.StopMotor('B');
    pause(1.5);
    
    %Moving back a bit
    brick.MoveMotorAngleRel('A', -25, 75, 'Coast');
    brick.MoveMotorAngleRel('B', -25, 75, 'Coast');
    
    pause(2);
    
    if(brick.GyroAngle(4) > 5)
        %If A-side isn't touching the wall just yet, but B is
        if brick.TouchPressed(1) == 1
            disp("A side isn't touching, but B is");
            while brick.TouchPressed(3) == 0
                brick.MoveMotor('B', -5);
                pause(0.5);
                
                brick.StopMotor('B');
                pause(0.5);
                
                brick.MoveMotor('A', 15);
                brick.MoveMotor('B', 15);
            end

            brick.StopMotor('A');
            brick.StopMotor('B');

            pause(1.5);
        %Otherwise, A is touching the wall
        else
            disp("B side isn't touching, but A is");
            while brick.TouchPressed(1) == 0
                brick.MoveMotor('A', -5);
                pause(0.5);
                
                brick.StopMotor('A');
                pause(0.5);
                
                brick.MoveMotor('A', 15);
                brick.MoveMotor('B', 15);
            end

            brick.StopMotor('A');
            brick.StopMotor('B');

            pause(1.5);
        end

        disp("Both are hitting wall now");
    end
    
    brick.StopMotor('A');
    brick.StopMotor('B');
    pause(1.5);

    %Moving back a bit
    brick.MoveMotorAngleRel('A', -25, 200, 'Coast');
    brick.MoveMotorAngleRel('B', -25, 200, 'Coast');

    pause(2);

    %Starting our turn solution
    turnGyro(brick, 90);

    pause(1.5);

    for i = 1:20
        %Moving forward step by step, seeing if we hit a nearby wal
        brick.MoveMotorAngleRel('A', 50, 20, 'Coast');
        brick.MoveMotorAngleRel('B', 50, 20, 'Coast');
        pause(0.3);

        if brick.TouchPressed(1) == 1 || brick.TouchPressed(3) == 1
            disp("Should be turning now.")

            %Moving back a bit
            brick.MoveMotorAngleRel('A', -50, 200, 'Coast');
            brick.MoveMotorAngleRel('B', -50, 200, 'Coast');

            pause(2);

            turnGyro(brick, 180);

            pause(2);

            break;
        end
    end
end

function turnGyro(brick, degrees)
    %Calibrating gyro
    brick.GyroCalibrate(4);
    pause(0.5);
    
    disp(brick.GyroAngle(4));
    
    brick.MoveMotor('A', abs(degrees) / degrees * 50);
    brick.MoveMotor('B', -1 * abs(degrees) / degrees * 50);
    
    %This is just going to block until the gyro angle error reaches a good
    %accuracy
    while abs(brick.GyroAngle(4) - degrees) > 10
        disp(abs(brick.GyroAngle(4) - degrees));
    end
    
    brick.StopMotor('A', 'Brake');
    brick.StopMotor('B', 'Brake');
    
    pause(0.5);
    
    turnAngle = brick.GyroAngle(4) * 0.08;
    disp(turnAngle);
    
    brick.MoveMotorAngleRel('A', -40, turnAngle, 'Brake');
    brick.MoveMotorAngleRel('B', 40, turnAngle, 'Brake');
end