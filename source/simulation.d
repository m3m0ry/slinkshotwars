module simulation;

import std.range;
import std.math;
import std.stdio;
import std.container;
import std.algorithm;
import std.typecons;
import mir.combinatorics;

import data;

/// Acceleration due to gravity between two particles
Vector gravity(Particle p1, Particle p2)
{
    Vector r = p2.x - p1.x;
    auto dist = r.length;
    if (dist <= 0)
        return Vector();
    auto a = G * (p2.m / dist ^^ 2);
    return a * r / dist;
}

/// Computes acceleration of one particle with regard to others
ref Particle acceleration(Range)(ref Particle particle, Range particles)
        if (isInputRange!Range && is(ElementType!Range == Particle))
{
    particles.each!(p => particle.a += gravity(particle, p));
    return particle;
}

/// Compute acceleration for all particles
Range acceleration(Range)(Range particles)
        if (isInputRange!Range && is(ElementType!Range == Particle))
{
    particles.each!((ref p) => p.a = 0);
    particles.each!((ref p) => acceleration(p, particles));
    return particles;
}

/// Compute acceleration for all particles with regard to other particles
Range acceleration(Range, Source)(Range particles, Source others)
        if (isInputRange!Range && isInputRange!Source
            && is(ElementType!Range == Particle) && is(ElementType!Source == Particle))
{
    particles.each!((ref p) => p.a = 0);
    particles.each!((ref p) => acceleration(p, others));
    return particles;
}

/// Update velocity
Range velocity(Range)(Range particles, real dt)
        if (isInputRange!Range && is(ElementType!Range == Particle))
{
    particles.each!((ref p) => p.v += p.a * dt);
    return particles;
}

/// Update positions
Range position(Range)(Range particles, real dt)
        if (isInputRange!Range && is(ElementType!Range == Particle))
{
    particles.each!((ref p) => p.x += p.v * dt);
    return particles;
}

/// Test if two particles collide
bool collision(Particle p1, Particle p2)
{
    if (p1 != p2) return distance(p1, p2) <= p1.r + p2.r;
    else return false;
}


void collide(ref Particle p1, const ref Particle p2)
{
    p1.v = (p1.m * p1.v + p2.m * p2.v) / (p1.m * p2.m);
    p1.m += p2.m;
    p1.r = sqrt(p1.r ^^ 2 + p2.r ^^ 2);
}

DList!Particle collision(DList!Particle particles)
{
    DList!Particle ignore;
    DList!Particle remaining;
    foreach(p; particles)
    {
        if(!ignore[].canFind(p))
        {
            foreach(o; particles)
            {
                if(!ignore[].canFind(o) && collision(p,o))
                {
                    collide(p, o);
                    ignore.insert(o);
                }
            }
            remaining.insert(p);
        }
    }
    return remaining;
}
