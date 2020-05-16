module input;

// Handle inputs
// TODO setting saved to file in .config?
// TODO readout saved settings
class InputHandler{
    Command buttonA;
    Command buttonD;
    Command buttonLeftMouse;
    Command buttonW;
}

// TODO use https://wiki.dlang.org/Compile-time_Command_Pattern
class Command{
    abstract void execute(){}
}
