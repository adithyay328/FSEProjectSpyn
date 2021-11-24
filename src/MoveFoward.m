disp("Hello");

while 2 > 1
    %brick.MoveMotor('A', 50);
    %brick.MoveMotor('D', 50);
    %MoveMotorAngleRel('A', 100, 50, 'Coast');
    brick.MoveMotorAngleRel('A', 20, -90, 'Brake');
    
    pause(1);
    disp("Runing");
end