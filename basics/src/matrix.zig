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

    const matrix_size = try get_user_matrix_size();
    print("Matrix size: {s}\n", .{matrix_size});
}

fn get_user_matrix_size() !i64 {
    print("Type matrix[m][m] size: ", .{});

    var input: [10]u8 = undefined;
    const stdin = std.io.getStdIn().reader();

    _ = try stdin.readUntilDelimiter(&input, '\n');

    print("The user entered: {s}\n", .{input});
    return std.fmt.parseInt(i64, &input, 10);
}
