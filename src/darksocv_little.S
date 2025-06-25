
darksocv.o:     file format elf32-littleriscv


Disassembly of section .text:

00000000 <_start>:
       0:	00000513          	li	a0,0
       4:	f1402573          	csrr	a0,mhartid
       8:	00050463          	beqz	a0,10 <_uart_boot>

0000000c <_thread_lock>:
       c:	0000006f          	j	c <_thread_lock>

00000010 <_uart_boot>:
      10:	400007b7          	lui	a5,0x40000
      14:	0a500513          	li	a0,165
      18:	00a7a423          	sw	a0,8(a5) # 40000008 <_global+0x3fffda74>
      1c:	00078503          	lb	a0,0(a5)
      20:	04050a63          	beqz	a0,74 <_normal_boot>
      24:	07500513          	li	a0,117
      28:	0d0000ef          	jal	f8 <_uart_putchar>
      2c:	007d05b7          	lui	a1,0x7d0
      30:	00002617          	auipc	a2,0x2
      34:	da062603          	lw	a2,-608(a2) # 1dd0 <_GLOBAL_OFFSET_TABLE_+0x8>
      38:	00500693          	li	a3,5
      3c:	00a7a423          	sw	a0,8(a5)

00000040 <_uart_boot_loop1>:
      40:	00058513          	mv	a0,a1
      44:	0dc000ef          	jal	120 <_uart_getchar>
      48:	00054863          	bltz	a0,58 <_uart_boot_exit>
      4c:	00a60023          	sb	a0,0(a2)
      50:	00160613          	addi	a2,a2,1
      54:	fedff06f          	j	40 <_uart_boot_loop1>

00000058 <_uart_boot_exit>:
      58:	02e00513          	li	a0,46
      5c:	09c000ef          	jal	f8 <_uart_putchar>
      60:	fff68693          	addi	a3,a3,-1
      64:	00d7a423          	sw	a3,8(a5)
      68:	fcd04ce3          	bgtz	a3,40 <_uart_boot_loop1>
      6c:	06200513          	li	a0,98
      70:	088000ef          	jal	f8 <_uart_putchar>

00000074 <_normal_boot>:
      74:	00a00513          	li	a0,10
      78:	080000ef          	jal	f8 <_uart_putchar>
      7c:	00000617          	auipc	a2,0x0
      80:	0c860613          	addi	a2,a2,200 # 144 <_rle_banner>
      84:	00000597          	auipc	a1,0x0
      88:	12758593          	addi	a1,a1,295 # 1ab <_rle_dict>
      8c:	00064683          	lbu	a3,0(a2)

00000090 <_rle_banner_loop1>:
      90:	0066d513          	srli	a0,a3,0x6
      94:	00b50533          	add	a0,a0,a1
      98:	00054503          	lbu	a0,0(a0)
      9c:	03f6f693          	andi	a3,a3,63
      a0:	00160613          	addi	a2,a2,1

000000a4 <_rle_banner_loop2>:
      a4:	054000ef          	jal	f8 <_uart_putchar>
      a8:	fff68693          	addi	a3,a3,-1
      ac:	fed04ce3          	bgtz	a3,a4 <_rle_banner_loop2>
      b0:	00064683          	lbu	a3,0(a2)
      b4:	fc069ee3          	bnez	a3,90 <_rle_banner_loop1>
      b8:	00000617          	auipc	a2,0x0
      bc:	0f760613          	addi	a2,a2,247 # 1af <_str_banner>

000000c0 <_str_banner_loop3>:
      c0:	00064503          	lbu	a0,0(a2)
      c4:	00050863          	beqz	a0,d4 <_str_banner_loop4>
      c8:	030000ef          	jal	f8 <_uart_putchar>
      cc:	00160613          	addi	a2,a2,1
      d0:	ff1ff06f          	j	c0 <_str_banner_loop3>

000000d4 <_str_banner_loop4>:
      d4:	00002117          	auipc	sp,0x2
      d8:	d0012103          	lw	sp,-768(sp) # 1dd4 <_GLOBAL_OFFSET_TABLE_+0xc>
      dc:	00002197          	auipc	gp,0x2
      e0:	cf01a183          	lw	gp,-784(gp) # 1dcc <_GLOBAL_OFFSET_TABLE_+0x4>
      e4:	00a54533          	xor	a0,a0,a0
      e8:	00b5c5b3          	xor	a1,a1,a1
      ec:	00c64633          	xor	a2,a2,a2
      f0:	110000ef          	jal	200 <main>
      f4:	f0dff06f          	j	0 <_start>

000000f8 <_uart_putchar>:
      f8:	00478283          	lb	t0,4(a5)
      fc:	fff2c293          	not	t0,t0
     100:	0012f293          	andi	t0,t0,1
     104:	fe028ae3          	beqz	t0,f8 <_uart_putchar>
     108:	00a782a3          	sb	a0,5(a5)
     10c:	00a00293          	li	t0,10
     110:	00551663          	bne	a0,t0,11c <_uart_putchar_exit>
     114:	00d00513          	li	a0,13
     118:	fe1ff06f          	j	f8 <_uart_putchar>

0000011c <_uart_putchar_exit>:
     11c:	00008067          	ret

00000120 <_uart_getchar>:
     120:	00050e63          	beqz	a0,13c <_uart_getchar_tout>
     124:	fff50513          	addi	a0,a0,-1
     128:	00478283          	lb	t0,4(a5)
     12c:	0022f293          	andi	t0,t0,2
     130:	fe0288e3          	beqz	t0,120 <_uart_getchar>
     134:	0057c503          	lbu	a0,5(a5)
     138:	00008067          	ret

0000013c <_uart_getchar_tout>:
     13c:	fff00513          	li	a0,-1
     140:	00008067          	ret

00000144 <_rle_banner>:
     144:	a00e                	.insn	2, 0xa00e
     146:	12c1                	.insn	2, 0x12c1
     148:	c19c                	.insn	2, 0xc19c
     14a:	074d                	.insn	2, 0x074d
     14c:	c19a                	.insn	2, 0xc19a
     14e:	0650                	.insn	2, 0x0650
     150:	c198                	.insn	2, 0xc198
     152:	0452                	.insn	2, 0x0452
     154:	c198                	.insn	2, 0xc198
     156:	0452                	.insn	2, 0x0452
     158:	c198                	.insn	2, 0xc198
     15a:	0452                	.insn	2, 0x0452
     15c:	c198                	.insn	2, 0xc198
     15e:	0650                	.insn	2, 0x0650
     160:	0296                	.insn	2, 0x0296
     162:	4dc1                	.insn	2, 0x4dc1
     164:	c1049607          	.insn	4, 0xc1049607
     168:	1042                	.insn	2, 0x1042
     16a:	0696                	.insn	2, 0x0696
     16c:	42c1                	.insn	2, 0x42c1
     16e:	980c                	.insn	2, 0x980c
     170:	4206                	.insn	2, 0x4206
     172:	44c1                	.insn	2, 0x44c1
     174:	9a06                	.insn	2, 0x9a06
     176:	4406                	.insn	2, 0x4406
     178:	46c1                	.insn	2, 0x46c1
     17a:	9606                	.insn	2, 0x9606
     17c:	4606                	.insn	2, 0x4606
     17e:	48c1                	.insn	2, 0x48c1
     180:	9206                	.insn	2, 0x9206
     182:	4806                	.insn	2, 0x4806
     184:	4ac1                	.insn	2, 0x4ac1
     186:	8e06                	.insn	2, 0x8e06
     188:	4a06                	.insn	2, 0x4a06
     18a:	4cc1                	.insn	2, 0x4cc1
     18c:	8a06                	.insn	2, 0x8a06
     18e:	4c06                	.insn	2, 0x4c06
     190:	4ec1                	.insn	2, 0x4ec1
     192:	8606                	.insn	2, 0x8606
     194:	4e06                	.insn	2, 0x4e06
     196:	50c1                	.insn	2, 0x50c1
     198:	8206                	.insn	2, 0x8206
     19a:	5006                	.insn	2, 0x5006
     19c:	52c1                	.insn	2, 0x52c1
     19e:	520a                	.insn	2, 0x520a
     1a0:	54c1                	.insn	2, 0x54c1
     1a2:	5406                	.insn	2, 0x5406
     1a4:	56c1                	.insn	2, 0x56c1
     1a6:	5602                	.insn	2, 0x5602
     1a8:	07c2                	.insn	2, 0x07c2
	...

000001ab <_rle_dict>:
     1ab:	7220                	.insn	2, 0x7220
     1ad:	0a76                	.insn	2, 0x0a76

000001af <_str_banner>:
     1af:	4e49                	.insn	2, 0x4e49
     1b1:	55525453          	.insn	4, 0x55525453
     1b5:	4f495443          	.insn	4, 0x4f495443
     1b9:	204e                	.insn	2, 0x204e
     1bb:	53544553          	.insn	4, 0x53544553
     1bf:	5720                	.insn	2, 0x5720
     1c1:	4e41                	.insn	2, 0x4e41
     1c3:	2054                	.insn	2, 0x2054
     1c5:	4f54                	.insn	2, 0x4f54
     1c7:	4220                	.insn	2, 0x4220
     1c9:	2045                	.insn	2, 0x2045
     1cb:	5246                	.insn	2, 0x5246
     1cd:	4545                	.insn	2, 0x4545
     1cf:	0a0a                	.insn	2, 0x0a0a
     1d1:	0100                	.insn	2, 0x0100
	...

