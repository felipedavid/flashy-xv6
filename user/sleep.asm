
user/_sleep:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/types.h"
#include "user/user.h"

int main(int argc, char **argv) {
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	1800                	addi	s0,sp,48
   8:	87aa                	mv	a5,a0
   a:	fcb43823          	sd	a1,-48(s0)
   e:	fcf42e23          	sw	a5,-36(s0)
  if (argc != 2) {
  12:	fdc42783          	lw	a5,-36(s0)
  16:	0007871b          	sext.w	a4,a5
  1a:	4789                	li	a5,2
  1c:	02f70063          	beq	a4,a5,3c <main+0x3c>
    fprintf(2, "Usage: ./sleep <n_ticks>\n");
  20:	00001597          	auipc	a1,0x1
  24:	d6058593          	addi	a1,a1,-672 # d80 <malloc+0x13e>
  28:	4509                	li	a0,2
  2a:	00001097          	auipc	ra,0x1
  2e:	9ce080e7          	jalr	-1586(ra) # 9f8 <fprintf>
    exit(-1);
  32:	557d                	li	a0,-1
  34:	00000097          	auipc	ra,0x0
  38:	4e4080e7          	jalr	1252(ra) # 518 <exit>
  }
  int n_ticks = atoi(argv[1]);
  3c:	fd043783          	ld	a5,-48(s0)
  40:	07a1                	addi	a5,a5,8
  42:	639c                	ld	a5,0(a5)
  44:	853e                	mv	a0,a5
  46:	00000097          	auipc	ra,0x0
  4a:	2d8080e7          	jalr	728(ra) # 31e <atoi>
  4e:	87aa                	mv	a5,a0
  50:	fef42623          	sw	a5,-20(s0)
  sleep(n_ticks);
  54:	fec42783          	lw	a5,-20(s0)
  58:	853e                	mv	a0,a5
  5a:	00000097          	auipc	ra,0x0
  5e:	54e080e7          	jalr	1358(ra) # 5a8 <sleep>
  exit(0);
  62:	4501                	li	a0,0
  64:	00000097          	auipc	ra,0x0
  68:	4b4080e7          	jalr	1204(ra) # 518 <exit>

000000000000006c <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
  6c:	1141                	addi	sp,sp,-16
  6e:	e406                	sd	ra,8(sp)
  70:	e022                	sd	s0,0(sp)
  72:	0800                	addi	s0,sp,16
  extern int main();
  main();
  74:	00000097          	auipc	ra,0x0
  78:	f8c080e7          	jalr	-116(ra) # 0 <main>
  exit(0);
  7c:	4501                	li	a0,0
  7e:	00000097          	auipc	ra,0x0
  82:	49a080e7          	jalr	1178(ra) # 518 <exit>

0000000000000086 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  86:	7179                	addi	sp,sp,-48
  88:	f422                	sd	s0,40(sp)
  8a:	1800                	addi	s0,sp,48
  8c:	fca43c23          	sd	a0,-40(s0)
  90:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
  94:	fd843783          	ld	a5,-40(s0)
  98:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
  9c:	0001                	nop
  9e:	fd043703          	ld	a4,-48(s0)
  a2:	00170793          	addi	a5,a4,1
  a6:	fcf43823          	sd	a5,-48(s0)
  aa:	fd843783          	ld	a5,-40(s0)
  ae:	00178693          	addi	a3,a5,1
  b2:	fcd43c23          	sd	a3,-40(s0)
  b6:	00074703          	lbu	a4,0(a4)
  ba:	00e78023          	sb	a4,0(a5)
  be:	0007c783          	lbu	a5,0(a5)
  c2:	fff1                	bnez	a5,9e <strcpy+0x18>
    ;
  return os;
  c4:	fe843783          	ld	a5,-24(s0)
}
  c8:	853e                	mv	a0,a5
  ca:	7422                	ld	s0,40(sp)
  cc:	6145                	addi	sp,sp,48
  ce:	8082                	ret

00000000000000d0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  d0:	1101                	addi	sp,sp,-32
  d2:	ec22                	sd	s0,24(sp)
  d4:	1000                	addi	s0,sp,32
  d6:	fea43423          	sd	a0,-24(s0)
  da:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
  de:	a819                	j	f4 <strcmp+0x24>
    p++, q++;
  e0:	fe843783          	ld	a5,-24(s0)
  e4:	0785                	addi	a5,a5,1
  e6:	fef43423          	sd	a5,-24(s0)
  ea:	fe043783          	ld	a5,-32(s0)
  ee:	0785                	addi	a5,a5,1
  f0:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
  f4:	fe843783          	ld	a5,-24(s0)
  f8:	0007c783          	lbu	a5,0(a5)
  fc:	cb99                	beqz	a5,112 <strcmp+0x42>
  fe:	fe843783          	ld	a5,-24(s0)
 102:	0007c703          	lbu	a4,0(a5)
 106:	fe043783          	ld	a5,-32(s0)
 10a:	0007c783          	lbu	a5,0(a5)
 10e:	fcf709e3          	beq	a4,a5,e0 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
 112:	fe843783          	ld	a5,-24(s0)
 116:	0007c783          	lbu	a5,0(a5)
 11a:	0007871b          	sext.w	a4,a5
 11e:	fe043783          	ld	a5,-32(s0)
 122:	0007c783          	lbu	a5,0(a5)
 126:	2781                	sext.w	a5,a5
 128:	40f707bb          	subw	a5,a4,a5
 12c:	2781                	sext.w	a5,a5
}
 12e:	853e                	mv	a0,a5
 130:	6462                	ld	s0,24(sp)
 132:	6105                	addi	sp,sp,32
 134:	8082                	ret

0000000000000136 <strlen>:

uint
strlen(const char *s)
{
 136:	7179                	addi	sp,sp,-48
 138:	f422                	sd	s0,40(sp)
 13a:	1800                	addi	s0,sp,48
 13c:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
 140:	fe042623          	sw	zero,-20(s0)
 144:	a031                	j	150 <strlen+0x1a>
 146:	fec42783          	lw	a5,-20(s0)
 14a:	2785                	addiw	a5,a5,1
 14c:	fef42623          	sw	a5,-20(s0)
 150:	fec42783          	lw	a5,-20(s0)
 154:	fd843703          	ld	a4,-40(s0)
 158:	97ba                	add	a5,a5,a4
 15a:	0007c783          	lbu	a5,0(a5)
 15e:	f7e5                	bnez	a5,146 <strlen+0x10>
    ;
  return n;
 160:	fec42783          	lw	a5,-20(s0)
}
 164:	853e                	mv	a0,a5
 166:	7422                	ld	s0,40(sp)
 168:	6145                	addi	sp,sp,48
 16a:	8082                	ret

000000000000016c <memset>:

void*
memset(void *dst, int c, uint n)
{
 16c:	7179                	addi	sp,sp,-48
 16e:	f422                	sd	s0,40(sp)
 170:	1800                	addi	s0,sp,48
 172:	fca43c23          	sd	a0,-40(s0)
 176:	87ae                	mv	a5,a1
 178:	8732                	mv	a4,a2
 17a:	fcf42a23          	sw	a5,-44(s0)
 17e:	87ba                	mv	a5,a4
 180:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
 184:	fd843783          	ld	a5,-40(s0)
 188:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
 18c:	fe042623          	sw	zero,-20(s0)
 190:	a00d                	j	1b2 <memset+0x46>
    cdst[i] = c;
 192:	fec42783          	lw	a5,-20(s0)
 196:	fe043703          	ld	a4,-32(s0)
 19a:	97ba                	add	a5,a5,a4
 19c:	fd442703          	lw	a4,-44(s0)
 1a0:	0ff77713          	zext.b	a4,a4
 1a4:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
 1a8:	fec42783          	lw	a5,-20(s0)
 1ac:	2785                	addiw	a5,a5,1
 1ae:	fef42623          	sw	a5,-20(s0)
 1b2:	fec42703          	lw	a4,-20(s0)
 1b6:	fd042783          	lw	a5,-48(s0)
 1ba:	2781                	sext.w	a5,a5
 1bc:	fcf76be3          	bltu	a4,a5,192 <memset+0x26>
  }
  return dst;
 1c0:	fd843783          	ld	a5,-40(s0)
}
 1c4:	853e                	mv	a0,a5
 1c6:	7422                	ld	s0,40(sp)
 1c8:	6145                	addi	sp,sp,48
 1ca:	8082                	ret

