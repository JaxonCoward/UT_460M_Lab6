force Clk 0 0ns, 1 5ns -repeat 10ns
force C 2#00111000
force B 2#00101000
force Load 1

run 20 ns

force Load 0

run 40 ns

force C 2#11100100
force B 2#00101000
force Load 1

run 20 ns

force Load 0

run 40 ns

force C 2#00110101
force B 2#10100001
force Load 1

run 20 ns

force Load 0

run 40 ns
