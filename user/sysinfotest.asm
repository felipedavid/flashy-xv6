
user/_sysinfotest:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <sinfo>:
#include "kernel/sysinfo.h"
#include "user/user.h"


void
sinfo(struct sysinfo *info) {
       0:	1101                	addi	sp,sp,-32
       2:	ec06                	sd	ra,24(sp)
       4:	e822                	sd	s0,16(sp)
       6:	1000                	addi	s0,sp,32
       8:	fea43423          	sd	a0,-24(s0)
  if (sysinfo(info) < 0) {
       c:	fe843503          	ld	a0,-24(s0)
      10:	00001097          	auipc	ra,0x1
      14:	9d6080e7          	jalr	-1578(ra) # 9e6 <sysinfo>
      18:	87aa                	mv	a5,a0
      1a:	0007df63          	bgez	a5,38 <sinfo+0x38>
    printf("FAIL: sysinfo failed");
      1e:	00001517          	auipc	a0,0x1
      22:	19250513          	addi	a0,a0,402 # 11b0 <malloc+0x148>
      26:	00001097          	auipc	ra,0x1
      2a:	e50080e7          	jalr	-432(ra) # e76 <printf>
    exit(1);
      2e:	4505                	li	a0,1
      30:	00001097          	auipc	ra,0x1
      34:	90e080e7          	jalr	-1778(ra) # 93e <exit>
  }
}
      38:	0001                	nop
      3a:	60e2                	ld	ra,24(sp)
      3c:	6442                	ld	s0,16(sp)
      3e:	6105                	addi	sp,sp,32
      40:	8082                	ret

