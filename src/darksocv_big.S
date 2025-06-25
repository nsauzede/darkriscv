
darksocv.o:     file format elf32-bigriscv


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
      18:	00a7a423          	sw	a0,8(a5) # 40000008 <_global+0x3fffda78>
      1c:	00078503          	lb	a0,0(a5)
      20:	04050a63          	beqz	a0,74 <_normal_boot>
      24:	07500513          	li	a0,117
      28:	0d0000ef          	jal	f8 <_uart_putchar>
      2c:	007d05b7          	lui	a1,0x7d0
      30:	00002617          	auipc	a2,0x2
      34:	d9c62603          	lw	a2,-612(a2) # 1dcc <_GLOBAL_OFFSET_TABLE_+0x8>
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
      d8:	cfc12103          	lw	sp,-772(sp) # 1dd0 <_GLOBAL_OFFSET_TABLE_+0xc>
      dc:	00002197          	auipc	gp,0x2
      e0:	cec1a183          	lw	gp,-788(gp) # 1dc8 <_GLOBAL_OFFSET_TABLE_+0x4>
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
     20c:	b9040413          	addi	s0,s0,-1136 # 1d98 <io>
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
     254:	b4072023          	sw	zero,-1216(a4) # 1d90 <utimers>
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
     2fc:	54878793          	addi	a5,a5,1352 # 1840 <_etext+0x258>
     300:	00e51663          	bne	a0,a4,30c <main+0x10c>
     304:	00001797          	auipc	a5,0x1
     308:	2ec78793          	addi	a5,a5,748 # 15f0 <_etext+0x8>
     30c:	00078513          	mv	a0,a5
     310:	2dd000ef          	jal	dec <printf>
     314:	00001517          	auipc	a0,0x1
     318:	38450513          	addi	a0,a0,900 # 1698 <_etext+0xb0>
     31c:	2d1000ef          	jal	dec <printf>
     320:	00001517          	auipc	a0,0x1
     324:	3f450513          	addi	a0,a0,1012 # 1714 <_etext+0x12c>
     328:	2c5000ef          	jal	dec <printf>
     32c:	00001697          	auipc	a3,0x1
     330:	2bc68693          	addi	a3,a3,700 # 15e8 <_etext>
     334:	00000597          	auipc	a1,0x0
     338:	ecc58593          	addi	a1,a1,-308 # 200 <main>
     33c:	00002497          	auipc	s1,0x2
     340:	bb048493          	addi	s1,s1,-1104 # 1eec <_edata>
     344:	00001617          	auipc	a2,0x1
     348:	2a460613          	addi	a2,a2,676 # 15e8 <_etext>
     34c:	40d48733          	sub	a4,s1,a3
     350:	40b60633          	sub	a2,a2,a1
     354:	00002797          	auipc	a5,0x2
     358:	cac78793          	addi	a5,a5,-852 # 2000 <_stack>
     35c:	00001517          	auipc	a0,0x1
     360:	34850513          	addi	a0,a0,840 # 16a4 <_etext+0xbc>
     364:	289000ef          	jal	dec <printf>
     368:	00002797          	auipc	a5,0x2
     36c:	c9878793          	addi	a5,a5,-872 # 2000 <_stack>
     370:	409785b3          	sub	a1,a5,s1
     374:	00001517          	auipc	a0,0x1
     378:	35850513          	addi	a0,a0,856 # 16cc <_etext+0xe4>
     37c:	271000ef          	jal	dec <printf>
     380:	deadc7b7          	lui	a5,0xdeadc
     384:	eef78793          	addi	a5,a5,-273 # deadbeef <_global+0xdead995f>
     388:	00f4a023          	sw	a5,0(s1)
     38c:	00042783          	lw	a5,0(s0)
     390:	0067d503          	lhu	a0,6(a5)
     394:	108010ef          	jal	149c <bswap16>
     398:	00050593          	mv	a1,a0
     39c:	00001517          	auipc	a0,0x1
     3a0:	34850513          	addi	a0,a0,840 # 16e4 <_etext+0xfc>
     3a4:	249000ef          	jal	dec <printf>
     3a8:	00042783          	lw	a5,0(s0)
     3ac:	001e85b7          	lui	a1,0x1e8
     3b0:	48058593          	addi	a1,a1,1152 # 1e8480 <_global+0x1e5ef0>
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
     3dc:	32850513          	addi	a0,a0,808 # 1700 <_etext+0x118>
     3e0:	20d000ef          	jal	dec <printf>
     3e4:	01000637          	lui	a2,0x1000
     3e8:	000105b7          	lui	a1,0x10
     3ec:	fff58593          	addi	a1,a1,-1 # ffff <_global+0xda6f>
     3f0:	f0060613          	addi	a2,a2,-256 # ffff00 <_global+0xffd970>
     3f4:	ffff0537          	lui	a0,0xffff0
     3f8:	1d8010ef          	jal	15d0 <csr_test>
     3fc:	00050593          	mv	a1,a0
     400:	1c050663          	beqz	a0,5cc <main+0x3cc>
     404:	00001517          	auipc	a0,0x1
     408:	31450513          	addi	a0,a0,788 # 1718 <_etext+0x130>
     40c:	1e1000ef          	jal	dec <printf>
     410:	00001517          	auipc	a0,0x1
     414:	be850513          	addi	a0,a0,-1048 # ff8 <dbg_handler>
     418:	180010ef          	jal	1598 <set_stvec>
     41c:	0f8010ef          	jal	1514 <get_stvec>
     420:	00050413          	mv	s0,a0
     424:	1a050c63          	beqz	a0,5dc <main+0x3dc>
     428:	00050593          	mv	a1,a0
     42c:	00001517          	auipc	a0,0x1
     430:	31450513          	addi	a0,a0,788 # 1740 <_etext+0x158>
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
     468:	31850513          	addi	a0,a0,792 # 177c <_etext+0x194>
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
     494:	31850513          	addi	a0,a0,792 # 17a8 <_etext+0x1c0>
     498:	155000ef          	jal	dec <printf>
     49c:	00001517          	auipc	a0,0x1
     4a0:	27850513          	addi	a0,a0,632 # 1714 <_etext+0x12c>
     4a4:	149000ef          	jal	dec <printf>
     4a8:	00001517          	auipc	a0,0x1
     4ac:	33850513          	addi	a0,a0,824 # 17e0 <_etext+0x1f8>
     4b0:	13d000ef          	jal	dec <printf>
     4b4:	00012823          	sw	zero,16(sp)
     4b8:	02000613          	li	a2,32
     4bc:	00000593          	li	a1,0
     4c0:	02410513          	addi	a0,sp,36
     4c4:	60d000ef          	jal	12d0 <memset>
     4c8:	00002497          	auipc	s1,0x2
     4cc:	8d048493          	addi	s1,s1,-1840 # 1d98 <io>
     4d0:	0004a783          	lw	a5,0(s1)
     4d4:	00001517          	auipc	a0,0x1
     4d8:	32450513          	addi	a0,a0,804 # 17f8 <_etext+0x210>
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
     504:	23f70713          	addi	a4,a4,575 # f423f <_global+0xf1caf>
     508:	0004a783          	lw	a5,0(s1)
     50c:	0037c683          	lbu	a3,3(a5)
     510:	02c69463          	bne	a3,a2,538 <main+0x338>
     514:	00002697          	auipc	a3,0x2
     518:	87c6a683          	lw	a3,-1924(a3) # 1d90 <utimers>
     51c:	fff68513          	addi	a0,a3,-1
     520:	00002317          	auipc	t1,0x2
     524:	86a32823          	sw	a0,-1936(t1) # 1d90 <utimers>
     528:	00069663          	bnez	a3,534 <main+0x334>
     52c:	00002697          	auipc	a3,0x2
     530:	86e6a223          	sw	a4,-1948(a3) # 1d90 <utimers>
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
     568:	29c58593          	addi	a1,a1,668 # 1800 <_etext+0x218>
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
     5ac:	25c58593          	addi	a1,a1,604 # 1804 <_etext+0x21c>
     5b0:	00078513          	mv	a0,a5
     5b4:	425000ef          	jal	11d8 <strcmp>
     5b8:	04051063          	bnez	a0,5f8 <main+0x3f8>
     5bc:	00001517          	auipc	a0,0x1
     5c0:	25050513          	addi	a0,a0,592 # 180c <_etext+0x224>
     5c4:	029000ef          	jal	dec <printf>
     5c8:	ef1ff06f          	j	4b8 <main+0x2b8>
     5cc:	00001517          	auipc	a0,0x1
     5d0:	16050513          	addi	a0,a0,352 # 172c <_etext+0x144>
     5d4:	019000ef          	jal	dec <printf>
     5d8:	e39ff06f          	j	410 <main+0x210>
     5dc:	00001517          	auipc	a0,0x1
     5e0:	18c50513          	addi	a0,a0,396 # 1768 <_etext+0x180>
     5e4:	009000ef          	jal	dec <printf>
     5e8:	e51ff06f          	j	438 <main+0x238>
     5ec:	00001517          	auipc	a0,0x1
     5f0:	1d850513          	addi	a0,a0,472 # 17c4 <_etext+0x1dc>
     5f4:	ea5ff06f          	j	498 <main+0x298>
     5f8:	00012503          	lw	a0,0(sp)
     5fc:	00001597          	auipc	a1,0x1
     600:	21858593          	addi	a1,a1,536 # 1814 <_etext+0x22c>
     604:	3d5000ef          	jal	11d8 <strcmp>
     608:	00051663          	bnez	a0,614 <main+0x414>
     60c:	00100073          	ebreak
     610:	ea9ff06f          	j	4b8 <main+0x2b8>
     614:	00012503          	lw	a0,0(sp)
     618:	00001597          	auipc	a1,0x1
     61c:	20458593          	addi	a1,a1,516 # 181c <_etext+0x234>
     620:	3b9000ef          	jal	11d8 <strcmp>
     624:	06051263          	bnez	a0,688 <main+0x488>
     628:	781000ef          	jal	15a8 <set_mie>
     62c:	00001517          	auipc	a0,0x1
     630:	1f850513          	addi	a0,a0,504 # 1824 <_etext+0x23c>
     634:	7b8000ef          	jal	dec <printf>
     638:	00001517          	auipc	a0,0x1
     63c:	20c50513          	addi	a0,a0,524 # 1844 <_etext+0x25c>
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
     690:	1c858593          	addi	a1,a1,456 # 1854 <_etext+0x26c>
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
     6bc:	1a450513          	addi	a0,a0,420 # 185c <_etext+0x274>
     6c0:	72c000ef          	jal	dec <printf>
     6c4:	00000793          	li	a5,0
     6c8:	00f48733          	add	a4,s1,a5
     6cc:	00074583          	lbu	a1,0(a4)
     6d0:	00001517          	auipc	a0,0x1
     6d4:	19450513          	addi	a0,a0,404 # 1864 <_etext+0x27c>
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
     748:	12458593          	addi	a1,a1,292 # 1868 <_etext+0x280>
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
     798:	0c850513          	addi	a0,a0,200 # 185c <_etext+0x274>
     79c:	650000ef          	jal	dec <printf>
     7a0:	01812783          	lw	a5,24(sp)
     7a4:	08879063          	bne	a5,s0,824 <main+0x624>
     7a8:	00001517          	auipc	a0,0x1
     7ac:	f6c50513          	addi	a0,a0,-148 # 1714 <_etext+0x12c>
     7b0:	e15ff06f          	j	5c4 <main+0x3c4>
     7b4:	00012503          	lw	a0,0(sp)
     7b8:	00200613          	li	a2,2
     7bc:	00001597          	auipc	a1,0x1
     7c0:	0b058593          	addi	a1,a1,176 # 186c <_etext+0x284>
     7c4:	1dd000ef          	jal	11a0 <strncmp>
     7c8:	f80506e3          	beqz	a0,754 <main+0x554>
     7cc:	00012503          	lw	a0,0(sp)
     7d0:	00001597          	auipc	a1,0x1
     7d4:	0a058593          	addi	a1,a1,160 # 1870 <_etext+0x288>
     7d8:	201000ef          	jal	11d8 <strcmp>
     7dc:	1a051663          	bnez	a0,988 <main+0x788>
     7e0:	04812503          	lw	a0,72(sp)
     7e4:	00050863          	beqz	a0,7f4 <main+0x5f4>
     7e8:	734000ef          	jal	f1c <xtoi>
     7ec:	0004a783          	lw	a5,0(s1)
     7f0:	00a7a423          	sw	a0,8(a5)
     7f4:	0004a783          	lw	a5,0(s1)
     7f8:	00001517          	auipc	a0,0x1
     7fc:	07c50513          	addi	a0,a0,124 # 1874 <_etext+0x28c>
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
     85c:	00c50513          	addi	a0,a0,12 # 1864 <_etext+0x27c>
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
     888:	fe050513          	addi	a0,a0,-32 # 1864 <_etext+0x27c>
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
     8b4:	fb450513          	addi	a0,a0,-76 # 1864 <_etext+0x27c>
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
     914:	f5450513          	addi	a0,a0,-172 # 1864 <_etext+0x27c>
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
     948:	f2050513          	addi	a0,a0,-224 # 1864 <_etext+0x27c>
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
     978:	ef050513          	addi	a0,a0,-272 # 1864 <_etext+0x27c>
     97c:	470000ef          	jal	dec <printf>
     980:	01c12483          	lw	s1,28(sp)
     984:	f41ff06f          	j	8c4 <main+0x6c4>
     988:	00012503          	lw	a0,0(sp)
     98c:	00001597          	auipc	a1,0x1
     990:	ef458593          	addi	a1,a1,-268 # 1880 <_etext+0x298>
     994:	045000ef          	jal	11d8 <strcmp>
     998:	02051663          	bnez	a0,9c4 <main+0x7c4>
     99c:	04812503          	lw	a0,72(sp)
     9a0:	00050863          	beqz	a0,9b0 <main+0x7b0>
     9a4:	51c000ef          	jal	ec0 <atoi>
     9a8:	0004a783          	lw	a5,0(s1)
     9ac:	00a7a623          	sw	a0,12(a5)
     9b0:	0004a783          	lw	a5,0(s1)
     9b4:	00001517          	auipc	a0,0x1
     9b8:	ed450513          	addi	a0,a0,-300 # 1888 <_etext+0x2a0>
     9bc:	00c7a583          	lw	a1,12(a5)
     9c0:	e45ff06f          	j	804 <main+0x604>
     9c4:	00012503          	lw	a0,0(sp)
     9c8:	00001597          	auipc	a1,0x1
     9cc:	ecc58593          	addi	a1,a1,-308 # 1894 <_etext+0x2ac>
     9d0:	009000ef          	jal	11d8 <strcmp>
     9d4:	02051663          	bnez	a0,a00 <main+0x800>
     9d8:	04812503          	lw	a0,72(sp)
     9dc:	00050863          	beqz	a0,9ec <main+0x7ec>
     9e0:	53c000ef          	jal	f1c <xtoi>
     9e4:	0004a783          	lw	a5,0(s1)
     9e8:	00a7ac23          	sw	a0,24(a5)
     9ec:	0004a783          	lw	a5,0(s1)
     9f0:	00001517          	auipc	a0,0x1
     9f4:	eac50513          	addi	a0,a0,-340 # 189c <_etext+0x2b4>
     9f8:	0187a583          	lw	a1,24(a5)
     9fc:	e09ff06f          	j	804 <main+0x604>
     a00:	00012503          	lw	a0,0(sp)
     a04:	00001597          	auipc	a1,0x1
     a08:	ea458593          	addi	a1,a1,-348 # 18a8 <_etext+0x2c0>
     a0c:	7cc000ef          	jal	11d8 <strcmp>
     a10:	00051c63          	bnez	a0,a28 <main+0x828>
     a14:	0004a783          	lw	a5,0(s1)
     a18:	00001517          	auipc	a0,0x1
     a1c:	e9850513          	addi	a0,a0,-360 # 18b0 <_etext+0x2c8>
     a20:	0147a583          	lw	a1,20(a5)
     a24:	de1ff06f          	j	804 <main+0x604>
     a28:	00012503          	lw	a0,0(sp)
     a2c:	00001597          	auipc	a1,0x1
     a30:	e9058593          	addi	a1,a1,-368 # 18bc <_etext+0x2d4>
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
     a64:	e6050513          	addi	a0,a0,-416 # 18c0 <_etext+0x2d8>
     a68:	d9dff06f          	j	804 <main+0x604>
     a6c:	00012503          	lw	a0,0(sp)
     a70:	00001597          	auipc	a1,0x1
     a74:	e5c58593          	addi	a1,a1,-420 # 18cc <_etext+0x2e4>
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
     ac0:	e1450513          	addi	a0,a0,-492 # 18d0 <_etext+0x2e8>
     ac4:	328000ef          	jal	dec <printf>
     ac8:	9f1ff06f          	j	4b8 <main+0x2b8>
     acc:	00012503          	lw	a0,0(sp)
     ad0:	00001597          	auipc	a1,0x1
     ad4:	e1458593          	addi	a1,a1,-492 # 18e4 <_etext+0x2fc>
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
     b20:	dcc50513          	addi	a0,a0,-564 # 18e8 <_etext+0x300>
     b24:	ce1ff06f          	j	804 <main+0x604>
     b28:	00012503          	lw	a0,0(sp)
     b2c:	00001597          	auipc	a1,0x1
     b30:	dc858593          	addi	a1,a1,-568 # 18f4 <_etext+0x30c>
     b34:	6a4000ef          	jal	11d8 <strcmp>
     b38:	02051063          	bnez	a0,b58 <main+0x958>
     b3c:	04812503          	lw	a0,72(sp)
     b40:	3dc000ef          	jal	f1c <xtoi>
     b44:	00050593          	mv	a1,a0
     b48:	40155613          	srai	a2,a0,0x1
     b4c:	00001517          	auipc	a0,0x1
     b50:	db050513          	addi	a0,a0,-592 # 18fc <_etext+0x314>
     b54:	f71ff06f          	j	ac4 <main+0x8c4>
     b58:	00012783          	lw	a5,0(sp)
     b5c:	0007c783          	lbu	a5,0(a5)
     b60:	94078ce3          	beqz	a5,4b8 <main+0x2b8>
     b64:	00012583          	lw	a1,0(sp)
     b68:	00001517          	auipc	a0,0x1
     b6c:	da850513          	addi	a0,a0,-600 # 1910 <_etext+0x328>
     b70:	c95ff06f          	j	804 <main+0x604>

