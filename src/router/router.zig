const std = @import("std");

pub const Route = struct {
    method: []const u8,
    path: []const u8,
    handler: *const fn () void,
};

pub const Router = struct {
    allocator: std.mem.Allocator,
    routes: std.ArrayList(Route),

    pub fn init(allocator: std.mem.Allocator) Router {
        return Router{
            .allocator = allocator,
            .routes = std.ArrayList(Route).init(allocator),
        };
    }

    pub fn deinit(self: *Router) void {
        self.routes.deinit();
    }

    pub fn addRoute(self: *Router, method: []const u8, path: []const u8, handler: *const fn () void) !void {
        try self.routes.append(Route{ .method = method, .path = path, .handler = handler });
    }

    pub fn matchRoute(self: *Router, method: []const u8, path: []const u8) ?*const fn () void {
        for (self.routes.items) |route| {
            if (std.mem.eql(u8, route.method, method) and std.mem.eql(u8, route.path, path)) {
                return route.handler;
            }
        }
        return null;
    }
};
