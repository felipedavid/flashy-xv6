
user/_trace:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	7169                	addi	sp,sp,-304
   2:	f606                	sd	ra,296(sp)
   4:	f222                	sd	s0,288(sp)
   6:	1a00                	addi	s0,sp,304
   8:	87aa                	mv	a5,a0
   a:	ecb43823          	sd	a1,-304(s0)
   e:	ecf42e23          	sw	a5,-292(s0)
  int i;
  char *nargv[MAXARG];

  if(argc < 3 || (argv[1][0] < '0' || argv[1][0] > '9')){
  12:	edc42783          	lw	a5,-292(s0)
  16:	0007871b          	sext.w	a4,a5
  1a:	4789                	li	a5,2
  1c:	02e7d863          	bge	a5,a4,4c <main+0x4c>
  20:	ed043783          	ld	a5,-304(s0)
  24:	07a1                	addi	a5,a5,8
  26:	639c                	ld	a5,0(a5)
  28:	0007c783          	lbu	a5,0(a5)
  2c:	873e                	mv	a4,a5
  2e:	02f00793          	li	a5,47
  32:	00e7fd63          	bgeu	a5,a4,4c <main+0x4c>
  36:	ed043783          	ld	a5,-304(s0)
  3a:	07a1                	addi	a5,a5,8
  3c:	639c                	ld	a5,0(a5)
  3e:	0007c783          	lbu	a5,0(a5)
  42:	873e                	mv	a4,a5
  44:	03900793          	li	a5,57
  48:	02e7f463          	bgeu	a5,a4,70 <main+0x70>
    fprintf(2, "Usage: %s mask command\n", argv[0]);
  4c:	ed043783          	ld	a5,-304(s0)
  50:	639c                	ld	a5,0(a5)
  52:	863e                	mv	a2,a5
  54:	00001597          	auipc	a1,0x1
  58:	dec58593          	addi	a1,a1,-532 # e40 <malloc+0x140>
  5c:	4509                	li	a0,2
  5e:	00001097          	auipc	ra,0x1
  62:	a58080e7          	jalr	-1448(ra) # ab6 <fprintf>
    exit(1);
  66:	4505                	li	a0,1
  68:	00000097          	auipc	ra,0x0
  6c:	56e080e7          	jalr	1390(ra) # 5d6 <exit>
  }

  if (trace(atoi(argv[1])) < 0) {
  70:	ed043783          	ld	a5,-304(s0)
  74:	07a1                	addi	a5,a5,8
  76:	639c                	ld	a5,0(a5)
  78:	853e                	mv	a0,a5
  7a:	00000097          	auipc	ra,0x0
  7e:	362080e7          	jalr	866(ra) # 3dc <atoi>
  82:	87aa                	mv	a5,a0
  84:	2781                	sext.w	a5,a5
  86:	853e                	mv	a0,a5
  88:	00000097          	auipc	ra,0x0
  8c:	5ee080e7          	jalr	1518(ra) # 676 <trace>
  90:	87aa                	mv	a5,a0
  92:	0207d463          	bgez	a5,ba <main+0xba>
    fprintf(2, "%s: trace failed\n", argv[0]);
  96:	ed043783          	ld	a5,-304(s0)
  9a:	639c                	ld	a5,0(a5)
  9c:	863e                	mv	a2,a5
  9e:	00001597          	auipc	a1,0x1
  a2:	dba58593          	addi	a1,a1,-582 # e58 <malloc+0x158>
  a6:	4509                	li	a0,2
  a8:	00001097          	auipc	ra,0x1
  ac:	a0e080e7          	jalr	-1522(ra) # ab6 <fprintf>
    exit(1);
  b0:	4505                	li	a0,1
  b2:	00000097          	auipc	ra,0x0
  b6:	524080e7          	jalr	1316(ra) # 5d6 <exit>
  }
  
  for(i = 2; i < argc && i < MAXARG; i++){
  ba:	4789                	li	a5,2
  bc:	fef42623          	sw	a5,-20(s0)
  c0:	a035                	j	ec <main+0xec>
    nargv[i-2] = argv[i];
  c2:	fec42783          	lw	a5,-20(s0)
  c6:	078e                	slli	a5,a5,0x3
  c8:	ed043703          	ld	a4,-304(s0)
  cc:	973e                	add	a4,a4,a5
  ce:	fec42783          	lw	a5,-20(s0)
  d2:	37f9                	addiw	a5,a5,-2
  d4:	2781                	sext.w	a5,a5
  d6:	6318                	ld	a4,0(a4)
  d8:	078e                	slli	a5,a5,0x3
  da:	17c1                	addi	a5,a5,-16
  dc:	97a2                	add	a5,a5,s0
  de:	eee7bc23          	sd	a4,-264(a5)
  for(i = 2; i < argc && i < MAXARG; i++){
  e2:	fec42783          	lw	a5,-20(s0)
  e6:	2785                	addiw	a5,a5,1
  e8:	fef42623          	sw	a5,-20(s0)
  ec:	fec42783          	lw	a5,-20(s0)
  f0:	873e                	mv	a4,a5
  f2:	edc42783          	lw	a5,-292(s0)
  f6:	2701                	sext.w	a4,a4
  f8:	2781                	sext.w	a5,a5
  fa:	00f75963          	bge	a4,a5,10c <main+0x10c>
  fe:	fec42783          	lw	a5,-20(s0)
 102:	0007871b          	sext.w	a4,a5
 106:	47fd                	li	a5,31
 108:	fae7dde3          	bge	a5,a4,c2 <main+0xc2>
  }
  exec(nargv[0], nargv);
 10c:	ee843783          	ld	a5,-280(s0)
 110:	ee840713          	addi	a4,s0,-280
 114:	85ba                	mv	a1,a4
 116:	853e                	mv	a0,a5
 118:	00000097          	auipc	ra,0x0
 11c:	4f6080e7          	jalr	1270(ra) # 60e <exec>
  exit(0);
 120:	4501                	li	a0,0
 122:	00000097          	auipc	ra,0x0
 126:	4b4080e7          	jalr	1204(ra) # 5d6 <exit>

000000000000012a <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 12a:	1141                	addi	sp,sp,-16
 12c:	e406                	sd	ra,8(sp)
 12e:	e022                	sd	s0,0(sp)
 130:	0800                	addi	s0,sp,16
  extern int main();
  main();
 132:	00000097          	auipc	ra,0x0
 136:	ece080e7          	jalr	-306(ra) # 0 <main>
  exit(0);
 13a:	4501                	li	a0,0
 13c:	00000097          	auipc	ra,0x0
 140:	49a080e7          	jalr	1178(ra) # 5d6 <exit>

0000000000000144 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 144:	7179                	addi	sp,sp,-48
 146:	f422                	sd	s0,40(sp)
 148:	1800                	addi	s0,sp,48
 14a:	fca43c23          	sd	a0,-40(s0)
 14e:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
 152:	fd843783          	ld	a5,-40(s0)
 156:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
 15a:	0001                	nop
 15c:	fd043703          	ld	a4,-48(s0)
 160:	00170793          	addi	a5,a4,1
 164:	fcf43823          	sd	a5,-48(s0)
 168:	fd843783          	ld	a5,-40(s0)
 16c:	00178693          	addi	a3,a5,1
 170:	fcd43c23          	sd	a3,-40(s0)
 174:	00074703          	lbu	a4,0(a4)
 178:	00e78023          	sb	a4,0(a5)
 17c:	0007c783          	lbu	a5,0(a5)
 180:	fff1                	bnez	a5,15c <strcpy+0x18>
    ;
  return os;
 182:	fe843783          	ld	a5,-24(s0)
}
 186:	853e                	mv	a0,a5
 188:	7422                	ld	s0,40(sp)
 18a:	6145                	addi	sp,sp,48
 18c:	8082                	ret

000000000000018e <strcmp>:

int
strcmp(const char *p, const char *q)
{
 18e:	1101                	addi	sp,sp,-32
 190:	ec22                	sd	s0,24(sp)
 192:	1000                	addi	s0,sp,32
 194:	fea43423          	sd	a0,-24(s0)
 198:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
 19c:	a819                	j	1b2 <strcmp+0x24>
    p++, q++;
 19e:	fe843783          	ld	a5,-24(s0)
 1a2:	0785                	addi	a5,a5,1
 1a4:	fef43423          	sd	a5,-24(s0)
 1a8:	fe043783          	ld	a5,-32(s0)
 1ac:	0785                	addi	a5,a5,1
 1ae:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
 1b2:	fe843783          	ld	a5,-24(s0)
 1b6:	0007c783          	lbu	a5,0(a5)
 1ba:	cb99                	beqz	a5,1d0 <strcmp+0x42>
 1bc:	fe843783          	ld	a5,-24(s0)
 1c0:	0007c703          	lbu	a4,0(a5)
 1c4:	fe043783          	ld	a5,-32(s0)
 1c8:	0007c783          	lbu	a5,0(a5)
 1cc:	fcf709e3          	beq	a4,a5,19e <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
 1d0:	fe843783          	ld	a5,-24(s0)
 1d4:	0007c783          	lbu	a5,0(a5)
 1d8:	0007871b          	sext.w	a4,a5
 1dc:	fe043783          	ld	a5,-32(s0)
 1e0:	0007c783          	lbu	a5,0(a5)
 1e4:	2781                	sext.w	a5,a5
 1e6:	40f707bb          	subw	a5,a4,a5
 1ea:	2781                	sext.w	a5,a5
}
 1ec:	853e                	mv	a0,a5
 1ee:	6462                	ld	s0,24(sp)
 1f0:	6105                	addi	sp,sp,32
 1f2:	8082                	ret

00000000000001f4 <strlen>:

uint
strlen(const char *s)
{
 1f4:	7179                	addi	sp,sp,-48
 1f6:	f422                	sd	s0,40(sp)
 1f8:	1800                	addi	s0,sp,48
 1fa:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
 1fe:	fe042623          	sw	zero,-20(s0)
 202:	a031                	j	20e <strlen+0x1a>
 204:	fec42783          	lw	a5,-20(s0)
 208:	2785                	addiw	a5,a5,1
 20a:	fef42623          	sw	a5,-20(s0)
 20e:	fec42783          	lw	a5,-20(s0)
 212:	fd843703          	ld	a4,-40(s0)
 216:	97ba                	add	a5,a5,a4
 218:	0007c783          	lbu	a5,0(a5)
 21c:	f7e5                	bnez	a5,204 <strlen+0x10>
    ;
  return n;
 21e:	fec42783          	lw	a5,-20(s0)
}
 222:	853e                	mv	a0,a5
 224:	7422                	ld	s0,40(sp)
 226:	6145                	addi	sp,sp,48
 228:	8082                	ret

000000000000022a <memset>:

void*
memset(void *dst, int c, uint n)
{
 22a:	7179                	addi	sp,sp,-48
 22c:	f422                	sd	s0,40(sp)
 22e:	1800                	addi	s0,sp,48
 230:	fca43c23          	sd	a0,-40(s0)
 234:	87ae                	mv	a5,a1
 236:	8732                	mv	a4,a2
 238:	fcf42a23          	sw	a5,-44(s0)
 23c:	87ba                	mv	a5,a4
 23e:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
 242:	fd843783          	ld	a5,-40(s0)
 246:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
 24a:	fe042623          	sw	zero,-20(s0)
 24e:	a00d                	j	270 <memset+0x46>
    cdst[i] = c;
 250:	fec42783          	lw	a5,-20(s0)
 254:	fe043703          	ld	a4,-32(s0)
 258:	97ba                	add	a5,a5,a4
 25a:	fd442703          	lw	a4,-44(s0)
 25e:	0ff77713          	zext.b	a4,a4
 262:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
 266:	fec42783          	lw	a5,-20(s0)
 26a:	2785                	addiw	a5,a5,1
 26c:	fef42623          	sw	a5,-20(s0)
 270:	fec42703          	lw	a4,-20(s0)
 274:	fd042783          	lw	a5,-48(s0)
 278:	2781                	sext.w	a5,a5
 27a:	fcf76be3          	bltu	a4,a5,250 <memset+0x26>
  }
  return dst;
 27e:	fd843783          	ld	a5,-40(s0)
}
 282:	853e                	mv	a0,a5
 284:	7422                	ld	s0,40(sp)
 286:	6145                	addi	sp,sp,48
 288:	8082                	ret

000000000000028a <strchr>:

char*
strchr(const char *s, char c)
{
 28a:	1101                	addi	sp,sp,-32
 28c:	ec22                	sd	s0,24(sp)
 28e:	1000                	addi	s0,sp,32
 290:	fea43423          	sd	a0,-24(s0)
 294:	87ae                	mv	a5,a1
 296:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
 29a:	a01d                	j	2c0 <strchr+0x36>
    if(*s == c)
 29c:	fe843783          	ld	a5,-24(s0)
 2a0:	0007c703          	lbu	a4,0(a5)
 2a4:	fe744783          	lbu	a5,-25(s0)
 2a8:	0ff7f793          	zext.b	a5,a5
 2ac:	00e79563          	bne	a5,a4,2b6 <strchr+0x2c>
      return (char*)s;
 2b0:	fe843783          	ld	a5,-24(s0)
 2b4:	a821                	j	2cc <strchr+0x42>
  for(; *s; s++)
 2b6:	fe843783          	ld	a5,-24(s0)
 2ba:	0785                	addi	a5,a5,1
 2bc:	fef43423          	sd	a5,-24(s0)
 2c0:	fe843783          	ld	a5,-24(s0)
 2c4:	0007c783          	lbu	a5,0(a5)
 2c8:	fbf1                	bnez	a5,29c <strchr+0x12>
  return 0;
 2ca:	4781                	li	a5,0
}
 2cc:	853e                	mv	a0,a5
 2ce:	6462                	ld	s0,24(sp)
 2d0:	6105                	addi	sp,sp,32
 2d2:	8082                	ret

00000000000002d4 <gets>:

char*
gets(char *buf, int max)
{
 2d4:	7179                	addi	sp,sp,-48
 2d6:	f406                	sd	ra,40(sp)
 2d8:	f022                	sd	s0,32(sp)
 2da:	1800                	addi	s0,sp,48
 2dc:	fca43c23          	sd	a0,-40(s0)
 2e0:	87ae                	mv	a5,a1
 2e2:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2e6:	fe042623          	sw	zero,-20(s0)
 2ea:	a8a1                	j	342 <gets+0x6e>
    cc = read(0, &c, 1);
 2ec:	fe740793          	addi	a5,s0,-25
 2f0:	4605                	li	a2,1
 2f2:	85be                	mv	a1,a5
 2f4:	4501                	li	a0,0
 2f6:	00000097          	auipc	ra,0x0
 2fa:	2f8080e7          	jalr	760(ra) # 5ee <read>
 2fe:	87aa                	mv	a5,a0
 300:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
 304:	fe842783          	lw	a5,-24(s0)
 308:	2781                	sext.w	a5,a5
 30a:	04f05763          	blez	a5,358 <gets+0x84>
      break;
    buf[i++] = c;
 30e:	fec42783          	lw	a5,-20(s0)
 312:	0017871b          	addiw	a4,a5,1
 316:	fee42623          	sw	a4,-20(s0)
 31a:	873e                	mv	a4,a5
 31c:	fd843783          	ld	a5,-40(s0)
 320:	97ba                	add	a5,a5,a4
 322:	fe744703          	lbu	a4,-25(s0)
 326:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
 32a:	fe744783          	lbu	a5,-25(s0)
 32e:	873e                	mv	a4,a5
 330:	47a9                	li	a5,10
 332:	02f70463          	beq	a4,a5,35a <gets+0x86>
 336:	fe744783          	lbu	a5,-25(s0)
 33a:	873e                	mv	a4,a5
 33c:	47b5                	li	a5,13
 33e:	00f70e63          	beq	a4,a5,35a <gets+0x86>
  for(i=0; i+1 < max; ){
 342:	fec42783          	lw	a5,-20(s0)
 346:	2785                	addiw	a5,a5,1
 348:	0007871b          	sext.w	a4,a5
 34c:	fd442783          	lw	a5,-44(s0)
 350:	2781                	sext.w	a5,a5
 352:	f8f74de3          	blt	a4,a5,2ec <gets+0x18>
 356:	a011                	j	35a <gets+0x86>
      break;
 358:	0001                	nop
      break;
  }
  buf[i] = '\0';
 35a:	fec42783          	lw	a5,-20(s0)
 35e:	fd843703          	ld	a4,-40(s0)
 362:	97ba                	add	a5,a5,a4
 364:	00078023          	sb	zero,0(a5)
  return buf;
 368:	fd843783          	ld	a5,-40(s0)
}
 36c:	853e                	mv	a0,a5
 36e:	70a2                	ld	ra,40(sp)
 370:	7402                	ld	s0,32(sp)
 372:	6145                	addi	sp,sp,48
 374:	8082                	ret

