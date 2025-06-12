const std = @import("std");
const print = std.debug.print;

pub fn main() !void {
    print("Casting sample.\n", .{});

    var x: i32 = 42;
    print("x: {}\n", .{x});

    const y = @intCast(x);
    print("cast x: {}\n", .{y});
    
}