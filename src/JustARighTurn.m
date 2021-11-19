theoreticalDegreesTurned = 0;
actualDegreesTurned = 0;

for i = 1:4
    
    
    [theoreticalDegreesTurned, actualDegreesTurned] = turn(brick, 90, theoreticalDegreesTurned, actualDegreesTurned);
    
    
end


function [theoryTotal, actualTotal] = turn(brick, degrees, theoryTotal, actualTotal)
    %Calibrating gyro
    brick.GyroCalibrate(4);
    brick.GyroAngle(4);
    
    %Updating our record of how far we've turned in total so far
    theoryTotal = theoryTotal + degrees;
    disp("Theory Total: " + theoryTotal);
    
    turnRaw(brick, degrees);
    
    currentGyroAngle = brick.GyroAngle(4);
    
    %Updating our record of how far we've actually turned
    actualTotal = actualTotal + currentGyroAngle;
    
    %Figuring out how much error we have
    errorAngle = theoryTotal - actualTotal;
    disp("Error Angle" + errorAngle);
    
    if abs(errorAngle) > 4
        %Calibrating gyro
        brick.GyroCalibrate(4);
        brick.GyroAngle(4);
    
        turnRaw(brick, errorAngle);
        
        actualTotal = actualTotal + brick.GyroAngle(4);
    end
end

function turnRaw(brick, degrees)
    workingDegrees = degrees * 0.9;
    
    baseSpeed = degrees / -6;
    
    brick.MoveMotorAngleRel('A', baseSpeed * (workingDegrees / abs(workingDegrees)) , ( workingDegrees * 2 ), 'Brake');
    brick.MoveMotorAngleRel('B', -1 * baseSpeed * (workingDegrees / abs(workingDegrees)) , ( workingDegrees * 2), 'Brake');
    
    pause(4);
    disp("Pause time: " + abs(degrees) / 180 * 5);
end