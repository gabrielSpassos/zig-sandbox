const std = @import("std");
const print = std.debug.print;

pub fn main() !void {
    print("Matrix sample.\n", .{});

    const matrix = [_][2]i32{
        [_]i32{ 1, 2 },
        [_]i32{ 3, 4 },
        [_]i32{ 5, 6 },
    };

    print("Matrix: {any}", .{matrix});
}
