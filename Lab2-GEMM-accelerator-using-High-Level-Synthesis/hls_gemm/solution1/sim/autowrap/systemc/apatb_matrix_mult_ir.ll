; ModuleID = 'C:/Users/itsru/Desktop/FPGA/CEN-598-Reconfigurable-Computing/Lab2-GEMM-accelerator-using-High-Level-Synthesis/hls_gemm/solution1/.autopilot/db/a.g.ld.5.gdce.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-i128:128-i256:256-i512:512-i1024:1024-i2048:2048-i4096:4096-n8:16:32:64-S128-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "fpga64-xilinx-none"

%"struct.ap_uint<8>" = type { %"struct.ap_int_base<8, false>" }
%"struct.ap_int_base<8, false>" = type { %"struct.ssdm_int<8, false>" }
%"struct.ssdm_int<8, false>" = type { i8 }
%"struct.ap_uint<32>" = type { %"struct.ap_int_base<32, false>" }
%"struct.ap_int_base<32, false>" = type { %"struct.ssdm_int<32, false>" }
%"struct.ssdm_int<32, false>" = type { i32 }

; Function Attrs: argmemonly noinline willreturn
define void @apatb_matrix_mult_ir([16 x %"struct.ap_uint<8>"]* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="16" %a, [16 x %"struct.ap_uint<8>"]* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="16" %b, [16 x %"struct.ap_uint<32>"]* noalias nocapture nonnull "fpga.decayed.dim.hint"="16" %prod) local_unnamed_addr #0 {
entry:
  %a_copy = alloca [16 x [16 x i8]], align 512
  %b_copy = alloca [16 x [16 x i8]], align 512
  %prod_copy = alloca [16 x [16 x i32]], align 512
  %0 = bitcast [16 x %"struct.ap_uint<8>"]* %a to [16 x [16 x %"struct.ap_uint<8>"]]*
  %1 = bitcast [16 x %"struct.ap_uint<8>"]* %b to [16 x [16 x %"struct.ap_uint<8>"]]*
  %2 = bitcast [16 x %"struct.ap_uint<32>"]* %prod to [16 x [16 x %"struct.ap_uint<32>"]]*
  call fastcc void @copy_in([16 x [16 x %"struct.ap_uint<8>"]]* nonnull %0, [16 x [16 x i8]]* nonnull align 512 %a_copy, [16 x [16 x %"struct.ap_uint<8>"]]* nonnull %1, [16 x [16 x i8]]* nonnull align 512 %b_copy, [16 x [16 x %"struct.ap_uint<32>"]]* nonnull %2, [16 x [16 x i32]]* nonnull align 512 %prod_copy)
  call void @apatb_matrix_mult_hw([16 x [16 x i8]]* %a_copy, [16 x [16 x i8]]* %b_copy, [16 x [16 x i32]]* %prod_copy)
  call void @copy_back([16 x [16 x %"struct.ap_uint<8>"]]* %0, [16 x [16 x i8]]* %a_copy, [16 x [16 x %"struct.ap_uint<8>"]]* %1, [16 x [16 x i8]]* %b_copy, [16 x [16 x %"struct.ap_uint<32>"]]* %2, [16 x [16 x i32]]* %prod_copy)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_in([16 x [16 x %"struct.ap_uint<8>"]]* noalias readonly, [16 x [16 x i8]]* noalias align 512, [16 x [16 x %"struct.ap_uint<8>"]]* noalias readonly, [16 x [16 x i8]]* noalias align 512, [16 x [16 x %"struct.ap_uint<32>"]]* noalias readonly, [16 x [16 x i32]]* noalias align 512) unnamed_addr #1 {
entry:
  call fastcc void @"onebyonecpy_hls.p0a16a16struct.ap_uint<8>"([16 x [16 x i8]]* align 512 %1, [16 x [16 x %"struct.ap_uint<8>"]]* %0)
  call fastcc void @"onebyonecpy_hls.p0a16a16struct.ap_uint<8>"([16 x [16 x i8]]* align 512 %3, [16 x [16 x %"struct.ap_uint<8>"]]* %2)
  call fastcc void @"onebyonecpy_hls.p0a16a16struct.ap_uint<32>"([16 x [16 x i32]]* align 512 %5, [16 x [16 x %"struct.ap_uint<32>"]]* %4)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a16struct.ap_uint<8>"([16 x %"struct.ap_uint<8>"]* %dst, [16 x %"struct.ap_uint<8>"]* readonly %src, i64 %num) local_unnamed_addr #2 {
