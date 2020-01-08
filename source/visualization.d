module visualization;
import std.stdio;

import std.container;
import data;

void trace(Particle p, ref DList!Vector path)
{
    path.removeBack();
    path.insertFront(p.x);
}