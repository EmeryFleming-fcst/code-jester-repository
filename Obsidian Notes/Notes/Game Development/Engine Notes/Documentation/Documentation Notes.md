List of Features
- Visual Profiler
- Performance Monitoring Tools
- Game Embedding
- Video Playback
- Movie Maker Mode
FAQ
- Self-Contained Mode
https://docs.godotengine.org/en/stable/about/complying_with_licenses.html
Introduction to Godot
- Asset Library -> Template Projects
- Project Settings from Home Page
- GDExtension

Best Practices
- Still, autoloaded nodes can simplify your code for systems with a wide scope. If the autoload is managing its own information and not invading the data of other objects, then it's a great way to create systems that handle broad-scoped tasks. For example, a quest or a dialogue system.
- Use process for a framerate dependent delta time between frames.
- Use physics_process when you need a framerate-independent delta time between frames.
- Check for Input in input.
- Method Life Cycle
	- init is called down the tree
	- enter_tree calls cascade down the tree
	- ready is called moving back upwards

Data Preferences
- Array vs Dictionary vs Object
	- Array: Fastest Iteration.
	- Dictionary: Insert, Erase, Move fastest. Fastest Get/Set.
	- Object: Can create custom data structures. But slower.
- Enumerations: Int vs String
	- use ints unless you want to print the value
- AnimatedTexture vs AnimatedSprite2D vs AnimationPlayer vs AnimationTree
	- AnimatedTexture when you don't need a lot of control.
	- AnimatedSprite2D can create more complex animation sequences.
	- AnimationPlayer if you need to trigger effects.
	- AnimationTree: Smoothly blend and transition.
- Logic Preferences
	- Load vs Preload
		- Do not use preload if one cannot determine when a script might load.
		- If something could replace the value, never preload it.
		- If one wishes to import another class resource, use a preloaded constant.
			- If a script has many dependencies one might want to unload/load, at runtime.
- Large Levels: Static vs Dynamic
	- Memory vs Speed
	- Use static levels for smaller games.
	- Medium to Large games should have a library or plugin that manages nodes and resources with code.
https://docs.godotengine.org/en/stable/tutorials/troubleshooting.html#

Editor Introduction
- Project Manager
	- Tagging system for projects!
- Inspector Dock
	- Can favorite properties you change a lot!
- Customizing the Interface
	- Editor Settings
https://docs.godotengine.org/en/stable/tutorials/editor/command_line_tutorial.html
- Profiles
	- Can save and export custom editor profiles

2D
- Rendering
	- CanvasModulate darkens scene
	- Light 2D effects
	- Additive sprites can be used as a more performant alternative, with tradeoffs
- 2D antialiasing
	- Antialiasing as a property
	- MSAA
- 2D Parallax
	- Parallax2D node
- 2D Tools
	- Tilesets and Tilemaps
3D
- Read when needed

Animation

Assets Pipeline

Audio
- Read when needed

Export

File and Data I/O

Internalization

Input Handling

Math

Navigation

Performance

Physics

Platform Specific

Plugins

Rendering

Scripting

Shaders

UI
