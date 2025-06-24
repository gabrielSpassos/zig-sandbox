const std = @import("std");
const print = std.debug.print;

pub fn main() !void {
    print("Casting sample.\n", .{});

    const x: i32 = 42;
    print("x: {}\n", .{x});

    const y: u8 = @intCast(x);
    print("cast y: {}\n", .{y});

    const z: usize = @intCast(x);
    print("cast z: {}\n", .{z});

    const a: i32 = @intCast(x);
    print("cast a: {}\n", .{a});
}
