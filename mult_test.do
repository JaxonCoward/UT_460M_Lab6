force clk 0 0ns, 1 5ns -repeat 10ns
force {A[7]} 0
force {A[6]} 0
force {A[5]} 1
force {A[4]} 1
force {A[3]} 1
force {A[2]} 0
force {A[1]} 0
force {A[0]} 0

force {B[7]} 0
force {B[6]} 0
force {B[5]} 1
force {B[4]} 0
force {B[3]} 1
force {B[2]} 0
force {B[1]} 0
force {B[0]} 0

force start 1

run 20 ns

force start 0

run 200 ns