0000000000000042 <countfree>:
//
// use sbrk() to count how many free physical memory pages there are.
//
int
countfree()
{
      42:	7139                	addi	sp,sp,-64
      44:	fc06                	sd	ra,56(sp)
      46:	f822                	sd	s0,48(sp)
      48:	f426                	sd	s1,40(sp)
      4a:	0080                	addi	s0,sp,64
  uint64 sz0 = (uint64)sbrk(0);
      4c:	4501                	li	a0,0
      4e:	00001097          	auipc	ra,0x1
      52:	978080e7          	jalr	-1672(ra) # 9c6 <sbrk>
      56:	87aa                	mv	a5,a0
      58:	fcf43823          	sd	a5,-48(s0)
  struct sysinfo info;
  int n = 0;
      5c:	fc042e23          	sw	zero,-36(s0)

  while(1){
    if((uint64)sbrk(PGSIZE) == 0xffffffffffffffff){
      60:	6505                	lui	a0,0x1
      62:	00001097          	auipc	ra,0x1
      66:	964080e7          	jalr	-1692(ra) # 9c6 <sbrk>
      6a:	872a                	mv	a4,a0
      6c:	57fd                	li	a5,-1
      6e:	00f70a63          	beq	a4,a5,82 <countfree+0x40>
      break;
    }
    n += PGSIZE;
      72:	fdc42783          	lw	a5,-36(s0)
      76:	873e                	mv	a4,a5
      78:	6785                	lui	a5,0x1
      7a:	9fb9                	addw	a5,a5,a4
      7c:	fcf42e23          	sw	a5,-36(s0)
    if((uint64)sbrk(PGSIZE) == 0xffffffffffffffff){
      80:	b7c5                	j	60 <countfree+0x1e>
      break;
      82:	0001                	nop
  }
  sinfo(&info);
      84:	fc040793          	addi	a5,s0,-64
      88:	853e                	mv	a0,a5
      8a:	00000097          	auipc	ra,0x0
      8e:	f76080e7          	jalr	-138(ra) # 0 <sinfo>
  if (info.freemem != 0) {
      92:	fc043783          	ld	a5,-64(s0)
      96:	c38d                	beqz	a5,b8 <countfree+0x76>
    printf("FAIL: there is no free mem, but sysinfo.freemem=%d\n",
      98:	fc043783          	ld	a5,-64(s0)
      9c:	85be                	mv	a1,a5
      9e:	00001517          	auipc	a0,0x1
      a2:	12a50513          	addi	a0,a0,298 # 11c8 <malloc+0x160>
      a6:	00001097          	auipc	ra,0x1
      aa:	dd0080e7          	jalr	-560(ra) # e76 <printf>
      info.freemem);
    exit(1);
      ae:	4505                	li	a0,1
      b0:	00001097          	auipc	ra,0x1
      b4:	88e080e7          	jalr	-1906(ra) # 93e <exit>
  }
  sbrk(-((uint64)sbrk(0) - sz0));
      b8:	fd043783          	ld	a5,-48(s0)
      bc:	0007849b          	sext.w	s1,a5
      c0:	4501                	li	a0,0
      c2:	00001097          	auipc	ra,0x1
      c6:	904080e7          	jalr	-1788(ra) # 9c6 <sbrk>
      ca:	87aa                	mv	a5,a0
      cc:	2781                	sext.w	a5,a5
      ce:	40f487bb          	subw	a5,s1,a5
      d2:	2781                	sext.w	a5,a5
      d4:	2781                	sext.w	a5,a5
      d6:	853e                	mv	a0,a5
      d8:	00001097          	auipc	ra,0x1
      dc:	8ee080e7          	jalr	-1810(ra) # 9c6 <sbrk>
  return n;
      e0:	fdc42783          	lw	a5,-36(s0)
}
      e4:	853e                	mv	a0,a5
      e6:	70e2                	ld	ra,56(sp)
      e8:	7442                	ld	s0,48(sp)
      ea:	74a2                	ld	s1,40(sp)
      ec:	6121                	addi	sp,sp,64
      ee:	8082                	ret

00000000000000f0 <testmem>:

void
testmem() {
      f0:	7179                	addi	sp,sp,-48
      f2:	f406                	sd	ra,40(sp)
      f4:	f022                	sd	s0,32(sp)
      f6:	1800                	addi	s0,sp,48
  struct sysinfo info;
  uint64 n = countfree();
      f8:	00000097          	auipc	ra,0x0
      fc:	f4a080e7          	jalr	-182(ra) # 42 <countfree>
     100:	87aa                	mv	a5,a0
     102:	fef43423          	sd	a5,-24(s0)
  
  sinfo(&info);
     106:	fd840793          	addi	a5,s0,-40
     10a:	853e                	mv	a0,a5
     10c:	00000097          	auipc	ra,0x0
     110:	ef4080e7          	jalr	-268(ra) # 0 <sinfo>

  if (info.freemem!= n) {
     114:	fd843783          	ld	a5,-40(s0)
     118:	fe843703          	ld	a4,-24(s0)
     11c:	02f70463          	beq	a4,a5,144 <testmem+0x54>
    printf("FAIL: free mem %d (bytes) instead of %d\n", info.freemem, n);
     120:	fd843783          	ld	a5,-40(s0)
     124:	fe843603          	ld	a2,-24(s0)
     128:	85be                	mv	a1,a5
     12a:	00001517          	auipc	a0,0x1
     12e:	0d650513          	addi	a0,a0,214 # 1200 <malloc+0x198>
     132:	00001097          	auipc	ra,0x1
     136:	d44080e7          	jalr	-700(ra) # e76 <printf>
    exit(1);
     13a:	4505                	li	a0,1
     13c:	00001097          	auipc	ra,0x1
     140:	802080e7          	jalr	-2046(ra) # 93e <exit>
  }
  
  if((uint64)sbrk(PGSIZE) == 0xffffffffffffffff){
     144:	6505                	lui	a0,0x1
     146:	00001097          	auipc	ra,0x1
     14a:	880080e7          	jalr	-1920(ra) # 9c6 <sbrk>
     14e:	872a                	mv	a4,a0
     150:	57fd                	li	a5,-1
     152:	00f71f63          	bne	a4,a5,170 <testmem+0x80>
    printf("sbrk failed");
     156:	00001517          	auipc	a0,0x1
     15a:	0da50513          	addi	a0,a0,218 # 1230 <malloc+0x1c8>
     15e:	00001097          	auipc	ra,0x1
     162:	d18080e7          	jalr	-744(ra) # e76 <printf>
    exit(1);
     166:	4505                	li	a0,1
     168:	00000097          	auipc	ra,0x0
     16c:	7d6080e7          	jalr	2006(ra) # 93e <exit>
  }

  sinfo(&info);
     170:	fd840793          	addi	a5,s0,-40
     174:	853e                	mv	a0,a5
     176:	00000097          	auipc	ra,0x0
     17a:	e8a080e7          	jalr	-374(ra) # 0 <sinfo>
    
  if (info.freemem != n-PGSIZE) {
     17e:	fd843703          	ld	a4,-40(s0)
     182:	fe843683          	ld	a3,-24(s0)
     186:	77fd                	lui	a5,0xfffff
     188:	97b6                	add	a5,a5,a3
     18a:	02f70763          	beq	a4,a5,1b8 <testmem+0xc8>
    printf("FAIL: free mem %d (bytes) instead of %d\n", n-PGSIZE, info.freemem);
     18e:	fe843703          	ld	a4,-24(s0)
     192:	77fd                	lui	a5,0xfffff
     194:	97ba                	add	a5,a5,a4
     196:	fd843703          	ld	a4,-40(s0)
     19a:	863a                	mv	a2,a4
     19c:	85be                	mv	a1,a5
     19e:	00001517          	auipc	a0,0x1
     1a2:	06250513          	addi	a0,a0,98 # 1200 <malloc+0x198>
     1a6:	00001097          	auipc	ra,0x1
     1aa:	cd0080e7          	jalr	-816(ra) # e76 <printf>
    exit(1);
     1ae:	4505                	li	a0,1
     1b0:	00000097          	auipc	ra,0x0
     1b4:	78e080e7          	jalr	1934(ra) # 93e <exit>
  }
  
  if((uint64)sbrk(-PGSIZE) == 0xffffffffffffffff){
     1b8:	757d                	lui	a0,0xfffff
     1ba:	00001097          	auipc	ra,0x1
     1be:	80c080e7          	jalr	-2036(ra) # 9c6 <sbrk>
     1c2:	872a                	mv	a4,a0
     1c4:	57fd                	li	a5,-1
     1c6:	00f71f63          	bne	a4,a5,1e4 <testmem+0xf4>
    printf("sbrk failed");
     1ca:	00001517          	auipc	a0,0x1
     1ce:	06650513          	addi	a0,a0,102 # 1230 <malloc+0x1c8>
     1d2:	00001097          	auipc	ra,0x1
     1d6:	ca4080e7          	jalr	-860(ra) # e76 <printf>
    exit(1);
     1da:	4505                	li	a0,1
     1dc:	00000097          	auipc	ra,0x0
     1e0:	762080e7          	jalr	1890(ra) # 93e <exit>
  }

  sinfo(&info);
     1e4:	fd840793          	addi	a5,s0,-40
     1e8:	853e                	mv	a0,a5
     1ea:	00000097          	auipc	ra,0x0
     1ee:	e16080e7          	jalr	-490(ra) # 0 <sinfo>
    
  if (info.freemem != n) {
     1f2:	fd843783          	ld	a5,-40(s0)
     1f6:	fe843703          	ld	a4,-24(s0)
     1fa:	02f70463          	beq	a4,a5,222 <testmem+0x132>
    printf("FAIL: free mem %d (bytes) instead of %d\n", n, info.freemem);
     1fe:	fd843783          	ld	a5,-40(s0)
     202:	863e                	mv	a2,a5
     204:	fe843583          	ld	a1,-24(s0)
     208:	00001517          	auipc	a0,0x1
     20c:	ff850513          	addi	a0,a0,-8 # 1200 <malloc+0x198>
     210:	00001097          	auipc	ra,0x1
     214:	c66080e7          	jalr	-922(ra) # e76 <printf>
    exit(1);
     218:	4505                	li	a0,1
     21a:	00000097          	auipc	ra,0x0
     21e:	724080e7          	jalr	1828(ra) # 93e <exit>
  }
}
     222:	0001                	nop
     224:	70a2                	ld	ra,40(sp)
     226:	7402                	ld	s0,32(sp)
     228:	6145                	addi	sp,sp,48
     22a:	8082                	ret

000000000000022c <testcall>:

void
testcall() {
     22c:	1101                	addi	sp,sp,-32
     22e:	ec06                	sd	ra,24(sp)
     230:	e822                	sd	s0,16(sp)
     232:	1000                	addi	s0,sp,32
  struct sysinfo info;
  
  if (sysinfo(&info) < 0) {
     234:	fe040793          	addi	a5,s0,-32
     238:	853e                	mv	a0,a5
     23a:	00000097          	auipc	ra,0x0
     23e:	7ac080e7          	jalr	1964(ra) # 9e6 <sysinfo>
     242:	87aa                	mv	a5,a0
     244:	0007df63          	bgez	a5,262 <testcall+0x36>
    printf("FAIL: sysinfo failed\n");
     248:	00001517          	auipc	a0,0x1
     24c:	ff850513          	addi	a0,a0,-8 # 1240 <malloc+0x1d8>
     250:	00001097          	auipc	ra,0x1
     254:	c26080e7          	jalr	-986(ra) # e76 <printf>
    exit(1);
     258:	4505                	li	a0,1
     25a:	00000097          	auipc	ra,0x0
     25e:	6e4080e7          	jalr	1764(ra) # 93e <exit>
  }

  if (sysinfo((struct sysinfo *) 0xeaeb0b5b00002f5e) !=  0xffffffffffffffff) {
     262:	00001797          	auipc	a5,0x1
     266:	0ce78793          	addi	a5,a5,206 # 1330 <malloc+0x2c8>
     26a:	639c                	ld	a5,0(a5)
     26c:	853e                	mv	a0,a5
     26e:	00000097          	auipc	ra,0x0
     272:	778080e7          	jalr	1912(ra) # 9e6 <sysinfo>
     276:	87aa                	mv	a5,a0
     278:	873e                	mv	a4,a5
     27a:	57fd                	li	a5,-1
     27c:	00f70f63          	beq	a4,a5,29a <testcall+0x6e>
    printf("FAIL: sysinfo succeeded with bad argument\n");
     280:	00001517          	auipc	a0,0x1
     284:	fd850513          	addi	a0,a0,-40 # 1258 <malloc+0x1f0>
     288:	00001097          	auipc	ra,0x1
     28c:	bee080e7          	jalr	-1042(ra) # e76 <printf>
    exit(1);
     290:	4505                	li	a0,1
     292:	00000097          	auipc	ra,0x0
     296:	6ac080e7          	jalr	1708(ra) # 93e <exit>
  }
}
     29a:	0001                	nop
     29c:	60e2                	ld	ra,24(sp)
     29e:	6442                	ld	s0,16(sp)
     2a0:	6105                	addi	sp,sp,32
     2a2:	8082                	ret

00000000000002a4 <testproc>:

void testproc() {
     2a4:	7139                	addi	sp,sp,-64
     2a6:	fc06                	sd	ra,56(sp)
     2a8:	f822                	sd	s0,48(sp)
     2aa:	0080                	addi	s0,sp,64
  struct sysinfo info;
  uint64 nproc;
  int status;
  int pid;
  
  sinfo(&info);
     2ac:	fd040793          	addi	a5,s0,-48
     2b0:	853e                	mv	a0,a5
     2b2:	00000097          	auipc	ra,0x0
     2b6:	d4e080e7          	jalr	-690(ra) # 0 <sinfo>
  nproc = info.nproc;
     2ba:	fd843783          	ld	a5,-40(s0)
     2be:	fef43423          	sd	a5,-24(s0)

  pid = fork();
     2c2:	00000097          	auipc	ra,0x0
     2c6:	674080e7          	jalr	1652(ra) # 936 <fork>
     2ca:	87aa                	mv	a5,a0
     2cc:	fef42223          	sw	a5,-28(s0)
  if(pid < 0){
     2d0:	fe442783          	lw	a5,-28(s0)
     2d4:	2781                	sext.w	a5,a5
     2d6:	0007df63          	bgez	a5,2f4 <testproc+0x50>
    printf("sysinfotest: fork failed\n");
     2da:	00001517          	auipc	a0,0x1
     2de:	fae50513          	addi	a0,a0,-82 # 1288 <malloc+0x220>
     2e2:	00001097          	auipc	ra,0x1
     2e6:	b94080e7          	jalr	-1132(ra) # e76 <printf>
    exit(1);
     2ea:	4505                	li	a0,1
     2ec:	00000097          	auipc	ra,0x0
     2f0:	652080e7          	jalr	1618(ra) # 93e <exit>
  }
  if(pid == 0){
     2f4:	fe442783          	lw	a5,-28(s0)
     2f8:	2781                	sext.w	a5,a5
     2fa:	eba1                	bnez	a5,34a <testproc+0xa6>
    sinfo(&info);
     2fc:	fd040793          	addi	a5,s0,-48
     300:	853e                	mv	a0,a5
     302:	00000097          	auipc	ra,0x0
     306:	cfe080e7          	jalr	-770(ra) # 0 <sinfo>
    if(info.nproc != nproc+1) {
     30a:	fd843703          	ld	a4,-40(s0)
     30e:	fe843783          	ld	a5,-24(s0)
     312:	0785                	addi	a5,a5,1
     314:	02f70663          	beq	a4,a5,340 <testproc+0x9c>
      printf("sysinfotest: FAIL nproc is %d instead of %d\n", info.nproc, nproc+1);
     318:	fd843703          	ld	a4,-40(s0)
     31c:	fe843783          	ld	a5,-24(s0)
     320:	0785                	addi	a5,a5,1
     322:	863e                	mv	a2,a5
     324:	85ba                	mv	a1,a4
     326:	00001517          	auipc	a0,0x1
     32a:	f8250513          	addi	a0,a0,-126 # 12a8 <malloc+0x240>
     32e:	00001097          	auipc	ra,0x1
     332:	b48080e7          	jalr	-1208(ra) # e76 <printf>
      exit(1);
     336:	4505                	li	a0,1
     338:	00000097          	auipc	ra,0x0
     33c:	606080e7          	jalr	1542(ra) # 93e <exit>
    }
    exit(0);
     340:	4501                	li	a0,0
     342:	00000097          	auipc	ra,0x0
     346:	5fc080e7          	jalr	1532(ra) # 93e <exit>
  }
  wait(&status);
     34a:	fcc40793          	addi	a5,s0,-52
     34e:	853e                	mv	a0,a5
     350:	00000097          	auipc	ra,0x0
     354:	5f6080e7          	jalr	1526(ra) # 946 <wait>
  sinfo(&info);
     358:	fd040793          	addi	a5,s0,-48
     35c:	853e                	mv	a0,a5
     35e:	00000097          	auipc	ra,0x0
     362:	ca2080e7          	jalr	-862(ra) # 0 <sinfo>
  if(info.nproc != nproc) {
     366:	fd843783          	ld	a5,-40(s0)
     36a:	fe843703          	ld	a4,-24(s0)
     36e:	02f70463          	beq	a4,a5,396 <testproc+0xf2>
      printf("sysinfotest: FAIL nproc is %d instead of %d\n", info.nproc, nproc);
     372:	fd843783          	ld	a5,-40(s0)
     376:	fe843603          	ld	a2,-24(s0)
     37a:	85be                	mv	a1,a5
     37c:	00001517          	auipc	a0,0x1
     380:	f2c50513          	addi	a0,a0,-212 # 12a8 <malloc+0x240>
     384:	00001097          	auipc	ra,0x1
     388:	af2080e7          	jalr	-1294(ra) # e76 <printf>
      exit(1);
     38c:	4505                	li	a0,1
     38e:	00000097          	auipc	ra,0x0
     392:	5b0080e7          	jalr	1456(ra) # 93e <exit>
  }
}
     396:	0001                	nop
     398:	70e2                	ld	ra,56(sp)
     39a:	7442                	ld	s0,48(sp)
     39c:	6121                	addi	sp,sp,64
     39e:	8082                	ret

00000000000003a0 <testbad>:

void testbad() {
     3a0:	1101                	addi	sp,sp,-32
     3a2:	ec06                	sd	ra,24(sp)
     3a4:	e822                	sd	s0,16(sp)
     3a6:	1000                	addi	s0,sp,32
  int pid = fork();
     3a8:	00000097          	auipc	ra,0x0
     3ac:	58e080e7          	jalr	1422(ra) # 936 <fork>
     3b0:	87aa                	mv	a5,a0
     3b2:	fef42623          	sw	a5,-20(s0)
  int xstatus;
  
  if(pid < 0){
     3b6:	fec42783          	lw	a5,-20(s0)
     3ba:	2781                	sext.w	a5,a5
     3bc:	0007df63          	bgez	a5,3da <testbad+0x3a>
    printf("sysinfotest: fork failed\n");
     3c0:	00001517          	auipc	a0,0x1
     3c4:	ec850513          	addi	a0,a0,-312 # 1288 <malloc+0x220>
     3c8:	00001097          	auipc	ra,0x1
     3cc:	aae080e7          	jalr	-1362(ra) # e76 <printf>
    exit(1);
     3d0:	4505                	li	a0,1
     3d2:	00000097          	auipc	ra,0x0
     3d6:	56c080e7          	jalr	1388(ra) # 93e <exit>
  }
  if(pid == 0){
     3da:	fec42783          	lw	a5,-20(s0)
     3de:	2781                	sext.w	a5,a5
     3e0:	eb99                	bnez	a5,3f6 <testbad+0x56>
      sinfo(0x0);
     3e2:	4501                	li	a0,0
     3e4:	00000097          	auipc	ra,0x0
     3e8:	c1c080e7          	jalr	-996(ra) # 0 <sinfo>
      exit(0);
     3ec:	4501                	li	a0,0
     3ee:	00000097          	auipc	ra,0x0
     3f2:	550080e7          	jalr	1360(ra) # 93e <exit>
  }
  wait(&xstatus);
     3f6:	fe840793          	addi	a5,s0,-24
     3fa:	853e                	mv	a0,a5
     3fc:	00000097          	auipc	ra,0x0
     400:	54a080e7          	jalr	1354(ra) # 946 <wait>
  if(xstatus == -1)  // kernel killed child?
     404:	fe842783          	lw	a5,-24(s0)
     408:	873e                	mv	a4,a5
     40a:	57fd                	li	a5,-1
     40c:	00f71763          	bne	a4,a5,41a <testbad+0x7a>
    exit(0);
     410:	4501                	li	a0,0
     412:	00000097          	auipc	ra,0x0
     416:	52c080e7          	jalr	1324(ra) # 93e <exit>
  else {
    printf("sysinfotest: testbad succeeded %d\n", xstatus);
     41a:	fe842783          	lw	a5,-24(s0)
     41e:	85be                	mv	a1,a5
     420:	00001517          	auipc	a0,0x1
     424:	eb850513          	addi	a0,a0,-328 # 12d8 <malloc+0x270>
     428:	00001097          	auipc	ra,0x1
     42c:	a4e080e7          	jalr	-1458(ra) # e76 <printf>
    exit(xstatus);
     430:	fe842783          	lw	a5,-24(s0)
     434:	853e                	mv	a0,a5
     436:	00000097          	auipc	ra,0x0
     43a:	508080e7          	jalr	1288(ra) # 93e <exit>

000000000000043e <main>:
  }
}

int
main(int argc, char *argv[])
{
     43e:	1101                	addi	sp,sp,-32
     440:	ec06                	sd	ra,24(sp)
     442:	e822                	sd	s0,16(sp)
     444:	1000                	addi	s0,sp,32
     446:	87aa                	mv	a5,a0
     448:	feb43023          	sd	a1,-32(s0)
     44c:	fef42623          	sw	a5,-20(s0)
  printf("sysinfotest: start\n");
     450:	00001517          	auipc	a0,0x1
     454:	eb050513          	addi	a0,a0,-336 # 1300 <malloc+0x298>
     458:	00001097          	auipc	ra,0x1
     45c:	a1e080e7          	jalr	-1506(ra) # e76 <printf>
  testcall();
     460:	00000097          	auipc	ra,0x0
     464:	dcc080e7          	jalr	-564(ra) # 22c <testcall>
  testmem();
     468:	00000097          	auipc	ra,0x0
     46c:	c88080e7          	jalr	-888(ra) # f0 <testmem>
  testproc();
     470:	00000097          	auipc	ra,0x0
     474:	e34080e7          	jalr	-460(ra) # 2a4 <testproc>
  printf("sysinfotest: OK\n");
     478:	00001517          	auipc	a0,0x1
     47c:	ea050513          	addi	a0,a0,-352 # 1318 <malloc+0x2b0>
     480:	00001097          	auipc	ra,0x1
     484:	9f6080e7          	jalr	-1546(ra) # e76 <printf>
  exit(0);
     488:	4501                	li	a0,0
     48a:	00000097          	auipc	ra,0x0
     48e:	4b4080e7          	jalr	1204(ra) # 93e <exit>

0000000000000492 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
     492:	1141                	addi	sp,sp,-16
     494:	e406                	sd	ra,8(sp)
     496:	e022                	sd	s0,0(sp)
     498:	0800                	addi	s0,sp,16
  extern int main();
  main();
     49a:	00000097          	auipc	ra,0x0
     49e:	fa4080e7          	jalr	-92(ra) # 43e <main>
  exit(0);
     4a2:	4501                	li	a0,0
     4a4:	00000097          	auipc	ra,0x0
     4a8:	49a080e7          	jalr	1178(ra) # 93e <exit>

00000000000004ac <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
     4ac:	7179                	addi	sp,sp,-48
     4ae:	f422                	sd	s0,40(sp)
     4b0:	1800                	addi	s0,sp,48
     4b2:	fca43c23          	sd	a0,-40(s0)
     4b6:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
     4ba:	fd843783          	ld	a5,-40(s0)
     4be:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     4c2:	0001                	nop
     4c4:	fd043703          	ld	a4,-48(s0)
     4c8:	00170793          	addi	a5,a4,1
     4cc:	fcf43823          	sd	a5,-48(s0)
     4d0:	fd843783          	ld	a5,-40(s0)
     4d4:	00178693          	addi	a3,a5,1
     4d8:	fcd43c23          	sd	a3,-40(s0)
     4dc:	00074703          	lbu	a4,0(a4)
     4e0:	00e78023          	sb	a4,0(a5)
     4e4:	0007c783          	lbu	a5,0(a5)
     4e8:	fff1                	bnez	a5,4c4 <strcpy+0x18>
    ;
  return os;
     4ea:	fe843783          	ld	a5,-24(s0)
}
     4ee:	853e                	mv	a0,a5
     4f0:	7422                	ld	s0,40(sp)
     4f2:	6145                	addi	sp,sp,48
     4f4:	8082                	ret

00000000000004f6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     4f6:	1101                	addi	sp,sp,-32
     4f8:	ec22                	sd	s0,24(sp)
     4fa:	1000                	addi	s0,sp,32
     4fc:	fea43423          	sd	a0,-24(s0)
     500:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     504:	a819                	j	51a <strcmp+0x24>
    p++, q++;
     506:	fe843783          	ld	a5,-24(s0)
     50a:	0785                	addi	a5,a5,1
     50c:	fef43423          	sd	a5,-24(s0)
     510:	fe043783          	ld	a5,-32(s0)
     514:	0785                	addi	a5,a5,1
     516:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     51a:	fe843783          	ld	a5,-24(s0)
     51e:	0007c783          	lbu	a5,0(a5)
     522:	cb99                	beqz	a5,538 <strcmp+0x42>
     524:	fe843783          	ld	a5,-24(s0)
     528:	0007c703          	lbu	a4,0(a5)
     52c:	fe043783          	ld	a5,-32(s0)
     530:	0007c783          	lbu	a5,0(a5)
     534:	fcf709e3          	beq	a4,a5,506 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
     538:	fe843783          	ld	a5,-24(s0)
     53c:	0007c783          	lbu	a5,0(a5)
     540:	0007871b          	sext.w	a4,a5
     544:	fe043783          	ld	a5,-32(s0)
     548:	0007c783          	lbu	a5,0(a5)
     54c:	2781                	sext.w	a5,a5
     54e:	40f707bb          	subw	a5,a4,a5
     552:	2781                	sext.w	a5,a5
}
     554:	853e                	mv	a0,a5
     556:	6462                	ld	s0,24(sp)
     558:	6105                	addi	sp,sp,32
     55a:	8082                	ret