00000200 <main>:
     200:	f9010113          	addi	sp,sp,-112
     204:	06812423          	sw	s0,104(sp)
     208:	00002417          	auipc	s0,0x2
     20c:	b9440413          	addi	s0,s0,-1132 # 1d9c <io>
     210:	00042583          	lw	a1,0(s0)
     214:	00001517          	auipc	a0,0x1
     218:	3e450513          	addi	a0,a0,996 # 15f8 <_etext+0x10>
     21c:	06112623          	sw	ra,108(sp)
     220:	06912223          	sw	s1,100(sp)
     224:	3c9000ef          	jal	dec <printf>
     228:	02010613          	addi	a2,sp,32
     22c:	00000597          	auipc	a1,0x0
     230:	fd458593          	addi	a1,a1,-44 # 200 <main>
     234:	00001517          	auipc	a0,0x1
     238:	3cc50513          	addi	a0,a0,972 # 1600 <_etext+0x18>
     23c:	02012023          	sw	zero,32(sp)
     240:	3ad000ef          	jal	dec <printf>
     244:	00042783          	lw	a5,0(s0)
     248:	f8000713          	li	a4,-128
     24c:	00e781a3          	sb	a4,3(a5)
     250:	00002717          	auipc	a4,0x2
     254:	b4072223          	sw	zero,-1212(a4) # 1d94 <utimers>
     258:	0007c503          	lbu	a0,0(a5)
     25c:	505000ef          	jal	f60 <board_name>
     260:	00042783          	lw	a5,0(s0)
     264:	00050593          	mv	a1,a0
     268:	00001517          	auipc	a0,0x1
     26c:	3b450513          	addi	a0,a0,948 # 161c <_etext+0x34>
     270:	0007c603          	lbu	a2,0(a5)
     274:	379000ef          	jal	dec <printf>
     278:	00001617          	auipc	a2,0x1
     27c:	3b860613          	addi	a2,a2,952 # 1630 <_etext+0x48>
     280:	00001597          	auipc	a1,0x1
     284:	3bc58593          	addi	a1,a1,956 # 163c <_etext+0x54>
     288:	00001517          	auipc	a0,0x1
     28c:	3d450513          	addi	a0,a0,980 # 165c <_etext+0x74>
     290:	35d000ef          	jal	dec <printf>
     294:	00042783          	lw	a5,0(s0)
     298:	00001517          	auipc	a0,0x1
     29c:	3d850513          	addi	a0,a0,984 # 1670 <_etext+0x88>
     2a0:	0027c583          	lbu	a1,2(a5)
     2a4:	349000ef          	jal	dec <printf>
     2a8:	00042783          	lw	a5,0(s0)
     2ac:	00001517          	auipc	a0,0x1
     2b0:	3d050513          	addi	a0,a0,976 # 167c <_etext+0x94>
     2b4:	0017c583          	lbu	a1,1(a5)
     2b8:	00159593          	slli	a1,a1,0x1
     2bc:	331000ef          	jal	dec <printf>
     2c0:	1fc010ef          	jal	14bc <check4rv32i>
     2c4:	00001597          	auipc	a1,0x1
     2c8:	32458593          	addi	a1,a1,804 # 15e8 <_etext>
     2cc:	00051663          	bnez	a0,2d8 <main+0xd8>
     2d0:	00001597          	auipc	a1,0x1
     2d4:	31c58593          	addi	a1,a1,796 # 15ec <_etext+0x4>
     2d8:	00001517          	auipc	a0,0x1
     2dc:	3b850513          	addi	a0,a0,952 # 1690 <_etext+0xa8>
     2e0:	30d000ef          	jal	dec <printf>
     2e4:	01000613          	li	a2,16
     2e8:	00060593          	mv	a1,a2
     2ec:	3e800513          	li	a0,1000
     2f0:	1c4010ef          	jal	14b4 <mac>
     2f4:	4e800713          	li	a4,1256
     2f8:	00001797          	auipc	a5,0x1
     2fc:	54c78793          	addi	a5,a5,1356 # 1844 <_etext+0x25c>
     300:	00e51663          	bne	a0,a4,30c <main+0x10c>
     304:	00001797          	auipc	a5,0x1
     308:	2ec78793          	addi	a5,a5,748 # 15f0 <_etext+0x8>
     30c:	00078513          	mv	a0,a5
     310:	2dd000ef          	jal	dec <printf>
     314:	00001517          	auipc	a0,0x1
     318:	38450513          	addi	a0,a0,900 # 1698 <_etext+0xb0>
     31c:	2d1000ef          	jal	dec <printf>
     320:	00001517          	auipc	a0,0x1
     324:	3f850513          	addi	a0,a0,1016 # 1718 <_etext+0x130>
     328:	2c5000ef          	jal	dec <printf>
     32c:	00001697          	auipc	a3,0x1
     330:	2bc68693          	addi	a3,a3,700 # 15e8 <_etext>
     334:	00000597          	auipc	a1,0x0
     338:	ecc58593          	addi	a1,a1,-308 # 200 <main>
     33c:	00002497          	auipc	s1,0x2
     340:	bb448493          	addi	s1,s1,-1100 # 1ef0 <_edata>
     344:	00001617          	auipc	a2,0x1
     348:	2a460613          	addi	a2,a2,676 # 15e8 <_etext>
     34c:	40d48733          	sub	a4,s1,a3
     350:	40b60633          	sub	a2,a2,a1
     354:	00002797          	auipc	a5,0x2
     358:	cac78793          	addi	a5,a5,-852 # 2000 <_stack>
     35c:	00001517          	auipc	a0,0x1
     360:	34c50513          	addi	a0,a0,844 # 16a8 <_etext+0xc0>
     364:	289000ef          	jal	dec <printf>
     368:	00002797          	auipc	a5,0x2
     36c:	c9878793          	addi	a5,a5,-872 # 2000 <_stack>
     370:	409785b3          	sub	a1,a5,s1
     374:	00001517          	auipc	a0,0x1
     378:	35c50513          	addi	a0,a0,860 # 16d0 <_etext+0xe8>
     37c:	271000ef          	jal	dec <printf>
     380:	deadc7b7          	lui	a5,0xdeadc
     384:	eef78793          	addi	a5,a5,-273 # deadbeef <_global+0xdead995b>
     388:	00f4a023          	sw	a5,0(s1)
     38c:	00042783          	lw	a5,0(s0)
     390:	0067d503          	lhu	a0,6(a5)
     394:	108010ef          	jal	149c <bswap16>
     398:	00050593          	mv	a1,a0
     39c:	00001517          	auipc	a0,0x1
     3a0:	34c50513          	addi	a0,a0,844 # 16e8 <_etext+0x100>
     3a4:	249000ef          	jal	dec <printf>
     3a8:	00042783          	lw	a5,0(s0)
     3ac:	001e85b7          	lui	a1,0x1e8
     3b0:	48058593          	addi	a1,a1,1152 # 1e8480 <_global+0x1e5eec>
     3b4:	0017c503          	lbu	a0,1(a5)
     3b8:	00c7a403          	lw	s0,12(a5)
     3bc:	00c7a603          	lw	a2,12(a5)
     3c0:	00c12023          	sw	a2,0(sp)
     3c4:	765000ef          	jal	1328 <__mulsi3>
     3c8:	00140593          	addi	a1,s0,1
     3cc:	004010ef          	jal	13d0 <__udivsi3>
     3d0:	00012603          	lw	a2,0(sp)
     3d4:	00050593          	mv	a1,a0
     3d8:	00001517          	auipc	a0,0x1
     3dc:	32c50513          	addi	a0,a0,812 # 1704 <_etext+0x11c>
     3e0:	20d000ef          	jal	dec <printf>
     3e4:	01000637          	lui	a2,0x1000
     3e8:	000105b7          	lui	a1,0x10
     3ec:	fff58593          	addi	a1,a1,-1 # ffff <_global+0xda6b>
     3f0:	f0060613          	addi	a2,a2,-256 # ffff00 <_global+0xffd96c>
     3f4:	ffff0537          	lui	a0,0xffff0
     3f8:	1d8010ef          	jal	15d0 <csr_test>
     3fc:	00050593          	mv	a1,a0
     400:	1c050663          	beqz	a0,5cc <main+0x3cc>
     404:	00001517          	auipc	a0,0x1
     408:	31850513          	addi	a0,a0,792 # 171c <_etext+0x134>
     40c:	1e1000ef          	jal	dec <printf>
     410:	00001517          	auipc	a0,0x1
     414:	be850513          	addi	a0,a0,-1048 # ff8 <dbg_handler>
     418:	180010ef          	jal	1598 <set_stvec>
     41c:	0f8010ef          	jal	1514 <get_stvec>
     420:	00050413          	mv	s0,a0
     424:	1a050c63          	beqz	a0,5dc <main+0x3dc>
     428:	00050593          	mv	a1,a0
     42c:	00001517          	auipc	a0,0x1
     430:	31850513          	addi	a0,a0,792 # 1744 <_etext+0x15c>
     434:	1b9000ef          	jal	dec <printf>
     438:	00001517          	auipc	a0,0x1
     43c:	b5450513          	addi	a0,a0,-1196 # f8c <irq_handler>
     440:	148010ef          	jal	1588 <set_mtvec>
     444:	00040863          	beqz	s0,454 <main+0x254>
     448:	00100073          	ebreak
     44c:	00100293          	li	t0,1
     450:	0002a283          	lw	t0,0(t0)
     454:	0a8010ef          	jal	14fc <get_mtvec>
     458:	00a12623          	sw	a0,12(sp)
     45c:	18050863          	beqz	a0,5ec <main+0x3ec>
     460:	00050593          	mv	a1,a0
     464:	00001517          	auipc	a0,0x1
     468:	31c50513          	addi	a0,a0,796 # 1780 <_etext+0x198>
     46c:	181000ef          	jal	dec <printf>
     470:	0bc010ef          	jal	152c <get_mie>
     474:	000017b7          	lui	a5,0x1
     478:	80078793          	addi	a5,a5,-2048 # 800 <main+0x600>
     47c:	00f56533          	or	a0,a0,a5
     480:	128010ef          	jal	15a8 <set_mie>
     484:	048010ef          	jal	14cc <get_mstatus>
     488:	00856513          	ori	a0,a0,8
     48c:	0f4010ef          	jal	1580 <set_mstatus>
     490:	00001517          	auipc	a0,0x1
     494:	31c50513          	addi	a0,a0,796 # 17ac <_etext+0x1c4>
     498:	155000ef          	jal	dec <printf>
     49c:	00001517          	auipc	a0,0x1
     4a0:	27c50513          	addi	a0,a0,636 # 1718 <_etext+0x130>
     4a4:	149000ef          	jal	dec <printf>
     4a8:	00001517          	auipc	a0,0x1
     4ac:	33c50513          	addi	a0,a0,828 # 17e4 <_etext+0x1fc>
     4b0:	13d000ef          	jal	dec <printf>
     4b4:	00012823          	sw	zero,16(sp)
     4b8:	02000613          	li	a2,32
     4bc:	00000593          	li	a1,0
     4c0:	02410513          	addi	a0,sp,36
     4c4:	60d000ef          	jal	12d0 <memset>
     4c8:	00002497          	auipc	s1,0x2
     4cc:	8d448493          	addi	s1,s1,-1836 # 1d9c <io>
     4d0:	0004a783          	lw	a5,0(s1)
     4d4:	00001517          	auipc	a0,0x1
     4d8:	32850513          	addi	a0,a0,808 # 17fc <_etext+0x214>
     4dc:	0107a583          	lw	a1,16(a5)
     4e0:	01012783          	lw	a5,16(sp)
     4e4:	02b12023          	sw	a1,32(sp)
     4e8:	40f585b3          	sub	a1,a1,a5
     4ec:	101000ef          	jal	dec <printf>
     4f0:	00c12783          	lw	a5,12(sp)
     4f4:	04079863          	bnez	a5,544 <main+0x344>
     4f8:	000f4737          	lui	a4,0xf4
     4fc:	08000613          	li	a2,128
     500:	f8000593          	li	a1,-128
     504:	23f70713          	addi	a4,a4,575 # f423f <_global+0xf1cab>
     508:	0004a783          	lw	a5,0(s1)
     50c:	0037c683          	lbu	a3,3(a5)
     510:	02c69463          	bne	a3,a2,538 <main+0x338>
     514:	00002697          	auipc	a3,0x2
     518:	8806a683          	lw	a3,-1920(a3) # 1d94 <utimers>
     51c:	fff68513          	addi	a0,a3,-1
     520:	00002317          	auipc	t1,0x2
     524:	86a32a23          	sw	a0,-1932(t1) # 1d94 <utimers>
     528:	00069663          	bnez	a3,534 <main+0x334>
     52c:	00002697          	auipc	a3,0x2
     530:	86e6a423          	sw	a4,-1944(a3) # 1d94 <utimers>
     534:	00b781a3          	sb	a1,3(a5)
     538:	0047c783          	lbu	a5,4(a5)
     53c:	0027f793          	andi	a5,a5,2
     540:	fc0784e3          	beqz	a5,508 <main+0x308>
     544:	02000593          	li	a1,32
     548:	02410513          	addi	a0,sp,36
     54c:	680000ef          	jal	bcc <gets>
     550:	0004a783          	lw	a5,0(s1)
     554:	02410513          	addi	a0,sp,36
     558:	0107a783          	lw	a5,16(a5)
     55c:	00f12823          	sw	a5,16(sp)
     560:	00000793          	li	a5,0
     564:	00001597          	auipc	a1,0x1
     568:	2a058593          	addi	a1,a1,672 # 1804 <_etext+0x21c>
     56c:	00f12023          	sw	a5,0(sp)
     570:	491000ef          	jal	1200 <strtok>
     574:	00012783          	lw	a5,0(sp)
     578:	04410413          	addi	s0,sp,68
     57c:	00279713          	slli	a4,a5,0x2
     580:	00e40733          	add	a4,s0,a4
     584:	00a72023          	sw	a0,0(a4)
     588:	00050a63          	beqz	a0,59c <main+0x39c>
     58c:	00178793          	addi	a5,a5,1
     590:	00800713          	li	a4,8
     594:	00000513          	li	a0,0
     598:	fce796e3          	bne	a5,a4,564 <main+0x364>
     59c:	04412783          	lw	a5,68(sp)
     5a0:	00f12023          	sw	a5,0(sp)
     5a4:	f0078ae3          	beqz	a5,4b8 <main+0x2b8>
     5a8:	00001597          	auipc	a1,0x1
     5ac:	26058593          	addi	a1,a1,608 # 1808 <_etext+0x220>
     5b0:	00078513          	mv	a0,a5
     5b4:	425000ef          	jal	11d8 <strcmp>
     5b8:	04051063          	bnez	a0,5f8 <main+0x3f8>
     5bc:	00001517          	auipc	a0,0x1
     5c0:	25450513          	addi	a0,a0,596 # 1810 <_etext+0x228>
     5c4:	029000ef          	jal	dec <printf>
     5c8:	ef1ff06f          	j	4b8 <main+0x2b8>
     5cc:	00001517          	auipc	a0,0x1
     5d0:	16450513          	addi	a0,a0,356 # 1730 <_etext+0x148>
     5d4:	019000ef          	jal	dec <printf>
     5d8:	e39ff06f          	j	410 <main+0x210>
     5dc:	00001517          	auipc	a0,0x1
     5e0:	19050513          	addi	a0,a0,400 # 176c <_etext+0x184>
     5e4:	009000ef          	jal	dec <printf>
     5e8:	e51ff06f          	j	438 <main+0x238>
     5ec:	00001517          	auipc	a0,0x1
     5f0:	1dc50513          	addi	a0,a0,476 # 17c8 <_etext+0x1e0>
     5f4:	ea5ff06f          	j	498 <main+0x298>
     5f8:	00012503          	lw	a0,0(sp)
     5fc:	00001597          	auipc	a1,0x1
     600:	21c58593          	addi	a1,a1,540 # 1818 <_etext+0x230>
     604:	3d5000ef          	jal	11d8 <strcmp>
     608:	00051663          	bnez	a0,614 <main+0x414>
     60c:	00100073          	ebreak
     610:	ea9ff06f          	j	4b8 <main+0x2b8>
     614:	00012503          	lw	a0,0(sp)
     618:	00001597          	auipc	a1,0x1
     61c:	20858593          	addi	a1,a1,520 # 1820 <_etext+0x238>
     620:	3b9000ef          	jal	11d8 <strcmp>
     624:	06051263          	bnez	a0,688 <main+0x488>
     628:	781000ef          	jal	15a8 <set_mie>
     62c:	00001517          	auipc	a0,0x1
     630:	1fc50513          	addi	a0,a0,508 # 1828 <_etext+0x240>
     634:	7b8000ef          	jal	dec <printf>
     638:	00001517          	auipc	a0,0x1
     63c:	21050513          	addi	a0,a0,528 # 1848 <_etext+0x260>
     640:	7ac000ef          	jal	dec <printf>
     644:	04812403          	lw	s0,72(sp)
     648:	02040463          	beqz	s0,670 <main+0x470>
     64c:	00040513          	mv	a0,s0
     650:	0cd000ef          	jal	f1c <xtoi>
     654:	00050493          	mv	s1,a0
     658:	00040513          	mv	a0,s0
     65c:	0c1000ef          	jal	f1c <xtoi>
     660:	000025b7          	lui	a1,0x2
     664:	00b505b3          	add	a1,a0,a1
     668:	00048513          	mv	a0,s1
     66c:	74d000ef          	jal	15b8 <reboot>
     670:	06c12083          	lw	ra,108(sp)
     674:	06812403          	lw	s0,104(sp)
     678:	06412483          	lw	s1,100(sp)
     67c:	00000513          	li	a0,0
     680:	07010113          	addi	sp,sp,112
     684:	00008067          	ret
     688:	00012503          	lw	a0,0(sp)
     68c:	00001597          	auipc	a1,0x1
     690:	1cc58593          	addi	a1,a1,460 # 1858 <_etext+0x270>
     694:	345000ef          	jal	11d8 <strcmp>
     698:	0a051263          	bnez	a0,73c <main+0x53c>
     69c:	04812483          	lw	s1,72(sp)
     6a0:	00048863          	beqz	s1,6b0 <main+0x4b0>
     6a4:	00048513          	mv	a0,s1
     6a8:	075000ef          	jal	f1c <xtoi>
     6ac:	00050493          	mv	s1,a0
     6b0:	10048413          	addi	s0,s1,256
     6b4:	00048593          	mv	a1,s1
     6b8:	00001517          	auipc	a0,0x1
     6bc:	1a850513          	addi	a0,a0,424 # 1860 <_etext+0x278>
     6c0:	72c000ef          	jal	dec <printf>
     6c4:	00000793          	li	a5,0
     6c8:	00f48733          	add	a4,s1,a5
     6cc:	00074583          	lbu	a1,0(a4)
     6d0:	00001517          	auipc	a0,0x1
     6d4:	19850513          	addi	a0,a0,408 # 1868 <_etext+0x280>
     6d8:	00f12023          	sw	a5,0(sp)
     6dc:	710000ef          	jal	dec <printf>
     6e0:	00012783          	lw	a5,0(sp)
     6e4:	01000713          	li	a4,16
     6e8:	00178793          	addi	a5,a5,1
     6ec:	fce79ee3          	bne	a5,a4,6c8 <main+0x4c8>
     6f0:	00000793          	li	a5,0
     6f4:	00f48733          	add	a4,s1,a5
     6f8:	00074503          	lbu	a0,0(a4)
     6fc:	05e00693          	li	a3,94
     700:	fe050713          	addi	a4,a0,-32
     704:	0ff77713          	zext.b	a4,a4
     708:	00e6f463          	bgeu	a3,a4,710 <main+0x510>
     70c:	02e00513          	li	a0,46
     710:	00f12023          	sw	a5,0(sp)
     714:	47c000ef          	jal	b90 <putchar>
     718:	00012783          	lw	a5,0(sp)
     71c:	01000713          	li	a4,16
     720:	00178793          	addi	a5,a5,1
     724:	fce798e3          	bne	a5,a4,6f4 <main+0x4f4>
     728:	00a00513          	li	a0,10
     72c:	01048493          	addi	s1,s1,16
     730:	460000ef          	jal	b90 <putchar>
     734:	f88490e3          	bne	s1,s0,6b4 <main+0x4b4>
     738:	d81ff06f          	j	4b8 <main+0x2b8>
     73c:	00012503          	lw	a0,0(sp)
     740:	00200613          	li	a2,2
     744:	00001597          	auipc	a1,0x1
     748:	12858593          	addi	a1,a1,296 # 186c <_etext+0x284>
     74c:	255000ef          	jal	11a0 <strncmp>
     750:	06051263          	bnez	a0,7b4 <main+0x5b4>
     754:	00012783          	lw	a5,0(sp)
     758:	0027c703          	lbu	a4,2(a5)
     75c:	06d00793          	li	a5,109
     760:	0af70663          	beq	a4,a5,80c <main+0x60c>
     764:	00100793          	li	a5,1
     768:	00f12c23          	sw	a5,24(sp)
     76c:	00200713          	li	a4,2
     770:	00178493          	addi	s1,a5,1
     774:	00279793          	slli	a5,a5,0x2
     778:	00f40433          	add	s0,s0,a5
     77c:	00042503          	lw	a0,0(s0)
     780:	00e12a23          	sw	a4,20(sp)
     784:	00000413          	li	s0,0
     788:	794000ef          	jal	f1c <xtoi>
     78c:	00a12223          	sw	a0,4(sp)
     790:	00050593          	mv	a1,a0
     794:	00001517          	auipc	a0,0x1
     798:	0cc50513          	addi	a0,a0,204 # 1860 <_etext+0x278>
     79c:	650000ef          	jal	dec <printf>
     7a0:	01812783          	lw	a5,24(sp)
     7a4:	08879063          	bne	a5,s0,824 <main+0x624>
     7a8:	00001517          	auipc	a0,0x1
     7ac:	f7050513          	addi	a0,a0,-144 # 1718 <_etext+0x130>
     7b0:	e15ff06f          	j	5c4 <main+0x3c4>
     7b4:	00012503          	lw	a0,0(sp)
     7b8:	00200613          	li	a2,2
     7bc:	00001597          	auipc	a1,0x1
     7c0:	0b458593          	addi	a1,a1,180 # 1870 <_etext+0x288>
     7c4:	1dd000ef          	jal	11a0 <strncmp>
     7c8:	f80506e3          	beqz	a0,754 <main+0x554>
     7cc:	00012503          	lw	a0,0(sp)
     7d0:	00001597          	auipc	a1,0x1
     7d4:	0a458593          	addi	a1,a1,164 # 1874 <_etext+0x28c>
     7d8:	201000ef          	jal	11d8 <strcmp>
     7dc:	1a051663          	bnez	a0,988 <main+0x788>
     7e0:	04812503          	lw	a0,72(sp)
     7e4:	00050863          	beqz	a0,7f4 <main+0x5f4>
     7e8:	734000ef          	jal	f1c <xtoi>
     7ec:	0004a783          	lw	a5,0(s1)
     7f0:	00a7a423          	sw	a0,8(a5)
     7f4:	0004a783          	lw	a5,0(s1)
     7f8:	00001517          	auipc	a0,0x1
     7fc:	08050513          	addi	a0,a0,128 # 1878 <_etext+0x290>
     800:	0087a583          	lw	a1,8(a5)
     804:	5e8000ef          	jal	dec <printf>
     808:	cb1ff06f          	j	4b8 <main+0x2b8>
     80c:	04812503          	lw	a0,72(sp)
     810:	70c000ef          	jal	f1c <xtoi>
     814:	00a12c23          	sw	a0,24(sp)
     818:	00200793          	li	a5,2
     81c:	00300713          	li	a4,3
     820:	f51ff06f          	j	770 <main+0x570>
     824:	01412703          	lw	a4,20(sp)
     828:	00012783          	lw	a5,0(sp)
     82c:	00e787b3          	add	a5,a5,a4
     830:	00f12423          	sw	a5,8(sp)
     834:	00012783          	lw	a5,0(sp)
     838:	0007c703          	lbu	a4,0(a5)
     83c:	07200793          	li	a5,114
     840:	08f71663          	bne	a4,a5,8cc <main+0x6cc>
     844:	00812783          	lw	a5,8(sp)
     848:	0007c703          	lbu	a4,0(a5)
     84c:	06200793          	li	a5,98
     850:	00f71e63          	bne	a4,a5,86c <main+0x66c>
     854:	00412783          	lw	a5,4(sp)
     858:	00001517          	auipc	a0,0x1
     85c:	01050513          	addi	a0,a0,16 # 1868 <_etext+0x280>
     860:	008787b3          	add	a5,a5,s0
     864:	0007c583          	lbu	a1,0(a5)
     868:	584000ef          	jal	dec <printf>
     86c:	00812783          	lw	a5,8(sp)
     870:	0007c703          	lbu	a4,0(a5)
     874:	07700793          	li	a5,119
     878:	02f71063          	bne	a4,a5,898 <main+0x698>
     87c:	00412703          	lw	a4,4(sp)
     880:	00141793          	slli	a5,s0,0x1
     884:	00001517          	auipc	a0,0x1
     888:	fe450513          	addi	a0,a0,-28 # 1868 <_etext+0x280>
     88c:	00e787b3          	add	a5,a5,a4
     890:	00079583          	lh	a1,0(a5)
     894:	558000ef          	jal	dec <printf>
     898:	00812783          	lw	a5,8(sp)
     89c:	0007c703          	lbu	a4,0(a5)
     8a0:	06c00793          	li	a5,108
     8a4:	02f71063          	bne	a4,a5,8c4 <main+0x6c4>
     8a8:	00412703          	lw	a4,4(sp)
     8ac:	00241793          	slli	a5,s0,0x2
     8b0:	00001517          	auipc	a0,0x1
     8b4:	fb850513          	addi	a0,a0,-72 # 1868 <_etext+0x280>
     8b8:	00e787b3          	add	a5,a5,a4
     8bc:	0007a583          	lw	a1,0(a5)
     8c0:	52c000ef          	jal	dec <printf>
     8c4:	00140413          	addi	s0,s0,1
     8c8:	ed9ff06f          	j	7a0 <main+0x5a0>
     8cc:	00148793          	addi	a5,s1,1
     8d0:	00249493          	slli	s1,s1,0x2
     8d4:	02010713          	addi	a4,sp,32
     8d8:	00f12e23          	sw	a5,28(sp)
     8dc:	04448793          	addi	a5,s1,68
     8e0:	00e784b3          	add	s1,a5,a4
     8e4:	fe04a503          	lw	a0,-32(s1)
     8e8:	634000ef          	jal	f1c <xtoi>
     8ec:	00812783          	lw	a5,8(sp)
     8f0:	00050493          	mv	s1,a0
     8f4:	0007c703          	lbu	a4,0(a5)
     8f8:	06200793          	li	a5,98
     8fc:	02f71063          	bne	a4,a5,91c <main+0x71c>
     900:	00412783          	lw	a5,4(sp)
     904:	0ff57593          	zext.b	a1,a0
     908:	008787b3          	add	a5,a5,s0
     90c:	00a78023          	sb	a0,0(a5)
     910:	00001517          	auipc	a0,0x1
     914:	f5850513          	addi	a0,a0,-168 # 1868 <_etext+0x280>
     918:	4d4000ef          	jal	dec <printf>
     91c:	00812783          	lw	a5,8(sp)
     920:	0007c703          	lbu	a4,0(a5)
     924:	07700793          	li	a5,119
     928:	02f71463          	bne	a4,a5,950 <main+0x750>
     92c:	00412703          	lw	a4,4(sp)
     930:	01049593          	slli	a1,s1,0x10
     934:	00141793          	slli	a5,s0,0x1
     938:	4105d593          	srai	a1,a1,0x10
     93c:	00e787b3          	add	a5,a5,a4
     940:	00b79023          	sh	a1,0(a5)
     944:	00001517          	auipc	a0,0x1
     948:	f2450513          	addi	a0,a0,-220 # 1868 <_etext+0x280>
     94c:	4a0000ef          	jal	dec <printf>
     950:	00812783          	lw	a5,8(sp)
     954:	0007c703          	lbu	a4,0(a5)
     958:	06c00793          	li	a5,108
     95c:	02f71263          	bne	a4,a5,980 <main+0x780>
     960:	00412703          	lw	a4,4(sp)
     964:	00241793          	slli	a5,s0,0x2
     968:	00048593          	mv	a1,s1
     96c:	00e787b3          	add	a5,a5,a4
     970:	0097a023          	sw	s1,0(a5)
     974:	00001517          	auipc	a0,0x1
     978:	ef450513          	addi	a0,a0,-268 # 1868 <_etext+0x280>
     97c:	470000ef          	jal	dec <printf>
     980:	01c12483          	lw	s1,28(sp)
     984:	f41ff06f          	j	8c4 <main+0x6c4>
     988:	00012503          	lw	a0,0(sp)
     98c:	00001597          	auipc	a1,0x1
     990:	ef858593          	addi	a1,a1,-264 # 1884 <_etext+0x29c>
     994:	045000ef          	jal	11d8 <strcmp>
     998:	02051663          	bnez	a0,9c4 <main+0x7c4>
     99c:	04812503          	lw	a0,72(sp)
     9a0:	00050863          	beqz	a0,9b0 <main+0x7b0>
     9a4:	51c000ef          	jal	ec0 <atoi>
     9a8:	0004a783          	lw	a5,0(s1)
     9ac:	00a7a623          	sw	a0,12(a5)
     9b0:	0004a783          	lw	a5,0(s1)
     9b4:	00001517          	auipc	a0,0x1
     9b8:	ed850513          	addi	a0,a0,-296 # 188c <_etext+0x2a4>
     9bc:	00c7a583          	lw	a1,12(a5)
     9c0:	e45ff06f          	j	804 <main+0x604>
     9c4:	00012503          	lw	a0,0(sp)
     9c8:	00001597          	auipc	a1,0x1
     9cc:	ed058593          	addi	a1,a1,-304 # 1898 <_etext+0x2b0>
     9d0:	009000ef          	jal	11d8 <strcmp>
     9d4:	02051663          	bnez	a0,a00 <main+0x800>
     9d8:	04812503          	lw	a0,72(sp)
     9dc:	00050863          	beqz	a0,9ec <main+0x7ec>
     9e0:	53c000ef          	jal	f1c <xtoi>
     9e4:	0004a783          	lw	a5,0(s1)
     9e8:	00a7ac23          	sw	a0,24(a5)
     9ec:	0004a783          	lw	a5,0(s1)
     9f0:	00001517          	auipc	a0,0x1
     9f4:	eb050513          	addi	a0,a0,-336 # 18a0 <_etext+0x2b8>
     9f8:	0187a583          	lw	a1,24(a5)
     9fc:	e09ff06f          	j	804 <main+0x604>
     a00:	00012503          	lw	a0,0(sp)
     a04:	00001597          	auipc	a1,0x1
     a08:	ea858593          	addi	a1,a1,-344 # 18ac <_etext+0x2c4>
     a0c:	7cc000ef          	jal	11d8 <strcmp>
     a10:	00051c63          	bnez	a0,a28 <main+0x828>
     a14:	0004a783          	lw	a5,0(s1)
     a18:	00001517          	auipc	a0,0x1
     a1c:	e9c50513          	addi	a0,a0,-356 # 18b4 <_etext+0x2cc>
     a20:	0147a583          	lw	a1,20(a5)
     a24:	de1ff06f          	j	804 <main+0x604>
     a28:	00012503          	lw	a0,0(sp)
     a2c:	00001597          	auipc	a1,0x1
     a30:	e9458593          	addi	a1,a1,-364 # 18c0 <_etext+0x2d8>
     a34:	7a4000ef          	jal	11d8 <strcmp>
     a38:	02051a63          	bnez	a0,a6c <main+0x86c>
     a3c:	04812503          	lw	a0,72(sp)
     a40:	480000ef          	jal	ec0 <atoi>
     a44:	00050413          	mv	s0,a0
     a48:	04c12503          	lw	a0,76(sp)
     a4c:	474000ef          	jal	ec0 <atoi>
     a50:	00050593          	mv	a1,a0
     a54:	00040513          	mv	a0,s0
     a58:	0d1000ef          	jal	1328 <__mulsi3>
     a5c:	00050593          	mv	a1,a0
     a60:	00001517          	auipc	a0,0x1
     a64:	e6450513          	addi	a0,a0,-412 # 18c4 <_etext+0x2dc>
     a68:	d9dff06f          	j	804 <main+0x604>
     a6c:	00012503          	lw	a0,0(sp)
     a70:	00001597          	auipc	a1,0x1
     a74:	e6058593          	addi	a1,a1,-416 # 18d0 <_etext+0x2e8>
     a78:	760000ef          	jal	11d8 <strcmp>
     a7c:	04051863          	bnez	a0,acc <main+0x8cc>
     a80:	04812503          	lw	a0,72(sp)
     a84:	43c000ef          	jal	ec0 <atoi>
     a88:	00050413          	mv	s0,a0
     a8c:	04c12503          	lw	a0,76(sp)
     a90:	430000ef          	jal	ec0 <atoi>
     a94:	00050593          	mv	a1,a0
     a98:	00a12223          	sw	a0,4(sp)
     a9c:	00040513          	mv	a0,s0
     aa0:	1c5000ef          	jal	1464 <__modsi3>
     aa4:	00412583          	lw	a1,4(sp)
     aa8:	00a12023          	sw	a0,0(sp)
     aac:	00040513          	mv	a0,s0
     ab0:	1ad000ef          	jal	145c <__divsi3>
     ab4:	00012603          	lw	a2,0(sp)
     ab8:	00050593          	mv	a1,a0
     abc:	00001517          	auipc	a0,0x1
     ac0:	e1850513          	addi	a0,a0,-488 # 18d4 <_etext+0x2ec>
     ac4:	328000ef          	jal	dec <printf>
     ac8:	9f1ff06f          	j	4b8 <main+0x2b8>
     acc:	00012503          	lw	a0,0(sp)
     ad0:	00001597          	auipc	a1,0x1
     ad4:	e1858593          	addi	a1,a1,-488 # 18e8 <_etext+0x300>
     ad8:	700000ef          	jal	11d8 <strcmp>
     adc:	04051663          	bnez	a0,b28 <main+0x928>
     ae0:	04812503          	lw	a0,72(sp)
     ae4:	3dc000ef          	jal	ec0 <atoi>
     ae8:	00050413          	mv	s0,a0
     aec:	04c12503          	lw	a0,76(sp)
     af0:	3d0000ef          	jal	ec0 <atoi>
     af4:	00050493          	mv	s1,a0
     af8:	05012503          	lw	a0,80(sp)
     afc:	3c4000ef          	jal	ec0 <atoi>
     b00:	01051613          	slli	a2,a0,0x10
     b04:	01049593          	slli	a1,s1,0x10
     b08:	4105d593          	srai	a1,a1,0x10
     b0c:	41065613          	srai	a2,a2,0x10
     b10:	00040513          	mv	a0,s0
     b14:	1a1000ef          	jal	14b4 <mac>
     b18:	00050593          	mv	a1,a0
     b1c:	00001517          	auipc	a0,0x1
     b20:	dd050513          	addi	a0,a0,-560 # 18ec <_etext+0x304>
     b24:	ce1ff06f          	j	804 <main+0x604>
     b28:	00012503          	lw	a0,0(sp)
     b2c:	00001597          	auipc	a1,0x1
     b30:	dcc58593          	addi	a1,a1,-564 # 18f8 <_etext+0x310>
     b34:	6a4000ef          	jal	11d8 <strcmp>
     b38:	02051063          	bnez	a0,b58 <main+0x958>
     b3c:	04812503          	lw	a0,72(sp)
     b40:	3dc000ef          	jal	f1c <xtoi>
     b44:	00050593          	mv	a1,a0
     b48:	40155613          	srai	a2,a0,0x1
     b4c:	00001517          	auipc	a0,0x1
     b50:	db450513          	addi	a0,a0,-588 # 1900 <_etext+0x318>
     b54:	f71ff06f          	j	ac4 <main+0x8c4>
     b58:	00012783          	lw	a5,0(sp)
     b5c:	0007c783          	lbu	a5,0(a5)
     b60:	94078ce3          	beqz	a5,4b8 <main+0x2b8>
     b64:	00012583          	lw	a1,0(sp)
     b68:	00001517          	auipc	a0,0x1
     b6c:	dac50513          	addi	a0,a0,-596 # 1914 <_etext+0x32c>
     b70:	c95ff06f          	j	804 <main+0x604>

