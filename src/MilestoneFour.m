while 2 > 1
    distance = brick.UltrasonicDist(3);

    brick.MoveMotor('C', -10);
    brick.MoveMotor('A', -50);
    brick.MoveMotor('B', -50);
end