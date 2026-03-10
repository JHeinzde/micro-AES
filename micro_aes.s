	.attribute	4, 16
	.attribute	5, "rv32i2p1_m2p0_zicbom1p0_zmmul1p0_xtheadcmo1p0"
	.file	"micro_aes.c"
                                        # Start of file scope inline assembly
	.text
_start:
	lui	sp, 65536
	call	main
	li	a7, -1
	ecall
_HALT:
	j	_HALT

                                        # End of file scope inline assembly
	.globl	AES_ECB_encrypt                 # -- Begin function AES_ECB_encrypt
	.p2align	2
	.type	AES_ECB_encrypt,@function
AES_ECB_encrypt:                        # @AES_ECB_encrypt
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	sw	s1, 4(sp)                       # 4-byte Folded Spill
	sw	s2, 0(sp)                       # 4-byte Folded Spill
	mv	s0, a3
	mv	s1, a2
	blez	a2, .LBB0_3
# %bb.1:
	addi	a3, s1, -1
	li	a2, 1
.LBB0_2:                                # =>This Inner Loop Header: Depth=1
	add	a4, a1, a3
	lbu	a4, 0(a4)
	add	a5, s0, a3
	addi	a6, a3, 1
	addi	a3, a3, -1
	sb	a4, 0(a5)
	bltu	a2, a6, .LBB0_2
.LBB0_3:
	call	KeyExpansion
	li	a0, 16
	bltu	s1, a0, .LBB0_6
# %bb.4:
	srli	a0, s1, 4
	slli	a0, a0, 4
	add	s2, s0, a0
.LBB0_5:                                # =>This Inner Loop Header: Depth=1
	mv	a0, s0
	mv	a1, s0
	call	rijndaelEncrypt
	addi	s0, s0, 16
	bne	s0, s2, .LBB0_5
.LBB0_6:
	neg	a1, s1
	andi	a1, a1, 15
	andi	s1, s1, 15
	beqz	a1, .LBB0_9
# %bb.7:
	add	a0, s1, s0
	addi	a0, a0, -1
	add	a1, a0, a1
.LBB0_8:                                # =>This Inner Loop Header: Depth=1
	sb	zero, 0(a1)
	addi	a1, a1, -1
	bne	a1, a0, .LBB0_8
.LBB0_9:
	beqz	s1, .LBB0_11
