const std = @import("std");
const print = std.debug.print;

pub fn main() !void {
    print("Console Input sample.\n", .{});

    var input: [5]u8 = undefined;
    const stdin = std.io.getStdIn().reader();

    _ = try stdin.readUntilDelimiter(&input, '\n');

    print("The user entered: {s}\n", .{input});
}
