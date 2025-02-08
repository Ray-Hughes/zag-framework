# Zag Framework

Zag is a minimalistic web framework written in Zig, inspired by Ruby on Rails. It provides an MVC-based structure to help developers build web applications quickly and efficiently.

## Features
- **Routing**: Define URL mappings to controller actions.
- **Middleware Support**: Extend functionality using a middleware system.
- **Templating**: Render dynamic HTML responses.
- **Database Integration**: ORM-style model interactions (Planned).
- **Scaffolding**: Code generation for models, controllers, and views (Planned).

## Installation
1. Install [Zig](https://ziglang.org/download/)
2. Clone this repository:
```sh
git clone https://github.com/yourusername/zag_framework.git
cd zag_framework
```

3. Build the project:
```sh
zig build
```

## Usage
Start the server
```sh
zig build run
```

Example Routes
```zig
try router.get("/", homeHandler);
try router.get("/about", aboutHandler);
```

Roadmap
* [ ] Routing System
* [ ] Middleware
* [ ] Model Layer (ActiveRecord-like)
* [ ] View Layer (HTML Templating)
* [ ] CLI (zag new MyApp)
* [ ] HTTP Server Integration

## Contributing

Feel free to open issues and contribute!
