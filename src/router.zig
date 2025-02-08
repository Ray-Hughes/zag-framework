const std = @import("std");

pub const Router = struct {
    allocator: std.mem.Allocator,
    routes: std.StringHashMap(*const fn ([]const u8) anyerror![]const u8),

    pub fn init(allocator: std.mem.Allocator) !Router {
        return Router{
            .allocator = allocator,
            .routes = std.StringHashMap(*const fn ([]const u8) anyerror![]const u8).init(allocator),
        };
    }

    pub fn deinit(self: *Router) void {
        self.routes.deinit();
    }

    pub fn get(self: *Router, path: []const u8, handler: *const fn ([]const u8) anyerror![]const u8) !void {
        try self.routes.put(path, handler);
    }

    pub fn serve(self: *Router) !void {
        var it = self.routes.iterator();
        while (it.next()) |entry| {
            std.debug.print("Route: {s}\n", .{entry.key_ptr.*});
        }
    }
};