entry:
  %0 = icmp eq [16 x %"struct.ap_uint<8>"]* %src, null
  %1 = icmp eq [16 x %"struct.ap_uint<8>"]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond7 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond7, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx8 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.0.0.05 = getelementptr [16 x %"struct.ap_uint<8>"], [16 x %"struct.ap_uint<8>"]* %src, i64 0, i64 %for.loop.idx8, i32 0, i32 0, i32 0
  %dst.addr.0.0.06 = getelementptr [16 x %"struct.ap_uint<8>"], [16 x %"struct.ap_uint<8>"]* %dst, i64 0, i64 %for.loop.idx8, i32 0, i32 0, i32 0
  %3 = load i8, i8* %src.addr.0.0.05, align 1
  store i8 %3, i8* %dst.addr.0.0.06, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx8, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0a16a16struct.ap_uint<32>"([16 x [16 x i32]]* noalias align 512 %dst, [16 x [16 x %"struct.ap_uint<32>"]]* noalias readonly %src) unnamed_addr #3 {
entry:
  %0 = icmp eq [16 x [16 x i32]]* %dst, null
  %1 = icmp eq [16 x [16 x %"struct.ap_uint<32>"]]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a16a16struct.ap_uint<32>"([16 x [16 x i32]]* nonnull %dst, [16 x [16 x %"struct.ap_uint<32>"]]* nonnull %src, i64 16)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a16a16struct.ap_uint<32>"([16 x [16 x i32]]* %dst, [16 x [16 x %"struct.ap_uint<32>"]]* readonly %src, i64 %num) local_unnamed_addr #2 {
entry:
  %0 = icmp eq [16 x [16 x %"struct.ap_uint<32>"]]* %src, null
  %1 = icmp eq [16 x [16 x i32]]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %3 = getelementptr [16 x [16 x i32]], [16 x [16 x i32]]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [16 x [16 x %"struct.ap_uint<32>"]], [16 x [16 x %"struct.ap_uint<32>"]]* %src, i64 0, i64 %for.loop.idx2
  call void @"arraycpy_hls.p0a16struct.ap_uint<32>"([16 x i32]* %3, [16 x %"struct.ap_uint<32>"]* %src.addr, i64 16)
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a16struct.ap_uint<32>"([16 x i32]* %dst, [16 x %"struct.ap_uint<32>"]* readonly %src, i64 %num) local_unnamed_addr #2 {
entry:
  %0 = icmp eq [16 x %"struct.ap_uint<32>"]* %src, null
  %1 = icmp eq [16 x i32]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond7 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond7, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx8 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.0.0.05 = getelementptr [16 x %"struct.ap_uint<32>"], [16 x %"struct.ap_uint<32>"]* %src, i64 0, i64 %for.loop.idx8, i32 0, i32 0, i32 0
  %3 = getelementptr [16 x i32], [16 x i32]* %dst, i64 0, i64 %for.loop.idx8
  %4 = load i32, i32* %src.addr.0.0.05, align 4
  store i32 %4, i32* %3, align 4
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx8, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_out([16 x [16 x %"struct.ap_uint<8>"]]* noalias, [16 x [16 x i8]]* noalias readonly align 512, [16 x [16 x %"struct.ap_uint<8>"]]* noalias, [16 x [16 x i8]]* noalias readonly align 512, [16 x [16 x %"struct.ap_uint<32>"]]* noalias, [16 x [16 x i32]]* noalias readonly align 512) unnamed_addr #4 {
entry:
  call fastcc void @"onebyonecpy_hls.p0a16a16struct.ap_uint<8>.30"([16 x [16 x %"struct.ap_uint<8>"]]* %0, [16 x [16 x i8]]* align 512 %1)
  call fastcc void @"onebyonecpy_hls.p0a16a16struct.ap_uint<8>.30"([16 x [16 x %"struct.ap_uint<8>"]]* %2, [16 x [16 x i8]]* align 512 %3)
  call fastcc void @"onebyonecpy_hls.p0a16a16struct.ap_uint<32>.6"([16 x [16 x %"struct.ap_uint<32>"]]* %4, [16 x [16 x i32]]* align 512 %5)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0a16a16struct.ap_uint<32>.6"([16 x [16 x %"struct.ap_uint<32>"]]* noalias %dst, [16 x [16 x i32]]* noalias readonly align 512 %src) unnamed_addr #3 {
entry:
  %0 = icmp eq [16 x [16 x %"struct.ap_uint<32>"]]* %dst, null
  %1 = icmp eq [16 x [16 x i32]]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a16a16struct.ap_uint<32>.9"([16 x [16 x %"struct.ap_uint<32>"]]* nonnull %dst, [16 x [16 x i32]]* nonnull %src, i64 16)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a16a16struct.ap_uint<32>.9"([16 x [16 x %"struct.ap_uint<32>"]]* %dst, [16 x [16 x i32]]* readonly %src, i64 %num) local_unnamed_addr #2 {
