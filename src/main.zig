const std = @import("std");
const Router = @import("router.zig");

pub fn main() !void {
    const allocator = std.heap.page_allocator;

    var router = try Router.init(allocator);
    defer router.deinit();

    // Define routes
    try router.get("/", homeHandler);
    try router.get("/about", aboutHandler);

    std.debug.print("Starting Zag Framework Server...\n", .{});

    // Simulated HTTP server loop (Placeholder for real server)
    try router.serve();
}

// Sample route handlers
fn homeHandler(req: []const u8) ![]const u8 {
    _ = req;
    return "Welcome to Zag Framework!";
}

fn aboutHandler(req: []const u8) ![]const u8 {
    _ = req;
    return "About Zag Framework";
}