00000b74 <getchar>:
     b74:	00001717          	auipc	a4,0x1
     b78:	22872703          	lw	a4,552(a4) # 1d9c <io>
     b7c:	00474783          	lbu	a5,4(a4)
     b80:	0027f793          	andi	a5,a5,2
     b84:	fe078ce3          	beqz	a5,b7c <getchar+0x8>
     b88:	00574503          	lbu	a0,5(a4)
     b8c:	00008067          	ret

00000b90 <putchar>:
     b90:	00a00713          	li	a4,10
     b94:	00001797          	auipc	a5,0x1
     b98:	2087a783          	lw	a5,520(a5) # 1d9c <io>
     b9c:	00e51c63          	bne	a0,a4,bb4 <putchar+0x24>
     ba0:	0047c703          	lbu	a4,4(a5)
     ba4:	00177713          	andi	a4,a4,1
     ba8:	fe071ce3          	bnez	a4,ba0 <putchar+0x10>
     bac:	00d00713          	li	a4,13
     bb0:	00e782a3          	sb	a4,5(a5)
     bb4:	0047c703          	lbu	a4,4(a5)
     bb8:	00177713          	andi	a4,a4,1
     bbc:	fe071ce3          	bnez	a4,bb4 <putchar+0x24>
     bc0:	00a782a3          	sb	a0,5(a5)
     bc4:	0ff57513          	zext.b	a0,a0
     bc8:	00008067          	ret

00000bcc <gets>:
     bcc:	fe810113          	addi	sp,sp,-24
     bd0:	00812823          	sw	s0,16(sp)
     bd4:	00912623          	sw	s1,12(sp)
     bd8:	00112a23          	sw	ra,20(sp)
     bdc:	00050413          	mv	s0,a0
     be0:	00050493          	mv	s1,a0
     be4:	fff58593          	addi	a1,a1,-1
     be8:	00b12023          	sw	a1,0(sp)
     bec:	02059a63          	bnez	a1,c20 <gets+0x54>
     bf0:	00a00513          	li	a0,10
     bf4:	f9dff0ef          	jal	b90 <putchar>
     bf8:	40940533          	sub	a0,s0,s1
     bfc:	00a03533          	snez	a0,a0
     c00:	00048023          	sb	zero,0(s1)
     c04:	40a00533          	neg	a0,a0
     c08:	01412083          	lw	ra,20(sp)
     c0c:	00a47533          	and	a0,s0,a0
     c10:	01012403          	lw	s0,16(sp)
     c14:	00c12483          	lw	s1,12(sp)
     c18:	01810113          	addi	sp,sp,24
     c1c:	00008067          	ret
     c20:	00b12223          	sw	a1,4(sp)
     c24:	f51ff0ef          	jal	b74 <getchar>
     c28:	ff350693          	addi	a3,a0,-13
     c2c:	fc0682e3          	beqz	a3,bf0 <gets+0x24>
     c30:	ff650693          	addi	a3,a0,-10
     c34:	fa068ee3          	beqz	a3,bf0 <gets+0x24>
     c38:	00a12423          	sw	a0,8(sp)
     c3c:	f55ff0ef          	jal	b90 <putchar>
     c40:	00812703          	lw	a4,8(sp)
     c44:	00800693          	li	a3,8
     c48:	00412583          	lw	a1,4(sp)
     c4c:	00d71c63          	bne	a4,a3,c64 <gets+0x98>
     c50:	f8940ae3          	beq	s0,s1,be4 <gets+0x18>
     c54:	fe048fa3          	sb	zero,-1(s1)
     c58:	00012583          	lw	a1,0(sp)
     c5c:	fff48493          	addi	s1,s1,-1
     c60:	fc1ff06f          	j	c20 <gets+0x54>
     c64:	00e48023          	sb	a4,0(s1)
     c68:	00148493          	addi	s1,s1,1
     c6c:	f79ff06f          	j	be4 <gets+0x18>

00000c70 <putstr>:
     c70:	ff810113          	addi	sp,sp,-8
     c74:	00812023          	sw	s0,0(sp)
     c78:	00112223          	sw	ra,4(sp)
     c7c:	00050413          	mv	s0,a0
     c80:	00051663          	bnez	a0,c8c <putstr+0x1c>
     c84:	00001417          	auipc	s0,0x1
     c88:	db040413          	addi	s0,s0,-592 # 1a34 <_etext+0x44c>
     c8c:	00044503          	lbu	a0,0(s0)
     c90:	00051a63          	bnez	a0,ca4 <putstr+0x34>
     c94:	00412083          	lw	ra,4(sp)
     c98:	00012403          	lw	s0,0(sp)
     c9c:	00810113          	addi	sp,sp,8
     ca0:	00008067          	ret
     ca4:	00140413          	addi	s0,s0,1
     ca8:	ee9ff0ef          	jal	b90 <putchar>
     cac:	fe1ff06f          	j	c8c <putstr+0x1c>

00000cb0 <puts>:
     cb0:	ffc10113          	addi	sp,sp,-4
     cb4:	00112023          	sw	ra,0(sp)
     cb8:	fb9ff0ef          	jal	c70 <putstr>
     cbc:	00012083          	lw	ra,0(sp)
     cc0:	00a00513          	li	a0,10
     cc4:	00410113          	addi	sp,sp,4
     cc8:	ec9ff06f          	j	b90 <putchar>

00000ccc <putnum>:
     ccc:	fb810113          	addi	sp,sp,-72
     cd0:	04812023          	sw	s0,64(sp)
     cd4:	00b12023          	sw	a1,0(sp)
     cd8:	00050413          	mv	s0,a0
     cdc:	01100613          	li	a2,17
     ce0:	00001597          	auipc	a1,0x1
     ce4:	d5c58593          	addi	a1,a1,-676 # 1a3c <_etext+0x454>
     ce8:	00810513          	addi	a0,sp,8
     cec:	04112223          	sw	ra,68(sp)
     cf0:	02912e23          	sw	s1,60(sp)
     cf4:	590000ef          	jal	1284 <memcpy>
     cf8:	00045e63          	bgez	s0,d14 <putnum+0x48>
     cfc:	00012783          	lw	a5,0(sp)
     d00:	ff678793          	addi	a5,a5,-10
     d04:	00079863          	bnez	a5,d14 <putnum+0x48>
     d08:	02d00513          	li	a0,45
     d0c:	e85ff0ef          	jal	b90 <putchar>
     d10:	40800433          	neg	s0,s0
     d14:	00000493          	li	s1,0
     d18:	00012583          	lw	a1,0(sp)
     d1c:	00148713          	addi	a4,s1,1
     d20:	00040513          	mv	a0,s0
     d24:	00e12223          	sw	a4,4(sp)
     d28:	6b0000ef          	jal	13d8 <__umodsi3>
     d2c:	00810713          	addi	a4,sp,8
     d30:	03450793          	addi	a5,a0,52
     d34:	00e78533          	add	a0,a5,a4
     d38:	fcc54603          	lbu	a2,-52(a0)
     d3c:	03448793          	addi	a5,s1,52
     d40:	00012583          	lw	a1,0(sp)
     d44:	00e786b3          	add	a3,a5,a4
     d48:	fec68023          	sb	a2,-32(a3)
     d4c:	00040513          	mv	a0,s0
     d50:	680000ef          	jal	13d0 <__udivsi3>
     d54:	00012783          	lw	a5,0(sp)
     d58:	00a00693          	li	a3,10
     d5c:	00412703          	lw	a4,4(sp)
     d60:	00050413          	mv	s0,a0
     d64:	06d78263          	beq	a5,a3,dc8 <putnum+0xfc>
     d68:	00012583          	lw	a1,0(sp)
     d6c:	03470793          	addi	a5,a4,52
     d70:	00810713          	addi	a4,sp,8
     d74:	00e78733          	add	a4,a5,a4
     d78:	00e12223          	sw	a4,4(sp)
     d7c:	65c000ef          	jal	13d8 <__umodsi3>
     d80:	03450793          	addi	a5,a0,52
     d84:	00810713          	addi	a4,sp,8
     d88:	00e78533          	add	a0,a5,a4
     d8c:	fcc54683          	lbu	a3,-52(a0)
     d90:	00412703          	lw	a4,4(sp)
     d94:	00012583          	lw	a1,0(sp)
     d98:	00040513          	mv	a0,s0
     d9c:	fed70023          	sb	a3,-32(a4)
     da0:	630000ef          	jal	13d0 <__udivsi3>
     da4:	00248493          	addi	s1,s1,2
     da8:	00050413          	mv	s0,a0
     dac:	f60416e3          	bnez	s0,d18 <putnum+0x4c>
     db0:	02049063          	bnez	s1,dd0 <putnum+0x104>
     db4:	04412083          	lw	ra,68(sp)
     db8:	04012403          	lw	s0,64(sp)
     dbc:	03c12483          	lw	s1,60(sp)
     dc0:	04810113          	addi	sp,sp,72
     dc4:	00008067          	ret
     dc8:	00070493          	mv	s1,a4
     dcc:	fe1ff06f          	j	dac <putnum+0xe0>
     dd0:	fff48493          	addi	s1,s1,-1
     dd4:	03448793          	addi	a5,s1,52
     dd8:	00810713          	addi	a4,sp,8
     ddc:	00e78733          	add	a4,a5,a4
     de0:	fe074503          	lbu	a0,-32(a4)
     de4:	dadff0ef          	jal	b90 <putchar>
     de8:	fc9ff06f          	j	db0 <putnum+0xe4>