entry:
  %0 = icmp eq [16 x [16 x i32]]* %src, null
  %1 = icmp eq [16 x [16 x %"struct.ap_uint<32>"]]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [16 x [16 x %"struct.ap_uint<32>"]], [16 x [16 x %"struct.ap_uint<32>"]]* %dst, i64 0, i64 %for.loop.idx2
  %3 = getelementptr [16 x [16 x i32]], [16 x [16 x i32]]* %src, i64 0, i64 %for.loop.idx2
  call void @"arraycpy_hls.p0a16struct.ap_uint<32>.12"([16 x %"struct.ap_uint<32>"]* %dst.addr, [16 x i32]* %3, i64 16)
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a16struct.ap_uint<32>.12"([16 x %"struct.ap_uint<32>"]* %dst, [16 x i32]* readonly %src, i64 %num) local_unnamed_addr #2 {
entry:
  %0 = icmp eq [16 x i32]* %src, null
  %1 = icmp eq [16 x %"struct.ap_uint<32>"]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond7 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond7, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx8 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %3 = getelementptr [16 x i32], [16 x i32]* %src, i64 0, i64 %for.loop.idx8
  %dst.addr.0.0.06 = getelementptr [16 x %"struct.ap_uint<32>"], [16 x %"struct.ap_uint<32>"]* %dst, i64 0, i64 %for.loop.idx8, i32 0, i32 0, i32 0
  %4 = load i32, i32* %3, align 4
  store i32 %4, i32* %dst.addr.0.0.06, align 4
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx8, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0a16a16struct.ap_uint<8>"([16 x [16 x i8]]* noalias align 512 %dst, [16 x [16 x %"struct.ap_uint<8>"]]* noalias readonly %src) unnamed_addr #3 {
entry:
  %0 = icmp eq [16 x [16 x i8]]* %dst, null
  %1 = icmp eq [16 x [16 x %"struct.ap_uint<8>"]]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a16a16struct.ap_uint<8>.23"([16 x [16 x i8]]* nonnull %dst, [16 x [16 x %"struct.ap_uint<8>"]]* nonnull %src, i64 16)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a16a16struct.ap_uint<8>.23"([16 x [16 x i8]]* %dst, [16 x [16 x %"struct.ap_uint<8>"]]* readonly %src, i64 %num) local_unnamed_addr #2 {
entry:
  %0 = icmp eq [16 x [16 x %"struct.ap_uint<8>"]]* %src, null
  %1 = icmp eq [16 x [16 x i8]]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %3 = getelementptr [16 x [16 x i8]], [16 x [16 x i8]]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [16 x [16 x %"struct.ap_uint<8>"]], [16 x [16 x %"struct.ap_uint<8>"]]* %src, i64 0, i64 %for.loop.idx2
  call void @"arraycpy_hls.p0a16struct.ap_uint<8>.26"([16 x i8]* %3, [16 x %"struct.ap_uint<8>"]* %src.addr, i64 16)
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a16struct.ap_uint<8>.26"([16 x i8]* %dst, [16 x %"struct.ap_uint<8>"]* readonly %src, i64 %num) local_unnamed_addr #2 {
entry:
  %0 = icmp eq [16 x %"struct.ap_uint<8>"]* %src, null
  %1 = icmp eq [16 x i8]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond7 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond7, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx8 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.0.0.05 = getelementptr [16 x %"struct.ap_uint<8>"], [16 x %"struct.ap_uint<8>"]* %src, i64 0, i64 %for.loop.idx8, i32 0, i32 0, i32 0
  %3 = getelementptr [16 x i8], [16 x i8]* %dst, i64 0, i64 %for.loop.idx8
  %4 = load i8, i8* %src.addr.0.0.05, align 1
  store i8 %4, i8* %3, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx8, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0a16a16struct.ap_uint<8>.30"([16 x [16 x %"struct.ap_uint<8>"]]* noalias %dst, [16 x [16 x i8]]* noalias readonly align 512 %src) unnamed_addr #3 {
entry:
  %0 = icmp eq [16 x [16 x %"struct.ap_uint<8>"]]* %dst, null
  %1 = icmp eq [16 x [16 x i8]]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a16a16struct.ap_uint<8>.33"([16 x [16 x %"struct.ap_uint<8>"]]* nonnull %dst, [16 x [16 x i8]]* nonnull %src, i64 16)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a16a16struct.ap_uint<8>.33"([16 x [16 x %"struct.ap_uint<8>"]]* %dst, [16 x [16 x i8]]* readonly %src, i64 %num) local_unnamed_addr #2 {
