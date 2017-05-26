
bin/merged.bin:     file format binary


Disassembly of section .data:

0080001a <.data+0x1a>:
  80001a:	33fc 8000 00e4 	movew #-32768,0xe43000
  800020:	3000 
  800022:	33fc 0f00 004a 	movew #3840,0x4a0000
  800028:	0000 
  80002a:	4286           	clrl %d6
  80002c:	5206           	addqb #1,%d6
  80002e:	2006           	movel %d6,%d0
  800030:	4600           	notb %d0
  800032:	e148           	lslw #8,%d0
  800034:	33c0 004a 0000 	movew %d0,0x4a0000
  80003a:	13fc 0000 004c 	moveb #0,0x4c0000
  800040:	0000 
  800042:	33fc 0018 00e5 	movew #24,0xe50004
  800048:	0004 
  80004a:	33fc 0018 00e5 	movew #24,0xe50006
  800050:	0006 
  800052:	33fc 00f0 00e5 	movew #240,0xe50004
  800058:	0004 
  80005a:	33fc 00f0 00e5 	movew #240,0xe50006
  800060:	0006 
  800062:	33fc 0300 00e7 	movew #768,0xe70000
  800068:	0000 
  80006a:	33fc 9500 00e7 	movew #-27392,0xe70000
  800070:	0000 
  800072:	33fc 8000 00e4 	movew #-32768,0xe44000
  800078:	4000 
  80007a:	33fc 8000 00e4 	movew #-32768,0xe45000
  800080:	5000 
  800082:	33fc 0001 00e6 	movew #1,0xe60000
  800088:	0000 
  80008a:	223c 0000 00ff 	movel #255,%d1
  800090:	51c9 fffe      	dbf %d1,0x800090
  800094:	33fc 0000 00e6 	movew #0,0xe60000
  80009a:	0000 
  80009c:	33fc 4000 0049 	movew #16384,0x490000
  8000a2:	0000 
  8000a4:	33fc 4000 0049 	movew #16384,0x491000
  8000aa:	1000 
  8000ac:	4280           	clrl %d0
  8000ae:	3039 0045 0000 	movew 0x450000,%d0
  8000b4:	0240 0001      	andiw #1,%d0
  8000b8:	6700 0012      	beqw 0x8000cc
  8000bc:	33fc 4000 0049 	movew #16384,0x492000
  8000c2:	2000 
  8000c4:	33fc 4000 0049 	movew #16384,0x496000
  8000ca:	6000 
  8000cc:	33fc 0000 0049 	movew #0,0x494000
  8000d2:	4000 
  8000d4:	33fc 0000 0049 	movew #0,0x495000
  8000da:	5000 
  8000dc:	33fc 4000 0049 	movew #16384,0x493000
  8000e2:	3000 
  8000e4:	33fc 4000 0049 	movew #16384,0x497000
  8000ea:	7000 
  8000ec:	33fc 0000 004f 	movew #0,0x4f0000
  8000f2:	0000 
  8000f4:	13fc 0000 004b 	moveb #0,0x4b0400
  8000fa:	0400 
  8000fc:	13fc 0000 004b 	moveb #0,0x4b0800
  800102:	0800 
  800104:	33fc 0000 0046 	movew #0,0x460000
  80010a:	0000 
  80010c:	33fc 0000 004d 	movew #0,0x4d0000
  800112:	0000 
  800114:	5206           	addqb #1,%d6
  800116:	2006           	movel %d6,%d0
  800118:	4600           	notb %d0
  80011a:	e148           	lslw #8,%d0
  80011c:	33c0 004a 0000 	movew %d0,0x4a0000
  800122:	207c 0042 0000 	moveal #4325376,%a0
  800128:	2c7c 0042 7fff 	moveal #4358143,%fp
  80012e:	4283           	clrl %d3
  800130:	2848           	moveal %a0,%a4
  800132:	3883           	movew %d3,%a4@
  800134:	b65c           	cmpw %a4@+,%d3
  800136:	6600 0032      	bnew 0x80016a
  80013a:	b9ce           	cmpal %fp,%a4
  80013c:	6e00 0008      	bgtw 0x800146
  800140:	5243           	addqw #1,%d3
  800142:	6000 ffee      	braw 0x800132
  800146:	4283           	clrl %d3
  800148:	2848           	moveal %a0,%a4
  80014a:	b654           	cmpw %a4@,%d3
  80014c:	6600 001c      	bnew 0x80016a
  800150:	38c3           	movew %d3,%a4@+
  800152:	5243           	addqw #1,%d3
  800154:	b9ce           	cmpal %fp,%a4
  800156:	6f00 fff2      	blew 0x80014a
  80015a:	4283           	clrl %d3
  80015c:	2848           	moveal %a0,%a4
  80015e:	28c3           	movel %d3,%a4@+
  800160:	b9ce           	cmpal %fp,%a4
  800162:	6d00 fffa      	bltw 0x80015e
  800166:	6000 0008      	braw 0x800170
  80016a:	4e72 2700      	stop #9984
  80016e:	60fa           	bras 0x80016a
  800170:	5206           	addqb #1,%d6
  800172:	2006           	movel %d6,%d0
  800174:	4600           	notb %d0
  800176:	e148           	lslw #8,%d0
  800178:	33c0 004a 0000 	movew %d0,0x4a0000
  80017e:	207c 0040 0000 	moveal #4194304,%a0
  800184:	2c7c 0040 07ff 	moveal #4196351,%fp
  80018a:	4283           	clrl %d3
  80018c:	3083           	movew %d3,%a0@
  80018e:	b658           	cmpw %a0@+,%d3
  800190:	6600 0026      	bnew 0x8001b8
  800194:	5243           	addqw #1,%d3
  800196:	b1ce           	cmpal %fp,%a0
  800198:	6f00 fff2      	blew 0x80018c
  80019c:	4283           	clrl %d3
  80019e:	207c 0040 0000 	moveal #4194304,%a0
  8001a4:	b650           	cmpw %a0@,%d3
  8001a6:	6600 0010      	bnew 0x8001b8
  8001aa:	30c3           	movew %d3,%a0@+
  8001ac:	5243           	addqw #1,%d3
  8001ae:	b1ce           	cmpal %fp,%a0
  8001b0:	6f00 fff2      	blew 0x8001a4
  8001b4:	6000 0024      	braw 0x8001da
  8001b8:	207c 0042 0000 	moveal #4325376,%a0
  8001be:	2c7c 0042 7fff 	moveal #4358143,%fp
  8001c4:	4283           	clrl %d3
  8001c6:	3c3c ffff      	movew #-1,%d6
  8001ca:	30c6           	movew %d6,%a0@+
  8001cc:	30c3           	movew %d3,%a0@+
  8001ce:	b1ce           	cmpal %fp,%a0
  8001d0:	6d00 fff8      	bltw 0x8001ca
  8001d4:	4e72 2700      	stop #9984
  8001d8:	60f0           	bras 0x8001ca
  8001da:	5206           	addqb #1,%d6
  8001dc:	2006           	movel %d6,%d0
  8001de:	4600           	notb %d0
  8001e0:	e148           	lslw #8,%d0
  8001e2:	33c0 004a 0000 	movew %d0,0x4a0000
  8001e8:	263c 0000 a000 	movel #40960,%d3
  8001ee:	207c 0040 0000 	moveal #4194304,%a0
  8001f4:	203c 0000 03ff 	movel #1023,%d0
  8001fa:	30c3           	movew %d3,%a0@+
  8001fc:	5243           	addqw #1,%d3
  8001fe:	51c8 fffa      	dbf %d0,0x8001fa
  800202:	5206           	addqb #1,%d6
  800204:	2006           	movel %d6,%d0
  800206:	4600           	notb %d0
  800208:	e148           	lslw #8,%d0
  80020a:	33c0 004a 0000 	movew %d0,0x4a0000
  800210:	207c 0000 0000 	moveal #0,%a0
  800216:	2c7c 0007 ffff 	moveal #524287,%fp
  80021c:	2248           	moveal %a0,%a1
  80021e:	2608           	movel %a0,%d3
  800220:	2289           	movel %a1,%a1@
  800222:	b699           	cmpl %a1@+,%d3
  800224:	6600 0022      	bnew 0x800248
  800228:	b3ce           	cmpal %fp,%a1
  80022a:	6e00 0008      	bgtw 0x800234
  80022e:	5883           	addql #4,%d3
  800230:	6000 ffee      	braw 0x800220
  800234:	2248           	moveal %a0,%a1
  800236:	b3d1           	cmpal %a1@,%a1
  800238:	6600 000e      	bnew 0x800248
  80023c:	22c9           	movel %a1,%a1@+
  80023e:	b3ce           	cmpal %fp,%a1
  800240:	6e00 0028      	bgtw 0x80026a
  800244:	6000 fff0      	braw 0x800236
  800248:	207c 0042 0000 	moveal #4325376,%a0
  80024e:	2c7c 0042 7fff 	moveal #4358143,%fp
  800254:	4283           	clrl %d3
  800256:	3c3c ffff      	movew #-1,%d6
  80025a:	30c6           	movew %d6,%a0@+
  80025c:	30c3           	movew %d3,%a0@+
  80025e:	b1ce           	cmpal %fp,%a0
  800260:	6d00 fff8      	bltw 0x80025a
  800264:	4e72 2700      	stop #9984
  800268:	60f0           	bras 0x80025a
  80026a:	13fc 0000 004c 	moveb #0,0x4c0000
  800270:	0000 
  800272:	5206           	addqb #1,%d6
  800274:	2006           	movel %d6,%d0
  800276:	4600           	notb %d0
  800278:	e148           	lslw #8,%d0
  80027a:	33c0 004a 0000 	movew %d0,0x4a0000
  800280:	4ef9 0080 0e44 	jmp 0x800e44
  800286:	5206           	addqb #1,%d6
  800288:	2006           	movel %d6,%d0
  80028a:	4600           	notb %d0
  80028c:	e148           	lslw #8,%d0
  80028e:	33c0 004a 0000 	movew %d0,0x4a0000
  800294:	4ef9 0007 0000 	jmp 0x70000
  80029a:	4028 2329      	negxb %a0@(9001)
  80029e:	7072           	moveq #114,%d0
  8002a0:	6f6d           	bles 0x80030f
  8002a2:	7033           	moveq #51,%d0
  8002a4:	0000 0000      	orib #0,%d0
  8002a8:	4e56 fffc      	linkw %fp,#-4
  8002ac:	23fc 0080 077c 	movel #8390524,0x5032
  8002b2:	0000 5032 
  8002b6:	23fc 0080 087c 	movel #8390780,0x503a
  8002bc:	0000 503a 
  8002c0:	33fc 0001 0000 	movew #1,0x501c
  8002c6:	501c 
  8002c8:	4279 0000 502c 	clrw 0x502c
  8002ce:	0cae 0000 0002 	cmpil #2,%fp@(8)
  8002d4:	0008 
  8002d6:	6600 008e      	bnew 0x800366
  8002da:	4eb9 0080 0da2 	jsr 0x800da2
  8002e0:	4eb9 0080 0c9a 	jsr 0x800c9a
  8002e6:	4eb9 0080 0d32 	jsr 0x800d32
  8002ec:	4eb9 0080 0d6a 	jsr 0x800d6a
  8002f2:	4eb9 0080 0840 	jsr 0x800840
  8002f8:	2d40 fffc      	movel %d0,%fp@(-4)
  8002fc:	6708           	beqs 0x800306
  8002fe:	202e fffc      	movel %fp@(-4),%d0
  800302:	6000 0124      	braw 0x800428
  800306:	4eb9 0080 080c 	jsr 0x80080c
  80030c:	2d40 fffc      	movel %d0,%fp@(-4)
  800310:	42a7           	clrl %sp@-
  800312:	7001           	moveq #1,%d0
  800314:	2f00           	movel %d0,%sp@-
  800316:	4eb9 0080 0a72 	jsr 0x800a72
  80031c:	508f           	addql #8,%sp
  80031e:	42a7           	clrl %sp@-
  800320:	7002           	moveq #2,%d0
  800322:	2f00           	movel %d0,%sp@-
  800324:	4eb9 0080 0a72 	jsr 0x800a72
  80032a:	508f           	addql #8,%sp
  80032c:	42a7           	clrl %sp@-
  80032e:	7003           	moveq #3,%d0
  800330:	2f00           	movel %d0,%sp@-
  800332:	4eb9 0080 0a72 	jsr 0x800a72
  800338:	508f           	addql #8,%sp
  80033a:	2f2e 0010      	movel %fp@(16),%sp@-
  80033e:	2f3c 0000 5012 	movel #20498,%sp@-
  800344:	2f3c 0000 5032 	movel #20530,%sp@-
  80034a:	4eb9 0080 062e 	jsr 0x80062e
  800350:	defc 000c      	addaw #12,%sp
  800354:	2d40 fffc      	movel %d0,%fp@(-4)
  800358:	6708           	beqs 0x800362
  80035a:	202e fffc      	movel %fp@(-4),%d0
  80035e:	6000 00c8      	braw 0x800428
  800362:	6000 00c2      	braw 0x800426
  800366:	42b9 0080 0014 	clrl 0x800014
  80036c:	4eb9 0080 0cce 	jsr 0x800cce
  800372:	4eb9 0080 0d6a 	jsr 0x800d6a
  800378:	4eb9 0080 0954 	jsr 0x800954
  80037e:	2d40 fffc      	movel %d0,%fp@(-4)
  800382:	42a7           	clrl %sp@-
  800384:	7001           	moveq #1,%d0
  800386:	2f00           	movel %d0,%sp@-
  800388:	4eb9 0080 0ade 	jsr 0x800ade
  80038e:	508f           	addql #8,%sp
  800390:	7001           	moveq #1,%d0
  800392:	2f00           	movel %d0,%sp@-
  800394:	7002           	moveq #2,%d0
  800396:	2f00           	movel %d0,%sp@-
  800398:	4eb9 0080 0ade 	jsr 0x800ade
  80039e:	508f           	addql #8,%sp
  8003a0:	42a7           	clrl %sp@-
  8003a2:	7003           	moveq #3,%d0
  8003a4:	2f00           	movel %d0,%sp@-
  8003a6:	4eb9 0080 0ade 	jsr 0x800ade
  8003ac:	508f           	addql #8,%sp
  8003ae:	42a7           	clrl %sp@-
  8003b0:	7004           	moveq #4,%d0
  8003b2:	2f00           	movel %d0,%sp@-
  8003b4:	4eb9 0080 0ade 	jsr 0x800ade
  8003ba:	508f           	addql #8,%sp
  8003bc:	42a7           	clrl %sp@-
  8003be:	7005           	moveq #5,%d0
  8003c0:	2f00           	movel %d0,%sp@-
  8003c2:	4eb9 0080 0ade 	jsr 0x800ade
  8003c8:	508f           	addql #8,%sp
  8003ca:	7020           	moveq #32,%d0
  8003cc:	2f00           	movel %d0,%sp@-
  8003ce:	7006           	moveq #6,%d0
  8003d0:	2f00           	movel %d0,%sp@-
  8003d2:	4eb9 0080 0ade 	jsr 0x800ade
  8003d8:	508f           	addql #8,%sp
  8003da:	2f2e 0010      	movel %fp@(16),%sp@-
  8003de:	2f3c 0000 5022 	movel #20514,%sp@-
  8003e4:	2f3c 0000 503a 	movel #20538,%sp@-
  8003ea:	4eb9 0080 062e 	jsr 0x80062e
  8003f0:	defc 000c      	addaw #12,%sp
  8003f4:	2d40 fffc      	movel %d0,%fp@(-4)
  8003f8:	6706           	beqs 0x800400
  8003fa:	202e fffc      	movel %fp@(-4),%d0
  8003fe:	6028           	bras 0x800428
  800400:	2f2e 000c      	movel %fp@(12),%sp@-
  800404:	2f3c 0000 5022 	movel #20514,%sp@-
  80040a:	2f3c 0000 503a 	movel #20538,%sp@-
  800410:	4eb9 0080 0702 	jsr 0x800702
  800416:	defc 000c      	addaw #12,%sp
  80041a:	2d40 fffc      	movel %d0,%fp@(-4)
  80041e:	6706           	beqs 0x800426
  800420:	202e fffc      	movel %fp@(-4),%d0
  800424:	6002           	bras 0x800428
  800426:	4280           	clrl %d0
  800428:	4e5e           	unlk %fp
  80042a:	4e75           	rts
  80042c:	4e56 0000      	linkw %fp,#0
  800430:	23ee 0014 0000 	movel %fp@(20),0x500e
  800436:	500e 
  800438:	0cae 0000 0002 	cmpil #2,%fp@(20)
  80043e:	0014 
  800440:	6628           	bnes 0x80046a
  800442:	2f2e 000c      	movel %fp@(12),%sp@-
  800446:	2f2e 0018      	movel %fp@(24),%sp@-
  80044a:	2f2e 0010      	movel %fp@(16),%sp@-
  80044e:	2f2e 0008      	movel %fp@(8),%sp@-
  800452:	2f3c 0000 5012 	movel #20498,%sp@-
  800458:	2f39 0000 5032 	movel 0x5032,%sp@-
  80045e:	4eb9 0080 0494 	jsr 0x800494
  800464:	defc 0018      	addaw #24,%sp
  800468:	6026           	bras 0x800490
  80046a:	2f2e 000c      	movel %fp@(12),%sp@-
  80046e:	2f2e 0018      	movel %fp@(24),%sp@-
  800472:	2f2e 0010      	movel %fp@(16),%sp@-
  800476:	2f2e 0008      	movel %fp@(8),%sp@-
  80047a:	2f3c 0000 5022 	movel #20514,%sp@-
  800480:	2f39 0000 503a 	movel 0x503a,%sp@-
  800486:	4eb9 0080 0494 	jsr 0x800494
  80048c:	defc 0018      	addaw #24,%sp
  800490:	4e5e           	unlk %fp
  800492:	4e75           	rts
  800494:	4e56 fff4      	linkw %fp,#-12
  800498:	0cb9 0000 0002 	cmpil #2,0x500e
  80049e:	0000 500e 
  8004a2:	660e           	bnes 0x8004b2
  8004a4:	4eb9 0080 0ce8 	jsr 0x800ce8
  8004aa:	4eb9 0080 0c9a 	jsr 0x800c9a
  8004b0:	600c           	bras 0x8004be
  8004b2:	4eb9 0080 0cb4 	jsr 0x800cb4
  8004b8:	4eb9 0080 0cce 	jsr 0x800cce
  8004be:	202e 0014      	movel %fp@(20),%d0
  8004c2:	53ae 0014      	subql #1,%fp@(20)
  8004c6:	4a80           	tstl %d0
  8004c8:	6f00 015e      	blew 0x800628
  8004cc:	23fc 0000 0005 	movel #5,0x5006
  8004d2:	0000 5006 
  8004d6:	23fc 0000 0003 	movel #3,0x500a
  8004dc:	0000 500a 
  8004e0:	0cae 0000 0001 	cmpil #1,%fp@(24)
  8004e6:	0018 
  8004e8:	663e           	bnes 0x800528
  8004ea:	206e 000c      	moveal %fp@(12),%a0
  8004ee:	3028 0006      	movew %a0@(6),%d0
  8004f2:	4281           	clrl %d1
  8004f4:	3200           	movew %d0,%d1
  8004f6:	2f01           	movel %d1,%sp@-
  8004f8:	2f2e 0010      	movel %fp@(16),%sp@-
  8004fc:	4eb9 0080 10f8 	jsr 0x8010f8
  800502:	508f           	addql #8,%sp
  800504:	2d40 fff8      	movel %d0,%fp@(-8)
  800508:	206e 000c      	moveal %fp@(12),%a0
  80050c:	3028 0006      	movew %a0@(6),%d0
  800510:	4281           	clrl %d1
  800512:	3200           	movew %d0,%d1
  800514:	2f01           	movel %d1,%sp@-
  800516:	2f2e 0010      	movel %fp@(16),%sp@-
  80051a:	4eb9 0080 110a 	jsr 0x80110a
  800520:	508f           	addql #8,%sp
  800522:	2d40 fff4      	movel %d0,%fp@(-12)
  800526:	603c           	bras 0x800564
  800528:	206e 000c      	moveal %fp@(12),%a0
  80052c:	3028 0004      	movew %a0@(4),%d0
  800530:	4281           	clrl %d1
  800532:	3200           	movew %d0,%d1
  800534:	2f01           	movel %d1,%sp@-
  800536:	2f2e 0010      	movel %fp@(16),%sp@-
  80053a:	4eb9 0080 10f8 	jsr 0x8010f8
  800540:	508f           	addql #8,%sp
  800542:	2d40 fff8      	movel %d0,%fp@(-8)
  800546:	206e 000c      	moveal %fp@(12),%a0
  80054a:	3028 0004      	movew %a0@(4),%d0
  80054e:	4281           	clrl %d1
  800550:	3200           	movew %d0,%d1
  800552:	2f01           	movel %d1,%sp@-
  800554:	2f2e 0010      	movel %fp@(16),%sp@-
  800558:	4eb9 0080 110a 	jsr 0x80110a
  80055e:	508f           	addql #8,%sp
  800560:	2d40 fff4      	movel %d0,%fp@(-12)
  800564:	2f2e 001c      	movel %fp@(28),%sp@-
  800568:	206e 000c      	moveal %fp@(12),%a0
  80056c:	3028 000a      	movew %a0@(10),%d0
  800570:	4281           	clrl %d1
  800572:	3200           	movew %d0,%d1
  800574:	d2ae fff4      	addl %fp@(-12),%d1
  800578:	2f01           	movel %d1,%sp@-
  80057a:	206e 000c      	moveal %fp@(12),%a0
  80057e:	3028 0002      	movew %a0@(2),%d0
  800582:	4281           	clrl %d1
  800584:	3200           	movew %d0,%d1
  800586:	2f01           	movel %d1,%sp@-
  800588:	2f2e fff8      	movel %fp@(-8),%sp@-
  80058c:	4eb9 0080 110a 	jsr 0x80110a
  800592:	508f           	addql #8,%sp
  800594:	2f00           	movel %d0,%sp@-
  800596:	206e 000c      	moveal %fp@(12),%a0
  80059a:	3028 0002      	movew %a0@(2),%d0
  80059e:	4281           	clrl %d1
  8005a0:	3200           	movew %d0,%d1
  8005a2:	2f01           	movel %d1,%sp@-
  8005a4:	2f2e fff8      	movel %fp@(-8),%sp@-
  8005a8:	4eb9 0080 10f8 	jsr 0x8010f8
  8005ae:	508f           	addql #8,%sp
  8005b0:	2f00           	movel %d0,%sp@-
  8005b2:	206e 0008      	moveal %fp@(8),%a0
  8005b6:	4e90           	jsr %a0@
  8005b8:	defc 0010      	addaw #16,%sp
  8005bc:	2d40 fffc      	movel %d0,%fp@(-4)
  8005c0:	674e           	beqs 0x800610
  8005c2:	2039 0000 5006 	movel 0x5006,%d0
  8005c8:	53b9 0000 5006 	subql #1,0x5006
  8005ce:	4a80           	tstl %d0
  8005d0:	6692           	bnes 0x800564
  8005d2:	2039 0000 500a 	movel 0x500a,%d0
  8005d8:	53b9 0000 500a 	subql #1,0x500a
  8005de:	4a80           	tstl %d0
  8005e0:	6728           	beqs 0x80060a
  8005e2:	23fc 0000 0005 	movel #5,0x5006
  8005e8:	0000 5006 
  8005ec:	0cb9 0000 0002 	cmpil #2,0x500e
  8005f2:	0000 500e 
  8005f6:	6608           	bnes 0x800600
  8005f8:	4eb9 0080 080c 	jsr 0x80080c
  8005fe:	6006           	bras 0x800606
  800600:	4eb9 0080 0954 	jsr 0x800954
  800606:	6000 ff5c      	braw 0x800564
  80060a:	202e fffc      	movel %fp@(-4),%d0
  80060e:	601a           	bras 0x80062a
  800610:	206e 000c      	moveal %fp@(12),%a0
  800614:	3028 0008      	movew %a0@(8),%d0
  800618:	4281           	clrl %d1
  80061a:	3200           	movew %d0,%d1
  80061c:	d3ae 001c      	addl %d1,%fp@(28)
  800620:	52ae 0010      	addql #1,%fp@(16)
  800624:	6000 fe98      	braw 0x8004be
  800628:	4280           	clrl %d0
  80062a:	4e5e           	unlk %fp
  80062c:	4e75           	rts
  80062e:	4e56 fff8      	linkw %fp,#-8
  800632:	2d6e 0010 fff8 	movel %fp@(16),%fp@(-8)
  800638:	2f2e 0010      	movel %fp@(16),%sp@-
  80063c:	206e 000c      	moveal %fp@(12),%a0
  800640:	3028 000a      	movew %a0@(10),%d0
  800644:	4281           	clrl %d1
  800646:	3200           	movew %d0,%d1
  800648:	2f01           	movel %d1,%sp@-
  80064a:	42a7           	clrl %sp@-
  80064c:	42a7           	clrl %sp@-
  80064e:	206e 0008      	moveal %fp@(8),%a0
  800652:	2050           	moveal %a0@,%a0
  800654:	4e90           	jsr %a0@
  800656:	defc 0010      	addaw #16,%sp
  80065a:	2d40 fffc      	movel %d0,%fp@(-4)
  80065e:	6708           	beqs 0x800668
  800660:	202e fffc      	movel %fp@(-4),%d0
  800664:	6000 0098      	braw 0x8006fe
  800668:	202e 0010      	movel %fp@(16),%d0
  80066c:	0680 0000 0200 	addil #512,%d0
  800672:	2f00           	movel %d0,%sp@-
  800674:	206e 000c      	moveal %fp@(12),%a0
  800678:	3028 000a      	movew %a0@(10),%d0
  80067c:	4281           	clrl %d1
  80067e:	3200           	movew %d0,%d1
  800680:	5281           	addql #1,%d1
  800682:	2f01           	movel %d1,%sp@-
  800684:	42a7           	clrl %sp@-
  800686:	42a7           	clrl %sp@-
  800688:	206e 0008      	moveal %fp@(8),%a0
  80068c:	2050           	moveal %a0@,%a0
  80068e:	4e90           	jsr %a0@
  800690:	defc 0010      	addaw #16,%sp
  800694:	2d40 fffc      	movel %d0,%fp@(-4)
  800698:	6706           	beqs 0x8006a0
  80069a:	202e fffc      	movel %fp@(-4),%d0
  80069e:	605e           	bras 0x8006fe
  8006a0:	206e fff8      	moveal %fp@(-8),%a0
  8006a4:	226e 000c      	moveal %fp@(12),%a1
  8006a8:	32a8 000e      	movew %a0@(14),%a1@
  8006ac:	206e fff8      	moveal %fp@(-8),%a0
  8006b0:	226e 000c      	moveal %fp@(12),%a1
  8006b4:	3368 0010 0002 	movew %a0@(16),%a1@(2)
  8006ba:	206e fff8      	moveal %fp@(-8),%a0
  8006be:	3028 0012      	movew %a0@(18),%d0
  8006c2:	4281           	clrl %d1
  8006c4:	3200           	movew %d0,%d1
  8006c6:	0241 fffe      	andiw #-2,%d1
  8006ca:	206e 000c      	moveal %fp@(12),%a0
  8006ce:	3141 0004      	movew %d1,%a0@(4)
  8006d2:	206e fff8      	moveal %fp@(-8),%a0
  8006d6:	226e 000c      	moveal %fp@(12),%a1
  8006da:	3368 0012 0006 	movew %a0@(18),%a1@(6)
  8006e0:	206e fff8      	moveal %fp@(-8),%a0
  8006e4:	226e 000c      	moveal %fp@(12),%a1
  8006e8:	3368 0018 0008 	movew %a0@(24),%a1@(8)
  8006ee:	206e fff8      	moveal %fp@(-8),%a0
  8006f2:	226e 000c      	moveal %fp@(12),%a1
  8006f6:	1368 0017 000c 	moveb %a0@(23),%a1@(12)
  8006fc:	4280           	clrl %d0
  8006fe:	4e5e           	unlk %fp
  800700:	4e75           	rts
  800702:	4e56 fffc      	linkw %fp,#-4
  800706:	2f2e 0010      	movel %fp@(16),%sp@-
  80070a:	206e 000c      	moveal %fp@(12),%a0
  80070e:	3028 000a      	movew %a0@(10),%d0
  800712:	4281           	clrl %d1
  800714:	3200           	movew %d0,%d1
  800716:	5481           	addql #2,%d1
  800718:	2f01           	movel %d1,%sp@-
  80071a:	42a7           	clrl %sp@-
  80071c:	42a7           	clrl %sp@-
  80071e:	206e 0008      	moveal %fp@(8),%a0
  800722:	2050           	moveal %a0@,%a0
  800724:	4e90           	jsr %a0@
  800726:	defc 0010      	addaw #16,%sp
  80072a:	2d40 fffc      	movel %d0,%fp@(-4)
  80072e:	6706           	beqs 0x800736
  800730:	202e fffc      	movel %fp@(-4),%d0
  800734:	6042           	bras 0x800778
  800736:	202e 0010      	movel %fp@(16),%d0
  80073a:	0680 0000 0200 	addil #512,%d0
  800740:	2f00           	movel %d0,%sp@-
  800742:	206e 000c      	moveal %fp@(12),%a0
  800746:	3028 000a      	movew %a0@(10),%d0
  80074a:	4281           	clrl %d1
  80074c:	3200           	movew %d0,%d1
  80074e:	5681           	addql #3,%d1
  800750:	2f01           	movel %d1,%sp@-
  800752:	42a7           	clrl %sp@-
  800754:	42a7           	clrl %sp@-
  800756:	206e 0008      	moveal %fp@(8),%a0
  80075a:	2050           	moveal %a0@,%a0
  80075c:	4e90           	jsr %a0@
  80075e:	defc 0010      	addaw #16,%sp
  800762:	2d40 fffc      	movel %d0,%fp@(-4)
  800766:	6706           	beqs 0x80076e
  800768:	202e fffc      	movel %fp@(-4),%d0
  80076c:	600a           	bras 0x800778
  80076e:	23ee 0010 0080 	movel %fp@(16),0x800014
  800774:	0014 
  800776:	4280           	clrl %d0
  800778:	4e5e           	unlk %fp
  80077a:	4e75           	rts
  80077c:	4e56 fffc      	linkw %fp,#-4
  800780:	2f2e 0008      	movel %fp@(8),%sp@-
  800784:	4eb9 0080 07e6 	jsr 0x8007e6
  80078a:	588f           	addql #4,%sp
  80078c:	2d40 fffc      	movel %d0,%fp@(-4)
  800790:	6706           	beqs 0x800798
  800792:	202e fffc      	movel %fp@(-4),%d0
  800796:	604a           	bras 0x8007e2
  800798:	7001           	moveq #1,%d0
  80079a:	2f00           	movel %d0,%sp@-
  80079c:	2f3c 0000 0200 	movel #512,%sp@-
  8007a2:	2f2e 0014      	movel %fp@(20),%sp@-
  8007a6:	4eb9 0080 0b56 	jsr 0x800b56
  8007ac:	defc 000c      	addaw #12,%sp
  8007b0:	2f2e 0010      	movel %fp@(16),%sp@-
  8007b4:	7002           	moveq #2,%d0
  8007b6:	2f00           	movel %d0,%sp@-
  8007b8:	4eb9 0080 0a72 	jsr 0x800a72
  8007be:	508f           	addql #8,%sp
  8007c0:	2d40 fffc      	movel %d0,%fp@(-4)
  8007c4:	202e 000c      	movel %fp@(12),%d0
  8007c8:	d080           	addl %d0,%d0
  8007ca:	0040 0088      	oriw #136,%d0
  8007ce:	2f00           	movel %d0,%sp@-
  8007d0:	42a7           	clrl %sp@-
  8007d2:	4eb9 0080 0a72 	jsr 0x800a72
  8007d8:	508f           	addql #8,%sp
  8007da:	2d40 fffc      	movel %d0,%fp@(-4)
  8007de:	202e fffc      	movel %fp@(-4),%d0
  8007e2:	4e5e           	unlk %fp
  8007e4:	4e75           	rts
  8007e6:	4e56 0000      	linkw %fp,#0
  8007ea:	2f2e 0008      	movel %fp@(8),%sp@-
  8007ee:	7003           	moveq #3,%d0
  8007f0:	2f00           	movel %d0,%sp@-
  8007f2:	4eb9 0080 0a72 	jsr 0x800a72
  8007f8:	508f           	addql #8,%sp
  8007fa:	7010           	moveq #16,%d0
  8007fc:	2f00           	movel %d0,%sp@-
  8007fe:	42a7           	clrl %sp@-
  800800:	4eb9 0080 0a72 	jsr 0x800a72
  800806:	508f           	addql #8,%sp
  800808:	4e5e           	unlk %fp
  80080a:	4e75           	rts
  80080c:	4e56 0000      	linkw %fp,#0
  800810:	7003           	moveq #3,%d0
  800812:	2f00           	movel %d0,%sp@-
  800814:	42a7           	clrl %sp@-
  800816:	4eb9 0080 0a72 	jsr 0x800a72
  80081c:	508f           	addql #8,%sp
  80081e:	4e5e           	unlk %fp
  800820:	4e75           	rts
  800822:	4e56 0000      	linkw %fp,#0
  800826:	2f3c 0000 00d8 	movel #216,%sp@-
  80082c:	42a7           	clrl %sp@-
  80082e:	4eb9 0080 0a72 	jsr 0x800a72
  800834:	508f           	addql #8,%sp
  800836:	4eb9 0080 0d32 	jsr 0x800d32
  80083c:	4e5e           	unlk %fp
  80083e:	4e75           	rts
  800840:	4e56 fff8      	linkw %fp,#-8
  800844:	48ee 00c0 fff8 	moveml %d6-%d7,%fp@(-8)
  80084a:	4287           	clrl %d7
  80084c:	0c87 0000 c350 	cmpil #50000,%d7
  800852:	6c1c           	bges 0x800870
  800854:	42a7           	clrl %sp@-
  800856:	4eb9 0080 0b16 	jsr 0x800b16
  80085c:	588f           	addql #4,%sp
  80085e:	2c00           	movel %d0,%d6
  800860:	0286 0000 0080 	andil #128,%d6
  800866:	6704           	beqs 0x80086c
  800868:	5287           	addql #1,%d7
  80086a:	6002           	bras 0x80086e
  80086c:	6002           	bras 0x800870
  80086e:	60dc           	bras 0x80084c
  800870:	2006           	movel %d6,%d0
  800872:	4cee 00c0 fff8 	moveml %fp@(-8),%d6-%d7
  800878:	4e5e           	unlk %fp
  80087a:	4e75           	rts
  80087c:	4e56 fffc      	linkw %fp,#-4
  800880:	4ab9 0080 0014 	tstl 0x800014
  800886:	6716           	beqs 0x80089e
  800888:	486e 0010      	pea %fp@(16)
  80088c:	486e 000c      	pea %fp@(12)
  800890:	486e 0008      	pea %fp@(8)
  800894:	4eb9 0080 096c 	jsr 0x80096c
  80089a:	defc 000c      	addaw #12,%sp
  80089e:	7001           	moveq #1,%d0
  8008a0:	2f00           	movel %d0,%sp@-
  8008a2:	2f3c 0000 0200 	movel #512,%sp@-
  8008a8:	2f2e 0014      	movel %fp@(20),%sp@-
  8008ac:	4eb9 0080 0b56 	jsr 0x800b56
  8008b2:	defc 000c      	addaw #12,%sp
  8008b6:	2f2e 000c      	movel %fp@(12),%sp@-
  8008ba:	4eb9 0080 0d02 	jsr 0x800d02
  8008c0:	588f           	addql #4,%sp
  8008c2:	202e 000c      	movel %fp@(12),%d0
  8008c6:	0280 0000 0007 	andil #7,%d0
  8008cc:	0040 0020      	oriw #32,%d0
  8008d0:	2f00           	movel %d0,%sp@-
  8008d2:	7006           	moveq #6,%d0
  8008d4:	2f00           	movel %d0,%sp@-
  8008d6:	4eb9 0080 0ade 	jsr 0x800ade
  8008dc:	508f           	addql #8,%sp
  8008de:	2d40 fffc      	movel %d0,%fp@(-4)
  8008e2:	302e 000a      	movew %fp@(10),%d0
  8008e6:	4281           	clrl %d1
  8008e8:	3200           	movew %d0,%d1
  8008ea:	2f01           	movel %d1,%sp@-
  8008ec:	7004           	moveq #4,%d0
  8008ee:	2f00           	movel %d0,%sp@-
  8008f0:	4eb9 0080 0ade 	jsr 0x800ade
  8008f6:	508f           	addql #8,%sp
  8008f8:	2d40 fffc      	movel %d0,%fp@(-4)
  8008fc:	202e 0008      	movel %fp@(8),%d0
  800900:	e080           	asrl #8,%d0
  800902:	0280 0000 0003 	andil #3,%d0
  800908:	4281           	clrl %d1
  80090a:	3200           	movew %d0,%d1
  80090c:	2f01           	movel %d1,%sp@-
  80090e:	7005           	moveq #5,%d0
  800910:	2f00           	movel %d0,%sp@-
  800912:	4eb9 0080 0ade 	jsr 0x800ade
  800918:	508f           	addql #8,%sp
  80091a:	2d40 fffc      	movel %d0,%fp@(-4)
  80091e:	302e 0012      	movew %fp@(18),%d0
  800922:	4281           	clrl %d1
  800924:	3200           	movew %d0,%d1
  800926:	2f01           	movel %d1,%sp@-
  800928:	7003           	moveq #3,%d0
  80092a:	2f00           	movel %d0,%sp@-
  80092c:	4eb9 0080 0ade 	jsr 0x800ade
  800932:	508f           	addql #8,%sp
  800934:	2d40 fffc      	movel %d0,%fp@(-4)
  800938:	7028           	moveq #40,%d0
  80093a:	2f00           	movel %d0,%sp@-
  80093c:	7007           	moveq #7,%d0
  80093e:	2f00           	movel %d0,%sp@-
  800940:	4eb9 0080 0ade 	jsr 0x800ade
  800946:	508f           	addql #8,%sp
  800948:	2d40 fffc      	movel %d0,%fp@(-4)
  80094c:	202e fffc      	movel %fp@(-4),%d0
  800950:	4e5e           	unlk %fp
  800952:	4e75           	rts
  800954:	4e56 0000      	linkw %fp,#0
  800958:	7010           	moveq #16,%d0
  80095a:	2f00           	movel %d0,%sp@-
  80095c:	7007           	moveq #7,%d0
  80095e:	2f00           	movel %d0,%sp@-
  800960:	4eb9 0080 0ade 	jsr 0x800ade
  800966:	508f           	addql #8,%sp
  800968:	4e5e           	unlk %fp
  80096a:	4e75           	rts
  80096c:	4e56 fff8      	linkw %fp,#-8
  800970:	48ee 2000 fff8 	moveml %a5,%fp@(-8)
  800976:	2a79 0080 0014 	moveal 0x800014,%a5
  80097c:	508d           	addql #8,%a5
  80097e:	2d7c 0000 0001 	movel #1,%fp@(-4)
  800984:	fffc 
  800986:	0cae 0000 007f 	cmpil #127,%fp@(-4)
  80098c:	fffc 
  80098e:	6c00 00bc      	bgew 0x800a4c
  800992:	4a55           	tstw %a5@
  800994:	6608           	bnes 0x80099e
  800996:	4a6d 0002      	tstw %a5@(2)
  80099a:	6700 00b0      	beqw 0x800a4c
  80099e:	4280           	clrl %d0
  8009a0:	3015           	movew %a5@,%d0
  8009a2:	206e 0008      	moveal %fp@(8),%a0
  8009a6:	b090           	cmpl %a0@,%d0
  8009a8:	6600 0098      	bnew 0x800a42
  8009ac:	3039 0000 5028 	movew 0x5028,%d0
  8009b2:	3040           	moveaw %d0,%a0
  8009b4:	2f08           	movel %a0,%sp@-
  8009b6:	302d 0002      	movew %a5@(2),%d0
  8009ba:	3040           	moveaw %d0,%a0
  8009bc:	2f08           	movel %a0,%sp@-
  8009be:	4eb9 0080 10f8 	jsr 0x8010f8
  8009c4:	508f           	addql #8,%sp
  8009c6:	206e 000c      	moveal %fp@(12),%a0
  8009ca:	b090           	cmpl %a0@,%d0
  8009cc:	6674           	bnes 0x800a42
  8009ce:	3039 0000 5028 	movew 0x5028,%d0
  8009d4:	3040           	moveaw %d0,%a0
  8009d6:	2f08           	movel %a0,%sp@-
  8009d8:	302d 0002      	movew %a5@(2),%d0
  8009dc:	3040           	moveaw %d0,%a0
  8009de:	2f08           	movel %a0,%sp@-
  8009e0:	4eb9 0080 110a 	jsr 0x80110a
  8009e6:	508f           	addql #8,%sp
  8009e8:	206e 0010      	moveal %fp@(16),%a0
  8009ec:	b090           	cmpl %a0@,%d0
  8009ee:	6652           	bnes 0x800a42
  8009f0:	4280           	clrl %d0
  8009f2:	3039 0000 5024 	movew 0x5024,%d0
  8009f8:	2f00           	movel %d0,%sp@-
  8009fa:	4280           	clrl %d0
  8009fc:	302d 0004      	movew %a5@(4),%d0
  800a00:	2f00           	movel %d0,%sp@-
  800a02:	4eb9 0080 10f8 	jsr 0x8010f8
  800a08:	508f           	addql #8,%sp
  800a0a:	206e 0008      	moveal %fp@(8),%a0
  800a0e:	2080           	movel %d0,%a0@
  800a10:	4280           	clrl %d0
  800a12:	3039 0000 5024 	movew 0x5024,%d0
  800a18:	2f00           	movel %d0,%sp@-
  800a1a:	4280           	clrl %d0
  800a1c:	302d 0004      	movew %a5@(4),%d0
  800a20:	2f00           	movel %d0,%sp@-
  800a22:	4eb9 0080 110a 	jsr 0x80110a
  800a28:	508f           	addql #8,%sp
  800a2a:	206e 000c      	moveal %fp@(12),%a0
  800a2e:	2080           	movel %d0,%a0@
  800a30:	4280           	clrl %d0
  800a32:	3039 0000 5028 	movew 0x5028,%d0
  800a38:	5380           	subql #1,%d0
  800a3a:	206e 0010      	moveal %fp@(16),%a0
  800a3e:	2080           	movel %d0,%a0@
  800a40:	600a           	bras 0x800a4c
  800a42:	508d           	addql #8,%a5
  800a44:	52ae fffc      	addql #1,%fp@(-4)
  800a48:	6000 ff3c      	braw 0x800986
  800a4c:	4cee 2000 fff8 	moveml %fp@(-8),%a5
  800a52:	4e5e           	unlk %fp
  800a54:	4e75           	rts
  800a56:	4e56 fffc      	linkw %fp,#-4
  800a5a:	42ae fffc      	clrl %fp@(-4)
  800a5e:	0cae 0000 03e8 	cmpil #1000,%fp@(-4)
  800a64:	fffc 
  800a66:	6c06           	bges 0x800a6e
  800a68:	52ae fffc      	addql #1,%fp@(-4)
  800a6c:	60f0           	bras 0x800a5e
  800a6e:	4e5e           	unlk %fp
  800a70:	4e75           	rts
  800a72:	4e56 fffc      	linkw %fp,#-4
  800a76:	4280           	clrl %d0
  800a78:	302e 000a      	movew %fp@(10),%d0
  800a7c:	d080           	addl %d0,%d0
  800a7e:	0680 00e1 0000 	addil #14745600,%d0
  800a84:	2040           	moveal %d0,%a0
  800a86:	30ae 000e      	movew %fp@(14),%a0@
  800a8a:	4a6e 000a      	tstw %fp@(10)
  800a8e:	6646           	bnes 0x800ad6
  800a90:	4eb9 0080 0e14 	jsr 0x800e14
  800a96:	2d40 fffc      	movel %d0,%fp@(-4)
  800a9a:	082e 0007 000f 	btst #7,%fp@(15)
  800aa0:	661a           	bnes 0x800abc
  800aa2:	202e fffc      	movel %fp@(-4),%d0
  800aa6:	0280 8000 0098 	andil #-2147483496,%d0
  800aac:	670c           	beqs 0x800aba
  800aae:	202e fffc      	movel %fp@(-4),%d0
  800ab2:	0280 8000 0098 	andil #-2147483496,%d0
  800ab8:	6020           	bras 0x800ada
  800aba:	6018           	bras 0x800ad4
  800abc:	202e fffc      	movel %fp@(-4),%d0
  800ac0:	0280 8000 00bc 	andil #-2147483460,%d0
  800ac6:	670c           	beqs 0x800ad4
  800ac8:	202e fffc      	movel %fp@(-4),%d0
  800acc:	0280 8000 00bc 	andil #-2147483460,%d0
  800ad2:	6006           	bras 0x800ada
  800ad4:	6004           	bras 0x800ada
  800ad6:	4280           	clrl %d0
  800ad8:	4e71           	nop
  800ada:	4e5e           	unlk %fp
  800adc:	4e75           	rts
  800ade:	4e56 0000      	linkw %fp,#0
  800ae2:	33f9 0000 5000 	movew 0x5000,0x4e0000
  800ae8:	004e 0000 
  800aec:	4280           	clrl %d0
  800aee:	302e 000a      	movew %fp@(10),%d0
  800af2:	d080           	addl %d0,%d0
  800af4:	0680 00e0 0000 	addil #14680064,%d0
  800afa:	2040           	moveal %d0,%a0
  800afc:	30ae 000e      	movew %fp@(14),%a0@
  800b00:	0c6e 0007 000a 	cmpiw #7,%fp@(10)
  800b06:	6608           	bnes 0x800b10
  800b08:	4eb9 0080 0dd6 	jsr 0x800dd6
  800b0e:	6002           	bras 0x800b12
  800b10:	4280           	clrl %d0
  800b12:	4e5e           	unlk %fp
  800b14:	4e75           	rts
  800b16:	4e56 0000      	linkw %fp,#0
  800b1a:	4280           	clrl %d0
  800b1c:	302e 000a      	movew %fp@(10),%d0
  800b20:	d080           	addl %d0,%d0
  800b22:	0680 00e1 0000 	addil #14745600,%d0
  800b28:	2040           	moveal %d0,%a0
  800b2a:	3010           	movew %a0@,%d0
  800b2c:	4281           	clrl %d1
  800b2e:	3200           	movew %d0,%d1
  800b30:	2001           	movel %d1,%d0
  800b32:	4e5e           	unlk %fp
  800b34:	4e75           	rts
  800b36:	4e56 0000      	linkw %fp,#0
  800b3a:	4280           	clrl %d0
  800b3c:	302e 000a      	movew %fp@(10),%d0
  800b40:	d080           	addl %d0,%d0
  800b42:	0680 00e0 0000 	addil #14680064,%d0
  800b48:	2040           	moveal %d0,%a0
  800b4a:	3010           	movew %a0@,%d0
  800b4c:	4281           	clrl %d1
  800b4e:	3200           	movew %d0,%d1
  800b50:	2001           	movel %d1,%d0
  800b52:	4e5e           	unlk %fp
  800b54:	4e75           	rts
  800b56:	4e56 fffc      	linkw %fp,#-4
  800b5a:	202e 000c      	movel %fp@(12),%d0
  800b5e:	e280           	asrl #1,%d0
  800b60:	5280           	addql #1,%d0
  800b62:	4480           	negl %d0
  800b64:	3d40 fffe      	movew %d0,%fp@(-2)
  800b68:	202e 0008      	movel %fp@(8),%d0
  800b6c:	0280 0000 01fe 	andil #510,%d0
  800b72:	4281           	clrl %d1
  800b74:	3200           	movew %d0,%d1
  800b76:	0681 004d 0000 	addil #5046272,%d1
  800b7c:	2041           	moveal %d1,%a0
  800b7e:	4210           	clrb %a0@
  800b80:	202e 0008      	movel %fp@(8),%d0
  800b84:	e080           	asrl #8,%d0
  800b86:	0280 0000 1ffe 	andil #8190,%d0
  800b8c:	4281           	clrl %d1
  800b8e:	3200           	movew %d0,%d1
  800b90:	0681 004d 4000 	addil #5062656,%d1
  800b96:	2041           	moveal %d1,%a0
  800b98:	4210           	clrb %a0@
  800b9a:	4a2e 0013      	tstb %fp@(19)
  800b9e:	6626           	bnes 0x800bc6
  800ba0:	0079 4000 0000 	oriw #16384,0x5002
  800ba6:	5002 
  800ba8:	33f9 0000 5002 	movew 0x5002,0x4a0000
  800bae:	004a 0000 
  800bb2:	4280           	clrl %d0
  800bb4:	302e fffe      	movew %fp@(-2),%d0
  800bb8:	0040 c000      	oriw #-16384,%d0
  800bbc:	33c0 0046 0000 	movew %d0,0x460000
  800bc2:	6000 0084      	braw 0x800c48
  800bc6:	0279 bfff 0000 	andiw #-16385,0x5002
  800bcc:	5002 
  800bce:	33f9 0000 5002 	movew 0x5002,0x4a0000
  800bd4:	004a 0000 
  800bd8:	4280           	clrl %d0
  800bda:	302e fffe      	movew %fp@(-2),%d0
  800bde:	0040 8000      	oriw #-32768,%d0
  800be2:	0240 bfff      	andiw #-16385,%d0
  800be6:	33c0 0046 0000 	movew %d0,0x460000
  800bec:	4280           	clrl %d0
  800bee:	302e fffe      	movew %fp@(-2),%d0
  800bf2:	0040 8000      	oriw #-32768,%d0
  800bf6:	4281           	clrl %d1
  800bf8:	3239 0046 0000 	movew 0x460000,%d1
  800bfe:	b081           	cmpl %d1,%d0
  800c00:	67ea           	beqs 0x800bec
  800c02:	202e 0008      	movel %fp@(8),%d0
  800c06:	0280 0000 01fe 	andil #510,%d0
  800c0c:	4281           	clrl %d1
  800c0e:	3200           	movew %d0,%d1
  800c10:	0681 004d 0000 	addil #5046272,%d1
  800c16:	2041           	moveal %d1,%a0
  800c18:	4210           	clrb %a0@
  800c1a:	202e 0008      	movel %fp@(8),%d0
  800c1e:	e080           	asrl #8,%d0
  800c20:	0280 0000 1ffe 	andil #8190,%d0
  800c26:	4281           	clrl %d1
  800c28:	3200           	movew %d0,%d1
  800c2a:	0681 004d 4000 	addil #5062656,%d1
  800c30:	2041           	moveal %d1,%a0
  800c32:	4210           	clrb %a0@
  800c34:	4280           	clrl %d0
  800c36:	302e fffe      	movew %fp@(-2),%d0
  800c3a:	0040 8000      	oriw #-32768,%d0
  800c3e:	0240 bfff      	andiw #-16385,%d0
  800c42:	33c0 0046 0000 	movew %d0,0x460000
  800c48:	33fc ffff 0000 	movew #-1,0x5004
  800c4e:	5004 
  800c50:	4e5e           	unlk %fp
  800c52:	4e75           	rts
  800c54:	4e56 fffc      	linkw %fp,#-4
  800c58:	48ee 0080 fffc 	moveml %d7,%fp@(-4)
  800c5e:	4a79 0000 5004 	tstw 0x5004
  800c64:	6604           	bnes 0x800c6a
  800c66:	4280           	clrl %d0
  800c68:	6026           	bras 0x800c90
  800c6a:	4279 0000 5004 	clrw 0x5004
  800c70:	4287           	clrl %d7
  800c72:	3e39 0046 0000 	movew 0x460000,%d7
  800c78:	4279 0046 0000 	clrw 0x460000
  800c7e:	4239 004d 0000 	clrb 0x4d0000
  800c84:	5287           	addql #1,%d7
  800c86:	2007           	movel %d7,%d0
  800c88:	0240 3fff      	andiw #16383,%d0
  800c8c:	4840           	swap %d0
  800c8e:	4240           	clrw %d0
  800c90:	4cee 0080 fffc 	moveml %fp@(-4),%d7
  800c96:	4e5e           	unlk %fp
  800c98:	4e75           	rts
  800c9a:	4e56 0000      	linkw %fp,#0
  800c9e:	0079 0040 0000 	oriw #64,0x5000
  800ca4:	5000 
  800ca6:	33f9 0000 5000 	movew 0x5000,0x4e0000
  800cac:	004e 0000 
  800cb0:	4e5e           	unlk %fp
  800cb2:	4e75           	rts
  800cb4:	4e56 0000      	linkw %fp,#0
  800cb8:	0279 ffbf 0000 	andiw #-65,0x5000
  800cbe:	5000 
  800cc0:	33f9 0000 5000 	movew 0x5000,0x4e0000
  800cc6:	004e 0000 
  800cca:	4e5e           	unlk %fp
  800ccc:	4e75           	rts
  800cce:	4e56 0000      	linkw %fp,#0
  800cd2:	0079 0008 0000 	oriw #8,0x5000
  800cd8:	5000 
  800cda:	33f9 0000 5000 	movew 0x5000,0x4e0000
  800ce0:	004e 0000 
  800ce4:	4e5e           	unlk %fp
  800ce6:	4e75           	rts
  800ce8:	4e56 0000      	linkw %fp,#0
  800cec:	0279 fff7 0000 	andiw #-9,0x5000
  800cf2:	5000 
  800cf4:	33f9 0000 5000 	movew 0x5000,0x4e0000
  800cfa:	004e 0000 
  800cfe:	4e5e           	unlk %fp
  800d00:	4e75           	rts
  800d02:	4e56 0000      	linkw %fp,#0
  800d06:	0279 fff8 0000 	andiw #-8,0x5000
  800d0c:	5000 
  800d0e:	202e 0008      	movel %fp@(8),%d0
  800d12:	0280 0000 0007 	andil #7,%d0
  800d18:	0280 0000 ffff 	andil #65535,%d0
  800d1e:	8179 0000 5000 	orw %d0,0x5000
  800d24:	33f9 0000 5000 	movew 0x5000,0x4e0000
  800d2a:	004e 0000 
  800d2e:	4e5e           	unlk %fp
  800d30:	4e75           	rts
  800d32:	4e56 0000      	linkw %fp,#0
  800d36:	0279 ff7f 0000 	andiw #-129,0x5000
  800d3c:	5000 
  800d3e:	33f9 0000 5000 	movew 0x5000,0x4e0000
  800d44:	004e 0000 
  800d48:	4eb9 0080 0a56 	jsr 0x800a56
  800d4e:	0079 0080 0000 	oriw #128,0x5000
  800d54:	5000 
  800d56:	33f9 0000 5000 	movew 0x5000,0x4e0000
  800d5c:	004e 0000 
  800d60:	4eb9 0080 0a56 	jsr 0x800a56
  800d66:	4e5e           	unlk %fp
  800d68:	4e75           	rts
  800d6a:	4e56 0000      	linkw %fp,#0
  800d6e:	0279 ffef 0000 	andiw #-17,0x5000
  800d74:	5000 
  800d76:	33f9 0000 5000 	movew 0x5000,0x4e0000
  800d7c:	004e 0000 
  800d80:	4eb9 0080 0a56 	jsr 0x800a56
  800d86:	0079 0010 0000 	oriw #16,0x5000
  800d8c:	5000 
  800d8e:	33f9 0000 5000 	movew 0x5000,0x4e0000
  800d94:	004e 0000 
  800d98:	4eb9 0080 0a56 	jsr 0x800a56
  800d9e:	4e5e           	unlk %fp
  800da0:	4e75           	rts
  800da2:	4e56 0000      	linkw %fp,#0
  800da6:	0079 0020 0000 	oriw #32,0x5000
  800dac:	5000 
  800dae:	33f9 0000 5000 	movew 0x5000,0x4e0000
  800db4:	004e 0000 
  800db8:	4e5e           	unlk %fp
  800dba:	4e75           	rts
  800dbc:	4e56 0000      	linkw %fp,#0
  800dc0:	0279 ffdf 0000 	andiw #-33,0x5000
  800dc6:	5000 
  800dc8:	33f9 0000 5000 	movew 0x5000,0x4e0000
  800dce:	004e 0000 
  800dd2:	4e5e           	unlk %fp
  800dd4:	4e75           	rts
  800dd6:	4e56 fffc      	linkw %fp,#-4
  800dda:	0839 0002 0047 	btst #2,0x470001
  800de0:	0001 
  800de2:	6602           	bnes 0x800de6
  800de4:	60f4           	bras 0x800dda
  800de6:	4eb9 0080 0c54 	jsr 0x800c54
  800dec:	2d40 fffc      	movel %d0,%fp@(-4)
  800df0:	7007           	moveq #7,%d0
  800df2:	2f00           	movel %d0,%sp@-
  800df4:	4eb9 0080 0b36 	jsr 0x800b36
  800dfa:	588f           	addql #4,%sp
  800dfc:	0280 0000 0001 	andil #1,%d0
  800e02:	81ae fffc      	orl %d0,%fp@(-4)
  800e06:	4eb9 0080 0d6a 	jsr 0x800d6a
  800e0c:	202e fffc      	movel %fp@(-4),%d0
  800e10:	4e5e           	unlk %fp
  800e12:	4e75           	rts
  800e14:	4e56 fffc      	linkw %fp,#-4
  800e18:	0839 0003 0047 	btst #3,0x470001
  800e1e:	0001 
  800e20:	6602           	bnes 0x800e24
  800e22:	60f4           	bras 0x800e18
  800e24:	4eb9 0080 0c54 	jsr 0x800c54
  800e2a:	2d40 fffc      	movel %d0,%fp@(-4)
  800e2e:	42a7           	clrl %sp@-
  800e30:	4eb9 0080 0b16 	jsr 0x800b16
  800e36:	588f           	addql #4,%sp
  800e38:	81ae fffc      	orl %d0,%fp@(-4)
  800e3c:	202e fffc      	movel %fp@(-4),%d0
  800e40:	4e5e           	unlk %fp
  800e42:	4e75           	rts
  800e44:	4e56 fff4      	linkw %fp,#-12
  800e48:	48ee 20c0 fff4 	moveml %d6-%d7/%a5,%fp@(-12)
  800e4e:	7c04           	moveq #4,%d6
  800e50:	2a79 0080 000c 	moveal 0x80000c,%a5
  800e56:	42b9 0000 5046 	clrl 0x5046
  800e5c:	23f9 0000 5046 	movel 0x5046,0x5042
  800e62:	0000 5042 
  800e66:	4eb9 0080 0f44 	jsr 0x800f44
  800e6c:	5586           	subql #2,%d6
  800e6e:	4a86           	tstl %d6
  800e70:	6c08           	bges 0x800e7a
  800e72:	4eb9 0080 0f44 	jsr 0x800f44
  800e78:	7c02           	moveq #2,%d6
  800e7a:	2f39 0080 000c 	movel 0x80000c,%sp@-
  800e80:	2f39 0080 0010 	movel 0x800010,%sp@-
  800e86:	2f06           	movel %d6,%sp@-
  800e88:	4eb9 0080 02a8 	jsr 0x8002a8
  800e8e:	defc 000c      	addaw #12,%sp
  800e92:	2e00           	movel %d0,%d7
  800e94:	4a87           	tstl %d7
  800e96:	66d4           	bnes 0x800e6c
  800e98:	4a86           	tstl %d6
  800e9a:	6726           	beqs 0x800ec2
  800e9c:	4eb9 0080 0ce8 	jsr 0x800ce8
  800ea2:	2f39 0080 000c 	movel 0x80000c,%sp@-
  800ea8:	2f3c 0000 5012 	movel #20498,%sp@-
  800eae:	2f3c 0000 5032 	movel #20530,%sp@-
  800eb4:	4eb9 0080 062e 	jsr 0x80062e
  800eba:	defc 000c      	addaw #12,%sp
  800ebe:	2e00           	movel %d0,%d7
  800ec0:	6024           	bras 0x800ee6
  800ec2:	4eb9 0080 0cb4 	jsr 0x800cb4
  800ec8:	2f39 0080 000c 	movel 0x80000c,%sp@-
  800ece:	2f3c 0000 5022 	movel #20514,%sp@-
  800ed4:	2f3c 0000 503a 	movel #20538,%sp@-
  800eda:	4eb9 0080 062e 	jsr 0x80062e
  800ee0:	defc 000c      	addaw #12,%sp
  800ee4:	2e00           	movel %d0,%d7
  800ee6:	4a87           	tstl %d7
  800ee8:	6682           	bnes 0x800e6c
  800eea:	4a6d 005e      	tstw %a5@(94)
  800eee:	6604           	bnes 0x800ef4
  800ef0:	6000 ff7a      	braw 0x800e6c
  800ef4:	42a7           	clrl %sp@-
  800ef6:	2f06           	movel %d6,%sp@-
  800ef8:	4280           	clrl %d0
  800efa:	302d 005e      	movew %a5@(94),%d0
  800efe:	d080           	addl %d0,%d0
  800f00:	2f00           	movel %d0,%sp@-
  800f02:	2f3c 0007 0000 	movel #458752,%sp@-
  800f08:	202d 005a      	movel %a5@(90),%d0
  800f0c:	d080           	addl %d0,%d0
  800f0e:	2f00           	movel %d0,%sp@-
  800f10:	4eb9 0080 042c 	jsr 0x80042c
  800f16:	defc 0014      	addaw #20,%sp
  800f1a:	2e00           	movel %d0,%d7
  800f1c:	4a87           	tstl %d7
  800f1e:	6600 ff4c      	bnew 0x800e6c
  800f22:	4eb9 0080 0dbc 	jsr 0x800dbc
  800f28:	4eb9 0080 0cb4 	jsr 0x800cb4
  800f2e:	4eb9 0080 0ce8 	jsr 0x800ce8
  800f34:	4eb9 0080 0286 	jsr 0x800286
  800f3a:	4cee 20c0 fff4 	moveml %fp@(-12),%d6-%d7/%a5
  800f40:	4e5e           	unlk %fp
  800f42:	4e75           	rts
  800f44:	4e56 fffc      	linkw %fp,#-4
  800f48:	3d79 0000 5044 	movew 0x5044,%fp@(-2)
  800f4e:	fffe 
  800f50:	4280           	clrl %d0
  800f52:	302e fffe      	movew %fp@(-2),%d0
  800f56:	2239 0000 5042 	movel 0x5042,%d1
  800f5c:	5c81           	addql #6,%d1
  800f5e:	b081           	cmpl %d1,%d0
  800f60:	625a           	bhis 0x800fbc
  800f62:	2f3c 0000 ffff 	movel #65535,%sp@-
  800f68:	2039 0000 5046 	movel 0x5046,%d0
  800f6e:	5880           	addql #4,%d0
  800f70:	2f00           	movel %d0,%sp@-
  800f72:	2f39 0000 5046 	movel 0x5046,%sp@-
  800f78:	4280           	clrl %d0
  800f7a:	302e fffe      	movew %fp@(-2),%d0
  800f7e:	2f00           	movel %d0,%sp@-
  800f80:	4eb9 0080 0ff8 	jsr 0x800ff8
  800f86:	defc 0010      	addaw #16,%sp
  800f8a:	42a7           	clrl %sp@-
  800f8c:	2039 0000 5046 	movel 0x5046,%d0
  800f92:	0680 0000 0009 	addil #9,%d0
  800f98:	2f00           	movel %d0,%sp@-
  800f9a:	2039 0000 5046 	movel 0x5046,%d0
  800fa0:	5a80           	addql #5,%d0
  800fa2:	2f00           	movel %d0,%sp@-
  800fa4:	4280           	clrl %d0
  800fa6:	302e fffe      	movew %fp@(-2),%d0
  800faa:	2f00           	movel %d0,%sp@-
  800fac:	4eb9 0080 0ff8 	jsr 0x800ff8
  800fb2:	defc 0010      	addaw #16,%sp
  800fb6:	526e fffe      	addqw #1,%fp@(-2)
  800fba:	6094           	bras 0x800f50
  800fbc:	06b9 0000 000a 	addil #10,0x5046
  800fc2:	0000 5046 
  800fc6:	0cb9 0000 02d0 	cmpil #720,0x5046
  800fcc:	0000 5046 
  800fd0:	6d22           	blts 0x800ff4
  800fd2:	42b9 0000 5046 	clrl 0x5046
  800fd8:	06b9 0000 000c 	addil #12,0x5042
  800fde:	0000 5042 
  800fe2:	0cb9 0000 015c 	cmpil #348,0x5042
  800fe8:	0000 5042 
  800fec:	6d06           	blts 0x800ff4
  800fee:	42b9 0000 5042 	clrl 0x5042
  800ff4:	4e5e           	unlk %fp
  800ff6:	4e75           	rts
  800ff8:	4e56 fffc      	linkw %fp,#-4
  800ffc:	3d6e 000e fffc 	movew %fp@(14),%fp@(-4)
  801002:	302e fffc      	movew %fp@(-4),%d0
  801006:	b06e 0012      	cmpw %fp@(18),%d0
  80100a:	6224           	bhis 0x801030
  80100c:	2f2e 0014      	movel %fp@(20),%sp@-
  801010:	4280           	clrl %d0
  801012:	302e 000a      	movew %fp@(10),%d0
  801016:	2f00           	movel %d0,%sp@-
  801018:	4280           	clrl %d0
  80101a:	302e fffc      	movew %fp@(-4),%d0
  80101e:	2f00           	movel %d0,%sp@-
  801020:	4eb9 0080 1034 	jsr 0x801034
  801026:	defc 000c      	addaw #12,%sp
  80102a:	526e fffc      	addqw #1,%fp@(-4)
  80102e:	60d2           	bras 0x801002
  801030:	4e5e           	unlk %fp
  801032:	4e75           	rts
  801034:	4e56 fff8      	linkw %fp,#-8
  801038:	322e 000e      	movew %fp@(14),%d1
  80103c:	c2fc 005a      	muluw #90,%d1
  801040:	0681 0042 0000 	addil #4325376,%d1
  801046:	4280           	clrl %d0
  801048:	302e 000a      	movew %fp@(10),%d0
  80104c:	e888           	lsrl #4,%d0
  80104e:	d080           	addl %d0,%d0
  801050:	d280           	addl %d0,%d1
  801052:	2d41 fffc      	movel %d1,%fp@(-4)
  801056:	4280           	clrl %d0
  801058:	302e 000a      	movew %fp@(10),%d0
  80105c:	4281           	clrl %d1
  80105e:	322e 000a      	movew %fp@(10),%d1
  801062:	e889           	lsrl #4,%d1
  801064:	e989           	lsll #4,%d1
  801066:	9081           	subl %d1,%d0
  801068:	3d40 fffa      	movew %d0,%fp@(-6)
  80106c:	4280           	clrl %d0
  80106e:	302e fffa      	movew %fp@(-6),%d0
  801072:	2f00           	movel %d0,%sp@-
  801074:	4eb9 0080 10a2 	jsr 0x8010a2
  80107a:	588f           	addql #4,%sp
  80107c:	3d40 fffa      	movew %d0,%fp@(-6)
  801080:	4aae 0010      	tstl %fp@(16)
  801084:	670c           	beqs 0x801092
  801086:	206e fffc      	moveal %fp@(-4),%a0
  80108a:	302e fffa      	movew %fp@(-6),%d0
  80108e:	8150           	orw %d0,%a0@
  801090:	600c           	bras 0x80109e
  801092:	302e fffa      	movew %fp@(-6),%d0
  801096:	4640           	notw %d0
  801098:	206e fffc      	moveal %fp@(-4),%a0
  80109c:	c150           	andw %d0,%a0@
  80109e:	4e5e           	unlk %fp
  8010a0:	4e75           	rts
  8010a2:	4e56 fffc      	linkw %fp,#-4
  8010a6:	3d7c 0001 fffe 	movew #1,%fp@(-2)
  8010ac:	4280           	clrl %d0
  8010ae:	302e fffe      	movew %fp@(-2),%d0
  8010b2:	4281           	clrl %d1
  8010b4:	322e 000a      	movew %fp@(10),%d1
  8010b8:	e3a8           	lsll %d1,%d0
  8010ba:	3d40 fffe      	movew %d0,%fp@(-2)
  8010be:	302e fffe      	movew %fp@(-2),%d0
  8010c2:	4e5e           	unlk %fp
  8010c4:	4e75           	rts
  8010c6:	0000 2f01      	orib #1,%d0
  8010ca:	4280           	clrl %d0
  8010cc:	302f 000a      	movew %sp@(10),%d0
  8010d0:	c0ef 000e      	muluw %sp@(14),%d0
  8010d4:	4281           	clrl %d1
  8010d6:	322f 0008      	movew %sp@(8),%d1
  8010da:	c2ef 000e      	muluw %sp@(14),%d1
  8010de:	4841           	swap %d1
  8010e0:	4241           	clrw %d1
  8010e2:	d081           	addl %d1,%d0
  8010e4:	4281           	clrl %d1
  8010e6:	322f 000c      	movew %sp@(12),%d1
  8010ea:	c2ef 000a      	muluw %sp@(10),%d1
  8010ee:	4841           	swap %d1
  8010f0:	4241           	clrw %d1
  8010f2:	d081           	addl %d1,%d0
  8010f4:	221f           	movel %sp@+,%d1
  8010f6:	4e75           	rts
  8010f8:	2f01           	movel %d1,%sp@-
  8010fa:	4280           	clrl %d0
  8010fc:	202f 0008      	movel %sp@(8),%d0
  801100:	81ef 000e      	divsw %sp@(14),%d0
  801104:	48c0           	extl %d0
  801106:	221f           	movel %sp@+,%d1
  801108:	4e75           	rts
  80110a:	2f01           	movel %d1,%sp@-
  80110c:	4280           	clrl %d0
  80110e:	202f 0008      	movel %sp@(8),%d0
  801112:	81ef 000e      	divsw %sp@(14),%d0
  801116:	e080           	asrl #8,%d0
  801118:	e080           	asrl #8,%d0
  80111a:	221f           	movel %sp@+,%d1
  80111c:	4e75           	rts
	...
  803ffe:	ffff           	.short 0xffff