00000dec <printf>:
     dec:	fdc10113          	addi	sp,sp,-36
     df0:	02f12023          	sw	a5,32(sp)
     df4:	01010793          	addi	a5,sp,16
     df8:	00812423          	sw	s0,8(sp)
     dfc:	00112623          	sw	ra,12(sp)
     e00:	00912223          	sw	s1,4(sp)
     e04:	00050413          	mv	s0,a0
     e08:	00b12823          	sw	a1,16(sp)
     e0c:	00c12a23          	sw	a2,20(sp)
     e10:	00d12c23          	sw	a3,24(sp)
     e14:	00e12e23          	sw	a4,28(sp)
     e18:	00f12023          	sw	a5,0(sp)
     e1c:	00044503          	lbu	a0,0(s0)
     e20:	00051c63          	bnez	a0,e38 <printf+0x4c>
     e24:	00c12083          	lw	ra,12(sp)
     e28:	00812403          	lw	s0,8(sp)
     e2c:	00412483          	lw	s1,4(sp)
     e30:	02410113          	addi	sp,sp,36
     e34:	00008067          	ret
     e38:	02500793          	li	a5,37
     e3c:	06f51e63          	bne	a0,a5,eb8 <printf+0xcc>
     e40:	00144503          	lbu	a0,1(s0)
     e44:	07300793          	li	a5,115
     e48:	00140493          	addi	s1,s0,1
     e4c:	02f51263          	bne	a0,a5,e70 <printf+0x84>
     e50:	00012783          	lw	a5,0(sp)
     e54:	0007a503          	lw	a0,0(a5)
     e58:	00478713          	addi	a4,a5,4
     e5c:	00e12023          	sw	a4,0(sp)
     e60:	e11ff0ef          	jal	c70 <putstr>
     e64:	00048413          	mv	s0,s1
     e68:	00140413          	addi	s0,s0,1
     e6c:	fb1ff06f          	j	e1c <printf+0x30>
     e70:	07800793          	li	a5,120
     e74:	02f51063          	bne	a0,a5,e94 <printf+0xa8>
     e78:	00012783          	lw	a5,0(sp)
     e7c:	01000593          	li	a1,16
     e80:	00478713          	addi	a4,a5,4
     e84:	00e12023          	sw	a4,0(sp)
     e88:	0007a503          	lw	a0,0(a5)
     e8c:	e41ff0ef          	jal	ccc <putnum>
     e90:	fd5ff06f          	j	e64 <printf+0x78>
     e94:	06400793          	li	a5,100
     e98:	00f51c63          	bne	a0,a5,eb0 <printf+0xc4>
     e9c:	00012783          	lw	a5,0(sp)
     ea0:	00a00593          	li	a1,10
     ea4:	00478713          	addi	a4,a5,4
     ea8:	00e12023          	sw	a4,0(sp)
     eac:	fddff06f          	j	e88 <printf+0x9c>
     eb0:	ce1ff0ef          	jal	b90 <putchar>
     eb4:	fb1ff06f          	j	e64 <printf+0x78>
     eb8:	cd9ff0ef          	jal	b90 <putchar>
     ebc:	fadff06f          	j	e68 <printf+0x7c>

00000ec0 <atoi>:
     ec0:	00050693          	mv	a3,a0
     ec4:	04051063          	bnez	a0,f04 <atoi+0x44>
     ec8:	00000513          	li	a0,0
     ecc:	00008067          	ret
     ed0:	02b78663          	beq	a5,a1,efc <atoi+0x3c>
     ed4:	fd078793          	addi	a5,a5,-48
     ed8:	00351713          	slli	a4,a0,0x3
     edc:	00e78733          	add	a4,a5,a4
     ee0:	00151793          	slli	a5,a0,0x1
     ee4:	00f70533          	add	a0,a4,a5
     ee8:	00168693          	addi	a3,a3,1
     eec:	0006c783          	lbu	a5,0(a3)
     ef0:	fe0790e3          	bnez	a5,ed0 <atoi+0x10>
     ef4:	02061063          	bnez	a2,f14 <atoi+0x54>
     ef8:	00008067          	ret
     efc:	00100613          	li	a2,1
     f00:	fe9ff06f          	j	ee8 <atoi+0x28>
     f04:	00000613          	li	a2,0
     f08:	00000513          	li	a0,0
     f0c:	02d00593          	li	a1,45
     f10:	fddff06f          	j	eec <atoi+0x2c>
     f14:	40a00533          	neg	a0,a0
     f18:	00008067          	ret

00000f1c <xtoi>:
     f1c:	00050693          	mv	a3,a0
     f20:	00000513          	li	a0,0
     f24:	02069a63          	bnez	a3,f58 <xtoi+0x3c>
     f28:	00008067          	ret
     f2c:	00451713          	slli	a4,a0,0x4
     f30:	00f66e63          	bltu	a2,a5,f4c <xtoi+0x30>
     f34:	fd078793          	addi	a5,a5,-48
     f38:	00e78533          	add	a0,a5,a4
     f3c:	00168693          	addi	a3,a3,1
     f40:	0006c783          	lbu	a5,0(a3)
     f44:	fe0794e3          	bnez	a5,f2c <xtoi+0x10>
     f48:	00008067          	ret
     f4c:	05f7f793          	andi	a5,a5,95
     f50:	fc978793          	addi	a5,a5,-55
     f54:	fe5ff06f          	j	f38 <xtoi+0x1c>
     f58:	03900613          	li	a2,57
     f5c:	fe5ff06f          	j	f40 <xtoi+0x24>

00000f60 <board_name>:
     f60:	01400793          	li	a5,20
     f64:	00a7ee63          	bltu	a5,a0,f80 <board_name+0x20>
     f68:	00251513          	slli	a0,a0,0x2
     f6c:	00001797          	auipc	a5,0x1
     f70:	db878793          	addi	a5,a5,-584 # 1d24 <CSWTCH.10>
     f74:	00a787b3          	add	a5,a5,a0
     f78:	0007a503          	lw	a0,0(a5)
     f7c:	00008067          	ret
     f80:	00001517          	auipc	a0,0x1
     f84:	ad050513          	addi	a0,a0,-1328 # 1a50 <_etext+0x468>
     f88:	00008067          	ret

00000f8c <irq_handler>:
     f8c:	ff010113          	addi	sp,sp,-16
     f90:	00f12023          	sw	a5,0(sp)
     f94:	00001797          	auipc	a5,0x1
     f98:	e087a783          	lw	a5,-504(a5) # 1d9c <io>
     f9c:	00e12223          	sw	a4,4(sp)
     fa0:	00c12623          	sw	a2,12(sp)
     fa4:	00d12423          	sw	a3,8(sp)
     fa8:	0037c683          	lbu	a3,3(a5)
     fac:	08000713          	li	a4,128
     fb0:	02e69863          	bne	a3,a4,fe0 <irq_handler+0x54>
     fb4:	00001717          	auipc	a4,0x1
     fb8:	de072703          	lw	a4,-544(a4) # 1d94 <utimers>
     fbc:	fff70693          	addi	a3,a4,-1
     fc0:	00001617          	auipc	a2,0x1
     fc4:	dcd62a23          	sw	a3,-556(a2) # 1d94 <utimers>
     fc8:	00071863          	bnez	a4,fd8 <irq_handler+0x4c>
     fcc:	06300713          	li	a4,99
     fd0:	00001697          	auipc	a3,0x1
     fd4:	dce6a223          	sw	a4,-572(a3) # 1d94 <utimers>
     fd8:	f8000713          	li	a4,-128
     fdc:	00e781a3          	sb	a4,3(a5)
     fe0:	00c12603          	lw	a2,12(sp)
     fe4:	00812683          	lw	a3,8(sp)
     fe8:	00412703          	lw	a4,4(sp)
     fec:	00012783          	lw	a5,0(sp)
     ff0:	01010113          	addi	sp,sp,16
     ff4:	30200073          	mret

00000ff8 <dbg_handler>:
     ff8:	fd410113          	addi	sp,sp,-44
     ffc:	00b12a23          	sw	a1,20(sp)
    1000:	00c12823          	sw	a2,16(sp)
    1004:	00d12623          	sw	a3,12(sp)
    1008:	02112423          	sw	ra,40(sp)
    100c:	02512223          	sw	t0,36(sp)
    1010:	02612023          	sw	t1,32(sp)
    1014:	00712e23          	sw	t2,28(sp)
    1018:	00e12423          	sw	a4,8(sp)
    101c:	00f12223          	sw	a5,4(sp)
    1020:	00a12c23          	sw	a0,24(sp)
    1024:	4c0000ef          	jal	14e4 <get_scause>
    1028:	00a12023          	sw	a0,0(sp)
    102c:	4f4000ef          	jal	1520 <get_sepc>
    1030:	00012603          	lw	a2,0(sp)
    1034:	00050593          	mv	a1,a0
    1038:	00001697          	auipc	a3,0x1
    103c:	a2068693          	addi	a3,a3,-1504 # 1a58 <_etext+0x470>
    1040:	02060663          	beqz	a2,106c <dbg_handler+0x74>
    1044:	fff60793          	addi	a5,a2,-1
    1048:	00600713          	li	a4,6
    104c:	00001697          	auipc	a3,0x1
    1050:	a0468693          	addi	a3,a3,-1532 # 1a50 <_etext+0x468>
    1054:	00f76c63          	bltu	a4,a5,106c <dbg_handler+0x74>
    1058:	00279793          	slli	a5,a5,0x2
    105c:	00001717          	auipc	a4,0x1
    1060:	cc870713          	addi	a4,a4,-824 # 1d24 <CSWTCH.10>
    1064:	00f707b3          	add	a5,a4,a5
    1068:	0547a683          	lw	a3,84(a5)
    106c:	00001517          	auipc	a0,0x1
    1070:	a0850513          	addi	a0,a0,-1528 # 1a74 <_etext+0x48c>
    1074:	d79ff0ef          	jal	dec <printf>
    1078:	4a8000ef          	jal	1520 <get_sepc>
    107c:	00450513          	addi	a0,a0,4
    1080:	520000ef          	jal	15a0 <set_sepc>
    1084:	02812083          	lw	ra,40(sp)
    1088:	02412283          	lw	t0,36(sp)
    108c:	02012303          	lw	t1,32(sp)
    1090:	01c12383          	lw	t2,28(sp)
    1094:	01812503          	lw	a0,24(sp)
    1098:	01412583          	lw	a1,20(sp)
    109c:	01012603          	lw	a2,16(sp)
    10a0:	00c12683          	lw	a3,12(sp)
    10a4:	00812703          	lw	a4,8(sp)
    10a8:	00412783          	lw	a5,4(sp)
    10ac:	02c10113          	addi	sp,sp,44
    10b0:	10200073          	sret

000010b4 <time>:
    10b4:	00001797          	auipc	a5,0x1
    10b8:	ce87a783          	lw	a5,-792(a5) # 1d9c <io>
    10bc:	ff810113          	addi	sp,sp,-8
    10c0:	00812023          	sw	s0,0(sp)
    10c4:	00050413          	mv	s0,a0
    10c8:	0107a503          	lw	a0,16(a5)
    10cc:	000f45b7          	lui	a1,0xf4
    10d0:	24058593          	addi	a1,a1,576 # f4240 <_global+0xf1cac>
    10d4:	00112223          	sw	ra,4(sp)
    10d8:	2f8000ef          	jal	13d0 <__udivsi3>
    10dc:	00040463          	beqz	s0,10e4 <time+0x30>
    10e0:	00a42023          	sw	a0,0(s0)
    10e4:	00412083          	lw	ra,4(sp)
    10e8:	00012403          	lw	s0,0(sp)
    10ec:	00810113          	addi	sp,sp,8
    10f0:	00008067          	ret

000010f4 <clock>:
    10f4:	00001797          	auipc	a5,0x1
    10f8:	ca87a783          	lw	a5,-856(a5) # 1d9c <io>
    10fc:	0107a503          	lw	a0,16(a5)
    1100:	00008067          	ret

00001104 <gettimeofday>:
    1104:	00001797          	auipc	a5,0x1
    1108:	c987a783          	lw	a5,-872(a5) # 1d9c <io>
    110c:	ff410113          	addi	sp,sp,-12
    1110:	00912023          	sw	s1,0(sp)
    1114:	0107a483          	lw	s1,16(a5)
    1118:	00112423          	sw	ra,8(sp)
    111c:	00812223          	sw	s0,4(sp)
    1120:	04050463          	beqz	a0,1168 <gettimeofday+0x64>
    1124:	000f45b7          	lui	a1,0xf4
    1128:	00050413          	mv	s0,a0
    112c:	24058593          	addi	a1,a1,576 # f4240 <_global+0xf1cac>
    1130:	00048513          	mv	a0,s1
    1134:	29c000ef          	jal	13d0 <__udivsi3>
    1138:	000f45b7          	lui	a1,0xf4
    113c:	00a42023          	sw	a0,0(s0)
    1140:	24058593          	addi	a1,a1,576 # f4240 <_global+0xf1cac>
    1144:	00048513          	mv	a0,s1
    1148:	290000ef          	jal	13d8 <__umodsi3>
    114c:	00a42223          	sw	a0,4(s0)
    1150:	00000513          	li	a0,0
    1154:	00812083          	lw	ra,8(sp)
    1158:	00412403          	lw	s0,4(sp)
    115c:	00012483          	lw	s1,0(sp)
    1160:	00c10113          	addi	sp,sp,12
    1164:	00008067          	ret
    1168:	fff00513          	li	a0,-1
    116c:	fe9ff06f          	j	1154 <gettimeofday+0x50>

00001170 <strncpy>:
    1170:	fff60613          	addi	a2,a2,-1
    1174:	00000793          	li	a5,0
    1178:	00c78e63          	beq	a5,a2,1194 <strncpy+0x24>
    117c:	00f58733          	add	a4,a1,a5
    1180:	00074703          	lbu	a4,0(a4)
    1184:	00f506b3          	add	a3,a0,a5
    1188:	00178793          	addi	a5,a5,1
    118c:	00e68023          	sb	a4,0(a3)
    1190:	fe0714e3          	bnez	a4,1178 <strncpy+0x8>
    1194:	00008067          	ret

00001198 <strcpy>:
    1198:	fff00613          	li	a2,-1
    119c:	fd5ff06f          	j	1170 <strncpy>

000011a0 <strncmp>:
    11a0:	fff60613          	addi	a2,a2,-1
    11a4:	00000793          	li	a5,0
    11a8:	00f50733          	add	a4,a0,a5
    11ac:	00074303          	lbu	t1,0(a4)
    11b0:	00f58733          	add	a4,a1,a5
    11b4:	00074683          	lbu	a3,0(a4)
    11b8:	40d30733          	sub	a4,t1,a3
    11bc:	00c78a63          	beq	a5,a2,11d0 <strncmp+0x30>
    11c0:	00030863          	beqz	t1,11d0 <strncmp+0x30>
    11c4:	00178793          	addi	a5,a5,1
    11c8:	00068463          	beqz	a3,11d0 <strncmp+0x30>
    11cc:	fc070ee3          	beqz	a4,11a8 <strncmp+0x8>
    11d0:	00070513          	mv	a0,a4
    11d4:	00008067          	ret

000011d8 <strcmp>:
    11d8:	fff00613          	li	a2,-1
    11dc:	fc5ff06f          	j	11a0 <strncmp>

000011e0 <strlen>:
    11e0:	00050793          	mv	a5,a0
    11e4:	00078663          	beqz	a5,11f0 <strlen+0x10>
    11e8:	0007c703          	lbu	a4,0(a5)
    11ec:	00071663          	bnez	a4,11f8 <strlen+0x18>
    11f0:	40a78533          	sub	a0,a5,a0
    11f4:	00008067          	ret
    11f8:	00178793          	addi	a5,a5,1
    11fc:	fe9ff06f          	j	11e4 <strlen+0x4>