000000000000055c <strlen>:

uint
strlen(const char *s)
{
     55c:	7179                	addi	sp,sp,-48
     55e:	f422                	sd	s0,40(sp)
     560:	1800                	addi	s0,sp,48
     562:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     566:	fe042623          	sw	zero,-20(s0)
     56a:	a031                	j	576 <strlen+0x1a>
     56c:	fec42783          	lw	a5,-20(s0)
     570:	2785                	addiw	a5,a5,1
     572:	fef42623          	sw	a5,-20(s0)
     576:	fec42783          	lw	a5,-20(s0)
     57a:	fd843703          	ld	a4,-40(s0)
     57e:	97ba                	add	a5,a5,a4
     580:	0007c783          	lbu	a5,0(a5)
     584:	f7e5                	bnez	a5,56c <strlen+0x10>
    ;
  return n;
     586:	fec42783          	lw	a5,-20(s0)
}
     58a:	853e                	mv	a0,a5
     58c:	7422                	ld	s0,40(sp)
     58e:	6145                	addi	sp,sp,48
     590:	8082                	ret

0000000000000592 <memset>:

void*
memset(void *dst, int c, uint n)
{
     592:	7179                	addi	sp,sp,-48
     594:	f422                	sd	s0,40(sp)
     596:	1800                	addi	s0,sp,48
     598:	fca43c23          	sd	a0,-40(s0)
     59c:	87ae                	mv	a5,a1
     59e:	8732                	mv	a4,a2
     5a0:	fcf42a23          	sw	a5,-44(s0)
     5a4:	87ba                	mv	a5,a4
     5a6:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     5aa:	fd843783          	ld	a5,-40(s0)
     5ae:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     5b2:	fe042623          	sw	zero,-20(s0)
     5b6:	a00d                	j	5d8 <memset+0x46>
    cdst[i] = c;
     5b8:	fec42783          	lw	a5,-20(s0)
     5bc:	fe043703          	ld	a4,-32(s0)
     5c0:	97ba                	add	a5,a5,a4
     5c2:	fd442703          	lw	a4,-44(s0)
     5c6:	0ff77713          	zext.b	a4,a4
     5ca:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     5ce:	fec42783          	lw	a5,-20(s0)
     5d2:	2785                	addiw	a5,a5,1
     5d4:	fef42623          	sw	a5,-20(s0)
     5d8:	fec42703          	lw	a4,-20(s0)
     5dc:	fd042783          	lw	a5,-48(s0)
     5e0:	2781                	sext.w	a5,a5
     5e2:	fcf76be3          	bltu	a4,a5,5b8 <memset+0x26>
  }
  return dst;
     5e6:	fd843783          	ld	a5,-40(s0)
}
     5ea:	853e                	mv	a0,a5
     5ec:	7422                	ld	s0,40(sp)
     5ee:	6145                	addi	sp,sp,48
     5f0:	8082                	ret

00000000000005f2 <strchr>:

char*
strchr(const char *s, char c)
{
     5f2:	1101                	addi	sp,sp,-32
     5f4:	ec22                	sd	s0,24(sp)
     5f6:	1000                	addi	s0,sp,32
     5f8:	fea43423          	sd	a0,-24(s0)
     5fc:	87ae                	mv	a5,a1
     5fe:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     602:	a01d                	j	628 <strchr+0x36>
    if(*s == c)
     604:	fe843783          	ld	a5,-24(s0)
     608:	0007c703          	lbu	a4,0(a5)
     60c:	fe744783          	lbu	a5,-25(s0)
     610:	0ff7f793          	zext.b	a5,a5
     614:	00e79563          	bne	a5,a4,61e <strchr+0x2c>
      return (char*)s;
     618:	fe843783          	ld	a5,-24(s0)
     61c:	a821                	j	634 <strchr+0x42>
  for(; *s; s++)
     61e:	fe843783          	ld	a5,-24(s0)
     622:	0785                	addi	a5,a5,1
     624:	fef43423          	sd	a5,-24(s0)
     628:	fe843783          	ld	a5,-24(s0)
     62c:	0007c783          	lbu	a5,0(a5)
     630:	fbf1                	bnez	a5,604 <strchr+0x12>
  return 0;
     632:	4781                	li	a5,0
}
     634:	853e                	mv	a0,a5
     636:	6462                	ld	s0,24(sp)
     638:	6105                	addi	sp,sp,32
     63a:	8082                	ret

