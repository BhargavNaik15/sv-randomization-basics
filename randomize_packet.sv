class packet;
  // Data members modified with 'rand' modifier
  rand bit [3:0] src, dest; // 4-bit Source and Dest address values
  rand bit [7:0] data; // 8-bit data

  // Overriding pre-randomize method
  function void pre_randomize();
    $display("[%0t] Before Randomize", $time);
  endfunction

  // Overriding post-randomize method
  function void post_randomize();
    $display("[%0t] After Randomize", $time);
  endfunction

  // Usage of extern keyword to define function and constraints outside the class
  extern function void display();
  extern constraint valid_values;
endclass

// Display function definition
function void packet::display();
  $display("Randomized Values : src = %0d, dest = %0d, data = %0d", src, dest, data);
endfunction

// Valid_values constraints definition (On requirements)
constraint packet::valid_values {
  src != dest;
  src inside {0, 2, 4, 6, 8};
  dest inside {0, 2, 4, 6, 8};
};
    
module tester;
  // Hnadle of the packet class
  packet p1;

  initial begin
    p1 = new(); // Constructor

    // repeating the process for the 4 times(Can be adjusted accordingly)
    repeat(4) begin
      p1.randomize();
      p1.display();
    end
    p1 = null;
  end
endmodule