0000000000000376 <stat>:

int
stat(const char *n, struct stat *st)
{
 376:	7179                	addi	sp,sp,-48
 378:	f406                	sd	ra,40(sp)
 37a:	f022                	sd	s0,32(sp)
 37c:	1800                	addi	s0,sp,48
 37e:	fca43c23          	sd	a0,-40(s0)
 382:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 386:	4581                	li	a1,0
 388:	fd843503          	ld	a0,-40(s0)
 38c:	00000097          	auipc	ra,0x0
 390:	28a080e7          	jalr	650(ra) # 616 <open>
 394:	87aa                	mv	a5,a0
 396:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
 39a:	fec42783          	lw	a5,-20(s0)
 39e:	2781                	sext.w	a5,a5
 3a0:	0007d463          	bgez	a5,3a8 <stat+0x32>
    return -1;
 3a4:	57fd                	li	a5,-1
 3a6:	a035                	j	3d2 <stat+0x5c>
  r = fstat(fd, st);
 3a8:	fec42783          	lw	a5,-20(s0)
 3ac:	fd043583          	ld	a1,-48(s0)
 3b0:	853e                	mv	a0,a5
 3b2:	00000097          	auipc	ra,0x0
 3b6:	27c080e7          	jalr	636(ra) # 62e <fstat>
 3ba:	87aa                	mv	a5,a0
 3bc:	fef42423          	sw	a5,-24(s0)
  close(fd);
 3c0:	fec42783          	lw	a5,-20(s0)
 3c4:	853e                	mv	a0,a5
 3c6:	00000097          	auipc	ra,0x0
 3ca:	238080e7          	jalr	568(ra) # 5fe <close>
  return r;
 3ce:	fe842783          	lw	a5,-24(s0)
}
 3d2:	853e                	mv	a0,a5
 3d4:	70a2                	ld	ra,40(sp)
 3d6:	7402                	ld	s0,32(sp)
 3d8:	6145                	addi	sp,sp,48
 3da:	8082                	ret

00000000000003dc <atoi>:

int
atoi(const char *s)
{
 3dc:	7179                	addi	sp,sp,-48
 3de:	f422                	sd	s0,40(sp)
 3e0:	1800                	addi	s0,sp,48
 3e2:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
 3e6:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
 3ea:	a81d                	j	420 <atoi+0x44>
    n = n*10 + *s++ - '0';
 3ec:	fec42783          	lw	a5,-20(s0)
 3f0:	873e                	mv	a4,a5
 3f2:	87ba                	mv	a5,a4
 3f4:	0027979b          	slliw	a5,a5,0x2
 3f8:	9fb9                	addw	a5,a5,a4
 3fa:	0017979b          	slliw	a5,a5,0x1
 3fe:	0007871b          	sext.w	a4,a5
 402:	fd843783          	ld	a5,-40(s0)
 406:	00178693          	addi	a3,a5,1
 40a:	fcd43c23          	sd	a3,-40(s0)
 40e:	0007c783          	lbu	a5,0(a5)
 412:	2781                	sext.w	a5,a5
 414:	9fb9                	addw	a5,a5,a4
 416:	2781                	sext.w	a5,a5
 418:	fd07879b          	addiw	a5,a5,-48
 41c:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
 420:	fd843783          	ld	a5,-40(s0)
 424:	0007c783          	lbu	a5,0(a5)
 428:	873e                	mv	a4,a5
 42a:	02f00793          	li	a5,47
 42e:	00e7fb63          	bgeu	a5,a4,444 <atoi+0x68>
 432:	fd843783          	ld	a5,-40(s0)
 436:	0007c783          	lbu	a5,0(a5)
 43a:	873e                	mv	a4,a5
 43c:	03900793          	li	a5,57
 440:	fae7f6e3          	bgeu	a5,a4,3ec <atoi+0x10>
  return n;
 444:	fec42783          	lw	a5,-20(s0)
}
 448:	853e                	mv	a0,a5
 44a:	7422                	ld	s0,40(sp)
 44c:	6145                	addi	sp,sp,48
 44e:	8082                	ret

0000000000000450 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 450:	7139                	addi	sp,sp,-64
 452:	fc22                	sd	s0,56(sp)
 454:	0080                	addi	s0,sp,64
 456:	fca43c23          	sd	a0,-40(s0)
 45a:	fcb43823          	sd	a1,-48(s0)
 45e:	87b2                	mv	a5,a2
 460:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
 464:	fd843783          	ld	a5,-40(s0)
 468:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
 46c:	fd043783          	ld	a5,-48(s0)
 470:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
 474:	fe043703          	ld	a4,-32(s0)
 478:	fe843783          	ld	a5,-24(s0)
 47c:	02e7fc63          	bgeu	a5,a4,4b4 <memmove+0x64>
    while(n-- > 0)
 480:	a00d                	j	4a2 <memmove+0x52>
      *dst++ = *src++;
 482:	fe043703          	ld	a4,-32(s0)
 486:	00170793          	addi	a5,a4,1
 48a:	fef43023          	sd	a5,-32(s0)
 48e:	fe843783          	ld	a5,-24(s0)
 492:	00178693          	addi	a3,a5,1
 496:	fed43423          	sd	a3,-24(s0)
 49a:	00074703          	lbu	a4,0(a4)
 49e:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 4a2:	fcc42783          	lw	a5,-52(s0)
 4a6:	fff7871b          	addiw	a4,a5,-1
 4aa:	fce42623          	sw	a4,-52(s0)
 4ae:	fcf04ae3          	bgtz	a5,482 <memmove+0x32>
 4b2:	a891                	j	506 <memmove+0xb6>
  } else {
    dst += n;
 4b4:	fcc42783          	lw	a5,-52(s0)
 4b8:	fe843703          	ld	a4,-24(s0)
 4bc:	97ba                	add	a5,a5,a4
 4be:	fef43423          	sd	a5,-24(s0)
    src += n;
 4c2:	fcc42783          	lw	a5,-52(s0)
 4c6:	fe043703          	ld	a4,-32(s0)
 4ca:	97ba                	add	a5,a5,a4
 4cc:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
 4d0:	a01d                	j	4f6 <memmove+0xa6>
      *--dst = *--src;
 4d2:	fe043783          	ld	a5,-32(s0)
 4d6:	17fd                	addi	a5,a5,-1
 4d8:	fef43023          	sd	a5,-32(s0)
 4dc:	fe843783          	ld	a5,-24(s0)
 4e0:	17fd                	addi	a5,a5,-1
 4e2:	fef43423          	sd	a5,-24(s0)
 4e6:	fe043783          	ld	a5,-32(s0)
 4ea:	0007c703          	lbu	a4,0(a5)
 4ee:	fe843783          	ld	a5,-24(s0)
 4f2:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 4f6:	fcc42783          	lw	a5,-52(s0)
 4fa:	fff7871b          	addiw	a4,a5,-1
 4fe:	fce42623          	sw	a4,-52(s0)
 502:	fcf048e3          	bgtz	a5,4d2 <memmove+0x82>
  }
  return vdst;
 506:	fd843783          	ld	a5,-40(s0)
}
 50a:	853e                	mv	a0,a5
 50c:	7462                	ld	s0,56(sp)
 50e:	6121                	addi	sp,sp,64
 510:	8082                	ret