00000b74 <getchar>:
     b74:	00001717          	auipc	a4,0x1
     b78:	22472703          	lw	a4,548(a4) # 1d98 <io>
     b7c:	00474783          	lbu	a5,4(a4)
     b80:	0027f793          	andi	a5,a5,2
     b84:	fe078ce3          	beqz	a5,b7c <getchar+0x8>
     b88:	00574503          	lbu	a0,5(a4)
     b8c:	00008067          	ret

00000b90 <putchar>:
     b90:	00a00713          	li	a4,10
     b94:	00001797          	auipc	a5,0x1
     b98:	2047a783          	lw	a5,516(a5) # 1d98 <io>
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
     c88:	dac40413          	addi	s0,s0,-596 # 1a30 <_etext+0x448>
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
     ce4:	d5858593          	addi	a1,a1,-680 # 1a38 <_etext+0x450>
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
     f70:	db478793          	addi	a5,a5,-588 # 1d20 <CSWTCH.10>
     f74:	00a787b3          	add	a5,a5,a0
     f78:	0007a503          	lw	a0,0(a5)
     f7c:	00008067          	ret
     f80:	00001517          	auipc	a0,0x1
     f84:	acc50513          	addi	a0,a0,-1332 # 1a4c <_etext+0x464>
     f88:	00008067          	ret

