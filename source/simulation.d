module simulation;

import mir.combinatorics;
import data;

/// Gravitation force between two particles
Vector gravity(Particle p1, Particle p2)
{
    Vector r = p2.x - p1.x;
    real dist = r.length;
    real f = G * (p1.m * p2.m / dist^^2);
    return f * r/dist;
}

/// Compute gravitation force for all particles
void force(Particle[] particles)
{
    foreach(ref p; particles)
    {
        p.f = 0;
    }
    foreach(comb; particles.combinations(2))
    {
        auto f = gravity(comb[0], comb[1]);
        comb[0].f += f;
        comb[1].f -= f;
    }
}

/// Compute velocity
void velocity(Particle[] particles, real dt)
{
    foreach(ref p; particles)
    {
        p.v += p.a * dt;
    }
}

/// Update positions
void position(Particle[] particles, real dt)
{
    foreach(ref p; particles)
    {
        p.x += p.v * dt;
    }
}

void step(Particle[] particles, real dt)
{
    force(particles);
    velocity(particles, dt);
    position(particles, dt);
}