00001200 <strtok>:
    1200:	fec10113          	addi	sp,sp,-20
    1204:	00912423          	sw	s1,8(sp)
    1208:	00112823          	sw	ra,16(sp)
    120c:	00812623          	sw	s0,12(sp)
    1210:	00050493          	mv	s1,a0
    1214:	00051863          	bnez	a0,1224 <strtok+0x24>
    1218:	00001497          	auipc	s1,0x1
    121c:	b804a483          	lw	s1,-1152(s1) # 1d98 <nxt.0>
    1220:	04048263          	beqz	s1,1264 <strtok+0x64>
    1224:	00058513          	mv	a0,a1
    1228:	00b12023          	sw	a1,0(sp)
    122c:	fb5ff0ef          	jal	11e0 <strlen>
    1230:	00a12223          	sw	a0,4(sp)
    1234:	00048413          	mv	s0,s1
    1238:	00044703          	lbu	a4,0(s0)
    123c:	02070063          	beqz	a4,125c <strtok+0x5c>
    1240:	00412603          	lw	a2,4(sp)
    1244:	00012583          	lw	a1,0(sp)
    1248:	00040513          	mv	a0,s0
    124c:	f55ff0ef          	jal	11a0 <strncmp>
    1250:	00140713          	addi	a4,s0,1
    1254:	02051463          	bnez	a0,127c <strtok+0x7c>
    1258:	00040023          	sb	zero,0(s0)
    125c:	00001797          	auipc	a5,0x1
    1260:	b2e7ae23          	sw	a4,-1220(a5) # 1d98 <nxt.0>
    1264:	01012083          	lw	ra,16(sp)
    1268:	00c12403          	lw	s0,12(sp)
    126c:	00048513          	mv	a0,s1
    1270:	00812483          	lw	s1,8(sp)
    1274:	01410113          	addi	sp,sp,20
    1278:	00008067          	ret
    127c:	00070413          	mv	s0,a4
    1280:	fb9ff06f          	j	1238 <strtok+0x38>

00001284 <memcpy>:
    1284:	00000793          	li	a5,0
    1288:	00c79463          	bne	a5,a2,1290 <memcpy+0xc>
    128c:	00008067          	ret
    1290:	00f58733          	add	a4,a1,a5
    1294:	00074683          	lbu	a3,0(a4)
    1298:	00f50733          	add	a4,a0,a5
    129c:	00178793          	addi	a5,a5,1
    12a0:	00d70023          	sb	a3,0(a4)
    12a4:	fe5ff06f          	j	1288 <memcpy+0x4>

000012a8 <memcmp>:
    12a8:	00c58633          	add	a2,a1,a2
    12ac:	00c59663          	bne	a1,a2,12b8 <memcmp+0x10>
    12b0:	00000513          	li	a0,0
    12b4:	00008067          	ret
    12b8:	00054703          	lbu	a4,0(a0)
    12bc:	0005c783          	lbu	a5,0(a1)
    12c0:	00158593          	addi	a1,a1,1
    12c4:	fef718e3          	bne	a4,a5,12b4 <memcmp+0xc>
    12c8:	00150513          	addi	a0,a0,1
    12cc:	fe1ff06f          	j	12ac <memcmp+0x4>

000012d0 <memset>:
    12d0:	00c50633          	add	a2,a0,a2
    12d4:	00050793          	mv	a5,a0
    12d8:	00c79463          	bne	a5,a2,12e0 <memset+0x10>
    12dc:	00008067          	ret
    12e0:	00178793          	addi	a5,a5,1
    12e4:	feb78fa3          	sb	a1,-1(a5)
    12e8:	ff1ff06f          	j	12d8 <memset+0x8>

000012ec <__umulsi3>:
    12ec:	00050793          	mv	a5,a0
    12f0:	00b56863          	bltu	a0,a1,1300 <__umulsi3+0x14>
    12f4:	00058713          	mv	a4,a1
    12f8:	00070793          	mv	a5,a4
    12fc:	00050593          	mv	a1,a0
    1300:	00000513          	li	a0,0
    1304:	01c0006f          	j	1320 <__umulsi3+0x34>
    1308:	01f79693          	slli	a3,a5,0x1f
    130c:	41f6d713          	srai	a4,a3,0x1f
    1310:	00b77733          	and	a4,a4,a1
    1314:	00e50533          	add	a0,a0,a4
    1318:	00159593          	slli	a1,a1,0x1
    131c:	0017d793          	srli	a5,a5,0x1
    1320:	fe0794e3          	bnez	a5,1308 <__umulsi3+0x1c>
    1324:	00008067          	ret

00001328 <__mulsi3>:
    1328:	ff410113          	addi	sp,sp,-12
    132c:	00912023          	sw	s1,0(sp)
    1330:	00112423          	sw	ra,8(sp)
    1334:	00812223          	sw	s0,4(sp)
    1338:	00000493          	li	s1,0
    133c:	00055663          	bgez	a0,1348 <__mulsi3+0x20>
    1340:	40a00533          	neg	a0,a0
    1344:	00100493          	li	s1,1
    1348:	00000413          	li	s0,0
    134c:	0005d663          	bgez	a1,1358 <__mulsi3+0x30>
    1350:	40b005b3          	neg	a1,a1
    1354:	00100413          	li	s0,1
    1358:	f95ff0ef          	jal	12ec <__umulsi3>
    135c:	00848463          	beq	s1,s0,1364 <__mulsi3+0x3c>
    1360:	40a00533          	neg	a0,a0
    1364:	00812083          	lw	ra,8(sp)
    1368:	00412403          	lw	s0,4(sp)
    136c:	00012483          	lw	s1,0(sp)
    1370:	00c10113          	addi	sp,sp,12
    1374:	00008067          	ret

00001378 <__udiv_umod_si3>:
    1378:	00100793          	li	a5,1
    137c:	00059a63          	bnez	a1,1390 <__udiv_umod_si3+0x18>
    1380:	00058513          	mv	a0,a1
    1384:	00008067          	ret
    1388:	00179793          	slli	a5,a5,0x1
    138c:	00159593          	slli	a1,a1,0x1
    1390:	00a5f463          	bgeu	a1,a0,1398 <__udiv_umod_si3+0x20>
    1394:	fe05dae3          	bgez	a1,1388 <__udiv_umod_si3+0x10>
    1398:	00058713          	mv	a4,a1
    139c:	00000693          	li	a3,0
    13a0:	00050593          	mv	a1,a0
    13a4:	00058463          	beqz	a1,13ac <__udiv_umod_si3+0x34>
    13a8:	00079863          	bnez	a5,13b8 <__udiv_umod_si3+0x40>
    13ac:	fc060ae3          	beqz	a2,1380 <__udiv_umod_si3+0x8>
    13b0:	00068593          	mv	a1,a3
    13b4:	fcdff06f          	j	1380 <__udiv_umod_si3+0x8>
    13b8:	00e5e663          	bltu	a1,a4,13c4 <__udiv_umod_si3+0x4c>
    13bc:	40e585b3          	sub	a1,a1,a4
    13c0:	00f686b3          	add	a3,a3,a5
    13c4:	0017d793          	srli	a5,a5,0x1
    13c8:	00175713          	srli	a4,a4,0x1
    13cc:	fd9ff06f          	j	13a4 <__udiv_umod_si3+0x2c>

000013d0 <__udivsi3>:
    13d0:	00100613          	li	a2,1
    13d4:	fa5ff06f          	j	1378 <__udiv_umod_si3>

000013d8 <__umodsi3>:
    13d8:	00000613          	li	a2,0
    13dc:	f9dff06f          	j	1378 <__udiv_umod_si3>

000013e0 <__div_mod_si3>:
    13e0:	06058a63          	beqz	a1,1454 <__div_mod_si3+0x74>
    13e4:	ff010113          	addi	sp,sp,-16
    13e8:	00912223          	sw	s1,4(sp)
    13ec:	00112623          	sw	ra,12(sp)
    13f0:	00812423          	sw	s0,8(sp)
    13f4:	00000493          	li	s1,0
    13f8:	00055663          	bgez	a0,1404 <__div_mod_si3+0x24>
    13fc:	40a00533          	neg	a0,a0
    1400:	00100493          	li	s1,1
    1404:	00000793          	li	a5,0
    1408:	0005d663          	bgez	a1,1414 <__div_mod_si3+0x34>
    140c:	40b005b3          	neg	a1,a1
    1410:	00100793          	li	a5,1
    1414:	00f12023          	sw	a5,0(sp)
    1418:	00060413          	mv	s0,a2
    141c:	f5dff0ef          	jal	1378 <__udiv_umod_si3>
    1420:	00050593          	mv	a1,a0
    1424:	00040a63          	beqz	s0,1438 <__div_mod_si3+0x58>
    1428:	00012783          	lw	a5,0(sp)
    142c:	00f48863          	beq	s1,a5,143c <__div_mod_si3+0x5c>
    1430:	40b005b3          	neg	a1,a1
    1434:	0080006f          	j	143c <__div_mod_si3+0x5c>
    1438:	fe049ce3          	bnez	s1,1430 <__div_mod_si3+0x50>
    143c:	00c12083          	lw	ra,12(sp)
    1440:	00812403          	lw	s0,8(sp)
    1444:	00412483          	lw	s1,4(sp)
    1448:	00058513          	mv	a0,a1
    144c:	01010113          	addi	sp,sp,16
    1450:	00008067          	ret
    1454:	00058513          	mv	a0,a1
    1458:	00008067          	ret

0000145c <__divsi3>:
    145c:	00100613          	li	a2,1
    1460:	f81ff06f          	j	13e0 <__div_mod_si3>

00001464 <__modsi3>:
    1464:	00000613          	li	a2,0
    1468:	f79ff06f          	j	13e0 <__div_mod_si3>

0000146c <bswap32>:
    146c:	01051613          	slli	a2,a0,0x10
    1470:	01055793          	srli	a5,a0,0x10
    1474:	01855693          	srli	a3,a0,0x18
    1478:	01865713          	srli	a4,a2,0x18
    147c:	0ff7f793          	zext.b	a5,a5
    1480:	00851513          	slli	a0,a0,0x8
    1484:	00a70533          	add	a0,a4,a0
    1488:	00879793          	slli	a5,a5,0x8
    148c:	00d7e7b3          	or	a5,a5,a3
    1490:	01051513          	slli	a0,a0,0x10
    1494:	00a7e533          	or	a0,a5,a0
    1498:	00008067          	ret

0000149c <bswap16>:
    149c:	00855793          	srli	a5,a0,0x8
    14a0:	00851513          	slli	a0,a0,0x8
    14a4:	00a78533          	add	a0,a5,a0
    14a8:	01051513          	slli	a0,a0,0x10
    14ac:	01055513          	srli	a0,a0,0x10
    14b0:	00008067          	ret

000014b4 <mac>:
    14b4:	00c5850b          	.insn	4, 0x00c5850b
    14b8:	00008067          	ret

000014bc <check4rv32i>:
    14bc:	00000793          	li	a5,0
    14c0:	00100f93          	li	t6,1
    14c4:	40ff8533          	sub	a0,t6,a5
    14c8:	00008067          	ret

000014cc <get_mstatus>:
    14cc:	00000513          	li	a0,0
    14d0:	30002573          	csrr	a0,mstatus
    14d4:	00008067          	ret

000014d8 <get_mcause>:
    14d8:	00000513          	li	a0,0
    14dc:	34202573          	csrr	a0,mcause
    14e0:	00008067          	ret

000014e4 <get_scause>:
    14e4:	00000513          	li	a0,0
    14e8:	14202573          	csrr	a0,scause
    14ec:	00008067          	ret

000014f0 <get_mhartid>:
    14f0:	00000513          	li	a0,0
    14f4:	f1402573          	csrr	a0,mhartid
    14f8:	00008067          	ret

000014fc <get_mtvec>:
    14fc:	00000513          	li	a0,0
    1500:	30502573          	csrr	a0,mtvec
    1504:	00008067          	ret

00001508 <get_mepc>:
    1508:	00000513          	li	a0,0
    150c:	34102573          	csrr	a0,mepc
    1510:	00008067          	ret

00001514 <get_stvec>:
    1514:	00000513          	li	a0,0
    1518:	10502573          	csrr	a0,stvec
    151c:	00008067          	ret

00001520 <get_sepc>:
    1520:	00000513          	li	a0,0
    1524:	14102573          	csrr	a0,sepc
    1528:	00008067          	ret

0000152c <get_mie>:
    152c:	00000513          	li	a0,0
    1530:	30402573          	csrr	a0,mie
    1534:	00008067          	ret

00001538 <get_mip>:
    1538:	00000513          	li	a0,0
    153c:	34402573          	csrr	a0,mip
    1540:	00008067          	ret

00001544 <get_mcycle>:
    1544:	00000513          	li	a0,0
    1548:	00000593          	li	a1,0
    154c:	c80025f3          	rdcycleh	a1
    1550:	c0002573          	rdcycle	a0
    1554:	00100073          	ebreak
    1558:	c8002673          	rdcycleh	a2
    155c:	fec594e3          	bne	a1,a2,1544 <get_mcycle>
    1560:	00008067          	ret

00001564 <get_minstret>:
    1564:	00000513          	li	a0,0
    1568:	00000593          	li	a1,0
    156c:	c82025f3          	rdinstreth	a1
    1570:	c0202573          	rdinstret	a0
    1574:	c8202673          	rdinstreth	a2
    1578:	fec596e3          	bne	a1,a2,1564 <get_minstret>
    157c:	00008067          	ret

00001580 <set_mstatus>:
    1580:	30051073          	csrw	mstatus,a0
    1584:	00008067          	ret

00001588 <set_mtvec>:
    1588:	30551073          	csrw	mtvec,a0
    158c:	00008067          	ret

00001590 <set_mepc>:
    1590:	34151073          	csrw	mepc,a0
    1594:	00008067          	ret

00001598 <set_stvec>:
    1598:	10551073          	csrw	stvec,a0
    159c:	00008067          	ret

000015a0 <set_sepc>:
    15a0:	14151073          	csrw	sepc,a0
    15a4:	00008067          	ret

000015a8 <set_mie>:
    15a8:	30451073          	csrw	mie,a0
    15ac:	00008067          	ret

000015b0 <set_sp>:
    15b0:	00050113          	mv	sp,a0
    15b4:	00008067          	ret

000015b8 <reboot>:
    15b8:	00058113          	mv	sp,a1

000015bc <set_pc>:
    15bc:	00050093          	mv	ra,a0
    15c0:	00000513          	li	a0,0
    15c4:	00000593          	li	a1,0
    15c8:	00000613          	li	a2,0
    15cc:	00008067          	ret

000015d0 <csr_test>:
    15d0:	34051073          	csrw	mscratch,a0
    15d4:	3405a073          	csrs	mscratch,a1
    15d8:	34063073          	csrc	mscratch,a2
    15dc:	00000513          	li	a0,0
    15e0:	34002573          	csrr	a0,mscratch
    15e4:	00008067          	ret

Disassembly of section .data:

000015e8 <_data>:
    15e8:	0069                	.insn	2, 0x0069
    15ea:	0000                	.insn	2, 0x0000
    15ec:	0065                	.insn	2, 0x0065
    15ee:	0000                	.insn	2, 0x0000
    15f0:	616d                	.insn	2, 0x616d
    15f2:	00002063          	.insn	4, 0x2063
    15f6:	0000                	.insn	2, 0x0000
    15f8:	6f69                	.insn	2, 0x6f69
    15fa:	253d                	.insn	2, 0x253d
    15fc:	0a78                	.insn	2, 0x0a78
    15fe:	0000                	.insn	2, 0x0000
    1600:	6f62                	.insn	2, 0x6f62
    1602:	3a30746f          	jal	s0,91a4 <_global+0x6c10>
    1606:	6d20                	.insn	2, 0x6d20
    1608:	6961                	.insn	2, 0x6961
    160a:	406e                	.insn	2, 0x406e
    160c:	7825                	.insn	2, 0x7825
    160e:	7320                	.insn	2, 0x7320
    1610:	6174                	.insn	2, 0x6174
    1612:	25406b63          	bltu	zero,s4,1868 <_data+0x280>
    1616:	0a78                	.insn	2, 0x0a78
    1618:	0000                	.insn	2, 0x0000
    161a:	0000                	.insn	2, 0x0000
    161c:	6f62                	.insn	2, 0x6f62
    161e:	7261                	.insn	2, 0x7261
    1620:	3a64                	.insn	2, 0x3a64
    1622:	2520                	.insn	2, 0x2520
    1624:	69282073          	csrs	0x692,a6
    1628:	3d64                	.insn	2, 0x3d64
    162a:	6425                	.insn	2, 0x6425
    162c:	0a29                	.insn	2, 0x0a29
    162e:	0000                	.insn	2, 0x0000
    1630:	7672                	.insn	2, 0x7672
    1632:	5f653233          	.insn	4, 0x5f653233
    1636:	697a                	.insn	2, 0x697a
    1638:	00727363          	bgeu	tp,t2,163e <_data+0x56>
    163c:	2c646557          	.insn	4, 0x2c646557
    1640:	3220                	.insn	2, 0x3220
    1642:	2035                	.insn	2, 0x2035
    1644:	754a                	.insn	2, 0x754a
    1646:	206e                	.insn	2, 0x206e
    1648:	3032                	.insn	2, 0x3032
    164a:	3532                	.insn	2, 0x3532
    164c:	3120                	.insn	2, 0x3120
    164e:	3a31                	.insn	2, 0x3a31
    1650:	3531                	.insn	2, 0x3531
    1652:	333a                	.insn	2, 0x333a
    1654:	2035                	.insn	2, 0x2035
    1656:	3032302b          	.insn	4, 0x3032302b
    165a:	0030                	.insn	2, 0x0030
    165c:	7562                	.insn	2, 0x7562
    165e:	6c69                	.insn	2, 0x6c69
    1660:	3a64                	.insn	2, 0x3a64
    1662:	2520                	.insn	2, 0x2520
    1664:	6f662073          	csrs	0x6f6,a2
    1668:	2072                	.insn	2, 0x2072
    166a:	7325                	.insn	2, 0x7325
    166c:	000a                	.insn	2, 0x000a
    166e:	0000                	.insn	2, 0x0000
    1670:	65726f63          	bltu	tp,s7,1cce <_data+0x6e6>
    1674:	6425                	.insn	2, 0x6425
    1676:	203a                	.insn	2, 0x203a
    1678:	0000                	.insn	2, 0x0000
    167a:	0000                	.insn	2, 0x0000
    167c:	6164                	.insn	2, 0x6164
    167e:	6b72                	.insn	2, 0x6b72
    1680:	6972                	.insn	2, 0x6972
    1682:	40766373          	csrrsi	t1,0x407,12
    1686:	6425                	.insn	2, 0x6425
    1688:	484d                	.insn	2, 0x484d
    168a:	207a                	.insn	2, 0x207a
    168c:	0000                	.insn	2, 0x0000
    168e:	0000                	.insn	2, 0x0000
    1690:	7672                	.insn	2, 0x7672
    1692:	73253233          	.insn	4, 0x73253233
    1696:	0020                	.insn	2, 0x0020
    1698:	696c                	.insn	2, 0x696c
    169a:	7474                	.insn	2, 0x7474
    169c:	656c                	.insn	2, 0x656c
    169e:	652d                	.insn	2, 0x652d
    16a0:	646e                	.insn	2, 0x646e
    16a2:	6169                	.insn	2, 0x6169
    16a4:	206e                	.insn	2, 0x206e
    16a6:	0000                	.insn	2, 0x0000
    16a8:	7262                	.insn	2, 0x7262
    16aa:	6d61                	.insn	2, 0x6d61
    16ac:	3a30                	.insn	2, 0x3a30
    16ae:	7420                	.insn	2, 0x7420
    16b0:	7865                	.insn	2, 0x7865
    16b2:	4074                	.insn	2, 0x4074
    16b4:	7825                	.insn	2, 0x7825
    16b6:	2078252b          	.insn	4, 0x2078252b
    16ba:	6164                	.insn	2, 0x6164
    16bc:	6174                	.insn	2, 0x6174
    16be:	2540                	.insn	2, 0x2540
    16c0:	2b78                	.insn	2, 0x2b78
    16c2:	7825                	.insn	2, 0x7825
    16c4:	7320                	.insn	2, 0x7320
    16c6:	6174                	.insn	2, 0x6174
    16c8:	25406b63          	bltu	zero,s4,191e <_data+0x336>
    16cc:	0a78                	.insn	2, 0x0a78
    16ce:	0000                	.insn	2, 0x0000
    16d0:	7262                	.insn	2, 0x7262
    16d2:	6d61                	.insn	2, 0x6d61
    16d4:	3a30                	.insn	2, 0x3a30
    16d6:	2520                	.insn	2, 0x2520
    16d8:	2064                	.insn	2, 0x2064
    16da:	7962                	.insn	2, 0x7962
    16dc:	6574                	.insn	2, 0x6574
    16de:	72662073          	csrs	mhpmevent6h,a2
    16e2:	6565                	.insn	2, 0x6565
    16e4:	000a                	.insn	2, 0x000a
    16e6:	0000                	.insn	2, 0x0000
    16e8:	6175                	.insn	2, 0x6175
    16ea:	7472                	.insn	2, 0x7472
    16ec:	3a30                	.insn	2, 0x3a30
    16ee:	3120                	.insn	2, 0x3120
    16f0:	3531                	.insn	2, 0x3531
    16f2:	322e                	.insn	2, 0x322e
    16f4:	7370626b          	.insn	4, 0x7370626b
    16f8:	2820                	.insn	2, 0x2820
    16fa:	6964                	.insn	2, 0x6964
    16fc:	3d76                	.insn	2, 0x3d76
    16fe:	6425                	.insn	2, 0x6425
    1700:	0a29                	.insn	2, 0x0a29
    1702:	0000                	.insn	2, 0x0000
    1704:	6974                	.insn	2, 0x6974
    1706:	726d                	.insn	2, 0x726d
    1708:	3a30                	.insn	2, 0x3a30
    170a:	2520                	.insn	2, 0x2520
    170c:	4864                	.insn	2, 0x4864
    170e:	207a                	.insn	2, 0x207a
    1710:	6428                	.insn	2, 0x6428
    1712:	7669                	.insn	2, 0x7669
    1714:	253d                	.insn	2, 0x253d
    1716:	2964                	.insn	2, 0x2964
    1718:	000a                	.insn	2, 0x000a
    171a:	0000                	.insn	2, 0x0000
    171c:	78727363          	bgeu	tp,t2,1ea2 <_GLOBAL_OFFSET_TABLE_+0xda>
    1720:	3a78                	.insn	2, 0x3a78
    1722:	6320                	.insn	2, 0x6320
    1724:	745f7273          	csrrci	tp,0x745,30
    1728:	7365                	.insn	2, 0x7365
    172a:	3d74                	.insn	2, 0x3d74
    172c:	7825                	.insn	2, 0x7825
    172e:	000a                	.insn	2, 0x000a
    1730:	78727363          	bgeu	tp,t2,1eb6 <_GLOBAL_OFFSET_TABLE_+0xee>
    1734:	3a78                	.insn	2, 0x3a78
    1736:	6e20                	.insn	2, 0x6e20
    1738:	6620746f          	jal	s0,8d9a <_global+0x6806>
    173c:	646e756f          	jal	a0,e8d82 <_global+0xe67ee>
    1740:	000a                	.insn	2, 0x000a
    1742:	0000                	.insn	2, 0x0000
    1744:	65767473          	csrrci	s0,hviprio2h,12
    1748:	68203a63          	.insn	4, 0x68203a63
    174c:	6e61                	.insn	2, 0x6e61
    174e:	6c64                	.insn	2, 0x6c64
    1750:	7265                	.insn	2, 0x7265
    1752:	2540                	.insn	2, 0x2540
    1754:	2c78                	.insn	2, 0x2c78
    1756:	6420                	.insn	2, 0x6420
    1758:	6265                	.insn	2, 0x6265
    175a:	6775                	.insn	2, 0x6775
    175c:	6520                	.insn	2, 0x6520
    175e:	616e                	.insn	2, 0x616e
    1760:	6c62                	.insn	2, 0x6c62
    1762:	6465                	.insn	2, 0x6465
    1764:	2e2e                	.insn	2, 0x2e2e
    1766:	0a2e                	.insn	2, 0x0a2e
    1768:	0000                	.insn	2, 0x0000
    176a:	0000                	.insn	2, 0x0000
    176c:	65767473          	csrrci	s0,hviprio2h,12
    1770:	6e203a63          	.insn	4, 0x6e203a63
    1774:	6620746f          	jal	s0,8dd6 <_global+0x6842>
    1778:	646e756f          	jal	a0,e8dbe <_global+0xe682a>
    177c:	000a                	.insn	2, 0x000a
    177e:	0000                	.insn	2, 0x0000
    1780:	746d                	.insn	2, 0x746d
    1782:	6576                	.insn	2, 0x6576
    1784:	68203a63          	.insn	4, 0x68203a63
    1788:	6e61                	.insn	2, 0x6e61
    178a:	6c64                	.insn	2, 0x6c64
    178c:	7265                	.insn	2, 0x7265
    178e:	2540                	.insn	2, 0x2540
    1790:	2c78                	.insn	2, 0x2c78
    1792:	6520                	.insn	2, 0x6520
    1794:	616e                	.insn	2, 0x616e
    1796:	6c62                	.insn	2, 0x6c62
    1798:	6e69                	.insn	2, 0x6e69
    179a:	6e692067          	.insn	4, 0x6e692067
    179e:	6574                	.insn	2, 0x6574
    17a0:	7272                	.insn	2, 0x7272
    17a2:	7075                	.insn	2, 0x7075
    17a4:	7374                	.insn	2, 0x7374
    17a6:	2e2e                	.insn	2, 0x2e2e
    17a8:	0a2e                	.insn	2, 0x0a2e
    17aa:	0000                	.insn	2, 0x0000
    17ac:	746d                	.insn	2, 0x746d
    17ae:	6576                	.insn	2, 0x6576
    17b0:	69203a63          	.insn	4, 0x69203a63
    17b4:	746e                	.insn	2, 0x746e
    17b6:	7265                	.insn	2, 0x7265
    17b8:	7572                	.insn	2, 0x7572
    17ba:	7470                	.insn	2, 0x7470
    17bc:	6e652073          	csrs	0x6e6,a0
    17c0:	6261                	.insn	2, 0x6261
    17c2:	656c                	.insn	2, 0x656c
    17c4:	2164                	.insn	2, 0x2164
    17c6:	000a                	.insn	2, 0x000a
    17c8:	746d                	.insn	2, 0x746d
    17ca:	6576                	.insn	2, 0x6576
    17cc:	6e203a63          	.insn	4, 0x6e203a63
    17d0:	6620746f          	jal	s0,8e32 <_global+0x689e>
    17d4:	646e756f          	jal	a0,e8e1a <_global+0xe6886>
    17d8:	2820                	.insn	2, 0x2820
    17da:	6f70                	.insn	2, 0x6f70
    17dc:	6c6c                	.insn	2, 0x6c6c
    17de:	6e69                	.insn	2, 0x6e69
    17e0:	000a2967          	.insn	4, 0x000a2967
    17e4:	636c6557          	.insn	4, 0x636c6557
    17e8:	20656d6f          	jal	s10,579ee <_global+0x5545a>
    17ec:	6f74                	.insn	2, 0x6f74
    17ee:	4420                	.insn	2, 0x4420
    17f0:	7261                	.insn	2, 0x7261
    17f2:	5349526b          	.insn	4, 0x5349526b
    17f6:	0a215643          	.insn	4, 0x0a215643
    17fa:	000a                	.insn	2, 0x000a
    17fc:	6425                	.insn	2, 0x6425
    17fe:	203e                	.insn	2, 0x203e
    1800:	0000                	.insn	2, 0x0000
    1802:	0000                	.insn	2, 0x0000
    1804:	0020                	.insn	2, 0x0020
    1806:	0000                	.insn	2, 0x0000
    1808:	61656c63          	bltu	a0,s6,1e20 <_GLOBAL_OFFSET_TABLE_+0x58>
    180c:	0072                	.insn	2, 0x0072
    180e:	0000                	.insn	2, 0x0000
    1810:	1b485b1b          	.insn	4, 0x1b485b1b
    1814:	004a325b          	.insn	4, 0x004a325b
    1818:	706f7473          	csrrci	s0,0x706,30
    181c:	0000                	.insn	2, 0x0000
    181e:	0000                	.insn	2, 0x0000
    1820:	6572                	.insn	2, 0x6572
    1822:	6f62                	.insn	2, 0x6f62
    1824:	0000746f          	jal	s0,8824 <_global+0x6290>
    1828:	746d                	.insn	2, 0x746d
    182a:	6576                	.insn	2, 0x6576
    182c:	69203a63          	.insn	4, 0x69203a63
    1830:	746e                	.insn	2, 0x746e
    1832:	7265                	.insn	2, 0x7265
    1834:	7572                	.insn	2, 0x7572
    1836:	7470                	.insn	2, 0x7470
    1838:	69642073          	csrs	0x696,s0
    183c:	6c626173          	csrrsi	sp,0x6c6,4
    1840:	6465                	.insn	2, 0x6465
    1842:	0a21                	.insn	2, 0x0a21
    1844:	0000                	.insn	2, 0x0000
    1846:	0000                	.insn	2, 0x0000
    1848:	6572                	.insn	2, 0x6572
    184a:	6f62                	.insn	2, 0x6f62
    184c:	6e69746f          	jal	s0,98f32 <_global+0x9699e>
    1850:	2e2e2e67          	.insn	4, 0x2e2e2e67
    1854:	000a                	.insn	2, 0x000a
    1856:	0000                	.insn	2, 0x0000
    1858:	7564                	.insn	2, 0x7564
    185a:	706d                	.insn	2, 0x706d
    185c:	0000                	.insn	2, 0x0000
    185e:	0000                	.insn	2, 0x0000
    1860:	7825                	.insn	2, 0x7825
    1862:	203a                	.insn	2, 0x203a
    1864:	0000                	.insn	2, 0x0000
    1866:	0000                	.insn	2, 0x0000
    1868:	7825                	.insn	2, 0x7825
    186a:	0020                	.insn	2, 0x0020
    186c:	6472                	.insn	2, 0x6472
    186e:	0000                	.insn	2, 0x0000
    1870:	00007277          	.insn	4, 0x7277
    1874:	656c                	.insn	2, 0x656c
    1876:	0064                	.insn	2, 0x0064
    1878:	656c                	.insn	2, 0x656c
    187a:	2064                	.insn	2, 0x2064
    187c:	203d                	.insn	2, 0x203d
    187e:	7825                	.insn	2, 0x7825
    1880:	000a                	.insn	2, 0x000a
    1882:	0000                	.insn	2, 0x0000
    1884:	6974                	.insn	2, 0x6974
    1886:	656d                	.insn	2, 0x656d
    1888:	0072                	.insn	2, 0x0072
    188a:	0000                	.insn	2, 0x0000
    188c:	6974                	.insn	2, 0x6974
    188e:	656d                	.insn	2, 0x656d
    1890:	2072                	.insn	2, 0x2072
    1892:	203d                	.insn	2, 0x203d
    1894:	6425                	.insn	2, 0x6425
    1896:	000a                	.insn	2, 0x000a
    1898:	726f706f          	j	f8fbe <_global+0xf6a2a>
    189c:	0074                	.insn	2, 0x0074
    189e:	0000                	.insn	2, 0x0000
    18a0:	726f706f          	j	f8fc6 <_global+0xf6a32>
    18a4:	2074                	.insn	2, 0x2074
    18a6:	203d                	.insn	2, 0x203d
    18a8:	7825                	.insn	2, 0x7825
    18aa:	000a                	.insn	2, 0x000a
    18ac:	7069                	.insn	2, 0x7069
    18ae:	0074726f          	jal	tp,490b4 <_global+0x46b20>
    18b2:	0000                	.insn	2, 0x0000
    18b4:	7069                	.insn	2, 0x7069
    18b6:	2074726f          	jal	tp,492bc <_global+0x46d28>
    18ba:	203d                	.insn	2, 0x203d
    18bc:	7825                	.insn	2, 0x7825
    18be:	000a                	.insn	2, 0x000a
    18c0:	756d                	.insn	2, 0x756d
    18c2:	006c                	.insn	2, 0x006c
    18c4:	756d                	.insn	2, 0x756d
    18c6:	206c                	.insn	2, 0x206c
    18c8:	203d                	.insn	2, 0x203d
    18ca:	6425                	.insn	2, 0x6425
    18cc:	000a                	.insn	2, 0x000a
    18ce:	0000                	.insn	2, 0x0000
    18d0:	6964                	.insn	2, 0x6964
    18d2:	0076                	.insn	2, 0x0076
    18d4:	6964                	.insn	2, 0x6964
    18d6:	2076                	.insn	2, 0x2076
    18d8:	203d                	.insn	2, 0x203d
    18da:	6425                	.insn	2, 0x6425
    18dc:	202c                	.insn	2, 0x202c
    18de:	6f6d                	.insn	2, 0x6f6d
    18e0:	2064                	.insn	2, 0x2064
    18e2:	203d                	.insn	2, 0x203d
    18e4:	6425                	.insn	2, 0x6425
    18e6:	000a                	.insn	2, 0x000a
    18e8:	616d                	.insn	2, 0x616d
    18ea:	616d0063          	beq	s10,s6,1eea <_GLOBAL_OFFSET_TABLE_+0x122>
    18ee:	203d2063          	.insn	4, 0x203d2063
    18f2:	6425                	.insn	2, 0x6425
    18f4:	000a                	.insn	2, 0x000a
    18f6:	0000                	.insn	2, 0x0000
    18f8:	69617273          	csrrci	tp,0x696,2
    18fc:	0000                	.insn	2, 0x0000
    18fe:	0000                	.insn	2, 0x0000
    1900:	69617273          	csrrci	tp,0x696,2
    1904:	2520                	.insn	2, 0x2520
    1906:	2078                	.insn	2, 0x2078
    1908:	3e3e                	.insn	2, 0x3e3e
    190a:	3120                	.insn	2, 0x3120
    190c:	3d20                	.insn	2, 0x3d20
    190e:	2520                	.insn	2, 0x2520
    1910:	0a78                	.insn	2, 0x0a78
    1912:	0000                	.insn	2, 0x0000
    1914:	6d6d6f63          	bltu	s10,s6,1ff2 <_edata+0x102>
    1918:	6e61                	.insn	2, 0x6e61
    191a:	3a64                	.insn	2, 0x3a64
    191c:	5b20                	.insn	2, 0x5b20
    191e:	7325                	.insn	2, 0x7325
    1920:	205d                	.insn	2, 0x205d
    1922:	6f6e                	.insn	2, 0x6f6e
    1924:	2074                	.insn	2, 0x2074
    1926:	6f66                	.insn	2, 0x6f66
    1928:	6e75                	.insn	2, 0x6e75
    192a:	2e64                	.insn	2, 0x2e64
    192c:	760a                	.insn	2, 0x760a
    192e:	6c61                	.insn	2, 0x6c61
    1930:	6469                	.insn	2, 0x6469
    1932:	6320                	.insn	2, 0x6320
    1934:	616d6d6f          	jal	s10,d7f4a <_global+0xd59b6>
    1938:	646e                	.insn	2, 0x646e
    193a:	63203a73          	csrrc	s4,0x632,zero
    193e:	656c                	.insn	2, 0x656c
    1940:	7261                	.insn	2, 0x7261
    1942:	202c                	.insn	2, 0x202c
    1944:	7564                	.insn	2, 0x7564
    1946:	706d                	.insn	2, 0x706d
    1948:	5b20                	.insn	2, 0x5b20
    194a:	6568                	.insn	2, 0x6568
    194c:	5d78                	.insn	2, 0x5d78
    194e:	202c                	.insn	2, 0x202c
    1950:	656c                	.insn	2, 0x656c
    1952:	2064                	.insn	2, 0x2064
    1954:	7865685b          	.insn	4, 0x7865685b
    1958:	2c5d                	.insn	2, 0x2c5d
    195a:	7420                	.insn	2, 0x7420
    195c:	6d69                	.insn	2, 0x6d69
    195e:	7265                	.insn	2, 0x7265
    1960:	5b20                	.insn	2, 0x5b20
    1962:	6564                	.insn	2, 0x6564
    1964:	202c5d63          	bge	s8,sp,1b7e <_data+0x596>
    1968:	726f706f          	j	f908e <_global+0xf6afa>
    196c:	2074                	.insn	2, 0x2074
    196e:	7865685b          	.insn	4, 0x7865685b
    1972:	0a5d                	.insn	2, 0x0a5d
    1974:	2020                	.insn	2, 0x2020
    1976:	2020                	.insn	2, 0x2020
    1978:	2020                	.insn	2, 0x2020
    197a:	2020                	.insn	2, 0x2020
    197c:	2020                	.insn	2, 0x2020
    197e:	2020                	.insn	2, 0x2020
    1980:	2020                	.insn	2, 0x2020
    1982:	2020                	.insn	2, 0x2020
    1984:	756d                	.insn	2, 0x756d
    1986:	206c                	.insn	2, 0x206c
    1988:	6365645b          	.insn	4, 0x6365645b
    198c:	205d                	.insn	2, 0x205d
    198e:	6365645b          	.insn	4, 0x6365645b
    1992:	2c5d                	.insn	2, 0x2c5d
    1994:	6420                	.insn	2, 0x6420
    1996:	7669                	.insn	2, 0x7669
    1998:	5b20                	.insn	2, 0x5b20
    199a:	6564                	.insn	2, 0x6564
    199c:	5b205d63          	blez	s2,1f56 <_edata+0x66>
    19a0:	6564                	.insn	2, 0x6564
    19a2:	202c5d63          	bge	s8,sp,1bbc <_data+0x5d4>
    19a6:	616d                	.insn	2, 0x616d
    19a8:	645b2063          	.insn	4, 0x645b2063
    19ac:	6365                	.insn	2, 0x6365
    19ae:	205d                	.insn	2, 0x205d
    19b0:	6365645b          	.insn	4, 0x6365645b
    19b4:	205d                	.insn	2, 0x205d
    19b6:	6365645b          	.insn	4, 0x6365645b
    19ba:	0a5d                	.insn	2, 0x0a5d
    19bc:	2020                	.insn	2, 0x2020
    19be:	2020                	.insn	2, 0x2020
    19c0:	2020                	.insn	2, 0x2020
    19c2:	2020                	.insn	2, 0x2020
    19c4:	2020                	.insn	2, 0x2020
    19c6:	2020                	.insn	2, 0x2020
    19c8:	2020                	.insn	2, 0x2020
    19ca:	2020                	.insn	2, 0x2020
    19cc:	6572                	.insn	2, 0x6572
    19ce:	6f62                	.insn	2, 0x6f62
    19d0:	202c746f          	jal	s0,c8bd2 <_global+0xc663e>
    19d4:	6d5b7277          	.insn	4, 0x6d5b7277
    19d8:	5b5d                	.insn	2, 0x5b5d
    19da:	7762                	.insn	2, 0x7762
    19dc:	5d6c                	.insn	2, 0x5d6c
    19de:	5b20                	.insn	2, 0x5b20
    19e0:	6568                	.insn	2, 0x6568
    19e2:	5d78                	.insn	2, 0x5d78
    19e4:	5b20                	.insn	2, 0x5b20
    19e6:	6568                	.insn	2, 0x6568
    19e8:	5d78                	.insn	2, 0x5d78
    19ea:	5b20                	.insn	2, 0x5b20
    19ec:	7865685b          	.insn	4, 0x7865685b
    19f0:	205d                	.insn	2, 0x205d
    19f2:	6e656877          	.insn	4, 0x6e656877
    19f6:	6d20                	.insn	2, 0x6d20
    19f8:	2c5d                	.insn	2, 0x2c5d
    19fa:	200a                	.insn	2, 0x200a
    19fc:	2020                	.insn	2, 0x2020
    19fe:	2020                	.insn	2, 0x2020
    1a00:	2020                	.insn	2, 0x2020
    1a02:	2020                	.insn	2, 0x2020
    1a04:	2020                	.insn	2, 0x2020
    1a06:	2020                	.insn	2, 0x2020
    1a08:	2020                	.insn	2, 0x2020
    1a0a:	7220                	.insn	2, 0x7220
    1a0c:	5b64                	.insn	2, 0x5b64
    1a0e:	5d6d                	.insn	2, 0x5d6d
    1a10:	6c77625b          	.insn	4, 0x6c77625b
    1a14:	205d                	.insn	2, 0x205d
    1a16:	7865685b          	.insn	4, 0x7865685b
    1a1a:	205d                	.insn	2, 0x205d
    1a1c:	65685b5b          	.insn	4, 0x65685b5b
    1a20:	5d78                	.insn	2, 0x5d78
    1a22:	7720                	.insn	2, 0x7720
    1a24:	6568                	.insn	2, 0x6568
    1a26:	206e                	.insn	2, 0x206e
    1a28:	5d6d                	.insn	2, 0x5d6d
    1a2a:	202c                	.insn	2, 0x202c
    1a2c:	7069                	.insn	2, 0x7069
    1a2e:	0a74726f          	jal	tp,492d4 <_global+0x46d40>
    1a32:	0000                	.insn	2, 0x0000
    1a34:	4e28                	.insn	2, 0x4e28
    1a36:	4c55                	.insn	2, 0x4c55
    1a38:	294c                	.insn	2, 0x294c
    1a3a:	0000                	.insn	2, 0x0000
    1a3c:	3130                	.insn	2, 0x3130
    1a3e:	3332                	.insn	2, 0x3332
    1a40:	3534                	.insn	2, 0x3534
    1a42:	3736                	.insn	2, 0x3736
    1a44:	3938                	.insn	2, 0x3938
    1a46:	6261                	.insn	2, 0x6261
    1a48:	66656463          	bltu	a0,t1,20b0 <_stack+0xb0>
    1a4c:	0000                	.insn	2, 0x0000
    1a4e:	0000                	.insn	2, 0x0000
    1a50:	6e75                	.insn	2, 0x6e75
    1a52:	776f6e6b          	.insn	4, 0x776f6e6b
    1a56:	006e                	.insn	2, 0x006e
    1a58:	6e69                	.insn	2, 0x6e69
    1a5a:	75727473          	csrrci	s0,mseccfgh,4
    1a5e:	6f697463          	bgeu	s2,s6,2146 <_stack+0x146>
    1a62:	206e                	.insn	2, 0x206e
    1a64:	6461                	.insn	2, 0x6461
    1a66:	7264                	.insn	2, 0x7264
    1a68:	7365                	.insn	2, 0x7365
    1a6a:	6c612073          	csrs	0x6c6,sp
    1a6e:	6769                	.insn	2, 0x6769
    1a70:	006e                	.insn	2, 0x006e
    1a72:	0000                	.insn	2, 0x0000
    1a74:	6564                	.insn	2, 0x6564
    1a76:	7562                	.insn	2, 0x7562
    1a78:	2a203a67          	.insn	4, 0x2a203a67
    1a7c:	2a2a                	.insn	2, 0x2a2a
    1a7e:	6520                	.insn	2, 0x6520
    1a80:	6378                	.insn	2, 0x6378
    1a82:	7065                	.insn	2, 0x7065
    1a84:	6974                	.insn	2, 0x6974
    1a86:	61206e6f          	jal	t3,8098 <_global+0x5b04>
    1a8a:	2074                	.insn	2, 0x2074
    1a8c:	7825                	.insn	2, 0x7825
    1a8e:	7720                	.insn	2, 0x7720
    1a90:	636d202f          	.insn	4, 0x636d202f
    1a94:	7561                	.insn	2, 0x7561
    1a96:	253d6573          	csrrsi	a0,vsireg3,26
    1a9a:	2f78                	.insn	2, 0x2f78
    1a9c:	5d73255b          	.insn	4, 0x5d73255b
    1aa0:	2a20                	.insn	2, 0x2a20
    1aa2:	2a2a                	.insn	2, 0x2a2a
    1aa4:	000a                	.insn	2, 0x000a
    1aa6:	0000                	.insn	2, 0x0000
    1aa8:	6e69                	.insn	2, 0x6e69
    1aaa:	75727473          	csrrci	s0,mseccfgh,4
    1aae:	6f697463          	bgeu	s2,s6,2196 <_stack+0x196>
    1ab2:	206e                	.insn	2, 0x206e
    1ab4:	6164                	.insn	2, 0x6164
    1ab6:	6174                	.insn	2, 0x6174
    1ab8:	6620                	.insn	2, 0x6620
    1aba:	7561                	.insn	2, 0x7561
    1abc:	746c                	.insn	2, 0x746c
    1abe:	0000                	.insn	2, 0x0000
    1ac0:	6c69                	.insn	2, 0x6c69
    1ac2:	656c                	.insn	2, 0x656c
    1ac4:	206c6167          	.insn	4, 0x206c6167
    1ac8:	6e69                	.insn	2, 0x6e69
    1aca:	75727473          	csrrci	s0,mseccfgh,4
    1ace:	6f697463          	bgeu	s2,s6,21b6 <_stack+0x1b6>
    1ad2:	006e                	.insn	2, 0x006e
    1ad4:	7262                	.insn	2, 0x7262
    1ad6:	6165                	.insn	2, 0x6165
    1ad8:	696f706b          	.insn	4, 0x696f706b
    1adc:	746e                	.insn	2, 0x746e
    1ade:	0000                	.insn	2, 0x0000
    1ae0:	6f6c                	.insn	2, 0x6f6c
    1ae2:	6461                	.insn	2, 0x6461
    1ae4:	6120                	.insn	2, 0x6120
    1ae6:	6464                	.insn	2, 0x6464
    1ae8:	6572                	.insn	2, 0x6572
    1aea:	61207373          	csrrci	t1,0x612,0
    1aee:	696c                	.insn	2, 0x696c
    1af0:	00006e67          	.insn	4, 0x6e67
    1af4:	6f6c                	.insn	2, 0x6f6c
    1af6:	6461                	.insn	2, 0x6461
    1af8:	6420                	.insn	2, 0x6420
    1afa:	7461                	.insn	2, 0x7461
    1afc:	2061                	.insn	2, 0x2061
    1afe:	6166                	.insn	2, 0x6166
    1b00:	6c75                	.insn	2, 0x6c75
    1b02:	0074                	.insn	2, 0x0074
    1b04:	726f7473          	csrrci	s0,mhpmevent6h,30
    1b08:	2065                	.insn	2, 0x2065
    1b0a:	6461                	.insn	2, 0x6461
    1b0c:	7264                	.insn	2, 0x7264
    1b0e:	7365                	.insn	2, 0x7365
    1b10:	6c612073          	csrs	0x6c6,sp
    1b14:	6769                	.insn	2, 0x6769
    1b16:	006e                	.insn	2, 0x006e
    1b18:	726f7473          	csrrci	s0,mhpmevent6h,30
    1b1c:	2065                	.insn	2, 0x2065
    1b1e:	6164                	.insn	2, 0x6164
    1b20:	6174                	.insn	2, 0x6174
    1b22:	6620                	.insn	2, 0x6620
    1b24:	7561                	.insn	2, 0x7561
    1b26:	746c                	.insn	2, 0x746c
    1b28:	0000                	.insn	2, 0x0000
    1b2a:	0000                	.insn	2, 0x0000
    1b2c:	756d6973          	csrrsi	s2,0x756,26
    1b30:	616c                	.insn	2, 0x616c
    1b32:	6974                	.insn	2, 0x6974
    1b34:	6f206e6f          	jal	t3,8226 <_global+0x5c92>
    1b38:	6c6e                	.insn	2, 0x6c6e
    1b3a:	0079                	.insn	2, 0x0079
    1b3c:	7661                	.insn	2, 0x7661
    1b3e:	656e                	.insn	2, 0x656e
    1b40:	2074                	.insn	2, 0x2074
    1b42:	696d                	.insn	2, 0x696d
    1b44:	626f7263          	bgeu	t5,t1,2168 <_stack+0x168>
    1b48:	6472616f          	jal	sp,2898e <_global+0x263fa>
    1b4c:	6c20                	.insn	2, 0x6c20
    1b4e:	3978                	.insn	2, 0x3978
    1b50:	0000                	.insn	2, 0x0000
    1b52:	0000                	.insn	2, 0x0000
    1b54:	6978                	.insn	2, 0x6978
    1b56:	696c                	.insn	2, 0x696c
    1b58:	786e                	.insn	2, 0x786e
    1b5a:	6120                	.insn	2, 0x6120
    1b5c:	31303763          	.insn	4, 0x31303763
    1b60:	6120                	.insn	2, 0x6120
    1b62:	3032                	.insn	2, 0x3032
    1b64:	0030                	.insn	2, 0x0030
    1b66:	0000                	.insn	2, 0x0000
    1b68:	6d71                	.insn	2, 0x6d71
    1b6a:	6574                	.insn	2, 0x6574
    1b6c:	73206863          	bltu	zero,s2,229c <_stack+0x29c>
    1b70:	7264                	.insn	2, 0x7264
    1b72:	6d61                	.insn	2, 0x6d61
    1b74:	6c20                	.insn	2, 0x6c20
    1b76:	3178                	.insn	2, 0x3178
    1b78:	0036                	.insn	2, 0x0036
    1b7a:	0000                	.insn	2, 0x0000
    1b7c:	6d71                	.insn	2, 0x6d71
    1b7e:	6574                	.insn	2, 0x6574
    1b80:	73206863          	bltu	zero,s2,22b0 <_stack+0x2b0>
    1b84:	6170                	.insn	2, 0x6170
    1b86:	7472                	.insn	2, 0x7472
    1b88:	6e61                	.insn	2, 0x6e61
    1b8a:	31732037          	lui	zero,0x31732
    1b8e:	0035                	.insn	2, 0x0035
    1b90:	616c                	.insn	2, 0x616c
    1b92:	7474                	.insn	2, 0x7474
    1b94:	6369                	.insn	2, 0x6369
    1b96:	2065                	.insn	2, 0x2065
    1b98:	7262                	.insn	2, 0x7262
    1b9a:	7665                	.insn	2, 0x7665
    1b9c:	6169                	.insn	2, 0x6169
    1b9e:	2032                	.insn	2, 0x2032
    1ba0:	786c                	.insn	2, 0x786c
    1ba2:	3270                	.insn	2, 0x3270
    1ba4:	0000                	.insn	2, 0x0000
    1ba6:	0000                	.insn	2, 0x0000
    1ba8:	6970                	.insn	2, 0x6970
    1baa:	726f7773          	csrrci	a4,mhpmevent6h,30
    1bae:	7364                	.insn	2, 0x7364
    1bb0:	7220                	.insn	2, 0x7220
    1bb2:	35383473          	csrrc	s0,mireg3,a6
    1bb6:	6c20                	.insn	2, 0x6c20
    1bb8:	3978                	.insn	2, 0x3978
    1bba:	0000                	.insn	2, 0x0000
    1bbc:	6964                	.insn	2, 0x6964
    1bbe:	656c6967          	.insn	4, 0x656c6967
    1bc2:	746e                	.insn	2, 0x746e
    1bc4:	7320                	.insn	2, 0x7320
    1bc6:	6170                	.insn	2, 0x6170
    1bc8:	7472                	.insn	2, 0x7472
    1bca:	6e61                	.insn	2, 0x6e61
    1bcc:	32732033          	.insn	4, 0x32732033
    1bd0:	3030                	.insn	2, 0x3030
    1bd2:	0000                	.insn	2, 0x0000
    1bd4:	6c61                	.insn	2, 0x6c61
    1bd6:	6569                	.insn	2, 0x6569
    1bd8:	7078                	.insn	2, 0x7078
    1bda:	6572                	.insn	2, 0x6572
    1bdc:	68207373          	csrrci	t1,0x682,0
    1be0:	6370                	.insn	2, 0x6370
    1be2:	6730342f          	.insn	4, 0x6730342f
    1be6:	6562                	.insn	2, 0x6562
    1be8:	6b20                	.insn	2, 0x6b20
    1bea:	3234                	.insn	2, 0x3234
    1bec:	0030                	.insn	2, 0x0030
    1bee:	0000                	.insn	2, 0x0000
    1bf0:	6d71                	.insn	2, 0x6d71
    1bf2:	6574                	.insn	2, 0x6574
    1bf4:	61206863          	bltu	zero,s2,2204 <_stack+0x204>
    1bf8:	7472                	.insn	2, 0x7472
    1bfa:	7869                	.insn	2, 0x7869
    1bfc:	33612037          	lui	zero,0x33612
    1c00:	0035                	.insn	2, 0x0035
    1c02:	0000                	.insn	2, 0x0000
    1c04:	6c61                	.insn	2, 0x6c61
    1c06:	6569                	.insn	2, 0x6569
    1c08:	7078                	.insn	2, 0x7078
    1c0a:	6572                	.insn	2, 0x6572
    1c0c:	68207373          	csrrci	t1,0x682,0
    1c10:	6370                	.insn	2, 0x6370
    1c12:	6730342f          	.insn	4, 0x6730342f
    1c16:	6562                	.insn	2, 0x6562
    1c18:	6b20                	.insn	2, 0x6b20
    1c1a:	3075                	.insn	2, 0x3075
    1c1c:	3034                	.insn	2, 0x3034
    1c1e:	0000                	.insn	2, 0x0000
    1c20:	6170                	.insn	2, 0x6170
    1c22:	6970                	.insn	2, 0x6970
    1c24:	696c                	.insn	2, 0x696c
    1c26:	7564206f          	j	4437c <_global+0x41de8>
    1c2a:	6f6c206f          	j	c4320 <_global+0xc1d8c>
    1c2e:	73636967          	.insn	4, 0x73636967
    1c32:	6174                	.insn	2, 0x6174
    1c34:	7472                	.insn	2, 0x7472
    1c36:	0000                	.insn	2, 0x0000
    1c38:	6d71                	.insn	2, 0x6d71
    1c3a:	6574                	.insn	2, 0x6574
    1c3c:	6b206863          	bltu	zero,s2,22ec <_stack+0x2ec>
    1c40:	6e69                	.insn	2, 0x6e69
    1c42:	6574                	.insn	2, 0x6574
    1c44:	2d78                	.insn	2, 0x2d78
    1c46:	336b2037          	lui	zero,0x336b2
    1c4a:	3532                	.insn	2, 0x3532
    1c4c:	0000                	.insn	2, 0x0000
    1c4e:	0000                	.insn	2, 0x0000
    1c50:	72616373          	csrrsi	t1,mhpmevent6h,2
    1c54:	6261                	.insn	2, 0x6261
    1c56:	6d20                	.insn	2, 0x6d20
    1c58:	6e69                	.insn	2, 0x6e69
    1c5a:	7369                	.insn	2, 0x7369
    1c5c:	6170                	.insn	2, 0x6170
    1c5e:	7472                	.insn	2, 0x7472
    1c60:	6e61                	.insn	2, 0x6e61
    1c62:	2d36                	.insn	2, 0x2d36
    1c64:	6c70                	.insn	2, 0x6c70
    1c66:	7375                	.insn	2, 0x7375
    1c68:	6c20                	.insn	2, 0x6c20
    1c6a:	3978                	.insn	2, 0x3978
    1c6c:	0000                	.insn	2, 0x0000
    1c6e:	0000                	.insn	2, 0x0000
    1c70:	616c                	.insn	2, 0x616c
    1c72:	7474                	.insn	2, 0x7474
    1c74:	6369                	.insn	2, 0x6369
    1c76:	2065                	.insn	2, 0x2065
    1c78:	6365                	.insn	2, 0x6365
    1c7a:	3570                	.insn	2, 0x3570
    1c7c:	342d                	.insn	2, 0x342d
    1c7e:	4635                	.insn	2, 0x4635
    1c80:	6320                	.insn	2, 0x6320
    1c82:	726f6c6f          	jal	s8,f83a8 <_global+0xf5e14>
    1c86:	696c                	.insn	2, 0x696c
    1c88:	69746867          	.insn	4, 0x69746867
    1c8c:	0039                	.insn	2, 0x0039
    1c8e:	0000                	.insn	2, 0x0000
    1c90:	616c                	.insn	2, 0x616c
    1c92:	7474                	.insn	2, 0x7474
    1c94:	6369                	.insn	2, 0x6369
    1c96:	2065                	.insn	2, 0x2065
    1c98:	6365                	.insn	2, 0x6365
    1c9a:	3570                	.insn	2, 0x3570
    1c9c:	322d                	.insn	2, 0x322d
    1c9e:	4635                	.insn	2, 0x4635
    1ca0:	6320                	.insn	2, 0x6320
    1ca2:	726f6c6f          	jal	s8,f83c8 <_global+0xf5e34>
    1ca6:	696c                	.insn	2, 0x696c
    1ca8:	69746867          	.insn	4, 0x69746867
    1cac:	0035                	.insn	2, 0x0035
    1cae:	0000                	.insn	2, 0x0000
    1cb0:	616c                	.insn	2, 0x616c
    1cb2:	7474                	.insn	2, 0x7474
    1cb4:	6369                	.insn	2, 0x6369
    1cb6:	2065                	.insn	2, 0x2065
    1cb8:	6365                	.insn	2, 0x6365
    1cba:	3570                	.insn	2, 0x3570
    1cbc:	382d                	.insn	2, 0x382d
    1cbe:	4635                	.insn	2, 0x4635
    1cc0:	7520                	.insn	2, 0x7520
    1cc2:	786c                	.insn	2, 0x786c
    1cc4:	00007333          	and	t1,zero,zero
    1cc8:	6d71                	.insn	2, 0x6d71
    1cca:	6574                	.insn	2, 0x6574
    1ccc:	63206863          	bltu	zero,s2,22fc <_stack+0x2fc>
    1cd0:	6379                	.insn	2, 0x6379
    1cd2:	6f6c                	.insn	2, 0x6f6c
    1cd4:	656e                	.insn	2, 0x656e
    1cd6:	3120                	.insn	2, 0x3120
    1cd8:	6c30                	.insn	2, 0x6c30
    1cda:	2070                	.insn	2, 0x2070
    1cdc:	36313063          	.insn	4, 0x36313063
    1ce0:	0000                	.insn	2, 0x0000
    1ce2:	0000                	.insn	2, 0x0000
    1ce4:	6970                	.insn	2, 0x6970
    1ce6:	726f7773          	csrrci	a4,mhpmevent6h,30
    1cea:	7364                	.insn	2, 0x7364
    1cec:	6320                	.insn	2, 0x6320
    1cee:	3368                	.insn	2, 0x3368
    1cf0:	7834                	.insn	2, 0x7834
    1cf2:	6c20                	.insn	2, 0x6c20
    1cf4:	3178                	.insn	2, 0x3178
    1cf6:	0036                	.insn	2, 0x0036
    1cf8:	616d                	.insn	2, 0x616d
    1cfa:	3178                	.insn	2, 0x3178
    1cfc:	3030                	.insn	2, 0x3030
    1cfe:	2030                	.insn	2, 0x2030
    1d00:	616d                	.insn	2, 0x616d
    1d02:	3178                	.insn	2, 0x3178
    1d04:	0030                	.insn	2, 0x0030
    1d06:	0000                	.insn	2, 0x0000
    1d08:	6564                	.insn	2, 0x6564
    1d0a:	3031                	.insn	2, 0x3031
    1d0c:	616e                	.insn	2, 0x616e
    1d0e:	6f6e                	.insn	2, 0x6f6e
    1d10:	6320                	.insn	2, 0x6320
    1d12:	6379                	.insn	2, 0x6379
    1d14:	6f6c                	.insn	2, 0x6f6c
    1d16:	656e                	.insn	2, 0x656e
    1d18:	2076                	.insn	2, 0x2076
    1d1a:	696d                	.insn	2, 0x696d
    1d1c:	72657473          	csrrci	s0,mhpmevent6h,10
    1d20:	0000                	.insn	2, 0x0000
	...

