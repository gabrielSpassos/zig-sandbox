const std = @import("std");
const print = std.debug.print;

pub fn main() !void {
    print("Loops sample.\n", .{});

    var array = [_]u32{ 1, 2, 3 };

    for (array) |elem| {
        print("by val: {}\n", .{elem});
    }

    for (&array) |*elem| {
        elem.* += 100;
        print("by ref: {}\n", .{elem.*});
    }

    for (array, &array) |val, *ref| {
        print("{}: {}\n", .{ val, ref.* });
    }

    for (0.., array) |i, elem| {
        print("{}: {}\n", .{ i, elem });
    }

    for (array) |_| {}

    const m: i32 = 5;
    var i: i32 = m - 2;
    while (i >= 0) : (i -= 1) {
        std.debug.print("Index: {}\n", .{i});
    }
}