00000f8c <irq_handler>:
     f8c:	ff010113          	addi	sp,sp,-16
     f90:	00f12023          	sw	a5,0(sp)
     f94:	00001797          	auipc	a5,0x1
     f98:	e047a783          	lw	a5,-508(a5) # 1d98 <io>
     f9c:	00e12223          	sw	a4,4(sp)
     fa0:	00c12623          	sw	a2,12(sp)
     fa4:	00d12423          	sw	a3,8(sp)
     fa8:	0037c683          	lbu	a3,3(a5)
     fac:	08000713          	li	a4,128
     fb0:	02e69863          	bne	a3,a4,fe0 <irq_handler+0x54>
     fb4:	00001717          	auipc	a4,0x1
     fb8:	ddc72703          	lw	a4,-548(a4) # 1d90 <utimers>
     fbc:	fff70693          	addi	a3,a4,-1
     fc0:	00001617          	auipc	a2,0x1
     fc4:	dcd62823          	sw	a3,-560(a2) # 1d90 <utimers>
     fc8:	00071863          	bnez	a4,fd8 <irq_handler+0x4c>
     fcc:	06300713          	li	a4,99
     fd0:	00001697          	auipc	a3,0x1
     fd4:	dce6a023          	sw	a4,-576(a3) # 1d90 <utimers>
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
    103c:	a1c68693          	addi	a3,a3,-1508 # 1a54 <_etext+0x46c>
    1040:	02060663          	beqz	a2,106c <dbg_handler+0x74>
    1044:	fff60793          	addi	a5,a2,-1
    1048:	00600713          	li	a4,6
    104c:	00001697          	auipc	a3,0x1
    1050:	a0068693          	addi	a3,a3,-1536 # 1a4c <_etext+0x464>
    1054:	00f76c63          	bltu	a4,a5,106c <dbg_handler+0x74>
    1058:	00279793          	slli	a5,a5,0x2
    105c:	00001717          	auipc	a4,0x1
    1060:	cc470713          	addi	a4,a4,-828 # 1d20 <CSWTCH.10>
    1064:	00f707b3          	add	a5,a4,a5
    1068:	0547a683          	lw	a3,84(a5)
    106c:	00001517          	auipc	a0,0x1
    1070:	a0450513          	addi	a0,a0,-1532 # 1a70 <_etext+0x488>
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
    10b8:	ce47a783          	lw	a5,-796(a5) # 1d98 <io>
    10bc:	ff810113          	addi	sp,sp,-8
    10c0:	00812023          	sw	s0,0(sp)
    10c4:	00050413          	mv	s0,a0
    10c8:	0107a503          	lw	a0,16(a5)
    10cc:	000f45b7          	lui	a1,0xf4
    10d0:	24058593          	addi	a1,a1,576 # f4240 <_global+0xf1cb0>
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
    10f8:	ca47a783          	lw	a5,-860(a5) # 1d98 <io>
    10fc:	0107a503          	lw	a0,16(a5)
    1100:	00008067          	ret