0000000000000512 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 512:	7139                	addi	sp,sp,-64
 514:	fc22                	sd	s0,56(sp)
 516:	0080                	addi	s0,sp,64
 518:	fca43c23          	sd	a0,-40(s0)
 51c:	fcb43823          	sd	a1,-48(s0)
 520:	87b2                	mv	a5,a2
 522:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
 526:	fd843783          	ld	a5,-40(s0)
 52a:	fef43423          	sd	a5,-24(s0)
 52e:	fd043783          	ld	a5,-48(s0)
 532:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 536:	a0a1                	j	57e <memcmp+0x6c>
    if (*p1 != *p2) {
 538:	fe843783          	ld	a5,-24(s0)
 53c:	0007c703          	lbu	a4,0(a5)
 540:	fe043783          	ld	a5,-32(s0)
 544:	0007c783          	lbu	a5,0(a5)
 548:	02f70163          	beq	a4,a5,56a <memcmp+0x58>
      return *p1 - *p2;
 54c:	fe843783          	ld	a5,-24(s0)
 550:	0007c783          	lbu	a5,0(a5)
 554:	0007871b          	sext.w	a4,a5
 558:	fe043783          	ld	a5,-32(s0)
 55c:	0007c783          	lbu	a5,0(a5)
 560:	2781                	sext.w	a5,a5
 562:	40f707bb          	subw	a5,a4,a5
 566:	2781                	sext.w	a5,a5
 568:	a01d                	j	58e <memcmp+0x7c>
    }
    p1++;
 56a:	fe843783          	ld	a5,-24(s0)
 56e:	0785                	addi	a5,a5,1
 570:	fef43423          	sd	a5,-24(s0)
    p2++;
 574:	fe043783          	ld	a5,-32(s0)
 578:	0785                	addi	a5,a5,1
 57a:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 57e:	fcc42783          	lw	a5,-52(s0)
 582:	fff7871b          	addiw	a4,a5,-1
 586:	fce42623          	sw	a4,-52(s0)
 58a:	f7dd                	bnez	a5,538 <memcmp+0x26>
  }
  return 0;
 58c:	4781                	li	a5,0
}
 58e:	853e                	mv	a0,a5
 590:	7462                	ld	s0,56(sp)
 592:	6121                	addi	sp,sp,64
 594:	8082                	ret

0000000000000596 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 596:	7179                	addi	sp,sp,-48
 598:	f406                	sd	ra,40(sp)
 59a:	f022                	sd	s0,32(sp)
 59c:	1800                	addi	s0,sp,48
 59e:	fea43423          	sd	a0,-24(s0)
 5a2:	feb43023          	sd	a1,-32(s0)
 5a6:	87b2                	mv	a5,a2
 5a8:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
 5ac:	fdc42783          	lw	a5,-36(s0)
 5b0:	863e                	mv	a2,a5
 5b2:	fe043583          	ld	a1,-32(s0)
 5b6:	fe843503          	ld	a0,-24(s0)
 5ba:	00000097          	auipc	ra,0x0
 5be:	e96080e7          	jalr	-362(ra) # 450 <memmove>
 5c2:	87aa                	mv	a5,a0
}
 5c4:	853e                	mv	a0,a5
 5c6:	70a2                	ld	ra,40(sp)
 5c8:	7402                	ld	s0,32(sp)
 5ca:	6145                	addi	sp,sp,48
 5cc:	8082                	ret

00000000000005ce <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 5ce:	4885                	li	a7,1
 ecall
 5d0:	00000073          	ecall
 ret
 5d4:	8082                	ret

00000000000005d6 <exit>:
.global exit
exit:
 li a7, SYS_exit
 5d6:	4889                	li	a7,2
 ecall
 5d8:	00000073          	ecall
 ret
 5dc:	8082                	ret

00000000000005de <wait>:
.global wait
wait:
 li a7, SYS_wait
 5de:	488d                	li	a7,3
 ecall
 5e0:	00000073          	ecall
 ret
 5e4:	8082                	ret

00000000000005e6 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5e6:	4891                	li	a7,4
 ecall
 5e8:	00000073          	ecall
 ret
 5ec:	8082                	ret

00000000000005ee <read>:
.global read
read:
 li a7, SYS_read
 5ee:	4895                	li	a7,5
 ecall
 5f0:	00000073          	ecall
 ret
 5f4:	8082                	ret

00000000000005f6 <write>:
.global write
write:
 li a7, SYS_write
 5f6:	48c1                	li	a7,16
 ecall
 5f8:	00000073          	ecall
 ret
 5fc:	8082                	ret

00000000000005fe <close>:
.global close
close:
 li a7, SYS_close
 5fe:	48d5                	li	a7,21
 ecall
 600:	00000073          	ecall
 ret
 604:	8082                	ret

0000000000000606 <kill>:
.global kill
kill:
 li a7, SYS_kill
 606:	4899                	li	a7,6
 ecall
 608:	00000073          	ecall
 ret
 60c:	8082                	ret

000000000000060e <exec>:
.global exec
exec:
 li a7, SYS_exec
 60e:	489d                	li	a7,7
 ecall
 610:	00000073          	ecall
 ret
 614:	8082                	ret

0000000000000616 <open>:
.global open
open:
 li a7, SYS_open
 616:	48bd                	li	a7,15
 ecall
 618:	00000073          	ecall
 ret
 61c:	8082                	ret

000000000000061e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 61e:	48c5                	li	a7,17
 ecall
 620:	00000073          	ecall
 ret
 624:	8082                	ret

0000000000000626 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 626:	48c9                	li	a7,18
 ecall
 628:	00000073          	ecall
 ret
 62c:	8082                	ret

000000000000062e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 62e:	48a1                	li	a7,8
 ecall
 630:	00000073          	ecall
 ret
 634:	8082                	ret

0000000000000636 <link>:
.global link
link:
 li a7, SYS_link
 636:	48cd                	li	a7,19
 ecall
 638:	00000073          	ecall
 ret
 63c:	8082                	ret

000000000000063e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 63e:	48d1                	li	a7,20
 ecall
 640:	00000073          	ecall
 ret
 644:	8082                	ret

0000000000000646 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 646:	48a5                	li	a7,9
 ecall
 648:	00000073          	ecall
 ret
 64c:	8082                	ret

000000000000064e <dup>:
.global dup
dup:
 li a7, SYS_dup
 64e:	48a9                	li	a7,10
 ecall
 650:	00000073          	ecall
 ret
 654:	8082                	ret

0000000000000656 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 656:	48ad                	li	a7,11
 ecall
 658:	00000073          	ecall
 ret
 65c:	8082                	ret

000000000000065e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 65e:	48b1                	li	a7,12
 ecall
 660:	00000073          	ecall
 ret
 664:	8082                	ret

0000000000000666 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 666:	48b5                	li	a7,13
 ecall
 668:	00000073          	ecall
 ret
 66c:	8082                	ret

000000000000066e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 66e:	48b9                	li	a7,14
 ecall
 670:	00000073          	ecall
 ret
 674:	8082                	ret

0000000000000676 <trace>:
.global trace
trace:
 li a7, SYS_trace
 676:	48d9                	li	a7,22
 ecall
 678:	00000073          	ecall
 ret
 67c:	8082                	ret

000000000000067e <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 67e:	48dd                	li	a7,23
 ecall
 680:	00000073          	ecall
 ret
 684:	8082                	ret

0000000000000686 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 686:	1101                	addi	sp,sp,-32
 688:	ec06                	sd	ra,24(sp)
 68a:	e822                	sd	s0,16(sp)
 68c:	1000                	addi	s0,sp,32
 68e:	87aa                	mv	a5,a0
 690:	872e                	mv	a4,a1
 692:	fef42623          	sw	a5,-20(s0)
 696:	87ba                	mv	a5,a4
 698:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
 69c:	feb40713          	addi	a4,s0,-21
 6a0:	fec42783          	lw	a5,-20(s0)
 6a4:	4605                	li	a2,1
 6a6:	85ba                	mv	a1,a4
 6a8:	853e                	mv	a0,a5
 6aa:	00000097          	auipc	ra,0x0
 6ae:	f4c080e7          	jalr	-180(ra) # 5f6 <write>
}
 6b2:	0001                	nop
 6b4:	60e2                	ld	ra,24(sp)
 6b6:	6442                	ld	s0,16(sp)
 6b8:	6105                	addi	sp,sp,32
 6ba:	8082                	ret

