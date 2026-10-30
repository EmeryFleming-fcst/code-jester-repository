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
- Introduction
	- Godot uses Meters. 1 Unit = 1 Meter.
![[introduction_to_3d_coordinate_systems 1.webp]]
- Blender Style Shortcuts:
	- Editor Setting Shortcut's Tab
		- Begin Translate Transform to G
		- Begin Rotate Transform to R
		- Bring Scale Transform to S
		- Unbind Scale Mode
- Using 3D Transforms
	- Euler Angles
		- Problem: Orientation is dependent on the orientation of the previous one.
		- Rotation Order is Important!
		- Solution: Do not use the rotation property of Node3D! Use Transform.Basis
		- Basis + Origin = Transform.
		- Precision Errors:
			- Doing successive operations on transforms will result in a loss of precision due to floating-point error.
			- One solution is to call orthonormalized, but it will cause scale to be lost.
			- It is recommended to not scale nodes that are going to be manipulated, but their children instead.
		- Transforms are meant to be used with Vectors. Keep track of things like angles outside of them.
		- Can use Quaternions for nearest interpolation.
- Procedural Geometry
	- Three Tools: ArrayMesh, SurfaceTool, and ImmediateMesh
- 3D Text
	- Label3D faster, more robust fonts, but limited interaction with the environment.
	- TextMesh can have actual depth.
	- Projected Control: Project a 2D node onto 3D space. More complicated. Use if BBCode or Control theming support is needed.
- Rendering
	- Limitations
		- Texture Sizes
			- Larger than 8192 x 8192 might not be supported for desktops.
			- 4096 x 4096 maximum for mobile.
			- Process -> Size Limit can reduce dimension's during import.
		- Color Banding
			- Project Settings -> Rendering -> Anti-Aliasing. Cheap. Applies a full-screen debanding Shader as post-processing.
			- Custom shaders or baking some noise into the textures also works.
		- Depth Buffer Precision
			- To increase depth buffer precision, increase a Camera's Near property and lower it's far. Tradeoffs.
		- Transparency Sorting
			- Transparent after Opaque.
			- If Objects sorted improperly, tweak Render Priority on material or sorting offset on Node.
			- Can split a material into a transparent part and opaque part.
			- It texture has mostly fully opaque and fully transparent, try Alpha Testing instead of Alpha Blending. 
	- Lighting
		- Light limits, by default, depend on the render.
		- See Lights and Shadows as needed: https://docs.godotengine.org/en/stable/tutorials/3d/lights_and_shadows.html
	- Decals
		- Projected Textures
		- Useful for:
			- Static Decorations
			- Bullet Impacts and explosions
			- Blob Shadows
		- Rendering Performance is mostly determined by screen coverage. Many small is better than a few large.
	- Physical Light and Camera Units
		- Physicals Units: Photorealism. Useful when porting from 3D software.
		- Downside: Must manage dynamic range yourself.
	- Particle Systems
		- GPU vs CPU Variants
	- HDR Lighting (Look more into this)
		- sRGB -> Display Linear and Display Linear -> sRGB must both be enabled.
	- Global Illumination
		- Reflection Probe
		- LightmapGI
		- VoxelGI
		- Screen-Space Indirect Lighting
		- SDFGI
	- Environment and Post-Processing
		- Use the world-environment node
		- Background: Displays an image or color. Changes how objects are affected by the ambient and reflected light.
		- Sky Material
			- Can also create custom shader.
		- Ambient Light
			- Background, Color, Sky, or Disabled.
		- Reflected Light
			- Specular Light. Background, Disabled, Sky
		- Tonemap
			- Linear: Simple and Fast.
			- Reinhard: Slower than linear. Dull and low contrast. Rolls off brights.
			- Filmic: Slightly slower than Reinhard.
			- ACES: Desaturates bright values. Slightly slower that filmic. 
			- AgX: Similar to ACES. Slowest. Best at maintaining the hue of colors as they become brighter.
	- Mid- and post-processing effects
		- Screen Space Reflections
			- Most sense when objects are in contact. 
			- Real time
			- Won't reflect transparent materials.
		- Screen-Space Ambient Occlusion
			- Only works with Ambient light by default.
			- Make the darks, darker
			- Looks best when combined with a real source of indirect light, like VoxelGI
		- Screen-Space Indirect Lighting
			- Meant to complement other Global Illuminations.
			- Only provides indirect lighting
		- Signed Distance Field Global Illumination
			- Real Time
		- Glow
			- Can also be used to blur the screen
		- Fog
			- Depth Fog: Based on Distance to Camera
			- Height Fog: Applied to objects beyond a certain height threshold (above or below)
		- Volumetric Fog
			- Fog affected by the lights that traverse the fog.
		- BCS
			- Brightness, Contrast, Saturation, Color Correction
	- Camera Attribute Options
		- Depth of Field / Far Blur
		- Depth of Field / Near Blur
		- Exposure
	- Volumetric Fog and Fog Volumes
		- Volumetric Fog can be used for lighting
		- Fog Volumes can restrict it
	- Antialiasing 
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