00001104 <gettimeofday>:
    1104:	00001797          	auipc	a5,0x1
    1108:	c947a783          	lw	a5,-876(a5) # 1d98 <io>
    110c:	ff410113          	addi	sp,sp,-12
    1110:	00912023          	sw	s1,0(sp)
    1114:	0107a483          	lw	s1,16(a5)
    1118:	00112423          	sw	ra,8(sp)
    111c:	00812223          	sw	s0,4(sp)
    1120:	04050463          	beqz	a0,1168 <gettimeofday+0x64>
    1124:	000f45b7          	lui	a1,0xf4
    1128:	00050413          	mv	s0,a0
    112c:	24058593          	addi	a1,a1,576 # f4240 <_global+0xf1cb0>
    1130:	00048513          	mv	a0,s1
    1134:	29c000ef          	jal	13d0 <__udivsi3>
    1138:	000f45b7          	lui	a1,0xf4
    113c:	00a42023          	sw	a0,0(s0)
    1140:	24058593          	addi	a1,a1,576 # f4240 <_global+0xf1cb0>
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
    121c:	b7c4a483          	lw	s1,-1156(s1) # 1d94 <nxt.0>
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
    1260:	b2e7ac23          	sw	a4,-1224(a5) # 1d94 <nxt.0>
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
    1602:	3a30746f          	jal	s0,91a4 <_global+0x6c14>
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
    1650:	3431                	.insn	2, 0x3431
    1652:	303a                	.insn	2, 0x303a
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
    1698:	6962                	.insn	2, 0x6962
    169a:	6e652d67          	.insn	4, 0x6e652d67
    169e:	6964                	.insn	2, 0x6964
    16a0:	6e61                	.insn	2, 0x6e61
    16a2:	0020                	.insn	2, 0x0020
    16a4:	7262                	.insn	2, 0x7262
    16a6:	6d61                	.insn	2, 0x6d61
    16a8:	3a30                	.insn	2, 0x3a30
    16aa:	7420                	.insn	2, 0x7420
    16ac:	7865                	.insn	2, 0x7865
    16ae:	4074                	.insn	2, 0x4074
    16b0:	7825                	.insn	2, 0x7825
    16b2:	2078252b          	.insn	4, 0x2078252b
    16b6:	6164                	.insn	2, 0x6164
    16b8:	6174                	.insn	2, 0x6174
    16ba:	2540                	.insn	2, 0x2540
    16bc:	2b78                	.insn	2, 0x2b78
    16be:	7825                	.insn	2, 0x7825
    16c0:	7320                	.insn	2, 0x7320
    16c2:	6174                	.insn	2, 0x6174
    16c4:	25406b63          	bltu	zero,s4,191a <_data+0x332>
    16c8:	0a78                	.insn	2, 0x0a78
    16ca:	0000                	.insn	2, 0x0000
    16cc:	7262                	.insn	2, 0x7262
    16ce:	6d61                	.insn	2, 0x6d61
    16d0:	3a30                	.insn	2, 0x3a30
    16d2:	2520                	.insn	2, 0x2520
    16d4:	2064                	.insn	2, 0x2064
    16d6:	7962                	.insn	2, 0x7962
    16d8:	6574                	.insn	2, 0x6574
    16da:	72662073          	csrs	mhpmevent6h,a2
    16de:	6565                	.insn	2, 0x6565
    16e0:	000a                	.insn	2, 0x000a
    16e2:	0000                	.insn	2, 0x0000
    16e4:	6175                	.insn	2, 0x6175
    16e6:	7472                	.insn	2, 0x7472
    16e8:	3a30                	.insn	2, 0x3a30
    16ea:	3120                	.insn	2, 0x3120
    16ec:	3531                	.insn	2, 0x3531
    16ee:	322e                	.insn	2, 0x322e
    16f0:	7370626b          	.insn	4, 0x7370626b
    16f4:	2820                	.insn	2, 0x2820
    16f6:	6964                	.insn	2, 0x6964
    16f8:	3d76                	.insn	2, 0x3d76
    16fa:	6425                	.insn	2, 0x6425
    16fc:	0a29                	.insn	2, 0x0a29
    16fe:	0000                	.insn	2, 0x0000
    1700:	6974                	.insn	2, 0x6974
    1702:	726d                	.insn	2, 0x726d
    1704:	3a30                	.insn	2, 0x3a30
    1706:	2520                	.insn	2, 0x2520
    1708:	4864                	.insn	2, 0x4864
    170a:	207a                	.insn	2, 0x207a
    170c:	6428                	.insn	2, 0x6428
    170e:	7669                	.insn	2, 0x7669
    1710:	253d                	.insn	2, 0x253d
    1712:	2964                	.insn	2, 0x2964
    1714:	000a                	.insn	2, 0x000a
    1716:	0000                	.insn	2, 0x0000
    1718:	78727363          	bgeu	tp,t2,1e9e <_GLOBAL_OFFSET_TABLE_+0xda>
    171c:	3a78                	.insn	2, 0x3a78
    171e:	6320                	.insn	2, 0x6320
    1720:	745f7273          	csrrci	tp,0x745,30
    1724:	7365                	.insn	2, 0x7365
    1726:	3d74                	.insn	2, 0x3d74
    1728:	7825                	.insn	2, 0x7825
    172a:	000a                	.insn	2, 0x000a
    172c:	78727363          	bgeu	tp,t2,1eb2 <_GLOBAL_OFFSET_TABLE_+0xee>
    1730:	3a78                	.insn	2, 0x3a78
    1732:	6e20                	.insn	2, 0x6e20
    1734:	6620746f          	jal	s0,8d96 <_global+0x6806>
    1738:	646e756f          	jal	a0,e8d7e <_global+0xe67ee>
    173c:	000a                	.insn	2, 0x000a
    173e:	0000                	.insn	2, 0x0000
    1740:	65767473          	csrrci	s0,hviprio2h,12
    1744:	68203a63          	.insn	4, 0x68203a63
    1748:	6e61                	.insn	2, 0x6e61
    174a:	6c64                	.insn	2, 0x6c64
    174c:	7265                	.insn	2, 0x7265
    174e:	2540                	.insn	2, 0x2540
    1750:	2c78                	.insn	2, 0x2c78
    1752:	6420                	.insn	2, 0x6420
    1754:	6265                	.insn	2, 0x6265
    1756:	6775                	.insn	2, 0x6775
    1758:	6520                	.insn	2, 0x6520
    175a:	616e                	.insn	2, 0x616e
    175c:	6c62                	.insn	2, 0x6c62
    175e:	6465                	.insn	2, 0x6465
    1760:	2e2e                	.insn	2, 0x2e2e
    1762:	0a2e                	.insn	2, 0x0a2e
    1764:	0000                	.insn	2, 0x0000
    1766:	0000                	.insn	2, 0x0000
    1768:	65767473          	csrrci	s0,hviprio2h,12
    176c:	6e203a63          	.insn	4, 0x6e203a63
    1770:	6620746f          	jal	s0,8dd2 <_global+0x6842>
    1774:	646e756f          	jal	a0,e8dba <_global+0xe682a>
    1778:	000a                	.insn	2, 0x000a
    177a:	0000                	.insn	2, 0x0000
    177c:	746d                	.insn	2, 0x746d
    177e:	6576                	.insn	2, 0x6576
    1780:	68203a63          	.insn	4, 0x68203a63
    1784:	6e61                	.insn	2, 0x6e61
    1786:	6c64                	.insn	2, 0x6c64
    1788:	7265                	.insn	2, 0x7265
    178a:	2540                	.insn	2, 0x2540
    178c:	2c78                	.insn	2, 0x2c78
    178e:	6520                	.insn	2, 0x6520
    1790:	616e                	.insn	2, 0x616e
    1792:	6c62                	.insn	2, 0x6c62
    1794:	6e69                	.insn	2, 0x6e69
    1796:	6e692067          	.insn	4, 0x6e692067
    179a:	6574                	.insn	2, 0x6574
    179c:	7272                	.insn	2, 0x7272
    179e:	7075                	.insn	2, 0x7075
    17a0:	7374                	.insn	2, 0x7374
    17a2:	2e2e                	.insn	2, 0x2e2e
    17a4:	0a2e                	.insn	2, 0x0a2e
    17a6:	0000                	.insn	2, 0x0000
    17a8:	746d                	.insn	2, 0x746d
    17aa:	6576                	.insn	2, 0x6576
    17ac:	69203a63          	.insn	4, 0x69203a63
    17b0:	746e                	.insn	2, 0x746e
    17b2:	7265                	.insn	2, 0x7265
    17b4:	7572                	.insn	2, 0x7572
    17b6:	7470                	.insn	2, 0x7470
    17b8:	6e652073          	csrs	0x6e6,a0
    17bc:	6261                	.insn	2, 0x6261
    17be:	656c                	.insn	2, 0x656c
    17c0:	2164                	.insn	2, 0x2164
    17c2:	000a                	.insn	2, 0x000a
    17c4:	746d                	.insn	2, 0x746d
    17c6:	6576                	.insn	2, 0x6576
    17c8:	6e203a63          	.insn	4, 0x6e203a63
    17cc:	6620746f          	jal	s0,8e2e <_global+0x689e>
    17d0:	646e756f          	jal	a0,e8e16 <_global+0xe6886>
    17d4:	2820                	.insn	2, 0x2820
    17d6:	6f70                	.insn	2, 0x6f70
    17d8:	6c6c                	.insn	2, 0x6c6c
    17da:	6e69                	.insn	2, 0x6e69
    17dc:	000a2967          	.insn	4, 0x000a2967
    17e0:	636c6557          	.insn	4, 0x636c6557
    17e4:	20656d6f          	jal	s10,579ea <_global+0x5545a>
    17e8:	6f74                	.insn	2, 0x6f74
    17ea:	4420                	.insn	2, 0x4420
    17ec:	7261                	.insn	2, 0x7261
    17ee:	5349526b          	.insn	4, 0x5349526b
    17f2:	0a215643          	.insn	4, 0x0a215643
    17f6:	000a                	.insn	2, 0x000a
    17f8:	6425                	.insn	2, 0x6425
    17fa:	203e                	.insn	2, 0x203e
    17fc:	0000                	.insn	2, 0x0000
    17fe:	0000                	.insn	2, 0x0000
    1800:	0020                	.insn	2, 0x0020
    1802:	0000                	.insn	2, 0x0000
    1804:	61656c63          	bltu	a0,s6,1e1c <_GLOBAL_OFFSET_TABLE_+0x58>
    1808:	0072                	.insn	2, 0x0072
    180a:	0000                	.insn	2, 0x0000
    180c:	1b485b1b          	.insn	4, 0x1b485b1b
    1810:	004a325b          	.insn	4, 0x004a325b
    1814:	706f7473          	csrrci	s0,0x706,30
    1818:	0000                	.insn	2, 0x0000
    181a:	0000                	.insn	2, 0x0000
    181c:	6572                	.insn	2, 0x6572
    181e:	6f62                	.insn	2, 0x6f62
    1820:	0000746f          	jal	s0,8820 <_global+0x6290>
    1824:	746d                	.insn	2, 0x746d
    1826:	6576                	.insn	2, 0x6576
    1828:	69203a63          	.insn	4, 0x69203a63
    182c:	746e                	.insn	2, 0x746e
    182e:	7265                	.insn	2, 0x7265
    1830:	7572                	.insn	2, 0x7572
    1832:	7470                	.insn	2, 0x7470
    1834:	69642073          	csrs	0x696,s0
    1838:	6c626173          	csrrsi	sp,0x6c6,4
    183c:	6465                	.insn	2, 0x6465
    183e:	0a21                	.insn	2, 0x0a21
    1840:	0000                	.insn	2, 0x0000
    1842:	0000                	.insn	2, 0x0000
    1844:	6572                	.insn	2, 0x6572
    1846:	6f62                	.insn	2, 0x6f62
    1848:	6e69746f          	jal	s0,98f2e <_global+0x9699e>
    184c:	2e2e2e67          	.insn	4, 0x2e2e2e67
    1850:	000a                	.insn	2, 0x000a
    1852:	0000                	.insn	2, 0x0000
    1854:	7564                	.insn	2, 0x7564
    1856:	706d                	.insn	2, 0x706d
    1858:	0000                	.insn	2, 0x0000
    185a:	0000                	.insn	2, 0x0000
    185c:	7825                	.insn	2, 0x7825
    185e:	203a                	.insn	2, 0x203a
    1860:	0000                	.insn	2, 0x0000
    1862:	0000                	.insn	2, 0x0000
    1864:	7825                	.insn	2, 0x7825
    1866:	0020                	.insn	2, 0x0020
    1868:	6472                	.insn	2, 0x6472
    186a:	0000                	.insn	2, 0x0000
    186c:	00007277          	.insn	4, 0x7277
    1870:	656c                	.insn	2, 0x656c
    1872:	0064                	.insn	2, 0x0064
    1874:	656c                	.insn	2, 0x656c
    1876:	2064                	.insn	2, 0x2064
    1878:	203d                	.insn	2, 0x203d
    187a:	7825                	.insn	2, 0x7825
    187c:	000a                	.insn	2, 0x000a
    187e:	0000                	.insn	2, 0x0000
    1880:	6974                	.insn	2, 0x6974
    1882:	656d                	.insn	2, 0x656d
    1884:	0072                	.insn	2, 0x0072
    1886:	0000                	.insn	2, 0x0000
    1888:	6974                	.insn	2, 0x6974
    188a:	656d                	.insn	2, 0x656d
    188c:	2072                	.insn	2, 0x2072
    188e:	203d                	.insn	2, 0x203d
    1890:	6425                	.insn	2, 0x6425
    1892:	000a                	.insn	2, 0x000a
    1894:	726f706f          	j	f8fba <_global+0xf6a2a>
    1898:	0074                	.insn	2, 0x0074
    189a:	0000                	.insn	2, 0x0000
    189c:	726f706f          	j	f8fc2 <_global+0xf6a32>
    18a0:	2074                	.insn	2, 0x2074
    18a2:	203d                	.insn	2, 0x203d
    18a4:	7825                	.insn	2, 0x7825
    18a6:	000a                	.insn	2, 0x000a
    18a8:	7069                	.insn	2, 0x7069
    18aa:	0074726f          	jal	tp,490b0 <_global+0x46b20>
    18ae:	0000                	.insn	2, 0x0000
    18b0:	7069                	.insn	2, 0x7069
    18b2:	2074726f          	jal	tp,492b8 <_global+0x46d28>
    18b6:	203d                	.insn	2, 0x203d
    18b8:	7825                	.insn	2, 0x7825
    18ba:	000a                	.insn	2, 0x000a
    18bc:	756d                	.insn	2, 0x756d
    18be:	006c                	.insn	2, 0x006c
    18c0:	756d                	.insn	2, 0x756d
    18c2:	206c                	.insn	2, 0x206c
    18c4:	203d                	.insn	2, 0x203d
    18c6:	6425                	.insn	2, 0x6425
    18c8:	000a                	.insn	2, 0x000a
    18ca:	0000                	.insn	2, 0x0000
    18cc:	6964                	.insn	2, 0x6964
    18ce:	0076                	.insn	2, 0x0076
    18d0:	6964                	.insn	2, 0x6964
    18d2:	2076                	.insn	2, 0x2076
    18d4:	203d                	.insn	2, 0x203d
    18d6:	6425                	.insn	2, 0x6425
    18d8:	202c                	.insn	2, 0x202c
    18da:	6f6d                	.insn	2, 0x6f6d
    18dc:	2064                	.insn	2, 0x2064
    18de:	203d                	.insn	2, 0x203d
    18e0:	6425                	.insn	2, 0x6425
    18e2:	000a                	.insn	2, 0x000a
    18e4:	616d                	.insn	2, 0x616d
    18e6:	616d0063          	beq	s10,s6,1ee6 <_GLOBAL_OFFSET_TABLE_+0x122>
    18ea:	203d2063          	.insn	4, 0x203d2063
    18ee:	6425                	.insn	2, 0x6425
    18f0:	000a                	.insn	2, 0x000a
    18f2:	0000                	.insn	2, 0x0000
    18f4:	69617273          	csrrci	tp,0x696,2
    18f8:	0000                	.insn	2, 0x0000
    18fa:	0000                	.insn	2, 0x0000
    18fc:	69617273          	csrrci	tp,0x696,2
    1900:	2520                	.insn	2, 0x2520
    1902:	2078                	.insn	2, 0x2078
    1904:	3e3e                	.insn	2, 0x3e3e
    1906:	3120                	.insn	2, 0x3120
    1908:	3d20                	.insn	2, 0x3d20
    190a:	2520                	.insn	2, 0x2520
    190c:	0a78                	.insn	2, 0x0a78
    190e:	0000                	.insn	2, 0x0000
    1910:	6d6d6f63          	bltu	s10,s6,1fee <_edata+0x102>
    1914:	6e61                	.insn	2, 0x6e61
    1916:	3a64                	.insn	2, 0x3a64
    1918:	5b20                	.insn	2, 0x5b20
    191a:	7325                	.insn	2, 0x7325
    191c:	205d                	.insn	2, 0x205d
    191e:	6f6e                	.insn	2, 0x6f6e
    1920:	2074                	.insn	2, 0x2074
    1922:	6f66                	.insn	2, 0x6f66
    1924:	6e75                	.insn	2, 0x6e75
    1926:	2e64                	.insn	2, 0x2e64
    1928:	760a                	.insn	2, 0x760a
    192a:	6c61                	.insn	2, 0x6c61
    192c:	6469                	.insn	2, 0x6469
    192e:	6320                	.insn	2, 0x6320
    1930:	616d6d6f          	jal	s10,d7f46 <_global+0xd59b6>
    1934:	646e                	.insn	2, 0x646e
    1936:	63203a73          	csrrc	s4,0x632,zero
    193a:	656c                	.insn	2, 0x656c
    193c:	7261                	.insn	2, 0x7261
    193e:	202c                	.insn	2, 0x202c
    1940:	7564                	.insn	2, 0x7564
    1942:	706d                	.insn	2, 0x706d
    1944:	5b20                	.insn	2, 0x5b20
    1946:	6568                	.insn	2, 0x6568
    1948:	5d78                	.insn	2, 0x5d78
    194a:	202c                	.insn	2, 0x202c
    194c:	656c                	.insn	2, 0x656c
    194e:	2064                	.insn	2, 0x2064
    1950:	7865685b          	.insn	4, 0x7865685b
    1954:	2c5d                	.insn	2, 0x2c5d
    1956:	7420                	.insn	2, 0x7420
    1958:	6d69                	.insn	2, 0x6d69
    195a:	7265                	.insn	2, 0x7265
    195c:	5b20                	.insn	2, 0x5b20
    195e:	6564                	.insn	2, 0x6564
    1960:	202c5d63          	bge	s8,sp,1b7a <_data+0x592>
    1964:	726f706f          	j	f908a <_global+0xf6afa>
    1968:	2074                	.insn	2, 0x2074
    196a:	7865685b          	.insn	4, 0x7865685b
    196e:	0a5d                	.insn	2, 0x0a5d
    1970:	2020                	.insn	2, 0x2020
    1972:	2020                	.insn	2, 0x2020
    1974:	2020                	.insn	2, 0x2020
    1976:	2020                	.insn	2, 0x2020
    1978:	2020                	.insn	2, 0x2020
    197a:	2020                	.insn	2, 0x2020
    197c:	2020                	.insn	2, 0x2020
    197e:	2020                	.insn	2, 0x2020
    1980:	756d                	.insn	2, 0x756d
    1982:	206c                	.insn	2, 0x206c
    1984:	6365645b          	.insn	4, 0x6365645b
    1988:	205d                	.insn	2, 0x205d
    198a:	6365645b          	.insn	4, 0x6365645b
    198e:	2c5d                	.insn	2, 0x2c5d
    1990:	6420                	.insn	2, 0x6420
    1992:	7669                	.insn	2, 0x7669
    1994:	5b20                	.insn	2, 0x5b20
    1996:	6564                	.insn	2, 0x6564
    1998:	5b205d63          	blez	s2,1f52 <_edata+0x66>
    199c:	6564                	.insn	2, 0x6564
    199e:	202c5d63          	bge	s8,sp,1bb8 <_data+0x5d0>
    19a2:	616d                	.insn	2, 0x616d
    19a4:	645b2063          	.insn	4, 0x645b2063
    19a8:	6365                	.insn	2, 0x6365
    19aa:	205d                	.insn	2, 0x205d
    19ac:	6365645b          	.insn	4, 0x6365645b
    19b0:	205d                	.insn	2, 0x205d
    19b2:	6365645b          	.insn	4, 0x6365645b
    19b6:	0a5d                	.insn	2, 0x0a5d
    19b8:	2020                	.insn	2, 0x2020
    19ba:	2020                	.insn	2, 0x2020
    19bc:	2020                	.insn	2, 0x2020
    19be:	2020                	.insn	2, 0x2020
    19c0:	2020                	.insn	2, 0x2020
    19c2:	2020                	.insn	2, 0x2020
    19c4:	2020                	.insn	2, 0x2020
    19c6:	2020                	.insn	2, 0x2020
    19c8:	6572                	.insn	2, 0x6572
    19ca:	6f62                	.insn	2, 0x6f62
    19cc:	202c746f          	jal	s0,c8bce <_global+0xc663e>
    19d0:	6d5b7277          	.insn	4, 0x6d5b7277
    19d4:	5b5d                	.insn	2, 0x5b5d
    19d6:	7762                	.insn	2, 0x7762
    19d8:	5d6c                	.insn	2, 0x5d6c
    19da:	5b20                	.insn	2, 0x5b20
    19dc:	6568                	.insn	2, 0x6568
    19de:	5d78                	.insn	2, 0x5d78
    19e0:	5b20                	.insn	2, 0x5b20
    19e2:	6568                	.insn	2, 0x6568
    19e4:	5d78                	.insn	2, 0x5d78
    19e6:	5b20                	.insn	2, 0x5b20
    19e8:	7865685b          	.insn	4, 0x7865685b
    19ec:	205d                	.insn	2, 0x205d
    19ee:	6e656877          	.insn	4, 0x6e656877
    19f2:	6d20                	.insn	2, 0x6d20
    19f4:	2c5d                	.insn	2, 0x2c5d
    19f6:	200a                	.insn	2, 0x200a
    19f8:	2020                	.insn	2, 0x2020
    19fa:	2020                	.insn	2, 0x2020
    19fc:	2020                	.insn	2, 0x2020
    19fe:	2020                	.insn	2, 0x2020
    1a00:	2020                	.insn	2, 0x2020
    1a02:	2020                	.insn	2, 0x2020
    1a04:	2020                	.insn	2, 0x2020
    1a06:	7220                	.insn	2, 0x7220
    1a08:	5b64                	.insn	2, 0x5b64
    1a0a:	5d6d                	.insn	2, 0x5d6d
    1a0c:	6c77625b          	.insn	4, 0x6c77625b
    1a10:	205d                	.insn	2, 0x205d
    1a12:	7865685b          	.insn	4, 0x7865685b
    1a16:	205d                	.insn	2, 0x205d
    1a18:	65685b5b          	.insn	4, 0x65685b5b
    1a1c:	5d78                	.insn	2, 0x5d78
    1a1e:	7720                	.insn	2, 0x7720
    1a20:	6568                	.insn	2, 0x6568
    1a22:	206e                	.insn	2, 0x206e
    1a24:	5d6d                	.insn	2, 0x5d6d
    1a26:	202c                	.insn	2, 0x202c
    1a28:	7069                	.insn	2, 0x7069
    1a2a:	0a74726f          	jal	tp,492d0 <_global+0x46d40>
    1a2e:	0000                	.insn	2, 0x0000
    1a30:	4e28                	.insn	2, 0x4e28
    1a32:	4c55                	.insn	2, 0x4c55
    1a34:	294c                	.insn	2, 0x294c
    1a36:	0000                	.insn	2, 0x0000
    1a38:	3130                	.insn	2, 0x3130
    1a3a:	3332                	.insn	2, 0x3332
    1a3c:	3534                	.insn	2, 0x3534
    1a3e:	3736                	.insn	2, 0x3736
    1a40:	3938                	.insn	2, 0x3938
    1a42:	6261                	.insn	2, 0x6261
    1a44:	66656463          	bltu	a0,t1,20ac <_stack+0xac>
    1a48:	0000                	.insn	2, 0x0000
    1a4a:	0000                	.insn	2, 0x0000
    1a4c:	6e75                	.insn	2, 0x6e75
    1a4e:	776f6e6b          	.insn	4, 0x776f6e6b
    1a52:	006e                	.insn	2, 0x006e
    1a54:	6e69                	.insn	2, 0x6e69
    1a56:	75727473          	csrrci	s0,mseccfgh,4
    1a5a:	6f697463          	bgeu	s2,s6,2142 <_stack+0x142>
    1a5e:	206e                	.insn	2, 0x206e
    1a60:	6461                	.insn	2, 0x6461
    1a62:	7264                	.insn	2, 0x7264
    1a64:	7365                	.insn	2, 0x7365
    1a66:	6c612073          	csrs	0x6c6,sp
    1a6a:	6769                	.insn	2, 0x6769
    1a6c:	006e                	.insn	2, 0x006e
    1a6e:	0000                	.insn	2, 0x0000
    1a70:	6564                	.insn	2, 0x6564
    1a72:	7562                	.insn	2, 0x7562
    1a74:	2a203a67          	.insn	4, 0x2a203a67
    1a78:	2a2a                	.insn	2, 0x2a2a
    1a7a:	6520                	.insn	2, 0x6520
    1a7c:	6378                	.insn	2, 0x6378
    1a7e:	7065                	.insn	2, 0x7065
    1a80:	6974                	.insn	2, 0x6974
    1a82:	61206e6f          	jal	t3,8094 <_global+0x5b04>
    1a86:	2074                	.insn	2, 0x2074
    1a88:	7825                	.insn	2, 0x7825
    1a8a:	7720                	.insn	2, 0x7720
    1a8c:	636d202f          	.insn	4, 0x636d202f
    1a90:	7561                	.insn	2, 0x7561
    1a92:	253d6573          	csrrsi	a0,vsireg3,26
    1a96:	2f78                	.insn	2, 0x2f78
    1a98:	5d73255b          	.insn	4, 0x5d73255b
    1a9c:	2a20                	.insn	2, 0x2a20
    1a9e:	2a2a                	.insn	2, 0x2a2a
    1aa0:	000a                	.insn	2, 0x000a
    1aa2:	0000                	.insn	2, 0x0000
    1aa4:	6e69                	.insn	2, 0x6e69
    1aa6:	75727473          	csrrci	s0,mseccfgh,4
    1aaa:	6f697463          	bgeu	s2,s6,2192 <_stack+0x192>
    1aae:	206e                	.insn	2, 0x206e
    1ab0:	6164                	.insn	2, 0x6164
    1ab2:	6174                	.insn	2, 0x6174
    1ab4:	6620                	.insn	2, 0x6620
    1ab6:	7561                	.insn	2, 0x7561
    1ab8:	746c                	.insn	2, 0x746c
    1aba:	0000                	.insn	2, 0x0000
    1abc:	6c69                	.insn	2, 0x6c69
    1abe:	656c                	.insn	2, 0x656c
    1ac0:	206c6167          	.insn	4, 0x206c6167
    1ac4:	6e69                	.insn	2, 0x6e69
    1ac6:	75727473          	csrrci	s0,mseccfgh,4
    1aca:	6f697463          	bgeu	s2,s6,21b2 <_stack+0x1b2>
    1ace:	006e                	.insn	2, 0x006e
    1ad0:	7262                	.insn	2, 0x7262
    1ad2:	6165                	.insn	2, 0x6165
    1ad4:	696f706b          	.insn	4, 0x696f706b
    1ad8:	746e                	.insn	2, 0x746e
    1ada:	0000                	.insn	2, 0x0000
    1adc:	6f6c                	.insn	2, 0x6f6c
    1ade:	6461                	.insn	2, 0x6461
    1ae0:	6120                	.insn	2, 0x6120
    1ae2:	6464                	.insn	2, 0x6464
    1ae4:	6572                	.insn	2, 0x6572
    1ae6:	61207373          	csrrci	t1,0x612,0
    1aea:	696c                	.insn	2, 0x696c
    1aec:	00006e67          	.insn	4, 0x6e67
    1af0:	6f6c                	.insn	2, 0x6f6c
    1af2:	6461                	.insn	2, 0x6461
    1af4:	6420                	.insn	2, 0x6420
    1af6:	7461                	.insn	2, 0x7461
    1af8:	2061                	.insn	2, 0x2061
    1afa:	6166                	.insn	2, 0x6166
    1afc:	6c75                	.insn	2, 0x6c75
    1afe:	0074                	.insn	2, 0x0074
    1b00:	726f7473          	csrrci	s0,mhpmevent6h,30
    1b04:	2065                	.insn	2, 0x2065
    1b06:	6461                	.insn	2, 0x6461
    1b08:	7264                	.insn	2, 0x7264
    1b0a:	7365                	.insn	2, 0x7365
    1b0c:	6c612073          	csrs	0x6c6,sp
    1b10:	6769                	.insn	2, 0x6769
    1b12:	006e                	.insn	2, 0x006e
    1b14:	726f7473          	csrrci	s0,mhpmevent6h,30
    1b18:	2065                	.insn	2, 0x2065
    1b1a:	6164                	.insn	2, 0x6164
    1b1c:	6174                	.insn	2, 0x6174
    1b1e:	6620                	.insn	2, 0x6620
    1b20:	7561                	.insn	2, 0x7561
    1b22:	746c                	.insn	2, 0x746c
    1b24:	0000                	.insn	2, 0x0000
    1b26:	0000                	.insn	2, 0x0000
    1b28:	756d6973          	csrrsi	s2,0x756,26
    1b2c:	616c                	.insn	2, 0x616c
    1b2e:	6974                	.insn	2, 0x6974
    1b30:	6f206e6f          	jal	t3,8222 <_global+0x5c92>
    1b34:	6c6e                	.insn	2, 0x6c6e
    1b36:	0079                	.insn	2, 0x0079
    1b38:	7661                	.insn	2, 0x7661
    1b3a:	656e                	.insn	2, 0x656e
    1b3c:	2074                	.insn	2, 0x2074
    1b3e:	696d                	.insn	2, 0x696d
    1b40:	626f7263          	bgeu	t5,t1,2164 <_stack+0x164>
    1b44:	6472616f          	jal	sp,2898a <_global+0x263fa>
    1b48:	6c20                	.insn	2, 0x6c20
    1b4a:	3978                	.insn	2, 0x3978
    1b4c:	0000                	.insn	2, 0x0000
    1b4e:	0000                	.insn	2, 0x0000
    1b50:	6978                	.insn	2, 0x6978
    1b52:	696c                	.insn	2, 0x696c
    1b54:	786e                	.insn	2, 0x786e
    1b56:	6120                	.insn	2, 0x6120
    1b58:	31303763          	.insn	4, 0x31303763
    1b5c:	6120                	.insn	2, 0x6120
    1b5e:	3032                	.insn	2, 0x3032
    1b60:	0030                	.insn	2, 0x0030
    1b62:	0000                	.insn	2, 0x0000
    1b64:	6d71                	.insn	2, 0x6d71
    1b66:	6574                	.insn	2, 0x6574
    1b68:	73206863          	bltu	zero,s2,2298 <_stack+0x298>
    1b6c:	7264                	.insn	2, 0x7264
    1b6e:	6d61                	.insn	2, 0x6d61
    1b70:	6c20                	.insn	2, 0x6c20
    1b72:	3178                	.insn	2, 0x3178
    1b74:	0036                	.insn	2, 0x0036
    1b76:	0000                	.insn	2, 0x0000
    1b78:	6d71                	.insn	2, 0x6d71
    1b7a:	6574                	.insn	2, 0x6574
    1b7c:	73206863          	bltu	zero,s2,22ac <_stack+0x2ac>
    1b80:	6170                	.insn	2, 0x6170
    1b82:	7472                	.insn	2, 0x7472
    1b84:	6e61                	.insn	2, 0x6e61
    1b86:	31732037          	lui	zero,0x31732
    1b8a:	0035                	.insn	2, 0x0035
    1b8c:	616c                	.insn	2, 0x616c
    1b8e:	7474                	.insn	2, 0x7474
    1b90:	6369                	.insn	2, 0x6369
    1b92:	2065                	.insn	2, 0x2065
    1b94:	7262                	.insn	2, 0x7262
    1b96:	7665                	.insn	2, 0x7665
    1b98:	6169                	.insn	2, 0x6169
    1b9a:	2032                	.insn	2, 0x2032
    1b9c:	786c                	.insn	2, 0x786c
    1b9e:	3270                	.insn	2, 0x3270
    1ba0:	0000                	.insn	2, 0x0000
    1ba2:	0000                	.insn	2, 0x0000
    1ba4:	6970                	.insn	2, 0x6970
    1ba6:	726f7773          	csrrci	a4,mhpmevent6h,30
    1baa:	7364                	.insn	2, 0x7364
    1bac:	7220                	.insn	2, 0x7220
    1bae:	35383473          	csrrc	s0,mireg3,a6
    1bb2:	6c20                	.insn	2, 0x6c20
    1bb4:	3978                	.insn	2, 0x3978
    1bb6:	0000                	.insn	2, 0x0000
    1bb8:	6964                	.insn	2, 0x6964
    1bba:	656c6967          	.insn	4, 0x656c6967
    1bbe:	746e                	.insn	2, 0x746e
    1bc0:	7320                	.insn	2, 0x7320
    1bc2:	6170                	.insn	2, 0x6170
    1bc4:	7472                	.insn	2, 0x7472
    1bc6:	6e61                	.insn	2, 0x6e61
    1bc8:	32732033          	.insn	4, 0x32732033
    1bcc:	3030                	.insn	2, 0x3030
    1bce:	0000                	.insn	2, 0x0000
    1bd0:	6c61                	.insn	2, 0x6c61
    1bd2:	6569                	.insn	2, 0x6569
    1bd4:	7078                	.insn	2, 0x7078
    1bd6:	6572                	.insn	2, 0x6572
    1bd8:	68207373          	csrrci	t1,0x682,0
    1bdc:	6370                	.insn	2, 0x6370
    1bde:	6730342f          	.insn	4, 0x6730342f
    1be2:	6562                	.insn	2, 0x6562
    1be4:	6b20                	.insn	2, 0x6b20
    1be6:	3234                	.insn	2, 0x3234
    1be8:	0030                	.insn	2, 0x0030
    1bea:	0000                	.insn	2, 0x0000
    1bec:	6d71                	.insn	2, 0x6d71
    1bee:	6574                	.insn	2, 0x6574
    1bf0:	61206863          	bltu	zero,s2,2200 <_stack+0x200>
    1bf4:	7472                	.insn	2, 0x7472
    1bf6:	7869                	.insn	2, 0x7869
    1bf8:	33612037          	lui	zero,0x33612
    1bfc:	0035                	.insn	2, 0x0035
    1bfe:	0000                	.insn	2, 0x0000
    1c00:	6c61                	.insn	2, 0x6c61
    1c02:	6569                	.insn	2, 0x6569
    1c04:	7078                	.insn	2, 0x7078
    1c06:	6572                	.insn	2, 0x6572
    1c08:	68207373          	csrrci	t1,0x682,0
    1c0c:	6370                	.insn	2, 0x6370
    1c0e:	6730342f          	.insn	4, 0x6730342f
    1c12:	6562                	.insn	2, 0x6562
    1c14:	6b20                	.insn	2, 0x6b20
    1c16:	3075                	.insn	2, 0x3075
    1c18:	3034                	.insn	2, 0x3034
    1c1a:	0000                	.insn	2, 0x0000
    1c1c:	6170                	.insn	2, 0x6170
    1c1e:	6970                	.insn	2, 0x6970
    1c20:	696c                	.insn	2, 0x696c
    1c22:	7564206f          	j	44378 <_global+0x41de8>
    1c26:	6f6c206f          	j	c431c <_global+0xc1d8c>
    1c2a:	73636967          	.insn	4, 0x73636967
    1c2e:	6174                	.insn	2, 0x6174
    1c30:	7472                	.insn	2, 0x7472
    1c32:	0000                	.insn	2, 0x0000
    1c34:	6d71                	.insn	2, 0x6d71
    1c36:	6574                	.insn	2, 0x6574
    1c38:	6b206863          	bltu	zero,s2,22e8 <_stack+0x2e8>
    1c3c:	6e69                	.insn	2, 0x6e69
    1c3e:	6574                	.insn	2, 0x6574
    1c40:	2d78                	.insn	2, 0x2d78
    1c42:	336b2037          	lui	zero,0x336b2
    1c46:	3532                	.insn	2, 0x3532
    1c48:	0000                	.insn	2, 0x0000
    1c4a:	0000                	.insn	2, 0x0000
    1c4c:	72616373          	csrrsi	t1,mhpmevent6h,2
    1c50:	6261                	.insn	2, 0x6261
    1c52:	6d20                	.insn	2, 0x6d20
    1c54:	6e69                	.insn	2, 0x6e69
    1c56:	7369                	.insn	2, 0x7369
    1c58:	6170                	.insn	2, 0x6170
    1c5a:	7472                	.insn	2, 0x7472
    1c5c:	6e61                	.insn	2, 0x6e61
    1c5e:	2d36                	.insn	2, 0x2d36
    1c60:	6c70                	.insn	2, 0x6c70
    1c62:	7375                	.insn	2, 0x7375
    1c64:	6c20                	.insn	2, 0x6c20
    1c66:	3978                	.insn	2, 0x3978
    1c68:	0000                	.insn	2, 0x0000
    1c6a:	0000                	.insn	2, 0x0000
    1c6c:	616c                	.insn	2, 0x616c
    1c6e:	7474                	.insn	2, 0x7474
    1c70:	6369                	.insn	2, 0x6369
    1c72:	2065                	.insn	2, 0x2065
    1c74:	6365                	.insn	2, 0x6365
    1c76:	3570                	.insn	2, 0x3570
    1c78:	342d                	.insn	2, 0x342d
    1c7a:	4635                	.insn	2, 0x4635
    1c7c:	6320                	.insn	2, 0x6320
    1c7e:	726f6c6f          	jal	s8,f83a4 <_global+0xf5e14>
    1c82:	696c                	.insn	2, 0x696c
    1c84:	69746867          	.insn	4, 0x69746867
    1c88:	0039                	.insn	2, 0x0039
    1c8a:	0000                	.insn	2, 0x0000
    1c8c:	616c                	.insn	2, 0x616c
    1c8e:	7474                	.insn	2, 0x7474
    1c90:	6369                	.insn	2, 0x6369
    1c92:	2065                	.insn	2, 0x2065
    1c94:	6365                	.insn	2, 0x6365
    1c96:	3570                	.insn	2, 0x3570
    1c98:	322d                	.insn	2, 0x322d
    1c9a:	4635                	.insn	2, 0x4635
    1c9c:	6320                	.insn	2, 0x6320
    1c9e:	726f6c6f          	jal	s8,f83c4 <_global+0xf5e34>
    1ca2:	696c                	.insn	2, 0x696c
    1ca4:	69746867          	.insn	4, 0x69746867
    1ca8:	0035                	.insn	2, 0x0035
    1caa:	0000                	.insn	2, 0x0000
    1cac:	616c                	.insn	2, 0x616c
    1cae:	7474                	.insn	2, 0x7474
    1cb0:	6369                	.insn	2, 0x6369
    1cb2:	2065                	.insn	2, 0x2065
    1cb4:	6365                	.insn	2, 0x6365
    1cb6:	3570                	.insn	2, 0x3570
    1cb8:	382d                	.insn	2, 0x382d
    1cba:	4635                	.insn	2, 0x4635
    1cbc:	7520                	.insn	2, 0x7520
    1cbe:	786c                	.insn	2, 0x786c
    1cc0:	00007333          	and	t1,zero,zero
    1cc4:	6d71                	.insn	2, 0x6d71
    1cc6:	6574                	.insn	2, 0x6574
    1cc8:	63206863          	bltu	zero,s2,22f8 <_stack+0x2f8>
    1ccc:	6379                	.insn	2, 0x6379
    1cce:	6f6c                	.insn	2, 0x6f6c
    1cd0:	656e                	.insn	2, 0x656e
    1cd2:	3120                	.insn	2, 0x3120
    1cd4:	6c30                	.insn	2, 0x6c30
    1cd6:	2070                	.insn	2, 0x2070
    1cd8:	36313063          	.insn	4, 0x36313063
    1cdc:	0000                	.insn	2, 0x0000
    1cde:	0000                	.insn	2, 0x0000
    1ce0:	6970                	.insn	2, 0x6970
    1ce2:	726f7773          	csrrci	a4,mhpmevent6h,30
    1ce6:	7364                	.insn	2, 0x7364
    1ce8:	6320                	.insn	2, 0x6320
    1cea:	3368                	.insn	2, 0x3368
    1cec:	7834                	.insn	2, 0x7834
    1cee:	6c20                	.insn	2, 0x6c20
    1cf0:	3178                	.insn	2, 0x3178
    1cf2:	0036                	.insn	2, 0x0036
    1cf4:	616d                	.insn	2, 0x616d
    1cf6:	3178                	.insn	2, 0x3178
    1cf8:	3030                	.insn	2, 0x3030
    1cfa:	2030                	.insn	2, 0x2030
    1cfc:	616d                	.insn	2, 0x616d
    1cfe:	3178                	.insn	2, 0x3178
    1d00:	0030                	.insn	2, 0x0030
    1d02:	0000                	.insn	2, 0x0000
    1d04:	6564                	.insn	2, 0x6564
    1d06:	3031                	.insn	2, 0x3031
    1d08:	616e                	.insn	2, 0x616e
    1d0a:	6f6e                	.insn	2, 0x6f6e
    1d0c:	6320                	.insn	2, 0x6320
    1d0e:	6379                	.insn	2, 0x6379
    1d10:	6f6c                	.insn	2, 0x6f6c
    1d12:	656e                	.insn	2, 0x656e
    1d14:	2076                	.insn	2, 0x2076
    1d16:	696d                	.insn	2, 0x696d
    1d18:	72657473          	csrrci	s0,mhpmevent6h,10
    1d1c:	0000                	.insn	2, 0x0000
	...