00000000000006bc <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 6bc:	7139                	addi	sp,sp,-64
 6be:	fc06                	sd	ra,56(sp)
 6c0:	f822                	sd	s0,48(sp)
 6c2:	0080                	addi	s0,sp,64
 6c4:	87aa                	mv	a5,a0
 6c6:	8736                	mv	a4,a3
 6c8:	fcf42623          	sw	a5,-52(s0)
 6cc:	87ae                	mv	a5,a1
 6ce:	fcf42423          	sw	a5,-56(s0)
 6d2:	87b2                	mv	a5,a2
 6d4:	fcf42223          	sw	a5,-60(s0)
 6d8:	87ba                	mv	a5,a4
 6da:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 6de:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
 6e2:	fc042783          	lw	a5,-64(s0)
 6e6:	2781                	sext.w	a5,a5
 6e8:	c38d                	beqz	a5,70a <printint+0x4e>
 6ea:	fc842783          	lw	a5,-56(s0)
 6ee:	2781                	sext.w	a5,a5
 6f0:	0007dd63          	bgez	a5,70a <printint+0x4e>
    neg = 1;
 6f4:	4785                	li	a5,1
 6f6:	fef42423          	sw	a5,-24(s0)
    x = -xx;
 6fa:	fc842783          	lw	a5,-56(s0)
 6fe:	40f007bb          	negw	a5,a5
 702:	2781                	sext.w	a5,a5
 704:	fef42223          	sw	a5,-28(s0)
 708:	a029                	j	712 <printint+0x56>
  } else {
    x = xx;
 70a:	fc842783          	lw	a5,-56(s0)
 70e:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
 712:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
 716:	fc442783          	lw	a5,-60(s0)
 71a:	fe442703          	lw	a4,-28(s0)
 71e:	02f777bb          	remuw	a5,a4,a5
 722:	0007861b          	sext.w	a2,a5
 726:	fec42783          	lw	a5,-20(s0)
 72a:	0017871b          	addiw	a4,a5,1
 72e:	fee42623          	sw	a4,-20(s0)
 732:	00001697          	auipc	a3,0x1
 736:	8ce68693          	addi	a3,a3,-1842 # 1000 <digits>
 73a:	02061713          	slli	a4,a2,0x20
 73e:	9301                	srli	a4,a4,0x20
 740:	9736                	add	a4,a4,a3
 742:	00074703          	lbu	a4,0(a4)
 746:	17c1                	addi	a5,a5,-16
 748:	97a2                	add	a5,a5,s0
 74a:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
 74e:	fc442783          	lw	a5,-60(s0)
 752:	fe442703          	lw	a4,-28(s0)
 756:	02f757bb          	divuw	a5,a4,a5
 75a:	fef42223          	sw	a5,-28(s0)
 75e:	fe442783          	lw	a5,-28(s0)
 762:	2781                	sext.w	a5,a5
 764:	fbcd                	bnez	a5,716 <printint+0x5a>
  if(neg)
 766:	fe842783          	lw	a5,-24(s0)
 76a:	2781                	sext.w	a5,a5
 76c:	cf85                	beqz	a5,7a4 <printint+0xe8>
    buf[i++] = '-';
 76e:	fec42783          	lw	a5,-20(s0)
 772:	0017871b          	addiw	a4,a5,1
 776:	fee42623          	sw	a4,-20(s0)
 77a:	17c1                	addi	a5,a5,-16
 77c:	97a2                	add	a5,a5,s0
 77e:	02d00713          	li	a4,45
 782:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
 786:	a839                	j	7a4 <printint+0xe8>
    putc(fd, buf[i]);
 788:	fec42783          	lw	a5,-20(s0)
 78c:	17c1                	addi	a5,a5,-16
 78e:	97a2                	add	a5,a5,s0
 790:	fe07c703          	lbu	a4,-32(a5)
 794:	fcc42783          	lw	a5,-52(s0)
 798:	85ba                	mv	a1,a4
 79a:	853e                	mv	a0,a5
 79c:	00000097          	auipc	ra,0x0
 7a0:	eea080e7          	jalr	-278(ra) # 686 <putc>
  while(--i >= 0)
 7a4:	fec42783          	lw	a5,-20(s0)
 7a8:	37fd                	addiw	a5,a5,-1
 7aa:	fef42623          	sw	a5,-20(s0)
 7ae:	fec42783          	lw	a5,-20(s0)
 7b2:	2781                	sext.w	a5,a5
 7b4:	fc07dae3          	bgez	a5,788 <printint+0xcc>
}
 7b8:	0001                	nop
 7ba:	0001                	nop
 7bc:	70e2                	ld	ra,56(sp)
 7be:	7442                	ld	s0,48(sp)
 7c0:	6121                	addi	sp,sp,64
 7c2:	8082                	ret

00000000000007c4 <printptr>:

static void
printptr(int fd, uint64 x) {
 7c4:	7179                	addi	sp,sp,-48
 7c6:	f406                	sd	ra,40(sp)
 7c8:	f022                	sd	s0,32(sp)
 7ca:	1800                	addi	s0,sp,48
 7cc:	87aa                	mv	a5,a0
 7ce:	fcb43823          	sd	a1,-48(s0)
 7d2:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
 7d6:	fdc42783          	lw	a5,-36(s0)
 7da:	03000593          	li	a1,48
 7de:	853e                	mv	a0,a5
 7e0:	00000097          	auipc	ra,0x0
 7e4:	ea6080e7          	jalr	-346(ra) # 686 <putc>
  putc(fd, 'x');
 7e8:	fdc42783          	lw	a5,-36(s0)
 7ec:	07800593          	li	a1,120
 7f0:	853e                	mv	a0,a5
 7f2:	00000097          	auipc	ra,0x0
 7f6:	e94080e7          	jalr	-364(ra) # 686 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7fa:	fe042623          	sw	zero,-20(s0)
 7fe:	a82d                	j	838 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 800:	fd043783          	ld	a5,-48(s0)
 804:	93f1                	srli	a5,a5,0x3c
 806:	00000717          	auipc	a4,0x0
 80a:	7fa70713          	addi	a4,a4,2042 # 1000 <digits>
 80e:	97ba                	add	a5,a5,a4
 810:	0007c703          	lbu	a4,0(a5)
 814:	fdc42783          	lw	a5,-36(s0)
 818:	85ba                	mv	a1,a4
 81a:	853e                	mv	a0,a5
 81c:	00000097          	auipc	ra,0x0
 820:	e6a080e7          	jalr	-406(ra) # 686 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 824:	fec42783          	lw	a5,-20(s0)
 828:	2785                	addiw	a5,a5,1
 82a:	fef42623          	sw	a5,-20(s0)
 82e:	fd043783          	ld	a5,-48(s0)
 832:	0792                	slli	a5,a5,0x4
 834:	fcf43823          	sd	a5,-48(s0)
 838:	fec42783          	lw	a5,-20(s0)
 83c:	873e                	mv	a4,a5
 83e:	47bd                	li	a5,15
 840:	fce7f0e3          	bgeu	a5,a4,800 <printptr+0x3c>
}
 844:	0001                	nop
 846:	0001                	nop
 848:	70a2                	ld	ra,40(sp)
 84a:	7402                	ld	s0,32(sp)
 84c:	6145                	addi	sp,sp,48
 84e:	8082                	ret