000000000000063c <gets>:

char*
gets(char *buf, int max)
{
     63c:	7179                	addi	sp,sp,-48
     63e:	f406                	sd	ra,40(sp)
     640:	f022                	sd	s0,32(sp)
     642:	1800                	addi	s0,sp,48
     644:	fca43c23          	sd	a0,-40(s0)
     648:	87ae                	mv	a5,a1
     64a:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     64e:	fe042623          	sw	zero,-20(s0)
     652:	a8a1                	j	6aa <gets+0x6e>
    cc = read(0, &c, 1);
     654:	fe740793          	addi	a5,s0,-25
     658:	4605                	li	a2,1
     65a:	85be                	mv	a1,a5
     65c:	4501                	li	a0,0
     65e:	00000097          	auipc	ra,0x0
     662:	2f8080e7          	jalr	760(ra) # 956 <read>
     666:	87aa                	mv	a5,a0
     668:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     66c:	fe842783          	lw	a5,-24(s0)
     670:	2781                	sext.w	a5,a5
     672:	04f05763          	blez	a5,6c0 <gets+0x84>
      break;
    buf[i++] = c;
     676:	fec42783          	lw	a5,-20(s0)
     67a:	0017871b          	addiw	a4,a5,1
     67e:	fee42623          	sw	a4,-20(s0)
     682:	873e                	mv	a4,a5
     684:	fd843783          	ld	a5,-40(s0)
     688:	97ba                	add	a5,a5,a4
     68a:	fe744703          	lbu	a4,-25(s0)
     68e:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     692:	fe744783          	lbu	a5,-25(s0)
     696:	873e                	mv	a4,a5
     698:	47a9                	li	a5,10
     69a:	02f70463          	beq	a4,a5,6c2 <gets+0x86>
     69e:	fe744783          	lbu	a5,-25(s0)
     6a2:	873e                	mv	a4,a5
     6a4:	47b5                	li	a5,13
     6a6:	00f70e63          	beq	a4,a5,6c2 <gets+0x86>
  for(i=0; i+1 < max; ){
     6aa:	fec42783          	lw	a5,-20(s0)
     6ae:	2785                	addiw	a5,a5,1
     6b0:	0007871b          	sext.w	a4,a5
     6b4:	fd442783          	lw	a5,-44(s0)
     6b8:	2781                	sext.w	a5,a5
     6ba:	f8f74de3          	blt	a4,a5,654 <gets+0x18>
     6be:	a011                	j	6c2 <gets+0x86>
      break;
     6c0:	0001                	nop
      break;
  }
  buf[i] = '\0';
     6c2:	fec42783          	lw	a5,-20(s0)
     6c6:	fd843703          	ld	a4,-40(s0)
     6ca:	97ba                	add	a5,a5,a4
     6cc:	00078023          	sb	zero,0(a5)
  return buf;
     6d0:	fd843783          	ld	a5,-40(s0)
}
     6d4:	853e                	mv	a0,a5
     6d6:	70a2                	ld	ra,40(sp)
     6d8:	7402                	ld	s0,32(sp)
     6da:	6145                	addi	sp,sp,48
     6dc:	8082                	ret

00000000000006de <stat>:

int
stat(const char *n, struct stat *st)
{
     6de:	7179                	addi	sp,sp,-48
     6e0:	f406                	sd	ra,40(sp)
     6e2:	f022                	sd	s0,32(sp)
     6e4:	1800                	addi	s0,sp,48
     6e6:	fca43c23          	sd	a0,-40(s0)
     6ea:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     6ee:	4581                	li	a1,0
     6f0:	fd843503          	ld	a0,-40(s0)
     6f4:	00000097          	auipc	ra,0x0
     6f8:	28a080e7          	jalr	650(ra) # 97e <open>
     6fc:	87aa                	mv	a5,a0
     6fe:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     702:	fec42783          	lw	a5,-20(s0)
     706:	2781                	sext.w	a5,a5
     708:	0007d463          	bgez	a5,710 <stat+0x32>
    return -1;
     70c:	57fd                	li	a5,-1
     70e:	a035                	j	73a <stat+0x5c>
  r = fstat(fd, st);
     710:	fec42783          	lw	a5,-20(s0)
     714:	fd043583          	ld	a1,-48(s0)
     718:	853e                	mv	a0,a5
     71a:	00000097          	auipc	ra,0x0
     71e:	27c080e7          	jalr	636(ra) # 996 <fstat>
     722:	87aa                	mv	a5,a0
     724:	fef42423          	sw	a5,-24(s0)
  close(fd);
     728:	fec42783          	lw	a5,-20(s0)
     72c:	853e                	mv	a0,a5
     72e:	00000097          	auipc	ra,0x0
     732:	238080e7          	jalr	568(ra) # 966 <close>
  return r;
     736:	fe842783          	lw	a5,-24(s0)
}
     73a:	853e                	mv	a0,a5
     73c:	70a2                	ld	ra,40(sp)
     73e:	7402                	ld	s0,32(sp)
     740:	6145                	addi	sp,sp,48
     742:	8082                	ret

0000000000000744 <atoi>:

int
atoi(const char *s)
{
     744:	7179                	addi	sp,sp,-48
     746:	f422                	sd	s0,40(sp)
     748:	1800                	addi	s0,sp,48
     74a:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     74e:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     752:	a81d                	j	788 <atoi+0x44>
    n = n*10 + *s++ - '0';
     754:	fec42783          	lw	a5,-20(s0)
     758:	873e                	mv	a4,a5
     75a:	87ba                	mv	a5,a4
     75c:	0027979b          	slliw	a5,a5,0x2
     760:	9fb9                	addw	a5,a5,a4
     762:	0017979b          	slliw	a5,a5,0x1
     766:	0007871b          	sext.w	a4,a5
     76a:	fd843783          	ld	a5,-40(s0)
     76e:	00178693          	addi	a3,a5,1
     772:	fcd43c23          	sd	a3,-40(s0)
     776:	0007c783          	lbu	a5,0(a5)
     77a:	2781                	sext.w	a5,a5
     77c:	9fb9                	addw	a5,a5,a4
     77e:	2781                	sext.w	a5,a5
     780:	fd07879b          	addiw	a5,a5,-48
     784:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     788:	fd843783          	ld	a5,-40(s0)
     78c:	0007c783          	lbu	a5,0(a5)
     790:	873e                	mv	a4,a5
     792:	02f00793          	li	a5,47
     796:	00e7fb63          	bgeu	a5,a4,7ac <atoi+0x68>
     79a:	fd843783          	ld	a5,-40(s0)
     79e:	0007c783          	lbu	a5,0(a5)
     7a2:	873e                	mv	a4,a5
     7a4:	03900793          	li	a5,57
     7a8:	fae7f6e3          	bgeu	a5,a4,754 <atoi+0x10>
  return n;
     7ac:	fec42783          	lw	a5,-20(s0)
}
     7b0:	853e                	mv	a0,a5
     7b2:	7422                	ld	s0,40(sp)
     7b4:	6145                	addi	sp,sp,48
     7b6:	8082                	ret

00000000000007b8 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     7b8:	7139                	addi	sp,sp,-64
     7ba:	fc22                	sd	s0,56(sp)
     7bc:	0080                	addi	s0,sp,64
     7be:	fca43c23          	sd	a0,-40(s0)
     7c2:	fcb43823          	sd	a1,-48(s0)
     7c6:	87b2                	mv	a5,a2
     7c8:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     7cc:	fd843783          	ld	a5,-40(s0)
     7d0:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     7d4:	fd043783          	ld	a5,-48(s0)
     7d8:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     7dc:	fe043703          	ld	a4,-32(s0)
     7e0:	fe843783          	ld	a5,-24(s0)
     7e4:	02e7fc63          	bgeu	a5,a4,81c <memmove+0x64>
    while(n-- > 0)
     7e8:	a00d                	j	80a <memmove+0x52>
      *dst++ = *src++;
     7ea:	fe043703          	ld	a4,-32(s0)
     7ee:	00170793          	addi	a5,a4,1
     7f2:	fef43023          	sd	a5,-32(s0)
     7f6:	fe843783          	ld	a5,-24(s0)
     7fa:	00178693          	addi	a3,a5,1
     7fe:	fed43423          	sd	a3,-24(s0)
     802:	00074703          	lbu	a4,0(a4)
     806:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     80a:	fcc42783          	lw	a5,-52(s0)
     80e:	fff7871b          	addiw	a4,a5,-1
     812:	fce42623          	sw	a4,-52(s0)
     816:	fcf04ae3          	bgtz	a5,7ea <memmove+0x32>
     81a:	a891                	j	86e <memmove+0xb6>
  } else {
    dst += n;
     81c:	fcc42783          	lw	a5,-52(s0)
     820:	fe843703          	ld	a4,-24(s0)
     824:	97ba                	add	a5,a5,a4
     826:	fef43423          	sd	a5,-24(s0)
    src += n;
     82a:	fcc42783          	lw	a5,-52(s0)
     82e:	fe043703          	ld	a4,-32(s0)
     832:	97ba                	add	a5,a5,a4
     834:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     838:	a01d                	j	85e <memmove+0xa6>
      *--dst = *--src;
     83a:	fe043783          	ld	a5,-32(s0)
     83e:	17fd                	addi	a5,a5,-1
     840:	fef43023          	sd	a5,-32(s0)
     844:	fe843783          	ld	a5,-24(s0)
     848:	17fd                	addi	a5,a5,-1
     84a:	fef43423          	sd	a5,-24(s0)
     84e:	fe043783          	ld	a5,-32(s0)
     852:	0007c703          	lbu	a4,0(a5)
     856:	fe843783          	ld	a5,-24(s0)
     85a:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     85e:	fcc42783          	lw	a5,-52(s0)
     862:	fff7871b          	addiw	a4,a5,-1
     866:	fce42623          	sw	a4,-52(s0)
     86a:	fcf048e3          	bgtz	a5,83a <memmove+0x82>
  }
  return vdst;
     86e:	fd843783          	ld	a5,-40(s0)
}
     872:	853e                	mv	a0,a5
     874:	7462                	ld	s0,56(sp)
     876:	6121                	addi	sp,sp,64
     878:	8082                	ret