00000000000001cc <strchr>:

char*
strchr(const char *s, char c)
{
 1cc:	1101                	addi	sp,sp,-32
 1ce:	ec22                	sd	s0,24(sp)
 1d0:	1000                	addi	s0,sp,32
 1d2:	fea43423          	sd	a0,-24(s0)
 1d6:	87ae                	mv	a5,a1
 1d8:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
 1dc:	a01d                	j	202 <strchr+0x36>
    if(*s == c)
 1de:	fe843783          	ld	a5,-24(s0)
 1e2:	0007c703          	lbu	a4,0(a5)
 1e6:	fe744783          	lbu	a5,-25(s0)
 1ea:	0ff7f793          	zext.b	a5,a5
 1ee:	00e79563          	bne	a5,a4,1f8 <strchr+0x2c>
      return (char*)s;
 1f2:	fe843783          	ld	a5,-24(s0)
 1f6:	a821                	j	20e <strchr+0x42>
  for(; *s; s++)
 1f8:	fe843783          	ld	a5,-24(s0)
 1fc:	0785                	addi	a5,a5,1
 1fe:	fef43423          	sd	a5,-24(s0)
 202:	fe843783          	ld	a5,-24(s0)
 206:	0007c783          	lbu	a5,0(a5)
 20a:	fbf1                	bnez	a5,1de <strchr+0x12>
  return 0;
 20c:	4781                	li	a5,0
}
 20e:	853e                	mv	a0,a5
 210:	6462                	ld	s0,24(sp)
 212:	6105                	addi	sp,sp,32
 214:	8082                	ret

0000000000000216 <gets>:

char*
gets(char *buf, int max)
{
 216:	7179                	addi	sp,sp,-48
 218:	f406                	sd	ra,40(sp)
 21a:	f022                	sd	s0,32(sp)
 21c:	1800                	addi	s0,sp,48
 21e:	fca43c23          	sd	a0,-40(s0)
 222:	87ae                	mv	a5,a1
 224:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 228:	fe042623          	sw	zero,-20(s0)
 22c:	a8a1                	j	284 <gets+0x6e>
    cc = read(0, &c, 1);
 22e:	fe740793          	addi	a5,s0,-25
 232:	4605                	li	a2,1
 234:	85be                	mv	a1,a5
 236:	4501                	li	a0,0
 238:	00000097          	auipc	ra,0x0
 23c:	2f8080e7          	jalr	760(ra) # 530 <read>
 240:	87aa                	mv	a5,a0
 242:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
 246:	fe842783          	lw	a5,-24(s0)
 24a:	2781                	sext.w	a5,a5
 24c:	04f05763          	blez	a5,29a <gets+0x84>
      break;
    buf[i++] = c;
 250:	fec42783          	lw	a5,-20(s0)
 254:	0017871b          	addiw	a4,a5,1
 258:	fee42623          	sw	a4,-20(s0)
 25c:	873e                	mv	a4,a5
 25e:	fd843783          	ld	a5,-40(s0)
 262:	97ba                	add	a5,a5,a4
 264:	fe744703          	lbu	a4,-25(s0)
 268:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
 26c:	fe744783          	lbu	a5,-25(s0)
 270:	873e                	mv	a4,a5
 272:	47a9                	li	a5,10
 274:	02f70463          	beq	a4,a5,29c <gets+0x86>
 278:	fe744783          	lbu	a5,-25(s0)
 27c:	873e                	mv	a4,a5
 27e:	47b5                	li	a5,13
 280:	00f70e63          	beq	a4,a5,29c <gets+0x86>
  for(i=0; i+1 < max; ){
 284:	fec42783          	lw	a5,-20(s0)
 288:	2785                	addiw	a5,a5,1
 28a:	0007871b          	sext.w	a4,a5
 28e:	fd442783          	lw	a5,-44(s0)
 292:	2781                	sext.w	a5,a5
 294:	f8f74de3          	blt	a4,a5,22e <gets+0x18>
 298:	a011                	j	29c <gets+0x86>
      break;
 29a:	0001                	nop
      break;
  }
  buf[i] = '\0';
 29c:	fec42783          	lw	a5,-20(s0)
 2a0:	fd843703          	ld	a4,-40(s0)
 2a4:	97ba                	add	a5,a5,a4
 2a6:	00078023          	sb	zero,0(a5)
  return buf;
 2aa:	fd843783          	ld	a5,-40(s0)
}
 2ae:	853e                	mv	a0,a5
 2b0:	70a2                	ld	ra,40(sp)
 2b2:	7402                	ld	s0,32(sp)
 2b4:	6145                	addi	sp,sp,48
 2b6:	8082                	ret

00000000000002b8 <stat>:

int
stat(const char *n, struct stat *st)
{
 2b8:	7179                	addi	sp,sp,-48
 2ba:	f406                	sd	ra,40(sp)
 2bc:	f022                	sd	s0,32(sp)
 2be:	1800                	addi	s0,sp,48
 2c0:	fca43c23          	sd	a0,-40(s0)
 2c4:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2c8:	4581                	li	a1,0
 2ca:	fd843503          	ld	a0,-40(s0)
 2ce:	00000097          	auipc	ra,0x0
 2d2:	28a080e7          	jalr	650(ra) # 558 <open>
 2d6:	87aa                	mv	a5,a0
 2d8:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
 2dc:	fec42783          	lw	a5,-20(s0)
 2e0:	2781                	sext.w	a5,a5
 2e2:	0007d463          	bgez	a5,2ea <stat+0x32>
    return -1;
 2e6:	57fd                	li	a5,-1
 2e8:	a035                	j	314 <stat+0x5c>
  r = fstat(fd, st);
 2ea:	fec42783          	lw	a5,-20(s0)
 2ee:	fd043583          	ld	a1,-48(s0)
 2f2:	853e                	mv	a0,a5
 2f4:	00000097          	auipc	ra,0x0
 2f8:	27c080e7          	jalr	636(ra) # 570 <fstat>
 2fc:	87aa                	mv	a5,a0
 2fe:	fef42423          	sw	a5,-24(s0)
  close(fd);
 302:	fec42783          	lw	a5,-20(s0)
 306:	853e                	mv	a0,a5
 308:	00000097          	auipc	ra,0x0
 30c:	238080e7          	jalr	568(ra) # 540 <close>
  return r;
 310:	fe842783          	lw	a5,-24(s0)
}
 314:	853e                	mv	a0,a5
 316:	70a2                	ld	ra,40(sp)
 318:	7402                	ld	s0,32(sp)
 31a:	6145                	addi	sp,sp,48
 31c:	8082                	ret

000000000000031e <atoi>:

int
atoi(const char *s)
{
 31e:	7179                	addi	sp,sp,-48
 320:	f422                	sd	s0,40(sp)
 322:	1800                	addi	s0,sp,48
 324:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
 328:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
 32c:	a81d                	j	362 <atoi+0x44>
    n = n*10 + *s++ - '0';
 32e:	fec42783          	lw	a5,-20(s0)
 332:	873e                	mv	a4,a5
 334:	87ba                	mv	a5,a4
 336:	0027979b          	slliw	a5,a5,0x2
 33a:	9fb9                	addw	a5,a5,a4
 33c:	0017979b          	slliw	a5,a5,0x1
 340:	0007871b          	sext.w	a4,a5
 344:	fd843783          	ld	a5,-40(s0)
 348:	00178693          	addi	a3,a5,1
 34c:	fcd43c23          	sd	a3,-40(s0)
 350:	0007c783          	lbu	a5,0(a5)
 354:	2781                	sext.w	a5,a5
 356:	9fb9                	addw	a5,a5,a4
 358:	2781                	sext.w	a5,a5
 35a:	fd07879b          	addiw	a5,a5,-48
 35e:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
 362:	fd843783          	ld	a5,-40(s0)
 366:	0007c783          	lbu	a5,0(a5)
 36a:	873e                	mv	a4,a5
 36c:	02f00793          	li	a5,47
 370:	00e7fb63          	bgeu	a5,a4,386 <atoi+0x68>
 374:	fd843783          	ld	a5,-40(s0)
 378:	0007c783          	lbu	a5,0(a5)
 37c:	873e                	mv	a4,a5
 37e:	03900793          	li	a5,57
 382:	fae7f6e3          	bgeu	a5,a4,32e <atoi+0x10>
  return n;
 386:	fec42783          	lw	a5,-20(s0)
}
 38a:	853e                	mv	a0,a5
 38c:	7422                	ld	s0,40(sp)
 38e:	6145                	addi	sp,sp,48
 390:	8082                	ret

0000000000000392 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 392:	7139                	addi	sp,sp,-64
 394:	fc22                	sd	s0,56(sp)
 396:	0080                	addi	s0,sp,64
 398:	fca43c23          	sd	a0,-40(s0)
 39c:	fcb43823          	sd	a1,-48(s0)
 3a0:	87b2                	mv	a5,a2
 3a2:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
 3a6:	fd843783          	ld	a5,-40(s0)
 3aa:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
 3ae:	fd043783          	ld	a5,-48(s0)
 3b2:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
 3b6:	fe043703          	ld	a4,-32(s0)
 3ba:	fe843783          	ld	a5,-24(s0)
 3be:	02e7fc63          	bgeu	a5,a4,3f6 <memmove+0x64>
    while(n-- > 0)
 3c2:	a00d                	j	3e4 <memmove+0x52>
      *dst++ = *src++;
 3c4:	fe043703          	ld	a4,-32(s0)
 3c8:	00170793          	addi	a5,a4,1
 3cc:	fef43023          	sd	a5,-32(s0)
 3d0:	fe843783          	ld	a5,-24(s0)
 3d4:	00178693          	addi	a3,a5,1
 3d8:	fed43423          	sd	a3,-24(s0)
 3dc:	00074703          	lbu	a4,0(a4)
 3e0:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 3e4:	fcc42783          	lw	a5,-52(s0)
 3e8:	fff7871b          	addiw	a4,a5,-1
 3ec:	fce42623          	sw	a4,-52(s0)
 3f0:	fcf04ae3          	bgtz	a5,3c4 <memmove+0x32>
 3f4:	a891                	j	448 <memmove+0xb6>
  } else {
    dst += n;
 3f6:	fcc42783          	lw	a5,-52(s0)
 3fa:	fe843703          	ld	a4,-24(s0)
 3fe:	97ba                	add	a5,a5,a4
 400:	fef43423          	sd	a5,-24(s0)
    src += n;
 404:	fcc42783          	lw	a5,-52(s0)
 408:	fe043703          	ld	a4,-32(s0)
 40c:	97ba                	add	a5,a5,a4
 40e:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
 412:	a01d                	j	438 <memmove+0xa6>
      *--dst = *--src;
 414:	fe043783          	ld	a5,-32(s0)
 418:	17fd                	addi	a5,a5,-1
 41a:	fef43023          	sd	a5,-32(s0)
 41e:	fe843783          	ld	a5,-24(s0)
 422:	17fd                	addi	a5,a5,-1
 424:	fef43423          	sd	a5,-24(s0)
 428:	fe043783          	ld	a5,-32(s0)
 42c:	0007c703          	lbu	a4,0(a5)
 430:	fe843783          	ld	a5,-24(s0)
 434:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
 438:	fcc42783          	lw	a5,-52(s0)
 43c:	fff7871b          	addiw	a4,a5,-1
 440:	fce42623          	sw	a4,-52(s0)
 444:	fcf048e3          	bgtz	a5,414 <memmove+0x82>
  }
  return vdst;
 448:	fd843783          	ld	a5,-40(s0)
}
 44c:	853e                	mv	a0,a5
 44e:	7462                	ld	s0,56(sp)
 450:	6121                	addi	sp,sp,64
 452:	8082                	ret

0000000000000454 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 454:	7139                	addi	sp,sp,-64
 456:	fc22                	sd	s0,56(sp)
 458:	0080                	addi	s0,sp,64
 45a:	fca43c23          	sd	a0,-40(s0)
 45e:	fcb43823          	sd	a1,-48(s0)
 462:	87b2                	mv	a5,a2
 464:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
 468:	fd843783          	ld	a5,-40(s0)
 46c:	fef43423          	sd	a5,-24(s0)
 470:	fd043783          	ld	a5,-48(s0)
 474:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 478:	a0a1                	j	4c0 <memcmp+0x6c>
    if (*p1 != *p2) {
 47a:	fe843783          	ld	a5,-24(s0)
 47e:	0007c703          	lbu	a4,0(a5)
 482:	fe043783          	ld	a5,-32(s0)
 486:	0007c783          	lbu	a5,0(a5)
 48a:	02f70163          	beq	a4,a5,4ac <memcmp+0x58>
      return *p1 - *p2;
 48e:	fe843783          	ld	a5,-24(s0)
 492:	0007c783          	lbu	a5,0(a5)
 496:	0007871b          	sext.w	a4,a5
 49a:	fe043783          	ld	a5,-32(s0)
 49e:	0007c783          	lbu	a5,0(a5)
 4a2:	2781                	sext.w	a5,a5
 4a4:	40f707bb          	subw	a5,a4,a5
 4a8:	2781                	sext.w	a5,a5
 4aa:	a01d                	j	4d0 <memcmp+0x7c>
    }
    p1++;
 4ac:	fe843783          	ld	a5,-24(s0)
 4b0:	0785                	addi	a5,a5,1
 4b2:	fef43423          	sd	a5,-24(s0)
    p2++;
 4b6:	fe043783          	ld	a5,-32(s0)
 4ba:	0785                	addi	a5,a5,1
 4bc:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
 4c0:	fcc42783          	lw	a5,-52(s0)
 4c4:	fff7871b          	addiw	a4,a5,-1
 4c8:	fce42623          	sw	a4,-52(s0)
 4cc:	f7dd                	bnez	a5,47a <memcmp+0x26>
  }
  return 0;
 4ce:	4781                	li	a5,0
}
 4d0:	853e                	mv	a0,a5
 4d2:	7462                	ld	s0,56(sp)
 4d4:	6121                	addi	sp,sp,64
 4d6:	8082                	ret

00000000000004d8 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4d8:	7179                	addi	sp,sp,-48
 4da:	f406                	sd	ra,40(sp)
 4dc:	f022                	sd	s0,32(sp)
 4de:	1800                	addi	s0,sp,48
 4e0:	fea43423          	sd	a0,-24(s0)
 4e4:	feb43023          	sd	a1,-32(s0)
 4e8:	87b2                	mv	a5,a2
 4ea:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
 4ee:	fdc42783          	lw	a5,-36(s0)
 4f2:	863e                	mv	a2,a5
 4f4:	fe043583          	ld	a1,-32(s0)
 4f8:	fe843503          	ld	a0,-24(s0)
 4fc:	00000097          	auipc	ra,0x0
 500:	e96080e7          	jalr	-362(ra) # 392 <memmove>
 504:	87aa                	mv	a5,a0
}
 506:	853e                	mv	a0,a5
 508:	70a2                	ld	ra,40(sp)
 50a:	7402                	ld	s0,32(sp)
 50c:	6145                	addi	sp,sp,48
 50e:	8082                	ret

0000000000000510 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 510:	4885                	li	a7,1
 ecall
 512:	00000073          	ecall
 ret
 516:	8082                	ret

0000000000000518 <exit>:
.global exit
exit:
 li a7, SYS_exit
 518:	4889                	li	a7,2
 ecall
 51a:	00000073          	ecall
 ret
 51e:	8082                	ret

