// --------------------------------------------------------
// YAPP - Scoreboard - https://quicksilicon.in/course/testbench-design/module/yapp
// --------------------------------------------------------

class yapp_scoreboard;

  mailbox #(yapp_req_transaction) mon2sb_req;
  mailbox #(yapp_resp_transaction) mon2sb_resp;
  
  // creating an array of pending IDs
	bit [11:0] pend_id_arr = 12'b0;

  function new (mailbox #(yapp_req_transaction) mon2sb_req, mailbox #(yapp_resp_transaction) mon2sb_resp);
    $display("[INFO] @ %0t: Creating the yapp_scoreboard", $time);
    this.mon2sb_req = mon2sb_req;
    this.mon2sb_resp = mon2sb_resp;
  endfunction

  // --------------------------------------------------------
  // Run the scoreboard
  // --------------------------------------------------------
  task run ();
    fork
        void'(process_requests());
        void'(process_responses());
    join
  endtask

  // --------------------------------------------------------
  // Process the requests from the monitor
  // --------------------------------------------------------
  task process_requests ();
    yapp_req_transaction req_tr;

    forever begin
      // Wait for the request transaction from the monitor
      mon2sb_req.get(req_tr);
      if (req_tr.yapp_req) begin
        $display("[INFO] @ %0t: YAPP Scoreboard: Received Request Transaction", $time);

        // Check if the req_id is valid (0 to 11)
        if (req_tr.yapp_req_id > 11) begin
          $display("[ERROR] @ %0t: YAPP Scoreboard: yapp_req_id is greater than 11!", $time);
          bug_tracker($time, req_tr.yapp_req_id);
          continue; // Skip processing this transaction
        end else if (pend_id_arr[req_tr.yapp_req_id]) begin
        	$display("[ERROR] @ %0t: YAPP Scoreboard: req is going to an id %0b where a response is pending!!", $time, req_tr.yapp_req_id);
        	bug_tracker($time, req_tr.yapp_req_id);
          continue;
        end else if (!pend_id_arr[req_tr.yapp_req_id]) begin
          pend_id_arr[req_tr.yapp_req_id] = 1;
        end
        
        if (req_tr.yapp_reqbuf_full) begin
        	// check if pending id array is all 1s
          if (!&pend_id_arr) begin
            $display("[ERROR] @ %0t: YAPP Scoreboard: full signal is asserted when IDs are available!", $time);
            bug_tracker($time, req_tr.yapp_req_id);
            continue;
          end
        end
        // print the pending array
        print_pend_ids(pend_id_arr);
      end
    end
  endtask

  // --------------------------------------------------------
  // Process the responses from the monitor
  // --------------------------------------------------------
  task process_responses ();
    yapp_resp_transaction resp_tr;
    forever begin
      // Wait for the response transaction from the monitor
      mon2sb_resp.get(resp_tr);
      // Add any checks for the response transaction here if needed
      if (resp_tr.yapp_resp) begin
        $display("[INFO] @ %0t: YAPP Scoreboard: Received Response Transaction", $time);
        
        // check if resp id is valid
        if (resp_tr.yapp_resp_id > 11) begin
        	$display("[ERROR] @ %0t: YAPP Scoreboard: yapp_resp_id is greater than 11!", $time);
          bug_tracker($time, resp_tr.yapp_resp_id);
      	end else if (resp_tr.yapp_resp_abort) begin
          $display("[INFO] @ %0t: YAPP Scoreboard: Abort Rsp Transaction!", $time);
          print_pend_ids(pend_id_arr);
        	continue; // do not process the aborted response
      	end else if (!resp_tr.yapp_resp_abort) begin
        	if(pend_id_arr[resp_tr.yapp_resp_id]) begin
          	pend_id_arr[resp_tr.yapp_resp_id] = 0;
        	end else begin
          	$display("[ERROR] @ %0t: YAPP Scoreboard: Sending a response to an id(%0b) that doesnt require it", $time, resp_tr.yapp_resp_id);
            bug_tracker($time, resp_tr.yapp_resp_id);
        	end
      	end
        
        // print pending id array
        print_pend_ids(pend_id_arr);
      end
    end
  endtask

  // --------------------------------------------------------
  // End of test function
  // --------------------------------------------------------
  function void end_of_test ();
    $display("[INFO] @ %0t: YAPP Scoreboard: End of test", $time);
    // Add any end of the test checks here if needed
      
      // Check 1: Check if all pending reqs are serviced. Use the pending_id_array
  endfunction
  
  function void print_pend_ids(bit [11:0] id_vector);
    // Header: Bit Numbers
    $write("ID Bit: |");
    for (int i=11; i>=0; i--) begin
      $write(" %2d |", i);
    end
    $display("");

    // Visual Divider
    $display("--------+----+----+----+----+----+----+----+----+----+----+----+----+");

    // Row: Bit Values
    $write("Status: |");
    for (int i=11; i>=0; i--) begin
      // Using %1b for a clean single-bit look
      $write("  %1b |", id_vector[i]);
    end
    $display("\n");
	endfunction

endclass

