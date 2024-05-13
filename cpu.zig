const std = @import("std");
pub const CPU = struct {
    ram: [4096]u8,
    registers: [16]u8,
    delay: u8,
    sound: u8,
    PC: u16,
    SP: u16,
    stack: [16]u16,
    pub fn init() CPU {
        return CPU{ .ram = std.mem.zeroes([4096]u8), .registers = std.mem.zeroes([16]u8), .delay = 0, .sound = 0, .PC = 0x200, .SP = 0, .stack = std.mem.zeroes([16]u16) };
    }
    pub fn readFont(cpu: *CPU, rom: []const u8) void {
        for (0..rom.len) |i| {
            cpu.ram[i] = rom[i];
        }
    }
    pub fn loadRom(cpu: *CPU, rom_buf: []const u8) void {
        for (0..rom_buf.len) |i| {
            cpu.ram[i + 0x200] = rom_buf[i];
        }
    }
    pub fn readOpcode(cpu: *CPU) bool {
        const hightBit: u8 = cpu.ram[cpu.PC];
        //const shift: u8 = 8;
        const opcode = std.math.shl(u16, hightBit, 8) | cpu.ram[cpu.PC + 1];
        if (opcode == 0) {
            return false;
        }
        cpu.PC += 2;
        std.debug.print("current opcode 0x{X:0>4}\n", .{opcode});
        return true;
    }
};
