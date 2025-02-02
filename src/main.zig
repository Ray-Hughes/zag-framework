const std = @import("std");
const Router = @import("router/router.zig").Router;

fn homeHandler() void {
    std.debug.print("Welcome to Zag Framework!\n", .{});
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    defer _ = gpa.deinit();

    var router = Router.init(allocator);
    defer router.deinit();

    try router.addRoute("GET", "/", homeHandler);

    if (router.matchRoute("GET", "/")) |handler| {
        handler();
    } else {
        std.debug.print("404 Not Found\n", .{});
    }
}
