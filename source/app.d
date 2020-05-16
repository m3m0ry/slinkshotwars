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
	auto game = Game.randomInitialization(0.01);

	int window = 800;

	SetTargetFPS(60); 
	InitWindow(window, window, "Slinkshot Wars");
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
