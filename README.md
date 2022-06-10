# Belts

[//]: # (Add badges here. Gem version, Github Actions build passing and CodeClimate)

Belts is a data-oriented game engine for the ruby programming language, heavily inspired by Ruby on Rails and Unity's DOTS.

In data-oriented game development, components hold data and systems hold game logic. Belts takes advantage of this to make code more descriptive and allow plugins to hook into the main loop, enabling or disabling features depending as needed.

Belts is designed to be easy to pick up and get something shipped, ideal for hackathons and low demanding games. While performance improvements are welcome, the bulk of the features in the pipeline aim to target developer happiness (scaffolding, testing, plugin support, etc.)

## Getting Started
### Install
Install belts globally. Make sure you're running ==ruby > 3.1.2==:
```bash
gem install belts
```

### Creating a new project
Run the belts new command line. This will create a new folder with all the necessary files to get started:
```bash
# change my_game to the name of your project
belts new my_game
```

After you create the new game, switch to its folder:
```bash
# change my_game to the name of your project
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

## The Demo
A fresh project comes with a few basic but powerful examples. But to understand them we need to dive into what each of the folders in `app/` represents:

```
app/
  components/
  prefabs/
  scenes/
  systems/
```

### Components
Components are simple structs to hold data. They can also serve as tags if they don't hold any attribtues.

```ruby
# globally available
Transform = Struct.new(:position, :rotation, :scale)

# app/components/spinner.rb
Spinner = Struct.new(nil)
```

### Entities
There isn't a folder for entities because they only exist at runtime. They hold any number of Components and represent game objects: the player, the camera, an enemy or a just a cube.

### Prefabs
Prefabs are blueprints of entities. They can be used to instantiate new entities during runtime or from scenes.
```ruby
class SpinningCube < BeltsEngine::Prefab
  component :render_data, RenderData.new(:cube, Vec3.right)
  component :spinner, Spinner.new
end
```

### Scenes
Scenes declare the initial state of a game level. You just need to specify the prefab to use and where it should be placed.
```ruby
class MainScene < BeltsEngine::Scene
  prefab :Camera3d, position: Vec3.back * 5
  prefab :SpinningCube, position: Vec3.zero
end
```

### Systems
Lastly, systems! Systems are where all game logic should happen.

Each system is initiated once and then called once each frame:

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

They way to do this is by specifying a **collection**. Collections are automatically updated when components are added or removed from entities or when these are instantiated or destroyed.