0000000000000520 <wait>:
.global wait
wait:
 li a7, SYS_wait
 520:	488d                	li	a7,3
 ecall
 522:	00000073          	ecall
 ret
 526:	8082                	ret

0000000000000528 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 528:	4891                	li	a7,4
 ecall
 52a:	00000073          	ecall
 ret
 52e:	8082                	ret

0000000000000530 <read>:
.global read
read:
 li a7, SYS_read
 530:	4895                	li	a7,5
 ecall
 532:	00000073          	ecall
 ret
 536:	8082                	ret

0000000000000538 <write>:
.global write
write:
 li a7, SYS_write
 538:	48c1                	li	a7,16
 ecall
 53a:	00000073          	ecall
 ret
 53e:	8082                	ret

0000000000000540 <close>:
.global close
close:
 li a7, SYS_close
 540:	48d5                	li	a7,21
 ecall
 542:	00000073          	ecall
 ret
 546:	8082                	ret

0000000000000548 <kill>:
.global kill
kill:
 li a7, SYS_kill
 548:	4899                	li	a7,6
 ecall
 54a:	00000073          	ecall
 ret
 54e:	8082                	ret

0000000000000550 <exec>:
.global exec
exec:
 li a7, SYS_exec
 550:	489d                	li	a7,7
 ecall
 552:	00000073          	ecall
 ret
 556:	8082                	ret

0000000000000558 <open>:
.global open
open:
 li a7, SYS_open
 558:	48bd                	li	a7,15
 ecall
 55a:	00000073          	ecall
 ret
 55e:	8082                	ret

0000000000000560 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 560:	48c5                	li	a7,17
 ecall
 562:	00000073          	ecall
 ret
 566:	8082                	ret

0000000000000568 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 568:	48c9                	li	a7,18
 ecall
 56a:	00000073          	ecall
 ret
 56e:	8082                	ret

0000000000000570 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 570:	48a1                	li	a7,8
 ecall
 572:	00000073          	ecall
 ret
 576:	8082                	ret

0000000000000578 <link>:
.global link
link:
 li a7, SYS_link
 578:	48cd                	li	a7,19
 ecall
 57a:	00000073          	ecall
 ret
 57e:	8082                	ret

0000000000000580 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 580:	48d1                	li	a7,20
 ecall
 582:	00000073          	ecall
 ret
 586:	8082                	ret

0000000000000588 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 588:	48a5                	li	a7,9
 ecall
 58a:	00000073          	ecall
 ret
 58e:	8082                	ret

0000000000000590 <dup>:
.global dup
dup:
 li a7, SYS_dup
 590:	48a9                	li	a7,10
 ecall
 592:	00000073          	ecall
 ret
 596:	8082                	ret

0000000000000598 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 598:	48ad                	li	a7,11
 ecall
 59a:	00000073          	ecall
 ret
 59e:	8082                	ret

00000000000005a0 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5a0:	48b1                	li	a7,12
 ecall
 5a2:	00000073          	ecall
 ret
 5a6:	8082                	ret

00000000000005a8 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5a8:	48b5                	li	a7,13
 ecall
 5aa:	00000073          	ecall
 ret
 5ae:	8082                	ret

00000000000005b0 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5b0:	48b9                	li	a7,14
 ecall
 5b2:	00000073          	ecall
 ret
 5b6:	8082                	ret

00000000000005b8 <trace>:
.global trace
trace:
 li a7, SYS_trace
 5b8:	48d9                	li	a7,22
 ecall
 5ba:	00000073          	ecall
 ret
 5be:	8082                	ret

00000000000005c0 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 5c0:	48dd                	li	a7,23
 ecall
 5c2:	00000073          	ecall
 ret
 5c6:	8082                	ret

00000000000005c8 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5c8:	1101                	addi	sp,sp,-32
 5ca:	ec06                	sd	ra,24(sp)
 5cc:	e822                	sd	s0,16(sp)
 5ce:	1000                	addi	s0,sp,32
 5d0:	87aa                	mv	a5,a0
 5d2:	872e                	mv	a4,a1
 5d4:	fef42623          	sw	a5,-20(s0)
 5d8:	87ba                	mv	a5,a4
 5da:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
 5de:	feb40713          	addi	a4,s0,-21
 5e2:	fec42783          	lw	a5,-20(s0)
 5e6:	4605                	li	a2,1
 5e8:	85ba                	mv	a1,a4
 5ea:	853e                	mv	a0,a5
 5ec:	00000097          	auipc	ra,0x0
 5f0:	f4c080e7          	jalr	-180(ra) # 538 <write>
}
 5f4:	0001                	nop
 5f6:	60e2                	ld	ra,24(sp)
 5f8:	6442                	ld	s0,16(sp)
 5fa:	6105                	addi	sp,sp,32
 5fc:	8082                	ret

00000000000005fe <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5fe:	7139                	addi	sp,sp,-64
 600:	fc06                	sd	ra,56(sp)
 602:	f822                	sd	s0,48(sp)
 604:	0080                	addi	s0,sp,64
 606:	87aa                	mv	a5,a0
 608:	8736                	mv	a4,a3
 60a:	fcf42623          	sw	a5,-52(s0)
 60e:	87ae                	mv	a5,a1
 610:	fcf42423          	sw	a5,-56(s0)
 614:	87b2                	mv	a5,a2
 616:	fcf42223          	sw	a5,-60(s0)
 61a:	87ba                	mv	a5,a4
 61c:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 620:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
 624:	fc042783          	lw	a5,-64(s0)
 628:	2781                	sext.w	a5,a5
 62a:	c38d                	beqz	a5,64c <printint+0x4e>
 62c:	fc842783          	lw	a5,-56(s0)
 630:	2781                	sext.w	a5,a5
 632:	0007dd63          	bgez	a5,64c <printint+0x4e>
    neg = 1;
 636:	4785                	li	a5,1
 638:	fef42423          	sw	a5,-24(s0)
    x = -xx;
 63c:	fc842783          	lw	a5,-56(s0)
 640:	40f007bb          	negw	a5,a5
 644:	2781                	sext.w	a5,a5
 646:	fef42223          	sw	a5,-28(s0)
 64a:	a029                	j	654 <printint+0x56>
  } else {
    x = xx;
 64c:	fc842783          	lw	a5,-56(s0)
 650:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
 654:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
 658:	fc442783          	lw	a5,-60(s0)
 65c:	fe442703          	lw	a4,-28(s0)
 660:	02f777bb          	remuw	a5,a4,a5
 664:	0007861b          	sext.w	a2,a5
 668:	fec42783          	lw	a5,-20(s0)
 66c:	0017871b          	addiw	a4,a5,1
 670:	fee42623          	sw	a4,-20(s0)
 674:	00001697          	auipc	a3,0x1
 678:	98c68693          	addi	a3,a3,-1652 # 1000 <digits>
 67c:	02061713          	slli	a4,a2,0x20
 680:	9301                	srli	a4,a4,0x20
 682:	9736                	add	a4,a4,a3
 684:	00074703          	lbu	a4,0(a4)
 688:	17c1                	addi	a5,a5,-16
 68a:	97a2                	add	a5,a5,s0
 68c:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
 690:	fc442783          	lw	a5,-60(s0)
 694:	fe442703          	lw	a4,-28(s0)
 698:	02f757bb          	divuw	a5,a4,a5
 69c:	fef42223          	sw	a5,-28(s0)
 6a0:	fe442783          	lw	a5,-28(s0)
 6a4:	2781                	sext.w	a5,a5
 6a6:	fbcd                	bnez	a5,658 <printint+0x5a>
  if(neg)
 6a8:	fe842783          	lw	a5,-24(s0)
 6ac:	2781                	sext.w	a5,a5
 6ae:	cf85                	beqz	a5,6e6 <printint+0xe8>
    buf[i++] = '-';
 6b0:	fec42783          	lw	a5,-20(s0)
 6b4:	0017871b          	addiw	a4,a5,1
 6b8:	fee42623          	sw	a4,-20(s0)
 6bc:	17c1                	addi	a5,a5,-16
 6be:	97a2                	add	a5,a5,s0
 6c0:	02d00713          	li	a4,45
 6c4:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
 6c8:	a839                	j	6e6 <printint+0xe8>
    putc(fd, buf[i]);
 6ca:	fec42783          	lw	a5,-20(s0)
 6ce:	17c1                	addi	a5,a5,-16
 6d0:	97a2                	add	a5,a5,s0
 6d2:	fe07c703          	lbu	a4,-32(a5)
 6d6:	fcc42783          	lw	a5,-52(s0)
 6da:	85ba                	mv	a1,a4
 6dc:	853e                	mv	a0,a5
 6de:	00000097          	auipc	ra,0x0
 6e2:	eea080e7          	jalr	-278(ra) # 5c8 <putc>
  while(--i >= 0)
 6e6:	fec42783          	lw	a5,-20(s0)
 6ea:	37fd                	addiw	a5,a5,-1
 6ec:	fef42623          	sw	a5,-20(s0)
 6f0:	fec42783          	lw	a5,-20(s0)
 6f4:	2781                	sext.w	a5,a5
 6f6:	fc07dae3          	bgez	a5,6ca <printint+0xcc>
}
 6fa:	0001                	nop
 6fc:	0001                	nop
 6fe:	70e2                	ld	ra,56(sp)
 700:	7442                	ld	s0,48(sp)
 702:	6121                	addi	sp,sp,64
 704:	8082                	ret

