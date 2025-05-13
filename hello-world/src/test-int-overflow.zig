test "integer overflow at compile time" {
    const x: u8 = 255;
    _ = x + 1;
}

test "integer overflow at runtime" {
    var x: u8 = 255;
    x += 1;
}

test "actually undefined behavior" {
    @setRuntimeSafety(false);
    var x: u8 = 255;
    x += 1; // XXX undefined behavior!
}
