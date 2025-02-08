const std = @import("std");
const Router = @import("router.zig").Router;

pub const HttpServer = struct {
    allocator: std.mem.Allocator,
    router: *Router,

    pub fn init(allocator: std.mem.Allocator, router: *Router) HttpServer {
        return HttpServer{
            .allocator = allocator,
            .router = router,
        };
    }

    pub fn serve(self: *HttpServer, address: []const u8, port: u16) !void {
        // Create a TCP listener on the given address and port.
        const listener = try std.net.tcpConnectToAddress(address);
        defer listener.close();
        std.debug.print("HTTP server listening on {s}:{d}\n", .{ address, port });

        while (true) {
            var connection = try listener.accept();
            // Handle the connection (sequentially for this basic example).
            try self.handleConnection(&connection);
            connection.close();
        }
    }

    fn handleConnection(self: *HttpServer, connection: *std.net.TcpSocket) !void {
        // Use a fixed-size buffer to read the HTTP request.
        var buffer: [1024]u8 = undefined;
        const bytes_read = try connection.read(&buffer);
        if (bytes_read == 0) return; // No data read.

        const request_str = buffer[0..bytes_read];
        std.debug.print("Received request:\n{s}\n", .{request_str});

        // Parse the first line of the HTTP request.
        const first_line_end = std.mem.indexOf(u8, request_str, "\n") orelse bytes_read;
        const first_line = request_str[0..first_line_end];

        // Expecting the request line to be in the format: "GET /path HTTP/1.1"
        const parts = std.mem.split(u8, first_line, " ");
        if (parts.len < 3) {
            try connection.writeAll("HTTP/1.1 400 Bad Request\r\n\r\n");
            return;
        }
        const method = parts[0];
        const path = parts[1];
        _ = method; // Currently, we only handle GET requests.

        // Lookup the handler for the requested path.
        const handler_opt = self.router.get_handler(path);
        var response_body: []const u8 = "";
        if (handler_opt) |handler| {
            response_body = try handler(path);
        } else {
            response_body = "404 Not Found";
        }

        // Prepare an HTTP response.
        // (Using a temporary buffer; in production, consider a dynamic buffer or streaming.)
        const response_buffer = try std.heap.page_allocator.alloc(u8, 1024);
        defer std.heap.page_allocator.free(response_buffer);
        const response = try std.fmt.bufPrint(response_buffer, "HTTP/1.1 200 OK\r\nContent-Length: {d}\r\nContent-Type: text/html\r\n\r\n{s}", .{ response_body.len, response_body });
        try connection.writeAll(response);
    }
};
