const std = @import("std");
const Io = std.Io;

const rrt = @import("base");

const Format = enum { Console, HTML };

const CmdArgsError = error{InvalidFormat};

/// A struct containing parsed command-line arguments that are relevant/needed
/// for the app to run.
const CmdArgs = struct {
    filePath: [:0]const u8,
    format: Format,

    /// Tries to set the report's format based on a provided string argument.
    /// If an invalid value is provided, then an error is returned.
    pub fn setFormat(self: *CmdArgs, fmt: [:0]const u8) !void {
        self.format = std.meta.stringToEnum(Format, fmt) orelse
            return CmdArgsError.InvalidFormat;
    }
};

pub fn main(init: std.process.Init) !void {
    // This is appropriate for anything that lives as long as the process.
    const arena: std.mem.Allocator = init.arena.allocator();

    const args = try parseArgs(arena, init.minimal.args);
    std.debug.print("Parsed args: {s}, {}\n", .{ args.filePath, args.format });

    const io = init.io;
    const fileContent = readConfigFile(io, args.filePath);
    std.debug.print("content:\n{s}\n", .{fileContent});
}

fn parseArgs(aloc: std.mem.Allocator, args: std.process.Args) !CmdArgs {
    const slice = try args.toSlice(aloc);

    var result: CmdArgs = .{ .filePath = undefined, .format = undefined };
    for (slice, 0..) |val, i| {
        if (std.mem.eql(u8, val, "-c")) {
            result.filePath = slice[i + 1];
        } else if (std.mem.eql(u8, val, "-f")) {
            try result.setFormat(slice[i + 1]);
        }
    }

    return result;
}

fn readConfigFile(io: Io, path: []const u8) []u8 {
    const file: Io.File =
        Io.Dir.cwd().openFile(io, path, .{}) catch |err| label: {
            std.log.err("unable to open file, reason: {}", .{err});
            break :label .stderr();
        };

    var buffer: [1024]u8 = undefined;
    const reader = &file.reader(io, &buffer).interface;
    while (reader.takeDelimiterExclusive('\n')) |line| {
        std.debug.print("{s}", .{line});
    }

    return buffer;
}