000000000000087a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     87a:	7139                	addi	sp,sp,-64
     87c:	fc22                	sd	s0,56(sp)
     87e:	0080                	addi	s0,sp,64
     880:	fca43c23          	sd	a0,-40(s0)
     884:	fcb43823          	sd	a1,-48(s0)
     888:	87b2                	mv	a5,a2
     88a:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     88e:	fd843783          	ld	a5,-40(s0)
     892:	fef43423          	sd	a5,-24(s0)
     896:	fd043783          	ld	a5,-48(s0)
     89a:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     89e:	a0a1                	j	8e6 <memcmp+0x6c>
    if (*p1 != *p2) {
     8a0:	fe843783          	ld	a5,-24(s0)
     8a4:	0007c703          	lbu	a4,0(a5)
     8a8:	fe043783          	ld	a5,-32(s0)
     8ac:	0007c783          	lbu	a5,0(a5)
     8b0:	02f70163          	beq	a4,a5,8d2 <memcmp+0x58>
      return *p1 - *p2;
     8b4:	fe843783          	ld	a5,-24(s0)
     8b8:	0007c783          	lbu	a5,0(a5)
     8bc:	0007871b          	sext.w	a4,a5
     8c0:	fe043783          	ld	a5,-32(s0)
     8c4:	0007c783          	lbu	a5,0(a5)
     8c8:	2781                	sext.w	a5,a5
     8ca:	40f707bb          	subw	a5,a4,a5
     8ce:	2781                	sext.w	a5,a5
     8d0:	a01d                	j	8f6 <memcmp+0x7c>
    }
    p1++;
     8d2:	fe843783          	ld	a5,-24(s0)
     8d6:	0785                	addi	a5,a5,1
     8d8:	fef43423          	sd	a5,-24(s0)
    p2++;
     8dc:	fe043783          	ld	a5,-32(s0)
     8e0:	0785                	addi	a5,a5,1
     8e2:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     8e6:	fcc42783          	lw	a5,-52(s0)
     8ea:	fff7871b          	addiw	a4,a5,-1
     8ee:	fce42623          	sw	a4,-52(s0)
     8f2:	f7dd                	bnez	a5,8a0 <memcmp+0x26>
  }
  return 0;
     8f4:	4781                	li	a5,0
}
     8f6:	853e                	mv	a0,a5
     8f8:	7462                	ld	s0,56(sp)
     8fa:	6121                	addi	sp,sp,64
     8fc:	8082                	ret

00000000000008fe <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     8fe:	7179                	addi	sp,sp,-48
     900:	f406                	sd	ra,40(sp)
     902:	f022                	sd	s0,32(sp)
     904:	1800                	addi	s0,sp,48
     906:	fea43423          	sd	a0,-24(s0)
     90a:	feb43023          	sd	a1,-32(s0)
     90e:	87b2                	mv	a5,a2
     910:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     914:	fdc42783          	lw	a5,-36(s0)
     918:	863e                	mv	a2,a5
     91a:	fe043583          	ld	a1,-32(s0)
     91e:	fe843503          	ld	a0,-24(s0)
     922:	00000097          	auipc	ra,0x0
     926:	e96080e7          	jalr	-362(ra) # 7b8 <memmove>
     92a:	87aa                	mv	a5,a0
}
     92c:	853e                	mv	a0,a5
     92e:	70a2                	ld	ra,40(sp)
     930:	7402                	ld	s0,32(sp)
     932:	6145                	addi	sp,sp,48
     934:	8082                	ret

0000000000000936 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     936:	4885                	li	a7,1
 ecall
     938:	00000073          	ecall
 ret
     93c:	8082                	ret

000000000000093e <exit>:
.global exit
exit:
 li a7, SYS_exit
     93e:	4889                	li	a7,2
 ecall
     940:	00000073          	ecall
 ret
     944:	8082                	ret

0000000000000946 <wait>:
.global wait
wait:
 li a7, SYS_wait
     946:	488d                	li	a7,3
 ecall
     948:	00000073          	ecall
 ret
     94c:	8082                	ret

000000000000094e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     94e:	4891                	li	a7,4
 ecall
     950:	00000073          	ecall
 ret
     954:	8082                	ret

0000000000000956 <read>:
.global read
read:
 li a7, SYS_read
     956:	4895                	li	a7,5
 ecall
     958:	00000073          	ecall
 ret
     95c:	8082                	ret

000000000000095e <write>:
.global write
write:
 li a7, SYS_write
     95e:	48c1                	li	a7,16
 ecall
     960:	00000073          	ecall
 ret
     964:	8082                	ret

0000000000000966 <close>:
.global close
close:
 li a7, SYS_close
     966:	48d5                	li	a7,21
 ecall
     968:	00000073          	ecall
 ret
     96c:	8082                	ret

000000000000096e <kill>:
.global kill
kill:
 li a7, SYS_kill
     96e:	4899                	li	a7,6
 ecall
     970:	00000073          	ecall
 ret
     974:	8082                	ret

0000000000000976 <exec>:
.global exec
exec:
 li a7, SYS_exec
     976:	489d                	li	a7,7
 ecall
     978:	00000073          	ecall
 ret
     97c:	8082                	ret

000000000000097e <open>:
.global open
open:
 li a7, SYS_open
     97e:	48bd                	li	a7,15
 ecall
     980:	00000073          	ecall
 ret
     984:	8082                	ret

0000000000000986 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     986:	48c5                	li	a7,17
 ecall
     988:	00000073          	ecall
 ret
     98c:	8082                	ret

000000000000098e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     98e:	48c9                	li	a7,18
 ecall
     990:	00000073          	ecall
 ret
     994:	8082                	ret

0000000000000996 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     996:	48a1                	li	a7,8
 ecall
     998:	00000073          	ecall
 ret
     99c:	8082                	ret

000000000000099e <link>:
.global link
link:
 li a7, SYS_link
     99e:	48cd                	li	a7,19
 ecall
     9a0:	00000073          	ecall
 ret
     9a4:	8082                	ret

00000000000009a6 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     9a6:	48d1                	li	a7,20
 ecall
     9a8:	00000073          	ecall
 ret
     9ac:	8082                	ret

00000000000009ae <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     9ae:	48a5                	li	a7,9
 ecall
     9b0:	00000073          	ecall
 ret
     9b4:	8082                	ret

00000000000009b6 <dup>:
.global dup
dup:
 li a7, SYS_dup
     9b6:	48a9                	li	a7,10
 ecall
     9b8:	00000073          	ecall
 ret
     9bc:	8082                	ret

00000000000009be <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     9be:	48ad                	li	a7,11
 ecall
     9c0:	00000073          	ecall
 ret
     9c4:	8082                	ret

00000000000009c6 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     9c6:	48b1                	li	a7,12
 ecall
     9c8:	00000073          	ecall
 ret
     9cc:	8082                	ret

00000000000009ce <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     9ce:	48b5                	li	a7,13
 ecall
     9d0:	00000073          	ecall
 ret
     9d4:	8082                	ret

00000000000009d6 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     9d6:	48b9                	li	a7,14
 ecall
     9d8:	00000073          	ecall
 ret
     9dc:	8082                	ret

00000000000009de <trace>:
.global trace
trace:
 li a7, SYS_trace
     9de:	48d9                	li	a7,22
 ecall
     9e0:	00000073          	ecall
 ret
     9e4:	8082                	ret

00000000000009e6 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
     9e6:	48dd                	li	a7,23
 ecall
     9e8:	00000073          	ecall
 ret
     9ec:	8082                	ret

00000000000009ee <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     9ee:	1101                	addi	sp,sp,-32
     9f0:	ec06                	sd	ra,24(sp)
     9f2:	e822                	sd	s0,16(sp)
     9f4:	1000                	addi	s0,sp,32
     9f6:	87aa                	mv	a5,a0
     9f8:	872e                	mv	a4,a1
     9fa:	fef42623          	sw	a5,-20(s0)
     9fe:	87ba                	mv	a5,a4
     a00:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     a04:	feb40713          	addi	a4,s0,-21
     a08:	fec42783          	lw	a5,-20(s0)
     a0c:	4605                	li	a2,1
     a0e:	85ba                	mv	a1,a4
     a10:	853e                	mv	a0,a5
     a12:	00000097          	auipc	ra,0x0
     a16:	f4c080e7          	jalr	-180(ra) # 95e <write>
}
     a1a:	0001                	nop
     a1c:	60e2                	ld	ra,24(sp)
     a1e:	6442                	ld	s0,16(sp)
     a20:	6105                	addi	sp,sp,32
     a22:	8082                	ret

0000000000000a24 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     a24:	7139                	addi	sp,sp,-64
     a26:	fc06                	sd	ra,56(sp)
     a28:	f822                	sd	s0,48(sp)
     a2a:	0080                	addi	s0,sp,64
     a2c:	87aa                	mv	a5,a0
     a2e:	8736                	mv	a4,a3
     a30:	fcf42623          	sw	a5,-52(s0)
     a34:	87ae                	mv	a5,a1
     a36:	fcf42423          	sw	a5,-56(s0)
     a3a:	87b2                	mv	a5,a2
     a3c:	fcf42223          	sw	a5,-60(s0)
     a40:	87ba                	mv	a5,a4
     a42:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     a46:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     a4a:	fc042783          	lw	a5,-64(s0)
     a4e:	2781                	sext.w	a5,a5
     a50:	c38d                	beqz	a5,a72 <printint+0x4e>
     a52:	fc842783          	lw	a5,-56(s0)
     a56:	2781                	sext.w	a5,a5
     a58:	0007dd63          	bgez	a5,a72 <printint+0x4e>
    neg = 1;
     a5c:	4785                	li	a5,1
     a5e:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     a62:	fc842783          	lw	a5,-56(s0)
     a66:	40f007bb          	negw	a5,a5
     a6a:	2781                	sext.w	a5,a5
     a6c:	fef42223          	sw	a5,-28(s0)
     a70:	a029                	j	a7a <printint+0x56>
  } else {
    x = xx;
     a72:	fc842783          	lw	a5,-56(s0)
     a76:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
     a7a:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     a7e:	fc442783          	lw	a5,-60(s0)
     a82:	fe442703          	lw	a4,-28(s0)
     a86:	02f777bb          	remuw	a5,a4,a5
     a8a:	0007861b          	sext.w	a2,a5
     a8e:	fec42783          	lw	a5,-20(s0)
     a92:	0017871b          	addiw	a4,a5,1
     a96:	fee42623          	sw	a4,-20(s0)
     a9a:	00001697          	auipc	a3,0x1
     a9e:	56668693          	addi	a3,a3,1382 # 2000 <digits>
     aa2:	02061713          	slli	a4,a2,0x20
     aa6:	9301                	srli	a4,a4,0x20
     aa8:	9736                	add	a4,a4,a3
     aaa:	00074703          	lbu	a4,0(a4)
     aae:	17c1                	addi	a5,a5,-16
     ab0:	97a2                	add	a5,a5,s0
     ab2:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
     ab6:	fc442783          	lw	a5,-60(s0)
     aba:	fe442703          	lw	a4,-28(s0)
     abe:	02f757bb          	divuw	a5,a4,a5
     ac2:	fef42223          	sw	a5,-28(s0)
     ac6:	fe442783          	lw	a5,-28(s0)
     aca:	2781                	sext.w	a5,a5
     acc:	fbcd                	bnez	a5,a7e <printint+0x5a>
  if(neg)
     ace:	fe842783          	lw	a5,-24(s0)
     ad2:	2781                	sext.w	a5,a5
     ad4:	cf85                	beqz	a5,b0c <printint+0xe8>
    buf[i++] = '-';
     ad6:	fec42783          	lw	a5,-20(s0)
     ada:	0017871b          	addiw	a4,a5,1
     ade:	fee42623          	sw	a4,-20(s0)
     ae2:	17c1                	addi	a5,a5,-16
     ae4:	97a2                	add	a5,a5,s0
     ae6:	02d00713          	li	a4,45
     aea:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
     aee:	a839                	j	b0c <printint+0xe8>
    putc(fd, buf[i]);
     af0:	fec42783          	lw	a5,-20(s0)
     af4:	17c1                	addi	a5,a5,-16
     af6:	97a2                	add	a5,a5,s0
     af8:	fe07c703          	lbu	a4,-32(a5)
     afc:	fcc42783          	lw	a5,-52(s0)
     b00:	85ba                	mv	a1,a4
     b02:	853e                	mv	a0,a5
     b04:	00000097          	auipc	ra,0x0
     b08:	eea080e7          	jalr	-278(ra) # 9ee <putc>
  while(--i >= 0)
     b0c:	fec42783          	lw	a5,-20(s0)
     b10:	37fd                	addiw	a5,a5,-1
     b12:	fef42623          	sw	a5,-20(s0)
     b16:	fec42783          	lw	a5,-20(s0)
     b1a:	2781                	sext.w	a5,a5
     b1c:	fc07dae3          	bgez	a5,af0 <printint+0xcc>
}
     b20:	0001                	nop
     b22:	0001                	nop
     b24:	70e2                	ld	ra,56(sp)
     b26:	7442                	ld	s0,48(sp)
     b28:	6121                	addi	sp,sp,64
     b2a:	8082                	ret

