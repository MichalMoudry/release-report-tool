const std = @import("std");
const Io = std.Io;

const rrt = @import("base");

pub fn main(init: std.process.Init) !void {
    // Prints to stderr, unbuffered, ignoring potential errors.
    std.debug.print("All your {s} are belong to us.\n", .{"codebase"});

    // This is appropriate for anything that lives as long as the process.
    const arena: std.mem.Allocator = init.arena.allocator();

    // Accessing command line arguments:
    const args = try init.minimal.args.toSlice(arena);
    for (args) |arg| {
        std.log.info("arg: {s}", .{arg});
    }

    const io = init.io;

    read_config_file(io, "config.json");
    // const file: Io.File = Io.Dir.cwd().openFile(io, "config.json", .{}) catch |err| label: {
    //     std.log.err("unable to open config file, reason: {}", .{err});
    //     break :label .stderr();
    // };
    // defer file.close(io);

    // var buffer: [1024]u8 = undefined;
    // var file_reader = file.reader(io, &buffer);
    // const reader = &file_reader.interface;

    // std.debug.print("Config:\n", .{});
    // while (reader.takeDelimiterInclusive('\n')) |line| {
    //     std.debug.print("{s}\n", .{line});
    // } else |err| {
    //     std.log.err("config file read error: {}", .{err});
    //     return;
    // }
}

fn read_config_file(io: Io, path: []u8) void {
    const file: Io.File =
        Io.Dir.cwd().openFile(io, path, .{}) catch |err| label: {
            std.log.err("unable to open config file, reason: {}", .{err});
            break :label .stderr();
        };
    defer file.close(io);

    var buffer: [1024]u8 = undefined;
    const reader = &file.reader(io, &buffer).interface;

    const line_read = read_line(reader);
    switch (line_read) {
        //Io.Reader.DelimiterError.EndOfStream =>
    }

    //while (line_read != Io.Reader.DelimiterError.EndOfStream) {}
    //var temp = reader.takeDelimiterInclusive('\n');
}

fn read_line(reader: *const Io.Reader) ![]u8 {
    return reader.takeDelimiterExclusive('\n');
}