# %bb.10:
	mv	a0, s0
	mv	a1, s0
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	lw	s1, 4(sp)                       # 4-byte Folded Reload
	lw	s2, 0(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	tail	rijndaelEncrypt
.LBB0_11:
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	lw	s1, 4(sp)                       # 4-byte Folded Reload
	lw	s2, 0(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end0:
	.size	AES_ECB_encrypt, .Lfunc_end0-AES_ECB_encrypt
                                        # -- End function
	.p2align	2                               # -- Begin function KeyExpansion
	.type	KeyExpansion,@function
KeyExpansion:                           # @KeyExpansion
# %bb.0:
	li	a3, 15
	lui	a1, %hi(RoundKey)
	addi	a1, a1, %lo(RoundKey)
	li	a2, 1
.LBB1_1:                                # =>This Inner Loop Header: Depth=1
	add	a4, a0, a3
	lbu	a4, 0(a4)
	add	a5, a1, a3
	addi	a6, a3, 1
	addi	a3, a3, -1
	sb	a4, 0(a5)
	bltu	a2, a6, .LBB1_1
# %bb.2:
	addi	sp, sp, -16
	sw	s0, 12(sp)                      # 4-byte Folded Spill
	li	a0, 0
	li	a2, 1
	li	a7, 16
	lui	a3, %hi(sbox)
	addi	a3, a3, %lo(sbox)
	li	a4, 172
	mv	a5, a1
.LBB1_3:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_6 Depth 2
	mv	a6, a7
	andi	t0, a7, 12
	add	a7, a1, a7
	beqz	t0, .LBB1_5
# %bb.4:                                #   in Loop: Header=BB1_3 Depth=1
	lbu	t0, -3(a7)
	lbu	t1, -2(a7)
	lbu	t2, -1(a7)
	lbu	t3, -4(a7)
	slli	t0, t0, 8
	slli	t1, t1, 16
	slli	t2, t2, 24
	or	t0, t0, t3
	or	t1, t2, t1
	lbu	t2, 1(a7)
	lbu	t3, 0(a7)
	lbu	t4, 2(a7)
	lbu	t5, 3(a7)
	slli	t2, t2, 8
	or	t2, t2, t3
	slli	t4, t4, 16
	slli	t5, t5, 24
	or	t3, t5, t4
	or	t0, t1, t0
	or	t1, t3, t2
	xor	t0, t1, t0
	srli	t1, t0, 16
	srli	t2, t0, 24
	srli	t3, t0, 8
	sb	t0, 0(a7)
	sb	t3, 1(a7)
	sb	t1, 2(a7)
	sb	t2, 3(a7)
	j	.LBB1_10
.LBB1_5:                                #   in Loop: Header=BB1_3 Depth=1
	slli	t0, a0, 2
	add	t0, t0, a1
	addi	t0, t0, -16
	mv	t1, a5
.LBB1_6:                                #   Parent Loop BB1_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	lbu	t2, 15(t1)
	sb	t2, 31(t1)
	addi	t1, t1, -1
	bne	t1, t0, .LBB1_6
# %bb.7:                                #   in Loop: Header=BB1_3 Depth=1
	zext.b	t0, a2
	bnez	t0, .LBB1_9
# %bb.8:                                #   in Loop: Header=BB1_3 Depth=1
	li	a2, 27
.LBB1_9:                                #   in Loop: Header=BB1_3 Depth=1
	lbu	t0, -4(a7)
	lbu	t1, -3(a7)
	lbu	t2, -2(a7)
	lbu	t3, -1(a7)
	lbu	t4, 0(a7)
	lbu	t5, 1(a7)
	lbu	t6, 2(a7)
	lbu	s0, 3(a7)
	add	t1, a3, t1
	xor	t4, t4, a2
	add	t2, a3, t2
	add	t3, a3, t3
	add	t0, a3, t0
	lbu	t1, 0(t1)
	lbu	t2, 0(t2)
	lbu	t3, 0(t3)
	lbu	t0, 0(t0)
	xor	t1, t1, t4
	xor	t2, t5, t2
	xor	t3, t6, t3
	xor	t0, s0, t0
	sb	t1, 0(a7)
	sb	t2, 1(a7)
	sb	t3, 2(a7)
	sb	t0, 3(a7)
	slli	a2, a2, 1
.LBB1_10:                               #   in Loop: Header=BB1_3 Depth=1
	addi	a7, a6, 4
	addi	a5, a5, 4
	addi	a0, a0, 1
	bltu	a6, a4, .LBB1_3
# %bb.11:
	lw	s0, 12(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end1:
	.size	KeyExpansion, .Lfunc_end1-KeyExpansion
                                        # -- End function
	.p2align	2                               # -- Begin function rijndaelEncrypt
	.type	rijndaelEncrypt,@function
rijndaelEncrypt:                        # @rijndaelEncrypt
# %bb.0:
	beq	a0, a1, .LBB2_3
# %bb.1:
	li	a3, 15
	li	a2, 1
.LBB2_2:                                # =>This Inner Loop Header: Depth=1
	add	a4, a0, a3
	lbu	a4, 0(a4)
	add	a5, a1, a3
	addi	a6, a3, 1
	addi	a3, a3, -1
	sb	a4, 0(a5)
	bltu	a2, a6, .LBB2_2
.LBB2_3:
	addi	sp, sp, -32
	sw	s0, 28(sp)                      # 4-byte Folded Spill
	sw	s1, 24(sp)                      # 4-byte Folded Spill
	sw	s2, 20(sp)                      # 4-byte Folded Spill
	sw	s3, 16(sp)                      # 4-byte Folded Spill
	sw	s4, 12(sp)                      # 4-byte Folded Spill
	li	a2, 0
	addi	a0, a1, 16
	addi	a3, a1, 1
	addi	a4, a1, 17
	lui	a5, %hi(RoundKey)
	addi	a5, a5, %lo(RoundKey)
	lui	a6, %hi(sbox)
	addi	a6, a6, %lo(sbox)
	li	a7, 10
.LBB2_4:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_5 Depth 2
                                        #     Child Loop BB2_7 Depth 2
                                        #     Child Loop BB2_9 Depth 2
	mv	t0, a5
	mv	t1, a1
.LBB2_5:                                #   Parent Loop BB2_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	lbu	t2, 0(t0)
	lbu	t3, 0(t1)
	xor	t2, t3, t2
	sb	t2, 0(t1)
	addi	t1, t1, 1
	addi	t0, t0, 1
	bne	t1, a0, .LBB2_5
# %bb.6:                                #   in Loop: Header=BB2_4 Depth=1
	mv	t0, a1
.LBB2_7:                                #   Parent Loop BB2_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	lbu	t1, 0(t0)
	add	t1, a6, t1
	lbu	t1, 0(t1)
	sb	t1, 0(t0)
	addi	t0, t0, 1
	bne	t0, a0, .LBB2_7
# %bb.8:                                #   in Loop: Header=BB2_4 Depth=1
	lbu	t0, 1(a1)
	lbu	t1, 2(a1)
	lbu	t2, 3(a1)
	lbu	t3, 5(a1)
	lbu	t4, 11(a1)
	lbu	t5, 13(a1)
	lbu	t6, 14(a1)
	lbu	s0, 15(a1)
	lbu	s1, 9(a1)
	lbu	s2, 10(a1)
	lbu	s3, 6(a1)
	lbu	s4, 7(a1)
	sb	t3, 1(a1)
	sb	s2, 2(a1)
	sb	s0, 3(a1)
	sb	s1, 5(a1)
	sb	t6, 6(a1)
	sb	t2, 7(a1)
	sb	t5, 9(a1)
	sb	t1, 10(a1)
	addi	a2, a2, 1
	sb	s4, 11(a1)
	sb	t0, 13(a1)
	sb	s3, 14(a1)
	sb	t4, 15(a1)
	mv	t0, a3
	beq	a2, a7, .LBB2_11
.LBB2_9:                                #   Parent Loop BB2_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	lw	t1, -1(t0)
	srli	t2, t1, 8
	srli	t3, t1, 16
	srli	t4, t1, 24
	xor	t5, t4, t2
	xor	t6, t2, t1
	xor	s0, t3, t1
	slli	s1, t5, 24
	slli	s2, t6, 24
	slli	s3, s0, 24
	slli	s4, s0, 1
	slli	t6, t6, 1
	xor	t6, t6, s0
	slli	s0, t5, 1
	srai	s3, s3, 31
	srai	s2, s2, 31
	srai	s1, s1, 31
	andi	s3, s3, 27
	andi	s2, s2, 27
	andi	s1, s1, 27
	xor	t5, t6, t5
	xor	t6, s3, s4
	xor	s0, s1, s0
	xor	t5, t5, s2
	xor	t1, t5, t1
	xor	t6, t6, t5
	xor	t3, s0, t3
	xor	t4, s0, t4
	xor	t2, t6, t2
	xor	t3, t3, t6
	xor	t4, t4, t5
	sb	t1, -1(t0)
	sb	t2, 0(t0)
	sb	t3, 1(t0)
	sb	t4, 2(t0)
	addi	t0, t0, 4
	bne	t0, a4, .LBB2_9
# %bb.10:                               #   in Loop: Header=BB2_4 Depth=1
	addi	a5, a5, 16
	j	.LBB2_4
.LBB2_11:
	lui	a2, %hi(RoundKey+160)
	addi	a2, a2, %lo(RoundKey+160)
.LBB2_12:                               # =>This Inner Loop Header: Depth=1
	lbu	a3, 0(a2)
	lbu	a4, 0(a1)
	xor	a3, a4, a3
	sb	a3, 0(a1)
	addi	a1, a1, 1
	addi	a2, a2, 1
	bne	a1, a0, .LBB2_12
# %bb.13:
	lw	s0, 28(sp)                      # 4-byte Folded Reload
	lw	s1, 24(sp)                      # 4-byte Folded Reload
	lw	s2, 20(sp)                      # 4-byte Folded Reload
	lw	s3, 16(sp)                      # 4-byte Folded Reload
	lw	s4, 12(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end2:
	.size	rijndaelEncrypt, .Lfunc_end2-rijndaelEncrypt
                                        # -- End function
	.globl	AES_ECB_decrypt                 # -- Begin function AES_ECB_decrypt
	.p2align	2
	.type	AES_ECB_decrypt,@function
AES_ECB_decrypt:                        # @AES_ECB_decrypt
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	sw	s1, 4(sp)                       # 4-byte Folded Spill
	sw	s2, 0(sp)                       # 4-byte Folded Spill
	mv	s1, a3
	mv	s0, a2
	blez	a2, .LBB3_3
# %bb.1:
	addi	a3, s0, -1
	li	a2, 1
.LBB3_2:                                # =>This Inner Loop Header: Depth=1
	add	a4, a1, a3
	lbu	a4, 0(a4)
	add	a5, s1, a3
	addi	a6, a3, 1
	addi	a3, a3, -1
	sb	a4, 0(a5)
	bltu	a2, a6, .LBB3_2
.LBB3_3:
	call	KeyExpansion
	li	a0, 16
	bltu	s0, a0, .LBB3_6
# %bb.4:
	srli	a0, s0, 4
	slli	a0, a0, 4
	add	s2, s1, a0
.LBB3_5:                                # =>This Inner Loop Header: Depth=1
	mv	a0, s1
	mv	a1, s1
	call	rijndaelDecrypt
	addi	s1, s1, 16
	bne	s1, s2, .LBB3_5
.LBB3_6:
	andi	s0, s0, 15
	seqz	a0, s0
	addi	a0, a0, -1
	andi	a0, a0, 29
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	lw	s1, 4(sp)                       # 4-byte Folded Reload
	lw	s2, 0(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end3:
	.size	AES_ECB_decrypt, .Lfunc_end3-AES_ECB_decrypt
                                        # -- End function
	.p2align	2                               # -- Begin function rijndaelDecrypt
	.type	rijndaelDecrypt,@function
rijndaelDecrypt:                        # @rijndaelDecrypt
# %bb.0:
	beq	a0, a1, .LBB4_3
# %bb.1:
	li	a3, 15
	li	a2, 1
.LBB4_2:                                # =>This Inner Loop Header: Depth=1
	add	a4, a0, a3
	lbu	a4, 0(a4)
	add	a5, a1, a3
	addi	a6, a3, 1
	addi	a3, a3, -1
	sb	a4, 0(a5)
	bltu	a2, a6, .LBB4_2
.LBB4_3:
	addi	sp, sp, -32
	sw	s0, 28(sp)                      # 4-byte Folded Spill
	sw	s1, 24(sp)                      # 4-byte Folded Spill
	sw	s2, 20(sp)                      # 4-byte Folded Spill
	sw	s3, 16(sp)                      # 4-byte Folded Spill
	sw	s4, 12(sp)                      # 4-byte Folded Spill
	sw	s5, 8(sp)                       # 4-byte Folded Spill
	sw	s6, 4(sp)                       # 4-byte Folded Spill
	sw	s7, 0(sp)                       # 4-byte Folded Spill
	addi	a0, a1, 1
	addi	a2, a1, 17
	lui	a7, %hi(RoundKey)
	addi	a7, a7, %lo(RoundKey)
	addi	a3, a1, 16
	li	a4, 10
	lui	a5, %hi(rsbox)
	addi	a5, a5, %lo(rsbox)
	addi	a6, a7, 144
	addi	a7, a7, 160
	li	t0, 10
.LBB4_4:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB4_7 Depth 2
                                        #     Child Loop BB4_6 Depth 2
                                        #     Child Loop BB4_9 Depth 2
                                        #     Child Loop BB4_11 Depth 2
	mv	t1, a0
	bne	t0, a4, .LBB4_7
# %bb.5:                                #   in Loop: Header=BB4_4 Depth=1
	mv	t1, a7
	mv	t2, a1
.LBB4_6:                                #   Parent Loop BB4_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	lbu	t3, 0(t1)
	lbu	t4, 0(t2)
	xor	t3, t4, t3
	sb	t3, 0(t2)
	addi	t2, t2, 1
	addi	t1, t1, 1
	bne	t2, a3, .LBB4_6
	j	.LBB4_8
.LBB4_7:                                #   Parent Loop BB4_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	lw	t3, -1(t1)
	srli	s0, t3, 8
	srli	t6, t3, 16
	srli	t5, t3, 24
	xor	t2, s0, t3
	xor	t4, t5, t6
	xor	s1, t6, s0
	xor	s2, t5, t3
	xor	s3, t4, t2
	xor	s4, s2, s1
	slli	s5, s3, 24
	slli	s3, s3, 1
	slli	s6, s4, 24
	slli	s4, s4, 1
	srai	s5, s5, 31
	xor	s3, s3, t3
	srai	s6, s6, 31
	xor	s4, s4, s0
	andi	s5, s5, 27
	xor	s3, s3, t6
	andi	s6, s6, 27
	xor	s4, s4, t5
	xor	s3, s3, s5
	xor	s4, s4, s6
	slli	s5, s3, 24
	slli	s3, s3, 1
	slli	s6, s4, 24
	slli	s4, s4, 1
	srai	s5, s5, 31
	srai	s6, s6, 31
	andi	s5, s5, 27
	andi	s6, s6, 27
	xor	s3, s5, s3
	xor	s4, s6, s4
	xor	s5, s3, t2
	xor	s6, s4, s1
	xor	s3, s3, t4
	xor	s4, s4, s2
	slli	s7, s5, 1
	xor	s0, s7, s0
	slli	s7, s6, 1
	xor	t6, s7, t6
	slli	s7, s3, 1
	xor	t5, s7, t5
	slli	s7, s4, 1
	xor	t3, s7, t3
	xor	t4, s0, t4
	slli	s5, s5, 24
	slli	s6, s6, 24
	slli	s3, s3, 24
	slli	s4, s4, 24
	srai	s0, s5, 31
	srai	s5, s6, 31
	srai	s3, s3, 31
	srai	s4, s4, 31
	andi	s0, s0, 27
	andi	s5, s5, 27
	xor	t6, t6, s2
	andi	s2, s3, 27
	xor	t2, t5, t2
	andi	t5, s4, 27
	xor	t3, t3, s1
	xor	t4, t4, s0
	xor	t6, t6, s5
	xor	t2, t2, s2
	xor	t3, t3, t5
	sb	t4, -1(t1)
	sb	t6, 0(t1)
	sb	t2, 1(t1)
	sb	t3, 2(t1)
	addi	t1, t1, 4
	bne	t1, a2, .LBB4_7
.LBB4_8:                                #   in Loop: Header=BB4_4 Depth=1
	lbu	t1, 1(a1)
	lbu	t2, 2(a1)
	lbu	t3, 3(a1)
	lbu	t4, 5(a1)
	lbu	t5, 6(a1)
	lbu	t6, 7(a1)
	lbu	s0, 9(a1)
	lbu	s1, 10(a1)
	lbu	s2, 13(a1)
	lbu	s3, 11(a1)
	lbu	s4, 14(a1)
	lbu	s5, 15(a1)
	sb	s2, 1(a1)
	sb	s1, 2(a1)
	sb	t6, 3(a1)
	sb	t1, 5(a1)
	sb	s4, 6(a1)
	sb	s3, 7(a1)
	sb	t4, 9(a1)
	sb	t2, 10(a1)
	addi	t0, t0, -1
	sb	s5, 11(a1)
	sb	s0, 13(a1)
	sb	t5, 14(a1)
	sb	t3, 15(a1)
	mv	t1, a1
.LBB4_9:                                #   Parent Loop BB4_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	lbu	t2, 0(t1)
	add	t2, a5, t2
	lbu	t2, 0(t2)
	sb	t2, 0(t1)
	addi	t1, t1, 1
	bne	t1, a3, .LBB4_9
# %bb.10:                               #   in Loop: Header=BB4_4 Depth=1
	mv	t1, a6
	mv	t2, a1
.LBB4_11:                               #   Parent Loop BB4_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	lbu	t3, 0(t1)
	lbu	t4, 0(t2)
	xor	t3, t4, t3
	sb	t3, 0(t2)
	addi	t2, t2, 1
	addi	t1, t1, 1
	bne	t2, a3, .LBB4_11
# %bb.12:                               #   in Loop: Header=BB4_4 Depth=1
	addi	a6, a6, -16
	bnez	t0, .LBB4_4
# %bb.13:
	lw	s0, 28(sp)                      # 4-byte Folded Reload
	lw	s1, 24(sp)                      # 4-byte Folded Reload
	lw	s2, 20(sp)                      # 4-byte Folded Reload
	lw	s3, 16(sp)                      # 4-byte Folded Reload
	lw	s4, 12(sp)                      # 4-byte Folded Reload
	lw	s5, 8(sp)                       # 4-byte Folded Reload
	lw	s6, 4(sp)                       # 4-byte Folded Reload
	lw	s7, 0(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end4:
	.size	rijndaelDecrypt, .Lfunc_end4-rijndaelDecrypt
                                        # -- End function
	.globl	AES_CBC_encrypt                 # -- Begin function AES_CBC_encrypt
	.p2align	2
	.type	AES_CBC_encrypt,@function
AES_CBC_encrypt:                        # @AES_CBC_encrypt
# %bb.0:
	addi	sp, sp, -48
	sw	ra, 44(sp)                      # 4-byte Folded Spill
	sw	s0, 40(sp)                      # 4-byte Folded Spill
	sw	s1, 36(sp)                      # 4-byte Folded Spill
	sw	s2, 32(sp)                      # 4-byte Folded Spill
	sw	s3, 28(sp)                      # 4-byte Folded Spill
	sw	s4, 24(sp)                      # 4-byte Folded Spill
	sw	s5, 20(sp)                      # 4-byte Folded Spill
	mv	s1, a4
	mv	s0, a1
	andi	s2, a3, 15
	sltiu	a1, a3, 32
	not	a1, a1
	seqz	a4, s2
	and	a1, a1, a4
	srli	a4, a3, 4
	beqz	a1, .LBB5_2
# %bb.1:
	li	s2, 16
.LBB5_2:
	sub	s4, a4, a1
	beqz	s4, .LBB5_19
# %bb.3:
	blez	a3, .LBB5_6
# %bb.4:
	addi	a3, a3, -1
	li	a1, 1
.LBB5_5:                                # =>This Inner Loop Header: Depth=1
	add	a4, a2, a3
	lbu	a4, 0(a4)
	add	a5, s1, a3
	addi	a6, a3, 1
	addi	a3, a3, -1
	sb	a4, 0(a5)
	bltu	a1, a6, .LBB5_5
.LBB5_6:
	call	KeyExpansion
	li	s5, 0
	mv	a0, s1
.LBB5_7:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB5_8 Depth 2
	mv	a1, s0
	mv	s0, a0
	slli	a0, s5, 4
	add	a0, a0, s1
	addi	s3, a0, 16
	mv	a0, s0
.LBB5_8:                                #   Parent Loop BB5_7 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	lbu	a2, 0(a1)
	lbu	a3, 0(a0)
	xor	a2, a3, a2
	sb	a2, 0(a0)
	addi	a0, a0, 1
	addi	a1, a1, 1
	bne	a0, s3, .LBB5_8
# %bb.9:                                #   in Loop: Header=BB5_7 Depth=1
	addi	s4, s4, -1
	mv	a0, s0
	mv	a1, s0
	call	rijndaelEncrypt
	addi	a0, s0, 16
	addi	s5, s5, 1
	bnez	s4, .LBB5_7
# %bb.10:
	beqz	s2, .LBB5_18
# %bb.11:
	sw	zero, 4(sp)
	sw	zero, 8(sp)
	sw	zero, 12(sp)
	sw	zero, 16(sp)
	addi	a3, s2, -1
	addi	a1, sp, 4
	li	a2, 1
.LBB5_12:                               # =>This Inner Loop Header: Depth=1
	add	a4, a0, a3
	lbu	a4, 0(a4)
	add	a5, a1, a3
	addi	a6, a3, 1
	addi	a3, a3, -1
	sb	a4, 0(a5)
	bltu	a2, a6, .LBB5_12
# %bb.13:
	addi	s2, s2, -1
	li	a1, 1
.LBB5_14:                               # =>This Inner Loop Header: Depth=1
	add	a2, a0, s2
	lbu	a3, -16(a2)
	addi	a4, s2, 1
	addi	s2, s2, -1
	sb	a3, 0(a2)
	bltu	a1, a4, .LBB5_14
# %bb.15:
	addi	a0, sp, 4
	mv	a1, s0
.LBB5_16:                               # =>This Inner Loop Header: Depth=1
	lbu	a2, 0(a0)
	lbu	a3, 0(a1)
	xor	a2, a3, a2
	sb	a2, 0(a1)
	addi	a1, a1, 1
	addi	a0, a0, 1
	bne	a1, s3, .LBB5_16
# %bb.17:
	mv	a0, s0
	mv	a1, s0
	call	rijndaelEncrypt
.LBB5_18:
	li	a0, 0
	j	.LBB5_20
.LBB5_19:
	li	a0, 1
.LBB5_20:
	lw	ra, 44(sp)                      # 4-byte Folded Reload
	lw	s0, 40(sp)                      # 4-byte Folded Reload
	lw	s1, 36(sp)                      # 4-byte Folded Reload
	lw	s2, 32(sp)                      # 4-byte Folded Reload
	lw	s3, 28(sp)                      # 4-byte Folded Reload
	lw	s4, 24(sp)                      # 4-byte Folded Reload
	lw	s5, 20(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 48
	ret
.Lfunc_end5:
	.size	AES_CBC_encrypt, .Lfunc_end5-AES_CBC_encrypt
                                        # -- End function
	.globl	AES_CBC_decrypt                 # -- Begin function AES_CBC_decrypt
	.p2align	2
	.type	AES_CBC_decrypt,@function
AES_CBC_decrypt:                        # @AES_CBC_decrypt
# %bb.0:
	addi	sp, sp, -48
	sw	ra, 44(sp)                      # 4-byte Folded Spill
	sw	s0, 40(sp)                      # 4-byte Folded Spill
	sw	s1, 36(sp)                      # 4-byte Folded Spill
	sw	s2, 32(sp)                      # 4-byte Folded Spill
	sw	s3, 28(sp)                      # 4-byte Folded Spill
	sw	s4, 24(sp)                      # 4-byte Folded Spill
	sw	s5, 20(sp)                      # 4-byte Folded Spill
	sw	s6, 16(sp)                      # 4-byte Folded Spill
	sw	s7, 12(sp)                      # 4-byte Folded Spill
	mv	s3, a4
	mv	s2, a2
	mv	s4, a1
	andi	s5, a3, 15
	sltiu	a1, a3, 32
	not	a1, a1
	seqz	a2, s5
	and	a1, a1, a2
	srli	a3, a3, 4
	beqz	a1, .LBB6_2
# %bb.1:
	li	s5, 16
.LBB6_2:
	sub	a3, a3, a1
	beqz	a3, .LBB6_9
# %bb.3:
	snez	a1, s5
	sub	s6, a3, a1
	call	KeyExpansion
	beqz	s6, .LBB6_10
# %bb.4:
	li	s7, 0
	mv	s0, s3
.LBB6_5:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB6_6 Depth 2
	mv	s1, s2
	slli	a0, s7, 4
	add	a0, a0, s3
	addi	s2, a0, 16
	mv	a0, s1
	mv	a1, s0
	call	rijndaelDecrypt
	mv	a0, s0
.LBB6_6:                                #   Parent Loop BB6_5 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	lbu	a1, 0(s4)
	lbu	a2, 0(a0)
	xor	a1, a2, a1
	sb	a1, 0(a0)
	addi	a0, a0, 1
	addi	s4, s4, 1
	bne	a0, s2, .LBB6_6
# %bb.7:                                #   in Loop: Header=BB6_5 Depth=1
	addi	s6, s6, -1
	addi	s2, s1, 16
	addi	s0, s0, 16
	addi	s7, s7, 1
	mv	s4, s1
	bnez	s6, .LBB6_5
# %bb.8:
	bnez	s5, .LBB6_11
	j	.LBB6_17
.LBB6_9:
	li	a0, 1
	j	.LBB6_18
.LBB6_10:
	mv	s1, s4
	mv	s0, s3
	beqz	s5, .LBB6_17
.LBB6_11:
	mv	a0, s2
	mv	a1, s0
	call	rijndaelDecrypt
	addi	a1, s5, 15
	add	a0, s2, a1
	add	a1, s0, a1
	addi	a2, s2, 15
.LBB6_12:                               # =>This Inner Loop Header: Depth=1
	lbu	a3, -16(a1)
	lbu	a4, 0(a0)
	addi	a0, a0, -1
	xor	a3, a4, a3
	sb	a3, 0(a1)
	addi	a1, a1, -1
	bne	a0, a2, .LBB6_12
# %bb.13:
	addi	a0, s0, -1
	add	a1, s5, s2
	add	s5, a0, s5
	addi	a1, a1, 15
.LBB6_14:                               # =>This Inner Loop Header: Depth=1
	lbu	a2, 0(a1)
	sb	a2, 0(s5)
	addi	s5, s5, -1
	addi	a1, a1, -1
	bne	s5, a0, .LBB6_14
# %bb.15:
	mv	a0, s0
	mv	a1, s0
	call	rijndaelDecrypt
	addi	a0, s0, 16
.LBB6_16:                               # =>This Inner Loop Header: Depth=1
	lbu	a1, 0(s1)
	lbu	a2, 0(s0)
	xor	a1, a2, a1
	sb	a1, 0(s0)
	addi	s0, s0, 1
	addi	s1, s1, 1
	bne	s0, a0, .LBB6_16
.LBB6_17:
	li	a0, 0
.LBB6_18:
	lw	ra, 44(sp)                      # 4-byte Folded Reload
	lw	s0, 40(sp)                      # 4-byte Folded Reload
	lw	s1, 36(sp)                      # 4-byte Folded Reload
	lw	s2, 32(sp)                      # 4-byte Folded Reload
	lw	s3, 28(sp)                      # 4-byte Folded Reload
	lw	s4, 24(sp)                      # 4-byte Folded Reload
	lw	s5, 20(sp)                      # 4-byte Folded Reload
	lw	s6, 16(sp)                      # 4-byte Folded Reload
	lw	s7, 12(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 48
	ret
.Lfunc_end6:
	.size	AES_CBC_decrypt, .Lfunc_end6-AES_CBC_decrypt
                                        # -- End function
	.globl	AES_CFB_encrypt                 # -- Begin function AES_CFB_encrypt
	.p2align	2
	.type	AES_CFB_encrypt,@function
AES_CFB_encrypt:                        # @AES_CFB_encrypt
# %bb.0:
	mv	a5, a4
	mv	a4, a3
	mv	a3, a2
	li	a2, 1
	tail	CFB_cipher
.Lfunc_end7:
	.size	AES_CFB_encrypt, .Lfunc_end7-AES_CFB_encrypt
                                        # -- End function
	.p2align	2                               # -- Begin function CFB_cipher
	.type	CFB_cipher,@function
CFB_cipher:                             # @CFB_cipher
# %bb.0:
	addi	sp, sp, -64
	sw	ra, 60(sp)                      # 4-byte Folded Spill
	sw	s0, 56(sp)                      # 4-byte Folded Spill
	sw	s1, 52(sp)                      # 4-byte Folded Spill
	sw	s2, 48(sp)                      # 4-byte Folded Spill
	sw	s3, 44(sp)                      # 4-byte Folded Spill
	sw	s4, 40(sp)                      # 4-byte Folded Spill
	sw	s5, 36(sp)                      # 4-byte Folded Spill
	sw	s6, 32(sp)                      # 4-byte Folded Spill
	sw	s7, 28(sp)                      # 4-byte Folded Spill
	sw	s8, 24(sp)                      # 4-byte Folded Spill
	mv	s3, a5
	mv	s1, a4
	mv	s0, a3
	mv	s4, a2
	mv	s5, a1
	call	KeyExpansion
	srli	s6, s1, 4
	beqz	s6, .LBB8_7
# %bb.1:
	li	s7, 0
	mv	s2, s3
.LBB8_2:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB8_3 Depth 2
	slli	a0, s7, 4
	add	a0, a0, s3
	addi	s8, a0, 16
	mv	a0, s5
	mv	a1, s2
	call	rijndaelEncrypt
	mv	a0, s0
	mv	a1, s2
.LBB8_3:                                #   Parent Loop BB8_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	lbu	a2, 0(a0)
	lbu	a3, 0(a1)
	xor	a2, a3, a2
	sb	a2, 0(a1)
	addi	a1, a1, 1
	addi	a0, a0, 1
	bne	a1, s8, .LBB8_3
# %bb.4:                                #   in Loop: Header=BB8_2 Depth=1
	mv	s5, s0
	beqz	s4, .LBB8_6
# %bb.5:                                #   in Loop: Header=BB8_2 Depth=1
	mv	s5, s2
.LBB8_6:                                #   in Loop: Header=BB8_2 Depth=1
	addi	s6, s6, -1
	addi	s0, s0, 16
	addi	s2, s2, 16
	addi	s7, s7, 1
	bnez	s6, .LBB8_2
	j	.LBB8_8
.LBB8_7:
	mv	s2, s3
.LBB8_8:
	andi	s1, s1, 15
	beqz	s1, .LBB8_11
# %bb.9:
	addi	a1, sp, 8
	addi	s3, sp, 8
	mv	a0, s5
	call	rijndaelEncrypt
	addi	a1, s1, -1
	add	a0, s2, a1
	add	s0, s0, a1
	add	a1, s3, a1
	addi	s2, s2, -1
.LBB8_10:                               # =>This Inner Loop Header: Depth=1
	lbu	a2, 0(a1)
	lbu	a3, 0(s0)
	xor	a2, a3, a2
	sb	a2, 0(a0)
	addi	a0, a0, -1
	addi	s0, s0, -1
	addi	a1, a1, -1
	bne	a0, s2, .LBB8_10
.LBB8_11:
	lw	ra, 60(sp)                      # 4-byte Folded Reload
	lw	s0, 56(sp)                      # 4-byte Folded Reload
	lw	s1, 52(sp)                      # 4-byte Folded Reload
	lw	s2, 48(sp)                      # 4-byte Folded Reload
	lw	s3, 44(sp)                      # 4-byte Folded Reload
	lw	s4, 40(sp)                      # 4-byte Folded Reload
	lw	s5, 36(sp)                      # 4-byte Folded Reload
	lw	s6, 32(sp)                      # 4-byte Folded Reload
	lw	s7, 28(sp)                      # 4-byte Folded Reload
	lw	s8, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 64
	ret
.Lfunc_end8:
	.size	CFB_cipher, .Lfunc_end8-CFB_cipher
                                        # -- End function
	.globl	AES_CFB_decrypt                 # -- Begin function AES_CFB_decrypt
	.p2align	2
	.type	AES_CFB_decrypt,@function
AES_CFB_decrypt:                        # @AES_CFB_decrypt
# %bb.0:
	mv	a5, a4
	mv	a4, a3
	mv	a3, a2
	li	a2, 0
	tail	CFB_cipher
.Lfunc_end9:
	.size	AES_CFB_decrypt, .Lfunc_end9-AES_CFB_decrypt
                                        # -- End function
	.globl	AES_OFB_encrypt                 # -- Begin function AES_OFB_encrypt
	.p2align	2
	.type	AES_OFB_encrypt,@function
AES_OFB_encrypt:                        # @AES_OFB_encrypt
# %bb.0:
	addi	sp, sp, -48
	sw	ra, 44(sp)                      # 4-byte Folded Spill
	sw	s0, 40(sp)                      # 4-byte Folded Spill
	sw	s1, 36(sp)                      # 4-byte Folded Spill
	sw	s2, 32(sp)                      # 4-byte Folded Spill
	sw	s3, 28(sp)                      # 4-byte Folded Spill
	sw	s4, 24(sp)                      # 4-byte Folded Spill
	sw	s5, 20(sp)                      # 4-byte Folded Spill
	sw	s6, 16(sp)                      # 4-byte Folded Spill
	mv	s1, a4
	mv	s0, a3
	li	a5, 15
	mv	a3, sp
	li	a4, 1
.LBB10_1:                               # =>This Inner Loop Header: Depth=1
	add	a6, a1, a5
	lbu	a6, 0(a6)
	add	a7, a3, a5
	addi	t0, a5, 1
	addi	a5, a5, -1
	sb	a6, 0(a7)
	bltu	a4, t0, .LBB10_1
# %bb.2:
	blez	s0, .LBB10_5
# %bb.3:
	addi	a3, s0, -1
	li	a1, 1
.LBB10_4:                               # =>This Inner Loop Header: Depth=1
	add	a4, a2, a3
	lbu	a4, 0(a4)
	add	a5, s1, a3
	addi	a6, a3, 1
	addi	a3, a3, -1
	sb	a4, 0(a5)
	bltu	a1, a6, .LBB10_4
.LBB10_5:
	call	KeyExpansion
	li	a0, 16
	bgeu	s0, a0, .LBB10_7
# %bb.6:
	mv	s2, s1
	j	.LBB10_11
.LBB10_7:
	li	s3, 0
	srli	s4, s0, 4
	mv	s2, s1
.LBB10_8:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB10_9 Depth 2
	slli	a0, s3, 4
	add	a0, a0, s1
	addi	s5, a0, 16
	mv	a0, sp
	mv	a1, sp
	mv	s6, sp
	call	rijndaelEncrypt
	mv	a0, s2
.LBB10_9:                               #   Parent Loop BB10_8 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	lbu	a1, 0(s6)
	lbu	a2, 0(a0)
	xor	a1, a2, a1
	sb	a1, 0(a0)
	addi	a0, a0, 1
	addi	s6, s6, 1
	bne	a0, s5, .LBB10_9
# %bb.10:                               #   in Loop: Header=BB10_8 Depth=1
	addi	s4, s4, -1
	addi	s2, s2, 16
	addi	s3, s3, 1
	bnez	s4, .LBB10_8
.LBB10_11:
	andi	s0, s0, 15
	beqz	s0, .LBB10_14
# %bb.12:
	mv	a0, sp
	mv	a1, sp
	mv	s1, sp
	call	rijndaelEncrypt
	addi	a1, s0, -1
	add	a0, s2, a1
	add	a1, s1, a1
	addi	s2, s2, -1
.LBB10_13:                              # =>This Inner Loop Header: Depth=1
	lbu	a2, 0(a1)
	lbu	a3, 0(a0)
	xor	a2, a3, a2
	sb	a2, 0(a0)
	addi	a0, a0, -1
	addi	a1, a1, -1
	bne	a0, s2, .LBB10_13
.LBB10_14:
	lw	ra, 44(sp)                      # 4-byte Folded Reload
	lw	s0, 40(sp)                      # 4-byte Folded Reload
	lw	s1, 36(sp)                      # 4-byte Folded Reload
	lw	s2, 32(sp)                      # 4-byte Folded Reload
	lw	s3, 28(sp)                      # 4-byte Folded Reload
	lw	s4, 24(sp)                      # 4-byte Folded Reload
	lw	s5, 20(sp)                      # 4-byte Folded Reload
	lw	s6, 16(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 48
	ret
.Lfunc_end10:
	.size	AES_OFB_encrypt, .Lfunc_end10-AES_OFB_encrypt
                                        # -- End function
	.globl	AES_OFB_decrypt                 # -- Begin function AES_OFB_decrypt
	.p2align	2
	.type	AES_OFB_decrypt,@function
AES_OFB_decrypt:                        # @AES_OFB_decrypt
# %bb.0:
	tail	AES_OFB_encrypt
.Lfunc_end11:
	.size	AES_OFB_decrypt, .Lfunc_end11-AES_OFB_decrypt
                                        # -- End function
	.globl	AES_CTR_encrypt                 # -- Begin function AES_CTR_encrypt
	.p2align	2
	.type	AES_CTR_encrypt,@function
AES_CTR_encrypt:                        # @AES_CTR_encrypt
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	sw	s1, 20(sp)                      # 4-byte Folded Spill
	sw	s2, 16(sp)                      # 4-byte Folded Spill
	mv	s0, a4
	mv	s1, a3
	mv	s2, a2
	sw	zero, 0(sp)
	sw	zero, 4(sp)
	sw	zero, 8(sp)
	sw	zero, 12(sp)
	li	a4, 11
	mv	a2, sp
	li	a3, 1
.LBB12_1:                               # =>This Inner Loop Header: Depth=1
	add	a5, a1, a4
	lbu	a5, 0(a5)
	add	a6, a2, a4
	addi	a7, a4, 1
	addi	a4, a4, -1
	sb	a5, 0(a6)
	bltu	a3, a7, .LBB12_1
# %bb.2:
	lbu	a1, 15(sp)
	xori	a1, a1, 1
	sb	a1, 15(sp)
	call	KeyExpansion
	mv	a0, sp
	li	a1, 0
	mv	a2, s2
	mv	a3, s1
	mv	a4, s0
	call	CTR_cipher
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	lw	s1, 20(sp)                      # 4-byte Folded Reload
	lw	s2, 16(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end12:
	.size	AES_CTR_encrypt, .Lfunc_end12-AES_CTR_encrypt
                                        # -- End function
	.p2align	2                               # -- Begin function CTR_cipher
	.type	CTR_cipher,@function
CTR_cipher:                             # @CTR_cipher
# %bb.0:
	addi	sp, sp, -80
	sw	ra, 76(sp)                      # 4-byte Folded Spill
	sw	s0, 72(sp)                      # 4-byte Folded Spill
	sw	s1, 68(sp)                      # 4-byte Folded Spill
	sw	s2, 64(sp)                      # 4-byte Folded Spill
	sw	s3, 60(sp)                      # 4-byte Folded Spill
	sw	s4, 56(sp)                      # 4-byte Folded Spill
	sw	s5, 52(sp)                      # 4-byte Folded Spill
	sw	s6, 48(sp)                      # 4-byte Folded Spill
	sw	s7, 44(sp)                      # 4-byte Folded Spill
	mv	s1, a4
	mv	s0, a3
	blez	a3, .LBB13_3
# %bb.1:
	addi	a4, s0, -1
	li	a3, 1
.LBB13_2:                               # =>This Inner Loop Header: Depth=1
	add	a5, a2, a4
	lbu	a5, 0(a5)
	add	a6, s1, a4
	addi	a7, a4, 1
	addi	a4, a4, -1
	sb	a5, 0(a6)
	bltu	a3, a7, .LBB13_2
.LBB13_3:
	srli	s3, s0, 4
	li	a4, 15
	addi	a2, sp, 28
	li	a3, 1
.LBB13_4:                               # =>This Inner Loop Header: Depth=1
	add	a5, a0, a4
	lbu	a5, 0(a5)
	add	a6, a2, a4
	addi	a7, a4, 1
	addi	a4, a4, -1
	sb	a5, 0(a6)
	bltu	a3, a7, .LBB13_4
# %bb.5:
	li	a0, 2
	beq	a1, a0, .LBB13_10
# %bb.6:
	li	a0, 8
	beq	a1, a0, .LBB13_9
# %bb.7:
	li	a0, 5
	li	s2, 15
	bne	a1, a0, .LBB13_11
# %bb.8:
	lbu	a0, 36(sp)
	lbu	a1, 40(sp)
	andi	a0, a0, 127
	andi	a1, a1, 127
	sb	a0, 36(sp)
	sb	a1, 40(sp)
	j	.LBB13_11
.LBB13_9:
	li	s2, 0
	lbu	a0, 43(sp)
	ori	a0, a0, 128
	sb	a0, 43(sp)
	j	.LBB13_11
.LBB13_10:
	addi	a0, sp, 28
	li	a1, 15
	li	s2, 15
	call	incBlock
.LBB13_11:
	li	a0, 16
	bgeu	s0, a0, .LBB13_13
# %bb.12:
	mv	s4, s1
	j	.LBB13_17
.LBB13_13:
	li	s5, 0
	mv	s4, s1
.LBB13_14:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB13_15 Depth 2
	slli	a0, s5, 4
	add	a0, a0, s1
	addi	s6, a0, 16
	addi	a0, sp, 28
	addi	a1, sp, 12
	addi	s7, sp, 12
	call	rijndaelEncrypt
	mv	a0, s4
.LBB13_15:                              #   Parent Loop BB13_14 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	lbu	a1, 0(s7)
	lbu	a2, 0(a0)
	xor	a1, a2, a1
	sb	a1, 0(a0)
	addi	a0, a0, 1
	addi	s7, s7, 1
	bne	a0, s6, .LBB13_15
# %bb.16:                               #   in Loop: Header=BB13_14 Depth=1
	addi	s3, s3, -1
	addi	a0, sp, 28
	mv	a1, s2
	call	incBlock
	addi	s4, s4, 16
	addi	s5, s5, 1
	bnez	s3, .LBB13_14
.LBB13_17:
	andi	s0, s0, 15
	beqz	s0, .LBB13_20
# %bb.18:
	addi	a0, sp, 28
	addi	a1, sp, 28
	addi	s1, sp, 28
	call	rijndaelEncrypt
	addi	a1, s0, -1
	add	a0, s4, a1
	add	a1, s1, a1
	addi	s4, s4, -1
.LBB13_19:                              # =>This Inner Loop Header: Depth=1
	lbu	a2, 0(a1)
	lbu	a3, 0(a0)
	xor	a2, a3, a2
	sb	a2, 0(a0)
	addi	a0, a0, -1
	addi	a1, a1, -1
	bne	a0, s4, .LBB13_19
.LBB13_20:
	lw	ra, 76(sp)                      # 4-byte Folded Reload
	lw	s0, 72(sp)                      # 4-byte Folded Reload
	lw	s1, 68(sp)                      # 4-byte Folded Reload
	lw	s2, 64(sp)                      # 4-byte Folded Reload
	lw	s3, 60(sp)                      # 4-byte Folded Reload
	lw	s4, 56(sp)                      # 4-byte Folded Reload
	lw	s5, 52(sp)                      # 4-byte Folded Reload
	lw	s6, 48(sp)                      # 4-byte Folded Reload
	lw	s7, 44(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 80
	ret
.Lfunc_end13:
	.size	CTR_cipher, .Lfunc_end13-CTR_cipher
                                        # -- End function
	.globl	AES_CTR_decrypt                 # -- Begin function AES_CTR_decrypt
	.p2align	2
	.type	AES_CTR_decrypt,@function
AES_CTR_decrypt:                        # @AES_CTR_decrypt
# %bb.0:
	tail	AES_CTR_encrypt
.Lfunc_end14:
	.size	AES_CTR_decrypt, .Lfunc_end14-AES_CTR_decrypt
                                        # -- End function
	.globl	AES_XTS_encrypt                 # -- Begin function AES_XTS_encrypt
	.p2align	2
	.type	AES_XTS_encrypt,@function
AES_XTS_encrypt:                        # @AES_XTS_encrypt
# %bb.0:
	mv	a5, a1
	li	a1, 16
	bgeu	a3, a1, .LBB15_2
# %bb.1:
	li	a0, 1
	ret
.LBB15_2:
	blez	a3, .LBB15_5
# %bb.3:
	addi	a6, a3, -1
	li	a1, 1
.LBB15_4:                               # =>This Inner Loop Header: Depth=1
	add	a7, a2, a6
	lbu	a7, 0(a7)
	add	t0, a4, a6
	addi	t1, a6, 1
	addi	a6, a6, -1
	sb	a7, 0(t0)
	bltu	a1, t1, .LBB15_4
.LBB15_5:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	li	a1, 1
	mv	a2, a5
	call	XTS_cipher
	li	a0, 0
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end15:
	.size	AES_XTS_encrypt, .Lfunc_end15-AES_XTS_encrypt
                                        # -- End function
	.p2align	2                               # -- Begin function XTS_cipher
	.type	XTS_cipher,@function
XTS_cipher:                             # @XTS_cipher
# %bb.0:
	addi	sp, sp, -80
	sw	ra, 76(sp)                      # 4-byte Folded Spill
	sw	s0, 72(sp)                      # 4-byte Folded Spill
	sw	s1, 68(sp)                      # 4-byte Folded Spill
	sw	s2, 64(sp)                      # 4-byte Folded Spill
	sw	s3, 60(sp)                      # 4-byte Folded Spill
	sw	s4, 56(sp)                      # 4-byte Folded Spill
	sw	s5, 52(sp)                      # 4-byte Folded Spill
	sw	s6, 48(sp)                      # 4-byte Folded Spill
	sw	s7, 44(sp)                      # 4-byte Folded Spill
	sw	s8, 40(sp)                      # 4-byte Folded Spill
	sw	s9, 36(sp)                      # 4-byte Folded Spill
	mv	s2, a4
	mv	s1, a1
	mv	s0, a0
	beqz	a1, .LBB16_2
# %bb.1:
	lui	s3, %hi(rijndaelEncrypt)
	addi	s3, s3, %lo(rijndaelEncrypt)
	j	.LBB16_3
.LBB16_2:
	lui	s3, %hi(rijndaelDecrypt)
	addi	s3, s3, %lo(rijndaelDecrypt)
.LBB16_3:
	srli	a0, a3, 4
	andi	s4, a3, 15
	snez	a1, s4
	sub	s5, a0, a1
	beqz	a2, .LBB16_6
# %bb.4:
	li	a3, 15
	addi	a0, sp, 20
	li	a1, 1
.LBB16_5:                               # =>This Inner Loop Header: Depth=1
	add	a4, a2, a3
	lbu	a4, 0(a4)
	add	a5, a0, a3
	addi	a6, a3, 1
	addi	a3, a3, -1
	sb	a4, 0(a5)
	bltu	a1, a6, .LBB16_5
	j	.LBB16_9
.LBB16_6:
	addi	a0, sp, 35
	addi	a1, sp, 19
.LBB16_7:                               # =>This Inner Loop Header: Depth=1
	sb	zero, 0(a0)
	addi	a0, a0, -1
	bne	a0, a1, .LBB16_7
# %bb.8:
	sb	zero, 20(sp)
.LBB16_9:
	addi	a0, s0, 16
	call	KeyExpansion
	addi	a0, sp, 20
	addi	a1, sp, 20
	call	rijndaelEncrypt
	mv	a0, s0
	call	KeyExpansion
	beqz	s5, .LBB16_19
# %bb.10:
	li	s6, 0
	addi	s7, sp, 36
	li	s8, -121
	mv	s0, s2
.LBB16_11:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB16_12 Depth 2
                                        #     Child Loop BB16_14 Depth 2
                                        #     Child Loop BB16_16 Depth 2
	slli	a0, s6, 4
	add	a0, a0, s2
	addi	s9, a0, 16
	addi	a0, sp, 20
	mv	a1, s0
.LBB16_12:                              #   Parent Loop BB16_11 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	lbu	a2, 0(a0)
	lbu	a3, 0(a1)
	xor	a2, a3, a2
	sb	a2, 0(a1)
	addi	a1, a1, 1
	addi	a0, a0, 1
	bne	a1, s9, .LBB16_12
# %bb.13:                               #   in Loop: Header=BB16_11 Depth=1
	mv	a0, s0
	mv	a1, s0
	jalr	s3
	addi	a0, sp, 20
	mv	a1, s0
.LBB16_14:                              #   Parent Loop BB16_11 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	lbu	a2, 0(a0)
	lbu	a3, 0(a1)
	xor	a2, a3, a2
	sb	a2, 0(a1)
	addi	a1, a1, 1
	addi	a0, a0, 1
	bne	a1, s9, .LBB16_14
# %bb.15:                               #   in Loop: Header=BB16_11 Depth=1
	li	a0, 0
	addi	a1, sp, 20
.LBB16_16:                              #   Parent Loop BB16_11 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	lbu	a2, 0(a1)
	slli	a2, a2, 1
	or	a0, a2, a0
	sb	a0, 0(a1)
	addi	a1, a1, 1
	srli	a0, a0, 8
	bne	a1, s7, .LBB16_16
# %bb.17:                               #   in Loop: Header=BB16_11 Depth=1
	lbu	a1, 20(sp)
	addi	s5, s5, -1
	mul	a0, a0, s8
	addi	s0, s0, 16
	xor	a0, a1, a0
	sb	a0, 20(sp)
	addi	s6, s6, 1
	bnez	s5, .LBB16_11
# %bb.18:
	bnez	s4, .LBB16_20
	j	.LBB16_40
.LBB16_19:
	mv	s0, s2
	beqz	s4, .LBB16_40
.LBB16_20:
	li	a2, 15
	addi	a0, sp, 20
	addi	a1, sp, 4
	li	a3, 1
.LBB16_21:                              # =>This Inner Loop Header: Depth=1
	add	a4, a0, a2
	lbu	a4, 0(a4)
	add	a5, a1, a2
	addi	a6, a2, 1
	addi	a2, a2, -1
	sb	a4, 0(a5)
	bltu	a3, a6, .LBB16_21
# %bb.22:
	addi	a0, sp, 4
	beqz	s1, .LBB16_24
# %bb.23:
	addi	a0, sp, 20
.LBB16_24:
	li	a1, 0
	addi	a2, a0, 16
	mv	a3, a0
.LBB16_25:                              # =>This Inner Loop Header: Depth=1
	lbu	a4, 0(a3)
	slli	a4, a4, 1
	or	a1, a4, a1
	sb	a1, 0(a3)
	addi	a3, a3, 1
	srli	a1, a1, 8
	bne	a3, a2, .LBB16_25
# %bb.26:
	lbu	a2, 0(a0)
	li	a3, -121
	mul	a1, a1, a3
	addi	s1, s0, 16
	xor	a1, a2, a1
	sb	a1, 0(a0)
	addi	a0, sp, 4
	mv	a1, s0
.LBB16_27:                              # =>This Inner Loop Header: Depth=1
	lbu	a2, 0(a0)
	lbu	a3, 0(a1)
	xor	a2, a3, a2
	sb	a2, 0(a1)
	addi	a1, a1, 1
	addi	a0, a0, 1
	bne	a1, s1, .LBB16_27
# %bb.28:
	mv	a0, s0
	mv	a1, s0
	jalr	s3
	addi	a0, sp, 4
	mv	a1, s0
.LBB16_29:                              # =>This Inner Loop Header: Depth=1
	lbu	a2, 0(a0)
	lbu	a3, 0(a1)
	xor	a2, a3, a2
	sb	a2, 0(a1)
	addi	a1, a1, 1
	addi	a0, a0, 1
	bne	a1, s1, .LBB16_29
# %bb.30:
	li	a2, 15
	addi	a0, sp, 4
	li	a1, 1
.LBB16_31:                              # =>This Inner Loop Header: Depth=1
	add	a3, s0, a2
	lbu	a3, 0(a3)
	add	a4, a0, a2
	addi	a5, a2, 1
	addi	a2, a2, -1
	sb	a3, 0(a4)
	bltu	a1, a5, .LBB16_31
# %bb.32:
	add	a0, s0, s4
.LBB16_33:                              # =>This Inner Loop Header: Depth=1
	lbu	a1, 15(a0)
	addi	a2, a0, -1
	sb	a1, -1(a0)
	mv	a0, a2
	bne	a2, s0, .LBB16_33
# %bb.34:
	addi	a0, s0, 15
	addi	a2, sp, 4
	add	a1, a0, s4
	add	a2, s4, a2
	addi	a2, a2, -1
.LBB16_35:                              # =>This Inner Loop Header: Depth=1
	lbu	a3, 0(a2)
	sb	a3, 0(a1)
	addi	a1, a1, -1
	addi	a2, a2, -1
	bne	a1, a0, .LBB16_35
# %bb.36:
	addi	a0, sp, 20
	mv	a1, s0
.LBB16_37:                              # =>This Inner Loop Header: Depth=1
	lbu	a2, 0(a0)
	lbu	a3, 0(a1)
	xor	a2, a3, a2
	sb	a2, 0(a1)
	addi	a1, a1, 1
	addi	a0, a0, 1
	bne	a1, s1, .LBB16_37
# %bb.38:
	mv	a0, s0
	mv	a1, s0
	jalr	s3
	addi	a0, sp, 20
.LBB16_39:                              # =>This Inner Loop Header: Depth=1
	lbu	a1, 0(a0)
	lbu	a2, 0(s0)
	xor	a1, a2, a1
	sb	a1, 0(s0)
	addi	s0, s0, 1
	addi	a0, a0, 1
	bne	s0, s1, .LBB16_39
.LBB16_40:
	lw	ra, 76(sp)                      # 4-byte Folded Reload
	lw	s0, 72(sp)                      # 4-byte Folded Reload
	lw	s1, 68(sp)                      # 4-byte Folded Reload
	lw	s2, 64(sp)                      # 4-byte Folded Reload
	lw	s3, 60(sp)                      # 4-byte Folded Reload
	lw	s4, 56(sp)                      # 4-byte Folded Reload
	lw	s5, 52(sp)                      # 4-byte Folded Reload
	lw	s6, 48(sp)                      # 4-byte Folded Reload
	lw	s7, 44(sp)                      # 4-byte Folded Reload
	lw	s8, 40(sp)                      # 4-byte Folded Reload
	lw	s9, 36(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 80
	ret
.Lfunc_end16:
	.size	XTS_cipher, .Lfunc_end16-XTS_cipher
                                        # -- End function
	.globl	AES_XTS_decrypt                 # -- Begin function AES_XTS_decrypt
	.p2align	2
	.type	AES_XTS_decrypt,@function
AES_XTS_decrypt:                        # @AES_XTS_decrypt
# %bb.0:
	mv	a5, a1
	li	a1, 16
	bgeu	a3, a1, .LBB17_2
# %bb.1:
	li	a0, 1
	ret
.LBB17_2:
	blez	a3, .LBB17_5
# %bb.3:
	addi	a6, a3, -1
	li	a1, 1
.LBB17_4:                               # =>This Inner Loop Header: Depth=1
	add	a7, a2, a6
	lbu	a7, 0(a7)
	add	t0, a4, a6
	addi	t1, a6, 1
	addi	a6, a6, -1
	sb	a7, 0(t0)
	bltu	a1, t1, .LBB17_4
.LBB17_5:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	li	a1, 0
	mv	a2, a5
	call	XTS_cipher
	li	a0, 0
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end17:
	.size	AES_XTS_decrypt, .Lfunc_end17-AES_XTS_decrypt
                                        # -- End function
	.globl	AES_CMAC                        # -- Begin function AES_CMAC
	.p2align	2
	.type	AES_CMAC,@function
AES_CMAC:                               # @AES_CMAC
# %bb.0:
	addi	sp, sp, -48
	sw	ra, 44(sp)                      # 4-byte Folded Spill
	sw	s0, 40(sp)                      # 4-byte Folded Spill
	sw	s1, 36(sp)                      # 4-byte Folded Spill
	sw	s2, 32(sp)                      # 4-byte Folded Spill
	mv	s0, a3
	mv	s1, a2
	mv	s2, a1
	mv	a1, a0
	sw	zero, 16(sp)
	sw	zero, 20(sp)
	sw	zero, 24(sp)
	sw	zero, 28(sp)
	li	a3, 15
	addi	a0, sp, 16
	li	a2, 1
.LBB18_1:                               # =>This Inner Loop Header: Depth=1
	add	a4, a0, a3
	lbu	a4, 0(a4)
	add	a5, s0, a3
	addi	a6, a3, 1
	addi	a3, a3, -1
	sb	a4, 0(a5)
	bltu	a2, a6, .LBB18_1
# %bb.2:
	li	a0, 1
	addi	a2, sp, 16
	mv	a3, sp
	call	getSubkeys
	addi	a0, sp, 16
	mv	a1, sp
	mv	a2, s2
	mv	a3, s1
	mv	a4, s0
	call	cMac
	lw	ra, 44(sp)                      # 4-byte Folded Reload
	lw	s0, 40(sp)                      # 4-byte Folded Reload
	lw	s1, 36(sp)                      # 4-byte Folded Reload
	lw	s2, 32(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 48
	ret
.Lfunc_end18:
	.size	AES_CMAC, .Lfunc_end18-AES_CMAC
                                        # -- End function
	.p2align	2                               # -- Begin function getSubkeys
	.type	getSubkeys,@function
getSubkeys:                             # @getSubkeys
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	sw	s1, 4(sp)                       # 4-byte Folded Spill
	sw	s2, 0(sp)                       # 4-byte Folded Spill
	mv	s0, a3
	mv	s1, a2
	mv	s2, a0
	mv	a0, a1
	call	KeyExpansion
	mv	a0, s1
	mv	a1, s1
	call	rijndaelEncrypt
	beqz	s2, .LBB19_4
# %bb.1:
	li	a0, 0
	li	a2, 15
	li	a1, 1
.LBB19_2:                               # =>This Inner Loop Header: Depth=1
	add	a3, s1, a2
	lbu	a4, 0(a3)
	slli	a4, a4, 1
	or	a0, a4, a0
	addi	a4, a2, 1
	addi	a2, a2, -1
	sb	a0, 0(a3)
	srli	a0, a0, 8
	bltu	a1, a4, .LBB19_2
# %bb.3:
	lbu	a1, 15(s1)
	li	a2, -121
	mul	a0, a0, a2
	xor	a0, a1, a0
	sb	a0, 15(s1)
.LBB19_4:
	li	a1, 15
	li	a0, 1
.LBB19_5:                               # =>This Inner Loop Header: Depth=1
	add	a2, s1, a1
	lbu	a2, 0(a2)
	add	a3, s0, a1
	addi	a4, a1, 1
	addi	a1, a1, -1
	sb	a2, 0(a3)
	bltu	a0, a4, .LBB19_5
# %bb.6:
	li	a0, 0
	li	a2, 15
	li	a1, 1
.LBB19_7:                               # =>This Inner Loop Header: Depth=1
	add	a3, s0, a2
	lbu	a4, 0(a3)
	slli	a4, a4, 1
	or	a0, a4, a0
	addi	a4, a2, 1
	addi	a2, a2, -1
	sb	a0, 0(a3)
	srli	a0, a0, 8
	bltu	a1, a4, .LBB19_7
# %bb.8:
	lbu	a1, 15(s0)
	li	a2, -121
	mul	a0, a0, a2
	xor	a0, a1, a0
	sb	a0, 15(s0)
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	lw	s1, 4(sp)                       # 4-byte Folded Reload
	lw	s2, 0(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end19:
	.size	getSubkeys, .Lfunc_end19-getSubkeys
                                        # -- End function
	.p2align	2                               # -- Begin function cMac
	.type	cMac,@function
cMac:                                   # @cMac
# %bb.0:
	addi	sp, sp, -48
	sw	ra, 44(sp)                      # 4-byte Folded Spill
	sw	s0, 40(sp)                      # 4-byte Folded Spill
	sw	s1, 36(sp)                      # 4-byte Folded Spill
	sw	s2, 32(sp)                      # 4-byte Folded Spill
	sw	s3, 28(sp)                      # 4-byte Folded Spill
	sw	s4, 24(sp)                      # 4-byte Folded Spill
	sw	s5, 20(sp)                      # 4-byte Folded Spill
	sw	s6, 16(sp)                      # 4-byte Folded Spill
	mv	s0, a4
	mv	s1, a3
	mv	s2, a2
	mv	s4, a1
	mv	s3, a0
	seqz	s5, a3
	addi	a0, a3, -1
	andi	a0, a0, 15
	addi	a1, s5, -1
	addi	a0, a0, 1
	and	s6, a1, a0
	sb	s6, 15(sp)
	sub	a1, a3, s6
	lui	a3, %hi(rijndaelEncrypt)
	addi	a3, a3, %lo(rijndaelEncrypt)
	mv	a0, a2
	mv	a2, a4
	call	xMac
	li	a0, 15
	bltu	a0, s6, .LBB20_2
# %bb.1:
	add	a0, s0, s6
	lbu	a1, 0(a0)
	xori	a1, a1, 128
	sb	a1, 0(a0)
	mv	s3, s4
.LBB20_2:
	addi	a0, s0, 16
	mv	a1, s0
.LBB20_3:                               # =>This Inner Loop Header: Depth=1
	lbu	a2, 0(s3)
	lbu	a3, 0(a1)
	xor	a2, a3, a2
	sb	a2, 0(a1)
	addi	a1, a1, 1
	addi	s3, s3, 1
	bne	a1, a0, .LBB20_3
# %bb.4:
	addi	a0, sp, 15
	beqz	s1, .LBB20_6
# %bb.5:
	add	s1, s2, s1
	sub	a0, s1, s6
.LBB20_6:
	add	a1, s6, s5
	lui	a3, %hi(rijndaelEncrypt)
	addi	a3, a3, %lo(rijndaelEncrypt)
	mv	a2, s0
	mv	a4, s0
	call	xMac
	lw	ra, 44(sp)                      # 4-byte Folded Reload
	lw	s0, 40(sp)                      # 4-byte Folded Reload
	lw	s1, 36(sp)                      # 4-byte Folded Reload
	lw	s2, 32(sp)                      # 4-byte Folded Reload
	lw	s3, 28(sp)                      # 4-byte Folded Reload
	lw	s4, 24(sp)                      # 4-byte Folded Reload
	lw	s5, 20(sp)                      # 4-byte Folded Reload
	lw	s6, 16(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 48
	ret
.Lfunc_end20:
	.size	cMac, .Lfunc_end20-cMac
                                        # -- End function
	.globl	AES_GCM_encrypt                 # -- Begin function AES_GCM_encrypt
	.p2align	2
	.type	AES_GCM_encrypt,@function
AES_GCM_encrypt:                        # @AES_GCM_encrypt
# %bb.0:
	addi	sp, sp, -80
	sw	ra, 76(sp)                      # 4-byte Folded Spill
	sw	s0, 72(sp)                      # 4-byte Folded Spill
	sw	s1, 68(sp)                      # 4-byte Folded Spill
	sw	s2, 64(sp)                      # 4-byte Folded Spill
	sw	s3, 60(sp)                      # 4-byte Folded Spill
	sw	s4, 56(sp)                      # 4-byte Folded Spill
	sw	s5, 52(sp)                      # 4-byte Folded Spill
	mv	s0, a6
	mv	s1, a5
	mv	s4, a4
	mv	s2, a3
	mv	s3, a2
	sw	zero, 36(sp)
	sw	zero, 40(sp)
	sw	zero, 44(sp)
	sw	zero, 48(sp)
	sw	zero, 20(sp)
	sw	zero, 24(sp)
	sw	zero, 28(sp)
	sw	zero, 32(sp)
	sw	zero, 4(sp)
	sw	zero, 8(sp)
	sw	zero, 12(sp)
	sw	zero, 16(sp)
	addi	a2, sp, 20
	addi	a3, sp, 36
	addi	s5, sp, 36
	call	GCMsetup
	addi	a0, sp, 36
	li	a1, 2
	mv	a2, s4
	mv	a3, s1
	mv	a4, s0
	call	CTR_cipher
	addi	a0, sp, 36
	addi	a1, sp, 36
	call	rijndaelEncrypt
	addi	a0, sp, 20
	addi	a5, sp, 4
	addi	s4, sp, 4
	mv	a1, s3
	mv	a2, s0
	mv	a3, s2
	mv	a4, s1
	call	gHash
	addi	a0, sp, 20
.LBB21_1:                               # =>This Inner Loop Header: Depth=1
	lbu	a1, 0(s5)
	lbu	a2, 0(s4)
	xor	a1, a2, a1
	sb	a1, 0(s4)
	addi	s4, s4, 1
	addi	s5, s5, 1
	bne	s4, a0, .LBB21_1
# %bb.2:
	add	s0, s0, s1
	li	a2, 15
	addi	a0, sp, 4
	li	a1, 1
.LBB21_3:                               # =>This Inner Loop Header: Depth=1
	add	a3, a0, a2
	lbu	a3, 0(a3)
	add	a4, s0, a2
	addi	a5, a2, 1
	addi	a2, a2, -1
	sb	a3, 0(a4)
	bltu	a1, a5, .LBB21_3
# %bb.4:
	lw	ra, 76(sp)                      # 4-byte Folded Reload
	lw	s0, 72(sp)                      # 4-byte Folded Reload
	lw	s1, 68(sp)                      # 4-byte Folded Reload
	lw	s2, 64(sp)                      # 4-byte Folded Reload
	lw	s3, 60(sp)                      # 4-byte Folded Reload
	lw	s4, 56(sp)                      # 4-byte Folded Reload
	lw	s5, 52(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 80
	ret
.Lfunc_end21:
	.size	AES_GCM_encrypt, .Lfunc_end21-AES_GCM_encrypt
                                        # -- End function
	.p2align	2                               # -- Begin function GCMsetup
	.type	GCMsetup,@function
GCMsetup:                               # @GCMsetup
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	sw	s1, 4(sp)                       # 4-byte Folded Spill
	sw	s2, 0(sp)                       # 4-byte Folded Spill
	mv	s0, a3
	mv	s2, a2
	mv	s1, a1
	call	KeyExpansion
	mv	a0, s2
	mv	a1, s2
	call	rijndaelEncrypt
	li	a1, 11
	li	a0, 1
.LBB22_1:                               # =>This Inner Loop Header: Depth=1
	add	a2, s1, a1
	lbu	a2, 0(a2)
	add	a3, s0, a1
	addi	a4, a1, 1
	addi	a1, a1, -1
	sb	a2, 0(a3)
	bltu	a0, a4, .LBB22_1
# %bb.2:
	li	a0, 1
	sb	a0, 15(s0)
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	lw	s1, 4(sp)                       # 4-byte Folded Reload
	lw	s2, 0(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end22:
	.size	GCMsetup, .Lfunc_end22-GCMsetup
                                        # -- End function
	.p2align	2                               # -- Begin function gHash
	.type	gHash,@function
gHash:                                  # @gHash
# %bb.0:
	addi	sp, sp, -48
	sw	ra, 44(sp)                      # 4-byte Folded Spill
	sw	s0, 40(sp)                      # 4-byte Folded Spill
	sw	s1, 36(sp)                      # 4-byte Folded Spill
	sw	s2, 32(sp)                      # 4-byte Folded Spill
	sw	s3, 28(sp)                      # 4-byte Folded Spill
	sw	s4, 24(sp)                      # 4-byte Folded Spill
	mv	s0, a5
	mv	s2, a4
	mv	s3, a2
	mv	s1, a0
	sw	zero, 8(sp)
	sw	zero, 12(sp)
	sw	zero, 16(sp)
	sw	zero, 20(sp)
	slli	a0, a3, 3
	li	a4, 7
	addi	a2, sp, 8
.LBB23_1:                               # =>This Inner Loop Header: Depth=1
	zext.b	a5, a4
	add	a5, a2, a5
	lbu	a6, 0(a5)
	addi	a4, a4, -1
	xor	a6, a6, a0
	srli	a0, a0, 8
	sb	a6, 0(a5)
	bnez	a0, .LBB23_1
# %bb.2:
	slli	a0, s2, 3
	li	a4, 15
	addi	a2, sp, 8
.LBB23_3:                               # =>This Inner Loop Header: Depth=1
	zext.b	a5, a4
	add	a5, a2, a5
	lbu	a6, 0(a5)
	addi	a4, a4, -1
	xor	a6, a6, a0
	srli	a0, a0, 8
	sb	a6, 0(a5)
	bnez	a0, .LBB23_3
# %bb.4:
	lui	s4, %hi(mulGF128)
	addi	s4, s4, %lo(mulGF128)
	mv	a0, a1
	mv	a1, a3
	mv	a2, s1
	mv	a3, s4
	mv	a4, s0
	call	xMac
	mv	a0, s3
	mv	a1, s2
	mv	a2, s1
	mv	a3, s4
	mv	a4, s0
	call	xMac
	addi	a0, s0, 16
	addi	a1, sp, 8
	mv	a2, s0
.LBB23_5:                               # =>This Inner Loop Header: Depth=1
	lbu	a3, 0(a1)
	lbu	a4, 0(a2)
	xor	a3, a4, a3
	sb	a3, 0(a2)
	addi	a2, a2, 1
	addi	a1, a1, 1
	bne	a2, a0, .LBB23_5
# %bb.6:
	mv	a0, s1
	mv	a1, s0
	lw	ra, 44(sp)                      # 4-byte Folded Reload
	lw	s0, 40(sp)                      # 4-byte Folded Reload
	lw	s1, 36(sp)                      # 4-byte Folded Reload
	lw	s2, 32(sp)                      # 4-byte Folded Reload
	lw	s3, 28(sp)                      # 4-byte Folded Reload
	lw	s4, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 48
	tail	mulGF128
.Lfunc_end23:
	.size	gHash, .Lfunc_end23-gHash
                                        # -- End function
	.globl	AES_GCM_decrypt                 # -- Begin function AES_GCM_decrypt
	.p2align	2
	.type	AES_GCM_decrypt,@function
AES_GCM_decrypt:                        # @AES_GCM_decrypt
# %bb.0:
	addi	sp, sp, -80
	sw	ra, 76(sp)                      # 4-byte Folded Spill
	sw	s0, 72(sp)                      # 4-byte Folded Spill
	sw	s1, 68(sp)                      # 4-byte Folded Spill
	sw	s2, 64(sp)                      # 4-byte Folded Spill
	sw	s3, 60(sp)                      # 4-byte Folded Spill
	sw	s4, 56(sp)                      # 4-byte Folded Spill
	sw	s5, 52(sp)                      # 4-byte Folded Spill
	sw	s6, 48(sp)                      # 4-byte Folded Spill
	mv	s0, a6
	mv	s1, a5
	mv	s2, a4
	mv	s3, a3
	mv	s4, a2
	sw	zero, 32(sp)
	sw	zero, 36(sp)
	sw	zero, 40(sp)
	sw	zero, 44(sp)
	sw	zero, 16(sp)
	sw	zero, 20(sp)
	sw	zero, 24(sp)
	sw	zero, 28(sp)
	sw	zero, 0(sp)
	sw	zero, 4(sp)
	sw	zero, 8(sp)
	sw	zero, 12(sp)
	addi	a2, sp, 32
	addi	a3, sp, 16
	addi	s5, sp, 32
	call	GCMsetup
	addi	a0, sp, 32
	mv	a5, sp
	mv	s6, sp
	mv	a1, s4
	mv	a2, s2
	mv	a3, s3
	mv	a4, s1
	call	gHash
	addi	a0, sp, 16
	addi	a1, sp, 32
	call	rijndaelEncrypt
	addi	a0, sp, 16
.LBB24_1:                               # =>This Inner Loop Header: Depth=1
	lbu	a1, 0(s5)
	lbu	a2, 0(s6)
	xor	a1, a2, a1
	sb	a1, 0(s6)
	addi	s6, s6, 1
	addi	s5, s5, 1
	bne	s6, a0, .LBB24_1
# %bb.2:
	addi	a0, sp, 15
	add	a1, s1, s2
	addi	a1, a1, 15
	li	a2, -16
.LBB24_3:                               # =>This Inner Loop Header: Depth=1
	beqz	a2, .LBB24_6
# %bb.4:                                #   in Loop: Header=BB24_3 Depth=1
	lbu	a3, 0(a1)
	lbu	a4, 0(a0)
	addi	a0, a0, -1
	addi	a1, a1, -1
	addi	a2, a2, 1
	beq	a3, a4, .LBB24_3
# %bb.5:
	li	a0, 26
	j	.LBB24_7
.LBB24_6:
	addi	a0, sp, 16
	li	a1, 2
	mv	a2, s2
	mv	a3, s1
	mv	a4, s0
	call	CTR_cipher
	li	a0, 0
.LBB24_7:
	lw	ra, 76(sp)                      # 4-byte Folded Reload
	lw	s0, 72(sp)                      # 4-byte Folded Reload
	lw	s1, 68(sp)                      # 4-byte Folded Reload
	lw	s2, 64(sp)                      # 4-byte Folded Reload
	lw	s3, 60(sp)                      # 4-byte Folded Reload
	lw	s4, 56(sp)                      # 4-byte Folded Reload
	lw	s5, 52(sp)                      # 4-byte Folded Reload
	lw	s6, 48(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 80
	ret
.Lfunc_end24:
	.size	AES_GCM_decrypt, .Lfunc_end24-AES_GCM_decrypt
                                        # -- End function
	.globl	AES_CCM_encrypt                 # -- Begin function AES_CCM_encrypt
	.p2align	2
	.type	AES_CCM_encrypt,@function
AES_CCM_encrypt:                        # @AES_CCM_encrypt
# %bb.0:
	addi	sp, sp, -64
	sw	ra, 60(sp)                      # 4-byte Folded Spill
	sw	s0, 56(sp)                      # 4-byte Folded Spill
	sw	s1, 52(sp)                      # 4-byte Folded Spill
	sw	s2, 48(sp)                      # 4-byte Folded Spill
	sw	s3, 44(sp)                      # 4-byte Folded Spill
	sw	s4, 40(sp)                      # 4-byte Folded Spill
	sw	s5, 36(sp)                      # 4-byte Folded Spill
	sw	s6, 32(sp)                      # 4-byte Folded Spill
	mv	s0, a6
	mv	s1, a5
	mv	s2, a4
	mv	s3, a3
	mv	s4, a2
	li	a4, 3
	li	a3, 10
	addi	a2, sp, 27
	sw	a4, 16(sp)
	sw	zero, 20(sp)
	sw	zero, 24(sp)
	sw	zero, 28(sp)
	li	a4, 1
.LBB25_1:                               # =>This Inner Loop Header: Depth=1
	add	a5, a1, a3
	lbu	a5, 0(a5)
	sb	a5, 0(a2)
	addi	a5, a3, 1
	addi	a3, a3, -1
	addi	a2, a2, -1
	bltu	a4, a5, .LBB25_1
# %bb.2:
	add	s5, s0, s1
	call	KeyExpansion
	addi	a0, sp, 16
	mv	a5, sp
	mv	s6, sp
	mv	a1, s4
	mv	a2, s2
	mv	a3, s3
	mv	a4, s1
	call	CCMtag
	addi	a0, sp, 16
	li	a1, 2
	mv	a2, s2
	mv	a3, s1
	mv	a4, s0
	call	CTR_cipher
	li	a1, 15
	li	a0, 1
.LBB25_3:                               # =>This Inner Loop Header: Depth=1
	add	a2, s6, a1
	lbu	a2, 0(a2)
	add	a3, s5, a1
	addi	a4, a1, 1
	addi	a1, a1, -1
	sb	a2, 0(a3)
	bltu	a0, a4, .LBB25_3
# %bb.4:
	lw	ra, 60(sp)                      # 4-byte Folded Reload
	lw	s0, 56(sp)                      # 4-byte Folded Reload
	lw	s1, 52(sp)                      # 4-byte Folded Reload
	lw	s2, 48(sp)                      # 4-byte Folded Reload
	lw	s3, 44(sp)                      # 4-byte Folded Reload
	lw	s4, 40(sp)                      # 4-byte Folded Reload
	lw	s5, 36(sp)                      # 4-byte Folded Reload
	lw	s6, 32(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 64
	ret
.Lfunc_end25:
	.size	AES_CCM_encrypt, .Lfunc_end25-AES_CCM_encrypt
                                        # -- End function
	.p2align	2                               # -- Begin function CCMtag
	.type	CCMtag,@function
CCMtag:                                 # @CCMtag
# %bb.0:
	addi	sp, sp, -64
	sw	ra, 60(sp)                      # 4-byte Folded Spill
	sw	s0, 56(sp)                      # 4-byte Folded Spill
	sw	s1, 52(sp)                      # 4-byte Folded Spill
	sw	s2, 48(sp)                      # 4-byte Folded Spill
	sw	s3, 44(sp)                      # 4-byte Folded Spill
	sw	s4, 40(sp)                      # 4-byte Folded Spill
	sw	s5, 36(sp)                      # 4-byte Folded Spill
	sw	s6, 32(sp)                      # 4-byte Folded Spill
	sw	s7, 28(sp)                      # 4-byte Folded Spill
	mv	s0, a5
	mv	s2, a4
	mv	s4, a3
	mv	s3, a2
	mv	s5, a1
	mv	s1, a0
	sw	zero, 12(sp)
	sw	zero, 16(sp)
	sw	zero, 20(sp)
	sw	zero, 24(sp)
	li	a1, 15
	li	a0, 1
.LBB26_1:                               # =>This Inner Loop Header: Depth=1
	add	a2, s1, a1
	lbu	a2, 0(a2)
	add	a3, s0, a1
	addi	a4, a1, 1
	addi	a1, a1, -1
	sb	a2, 0(a3)
	bltu	a0, a4, .LBB26_1
# %bb.2:
	lbu	a0, 0(s0)
	ori	a0, a0, 56
	sb	a0, 0(s0)
	li	a1, 15
	mv	a0, s2
.LBB26_3:                               # =>This Inner Loop Header: Depth=1
	zext.b	a2, a1
	add	a2, s0, a2
	lbu	a3, 0(a2)
	addi	a1, a1, -1
	xor	a3, a3, a0
	srli	a0, a0, 8
	sb	a3, 0(a2)
	bnez	a0, .LBB26_3
# %bb.4:
	beqz	s4, .LBB26_7
# %bb.5:
	lbu	a0, 0(s0)
	ori	a0, a0, 64
	sb	a0, 0(s0)
	mv	a0, s0
	mv	a1, s0
	call	rijndaelEncrypt
	srli	a0, s4, 8
	li	a1, 255
	bltu	a0, a1, .LBB26_8
# %bb.6:
	li	a0, -257
	sh	a0, 12(sp)
	li	a0, 5
	j	.LBB26_9
.LBB26_7:
	li	s7, 0
	j	.LBB26_15
.LBB26_8:
	li	a0, 1
.LBB26_9:
	addi	a1, sp, 12
	mv	a2, s4
	mv	a3, a0
.LBB26_10:                              # =>This Inner Loop Header: Depth=1
	zext.b	a4, a3
	add	a4, a1, a4
	lbu	a5, 0(a4)
	addi	a3, a3, -1
	xor	a5, a5, a2
	srli	a2, a2, 8
	sb	a5, 0(a4)
	bnez	a2, .LBB26_10
# %bb.11:
	xori	s7, a0, 15
	addi	a2, sp, 12
	mv	a1, s4
	bltu	s4, s7, .LBB26_13
# %bb.12:
	mv	a1, s7
.LBB26_13:
	add	a0, a2, a0
	addi	a2, s5, -1
	li	a3, 1
.LBB26_14:                              # =>This Inner Loop Header: Depth=1
	mv	a4, a1
	add	a1, a2, a1
	lbu	a5, 0(a1)
	addi	a1, a4, -1
	add	a6, a0, a4
	sb	a5, 0(a6)
	bltu	a3, a4, .LBB26_14
.LBB26_15:
	addi	s6, s0, 16
	addi	a0, sp, 12
	mv	a1, s0
.LBB26_16:                              # =>This Inner Loop Header: Depth=1
	lbu	a2, 0(a0)
	lbu	a3, 0(a1)
	xor	a2, a3, a2
	sb	a2, 0(a1)
	addi	a1, a1, 1
	addi	a0, a0, 1
	bne	a1, s6, .LBB26_16
# %bb.17:
	mv	a0, s0
	mv	a1, s0
	call	rijndaelEncrypt
	bgeu	s7, s4, .LBB26_19
# %bb.18:
	add	a0, s5, s7
	sub	a1, s4, s7
	lui	a3, %hi(rijndaelEncrypt)
	addi	a3, a3, %lo(rijndaelEncrypt)
	mv	a2, s0
	mv	a4, s0
	call	xMac
.LBB26_19:
	lui	a3, %hi(rijndaelEncrypt)
	addi	a3, a3, %lo(rijndaelEncrypt)
	mv	a0, s3
	mv	a1, s2
	mv	a2, s0
	mv	a4, s0
	call	xMac
	addi	a1, sp, 12
	addi	s2, sp, 12
	mv	a0, s1
	call	rijndaelEncrypt
.LBB26_20:                              # =>This Inner Loop Header: Depth=1
	lbu	a0, 0(s2)
	lbu	a1, 0(s0)
	xor	a0, a1, a0
	sb	a0, 0(s0)
	addi	s0, s0, 1
	addi	s2, s2, 1
	bne	s0, s6, .LBB26_20
# %bb.21:
	lw	ra, 60(sp)                      # 4-byte Folded Reload
	lw	s0, 56(sp)                      # 4-byte Folded Reload
	lw	s1, 52(sp)                      # 4-byte Folded Reload
	lw	s2, 48(sp)                      # 4-byte Folded Reload
	lw	s3, 44(sp)                      # 4-byte Folded Reload
	lw	s4, 40(sp)                      # 4-byte Folded Reload
	lw	s5, 36(sp)                      # 4-byte Folded Reload
	lw	s6, 32(sp)                      # 4-byte Folded Reload
	lw	s7, 28(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 64
	ret
.Lfunc_end26:
	.size	CCMtag, .Lfunc_end26-CCMtag
                                        # -- End function
	.globl	AES_CCM_decrypt                 # -- Begin function AES_CCM_decrypt
	.p2align	2
	.type	AES_CCM_decrypt,@function
AES_CCM_decrypt:                        # @AES_CCM_decrypt
# %bb.0:
	addi	sp, sp, -64
	sw	ra, 60(sp)                      # 4-byte Folded Spill
	sw	s0, 56(sp)                      # 4-byte Folded Spill
	sw	s1, 52(sp)                      # 4-byte Folded Spill
	sw	s2, 48(sp)                      # 4-byte Folded Spill
	sw	s3, 44(sp)                      # 4-byte Folded Spill
	sw	s4, 40(sp)                      # 4-byte Folded Spill
	mv	s2, a6
	mv	s0, a5
	mv	s1, a4
	mv	s3, a3
	mv	s4, a2
	li	a4, 3
	li	a3, 10
	addi	a2, sp, 35
	sw	a4, 24(sp)
	sw	zero, 28(sp)
	sw	zero, 32(sp)
	sw	zero, 36(sp)
	li	a4, 1
.LBB27_1:                               # =>This Inner Loop Header: Depth=1
	add	a5, a1, a3
	lbu	a5, 0(a5)
	sb	a5, 0(a2)
	addi	a5, a3, 1
	addi	a3, a3, -1
	addi	a2, a2, -1
	bltu	a4, a5, .LBB27_1
# %bb.2:
	call	KeyExpansion
	addi	a0, sp, 24
	li	a1, 2
	mv	a2, s1
	mv	a3, s0
	mv	a4, s2
	call	CTR_cipher
	addi	a0, sp, 24
	addi	a5, sp, 8
	mv	a1, s4
	mv	a2, s2
	mv	a3, s3
	mv	a4, s0
	call	CCMtag
	addi	a0, sp, 23
	add	a1, s0, s1
	addi	a1, a1, 15
	li	a2, -16
.LBB27_3:                               # =>This Inner Loop Header: Depth=1
	beqz	a2, .LBB27_6
# %bb.4:                                #   in Loop: Header=BB27_3 Depth=1
	lbu	a3, 0(a1)
	lbu	a4, 0(a0)
	addi	a0, a0, -1
	addi	a1, a1, -1
	addi	a2, a2, 1
	beq	a3, a4, .LBB27_3
# %bb.5:
	li	a0, 26
	j	.LBB27_7
.LBB27_6:
	li	a0, 0
.LBB27_7:
	lw	ra, 60(sp)                      # 4-byte Folded Reload
	lw	s0, 56(sp)                      # 4-byte Folded Reload
	lw	s1, 52(sp)                      # 4-byte Folded Reload
	lw	s2, 48(sp)                      # 4-byte Folded Reload
	lw	s3, 44(sp)                      # 4-byte Folded Reload
	lw	s4, 40(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 64
	ret
.Lfunc_end27:
	.size	AES_CCM_decrypt, .Lfunc_end27-AES_CCM_decrypt
                                        # -- End function
	.globl	AES_SIV_encrypt                 # -- Begin function AES_SIV_encrypt
	.p2align	2
	.type	AES_SIV_encrypt,@function
AES_SIV_encrypt:                        # @AES_SIV_encrypt
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	sw	s1, 20(sp)                      # 4-byte Folded Spill
	sw	s2, 16(sp)                      # 4-byte Folded Spill
	sw	s3, 12(sp)                      # 4-byte Folded Spill
	sw	s4, 8(sp)                       # 4-byte Folded Spill
	mv	s0, a6
	mv	s1, a5
	mv	s2, a4
	mv	s3, a3
	mv	a3, a2
	mv	s4, a0
	mv	a2, s3
	call	S2V
	addi	a0, s4, 16
	call	KeyExpansion
	li	a1, 5
	mv	a0, s1
	mv	a2, s3
	mv	a3, s2
	mv	a4, s0
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	lw	s1, 20(sp)                      # 4-byte Folded Reload
	lw	s2, 16(sp)                      # 4-byte Folded Reload
	lw	s3, 12(sp)                      # 4-byte Folded Reload
	lw	s4, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 32
	tail	CTR_cipher
.Lfunc_end28:
	.size	AES_SIV_encrypt, .Lfunc_end28-AES_SIV_encrypt
                                        # -- End function
	.p2align	2                               # -- Begin function S2V
	.type	S2V,@function
S2V:                                    # @S2V
# %bb.0:
	addi	sp, sp, -96
	sw	ra, 92(sp)                      # 4-byte Folded Spill
	sw	s0, 88(sp)                      # 4-byte Folded Spill
	sw	s1, 84(sp)                      # 4-byte Folded Spill
	sw	s2, 80(sp)                      # 4-byte Folded Spill
	sw	s3, 76(sp)                      # 4-byte Folded Spill
	sw	s4, 72(sp)                      # 4-byte Folded Spill
	sw	s5, 68(sp)                      # 4-byte Folded Spill
	sw	s6, 64(sp)                      # 4-byte Folded Spill
	sw	s7, 60(sp)                      # 4-byte Folded Spill
	mv	s0, a5
	mv	s1, a4
	mv	s4, a3
	mv	s2, a2
	mv	s5, a1
	mv	s6, a0
	addi	a0, sp, 28
	li	a2, 32
	addi	s3, sp, 28
	li	a1, 0
	call	memset
	li	a1, 15
	li	a0, 1
.LBB29_1:                               # =>This Inner Loop Header: Depth=1
	add	a2, s3, a1
	lbu	a2, 0(a2)
	add	a3, s0, a1
	addi	a4, a1, 1
	addi	a1, a1, -1
	sb	a2, 0(a3)
	bltu	a0, a4, .LBB29_1
# %bb.2:
	addi	s3, sp, 44
	li	a0, 1
	addi	a2, sp, 28
	li	s7, 1
	mv	a1, s6
	mv	a3, s3
	call	getSubkeys
	addi	a0, sp, 28
	addi	a1, sp, 12
	addi	s6, sp, 12
	call	rijndaelEncrypt
	beqz	s4, .LBB29_9
# %bb.3:
	addi	a0, sp, 28
	mv	a1, s3
	mv	a2, s5
	mv	a3, s4
	mv	a4, s0
	call	cMac
	li	a0, 0
	li	a1, 15
.LBB29_4:                               # =>This Inner Loop Header: Depth=1
	add	a2, s6, a1
	lbu	a3, 0(a2)
	slli	a3, a3, 1
	or	a0, a3, a0
	addi	a3, a1, 1
	addi	a1, a1, -1
	sb	a0, 0(a2)
	srli	a0, a0, 8
	bltu	s7, a3, .LBB29_4
# %bb.5:
	lbu	a1, 27(sp)
	li	a2, -121
	mul	a2, a0, a2
	addi	a0, sp, 12
	xor	a1, a1, a2
	sb	a1, 27(sp)
	addi	a1, sp, 28
	mv	a2, s0
.LBB29_6:                               # =>This Inner Loop Header: Depth=1
	lbu	a3, 0(a2)
	lbu	a4, 0(a0)
	xor	a3, a4, a3
	sb	a3, 0(a0)
	addi	a0, a0, 1
	addi	a2, a2, 1
	bne	a0, a1, .LBB29_6
# %bb.7:
	addi	a0, s0, 15
	addi	a1, s0, -1
.LBB29_8:                               # =>This Inner Loop Header: Depth=1
	sb	zero, 0(a0)
	addi	a0, a0, -1
	bne	a0, a1, .LBB29_8
.LBB29_9:
	li	a0, 15
	bltu	a0, s1, .LBB29_13
# %bb.10:
	li	a1, 0
	addi	a2, sp, 12
	li	a3, 1
.LBB29_11:                              # =>This Inner Loop Header: Depth=1
	add	a4, a2, a0
	lbu	a5, 0(a4)
	slli	a5, a5, 1
	or	a1, a5, a1
	addi	a5, a0, 1
	addi	a0, a0, -1
	sb	a1, 0(a4)
	srli	a1, a1, 8
	bltu	a3, a5, .LBB29_11
# %bb.12:
	li	s4, 0
	lbu	a0, 27(sp)
	li	a2, -121
	mul	a1, a1, a2
	xor	a0, a0, a1
	sb	a0, 27(sp)
	j	.LBB29_16
.LBB29_13:
	andi	s4, s1, 15
	beqz	s4, .LBB29_16
# %bb.14:
	addi	a0, sp, 43
	addi	a1, sp, 27
.LBB29_15:                              # =>This Inner Loop Header: Depth=1
	sb	zero, 0(a0)
	addi	a0, a0, -1
	bne	a0, a1, .LBB29_15
.LBB29_16:
	addi	a0, sp, 28
	add	a0, a0, s4
	addi	a1, a0, 16
	addi	a2, sp, 12
.LBB29_17:                              # =>This Inner Loop Header: Depth=1
	lbu	a3, 0(a2)
	lbu	a4, 0(a0)
	xor	a3, a4, a3
	sb	a3, 0(a0)
	addi	a0, a0, 1
	addi	a2, a2, 1
	bne	a0, a1, .LBB29_17
# %bb.18:
	sub	a3, s1, s4
	addi	a0, sp, 28
	addi	a1, sp, 28
	mv	a2, s2
	mv	a4, s0
	call	cMac
	beqz	s4, .LBB29_20
# %bb.19:
	add	s1, s2, s1
	sub	a2, s1, s4
	li	a0, 0
	mv	a1, s3
	mv	a3, s4
	mv	a4, s0
	call	cMac
.LBB29_20:
	lw	ra, 92(sp)                      # 4-byte Folded Reload
	lw	s0, 88(sp)                      # 4-byte Folded Reload
	lw	s1, 84(sp)                      # 4-byte Folded Reload
	lw	s2, 80(sp)                      # 4-byte Folded Reload
	lw	s3, 76(sp)                      # 4-byte Folded Reload
	lw	s4, 72(sp)                      # 4-byte Folded Reload
	lw	s5, 68(sp)                      # 4-byte Folded Reload
	lw	s6, 64(sp)                      # 4-byte Folded Reload
	lw	s7, 60(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 96
	ret
.Lfunc_end29:
	.size	S2V, .Lfunc_end29-S2V
                                        # -- End function
	.globl	AES_SIV_decrypt                 # -- Begin function AES_SIV_decrypt
	.p2align	2
	.type	AES_SIV_decrypt,@function
AES_SIV_decrypt:                        # @AES_SIV_decrypt
# %bb.0:
	addi	sp, sp, -48
	sw	ra, 44(sp)                      # 4-byte Folded Spill
	sw	s0, 40(sp)                      # 4-byte Folded Spill
	sw	s1, 36(sp)                      # 4-byte Folded Spill
	sw	s2, 32(sp)                      # 4-byte Folded Spill
	sw	s3, 28(sp)                      # 4-byte Folded Spill
	sw	s4, 24(sp)                      # 4-byte Folded Spill
	sw	s5, 20(sp)                      # 4-byte Folded Spill
	sw	s6, 16(sp)                      # 4-byte Folded Spill
	mv	s0, a6
	mv	s1, a5
	mv	s2, a4
	mv	s3, a3
	mv	s4, a2
	mv	s5, a1
	mv	s6, a0
	addi	a0, a0, 16
	call	KeyExpansion
	li	a1, 5
	mv	a0, s5
	mv	a2, s2
	mv	a3, s1
	mv	a4, s0
	call	CTR_cipher
	mv	a5, sp
	mv	a0, s6
	mv	a1, s4
	mv	a2, s0
	mv	a3, s3
	mv	a4, s1
	call	S2V
	addi	s5, s5, 15
	li	a0, -16
	addi	a1, sp, 15
.LBB30_1:                               # =>This Inner Loop Header: Depth=1
	beqz	a0, .LBB30_4
# %bb.2:                                #   in Loop: Header=BB30_1 Depth=1
	lbu	a2, 0(a1)
	lbu	a3, 0(s5)
	addi	s5, s5, -1
	addi	a1, a1, -1
	addi	a0, a0, 1
	beq	a2, a3, .LBB30_1
# %bb.3:
	li	a0, 26
.LBB30_4:
	lw	ra, 44(sp)                      # 4-byte Folded Reload
	lw	s0, 40(sp)                      # 4-byte Folded Reload
	lw	s1, 36(sp)                      # 4-byte Folded Reload
	lw	s2, 32(sp)                      # 4-byte Folded Reload
	lw	s3, 28(sp)                      # 4-byte Folded Reload
	lw	s4, 24(sp)                      # 4-byte Folded Reload
	lw	s5, 20(sp)                      # 4-byte Folded Reload
	lw	s6, 16(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 48
	ret
.Lfunc_end30:
	.size	AES_SIV_decrypt, .Lfunc_end30-AES_SIV_decrypt
                                        # -- End function
	.globl	GCM_SIV_encrypt                 # -- Begin function GCM_SIV_encrypt
	.p2align	2
	.type	GCM_SIV_encrypt,@function
GCM_SIV_encrypt:                        # @GCM_SIV_encrypt
# %bb.0:
	addi	sp, sp, -48
	sw	ra, 44(sp)                      # 4-byte Folded Spill
	sw	s0, 40(sp)                      # 4-byte Folded Spill
	sw	s1, 36(sp)                      # 4-byte Folded Spill
	sw	s2, 32(sp)                      # 4-byte Folded Spill
	sw	s3, 28(sp)                      # 4-byte Folded Spill
	sw	s4, 24(sp)                      # 4-byte Folded Spill
	sw	s5, 20(sp)                      # 4-byte Folded Spill
	sw	s6, 16(sp)                      # 4-byte Folded Spill
	mv	s0, a6
	mv	s1, a5
	mv	s2, a4
	mv	s3, a3
	mv	s4, a2
	mv	s5, a1
	sw	zero, 0(sp)
	sw	zero, 4(sp)
	sw	zero, 8(sp)
	sw	zero, 12(sp)
	add	s6, a6, a5
	mv	a2, s6
	call	GCM_SIVsetup
	mv	a5, sp
	mv	a0, s6
	mv	a1, s4
	mv	a2, s2
	mv	a3, s3
	mv	a4, s1
	call	polyval
	lw	a0, 0(s5)
	lw	a1, 4(s5)
	lw	a2, 8(s5)
	lw	a3, 0(sp)
	lw	a4, 4(sp)
	lw	a5, 8(sp)
	lbu	a6, 15(sp)
	xor	a0, a3, a0
	xor	a1, a4, a1
	xor	a2, a5, a2
	andi	a3, a6, 127
	sw	a0, 0(sp)
	sw	a1, 4(sp)
	sw	a2, 8(sp)
	sb	a3, 15(sp)
	mv	a0, sp
	mv	a1, s6
	call	rijndaelEncrypt
	li	a1, 8
	mv	a0, s6
	mv	a2, s2
	mv	a3, s1
	mv	a4, s0
	call	CTR_cipher
	lw	ra, 44(sp)                      # 4-byte Folded Reload
	lw	s0, 40(sp)                      # 4-byte Folded Reload
	lw	s1, 36(sp)                      # 4-byte Folded Reload
	lw	s2, 32(sp)                      # 4-byte Folded Reload
	lw	s3, 28(sp)                      # 4-byte Folded Reload
	lw	s4, 24(sp)                      # 4-byte Folded Reload
	lw	s5, 20(sp)                      # 4-byte Folded Reload
	lw	s6, 16(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 48
	ret
.Lfunc_end31:
	.size	GCM_SIV_encrypt, .Lfunc_end31-GCM_SIV_encrypt
                                        # -- End function
	.p2align	2                               # -- Begin function GCM_SIVsetup
	.type	GCM_SIVsetup,@function
GCM_SIVsetup:                           # @GCM_SIVsetup
# %bb.0:
	addi	sp, sp, -80
	sw	ra, 76(sp)                      # 4-byte Folded Spill
	sw	s0, 72(sp)                      # 4-byte Folded Spill
	sw	s1, 68(sp)                      # 4-byte Folded Spill
	sw	s2, 64(sp)                      # 4-byte Folded Spill
	mv	s0, a2
	addi	a2, sp, 23
	addi	a1, a1, 11
	addi	a3, sp, 11
.LBB32_1:                               # =>This Inner Loop Header: Depth=1
	lbu	a4, 0(a1)
	sb	a4, 0(a2)
	addi	a2, a2, -1
	addi	a1, a1, -1
	bne	a2, a3, .LBB32_1
# %bb.2:
	call	KeyExpansion
	sw	zero, 8(sp)
	addi	s1, sp, 8
	li	s2, 4
.LBB32_3:                               # =>This Inner Loop Header: Depth=1
	addi	a1, s1, 16
	addi	a0, sp, 8
	call	rijndaelEncrypt
	lbu	a0, 8(sp)
	addi	a0, a0, 1
	zext.b	a1, a0
	sb	a0, 8(sp)
	addi	s1, s1, 8
	bltu	a1, s2, .LBB32_3
# %bb.4:
	mv	a0, s1
	call	KeyExpansion
	addi	a0, s0, 15
	addi	a1, sp, 39
	addi	s0, s0, -1
.LBB32_5:                               # =>This Inner Loop Header: Depth=1
	lbu	a2, 0(a1)
	sb	a2, 0(a0)
	addi	a0, a0, -1
	addi	a1, a1, -1
	bne	a0, s0, .LBB32_5
# %bb.6:
	lw	ra, 76(sp)                      # 4-byte Folded Reload
	lw	s0, 72(sp)                      # 4-byte Folded Reload
	lw	s1, 68(sp)                      # 4-byte Folded Reload
	lw	s2, 64(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 80
	ret
.Lfunc_end32:
	.size	GCM_SIVsetup, .Lfunc_end32-GCM_SIVsetup
                                        # -- End function
	.p2align	2                               # -- Begin function polyval
	.type	polyval,@function
polyval:                                # @polyval
# %bb.0:
	addi	sp, sp, -48
	sw	ra, 44(sp)                      # 4-byte Folded Spill
	sw	s0, 40(sp)                      # 4-byte Folded Spill
	sw	s1, 36(sp)                      # 4-byte Folded Spill
	sw	s2, 32(sp)                      # 4-byte Folded Spill
	sw	s3, 28(sp)                      # 4-byte Folded Spill
	sw	s4, 24(sp)                      # 4-byte Folded Spill
	mv	s0, a5
	mv	s2, a4
	mv	s3, a2
	mv	s1, a0
	sw	zero, 8(sp)
	sw	zero, 12(sp)
	sw	zero, 16(sp)
	sw	zero, 20(sp)
	slli	a0, a3, 3
	addi	a2, sp, 8
.LBB33_1:                               # =>This Inner Loop Header: Depth=1
	sb	a0, 0(a2)
	srli	a0, a0, 8
	addi	a2, a2, 1
	bnez	a0, .LBB33_1
# %bb.2:
	slli	a0, s2, 3
	addi	a2, sp, 16
.LBB33_3:                               # =>This Inner Loop Header: Depth=1
	sb	a0, 0(a2)
	srli	a0, a0, 8
	addi	a2, a2, 1
	bnez	a0, .LBB33_3
# %bb.4:
	lui	s4, %hi(dotGF128)
	addi	s4, s4, %lo(dotGF128)
	mv	a0, a1
	mv	a1, a3
	mv	a2, s1
	mv	a3, s4
	mv	a4, s0
	call	xMac
	mv	a0, s3
	mv	a1, s2
	mv	a2, s1
	mv	a3, s4
	mv	a4, s0
	call	xMac
	addi	a0, s0, 16
	addi	a1, sp, 8
	mv	a2, s0
.LBB33_5:                               # =>This Inner Loop Header: Depth=1
	lbu	a3, 0(a1)
	lbu	a4, 0(a2)
	xor	a3, a4, a3
	sb	a3, 0(a2)
	addi	a2, a2, 1
	addi	a1, a1, 1
	bne	a2, a0, .LBB33_5
# %bb.6:
	mv	a0, s1
	mv	a1, s0
	lw	ra, 44(sp)                      # 4-byte Folded Reload
	lw	s0, 40(sp)                      # 4-byte Folded Reload
	lw	s1, 36(sp)                      # 4-byte Folded Reload
	lw	s2, 32(sp)                      # 4-byte Folded Reload
	lw	s3, 28(sp)                      # 4-byte Folded Reload
	lw	s4, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 48
	tail	dotGF128
.Lfunc_end33:
	.size	polyval, .Lfunc_end33-polyval
                                        # -- End function
	.globl	GCM_SIV_decrypt                 # -- Begin function GCM_SIV_decrypt
	.p2align	2
	.type	GCM_SIV_decrypt,@function
GCM_SIV_decrypt:                        # @GCM_SIV_decrypt
# %bb.0:
	addi	sp, sp, -64
	sw	ra, 60(sp)                      # 4-byte Folded Spill
	sw	s0, 56(sp)                      # 4-byte Folded Spill
	sw	s1, 52(sp)                      # 4-byte Folded Spill
	sw	s2, 48(sp)                      # 4-byte Folded Spill
	sw	s3, 44(sp)                      # 4-byte Folded Spill
	sw	s4, 40(sp)                      # 4-byte Folded Spill
	sw	s5, 36(sp)                      # 4-byte Folded Spill
	sw	s6, 32(sp)                      # 4-byte Folded Spill
	mv	s1, a6
	mv	s2, a5
	mv	s3, a4
	mv	s4, a3
	mv	s5, a2
	mv	s6, a1
	sw	zero, 0(sp)
	sw	zero, 4(sp)
	sw	zero, 8(sp)
	sw	zero, 12(sp)
	add	s0, a4, a5
	addi	a2, sp, 16
	call	GCM_SIVsetup
	li	a1, 8
	mv	a0, s0
	mv	a2, s3
	mv	a3, s2
	mv	a4, s1
	call	CTR_cipher
	addi	a0, sp, 16
	mv	a5, sp
	mv	a1, s5
	mv	a2, s1
	mv	a3, s4
	mv	a4, s2
	call	polyval
	lw	a0, 0(s6)
	lw	a1, 4(s6)
	lw	a2, 8(s6)
	lw	a3, 0(sp)
	lw	a4, 4(sp)
	lw	a5, 8(sp)
	lbu	a6, 15(sp)
	xor	a0, a3, a0
	xor	a1, a4, a1
	xor	a2, a5, a2
	addi	s1, sp, 15
	andi	a3, a6, 127
	sw	a0, 0(sp)
	sw	a1, 4(sp)
	sw	a2, 8(sp)
	sb	a3, 15(sp)
	mv	a0, sp
	mv	a1, sp
	call	rijndaelEncrypt
	addi	s0, s0, 15
	li	a0, -16
.LBB34_1:                               # =>This Inner Loop Header: Depth=1
	beqz	a0, .LBB34_4
# %bb.2:                                #   in Loop: Header=BB34_1 Depth=1
	lbu	a1, 0(s0)
	lbu	a2, 0(s1)
	addi	s1, s1, -1
	addi	s0, s0, -1
	addi	a0, a0, 1
	beq	a1, a2, .LBB34_1
# %bb.3:
	li	a0, 26
.LBB34_4:
	lw	ra, 60(sp)                      # 4-byte Folded Reload
	lw	s0, 56(sp)                      # 4-byte Folded Reload
	lw	s1, 52(sp)                      # 4-byte Folded Reload
	lw	s2, 48(sp)                      # 4-byte Folded Reload
	lw	s3, 44(sp)                      # 4-byte Folded Reload
	lw	s4, 40(sp)                      # 4-byte Folded Reload
	lw	s5, 36(sp)                      # 4-byte Folded Reload
	lw	s6, 32(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 64
	ret
.Lfunc_end34:
	.size	GCM_SIV_decrypt, .Lfunc_end34-GCM_SIV_decrypt
                                        # -- End function
	.globl	AES_EAX_encrypt                 # -- Begin function AES_EAX_encrypt
	.p2align	2
	.type	AES_EAX_encrypt,@function
AES_EAX_encrypt:                        # @AES_EAX_encrypt
# %bb.0:
	addi	sp, sp, -96
	sw	ra, 92(sp)                      # 4-byte Folded Spill
	sw	s0, 88(sp)                      # 4-byte Folded Spill
	sw	s1, 84(sp)                      # 4-byte Folded Spill
	sw	s2, 80(sp)                      # 4-byte Folded Spill
	sw	s3, 76(sp)                      # 4-byte Folded Spill
	sw	s4, 72(sp)                      # 4-byte Folded Spill
	sw	s5, 68(sp)                      # 4-byte Folded Spill
	sw	s6, 64(sp)                      # 4-byte Folded Spill
	mv	s0, a6
	mv	s1, a5
	mv	s2, a4
	mv	s3, a3
	mv	s4, a2
	mv	s5, a1
	mv	a1, a0
	sw	zero, 48(sp)
	sw	zero, 52(sp)
	sw	zero, 56(sp)
	sw	zero, 60(sp)
	li	a0, 1
	addi	a2, sp, 48
	addi	a3, sp, 32
	call	getSubkeys
	addi	a1, sp, 48
	addi	a2, sp, 32
	li	a4, 16
	addi	a5, sp, 16
	addi	s6, sp, 16
	li	a0, 0
	mv	a3, s5
	call	oMac
	addi	a0, sp, 16
	li	a1, 0
	mv	a2, s2
	mv	a3, s1
	mv	a4, s0
	call	CTR_cipher
	li	a0, 1
	addi	a1, sp, 48
	addi	a2, sp, 32
	mv	a5, sp
	mv	s5, sp
	mv	a3, s4
	mv	a4, s3
	call	oMac
	addi	s2, sp, 16
.LBB35_1:                               # =>This Inner Loop Header: Depth=1
	lbu	a0, 0(s6)
	lbu	a1, 0(s5)
	xor	a0, a1, a0
	sb	a0, 0(s5)
	addi	s5, s5, 1
	addi	s6, s6, 1
	bne	s5, s2, .LBB35_1
# %bb.2:
	li	a0, 2
	addi	a1, sp, 48
	addi	a2, sp, 32
	addi	a5, sp, 16
	addi	s3, sp, 16
	mv	a3, s0
	mv	a4, s1
	call	oMac
	mv	a0, sp
.LBB35_3:                               # =>This Inner Loop Header: Depth=1
	lbu	a1, 0(s3)
	lbu	a2, 0(a0)
	xor	a1, a2, a1
	sb	a1, 0(a0)
	addi	a0, a0, 1
	addi	s3, s3, 1
	bne	a0, s2, .LBB35_3
# %bb.4:
	add	s0, s0, s1
	li	a2, 15
	mv	a0, sp
	li	a1, 1
.LBB35_5:                               # =>This Inner Loop Header: Depth=1
	add	a3, a0, a2
	lbu	a3, 0(a3)
	add	a4, s0, a2
	addi	a5, a2, 1
	addi	a2, a2, -1
	sb	a3, 0(a4)
	bltu	a1, a5, .LBB35_5
# %bb.6:
	lw	ra, 92(sp)                      # 4-byte Folded Reload
	lw	s0, 88(sp)                      # 4-byte Folded Reload
	lw	s1, 84(sp)                      # 4-byte Folded Reload
	lw	s2, 80(sp)                      # 4-byte Folded Reload
	lw	s3, 76(sp)                      # 4-byte Folded Reload
	lw	s4, 72(sp)                      # 4-byte Folded Reload
	lw	s5, 68(sp)                      # 4-byte Folded Reload
	lw	s6, 64(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 96
	ret
.Lfunc_end35:
	.size	AES_EAX_encrypt, .Lfunc_end35-AES_EAX_encrypt
                                        # -- End function
	.p2align	2                               # -- Begin function oMac
	.type	oMac,@function
oMac:                                   # @oMac
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	sw	s1, 20(sp)                      # 4-byte Folded Spill
	sw	s2, 16(sp)                      # 4-byte Folded Spill
	sw	s3, 12(sp)                      # 4-byte Folded Spill
	sw	s4, 8(sp)                       # 4-byte Folded Spill
	mv	s0, a5
	mv	s1, a4
	mv	s2, a3
	mv	s3, a2
	mv	s4, a1
	beqz	a4, .LBB36_3
# %bb.1:
	addi	a1, s0, 15
	addi	a2, s0, -1
.LBB36_2:                               # =>This Inner Loop Header: Depth=1
	sb	zero, 0(a1)
	addi	a1, a1, -1
	bne	a1, a2, .LBB36_2
	j	.LBB36_5
.LBB36_3:
	li	a2, 15
	li	a1, 1
.LBB36_4:                               # =>This Inner Loop Header: Depth=1
	add	a3, s4, a2
	lbu	a3, 0(a3)
	add	a4, s0, a2
	addi	a5, a2, 1
	addi	a2, a2, -1
	sb	a3, 0(a4)
	bltu	a1, a5, .LBB36_4
.LBB36_5:
	lbu	a1, 15(s0)
	xor	a0, a1, a0
	sb	a0, 15(s0)
	mv	a0, s0
	mv	a1, s0
	call	rijndaelEncrypt
	beqz	s1, .LBB36_7
# %bb.6:
	mv	a0, s4
	mv	a1, s3
	mv	a2, s2
	mv	a3, s1
	mv	a4, s0
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	lw	s1, 20(sp)                      # 4-byte Folded Reload
	lw	s2, 16(sp)                      # 4-byte Folded Reload
	lw	s3, 12(sp)                      # 4-byte Folded Reload
	lw	s4, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 32
	tail	cMac
.LBB36_7:
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	lw	s1, 20(sp)                      # 4-byte Folded Reload
	lw	s2, 16(sp)                      # 4-byte Folded Reload
	lw	s3, 12(sp)                      # 4-byte Folded Reload
	lw	s4, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end36:
	.size	oMac, .Lfunc_end36-oMac
                                        # -- End function
	.globl	AES_EAX_decrypt                 # -- Begin function AES_EAX_decrypt
	.p2align	2
	.type	AES_EAX_decrypt,@function
AES_EAX_decrypt:                        # @AES_EAX_decrypt
# %bb.0:
	addi	sp, sp, -112
	sw	ra, 108(sp)                     # 4-byte Folded Spill
	sw	s0, 104(sp)                     # 4-byte Folded Spill
	sw	s1, 100(sp)                     # 4-byte Folded Spill
	sw	s2, 96(sp)                      # 4-byte Folded Spill
	sw	s3, 92(sp)                      # 4-byte Folded Spill
	sw	s4, 88(sp)                      # 4-byte Folded Spill
	sw	s5, 84(sp)                      # 4-byte Folded Spill
	sw	s6, 80(sp)                      # 4-byte Folded Spill
	sw	s7, 76(sp)                      # 4-byte Folded Spill
	mv	s0, a6
	mv	s1, a5
	mv	s2, a4
	mv	s4, a3
	mv	s5, a2
	mv	s3, a1
	mv	a1, a0
	sw	zero, 60(sp)
	sw	zero, 64(sp)
	sw	zero, 68(sp)
	sw	zero, 72(sp)
	li	a0, 1
	addi	a2, sp, 60
	addi	a3, sp, 44
	call	getSubkeys
	li	a0, 2
	addi	a1, sp, 60
	addi	a2, sp, 44
	addi	a5, sp, 12
	addi	s6, sp, 12
	mv	a3, s2
	mv	a4, s1
	call	oMac
	li	a0, 1
	addi	a1, sp, 60
	addi	a2, sp, 44
	addi	a5, sp, 28
	addi	s7, sp, 28
	mv	a3, s5
	mv	a4, s4
	call	oMac
	addi	s4, sp, 28
.LBB37_1:                               # =>This Inner Loop Header: Depth=1
	lbu	a0, 0(s7)
	lbu	a1, 0(s6)
	xor	a0, a1, a0
	sb	a0, 0(s6)
	addi	s6, s6, 1
	addi	s7, s7, 1
	bne	s6, s4, .LBB37_1
# %bb.2:
	addi	a1, sp, 60
	addi	a2, sp, 44
	li	a4, 16
	addi	a5, sp, 28
	addi	s5, sp, 28
	li	a0, 0
	mv	a3, s3
	call	oMac
	addi	a0, sp, 12
.LBB37_3:                               # =>This Inner Loop Header: Depth=1
	lbu	a1, 0(s5)
	lbu	a2, 0(a0)
	xor	a1, a2, a1
	sb	a1, 0(a0)
	addi	a0, a0, 1
	addi	s5, s5, 1
	bne	a0, s4, .LBB37_3
# %bb.4:
	addi	a0, sp, 27
	add	a1, s1, s2
	addi	a1, a1, 15
	li	a2, -16
.LBB37_5:                               # =>This Inner Loop Header: Depth=1
	beqz	a2, .LBB37_8
# %bb.6:                                #   in Loop: Header=BB37_5 Depth=1
	lbu	a3, 0(a1)
	lbu	a4, 0(a0)
	addi	a0, a0, -1
	addi	a1, a1, -1
	addi	a2, a2, 1
	beq	a3, a4, .LBB37_5
# %bb.7:
	li	a0, 26
	j	.LBB37_9
.LBB37_8:
	addi	a0, sp, 28
	li	a1, 0
	mv	a2, s2
	mv	a3, s1
	mv	a4, s0
	call	CTR_cipher
	li	a0, 0
.LBB37_9:
	lw	ra, 108(sp)                     # 4-byte Folded Reload
	lw	s0, 104(sp)                     # 4-byte Folded Reload
	lw	s1, 100(sp)                     # 4-byte Folded Reload
	lw	s2, 96(sp)                      # 4-byte Folded Reload
	lw	s3, 92(sp)                      # 4-byte Folded Reload
	lw	s4, 88(sp)                      # 4-byte Folded Reload
	lw	s5, 84(sp)                      # 4-byte Folded Reload
	lw	s6, 80(sp)                      # 4-byte Folded Reload
	lw	s7, 76(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 112
	ret
.Lfunc_end37:
	.size	AES_EAX_decrypt, .Lfunc_end37-AES_EAX_decrypt
                                        # -- End function
	.globl	AES_OCB_encrypt                 # -- Begin function AES_OCB_encrypt
	.p2align	2
	.type	AES_OCB_encrypt,@function
AES_OCB_encrypt:                        # @AES_OCB_encrypt
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	sw	s1, 20(sp)                      # 4-byte Folded Spill
	mv	t0, a3
	mv	a3, a2
	sw	zero, 4(sp)
	sw	zero, 8(sp)
	sw	zero, 12(sp)
	sw	zero, 16(sp)
	blez	a5, .LBB38_3
# %bb.1:
	addi	a7, a5, -1
	li	a2, 1
.LBB38_2:                               # =>This Inner Loop Header: Depth=1
	add	t1, a4, a7
	lbu	t1, 0(t1)
	add	t2, a6, a7
	addi	t3, a7, 1
	addi	a7, a7, -1
	sb	t1, 0(t2)
	bltu	a2, t3, .LBB38_2
.LBB38_3:
	add	s0, a6, a5
	addi	a7, sp, 4
	addi	s1, sp, 4
	mv	a2, a5
	mv	a4, t0
	call	OCB_cipher
	li	a1, 15
	li	a0, 1
.LBB38_4:                               # =>This Inner Loop Header: Depth=1
	add	a2, s1, a1
	lbu	a2, 0(a2)
	add	a3, s0, a1
	addi	a4, a1, 1
	addi	a1, a1, -1
	sb	a2, 0(a3)
	bltu	a0, a4, .LBB38_4
# %bb.5:
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	lw	s1, 20(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end38:
	.size	AES_OCB_encrypt, .Lfunc_end38-AES_OCB_encrypt
                                        # -- End function
	.p2align	2                               # -- Begin function OCB_cipher
	.type	OCB_cipher,@function
OCB_cipher:                             # @OCB_cipher
# %bb.0:
	addi	sp, sp, -128
	sw	ra, 124(sp)                     # 4-byte Folded Spill
	sw	s0, 120(sp)                     # 4-byte Folded Spill
	sw	s1, 116(sp)                     # 4-byte Folded Spill
	sw	s2, 112(sp)                     # 4-byte Folded Spill
	sw	s3, 108(sp)                     # 4-byte Folded Spill
	sw	s4, 104(sp)                     # 4-byte Folded Spill
	sw	s5, 100(sp)                     # 4-byte Folded Spill
	sw	s6, 96(sp)                      # 4-byte Folded Spill
	sw	s7, 92(sp)                      # 4-byte Folded Spill
	sw	s8, 88(sp)                      # 4-byte Folded Spill
	sw	s9, 84(sp)                      # 4-byte Folded Spill
	sw	s10, 80(sp)                     # 4-byte Folded Spill
	sw	s11, 76(sp)                     # 4-byte Folded Spill
	mv	s0, a7
	mv	s5, a6
	mv	s6, a5
	mv	s7, a4
	mv	s1, a3
	mv	s10, a2
	mv	s3, a1
	mv	s8, a0
	addi	a0, sp, 12
	li	a2, 64
	li	a1, 0
	call	memset
	lbu	s2, 11(s3)
	addi	s3, s3, 11
	addi	a0, sp, 59
	addi	a1, sp, 47
.LBB39_1:                               # =>This Inner Loop Header: Depth=1
	lbu	a2, 0(s3)
	sb	a2, 0(a0)
	addi	a0, a0, -1
	addi	s3, s3, -1
	bne	a0, a1, .LBB39_1
# %bb.2:
	addi	a2, sp, 28
	lbu	a0, 47(sp)
	lbu	a1, 59(sp)
	addi	s9, sp, 44
	addi	s4, sp, 60
	ori	a0, a0, 1
	andi	a1, a1, 192
	sb	a0, 47(sp)
	sb	a1, 59(sp)
	addi	a3, sp, 12
	addi	s3, sp, 12
	li	a0, 0
	mv	a1, s8
	call	getSubkeys
	mv	a0, s9
	mv	a1, s9
	call	rijndaelEncrypt
	addi	a0, sp, 4
.LBB39_3:                               # =>This Inner Loop Header: Depth=1
	lbu	a1, 40(s3)
	sb	a1, 55(s3)
	addi	s3, s3, -1
	bne	s3, a0, .LBB39_3
# %bb.4:
	andi	a0, s2, 7
	li	a1, 8
	slli	s2, s2, 26
	sub	a0, a1, a0
	srli	a2, s2, 29
	add	a1, s9, a2
	lbu	a1, 0(a1)
	addi	a3, sp, 12
	add	a3, a2, a3
	addi	a2, a3, 33
	addi	a3, a3, 49
	mv	a4, s4
.LBB39_5:                               # =>This Inner Loop Header: Depth=1
	lbu	a5, -16(a4)
	lbu	a6, 0(a4)
	slli	a7, a1, 8
	lbu	a1, 0(a2)
	xor	a5, a6, a5
	addi	a2, a2, 1
	or	a6, a7, a1
	slli	a6, a6, 16
	srli	a6, a6, 16
	srl	a6, a6, a0
	sb	a6, -16(a4)
	sb	a5, 0(a4)
	addi	a4, a4, 1
	bne	a2, a3, .LBB39_5
# %bb.6:
	beqz	s10, .LBB39_8
# %bb.7:
	lui	s2, %hi(rijndaelEncrypt)
	addi	s2, s2, %lo(rijndaelEncrypt)
	j	.LBB39_9
.LBB39_8:
	lui	s2, %hi(rijndaelDecrypt)
	addi	s2, s2, %lo(rijndaelDecrypt)
.LBB39_9:
	srli	a1, s10, 4
	addi	s11, s0, 16
	mv	a0, s5
	beqz	a1, .LBB39_14
# %bb.10:
	mv	a0, s5
.LBB39_11:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB39_12 Depth 2
	mv	a2, a0
	mv	a3, s0
.LBB39_12:                              #   Parent Loop BB39_11 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	lbu	a4, 0(a2)
	lbu	a5, 0(a3)
	xor	a4, a5, a4
	sb	a4, 0(a3)
	addi	a3, a3, 1
	addi	a2, a2, 1
	bne	a3, s11, .LBB39_12
# %bb.13:                               #   in Loop: Header=BB39_11 Depth=1
	addi	a1, a1, -1
	addi	a0, a0, 16
	bnez	a1, .LBB39_11
.LBB39_14:
	andi	a1, s10, 15
	addi	s3, s0, -1
	beqz	a1, .LBB39_17
# %bb.15:
	addi	a2, a1, -1
	add	a1, s0, a2
	add	a0, a0, a2
.LBB39_16:                              # =>This Inner Loop Header: Depth=1
	lbu	a2, 0(a0)
	lbu	a3, 0(a1)
	xor	a2, a3, a2
	sb	a2, 0(a1)
	addi	a1, a1, -1
	addi	a0, a0, -1
	bne	a1, s3, .LBB39_16
.LBB39_17:
	sw	s10, 4(sp)                      # 4-byte Folded Spill
	sw	s6, 8(sp)                       # 4-byte Folded Spill
	srli	s6, s6, 4
	beqz	s6, .LBB39_25
# %bb.18:
	sw	s7, 0(sp)                       # 4-byte Folded Spill
	li	s8, 0
	mv	s10, s5
.LBB39_19:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB39_20 Depth 2
                                        #     Child Loop BB39_22 Depth 2
	slli	a0, s8, 4
	add	a0, a0, s5
	addi	s7, a0, 16
	addi	s8, s8, 1
	addi	a1, sp, 12
	mv	a0, s8
	mv	a2, s9
	mv	a3, s4
	call	getDelta
	mv	a0, s4
	mv	a1, s10
.LBB39_20:                              #   Parent Loop BB39_19 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	lbu	a2, 0(a0)
	lbu	a3, 0(a1)
	xor	a2, a3, a2
	sb	a2, 0(a1)
	addi	a1, a1, 1
	addi	a0, a0, 1
	bne	a1, s7, .LBB39_20
# %bb.21:                               #   in Loop: Header=BB39_19 Depth=1
	mv	a0, s10
	mv	a1, s10
	jalr	s2
	mv	a0, s4
	mv	a1, s10
.LBB39_22:                              #   Parent Loop BB39_19 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	lbu	a2, 0(a0)
	lbu	a3, 0(a1)
	xor	a2, a3, a2
	sb	a2, 0(a1)
	addi	a1, a1, 1
	addi	a0, a0, 1
	bne	a1, s7, .LBB39_22
# %bb.23:                               #   in Loop: Header=BB39_19 Depth=1
	addi	s10, s10, 16
	bne	s8, s6, .LBB39_19
# %bb.24:
	mv	s8, s4
	mv	s4, s9
	lw	s7, 0(sp)                       # 4-byte Folded Reload
	j	.LBB39_26
.LBB39_25:
	mv	s8, s9
	mv	s10, s5
.LBB39_26:
	lw	s6, 8(sp)                       # 4-byte Folded Reload
	andi	s2, s6, 15
	addi	s9, sp, 28
	beqz	s2, .LBB39_31
# %bb.27:
	add	a0, s0, s2
	lbu	a1, 0(a0)
	xori	a1, a1, 128
	sb	a1, 0(a0)
	addi	a0, s8, 16
	mv	a1, s9
	mv	a2, s8
.LBB39_28:                              # =>This Inner Loop Header: Depth=1
	lbu	a3, 0(a1)
	lbu	a4, 0(a2)
	xor	a3, a4, a3
	sb	a3, 0(a2)
	addi	a2, a2, 1
	addi	a1, a1, 1
	bne	a2, a0, .LBB39_28
# %bb.29:
	mv	a0, s8
	mv	a1, s4
	call	rijndaelEncrypt
	addi	a1, s2, -1
	add	a0, s10, a1
	add	a1, s4, a1
	addi	s10, s10, -1
.LBB39_30:                              # =>This Inner Loop Header: Depth=1
	lbu	a2, 0(a1)
	lbu	a3, 0(a0)
	xor	a2, a3, a2
	sb	a2, 0(a0)
	addi	a0, a0, -1
	addi	a1, a1, -1
	bne	a0, s10, .LBB39_30
.LBB39_31:
	lw	a0, 4(sp)                       # 4-byte Folded Reload
	sub	a0, s6, a0
	srli	a1, a0, 4
	beqz	a1, .LBB39_35
.LBB39_32:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB39_33 Depth 2
	mv	a2, s5
	mv	a3, s0
.LBB39_33:                              #   Parent Loop BB39_32 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	lbu	a4, 0(a2)
	lbu	a5, 0(a3)
	xor	a4, a5, a4
	sb	a4, 0(a3)
	addi	a3, a3, 1
	addi	a2, a2, 1
	bne	a3, s11, .LBB39_33
# %bb.34:                               #   in Loop: Header=BB39_32 Depth=1
	addi	a1, a1, -1
	addi	s5, s5, 16
	bnez	a1, .LBB39_32
.LBB39_35:
	andi	a0, a0, 15
	beqz	a0, .LBB39_38
# %bb.36:
	addi	a1, a0, -1
	add	a0, s0, a1
	add	s5, s5, a1
.LBB39_37:                              # =>This Inner Loop Header: Depth=1
	lbu	a1, 0(s5)
	lbu	a2, 0(a0)
	xor	a1, a2, a1
	sb	a1, 0(a0)
	addi	a0, a0, -1
	addi	s5, s5, -1
	bne	a0, s3, .LBB39_37
.LBB39_38:
	addi	a0, sp, 12
	li	a3, 16
	li	a1, 0
	mv	a2, s8
	mv	a4, s0
	call	cMac
	srli	s5, s7, 4
	beqz	s5, .LBB39_43
# %bb.39:
	li	s6, 0
.LBB39_40:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB39_41 Depth 2
	addi	s6, s6, 1
	addi	a1, sp, 12
	mv	a0, s6
	mv	a2, s1
	mv	a3, s8
	call	getDelta
	mv	a0, s8
	mv	a1, s8
	call	rijndaelEncrypt
	mv	a0, s8
	mv	a1, s0
.LBB39_41:                              #   Parent Loop BB39_40 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	lbu	a2, 0(a0)
	lbu	a3, 0(a1)
	xor	a2, a3, a2
	sb	a2, 0(a1)
	addi	a1, a1, 1
	addi	a0, a0, 1
	bne	a1, s11, .LBB39_41
# %bb.42:                               #   in Loop: Header=BB39_40 Depth=1
	addi	s1, s1, 16
	bne	s6, s5, .LBB39_40
.LBB39_43:
	andi	s2, s7, 15
	beqz	s2, .LBB39_48
# %bb.44:
	addi	a0, s4, 15
	addi	a1, s4, -1
.LBB39_45:                              # =>This Inner Loop Header: Depth=1
	sb	zero, 0(a0)
	addi	a0, a0, -1
	bne	a0, a1, .LBB39_45
# %bb.46:
	addi	a1, sp, 12
	mv	a0, s5
	mv	a2, s4
	mv	a3, s8
	call	getDelta
	li	a0, 0
	mv	a1, s9
	mv	a2, s1
	mv	a3, s2
	mv	a4, s8
	call	cMac
.LBB39_47:                              # =>This Inner Loop Header: Depth=1
	lbu	a0, 0(s8)
	lbu	a1, 0(s0)
	xor	a0, a1, a0
	sb	a0, 0(s0)
	addi	s0, s0, 1
	addi	s8, s8, 1
	bne	s0, s11, .LBB39_47
.LBB39_48:
	lw	ra, 124(sp)                     # 4-byte Folded Reload
	lw	s0, 120(sp)                     # 4-byte Folded Reload
	lw	s1, 116(sp)                     # 4-byte Folded Reload
	lw	s2, 112(sp)                     # 4-byte Folded Reload
	lw	s3, 108(sp)                     # 4-byte Folded Reload
	lw	s4, 104(sp)                     # 4-byte Folded Reload
	lw	s5, 100(sp)                     # 4-byte Folded Reload
	lw	s6, 96(sp)                      # 4-byte Folded Reload
	lw	s7, 92(sp)                      # 4-byte Folded Reload
	lw	s8, 88(sp)                      # 4-byte Folded Reload
	lw	s9, 84(sp)                      # 4-byte Folded Reload
	lw	s10, 80(sp)                     # 4-byte Folded Reload
	lw	s11, 76(sp)                     # 4-byte Folded Reload
	addi	sp, sp, 128
	ret
.Lfunc_end39:
	.size	OCB_cipher, .Lfunc_end39-OCB_cipher
                                        # -- End function
	.globl	AES_OCB_decrypt                 # -- Begin function AES_OCB_decrypt
	.p2align	2
	.type	AES_OCB_decrypt,@function
AES_OCB_decrypt:                        # @AES_OCB_decrypt
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	sw	s1, 20(sp)                      # 4-byte Folded Spill
	mv	s0, a5
	mv	s1, a4
	mv	a4, a3
	mv	a3, a2
	sw	zero, 4(sp)
	sw	zero, 8(sp)
	sw	zero, 12(sp)
	sw	zero, 16(sp)
	blez	a5, .LBB40_3
# %bb.1:
	addi	a5, s0, -1
	li	a2, 1
.LBB40_2:                               # =>This Inner Loop Header: Depth=1
	add	a7, s1, a5
	lbu	a7, 0(a7)
	add	t0, a6, a5
	addi	t1, a5, 1
	addi	a5, a5, -1
	sb	a7, 0(t0)
	bltu	a2, t1, .LBB40_2
.LBB40_3:
	addi	a7, sp, 4
	li	a2, 0
	mv	a5, s0
	call	OCB_cipher
	addi	a0, sp, 19
	add	a1, s0, s1
	addi	a1, a1, 15
	li	a2, -16
.LBB40_4:                               # =>This Inner Loop Header: Depth=1
	beqz	a2, .LBB40_7
# %bb.5:                                #   in Loop: Header=BB40_4 Depth=1
	lbu	a3, 0(a1)
	lbu	a4, 0(a0)
	addi	a0, a0, -1
	addi	a1, a1, -1
	addi	a2, a2, 1
	beq	a3, a4, .LBB40_4
# %bb.6:
	li	a0, 26
	j	.LBB40_8
.LBB40_7:
	li	a0, 0
.LBB40_8:
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	lw	s1, 20(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end40:
	.size	AES_OCB_decrypt, .Lfunc_end40-AES_OCB_decrypt
                                        # -- End function
	.globl	AES_KEY_wrap                    # -- Begin function AES_KEY_wrap
	.p2align	2
	.type	AES_KEY_wrap,@function
AES_KEY_wrap:                           # @AES_KEY_wrap
# %bb.0:
	addi	sp, sp, -64
	sw	ra, 60(sp)                      # 4-byte Folded Spill
	sw	s0, 56(sp)                      # 4-byte Folded Spill
	sw	s1, 52(sp)                      # 4-byte Folded Spill
	sw	s2, 48(sp)                      # 4-byte Folded Spill
	sw	s3, 44(sp)                      # 4-byte Folded Spill
	sw	s4, 40(sp)                      # 4-byte Folded Spill
	sw	s5, 36(sp)                      # 4-byte Folded Spill
	sw	s6, 32(sp)                      # 4-byte Folded Spill
	sw	s7, 28(sp)                      # 4-byte Folded Spill
	sw	s8, 24(sp)                      # 4-byte Folded Spill
	mv	s0, a3
	li	a4, 16
	li	a3, 1
	bltu	a2, a4, .LBB41_20
# %bb.1:
	andi	a4, a2, 7
	bnez	a4, .LBB41_20
# %bb.2:
	addi	s2, s0, 8
	add	s1, s0, a2
	srli	s4, a2, 3
	addi	a3, sp, 15
	addi	a4, sp, 7
	li	a5, 166
.LBB41_3:                               # =>This Inner Loop Header: Depth=1
	sb	a5, 0(a3)
	addi	a3, a3, -1
	bne	a3, a4, .LBB41_3
# %bb.4:
	blez	a2, .LBB41_7
# %bb.5:
	addi	a3, s0, 7
	add	a1, a2, a1
	add	a2, a3, a2
	addi	a1, a1, -1
.LBB41_6:                               # =>This Inner Loop Header: Depth=1
	lbu	a4, 0(a1)
	sb	a4, 0(a2)
	addi	a2, a2, -1
	addi	a1, a1, -1
	bne	a2, a3, .LBB41_6
.LBB41_7:
	call	KeyExpansion
	li	s3, 0
	slli	a0, s4, 1
	slli	a1, s4, 3
	addi	s4, sp, 23
	addi	s5, sp, 15
	sub	s6, a1, a0
	addi	s7, sp, 8
.LBB41_8:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB41_9 Depth 2
                                        #     Child Loop BB41_11 Depth 2
                                        #     Child Loop BB41_13 Depth 2
	addi	s8, s2, 7
	mv	a0, s8
	mv	a1, s4
.LBB41_9:                               #   Parent Loop BB41_8 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	lbu	a2, 0(a0)
	sb	a2, 0(a1)
	addi	a1, a1, -1
	addi	a0, a0, -1
	bne	a1, s5, .LBB41_9
# %bb.10:                               #   in Loop: Header=BB41_8 Depth=1
	addi	a0, sp, 8
	addi	a1, sp, 8
	call	rijndaelEncrypt
	addi	a0, s2, -1
	mv	a1, s4
.LBB41_11:                              #   Parent Loop BB41_8 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	lbu	a2, 0(a1)
	sb	a2, 0(s8)
	addi	s8, s8, -1
	addi	a1, a1, -1
	bne	s8, a0, .LBB41_11
# %bb.12:                               #   in Loop: Header=BB41_8 Depth=1
	addi	s3, s3, 1
	li	a1, 7
	mv	a0, s3
.LBB41_13:                              #   Parent Loop BB41_8 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	zext.b	a2, a1
	add	a2, s7, a2
	lbu	a3, 0(a2)
	addi	a1, a1, -1
	xor	a3, a3, a0
	srli	a0, a0, 8
	sb	a3, 0(a2)
	bnez	a0, .LBB41_13
# %bb.14:                               #   in Loop: Header=BB41_8 Depth=1
	mv	a0, s0
	beq	s2, s1, .LBB41_16
# %bb.15:                               #   in Loop: Header=BB41_8 Depth=1
	mv	a0, s2
.LBB41_16:                              #   in Loop: Header=BB41_8 Depth=1
	addi	s2, a0, 8
	bne	s3, s6, .LBB41_8
# %bb.17:
	li	a2, 7
	addi	a0, sp, 8
	li	a1, 1
.LBB41_18:                              # =>This Inner Loop Header: Depth=1
	add	a3, a0, a2
	lbu	a3, 0(a3)
	add	a4, s0, a2
	addi	a5, a2, 1
	addi	a2, a2, -1
	sb	a3, 0(a4)
	bltu	a1, a5, .LBB41_18
# %bb.19:
	li	a3, 0
.LBB41_20:
	mv	a0, a3
	lw	ra, 60(sp)                      # 4-byte Folded Reload
	lw	s0, 56(sp)                      # 4-byte Folded Reload
	lw	s1, 52(sp)                      # 4-byte Folded Reload
	lw	s2, 48(sp)                      # 4-byte Folded Reload
	lw	s3, 44(sp)                      # 4-byte Folded Reload
	lw	s4, 40(sp)                      # 4-byte Folded Reload
	lw	s5, 36(sp)                      # 4-byte Folded Reload
	lw	s6, 32(sp)                      # 4-byte Folded Reload
	lw	s7, 28(sp)                      # 4-byte Folded Reload
	lw	s8, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 64
	ret
.Lfunc_end41:
	.size	AES_KEY_wrap, .Lfunc_end41-AES_KEY_wrap
                                        # -- End function
	.globl	AES_KEY_unwrap                  # -- Begin function AES_KEY_unwrap
	.p2align	2
	.type	AES_KEY_unwrap,@function
AES_KEY_unwrap:                         # @AES_KEY_unwrap
# %bb.0:
	addi	sp, sp, -64
	sw	ra, 60(sp)                      # 4-byte Folded Spill
	sw	s0, 56(sp)                      # 4-byte Folded Spill
	sw	s1, 52(sp)                      # 4-byte Folded Spill
	sw	s2, 48(sp)                      # 4-byte Folded Spill
	sw	s3, 44(sp)                      # 4-byte Folded Spill
	sw	s4, 40(sp)                      # 4-byte Folded Spill
	sw	s5, 36(sp)                      # 4-byte Folded Spill
	sw	s6, 32(sp)                      # 4-byte Folded Spill
	sw	s7, 28(sp)                      # 4-byte Folded Spill
	mv	s0, a3
	li	a4, 24
	li	a3, 1
	bltu	a2, a4, .LBB42_21
# %bb.1:
	andi	a4, a2, 7
	bnez	a4, .LBB42_21
# %bb.2:
	add	a3, s0, a2
	srli	s2, a2, 3
	li	a5, 7
	addi	a4, sp, 12
	addi	s1, a3, -8
	li	a6, 1
.LBB42_3:                               # =>This Inner Loop Header: Depth=1
	add	a7, a1, a5
	lbu	a7, 0(a7)
	add	t0, a4, a5
	addi	t1, a5, 1
	addi	a5, a5, -1
	sb	a7, 0(t0)
	bltu	a6, t1, .LBB42_3
# %bb.4:
	addi	a4, a2, -8
	blez	a4, .LBB42_7
# %bb.5:
	addi	a3, a3, -9
	add	a1, a2, a1
	addi	a1, a1, -1
	addi	a2, s0, -1
.LBB42_6:                               # =>This Inner Loop Header: Depth=1
	lbu	a4, 0(a1)
	sb	a4, 0(a3)
	addi	a3, a3, -1
	addi	a1, a1, -1
	bne	a3, a2, .LBB42_6
.LBB42_7:
	call	KeyExpansion
	slli	a0, s2, 1
	slli	s2, s2, 3
	sub	s2, s2, a0
	addi	s2, s2, -6
	beqz	s2, .LBB42_18
# %bb.8:
	addi	s3, sp, 27
	addi	s4, sp, 12
	li	s5, 1
	mv	s6, s0
.LBB42_9:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB42_10 Depth 2
                                        #     Child Loop BB42_14 Depth 2
                                        #     Child Loop BB42_16 Depth 2
	li	a1, 7
	mv	a0, s2
.LBB42_10:                              #   Parent Loop BB42_9 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	zext.b	a2, a1
	add	a2, s4, a2
	lbu	a3, 0(a2)
	addi	a1, a1, -1
	xor	a3, a3, a0
	srli	a0, a0, 8
	sb	a3, 0(a2)
	bnez	a0, .LBB42_10
# %bb.11:                               #   in Loop: Header=BB42_9 Depth=1
	mv	s7, s1
	beq	s6, s0, .LBB42_13
# %bb.12:                               #   in Loop: Header=BB42_9 Depth=1
	mv	s7, s6
.LBB42_13:                              #   in Loop: Header=BB42_9 Depth=1
	li	a0, 0
	addi	s6, s7, -8
	addi	s7, s7, -1
.LBB42_14:                              #   Parent Loop BB42_9 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	add	a1, s7, a0
	lbu	a1, 0(a1)
	add	a2, s4, a0
	addi	a3, a0, 8
	addi	a0, a0, -1
	sb	a1, 15(a2)
	bltu	s5, a3, .LBB42_14
# %bb.15:                               #   in Loop: Header=BB42_9 Depth=1
	addi	a0, sp, 12
	addi	a1, sp, 12
	call	rijndaelDecrypt
	li	a0, 0
.LBB42_16:                              #   Parent Loop BB42_9 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	add	a1, s3, a0
	lbu	a1, 0(a1)
	add	a2, s7, a0
	addi	a3, a0, 8
	addi	a0, a0, -1
	sb	a1, 0(a2)
	bltu	s5, a3, .LBB42_16
# %bb.17:                               #   in Loop: Header=BB42_9 Depth=1
	addi	s2, s2, -1
	bnez	s2, .LBB42_9
.LBB42_18:
	li	a0, 0
	addi	a1, sp, 19
	addi	a2, sp, 11
.LBB42_19:                              # =>This Inner Loop Header: Depth=1
	lbu	a3, 0(a1)
	addi	a1, a1, -1
	addi	a3, a3, -166
	or	a0, a3, a0
	bne	a1, a2, .LBB42_19
# %bb.20:
	seqz	a0, a0
	addi	a0, a0, -1
	andi	a3, a0, 26
.LBB42_21:
	mv	a0, a3
	lw	ra, 60(sp)                      # 4-byte Folded Reload
	lw	s0, 56(sp)                      # 4-byte Folded Reload
	lw	s1, 52(sp)                      # 4-byte Folded Reload
	lw	s2, 48(sp)                      # 4-byte Folded Reload
	lw	s3, 44(sp)                      # 4-byte Folded Reload
	lw	s4, 40(sp)                      # 4-byte Folded Reload
	lw	s5, 36(sp)                      # 4-byte Folded Reload
	lw	s6, 32(sp)                      # 4-byte Folded Reload
	lw	s7, 28(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 64
	ret
.Lfunc_end42:
	.size	AES_KEY_unwrap, .Lfunc_end42-AES_KEY_unwrap
                                        # -- End function
	.globl	AES_Poly1305                    # -- Begin function AES_Poly1305
	.p2align	2
	.type	AES_Poly1305,@function
AES_Poly1305:                           # @AES_Poly1305
# %bb.0:
	addi	sp, sp, -112
	sw	ra, 108(sp)                     # 4-byte Folded Spill
	sw	s0, 104(sp)                     # 4-byte Folded Spill
	sw	s1, 100(sp)                     # 4-byte Folded Spill
	sw	s2, 96(sp)                      # 4-byte Folded Spill
	sw	s3, 92(sp)                      # 4-byte Folded Spill
	sw	s4, 88(sp)                      # 4-byte Folded Spill
	sw	s5, 84(sp)                      # 4-byte Folded Spill
	sw	s6, 80(sp)                      # 4-byte Folded Spill
	mv	s0, a4
	mv	s1, a3
	mv	s3, a2
	mv	s4, a1
	mv	s2, a0
	lui	a1, %hi(.L__const.AES_Poly1305.rk)
	addi	a1, a1, %lo(.L__const.AES_Poly1305.rk)
	addi	a0, sp, 46
	li	a2, 17
	call	memcpy
	addi	a0, sp, 29
	li	a2, 17
	li	a1, 0
	call	memset
	addi	a0, sp, 12
	li	a2, 17
	li	a1, 0
	call	memset
	mv	a0, s2
	call	KeyExpansion
	mv	a0, s4
	mv	a1, s0
	call	rijndaelEncrypt
	beqz	s1, .LBB43_24
# %bb.1:
	addi	a1, s1, -1
	add	s3, s3, s1
	addi	a2, sp, 78
	addi	s2, s2, 31
	srli	a0, a1, 4
	addi	a3, sp, 62
.LBB43_2:                               # =>This Inner Loop Header: Depth=1
	lbu	a4, 0(s2)
	sb	a4, 0(a2)
	addi	a2, a2, -1
	addi	s2, s2, -1
	bne	a2, a3, .LBB43_2
# %bb.3:
	addi	a2, sp, 79
	sb	zero, 79(sp)
	addi	a3, sp, 63
.LBB43_4:                               # =>This Inner Loop Header: Depth=1
	lbu	a4, 0(a2)
	lbu	a5, -1(a2)
	andi	a4, a4, 252
	andi	a5, a5, 15
	sb	a5, -1(a2)
	sb	a4, 0(a2)
	addi	a2, a2, -4
	bne	a2, a3, .LBB43_4
# %bb.5:
	andi	a1, a1, 240
	addi	s2, sp, 28
	addi	s4, sp, 29
	sub	s1, s1, a1
	zext.b	a1, s1
	li	s1, 1
.LBB43_6:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB43_8 Depth 2
                                        #     Child Loop BB43_10 Depth 2
                                        #     Child Loop BB43_13 Depth 2
	mv	s5, a0
	beqz	a1, .LBB43_9
# %bb.7:                                #   in Loop: Header=BB43_6 Depth=1
	addi	a0, s3, -1
	mv	a2, a1
.LBB43_8:                               #   Parent Loop BB43_6 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	lbu	a3, 0(a0)
	mv	a4, a2
	addi	a2, a2, -1
	add	a5, s2, a4
	sb	a3, 0(a5)
	addi	a0, a0, -1
	bltu	s1, a4, .LBB43_8
.LBB43_9:                               #   in Loop: Header=BB43_6 Depth=1
	sub	s3, s3, a1
	addi	s6, sp, 29
	add	a1, s6, a1
	sb	s1, 0(a1)
	addi	a0, sp, 63
	addi	a1, sp, 46
	call	mulLblocks
	addi	a0, sp, 46
	addi	a1, sp, 29
	call	mulLblocks
	li	a1, 0
	addi	a0, sp, 12
.LBB43_10:                              #   Parent Loop BB43_6 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	lbu	a2, 0(s6)
	lbu	a3, 0(a0)
	add	a1, a1, a2
	add	a1, a1, a3
	sb	a1, 0(a0)
	srli	a1, a1, 8
	addi	a0, a0, 1
	addi	s6, s6, 1
	bne	a0, s4, .LBB43_10
# %bb.11:                               #   in Loop: Header=BB43_6 Depth=1
	lbu	a1, 28(sp)
	srli	a0, a1, 2
	beqz	a0, .LBB43_14
# %bb.12:                               #   in Loop: Header=BB43_6 Depth=1
	andi	a1, a1, 3
	sb	a1, 28(sp)
	slli	a1, a0, 2
	add	a0, a1, a0
	addi	a1, sp, 12
.LBB43_13:                              #   Parent Loop BB43_6 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	lbu	a2, 0(a1)
	add	a2, a0, a2
	addi	a3, a1, 1
	srli	a0, a2, 8
	sb	a2, 0(a1)
	mv	a1, a3
	bnez	a0, .LBB43_13
.LBB43_14:                              #   in Loop: Header=BB43_6 Depth=1
	addi	a0, s5, -1
	li	a1, 16
	bnez	s5, .LBB43_6
# %bb.15:
	lbu	a2, 12(sp)
	lbu	a0, 28(sp)
	li	a3, 251
	slli	a1, a0, 2
	bltu	a2, a3, .LBB43_19
# %bb.16:
	li	a2, 3
	bne	a0, a2, .LBB43_19
# %bb.17:
	li	a1, 0
	addi	a2, sp, 13
	li	a3, 255
.LBB43_18:                              # =>This Inner Loop Header: Depth=1
	add	a4, a2, a1
	lbu	a4, 0(a4)
	addi	a1, a1, 1
	beq	a4, a3, .LBB43_18
.LBB43_19:
	srli	a1, a1, 4
	beqz	a1, .LBB43_22
# %bb.20:
	andi	a0, a0, 3
	sb	a0, 28(sp)
	slli	a0, a1, 2
	add	a0, a0, a1
	addi	a1, sp, 12
.LBB43_21:                              # =>This Inner Loop Header: Depth=1
	lbu	a2, 0(a1)
	add	a2, a0, a2
	addi	a3, a1, 1
	srli	a0, a2, 8
	sb	a2, 0(a1)
	mv	a1, a3
	bnez	a0, .LBB43_21
.LBB43_22:
	li	a1, 0
	addi	a0, s0, 16
	addi	a2, sp, 12
.LBB43_23:                              # =>This Inner Loop Header: Depth=1
	lbu	a3, 0(a2)
	lbu	a4, 0(s0)
	add	a1, a1, a3
	add	a1, a1, a4
	sb	a1, 0(s0)
	srli	a1, a1, 8
	addi	s0, s0, 1
	addi	a2, a2, 1
	bne	s0, a0, .LBB43_23
.LBB43_24:
	lw	ra, 108(sp)                     # 4-byte Folded Reload
	lw	s0, 104(sp)                     # 4-byte Folded Reload
	lw	s1, 100(sp)                     # 4-byte Folded Reload
	lw	s2, 96(sp)                      # 4-byte Folded Reload
	lw	s3, 92(sp)                      # 4-byte Folded Reload
	lw	s4, 88(sp)                      # 4-byte Folded Reload
	lw	s5, 84(sp)                      # 4-byte Folded Reload
	lw	s6, 80(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 112
	ret
.Lfunc_end43:
	.size	AES_Poly1305, .Lfunc_end43-AES_Poly1305
                                        # -- End function
	.p2align	2                               # -- Begin function mulLblocks
	.type	mulLblocks,@function
mulLblocks:                             # @mulLblocks
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	sw	s1, 20(sp)                      # 4-byte Folded Spill
	mv	s0, a1
	mv	s1, a0
	addi	a0, sp, 3
	li	a2, 17
	li	a1, 0
	call	memset
	li	a4, 16
	addi	a0, sp, 20
	li	a1, 4
.LBB44_1:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB44_2 Depth 2
                                        #     Child Loop BB44_5 Depth 2
	li	a3, 0
	mv	a2, a4
	add	a4, s0, a4
	lbu	a4, 0(a4)
	snez	a5, a2
	slli	a5, a5, 3
	mv	a6, s1
	addi	a7, sp, 3
.LBB44_2:                               #   Parent Loop BB44_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	lbu	t0, 0(a6)
	lbu	t1, 0(a7)
	srai	a3, a3, 8
	mul	t0, t0, a4
	add	t0, t0, t1
	sll	t0, t0, a5
	add	a3, t0, a3
	sb	a3, 0(a7)
	addi	a7, a7, 1
	addi	a6, a6, 1
	bne	a7, a0, .LBB44_2
# %bb.3:                                #   in Loop: Header=BB44_1 Depth=1
	blt	a3, a1, .LBB44_6
# %bb.4:                                #   in Loop: Header=BB44_1 Depth=1
	lbu	a4, 19(sp)
	srli	a5, a3, 2
	andi	a3, a3, -4
	add	a3, a3, a5
	andi	a4, a4, 3
	sb	a4, 19(sp)
	addi	a4, sp, 3
.LBB44_5:                               #   Parent Loop BB44_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	lbu	a5, 0(a4)
	add	a5, a3, a5
	addi	a6, a4, 1
	srli	a3, a5, 8
	sb	a5, 0(a4)
	mv	a4, a6
	bnez	a3, .LBB44_5
.LBB44_6:                               #   in Loop: Header=BB44_1 Depth=1
	addi	a4, a2, -1
	bnez	a2, .LBB44_1
# %bb.7:
	li	a2, 16
	addi	a0, sp, 3
	li	a1, 1
.LBB44_8:                               # =>This Inner Loop Header: Depth=1
	add	a3, a0, a2
	lbu	a3, 0(a3)
	add	a4, s0, a2
	addi	a5, a2, 1
	addi	a2, a2, -1
	sb	a3, 0(a4)
	bltu	a1, a5, .LBB44_8
# %bb.9:
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	lw	s1, 20(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end44:
	.size	mulLblocks, .Lfunc_end44-mulLblocks
                                        # -- End function
	.p2align	2                               # -- Begin function incBlock
	.type	incBlock,@function
incBlock:                               # @incBlock
# %bb.0:
	add	a2, a0, a1
	lbu	a3, 0(a2)
	addi	a3, a3, 1
	zext.b	a4, a3
	sb	a3, 0(a2)
	bnez	a4, .LBB45_7
# %bb.1:
	li	a2, 3
	li	a3, 9
.LBB45_2:                               # =>This Inner Loop Header: Depth=1
	zext.b	a4, a1
	bltu	a2, a4, .LBB45_5
# %bb.3:                                #   in Loop: Header=BB45_2 Depth=1
	beq	a4, a2, .LBB45_7
# %bb.4:                                #   in Loop: Header=BB45_2 Depth=1
	addi	a1, a1, 1
	j	.LBB45_6
.LBB45_5:                               #   in Loop: Header=BB45_2 Depth=1
	addi	a1, a1, -1
	zext.b	a4, a1
	bltu	a4, a3, .LBB45_7
.LBB45_6:                               #   in Loop: Header=BB45_2 Depth=1
	zext.b	a4, a1
	add	a4, a0, a4
	lbu	a5, 0(a4)
	addi	a5, a5, 1
	zext.b	a6, a5
	sb	a5, 0(a4)
	beqz	a6, .LBB45_2
.LBB45_7:
	ret
.Lfunc_end45:
	.size	incBlock, .Lfunc_end45-incBlock
                                        # -- End function
	.p2align	2                               # -- Begin function xMac
	.type	xMac,@function
xMac:                                   # @xMac
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	sw	s1, 20(sp)                      # 4-byte Folded Spill
	sw	s2, 16(sp)                      # 4-byte Folded Spill
	sw	s3, 12(sp)                      # 4-byte Folded Spill
	sw	s4, 8(sp)                       # 4-byte Folded Spill
	sw	s5, 4(sp)                       # 4-byte Folded Spill
	mv	s0, a4
	sw	a3, 0(sp)                       # 4-byte Folded Spill
	mv	s1, a2
	mv	s3, a1
	srli	s4, a1, 4
	mv	s2, a0
	beqz	s4, .LBB46_5
# %bb.1:
	addi	s5, s0, 16
.LBB46_2:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB46_3 Depth 2
	mv	a0, s2
	mv	a1, s0
.LBB46_3:                               #   Parent Loop BB46_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	lbu	a2, 0(a0)
	lbu	a3, 0(a1)
	xor	a2, a3, a2
	sb	a2, 0(a1)
	addi	a1, a1, 1
	addi	a0, a0, 1
	bne	a1, s5, .LBB46_3
# %bb.4:                                #   in Loop: Header=BB46_2 Depth=1
	addi	s4, s4, -1
	mv	a0, s1
	mv	a1, s0
	lw	t1, 0(sp)                       # 4-byte Folded Reload
	jalr	t1
	addi	s2, s2, 16
	bnez	s4, .LBB46_2
.LBB46_5:
	andi	a0, s3, 15
	beqz	a0, .LBB46_9
# %bb.6:
	addi	a1, a0, -1
	add	a0, s0, a1
	add	s2, s2, a1
	addi	a1, s0, -1
.LBB46_7:                               # =>This Inner Loop Header: Depth=1
	lbu	a2, 0(s2)
	lbu	a3, 0(a0)
	xor	a2, a3, a2
	sb	a2, 0(a0)
	addi	a0, a0, -1
	addi	s2, s2, -1
	bne	a0, a1, .LBB46_7
# %bb.8:
	mv	a0, s1
	mv	a1, s0
	lw	t1, 0(sp)                       # 4-byte Folded Reload
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	lw	s1, 20(sp)                      # 4-byte Folded Reload
	lw	s2, 16(sp)                      # 4-byte Folded Reload
	lw	s3, 12(sp)                      # 4-byte Folded Reload
	lw	s4, 8(sp)                       # 4-byte Folded Reload
	lw	s5, 4(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 32
	jr	t1
.LBB46_9:
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	lw	s1, 20(sp)                      # 4-byte Folded Reload
	lw	s2, 16(sp)                      # 4-byte Folded Reload
	lw	s3, 12(sp)                      # 4-byte Folded Reload
	lw	s4, 8(sp)                       # 4-byte Folded Reload
	lw	s5, 4(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end46:
	.size	xMac, .Lfunc_end46-xMac
                                        # -- End function
	.p2align	2                               # -- Begin function mulGF128
	.type	mulGF128,@function
mulGF128:                               # @mulGF128
# %bb.0:
	addi	sp, sp, -16
	li	a2, 0
	sw	zero, 0(sp)
	sw	zero, 4(sp)
	sw	zero, 8(sp)
	sw	zero, 12(sp)
	addi	a3, sp, 16
	addi	a4, a1, 16
	li	a5, 16
.LBB47_1:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB47_2 Depth 2
                                        #       Child Loop BB47_4 Depth 3
                                        #       Child Loop BB47_6 Depth 3
	add	a6, a0, a2
	li	a7, 128
.LBB47_2:                               #   Parent Loop BB47_1 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB47_4 Depth 3
                                        #       Child Loop BB47_6 Depth 3
	lbu	t0, 0(a6)
	and	t0, t0, a7
	beqz	t0, .LBB47_5
# %bb.3:                                #   in Loop: Header=BB47_2 Depth=2
	mv	t0, sp
	mv	t1, a1
.LBB47_4:                               #   Parent Loop BB47_1 Depth=1
                                        #     Parent Loop BB47_2 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	lbu	t2, 0(t1)
	lbu	t3, 0(t0)
	xor	t2, t3, t2
	sb	t2, 0(t0)
	addi	t0, t0, 1
	addi	t1, t1, 1
	bne	t0, a3, .LBB47_4
.LBB47_5:                               #   in Loop: Header=BB47_2 Depth=2
	li	t0, 0
	mv	t1, a1
.LBB47_6:                               #   Parent Loop BB47_1 Depth=1
                                        #     Parent Loop BB47_2 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	lbu	t2, 0(t1)
	slli	t0, t0, 8
	or	t0, t0, t2
	srli	t3, t0, 1
	sb	t3, 0(t1)
	addi	t1, t1, 1
	bne	t1, a4, .LBB47_6
# %bb.7:                                #   in Loop: Header=BB47_2 Depth=2
	andi	t0, t2, 1
	beqz	t0, .LBB47_9
# %bb.8:                                #   in Loop: Header=BB47_2 Depth=2
	lbu	t0, 0(a1)
	xori	t0, t0, 225
	sb	t0, 0(a1)
.LBB47_9:                               #   in Loop: Header=BB47_2 Depth=2
	srli	a7, a7, 1
	bnez	a7, .LBB47_2
# %bb.10:                               #   in Loop: Header=BB47_1 Depth=1
	addi	a2, a2, 1
	bne	a2, a5, .LBB47_1
# %bb.11:
	li	a3, 15
	mv	a0, sp
	li	a2, 1
.LBB47_12:                              # =>This Inner Loop Header: Depth=1
	add	a4, a0, a3
	lbu	a4, 0(a4)
	add	a5, a1, a3
	addi	a6, a3, 1
	addi	a3, a3, -1
	sb	a4, 0(a5)
	bltu	a2, a6, .LBB47_12
# %bb.13:
	addi	sp, sp, 16
	ret
.Lfunc_end47:
	.size	mulGF128, .Lfunc_end47-mulGF128
                                        # -- End function
	.p2align	2                               # -- Begin function dotGF128
	.type	dotGF128,@function
dotGF128:                               # @dotGF128
# %bb.0:
	addi	sp, sp, -16
	sw	zero, 0(sp)
	sw	zero, 4(sp)
	sw	zero, 8(sp)
	sw	zero, 12(sp)
	addi	a2, a1, 15
	addi	a3, a1, -1
	li	a6, 15
	addi	a4, sp, 16
.LBB48_1:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB48_2 Depth 2
                                        #       Child Loop BB48_3 Depth 3
                                        #       Child Loop BB48_8 Depth 3
	mv	a5, a6
	add	a6, a0, a6
	li	a7, 128
.LBB48_2:                               #   Parent Loop BB48_1 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB48_3 Depth 3
                                        #       Child Loop BB48_8 Depth 3
	li	t0, 0
	mv	t1, a2
.LBB48_3:                               #   Parent Loop BB48_1 Depth=1
                                        #     Parent Loop BB48_2 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	lbu	t2, 0(t1)
	slli	t0, t0, 8
	or	t0, t0, t2
	srli	t3, t0, 1
	sb	t3, 0(t1)
	addi	t1, t1, -1
	bne	t1, a3, .LBB48_3
# %bb.4:                                #   in Loop: Header=BB48_2 Depth=2
	andi	t0, t2, 1
	beqz	t0, .LBB48_6
# %bb.5:                                #   in Loop: Header=BB48_2 Depth=2
	lbu	t0, 0(a2)
	xori	t0, t0, 225
	sb	t0, 0(a2)
.LBB48_6:                               #   in Loop: Header=BB48_2 Depth=2
	lbu	t0, 0(a6)
	and	t0, t0, a7
	beqz	t0, .LBB48_9
# %bb.7:                                #   in Loop: Header=BB48_2 Depth=2
	mv	t0, sp
	mv	t1, a1
.LBB48_8:                               #   Parent Loop BB48_1 Depth=1
                                        #     Parent Loop BB48_2 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	lbu	t2, 0(t1)
	lbu	t3, 0(t0)
	xor	t2, t3, t2
	sb	t2, 0(t0)
	addi	t0, t0, 1
	addi	t1, t1, 1
	bne	t0, a4, .LBB48_8
.LBB48_9:                               #   in Loop: Header=BB48_2 Depth=2
	srli	a7, a7, 1
	bnez	a7, .LBB48_2
# %bb.10:                               #   in Loop: Header=BB48_1 Depth=1
	addi	a6, a5, -1
	bnez	a5, .LBB48_1
# %bb.11:
	li	a3, 15
	mv	a0, sp
	li	a2, 1
.LBB48_12:                              # =>This Inner Loop Header: Depth=1
	add	a4, a0, a3
	lbu	a4, 0(a4)
	add	a5, a1, a3
	addi	a6, a3, 1
	addi	a3, a3, -1
	sb	a4, 0(a5)
	bltu	a2, a6, .LBB48_12
# %bb.13:
	addi	sp, sp, 16
	ret
.Lfunc_end48:
	.size	dotGF128, .Lfunc_end48-dotGF128
                                        # -- End function
	.p2align	2                               # -- Begin function getDelta
	.type	getDelta,@function
getDelta:                               # @getDelta
# %bb.0:
	addi	sp, sp, -16
	li	a6, 15
	mv	a4, sp
	li	a5, 1
.LBB49_1:                               # =>This Inner Loop Header: Depth=1
	add	a7, a1, a6
	lbu	a7, 0(a7)
	add	t0, a4, a6
	addi	t1, a6, 1
	addi	a6, a6, -1
	sb	a7, 0(t0)
	bltu	a5, t1, .LBB49_1
# %bb.2:
	li	a4, 15
	li	a1, 1
.LBB49_3:                               # =>This Inner Loop Header: Depth=1
	add	a5, a2, a4
	lbu	a5, 0(a5)
	add	a6, a3, a4
	addi	a7, a4, 1
	addi	a4, a4, -1
	sb	a5, 0(a6)
	bltu	a1, a7, .LBB49_3
# %bb.4:
	beqz	a0, .LBB49_12
# %bb.5:
	addi	a7, a0, -1
	addi	a1, a3, 16
	li	a2, 1
	mv	a4, sp
	li	a5, -121
	li	a6, 1
.LBB49_6:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB49_7 Depth 2
                                        #     Child Loop BB49_10 Depth 2
	li	t0, 0
	li	t1, 15
.LBB49_7:                               #   Parent Loop BB49_6 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	add	t2, a4, t1
	lbu	t3, 0(t2)
	slli	t3, t3, 1
	or	t0, t3, t0
	addi	t3, t1, 1
	addi	t1, t1, -1
	sb	t0, 0(t2)
	srli	t0, t0, 8
	bltu	a2, t3, .LBB49_7
# %bb.8:                                #   in Loop: Header=BB49_6 Depth=1
	lbu	t1, 15(sp)
	mul	t0, t0, a5
	slli	a6, a6, 1
	xor	t0, t1, t0
	and	a7, a7, a6
	sb	t0, 15(sp)
	bnez	a7, .LBB49_11
# %bb.9:                                #   in Loop: Header=BB49_6 Depth=1
	mv	a7, sp
	mv	t0, a3
.LBB49_10:                              #   Parent Loop BB49_6 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	lbu	t1, 0(a7)
	lbu	t2, 0(t0)
	xor	t1, t2, t1
	sb	t1, 0(t0)
	addi	t0, t0, 1
	addi	a7, a7, 1
	bne	t0, a1, .LBB49_10
.LBB49_11:                              #   in Loop: Header=BB49_6 Depth=1
	sub	a7, a0, a6
	bltu	a7, a0, .LBB49_6
.LBB49_12:
	addi	sp, sp, 16
	ret
.Lfunc_end49:
	.size	getDelta, .Lfunc_end49-getDelta
                                        # -- End function
	.type	RoundKey,@object                # @RoundKey
	.local	RoundKey
	.comm	RoundKey,176,1
	.type	.L__const.AES_CCM_decrypt.iv,@object # @__const.AES_CCM_decrypt.iv
	.section	.rodata.cst16,"aM",@progbits,16
.L__const.AES_CCM_decrypt.iv:
	.byte	3                               # 0x3
	.zero	15
	.size	.L__const.AES_CCM_decrypt.iv, 16

	.type	.L__const.AES_Poly1305.rk,@object # @__const.AES_Poly1305.rk
	.section	.rodata,"a",@progbits
.L__const.AES_Poly1305.rk:
	.byte	1                               # 0x1
	.zero	16
	.size	.L__const.AES_Poly1305.rk, 17

	.type	sbox,@object                    # @sbox
sbox:
	.ascii	"c|w{\362ko\3050\001g+\376\327\253v\312\202\311}\372YG\360\255\324\242\257\234\244r\300\267\375\223&6?\367\3144\245\345\361q\3301\025\004\307#\303\030\226\005\232\007\022\200\342\353'\262u\t\203,\032\033nZ\240R;\326\263)\343/\204S\321\000\355 \374\261[j\313\2769JLX\317\320\357\252\373CM3\205E\371\002\177P<\237\250Q\243@\217\222\2358\365\274\266\332!\020\377\363\322\315\f\023\354_\227D\027\304\247~=d]\031s`\201O\334\"*\220\210F\356\270\024\336^\013\333\3402:\nI\006$\\\302\323\254b\221\225\344y\347\3107m\215\325N\251lV\364\352ez\256\b\272x%.\034\246\264\306\350\335t\037K\275\213\212p>\265fH\003\366\016a5W\271\206\301\035\236\341\370\230\021i\331\216\224\233\036\207\351\316U(\337\214\241\211\r\277\346BhA\231-\017\260T\273\026"
	.size	sbox, 256

	.type	rsbox,@object                   # @rsbox
rsbox:
	.ascii	"R\tj\32506\2458\277@\243\236\201\363\327\373|\3439\202\233/\377\2074\216CD\304\336\351\313T{\2242\246\302#=\356L\225\013B\372\303N\b.\241f(\331$\262v[\242Im\213\321%r\370\366d\206h\230\026\324\244\\\314]e\266\222lpHP\375\355\271\332^\025FW\247\215\235\204\220\330\253\000\214\274\323\n\367\344X\005\270\263E\006\320,\036\217\312?\017\002\301\257\275\003\001\023\212k:\221\021AOg\334\352\227\362\317\316\360\264\346s\226\254t\"\347\2555\205\342\3717\350\034u\337nG\361\032q\035)\305\211o\267b\016\252\030\276\033\374V>K\306\322y \232\333\300\376x\315Z\364\037\335\2503\210\007\3071\261\022\020Y'\200\354_`Q\177\251\031\265J\r-\345z\237\223\311\234\357\240\340;M\256*\365\260\310\353\273<\203S\231a\027+\004~\272w\326&\341i\024cU!\f}"
	.size	rsbox, 256

	.ident	"clang version 21.1.8"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym rijndaelEncrypt
	.addrsig_sym mulGF128
	.addrsig_sym dotGF128