00001d20 <CSWTCH.10>:
    1d20:	0000                	.insn	2, 0x0000
    1d22:	0000281b          	.insn	4, 0x281b
    1d26:	0000381b          	.insn	4, 0x381b
    1d2a:	0000501b          	.insn	4, 0x501b
    1d2e:	0000641b          	.insn	4, 0x641b
    1d32:	0000781b          	.insn	4, 0x781b
    1d36:	00008c1b          	.insn	4, 0x8c1b
    1d3a:	0000a41b          	.insn	4, 0xa41b
    1d3e:	0000b81b          	.insn	4, 0xb81b
    1d42:	0000d01b          	.insn	4, 0xd01b
    1d46:	0000ec1b          	.insn	4, 0xec1b
    1d4a:	001c                	.insn	2, 0x001c
    1d4c:	0000                	.insn	2, 0x0000
    1d4e:	1c1c                	.insn	2, 0x1c1c
    1d50:	0000                	.insn	2, 0x0000
    1d52:	341c                	.insn	2, 0x341c
    1d54:	0000                	.insn	2, 0x0000
    1d56:	4c1c                	.insn	2, 0x4c1c
    1d58:	0000                	.insn	2, 0x0000
    1d5a:	6c1c                	.insn	2, 0x6c1c
    1d5c:	0000                	.insn	2, 0x0000
    1d5e:	8c1c                	.insn	2, 0x8c1c
    1d60:	0000                	.insn	2, 0x0000
    1d62:	ac1c                	.insn	2, 0xac1c
    1d64:	0000                	.insn	2, 0x0000
    1d66:	c41c                	.insn	2, 0xc41c
    1d68:	0000                	.insn	2, 0x0000
    1d6a:	e01c                	.insn	2, 0xe01c
    1d6c:	0000                	.insn	2, 0x0000
    1d6e:	f41c                	.insn	2, 0xf41c
    1d70:	0000                	.insn	2, 0x0000
    1d72:	041d                	.insn	2, 0x041d

