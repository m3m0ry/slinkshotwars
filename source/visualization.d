module visualization;
import std.stdio;
import std.container;
import std.algorithm;
import std.range;
import std.conv;

import raylib;

import data;

//void trace(Particle p, ref DList!Vector path)
//{
//    path.removeBack();
//    path.insertFront(p.x);
//}
//
//void drawTrace(DList!Vector trace, int window = 800)
//{
//    foreach(line; zip(trace[], trace[].dropOne))
//    {
//        Vector pos1 = line[0] * window;
//        Vector pos2 = line[1] * window;
//        DrawLine(pos1.x.to!int, pos1.y.to!int, pos2.x.to!int, pos2.y.to!int, GREEN);
//    }
//}