0000000000000b2c <printptr>:

static void
printptr(int fd, uint64 x) {
     b2c:	7179                	addi	sp,sp,-48
     b2e:	f406                	sd	ra,40(sp)
     b30:	f022                	sd	s0,32(sp)
     b32:	1800                	addi	s0,sp,48
     b34:	87aa                	mv	a5,a0
     b36:	fcb43823          	sd	a1,-48(s0)
     b3a:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     b3e:	fdc42783          	lw	a5,-36(s0)
     b42:	03000593          	li	a1,48
     b46:	853e                	mv	a0,a5
     b48:	00000097          	auipc	ra,0x0
     b4c:	ea6080e7          	jalr	-346(ra) # 9ee <putc>
  putc(fd, 'x');
     b50:	fdc42783          	lw	a5,-36(s0)
     b54:	07800593          	li	a1,120
     b58:	853e                	mv	a0,a5
     b5a:	00000097          	auipc	ra,0x0
     b5e:	e94080e7          	jalr	-364(ra) # 9ee <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     b62:	fe042623          	sw	zero,-20(s0)
     b66:	a82d                	j	ba0 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     b68:	fd043783          	ld	a5,-48(s0)
     b6c:	93f1                	srli	a5,a5,0x3c
     b6e:	00001717          	auipc	a4,0x1
     b72:	49270713          	addi	a4,a4,1170 # 2000 <digits>
     b76:	97ba                	add	a5,a5,a4
     b78:	0007c703          	lbu	a4,0(a5)
     b7c:	fdc42783          	lw	a5,-36(s0)
     b80:	85ba                	mv	a1,a4
     b82:	853e                	mv	a0,a5
     b84:	00000097          	auipc	ra,0x0
     b88:	e6a080e7          	jalr	-406(ra) # 9ee <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     b8c:	fec42783          	lw	a5,-20(s0)
     b90:	2785                	addiw	a5,a5,1
     b92:	fef42623          	sw	a5,-20(s0)
     b96:	fd043783          	ld	a5,-48(s0)
     b9a:	0792                	slli	a5,a5,0x4
     b9c:	fcf43823          	sd	a5,-48(s0)
     ba0:	fec42783          	lw	a5,-20(s0)
     ba4:	873e                	mv	a4,a5
     ba6:	47bd                	li	a5,15
     ba8:	fce7f0e3          	bgeu	a5,a4,b68 <printptr+0x3c>
}
     bac:	0001                	nop
     bae:	0001                	nop
     bb0:	70a2                	ld	ra,40(sp)
     bb2:	7402                	ld	s0,32(sp)
     bb4:	6145                	addi	sp,sp,48
     bb6:	8082                	ret

0000000000000bb8 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     bb8:	715d                	addi	sp,sp,-80
     bba:	e486                	sd	ra,72(sp)
     bbc:	e0a2                	sd	s0,64(sp)
     bbe:	0880                	addi	s0,sp,80
     bc0:	87aa                	mv	a5,a0
     bc2:	fcb43023          	sd	a1,-64(s0)
     bc6:	fac43c23          	sd	a2,-72(s0)
     bca:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
     bce:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     bd2:	fe042223          	sw	zero,-28(s0)
     bd6:	a42d                	j	e00 <vprintf+0x248>
    c = fmt[i] & 0xff;
     bd8:	fe442783          	lw	a5,-28(s0)
     bdc:	fc043703          	ld	a4,-64(s0)
     be0:	97ba                	add	a5,a5,a4
     be2:	0007c783          	lbu	a5,0(a5)
     be6:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
     bea:	fe042783          	lw	a5,-32(s0)
     bee:	2781                	sext.w	a5,a5
     bf0:	eb9d                	bnez	a5,c26 <vprintf+0x6e>
      if(c == '%'){
     bf2:	fdc42783          	lw	a5,-36(s0)
     bf6:	0007871b          	sext.w	a4,a5
     bfa:	02500793          	li	a5,37
     bfe:	00f71763          	bne	a4,a5,c0c <vprintf+0x54>
        state = '%';
     c02:	02500793          	li	a5,37
     c06:	fef42023          	sw	a5,-32(s0)
     c0a:	a2f5                	j	df6 <vprintf+0x23e>
      } else {
        putc(fd, c);
     c0c:	fdc42783          	lw	a5,-36(s0)
     c10:	0ff7f713          	zext.b	a4,a5
     c14:	fcc42783          	lw	a5,-52(s0)
     c18:	85ba                	mv	a1,a4
     c1a:	853e                	mv	a0,a5
     c1c:	00000097          	auipc	ra,0x0
     c20:	dd2080e7          	jalr	-558(ra) # 9ee <putc>
     c24:	aac9                	j	df6 <vprintf+0x23e>
      }
    } else if(state == '%'){
     c26:	fe042783          	lw	a5,-32(s0)
     c2a:	0007871b          	sext.w	a4,a5
     c2e:	02500793          	li	a5,37
     c32:	1cf71263          	bne	a4,a5,df6 <vprintf+0x23e>
      if(c == 'd'){
     c36:	fdc42783          	lw	a5,-36(s0)
     c3a:	0007871b          	sext.w	a4,a5
     c3e:	06400793          	li	a5,100
     c42:	02f71463          	bne	a4,a5,c6a <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
     c46:	fb843783          	ld	a5,-72(s0)
     c4a:	00878713          	addi	a4,a5,8
     c4e:	fae43c23          	sd	a4,-72(s0)
     c52:	4398                	lw	a4,0(a5)
     c54:	fcc42783          	lw	a5,-52(s0)
     c58:	4685                	li	a3,1
     c5a:	4629                	li	a2,10
     c5c:	85ba                	mv	a1,a4
     c5e:	853e                	mv	a0,a5
     c60:	00000097          	auipc	ra,0x0
     c64:	dc4080e7          	jalr	-572(ra) # a24 <printint>
     c68:	a269                	j	df2 <vprintf+0x23a>
      } else if(c == 'l') {
     c6a:	fdc42783          	lw	a5,-36(s0)
     c6e:	0007871b          	sext.w	a4,a5
     c72:	06c00793          	li	a5,108
     c76:	02f71663          	bne	a4,a5,ca2 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
     c7a:	fb843783          	ld	a5,-72(s0)
     c7e:	00878713          	addi	a4,a5,8
     c82:	fae43c23          	sd	a4,-72(s0)
     c86:	639c                	ld	a5,0(a5)
     c88:	0007871b          	sext.w	a4,a5
     c8c:	fcc42783          	lw	a5,-52(s0)
     c90:	4681                	li	a3,0
     c92:	4629                	li	a2,10
     c94:	85ba                	mv	a1,a4
     c96:	853e                	mv	a0,a5
     c98:	00000097          	auipc	ra,0x0
     c9c:	d8c080e7          	jalr	-628(ra) # a24 <printint>
     ca0:	aa89                	j	df2 <vprintf+0x23a>
      } else if(c == 'x') {
     ca2:	fdc42783          	lw	a5,-36(s0)
     ca6:	0007871b          	sext.w	a4,a5
     caa:	07800793          	li	a5,120
     cae:	02f71463          	bne	a4,a5,cd6 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
     cb2:	fb843783          	ld	a5,-72(s0)
     cb6:	00878713          	addi	a4,a5,8
     cba:	fae43c23          	sd	a4,-72(s0)
     cbe:	4398                	lw	a4,0(a5)
     cc0:	fcc42783          	lw	a5,-52(s0)
     cc4:	4681                	li	a3,0
     cc6:	4641                	li	a2,16
     cc8:	85ba                	mv	a1,a4
     cca:	853e                	mv	a0,a5
     ccc:	00000097          	auipc	ra,0x0
     cd0:	d58080e7          	jalr	-680(ra) # a24 <printint>
     cd4:	aa39                	j	df2 <vprintf+0x23a>
      } else if(c == 'p') {
     cd6:	fdc42783          	lw	a5,-36(s0)
     cda:	0007871b          	sext.w	a4,a5
     cde:	07000793          	li	a5,112
     ce2:	02f71263          	bne	a4,a5,d06 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
     ce6:	fb843783          	ld	a5,-72(s0)
     cea:	00878713          	addi	a4,a5,8
     cee:	fae43c23          	sd	a4,-72(s0)
     cf2:	6398                	ld	a4,0(a5)
     cf4:	fcc42783          	lw	a5,-52(s0)
     cf8:	85ba                	mv	a1,a4
     cfa:	853e                	mv	a0,a5
     cfc:	00000097          	auipc	ra,0x0
     d00:	e30080e7          	jalr	-464(ra) # b2c <printptr>
     d04:	a0fd                	j	df2 <vprintf+0x23a>
      } else if(c == 's'){
     d06:	fdc42783          	lw	a5,-36(s0)
     d0a:	0007871b          	sext.w	a4,a5
     d0e:	07300793          	li	a5,115
     d12:	04f71c63          	bne	a4,a5,d6a <vprintf+0x1b2>
        s = va_arg(ap, char*);
     d16:	fb843783          	ld	a5,-72(s0)
     d1a:	00878713          	addi	a4,a5,8
     d1e:	fae43c23          	sd	a4,-72(s0)
     d22:	639c                	ld	a5,0(a5)
     d24:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
     d28:	fe843783          	ld	a5,-24(s0)
     d2c:	eb8d                	bnez	a5,d5e <vprintf+0x1a6>
          s = "(null)";
     d2e:	00000797          	auipc	a5,0x0
     d32:	60a78793          	addi	a5,a5,1546 # 1338 <malloc+0x2d0>
     d36:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     d3a:	a015                	j	d5e <vprintf+0x1a6>
          putc(fd, *s);
     d3c:	fe843783          	ld	a5,-24(s0)
     d40:	0007c703          	lbu	a4,0(a5)
     d44:	fcc42783          	lw	a5,-52(s0)
     d48:	85ba                	mv	a1,a4
     d4a:	853e                	mv	a0,a5
     d4c:	00000097          	auipc	ra,0x0
     d50:	ca2080e7          	jalr	-862(ra) # 9ee <putc>
          s++;
     d54:	fe843783          	ld	a5,-24(s0)
     d58:	0785                	addi	a5,a5,1
     d5a:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     d5e:	fe843783          	ld	a5,-24(s0)
     d62:	0007c783          	lbu	a5,0(a5)
     d66:	fbf9                	bnez	a5,d3c <vprintf+0x184>
     d68:	a069                	j	df2 <vprintf+0x23a>
        }
      } else if(c == 'c'){
     d6a:	fdc42783          	lw	a5,-36(s0)
     d6e:	0007871b          	sext.w	a4,a5
     d72:	06300793          	li	a5,99
     d76:	02f71463          	bne	a4,a5,d9e <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
     d7a:	fb843783          	ld	a5,-72(s0)
     d7e:	00878713          	addi	a4,a5,8
     d82:	fae43c23          	sd	a4,-72(s0)
     d86:	439c                	lw	a5,0(a5)
     d88:	0ff7f713          	zext.b	a4,a5
     d8c:	fcc42783          	lw	a5,-52(s0)
     d90:	85ba                	mv	a1,a4
     d92:	853e                	mv	a0,a5
     d94:	00000097          	auipc	ra,0x0
     d98:	c5a080e7          	jalr	-934(ra) # 9ee <putc>
     d9c:	a899                	j	df2 <vprintf+0x23a>
      } else if(c == '%'){
     d9e:	fdc42783          	lw	a5,-36(s0)
     da2:	0007871b          	sext.w	a4,a5
     da6:	02500793          	li	a5,37
     daa:	00f71f63          	bne	a4,a5,dc8 <vprintf+0x210>
        putc(fd, c);
     dae:	fdc42783          	lw	a5,-36(s0)
     db2:	0ff7f713          	zext.b	a4,a5
     db6:	fcc42783          	lw	a5,-52(s0)
     dba:	85ba                	mv	a1,a4
     dbc:	853e                	mv	a0,a5
     dbe:	00000097          	auipc	ra,0x0
     dc2:	c30080e7          	jalr	-976(ra) # 9ee <putc>
     dc6:	a035                	j	df2 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     dc8:	fcc42783          	lw	a5,-52(s0)
     dcc:	02500593          	li	a1,37
     dd0:	853e                	mv	a0,a5
     dd2:	00000097          	auipc	ra,0x0
     dd6:	c1c080e7          	jalr	-996(ra) # 9ee <putc>
        putc(fd, c);
     dda:	fdc42783          	lw	a5,-36(s0)
     dde:	0ff7f713          	zext.b	a4,a5
     de2:	fcc42783          	lw	a5,-52(s0)
     de6:	85ba                	mv	a1,a4
     de8:	853e                	mv	a0,a5
     dea:	00000097          	auipc	ra,0x0
     dee:	c04080e7          	jalr	-1020(ra) # 9ee <putc>
      }
      state = 0;
     df2:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     df6:	fe442783          	lw	a5,-28(s0)
     dfa:	2785                	addiw	a5,a5,1
     dfc:	fef42223          	sw	a5,-28(s0)
     e00:	fe442783          	lw	a5,-28(s0)
     e04:	fc043703          	ld	a4,-64(s0)
     e08:	97ba                	add	a5,a5,a4
     e0a:	0007c783          	lbu	a5,0(a5)
     e0e:	dc0795e3          	bnez	a5,bd8 <vprintf+0x20>
    }
  }
}
     e12:	0001                	nop
     e14:	0001                	nop
     e16:	60a6                	ld	ra,72(sp)
     e18:	6406                	ld	s0,64(sp)
     e1a:	6161                	addi	sp,sp,80
     e1c:	8082                	ret

