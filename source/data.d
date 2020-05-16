module data;

import std.stdio;
import std.math;
import std.algorithm;
import std.typecons;
import std.traits;

/// Newtonian constant of gravitation
enum real G = 6.6743015E-11;

/// 2D Vector
struct Vector{
    /// X-Coordinate
    real x = 0;
    /// Y-Coordinate
    real y = 0;

    this(T, R)(T i, R j) if (isNumeric!T && isNumeric!R)
    {
        x = i;
        y = j;
    }
    this(T)(T i) if (isNumeric!T)
    {
        x = i;
        y = i;
    }
    
    void opAssign(T)(T i) if (isNumeric!T)
    {
        x = i;
        y = i;
    }

    void opOpAssign(string op, T)(T rhs) if (isNumeric!T)
    {
        mixin("x" ~op~ "= rhs;");
        mixin("y" ~op~ "= rhs;");
    }
    void opOpAssign(string op)(Vector rhs)
    {
        mixin("x" ~op~ "= rhs.x;");
        mixin("y" ~op~ "= rhs.y;");
    }

    Vector opUnary(string op)() const
    {
        return mixin("Vector(" ~op~ " x," ~op~ "y)");
    }

    Vector opBinary(string op, T)(T rhs) const if (isNumeric!T)
    {
        return mixin("Vector(x" ~ op ~ "rhs, y" ~ op ~ "rhs)");
    }
    Vector opBinary(string op)(Vector rhs) const
    {
        return mixin("Vector(x" ~ op ~ "rhs.x, y" ~ op ~ "rhs.y)");
    }


    Vector opBinaryRight(string op, T)(T rhs) const if (isNumeric!T)
    {
        return mixin("Vector(rhs" ~ op ~ "x, rhs" ~ op ~ "y)");
    }

    /// Vector length
    real length() const
    {
        return sqrt(dot(this, this));
    }
}

/// Dot product
real dot(const ref Vector p1, const ref Vector p2)
{
    auto r =  p1*p2;
    return r.x + r.y;
}

/// Computes the distance between two vectors
real distance(const ref Vector p1, const ref Vector p2)
{
    Vector r = p1 - p2;
    return r.length;
}

/// Computes the distance between two particles
real distance(const ref Particle p1, const ref Particle p2)
{
    return distance(p1.x, p2.x);
}


/// Particle struct
struct Particle{
    /// Position
    Vector x;
    /// Velocity
    Vector v;
    /// Acceleration
    Vector a;
    /// Mass
    real m;
    /// Radius
    real r;
}