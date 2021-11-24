currentDirection = 0;

brick.GyroCalibrate(2);

%main robot loop
while 2 > 1
    currentDirection = brick.GyroAngle(2);
    
    currentDirection = rem(currentDirection, 360);
    
    %Getting direction in each direction
    %3 refers to port 3. Also, the unit returned is in centimeters
    frontDist = brick.UltrasonicDist(3);
    
    disp(currentDirection);
    currentDirection = turnAngle(brick, currentDirection, currentDirection + 90);
    
    rightDist = brick.UltrasonicDist(3);
    
    currentDirection = turnAngle(brick, currentDirection, currentDirection + 90);
    
    rearDist = brick.UltrasonicDist(3);
    
    currentDirection = turnAngle(brick, currentDirection, currentDirection + 90);
    
    leftDist = brick.UltrasonicDist(3);
    
    %Now we're back facing front
    currentDirection = turnAngle(brick, currentDirection, currentDirection + 90);
    
    dists = [frontDist, rightDist, rearDist, leftDist];
    maxDist = max(dists);
        
    if rightDist == maxDist
        currentDirection = turnAngle(brick, currentDirection, currentDirection + 90);
    elseif rearDist == maxDist
        currentDirection = turnAngle(brick, currentDirection, currentDirection + 180);
    elseif leftDist == maxDist
        currentDirection = turnAngle(brick, currentDirection, currentDirection + 270);
    end
    
    brick.MoveMotor('A', 700);
    brick.MoveMotor('B', 700);
end

function a = turnAngle(brick, currentDir, targetDir)
    %reversing a bit
    %brick.MoveMotor('A', -30);
    %brick.MoveMotor('B', -30);
    
    motorMove = (targetDir - currentDir) / 2;
    brick.MoveMotor('A', -1 * motorMove);
    brick.MoveMotor('B', motorMove);
    
    currentDir = brick.GyroAngle(2);
    
    if abs(currentDir - targetDir) > 20
        disp(targetDir);
        disp(currentDir);
        
        a = turnAngle(brick, currentDir, targetDir);
    else
        a = currentDir;
    end
end