0000000000000e1e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     e1e:	7159                	addi	sp,sp,-112
     e20:	fc06                	sd	ra,56(sp)
     e22:	f822                	sd	s0,48(sp)
     e24:	0080                	addi	s0,sp,64
     e26:	fcb43823          	sd	a1,-48(s0)
     e2a:	e010                	sd	a2,0(s0)
     e2c:	e414                	sd	a3,8(s0)
     e2e:	e818                	sd	a4,16(s0)
     e30:	ec1c                	sd	a5,24(s0)
     e32:	03043023          	sd	a6,32(s0)
     e36:	03143423          	sd	a7,40(s0)
     e3a:	87aa                	mv	a5,a0
     e3c:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     e40:	03040793          	addi	a5,s0,48
     e44:	fcf43423          	sd	a5,-56(s0)
     e48:	fc843783          	ld	a5,-56(s0)
     e4c:	fd078793          	addi	a5,a5,-48
     e50:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     e54:	fe843703          	ld	a4,-24(s0)
     e58:	fdc42783          	lw	a5,-36(s0)
     e5c:	863a                	mv	a2,a4
     e5e:	fd043583          	ld	a1,-48(s0)
     e62:	853e                	mv	a0,a5
     e64:	00000097          	auipc	ra,0x0
     e68:	d54080e7          	jalr	-684(ra) # bb8 <vprintf>
}
     e6c:	0001                	nop
     e6e:	70e2                	ld	ra,56(sp)
     e70:	7442                	ld	s0,48(sp)
     e72:	6165                	addi	sp,sp,112
     e74:	8082                	ret

0000000000000e76 <printf>:

void
printf(const char *fmt, ...)
{
     e76:	7159                	addi	sp,sp,-112
     e78:	f406                	sd	ra,40(sp)
     e7a:	f022                	sd	s0,32(sp)
     e7c:	1800                	addi	s0,sp,48
     e7e:	fca43c23          	sd	a0,-40(s0)
     e82:	e40c                	sd	a1,8(s0)
     e84:	e810                	sd	a2,16(s0)
     e86:	ec14                	sd	a3,24(s0)
     e88:	f018                	sd	a4,32(s0)
     e8a:	f41c                	sd	a5,40(s0)
     e8c:	03043823          	sd	a6,48(s0)
     e90:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     e94:	04040793          	addi	a5,s0,64
     e98:	fcf43823          	sd	a5,-48(s0)
     e9c:	fd043783          	ld	a5,-48(s0)
     ea0:	fc878793          	addi	a5,a5,-56
     ea4:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     ea8:	fe843783          	ld	a5,-24(s0)
     eac:	863e                	mv	a2,a5
     eae:	fd843583          	ld	a1,-40(s0)
     eb2:	4505                	li	a0,1
     eb4:	00000097          	auipc	ra,0x0
     eb8:	d04080e7          	jalr	-764(ra) # bb8 <vprintf>
}
     ebc:	0001                	nop
     ebe:	70a2                	ld	ra,40(sp)
     ec0:	7402                	ld	s0,32(sp)
     ec2:	6165                	addi	sp,sp,112
     ec4:	8082                	ret

0000000000000ec6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     ec6:	7179                	addi	sp,sp,-48
     ec8:	f422                	sd	s0,40(sp)
     eca:	1800                	addi	s0,sp,48
     ecc:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     ed0:	fd843783          	ld	a5,-40(s0)
     ed4:	17c1                	addi	a5,a5,-16
     ed6:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     eda:	00001797          	auipc	a5,0x1
     ede:	15678793          	addi	a5,a5,342 # 2030 <freep>
     ee2:	639c                	ld	a5,0(a5)
     ee4:	fef43423          	sd	a5,-24(s0)
     ee8:	a815                	j	f1c <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     eea:	fe843783          	ld	a5,-24(s0)
     eee:	639c                	ld	a5,0(a5)
     ef0:	fe843703          	ld	a4,-24(s0)
     ef4:	00f76f63          	bltu	a4,a5,f12 <free+0x4c>
     ef8:	fe043703          	ld	a4,-32(s0)
     efc:	fe843783          	ld	a5,-24(s0)
     f00:	02e7eb63          	bltu	a5,a4,f36 <free+0x70>
     f04:	fe843783          	ld	a5,-24(s0)
     f08:	639c                	ld	a5,0(a5)
     f0a:	fe043703          	ld	a4,-32(s0)
     f0e:	02f76463          	bltu	a4,a5,f36 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     f12:	fe843783          	ld	a5,-24(s0)
     f16:	639c                	ld	a5,0(a5)
     f18:	fef43423          	sd	a5,-24(s0)
     f1c:	fe043703          	ld	a4,-32(s0)
     f20:	fe843783          	ld	a5,-24(s0)
     f24:	fce7f3e3          	bgeu	a5,a4,eea <free+0x24>
     f28:	fe843783          	ld	a5,-24(s0)
     f2c:	639c                	ld	a5,0(a5)
     f2e:	fe043703          	ld	a4,-32(s0)
     f32:	faf77ce3          	bgeu	a4,a5,eea <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
     f36:	fe043783          	ld	a5,-32(s0)
     f3a:	479c                	lw	a5,8(a5)
     f3c:	1782                	slli	a5,a5,0x20
     f3e:	9381                	srli	a5,a5,0x20
     f40:	0792                	slli	a5,a5,0x4
     f42:	fe043703          	ld	a4,-32(s0)
     f46:	973e                	add	a4,a4,a5
     f48:	fe843783          	ld	a5,-24(s0)
     f4c:	639c                	ld	a5,0(a5)
     f4e:	02f71763          	bne	a4,a5,f7c <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
     f52:	fe043783          	ld	a5,-32(s0)
     f56:	4798                	lw	a4,8(a5)
     f58:	fe843783          	ld	a5,-24(s0)
     f5c:	639c                	ld	a5,0(a5)
     f5e:	479c                	lw	a5,8(a5)
     f60:	9fb9                	addw	a5,a5,a4
     f62:	0007871b          	sext.w	a4,a5
     f66:	fe043783          	ld	a5,-32(s0)
     f6a:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     f6c:	fe843783          	ld	a5,-24(s0)
     f70:	639c                	ld	a5,0(a5)
     f72:	6398                	ld	a4,0(a5)
     f74:	fe043783          	ld	a5,-32(s0)
     f78:	e398                	sd	a4,0(a5)
     f7a:	a039                	j	f88 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
     f7c:	fe843783          	ld	a5,-24(s0)
     f80:	6398                	ld	a4,0(a5)
     f82:	fe043783          	ld	a5,-32(s0)
     f86:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     f88:	fe843783          	ld	a5,-24(s0)
     f8c:	479c                	lw	a5,8(a5)
     f8e:	1782                	slli	a5,a5,0x20
     f90:	9381                	srli	a5,a5,0x20
     f92:	0792                	slli	a5,a5,0x4
     f94:	fe843703          	ld	a4,-24(s0)
     f98:	97ba                	add	a5,a5,a4
     f9a:	fe043703          	ld	a4,-32(s0)
     f9e:	02f71563          	bne	a4,a5,fc8 <free+0x102>
    p->s.size += bp->s.size;
     fa2:	fe843783          	ld	a5,-24(s0)
     fa6:	4798                	lw	a4,8(a5)
     fa8:	fe043783          	ld	a5,-32(s0)
     fac:	479c                	lw	a5,8(a5)
     fae:	9fb9                	addw	a5,a5,a4
     fb0:	0007871b          	sext.w	a4,a5
     fb4:	fe843783          	ld	a5,-24(s0)
     fb8:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     fba:	fe043783          	ld	a5,-32(s0)
     fbe:	6398                	ld	a4,0(a5)
     fc0:	fe843783          	ld	a5,-24(s0)
     fc4:	e398                	sd	a4,0(a5)
     fc6:	a031                	j	fd2 <free+0x10c>
  } else
    p->s.ptr = bp;
     fc8:	fe843783          	ld	a5,-24(s0)
     fcc:	fe043703          	ld	a4,-32(s0)
     fd0:	e398                	sd	a4,0(a5)
  freep = p;
     fd2:	00001797          	auipc	a5,0x1
     fd6:	05e78793          	addi	a5,a5,94 # 2030 <freep>
     fda:	fe843703          	ld	a4,-24(s0)
     fde:	e398                	sd	a4,0(a5)
}
     fe0:	0001                	nop
     fe2:	7422                	ld	s0,40(sp)
     fe4:	6145                	addi	sp,sp,48
     fe6:	8082                	ret

