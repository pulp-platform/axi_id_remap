// Copyright 2014-2018 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the “License”); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.
//
// Florian Zaruba <zarubaf@iis.ee.ethz.ch>

module axi_id_remap_wrap #(
    parameter  int unsigned AXI_ADDRESS_W  = 32,
    parameter  int unsigned AXI_DATA_W     = 64,
    parameter  int unsigned AXI_NUMBYTES   = AXI_DATA_W/8,
    parameter  int unsigned AXI_USER_W     = 6,

    parameter  int unsigned AXI_ID_IN      = 8,
    parameter  int unsigned AXI_ID_OUT     = 4,
    parameter  int unsigned ID_SLOT        = 16
)(
  input logic       clk_i,
  input logic       rst_ni,
  AXI_BUS.Slave     slave,
  AXI_BUS.Master    master
);

    axi_id_remap #(
        .AXI_ADDRESS_W(AXI_ADDRESS_W),
        .AXI_DATA_W   (AXI_DATA_W),
        .AXI_NUMBYTES (AXI_NUMBYTES),
        .AXI_USER_W   (AXI_USER_W),
        .AXI_ID_IN    (AXI_ID_IN),
        .AXI_ID_OUT   (AXI_ID_OUT),
        .ID_SLOT      (ID_SLOT)
    ) i_axi_id_remap (
        .clk             ( clk_i           ),
        .rst_n           ( rst_ni          ),

        .targ_awid_i     ( slave.aw_id     ),
        .targ_awaddr_i   ( slave.aw_addr   ),
        .targ_awlen_i    ( slave.aw_len    ),
        .targ_awsize_i   ( slave.aw_size   ),
        .targ_awburst_i  ( slave.aw_burst  ),
        .targ_awlock_i   ( slave.aw_lock   ),
        .targ_awcache_i  ( slave.aw_cache  ),
        .targ_awprot_i   ( slave.aw_prot   ),
        .targ_awregion_i ( slave.aw_region ),
        .targ_awuser_i   ( slave.aw_user   ),
        .targ_awqos_i    ( slave.aw_qos    ),
        .targ_awvalid_i  ( slave.aw_valid  ),
        .targ_awready_o  ( slave.aw_ready  ),

        .targ_wdata_i    ( slave.w_data    ),
        .targ_wstrb_i    ( slave.w_strb    ),
        .targ_wlast_i    ( slave.w_last    ),
        .targ_wuser_i    ( slave.w_user    ),
        .targ_wvalid_i   ( slave.w_valid   ),
        .targ_wready_o   ( slave.w_ready   ),

        .targ_bid_o      ( slave.b_id      ),
        .targ_bresp_o    ( slave.b_resp    ),
        .targ_bvalid_o   ( slave.b_valid   ),
        .targ_buser_o    ( slave.b_user    ),
        .targ_bready_i   ( slave.b_ready   ),

        .targ_arid_i     ( slave.ar_id     ),
        .targ_araddr_i   ( slave.ar_addr   ),
        .targ_arlen_i    ( slave.ar_len    ),
        .targ_arsize_i   ( slave.ar_size   ),
        .targ_arburst_i  ( slave.ar_burst  ),
        .targ_arlock_i   ( slave.ar_lock   ),
        .targ_arcache_i  ( slave.ar_cache  ),
        .targ_arprot_i   ( slave.ar_prot   ),
        .targ_arregion_i ( slave.ar_region ),
        .targ_aruser_i   ( slave.ar_user   ),
        .targ_arqos_i    ( slave.ar_qos    ),
        .targ_arvalid_i  ( slave.ar_valid  ),
        .targ_arready_o  ( slave.ar_ready  ),

        .targ_rid_o      ( slave.r_id      ),
        .targ_rdata_o    ( slave.r_data    ),
        .targ_rresp_o    ( slave.r_resp    ),
        .targ_rlast_o    ( slave.r_last    ),
        .targ_ruser_o    ( slave.r_user    ),
        .targ_rvalid_o   ( slave.r_valid   ),
        .targ_rready_i   ( slave.r_ready   ),

        .init_awid_o     ( master.aw_id     ),
        .init_awaddr_o   ( master.aw_addr   ),
        .init_awlen_o    ( master.aw_len    ),
        .init_awsize_o   ( master.aw_size   ),
        .init_awburst_o  ( master.aw_burst  ),
        .init_awlock_o   ( master.aw_lock   ),
        .init_awcache_o  ( master.aw_cache  ),
        .init_awprot_o   ( master.aw_prot   ),
        .init_awregion_o ( master.aw_region ),
        .init_awuser_o   ( master.aw_user   ),
        .init_awqos_o    ( master.aw_qos    ),
        .init_awvalid_o  ( master.aw_valid  ),
        .init_awready_i  ( master.aw_ready  ),

        .init_wdata_o    ( master.w_data    ),
        .init_wstrb_o    ( master.w_strb    ),
        .init_wlast_o    ( master.w_last    ),
        .init_wuser_o    ( master.w_user    ),
        .init_wvalid_o   ( master.w_valid   ),
        .init_wready_i   ( master.w_ready   ),

        .init_bid_i      ( master.b_id      ),
        .init_bresp_i    ( master.b_resp    ),
        .init_buser_i    ( master.b_user    ),
        .init_bvalid_i   ( master.b_valid   ),
        .init_bready_o   ( master.b_ready   ),

        .init_arid_o     ( master.ar_id     ),
        .init_araddr_o   ( master.ar_addr   ),
        .init_arlen_o    ( master.ar_len    ),
        .init_arsize_o   ( master.ar_size   ),
        .init_arburst_o  ( master.ar_burst  ),
        .init_arlock_o   ( master.ar_lock   ),
        .init_arcache_o  ( master.ar_cache  ),
        .init_arprot_o   ( master.ar_prot   ),
        .init_arregion_o ( master.ar_region ),
        .init_aruser_o   ( master.ar_user   ),
        .init_arqos_o    ( master.ar_qos    ),
        .init_arvalid_o  ( master.ar_valid  ),
        .init_arready_i  ( master.ar_ready  ),

        .init_rid_i      ( master.r_id      ),
        .init_rdata_i    ( master.r_data    ),
        .init_rresp_i    ( master.r_resp    ),
        .init_rlast_i    ( master.r_last    ),
        .init_ruser_i    ( master.r_user    ),
        .init_rvalid_i   ( master.r_valid   ),
        .init_rready_o   ( master.r_ready   )
    );

endmodule
