const std = @import("std");
const print = std.debug.print;

pub fn main() !void {
    print("Matrix sample.\n", .{});

    const matrix = [_][2]i32{
        [_]i32{ 1, 2 },
        [_]i32{ 3, 4 },
        [_]i32{ 5, 6 },
    };

    print("Matrix: {any}\n", .{matrix});

    const matrix_size = try get_user_matrix_size();
    print("Matrix size: {d}\n", .{matrix_size});
}

fn get_user_matrix_size() !i64 {
    print("Type matrix[m][m] size: ", .{});

    var input: [10]u8 = undefined;
    const stdin = std.io.getStdIn().reader();

    const trimmed = try stdin.readUntilDelimiter(&input, '\n');

    print("The user entered: {s}\n", .{trimmed});
    const parsed = std.fmt.parseInt(i64, trimmed, 10) catch {
        print("Invalid input! Please enter a valid integer.\n", .{});
        return error.InvalidInput;
    };
    return parsed;
}
