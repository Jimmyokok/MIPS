`define PATH_PREFIX "D:/Vivado/Projects/Single-cycle/"
`define NAME "benchtest/"

module cpu_tb();

wire mem_write, cpu_clk, finish, cpu_mem_write;
wire [31:0] pc, instr, read_data, write_data, cpu_data_addr;

reg clk, reset;
reg [31:0] tb_data_addr, tb_dmem_data, pc_finished;

string summary;
// test variables
integer fans, frun, fimem, fdmem, error_count, imem_counter, dmem_counter;

// module instances
mips mips(.clk(cpu_clk), .reset(reset), .pc(pc), .instr(instr), .memwrite(cpu_mem_write), .aluout(cpu_data_addr), .writedata(write_data), .readdata(read_data));
imem imem(.a(pc[7:2]), .rd(instr));
dmem dmem(.clk(clk), .we(mem_write), .a(cpu_data_addr), .wd(write_data), .rd(read_data));

// clock and reset
always #20 clk = ~clk;

assign finish = ~|(pc ^ pc_finished);
assign cpu_clk = clk & ~finish;
assign mem_write = cpu_mem_write & ~finish;

task judge(
    input integer frun,
    input integer cycle,
    input string out
);
    string ans;
    ans = "";
    $fscanf(frun, "%s\n", ans);
    if (ans != out)
        begin
            $display("[Error] PC: 0x%x Cycle: %d\tExpected: %0s, Got: %0s", pc, cycle, ans, out);
		    $stop;
        end
endtask

// judge memory
task judge_memory(
	input integer fans
);
    $display("========== In memory judge ==========");
    begin
        wait(finish == 1'b1);
        while(!$feof(fans))
            begin
                tb_dmem_data = 32'h0000_0000;
                $fscanf(fans, "%h", tb_dmem_data);
                if (tb_dmem_data != dmem.RAM[tb_data_addr/4])
                    begin
                        $display("FAILUER: dmem 0x%0h expect 0x%0h but get 0x%0h",
                            tb_data_addr, tb_dmem_data, dmem.RAM[tb_data_addr/4]);
                        error_count = error_count + 1;
                    end
                tb_data_addr = tb_data_addr + 4;
            end
        $display("successfully pass memory judge");
    end
endtask

// check runtime
task runtime_checker(
    input integer frun
);
    integer cycle;
    string out;
    cycle = 0;
    $display("========== In runtime checker ==========");
    while(!$feof(frun))
        begin@(negedge clk)
            cycle = cycle + 1;
            // $readmemh({`PATH_PREFIX, "data", name, ".bat"}, imem.RAM);
            if (mem_write)
                begin
                    $sformat(out, "[0x%x]=0x%x", cpu_data_addr, write_data);
//                    $display("out: %0s", out);
                    judge(frun, cycle, out);
                end
        end
    $display("successfully pass runtime checker");
endtask

initial 
begin
	// ddl to finish simulation
	#10000000 $display("FAILURE: Testbench Failed to finish before ddl!");
	error_count = error_count + 1;
	$finish;
end

// init memory
task init(input string name);
    imem.RAM = '{ default: '0 };
    dmem.RAM = '{ default: '0 };
    fimem = $fopen({ `PATH_PREFIX, `NAME, name, "/", name, ".mem"}, "r");
    fdmem = $fopen({ `PATH_PREFIX, `NAME, name, "/", name, ".data"}, "r");
    if (fdmem != 0) 
        begin
            dmem_counter = 0;
                while(!$feof(fdmem))
                    begin
                        dmem.RAM[dmem_counter] = 32'h0000_0000;
                        $fscanf(fdmem, "%x", dmem.RAM[dmem_counter]);
                        dmem_counter = dmem_counter + 1;
                    end
            $fclose(fdmem);
        end
    imem_counter = 0;
    $display("========== In init ==========");
    while(!$feof(fimem))
        begin
            imem.RAM[imem_counter] = 32'h0000_0000;
            $fscanf(fimem, "%x", imem.RAM[imem_counter]);
            imem_counter = imem_counter + 1;
        end
    $display("%d instructions in total", imem_counter);
    $fclose(fimem);
endtask

task grader(input string name);
    $display("========== Test: %0s ==========", name);
    begin
        reset = 1'b1;
        tb_dmem_data = 32'h0000_0000;
        tb_data_addr = 32'h0000_0000;
        pc_finished = 32'hffff_ffff;
        #50 reset = 1'b0;   
    end
    init(name);
    fans = $fopen({ `PATH_PREFIX, `NAME, name, "/", name, ".ans"}, "r");
    $fscanf(fans, "%h", pc_finished);
    frun = $fopen({ `PATH_PREFIX, `NAME, name, "/", name, ".run"}, "r");
    runtime_checker(frun);
    error_count = 0;
    $fclose(frun);
	judge_memory(fans);
    $fclose(fans);
    if (error_count != 0)
        $display("Find %d error(s)", error_count);
    else
        $display("[OK] %0s\n", name);
endtask

// start test
initial
begin
    clk = 1'b0;
    grader("ad hoc");
    grader("factorial");
    grader("bubble sort");
    grader("gcd");
    grader("quick multiply");
    grader("bisection");
	$display("[Done]\n");
	$finish;
end

endmodule