00001d74 <CSWTCH.13>:
    1d74:	0000                	.insn	2, 0x0000
    1d76:	a41a                	.insn	2, 0xa41a
    1d78:	0000                	.insn	2, 0x0000
    1d7a:	bc1a                	.insn	2, 0xbc1a
    1d7c:	0000                	.insn	2, 0x0000
    1d7e:	d01a                	.insn	2, 0xd01a
    1d80:	0000                	.insn	2, 0x0000
    1d82:	dc1a                	.insn	2, 0xdc1a
    1d84:	0000                	.insn	2, 0x0000
    1d86:	f01a                	.insn	2, 0xf01a
    1d88:	0000                	.insn	2, 0x0000
    1d8a:	0000001b          	.insn	4, 0x001b
    1d8e:	          	.insn	4, 0x141b

00001d90 <utimers>:
    1d90:	0000                	.insn	2, 0x0000
	...

00001d94 <nxt.0>:
    1d94:	0000                	.insn	2, 0x0000
	...

00001d98 <io>:
    1d98:	0040                	.insn	2, 0x0040
    1d9a:	0000                	.insn	2, 0x0000
    1d9c:	0041                	.insn	2, 0x0041
    1d9e:	0000                	.insn	2, 0x0000
    1da0:	7226                	.insn	2, 0x7226
    1da2:	7369                	.insn	2, 0x7369
    1da4:	01007663          	bgeu	zero,a6,1db0 <io+0x18>
    1da8:	0000                	.insn	2, 0x0000
    1daa:	1c00                	.insn	2, 0x1c00
    1dac:	7205                	.insn	2, 0x7205
    1dae:	3376                	.insn	2, 0x3376
    1db0:	6532                	.insn	2, 0x6532
    1db2:	7031                	.insn	2, 0x7031
    1db4:	5f39                	.insn	2, 0x5f39
    1db6:	697a                	.insn	2, 0x697a
    1db8:	32727363          	bgeu	tp,t2,20de <_stack+0xde>
    1dbc:	3070                	.insn	2, 0x3070
    1dbe:	0800                	.insn	2, 0x0800
    1dc0:	0a01                	.insn	2, 0x0a01
    1dc2:	          	.insn	4, 0x000b

