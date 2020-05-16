import std.conv;
import std.container;
import std.range;
import std.random;
import std.stdio;
import std.algorithm;


import raylib;

import simulation;
import data;
import visualization;
import game;

void main()
{
	Particle[] particles;
	foreach(i; 0..10)
	{
		particles ~= Particle(Vector(uniform01, uniform01), Vector(uniform01, uniform01), Vector(), uniform01 * 10^^3, uniform01*0.01);
	}
	particles ~= Particle(Vector(0.5),Vector(0),Vector(0),10000000000,0.01);

	particles = [];
	particles ~= Particle(Vector(0.3, 0.5),Vector(0.6, 0),Vector(0),1,0.005);
	particles ~= Particle(Vector(0.7, 0.5),Vector(-0.3, 0),Vector(0),1,0.005);
	//Particle[] particles = [p1, p2, p3];

	particles = [];

	auto game = Game.randomInitialization(0.01);

	int window = 800;

	SetTargetFPS(60); 
	InitWindow(window, window, "Hello, Raylib-D!");
	scope(exit) 
		CloseWindow;
	while (!WindowShouldClose)
	{
		BeginDrawing;
		scope(exit) EndDrawing;
		ClearBackground(RAYWHITE);
		//TODO 
		foreach(p; game.planets)
		{
			Vector pos = ((p.x+1)/2) * window;
			DrawCircle(pos.x.to!int, pos.y.to!int, p.r*window/2, BLACK);
		}
		//foreach(i; 0..10)
		//	step(particles, dt);
		game.step;

		// TODO scale dt if fps drops?
	}
}