0000000000000850 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 850:	715d                	addi	sp,sp,-80
 852:	e486                	sd	ra,72(sp)
 854:	e0a2                	sd	s0,64(sp)
 856:	0880                	addi	s0,sp,80
 858:	87aa                	mv	a5,a0
 85a:	fcb43023          	sd	a1,-64(s0)
 85e:	fac43c23          	sd	a2,-72(s0)
 862:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
 866:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 86a:	fe042223          	sw	zero,-28(s0)
 86e:	a42d                	j	a98 <vprintf+0x248>
    c = fmt[i] & 0xff;
 870:	fe442783          	lw	a5,-28(s0)
 874:	fc043703          	ld	a4,-64(s0)
 878:	97ba                	add	a5,a5,a4
 87a:	0007c783          	lbu	a5,0(a5)
 87e:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
 882:	fe042783          	lw	a5,-32(s0)
 886:	2781                	sext.w	a5,a5
 888:	eb9d                	bnez	a5,8be <vprintf+0x6e>
      if(c == '%'){
 88a:	fdc42783          	lw	a5,-36(s0)
 88e:	0007871b          	sext.w	a4,a5
 892:	02500793          	li	a5,37
 896:	00f71763          	bne	a4,a5,8a4 <vprintf+0x54>
        state = '%';
 89a:	02500793          	li	a5,37
 89e:	fef42023          	sw	a5,-32(s0)
 8a2:	a2f5                	j	a8e <vprintf+0x23e>
      } else {
        putc(fd, c);
 8a4:	fdc42783          	lw	a5,-36(s0)
 8a8:	0ff7f713          	zext.b	a4,a5
 8ac:	fcc42783          	lw	a5,-52(s0)
 8b0:	85ba                	mv	a1,a4
 8b2:	853e                	mv	a0,a5
 8b4:	00000097          	auipc	ra,0x0
 8b8:	dd2080e7          	jalr	-558(ra) # 686 <putc>
 8bc:	aac9                	j	a8e <vprintf+0x23e>
      }
    } else if(state == '%'){
 8be:	fe042783          	lw	a5,-32(s0)
 8c2:	0007871b          	sext.w	a4,a5
 8c6:	02500793          	li	a5,37
 8ca:	1cf71263          	bne	a4,a5,a8e <vprintf+0x23e>
      if(c == 'd'){
 8ce:	fdc42783          	lw	a5,-36(s0)
 8d2:	0007871b          	sext.w	a4,a5
 8d6:	06400793          	li	a5,100
 8da:	02f71463          	bne	a4,a5,902 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
 8de:	fb843783          	ld	a5,-72(s0)
 8e2:	00878713          	addi	a4,a5,8
 8e6:	fae43c23          	sd	a4,-72(s0)
 8ea:	4398                	lw	a4,0(a5)
 8ec:	fcc42783          	lw	a5,-52(s0)
 8f0:	4685                	li	a3,1
 8f2:	4629                	li	a2,10
 8f4:	85ba                	mv	a1,a4
 8f6:	853e                	mv	a0,a5
 8f8:	00000097          	auipc	ra,0x0
 8fc:	dc4080e7          	jalr	-572(ra) # 6bc <printint>
 900:	a269                	j	a8a <vprintf+0x23a>
      } else if(c == 'l') {
 902:	fdc42783          	lw	a5,-36(s0)
 906:	0007871b          	sext.w	a4,a5
 90a:	06c00793          	li	a5,108
 90e:	02f71663          	bne	a4,a5,93a <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
 912:	fb843783          	ld	a5,-72(s0)
 916:	00878713          	addi	a4,a5,8
 91a:	fae43c23          	sd	a4,-72(s0)
 91e:	639c                	ld	a5,0(a5)
 920:	0007871b          	sext.w	a4,a5
 924:	fcc42783          	lw	a5,-52(s0)
 928:	4681                	li	a3,0
 92a:	4629                	li	a2,10
 92c:	85ba                	mv	a1,a4
 92e:	853e                	mv	a0,a5
 930:	00000097          	auipc	ra,0x0
 934:	d8c080e7          	jalr	-628(ra) # 6bc <printint>
 938:	aa89                	j	a8a <vprintf+0x23a>
      } else if(c == 'x') {
 93a:	fdc42783          	lw	a5,-36(s0)
 93e:	0007871b          	sext.w	a4,a5
 942:	07800793          	li	a5,120
 946:	02f71463          	bne	a4,a5,96e <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
 94a:	fb843783          	ld	a5,-72(s0)
 94e:	00878713          	addi	a4,a5,8
 952:	fae43c23          	sd	a4,-72(s0)
 956:	4398                	lw	a4,0(a5)
 958:	fcc42783          	lw	a5,-52(s0)
 95c:	4681                	li	a3,0
 95e:	4641                	li	a2,16
 960:	85ba                	mv	a1,a4
 962:	853e                	mv	a0,a5
 964:	00000097          	auipc	ra,0x0
 968:	d58080e7          	jalr	-680(ra) # 6bc <printint>
 96c:	aa39                	j	a8a <vprintf+0x23a>
      } else if(c == 'p') {
 96e:	fdc42783          	lw	a5,-36(s0)
 972:	0007871b          	sext.w	a4,a5
 976:	07000793          	li	a5,112
 97a:	02f71263          	bne	a4,a5,99e <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
 97e:	fb843783          	ld	a5,-72(s0)
 982:	00878713          	addi	a4,a5,8
 986:	fae43c23          	sd	a4,-72(s0)
 98a:	6398                	ld	a4,0(a5)
 98c:	fcc42783          	lw	a5,-52(s0)
 990:	85ba                	mv	a1,a4
 992:	853e                	mv	a0,a5
 994:	00000097          	auipc	ra,0x0
 998:	e30080e7          	jalr	-464(ra) # 7c4 <printptr>
 99c:	a0fd                	j	a8a <vprintf+0x23a>
      } else if(c == 's'){
 99e:	fdc42783          	lw	a5,-36(s0)
 9a2:	0007871b          	sext.w	a4,a5
 9a6:	07300793          	li	a5,115
 9aa:	04f71c63          	bne	a4,a5,a02 <vprintf+0x1b2>
        s = va_arg(ap, char*);
 9ae:	fb843783          	ld	a5,-72(s0)
 9b2:	00878713          	addi	a4,a5,8
 9b6:	fae43c23          	sd	a4,-72(s0)
 9ba:	639c                	ld	a5,0(a5)
 9bc:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
 9c0:	fe843783          	ld	a5,-24(s0)
 9c4:	eb8d                	bnez	a5,9f6 <vprintf+0x1a6>
          s = "(null)";
 9c6:	00000797          	auipc	a5,0x0
 9ca:	4aa78793          	addi	a5,a5,1194 # e70 <malloc+0x170>
 9ce:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 9d2:	a015                	j	9f6 <vprintf+0x1a6>
          putc(fd, *s);
 9d4:	fe843783          	ld	a5,-24(s0)
 9d8:	0007c703          	lbu	a4,0(a5)
 9dc:	fcc42783          	lw	a5,-52(s0)
 9e0:	85ba                	mv	a1,a4
 9e2:	853e                	mv	a0,a5
 9e4:	00000097          	auipc	ra,0x0
 9e8:	ca2080e7          	jalr	-862(ra) # 686 <putc>
          s++;
 9ec:	fe843783          	ld	a5,-24(s0)
 9f0:	0785                	addi	a5,a5,1
 9f2:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 9f6:	fe843783          	ld	a5,-24(s0)
 9fa:	0007c783          	lbu	a5,0(a5)
 9fe:	fbf9                	bnez	a5,9d4 <vprintf+0x184>
 a00:	a069                	j	a8a <vprintf+0x23a>
        }
      } else if(c == 'c'){
 a02:	fdc42783          	lw	a5,-36(s0)
 a06:	0007871b          	sext.w	a4,a5
 a0a:	06300793          	li	a5,99
 a0e:	02f71463          	bne	a4,a5,a36 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
 a12:	fb843783          	ld	a5,-72(s0)
 a16:	00878713          	addi	a4,a5,8
 a1a:	fae43c23          	sd	a4,-72(s0)
 a1e:	439c                	lw	a5,0(a5)
 a20:	0ff7f713          	zext.b	a4,a5
 a24:	fcc42783          	lw	a5,-52(s0)
 a28:	85ba                	mv	a1,a4
 a2a:	853e                	mv	a0,a5
 a2c:	00000097          	auipc	ra,0x0
 a30:	c5a080e7          	jalr	-934(ra) # 686 <putc>
 a34:	a899                	j	a8a <vprintf+0x23a>
      } else if(c == '%'){
 a36:	fdc42783          	lw	a5,-36(s0)
 a3a:	0007871b          	sext.w	a4,a5
 a3e:	02500793          	li	a5,37
 a42:	00f71f63          	bne	a4,a5,a60 <vprintf+0x210>
        putc(fd, c);
 a46:	fdc42783          	lw	a5,-36(s0)
 a4a:	0ff7f713          	zext.b	a4,a5
 a4e:	fcc42783          	lw	a5,-52(s0)
 a52:	85ba                	mv	a1,a4
 a54:	853e                	mv	a0,a5
 a56:	00000097          	auipc	ra,0x0
 a5a:	c30080e7          	jalr	-976(ra) # 686 <putc>
 a5e:	a035                	j	a8a <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 a60:	fcc42783          	lw	a5,-52(s0)
 a64:	02500593          	li	a1,37
 a68:	853e                	mv	a0,a5
 a6a:	00000097          	auipc	ra,0x0
 a6e:	c1c080e7          	jalr	-996(ra) # 686 <putc>
        putc(fd, c);
 a72:	fdc42783          	lw	a5,-36(s0)
 a76:	0ff7f713          	zext.b	a4,a5
 a7a:	fcc42783          	lw	a5,-52(s0)
 a7e:	85ba                	mv	a1,a4
 a80:	853e                	mv	a0,a5
 a82:	00000097          	auipc	ra,0x0
 a86:	c04080e7          	jalr	-1020(ra) # 686 <putc>
      }
      state = 0;
 a8a:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 a8e:	fe442783          	lw	a5,-28(s0)
 a92:	2785                	addiw	a5,a5,1
 a94:	fef42223          	sw	a5,-28(s0)
 a98:	fe442783          	lw	a5,-28(s0)
 a9c:	fc043703          	ld	a4,-64(s0)
 aa0:	97ba                	add	a5,a5,a4
 aa2:	0007c783          	lbu	a5,0(a5)
 aa6:	dc0795e3          	bnez	a5,870 <vprintf+0x20>
    }
  }
}
 aaa:	0001                	nop
 aac:	0001                	nop
 aae:	60a6                	ld	ra,72(sp)
 ab0:	6406                	ld	s0,64(sp)
 ab2:	6161                	addi	sp,sp,80
 ab4:	8082                	ret

