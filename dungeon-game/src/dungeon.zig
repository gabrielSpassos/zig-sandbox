const std = @import("std");

pub fn main() !void {
    const allocator = std.heap.page_allocator;

    var dungeon1 = [_][3]i32{
        [_]i32{ -2, -3, 3 },
        [_]i32{ -5, -10, 1 },
        [_]i32{ 10, 30, -5 },
    };

    var dungeon2 = [_][1]i32{
        [_]i32{ 0 },
    };

    const result1 = try calculateMinimumHP(allocator, &dungeon1);
    std.debug.print("Minimum initial health: {}\n", .{result1});

    const result2 = try calculateMinimumHP(allocator, &dungeon2);
    std.debug.print("Minimum initial health: {}\n", .{result2});
}

fn calculateMinimumHP(allocator: std.mem.Allocator, dungeon: anytype) !i32 {
    const m = dungeon.len;
    const n = dungeon[0].len;

    std.debug.print("Dungeon: ", .{});
    printDungeon(dungeon);

    var dp = try allocator.alloc([]i32, m);
    defer {
        for (dp) |*row| {
            allocator.free(row.*);
        }
        allocator.free(dp);
    }

    for (dp) |*row_ptr, i| {
        row_ptr.* = try allocator.alloc(i32, n);
        for (dp[i]) |*cell| {
            cell.* = 0;
        }
    }

    std.debug.print("Start new board: ", .{});
    printDungeon(dp);

    dp[m-1][n-1] = std.math.max(1, 1 - dungeon[m-1][n-1]);
    std.debug.print("Fill last cell: ", .{});
    printDungeon(dp);

    for (i32(m) - 2..0) |i| {
        dp[@intCast(usize, i)][n-1] = std.math.max(1, dp[@intCast(usize, i+1)][n-1] - dungeon[@intCast(usize, i)][n-1]);
    }
    std.debug.print("Fill last column: ", .{});
    printDungeon(dp);

    for (i32(n) - 2..0) |j| {
        dp[m-1][@intCast(usize, j)] = std.math.max(1, dp[m-1][@intCast(usize, j+1)] - dungeon[m-1][@intCast(usize, j)]);
    }
    std.debug.print("Fill last row: ", .{});
    printDungeon(dp);

    for (i32(m) - 2..0) |i| {
        for (i32(n) - 2..0) |j| {
            const minHealthOnExit = std.math.min(
                dp[@intCast(usize, i+1)][@intCast(usize, j)],
                dp[@intCast(usize, i)][@intCast(usize, j+1)]
            );
            dp[@intCast(usize, i)][@intCast(usize, j)] = std.math.max(1, minHealthOnExit - dungeon[@intCast(usize, i)][@intCast(usize, j)]);
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
