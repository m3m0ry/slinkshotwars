module game;

import std.container;
import std.stdio;

import data;
import simulation;
import player;

/// Game class combines all information
class Game {
    this(Particle[] planets, Particle[] asteroids, real dt)
    {
        this.planets = planets;
        this.asteroids = asteroids;
        this.dt = dt;
    }

    static Game fileInitialization()
    {
        return new Game([], [], 0.0);
    }

    static Game randomInitialization()
    {
        return new Game([], [], 0.0);
    }

    void step()
    {
        /*
        1) Calculate force of everything
        2) Update velocity and position
        3) check for collisions
            a) planets - planets -> spawns more asteroids, merges planets
            b) planets - asteroids -> planet eats asteroid or asteroid just vanishes
            c) planets - player -> player dies
            d) asteroids - player -> player takes dmg, asteroid vanishes?
        */
        asteroids[].acceleration;
        planets[].acceleration.velocity(dt).position(dt);
        asteroids[].velocity(dt).position(dt);

        planets = planets.collision;
    }

    DList!Particle planets;
    DList!Particle asteroids;
    Player player;
    real dt;
}