entry:
  %0 = icmp eq [16 x [16 x i8]]* %src, null
  %1 = icmp eq [16 x [16 x %"struct.ap_uint<8>"]]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [16 x [16 x %"struct.ap_uint<8>"]], [16 x [16 x %"struct.ap_uint<8>"]]* %dst, i64 0, i64 %for.loop.idx2
  %3 = getelementptr [16 x [16 x i8]], [16 x [16 x i8]]* %src, i64 0, i64 %for.loop.idx2
  call void @"arraycpy_hls.p0a16struct.ap_uint<8>.36"([16 x %"struct.ap_uint<8>"]* %dst.addr, [16 x i8]* %3, i64 16)
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a16struct.ap_uint<8>.36"([16 x %"struct.ap_uint<8>"]* %dst, [16 x i8]* readonly %src, i64 %num) local_unnamed_addr #2 {
entry:
  %0 = icmp eq [16 x i8]* %src, null
  %1 = icmp eq [16 x %"struct.ap_uint<8>"]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond7 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond7, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx8 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %3 = getelementptr [16 x i8], [16 x i8]* %src, i64 0, i64 %for.loop.idx8
  %dst.addr.0.0.06 = getelementptr [16 x %"struct.ap_uint<8>"], [16 x %"struct.ap_uint<8>"]* %dst, i64 0, i64 %for.loop.idx8, i32 0, i32 0, i32 0
  %4 = load i8, i8* %3, align 1
  store i8 %4, i8* %dst.addr.0.0.06, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx8, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

declare void @apatb_matrix_mult_hw([16 x [16 x i8]]*, [16 x [16 x i8]]*, [16 x [16 x i32]]*)

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_back([16 x [16 x %"struct.ap_uint<8>"]]* noalias, [16 x [16 x i8]]* noalias readonly align 512, [16 x [16 x %"struct.ap_uint<8>"]]* noalias, [16 x [16 x i8]]* noalias readonly align 512, [16 x [16 x %"struct.ap_uint<32>"]]* noalias, [16 x [16 x i32]]* noalias readonly align 512) unnamed_addr #4 {
entry:
  call fastcc void @"onebyonecpy_hls.p0a16a16struct.ap_uint<32>.6"([16 x [16 x %"struct.ap_uint<32>"]]* %4, [16 x [16 x i32]]* align 512 %5)
  ret void
}

define void @matrix_mult_hw_stub_wrapper([16 x [16 x i8]]*, [16 x [16 x i8]]*, [16 x [16 x i32]]*) #5 {
entry:
  %3 = alloca [16 x [16 x %"struct.ap_uint<8>"]]
  %4 = alloca [16 x [16 x %"struct.ap_uint<8>"]]
  %5 = alloca [16 x [16 x %"struct.ap_uint<32>"]]
  call void @copy_out([16 x [16 x %"struct.ap_uint<8>"]]* %3, [16 x [16 x i8]]* %0, [16 x [16 x %"struct.ap_uint<8>"]]* %4, [16 x [16 x i8]]* %1, [16 x [16 x %"struct.ap_uint<32>"]]* %5, [16 x [16 x i32]]* %2)
  %6 = bitcast [16 x [16 x %"struct.ap_uint<8>"]]* %3 to [16 x %"struct.ap_uint<8>"]*
  %7 = bitcast [16 x [16 x %"struct.ap_uint<8>"]]* %4 to [16 x %"struct.ap_uint<8>"]*
  %8 = bitcast [16 x [16 x %"struct.ap_uint<32>"]]* %5 to [16 x %"struct.ap_uint<32>"]*
  call void @matrix_mult_hw_stub([16 x %"struct.ap_uint<8>"]* %6, [16 x %"struct.ap_uint<8>"]* %7, [16 x %"struct.ap_uint<32>"]* %8)
  call void @copy_in([16 x [16 x %"struct.ap_uint<8>"]]* %3, [16 x [16 x i8]]* %0, [16 x [16 x %"struct.ap_uint<8>"]]* %4, [16 x [16 x i8]]* %1, [16 x [16 x %"struct.ap_uint<32>"]]* %5, [16 x [16 x i32]]* %2)
  ret void
}

declare void @matrix_mult_hw_stub([16 x %"struct.ap_uint<8>"]*, [16 x %"struct.ap_uint<8>"]*, [16 x %"struct.ap_uint<32>"]*)

attributes #0 = { argmemonly noinline willreturn "fpga.wrapper.func"="wrapper" }
attributes #1 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="copyin" }
attributes #2 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="arraycpy_hls" }
attributes #3 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="onebyonecpy_hls" }
attributes #4 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="copyout" }
attributes #5 = { "fpga.wrapper.func"="stub" }

!llvm.dbg.cu = !{}
!llvm.ident = !{!0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0}
!llvm.module.flags = !{!1, !2, !3}
!blackbox_cfg = !{!4}

!0 = !{!"clang version 7.0.0 "}
!1 = !{i32 2, !"Dwarf Version", i32 4}
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{}
