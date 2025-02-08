const std = @import("std");
const Router = @import("router.zig").Router;
const HttpServer = @import("http_server.zig").HttpServer;

pub fn main() !void {
    const allocator = std.heap.page_allocator;

    var router = try Router.init(allocator);
    defer router.deinit();

    // Define routes with their corresponding handlers.
    try router.get("/", homeHandler);
    try router.get("/about", aboutHandler);

    std.debug.print("Starting Zag Framework Server...\n", .{});

    // Create and run the HTTP server.
    var http_server = HttpServer.init(allocator, &router);
    try http_server.serve("0.0.0.0", 8080);
}

// Sample route handler functions.
fn homeHandler(req: []const u8) ![]const u8 {
    _ = req;
    return "Welcome to Zag Framework!";
}

fn aboutHandler(req: []const u8) ![]const u8 {
    _ = req;
    return "About Zag Framework";
}
