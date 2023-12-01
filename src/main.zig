const std = @import("std");

pub fn main() !void {
    const file = try std.fs.cwd().openFile("input.txt", .{});
    defer file.close();

    var bufReader = std.io.bufferedReader(file.reader());
    var inStream = bufReader.reader();

    var sum: u32 = 0;
    var buf: [1024]u8 = undefined;
    while (try inStream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        var firstNumber: i8 = -1;
        var lastNumber: i8 = -1;

        // Loops over each character in the line and finds the first and last numbers
        for (line) |char| {
            if (char >= '1' and char <= '9') {
                if (firstNumber == -1) {
                    firstNumber = @as(i8, @intCast(char - '0'));
                }
                lastNumber = @as(i8, @intCast(char - '0'));
            }
        }

        // Concatenates the first and last numbers into a single number
        const number: i8 = firstNumber * 10 + lastNumber;

        // Adds the number to the sum
        sum += @as(u32, @intCast(number));
    }

    std.debug.print("sum: {}\n", .{sum});
}
