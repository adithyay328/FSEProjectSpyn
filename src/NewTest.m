global key;
InitKeyboard();

startMoving = 0;

while 1
    pause(0.1);
    distance = brick.UltrasonicDist(3);

    switch key

        case 'uparrow' % on the up arrow, the auto-driving will begin

            while(startMoving == 0)

                distance = brick.UltrasonicDist(3);

                if (distance > 15)

                    brick.MoveMotor('A', 50);
                    brick.MoveMotor('B', 50);
                    numRightTurns = 0;
                    numLeftTurns = 0;

                    distance = brick.UltrasonicDist(3);

                elseif (distance < 15)

                    % turn right

                    brick.MoveMotor('A', 27);
                    brick.MoveMotor('B', -27);
                    pause(0.875);
                    brick.StopMotor('A');
                    brick.StopMotor('B');
                    numLeftTurns = 1;
                    
                    distance = brick.UltrasonicDist(3);
                    if (distance < 15)
                        brick.MoveMotor('A', -54);
                        brick.MoveMotor('B', 54);
                        pause(0.875);
                        brick.StopMotor('A');
                        brick.StopMotor('B');

                        brick.MoveMotor('A', -54);
                        brick.MoveMotor('B', 54);
                        pause(0.875);
                        brick.StopMotor('A');
                        brick.StopMotor('B');
                        numLeftTurns = 1;
                    end
                    
                    distance = brick.UltrasonicDist(3);
                    disp(distance);

                end
            end

        end
end