0000000000000706 <printptr>:

static void
printptr(int fd, uint64 x) {
 706:	7179                	addi	sp,sp,-48
 708:	f406                	sd	ra,40(sp)
 70a:	f022                	sd	s0,32(sp)
 70c:	1800                	addi	s0,sp,48
 70e:	87aa                	mv	a5,a0
 710:	fcb43823          	sd	a1,-48(s0)
 714:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
 718:	fdc42783          	lw	a5,-36(s0)
 71c:	03000593          	li	a1,48
 720:	853e                	mv	a0,a5
 722:	00000097          	auipc	ra,0x0
 726:	ea6080e7          	jalr	-346(ra) # 5c8 <putc>
  putc(fd, 'x');
 72a:	fdc42783          	lw	a5,-36(s0)
 72e:	07800593          	li	a1,120
 732:	853e                	mv	a0,a5
 734:	00000097          	auipc	ra,0x0
 738:	e94080e7          	jalr	-364(ra) # 5c8 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 73c:	fe042623          	sw	zero,-20(s0)
 740:	a82d                	j	77a <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 742:	fd043783          	ld	a5,-48(s0)
 746:	93f1                	srli	a5,a5,0x3c
 748:	00001717          	auipc	a4,0x1
 74c:	8b870713          	addi	a4,a4,-1864 # 1000 <digits>
 750:	97ba                	add	a5,a5,a4
 752:	0007c703          	lbu	a4,0(a5)
 756:	fdc42783          	lw	a5,-36(s0)
 75a:	85ba                	mv	a1,a4
 75c:	853e                	mv	a0,a5
 75e:	00000097          	auipc	ra,0x0
 762:	e6a080e7          	jalr	-406(ra) # 5c8 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 766:	fec42783          	lw	a5,-20(s0)
 76a:	2785                	addiw	a5,a5,1
 76c:	fef42623          	sw	a5,-20(s0)
 770:	fd043783          	ld	a5,-48(s0)
 774:	0792                	slli	a5,a5,0x4
 776:	fcf43823          	sd	a5,-48(s0)
 77a:	fec42783          	lw	a5,-20(s0)
 77e:	873e                	mv	a4,a5
 780:	47bd                	li	a5,15
 782:	fce7f0e3          	bgeu	a5,a4,742 <printptr+0x3c>
}
 786:	0001                	nop
 788:	0001                	nop
 78a:	70a2                	ld	ra,40(sp)
 78c:	7402                	ld	s0,32(sp)
 78e:	6145                	addi	sp,sp,48
 790:	8082                	ret