0000000000000ab6 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 ab6:	7159                	addi	sp,sp,-112
 ab8:	fc06                	sd	ra,56(sp)
 aba:	f822                	sd	s0,48(sp)
 abc:	0080                	addi	s0,sp,64
 abe:	fcb43823          	sd	a1,-48(s0)
 ac2:	e010                	sd	a2,0(s0)
 ac4:	e414                	sd	a3,8(s0)
 ac6:	e818                	sd	a4,16(s0)
 ac8:	ec1c                	sd	a5,24(s0)
 aca:	03043023          	sd	a6,32(s0)
 ace:	03143423          	sd	a7,40(s0)
 ad2:	87aa                	mv	a5,a0
 ad4:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
 ad8:	03040793          	addi	a5,s0,48
 adc:	fcf43423          	sd	a5,-56(s0)
 ae0:	fc843783          	ld	a5,-56(s0)
 ae4:	fd078793          	addi	a5,a5,-48
 ae8:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
 aec:	fe843703          	ld	a4,-24(s0)
 af0:	fdc42783          	lw	a5,-36(s0)
 af4:	863a                	mv	a2,a4
 af6:	fd043583          	ld	a1,-48(s0)
 afa:	853e                	mv	a0,a5
 afc:	00000097          	auipc	ra,0x0
 b00:	d54080e7          	jalr	-684(ra) # 850 <vprintf>
}
 b04:	0001                	nop
 b06:	70e2                	ld	ra,56(sp)
 b08:	7442                	ld	s0,48(sp)
 b0a:	6165                	addi	sp,sp,112
 b0c:	8082                	ret

0000000000000b0e <printf>:

void
printf(const char *fmt, ...)
{
 b0e:	7159                	addi	sp,sp,-112
 b10:	f406                	sd	ra,40(sp)
 b12:	f022                	sd	s0,32(sp)
 b14:	1800                	addi	s0,sp,48
 b16:	fca43c23          	sd	a0,-40(s0)
 b1a:	e40c                	sd	a1,8(s0)
 b1c:	e810                	sd	a2,16(s0)
 b1e:	ec14                	sd	a3,24(s0)
 b20:	f018                	sd	a4,32(s0)
 b22:	f41c                	sd	a5,40(s0)
 b24:	03043823          	sd	a6,48(s0)
 b28:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 b2c:	04040793          	addi	a5,s0,64
 b30:	fcf43823          	sd	a5,-48(s0)
 b34:	fd043783          	ld	a5,-48(s0)
 b38:	fc878793          	addi	a5,a5,-56
 b3c:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
 b40:	fe843783          	ld	a5,-24(s0)
 b44:	863e                	mv	a2,a5
 b46:	fd843583          	ld	a1,-40(s0)
 b4a:	4505                	li	a0,1
 b4c:	00000097          	auipc	ra,0x0
 b50:	d04080e7          	jalr	-764(ra) # 850 <vprintf>
}
 b54:	0001                	nop
 b56:	70a2                	ld	ra,40(sp)
 b58:	7402                	ld	s0,32(sp)
 b5a:	6165                	addi	sp,sp,112
 b5c:	8082                	ret

0000000000000b5e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b5e:	7179                	addi	sp,sp,-48
 b60:	f422                	sd	s0,40(sp)
 b62:	1800                	addi	s0,sp,48
 b64:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 b68:	fd843783          	ld	a5,-40(s0)
 b6c:	17c1                	addi	a5,a5,-16
 b6e:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b72:	00000797          	auipc	a5,0x0
 b76:	4be78793          	addi	a5,a5,1214 # 1030 <freep>
 b7a:	639c                	ld	a5,0(a5)
 b7c:	fef43423          	sd	a5,-24(s0)
 b80:	a815                	j	bb4 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b82:	fe843783          	ld	a5,-24(s0)
 b86:	639c                	ld	a5,0(a5)
 b88:	fe843703          	ld	a4,-24(s0)
 b8c:	00f76f63          	bltu	a4,a5,baa <free+0x4c>
 b90:	fe043703          	ld	a4,-32(s0)
 b94:	fe843783          	ld	a5,-24(s0)
 b98:	02e7eb63          	bltu	a5,a4,bce <free+0x70>
 b9c:	fe843783          	ld	a5,-24(s0)
 ba0:	639c                	ld	a5,0(a5)
 ba2:	fe043703          	ld	a4,-32(s0)
 ba6:	02f76463          	bltu	a4,a5,bce <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 baa:	fe843783          	ld	a5,-24(s0)
 bae:	639c                	ld	a5,0(a5)
 bb0:	fef43423          	sd	a5,-24(s0)
 bb4:	fe043703          	ld	a4,-32(s0)
 bb8:	fe843783          	ld	a5,-24(s0)
 bbc:	fce7f3e3          	bgeu	a5,a4,b82 <free+0x24>
 bc0:	fe843783          	ld	a5,-24(s0)
 bc4:	639c                	ld	a5,0(a5)
 bc6:	fe043703          	ld	a4,-32(s0)
 bca:	faf77ce3          	bgeu	a4,a5,b82 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
 bce:	fe043783          	ld	a5,-32(s0)
 bd2:	479c                	lw	a5,8(a5)
 bd4:	1782                	slli	a5,a5,0x20
 bd6:	9381                	srli	a5,a5,0x20
 bd8:	0792                	slli	a5,a5,0x4
 bda:	fe043703          	ld	a4,-32(s0)
 bde:	973e                	add	a4,a4,a5
 be0:	fe843783          	ld	a5,-24(s0)
 be4:	639c                	ld	a5,0(a5)
 be6:	02f71763          	bne	a4,a5,c14 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
 bea:	fe043783          	ld	a5,-32(s0)
 bee:	4798                	lw	a4,8(a5)
 bf0:	fe843783          	ld	a5,-24(s0)
 bf4:	639c                	ld	a5,0(a5)
 bf6:	479c                	lw	a5,8(a5)
 bf8:	9fb9                	addw	a5,a5,a4
 bfa:	0007871b          	sext.w	a4,a5
 bfe:	fe043783          	ld	a5,-32(s0)
 c02:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
 c04:	fe843783          	ld	a5,-24(s0)
 c08:	639c                	ld	a5,0(a5)
 c0a:	6398                	ld	a4,0(a5)
 c0c:	fe043783          	ld	a5,-32(s0)
 c10:	e398                	sd	a4,0(a5)
 c12:	a039                	j	c20 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
 c14:	fe843783          	ld	a5,-24(s0)
 c18:	6398                	ld	a4,0(a5)
 c1a:	fe043783          	ld	a5,-32(s0)
 c1e:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
 c20:	fe843783          	ld	a5,-24(s0)
 c24:	479c                	lw	a5,8(a5)
 c26:	1782                	slli	a5,a5,0x20
 c28:	9381                	srli	a5,a5,0x20
 c2a:	0792                	slli	a5,a5,0x4
 c2c:	fe843703          	ld	a4,-24(s0)
 c30:	97ba                	add	a5,a5,a4
 c32:	fe043703          	ld	a4,-32(s0)
 c36:	02f71563          	bne	a4,a5,c60 <free+0x102>
    p->s.size += bp->s.size;
 c3a:	fe843783          	ld	a5,-24(s0)
 c3e:	4798                	lw	a4,8(a5)
 c40:	fe043783          	ld	a5,-32(s0)
 c44:	479c                	lw	a5,8(a5)
 c46:	9fb9                	addw	a5,a5,a4
 c48:	0007871b          	sext.w	a4,a5
 c4c:	fe843783          	ld	a5,-24(s0)
 c50:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 c52:	fe043783          	ld	a5,-32(s0)
 c56:	6398                	ld	a4,0(a5)
 c58:	fe843783          	ld	a5,-24(s0)
 c5c:	e398                	sd	a4,0(a5)
 c5e:	a031                	j	c6a <free+0x10c>
  } else
    p->s.ptr = bp;
 c60:	fe843783          	ld	a5,-24(s0)
 c64:	fe043703          	ld	a4,-32(s0)
 c68:	e398                	sd	a4,0(a5)
  freep = p;
 c6a:	00000797          	auipc	a5,0x0
 c6e:	3c678793          	addi	a5,a5,966 # 1030 <freep>
 c72:	fe843703          	ld	a4,-24(s0)
 c76:	e398                	sd	a4,0(a5)
}
 c78:	0001                	nop
 c7a:	7422                	ld	s0,40(sp)
 c7c:	6145                	addi	sp,sp,48
 c7e:	8082                	ret