00001dc4 <_GLOBAL_OFFSET_TABLE_>:
    1dc4:	0000                	.insn	2, 0x0000
    1dc6:	0000                	.insn	2, 0x0000
    1dc8:	0000                	.insn	2, 0x0000
    1dca:	9025                	.insn	2, 0x9025
    1dcc:	0000                	.insn	2, 0x0000
    1dce:	0002                	.insn	2, 0x0002
    1dd0:	0000                	.insn	2, 0x0000
    1dd2:	0020                	.insn	2, 0x0020
    1dd4:	ffff                	.insn	2, 0xffff
    1dd6:	ffff                	.insn	2, 0xffff
    1dd8:	0000                	.insn	2, 0x0000
    1dda:	0000                	.insn	2, 0x0000
    1ddc:	3a434347          	.insn	4, 0x3a434347
    1de0:	2820                	.insn	2, 0x2820
    1de2:	29554e47          	.insn	4, 0x29554e47
    1de6:	3120                	.insn	2, 0x3120
    1de8:	2e35                	.insn	2, 0x2e35
    1dea:	2e30                	.insn	2, 0x2e30
    1dec:	2031                	.insn	2, 0x2031
    1dee:	3032                	.insn	2, 0x3032
    1df0:	3532                	.insn	2, 0x3532
    1df2:	3230                	.insn	2, 0x3230
    1df4:	3430                	.insn	2, 0x3430
    1df6:	2820                	.insn	2, 0x2820
    1df8:	7865                	.insn	2, 0x7865
    1dfa:	6570                	.insn	2, 0x6570
    1dfc:	6972                	.insn	2, 0x6972
    1dfe:	656d                	.insn	2, 0x656d
    1e00:	746e                	.insn	2, 0x746e
    1e02:	6c61                	.insn	2, 0x6c61
    1e04:	0029                	.insn	2, 0x0029
    1e06:	0041                	.insn	2, 0x0041
    1e08:	0000                	.insn	2, 0x0000
    1e0a:	7224                	.insn	2, 0x7224
    1e0c:	7369                	.insn	2, 0x7369
    1e0e:	01007663          	bgeu	zero,a6,1e1a <_GLOBAL_OFFSET_TABLE_+0x56>
    1e12:	0000                	.insn	2, 0x0000
    1e14:	1a00                	.insn	2, 0x1a00
    1e16:	0404                	.insn	2, 0x0404
    1e18:	7205                	.insn	2, 0x7205
    1e1a:	3376                	.insn	2, 0x3376
    1e1c:	6532                	.insn	2, 0x6532
    1e1e:	7032                	.insn	2, 0x7032
    1e20:	5f30                	.insn	2, 0x5f30
    1e22:	697a                	.insn	2, 0x697a
    1e24:	32727363          	bgeu	tp,t2,214a <_stack+0x14a>
    1e28:	3070                	.insn	2, 0x3070
    1e2a:	4100                	.insn	2, 0x4100
    1e2c:	0000                	.insn	2, 0x0000
    1e2e:	2400                	.insn	2, 0x2400
    1e30:	6972                	.insn	2, 0x6972
    1e32:	00766373          	csrrsi	t1,0x7,12
    1e36:	0001                	.insn	2, 0x0001
    1e38:	0000                	.insn	2, 0x0000
    1e3a:	041a                	.insn	2, 0x041a
    1e3c:	0504                	.insn	2, 0x0504
    1e3e:	7672                	.insn	2, 0x7672
    1e40:	32653233          	.insn	4, 0x32653233
    1e44:	3070                	.insn	2, 0x3070
    1e46:	7a5f 6369 7273      	.insn	6, 0x727363697a5f
    1e4c:	7032                	.insn	2, 0x7032
    1e4e:	0030                	.insn	2, 0x0030
    1e50:	0041                	.insn	2, 0x0041
    1e52:	0000                	.insn	2, 0x0000
    1e54:	7228                	.insn	2, 0x7228
    1e56:	7369                	.insn	2, 0x7369
    1e58:	01007663          	bgeu	zero,a6,1e64 <_GLOBAL_OFFSET_TABLE_+0xa0>
    1e5c:	0000                	.insn	2, 0x0000
    1e5e:	1e00                	.insn	2, 0x1e00
    1e60:	0404                	.insn	2, 0x0404
    1e62:	7205                	.insn	2, 0x7205
    1e64:	3376                	.insn	2, 0x3376
    1e66:	6532                	.insn	2, 0x6532
    1e68:	7032                	.insn	2, 0x7032
    1e6a:	5f30                	.insn	2, 0x5f30
    1e6c:	697a                	.insn	2, 0x697a
    1e6e:	32727363          	bgeu	tp,t2,2194 <_stack+0x194>
    1e72:	3070                	.insn	2, 0x3070
    1e74:	0800                	.insn	2, 0x0800
    1e76:	0a01                	.insn	2, 0x0a01
    1e78:	0000410b          	.insn	4, 0x410b
    1e7c:	2400                	.insn	2, 0x2400
    1e7e:	6972                	.insn	2, 0x6972
    1e80:	00766373          	csrrsi	t1,0x7,12
    1e84:	0001                	.insn	2, 0x0001
    1e86:	0000                	.insn	2, 0x0000
    1e88:	041a                	.insn	2, 0x041a
    1e8a:	0504                	.insn	2, 0x0504
    1e8c:	7672                	.insn	2, 0x7672
    1e8e:	32653233          	.insn	4, 0x32653233
    1e92:	3070                	.insn	2, 0x3070
    1e94:	7a5f 6369 7273      	.insn	6, 0x727363697a5f
    1e9a:	7032                	.insn	2, 0x7032
    1e9c:	0030                	.insn	2, 0x0030
    1e9e:	0041                	.insn	2, 0x0041
    1ea0:	0000                	.insn	2, 0x0000
    1ea2:	7224                	.insn	2, 0x7224
    1ea4:	7369                	.insn	2, 0x7369
    1ea6:	01007663          	bgeu	zero,a6,1eb2 <_GLOBAL_OFFSET_TABLE_+0xee>
    1eaa:	0000                	.insn	2, 0x0000
    1eac:	1a00                	.insn	2, 0x1a00
    1eae:	0404                	.insn	2, 0x0404
    1eb0:	7205                	.insn	2, 0x7205
    1eb2:	3376                	.insn	2, 0x3376
    1eb4:	6532                	.insn	2, 0x6532
    1eb6:	7032                	.insn	2, 0x7032
    1eb8:	5f30                	.insn	2, 0x5f30
    1eba:	697a                	.insn	2, 0x697a
    1ebc:	32727363          	bgeu	tp,t2,21e2 <_stack+0x1e2>
    1ec0:	3070                	.insn	2, 0x3070
    1ec2:	4100                	.insn	2, 0x4100
    1ec4:	0000                	.insn	2, 0x0000
    1ec6:	2600                	.insn	2, 0x2600
    1ec8:	6972                	.insn	2, 0x6972
    1eca:	00766373          	csrrsi	t1,0x7,12
    1ece:	0001                	.insn	2, 0x0001
    1ed0:	0000                	.insn	2, 0x0000
    1ed2:	051c                	.insn	2, 0x051c
    1ed4:	7672                	.insn	2, 0x7672
    1ed6:	31653233          	.insn	4, 0x31653233
    1eda:	3970                	.insn	2, 0x3970
    1edc:	7a5f 6369 7273      	.insn	6, 0x727363697a5f
    1ee2:	7032                	.insn	2, 0x7032
    1ee4:	0030                	.insn	2, 0x0030
    1ee6:	0108                	.insn	2, 0x0108
    1ee8:	0b0a                	.insn	2, 0x0b0a
	...
