import std.conv;
import std.container;
import std.range;
import std.stdio;
import std.algorithm;

import raylib;

import simulation;
import data;
import visualization;

void main()
{
	Particle p1 = Particle(Vector(0.3),Vector(-0.3, 0.4),Vector(0),1,5);
	Particle p2 = Particle(Vector(0.7),Vector(0.3, -0.4),Vector(0),1,5);
	Particle p3 = Particle(Vector(0.5),Vector(0),Vector(0),1000000000,10);
	DList!Vector t1;
	DList!Vector t2;
	foreach(i; 0..300)
	{
		t1.insertFront(p1.x);
		t2.insertFront(p2.x);
	}
	Particle[] particles = [p1, p2, p3];

	real dt = 0.01;

	int window = 800;
	SetTargetFPS(60); 
	InitWindow(window, window, "Hello, Raylib-D!");
	while (!WindowShouldClose())
	{
		BeginDrawing();
		ClearBackground(RAYWHITE);
		trace(particles[0], t1);
		trace(particles[1], t2);
		foreach(line; zip(t1[], t1[].dropOne))
		{
			Vector pos1 = line[0] * window;
			Vector pos2 = line[1] * window;
			DrawLine(pos1.x.to!int, pos1.y.to!int, pos2.x.to!int, pos2.y.to!int, GREEN);
		}
		foreach(line; zip(t2[], t2[].dropOne))
		{
			Vector pos1 = line[0] * window;
			Vector pos2 = line[1] * window;
			DrawLine(pos1.x.to!int, pos1.y.to!int, pos2.x.to!int, pos2.y.to!int, BLACK);
		}
		foreach(p; particles)
		{
			Vector pos = p.x * window;
			DrawCircle(pos.x.to!int, pos.y.to!int, p.r, BLACK);
		}
		foreach(i; 0..10)
			step(particles, dt);

		//DrawText("Hello, World!", 400, 300, 28, BLACK);
		EndDrawing();
	}
	CloseWindow();
}
