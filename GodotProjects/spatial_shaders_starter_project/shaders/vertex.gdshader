shader_type spatial;

void vertex() 
{
	// VERTEX += vec3(0.0, 0.0, sin(5.0 * TIME));
	// VERTEX *= (sin(TIME) + 1.0) * 0.5;
	
	VERTEX.x += sin(TIME * 10.0 + VERTEX.y * 10.0) * 0.02;
}