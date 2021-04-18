force Clk 0 0ns, 1 5ns -repeat 10ns
force {C[7]} 0
force {C[6]} 0
force {C[5]} 1
force {C[4]} 1
force {C[3]} 1
force {C[2]} 0
force {C[1]} 0
force {C[0]} 0

force {B[7]} 0
force {B[6]} 0
force {B[5]} 1
force {B[4]} 0
force {B[3]} 1
force {B[2]} 0
force {B[1]} 0
force {B[0]} 0

force Load 1

run 20 ns

force Load 0

run 40 ns

force {C[7]} 1
force {C[6]} 1
force {C[5]} 1
force {C[4]} 1
force {C[3]} 0
force {C[2]} 1
force {C[1]} 0
force {C[0]} 0

force {B[7]} 0
force {B[6]} 0
force {B[5]} 1
force {B[4]} 0
force {B[3]} 1
force {B[2]} 0
force {B[1]} 0
force {B[0]} 0

force Load 1

run 20 ns

force Load 0

run 40 ns

force {C[7]} 0
force {C[6]} 0
force {C[5]} 1
force {C[4]} 1
force {C[3]} 0
force {C[2]} 1
force {C[1]} 0
force {C[0]} 1

force {B[7]} 1
force {B[6]} 0
force {B[5]} 1
force {B[4]} 0
force {B[3]} 0
force {B[2]} 0
force {B[1]} 0
force {B[0]} 1

force Load 1

run 20 ns

force Load 0

run 40 ns