0000000000000792 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 792:	715d                	addi	sp,sp,-80
 794:	e486                	sd	ra,72(sp)
 796:	e0a2                	sd	s0,64(sp)
 798:	0880                	addi	s0,sp,80
 79a:	87aa                	mv	a5,a0
 79c:	fcb43023          	sd	a1,-64(s0)
 7a0:	fac43c23          	sd	a2,-72(s0)
 7a4:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
 7a8:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 7ac:	fe042223          	sw	zero,-28(s0)
 7b0:	a42d                	j	9da <vprintf+0x248>
    c = fmt[i] & 0xff;
 7b2:	fe442783          	lw	a5,-28(s0)
 7b6:	fc043703          	ld	a4,-64(s0)
 7ba:	97ba                	add	a5,a5,a4
 7bc:	0007c783          	lbu	a5,0(a5)
 7c0:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
 7c4:	fe042783          	lw	a5,-32(s0)
 7c8:	2781                	sext.w	a5,a5
 7ca:	eb9d                	bnez	a5,800 <vprintf+0x6e>
      if(c == '%'){
 7cc:	fdc42783          	lw	a5,-36(s0)
 7d0:	0007871b          	sext.w	a4,a5
 7d4:	02500793          	li	a5,37
 7d8:	00f71763          	bne	a4,a5,7e6 <vprintf+0x54>
        state = '%';
 7dc:	02500793          	li	a5,37
 7e0:	fef42023          	sw	a5,-32(s0)
 7e4:	a2f5                	j	9d0 <vprintf+0x23e>
      } else {
        putc(fd, c);
 7e6:	fdc42783          	lw	a5,-36(s0)
 7ea:	0ff7f713          	zext.b	a4,a5
 7ee:	fcc42783          	lw	a5,-52(s0)
 7f2:	85ba                	mv	a1,a4
 7f4:	853e                	mv	a0,a5
 7f6:	00000097          	auipc	ra,0x0
 7fa:	dd2080e7          	jalr	-558(ra) # 5c8 <putc>
 7fe:	aac9                	j	9d0 <vprintf+0x23e>
      }
    } else if(state == '%'){
 800:	fe042783          	lw	a5,-32(s0)
 804:	0007871b          	sext.w	a4,a5
 808:	02500793          	li	a5,37
 80c:	1cf71263          	bne	a4,a5,9d0 <vprintf+0x23e>
      if(c == 'd'){
 810:	fdc42783          	lw	a5,-36(s0)
 814:	0007871b          	sext.w	a4,a5
 818:	06400793          	li	a5,100
 81c:	02f71463          	bne	a4,a5,844 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
 820:	fb843783          	ld	a5,-72(s0)
 824:	00878713          	addi	a4,a5,8
 828:	fae43c23          	sd	a4,-72(s0)
 82c:	4398                	lw	a4,0(a5)
 82e:	fcc42783          	lw	a5,-52(s0)
 832:	4685                	li	a3,1
 834:	4629                	li	a2,10
 836:	85ba                	mv	a1,a4
 838:	853e                	mv	a0,a5
 83a:	00000097          	auipc	ra,0x0
 83e:	dc4080e7          	jalr	-572(ra) # 5fe <printint>
 842:	a269                	j	9cc <vprintf+0x23a>
      } else if(c == 'l') {
 844:	fdc42783          	lw	a5,-36(s0)
 848:	0007871b          	sext.w	a4,a5
 84c:	06c00793          	li	a5,108
 850:	02f71663          	bne	a4,a5,87c <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
 854:	fb843783          	ld	a5,-72(s0)
 858:	00878713          	addi	a4,a5,8
 85c:	fae43c23          	sd	a4,-72(s0)
 860:	639c                	ld	a5,0(a5)
 862:	0007871b          	sext.w	a4,a5
 866:	fcc42783          	lw	a5,-52(s0)
 86a:	4681                	li	a3,0
 86c:	4629                	li	a2,10
 86e:	85ba                	mv	a1,a4
 870:	853e                	mv	a0,a5
 872:	00000097          	auipc	ra,0x0
 876:	d8c080e7          	jalr	-628(ra) # 5fe <printint>
 87a:	aa89                	j	9cc <vprintf+0x23a>
      } else if(c == 'x') {
 87c:	fdc42783          	lw	a5,-36(s0)
 880:	0007871b          	sext.w	a4,a5
 884:	07800793          	li	a5,120
 888:	02f71463          	bne	a4,a5,8b0 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
 88c:	fb843783          	ld	a5,-72(s0)
 890:	00878713          	addi	a4,a5,8
 894:	fae43c23          	sd	a4,-72(s0)
 898:	4398                	lw	a4,0(a5)
 89a:	fcc42783          	lw	a5,-52(s0)
 89e:	4681                	li	a3,0
 8a0:	4641                	li	a2,16
 8a2:	85ba                	mv	a1,a4
 8a4:	853e                	mv	a0,a5
 8a6:	00000097          	auipc	ra,0x0
 8aa:	d58080e7          	jalr	-680(ra) # 5fe <printint>
 8ae:	aa39                	j	9cc <vprintf+0x23a>
      } else if(c == 'p') {
 8b0:	fdc42783          	lw	a5,-36(s0)
 8b4:	0007871b          	sext.w	a4,a5
 8b8:	07000793          	li	a5,112
 8bc:	02f71263          	bne	a4,a5,8e0 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
 8c0:	fb843783          	ld	a5,-72(s0)
 8c4:	00878713          	addi	a4,a5,8
 8c8:	fae43c23          	sd	a4,-72(s0)
 8cc:	6398                	ld	a4,0(a5)
 8ce:	fcc42783          	lw	a5,-52(s0)
 8d2:	85ba                	mv	a1,a4
 8d4:	853e                	mv	a0,a5
 8d6:	00000097          	auipc	ra,0x0
 8da:	e30080e7          	jalr	-464(ra) # 706 <printptr>
 8de:	a0fd                	j	9cc <vprintf+0x23a>
      } else if(c == 's'){
 8e0:	fdc42783          	lw	a5,-36(s0)
 8e4:	0007871b          	sext.w	a4,a5
 8e8:	07300793          	li	a5,115
 8ec:	04f71c63          	bne	a4,a5,944 <vprintf+0x1b2>
        s = va_arg(ap, char*);
 8f0:	fb843783          	ld	a5,-72(s0)
 8f4:	00878713          	addi	a4,a5,8
 8f8:	fae43c23          	sd	a4,-72(s0)
 8fc:	639c                	ld	a5,0(a5)
 8fe:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
 902:	fe843783          	ld	a5,-24(s0)
 906:	eb8d                	bnez	a5,938 <vprintf+0x1a6>
          s = "(null)";
 908:	00000797          	auipc	a5,0x0
 90c:	49878793          	addi	a5,a5,1176 # da0 <malloc+0x15e>
 910:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 914:	a015                	j	938 <vprintf+0x1a6>
          putc(fd, *s);
 916:	fe843783          	ld	a5,-24(s0)
 91a:	0007c703          	lbu	a4,0(a5)
 91e:	fcc42783          	lw	a5,-52(s0)
 922:	85ba                	mv	a1,a4
 924:	853e                	mv	a0,a5
 926:	00000097          	auipc	ra,0x0
 92a:	ca2080e7          	jalr	-862(ra) # 5c8 <putc>
          s++;
 92e:	fe843783          	ld	a5,-24(s0)
 932:	0785                	addi	a5,a5,1
 934:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
 938:	fe843783          	ld	a5,-24(s0)
 93c:	0007c783          	lbu	a5,0(a5)
 940:	fbf9                	bnez	a5,916 <vprintf+0x184>
 942:	a069                	j	9cc <vprintf+0x23a>
        }
      } else if(c == 'c'){
 944:	fdc42783          	lw	a5,-36(s0)
 948:	0007871b          	sext.w	a4,a5
 94c:	06300793          	li	a5,99
 950:	02f71463          	bne	a4,a5,978 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
 954:	fb843783          	ld	a5,-72(s0)
 958:	00878713          	addi	a4,a5,8
 95c:	fae43c23          	sd	a4,-72(s0)
 960:	439c                	lw	a5,0(a5)
 962:	0ff7f713          	zext.b	a4,a5
 966:	fcc42783          	lw	a5,-52(s0)
 96a:	85ba                	mv	a1,a4
 96c:	853e                	mv	a0,a5
 96e:	00000097          	auipc	ra,0x0
 972:	c5a080e7          	jalr	-934(ra) # 5c8 <putc>
 976:	a899                	j	9cc <vprintf+0x23a>
      } else if(c == '%'){
 978:	fdc42783          	lw	a5,-36(s0)
 97c:	0007871b          	sext.w	a4,a5
 980:	02500793          	li	a5,37
 984:	00f71f63          	bne	a4,a5,9a2 <vprintf+0x210>
        putc(fd, c);
 988:	fdc42783          	lw	a5,-36(s0)
 98c:	0ff7f713          	zext.b	a4,a5
 990:	fcc42783          	lw	a5,-52(s0)
 994:	85ba                	mv	a1,a4
 996:	853e                	mv	a0,a5
 998:	00000097          	auipc	ra,0x0
 99c:	c30080e7          	jalr	-976(ra) # 5c8 <putc>
 9a0:	a035                	j	9cc <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 9a2:	fcc42783          	lw	a5,-52(s0)
 9a6:	02500593          	li	a1,37
 9aa:	853e                	mv	a0,a5
 9ac:	00000097          	auipc	ra,0x0
 9b0:	c1c080e7          	jalr	-996(ra) # 5c8 <putc>
        putc(fd, c);
 9b4:	fdc42783          	lw	a5,-36(s0)
 9b8:	0ff7f713          	zext.b	a4,a5
 9bc:	fcc42783          	lw	a5,-52(s0)
 9c0:	85ba                	mv	a1,a4
 9c2:	853e                	mv	a0,a5
 9c4:	00000097          	auipc	ra,0x0
 9c8:	c04080e7          	jalr	-1020(ra) # 5c8 <putc>
      }
      state = 0;
 9cc:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
 9d0:	fe442783          	lw	a5,-28(s0)
 9d4:	2785                	addiw	a5,a5,1
 9d6:	fef42223          	sw	a5,-28(s0)
 9da:	fe442783          	lw	a5,-28(s0)
 9de:	fc043703          	ld	a4,-64(s0)
 9e2:	97ba                	add	a5,a5,a4
 9e4:	0007c783          	lbu	a5,0(a5)
 9e8:	dc0795e3          	bnez	a5,7b2 <vprintf+0x20>
    }
  }
}
 9ec:	0001                	nop
 9ee:	0001                	nop
 9f0:	60a6                	ld	ra,72(sp)
 9f2:	6406                	ld	s0,64(sp)
 9f4:	6161                	addi	sp,sp,80
 9f6:	8082                	ret

00000000000009f8 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 9f8:	7159                	addi	sp,sp,-112
 9fa:	fc06                	sd	ra,56(sp)
 9fc:	f822                	sd	s0,48(sp)
 9fe:	0080                	addi	s0,sp,64
 a00:	fcb43823          	sd	a1,-48(s0)
 a04:	e010                	sd	a2,0(s0)
 a06:	e414                	sd	a3,8(s0)
 a08:	e818                	sd	a4,16(s0)
 a0a:	ec1c                	sd	a5,24(s0)
 a0c:	03043023          	sd	a6,32(s0)
 a10:	03143423          	sd	a7,40(s0)
 a14:	87aa                	mv	a5,a0
 a16:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
 a1a:	03040793          	addi	a5,s0,48
 a1e:	fcf43423          	sd	a5,-56(s0)
 a22:	fc843783          	ld	a5,-56(s0)
 a26:	fd078793          	addi	a5,a5,-48
 a2a:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
 a2e:	fe843703          	ld	a4,-24(s0)
 a32:	fdc42783          	lw	a5,-36(s0)
 a36:	863a                	mv	a2,a4
 a38:	fd043583          	ld	a1,-48(s0)
 a3c:	853e                	mv	a0,a5
 a3e:	00000097          	auipc	ra,0x0
 a42:	d54080e7          	jalr	-684(ra) # 792 <vprintf>
}
 a46:	0001                	nop
 a48:	70e2                	ld	ra,56(sp)
 a4a:	7442                	ld	s0,48(sp)
 a4c:	6165                	addi	sp,sp,112
 a4e:	8082                	ret