0000000000000fe8 <morecore>:

static Header*
morecore(uint nu)
{
     fe8:	7179                	addi	sp,sp,-48
     fea:	f406                	sd	ra,40(sp)
     fec:	f022                	sd	s0,32(sp)
     fee:	1800                	addi	s0,sp,48
     ff0:	87aa                	mv	a5,a0
     ff2:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     ff6:	fdc42783          	lw	a5,-36(s0)
     ffa:	0007871b          	sext.w	a4,a5
     ffe:	6785                	lui	a5,0x1
    1000:	00f77563          	bgeu	a4,a5,100a <morecore+0x22>
    nu = 4096;
    1004:	6785                	lui	a5,0x1
    1006:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
    100a:	fdc42783          	lw	a5,-36(s0)
    100e:	0047979b          	slliw	a5,a5,0x4
    1012:	2781                	sext.w	a5,a5
    1014:	2781                	sext.w	a5,a5
    1016:	853e                	mv	a0,a5
    1018:	00000097          	auipc	ra,0x0
    101c:	9ae080e7          	jalr	-1618(ra) # 9c6 <sbrk>
    1020:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
    1024:	fe843703          	ld	a4,-24(s0)
    1028:	57fd                	li	a5,-1
    102a:	00f71463          	bne	a4,a5,1032 <morecore+0x4a>
    return 0;
    102e:	4781                	li	a5,0
    1030:	a03d                	j	105e <morecore+0x76>
  hp = (Header*)p;
    1032:	fe843783          	ld	a5,-24(s0)
    1036:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
    103a:	fe043783          	ld	a5,-32(s0)
    103e:	fdc42703          	lw	a4,-36(s0)
    1042:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
    1044:	fe043783          	ld	a5,-32(s0)
    1048:	07c1                	addi	a5,a5,16 # 1010 <morecore+0x28>
    104a:	853e                	mv	a0,a5
    104c:	00000097          	auipc	ra,0x0
    1050:	e7a080e7          	jalr	-390(ra) # ec6 <free>
  return freep;
    1054:	00001797          	auipc	a5,0x1
    1058:	fdc78793          	addi	a5,a5,-36 # 2030 <freep>
    105c:	639c                	ld	a5,0(a5)
}
    105e:	853e                	mv	a0,a5
    1060:	70a2                	ld	ra,40(sp)
    1062:	7402                	ld	s0,32(sp)
    1064:	6145                	addi	sp,sp,48
    1066:	8082                	ret

0000000000001068 <malloc>:

void*
malloc(uint nbytes)
{
    1068:	7139                	addi	sp,sp,-64
    106a:	fc06                	sd	ra,56(sp)
    106c:	f822                	sd	s0,48(sp)
    106e:	0080                	addi	s0,sp,64
    1070:	87aa                	mv	a5,a0
    1072:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1076:	fcc46783          	lwu	a5,-52(s0)
    107a:	07bd                	addi	a5,a5,15
    107c:	8391                	srli	a5,a5,0x4
    107e:	2781                	sext.w	a5,a5
    1080:	2785                	addiw	a5,a5,1
    1082:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
    1086:	00001797          	auipc	a5,0x1
    108a:	faa78793          	addi	a5,a5,-86 # 2030 <freep>
    108e:	639c                	ld	a5,0(a5)
    1090:	fef43023          	sd	a5,-32(s0)
    1094:	fe043783          	ld	a5,-32(s0)
    1098:	ef95                	bnez	a5,10d4 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
    109a:	00001797          	auipc	a5,0x1
    109e:	f8678793          	addi	a5,a5,-122 # 2020 <base>
    10a2:	fef43023          	sd	a5,-32(s0)
    10a6:	00001797          	auipc	a5,0x1
    10aa:	f8a78793          	addi	a5,a5,-118 # 2030 <freep>
    10ae:	fe043703          	ld	a4,-32(s0)
    10b2:	e398                	sd	a4,0(a5)
    10b4:	00001797          	auipc	a5,0x1
    10b8:	f7c78793          	addi	a5,a5,-132 # 2030 <freep>
    10bc:	6398                	ld	a4,0(a5)
    10be:	00001797          	auipc	a5,0x1
    10c2:	f6278793          	addi	a5,a5,-158 # 2020 <base>
    10c6:	e398                	sd	a4,0(a5)
    base.s.size = 0;
    10c8:	00001797          	auipc	a5,0x1
    10cc:	f5878793          	addi	a5,a5,-168 # 2020 <base>
    10d0:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    10d4:	fe043783          	ld	a5,-32(s0)
    10d8:	639c                	ld	a5,0(a5)
    10da:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    10de:	fe843783          	ld	a5,-24(s0)
    10e2:	4798                	lw	a4,8(a5)
    10e4:	fdc42783          	lw	a5,-36(s0)
    10e8:	2781                	sext.w	a5,a5
    10ea:	06f76763          	bltu	a4,a5,1158 <malloc+0xf0>
      if(p->s.size == nunits)
    10ee:	fe843783          	ld	a5,-24(s0)
    10f2:	4798                	lw	a4,8(a5)
    10f4:	fdc42783          	lw	a5,-36(s0)
    10f8:	2781                	sext.w	a5,a5
    10fa:	00e79963          	bne	a5,a4,110c <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
    10fe:	fe843783          	ld	a5,-24(s0)
    1102:	6398                	ld	a4,0(a5)
    1104:	fe043783          	ld	a5,-32(s0)
    1108:	e398                	sd	a4,0(a5)
    110a:	a825                	j	1142 <malloc+0xda>
      else {
        p->s.size -= nunits;
    110c:	fe843783          	ld	a5,-24(s0)
    1110:	479c                	lw	a5,8(a5)
    1112:	fdc42703          	lw	a4,-36(s0)
    1116:	9f99                	subw	a5,a5,a4
    1118:	0007871b          	sext.w	a4,a5
    111c:	fe843783          	ld	a5,-24(s0)
    1120:	c798                	sw	a4,8(a5)
        p += p->s.size;
    1122:	fe843783          	ld	a5,-24(s0)
    1126:	479c                	lw	a5,8(a5)
    1128:	1782                	slli	a5,a5,0x20
    112a:	9381                	srli	a5,a5,0x20
    112c:	0792                	slli	a5,a5,0x4
    112e:	fe843703          	ld	a4,-24(s0)
    1132:	97ba                	add	a5,a5,a4
    1134:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
    1138:	fe843783          	ld	a5,-24(s0)
    113c:	fdc42703          	lw	a4,-36(s0)
    1140:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
    1142:	00001797          	auipc	a5,0x1
    1146:	eee78793          	addi	a5,a5,-274 # 2030 <freep>
    114a:	fe043703          	ld	a4,-32(s0)
    114e:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
    1150:	fe843783          	ld	a5,-24(s0)
    1154:	07c1                	addi	a5,a5,16
    1156:	a091                	j	119a <malloc+0x132>
    }
    if(p == freep)
    1158:	00001797          	auipc	a5,0x1
    115c:	ed878793          	addi	a5,a5,-296 # 2030 <freep>
    1160:	639c                	ld	a5,0(a5)
    1162:	fe843703          	ld	a4,-24(s0)
    1166:	02f71063          	bne	a4,a5,1186 <malloc+0x11e>
      if((p = morecore(nunits)) == 0)
    116a:	fdc42783          	lw	a5,-36(s0)
    116e:	853e                	mv	a0,a5
    1170:	00000097          	auipc	ra,0x0
    1174:	e78080e7          	jalr	-392(ra) # fe8 <morecore>
    1178:	fea43423          	sd	a0,-24(s0)
    117c:	fe843783          	ld	a5,-24(s0)
    1180:	e399                	bnez	a5,1186 <malloc+0x11e>
        return 0;
    1182:	4781                	li	a5,0
    1184:	a819                	j	119a <malloc+0x132>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1186:	fe843783          	ld	a5,-24(s0)
    118a:	fef43023          	sd	a5,-32(s0)
    118e:	fe843783          	ld	a5,-24(s0)
    1192:	639c                	ld	a5,0(a5)
    1194:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
    1198:	b799                	j	10de <malloc+0x76>
  }
}
    119a:	853e                	mv	a0,a5
    119c:	70e2                	ld	ra,56(sp)
    119e:	7442                	ld	s0,48(sp)
    11a0:	6121                	addi	sp,sp,64
    11a2:	8082                	ret
