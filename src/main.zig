const std = @import("std");
const net = std.net;
const http = std.http;
const Router = @import("router").Router;

fn homeHandler() void {
    std.debug.print("Welcome to Zag Framework!\n", .{});
}

fn startServer() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    defer _ = gpa.deinit();

    var router = Router.init(allocator);
    defer router.deinit();

    try router.addRoute("GET", "/", homeHandler);

    // Initialize a TCP server
    var server = net.Server{
        .listen_address = try net.Address.parseIp4("127.0.0.1", 8080),
        .stream = net.Stream{ .handle = 0 },
    };
    defer server.deinit();

    const connection = try server.accept();

    std.debug.print("Server started at {}", .{connection.address});

    while (true) {
        var conn = try server.accept();
        defer conn.stream.close();

        var buffer: [1024]u8 = undefined;
        const read_size = try conn.stream.read(&buffer);
        const request = buffer[0..read_size];

        if (std.mem.indexOf(u8, request, "GET / ")) |_| {
            if (router.matchRoute("GET", "/")) |handler| {
                handler();
                _ = try conn.stream.writeAll("HTTP/1.1 200 OK\r\nContent-Length: 19\r\n\r\nWelcome to Zag!\n");
            } else {
                _ = try conn.stream.writeAll("HTTP/1.1 404 Not Found\r\nContent-Length: 13\r\n\r\n404 Not Found\n");
            }
        }
    }
}

pub fn main() !void {
    try startServer();
}