00001d24 <CSWTCH.10>:
    1d24:	1b2c                	.insn	2, 0x1b2c
    1d26:	0000                	.insn	2, 0x0000
    1d28:	1b3c                	.insn	2, 0x1b3c
    1d2a:	0000                	.insn	2, 0x0000
    1d2c:	1b54                	.insn	2, 0x1b54
    1d2e:	0000                	.insn	2, 0x0000
    1d30:	1b68                	.insn	2, 0x1b68
    1d32:	0000                	.insn	2, 0x0000
    1d34:	1b7c                	.insn	2, 0x1b7c
    1d36:	0000                	.insn	2, 0x0000
    1d38:	1b90                	.insn	2, 0x1b90
    1d3a:	0000                	.insn	2, 0x0000
    1d3c:	1ba8                	.insn	2, 0x1ba8
    1d3e:	0000                	.insn	2, 0x0000
    1d40:	1bbc                	.insn	2, 0x1bbc
    1d42:	0000                	.insn	2, 0x0000
    1d44:	1bd4                	.insn	2, 0x1bd4
    1d46:	0000                	.insn	2, 0x0000
    1d48:	1bf0                	.insn	2, 0x1bf0
    1d4a:	0000                	.insn	2, 0x0000
    1d4c:	1c04                	.insn	2, 0x1c04
    1d4e:	0000                	.insn	2, 0x0000
    1d50:	1c20                	.insn	2, 0x1c20
    1d52:	0000                	.insn	2, 0x0000
    1d54:	1c38                	.insn	2, 0x1c38
    1d56:	0000                	.insn	2, 0x0000
    1d58:	1c50                	.insn	2, 0x1c50
    1d5a:	0000                	.insn	2, 0x0000
    1d5c:	1c70                	.insn	2, 0x1c70
    1d5e:	0000                	.insn	2, 0x0000
    1d60:	1c90                	.insn	2, 0x1c90
    1d62:	0000                	.insn	2, 0x0000
    1d64:	1cb0                	.insn	2, 0x1cb0
    1d66:	0000                	.insn	2, 0x0000
    1d68:	1cc8                	.insn	2, 0x1cc8
    1d6a:	0000                	.insn	2, 0x0000
    1d6c:	1ce4                	.insn	2, 0x1ce4
    1d6e:	0000                	.insn	2, 0x0000
    1d70:	1cf8                	.insn	2, 0x1cf8
    1d72:	0000                	.insn	2, 0x0000
    1d74:	1d08                	.insn	2, 0x1d08
	...