0000000000000c80 <morecore>:

static Header*
morecore(uint nu)
{
 c80:	7179                	addi	sp,sp,-48
 c82:	f406                	sd	ra,40(sp)
 c84:	f022                	sd	s0,32(sp)
 c86:	1800                	addi	s0,sp,48
 c88:	87aa                	mv	a5,a0
 c8a:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
 c8e:	fdc42783          	lw	a5,-36(s0)
 c92:	0007871b          	sext.w	a4,a5
 c96:	6785                	lui	a5,0x1
 c98:	00f77563          	bgeu	a4,a5,ca2 <morecore+0x22>
    nu = 4096;
 c9c:	6785                	lui	a5,0x1
 c9e:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
 ca2:	fdc42783          	lw	a5,-36(s0)
 ca6:	0047979b          	slliw	a5,a5,0x4
 caa:	2781                	sext.w	a5,a5
 cac:	2781                	sext.w	a5,a5
 cae:	853e                	mv	a0,a5
 cb0:	00000097          	auipc	ra,0x0
 cb4:	9ae080e7          	jalr	-1618(ra) # 65e <sbrk>
 cb8:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
 cbc:	fe843703          	ld	a4,-24(s0)
 cc0:	57fd                	li	a5,-1
 cc2:	00f71463          	bne	a4,a5,cca <morecore+0x4a>
    return 0;
 cc6:	4781                	li	a5,0
 cc8:	a03d                	j	cf6 <morecore+0x76>
  hp = (Header*)p;
 cca:	fe843783          	ld	a5,-24(s0)
 cce:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
 cd2:	fe043783          	ld	a5,-32(s0)
 cd6:	fdc42703          	lw	a4,-36(s0)
 cda:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
 cdc:	fe043783          	ld	a5,-32(s0)
 ce0:	07c1                	addi	a5,a5,16 # 1010 <digits+0x10>
 ce2:	853e                	mv	a0,a5
 ce4:	00000097          	auipc	ra,0x0
 ce8:	e7a080e7          	jalr	-390(ra) # b5e <free>
  return freep;
 cec:	00000797          	auipc	a5,0x0
 cf0:	34478793          	addi	a5,a5,836 # 1030 <freep>
 cf4:	639c                	ld	a5,0(a5)
}
 cf6:	853e                	mv	a0,a5
 cf8:	70a2                	ld	ra,40(sp)
 cfa:	7402                	ld	s0,32(sp)
 cfc:	6145                	addi	sp,sp,48
 cfe:	8082                	ret

0000000000000d00 <malloc>:

void*
malloc(uint nbytes)
{
 d00:	7139                	addi	sp,sp,-64
 d02:	fc06                	sd	ra,56(sp)
 d04:	f822                	sd	s0,48(sp)
 d06:	0080                	addi	s0,sp,64
 d08:	87aa                	mv	a5,a0
 d0a:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 d0e:	fcc46783          	lwu	a5,-52(s0)
 d12:	07bd                	addi	a5,a5,15
 d14:	8391                	srli	a5,a5,0x4
 d16:	2781                	sext.w	a5,a5
 d18:	2785                	addiw	a5,a5,1
 d1a:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
 d1e:	00000797          	auipc	a5,0x0
 d22:	31278793          	addi	a5,a5,786 # 1030 <freep>
 d26:	639c                	ld	a5,0(a5)
 d28:	fef43023          	sd	a5,-32(s0)
 d2c:	fe043783          	ld	a5,-32(s0)
 d30:	ef95                	bnez	a5,d6c <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
 d32:	00000797          	auipc	a5,0x0
 d36:	2ee78793          	addi	a5,a5,750 # 1020 <base>
 d3a:	fef43023          	sd	a5,-32(s0)
 d3e:	00000797          	auipc	a5,0x0
 d42:	2f278793          	addi	a5,a5,754 # 1030 <freep>
 d46:	fe043703          	ld	a4,-32(s0)
 d4a:	e398                	sd	a4,0(a5)
 d4c:	00000797          	auipc	a5,0x0
 d50:	2e478793          	addi	a5,a5,740 # 1030 <freep>
 d54:	6398                	ld	a4,0(a5)
 d56:	00000797          	auipc	a5,0x0
 d5a:	2ca78793          	addi	a5,a5,714 # 1020 <base>
 d5e:	e398                	sd	a4,0(a5)
    base.s.size = 0;
 d60:	00000797          	auipc	a5,0x0
 d64:	2c078793          	addi	a5,a5,704 # 1020 <base>
 d68:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d6c:	fe043783          	ld	a5,-32(s0)
 d70:	639c                	ld	a5,0(a5)
 d72:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 d76:	fe843783          	ld	a5,-24(s0)
 d7a:	4798                	lw	a4,8(a5)
 d7c:	fdc42783          	lw	a5,-36(s0)
 d80:	2781                	sext.w	a5,a5
 d82:	06f76763          	bltu	a4,a5,df0 <malloc+0xf0>
      if(p->s.size == nunits)
 d86:	fe843783          	ld	a5,-24(s0)
 d8a:	4798                	lw	a4,8(a5)
 d8c:	fdc42783          	lw	a5,-36(s0)
 d90:	2781                	sext.w	a5,a5
 d92:	00e79963          	bne	a5,a4,da4 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
 d96:	fe843783          	ld	a5,-24(s0)
 d9a:	6398                	ld	a4,0(a5)
 d9c:	fe043783          	ld	a5,-32(s0)
 da0:	e398                	sd	a4,0(a5)
 da2:	a825                	j	dda <malloc+0xda>
      else {
        p->s.size -= nunits;
 da4:	fe843783          	ld	a5,-24(s0)
 da8:	479c                	lw	a5,8(a5)
 daa:	fdc42703          	lw	a4,-36(s0)
 dae:	9f99                	subw	a5,a5,a4
 db0:	0007871b          	sext.w	a4,a5
 db4:	fe843783          	ld	a5,-24(s0)
 db8:	c798                	sw	a4,8(a5)
        p += p->s.size;
 dba:	fe843783          	ld	a5,-24(s0)
 dbe:	479c                	lw	a5,8(a5)
 dc0:	1782                	slli	a5,a5,0x20
 dc2:	9381                	srli	a5,a5,0x20
 dc4:	0792                	slli	a5,a5,0x4
 dc6:	fe843703          	ld	a4,-24(s0)
 dca:	97ba                	add	a5,a5,a4
 dcc:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
 dd0:	fe843783          	ld	a5,-24(s0)
 dd4:	fdc42703          	lw	a4,-36(s0)
 dd8:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
 dda:	00000797          	auipc	a5,0x0
 dde:	25678793          	addi	a5,a5,598 # 1030 <freep>
 de2:	fe043703          	ld	a4,-32(s0)
 de6:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
 de8:	fe843783          	ld	a5,-24(s0)
 dec:	07c1                	addi	a5,a5,16
 dee:	a091                	j	e32 <malloc+0x132>
    }
    if(p == freep)
 df0:	00000797          	auipc	a5,0x0
 df4:	24078793          	addi	a5,a5,576 # 1030 <freep>
 df8:	639c                	ld	a5,0(a5)
 dfa:	fe843703          	ld	a4,-24(s0)
 dfe:	02f71063          	bne	a4,a5,e1e <malloc+0x11e>
      if((p = morecore(nunits)) == 0)
 e02:	fdc42783          	lw	a5,-36(s0)
 e06:	853e                	mv	a0,a5
 e08:	00000097          	auipc	ra,0x0
 e0c:	e78080e7          	jalr	-392(ra) # c80 <morecore>
 e10:	fea43423          	sd	a0,-24(s0)
 e14:	fe843783          	ld	a5,-24(s0)
 e18:	e399                	bnez	a5,e1e <malloc+0x11e>
        return 0;
 e1a:	4781                	li	a5,0
 e1c:	a819                	j	e32 <malloc+0x132>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 e1e:	fe843783          	ld	a5,-24(s0)
 e22:	fef43023          	sd	a5,-32(s0)
 e26:	fe843783          	ld	a5,-24(s0)
 e2a:	639c                	ld	a5,0(a5)
 e2c:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 e30:	b799                	j	d76 <malloc+0x76>
  }
}
 e32:	853e                	mv	a0,a5
 e34:	70e2                	ld	ra,56(sp)
 e36:	7442                	ld	s0,48(sp)
 e38:	6121                	addi	sp,sp,64
 e3a:	8082                	ret
