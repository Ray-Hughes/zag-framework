```
# Zag Framework

Zag is a minimalistic web framework written in Zig, inspired by Ruby on Rails.

## Features
- **Routing**: Define URL mappings to controller actions.
- **HTTP Server Integration**: A built-in, basic HTTP server that listens for incoming connections and dispatches requests to appropriate handlers.
- **Middleware Support**: (Planned) Extend functionality using a middleware system.
- **Templating**: (Planned) Render dynamic HTML responses.
- **Database Integration**: (Planned) ORM-style model interactions.
- **Scaffolding**: (Planned) Code generation for models, controllers, and views.

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
Start the server:
```sh
zig build run
```
By default, the server listens on `0.0.0.0:8080`. Access it via your browser or a tool like `curl`.

## Example Routes
```zig
try router.get("/", homeHandler);
try router.get("/about", aboutHandler);
```

## Roadmap
- [x] Routing System
- [x] HTTP Server Integration
- [ ] Middleware
- [ ] Model Layer (ActiveRecord-like)
- [ ] View Layer (HTML Templating)
- [ ] CLI (`zag new MyApp`)

## Contributing
Feel free to open issues and contribute!
```