0000000000000a50 <printf>:

void
printf(const char *fmt, ...)
{
 a50:	7159                	addi	sp,sp,-112
 a52:	f406                	sd	ra,40(sp)
 a54:	f022                	sd	s0,32(sp)
 a56:	1800                	addi	s0,sp,48
 a58:	fca43c23          	sd	a0,-40(s0)
 a5c:	e40c                	sd	a1,8(s0)
 a5e:	e810                	sd	a2,16(s0)
 a60:	ec14                	sd	a3,24(s0)
 a62:	f018                	sd	a4,32(s0)
 a64:	f41c                	sd	a5,40(s0)
 a66:	03043823          	sd	a6,48(s0)
 a6a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a6e:	04040793          	addi	a5,s0,64
 a72:	fcf43823          	sd	a5,-48(s0)
 a76:	fd043783          	ld	a5,-48(s0)
 a7a:	fc878793          	addi	a5,a5,-56
 a7e:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
 a82:	fe843783          	ld	a5,-24(s0)
 a86:	863e                	mv	a2,a5
 a88:	fd843583          	ld	a1,-40(s0)
 a8c:	4505                	li	a0,1
 a8e:	00000097          	auipc	ra,0x0
 a92:	d04080e7          	jalr	-764(ra) # 792 <vprintf>
}
 a96:	0001                	nop
 a98:	70a2                	ld	ra,40(sp)
 a9a:	7402                	ld	s0,32(sp)
 a9c:	6165                	addi	sp,sp,112
 a9e:	8082                	ret

0000000000000aa0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 aa0:	7179                	addi	sp,sp,-48
 aa2:	f422                	sd	s0,40(sp)
 aa4:	1800                	addi	s0,sp,48
 aa6:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 aaa:	fd843783          	ld	a5,-40(s0)
 aae:	17c1                	addi	a5,a5,-16
 ab0:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ab4:	00000797          	auipc	a5,0x0
 ab8:	57c78793          	addi	a5,a5,1404 # 1030 <freep>
 abc:	639c                	ld	a5,0(a5)
 abe:	fef43423          	sd	a5,-24(s0)
 ac2:	a815                	j	af6 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ac4:	fe843783          	ld	a5,-24(s0)
 ac8:	639c                	ld	a5,0(a5)
 aca:	fe843703          	ld	a4,-24(s0)
 ace:	00f76f63          	bltu	a4,a5,aec <free+0x4c>
 ad2:	fe043703          	ld	a4,-32(s0)
 ad6:	fe843783          	ld	a5,-24(s0)
 ada:	02e7eb63          	bltu	a5,a4,b10 <free+0x70>
 ade:	fe843783          	ld	a5,-24(s0)
 ae2:	639c                	ld	a5,0(a5)
 ae4:	fe043703          	ld	a4,-32(s0)
 ae8:	02f76463          	bltu	a4,a5,b10 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 aec:	fe843783          	ld	a5,-24(s0)
 af0:	639c                	ld	a5,0(a5)
 af2:	fef43423          	sd	a5,-24(s0)
 af6:	fe043703          	ld	a4,-32(s0)
 afa:	fe843783          	ld	a5,-24(s0)
 afe:	fce7f3e3          	bgeu	a5,a4,ac4 <free+0x24>
 b02:	fe843783          	ld	a5,-24(s0)
 b06:	639c                	ld	a5,0(a5)
 b08:	fe043703          	ld	a4,-32(s0)
 b0c:	faf77ce3          	bgeu	a4,a5,ac4 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
 b10:	fe043783          	ld	a5,-32(s0)
 b14:	479c                	lw	a5,8(a5)
 b16:	1782                	slli	a5,a5,0x20
 b18:	9381                	srli	a5,a5,0x20
 b1a:	0792                	slli	a5,a5,0x4
 b1c:	fe043703          	ld	a4,-32(s0)
 b20:	973e                	add	a4,a4,a5
 b22:	fe843783          	ld	a5,-24(s0)
 b26:	639c                	ld	a5,0(a5)
 b28:	02f71763          	bne	a4,a5,b56 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
 b2c:	fe043783          	ld	a5,-32(s0)
 b30:	4798                	lw	a4,8(a5)
 b32:	fe843783          	ld	a5,-24(s0)
 b36:	639c                	ld	a5,0(a5)
 b38:	479c                	lw	a5,8(a5)
 b3a:	9fb9                	addw	a5,a5,a4
 b3c:	0007871b          	sext.w	a4,a5
 b40:	fe043783          	ld	a5,-32(s0)
 b44:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
 b46:	fe843783          	ld	a5,-24(s0)
 b4a:	639c                	ld	a5,0(a5)
 b4c:	6398                	ld	a4,0(a5)
 b4e:	fe043783          	ld	a5,-32(s0)
 b52:	e398                	sd	a4,0(a5)
 b54:	a039                	j	b62 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
 b56:	fe843783          	ld	a5,-24(s0)
 b5a:	6398                	ld	a4,0(a5)
 b5c:	fe043783          	ld	a5,-32(s0)
 b60:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
 b62:	fe843783          	ld	a5,-24(s0)
 b66:	479c                	lw	a5,8(a5)
 b68:	1782                	slli	a5,a5,0x20
 b6a:	9381                	srli	a5,a5,0x20
 b6c:	0792                	slli	a5,a5,0x4
 b6e:	fe843703          	ld	a4,-24(s0)
 b72:	97ba                	add	a5,a5,a4
 b74:	fe043703          	ld	a4,-32(s0)
 b78:	02f71563          	bne	a4,a5,ba2 <free+0x102>
    p->s.size += bp->s.size;
 b7c:	fe843783          	ld	a5,-24(s0)
 b80:	4798                	lw	a4,8(a5)
 b82:	fe043783          	ld	a5,-32(s0)
 b86:	479c                	lw	a5,8(a5)
 b88:	9fb9                	addw	a5,a5,a4
 b8a:	0007871b          	sext.w	a4,a5
 b8e:	fe843783          	ld	a5,-24(s0)
 b92:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 b94:	fe043783          	ld	a5,-32(s0)
 b98:	6398                	ld	a4,0(a5)
 b9a:	fe843783          	ld	a5,-24(s0)
 b9e:	e398                	sd	a4,0(a5)
 ba0:	a031                	j	bac <free+0x10c>
  } else
    p->s.ptr = bp;
 ba2:	fe843783          	ld	a5,-24(s0)
 ba6:	fe043703          	ld	a4,-32(s0)
 baa:	e398                	sd	a4,0(a5)
  freep = p;
 bac:	00000797          	auipc	a5,0x0
 bb0:	48478793          	addi	a5,a5,1156 # 1030 <freep>
 bb4:	fe843703          	ld	a4,-24(s0)
 bb8:	e398                	sd	a4,0(a5)
}
 bba:	0001                	nop
 bbc:	7422                	ld	s0,40(sp)
 bbe:	6145                	addi	sp,sp,48
 bc0:	8082                	ret

0000000000000bc2 <morecore>:

static Header*
morecore(uint nu)
{
 bc2:	7179                	addi	sp,sp,-48
 bc4:	f406                	sd	ra,40(sp)
 bc6:	f022                	sd	s0,32(sp)
 bc8:	1800                	addi	s0,sp,48
 bca:	87aa                	mv	a5,a0
 bcc:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
 bd0:	fdc42783          	lw	a5,-36(s0)
 bd4:	0007871b          	sext.w	a4,a5
 bd8:	6785                	lui	a5,0x1
 bda:	00f77563          	bgeu	a4,a5,be4 <morecore+0x22>
    nu = 4096;
 bde:	6785                	lui	a5,0x1
 be0:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
 be4:	fdc42783          	lw	a5,-36(s0)
 be8:	0047979b          	slliw	a5,a5,0x4
 bec:	2781                	sext.w	a5,a5
 bee:	2781                	sext.w	a5,a5
 bf0:	853e                	mv	a0,a5
 bf2:	00000097          	auipc	ra,0x0
 bf6:	9ae080e7          	jalr	-1618(ra) # 5a0 <sbrk>
 bfa:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
 bfe:	fe843703          	ld	a4,-24(s0)
 c02:	57fd                	li	a5,-1
 c04:	00f71463          	bne	a4,a5,c0c <morecore+0x4a>
    return 0;
 c08:	4781                	li	a5,0
 c0a:	a03d                	j	c38 <morecore+0x76>
  hp = (Header*)p;
 c0c:	fe843783          	ld	a5,-24(s0)
 c10:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
 c14:	fe043783          	ld	a5,-32(s0)
 c18:	fdc42703          	lw	a4,-36(s0)
 c1c:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
 c1e:	fe043783          	ld	a5,-32(s0)
 c22:	07c1                	addi	a5,a5,16 # 1010 <digits+0x10>
 c24:	853e                	mv	a0,a5
 c26:	00000097          	auipc	ra,0x0
 c2a:	e7a080e7          	jalr	-390(ra) # aa0 <free>
  return freep;
 c2e:	00000797          	auipc	a5,0x0
 c32:	40278793          	addi	a5,a5,1026 # 1030 <freep>
 c36:	639c                	ld	a5,0(a5)
}
 c38:	853e                	mv	a0,a5
 c3a:	70a2                	ld	ra,40(sp)
 c3c:	7402                	ld	s0,32(sp)
 c3e:	6145                	addi	sp,sp,48
 c40:	8082                	ret

0000000000000c42 <malloc>:

void*
malloc(uint nbytes)
{
 c42:	7139                	addi	sp,sp,-64
 c44:	fc06                	sd	ra,56(sp)
 c46:	f822                	sd	s0,48(sp)
 c48:	0080                	addi	s0,sp,64
 c4a:	87aa                	mv	a5,a0
 c4c:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c50:	fcc46783          	lwu	a5,-52(s0)
 c54:	07bd                	addi	a5,a5,15
 c56:	8391                	srli	a5,a5,0x4
 c58:	2781                	sext.w	a5,a5
 c5a:	2785                	addiw	a5,a5,1
 c5c:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
 c60:	00000797          	auipc	a5,0x0
 c64:	3d078793          	addi	a5,a5,976 # 1030 <freep>
 c68:	639c                	ld	a5,0(a5)
 c6a:	fef43023          	sd	a5,-32(s0)
 c6e:	fe043783          	ld	a5,-32(s0)
 c72:	ef95                	bnez	a5,cae <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
 c74:	00000797          	auipc	a5,0x0
 c78:	3ac78793          	addi	a5,a5,940 # 1020 <base>
 c7c:	fef43023          	sd	a5,-32(s0)
 c80:	00000797          	auipc	a5,0x0
 c84:	3b078793          	addi	a5,a5,944 # 1030 <freep>
 c88:	fe043703          	ld	a4,-32(s0)
 c8c:	e398                	sd	a4,0(a5)
 c8e:	00000797          	auipc	a5,0x0
 c92:	3a278793          	addi	a5,a5,930 # 1030 <freep>
 c96:	6398                	ld	a4,0(a5)
 c98:	00000797          	auipc	a5,0x0
 c9c:	38878793          	addi	a5,a5,904 # 1020 <base>
 ca0:	e398                	sd	a4,0(a5)
    base.s.size = 0;
 ca2:	00000797          	auipc	a5,0x0
 ca6:	37e78793          	addi	a5,a5,894 # 1020 <base>
 caa:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 cae:	fe043783          	ld	a5,-32(s0)
 cb2:	639c                	ld	a5,0(a5)
 cb4:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 cb8:	fe843783          	ld	a5,-24(s0)
 cbc:	4798                	lw	a4,8(a5)
 cbe:	fdc42783          	lw	a5,-36(s0)
 cc2:	2781                	sext.w	a5,a5
 cc4:	06f76763          	bltu	a4,a5,d32 <malloc+0xf0>
      if(p->s.size == nunits)
 cc8:	fe843783          	ld	a5,-24(s0)
 ccc:	4798                	lw	a4,8(a5)
 cce:	fdc42783          	lw	a5,-36(s0)
 cd2:	2781                	sext.w	a5,a5
 cd4:	00e79963          	bne	a5,a4,ce6 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
 cd8:	fe843783          	ld	a5,-24(s0)
 cdc:	6398                	ld	a4,0(a5)
 cde:	fe043783          	ld	a5,-32(s0)
 ce2:	e398                	sd	a4,0(a5)
 ce4:	a825                	j	d1c <malloc+0xda>
      else {
        p->s.size -= nunits;
 ce6:	fe843783          	ld	a5,-24(s0)
 cea:	479c                	lw	a5,8(a5)
 cec:	fdc42703          	lw	a4,-36(s0)
 cf0:	9f99                	subw	a5,a5,a4
 cf2:	0007871b          	sext.w	a4,a5
 cf6:	fe843783          	ld	a5,-24(s0)
 cfa:	c798                	sw	a4,8(a5)
        p += p->s.size;
 cfc:	fe843783          	ld	a5,-24(s0)
 d00:	479c                	lw	a5,8(a5)
 d02:	1782                	slli	a5,a5,0x20
 d04:	9381                	srli	a5,a5,0x20
 d06:	0792                	slli	a5,a5,0x4
 d08:	fe843703          	ld	a4,-24(s0)
 d0c:	97ba                	add	a5,a5,a4
 d0e:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
 d12:	fe843783          	ld	a5,-24(s0)
 d16:	fdc42703          	lw	a4,-36(s0)
 d1a:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
 d1c:	00000797          	auipc	a5,0x0
 d20:	31478793          	addi	a5,a5,788 # 1030 <freep>
 d24:	fe043703          	ld	a4,-32(s0)
 d28:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
 d2a:	fe843783          	ld	a5,-24(s0)
 d2e:	07c1                	addi	a5,a5,16
 d30:	a091                	j	d74 <malloc+0x132>
    }
    if(p == freep)
 d32:	00000797          	auipc	a5,0x0
 d36:	2fe78793          	addi	a5,a5,766 # 1030 <freep>
 d3a:	639c                	ld	a5,0(a5)
 d3c:	fe843703          	ld	a4,-24(s0)
 d40:	02f71063          	bne	a4,a5,d60 <malloc+0x11e>
      if((p = morecore(nunits)) == 0)
 d44:	fdc42783          	lw	a5,-36(s0)
 d48:	853e                	mv	a0,a5
 d4a:	00000097          	auipc	ra,0x0
 d4e:	e78080e7          	jalr	-392(ra) # bc2 <morecore>
 d52:	fea43423          	sd	a0,-24(s0)
 d56:	fe843783          	ld	a5,-24(s0)
 d5a:	e399                	bnez	a5,d60 <malloc+0x11e>
        return 0;
 d5c:	4781                	li	a5,0
 d5e:	a819                	j	d74 <malloc+0x132>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d60:	fe843783          	ld	a5,-24(s0)
 d64:	fef43023          	sd	a5,-32(s0)
 d68:	fe843783          	ld	a5,-24(s0)
 d6c:	639c                	ld	a5,0(a5)
 d6e:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
 d72:	b799                	j	cb8 <malloc+0x76>
  }
}
 d74:	853e                	mv	a0,a5
 d76:	70e2                	ld	ra,56(sp)
 d78:	7442                	ld	s0,48(sp)
 d7a:	6121                	addi	sp,sp,64
 d7c:	8082                	ret
