const std = @import("std");

pub fn main() !void {
    const allocator = std.heap.page_allocator;

    var dungeon1 = [_][3]i32{
        [_]i32{ -2, -3, 3 },
        [_]i32{ -5, -10, 1 },
        [_]i32{ 10, 30, -5 },
    };

    var dungeon2 = [_][1]i32{
        [_]i32{0},
    };

    const result1 = try calculateMinimumHP(allocator, &dungeon1);
    std.debug.print("Minimum initial health: {}\n", .{result1});

    const result2 = try calculateMinimumHP(allocator, &dungeon2);
    std.debug.print("Minimum initial health: {}\n", .{result2});
}

fn calculateMinimumHP(allocator: std.mem.Allocator, dungeon: anytype) !i32 {
    const m: i32 = dungeon.len;
    const n: i32 = dungeon[0].len;

    std.debug.print("Dungeon: ", .{});
    printDungeon(dungeon);

    var dp = try allocator.alloc([]i32, m);
    defer {
        for (dp) |*row| {
            allocator.free(row.*);
        }
        allocator.free(dp);
    }

    for (0.., dp) |i, *row_ptr| {
        row_ptr.* = try allocator.alloc(i32, n);
        for (dp[i]) |*cell| {
            cell.* = 0;
        }
    }

    std.debug.print("Start new board: ", .{});
    printDungeon(dp);

    dp[m - 1][n - 1] = max(1, 1 - dungeon[m - 1][n - 1]);
    std.debug.print("Fill last cell: ", .{});
    printDungeon(dp);

    var i: i32 = m - 2;
    while (i >= 0) : (i -= 1) {
        dp[@intCast(i)][n - 1] = max(1, dp[@intCast(i + 1)][n - 1] - dungeon[@intCast(i)][n - 1]);
    }

    std.debug.print("Fill last column: ", .{});
    printDungeon(dp);

    i = n - 2;
    while (i >= 0) : (i -= 1) {
        dp[m - 1][@intCast(i)] = max(1, dp[m - 1][@intCast(i + 1)] - dungeon[m - 1][@intCast(i)]);
    }

    std.debug.print("Fill last row: ", .{});
    printDungeon(dp);

    i = m - 2;
    while (i >= 0) : (i -= 1) {
        var j: i32 = n - 2;
        while (j >= 0) : (j -= 1) {
            const minHealthOnExit = min(dp[@intCast(i + 1)][@intCast(j)], dp[@intCast(i)][@intCast(j + 1)]);
            dp[@intCast(i)][@intCast(j)] = max(1, minHealthOnExit - dungeon[@intCast(i)][@intCast(j)]);
        }
    }

    std.debug.print("Remaining board: ", .{});
    printDungeon(dp);

    return dp[0][0];
}

fn printDungeon(board: anytype) void {
    const stdout = std.io.getStdOut().writer();
    for (board) |row| {
        stdout.print("[", .{}) catch {};
        for (row) |cell| {
            stdout.print("{} ", .{cell}) catch {};
        }
        stdout.print("]\n", .{}) catch {};
    }
    stdout.print("\n", .{}) catch {};
}

fn max(a: i32, b: i32) i32 {
    if (a > b) {
        return a;
    } else {
        return b;
    }
}

fn min(a: i32, b: i32) i32 {
    if (a < b) {
        return a;
    } else {
        return b;
    }
}

test "should return 7 as max" {
    const max_value = max(7, 6);
    try std.testing.expectEqual(7, max_value);
}

test "should return 8 as max" {
    const max_value = max(7, 8);
    try std.testing.expectEqual(8, max_value);
}

test "should return 9 as max" {
    const max_value = max(9, 9);
    try std.testing.expectEqual(9, max_value);
}

test "should return 7 as min" {
    const min_value = min(7, 8);
    try std.testing.expectEqual(7, min_value);
}

test "should return 8 as min" {
    const min_value = min(9, 8);
    try std.testing.expectEqual(8, min_value);
}

test "should return 9 as min" {
    const min_value = min(9, 9);
    try std.testing.expectEqual(9, min_value);
}
