# Belts

[//]: # (Add badges here. Gem version, Github Actions build passing and CodeClimate)

Belts is a data-oriented game engine for the ruby programming language, heavily inspired by Ruby on Rails and Unity's DOTS.

In data-oriented game development, components hold data and systems hold game logic. Belts takes advantage of this to make code more descriptive and allow plugins to hook into the main loop, enabling or disabling features depending as needed.

Belts is designed to be easy to pick up and get something shipped, ideal for hackathons and low demanding games. While performance improvements are welcome, the bulk of the features in the pipeline aim to target developer happiness (scaffolding, testing, plugin support, etc.)

# Getting Started
## Install
Install belts globally. Make sure you're running ==ruby > 3.1.2==:
```bash
gem install belts
```

## Create a new project
Run the belts new command line. This will create a new folder with all the necessary files to get started:
```bash
belts new my_game
```

After you create the new game, switch to its folder:
```bash
cd my_game
```

Install dependencies:
```bash
bundle install
```

Start the game:
```bash
belts start
```

[//]: # (Add gif of the demo scene)

# Usage
A fresh project comes with a few basic but powerful examples. But to understand them we need to dive into what each of the folders in `app/` represents:

```
app/
  components/
  prefabs/
  scenes/
  systems/
```

## Components
Components are simple structs to hold data. They can also serve as tags if they don't hold any attribtues.

```ruby
# built-in component
Transform = Struct.new(:position, :rotation, :scale)

# app/components/spinner.rb
Spinner = Struct.new(nil)
```

## Entities
There isn't a folder for entities because they only exist during runtime. They hold any number of Components and represent game objects: the player, the camera, an enemy or a just a cube.

## Prefabs
Prefabs are blueprints of entities. They can be used to describe what entities should look like and be saved for later use. They can then be used to instantiate new entities during runtime or from scenes.
```ruby
class SpinningCube < BeltsEngine::Prefab
  component :render_data, RenderData.new(:cube, Vec3.right)
  component :spinner, Spinner.new
end
```

## Scenes
Scenes declare the initial state of a game level. You just need to specify the prefabs to use and where they should be placed.
```ruby
class MainScene < BeltsEngine::Scene
  prefab :Camera3d, position: Vec3.back * 5
  prefab :SpinningCube, position: Vec3.zero
end
```

## Systems
Lastly, systems! Systems are where all game logic happens.

Each system is initialised once and then called once each frame:

```ruby
class FrameCountSystem < BeltsEngine::System
  def start
    @current_frame = 0
  end

  def update
    puts @current_frame
    @current_frame += 1
  end
end
```

While there are some use cases for simple systems like the above, most of the time they will interact with entities and their components.

They way to do this is by specifying a **collection**. Behind the scenes, collections are automatically updated when components are added or removed from entities or when these are instantiated or destroyed.

```ruby
class SpinnerSystem < BeltsEngine::System
  collection :spinners,
    with: [:transform, :spinner]

  def update
    speed = @time.delta_time * 30

    spinners.each_with_components do |transform:, **|
      transform.rotation.x += speed
      transform.rotation.y += speed
      transform.rotation.z += speed
    end
  end
end
```

# Tools
Tools are libraries, independent from the current scene, that hold global data and can be accessed from systems. Currently, there are only two tools: input and time. Plugins can register other tools and that's the expected way to add new features to the engine (audio, asset management, physics).

The default way to use them is through the `@game` reference (e.g. `@game.time` or using the shortcut `@time`).

## Time
Time includes two read-only properties:
- uptime - time since the game started
- delta_time - time since last frame

## Input
Input gives access to information about the keyboard and mouse state. Examples:
```ruby
@input.key?(:a) # true if A is being pressed
@input.key_down?(:a) # true once, when A is pressed down
@input.key_up?(:a) # true once, when A is released

@input.button?(:mouse_1) # true if the mouse 1 button is being pressed
@input.button_down?(:mouse_1) # true once, when the mouse 1 button is pressed down
@input.button_up?(:mouse_1) # true once, when the mouse left button is released

@input.mouse(:x) # x position on the screen in pixels (from top-left)
@input.mouse(:y) # y position on the screen in pixels (from top-left)
```
