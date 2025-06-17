const std = @import("std");
const print = std.debug.print;

pub fn main() !void {
    print("Functions sample.\n", .{});

    const x = max(1, 2);
    print("x: {}\n", .{x});

    print("y: {}\n", .{max(5, 3)});
}

fn max(a: usize, b: usize) usize {
    if (a > b) {
        return a;
    } else {
        return b;
    }
}

test "should return 10" {
    const max_value = max(1, 10);
    try std.testing.expectEqual(10, max_value);
}

test "should return 876" {
    const max_value = max(876, 875);
    try std.testing.expectEqual(876, max_value);
}