00001d78 <CSWTCH.13>:
    1d78:	1aa8                	.insn	2, 0x1aa8
    1d7a:	0000                	.insn	2, 0x0000
    1d7c:	1ac0                	.insn	2, 0x1ac0
    1d7e:	0000                	.insn	2, 0x0000
    1d80:	1ad4                	.insn	2, 0x1ad4
    1d82:	0000                	.insn	2, 0x0000
    1d84:	1ae0                	.insn	2, 0x1ae0
    1d86:	0000                	.insn	2, 0x0000
    1d88:	1af4                	.insn	2, 0x1af4
    1d8a:	0000                	.insn	2, 0x0000
    1d8c:	1b04                	.insn	2, 0x1b04
    1d8e:	0000                	.insn	2, 0x0000
    1d90:	1b18                	.insn	2, 0x1b18
	...

00001d94 <utimers>:
    1d94:	0000                	.insn	2, 0x0000
	...

00001d98 <nxt.0>:
    1d98:	0000                	.insn	2, 0x0000
	...

00001d9c <io>:
    1d9c:	0000                	.insn	2, 0x0000
    1d9e:	4000                	.insn	2, 0x4000
    1da0:	2641                	.insn	2, 0x2641
    1da2:	0000                	.insn	2, 0x0000
    1da4:	7200                	.insn	2, 0x7200
    1da6:	7369                	.insn	2, 0x7369
    1da8:	01007663          	bgeu	zero,a6,1db4 <io+0x18>
    1dac:	001c                	.insn	2, 0x001c
    1dae:	0000                	.insn	2, 0x0000
    1db0:	7205                	.insn	2, 0x7205
    1db2:	3376                	.insn	2, 0x3376
    1db4:	6532                	.insn	2, 0x6532
    1db6:	7031                	.insn	2, 0x7031
    1db8:	5f39                	.insn	2, 0x5f39
    1dba:	697a                	.insn	2, 0x697a
    1dbc:	32727363          	bgeu	tp,t2,20e2 <_stack+0xe2>
    1dc0:	3070                	.insn	2, 0x3070
    1dc2:	0800                	.insn	2, 0x0800
    1dc4:	0a01                	.insn	2, 0x0a01
    1dc6:	          	.insn	4, 0x000b

00001dc8 <_GLOBAL_OFFSET_TABLE_>:
    1dc8:	0000                	.insn	2, 0x0000
    1dca:	0000                	.insn	2, 0x0000
    1dcc:	2594                	.insn	2, 0x2594
    1dce:	0000                	.insn	2, 0x0000
    1dd0:	0200                	.insn	2, 0x0200
    1dd2:	0000                	.insn	2, 0x0000
    1dd4:	2000                	.insn	2, 0x2000
    1dd6:	0000                	.insn	2, 0x0000
    1dd8:	ffff                	.insn	2, 0xffff
    1dda:	ffff                	.insn	2, 0xffff
    1ddc:	0000                	.insn	2, 0x0000
    1dde:	0000                	.insn	2, 0x0000
    1de0:	3a434347          	.insn	4, 0x3a434347
    1de4:	2820                	.insn	2, 0x2820
    1de6:	29554e47          	.insn	4, 0x29554e47
    1dea:	3120                	.insn	2, 0x3120
    1dec:	2e35                	.insn	2, 0x2e35
    1dee:	2e30                	.insn	2, 0x2e30
    1df0:	2031                	.insn	2, 0x2031
    1df2:	3032                	.insn	2, 0x3032
    1df4:	3532                	.insn	2, 0x3532
    1df6:	3230                	.insn	2, 0x3230
    1df8:	3430                	.insn	2, 0x3430
    1dfa:	2820                	.insn	2, 0x2820
    1dfc:	7865                	.insn	2, 0x7865
    1dfe:	6570                	.insn	2, 0x6570
    1e00:	6972                	.insn	2, 0x6972
    1e02:	656d                	.insn	2, 0x656d
    1e04:	746e                	.insn	2, 0x746e
    1e06:	6c61                	.insn	2, 0x6c61
    1e08:	0029                	.insn	2, 0x0029
    1e0a:	2441                	.insn	2, 0x2441
    1e0c:	0000                	.insn	2, 0x0000
    1e0e:	7200                	.insn	2, 0x7200
    1e10:	7369                	.insn	2, 0x7369
    1e12:	01007663          	bgeu	zero,a6,1e1e <_GLOBAL_OFFSET_TABLE_+0x56>
    1e16:	001a                	.insn	2, 0x001a
    1e18:	0000                	.insn	2, 0x0000
    1e1a:	0404                	.insn	2, 0x0404
    1e1c:	7205                	.insn	2, 0x7205
    1e1e:	3376                	.insn	2, 0x3376
    1e20:	6532                	.insn	2, 0x6532
    1e22:	7032                	.insn	2, 0x7032
    1e24:	5f30                	.insn	2, 0x5f30
    1e26:	697a                	.insn	2, 0x697a
    1e28:	32727363          	bgeu	tp,t2,214e <_stack+0x14e>
    1e2c:	3070                	.insn	2, 0x3070
    1e2e:	4100                	.insn	2, 0x4100
    1e30:	0024                	.insn	2, 0x0024
    1e32:	0000                	.insn	2, 0x0000
    1e34:	6972                	.insn	2, 0x6972
    1e36:	00766373          	csrrsi	t1,0x7,12
    1e3a:	1a01                	.insn	2, 0x1a01
    1e3c:	0000                	.insn	2, 0x0000
    1e3e:	0400                	.insn	2, 0x0400
    1e40:	0504                	.insn	2, 0x0504
    1e42:	7672                	.insn	2, 0x7672
    1e44:	32653233          	.insn	4, 0x32653233
    1e48:	3070                	.insn	2, 0x3070
    1e4a:	7a5f 6369 7273      	.insn	6, 0x727363697a5f
    1e50:	7032                	.insn	2, 0x7032
    1e52:	0030                	.insn	2, 0x0030
    1e54:	2841                	.insn	2, 0x2841
    1e56:	0000                	.insn	2, 0x0000
    1e58:	7200                	.insn	2, 0x7200
    1e5a:	7369                	.insn	2, 0x7369
    1e5c:	01007663          	bgeu	zero,a6,1e68 <_GLOBAL_OFFSET_TABLE_+0xa0>
    1e60:	001e                	.insn	2, 0x001e
    1e62:	0000                	.insn	2, 0x0000
    1e64:	0404                	.insn	2, 0x0404
    1e66:	7205                	.insn	2, 0x7205
    1e68:	3376                	.insn	2, 0x3376
    1e6a:	6532                	.insn	2, 0x6532
    1e6c:	7032                	.insn	2, 0x7032
    1e6e:	5f30                	.insn	2, 0x5f30
    1e70:	697a                	.insn	2, 0x697a
    1e72:	32727363          	bgeu	tp,t2,2198 <_stack+0x198>
    1e76:	3070                	.insn	2, 0x3070
    1e78:	0800                	.insn	2, 0x0800
    1e7a:	0a01                	.insn	2, 0x0a01
    1e7c:	0024410b          	.insn	4, 0x0024410b
    1e80:	0000                	.insn	2, 0x0000
    1e82:	6972                	.insn	2, 0x6972
    1e84:	00766373          	csrrsi	t1,0x7,12
    1e88:	1a01                	.insn	2, 0x1a01
    1e8a:	0000                	.insn	2, 0x0000
    1e8c:	0400                	.insn	2, 0x0400
    1e8e:	0504                	.insn	2, 0x0504
    1e90:	7672                	.insn	2, 0x7672
    1e92:	32653233          	.insn	4, 0x32653233
    1e96:	3070                	.insn	2, 0x3070
    1e98:	7a5f 6369 7273      	.insn	6, 0x727363697a5f
    1e9e:	7032                	.insn	2, 0x7032
    1ea0:	0030                	.insn	2, 0x0030
    1ea2:	2441                	.insn	2, 0x2441
    1ea4:	0000                	.insn	2, 0x0000
    1ea6:	7200                	.insn	2, 0x7200
    1ea8:	7369                	.insn	2, 0x7369
    1eaa:	01007663          	bgeu	zero,a6,1eb6 <_GLOBAL_OFFSET_TABLE_+0xee>
    1eae:	001a                	.insn	2, 0x001a
    1eb0:	0000                	.insn	2, 0x0000
    1eb2:	0404                	.insn	2, 0x0404
    1eb4:	7205                	.insn	2, 0x7205
    1eb6:	3376                	.insn	2, 0x3376
    1eb8:	6532                	.insn	2, 0x6532
    1eba:	7032                	.insn	2, 0x7032
    1ebc:	5f30                	.insn	2, 0x5f30
    1ebe:	697a                	.insn	2, 0x697a
    1ec0:	32727363          	bgeu	tp,t2,21e6 <_stack+0x1e6>
    1ec4:	3070                	.insn	2, 0x3070
    1ec6:	4100                	.insn	2, 0x4100
    1ec8:	0026                	.insn	2, 0x0026
    1eca:	0000                	.insn	2, 0x0000
    1ecc:	6972                	.insn	2, 0x6972
    1ece:	00766373          	csrrsi	t1,0x7,12
    1ed2:	1c01                	.insn	2, 0x1c01
    1ed4:	0000                	.insn	2, 0x0000
    1ed6:	0500                	.insn	2, 0x0500
    1ed8:	7672                	.insn	2, 0x7672
    1eda:	31653233          	.insn	4, 0x31653233
    1ede:	3970                	.insn	2, 0x3970
    1ee0:	7a5f 6369 7273      	.insn	6, 0x727363697a5f
    1ee6:	7032                	.insn	2, 0x7032
    1ee8:	0030                	.insn	2, 0x0030
    1eea:	0108                	.insn	2, 0x0108
    1eec:	0b0a                	.insn	2, 0x0b0a
	...
