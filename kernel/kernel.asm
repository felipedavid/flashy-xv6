
kernel/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0001d117          	auipc	sp,0x1d
    80000004:	eb010113          	addi	sp,sp,-336 # 8001ceb0 <stack0>
    80000008:	6505                	lui	a0,0x1
    8000000a:	f14025f3          	csrr	a1,mhartid
    8000000e:	0585                	addi	a1,a1,1
    80000010:	02b50533          	mul	a0,a0,a1
    80000014:	912a                	add	sp,sp,a0
    80000016:	450080ef          	jal	ra,80008466 <start>

000000008000001a <spin>:
    8000001a:	a001                	j	8000001a <spin>

000000008000001c <kinit>:
  struct run *freelist;
} kmem;

void
kinit()
{
    8000001c:	1141                	addi	sp,sp,-16
    8000001e:	e406                	sd	ra,8(sp)
    80000020:	e022                	sd	s0,0(sp)
    80000022:	0800                	addi	s0,sp,16
  initlock(&kmem.lock, "kmem");
    80000024:	0000b597          	auipc	a1,0xb
    80000028:	fdc58593          	addi	a1,a1,-36 # 8000b000 <etext>
    8000002c:	0000c517          	auipc	a0,0xc
    80000030:	a4450513          	addi	a0,a0,-1468 # 8000ba70 <kmem>
    80000034:	00009097          	auipc	ra,0x9
    80000038:	31a080e7          	jalr	794(ra) # 8000934e <initlock>
  freerange(end, (void*)PHYSTOP);
    8000003c:	47c5                	li	a5,17
    8000003e:	01b79593          	slli	a1,a5,0x1b
    80000042:	00025517          	auipc	a0,0x25
    80000046:	0ae50513          	addi	a0,a0,174 # 800250f0 <end>
    8000004a:	00000097          	auipc	ra,0x0
    8000004e:	012080e7          	jalr	18(ra) # 8000005c <freerange>
}
    80000052:	0001                	nop
    80000054:	60a2                	ld	ra,8(sp)
    80000056:	6402                	ld	s0,0(sp)
    80000058:	0141                	addi	sp,sp,16
    8000005a:	8082                	ret

000000008000005c <freerange>:

void
freerange(void *pa_start, void *pa_end)
{
    8000005c:	7179                	addi	sp,sp,-48
    8000005e:	f406                	sd	ra,40(sp)
    80000060:	f022                	sd	s0,32(sp)
    80000062:	1800                	addi	s0,sp,48
    80000064:	fca43c23          	sd	a0,-40(s0)
    80000068:	fcb43823          	sd	a1,-48(s0)
  char *p;
  p = (char*)PGROUNDUP((uint64)pa_start);
    8000006c:	fd843703          	ld	a4,-40(s0)
    80000070:	6785                	lui	a5,0x1
    80000072:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    80000074:	973e                	add	a4,a4,a5
    80000076:	77fd                	lui	a5,0xfffff
    80000078:	8ff9                	and	a5,a5,a4
    8000007a:	fef43423          	sd	a5,-24(s0)
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    8000007e:	a829                	j	80000098 <freerange+0x3c>
    kfree(p);
    80000080:	fe843503          	ld	a0,-24(s0)
    80000084:	00000097          	auipc	ra,0x0
    80000088:	030080e7          	jalr	48(ra) # 800000b4 <kfree>
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    8000008c:	fe843703          	ld	a4,-24(s0)
    80000090:	6785                	lui	a5,0x1
    80000092:	97ba                	add	a5,a5,a4
    80000094:	fef43423          	sd	a5,-24(s0)
    80000098:	fe843703          	ld	a4,-24(s0)
    8000009c:	6785                	lui	a5,0x1
    8000009e:	97ba                	add	a5,a5,a4
    800000a0:	fd043703          	ld	a4,-48(s0)
    800000a4:	fcf77ee3          	bgeu	a4,a5,80000080 <freerange+0x24>
}
    800000a8:	0001                	nop
    800000aa:	0001                	nop
    800000ac:	70a2                	ld	ra,40(sp)
    800000ae:	7402                	ld	s0,32(sp)
    800000b0:	6145                	addi	sp,sp,48
    800000b2:	8082                	ret

00000000800000b4 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
    800000b4:	7179                	addi	sp,sp,-48
    800000b6:	f406                	sd	ra,40(sp)
    800000b8:	f022                	sd	s0,32(sp)
    800000ba:	1800                	addi	s0,sp,48
    800000bc:	fca43c23          	sd	a0,-40(s0)
  struct run *r;

  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < end || (uint64)pa >= PHYSTOP)
    800000c0:	fd843703          	ld	a4,-40(s0)
    800000c4:	6785                	lui	a5,0x1
    800000c6:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    800000c8:	8ff9                	and	a5,a5,a4
    800000ca:	ef99                	bnez	a5,800000e8 <kfree+0x34>
    800000cc:	fd843703          	ld	a4,-40(s0)
    800000d0:	00025797          	auipc	a5,0x25
    800000d4:	02078793          	addi	a5,a5,32 # 800250f0 <end>
    800000d8:	00f76863          	bltu	a4,a5,800000e8 <kfree+0x34>
    800000dc:	fd843703          	ld	a4,-40(s0)
    800000e0:	47c5                	li	a5,17
    800000e2:	07ee                	slli	a5,a5,0x1b
    800000e4:	00f76a63          	bltu	a4,a5,800000f8 <kfree+0x44>
    panic("kfree");
    800000e8:	0000b517          	auipc	a0,0xb
    800000ec:	f2050513          	addi	a0,a0,-224 # 8000b008 <etext+0x8>
    800000f0:	00009097          	auipc	ra,0x9
    800000f4:	e46080e7          	jalr	-442(ra) # 80008f36 <panic>

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);
    800000f8:	6605                	lui	a2,0x1
    800000fa:	4585                	li	a1,1
    800000fc:	fd843503          	ld	a0,-40(s0)
    80000100:	00000097          	auipc	ra,0x0
    80000104:	10c080e7          	jalr	268(ra) # 8000020c <memset>

  r = (struct run*)pa;
    80000108:	fd843783          	ld	a5,-40(s0)
    8000010c:	fef43423          	sd	a5,-24(s0)

  acquire(&kmem.lock);
    80000110:	0000c517          	auipc	a0,0xc
    80000114:	96050513          	addi	a0,a0,-1696 # 8000ba70 <kmem>
    80000118:	00009097          	auipc	ra,0x9
    8000011c:	266080e7          	jalr	614(ra) # 8000937e <acquire>
  r->next = kmem.freelist;
    80000120:	0000c797          	auipc	a5,0xc
    80000124:	95078793          	addi	a5,a5,-1712 # 8000ba70 <kmem>
    80000128:	6f98                	ld	a4,24(a5)
    8000012a:	fe843783          	ld	a5,-24(s0)
    8000012e:	e398                	sd	a4,0(a5)
  kmem.freelist = r;
    80000130:	0000c797          	auipc	a5,0xc
    80000134:	94078793          	addi	a5,a5,-1728 # 8000ba70 <kmem>
    80000138:	fe843703          	ld	a4,-24(s0)
    8000013c:	ef98                	sd	a4,24(a5)
  release(&kmem.lock);
    8000013e:	0000c517          	auipc	a0,0xc
    80000142:	93250513          	addi	a0,a0,-1742 # 8000ba70 <kmem>
    80000146:	00009097          	auipc	ra,0x9
    8000014a:	29c080e7          	jalr	668(ra) # 800093e2 <release>
}
    8000014e:	0001                	nop
    80000150:	70a2                	ld	ra,40(sp)
    80000152:	7402                	ld	s0,32(sp)
    80000154:	6145                	addi	sp,sp,48
    80000156:	8082                	ret

0000000080000158 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
    80000158:	1101                	addi	sp,sp,-32
    8000015a:	ec06                	sd	ra,24(sp)
    8000015c:	e822                	sd	s0,16(sp)
    8000015e:	1000                	addi	s0,sp,32
  struct run *r;

  acquire(&kmem.lock);
    80000160:	0000c517          	auipc	a0,0xc
    80000164:	91050513          	addi	a0,a0,-1776 # 8000ba70 <kmem>
    80000168:	00009097          	auipc	ra,0x9
    8000016c:	216080e7          	jalr	534(ra) # 8000937e <acquire>
  r = kmem.freelist;
    80000170:	0000c797          	auipc	a5,0xc
    80000174:	90078793          	addi	a5,a5,-1792 # 8000ba70 <kmem>
    80000178:	6f9c                	ld	a5,24(a5)
    8000017a:	fef43423          	sd	a5,-24(s0)
  if(r)
    8000017e:	fe843783          	ld	a5,-24(s0)
    80000182:	cb89                	beqz	a5,80000194 <kalloc+0x3c>
    kmem.freelist = r->next;
    80000184:	fe843783          	ld	a5,-24(s0)
    80000188:	6398                	ld	a4,0(a5)
    8000018a:	0000c797          	auipc	a5,0xc
    8000018e:	8e678793          	addi	a5,a5,-1818 # 8000ba70 <kmem>
    80000192:	ef98                	sd	a4,24(a5)
  release(&kmem.lock);
    80000194:	0000c517          	auipc	a0,0xc
    80000198:	8dc50513          	addi	a0,a0,-1828 # 8000ba70 <kmem>
    8000019c:	00009097          	auipc	ra,0x9
    800001a0:	246080e7          	jalr	582(ra) # 800093e2 <release>

  if(r)
    800001a4:	fe843783          	ld	a5,-24(s0)
    800001a8:	cb89                	beqz	a5,800001ba <kalloc+0x62>
    memset((char*)r, 5, PGSIZE); // fill with junk
    800001aa:	6605                	lui	a2,0x1
    800001ac:	4595                	li	a1,5
    800001ae:	fe843503          	ld	a0,-24(s0)
    800001b2:	00000097          	auipc	ra,0x0
    800001b6:	05a080e7          	jalr	90(ra) # 8000020c <memset>
  return (void*)r;
    800001ba:	fe843783          	ld	a5,-24(s0)
}
    800001be:	853e                	mv	a0,a5
    800001c0:	60e2                	ld	ra,24(sp)
    800001c2:	6442                	ld	s0,16(sp)
    800001c4:	6105                	addi	sp,sp,32
    800001c6:	8082                	ret

00000000800001c8 <get_freemem>:

int
get_freemem() {
    800001c8:	1101                	addi	sp,sp,-32
    800001ca:	ec22                	sd	s0,24(sp)
    800001cc:	1000                	addi	s0,sp,32
  int freemem = 0;
    800001ce:	fe042623          	sw	zero,-20(s0)
  for (struct run *p = kmem.freelist; p != 0; p = p->next) {
    800001d2:	0000c797          	auipc	a5,0xc
    800001d6:	89e78793          	addi	a5,a5,-1890 # 8000ba70 <kmem>
    800001da:	6f9c                	ld	a5,24(a5)
    800001dc:	fef43023          	sd	a5,-32(s0)
    800001e0:	a829                	j	800001fa <get_freemem+0x32>
    freemem += PGSIZE;
    800001e2:	fec42783          	lw	a5,-20(s0)
    800001e6:	873e                	mv	a4,a5
    800001e8:	6785                	lui	a5,0x1
    800001ea:	9fb9                	addw	a5,a5,a4
    800001ec:	fef42623          	sw	a5,-20(s0)
  for (struct run *p = kmem.freelist; p != 0; p = p->next) {
    800001f0:	fe043783          	ld	a5,-32(s0)
    800001f4:	639c                	ld	a5,0(a5)
    800001f6:	fef43023          	sd	a5,-32(s0)
    800001fa:	fe043783          	ld	a5,-32(s0)
    800001fe:	f3f5                	bnez	a5,800001e2 <get_freemem+0x1a>
  }
  return freemem;
    80000200:	fec42783          	lw	a5,-20(s0)
}
    80000204:	853e                	mv	a0,a5
    80000206:	6462                	ld	s0,24(sp)
    80000208:	6105                	addi	sp,sp,32
    8000020a:	8082                	ret

000000008000020c <memset>:
#include "types.h"

void*
memset(void *dst, int c, uint n)
{
    8000020c:	7179                	addi	sp,sp,-48
    8000020e:	f422                	sd	s0,40(sp)
    80000210:	1800                	addi	s0,sp,48
    80000212:	fca43c23          	sd	a0,-40(s0)
    80000216:	87ae                	mv	a5,a1
    80000218:	8732                	mv	a4,a2
    8000021a:	fcf42a23          	sw	a5,-44(s0)
    8000021e:	87ba                	mv	a5,a4
    80000220:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
    80000224:	fd843783          	ld	a5,-40(s0)
    80000228:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
    8000022c:	fe042623          	sw	zero,-20(s0)
    80000230:	a00d                	j	80000252 <memset+0x46>
    cdst[i] = c;
    80000232:	fec42783          	lw	a5,-20(s0)
    80000236:	fe043703          	ld	a4,-32(s0)
    8000023a:	97ba                	add	a5,a5,a4
    8000023c:	fd442703          	lw	a4,-44(s0)
    80000240:	0ff77713          	zext.b	a4,a4
    80000244:	00e78023          	sb	a4,0(a5) # 1000 <_entry-0x7ffff000>
  for(i = 0; i < n; i++){
    80000248:	fec42783          	lw	a5,-20(s0)
    8000024c:	2785                	addiw	a5,a5,1
    8000024e:	fef42623          	sw	a5,-20(s0)
    80000252:	fec42703          	lw	a4,-20(s0)
    80000256:	fd042783          	lw	a5,-48(s0)
    8000025a:	2781                	sext.w	a5,a5
    8000025c:	fcf76be3          	bltu	a4,a5,80000232 <memset+0x26>
  }
  return dst;
    80000260:	fd843783          	ld	a5,-40(s0)
}
    80000264:	853e                	mv	a0,a5
    80000266:	7422                	ld	s0,40(sp)
    80000268:	6145                	addi	sp,sp,48
    8000026a:	8082                	ret

000000008000026c <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
    8000026c:	7139                	addi	sp,sp,-64
    8000026e:	fc22                	sd	s0,56(sp)
    80000270:	0080                	addi	s0,sp,64
    80000272:	fca43c23          	sd	a0,-40(s0)
    80000276:	fcb43823          	sd	a1,-48(s0)
    8000027a:	87b2                	mv	a5,a2
    8000027c:	fcf42623          	sw	a5,-52(s0)
  const uchar *s1, *s2;

  s1 = v1;
    80000280:	fd843783          	ld	a5,-40(s0)
    80000284:	fef43423          	sd	a5,-24(s0)
  s2 = v2;
    80000288:	fd043783          	ld	a5,-48(s0)
    8000028c:	fef43023          	sd	a5,-32(s0)
  while(n-- > 0){
    80000290:	a0a1                	j	800002d8 <memcmp+0x6c>
    if(*s1 != *s2)
    80000292:	fe843783          	ld	a5,-24(s0)
    80000296:	0007c703          	lbu	a4,0(a5)
    8000029a:	fe043783          	ld	a5,-32(s0)
    8000029e:	0007c783          	lbu	a5,0(a5)
    800002a2:	02f70163          	beq	a4,a5,800002c4 <memcmp+0x58>
      return *s1 - *s2;
    800002a6:	fe843783          	ld	a5,-24(s0)
    800002aa:	0007c783          	lbu	a5,0(a5)
    800002ae:	0007871b          	sext.w	a4,a5
    800002b2:	fe043783          	ld	a5,-32(s0)
    800002b6:	0007c783          	lbu	a5,0(a5)
    800002ba:	2781                	sext.w	a5,a5
    800002bc:	40f707bb          	subw	a5,a4,a5
    800002c0:	2781                	sext.w	a5,a5
    800002c2:	a01d                	j	800002e8 <memcmp+0x7c>
    s1++, s2++;
    800002c4:	fe843783          	ld	a5,-24(s0)
    800002c8:	0785                	addi	a5,a5,1
    800002ca:	fef43423          	sd	a5,-24(s0)
    800002ce:	fe043783          	ld	a5,-32(s0)
    800002d2:	0785                	addi	a5,a5,1
    800002d4:	fef43023          	sd	a5,-32(s0)
  while(n-- > 0){
    800002d8:	fcc42783          	lw	a5,-52(s0)
    800002dc:	fff7871b          	addiw	a4,a5,-1
    800002e0:	fce42623          	sw	a4,-52(s0)
    800002e4:	f7dd                	bnez	a5,80000292 <memcmp+0x26>
  }

  return 0;
    800002e6:	4781                	li	a5,0
}
    800002e8:	853e                	mv	a0,a5
    800002ea:	7462                	ld	s0,56(sp)
    800002ec:	6121                	addi	sp,sp,64
    800002ee:	8082                	ret

00000000800002f0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
    800002f0:	7139                	addi	sp,sp,-64
    800002f2:	fc22                	sd	s0,56(sp)
    800002f4:	0080                	addi	s0,sp,64
    800002f6:	fca43c23          	sd	a0,-40(s0)
    800002fa:	fcb43823          	sd	a1,-48(s0)
    800002fe:	87b2                	mv	a5,a2
    80000300:	fcf42623          	sw	a5,-52(s0)
  const char *s;
  char *d;

  if(n == 0)
    80000304:	fcc42783          	lw	a5,-52(s0)
    80000308:	2781                	sext.w	a5,a5
    8000030a:	e781                	bnez	a5,80000312 <memmove+0x22>
    return dst;
    8000030c:	fd843783          	ld	a5,-40(s0)
    80000310:	a855                	j	800003c4 <memmove+0xd4>
  
  s = src;
    80000312:	fd043783          	ld	a5,-48(s0)
    80000316:	fef43423          	sd	a5,-24(s0)
  d = dst;
    8000031a:	fd843783          	ld	a5,-40(s0)
    8000031e:	fef43023          	sd	a5,-32(s0)
  if(s < d && s + n > d){
    80000322:	fe843703          	ld	a4,-24(s0)
    80000326:	fe043783          	ld	a5,-32(s0)
    8000032a:	08f77463          	bgeu	a4,a5,800003b2 <memmove+0xc2>
    8000032e:	fcc46783          	lwu	a5,-52(s0)
    80000332:	fe843703          	ld	a4,-24(s0)
    80000336:	97ba                	add	a5,a5,a4
    80000338:	fe043703          	ld	a4,-32(s0)
    8000033c:	06f77b63          	bgeu	a4,a5,800003b2 <memmove+0xc2>
    s += n;
    80000340:	fcc46783          	lwu	a5,-52(s0)
    80000344:	fe843703          	ld	a4,-24(s0)
    80000348:	97ba                	add	a5,a5,a4
    8000034a:	fef43423          	sd	a5,-24(s0)
    d += n;
    8000034e:	fcc46783          	lwu	a5,-52(s0)
    80000352:	fe043703          	ld	a4,-32(s0)
    80000356:	97ba                	add	a5,a5,a4
    80000358:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
    8000035c:	a01d                	j	80000382 <memmove+0x92>
      *--d = *--s;
    8000035e:	fe843783          	ld	a5,-24(s0)
    80000362:	17fd                	addi	a5,a5,-1
    80000364:	fef43423          	sd	a5,-24(s0)
    80000368:	fe043783          	ld	a5,-32(s0)
    8000036c:	17fd                	addi	a5,a5,-1
    8000036e:	fef43023          	sd	a5,-32(s0)
    80000372:	fe843783          	ld	a5,-24(s0)
    80000376:	0007c703          	lbu	a4,0(a5)
    8000037a:	fe043783          	ld	a5,-32(s0)
    8000037e:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
    80000382:	fcc42783          	lw	a5,-52(s0)
    80000386:	fff7871b          	addiw	a4,a5,-1
    8000038a:	fce42623          	sw	a4,-52(s0)
    8000038e:	fbe1                	bnez	a5,8000035e <memmove+0x6e>
  if(s < d && s + n > d){
    80000390:	a805                	j	800003c0 <memmove+0xd0>
  } else
    while(n-- > 0)
      *d++ = *s++;
    80000392:	fe843703          	ld	a4,-24(s0)
    80000396:	00170793          	addi	a5,a4,1
    8000039a:	fef43423          	sd	a5,-24(s0)
    8000039e:	fe043783          	ld	a5,-32(s0)
    800003a2:	00178693          	addi	a3,a5,1
    800003a6:	fed43023          	sd	a3,-32(s0)
    800003aa:	00074703          	lbu	a4,0(a4)
    800003ae:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
    800003b2:	fcc42783          	lw	a5,-52(s0)
    800003b6:	fff7871b          	addiw	a4,a5,-1
    800003ba:	fce42623          	sw	a4,-52(s0)
    800003be:	fbf1                	bnez	a5,80000392 <memmove+0xa2>

  return dst;
    800003c0:	fd843783          	ld	a5,-40(s0)
}
    800003c4:	853e                	mv	a0,a5
    800003c6:	7462                	ld	s0,56(sp)
    800003c8:	6121                	addi	sp,sp,64
    800003ca:	8082                	ret

00000000800003cc <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
    800003cc:	7179                	addi	sp,sp,-48
    800003ce:	f406                	sd	ra,40(sp)
    800003d0:	f022                	sd	s0,32(sp)
    800003d2:	1800                	addi	s0,sp,48
    800003d4:	fea43423          	sd	a0,-24(s0)
    800003d8:	feb43023          	sd	a1,-32(s0)
    800003dc:	87b2                	mv	a5,a2
    800003de:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
    800003e2:	fdc42783          	lw	a5,-36(s0)
    800003e6:	863e                	mv	a2,a5
    800003e8:	fe043583          	ld	a1,-32(s0)
    800003ec:	fe843503          	ld	a0,-24(s0)
    800003f0:	00000097          	auipc	ra,0x0
    800003f4:	f00080e7          	jalr	-256(ra) # 800002f0 <memmove>
    800003f8:	87aa                	mv	a5,a0
}
    800003fa:	853e                	mv	a0,a5
    800003fc:	70a2                	ld	ra,40(sp)
    800003fe:	7402                	ld	s0,32(sp)
    80000400:	6145                	addi	sp,sp,48
    80000402:	8082                	ret

0000000080000404 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
    80000404:	7179                	addi	sp,sp,-48
    80000406:	f422                	sd	s0,40(sp)
    80000408:	1800                	addi	s0,sp,48
    8000040a:	fea43423          	sd	a0,-24(s0)
    8000040e:	feb43023          	sd	a1,-32(s0)
    80000412:	87b2                	mv	a5,a2
    80000414:	fcf42e23          	sw	a5,-36(s0)
  while(n > 0 && *p && *p == *q)
    80000418:	a005                	j	80000438 <strncmp+0x34>
    n--, p++, q++;
    8000041a:	fdc42783          	lw	a5,-36(s0)
    8000041e:	37fd                	addiw	a5,a5,-1
    80000420:	fcf42e23          	sw	a5,-36(s0)
    80000424:	fe843783          	ld	a5,-24(s0)
    80000428:	0785                	addi	a5,a5,1
    8000042a:	fef43423          	sd	a5,-24(s0)
    8000042e:	fe043783          	ld	a5,-32(s0)
    80000432:	0785                	addi	a5,a5,1
    80000434:	fef43023          	sd	a5,-32(s0)
  while(n > 0 && *p && *p == *q)
    80000438:	fdc42783          	lw	a5,-36(s0)
    8000043c:	2781                	sext.w	a5,a5
    8000043e:	c385                	beqz	a5,8000045e <strncmp+0x5a>
    80000440:	fe843783          	ld	a5,-24(s0)
    80000444:	0007c783          	lbu	a5,0(a5)
    80000448:	cb99                	beqz	a5,8000045e <strncmp+0x5a>
    8000044a:	fe843783          	ld	a5,-24(s0)
    8000044e:	0007c703          	lbu	a4,0(a5)
    80000452:	fe043783          	ld	a5,-32(s0)
    80000456:	0007c783          	lbu	a5,0(a5)
    8000045a:	fcf700e3          	beq	a4,a5,8000041a <strncmp+0x16>
  if(n == 0)
    8000045e:	fdc42783          	lw	a5,-36(s0)
    80000462:	2781                	sext.w	a5,a5
    80000464:	e399                	bnez	a5,8000046a <strncmp+0x66>
    return 0;
    80000466:	4781                	li	a5,0
    80000468:	a839                	j	80000486 <strncmp+0x82>
  return (uchar)*p - (uchar)*q;
    8000046a:	fe843783          	ld	a5,-24(s0)
    8000046e:	0007c783          	lbu	a5,0(a5)
    80000472:	0007871b          	sext.w	a4,a5
    80000476:	fe043783          	ld	a5,-32(s0)
    8000047a:	0007c783          	lbu	a5,0(a5)
    8000047e:	2781                	sext.w	a5,a5
    80000480:	40f707bb          	subw	a5,a4,a5
    80000484:	2781                	sext.w	a5,a5
}
    80000486:	853e                	mv	a0,a5
    80000488:	7422                	ld	s0,40(sp)
    8000048a:	6145                	addi	sp,sp,48
    8000048c:	8082                	ret

000000008000048e <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
    8000048e:	7139                	addi	sp,sp,-64
    80000490:	fc22                	sd	s0,56(sp)
    80000492:	0080                	addi	s0,sp,64
    80000494:	fca43c23          	sd	a0,-40(s0)
    80000498:	fcb43823          	sd	a1,-48(s0)
    8000049c:	87b2                	mv	a5,a2
    8000049e:	fcf42623          	sw	a5,-52(s0)
  char *os;

  os = s;
    800004a2:	fd843783          	ld	a5,-40(s0)
    800004a6:	fef43423          	sd	a5,-24(s0)
  while(n-- > 0 && (*s++ = *t++) != 0)
    800004aa:	0001                	nop
    800004ac:	fcc42783          	lw	a5,-52(s0)
    800004b0:	fff7871b          	addiw	a4,a5,-1
    800004b4:	fce42623          	sw	a4,-52(s0)
    800004b8:	02f05e63          	blez	a5,800004f4 <strncpy+0x66>
    800004bc:	fd043703          	ld	a4,-48(s0)
    800004c0:	00170793          	addi	a5,a4,1
    800004c4:	fcf43823          	sd	a5,-48(s0)
    800004c8:	fd843783          	ld	a5,-40(s0)
    800004cc:	00178693          	addi	a3,a5,1
    800004d0:	fcd43c23          	sd	a3,-40(s0)
    800004d4:	00074703          	lbu	a4,0(a4)
    800004d8:	00e78023          	sb	a4,0(a5)
    800004dc:	0007c783          	lbu	a5,0(a5)
    800004e0:	f7f1                	bnez	a5,800004ac <strncpy+0x1e>
    ;
  while(n-- > 0)
    800004e2:	a809                	j	800004f4 <strncpy+0x66>
    *s++ = 0;
    800004e4:	fd843783          	ld	a5,-40(s0)
    800004e8:	00178713          	addi	a4,a5,1
    800004ec:	fce43c23          	sd	a4,-40(s0)
    800004f0:	00078023          	sb	zero,0(a5)
  while(n-- > 0)
    800004f4:	fcc42783          	lw	a5,-52(s0)
    800004f8:	fff7871b          	addiw	a4,a5,-1
    800004fc:	fce42623          	sw	a4,-52(s0)
    80000500:	fef042e3          	bgtz	a5,800004e4 <strncpy+0x56>
  return os;
    80000504:	fe843783          	ld	a5,-24(s0)
}
    80000508:	853e                	mv	a0,a5
    8000050a:	7462                	ld	s0,56(sp)
    8000050c:	6121                	addi	sp,sp,64
    8000050e:	8082                	ret

0000000080000510 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
    80000510:	7139                	addi	sp,sp,-64
    80000512:	fc22                	sd	s0,56(sp)
    80000514:	0080                	addi	s0,sp,64
    80000516:	fca43c23          	sd	a0,-40(s0)
    8000051a:	fcb43823          	sd	a1,-48(s0)
    8000051e:	87b2                	mv	a5,a2
    80000520:	fcf42623          	sw	a5,-52(s0)
  char *os;

  os = s;
    80000524:	fd843783          	ld	a5,-40(s0)
    80000528:	fef43423          	sd	a5,-24(s0)
  if(n <= 0)
    8000052c:	fcc42783          	lw	a5,-52(s0)
    80000530:	2781                	sext.w	a5,a5
    80000532:	00f04563          	bgtz	a5,8000053c <safestrcpy+0x2c>
    return os;
    80000536:	fe843783          	ld	a5,-24(s0)
    8000053a:	a0a9                	j	80000584 <safestrcpy+0x74>
  while(--n > 0 && (*s++ = *t++) != 0)
    8000053c:	0001                	nop
    8000053e:	fcc42783          	lw	a5,-52(s0)
    80000542:	37fd                	addiw	a5,a5,-1
    80000544:	fcf42623          	sw	a5,-52(s0)
    80000548:	fcc42783          	lw	a5,-52(s0)
    8000054c:	2781                	sext.w	a5,a5
    8000054e:	02f05563          	blez	a5,80000578 <safestrcpy+0x68>
    80000552:	fd043703          	ld	a4,-48(s0)
    80000556:	00170793          	addi	a5,a4,1
    8000055a:	fcf43823          	sd	a5,-48(s0)
    8000055e:	fd843783          	ld	a5,-40(s0)
    80000562:	00178693          	addi	a3,a5,1
    80000566:	fcd43c23          	sd	a3,-40(s0)
    8000056a:	00074703          	lbu	a4,0(a4)
    8000056e:	00e78023          	sb	a4,0(a5)
    80000572:	0007c783          	lbu	a5,0(a5)
    80000576:	f7e1                	bnez	a5,8000053e <safestrcpy+0x2e>
    ;
  *s = 0;
    80000578:	fd843783          	ld	a5,-40(s0)
    8000057c:	00078023          	sb	zero,0(a5)
  return os;
    80000580:	fe843783          	ld	a5,-24(s0)
}
    80000584:	853e                	mv	a0,a5
    80000586:	7462                	ld	s0,56(sp)
    80000588:	6121                	addi	sp,sp,64
    8000058a:	8082                	ret

000000008000058c <strlen>:

int
strlen(const char *s)
{
    8000058c:	7179                	addi	sp,sp,-48
    8000058e:	f422                	sd	s0,40(sp)
    80000590:	1800                	addi	s0,sp,48
    80000592:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
    80000596:	fe042623          	sw	zero,-20(s0)
    8000059a:	a031                	j	800005a6 <strlen+0x1a>
    8000059c:	fec42783          	lw	a5,-20(s0)
    800005a0:	2785                	addiw	a5,a5,1
    800005a2:	fef42623          	sw	a5,-20(s0)
    800005a6:	fec42783          	lw	a5,-20(s0)
    800005aa:	fd843703          	ld	a4,-40(s0)
    800005ae:	97ba                	add	a5,a5,a4
    800005b0:	0007c783          	lbu	a5,0(a5)
    800005b4:	f7e5                	bnez	a5,8000059c <strlen+0x10>
    ;
  return n;
    800005b6:	fec42783          	lw	a5,-20(s0)
}
    800005ba:	853e                	mv	a0,a5
    800005bc:	7422                	ld	s0,40(sp)
    800005be:	6145                	addi	sp,sp,48
    800005c0:	8082                	ret

00000000800005c2 <main>:
volatile static int started = 0;

// start() jumps here in supervisor mode on all CPUs.
void
main()
{
    800005c2:	1141                	addi	sp,sp,-16
    800005c4:	e406                	sd	ra,8(sp)
    800005c6:	e022                	sd	s0,0(sp)
    800005c8:	0800                	addi	s0,sp,16
  if(cpuid() == 0){
    800005ca:	00001097          	auipc	ra,0x1
    800005ce:	fd8080e7          	jalr	-40(ra) # 800015a2 <cpuid>
    800005d2:	87aa                	mv	a5,a0
    800005d4:	efd5                	bnez	a5,80000690 <main+0xce>
    consoleinit();
    800005d6:	00008097          	auipc	ra,0x8
    800005da:	53a080e7          	jalr	1338(ra) # 80008b10 <consoleinit>
    printfinit();
    800005de:	00009097          	auipc	ra,0x9
    800005e2:	9ac080e7          	jalr	-1620(ra) # 80008f8a <printfinit>
    printf("\n");
    800005e6:	0000b517          	auipc	a0,0xb
    800005ea:	a2a50513          	addi	a0,a0,-1494 # 8000b010 <etext+0x10>
    800005ee:	00008097          	auipc	ra,0x8
    800005f2:	6f2080e7          	jalr	1778(ra) # 80008ce0 <printf>
    printf("xv6 kernel is booting\n");
    800005f6:	0000b517          	auipc	a0,0xb
    800005fa:	a2250513          	addi	a0,a0,-1502 # 8000b018 <etext+0x18>
    800005fe:	00008097          	auipc	ra,0x8
    80000602:	6e2080e7          	jalr	1762(ra) # 80008ce0 <printf>
    printf("\n");
    80000606:	0000b517          	auipc	a0,0xb
    8000060a:	a0a50513          	addi	a0,a0,-1526 # 8000b010 <etext+0x10>
    8000060e:	00008097          	auipc	ra,0x8
    80000612:	6d2080e7          	jalr	1746(ra) # 80008ce0 <printf>
    kinit();         // physical page allocator
    80000616:	00000097          	auipc	ra,0x0
    8000061a:	a06080e7          	jalr	-1530(ra) # 8000001c <kinit>
    kvminit();       // create kernel page table
    8000061e:	00000097          	auipc	ra,0x0
    80000622:	1f4080e7          	jalr	500(ra) # 80000812 <kvminit>
    kvminithart();   // turn on paging
    80000626:	00000097          	auipc	ra,0x0
    8000062a:	212080e7          	jalr	530(ra) # 80000838 <kvminithart>
    procinit();      // process table
    8000062e:	00001097          	auipc	ra,0x1
    80000632:	ea6080e7          	jalr	-346(ra) # 800014d4 <procinit>
    trapinit();      // trap vectors
    80000636:	00002097          	auipc	ra,0x2
    8000063a:	1f0080e7          	jalr	496(ra) # 80002826 <trapinit>
    trapinithart();  // install kernel trap vector
    8000063e:	00002097          	auipc	ra,0x2
    80000642:	212080e7          	jalr	530(ra) # 80002850 <trapinithart>
    plicinit();      // set up interrupt controller
    80000646:	00007097          	auipc	ra,0x7
    8000064a:	134080e7          	jalr	308(ra) # 8000777a <plicinit>
    plicinithart();  // ask PLIC for device interrupts
    8000064e:	00007097          	auipc	ra,0x7
    80000652:	150080e7          	jalr	336(ra) # 8000779e <plicinithart>
    binit();         // buffer cache
    80000656:	00003097          	auipc	ra,0x3
    8000065a:	d00080e7          	jalr	-768(ra) # 80003356 <binit>
    iinit();         // inode table
    8000065e:	00003097          	auipc	ra,0x3
    80000662:	536080e7          	jalr	1334(ra) # 80003b94 <iinit>
    fileinit();      // file table
    80000666:	00005097          	auipc	ra,0x5
    8000066a:	f14080e7          	jalr	-236(ra) # 8000557a <fileinit>
    virtio_disk_init(); // emulated hard disk
    8000066e:	00007097          	auipc	ra,0x7
    80000672:	204080e7          	jalr	516(ra) # 80007872 <virtio_disk_init>
    userinit();      // first user process
    80000676:	00001097          	auipc	ra,0x1
    8000067a:	30a080e7          	jalr	778(ra) # 80001980 <userinit>
    __sync_synchronize();
    8000067e:	0ff0000f          	fence
    started = 1;
    80000682:	0000b797          	auipc	a5,0xb
    80000686:	40e78793          	addi	a5,a5,1038 # 8000ba90 <started>
    8000068a:	4705                	li	a4,1
    8000068c:	c398                	sw	a4,0(a5)
    8000068e:	a0a9                	j	800006d8 <main+0x116>
  } else {
    while(started == 0)
    80000690:	0001                	nop
    80000692:	0000b797          	auipc	a5,0xb
    80000696:	3fe78793          	addi	a5,a5,1022 # 8000ba90 <started>
    8000069a:	439c                	lw	a5,0(a5)
    8000069c:	2781                	sext.w	a5,a5
    8000069e:	dbf5                	beqz	a5,80000692 <main+0xd0>
      ;
    __sync_synchronize();
    800006a0:	0ff0000f          	fence
    printf("hart %d starting\n", cpuid());
    800006a4:	00001097          	auipc	ra,0x1
    800006a8:	efe080e7          	jalr	-258(ra) # 800015a2 <cpuid>
    800006ac:	87aa                	mv	a5,a0
    800006ae:	85be                	mv	a1,a5
    800006b0:	0000b517          	auipc	a0,0xb
    800006b4:	98050513          	addi	a0,a0,-1664 # 8000b030 <etext+0x30>
    800006b8:	00008097          	auipc	ra,0x8
    800006bc:	628080e7          	jalr	1576(ra) # 80008ce0 <printf>
    kvminithart();    // turn on paging
    800006c0:	00000097          	auipc	ra,0x0
    800006c4:	178080e7          	jalr	376(ra) # 80000838 <kvminithart>
    trapinithart();   // install kernel trap vector
    800006c8:	00002097          	auipc	ra,0x2
    800006cc:	188080e7          	jalr	392(ra) # 80002850 <trapinithart>
    plicinithart();   // ask PLIC for device interrupts
    800006d0:	00007097          	auipc	ra,0x7
    800006d4:	0ce080e7          	jalr	206(ra) # 8000779e <plicinithart>
  }

  scheduler();        
    800006d8:	00002097          	auipc	ra,0x2
    800006dc:	8d6080e7          	jalr	-1834(ra) # 80001fae <scheduler>

00000000800006e0 <w_satp>:

// supervisor address translation and protection;
// holds the address of the page table.
static inline void 
w_satp(uint64 x)
{
    800006e0:	1101                	addi	sp,sp,-32
    800006e2:	ec22                	sd	s0,24(sp)
    800006e4:	1000                	addi	s0,sp,32
    800006e6:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw satp, %0" : : "r" (x));
    800006ea:	fe843783          	ld	a5,-24(s0)
    800006ee:	18079073          	csrw	satp,a5
}
    800006f2:	0001                	nop
    800006f4:	6462                	ld	s0,24(sp)
    800006f6:	6105                	addi	sp,sp,32
    800006f8:	8082                	ret

00000000800006fa <sfence_vma>:
}

// flush the TLB.
static inline void
sfence_vma()
{
    800006fa:	1141                	addi	sp,sp,-16
    800006fc:	e422                	sd	s0,8(sp)
    800006fe:	0800                	addi	s0,sp,16
  // the zero, zero means flush all TLB entries.
  asm volatile("sfence.vma zero, zero");
    80000700:	12000073          	sfence.vma
}
    80000704:	0001                	nop
    80000706:	6422                	ld	s0,8(sp)
    80000708:	0141                	addi	sp,sp,16
    8000070a:	8082                	ret

000000008000070c <kvmmake>:
extern char trampoline[]; // trampoline.S

// Make a direct-map page table for the kernel.
pagetable_t
kvmmake(void)
{
    8000070c:	1101                	addi	sp,sp,-32
    8000070e:	ec06                	sd	ra,24(sp)
    80000710:	e822                	sd	s0,16(sp)
    80000712:	1000                	addi	s0,sp,32
  pagetable_t kpgtbl;

  kpgtbl = (pagetable_t) kalloc();
    80000714:	00000097          	auipc	ra,0x0
    80000718:	a44080e7          	jalr	-1468(ra) # 80000158 <kalloc>
    8000071c:	fea43423          	sd	a0,-24(s0)
  memset(kpgtbl, 0, PGSIZE);
    80000720:	6605                	lui	a2,0x1
    80000722:	4581                	li	a1,0
    80000724:	fe843503          	ld	a0,-24(s0)
    80000728:	00000097          	auipc	ra,0x0
    8000072c:	ae4080e7          	jalr	-1308(ra) # 8000020c <memset>

  // uart registers
  kvmmap(kpgtbl, UART0, UART0, PGSIZE, PTE_R | PTE_W);
    80000730:	4719                	li	a4,6
    80000732:	6685                	lui	a3,0x1
    80000734:	10000637          	lui	a2,0x10000
    80000738:	100005b7          	lui	a1,0x10000
    8000073c:	fe843503          	ld	a0,-24(s0)
    80000740:	00000097          	auipc	ra,0x0
    80000744:	2a2080e7          	jalr	674(ra) # 800009e2 <kvmmap>

  // virtio mmio disk interface
  kvmmap(kpgtbl, VIRTIO0, VIRTIO0, PGSIZE, PTE_R | PTE_W);
    80000748:	4719                	li	a4,6
    8000074a:	6685                	lui	a3,0x1
    8000074c:	10001637          	lui	a2,0x10001
    80000750:	100015b7          	lui	a1,0x10001
    80000754:	fe843503          	ld	a0,-24(s0)
    80000758:	00000097          	auipc	ra,0x0
    8000075c:	28a080e7          	jalr	650(ra) # 800009e2 <kvmmap>

  // PLIC
  kvmmap(kpgtbl, PLIC, PLIC, 0x400000, PTE_R | PTE_W);
    80000760:	4719                	li	a4,6
    80000762:	004006b7          	lui	a3,0x400
    80000766:	0c000637          	lui	a2,0xc000
    8000076a:	0c0005b7          	lui	a1,0xc000
    8000076e:	fe843503          	ld	a0,-24(s0)
    80000772:	00000097          	auipc	ra,0x0
    80000776:	270080e7          	jalr	624(ra) # 800009e2 <kvmmap>

  // map kernel text executable and read-only.
  kvmmap(kpgtbl, KERNBASE, KERNBASE, (uint64)etext-KERNBASE, PTE_R | PTE_X);
    8000077a:	0000b717          	auipc	a4,0xb
    8000077e:	88670713          	addi	a4,a4,-1914 # 8000b000 <etext>
    80000782:	800007b7          	lui	a5,0x80000
    80000786:	97ba                	add	a5,a5,a4
    80000788:	4729                	li	a4,10
    8000078a:	86be                	mv	a3,a5
    8000078c:	4785                	li	a5,1
    8000078e:	01f79613          	slli	a2,a5,0x1f
    80000792:	4785                	li	a5,1
    80000794:	01f79593          	slli	a1,a5,0x1f
    80000798:	fe843503          	ld	a0,-24(s0)
    8000079c:	00000097          	auipc	ra,0x0
    800007a0:	246080e7          	jalr	582(ra) # 800009e2 <kvmmap>

  // map kernel data and the physical RAM we'll make use of.
  kvmmap(kpgtbl, (uint64)etext, (uint64)etext, PHYSTOP-(uint64)etext, PTE_R | PTE_W);
    800007a4:	0000b597          	auipc	a1,0xb
    800007a8:	85c58593          	addi	a1,a1,-1956 # 8000b000 <etext>
    800007ac:	0000b617          	auipc	a2,0xb
    800007b0:	85460613          	addi	a2,a2,-1964 # 8000b000 <etext>
    800007b4:	0000b797          	auipc	a5,0xb
    800007b8:	84c78793          	addi	a5,a5,-1972 # 8000b000 <etext>
    800007bc:	4745                	li	a4,17
    800007be:	076e                	slli	a4,a4,0x1b
    800007c0:	40f707b3          	sub	a5,a4,a5
    800007c4:	4719                	li	a4,6
    800007c6:	86be                	mv	a3,a5
    800007c8:	fe843503          	ld	a0,-24(s0)
    800007cc:	00000097          	auipc	ra,0x0
    800007d0:	216080e7          	jalr	534(ra) # 800009e2 <kvmmap>

  // map the trampoline for trap entry/exit to
  // the highest virtual address in the kernel.
  kvmmap(kpgtbl, TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X);
    800007d4:	0000a797          	auipc	a5,0xa
    800007d8:	82c78793          	addi	a5,a5,-2004 # 8000a000 <_trampoline>
    800007dc:	4729                	li	a4,10
    800007de:	6685                	lui	a3,0x1
    800007e0:	863e                	mv	a2,a5
    800007e2:	040007b7          	lui	a5,0x4000
    800007e6:	17fd                	addi	a5,a5,-1 # 3ffffff <_entry-0x7c000001>
    800007e8:	00c79593          	slli	a1,a5,0xc
    800007ec:	fe843503          	ld	a0,-24(s0)
    800007f0:	00000097          	auipc	ra,0x0
    800007f4:	1f2080e7          	jalr	498(ra) # 800009e2 <kvmmap>

  // allocate and map a kernel stack for each process.
  proc_mapstacks(kpgtbl);
    800007f8:	fe843503          	ld	a0,-24(s0)
    800007fc:	00001097          	auipc	ra,0x1
    80000800:	c1c080e7          	jalr	-996(ra) # 80001418 <proc_mapstacks>
  
  return kpgtbl;
    80000804:	fe843783          	ld	a5,-24(s0)
}
    80000808:	853e                	mv	a0,a5
    8000080a:	60e2                	ld	ra,24(sp)
    8000080c:	6442                	ld	s0,16(sp)
    8000080e:	6105                	addi	sp,sp,32
    80000810:	8082                	ret

0000000080000812 <kvminit>:

// Initialize the one kernel_pagetable
void
kvminit(void)
{
    80000812:	1141                	addi	sp,sp,-16
    80000814:	e406                	sd	ra,8(sp)
    80000816:	e022                	sd	s0,0(sp)
    80000818:	0800                	addi	s0,sp,16
  kernel_pagetable = kvmmake();
    8000081a:	00000097          	auipc	ra,0x0
    8000081e:	ef2080e7          	jalr	-270(ra) # 8000070c <kvmmake>
    80000822:	872a                	mv	a4,a0
    80000824:	0000b797          	auipc	a5,0xb
    80000828:	21c78793          	addi	a5,a5,540 # 8000ba40 <kernel_pagetable>
    8000082c:	e398                	sd	a4,0(a5)
}
    8000082e:	0001                	nop
    80000830:	60a2                	ld	ra,8(sp)
    80000832:	6402                	ld	s0,0(sp)
    80000834:	0141                	addi	sp,sp,16
    80000836:	8082                	ret

0000000080000838 <kvminithart>:

// Switch h/w page table register to the kernel's page table,
// and enable paging.
void
kvminithart()
{
    80000838:	1141                	addi	sp,sp,-16
    8000083a:	e406                	sd	ra,8(sp)
    8000083c:	e022                	sd	s0,0(sp)
    8000083e:	0800                	addi	s0,sp,16
  // wait for any previous writes to the page table memory to finish.
  sfence_vma();
    80000840:	00000097          	auipc	ra,0x0
    80000844:	eba080e7          	jalr	-326(ra) # 800006fa <sfence_vma>

  w_satp(MAKE_SATP(kernel_pagetable));
    80000848:	0000b797          	auipc	a5,0xb
    8000084c:	1f878793          	addi	a5,a5,504 # 8000ba40 <kernel_pagetable>
    80000850:	639c                	ld	a5,0(a5)
    80000852:	00c7d713          	srli	a4,a5,0xc
    80000856:	57fd                	li	a5,-1
    80000858:	17fe                	slli	a5,a5,0x3f
    8000085a:	8fd9                	or	a5,a5,a4
    8000085c:	853e                	mv	a0,a5
    8000085e:	00000097          	auipc	ra,0x0
    80000862:	e82080e7          	jalr	-382(ra) # 800006e0 <w_satp>

  // flush stale entries from the TLB.
  sfence_vma();
    80000866:	00000097          	auipc	ra,0x0
    8000086a:	e94080e7          	jalr	-364(ra) # 800006fa <sfence_vma>
}
    8000086e:	0001                	nop
    80000870:	60a2                	ld	ra,8(sp)
    80000872:	6402                	ld	s0,0(sp)
    80000874:	0141                	addi	sp,sp,16
    80000876:	8082                	ret

0000000080000878 <walk>:
//   21..29 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..11 -- 12 bits of byte offset within the page.
pte_t *
walk(pagetable_t pagetable, uint64 va, int alloc)
{
    80000878:	7139                	addi	sp,sp,-64
    8000087a:	fc06                	sd	ra,56(sp)
    8000087c:	f822                	sd	s0,48(sp)
    8000087e:	0080                	addi	s0,sp,64
    80000880:	fca43c23          	sd	a0,-40(s0)
    80000884:	fcb43823          	sd	a1,-48(s0)
    80000888:	87b2                	mv	a5,a2
    8000088a:	fcf42623          	sw	a5,-52(s0)
  if(va >= MAXVA)
    8000088e:	fd043703          	ld	a4,-48(s0)
    80000892:	57fd                	li	a5,-1
    80000894:	83e9                	srli	a5,a5,0x1a
    80000896:	00e7fa63          	bgeu	a5,a4,800008aa <walk+0x32>
    panic("walk");
    8000089a:	0000a517          	auipc	a0,0xa
    8000089e:	7ae50513          	addi	a0,a0,1966 # 8000b048 <etext+0x48>
    800008a2:	00008097          	auipc	ra,0x8
    800008a6:	694080e7          	jalr	1684(ra) # 80008f36 <panic>

  for(int level = 2; level > 0; level--) {
    800008aa:	4789                	li	a5,2
    800008ac:	fef42623          	sw	a5,-20(s0)
    800008b0:	a851                	j	80000944 <walk+0xcc>
    pte_t *pte = &pagetable[PX(level, va)];
    800008b2:	fec42783          	lw	a5,-20(s0)
    800008b6:	873e                	mv	a4,a5
    800008b8:	87ba                	mv	a5,a4
    800008ba:	0037979b          	slliw	a5,a5,0x3
    800008be:	9fb9                	addw	a5,a5,a4
    800008c0:	2781                	sext.w	a5,a5
    800008c2:	27b1                	addiw	a5,a5,12
    800008c4:	2781                	sext.w	a5,a5
    800008c6:	873e                	mv	a4,a5
    800008c8:	fd043783          	ld	a5,-48(s0)
    800008cc:	00e7d7b3          	srl	a5,a5,a4
    800008d0:	1ff7f793          	andi	a5,a5,511
    800008d4:	078e                	slli	a5,a5,0x3
    800008d6:	fd843703          	ld	a4,-40(s0)
    800008da:	97ba                	add	a5,a5,a4
    800008dc:	fef43023          	sd	a5,-32(s0)
    if(*pte & PTE_V) {
    800008e0:	fe043783          	ld	a5,-32(s0)
    800008e4:	639c                	ld	a5,0(a5)
    800008e6:	8b85                	andi	a5,a5,1
    800008e8:	cb89                	beqz	a5,800008fa <walk+0x82>
      pagetable = (pagetable_t)PTE2PA(*pte);
    800008ea:	fe043783          	ld	a5,-32(s0)
    800008ee:	639c                	ld	a5,0(a5)
    800008f0:	83a9                	srli	a5,a5,0xa
    800008f2:	07b2                	slli	a5,a5,0xc
    800008f4:	fcf43c23          	sd	a5,-40(s0)
    800008f8:	a089                	j	8000093a <walk+0xc2>
    } else {
      if(!alloc || (pagetable = (pde_t*)kalloc()) == 0)
    800008fa:	fcc42783          	lw	a5,-52(s0)
    800008fe:	2781                	sext.w	a5,a5
    80000900:	cb91                	beqz	a5,80000914 <walk+0x9c>
    80000902:	00000097          	auipc	ra,0x0
    80000906:	856080e7          	jalr	-1962(ra) # 80000158 <kalloc>
    8000090a:	fca43c23          	sd	a0,-40(s0)
    8000090e:	fd843783          	ld	a5,-40(s0)
    80000912:	e399                	bnez	a5,80000918 <walk+0xa0>
        return 0;
    80000914:	4781                	li	a5,0
    80000916:	a0a9                	j	80000960 <walk+0xe8>
      memset(pagetable, 0, PGSIZE);
    80000918:	6605                	lui	a2,0x1
    8000091a:	4581                	li	a1,0
    8000091c:	fd843503          	ld	a0,-40(s0)
    80000920:	00000097          	auipc	ra,0x0
    80000924:	8ec080e7          	jalr	-1812(ra) # 8000020c <memset>
      *pte = PA2PTE(pagetable) | PTE_V;
    80000928:	fd843783          	ld	a5,-40(s0)
    8000092c:	83b1                	srli	a5,a5,0xc
    8000092e:	07aa                	slli	a5,a5,0xa
    80000930:	0017e713          	ori	a4,a5,1
    80000934:	fe043783          	ld	a5,-32(s0)
    80000938:	e398                	sd	a4,0(a5)
  for(int level = 2; level > 0; level--) {
    8000093a:	fec42783          	lw	a5,-20(s0)
    8000093e:	37fd                	addiw	a5,a5,-1
    80000940:	fef42623          	sw	a5,-20(s0)
    80000944:	fec42783          	lw	a5,-20(s0)
    80000948:	2781                	sext.w	a5,a5
    8000094a:	f6f044e3          	bgtz	a5,800008b2 <walk+0x3a>
    }
  }
  return &pagetable[PX(0, va)];
    8000094e:	fd043783          	ld	a5,-48(s0)
    80000952:	83b1                	srli	a5,a5,0xc
    80000954:	1ff7f793          	andi	a5,a5,511
    80000958:	078e                	slli	a5,a5,0x3
    8000095a:	fd843703          	ld	a4,-40(s0)
    8000095e:	97ba                	add	a5,a5,a4
}
    80000960:	853e                	mv	a0,a5
    80000962:	70e2                	ld	ra,56(sp)
    80000964:	7442                	ld	s0,48(sp)
    80000966:	6121                	addi	sp,sp,64
    80000968:	8082                	ret

000000008000096a <walkaddr>:
// Look up a virtual address, return the physical address,
// or 0 if not mapped.
// Can only be used to look up user pages.
uint64
walkaddr(pagetable_t pagetable, uint64 va)
{
    8000096a:	7179                	addi	sp,sp,-48
    8000096c:	f406                	sd	ra,40(sp)
    8000096e:	f022                	sd	s0,32(sp)
    80000970:	1800                	addi	s0,sp,48
    80000972:	fca43c23          	sd	a0,-40(s0)
    80000976:	fcb43823          	sd	a1,-48(s0)
  pte_t *pte;
  uint64 pa;

  if(va >= MAXVA)
    8000097a:	fd043703          	ld	a4,-48(s0)
    8000097e:	57fd                	li	a5,-1
    80000980:	83e9                	srli	a5,a5,0x1a
    80000982:	00e7f463          	bgeu	a5,a4,8000098a <walkaddr+0x20>
    return 0;
    80000986:	4781                	li	a5,0
    80000988:	a881                	j	800009d8 <walkaddr+0x6e>

  pte = walk(pagetable, va, 0);
    8000098a:	4601                	li	a2,0
    8000098c:	fd043583          	ld	a1,-48(s0)
    80000990:	fd843503          	ld	a0,-40(s0)
    80000994:	00000097          	auipc	ra,0x0
    80000998:	ee4080e7          	jalr	-284(ra) # 80000878 <walk>
    8000099c:	fea43423          	sd	a0,-24(s0)
  if(pte == 0)
    800009a0:	fe843783          	ld	a5,-24(s0)
    800009a4:	e399                	bnez	a5,800009aa <walkaddr+0x40>
    return 0;
    800009a6:	4781                	li	a5,0
    800009a8:	a805                	j	800009d8 <walkaddr+0x6e>
  if((*pte & PTE_V) == 0)
    800009aa:	fe843783          	ld	a5,-24(s0)
    800009ae:	639c                	ld	a5,0(a5)
    800009b0:	8b85                	andi	a5,a5,1
    800009b2:	e399                	bnez	a5,800009b8 <walkaddr+0x4e>
    return 0;
    800009b4:	4781                	li	a5,0
    800009b6:	a00d                	j	800009d8 <walkaddr+0x6e>
  if((*pte & PTE_U) == 0)
    800009b8:	fe843783          	ld	a5,-24(s0)
    800009bc:	639c                	ld	a5,0(a5)
    800009be:	8bc1                	andi	a5,a5,16
    800009c0:	e399                	bnez	a5,800009c6 <walkaddr+0x5c>
    return 0;
    800009c2:	4781                	li	a5,0
    800009c4:	a811                	j	800009d8 <walkaddr+0x6e>
  pa = PTE2PA(*pte);
    800009c6:	fe843783          	ld	a5,-24(s0)
    800009ca:	639c                	ld	a5,0(a5)
    800009cc:	83a9                	srli	a5,a5,0xa
    800009ce:	07b2                	slli	a5,a5,0xc
    800009d0:	fef43023          	sd	a5,-32(s0)
  return pa;
    800009d4:	fe043783          	ld	a5,-32(s0)
}
    800009d8:	853e                	mv	a0,a5
    800009da:	70a2                	ld	ra,40(sp)
    800009dc:	7402                	ld	s0,32(sp)
    800009de:	6145                	addi	sp,sp,48
    800009e0:	8082                	ret

00000000800009e2 <kvmmap>:
// add a mapping to the kernel page table.
// only used when booting.
// does not flush TLB or enable paging.
void
kvmmap(pagetable_t kpgtbl, uint64 va, uint64 pa, uint64 sz, int perm)
{
    800009e2:	7139                	addi	sp,sp,-64
    800009e4:	fc06                	sd	ra,56(sp)
    800009e6:	f822                	sd	s0,48(sp)
    800009e8:	0080                	addi	s0,sp,64
    800009ea:	fea43423          	sd	a0,-24(s0)
    800009ee:	feb43023          	sd	a1,-32(s0)
    800009f2:	fcc43c23          	sd	a2,-40(s0)
    800009f6:	fcd43823          	sd	a3,-48(s0)
    800009fa:	87ba                	mv	a5,a4
    800009fc:	fcf42623          	sw	a5,-52(s0)
  if(mappages(kpgtbl, va, sz, pa, perm) != 0)
    80000a00:	fcc42783          	lw	a5,-52(s0)
    80000a04:	873e                	mv	a4,a5
    80000a06:	fd843683          	ld	a3,-40(s0)
    80000a0a:	fd043603          	ld	a2,-48(s0)
    80000a0e:	fe043583          	ld	a1,-32(s0)
    80000a12:	fe843503          	ld	a0,-24(s0)
    80000a16:	00000097          	auipc	ra,0x0
    80000a1a:	026080e7          	jalr	38(ra) # 80000a3c <mappages>
    80000a1e:	87aa                	mv	a5,a0
    80000a20:	cb89                	beqz	a5,80000a32 <kvmmap+0x50>
    panic("kvmmap");
    80000a22:	0000a517          	auipc	a0,0xa
    80000a26:	62e50513          	addi	a0,a0,1582 # 8000b050 <etext+0x50>
    80000a2a:	00008097          	auipc	ra,0x8
    80000a2e:	50c080e7          	jalr	1292(ra) # 80008f36 <panic>
}
    80000a32:	0001                	nop
    80000a34:	70e2                	ld	ra,56(sp)
    80000a36:	7442                	ld	s0,48(sp)
    80000a38:	6121                	addi	sp,sp,64
    80000a3a:	8082                	ret

0000000080000a3c <mappages>:
// physical addresses starting at pa. va and size might not
// be page-aligned. Returns 0 on success, -1 if walk() couldn't
// allocate a needed page-table page.
int
mappages(pagetable_t pagetable, uint64 va, uint64 size, uint64 pa, int perm)
{
    80000a3c:	711d                	addi	sp,sp,-96
    80000a3e:	ec86                	sd	ra,88(sp)
    80000a40:	e8a2                	sd	s0,80(sp)
    80000a42:	1080                	addi	s0,sp,96
    80000a44:	fca43423          	sd	a0,-56(s0)
    80000a48:	fcb43023          	sd	a1,-64(s0)
    80000a4c:	fac43c23          	sd	a2,-72(s0)
    80000a50:	fad43823          	sd	a3,-80(s0)
    80000a54:	87ba                	mv	a5,a4
    80000a56:	faf42623          	sw	a5,-84(s0)
  uint64 a, last;
  pte_t *pte;

  if(size == 0)
    80000a5a:	fb843783          	ld	a5,-72(s0)
    80000a5e:	eb89                	bnez	a5,80000a70 <mappages+0x34>
    panic("mappages: size");
    80000a60:	0000a517          	auipc	a0,0xa
    80000a64:	5f850513          	addi	a0,a0,1528 # 8000b058 <etext+0x58>
    80000a68:	00008097          	auipc	ra,0x8
    80000a6c:	4ce080e7          	jalr	1230(ra) # 80008f36 <panic>
  
  a = PGROUNDDOWN(va);
    80000a70:	fc043703          	ld	a4,-64(s0)
    80000a74:	77fd                	lui	a5,0xfffff
    80000a76:	8ff9                	and	a5,a5,a4
    80000a78:	fef43423          	sd	a5,-24(s0)
  last = PGROUNDDOWN(va + size - 1);
    80000a7c:	fc043703          	ld	a4,-64(s0)
    80000a80:	fb843783          	ld	a5,-72(s0)
    80000a84:	97ba                	add	a5,a5,a4
    80000a86:	fff78713          	addi	a4,a5,-1 # ffffffffffffefff <end+0xffffffff7ffd9f0f>
    80000a8a:	77fd                	lui	a5,0xfffff
    80000a8c:	8ff9                	and	a5,a5,a4
    80000a8e:	fef43023          	sd	a5,-32(s0)
  for(;;){
    if((pte = walk(pagetable, a, 1)) == 0)
    80000a92:	4605                	li	a2,1
    80000a94:	fe843583          	ld	a1,-24(s0)
    80000a98:	fc843503          	ld	a0,-56(s0)
    80000a9c:	00000097          	auipc	ra,0x0
    80000aa0:	ddc080e7          	jalr	-548(ra) # 80000878 <walk>
    80000aa4:	fca43c23          	sd	a0,-40(s0)
    80000aa8:	fd843783          	ld	a5,-40(s0)
    80000aac:	e399                	bnez	a5,80000ab2 <mappages+0x76>
      return -1;
    80000aae:	57fd                	li	a5,-1
    80000ab0:	a085                	j	80000b10 <mappages+0xd4>
    if(*pte & PTE_V)
    80000ab2:	fd843783          	ld	a5,-40(s0)
    80000ab6:	639c                	ld	a5,0(a5)
    80000ab8:	8b85                	andi	a5,a5,1
    80000aba:	cb89                	beqz	a5,80000acc <mappages+0x90>
      panic("mappages: remap");
    80000abc:	0000a517          	auipc	a0,0xa
    80000ac0:	5ac50513          	addi	a0,a0,1452 # 8000b068 <etext+0x68>
    80000ac4:	00008097          	auipc	ra,0x8
    80000ac8:	472080e7          	jalr	1138(ra) # 80008f36 <panic>
    *pte = PA2PTE(pa) | perm | PTE_V;
    80000acc:	fb043783          	ld	a5,-80(s0)
    80000ad0:	83b1                	srli	a5,a5,0xc
    80000ad2:	00a79713          	slli	a4,a5,0xa
    80000ad6:	fac42783          	lw	a5,-84(s0)
    80000ada:	8fd9                	or	a5,a5,a4
    80000adc:	0017e713          	ori	a4,a5,1
    80000ae0:	fd843783          	ld	a5,-40(s0)
    80000ae4:	e398                	sd	a4,0(a5)
    if(a == last)
    80000ae6:	fe843703          	ld	a4,-24(s0)
    80000aea:	fe043783          	ld	a5,-32(s0)
    80000aee:	00f70f63          	beq	a4,a5,80000b0c <mappages+0xd0>
      break;
    a += PGSIZE;
    80000af2:	fe843703          	ld	a4,-24(s0)
    80000af6:	6785                	lui	a5,0x1
    80000af8:	97ba                	add	a5,a5,a4
    80000afa:	fef43423          	sd	a5,-24(s0)
    pa += PGSIZE;
    80000afe:	fb043703          	ld	a4,-80(s0)
    80000b02:	6785                	lui	a5,0x1
    80000b04:	97ba                	add	a5,a5,a4
    80000b06:	faf43823          	sd	a5,-80(s0)
    if((pte = walk(pagetable, a, 1)) == 0)
    80000b0a:	b761                	j	80000a92 <mappages+0x56>
      break;
    80000b0c:	0001                	nop
  }
  return 0;
    80000b0e:	4781                	li	a5,0
}
    80000b10:	853e                	mv	a0,a5
    80000b12:	60e6                	ld	ra,88(sp)
    80000b14:	6446                	ld	s0,80(sp)
    80000b16:	6125                	addi	sp,sp,96
    80000b18:	8082                	ret

0000000080000b1a <uvmunmap>:
// Remove npages of mappings starting from va. va must be
// page-aligned. The mappings must exist.
// Optionally free the physical memory.
void
uvmunmap(pagetable_t pagetable, uint64 va, uint64 npages, int do_free)
{
    80000b1a:	715d                	addi	sp,sp,-80
    80000b1c:	e486                	sd	ra,72(sp)
    80000b1e:	e0a2                	sd	s0,64(sp)
    80000b20:	0880                	addi	s0,sp,80
    80000b22:	fca43423          	sd	a0,-56(s0)
    80000b26:	fcb43023          	sd	a1,-64(s0)
    80000b2a:	fac43c23          	sd	a2,-72(s0)
    80000b2e:	87b6                	mv	a5,a3
    80000b30:	faf42a23          	sw	a5,-76(s0)
  uint64 a;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    80000b34:	fc043703          	ld	a4,-64(s0)
    80000b38:	6785                	lui	a5,0x1
    80000b3a:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    80000b3c:	8ff9                	and	a5,a5,a4
    80000b3e:	cb89                	beqz	a5,80000b50 <uvmunmap+0x36>
    panic("uvmunmap: not aligned");
    80000b40:	0000a517          	auipc	a0,0xa
    80000b44:	53850513          	addi	a0,a0,1336 # 8000b078 <etext+0x78>
    80000b48:	00008097          	auipc	ra,0x8
    80000b4c:	3ee080e7          	jalr	1006(ra) # 80008f36 <panic>

  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80000b50:	fc043783          	ld	a5,-64(s0)
    80000b54:	fef43423          	sd	a5,-24(s0)
    80000b58:	a045                	j	80000bf8 <uvmunmap+0xde>
    if((pte = walk(pagetable, a, 0)) == 0)
    80000b5a:	4601                	li	a2,0
    80000b5c:	fe843583          	ld	a1,-24(s0)
    80000b60:	fc843503          	ld	a0,-56(s0)
    80000b64:	00000097          	auipc	ra,0x0
    80000b68:	d14080e7          	jalr	-748(ra) # 80000878 <walk>
    80000b6c:	fea43023          	sd	a0,-32(s0)
    80000b70:	fe043783          	ld	a5,-32(s0)
    80000b74:	eb89                	bnez	a5,80000b86 <uvmunmap+0x6c>
      panic("uvmunmap: walk");
    80000b76:	0000a517          	auipc	a0,0xa
    80000b7a:	51a50513          	addi	a0,a0,1306 # 8000b090 <etext+0x90>
    80000b7e:	00008097          	auipc	ra,0x8
    80000b82:	3b8080e7          	jalr	952(ra) # 80008f36 <panic>
    if((*pte & PTE_V) == 0)
    80000b86:	fe043783          	ld	a5,-32(s0)
    80000b8a:	639c                	ld	a5,0(a5)
    80000b8c:	8b85                	andi	a5,a5,1
    80000b8e:	eb89                	bnez	a5,80000ba0 <uvmunmap+0x86>
      panic("uvmunmap: not mapped");
    80000b90:	0000a517          	auipc	a0,0xa
    80000b94:	51050513          	addi	a0,a0,1296 # 8000b0a0 <etext+0xa0>
    80000b98:	00008097          	auipc	ra,0x8
    80000b9c:	39e080e7          	jalr	926(ra) # 80008f36 <panic>
    if(PTE_FLAGS(*pte) == PTE_V)
    80000ba0:	fe043783          	ld	a5,-32(s0)
    80000ba4:	639c                	ld	a5,0(a5)
    80000ba6:	3ff7f713          	andi	a4,a5,1023
    80000baa:	4785                	li	a5,1
    80000bac:	00f71a63          	bne	a4,a5,80000bc0 <uvmunmap+0xa6>
      panic("uvmunmap: not a leaf");
    80000bb0:	0000a517          	auipc	a0,0xa
    80000bb4:	50850513          	addi	a0,a0,1288 # 8000b0b8 <etext+0xb8>
    80000bb8:	00008097          	auipc	ra,0x8
    80000bbc:	37e080e7          	jalr	894(ra) # 80008f36 <panic>
    if(do_free){
    80000bc0:	fb442783          	lw	a5,-76(s0)
    80000bc4:	2781                	sext.w	a5,a5
    80000bc6:	cf99                	beqz	a5,80000be4 <uvmunmap+0xca>
      uint64 pa = PTE2PA(*pte);
    80000bc8:	fe043783          	ld	a5,-32(s0)
    80000bcc:	639c                	ld	a5,0(a5)
    80000bce:	83a9                	srli	a5,a5,0xa
    80000bd0:	07b2                	slli	a5,a5,0xc
    80000bd2:	fcf43c23          	sd	a5,-40(s0)
      kfree((void*)pa);
    80000bd6:	fd843783          	ld	a5,-40(s0)
    80000bda:	853e                	mv	a0,a5
    80000bdc:	fffff097          	auipc	ra,0xfffff
    80000be0:	4d8080e7          	jalr	1240(ra) # 800000b4 <kfree>
    }
    *pte = 0;
    80000be4:	fe043783          	ld	a5,-32(s0)
    80000be8:	0007b023          	sd	zero,0(a5)
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80000bec:	fe843703          	ld	a4,-24(s0)
    80000bf0:	6785                	lui	a5,0x1
    80000bf2:	97ba                	add	a5,a5,a4
    80000bf4:	fef43423          	sd	a5,-24(s0)
    80000bf8:	fb843783          	ld	a5,-72(s0)
    80000bfc:	00c79713          	slli	a4,a5,0xc
    80000c00:	fc043783          	ld	a5,-64(s0)
    80000c04:	97ba                	add	a5,a5,a4
    80000c06:	fe843703          	ld	a4,-24(s0)
    80000c0a:	f4f768e3          	bltu	a4,a5,80000b5a <uvmunmap+0x40>
  }
}
    80000c0e:	0001                	nop
    80000c10:	0001                	nop
    80000c12:	60a6                	ld	ra,72(sp)
    80000c14:	6406                	ld	s0,64(sp)
    80000c16:	6161                	addi	sp,sp,80
    80000c18:	8082                	ret

0000000080000c1a <uvmcreate>:

// create an empty user page table.
// returns 0 if out of memory.
pagetable_t
uvmcreate()
{
    80000c1a:	1101                	addi	sp,sp,-32
    80000c1c:	ec06                	sd	ra,24(sp)
    80000c1e:	e822                	sd	s0,16(sp)
    80000c20:	1000                	addi	s0,sp,32
  pagetable_t pagetable;
  pagetable = (pagetable_t) kalloc();
    80000c22:	fffff097          	auipc	ra,0xfffff
    80000c26:	536080e7          	jalr	1334(ra) # 80000158 <kalloc>
    80000c2a:	fea43423          	sd	a0,-24(s0)
  if(pagetable == 0)
    80000c2e:	fe843783          	ld	a5,-24(s0)
    80000c32:	e399                	bnez	a5,80000c38 <uvmcreate+0x1e>
    return 0;
    80000c34:	4781                	li	a5,0
    80000c36:	a819                	j	80000c4c <uvmcreate+0x32>
  memset(pagetable, 0, PGSIZE);
    80000c38:	6605                	lui	a2,0x1
    80000c3a:	4581                	li	a1,0
    80000c3c:	fe843503          	ld	a0,-24(s0)
    80000c40:	fffff097          	auipc	ra,0xfffff
    80000c44:	5cc080e7          	jalr	1484(ra) # 8000020c <memset>
  return pagetable;
    80000c48:	fe843783          	ld	a5,-24(s0)
}
    80000c4c:	853e                	mv	a0,a5
    80000c4e:	60e2                	ld	ra,24(sp)
    80000c50:	6442                	ld	s0,16(sp)
    80000c52:	6105                	addi	sp,sp,32
    80000c54:	8082                	ret

0000000080000c56 <uvmfirst>:
// Load the user initcode into address 0 of pagetable,
// for the very first process.
// sz must be less than a page.
void
uvmfirst(pagetable_t pagetable, uchar *src, uint sz)
{
    80000c56:	7139                	addi	sp,sp,-64
    80000c58:	fc06                	sd	ra,56(sp)
    80000c5a:	f822                	sd	s0,48(sp)
    80000c5c:	0080                	addi	s0,sp,64
    80000c5e:	fca43c23          	sd	a0,-40(s0)
    80000c62:	fcb43823          	sd	a1,-48(s0)
    80000c66:	87b2                	mv	a5,a2
    80000c68:	fcf42623          	sw	a5,-52(s0)
  char *mem;

  if(sz >= PGSIZE)
    80000c6c:	fcc42783          	lw	a5,-52(s0)
    80000c70:	0007871b          	sext.w	a4,a5
    80000c74:	6785                	lui	a5,0x1
    80000c76:	00f76a63          	bltu	a4,a5,80000c8a <uvmfirst+0x34>
    panic("uvmfirst: more than a page");
    80000c7a:	0000a517          	auipc	a0,0xa
    80000c7e:	45650513          	addi	a0,a0,1110 # 8000b0d0 <etext+0xd0>
    80000c82:	00008097          	auipc	ra,0x8
    80000c86:	2b4080e7          	jalr	692(ra) # 80008f36 <panic>
  mem = kalloc();
    80000c8a:	fffff097          	auipc	ra,0xfffff
    80000c8e:	4ce080e7          	jalr	1230(ra) # 80000158 <kalloc>
    80000c92:	fea43423          	sd	a0,-24(s0)
  memset(mem, 0, PGSIZE);
    80000c96:	6605                	lui	a2,0x1
    80000c98:	4581                	li	a1,0
    80000c9a:	fe843503          	ld	a0,-24(s0)
    80000c9e:	fffff097          	auipc	ra,0xfffff
    80000ca2:	56e080e7          	jalr	1390(ra) # 8000020c <memset>
  mappages(pagetable, 0, PGSIZE, (uint64)mem, PTE_W|PTE_R|PTE_X|PTE_U);
    80000ca6:	fe843783          	ld	a5,-24(s0)
    80000caa:	4779                	li	a4,30
    80000cac:	86be                	mv	a3,a5
    80000cae:	6605                	lui	a2,0x1
    80000cb0:	4581                	li	a1,0
    80000cb2:	fd843503          	ld	a0,-40(s0)
    80000cb6:	00000097          	auipc	ra,0x0
    80000cba:	d86080e7          	jalr	-634(ra) # 80000a3c <mappages>
  memmove(mem, src, sz);
    80000cbe:	fcc42783          	lw	a5,-52(s0)
    80000cc2:	863e                	mv	a2,a5
    80000cc4:	fd043583          	ld	a1,-48(s0)
    80000cc8:	fe843503          	ld	a0,-24(s0)
    80000ccc:	fffff097          	auipc	ra,0xfffff
    80000cd0:	624080e7          	jalr	1572(ra) # 800002f0 <memmove>
}
    80000cd4:	0001                	nop
    80000cd6:	70e2                	ld	ra,56(sp)
    80000cd8:	7442                	ld	s0,48(sp)
    80000cda:	6121                	addi	sp,sp,64
    80000cdc:	8082                	ret

0000000080000cde <uvmalloc>:

// Allocate PTEs and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
uint64
uvmalloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz, int xperm)
{
    80000cde:	7139                	addi	sp,sp,-64
    80000ce0:	fc06                	sd	ra,56(sp)
    80000ce2:	f822                	sd	s0,48(sp)
    80000ce4:	0080                	addi	s0,sp,64
    80000ce6:	fca43c23          	sd	a0,-40(s0)
    80000cea:	fcb43823          	sd	a1,-48(s0)
    80000cee:	fcc43423          	sd	a2,-56(s0)
    80000cf2:	87b6                	mv	a5,a3
    80000cf4:	fcf42223          	sw	a5,-60(s0)
  char *mem;
  uint64 a;

  if(newsz < oldsz)
    80000cf8:	fc843703          	ld	a4,-56(s0)
    80000cfc:	fd043783          	ld	a5,-48(s0)
    80000d00:	00f77563          	bgeu	a4,a5,80000d0a <uvmalloc+0x2c>
    return oldsz;
    80000d04:	fd043783          	ld	a5,-48(s0)
    80000d08:	a87d                	j	80000dc6 <uvmalloc+0xe8>

  oldsz = PGROUNDUP(oldsz);
    80000d0a:	fd043703          	ld	a4,-48(s0)
    80000d0e:	6785                	lui	a5,0x1
    80000d10:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    80000d12:	973e                	add	a4,a4,a5
    80000d14:	77fd                	lui	a5,0xfffff
    80000d16:	8ff9                	and	a5,a5,a4
    80000d18:	fcf43823          	sd	a5,-48(s0)
  for(a = oldsz; a < newsz; a += PGSIZE){
    80000d1c:	fd043783          	ld	a5,-48(s0)
    80000d20:	fef43423          	sd	a5,-24(s0)
    80000d24:	a849                	j	80000db6 <uvmalloc+0xd8>
    mem = kalloc();
    80000d26:	fffff097          	auipc	ra,0xfffff
    80000d2a:	432080e7          	jalr	1074(ra) # 80000158 <kalloc>
    80000d2e:	fea43023          	sd	a0,-32(s0)
    if(mem == 0){
    80000d32:	fe043783          	ld	a5,-32(s0)
    80000d36:	ef89                	bnez	a5,80000d50 <uvmalloc+0x72>
      uvmdealloc(pagetable, a, oldsz);
    80000d38:	fd043603          	ld	a2,-48(s0)
    80000d3c:	fe843583          	ld	a1,-24(s0)
    80000d40:	fd843503          	ld	a0,-40(s0)
    80000d44:	00000097          	auipc	ra,0x0
    80000d48:	08c080e7          	jalr	140(ra) # 80000dd0 <uvmdealloc>
      return 0;
    80000d4c:	4781                	li	a5,0
    80000d4e:	a8a5                	j	80000dc6 <uvmalloc+0xe8>
    }
    memset(mem, 0, PGSIZE);
    80000d50:	6605                	lui	a2,0x1
    80000d52:	4581                	li	a1,0
    80000d54:	fe043503          	ld	a0,-32(s0)
    80000d58:	fffff097          	auipc	ra,0xfffff
    80000d5c:	4b4080e7          	jalr	1204(ra) # 8000020c <memset>
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_R|PTE_U|xperm) != 0){
    80000d60:	fe043783          	ld	a5,-32(s0)
    80000d64:	fc442703          	lw	a4,-60(s0)
    80000d68:	01276713          	ori	a4,a4,18
    80000d6c:	2701                	sext.w	a4,a4
    80000d6e:	86be                	mv	a3,a5
    80000d70:	6605                	lui	a2,0x1
    80000d72:	fe843583          	ld	a1,-24(s0)
    80000d76:	fd843503          	ld	a0,-40(s0)
    80000d7a:	00000097          	auipc	ra,0x0
    80000d7e:	cc2080e7          	jalr	-830(ra) # 80000a3c <mappages>
    80000d82:	87aa                	mv	a5,a0
    80000d84:	c39d                	beqz	a5,80000daa <uvmalloc+0xcc>
      kfree(mem);
    80000d86:	fe043503          	ld	a0,-32(s0)
    80000d8a:	fffff097          	auipc	ra,0xfffff
    80000d8e:	32a080e7          	jalr	810(ra) # 800000b4 <kfree>
      uvmdealloc(pagetable, a, oldsz);
    80000d92:	fd043603          	ld	a2,-48(s0)
    80000d96:	fe843583          	ld	a1,-24(s0)
    80000d9a:	fd843503          	ld	a0,-40(s0)
    80000d9e:	00000097          	auipc	ra,0x0
    80000da2:	032080e7          	jalr	50(ra) # 80000dd0 <uvmdealloc>
      return 0;
    80000da6:	4781                	li	a5,0
    80000da8:	a839                	j	80000dc6 <uvmalloc+0xe8>
  for(a = oldsz; a < newsz; a += PGSIZE){
    80000daa:	fe843703          	ld	a4,-24(s0)
    80000dae:	6785                	lui	a5,0x1
    80000db0:	97ba                	add	a5,a5,a4
    80000db2:	fef43423          	sd	a5,-24(s0)
    80000db6:	fe843703          	ld	a4,-24(s0)
    80000dba:	fc843783          	ld	a5,-56(s0)
    80000dbe:	f6f764e3          	bltu	a4,a5,80000d26 <uvmalloc+0x48>
    }
  }
  return newsz;
    80000dc2:	fc843783          	ld	a5,-56(s0)
}
    80000dc6:	853e                	mv	a0,a5
    80000dc8:	70e2                	ld	ra,56(sp)
    80000dca:	7442                	ld	s0,48(sp)
    80000dcc:	6121                	addi	sp,sp,64
    80000dce:	8082                	ret

0000000080000dd0 <uvmdealloc>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
uvmdealloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz)
{
    80000dd0:	7139                	addi	sp,sp,-64
    80000dd2:	fc06                	sd	ra,56(sp)
    80000dd4:	f822                	sd	s0,48(sp)
    80000dd6:	0080                	addi	s0,sp,64
    80000dd8:	fca43c23          	sd	a0,-40(s0)
    80000ddc:	fcb43823          	sd	a1,-48(s0)
    80000de0:	fcc43423          	sd	a2,-56(s0)
  if(newsz >= oldsz)
    80000de4:	fc843703          	ld	a4,-56(s0)
    80000de8:	fd043783          	ld	a5,-48(s0)
    80000dec:	00f76563          	bltu	a4,a5,80000df6 <uvmdealloc+0x26>
    return oldsz;
    80000df0:	fd043783          	ld	a5,-48(s0)
    80000df4:	a885                	j	80000e64 <uvmdealloc+0x94>

  if(PGROUNDUP(newsz) < PGROUNDUP(oldsz)){
    80000df6:	fc843703          	ld	a4,-56(s0)
    80000dfa:	6785                	lui	a5,0x1
    80000dfc:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    80000dfe:	973e                	add	a4,a4,a5
    80000e00:	77fd                	lui	a5,0xfffff
    80000e02:	8f7d                	and	a4,a4,a5
    80000e04:	fd043683          	ld	a3,-48(s0)
    80000e08:	6785                	lui	a5,0x1
    80000e0a:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    80000e0c:	96be                	add	a3,a3,a5
    80000e0e:	77fd                	lui	a5,0xfffff
    80000e10:	8ff5                	and	a5,a5,a3
    80000e12:	04f77763          	bgeu	a4,a5,80000e60 <uvmdealloc+0x90>
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    80000e16:	fd043703          	ld	a4,-48(s0)
    80000e1a:	6785                	lui	a5,0x1
    80000e1c:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    80000e1e:	973e                	add	a4,a4,a5
    80000e20:	77fd                	lui	a5,0xfffff
    80000e22:	8f7d                	and	a4,a4,a5
    80000e24:	fc843683          	ld	a3,-56(s0)
    80000e28:	6785                	lui	a5,0x1
    80000e2a:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    80000e2c:	96be                	add	a3,a3,a5
    80000e2e:	77fd                	lui	a5,0xfffff
    80000e30:	8ff5                	and	a5,a5,a3
    80000e32:	40f707b3          	sub	a5,a4,a5
    80000e36:	83b1                	srli	a5,a5,0xc
    80000e38:	fef42623          	sw	a5,-20(s0)
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
    80000e3c:	fc843703          	ld	a4,-56(s0)
    80000e40:	6785                	lui	a5,0x1
    80000e42:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    80000e44:	973e                	add	a4,a4,a5
    80000e46:	77fd                	lui	a5,0xfffff
    80000e48:	8ff9                	and	a5,a5,a4
    80000e4a:	fec42703          	lw	a4,-20(s0)
    80000e4e:	4685                	li	a3,1
    80000e50:	863a                	mv	a2,a4
    80000e52:	85be                	mv	a1,a5
    80000e54:	fd843503          	ld	a0,-40(s0)
    80000e58:	00000097          	auipc	ra,0x0
    80000e5c:	cc2080e7          	jalr	-830(ra) # 80000b1a <uvmunmap>
  }

  return newsz;
    80000e60:	fc843783          	ld	a5,-56(s0)
}
    80000e64:	853e                	mv	a0,a5
    80000e66:	70e2                	ld	ra,56(sp)
    80000e68:	7442                	ld	s0,48(sp)
    80000e6a:	6121                	addi	sp,sp,64
    80000e6c:	8082                	ret

0000000080000e6e <freewalk>:

// Recursively free page-table pages.
// All leaf mappings must already have been removed.
void
freewalk(pagetable_t pagetable)
{
    80000e6e:	7139                	addi	sp,sp,-64
    80000e70:	fc06                	sd	ra,56(sp)
    80000e72:	f822                	sd	s0,48(sp)
    80000e74:	0080                	addi	s0,sp,64
    80000e76:	fca43423          	sd	a0,-56(s0)
  // there are 2^9 = 512 PTEs in a page table.
  for(int i = 0; i < 512; i++){
    80000e7a:	fe042623          	sw	zero,-20(s0)
    80000e7e:	a88d                	j	80000ef0 <freewalk+0x82>
    pte_t pte = pagetable[i];
    80000e80:	fec42783          	lw	a5,-20(s0)
    80000e84:	078e                	slli	a5,a5,0x3
    80000e86:	fc843703          	ld	a4,-56(s0)
    80000e8a:	97ba                	add	a5,a5,a4
    80000e8c:	639c                	ld	a5,0(a5)
    80000e8e:	fef43023          	sd	a5,-32(s0)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    80000e92:	fe043783          	ld	a5,-32(s0)
    80000e96:	8b85                	andi	a5,a5,1
    80000e98:	cb9d                	beqz	a5,80000ece <freewalk+0x60>
    80000e9a:	fe043783          	ld	a5,-32(s0)
    80000e9e:	8bb9                	andi	a5,a5,14
    80000ea0:	e79d                	bnez	a5,80000ece <freewalk+0x60>
      // this PTE points to a lower-level page table.
      uint64 child = PTE2PA(pte);
    80000ea2:	fe043783          	ld	a5,-32(s0)
    80000ea6:	83a9                	srli	a5,a5,0xa
    80000ea8:	07b2                	slli	a5,a5,0xc
    80000eaa:	fcf43c23          	sd	a5,-40(s0)
      freewalk((pagetable_t)child);
    80000eae:	fd843783          	ld	a5,-40(s0)
    80000eb2:	853e                	mv	a0,a5
    80000eb4:	00000097          	auipc	ra,0x0
    80000eb8:	fba080e7          	jalr	-70(ra) # 80000e6e <freewalk>
      pagetable[i] = 0;
    80000ebc:	fec42783          	lw	a5,-20(s0)
    80000ec0:	078e                	slli	a5,a5,0x3
    80000ec2:	fc843703          	ld	a4,-56(s0)
    80000ec6:	97ba                	add	a5,a5,a4
    80000ec8:	0007b023          	sd	zero,0(a5) # fffffffffffff000 <end+0xffffffff7ffd9f10>
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    80000ecc:	a829                	j	80000ee6 <freewalk+0x78>
    } else if(pte & PTE_V){
    80000ece:	fe043783          	ld	a5,-32(s0)
    80000ed2:	8b85                	andi	a5,a5,1
    80000ed4:	cb89                	beqz	a5,80000ee6 <freewalk+0x78>
      panic("freewalk: leaf");
    80000ed6:	0000a517          	auipc	a0,0xa
    80000eda:	21a50513          	addi	a0,a0,538 # 8000b0f0 <etext+0xf0>
    80000ede:	00008097          	auipc	ra,0x8
    80000ee2:	058080e7          	jalr	88(ra) # 80008f36 <panic>
  for(int i = 0; i < 512; i++){
    80000ee6:	fec42783          	lw	a5,-20(s0)
    80000eea:	2785                	addiw	a5,a5,1
    80000eec:	fef42623          	sw	a5,-20(s0)
    80000ef0:	fec42783          	lw	a5,-20(s0)
    80000ef4:	0007871b          	sext.w	a4,a5
    80000ef8:	1ff00793          	li	a5,511
    80000efc:	f8e7d2e3          	bge	a5,a4,80000e80 <freewalk+0x12>
    }
  }
  kfree((void*)pagetable);
    80000f00:	fc843503          	ld	a0,-56(s0)
    80000f04:	fffff097          	auipc	ra,0xfffff
    80000f08:	1b0080e7          	jalr	432(ra) # 800000b4 <kfree>
}
    80000f0c:	0001                	nop
    80000f0e:	70e2                	ld	ra,56(sp)
    80000f10:	7442                	ld	s0,48(sp)
    80000f12:	6121                	addi	sp,sp,64
    80000f14:	8082                	ret

0000000080000f16 <uvmfree>:

// Free user memory pages,
// then free page-table pages.
void
uvmfree(pagetable_t pagetable, uint64 sz)
{
    80000f16:	1101                	addi	sp,sp,-32
    80000f18:	ec06                	sd	ra,24(sp)
    80000f1a:	e822                	sd	s0,16(sp)
    80000f1c:	1000                	addi	s0,sp,32
    80000f1e:	fea43423          	sd	a0,-24(s0)
    80000f22:	feb43023          	sd	a1,-32(s0)
  if(sz > 0)
    80000f26:	fe043783          	ld	a5,-32(s0)
    80000f2a:	c385                	beqz	a5,80000f4a <uvmfree+0x34>
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
    80000f2c:	fe043703          	ld	a4,-32(s0)
    80000f30:	6785                	lui	a5,0x1
    80000f32:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    80000f34:	97ba                	add	a5,a5,a4
    80000f36:	83b1                	srli	a5,a5,0xc
    80000f38:	4685                	li	a3,1
    80000f3a:	863e                	mv	a2,a5
    80000f3c:	4581                	li	a1,0
    80000f3e:	fe843503          	ld	a0,-24(s0)
    80000f42:	00000097          	auipc	ra,0x0
    80000f46:	bd8080e7          	jalr	-1064(ra) # 80000b1a <uvmunmap>
  freewalk(pagetable);
    80000f4a:	fe843503          	ld	a0,-24(s0)
    80000f4e:	00000097          	auipc	ra,0x0
    80000f52:	f20080e7          	jalr	-224(ra) # 80000e6e <freewalk>
}
    80000f56:	0001                	nop
    80000f58:	60e2                	ld	ra,24(sp)
    80000f5a:	6442                	ld	s0,16(sp)
    80000f5c:	6105                	addi	sp,sp,32
    80000f5e:	8082                	ret

0000000080000f60 <uvmcopy>:
// physical memory.
// returns 0 on success, -1 on failure.
// frees any allocated pages on failure.
int
uvmcopy(pagetable_t old, pagetable_t new, uint64 sz)
{
    80000f60:	711d                	addi	sp,sp,-96
    80000f62:	ec86                	sd	ra,88(sp)
    80000f64:	e8a2                	sd	s0,80(sp)
    80000f66:	1080                	addi	s0,sp,96
    80000f68:	faa43c23          	sd	a0,-72(s0)
    80000f6c:	fab43823          	sd	a1,-80(s0)
    80000f70:	fac43423          	sd	a2,-88(s0)
  pte_t *pte;
  uint64 pa, i;
  uint flags;
  char *mem;

  for(i = 0; i < sz; i += PGSIZE){
    80000f74:	fe043423          	sd	zero,-24(s0)
    80000f78:	a0d9                	j	8000103e <uvmcopy+0xde>
    if((pte = walk(old, i, 0)) == 0)
    80000f7a:	4601                	li	a2,0
    80000f7c:	fe843583          	ld	a1,-24(s0)
    80000f80:	fb843503          	ld	a0,-72(s0)
    80000f84:	00000097          	auipc	ra,0x0
    80000f88:	8f4080e7          	jalr	-1804(ra) # 80000878 <walk>
    80000f8c:	fea43023          	sd	a0,-32(s0)
    80000f90:	fe043783          	ld	a5,-32(s0)
    80000f94:	eb89                	bnez	a5,80000fa6 <uvmcopy+0x46>
      panic("uvmcopy: pte should exist");
    80000f96:	0000a517          	auipc	a0,0xa
    80000f9a:	16a50513          	addi	a0,a0,362 # 8000b100 <etext+0x100>
    80000f9e:	00008097          	auipc	ra,0x8
    80000fa2:	f98080e7          	jalr	-104(ra) # 80008f36 <panic>
    if((*pte & PTE_V) == 0)
    80000fa6:	fe043783          	ld	a5,-32(s0)
    80000faa:	639c                	ld	a5,0(a5)
    80000fac:	8b85                	andi	a5,a5,1
    80000fae:	eb89                	bnez	a5,80000fc0 <uvmcopy+0x60>
      panic("uvmcopy: page not present");
    80000fb0:	0000a517          	auipc	a0,0xa
    80000fb4:	17050513          	addi	a0,a0,368 # 8000b120 <etext+0x120>
    80000fb8:	00008097          	auipc	ra,0x8
    80000fbc:	f7e080e7          	jalr	-130(ra) # 80008f36 <panic>
    pa = PTE2PA(*pte);
    80000fc0:	fe043783          	ld	a5,-32(s0)
    80000fc4:	639c                	ld	a5,0(a5)
    80000fc6:	83a9                	srli	a5,a5,0xa
    80000fc8:	07b2                	slli	a5,a5,0xc
    80000fca:	fcf43c23          	sd	a5,-40(s0)
    flags = PTE_FLAGS(*pte);
    80000fce:	fe043783          	ld	a5,-32(s0)
    80000fd2:	639c                	ld	a5,0(a5)
    80000fd4:	2781                	sext.w	a5,a5
    80000fd6:	3ff7f793          	andi	a5,a5,1023
    80000fda:	fcf42a23          	sw	a5,-44(s0)
    if((mem = kalloc()) == 0)
    80000fde:	fffff097          	auipc	ra,0xfffff
    80000fe2:	17a080e7          	jalr	378(ra) # 80000158 <kalloc>
    80000fe6:	fca43423          	sd	a0,-56(s0)
    80000fea:	fc843783          	ld	a5,-56(s0)
    80000fee:	c3a5                	beqz	a5,8000104e <uvmcopy+0xee>
      goto err;
    memmove(mem, (char*)pa, PGSIZE);
    80000ff0:	fd843783          	ld	a5,-40(s0)
    80000ff4:	6605                	lui	a2,0x1
    80000ff6:	85be                	mv	a1,a5
    80000ff8:	fc843503          	ld	a0,-56(s0)
    80000ffc:	fffff097          	auipc	ra,0xfffff
    80001000:	2f4080e7          	jalr	756(ra) # 800002f0 <memmove>
    if(mappages(new, i, PGSIZE, (uint64)mem, flags) != 0){
    80001004:	fc843783          	ld	a5,-56(s0)
    80001008:	fd442703          	lw	a4,-44(s0)
    8000100c:	86be                	mv	a3,a5
    8000100e:	6605                	lui	a2,0x1
    80001010:	fe843583          	ld	a1,-24(s0)
    80001014:	fb043503          	ld	a0,-80(s0)
    80001018:	00000097          	auipc	ra,0x0
    8000101c:	a24080e7          	jalr	-1500(ra) # 80000a3c <mappages>
    80001020:	87aa                	mv	a5,a0
    80001022:	cb81                	beqz	a5,80001032 <uvmcopy+0xd2>
      kfree(mem);
    80001024:	fc843503          	ld	a0,-56(s0)
    80001028:	fffff097          	auipc	ra,0xfffff
    8000102c:	08c080e7          	jalr	140(ra) # 800000b4 <kfree>
      goto err;
    80001030:	a005                	j	80001050 <uvmcopy+0xf0>
  for(i = 0; i < sz; i += PGSIZE){
    80001032:	fe843703          	ld	a4,-24(s0)
    80001036:	6785                	lui	a5,0x1
    80001038:	97ba                	add	a5,a5,a4
    8000103a:	fef43423          	sd	a5,-24(s0)
    8000103e:	fe843703          	ld	a4,-24(s0)
    80001042:	fa843783          	ld	a5,-88(s0)
    80001046:	f2f76ae3          	bltu	a4,a5,80000f7a <uvmcopy+0x1a>
    }
  }
  return 0;
    8000104a:	4781                	li	a5,0
    8000104c:	a839                	j	8000106a <uvmcopy+0x10a>
      goto err;
    8000104e:	0001                	nop

 err:
  uvmunmap(new, 0, i / PGSIZE, 1);
    80001050:	fe843783          	ld	a5,-24(s0)
    80001054:	83b1                	srli	a5,a5,0xc
    80001056:	4685                	li	a3,1
    80001058:	863e                	mv	a2,a5
    8000105a:	4581                	li	a1,0
    8000105c:	fb043503          	ld	a0,-80(s0)
    80001060:	00000097          	auipc	ra,0x0
    80001064:	aba080e7          	jalr	-1350(ra) # 80000b1a <uvmunmap>
  return -1;
    80001068:	57fd                	li	a5,-1
}
    8000106a:	853e                	mv	a0,a5
    8000106c:	60e6                	ld	ra,88(sp)
    8000106e:	6446                	ld	s0,80(sp)
    80001070:	6125                	addi	sp,sp,96
    80001072:	8082                	ret

0000000080001074 <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard page.
void
uvmclear(pagetable_t pagetable, uint64 va)
{
    80001074:	7179                	addi	sp,sp,-48
    80001076:	f406                	sd	ra,40(sp)
    80001078:	f022                	sd	s0,32(sp)
    8000107a:	1800                	addi	s0,sp,48
    8000107c:	fca43c23          	sd	a0,-40(s0)
    80001080:	fcb43823          	sd	a1,-48(s0)
  pte_t *pte;
  
  pte = walk(pagetable, va, 0);
    80001084:	4601                	li	a2,0
    80001086:	fd043583          	ld	a1,-48(s0)
    8000108a:	fd843503          	ld	a0,-40(s0)
    8000108e:	fffff097          	auipc	ra,0xfffff
    80001092:	7ea080e7          	jalr	2026(ra) # 80000878 <walk>
    80001096:	fea43423          	sd	a0,-24(s0)
  if(pte == 0)
    8000109a:	fe843783          	ld	a5,-24(s0)
    8000109e:	eb89                	bnez	a5,800010b0 <uvmclear+0x3c>
    panic("uvmclear");
    800010a0:	0000a517          	auipc	a0,0xa
    800010a4:	0a050513          	addi	a0,a0,160 # 8000b140 <etext+0x140>
    800010a8:	00008097          	auipc	ra,0x8
    800010ac:	e8e080e7          	jalr	-370(ra) # 80008f36 <panic>
  *pte &= ~PTE_U;
    800010b0:	fe843783          	ld	a5,-24(s0)
    800010b4:	639c                	ld	a5,0(a5)
    800010b6:	fef7f713          	andi	a4,a5,-17
    800010ba:	fe843783          	ld	a5,-24(s0)
    800010be:	e398                	sd	a4,0(a5)
}
    800010c0:	0001                	nop
    800010c2:	70a2                	ld	ra,40(sp)
    800010c4:	7402                	ld	s0,32(sp)
    800010c6:	6145                	addi	sp,sp,48
    800010c8:	8082                	ret

00000000800010ca <copyout>:
// Copy from kernel to user.
// Copy len bytes from src to virtual address dstva in a given page table.
// Return 0 on success, -1 on error.
int
copyout(pagetable_t pagetable, uint64 dstva, char *src, uint64 len)
{
    800010ca:	715d                	addi	sp,sp,-80
    800010cc:	e486                	sd	ra,72(sp)
    800010ce:	e0a2                	sd	s0,64(sp)
    800010d0:	0880                	addi	s0,sp,80
    800010d2:	fca43423          	sd	a0,-56(s0)
    800010d6:	fcb43023          	sd	a1,-64(s0)
    800010da:	fac43c23          	sd	a2,-72(s0)
    800010de:	fad43823          	sd	a3,-80(s0)
  uint64 n, va0, pa0;

  while(len > 0){
    800010e2:	a055                	j	80001186 <copyout+0xbc>
    va0 = PGROUNDDOWN(dstva);
    800010e4:	fc043703          	ld	a4,-64(s0)
    800010e8:	77fd                	lui	a5,0xfffff
    800010ea:	8ff9                	and	a5,a5,a4
    800010ec:	fef43023          	sd	a5,-32(s0)
    pa0 = walkaddr(pagetable, va0);
    800010f0:	fe043583          	ld	a1,-32(s0)
    800010f4:	fc843503          	ld	a0,-56(s0)
    800010f8:	00000097          	auipc	ra,0x0
    800010fc:	872080e7          	jalr	-1934(ra) # 8000096a <walkaddr>
    80001100:	fca43c23          	sd	a0,-40(s0)
    if(pa0 == 0)
    80001104:	fd843783          	ld	a5,-40(s0)
    80001108:	e399                	bnez	a5,8000110e <copyout+0x44>
      return -1;
    8000110a:	57fd                	li	a5,-1
    8000110c:	a049                	j	8000118e <copyout+0xc4>
    n = PGSIZE - (dstva - va0);
    8000110e:	fe043703          	ld	a4,-32(s0)
    80001112:	fc043783          	ld	a5,-64(s0)
    80001116:	8f1d                	sub	a4,a4,a5
    80001118:	6785                	lui	a5,0x1
    8000111a:	97ba                	add	a5,a5,a4
    8000111c:	fef43423          	sd	a5,-24(s0)
    if(n > len)
    80001120:	fe843703          	ld	a4,-24(s0)
    80001124:	fb043783          	ld	a5,-80(s0)
    80001128:	00e7f663          	bgeu	a5,a4,80001134 <copyout+0x6a>
      n = len;
    8000112c:	fb043783          	ld	a5,-80(s0)
    80001130:	fef43423          	sd	a5,-24(s0)
    memmove((void *)(pa0 + (dstva - va0)), src, n);
    80001134:	fc043703          	ld	a4,-64(s0)
    80001138:	fe043783          	ld	a5,-32(s0)
    8000113c:	8f1d                	sub	a4,a4,a5
    8000113e:	fd843783          	ld	a5,-40(s0)
    80001142:	97ba                	add	a5,a5,a4
    80001144:	873e                	mv	a4,a5
    80001146:	fe843783          	ld	a5,-24(s0)
    8000114a:	2781                	sext.w	a5,a5
    8000114c:	863e                	mv	a2,a5
    8000114e:	fb843583          	ld	a1,-72(s0)
    80001152:	853a                	mv	a0,a4
    80001154:	fffff097          	auipc	ra,0xfffff
    80001158:	19c080e7          	jalr	412(ra) # 800002f0 <memmove>

    len -= n;
    8000115c:	fb043703          	ld	a4,-80(s0)
    80001160:	fe843783          	ld	a5,-24(s0)
    80001164:	40f707b3          	sub	a5,a4,a5
    80001168:	faf43823          	sd	a5,-80(s0)
    src += n;
    8000116c:	fb843703          	ld	a4,-72(s0)
    80001170:	fe843783          	ld	a5,-24(s0)
    80001174:	97ba                	add	a5,a5,a4
    80001176:	faf43c23          	sd	a5,-72(s0)
    dstva = va0 + PGSIZE;
    8000117a:	fe043703          	ld	a4,-32(s0)
    8000117e:	6785                	lui	a5,0x1
    80001180:	97ba                	add	a5,a5,a4
    80001182:	fcf43023          	sd	a5,-64(s0)
  while(len > 0){
    80001186:	fb043783          	ld	a5,-80(s0)
    8000118a:	ffa9                	bnez	a5,800010e4 <copyout+0x1a>
  }
  return 0;
    8000118c:	4781                	li	a5,0
}
    8000118e:	853e                	mv	a0,a5
    80001190:	60a6                	ld	ra,72(sp)
    80001192:	6406                	ld	s0,64(sp)
    80001194:	6161                	addi	sp,sp,80
    80001196:	8082                	ret

0000000080001198 <copyin>:
// Copy from user to kernel.
// Copy len bytes to dst from virtual address srcva in a given page table.
// Return 0 on success, -1 on error.
int
copyin(pagetable_t pagetable, char *dst, uint64 srcva, uint64 len)
{
    80001198:	715d                	addi	sp,sp,-80
    8000119a:	e486                	sd	ra,72(sp)
    8000119c:	e0a2                	sd	s0,64(sp)
    8000119e:	0880                	addi	s0,sp,80
    800011a0:	fca43423          	sd	a0,-56(s0)
    800011a4:	fcb43023          	sd	a1,-64(s0)
    800011a8:	fac43c23          	sd	a2,-72(s0)
    800011ac:	fad43823          	sd	a3,-80(s0)
  uint64 n, va0, pa0;

  while(len > 0){
    800011b0:	a055                	j	80001254 <copyin+0xbc>
    va0 = PGROUNDDOWN(srcva);
    800011b2:	fb843703          	ld	a4,-72(s0)
    800011b6:	77fd                	lui	a5,0xfffff
    800011b8:	8ff9                	and	a5,a5,a4
    800011ba:	fef43023          	sd	a5,-32(s0)
    pa0 = walkaddr(pagetable, va0);
    800011be:	fe043583          	ld	a1,-32(s0)
    800011c2:	fc843503          	ld	a0,-56(s0)
    800011c6:	fffff097          	auipc	ra,0xfffff
    800011ca:	7a4080e7          	jalr	1956(ra) # 8000096a <walkaddr>
    800011ce:	fca43c23          	sd	a0,-40(s0)
    if(pa0 == 0)
    800011d2:	fd843783          	ld	a5,-40(s0)
    800011d6:	e399                	bnez	a5,800011dc <copyin+0x44>
      return -1;
    800011d8:	57fd                	li	a5,-1
    800011da:	a049                	j	8000125c <copyin+0xc4>
    n = PGSIZE - (srcva - va0);
    800011dc:	fe043703          	ld	a4,-32(s0)
    800011e0:	fb843783          	ld	a5,-72(s0)
    800011e4:	8f1d                	sub	a4,a4,a5
    800011e6:	6785                	lui	a5,0x1
    800011e8:	97ba                	add	a5,a5,a4
    800011ea:	fef43423          	sd	a5,-24(s0)
    if(n > len)
    800011ee:	fe843703          	ld	a4,-24(s0)
    800011f2:	fb043783          	ld	a5,-80(s0)
    800011f6:	00e7f663          	bgeu	a5,a4,80001202 <copyin+0x6a>
      n = len;
    800011fa:	fb043783          	ld	a5,-80(s0)
    800011fe:	fef43423          	sd	a5,-24(s0)
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    80001202:	fb843703          	ld	a4,-72(s0)
    80001206:	fe043783          	ld	a5,-32(s0)
    8000120a:	8f1d                	sub	a4,a4,a5
    8000120c:	fd843783          	ld	a5,-40(s0)
    80001210:	97ba                	add	a5,a5,a4
    80001212:	873e                	mv	a4,a5
    80001214:	fe843783          	ld	a5,-24(s0)
    80001218:	2781                	sext.w	a5,a5
    8000121a:	863e                	mv	a2,a5
    8000121c:	85ba                	mv	a1,a4
    8000121e:	fc043503          	ld	a0,-64(s0)
    80001222:	fffff097          	auipc	ra,0xfffff
    80001226:	0ce080e7          	jalr	206(ra) # 800002f0 <memmove>

    len -= n;
    8000122a:	fb043703          	ld	a4,-80(s0)
    8000122e:	fe843783          	ld	a5,-24(s0)
    80001232:	40f707b3          	sub	a5,a4,a5
    80001236:	faf43823          	sd	a5,-80(s0)
    dst += n;
    8000123a:	fc043703          	ld	a4,-64(s0)
    8000123e:	fe843783          	ld	a5,-24(s0)
    80001242:	97ba                	add	a5,a5,a4
    80001244:	fcf43023          	sd	a5,-64(s0)
    srcva = va0 + PGSIZE;
    80001248:	fe043703          	ld	a4,-32(s0)
    8000124c:	6785                	lui	a5,0x1
    8000124e:	97ba                	add	a5,a5,a4
    80001250:	faf43c23          	sd	a5,-72(s0)
  while(len > 0){
    80001254:	fb043783          	ld	a5,-80(s0)
    80001258:	ffa9                	bnez	a5,800011b2 <copyin+0x1a>
  }
  return 0;
    8000125a:	4781                	li	a5,0
}
    8000125c:	853e                	mv	a0,a5
    8000125e:	60a6                	ld	ra,72(sp)
    80001260:	6406                	ld	s0,64(sp)
    80001262:	6161                	addi	sp,sp,80
    80001264:	8082                	ret

0000000080001266 <copyinstr>:
// Copy bytes to dst from virtual address srcva in a given page table,
// until a '\0', or max.
// Return 0 on success, -1 on error.
int
copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max)
{
    80001266:	711d                	addi	sp,sp,-96
    80001268:	ec86                	sd	ra,88(sp)
    8000126a:	e8a2                	sd	s0,80(sp)
    8000126c:	1080                	addi	s0,sp,96
    8000126e:	faa43c23          	sd	a0,-72(s0)
    80001272:	fab43823          	sd	a1,-80(s0)
    80001276:	fac43423          	sd	a2,-88(s0)
    8000127a:	fad43023          	sd	a3,-96(s0)
  uint64 n, va0, pa0;
  int got_null = 0;
    8000127e:	fe042223          	sw	zero,-28(s0)

  while(got_null == 0 && max > 0){
    80001282:	a0f1                	j	8000134e <copyinstr+0xe8>
    va0 = PGROUNDDOWN(srcva);
    80001284:	fa843703          	ld	a4,-88(s0)
    80001288:	77fd                	lui	a5,0xfffff
    8000128a:	8ff9                	and	a5,a5,a4
    8000128c:	fcf43823          	sd	a5,-48(s0)
    pa0 = walkaddr(pagetable, va0);
    80001290:	fd043583          	ld	a1,-48(s0)
    80001294:	fb843503          	ld	a0,-72(s0)
    80001298:	fffff097          	auipc	ra,0xfffff
    8000129c:	6d2080e7          	jalr	1746(ra) # 8000096a <walkaddr>
    800012a0:	fca43423          	sd	a0,-56(s0)
    if(pa0 == 0)
    800012a4:	fc843783          	ld	a5,-56(s0)
    800012a8:	e399                	bnez	a5,800012ae <copyinstr+0x48>
      return -1;
    800012aa:	57fd                	li	a5,-1
    800012ac:	a87d                	j	8000136a <copyinstr+0x104>
    n = PGSIZE - (srcva - va0);
    800012ae:	fd043703          	ld	a4,-48(s0)
    800012b2:	fa843783          	ld	a5,-88(s0)
    800012b6:	8f1d                	sub	a4,a4,a5
    800012b8:	6785                	lui	a5,0x1
    800012ba:	97ba                	add	a5,a5,a4
    800012bc:	fef43423          	sd	a5,-24(s0)
    if(n > max)
    800012c0:	fe843703          	ld	a4,-24(s0)
    800012c4:	fa043783          	ld	a5,-96(s0)
    800012c8:	00e7f663          	bgeu	a5,a4,800012d4 <copyinstr+0x6e>
      n = max;
    800012cc:	fa043783          	ld	a5,-96(s0)
    800012d0:	fef43423          	sd	a5,-24(s0)

    char *p = (char *) (pa0 + (srcva - va0));
    800012d4:	fa843703          	ld	a4,-88(s0)
    800012d8:	fd043783          	ld	a5,-48(s0)
    800012dc:	8f1d                	sub	a4,a4,a5
    800012de:	fc843783          	ld	a5,-56(s0)
    800012e2:	97ba                	add	a5,a5,a4
    800012e4:	fcf43c23          	sd	a5,-40(s0)
    while(n > 0){
    800012e8:	a891                	j	8000133c <copyinstr+0xd6>
      if(*p == '\0'){
    800012ea:	fd843783          	ld	a5,-40(s0)
    800012ee:	0007c783          	lbu	a5,0(a5) # 1000 <_entry-0x7ffff000>
    800012f2:	eb89                	bnez	a5,80001304 <copyinstr+0x9e>
        *dst = '\0';
    800012f4:	fb043783          	ld	a5,-80(s0)
    800012f8:	00078023          	sb	zero,0(a5)
        got_null = 1;
    800012fc:	4785                	li	a5,1
    800012fe:	fef42223          	sw	a5,-28(s0)
        break;
    80001302:	a081                	j	80001342 <copyinstr+0xdc>
      } else {
        *dst = *p;
    80001304:	fd843783          	ld	a5,-40(s0)
    80001308:	0007c703          	lbu	a4,0(a5)
    8000130c:	fb043783          	ld	a5,-80(s0)
    80001310:	00e78023          	sb	a4,0(a5)
      }
      --n;
    80001314:	fe843783          	ld	a5,-24(s0)
    80001318:	17fd                	addi	a5,a5,-1
    8000131a:	fef43423          	sd	a5,-24(s0)
      --max;
    8000131e:	fa043783          	ld	a5,-96(s0)
    80001322:	17fd                	addi	a5,a5,-1
    80001324:	faf43023          	sd	a5,-96(s0)
      p++;
    80001328:	fd843783          	ld	a5,-40(s0)
    8000132c:	0785                	addi	a5,a5,1
    8000132e:	fcf43c23          	sd	a5,-40(s0)
      dst++;
    80001332:	fb043783          	ld	a5,-80(s0)
    80001336:	0785                	addi	a5,a5,1
    80001338:	faf43823          	sd	a5,-80(s0)
    while(n > 0){
    8000133c:	fe843783          	ld	a5,-24(s0)
    80001340:	f7cd                	bnez	a5,800012ea <copyinstr+0x84>
    }

    srcva = va0 + PGSIZE;
    80001342:	fd043703          	ld	a4,-48(s0)
    80001346:	6785                	lui	a5,0x1
    80001348:	97ba                	add	a5,a5,a4
    8000134a:	faf43423          	sd	a5,-88(s0)
  while(got_null == 0 && max > 0){
    8000134e:	fe442783          	lw	a5,-28(s0)
    80001352:	2781                	sext.w	a5,a5
    80001354:	e781                	bnez	a5,8000135c <copyinstr+0xf6>
    80001356:	fa043783          	ld	a5,-96(s0)
    8000135a:	f78d                	bnez	a5,80001284 <copyinstr+0x1e>
  }
  if(got_null){
    8000135c:	fe442783          	lw	a5,-28(s0)
    80001360:	2781                	sext.w	a5,a5
    80001362:	c399                	beqz	a5,80001368 <copyinstr+0x102>
    return 0;
    80001364:	4781                	li	a5,0
    80001366:	a011                	j	8000136a <copyinstr+0x104>
  } else {
    return -1;
    80001368:	57fd                	li	a5,-1
  }
}
    8000136a:	853e                	mv	a0,a5
    8000136c:	60e6                	ld	ra,88(sp)
    8000136e:	6446                	ld	s0,80(sp)
    80001370:	6125                	addi	sp,sp,96
    80001372:	8082                	ret

0000000080001374 <r_sstatus>:
{
    80001374:	1101                	addi	sp,sp,-32
    80001376:	ec22                	sd	s0,24(sp)
    80001378:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000137a:	100027f3          	csrr	a5,sstatus
    8000137e:	fef43423          	sd	a5,-24(s0)
  return x;
    80001382:	fe843783          	ld	a5,-24(s0)
}
    80001386:	853e                	mv	a0,a5
    80001388:	6462                	ld	s0,24(sp)
    8000138a:	6105                	addi	sp,sp,32
    8000138c:	8082                	ret

000000008000138e <w_sstatus>:
{
    8000138e:	1101                	addi	sp,sp,-32
    80001390:	ec22                	sd	s0,24(sp)
    80001392:	1000                	addi	s0,sp,32
    80001394:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001398:	fe843783          	ld	a5,-24(s0)
    8000139c:	10079073          	csrw	sstatus,a5
}
    800013a0:	0001                	nop
    800013a2:	6462                	ld	s0,24(sp)
    800013a4:	6105                	addi	sp,sp,32
    800013a6:	8082                	ret

00000000800013a8 <intr_on>:
{
    800013a8:	1141                	addi	sp,sp,-16
    800013aa:	e406                	sd	ra,8(sp)
    800013ac:	e022                	sd	s0,0(sp)
    800013ae:	0800                	addi	s0,sp,16
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    800013b0:	00000097          	auipc	ra,0x0
    800013b4:	fc4080e7          	jalr	-60(ra) # 80001374 <r_sstatus>
    800013b8:	87aa                	mv	a5,a0
    800013ba:	0027e793          	ori	a5,a5,2
    800013be:	853e                	mv	a0,a5
    800013c0:	00000097          	auipc	ra,0x0
    800013c4:	fce080e7          	jalr	-50(ra) # 8000138e <w_sstatus>
}
    800013c8:	0001                	nop
    800013ca:	60a2                	ld	ra,8(sp)
    800013cc:	6402                	ld	s0,0(sp)
    800013ce:	0141                	addi	sp,sp,16
    800013d0:	8082                	ret

00000000800013d2 <intr_get>:
{
    800013d2:	1101                	addi	sp,sp,-32
    800013d4:	ec06                	sd	ra,24(sp)
    800013d6:	e822                	sd	s0,16(sp)
    800013d8:	1000                	addi	s0,sp,32
  uint64 x = r_sstatus();
    800013da:	00000097          	auipc	ra,0x0
    800013de:	f9a080e7          	jalr	-102(ra) # 80001374 <r_sstatus>
    800013e2:	fea43423          	sd	a0,-24(s0)
  return (x & SSTATUS_SIE) != 0;
    800013e6:	fe843783          	ld	a5,-24(s0)
    800013ea:	8b89                	andi	a5,a5,2
    800013ec:	00f037b3          	snez	a5,a5
    800013f0:	0ff7f793          	zext.b	a5,a5
    800013f4:	2781                	sext.w	a5,a5
}
    800013f6:	853e                	mv	a0,a5
    800013f8:	60e2                	ld	ra,24(sp)
    800013fa:	6442                	ld	s0,16(sp)
    800013fc:	6105                	addi	sp,sp,32
    800013fe:	8082                	ret

0000000080001400 <r_tp>:
{
    80001400:	1101                	addi	sp,sp,-32
    80001402:	ec22                	sd	s0,24(sp)
    80001404:	1000                	addi	s0,sp,32
  asm volatile("mv %0, tp" : "=r" (x) );
    80001406:	8792                	mv	a5,tp
    80001408:	fef43423          	sd	a5,-24(s0)
  return x;
    8000140c:	fe843783          	ld	a5,-24(s0)
}
    80001410:	853e                	mv	a0,a5
    80001412:	6462                	ld	s0,24(sp)
    80001414:	6105                	addi	sp,sp,32
    80001416:	8082                	ret

0000000080001418 <proc_mapstacks>:
// Allocate a page for each process's kernel stack.
// Map it high in memory, followed by an invalid
// guard page.
void
proc_mapstacks(pagetable_t kpgtbl)
{
    80001418:	7139                	addi	sp,sp,-64
    8000141a:	fc06                	sd	ra,56(sp)
    8000141c:	f822                	sd	s0,48(sp)
    8000141e:	0080                	addi	s0,sp,64
    80001420:	fca43423          	sd	a0,-56(s0)
  struct proc *p;
  
  for(p = proc; p < &proc[NPROC]; p++) {
    80001424:	0000b797          	auipc	a5,0xb
    80001428:	a7478793          	addi	a5,a5,-1420 # 8000be98 <proc>
    8000142c:	fef43423          	sd	a5,-24(s0)
    80001430:	a061                	j	800014b8 <proc_mapstacks+0xa0>
    char *pa = kalloc();
    80001432:	fffff097          	auipc	ra,0xfffff
    80001436:	d26080e7          	jalr	-730(ra) # 80000158 <kalloc>
    8000143a:	fea43023          	sd	a0,-32(s0)
    if(pa == 0)
    8000143e:	fe043783          	ld	a5,-32(s0)
    80001442:	eb89                	bnez	a5,80001454 <proc_mapstacks+0x3c>
      panic("kalloc");
    80001444:	0000a517          	auipc	a0,0xa
    80001448:	d0c50513          	addi	a0,a0,-756 # 8000b150 <etext+0x150>
    8000144c:	00008097          	auipc	ra,0x8
    80001450:	aea080e7          	jalr	-1302(ra) # 80008f36 <panic>
    uint64 va = KSTACK((int) (p - proc));
    80001454:	fe843703          	ld	a4,-24(s0)
    80001458:	0000b797          	auipc	a5,0xb
    8000145c:	a4078793          	addi	a5,a5,-1472 # 8000be98 <proc>
    80001460:	40f707b3          	sub	a5,a4,a5
    80001464:	4047d713          	srai	a4,a5,0x4
    80001468:	0000a797          	auipc	a5,0xa
    8000146c:	de078793          	addi	a5,a5,-544 # 8000b248 <etext+0x248>
    80001470:	639c                	ld	a5,0(a5)
    80001472:	02f707b3          	mul	a5,a4,a5
    80001476:	2781                	sext.w	a5,a5
    80001478:	2785                	addiw	a5,a5,1
    8000147a:	2781                	sext.w	a5,a5
    8000147c:	00d7979b          	slliw	a5,a5,0xd
    80001480:	2781                	sext.w	a5,a5
    80001482:	873e                	mv	a4,a5
    80001484:	040007b7          	lui	a5,0x4000
    80001488:	17fd                	addi	a5,a5,-1 # 3ffffff <_entry-0x7c000001>
    8000148a:	07b2                	slli	a5,a5,0xc
    8000148c:	8f99                	sub	a5,a5,a4
    8000148e:	fcf43c23          	sd	a5,-40(s0)
    kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    80001492:	fe043783          	ld	a5,-32(s0)
    80001496:	4719                	li	a4,6
    80001498:	6685                	lui	a3,0x1
    8000149a:	863e                	mv	a2,a5
    8000149c:	fd843583          	ld	a1,-40(s0)
    800014a0:	fc843503          	ld	a0,-56(s0)
    800014a4:	fffff097          	auipc	ra,0xfffff
    800014a8:	53e080e7          	jalr	1342(ra) # 800009e2 <kvmmap>
  for(p = proc; p < &proc[NPROC]; p++) {
    800014ac:	fe843783          	ld	a5,-24(s0)
    800014b0:	17078793          	addi	a5,a5,368
    800014b4:	fef43423          	sd	a5,-24(s0)
    800014b8:	fe843703          	ld	a4,-24(s0)
    800014bc:	00010797          	auipc	a5,0x10
    800014c0:	5dc78793          	addi	a5,a5,1500 # 80011a98 <pid_lock>
    800014c4:	f6f767e3          	bltu	a4,a5,80001432 <proc_mapstacks+0x1a>
  }
}
    800014c8:	0001                	nop
    800014ca:	0001                	nop
    800014cc:	70e2                	ld	ra,56(sp)
    800014ce:	7442                	ld	s0,48(sp)
    800014d0:	6121                	addi	sp,sp,64
    800014d2:	8082                	ret

00000000800014d4 <procinit>:

// initialize the proc table.
void
procinit(void)
{
    800014d4:	1101                	addi	sp,sp,-32
    800014d6:	ec06                	sd	ra,24(sp)
    800014d8:	e822                	sd	s0,16(sp)
    800014da:	1000                	addi	s0,sp,32
  struct proc *p;
  
  initlock(&pid_lock, "nextpid");
    800014dc:	0000a597          	auipc	a1,0xa
    800014e0:	c7c58593          	addi	a1,a1,-900 # 8000b158 <etext+0x158>
    800014e4:	00010517          	auipc	a0,0x10
    800014e8:	5b450513          	addi	a0,a0,1460 # 80011a98 <pid_lock>
    800014ec:	00008097          	auipc	ra,0x8
    800014f0:	e62080e7          	jalr	-414(ra) # 8000934e <initlock>
  initlock(&wait_lock, "wait_lock");
    800014f4:	0000a597          	auipc	a1,0xa
    800014f8:	c6c58593          	addi	a1,a1,-916 # 8000b160 <etext+0x160>
    800014fc:	00010517          	auipc	a0,0x10
    80001500:	5b450513          	addi	a0,a0,1460 # 80011ab0 <wait_lock>
    80001504:	00008097          	auipc	ra,0x8
    80001508:	e4a080e7          	jalr	-438(ra) # 8000934e <initlock>
  for(p = proc; p < &proc[NPROC]; p++) {
    8000150c:	0000b797          	auipc	a5,0xb
    80001510:	98c78793          	addi	a5,a5,-1652 # 8000be98 <proc>
    80001514:	fef43423          	sd	a5,-24(s0)
    80001518:	a0bd                	j	80001586 <procinit+0xb2>
      initlock(&p->lock, "proc");
    8000151a:	fe843783          	ld	a5,-24(s0)
    8000151e:	0000a597          	auipc	a1,0xa
    80001522:	c5258593          	addi	a1,a1,-942 # 8000b170 <etext+0x170>
    80001526:	853e                	mv	a0,a5
    80001528:	00008097          	auipc	ra,0x8
    8000152c:	e26080e7          	jalr	-474(ra) # 8000934e <initlock>
      p->state = UNUSED;
    80001530:	fe843783          	ld	a5,-24(s0)
    80001534:	0007ac23          	sw	zero,24(a5)
      p->kstack = KSTACK((int) (p - proc));
    80001538:	fe843703          	ld	a4,-24(s0)
    8000153c:	0000b797          	auipc	a5,0xb
    80001540:	95c78793          	addi	a5,a5,-1700 # 8000be98 <proc>
    80001544:	40f707b3          	sub	a5,a4,a5
    80001548:	4047d713          	srai	a4,a5,0x4
    8000154c:	0000a797          	auipc	a5,0xa
    80001550:	cfc78793          	addi	a5,a5,-772 # 8000b248 <etext+0x248>
    80001554:	639c                	ld	a5,0(a5)
    80001556:	02f707b3          	mul	a5,a4,a5
    8000155a:	2781                	sext.w	a5,a5
    8000155c:	2785                	addiw	a5,a5,1
    8000155e:	2781                	sext.w	a5,a5
    80001560:	00d7979b          	slliw	a5,a5,0xd
    80001564:	2781                	sext.w	a5,a5
    80001566:	873e                	mv	a4,a5
    80001568:	040007b7          	lui	a5,0x4000
    8000156c:	17fd                	addi	a5,a5,-1 # 3ffffff <_entry-0x7c000001>
    8000156e:	07b2                	slli	a5,a5,0xc
    80001570:	8f99                	sub	a5,a5,a4
    80001572:	873e                	mv	a4,a5
    80001574:	fe843783          	ld	a5,-24(s0)
    80001578:	e3b8                	sd	a4,64(a5)
  for(p = proc; p < &proc[NPROC]; p++) {
    8000157a:	fe843783          	ld	a5,-24(s0)
    8000157e:	17078793          	addi	a5,a5,368
    80001582:	fef43423          	sd	a5,-24(s0)
    80001586:	fe843703          	ld	a4,-24(s0)
    8000158a:	00010797          	auipc	a5,0x10
    8000158e:	50e78793          	addi	a5,a5,1294 # 80011a98 <pid_lock>
    80001592:	f8f764e3          	bltu	a4,a5,8000151a <procinit+0x46>
  }
}
    80001596:	0001                	nop
    80001598:	0001                	nop
    8000159a:	60e2                	ld	ra,24(sp)
    8000159c:	6442                	ld	s0,16(sp)
    8000159e:	6105                	addi	sp,sp,32
    800015a0:	8082                	ret

00000000800015a2 <cpuid>:
// Must be called with interrupts disabled,
// to prevent race with process being moved
// to a different CPU.
int
cpuid()
{
    800015a2:	1101                	addi	sp,sp,-32
    800015a4:	ec06                	sd	ra,24(sp)
    800015a6:	e822                	sd	s0,16(sp)
    800015a8:	1000                	addi	s0,sp,32
  int id = r_tp();
    800015aa:	00000097          	auipc	ra,0x0
    800015ae:	e56080e7          	jalr	-426(ra) # 80001400 <r_tp>
    800015b2:	87aa                	mv	a5,a0
    800015b4:	fef42623          	sw	a5,-20(s0)
  return id;
    800015b8:	fec42783          	lw	a5,-20(s0)
}
    800015bc:	853e                	mv	a0,a5
    800015be:	60e2                	ld	ra,24(sp)
    800015c0:	6442                	ld	s0,16(sp)
    800015c2:	6105                	addi	sp,sp,32
    800015c4:	8082                	ret

00000000800015c6 <mycpu>:

// Return this CPU's cpu struct.
// Interrupts must be disabled.
struct cpu*
mycpu(void)
{
    800015c6:	1101                	addi	sp,sp,-32
    800015c8:	ec06                	sd	ra,24(sp)
    800015ca:	e822                	sd	s0,16(sp)
    800015cc:	1000                	addi	s0,sp,32
  int id = cpuid();
    800015ce:	00000097          	auipc	ra,0x0
    800015d2:	fd4080e7          	jalr	-44(ra) # 800015a2 <cpuid>
    800015d6:	87aa                	mv	a5,a0
    800015d8:	fef42623          	sw	a5,-20(s0)
  struct cpu *c = &cpus[id];
    800015dc:	fec42783          	lw	a5,-20(s0)
    800015e0:	00779713          	slli	a4,a5,0x7
    800015e4:	0000a797          	auipc	a5,0xa
    800015e8:	4b478793          	addi	a5,a5,1204 # 8000ba98 <cpus>
    800015ec:	97ba                	add	a5,a5,a4
    800015ee:	fef43023          	sd	a5,-32(s0)
  return c;
    800015f2:	fe043783          	ld	a5,-32(s0)
}
    800015f6:	853e                	mv	a0,a5
    800015f8:	60e2                	ld	ra,24(sp)
    800015fa:	6442                	ld	s0,16(sp)
    800015fc:	6105                	addi	sp,sp,32
    800015fe:	8082                	ret

0000000080001600 <myproc>:

// Return the current struct proc *, or zero if none.
struct proc*
myproc(void)
{
    80001600:	1101                	addi	sp,sp,-32
    80001602:	ec06                	sd	ra,24(sp)
    80001604:	e822                	sd	s0,16(sp)
    80001606:	1000                	addi	s0,sp,32
  push_off();
    80001608:	00008097          	auipc	ra,0x8
    8000160c:	e74080e7          	jalr	-396(ra) # 8000947c <push_off>
  struct cpu *c = mycpu();
    80001610:	00000097          	auipc	ra,0x0
    80001614:	fb6080e7          	jalr	-74(ra) # 800015c6 <mycpu>
    80001618:	fea43423          	sd	a0,-24(s0)
  struct proc *p = c->proc;
    8000161c:	fe843783          	ld	a5,-24(s0)
    80001620:	639c                	ld	a5,0(a5)
    80001622:	fef43023          	sd	a5,-32(s0)
  pop_off();
    80001626:	00008097          	auipc	ra,0x8
    8000162a:	eae080e7          	jalr	-338(ra) # 800094d4 <pop_off>
  return p;
    8000162e:	fe043783          	ld	a5,-32(s0)
}
    80001632:	853e                	mv	a0,a5
    80001634:	60e2                	ld	ra,24(sp)
    80001636:	6442                	ld	s0,16(sp)
    80001638:	6105                	addi	sp,sp,32
    8000163a:	8082                	ret

000000008000163c <allocpid>:

int
allocpid()
{
    8000163c:	1101                	addi	sp,sp,-32
    8000163e:	ec06                	sd	ra,24(sp)
    80001640:	e822                	sd	s0,16(sp)
    80001642:	1000                	addi	s0,sp,32
  int pid;
  
  acquire(&pid_lock);
    80001644:	00010517          	auipc	a0,0x10
    80001648:	45450513          	addi	a0,a0,1108 # 80011a98 <pid_lock>
    8000164c:	00008097          	auipc	ra,0x8
    80001650:	d32080e7          	jalr	-718(ra) # 8000937e <acquire>
  pid = nextpid;
    80001654:	0000a797          	auipc	a5,0xa
    80001658:	1dc78793          	addi	a5,a5,476 # 8000b830 <nextpid>
    8000165c:	439c                	lw	a5,0(a5)
    8000165e:	fef42623          	sw	a5,-20(s0)
  nextpid = nextpid + 1;
    80001662:	0000a797          	auipc	a5,0xa
    80001666:	1ce78793          	addi	a5,a5,462 # 8000b830 <nextpid>
    8000166a:	439c                	lw	a5,0(a5)
    8000166c:	2785                	addiw	a5,a5,1
    8000166e:	0007871b          	sext.w	a4,a5
    80001672:	0000a797          	auipc	a5,0xa
    80001676:	1be78793          	addi	a5,a5,446 # 8000b830 <nextpid>
    8000167a:	c398                	sw	a4,0(a5)
  release(&pid_lock);
    8000167c:	00010517          	auipc	a0,0x10
    80001680:	41c50513          	addi	a0,a0,1052 # 80011a98 <pid_lock>
    80001684:	00008097          	auipc	ra,0x8
    80001688:	d5e080e7          	jalr	-674(ra) # 800093e2 <release>

  return pid;
    8000168c:	fec42783          	lw	a5,-20(s0)
}
    80001690:	853e                	mv	a0,a5
    80001692:	60e2                	ld	ra,24(sp)
    80001694:	6442                	ld	s0,16(sp)
    80001696:	6105                	addi	sp,sp,32
    80001698:	8082                	ret

000000008000169a <allocproc>:
// If found, initialize state required to run in the kernel,
// and return with p->lock held.
// If there are no free procs, or a memory allocation fails, return 0.
static struct proc*
allocproc(void)
{
    8000169a:	1101                	addi	sp,sp,-32
    8000169c:	ec06                	sd	ra,24(sp)
    8000169e:	e822                	sd	s0,16(sp)
    800016a0:	1000                	addi	s0,sp,32
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    800016a2:	0000a797          	auipc	a5,0xa
    800016a6:	7f678793          	addi	a5,a5,2038 # 8000be98 <proc>
    800016aa:	fef43423          	sd	a5,-24(s0)
    800016ae:	a80d                	j	800016e0 <allocproc+0x46>
    acquire(&p->lock);
    800016b0:	fe843783          	ld	a5,-24(s0)
    800016b4:	853e                	mv	a0,a5
    800016b6:	00008097          	auipc	ra,0x8
    800016ba:	cc8080e7          	jalr	-824(ra) # 8000937e <acquire>
    if(p->state == UNUSED) {
    800016be:	fe843783          	ld	a5,-24(s0)
    800016c2:	4f9c                	lw	a5,24(a5)
    800016c4:	cb85                	beqz	a5,800016f4 <allocproc+0x5a>
      goto found;
    } else {
      release(&p->lock);
    800016c6:	fe843783          	ld	a5,-24(s0)
    800016ca:	853e                	mv	a0,a5
    800016cc:	00008097          	auipc	ra,0x8
    800016d0:	d16080e7          	jalr	-746(ra) # 800093e2 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    800016d4:	fe843783          	ld	a5,-24(s0)
    800016d8:	17078793          	addi	a5,a5,368
    800016dc:	fef43423          	sd	a5,-24(s0)
    800016e0:	fe843703          	ld	a4,-24(s0)
    800016e4:	00010797          	auipc	a5,0x10
    800016e8:	3b478793          	addi	a5,a5,948 # 80011a98 <pid_lock>
    800016ec:	fcf762e3          	bltu	a4,a5,800016b0 <allocproc+0x16>
    }
  }
  return 0;
    800016f0:	4781                	li	a5,0
    800016f2:	a0e1                	j	800017ba <allocproc+0x120>
      goto found;
    800016f4:	0001                	nop

found:
  p->pid = allocpid();
    800016f6:	00000097          	auipc	ra,0x0
    800016fa:	f46080e7          	jalr	-186(ra) # 8000163c <allocpid>
    800016fe:	87aa                	mv	a5,a0
    80001700:	873e                	mv	a4,a5
    80001702:	fe843783          	ld	a5,-24(s0)
    80001706:	db98                	sw	a4,48(a5)
  p->state = USED;
    80001708:	fe843783          	ld	a5,-24(s0)
    8000170c:	4705                	li	a4,1
    8000170e:	cf98                	sw	a4,24(a5)

  // Allocate a trapframe page.
  if((p->trapframe = (struct trapframe *)kalloc()) == 0){
    80001710:	fffff097          	auipc	ra,0xfffff
    80001714:	a48080e7          	jalr	-1464(ra) # 80000158 <kalloc>
    80001718:	872a                	mv	a4,a0
    8000171a:	fe843783          	ld	a5,-24(s0)
    8000171e:	efb8                	sd	a4,88(a5)
    80001720:	fe843783          	ld	a5,-24(s0)
    80001724:	6fbc                	ld	a5,88(a5)
    80001726:	e385                	bnez	a5,80001746 <allocproc+0xac>
    freeproc(p);
    80001728:	fe843503          	ld	a0,-24(s0)
    8000172c:	00000097          	auipc	ra,0x0
    80001730:	098080e7          	jalr	152(ra) # 800017c4 <freeproc>
    release(&p->lock);
    80001734:	fe843783          	ld	a5,-24(s0)
    80001738:	853e                	mv	a0,a5
    8000173a:	00008097          	auipc	ra,0x8
    8000173e:	ca8080e7          	jalr	-856(ra) # 800093e2 <release>
    return 0;
    80001742:	4781                	li	a5,0
    80001744:	a89d                	j	800017ba <allocproc+0x120>
  }

  // An empty user page table.
  p->pagetable = proc_pagetable(p);
    80001746:	fe843503          	ld	a0,-24(s0)
    8000174a:	00000097          	auipc	ra,0x0
    8000174e:	118080e7          	jalr	280(ra) # 80001862 <proc_pagetable>
    80001752:	872a                	mv	a4,a0
    80001754:	fe843783          	ld	a5,-24(s0)
    80001758:	ebb8                	sd	a4,80(a5)
  if(p->pagetable == 0){
    8000175a:	fe843783          	ld	a5,-24(s0)
    8000175e:	6bbc                	ld	a5,80(a5)
    80001760:	e385                	bnez	a5,80001780 <allocproc+0xe6>
    freeproc(p);
    80001762:	fe843503          	ld	a0,-24(s0)
    80001766:	00000097          	auipc	ra,0x0
    8000176a:	05e080e7          	jalr	94(ra) # 800017c4 <freeproc>
    release(&p->lock);
    8000176e:	fe843783          	ld	a5,-24(s0)
    80001772:	853e                	mv	a0,a5
    80001774:	00008097          	auipc	ra,0x8
    80001778:	c6e080e7          	jalr	-914(ra) # 800093e2 <release>
    return 0;
    8000177c:	4781                	li	a5,0
    8000177e:	a835                	j	800017ba <allocproc+0x120>
  }

  // Set up new context to start executing at forkret,
  // which returns to user space.
  memset(&p->context, 0, sizeof(p->context));
    80001780:	fe843783          	ld	a5,-24(s0)
    80001784:	06078793          	addi	a5,a5,96
    80001788:	07000613          	li	a2,112
    8000178c:	4581                	li	a1,0
    8000178e:	853e                	mv	a0,a5
    80001790:	fffff097          	auipc	ra,0xfffff
    80001794:	a7c080e7          	jalr	-1412(ra) # 8000020c <memset>
  p->context.ra = (uint64)forkret;
    80001798:	00001717          	auipc	a4,0x1
    8000179c:	9f270713          	addi	a4,a4,-1550 # 8000218a <forkret>
    800017a0:	fe843783          	ld	a5,-24(s0)
    800017a4:	f3b8                	sd	a4,96(a5)
  p->context.sp = p->kstack + PGSIZE;
    800017a6:	fe843783          	ld	a5,-24(s0)
    800017aa:	63b8                	ld	a4,64(a5)
    800017ac:	6785                	lui	a5,0x1
    800017ae:	973e                	add	a4,a4,a5
    800017b0:	fe843783          	ld	a5,-24(s0)
    800017b4:	f7b8                	sd	a4,104(a5)

  return p;
    800017b6:	fe843783          	ld	a5,-24(s0)
}
    800017ba:	853e                	mv	a0,a5
    800017bc:	60e2                	ld	ra,24(sp)
    800017be:	6442                	ld	s0,16(sp)
    800017c0:	6105                	addi	sp,sp,32
    800017c2:	8082                	ret

00000000800017c4 <freeproc>:
// free a proc structure and the data hanging from it,
// including user pages.
// p->lock must be held.
static void
freeproc(struct proc *p)
{
    800017c4:	1101                	addi	sp,sp,-32
    800017c6:	ec06                	sd	ra,24(sp)
    800017c8:	e822                	sd	s0,16(sp)
    800017ca:	1000                	addi	s0,sp,32
    800017cc:	fea43423          	sd	a0,-24(s0)
  if(p->trapframe)
    800017d0:	fe843783          	ld	a5,-24(s0)
    800017d4:	6fbc                	ld	a5,88(a5)
    800017d6:	cb89                	beqz	a5,800017e8 <freeproc+0x24>
    kfree((void*)p->trapframe);
    800017d8:	fe843783          	ld	a5,-24(s0)
    800017dc:	6fbc                	ld	a5,88(a5)
    800017de:	853e                	mv	a0,a5
    800017e0:	fffff097          	auipc	ra,0xfffff
    800017e4:	8d4080e7          	jalr	-1836(ra) # 800000b4 <kfree>
  p->trapframe = 0;
    800017e8:	fe843783          	ld	a5,-24(s0)
    800017ec:	0407bc23          	sd	zero,88(a5) # 1058 <_entry-0x7fffefa8>
  if(p->pagetable)
    800017f0:	fe843783          	ld	a5,-24(s0)
    800017f4:	6bbc                	ld	a5,80(a5)
    800017f6:	cf89                	beqz	a5,80001810 <freeproc+0x4c>
    proc_freepagetable(p->pagetable, p->sz);
    800017f8:	fe843783          	ld	a5,-24(s0)
    800017fc:	6bb8                	ld	a4,80(a5)
    800017fe:	fe843783          	ld	a5,-24(s0)
    80001802:	67bc                	ld	a5,72(a5)
    80001804:	85be                	mv	a1,a5
    80001806:	853a                	mv	a0,a4
    80001808:	00000097          	auipc	ra,0x0
    8000180c:	11a080e7          	jalr	282(ra) # 80001922 <proc_freepagetable>
  p->pagetable = 0;
    80001810:	fe843783          	ld	a5,-24(s0)
    80001814:	0407b823          	sd	zero,80(a5)
  p->sz = 0;
    80001818:	fe843783          	ld	a5,-24(s0)
    8000181c:	0407b423          	sd	zero,72(a5)
  p->pid = 0;
    80001820:	fe843783          	ld	a5,-24(s0)
    80001824:	0207a823          	sw	zero,48(a5)
  p->parent = 0;
    80001828:	fe843783          	ld	a5,-24(s0)
    8000182c:	0207bc23          	sd	zero,56(a5)
  p->name[0] = 0;
    80001830:	fe843783          	ld	a5,-24(s0)
    80001834:	14078c23          	sb	zero,344(a5)
  p->chan = 0;
    80001838:	fe843783          	ld	a5,-24(s0)
    8000183c:	0207b023          	sd	zero,32(a5)
  p->killed = 0;
    80001840:	fe843783          	ld	a5,-24(s0)
    80001844:	0207a423          	sw	zero,40(a5)
  p->xstate = 0;
    80001848:	fe843783          	ld	a5,-24(s0)
    8000184c:	0207a623          	sw	zero,44(a5)
  p->state = UNUSED;
    80001850:	fe843783          	ld	a5,-24(s0)
    80001854:	0007ac23          	sw	zero,24(a5)
}
    80001858:	0001                	nop
    8000185a:	60e2                	ld	ra,24(sp)
    8000185c:	6442                	ld	s0,16(sp)
    8000185e:	6105                	addi	sp,sp,32
    80001860:	8082                	ret

0000000080001862 <proc_pagetable>:

// Create a user page table for a given process, with no user memory,
// but with trampoline and trapframe pages.
pagetable_t
proc_pagetable(struct proc *p)
{
    80001862:	7179                	addi	sp,sp,-48
    80001864:	f406                	sd	ra,40(sp)
    80001866:	f022                	sd	s0,32(sp)
    80001868:	1800                	addi	s0,sp,48
    8000186a:	fca43c23          	sd	a0,-40(s0)
  pagetable_t pagetable;

  // An empty page table.
  pagetable = uvmcreate();
    8000186e:	fffff097          	auipc	ra,0xfffff
    80001872:	3ac080e7          	jalr	940(ra) # 80000c1a <uvmcreate>
    80001876:	fea43423          	sd	a0,-24(s0)
  if(pagetable == 0)
    8000187a:	fe843783          	ld	a5,-24(s0)
    8000187e:	e399                	bnez	a5,80001884 <proc_pagetable+0x22>
    return 0;
    80001880:	4781                	li	a5,0
    80001882:	a859                	j	80001918 <proc_pagetable+0xb6>

  // map the trampoline code (for system call return)
  // at the highest user virtual address.
  // only the supervisor uses it, on the way
  // to/from user space, so not PTE_U.
  if(mappages(pagetable, TRAMPOLINE, PGSIZE,
    80001884:	00008797          	auipc	a5,0x8
    80001888:	77c78793          	addi	a5,a5,1916 # 8000a000 <_trampoline>
    8000188c:	4729                	li	a4,10
    8000188e:	86be                	mv	a3,a5
    80001890:	6605                	lui	a2,0x1
    80001892:	040007b7          	lui	a5,0x4000
    80001896:	17fd                	addi	a5,a5,-1 # 3ffffff <_entry-0x7c000001>
    80001898:	00c79593          	slli	a1,a5,0xc
    8000189c:	fe843503          	ld	a0,-24(s0)
    800018a0:	fffff097          	auipc	ra,0xfffff
    800018a4:	19c080e7          	jalr	412(ra) # 80000a3c <mappages>
    800018a8:	87aa                	mv	a5,a0
    800018aa:	0007db63          	bgez	a5,800018c0 <proc_pagetable+0x5e>
              (uint64)trampoline, PTE_R | PTE_X) < 0){
    uvmfree(pagetable, 0);
    800018ae:	4581                	li	a1,0
    800018b0:	fe843503          	ld	a0,-24(s0)
    800018b4:	fffff097          	auipc	ra,0xfffff
    800018b8:	662080e7          	jalr	1634(ra) # 80000f16 <uvmfree>
    return 0;
    800018bc:	4781                	li	a5,0
    800018be:	a8a9                	j	80001918 <proc_pagetable+0xb6>
  }

  // map the trapframe page just below the trampoline page, for
  // trampoline.S.
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
              (uint64)(p->trapframe), PTE_R | PTE_W) < 0){
    800018c0:	fd843783          	ld	a5,-40(s0)
    800018c4:	6fbc                	ld	a5,88(a5)
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
    800018c6:	4719                	li	a4,6
    800018c8:	86be                	mv	a3,a5
    800018ca:	6605                	lui	a2,0x1
    800018cc:	020007b7          	lui	a5,0x2000
    800018d0:	17fd                	addi	a5,a5,-1 # 1ffffff <_entry-0x7e000001>
    800018d2:	00d79593          	slli	a1,a5,0xd
    800018d6:	fe843503          	ld	a0,-24(s0)
    800018da:	fffff097          	auipc	ra,0xfffff
    800018de:	162080e7          	jalr	354(ra) # 80000a3c <mappages>
    800018e2:	87aa                	mv	a5,a0
    800018e4:	0207d863          	bgez	a5,80001914 <proc_pagetable+0xb2>
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    800018e8:	4681                	li	a3,0
    800018ea:	4605                	li	a2,1
    800018ec:	040007b7          	lui	a5,0x4000
    800018f0:	17fd                	addi	a5,a5,-1 # 3ffffff <_entry-0x7c000001>
    800018f2:	00c79593          	slli	a1,a5,0xc
    800018f6:	fe843503          	ld	a0,-24(s0)
    800018fa:	fffff097          	auipc	ra,0xfffff
    800018fe:	220080e7          	jalr	544(ra) # 80000b1a <uvmunmap>
    uvmfree(pagetable, 0);
    80001902:	4581                	li	a1,0
    80001904:	fe843503          	ld	a0,-24(s0)
    80001908:	fffff097          	auipc	ra,0xfffff
    8000190c:	60e080e7          	jalr	1550(ra) # 80000f16 <uvmfree>
    return 0;
    80001910:	4781                	li	a5,0
    80001912:	a019                	j	80001918 <proc_pagetable+0xb6>
  }

  return pagetable;
    80001914:	fe843783          	ld	a5,-24(s0)
}
    80001918:	853e                	mv	a0,a5
    8000191a:	70a2                	ld	ra,40(sp)
    8000191c:	7402                	ld	s0,32(sp)
    8000191e:	6145                	addi	sp,sp,48
    80001920:	8082                	ret

0000000080001922 <proc_freepagetable>:

// Free a process's page table, and free the
// physical memory it refers to.
void
proc_freepagetable(pagetable_t pagetable, uint64 sz)
{
    80001922:	1101                	addi	sp,sp,-32
    80001924:	ec06                	sd	ra,24(sp)
    80001926:	e822                	sd	s0,16(sp)
    80001928:	1000                	addi	s0,sp,32
    8000192a:	fea43423          	sd	a0,-24(s0)
    8000192e:	feb43023          	sd	a1,-32(s0)
  uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80001932:	4681                	li	a3,0
    80001934:	4605                	li	a2,1
    80001936:	040007b7          	lui	a5,0x4000
    8000193a:	17fd                	addi	a5,a5,-1 # 3ffffff <_entry-0x7c000001>
    8000193c:	00c79593          	slli	a1,a5,0xc
    80001940:	fe843503          	ld	a0,-24(s0)
    80001944:	fffff097          	auipc	ra,0xfffff
    80001948:	1d6080e7          	jalr	470(ra) # 80000b1a <uvmunmap>
  uvmunmap(pagetable, TRAPFRAME, 1, 0);
    8000194c:	4681                	li	a3,0
    8000194e:	4605                	li	a2,1
    80001950:	020007b7          	lui	a5,0x2000
    80001954:	17fd                	addi	a5,a5,-1 # 1ffffff <_entry-0x7e000001>
    80001956:	00d79593          	slli	a1,a5,0xd
    8000195a:	fe843503          	ld	a0,-24(s0)
    8000195e:	fffff097          	auipc	ra,0xfffff
    80001962:	1bc080e7          	jalr	444(ra) # 80000b1a <uvmunmap>
  uvmfree(pagetable, sz);
    80001966:	fe043583          	ld	a1,-32(s0)
    8000196a:	fe843503          	ld	a0,-24(s0)
    8000196e:	fffff097          	auipc	ra,0xfffff
    80001972:	5a8080e7          	jalr	1448(ra) # 80000f16 <uvmfree>
}
    80001976:	0001                	nop
    80001978:	60e2                	ld	ra,24(sp)
    8000197a:	6442                	ld	s0,16(sp)
    8000197c:	6105                	addi	sp,sp,32
    8000197e:	8082                	ret

0000000080001980 <userinit>:
};

// Set up first user process.
void
userinit(void)
{
    80001980:	1101                	addi	sp,sp,-32
    80001982:	ec06                	sd	ra,24(sp)
    80001984:	e822                	sd	s0,16(sp)
    80001986:	1000                	addi	s0,sp,32
  struct proc *p;

  p = allocproc();
    80001988:	00000097          	auipc	ra,0x0
    8000198c:	d12080e7          	jalr	-750(ra) # 8000169a <allocproc>
    80001990:	fea43423          	sd	a0,-24(s0)
  initproc = p;
    80001994:	0000a797          	auipc	a5,0xa
    80001998:	0b478793          	addi	a5,a5,180 # 8000ba48 <initproc>
    8000199c:	fe843703          	ld	a4,-24(s0)
    800019a0:	e398                	sd	a4,0(a5)
  
  // allocate one user page and copy initcode's instructions
  // and data into it.
  uvmfirst(p->pagetable, initcode, sizeof(initcode));
    800019a2:	fe843783          	ld	a5,-24(s0)
    800019a6:	6bbc                	ld	a5,80(a5)
    800019a8:	03400613          	li	a2,52
    800019ac:	0000a597          	auipc	a1,0xa
    800019b0:	e9458593          	addi	a1,a1,-364 # 8000b840 <initcode>
    800019b4:	853e                	mv	a0,a5
    800019b6:	fffff097          	auipc	ra,0xfffff
    800019ba:	2a0080e7          	jalr	672(ra) # 80000c56 <uvmfirst>
  p->sz = PGSIZE;
    800019be:	fe843783          	ld	a5,-24(s0)
    800019c2:	6705                	lui	a4,0x1
    800019c4:	e7b8                	sd	a4,72(a5)

  // prepare for the very first "return" from kernel to user.
  p->trapframe->epc = 0;      // user program counter
    800019c6:	fe843783          	ld	a5,-24(s0)
    800019ca:	6fbc                	ld	a5,88(a5)
    800019cc:	0007bc23          	sd	zero,24(a5)
  p->trapframe->sp = PGSIZE;  // user stack pointer
    800019d0:	fe843783          	ld	a5,-24(s0)
    800019d4:	6fbc                	ld	a5,88(a5)
    800019d6:	6705                	lui	a4,0x1
    800019d8:	fb98                	sd	a4,48(a5)

  safestrcpy(p->name, "initcode", sizeof(p->name));
    800019da:	fe843783          	ld	a5,-24(s0)
    800019de:	15878793          	addi	a5,a5,344
    800019e2:	4641                	li	a2,16
    800019e4:	00009597          	auipc	a1,0x9
    800019e8:	79458593          	addi	a1,a1,1940 # 8000b178 <etext+0x178>
    800019ec:	853e                	mv	a0,a5
    800019ee:	fffff097          	auipc	ra,0xfffff
    800019f2:	b22080e7          	jalr	-1246(ra) # 80000510 <safestrcpy>
  p->cwd = namei("/");
    800019f6:	00009517          	auipc	a0,0x9
    800019fa:	79250513          	addi	a0,a0,1938 # 8000b188 <etext+0x188>
    800019fe:	00003097          	auipc	ra,0x3
    80001a02:	292080e7          	jalr	658(ra) # 80004c90 <namei>
    80001a06:	872a                	mv	a4,a0
    80001a08:	fe843783          	ld	a5,-24(s0)
    80001a0c:	14e7b823          	sd	a4,336(a5)

  p->state = RUNNABLE;
    80001a10:	fe843783          	ld	a5,-24(s0)
    80001a14:	470d                	li	a4,3
    80001a16:	cf98                	sw	a4,24(a5)

  // @felipe: Make sure no syscalls are being traced
  p->trace_mask = 0;
    80001a18:	fe843783          	ld	a5,-24(s0)
    80001a1c:	1607a423          	sw	zero,360(a5)

  release(&p->lock);
    80001a20:	fe843783          	ld	a5,-24(s0)
    80001a24:	853e                	mv	a0,a5
    80001a26:	00008097          	auipc	ra,0x8
    80001a2a:	9bc080e7          	jalr	-1604(ra) # 800093e2 <release>
}
    80001a2e:	0001                	nop
    80001a30:	60e2                	ld	ra,24(sp)
    80001a32:	6442                	ld	s0,16(sp)
    80001a34:	6105                	addi	sp,sp,32
    80001a36:	8082                	ret

0000000080001a38 <growproc>:

// Grow or shrink user memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
    80001a38:	7179                	addi	sp,sp,-48
    80001a3a:	f406                	sd	ra,40(sp)
    80001a3c:	f022                	sd	s0,32(sp)
    80001a3e:	1800                	addi	s0,sp,48
    80001a40:	87aa                	mv	a5,a0
    80001a42:	fcf42e23          	sw	a5,-36(s0)
  uint64 sz;
  struct proc *p = myproc();
    80001a46:	00000097          	auipc	ra,0x0
    80001a4a:	bba080e7          	jalr	-1094(ra) # 80001600 <myproc>
    80001a4e:	fea43023          	sd	a0,-32(s0)

  sz = p->sz;
    80001a52:	fe043783          	ld	a5,-32(s0)
    80001a56:	67bc                	ld	a5,72(a5)
    80001a58:	fef43423          	sd	a5,-24(s0)
  if(n > 0){
    80001a5c:	fdc42783          	lw	a5,-36(s0)
    80001a60:	2781                	sext.w	a5,a5
    80001a62:	02f05963          	blez	a5,80001a94 <growproc+0x5c>
    if((sz = uvmalloc(p->pagetable, sz, sz + n, PTE_W)) == 0) {
    80001a66:	fe043783          	ld	a5,-32(s0)
    80001a6a:	6ba8                	ld	a0,80(a5)
    80001a6c:	fdc42703          	lw	a4,-36(s0)
    80001a70:	fe843783          	ld	a5,-24(s0)
    80001a74:	97ba                	add	a5,a5,a4
    80001a76:	4691                	li	a3,4
    80001a78:	863e                	mv	a2,a5
    80001a7a:	fe843583          	ld	a1,-24(s0)
    80001a7e:	fffff097          	auipc	ra,0xfffff
    80001a82:	260080e7          	jalr	608(ra) # 80000cde <uvmalloc>
    80001a86:	fea43423          	sd	a0,-24(s0)
    80001a8a:	fe843783          	ld	a5,-24(s0)
    80001a8e:	eb95                	bnez	a5,80001ac2 <growproc+0x8a>
      return -1;
    80001a90:	57fd                	li	a5,-1
    80001a92:	a835                	j	80001ace <growproc+0x96>
    }
  } else if(n < 0){
    80001a94:	fdc42783          	lw	a5,-36(s0)
    80001a98:	2781                	sext.w	a5,a5
    80001a9a:	0207d463          	bgez	a5,80001ac2 <growproc+0x8a>
    sz = uvmdealloc(p->pagetable, sz, sz + n);
    80001a9e:	fe043783          	ld	a5,-32(s0)
    80001aa2:	6bb4                	ld	a3,80(a5)
    80001aa4:	fdc42703          	lw	a4,-36(s0)
    80001aa8:	fe843783          	ld	a5,-24(s0)
    80001aac:	97ba                	add	a5,a5,a4
    80001aae:	863e                	mv	a2,a5
    80001ab0:	fe843583          	ld	a1,-24(s0)
    80001ab4:	8536                	mv	a0,a3
    80001ab6:	fffff097          	auipc	ra,0xfffff
    80001aba:	31a080e7          	jalr	794(ra) # 80000dd0 <uvmdealloc>
    80001abe:	fea43423          	sd	a0,-24(s0)
  }
  p->sz = sz;
    80001ac2:	fe043783          	ld	a5,-32(s0)
    80001ac6:	fe843703          	ld	a4,-24(s0)
    80001aca:	e7b8                	sd	a4,72(a5)
  return 0;
    80001acc:	4781                	li	a5,0
}
    80001ace:	853e                	mv	a0,a5
    80001ad0:	70a2                	ld	ra,40(sp)
    80001ad2:	7402                	ld	s0,32(sp)
    80001ad4:	6145                	addi	sp,sp,48
    80001ad6:	8082                	ret

0000000080001ad8 <fork>:

// Create a new process, copying the parent.
// Sets up child kernel stack to return as if from fork() system call.
int
fork(void)
{
    80001ad8:	7179                	addi	sp,sp,-48
    80001ada:	f406                	sd	ra,40(sp)
    80001adc:	f022                	sd	s0,32(sp)
    80001ade:	1800                	addi	s0,sp,48
  int i, pid;
  struct proc *np;
  struct proc *p = myproc();
    80001ae0:	00000097          	auipc	ra,0x0
    80001ae4:	b20080e7          	jalr	-1248(ra) # 80001600 <myproc>
    80001ae8:	fea43023          	sd	a0,-32(s0)

  // Allocate process.
  if((np = allocproc()) == 0){
    80001aec:	00000097          	auipc	ra,0x0
    80001af0:	bae080e7          	jalr	-1106(ra) # 8000169a <allocproc>
    80001af4:	fca43c23          	sd	a0,-40(s0)
    80001af8:	fd843783          	ld	a5,-40(s0)
    80001afc:	e399                	bnez	a5,80001b02 <fork+0x2a>
    return -1;
    80001afe:	57fd                	li	a5,-1
    80001b00:	a271                	j	80001c8c <fork+0x1b4>
  }

  // Copy user memory from parent to child.
  if(uvmcopy(p->pagetable, np->pagetable, p->sz) < 0){
    80001b02:	fe043783          	ld	a5,-32(s0)
    80001b06:	6bb8                	ld	a4,80(a5)
    80001b08:	fd843783          	ld	a5,-40(s0)
    80001b0c:	6bb4                	ld	a3,80(a5)
    80001b0e:	fe043783          	ld	a5,-32(s0)
    80001b12:	67bc                	ld	a5,72(a5)
    80001b14:	863e                	mv	a2,a5
    80001b16:	85b6                	mv	a1,a3
    80001b18:	853a                	mv	a0,a4
    80001b1a:	fffff097          	auipc	ra,0xfffff
    80001b1e:	446080e7          	jalr	1094(ra) # 80000f60 <uvmcopy>
    80001b22:	87aa                	mv	a5,a0
    80001b24:	0207d163          	bgez	a5,80001b46 <fork+0x6e>
    freeproc(np);
    80001b28:	fd843503          	ld	a0,-40(s0)
    80001b2c:	00000097          	auipc	ra,0x0
    80001b30:	c98080e7          	jalr	-872(ra) # 800017c4 <freeproc>
    release(&np->lock);
    80001b34:	fd843783          	ld	a5,-40(s0)
    80001b38:	853e                	mv	a0,a5
    80001b3a:	00008097          	auipc	ra,0x8
    80001b3e:	8a8080e7          	jalr	-1880(ra) # 800093e2 <release>
    return -1;
    80001b42:	57fd                	li	a5,-1
    80001b44:	a2a1                	j	80001c8c <fork+0x1b4>
  }
  np->sz = p->sz;
    80001b46:	fe043783          	ld	a5,-32(s0)
    80001b4a:	67b8                	ld	a4,72(a5)
    80001b4c:	fd843783          	ld	a5,-40(s0)
    80001b50:	e7b8                	sd	a4,72(a5)

  // copy saved user registers.
  *(np->trapframe) = *(p->trapframe);
    80001b52:	fe043783          	ld	a5,-32(s0)
    80001b56:	6fb8                	ld	a4,88(a5)
    80001b58:	fd843783          	ld	a5,-40(s0)
    80001b5c:	6fbc                	ld	a5,88(a5)
    80001b5e:	86be                	mv	a3,a5
    80001b60:	12000793          	li	a5,288
    80001b64:	863e                	mv	a2,a5
    80001b66:	85ba                	mv	a1,a4
    80001b68:	8536                	mv	a0,a3
    80001b6a:	fffff097          	auipc	ra,0xfffff
    80001b6e:	862080e7          	jalr	-1950(ra) # 800003cc <memcpy>

  // Cause fork to return 0 in the child.
  np->trapframe->a0 = 0;
    80001b72:	fd843783          	ld	a5,-40(s0)
    80001b76:	6fbc                	ld	a5,88(a5)
    80001b78:	0607b823          	sd	zero,112(a5)

  // increment reference counts on open file descriptors.
  for(i = 0; i < NOFILE; i++)
    80001b7c:	fe042623          	sw	zero,-20(s0)
    80001b80:	a0a9                	j	80001bca <fork+0xf2>
    if(p->ofile[i])
    80001b82:	fe043703          	ld	a4,-32(s0)
    80001b86:	fec42783          	lw	a5,-20(s0)
    80001b8a:	07e9                	addi	a5,a5,26
    80001b8c:	078e                	slli	a5,a5,0x3
    80001b8e:	97ba                	add	a5,a5,a4
    80001b90:	639c                	ld	a5,0(a5)
    80001b92:	c79d                	beqz	a5,80001bc0 <fork+0xe8>
      np->ofile[i] = filedup(p->ofile[i]);
    80001b94:	fe043703          	ld	a4,-32(s0)
    80001b98:	fec42783          	lw	a5,-20(s0)
    80001b9c:	07e9                	addi	a5,a5,26
    80001b9e:	078e                	slli	a5,a5,0x3
    80001ba0:	97ba                	add	a5,a5,a4
    80001ba2:	639c                	ld	a5,0(a5)
    80001ba4:	853e                	mv	a0,a5
    80001ba6:	00004097          	auipc	ra,0x4
    80001baa:	a82080e7          	jalr	-1406(ra) # 80005628 <filedup>
    80001bae:	86aa                	mv	a3,a0
    80001bb0:	fd843703          	ld	a4,-40(s0)
    80001bb4:	fec42783          	lw	a5,-20(s0)
    80001bb8:	07e9                	addi	a5,a5,26
    80001bba:	078e                	slli	a5,a5,0x3
    80001bbc:	97ba                	add	a5,a5,a4
    80001bbe:	e394                	sd	a3,0(a5)
  for(i = 0; i < NOFILE; i++)
    80001bc0:	fec42783          	lw	a5,-20(s0)
    80001bc4:	2785                	addiw	a5,a5,1
    80001bc6:	fef42623          	sw	a5,-20(s0)
    80001bca:	fec42783          	lw	a5,-20(s0)
    80001bce:	0007871b          	sext.w	a4,a5
    80001bd2:	47bd                	li	a5,15
    80001bd4:	fae7d7e3          	bge	a5,a4,80001b82 <fork+0xaa>
  np->cwd = idup(p->cwd);
    80001bd8:	fe043783          	ld	a5,-32(s0)
    80001bdc:	1507b783          	ld	a5,336(a5)
    80001be0:	853e                	mv	a0,a5
    80001be2:	00002097          	auipc	ra,0x2
    80001be6:	332080e7          	jalr	818(ra) # 80003f14 <idup>
    80001bea:	872a                	mv	a4,a0
    80001bec:	fd843783          	ld	a5,-40(s0)
    80001bf0:	14e7b823          	sd	a4,336(a5)

  safestrcpy(np->name, p->name, sizeof(p->name));
    80001bf4:	fd843783          	ld	a5,-40(s0)
    80001bf8:	15878713          	addi	a4,a5,344
    80001bfc:	fe043783          	ld	a5,-32(s0)
    80001c00:	15878793          	addi	a5,a5,344
    80001c04:	4641                	li	a2,16
    80001c06:	85be                	mv	a1,a5
    80001c08:	853a                	mv	a0,a4
    80001c0a:	fffff097          	auipc	ra,0xfffff
    80001c0e:	906080e7          	jalr	-1786(ra) # 80000510 <safestrcpy>

  pid = np->pid;
    80001c12:	fd843783          	ld	a5,-40(s0)
    80001c16:	5b9c                	lw	a5,48(a5)
    80001c18:	fcf42a23          	sw	a5,-44(s0)

  release(&np->lock);
    80001c1c:	fd843783          	ld	a5,-40(s0)
    80001c20:	853e                	mv	a0,a5
    80001c22:	00007097          	auipc	ra,0x7
    80001c26:	7c0080e7          	jalr	1984(ra) # 800093e2 <release>

  acquire(&wait_lock);
    80001c2a:	00010517          	auipc	a0,0x10
    80001c2e:	e8650513          	addi	a0,a0,-378 # 80011ab0 <wait_lock>
    80001c32:	00007097          	auipc	ra,0x7
    80001c36:	74c080e7          	jalr	1868(ra) # 8000937e <acquire>
  np->parent = p;
    80001c3a:	fd843783          	ld	a5,-40(s0)
    80001c3e:	fe043703          	ld	a4,-32(s0)
    80001c42:	ff98                	sd	a4,56(a5)
  release(&wait_lock);
    80001c44:	00010517          	auipc	a0,0x10
    80001c48:	e6c50513          	addi	a0,a0,-404 # 80011ab0 <wait_lock>
    80001c4c:	00007097          	auipc	ra,0x7
    80001c50:	796080e7          	jalr	1942(ra) # 800093e2 <release>

  acquire(&np->lock);
    80001c54:	fd843783          	ld	a5,-40(s0)
    80001c58:	853e                	mv	a0,a5
    80001c5a:	00007097          	auipc	ra,0x7
    80001c5e:	724080e7          	jalr	1828(ra) # 8000937e <acquire>
  np->state = RUNNABLE;
    80001c62:	fd843783          	ld	a5,-40(s0)
    80001c66:	470d                	li	a4,3
    80001c68:	cf98                	sw	a4,24(a5)
  release(&np->lock);
    80001c6a:	fd843783          	ld	a5,-40(s0)
    80001c6e:	853e                	mv	a0,a5
    80001c70:	00007097          	auipc	ra,0x7
    80001c74:	772080e7          	jalr	1906(ra) # 800093e2 <release>

  np->trace_mask = p->trace_mask;
    80001c78:	fe043783          	ld	a5,-32(s0)
    80001c7c:	1687a703          	lw	a4,360(a5)
    80001c80:	fd843783          	ld	a5,-40(s0)
    80001c84:	16e7a423          	sw	a4,360(a5)

  return pid;
    80001c88:	fd442783          	lw	a5,-44(s0)
}
    80001c8c:	853e                	mv	a0,a5
    80001c8e:	70a2                	ld	ra,40(sp)
    80001c90:	7402                	ld	s0,32(sp)
    80001c92:	6145                	addi	sp,sp,48
    80001c94:	8082                	ret

0000000080001c96 <reparent>:

// Pass p's abandoned children to init.
// Caller must hold wait_lock.
void
reparent(struct proc *p)
{
    80001c96:	7179                	addi	sp,sp,-48
    80001c98:	f406                	sd	ra,40(sp)
    80001c9a:	f022                	sd	s0,32(sp)
    80001c9c:	1800                	addi	s0,sp,48
    80001c9e:	fca43c23          	sd	a0,-40(s0)
  struct proc *pp;

  for(pp = proc; pp < &proc[NPROC]; pp++){
    80001ca2:	0000a797          	auipc	a5,0xa
    80001ca6:	1f678793          	addi	a5,a5,502 # 8000be98 <proc>
    80001caa:	fef43423          	sd	a5,-24(s0)
    80001cae:	a081                	j	80001cee <reparent+0x58>
    if(pp->parent == p){
    80001cb0:	fe843783          	ld	a5,-24(s0)
    80001cb4:	7f9c                	ld	a5,56(a5)
    80001cb6:	fd843703          	ld	a4,-40(s0)
    80001cba:	02f71463          	bne	a4,a5,80001ce2 <reparent+0x4c>
      pp->parent = initproc;
    80001cbe:	0000a797          	auipc	a5,0xa
    80001cc2:	d8a78793          	addi	a5,a5,-630 # 8000ba48 <initproc>
    80001cc6:	6398                	ld	a4,0(a5)
    80001cc8:	fe843783          	ld	a5,-24(s0)
    80001ccc:	ff98                	sd	a4,56(a5)
      wakeup(initproc);
    80001cce:	0000a797          	auipc	a5,0xa
    80001cd2:	d7a78793          	addi	a5,a5,-646 # 8000ba48 <initproc>
    80001cd6:	639c                	ld	a5,0(a5)
    80001cd8:	853e                	mv	a0,a5
    80001cda:	00000097          	auipc	ra,0x0
    80001cde:	57c080e7          	jalr	1404(ra) # 80002256 <wakeup>
  for(pp = proc; pp < &proc[NPROC]; pp++){
    80001ce2:	fe843783          	ld	a5,-24(s0)
    80001ce6:	17078793          	addi	a5,a5,368
    80001cea:	fef43423          	sd	a5,-24(s0)
    80001cee:	fe843703          	ld	a4,-24(s0)
    80001cf2:	00010797          	auipc	a5,0x10
    80001cf6:	da678793          	addi	a5,a5,-602 # 80011a98 <pid_lock>
    80001cfa:	faf76be3          	bltu	a4,a5,80001cb0 <reparent+0x1a>
    }
  }
}
    80001cfe:	0001                	nop
    80001d00:	0001                	nop
    80001d02:	70a2                	ld	ra,40(sp)
    80001d04:	7402                	ld	s0,32(sp)
    80001d06:	6145                	addi	sp,sp,48
    80001d08:	8082                	ret

0000000080001d0a <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait().
void
exit(int status)
{
    80001d0a:	7139                	addi	sp,sp,-64
    80001d0c:	fc06                	sd	ra,56(sp)
    80001d0e:	f822                	sd	s0,48(sp)
    80001d10:	0080                	addi	s0,sp,64
    80001d12:	87aa                	mv	a5,a0
    80001d14:	fcf42623          	sw	a5,-52(s0)
  struct proc *p = myproc();
    80001d18:	00000097          	auipc	ra,0x0
    80001d1c:	8e8080e7          	jalr	-1816(ra) # 80001600 <myproc>
    80001d20:	fea43023          	sd	a0,-32(s0)

  if(p == initproc)
    80001d24:	0000a797          	auipc	a5,0xa
    80001d28:	d2478793          	addi	a5,a5,-732 # 8000ba48 <initproc>
    80001d2c:	639c                	ld	a5,0(a5)
    80001d2e:	fe043703          	ld	a4,-32(s0)
    80001d32:	00f71a63          	bne	a4,a5,80001d46 <exit+0x3c>
    panic("init exiting");
    80001d36:	00009517          	auipc	a0,0x9
    80001d3a:	45a50513          	addi	a0,a0,1114 # 8000b190 <etext+0x190>
    80001d3e:	00007097          	auipc	ra,0x7
    80001d42:	1f8080e7          	jalr	504(ra) # 80008f36 <panic>

  // Close all open files.
  for(int fd = 0; fd < NOFILE; fd++){
    80001d46:	fe042623          	sw	zero,-20(s0)
    80001d4a:	a881                	j	80001d9a <exit+0x90>
    if(p->ofile[fd]){
    80001d4c:	fe043703          	ld	a4,-32(s0)
    80001d50:	fec42783          	lw	a5,-20(s0)
    80001d54:	07e9                	addi	a5,a5,26
    80001d56:	078e                	slli	a5,a5,0x3
    80001d58:	97ba                	add	a5,a5,a4
    80001d5a:	639c                	ld	a5,0(a5)
    80001d5c:	cb95                	beqz	a5,80001d90 <exit+0x86>
      struct file *f = p->ofile[fd];
    80001d5e:	fe043703          	ld	a4,-32(s0)
    80001d62:	fec42783          	lw	a5,-20(s0)
    80001d66:	07e9                	addi	a5,a5,26
    80001d68:	078e                	slli	a5,a5,0x3
    80001d6a:	97ba                	add	a5,a5,a4
    80001d6c:	639c                	ld	a5,0(a5)
    80001d6e:	fcf43c23          	sd	a5,-40(s0)
      fileclose(f);
    80001d72:	fd843503          	ld	a0,-40(s0)
    80001d76:	00004097          	auipc	ra,0x4
    80001d7a:	918080e7          	jalr	-1768(ra) # 8000568e <fileclose>
      p->ofile[fd] = 0;
    80001d7e:	fe043703          	ld	a4,-32(s0)
    80001d82:	fec42783          	lw	a5,-20(s0)
    80001d86:	07e9                	addi	a5,a5,26
    80001d88:	078e                	slli	a5,a5,0x3
    80001d8a:	97ba                	add	a5,a5,a4
    80001d8c:	0007b023          	sd	zero,0(a5)
  for(int fd = 0; fd < NOFILE; fd++){
    80001d90:	fec42783          	lw	a5,-20(s0)
    80001d94:	2785                	addiw	a5,a5,1
    80001d96:	fef42623          	sw	a5,-20(s0)
    80001d9a:	fec42783          	lw	a5,-20(s0)
    80001d9e:	0007871b          	sext.w	a4,a5
    80001da2:	47bd                	li	a5,15
    80001da4:	fae7d4e3          	bge	a5,a4,80001d4c <exit+0x42>
    }
  }

  begin_op();
    80001da8:	00003097          	auipc	ra,0x3
    80001dac:	24c080e7          	jalr	588(ra) # 80004ff4 <begin_op>
  iput(p->cwd);
    80001db0:	fe043783          	ld	a5,-32(s0)
    80001db4:	1507b783          	ld	a5,336(a5)
    80001db8:	853e                	mv	a0,a5
    80001dba:	00002097          	auipc	ra,0x2
    80001dbe:	334080e7          	jalr	820(ra) # 800040ee <iput>
  end_op();
    80001dc2:	00003097          	auipc	ra,0x3
    80001dc6:	2f4080e7          	jalr	756(ra) # 800050b6 <end_op>
  p->cwd = 0;
    80001dca:	fe043783          	ld	a5,-32(s0)
    80001dce:	1407b823          	sd	zero,336(a5)

  acquire(&wait_lock);
    80001dd2:	00010517          	auipc	a0,0x10
    80001dd6:	cde50513          	addi	a0,a0,-802 # 80011ab0 <wait_lock>
    80001dda:	00007097          	auipc	ra,0x7
    80001dde:	5a4080e7          	jalr	1444(ra) # 8000937e <acquire>

  // Give any children to init.
  reparent(p);
    80001de2:	fe043503          	ld	a0,-32(s0)
    80001de6:	00000097          	auipc	ra,0x0
    80001dea:	eb0080e7          	jalr	-336(ra) # 80001c96 <reparent>

  // Parent might be sleeping in wait().
  wakeup(p->parent);
    80001dee:	fe043783          	ld	a5,-32(s0)
    80001df2:	7f9c                	ld	a5,56(a5)
    80001df4:	853e                	mv	a0,a5
    80001df6:	00000097          	auipc	ra,0x0
    80001dfa:	460080e7          	jalr	1120(ra) # 80002256 <wakeup>
  
  acquire(&p->lock);
    80001dfe:	fe043783          	ld	a5,-32(s0)
    80001e02:	853e                	mv	a0,a5
    80001e04:	00007097          	auipc	ra,0x7
    80001e08:	57a080e7          	jalr	1402(ra) # 8000937e <acquire>

  p->xstate = status;
    80001e0c:	fe043783          	ld	a5,-32(s0)
    80001e10:	fcc42703          	lw	a4,-52(s0)
    80001e14:	d7d8                	sw	a4,44(a5)
  p->state = ZOMBIE;
    80001e16:	fe043783          	ld	a5,-32(s0)
    80001e1a:	4715                	li	a4,5
    80001e1c:	cf98                	sw	a4,24(a5)

  release(&wait_lock);
    80001e1e:	00010517          	auipc	a0,0x10
    80001e22:	c9250513          	addi	a0,a0,-878 # 80011ab0 <wait_lock>
    80001e26:	00007097          	auipc	ra,0x7
    80001e2a:	5bc080e7          	jalr	1468(ra) # 800093e2 <release>

  // Jump into the scheduler, never to return.
  sched();
    80001e2e:	00000097          	auipc	ra,0x0
    80001e32:	230080e7          	jalr	560(ra) # 8000205e <sched>
  panic("zombie exit");
    80001e36:	00009517          	auipc	a0,0x9
    80001e3a:	36a50513          	addi	a0,a0,874 # 8000b1a0 <etext+0x1a0>
    80001e3e:	00007097          	auipc	ra,0x7
    80001e42:	0f8080e7          	jalr	248(ra) # 80008f36 <panic>

0000000080001e46 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(uint64 addr)
{
    80001e46:	7139                	addi	sp,sp,-64
    80001e48:	fc06                	sd	ra,56(sp)
    80001e4a:	f822                	sd	s0,48(sp)
    80001e4c:	0080                	addi	s0,sp,64
    80001e4e:	fca43423          	sd	a0,-56(s0)
  struct proc *pp;
  int havekids, pid;
  struct proc *p = myproc();
    80001e52:	fffff097          	auipc	ra,0xfffff
    80001e56:	7ae080e7          	jalr	1966(ra) # 80001600 <myproc>
    80001e5a:	fca43c23          	sd	a0,-40(s0)

  acquire(&wait_lock);
    80001e5e:	00010517          	auipc	a0,0x10
    80001e62:	c5250513          	addi	a0,a0,-942 # 80011ab0 <wait_lock>
    80001e66:	00007097          	auipc	ra,0x7
    80001e6a:	518080e7          	jalr	1304(ra) # 8000937e <acquire>

  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    80001e6e:	fe042223          	sw	zero,-28(s0)
    for(pp = proc; pp < &proc[NPROC]; pp++){
    80001e72:	0000a797          	auipc	a5,0xa
    80001e76:	02678793          	addi	a5,a5,38 # 8000be98 <proc>
    80001e7a:	fef43423          	sd	a5,-24(s0)
    80001e7e:	a8d1                	j	80001f52 <wait+0x10c>
      if(pp->parent == p){
    80001e80:	fe843783          	ld	a5,-24(s0)
    80001e84:	7f9c                	ld	a5,56(a5)
    80001e86:	fd843703          	ld	a4,-40(s0)
    80001e8a:	0af71e63          	bne	a4,a5,80001f46 <wait+0x100>
        // make sure the child isn't still in exit() or swtch().
        acquire(&pp->lock);
    80001e8e:	fe843783          	ld	a5,-24(s0)
    80001e92:	853e                	mv	a0,a5
    80001e94:	00007097          	auipc	ra,0x7
    80001e98:	4ea080e7          	jalr	1258(ra) # 8000937e <acquire>

        havekids = 1;
    80001e9c:	4785                	li	a5,1
    80001e9e:	fef42223          	sw	a5,-28(s0)
        if(pp->state == ZOMBIE){
    80001ea2:	fe843783          	ld	a5,-24(s0)
    80001ea6:	4f9c                	lw	a5,24(a5)
    80001ea8:	873e                	mv	a4,a5
    80001eaa:	4795                	li	a5,5
    80001eac:	08f71663          	bne	a4,a5,80001f38 <wait+0xf2>
          // Found one.
          pid = pp->pid;
    80001eb0:	fe843783          	ld	a5,-24(s0)
    80001eb4:	5b9c                	lw	a5,48(a5)
    80001eb6:	fcf42a23          	sw	a5,-44(s0)
          if(addr != 0 && copyout(p->pagetable, addr, (char *)&pp->xstate,
    80001eba:	fc843783          	ld	a5,-56(s0)
    80001ebe:	c7a9                	beqz	a5,80001f08 <wait+0xc2>
    80001ec0:	fd843783          	ld	a5,-40(s0)
    80001ec4:	6bb8                	ld	a4,80(a5)
    80001ec6:	fe843783          	ld	a5,-24(s0)
    80001eca:	02c78793          	addi	a5,a5,44
    80001ece:	4691                	li	a3,4
    80001ed0:	863e                	mv	a2,a5
    80001ed2:	fc843583          	ld	a1,-56(s0)
    80001ed6:	853a                	mv	a0,a4
    80001ed8:	fffff097          	auipc	ra,0xfffff
    80001edc:	1f2080e7          	jalr	498(ra) # 800010ca <copyout>
    80001ee0:	87aa                	mv	a5,a0
    80001ee2:	0207d363          	bgez	a5,80001f08 <wait+0xc2>
                                  sizeof(pp->xstate)) < 0) {
            release(&pp->lock);
    80001ee6:	fe843783          	ld	a5,-24(s0)
    80001eea:	853e                	mv	a0,a5
    80001eec:	00007097          	auipc	ra,0x7
    80001ef0:	4f6080e7          	jalr	1270(ra) # 800093e2 <release>
            release(&wait_lock);
    80001ef4:	00010517          	auipc	a0,0x10
    80001ef8:	bbc50513          	addi	a0,a0,-1092 # 80011ab0 <wait_lock>
    80001efc:	00007097          	auipc	ra,0x7
    80001f00:	4e6080e7          	jalr	1254(ra) # 800093e2 <release>
            return -1;
    80001f04:	57fd                	li	a5,-1
    80001f06:	a879                	j	80001fa4 <wait+0x15e>
          }
          freeproc(pp);
    80001f08:	fe843503          	ld	a0,-24(s0)
    80001f0c:	00000097          	auipc	ra,0x0
    80001f10:	8b8080e7          	jalr	-1864(ra) # 800017c4 <freeproc>
          release(&pp->lock);
    80001f14:	fe843783          	ld	a5,-24(s0)
    80001f18:	853e                	mv	a0,a5
    80001f1a:	00007097          	auipc	ra,0x7
    80001f1e:	4c8080e7          	jalr	1224(ra) # 800093e2 <release>
          release(&wait_lock);
    80001f22:	00010517          	auipc	a0,0x10
    80001f26:	b8e50513          	addi	a0,a0,-1138 # 80011ab0 <wait_lock>
    80001f2a:	00007097          	auipc	ra,0x7
    80001f2e:	4b8080e7          	jalr	1208(ra) # 800093e2 <release>
          return pid;
    80001f32:	fd442783          	lw	a5,-44(s0)
    80001f36:	a0bd                	j	80001fa4 <wait+0x15e>
        }
        release(&pp->lock);
    80001f38:	fe843783          	ld	a5,-24(s0)
    80001f3c:	853e                	mv	a0,a5
    80001f3e:	00007097          	auipc	ra,0x7
    80001f42:	4a4080e7          	jalr	1188(ra) # 800093e2 <release>
    for(pp = proc; pp < &proc[NPROC]; pp++){
    80001f46:	fe843783          	ld	a5,-24(s0)
    80001f4a:	17078793          	addi	a5,a5,368
    80001f4e:	fef43423          	sd	a5,-24(s0)
    80001f52:	fe843703          	ld	a4,-24(s0)
    80001f56:	00010797          	auipc	a5,0x10
    80001f5a:	b4278793          	addi	a5,a5,-1214 # 80011a98 <pid_lock>
    80001f5e:	f2f761e3          	bltu	a4,a5,80001e80 <wait+0x3a>
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || killed(p)){
    80001f62:	fe442783          	lw	a5,-28(s0)
    80001f66:	2781                	sext.w	a5,a5
    80001f68:	cb89                	beqz	a5,80001f7a <wait+0x134>
    80001f6a:	fd843503          	ld	a0,-40(s0)
    80001f6e:	00000097          	auipc	ra,0x0
    80001f72:	456080e7          	jalr	1110(ra) # 800023c4 <killed>
    80001f76:	87aa                	mv	a5,a0
    80001f78:	cb99                	beqz	a5,80001f8e <wait+0x148>
      release(&wait_lock);
    80001f7a:	00010517          	auipc	a0,0x10
    80001f7e:	b3650513          	addi	a0,a0,-1226 # 80011ab0 <wait_lock>
    80001f82:	00007097          	auipc	ra,0x7
    80001f86:	460080e7          	jalr	1120(ra) # 800093e2 <release>
      return -1;
    80001f8a:	57fd                	li	a5,-1
    80001f8c:	a821                	j	80001fa4 <wait+0x15e>
    }
    
    // Wait for a child to exit.
    sleep(p, &wait_lock);  //DOC: wait-sleep
    80001f8e:	00010597          	auipc	a1,0x10
    80001f92:	b2258593          	addi	a1,a1,-1246 # 80011ab0 <wait_lock>
    80001f96:	fd843503          	ld	a0,-40(s0)
    80001f9a:	00000097          	auipc	ra,0x0
    80001f9e:	240080e7          	jalr	576(ra) # 800021da <sleep>
    havekids = 0;
    80001fa2:	b5f1                	j	80001e6e <wait+0x28>
  }
}
    80001fa4:	853e                	mv	a0,a5
    80001fa6:	70e2                	ld	ra,56(sp)
    80001fa8:	7442                	ld	s0,48(sp)
    80001faa:	6121                	addi	sp,sp,64
    80001fac:	8082                	ret

0000000080001fae <scheduler>:
//  - swtch to start running that process.
//  - eventually that process transfers control
//    via swtch back to the scheduler.
void
scheduler(void)
{
    80001fae:	1101                	addi	sp,sp,-32
    80001fb0:	ec06                	sd	ra,24(sp)
    80001fb2:	e822                	sd	s0,16(sp)
    80001fb4:	1000                	addi	s0,sp,32
  struct proc *p;
  struct cpu *c = mycpu();
    80001fb6:	fffff097          	auipc	ra,0xfffff
    80001fba:	610080e7          	jalr	1552(ra) # 800015c6 <mycpu>
    80001fbe:	fea43023          	sd	a0,-32(s0)
  
  c->proc = 0;
    80001fc2:	fe043783          	ld	a5,-32(s0)
    80001fc6:	0007b023          	sd	zero,0(a5)
  for(;;){
    // Avoid deadlock by ensuring that devices can interrupt.
    intr_on();
    80001fca:	fffff097          	auipc	ra,0xfffff
    80001fce:	3de080e7          	jalr	990(ra) # 800013a8 <intr_on>

    for(p = proc; p < &proc[NPROC]; p++) {
    80001fd2:	0000a797          	auipc	a5,0xa
    80001fd6:	ec678793          	addi	a5,a5,-314 # 8000be98 <proc>
    80001fda:	fef43423          	sd	a5,-24(s0)
    80001fde:	a0bd                	j	8000204c <scheduler+0x9e>
      acquire(&p->lock);
    80001fe0:	fe843783          	ld	a5,-24(s0)
    80001fe4:	853e                	mv	a0,a5
    80001fe6:	00007097          	auipc	ra,0x7
    80001fea:	398080e7          	jalr	920(ra) # 8000937e <acquire>
      if(p->state == RUNNABLE) {
    80001fee:	fe843783          	ld	a5,-24(s0)
    80001ff2:	4f9c                	lw	a5,24(a5)
    80001ff4:	873e                	mv	a4,a5
    80001ff6:	478d                	li	a5,3
    80001ff8:	02f71d63          	bne	a4,a5,80002032 <scheduler+0x84>
        // Switch to chosen process.  It is the process's job
        // to release its lock and then reacquire it
        // before jumping back to us.
        p->state = RUNNING;
    80001ffc:	fe843783          	ld	a5,-24(s0)
    80002000:	4711                	li	a4,4
    80002002:	cf98                	sw	a4,24(a5)
        c->proc = p;
    80002004:	fe043783          	ld	a5,-32(s0)
    80002008:	fe843703          	ld	a4,-24(s0)
    8000200c:	e398                	sd	a4,0(a5)
        swtch(&c->context, &p->context);
    8000200e:	fe043783          	ld	a5,-32(s0)
    80002012:	00878713          	addi	a4,a5,8
    80002016:	fe843783          	ld	a5,-24(s0)
    8000201a:	06078793          	addi	a5,a5,96
    8000201e:	85be                	mv	a1,a5
    80002020:	853a                	mv	a0,a4
    80002022:	00000097          	auipc	ra,0x0
    80002026:	5fe080e7          	jalr	1534(ra) # 80002620 <swtch>

        // Process is done running for now.
        // It should have changed its p->state before coming back.
        c->proc = 0;
    8000202a:	fe043783          	ld	a5,-32(s0)
    8000202e:	0007b023          	sd	zero,0(a5)
      }
      release(&p->lock);
    80002032:	fe843783          	ld	a5,-24(s0)
    80002036:	853e                	mv	a0,a5
    80002038:	00007097          	auipc	ra,0x7
    8000203c:	3aa080e7          	jalr	938(ra) # 800093e2 <release>
    for(p = proc; p < &proc[NPROC]; p++) {
    80002040:	fe843783          	ld	a5,-24(s0)
    80002044:	17078793          	addi	a5,a5,368
    80002048:	fef43423          	sd	a5,-24(s0)
    8000204c:	fe843703          	ld	a4,-24(s0)
    80002050:	00010797          	auipc	a5,0x10
    80002054:	a4878793          	addi	a5,a5,-1464 # 80011a98 <pid_lock>
    80002058:	f8f764e3          	bltu	a4,a5,80001fe0 <scheduler+0x32>
    intr_on();
    8000205c:	b7bd                	j	80001fca <scheduler+0x1c>

000000008000205e <sched>:
// be proc->intena and proc->noff, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
    8000205e:	7179                	addi	sp,sp,-48
    80002060:	f406                	sd	ra,40(sp)
    80002062:	f022                	sd	s0,32(sp)
    80002064:	ec26                	sd	s1,24(sp)
    80002066:	1800                	addi	s0,sp,48
  int intena;
  struct proc *p = myproc();
    80002068:	fffff097          	auipc	ra,0xfffff
    8000206c:	598080e7          	jalr	1432(ra) # 80001600 <myproc>
    80002070:	fca43c23          	sd	a0,-40(s0)

  if(!holding(&p->lock))
    80002074:	fd843783          	ld	a5,-40(s0)
    80002078:	853e                	mv	a0,a5
    8000207a:	00007097          	auipc	ra,0x7
    8000207e:	3be080e7          	jalr	958(ra) # 80009438 <holding>
    80002082:	87aa                	mv	a5,a0
    80002084:	eb89                	bnez	a5,80002096 <sched+0x38>
    panic("sched p->lock");
    80002086:	00009517          	auipc	a0,0x9
    8000208a:	12a50513          	addi	a0,a0,298 # 8000b1b0 <etext+0x1b0>
    8000208e:	00007097          	auipc	ra,0x7
    80002092:	ea8080e7          	jalr	-344(ra) # 80008f36 <panic>
  if(mycpu()->noff != 1)
    80002096:	fffff097          	auipc	ra,0xfffff
    8000209a:	530080e7          	jalr	1328(ra) # 800015c6 <mycpu>
    8000209e:	87aa                	mv	a5,a0
    800020a0:	5fbc                	lw	a5,120(a5)
    800020a2:	873e                	mv	a4,a5
    800020a4:	4785                	li	a5,1
    800020a6:	00f70a63          	beq	a4,a5,800020ba <sched+0x5c>
    panic("sched locks");
    800020aa:	00009517          	auipc	a0,0x9
    800020ae:	11650513          	addi	a0,a0,278 # 8000b1c0 <etext+0x1c0>
    800020b2:	00007097          	auipc	ra,0x7
    800020b6:	e84080e7          	jalr	-380(ra) # 80008f36 <panic>
  if(p->state == RUNNING)
    800020ba:	fd843783          	ld	a5,-40(s0)
    800020be:	4f9c                	lw	a5,24(a5)
    800020c0:	873e                	mv	a4,a5
    800020c2:	4791                	li	a5,4
    800020c4:	00f71a63          	bne	a4,a5,800020d8 <sched+0x7a>
    panic("sched running");
    800020c8:	00009517          	auipc	a0,0x9
    800020cc:	10850513          	addi	a0,a0,264 # 8000b1d0 <etext+0x1d0>
    800020d0:	00007097          	auipc	ra,0x7
    800020d4:	e66080e7          	jalr	-410(ra) # 80008f36 <panic>
  if(intr_get())
    800020d8:	fffff097          	auipc	ra,0xfffff
    800020dc:	2fa080e7          	jalr	762(ra) # 800013d2 <intr_get>
    800020e0:	87aa                	mv	a5,a0
    800020e2:	cb89                	beqz	a5,800020f4 <sched+0x96>
    panic("sched interruptible");
    800020e4:	00009517          	auipc	a0,0x9
    800020e8:	0fc50513          	addi	a0,a0,252 # 8000b1e0 <etext+0x1e0>
    800020ec:	00007097          	auipc	ra,0x7
    800020f0:	e4a080e7          	jalr	-438(ra) # 80008f36 <panic>

  intena = mycpu()->intena;
    800020f4:	fffff097          	auipc	ra,0xfffff
    800020f8:	4d2080e7          	jalr	1234(ra) # 800015c6 <mycpu>
    800020fc:	87aa                	mv	a5,a0
    800020fe:	5ffc                	lw	a5,124(a5)
    80002100:	fcf42a23          	sw	a5,-44(s0)
  swtch(&p->context, &mycpu()->context);
    80002104:	fd843783          	ld	a5,-40(s0)
    80002108:	06078493          	addi	s1,a5,96
    8000210c:	fffff097          	auipc	ra,0xfffff
    80002110:	4ba080e7          	jalr	1210(ra) # 800015c6 <mycpu>
    80002114:	87aa                	mv	a5,a0
    80002116:	07a1                	addi	a5,a5,8
    80002118:	85be                	mv	a1,a5
    8000211a:	8526                	mv	a0,s1
    8000211c:	00000097          	auipc	ra,0x0
    80002120:	504080e7          	jalr	1284(ra) # 80002620 <swtch>
  mycpu()->intena = intena;
    80002124:	fffff097          	auipc	ra,0xfffff
    80002128:	4a2080e7          	jalr	1186(ra) # 800015c6 <mycpu>
    8000212c:	872a                	mv	a4,a0
    8000212e:	fd442783          	lw	a5,-44(s0)
    80002132:	df7c                	sw	a5,124(a4)
}
    80002134:	0001                	nop
    80002136:	70a2                	ld	ra,40(sp)
    80002138:	7402                	ld	s0,32(sp)
    8000213a:	64e2                	ld	s1,24(sp)
    8000213c:	6145                	addi	sp,sp,48
    8000213e:	8082                	ret

0000000080002140 <yield>:

// Give up the CPU for one scheduling round.
void
yield(void)
{
    80002140:	1101                	addi	sp,sp,-32
    80002142:	ec06                	sd	ra,24(sp)
    80002144:	e822                	sd	s0,16(sp)
    80002146:	1000                	addi	s0,sp,32
  struct proc *p = myproc();
    80002148:	fffff097          	auipc	ra,0xfffff
    8000214c:	4b8080e7          	jalr	1208(ra) # 80001600 <myproc>
    80002150:	fea43423          	sd	a0,-24(s0)
  acquire(&p->lock);
    80002154:	fe843783          	ld	a5,-24(s0)
    80002158:	853e                	mv	a0,a5
    8000215a:	00007097          	auipc	ra,0x7
    8000215e:	224080e7          	jalr	548(ra) # 8000937e <acquire>
  p->state = RUNNABLE;
    80002162:	fe843783          	ld	a5,-24(s0)
    80002166:	470d                	li	a4,3
    80002168:	cf98                	sw	a4,24(a5)
  sched();
    8000216a:	00000097          	auipc	ra,0x0
    8000216e:	ef4080e7          	jalr	-268(ra) # 8000205e <sched>
  release(&p->lock);
    80002172:	fe843783          	ld	a5,-24(s0)
    80002176:	853e                	mv	a0,a5
    80002178:	00007097          	auipc	ra,0x7
    8000217c:	26a080e7          	jalr	618(ra) # 800093e2 <release>
}
    80002180:	0001                	nop
    80002182:	60e2                	ld	ra,24(sp)
    80002184:	6442                	ld	s0,16(sp)
    80002186:	6105                	addi	sp,sp,32
    80002188:	8082                	ret

000000008000218a <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch to forkret.
void
forkret(void)
{
    8000218a:	1141                	addi	sp,sp,-16
    8000218c:	e406                	sd	ra,8(sp)
    8000218e:	e022                	sd	s0,0(sp)
    80002190:	0800                	addi	s0,sp,16
  static int first = 1;

  // Still holding p->lock from scheduler.
  release(&myproc()->lock);
    80002192:	fffff097          	auipc	ra,0xfffff
    80002196:	46e080e7          	jalr	1134(ra) # 80001600 <myproc>
    8000219a:	87aa                	mv	a5,a0
    8000219c:	853e                	mv	a0,a5
    8000219e:	00007097          	auipc	ra,0x7
    800021a2:	244080e7          	jalr	580(ra) # 800093e2 <release>

  if (first) {
    800021a6:	00009797          	auipc	a5,0x9
    800021aa:	68e78793          	addi	a5,a5,1678 # 8000b834 <first.1>
    800021ae:	439c                	lw	a5,0(a5)
    800021b0:	cf81                	beqz	a5,800021c8 <forkret+0x3e>
    // File system initialization must be run in the context of a
    // regular process (e.g., because it calls sleep), and thus cannot
    // be run from main().
    first = 0;
    800021b2:	00009797          	auipc	a5,0x9
    800021b6:	68278793          	addi	a5,a5,1666 # 8000b834 <first.1>
    800021ba:	0007a023          	sw	zero,0(a5)
    fsinit(ROOTDEV);
    800021be:	4505                	li	a0,1
    800021c0:	00001097          	auipc	ra,0x1
    800021c4:	642080e7          	jalr	1602(ra) # 80003802 <fsinit>
  }

  usertrapret();
    800021c8:	00001097          	auipc	ra,0x1
    800021cc:	80a080e7          	jalr	-2038(ra) # 800029d2 <usertrapret>
}
    800021d0:	0001                	nop
    800021d2:	60a2                	ld	ra,8(sp)
    800021d4:	6402                	ld	s0,0(sp)
    800021d6:	0141                	addi	sp,sp,16
    800021d8:	8082                	ret

00000000800021da <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
    800021da:	7179                	addi	sp,sp,-48
    800021dc:	f406                	sd	ra,40(sp)
    800021de:	f022                	sd	s0,32(sp)
    800021e0:	1800                	addi	s0,sp,48
    800021e2:	fca43c23          	sd	a0,-40(s0)
    800021e6:	fcb43823          	sd	a1,-48(s0)
  struct proc *p = myproc();
    800021ea:	fffff097          	auipc	ra,0xfffff
    800021ee:	416080e7          	jalr	1046(ra) # 80001600 <myproc>
    800021f2:	fea43423          	sd	a0,-24(s0)
  // Once we hold p->lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup locks p->lock),
  // so it's okay to release lk.

  acquire(&p->lock);  //DOC: sleeplock1
    800021f6:	fe843783          	ld	a5,-24(s0)
    800021fa:	853e                	mv	a0,a5
    800021fc:	00007097          	auipc	ra,0x7
    80002200:	182080e7          	jalr	386(ra) # 8000937e <acquire>
  release(lk);
    80002204:	fd043503          	ld	a0,-48(s0)
    80002208:	00007097          	auipc	ra,0x7
    8000220c:	1da080e7          	jalr	474(ra) # 800093e2 <release>

  // Go to sleep.
  p->chan = chan;
    80002210:	fe843783          	ld	a5,-24(s0)
    80002214:	fd843703          	ld	a4,-40(s0)
    80002218:	f398                	sd	a4,32(a5)
  p->state = SLEEPING;
    8000221a:	fe843783          	ld	a5,-24(s0)
    8000221e:	4709                	li	a4,2
    80002220:	cf98                	sw	a4,24(a5)

  sched();
    80002222:	00000097          	auipc	ra,0x0
    80002226:	e3c080e7          	jalr	-452(ra) # 8000205e <sched>

  // Tidy up.
  p->chan = 0;
    8000222a:	fe843783          	ld	a5,-24(s0)
    8000222e:	0207b023          	sd	zero,32(a5)

  // Reacquire original lock.
  release(&p->lock);
    80002232:	fe843783          	ld	a5,-24(s0)
    80002236:	853e                	mv	a0,a5
    80002238:	00007097          	auipc	ra,0x7
    8000223c:	1aa080e7          	jalr	426(ra) # 800093e2 <release>
  acquire(lk);
    80002240:	fd043503          	ld	a0,-48(s0)
    80002244:	00007097          	auipc	ra,0x7
    80002248:	13a080e7          	jalr	314(ra) # 8000937e <acquire>
}
    8000224c:	0001                	nop
    8000224e:	70a2                	ld	ra,40(sp)
    80002250:	7402                	ld	s0,32(sp)
    80002252:	6145                	addi	sp,sp,48
    80002254:	8082                	ret

0000000080002256 <wakeup>:

// Wake up all processes sleeping on chan.
// Must be called without any p->lock.
void
wakeup(void *chan)
{
    80002256:	7179                	addi	sp,sp,-48
    80002258:	f406                	sd	ra,40(sp)
    8000225a:	f022                	sd	s0,32(sp)
    8000225c:	1800                	addi	s0,sp,48
    8000225e:	fca43c23          	sd	a0,-40(s0)
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    80002262:	0000a797          	auipc	a5,0xa
    80002266:	c3678793          	addi	a5,a5,-970 # 8000be98 <proc>
    8000226a:	fef43423          	sd	a5,-24(s0)
    8000226e:	a085                	j	800022ce <wakeup+0x78>
    if(p != myproc()){
    80002270:	fffff097          	auipc	ra,0xfffff
    80002274:	390080e7          	jalr	912(ra) # 80001600 <myproc>
    80002278:	872a                	mv	a4,a0
    8000227a:	fe843783          	ld	a5,-24(s0)
    8000227e:	04e78263          	beq	a5,a4,800022c2 <wakeup+0x6c>
      acquire(&p->lock);
    80002282:	fe843783          	ld	a5,-24(s0)
    80002286:	853e                	mv	a0,a5
    80002288:	00007097          	auipc	ra,0x7
    8000228c:	0f6080e7          	jalr	246(ra) # 8000937e <acquire>
      if(p->state == SLEEPING && p->chan == chan) {
    80002290:	fe843783          	ld	a5,-24(s0)
    80002294:	4f9c                	lw	a5,24(a5)
    80002296:	873e                	mv	a4,a5
    80002298:	4789                	li	a5,2
    8000229a:	00f71d63          	bne	a4,a5,800022b4 <wakeup+0x5e>
    8000229e:	fe843783          	ld	a5,-24(s0)
    800022a2:	739c                	ld	a5,32(a5)
    800022a4:	fd843703          	ld	a4,-40(s0)
    800022a8:	00f71663          	bne	a4,a5,800022b4 <wakeup+0x5e>
        p->state = RUNNABLE;
    800022ac:	fe843783          	ld	a5,-24(s0)
    800022b0:	470d                	li	a4,3
    800022b2:	cf98                	sw	a4,24(a5)
      }
      release(&p->lock);
    800022b4:	fe843783          	ld	a5,-24(s0)
    800022b8:	853e                	mv	a0,a5
    800022ba:	00007097          	auipc	ra,0x7
    800022be:	128080e7          	jalr	296(ra) # 800093e2 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    800022c2:	fe843783          	ld	a5,-24(s0)
    800022c6:	17078793          	addi	a5,a5,368
    800022ca:	fef43423          	sd	a5,-24(s0)
    800022ce:	fe843703          	ld	a4,-24(s0)
    800022d2:	0000f797          	auipc	a5,0xf
    800022d6:	7c678793          	addi	a5,a5,1990 # 80011a98 <pid_lock>
    800022da:	f8f76be3          	bltu	a4,a5,80002270 <wakeup+0x1a>
    }
  }
}
    800022de:	0001                	nop
    800022e0:	0001                	nop
    800022e2:	70a2                	ld	ra,40(sp)
    800022e4:	7402                	ld	s0,32(sp)
    800022e6:	6145                	addi	sp,sp,48
    800022e8:	8082                	ret

00000000800022ea <kill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kill(int pid)
{
    800022ea:	7179                	addi	sp,sp,-48
    800022ec:	f406                	sd	ra,40(sp)
    800022ee:	f022                	sd	s0,32(sp)
    800022f0:	1800                	addi	s0,sp,48
    800022f2:	87aa                	mv	a5,a0
    800022f4:	fcf42e23          	sw	a5,-36(s0)
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++){
    800022f8:	0000a797          	auipc	a5,0xa
    800022fc:	ba078793          	addi	a5,a5,-1120 # 8000be98 <proc>
    80002300:	fef43423          	sd	a5,-24(s0)
    80002304:	a0ad                	j	8000236e <kill+0x84>
    acquire(&p->lock);
    80002306:	fe843783          	ld	a5,-24(s0)
    8000230a:	853e                	mv	a0,a5
    8000230c:	00007097          	auipc	ra,0x7
    80002310:	072080e7          	jalr	114(ra) # 8000937e <acquire>
    if(p->pid == pid){
    80002314:	fe843783          	ld	a5,-24(s0)
    80002318:	5b98                	lw	a4,48(a5)
    8000231a:	fdc42783          	lw	a5,-36(s0)
    8000231e:	2781                	sext.w	a5,a5
    80002320:	02e79a63          	bne	a5,a4,80002354 <kill+0x6a>
      p->killed = 1;
    80002324:	fe843783          	ld	a5,-24(s0)
    80002328:	4705                	li	a4,1
    8000232a:	d798                	sw	a4,40(a5)
      if(p->state == SLEEPING){
    8000232c:	fe843783          	ld	a5,-24(s0)
    80002330:	4f9c                	lw	a5,24(a5)
    80002332:	873e                	mv	a4,a5
    80002334:	4789                	li	a5,2
    80002336:	00f71663          	bne	a4,a5,80002342 <kill+0x58>
        // Wake process from sleep().
        p->state = RUNNABLE;
    8000233a:	fe843783          	ld	a5,-24(s0)
    8000233e:	470d                	li	a4,3
    80002340:	cf98                	sw	a4,24(a5)
      }
      release(&p->lock);
    80002342:	fe843783          	ld	a5,-24(s0)
    80002346:	853e                	mv	a0,a5
    80002348:	00007097          	auipc	ra,0x7
    8000234c:	09a080e7          	jalr	154(ra) # 800093e2 <release>
      return 0;
    80002350:	4781                	li	a5,0
    80002352:	a03d                	j	80002380 <kill+0x96>
    }
    release(&p->lock);
    80002354:	fe843783          	ld	a5,-24(s0)
    80002358:	853e                	mv	a0,a5
    8000235a:	00007097          	auipc	ra,0x7
    8000235e:	088080e7          	jalr	136(ra) # 800093e2 <release>
  for(p = proc; p < &proc[NPROC]; p++){
    80002362:	fe843783          	ld	a5,-24(s0)
    80002366:	17078793          	addi	a5,a5,368
    8000236a:	fef43423          	sd	a5,-24(s0)
    8000236e:	fe843703          	ld	a4,-24(s0)
    80002372:	0000f797          	auipc	a5,0xf
    80002376:	72678793          	addi	a5,a5,1830 # 80011a98 <pid_lock>
    8000237a:	f8f766e3          	bltu	a4,a5,80002306 <kill+0x1c>
  }
  return -1;
    8000237e:	57fd                	li	a5,-1
}
    80002380:	853e                	mv	a0,a5
    80002382:	70a2                	ld	ra,40(sp)
    80002384:	7402                	ld	s0,32(sp)
    80002386:	6145                	addi	sp,sp,48
    80002388:	8082                	ret

000000008000238a <setkilled>:

void
setkilled(struct proc *p)
{
    8000238a:	1101                	addi	sp,sp,-32
    8000238c:	ec06                	sd	ra,24(sp)
    8000238e:	e822                	sd	s0,16(sp)
    80002390:	1000                	addi	s0,sp,32
    80002392:	fea43423          	sd	a0,-24(s0)
  acquire(&p->lock);
    80002396:	fe843783          	ld	a5,-24(s0)
    8000239a:	853e                	mv	a0,a5
    8000239c:	00007097          	auipc	ra,0x7
    800023a0:	fe2080e7          	jalr	-30(ra) # 8000937e <acquire>
  p->killed = 1;
    800023a4:	fe843783          	ld	a5,-24(s0)
    800023a8:	4705                	li	a4,1
    800023aa:	d798                	sw	a4,40(a5)
  release(&p->lock);
    800023ac:	fe843783          	ld	a5,-24(s0)
    800023b0:	853e                	mv	a0,a5
    800023b2:	00007097          	auipc	ra,0x7
    800023b6:	030080e7          	jalr	48(ra) # 800093e2 <release>
}
    800023ba:	0001                	nop
    800023bc:	60e2                	ld	ra,24(sp)
    800023be:	6442                	ld	s0,16(sp)
    800023c0:	6105                	addi	sp,sp,32
    800023c2:	8082                	ret

00000000800023c4 <killed>:

int
killed(struct proc *p)
{
    800023c4:	7179                	addi	sp,sp,-48
    800023c6:	f406                	sd	ra,40(sp)
    800023c8:	f022                	sd	s0,32(sp)
    800023ca:	1800                	addi	s0,sp,48
    800023cc:	fca43c23          	sd	a0,-40(s0)
  int k;
  
  acquire(&p->lock);
    800023d0:	fd843783          	ld	a5,-40(s0)
    800023d4:	853e                	mv	a0,a5
    800023d6:	00007097          	auipc	ra,0x7
    800023da:	fa8080e7          	jalr	-88(ra) # 8000937e <acquire>
  k = p->killed;
    800023de:	fd843783          	ld	a5,-40(s0)
    800023e2:	579c                	lw	a5,40(a5)
    800023e4:	fef42623          	sw	a5,-20(s0)
  release(&p->lock);
    800023e8:	fd843783          	ld	a5,-40(s0)
    800023ec:	853e                	mv	a0,a5
    800023ee:	00007097          	auipc	ra,0x7
    800023f2:	ff4080e7          	jalr	-12(ra) # 800093e2 <release>
  return k;
    800023f6:	fec42783          	lw	a5,-20(s0)
}
    800023fa:	853e                	mv	a0,a5
    800023fc:	70a2                	ld	ra,40(sp)
    800023fe:	7402                	ld	s0,32(sp)
    80002400:	6145                	addi	sp,sp,48
    80002402:	8082                	ret

0000000080002404 <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    80002404:	7139                	addi	sp,sp,-64
    80002406:	fc06                	sd	ra,56(sp)
    80002408:	f822                	sd	s0,48(sp)
    8000240a:	0080                	addi	s0,sp,64
    8000240c:	87aa                	mv	a5,a0
    8000240e:	fcb43823          	sd	a1,-48(s0)
    80002412:	fcc43423          	sd	a2,-56(s0)
    80002416:	fcd43023          	sd	a3,-64(s0)
    8000241a:	fcf42e23          	sw	a5,-36(s0)
  struct proc *p = myproc();
    8000241e:	fffff097          	auipc	ra,0xfffff
    80002422:	1e2080e7          	jalr	482(ra) # 80001600 <myproc>
    80002426:	fea43423          	sd	a0,-24(s0)
  if(user_dst){
    8000242a:	fdc42783          	lw	a5,-36(s0)
    8000242e:	2781                	sext.w	a5,a5
    80002430:	c38d                	beqz	a5,80002452 <either_copyout+0x4e>
    return copyout(p->pagetable, dst, src, len);
    80002432:	fe843783          	ld	a5,-24(s0)
    80002436:	6bbc                	ld	a5,80(a5)
    80002438:	fc043683          	ld	a3,-64(s0)
    8000243c:	fc843603          	ld	a2,-56(s0)
    80002440:	fd043583          	ld	a1,-48(s0)
    80002444:	853e                	mv	a0,a5
    80002446:	fffff097          	auipc	ra,0xfffff
    8000244a:	c84080e7          	jalr	-892(ra) # 800010ca <copyout>
    8000244e:	87aa                	mv	a5,a0
    80002450:	a839                	j	8000246e <either_copyout+0x6a>
  } else {
    memmove((char *)dst, src, len);
    80002452:	fd043783          	ld	a5,-48(s0)
    80002456:	fc043703          	ld	a4,-64(s0)
    8000245a:	2701                	sext.w	a4,a4
    8000245c:	863a                	mv	a2,a4
    8000245e:	fc843583          	ld	a1,-56(s0)
    80002462:	853e                	mv	a0,a5
    80002464:	ffffe097          	auipc	ra,0xffffe
    80002468:	e8c080e7          	jalr	-372(ra) # 800002f0 <memmove>
    return 0;
    8000246c:	4781                	li	a5,0
  }
}
    8000246e:	853e                	mv	a0,a5
    80002470:	70e2                	ld	ra,56(sp)
    80002472:	7442                	ld	s0,48(sp)
    80002474:	6121                	addi	sp,sp,64
    80002476:	8082                	ret

0000000080002478 <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    80002478:	7139                	addi	sp,sp,-64
    8000247a:	fc06                	sd	ra,56(sp)
    8000247c:	f822                	sd	s0,48(sp)
    8000247e:	0080                	addi	s0,sp,64
    80002480:	fca43c23          	sd	a0,-40(s0)
    80002484:	87ae                	mv	a5,a1
    80002486:	fcc43423          	sd	a2,-56(s0)
    8000248a:	fcd43023          	sd	a3,-64(s0)
    8000248e:	fcf42a23          	sw	a5,-44(s0)
  struct proc *p = myproc();
    80002492:	fffff097          	auipc	ra,0xfffff
    80002496:	16e080e7          	jalr	366(ra) # 80001600 <myproc>
    8000249a:	fea43423          	sd	a0,-24(s0)
  if(user_src){
    8000249e:	fd442783          	lw	a5,-44(s0)
    800024a2:	2781                	sext.w	a5,a5
    800024a4:	c38d                	beqz	a5,800024c6 <either_copyin+0x4e>
    return copyin(p->pagetable, dst, src, len);
    800024a6:	fe843783          	ld	a5,-24(s0)
    800024aa:	6bbc                	ld	a5,80(a5)
    800024ac:	fc043683          	ld	a3,-64(s0)
    800024b0:	fc843603          	ld	a2,-56(s0)
    800024b4:	fd843583          	ld	a1,-40(s0)
    800024b8:	853e                	mv	a0,a5
    800024ba:	fffff097          	auipc	ra,0xfffff
    800024be:	cde080e7          	jalr	-802(ra) # 80001198 <copyin>
    800024c2:	87aa                	mv	a5,a0
    800024c4:	a839                	j	800024e2 <either_copyin+0x6a>
  } else {
    memmove(dst, (char*)src, len);
    800024c6:	fc843783          	ld	a5,-56(s0)
    800024ca:	fc043703          	ld	a4,-64(s0)
    800024ce:	2701                	sext.w	a4,a4
    800024d0:	863a                	mv	a2,a4
    800024d2:	85be                	mv	a1,a5
    800024d4:	fd843503          	ld	a0,-40(s0)
    800024d8:	ffffe097          	auipc	ra,0xffffe
    800024dc:	e18080e7          	jalr	-488(ra) # 800002f0 <memmove>
    return 0;
    800024e0:	4781                	li	a5,0
  }
}
    800024e2:	853e                	mv	a0,a5
    800024e4:	70e2                	ld	ra,56(sp)
    800024e6:	7442                	ld	s0,48(sp)
    800024e8:	6121                	addi	sp,sp,64
    800024ea:	8082                	ret

00000000800024ec <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    800024ec:	1101                	addi	sp,sp,-32
    800024ee:	ec06                	sd	ra,24(sp)
    800024f0:	e822                	sd	s0,16(sp)
    800024f2:	1000                	addi	s0,sp,32
  [ZOMBIE]    "zombie"
  };
  struct proc *p;
  char *state;

  printf("\n");
    800024f4:	00009517          	auipc	a0,0x9
    800024f8:	d0450513          	addi	a0,a0,-764 # 8000b1f8 <etext+0x1f8>
    800024fc:	00006097          	auipc	ra,0x6
    80002500:	7e4080e7          	jalr	2020(ra) # 80008ce0 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80002504:	0000a797          	auipc	a5,0xa
    80002508:	99478793          	addi	a5,a5,-1644 # 8000be98 <proc>
    8000250c:	fef43423          	sd	a5,-24(s0)
    80002510:	a04d                	j	800025b2 <procdump+0xc6>
    if(p->state == UNUSED)
    80002512:	fe843783          	ld	a5,-24(s0)
    80002516:	4f9c                	lw	a5,24(a5)
    80002518:	c7d1                	beqz	a5,800025a4 <procdump+0xb8>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    8000251a:	fe843783          	ld	a5,-24(s0)
    8000251e:	4f9c                	lw	a5,24(a5)
    80002520:	873e                	mv	a4,a5
    80002522:	4795                	li	a5,5
    80002524:	02e7ee63          	bltu	a5,a4,80002560 <procdump+0x74>
    80002528:	fe843783          	ld	a5,-24(s0)
    8000252c:	4f9c                	lw	a5,24(a5)
    8000252e:	00009717          	auipc	a4,0x9
    80002532:	34a70713          	addi	a4,a4,842 # 8000b878 <states.0>
    80002536:	1782                	slli	a5,a5,0x20
    80002538:	9381                	srli	a5,a5,0x20
    8000253a:	078e                	slli	a5,a5,0x3
    8000253c:	97ba                	add	a5,a5,a4
    8000253e:	639c                	ld	a5,0(a5)
    80002540:	c385                	beqz	a5,80002560 <procdump+0x74>
      state = states[p->state];
    80002542:	fe843783          	ld	a5,-24(s0)
    80002546:	4f9c                	lw	a5,24(a5)
    80002548:	00009717          	auipc	a4,0x9
    8000254c:	33070713          	addi	a4,a4,816 # 8000b878 <states.0>
    80002550:	1782                	slli	a5,a5,0x20
    80002552:	9381                	srli	a5,a5,0x20
    80002554:	078e                	slli	a5,a5,0x3
    80002556:	97ba                	add	a5,a5,a4
    80002558:	639c                	ld	a5,0(a5)
    8000255a:	fef43023          	sd	a5,-32(s0)
    8000255e:	a039                	j	8000256c <procdump+0x80>
    else
      state = "???";
    80002560:	00009797          	auipc	a5,0x9
    80002564:	ca078793          	addi	a5,a5,-864 # 8000b200 <etext+0x200>
    80002568:	fef43023          	sd	a5,-32(s0)
    printf("%d %s %s", p->pid, state, p->name);
    8000256c:	fe843783          	ld	a5,-24(s0)
    80002570:	5b98                	lw	a4,48(a5)
    80002572:	fe843783          	ld	a5,-24(s0)
    80002576:	15878793          	addi	a5,a5,344
    8000257a:	86be                	mv	a3,a5
    8000257c:	fe043603          	ld	a2,-32(s0)
    80002580:	85ba                	mv	a1,a4
    80002582:	00009517          	auipc	a0,0x9
    80002586:	c8650513          	addi	a0,a0,-890 # 8000b208 <etext+0x208>
    8000258a:	00006097          	auipc	ra,0x6
    8000258e:	756080e7          	jalr	1878(ra) # 80008ce0 <printf>
    printf("\n");
    80002592:	00009517          	auipc	a0,0x9
    80002596:	c6650513          	addi	a0,a0,-922 # 8000b1f8 <etext+0x1f8>
    8000259a:	00006097          	auipc	ra,0x6
    8000259e:	746080e7          	jalr	1862(ra) # 80008ce0 <printf>
    800025a2:	a011                	j	800025a6 <procdump+0xba>
      continue;
    800025a4:	0001                	nop
  for(p = proc; p < &proc[NPROC]; p++){
    800025a6:	fe843783          	ld	a5,-24(s0)
    800025aa:	17078793          	addi	a5,a5,368
    800025ae:	fef43423          	sd	a5,-24(s0)
    800025b2:	fe843703          	ld	a4,-24(s0)
    800025b6:	0000f797          	auipc	a5,0xf
    800025ba:	4e278793          	addi	a5,a5,1250 # 80011a98 <pid_lock>
    800025be:	f4f76ae3          	bltu	a4,a5,80002512 <procdump+0x26>
  }
}
    800025c2:	0001                	nop
    800025c4:	0001                	nop
    800025c6:	60e2                	ld	ra,24(sp)
    800025c8:	6442                	ld	s0,16(sp)
    800025ca:	6105                	addi	sp,sp,32
    800025cc:	8082                	ret

00000000800025ce <get_nproc>:

int
get_nproc() {
    800025ce:	1101                	addi	sp,sp,-32
    800025d0:	ec22                	sd	s0,24(sp)
    800025d2:	1000                	addi	s0,sp,32
  int nproc = 0;
    800025d4:	fe042623          	sw	zero,-20(s0)
  for (struct proc *p = proc; p < &proc[NPROC]; p++) {
    800025d8:	0000a797          	auipc	a5,0xa
    800025dc:	8c078793          	addi	a5,a5,-1856 # 8000be98 <proc>
    800025e0:	fef43023          	sd	a5,-32(s0)
    800025e4:	a005                	j	80002604 <get_nproc+0x36>
    if (p->state != UNUSED) {
    800025e6:	fe043783          	ld	a5,-32(s0)
    800025ea:	4f9c                	lw	a5,24(a5)
    800025ec:	c791                	beqz	a5,800025f8 <get_nproc+0x2a>
      nproc++;
    800025ee:	fec42783          	lw	a5,-20(s0)
    800025f2:	2785                	addiw	a5,a5,1
    800025f4:	fef42623          	sw	a5,-20(s0)
  for (struct proc *p = proc; p < &proc[NPROC]; p++) {
    800025f8:	fe043783          	ld	a5,-32(s0)
    800025fc:	17078793          	addi	a5,a5,368
    80002600:	fef43023          	sd	a5,-32(s0)
    80002604:	fe043703          	ld	a4,-32(s0)
    80002608:	0000f797          	auipc	a5,0xf
    8000260c:	49078793          	addi	a5,a5,1168 # 80011a98 <pid_lock>
    80002610:	fcf76be3          	bltu	a4,a5,800025e6 <get_nproc+0x18>
    }
  }
  return nproc;
    80002614:	fec42783          	lw	a5,-20(s0)
}
    80002618:	853e                	mv	a0,a5
    8000261a:	6462                	ld	s0,24(sp)
    8000261c:	6105                	addi	sp,sp,32
    8000261e:	8082                	ret

0000000080002620 <swtch>:
    80002620:	00153023          	sd	ra,0(a0)
    80002624:	00253423          	sd	sp,8(a0)
    80002628:	e900                	sd	s0,16(a0)
    8000262a:	ed04                	sd	s1,24(a0)
    8000262c:	03253023          	sd	s2,32(a0)
    80002630:	03353423          	sd	s3,40(a0)
    80002634:	03453823          	sd	s4,48(a0)
    80002638:	03553c23          	sd	s5,56(a0)
    8000263c:	05653023          	sd	s6,64(a0)
    80002640:	05753423          	sd	s7,72(a0)
    80002644:	05853823          	sd	s8,80(a0)
    80002648:	05953c23          	sd	s9,88(a0)
    8000264c:	07a53023          	sd	s10,96(a0)
    80002650:	07b53423          	sd	s11,104(a0)
    80002654:	0005b083          	ld	ra,0(a1)
    80002658:	0085b103          	ld	sp,8(a1)
    8000265c:	6980                	ld	s0,16(a1)
    8000265e:	6d84                	ld	s1,24(a1)
    80002660:	0205b903          	ld	s2,32(a1)
    80002664:	0285b983          	ld	s3,40(a1)
    80002668:	0305ba03          	ld	s4,48(a1)
    8000266c:	0385ba83          	ld	s5,56(a1)
    80002670:	0405bb03          	ld	s6,64(a1)
    80002674:	0485bb83          	ld	s7,72(a1)
    80002678:	0505bc03          	ld	s8,80(a1)
    8000267c:	0585bc83          	ld	s9,88(a1)
    80002680:	0605bd03          	ld	s10,96(a1)
    80002684:	0685bd83          	ld	s11,104(a1)
    80002688:	8082                	ret

000000008000268a <r_sstatus>:
{
    8000268a:	1101                	addi	sp,sp,-32
    8000268c:	ec22                	sd	s0,24(sp)
    8000268e:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002690:	100027f3          	csrr	a5,sstatus
    80002694:	fef43423          	sd	a5,-24(s0)
  return x;
    80002698:	fe843783          	ld	a5,-24(s0)
}
    8000269c:	853e                	mv	a0,a5
    8000269e:	6462                	ld	s0,24(sp)
    800026a0:	6105                	addi	sp,sp,32
    800026a2:	8082                	ret

00000000800026a4 <w_sstatus>:
{
    800026a4:	1101                	addi	sp,sp,-32
    800026a6:	ec22                	sd	s0,24(sp)
    800026a8:	1000                	addi	s0,sp,32
    800026aa:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800026ae:	fe843783          	ld	a5,-24(s0)
    800026b2:	10079073          	csrw	sstatus,a5
}
    800026b6:	0001                	nop
    800026b8:	6462                	ld	s0,24(sp)
    800026ba:	6105                	addi	sp,sp,32
    800026bc:	8082                	ret

00000000800026be <r_sip>:
{
    800026be:	1101                	addi	sp,sp,-32
    800026c0:	ec22                	sd	s0,24(sp)
    800026c2:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sip" : "=r" (x) );
    800026c4:	144027f3          	csrr	a5,sip
    800026c8:	fef43423          	sd	a5,-24(s0)
  return x;
    800026cc:	fe843783          	ld	a5,-24(s0)
}
    800026d0:	853e                	mv	a0,a5
    800026d2:	6462                	ld	s0,24(sp)
    800026d4:	6105                	addi	sp,sp,32
    800026d6:	8082                	ret

00000000800026d8 <w_sip>:
{
    800026d8:	1101                	addi	sp,sp,-32
    800026da:	ec22                	sd	s0,24(sp)
    800026dc:	1000                	addi	s0,sp,32
    800026de:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw sip, %0" : : "r" (x));
    800026e2:	fe843783          	ld	a5,-24(s0)
    800026e6:	14479073          	csrw	sip,a5
}
    800026ea:	0001                	nop
    800026ec:	6462                	ld	s0,24(sp)
    800026ee:	6105                	addi	sp,sp,32
    800026f0:	8082                	ret

00000000800026f2 <w_sepc>:
{
    800026f2:	1101                	addi	sp,sp,-32
    800026f4:	ec22                	sd	s0,24(sp)
    800026f6:	1000                	addi	s0,sp,32
    800026f8:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    800026fc:	fe843783          	ld	a5,-24(s0)
    80002700:	14179073          	csrw	sepc,a5
}
    80002704:	0001                	nop
    80002706:	6462                	ld	s0,24(sp)
    80002708:	6105                	addi	sp,sp,32
    8000270a:	8082                	ret

000000008000270c <r_sepc>:
{
    8000270c:	1101                	addi	sp,sp,-32
    8000270e:	ec22                	sd	s0,24(sp)
    80002710:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80002712:	141027f3          	csrr	a5,sepc
    80002716:	fef43423          	sd	a5,-24(s0)
  return x;
    8000271a:	fe843783          	ld	a5,-24(s0)
}
    8000271e:	853e                	mv	a0,a5
    80002720:	6462                	ld	s0,24(sp)
    80002722:	6105                	addi	sp,sp,32
    80002724:	8082                	ret

0000000080002726 <w_stvec>:
{
    80002726:	1101                	addi	sp,sp,-32
    80002728:	ec22                	sd	s0,24(sp)
    8000272a:	1000                	addi	s0,sp,32
    8000272c:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw stvec, %0" : : "r" (x));
    80002730:	fe843783          	ld	a5,-24(s0)
    80002734:	10579073          	csrw	stvec,a5
}
    80002738:	0001                	nop
    8000273a:	6462                	ld	s0,24(sp)
    8000273c:	6105                	addi	sp,sp,32
    8000273e:	8082                	ret

0000000080002740 <r_satp>:
{
    80002740:	1101                	addi	sp,sp,-32
    80002742:	ec22                	sd	s0,24(sp)
    80002744:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, satp" : "=r" (x) );
    80002746:	180027f3          	csrr	a5,satp
    8000274a:	fef43423          	sd	a5,-24(s0)
  return x;
    8000274e:	fe843783          	ld	a5,-24(s0)
}
    80002752:	853e                	mv	a0,a5
    80002754:	6462                	ld	s0,24(sp)
    80002756:	6105                	addi	sp,sp,32
    80002758:	8082                	ret

000000008000275a <r_scause>:
{
    8000275a:	1101                	addi	sp,sp,-32
    8000275c:	ec22                	sd	s0,24(sp)
    8000275e:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, scause" : "=r" (x) );
    80002760:	142027f3          	csrr	a5,scause
    80002764:	fef43423          	sd	a5,-24(s0)
  return x;
    80002768:	fe843783          	ld	a5,-24(s0)
}
    8000276c:	853e                	mv	a0,a5
    8000276e:	6462                	ld	s0,24(sp)
    80002770:	6105                	addi	sp,sp,32
    80002772:	8082                	ret

0000000080002774 <r_stval>:
{
    80002774:	1101                	addi	sp,sp,-32
    80002776:	ec22                	sd	s0,24(sp)
    80002778:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, stval" : "=r" (x) );
    8000277a:	143027f3          	csrr	a5,stval
    8000277e:	fef43423          	sd	a5,-24(s0)
  return x;
    80002782:	fe843783          	ld	a5,-24(s0)
}
    80002786:	853e                	mv	a0,a5
    80002788:	6462                	ld	s0,24(sp)
    8000278a:	6105                	addi	sp,sp,32
    8000278c:	8082                	ret

000000008000278e <intr_on>:
{
    8000278e:	1141                	addi	sp,sp,-16
    80002790:	e406                	sd	ra,8(sp)
    80002792:	e022                	sd	s0,0(sp)
    80002794:	0800                	addi	s0,sp,16
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80002796:	00000097          	auipc	ra,0x0
    8000279a:	ef4080e7          	jalr	-268(ra) # 8000268a <r_sstatus>
    8000279e:	87aa                	mv	a5,a0
    800027a0:	0027e793          	ori	a5,a5,2
    800027a4:	853e                	mv	a0,a5
    800027a6:	00000097          	auipc	ra,0x0
    800027aa:	efe080e7          	jalr	-258(ra) # 800026a4 <w_sstatus>
}
    800027ae:	0001                	nop
    800027b0:	60a2                	ld	ra,8(sp)
    800027b2:	6402                	ld	s0,0(sp)
    800027b4:	0141                	addi	sp,sp,16
    800027b6:	8082                	ret

00000000800027b8 <intr_off>:
{
    800027b8:	1141                	addi	sp,sp,-16
    800027ba:	e406                	sd	ra,8(sp)
    800027bc:	e022                	sd	s0,0(sp)
    800027be:	0800                	addi	s0,sp,16
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    800027c0:	00000097          	auipc	ra,0x0
    800027c4:	eca080e7          	jalr	-310(ra) # 8000268a <r_sstatus>
    800027c8:	87aa                	mv	a5,a0
    800027ca:	9bf5                	andi	a5,a5,-3
    800027cc:	853e                	mv	a0,a5
    800027ce:	00000097          	auipc	ra,0x0
    800027d2:	ed6080e7          	jalr	-298(ra) # 800026a4 <w_sstatus>
}
    800027d6:	0001                	nop
    800027d8:	60a2                	ld	ra,8(sp)
    800027da:	6402                	ld	s0,0(sp)
    800027dc:	0141                	addi	sp,sp,16
    800027de:	8082                	ret

00000000800027e0 <intr_get>:
{
    800027e0:	1101                	addi	sp,sp,-32
    800027e2:	ec06                	sd	ra,24(sp)
    800027e4:	e822                	sd	s0,16(sp)
    800027e6:	1000                	addi	s0,sp,32
  uint64 x = r_sstatus();
    800027e8:	00000097          	auipc	ra,0x0
    800027ec:	ea2080e7          	jalr	-350(ra) # 8000268a <r_sstatus>
    800027f0:	fea43423          	sd	a0,-24(s0)
  return (x & SSTATUS_SIE) != 0;
    800027f4:	fe843783          	ld	a5,-24(s0)
    800027f8:	8b89                	andi	a5,a5,2
    800027fa:	00f037b3          	snez	a5,a5
    800027fe:	0ff7f793          	zext.b	a5,a5
    80002802:	2781                	sext.w	a5,a5
}
    80002804:	853e                	mv	a0,a5
    80002806:	60e2                	ld	ra,24(sp)
    80002808:	6442                	ld	s0,16(sp)
    8000280a:	6105                	addi	sp,sp,32
    8000280c:	8082                	ret

000000008000280e <r_tp>:
{
    8000280e:	1101                	addi	sp,sp,-32
    80002810:	ec22                	sd	s0,24(sp)
    80002812:	1000                	addi	s0,sp,32
  asm volatile("mv %0, tp" : "=r" (x) );
    80002814:	8792                	mv	a5,tp
    80002816:	fef43423          	sd	a5,-24(s0)
  return x;
    8000281a:	fe843783          	ld	a5,-24(s0)
}
    8000281e:	853e                	mv	a0,a5
    80002820:	6462                	ld	s0,24(sp)
    80002822:	6105                	addi	sp,sp,32
    80002824:	8082                	ret

0000000080002826 <trapinit>:

extern int devintr();

void
trapinit(void)
{
    80002826:	1141                	addi	sp,sp,-16
    80002828:	e406                	sd	ra,8(sp)
    8000282a:	e022                	sd	s0,0(sp)
    8000282c:	0800                	addi	s0,sp,16
  initlock(&tickslock, "time");
    8000282e:	00009597          	auipc	a1,0x9
    80002832:	a2258593          	addi	a1,a1,-1502 # 8000b250 <etext+0x250>
    80002836:	0000f517          	auipc	a0,0xf
    8000283a:	29250513          	addi	a0,a0,658 # 80011ac8 <tickslock>
    8000283e:	00007097          	auipc	ra,0x7
    80002842:	b10080e7          	jalr	-1264(ra) # 8000934e <initlock>
}
    80002846:	0001                	nop
    80002848:	60a2                	ld	ra,8(sp)
    8000284a:	6402                	ld	s0,0(sp)
    8000284c:	0141                	addi	sp,sp,16
    8000284e:	8082                	ret

0000000080002850 <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    80002850:	1141                	addi	sp,sp,-16
    80002852:	e406                	sd	ra,8(sp)
    80002854:	e022                	sd	s0,0(sp)
    80002856:	0800                	addi	s0,sp,16
  w_stvec((uint64)kernelvec);
    80002858:	00005797          	auipc	a5,0x5
    8000285c:	e6878793          	addi	a5,a5,-408 # 800076c0 <kernelvec>
    80002860:	853e                	mv	a0,a5
    80002862:	00000097          	auipc	ra,0x0
    80002866:	ec4080e7          	jalr	-316(ra) # 80002726 <w_stvec>
}
    8000286a:	0001                	nop
    8000286c:	60a2                	ld	ra,8(sp)
    8000286e:	6402                	ld	s0,0(sp)
    80002870:	0141                	addi	sp,sp,16
    80002872:	8082                	ret

0000000080002874 <usertrap>:
// handle an interrupt, exception, or system call from user space.
// called from trampoline.S
//
void
usertrap(void)
{
    80002874:	7179                	addi	sp,sp,-48
    80002876:	f406                	sd	ra,40(sp)
    80002878:	f022                	sd	s0,32(sp)
    8000287a:	ec26                	sd	s1,24(sp)
    8000287c:	1800                	addi	s0,sp,48
  int which_dev = 0;
    8000287e:	fc042e23          	sw	zero,-36(s0)

  if((r_sstatus() & SSTATUS_SPP) != 0)
    80002882:	00000097          	auipc	ra,0x0
    80002886:	e08080e7          	jalr	-504(ra) # 8000268a <r_sstatus>
    8000288a:	87aa                	mv	a5,a0
    8000288c:	1007f793          	andi	a5,a5,256
    80002890:	cb89                	beqz	a5,800028a2 <usertrap+0x2e>
    panic("usertrap: not from user mode");
    80002892:	00009517          	auipc	a0,0x9
    80002896:	9c650513          	addi	a0,a0,-1594 # 8000b258 <etext+0x258>
    8000289a:	00006097          	auipc	ra,0x6
    8000289e:	69c080e7          	jalr	1692(ra) # 80008f36 <panic>

  // send interrupts and exceptions to kerneltrap(),
  // since we're now in the kernel.
  w_stvec((uint64)kernelvec);
    800028a2:	00005797          	auipc	a5,0x5
    800028a6:	e1e78793          	addi	a5,a5,-482 # 800076c0 <kernelvec>
    800028aa:	853e                	mv	a0,a5
    800028ac:	00000097          	auipc	ra,0x0
    800028b0:	e7a080e7          	jalr	-390(ra) # 80002726 <w_stvec>

  struct proc *p = myproc();
    800028b4:	fffff097          	auipc	ra,0xfffff
    800028b8:	d4c080e7          	jalr	-692(ra) # 80001600 <myproc>
    800028bc:	fca43823          	sd	a0,-48(s0)
  
  // save user program counter.
  p->trapframe->epc = r_sepc();
    800028c0:	fd043783          	ld	a5,-48(s0)
    800028c4:	6fa4                	ld	s1,88(a5)
    800028c6:	00000097          	auipc	ra,0x0
    800028ca:	e46080e7          	jalr	-442(ra) # 8000270c <r_sepc>
    800028ce:	87aa                	mv	a5,a0
    800028d0:	ec9c                	sd	a5,24(s1)
  
  if(r_scause() == 8){
    800028d2:	00000097          	auipc	ra,0x0
    800028d6:	e88080e7          	jalr	-376(ra) # 8000275a <r_scause>
    800028da:	872a                	mv	a4,a0
    800028dc:	47a1                	li	a5,8
    800028de:	04f71163          	bne	a4,a5,80002920 <usertrap+0xac>
    // system call

    if(killed(p))
    800028e2:	fd043503          	ld	a0,-48(s0)
    800028e6:	00000097          	auipc	ra,0x0
    800028ea:	ade080e7          	jalr	-1314(ra) # 800023c4 <killed>
    800028ee:	87aa                	mv	a5,a0
    800028f0:	c791                	beqz	a5,800028fc <usertrap+0x88>
      exit(-1);
    800028f2:	557d                	li	a0,-1
    800028f4:	fffff097          	auipc	ra,0xfffff
    800028f8:	416080e7          	jalr	1046(ra) # 80001d0a <exit>

    // sepc points to the ecall instruction,
    // but we want to return to the next instruction.
    p->trapframe->epc += 4;
    800028fc:	fd043783          	ld	a5,-48(s0)
    80002900:	6fbc                	ld	a5,88(a5)
    80002902:	6f98                	ld	a4,24(a5)
    80002904:	fd043783          	ld	a5,-48(s0)
    80002908:	6fbc                	ld	a5,88(a5)
    8000290a:	0711                	addi	a4,a4,4
    8000290c:	ef98                	sd	a4,24(a5)

    // an interrupt will change sepc, scause, and sstatus,
    // so enable only now that we're done with those registers.
    intr_on();
    8000290e:	00000097          	auipc	ra,0x0
    80002912:	e80080e7          	jalr	-384(ra) # 8000278e <intr_on>

    syscall();
    80002916:	00000097          	auipc	ra,0x0
    8000291a:	66c080e7          	jalr	1644(ra) # 80002f82 <syscall>
    8000291e:	a885                	j	8000298e <usertrap+0x11a>
  } else if((which_dev = devintr()) != 0){
    80002920:	00000097          	auipc	ra,0x0
    80002924:	34e080e7          	jalr	846(ra) # 80002c6e <devintr>
    80002928:	87aa                	mv	a5,a0
    8000292a:	fcf42e23          	sw	a5,-36(s0)
    8000292e:	fdc42783          	lw	a5,-36(s0)
    80002932:	2781                	sext.w	a5,a5
    80002934:	efa9                	bnez	a5,8000298e <usertrap+0x11a>
    // ok
  } else {
    printf("usertrap(): unexpected scause %p pid=%d\n", r_scause(), p->pid);
    80002936:	00000097          	auipc	ra,0x0
    8000293a:	e24080e7          	jalr	-476(ra) # 8000275a <r_scause>
    8000293e:	872a                	mv	a4,a0
    80002940:	fd043783          	ld	a5,-48(s0)
    80002944:	5b9c                	lw	a5,48(a5)
    80002946:	863e                	mv	a2,a5
    80002948:	85ba                	mv	a1,a4
    8000294a:	00009517          	auipc	a0,0x9
    8000294e:	92e50513          	addi	a0,a0,-1746 # 8000b278 <etext+0x278>
    80002952:	00006097          	auipc	ra,0x6
    80002956:	38e080e7          	jalr	910(ra) # 80008ce0 <printf>
    printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    8000295a:	00000097          	auipc	ra,0x0
    8000295e:	db2080e7          	jalr	-590(ra) # 8000270c <r_sepc>
    80002962:	84aa                	mv	s1,a0
    80002964:	00000097          	auipc	ra,0x0
    80002968:	e10080e7          	jalr	-496(ra) # 80002774 <r_stval>
    8000296c:	87aa                	mv	a5,a0
    8000296e:	863e                	mv	a2,a5
    80002970:	85a6                	mv	a1,s1
    80002972:	00009517          	auipc	a0,0x9
    80002976:	93650513          	addi	a0,a0,-1738 # 8000b2a8 <etext+0x2a8>
    8000297a:	00006097          	auipc	ra,0x6
    8000297e:	366080e7          	jalr	870(ra) # 80008ce0 <printf>
    setkilled(p);
    80002982:	fd043503          	ld	a0,-48(s0)
    80002986:	00000097          	auipc	ra,0x0
    8000298a:	a04080e7          	jalr	-1532(ra) # 8000238a <setkilled>
  }

  if(killed(p))
    8000298e:	fd043503          	ld	a0,-48(s0)
    80002992:	00000097          	auipc	ra,0x0
    80002996:	a32080e7          	jalr	-1486(ra) # 800023c4 <killed>
    8000299a:	87aa                	mv	a5,a0
    8000299c:	c791                	beqz	a5,800029a8 <usertrap+0x134>
    exit(-1);
    8000299e:	557d                	li	a0,-1
    800029a0:	fffff097          	auipc	ra,0xfffff
    800029a4:	36a080e7          	jalr	874(ra) # 80001d0a <exit>

  // give up the CPU if this is a timer interrupt.
  if(which_dev == 2)
    800029a8:	fdc42783          	lw	a5,-36(s0)
    800029ac:	0007871b          	sext.w	a4,a5
    800029b0:	4789                	li	a5,2
    800029b2:	00f71663          	bne	a4,a5,800029be <usertrap+0x14a>
    yield();
    800029b6:	fffff097          	auipc	ra,0xfffff
    800029ba:	78a080e7          	jalr	1930(ra) # 80002140 <yield>

  usertrapret();
    800029be:	00000097          	auipc	ra,0x0
    800029c2:	014080e7          	jalr	20(ra) # 800029d2 <usertrapret>
}
    800029c6:	0001                	nop
    800029c8:	70a2                	ld	ra,40(sp)
    800029ca:	7402                	ld	s0,32(sp)
    800029cc:	64e2                	ld	s1,24(sp)
    800029ce:	6145                	addi	sp,sp,48
    800029d0:	8082                	ret

00000000800029d2 <usertrapret>:
//
// return to user space
//
void
usertrapret(void)
{
    800029d2:	715d                	addi	sp,sp,-80
    800029d4:	e486                	sd	ra,72(sp)
    800029d6:	e0a2                	sd	s0,64(sp)
    800029d8:	fc26                	sd	s1,56(sp)
    800029da:	0880                	addi	s0,sp,80
  struct proc *p = myproc();
    800029dc:	fffff097          	auipc	ra,0xfffff
    800029e0:	c24080e7          	jalr	-988(ra) # 80001600 <myproc>
    800029e4:	fca43c23          	sd	a0,-40(s0)

  // we're about to switch the destination of traps from
  // kerneltrap() to usertrap(), so turn off interrupts until
  // we're back in user space, where usertrap() is correct.
  intr_off();
    800029e8:	00000097          	auipc	ra,0x0
    800029ec:	dd0080e7          	jalr	-560(ra) # 800027b8 <intr_off>

  // send syscalls, interrupts, and exceptions to uservec in trampoline.S
  uint64 trampoline_uservec = TRAMPOLINE + (uservec - trampoline);
    800029f0:	00007717          	auipc	a4,0x7
    800029f4:	61070713          	addi	a4,a4,1552 # 8000a000 <_trampoline>
    800029f8:	00007797          	auipc	a5,0x7
    800029fc:	60878793          	addi	a5,a5,1544 # 8000a000 <_trampoline>
    80002a00:	8f1d                	sub	a4,a4,a5
    80002a02:	040007b7          	lui	a5,0x4000
    80002a06:	17fd                	addi	a5,a5,-1 # 3ffffff <_entry-0x7c000001>
    80002a08:	07b2                	slli	a5,a5,0xc
    80002a0a:	97ba                	add	a5,a5,a4
    80002a0c:	fcf43823          	sd	a5,-48(s0)
  w_stvec(trampoline_uservec);
    80002a10:	fd043503          	ld	a0,-48(s0)
    80002a14:	00000097          	auipc	ra,0x0
    80002a18:	d12080e7          	jalr	-750(ra) # 80002726 <w_stvec>

  // set up trapframe values that uservec will need when
  // the process next traps into the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
    80002a1c:	fd843783          	ld	a5,-40(s0)
    80002a20:	6fa4                	ld	s1,88(a5)
    80002a22:	00000097          	auipc	ra,0x0
    80002a26:	d1e080e7          	jalr	-738(ra) # 80002740 <r_satp>
    80002a2a:	87aa                	mv	a5,a0
    80002a2c:	e09c                	sd	a5,0(s1)
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    80002a2e:	fd843783          	ld	a5,-40(s0)
    80002a32:	63b4                	ld	a3,64(a5)
    80002a34:	fd843783          	ld	a5,-40(s0)
    80002a38:	6fbc                	ld	a5,88(a5)
    80002a3a:	6705                	lui	a4,0x1
    80002a3c:	9736                	add	a4,a4,a3
    80002a3e:	e798                	sd	a4,8(a5)
  p->trapframe->kernel_trap = (uint64)usertrap;
    80002a40:	fd843783          	ld	a5,-40(s0)
    80002a44:	6fbc                	ld	a5,88(a5)
    80002a46:	00000717          	auipc	a4,0x0
    80002a4a:	e2e70713          	addi	a4,a4,-466 # 80002874 <usertrap>
    80002a4e:	eb98                	sd	a4,16(a5)
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()
    80002a50:	fd843783          	ld	a5,-40(s0)
    80002a54:	6fa4                	ld	s1,88(a5)
    80002a56:	00000097          	auipc	ra,0x0
    80002a5a:	db8080e7          	jalr	-584(ra) # 8000280e <r_tp>
    80002a5e:	87aa                	mv	a5,a0
    80002a60:	f09c                	sd	a5,32(s1)

  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
    80002a62:	00000097          	auipc	ra,0x0
    80002a66:	c28080e7          	jalr	-984(ra) # 8000268a <r_sstatus>
    80002a6a:	fca43423          	sd	a0,-56(s0)
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    80002a6e:	fc843783          	ld	a5,-56(s0)
    80002a72:	eff7f793          	andi	a5,a5,-257
    80002a76:	fcf43423          	sd	a5,-56(s0)
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    80002a7a:	fc843783          	ld	a5,-56(s0)
    80002a7e:	0207e793          	ori	a5,a5,32
    80002a82:	fcf43423          	sd	a5,-56(s0)
  w_sstatus(x);
    80002a86:	fc843503          	ld	a0,-56(s0)
    80002a8a:	00000097          	auipc	ra,0x0
    80002a8e:	c1a080e7          	jalr	-998(ra) # 800026a4 <w_sstatus>

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    80002a92:	fd843783          	ld	a5,-40(s0)
    80002a96:	6fbc                	ld	a5,88(a5)
    80002a98:	6f9c                	ld	a5,24(a5)
    80002a9a:	853e                	mv	a0,a5
    80002a9c:	00000097          	auipc	ra,0x0
    80002aa0:	c56080e7          	jalr	-938(ra) # 800026f2 <w_sepc>

  // tell trampoline.S the user page table to switch to.
  uint64 satp = MAKE_SATP(p->pagetable);
    80002aa4:	fd843783          	ld	a5,-40(s0)
    80002aa8:	6bbc                	ld	a5,80(a5)
    80002aaa:	00c7d713          	srli	a4,a5,0xc
    80002aae:	57fd                	li	a5,-1
    80002ab0:	17fe                	slli	a5,a5,0x3f
    80002ab2:	8fd9                	or	a5,a5,a4
    80002ab4:	fcf43023          	sd	a5,-64(s0)

  // jump to userret in trampoline.S at the top of memory, which 
  // switches to the user page table, restores user registers,
  // and switches to user mode with sret.
  uint64 trampoline_userret = TRAMPOLINE + (userret - trampoline);
    80002ab8:	00007717          	auipc	a4,0x7
    80002abc:	5e470713          	addi	a4,a4,1508 # 8000a09c <userret>
    80002ac0:	00007797          	auipc	a5,0x7
    80002ac4:	54078793          	addi	a5,a5,1344 # 8000a000 <_trampoline>
    80002ac8:	8f1d                	sub	a4,a4,a5
    80002aca:	040007b7          	lui	a5,0x4000
    80002ace:	17fd                	addi	a5,a5,-1 # 3ffffff <_entry-0x7c000001>
    80002ad0:	07b2                	slli	a5,a5,0xc
    80002ad2:	97ba                	add	a5,a5,a4
    80002ad4:	faf43c23          	sd	a5,-72(s0)
  ((void (*)(uint64))trampoline_userret)(satp);
    80002ad8:	fb843783          	ld	a5,-72(s0)
    80002adc:	fc043503          	ld	a0,-64(s0)
    80002ae0:	9782                	jalr	a5
}
    80002ae2:	0001                	nop
    80002ae4:	60a6                	ld	ra,72(sp)
    80002ae6:	6406                	ld	s0,64(sp)
    80002ae8:	74e2                	ld	s1,56(sp)
    80002aea:	6161                	addi	sp,sp,80
    80002aec:	8082                	ret

0000000080002aee <kerneltrap>:

// interrupts and exceptions from kernel code go here via kernelvec,
// on whatever the current kernel stack is.
void 
kerneltrap()
{
    80002aee:	7139                	addi	sp,sp,-64
    80002af0:	fc06                	sd	ra,56(sp)
    80002af2:	f822                	sd	s0,48(sp)
    80002af4:	f426                	sd	s1,40(sp)
    80002af6:	0080                	addi	s0,sp,64
  int which_dev = 0;
    80002af8:	fc042e23          	sw	zero,-36(s0)
  uint64 sepc = r_sepc();
    80002afc:	00000097          	auipc	ra,0x0
    80002b00:	c10080e7          	jalr	-1008(ra) # 8000270c <r_sepc>
    80002b04:	fca43823          	sd	a0,-48(s0)
  uint64 sstatus = r_sstatus();
    80002b08:	00000097          	auipc	ra,0x0
    80002b0c:	b82080e7          	jalr	-1150(ra) # 8000268a <r_sstatus>
    80002b10:	fca43423          	sd	a0,-56(s0)
  uint64 scause = r_scause();
    80002b14:	00000097          	auipc	ra,0x0
    80002b18:	c46080e7          	jalr	-954(ra) # 8000275a <r_scause>
    80002b1c:	fca43023          	sd	a0,-64(s0)
  
  if((sstatus & SSTATUS_SPP) == 0)
    80002b20:	fc843783          	ld	a5,-56(s0)
    80002b24:	1007f793          	andi	a5,a5,256
    80002b28:	eb89                	bnez	a5,80002b3a <kerneltrap+0x4c>
    panic("kerneltrap: not from supervisor mode");
    80002b2a:	00008517          	auipc	a0,0x8
    80002b2e:	79e50513          	addi	a0,a0,1950 # 8000b2c8 <etext+0x2c8>
    80002b32:	00006097          	auipc	ra,0x6
    80002b36:	404080e7          	jalr	1028(ra) # 80008f36 <panic>
  if(intr_get() != 0)
    80002b3a:	00000097          	auipc	ra,0x0
    80002b3e:	ca6080e7          	jalr	-858(ra) # 800027e0 <intr_get>
    80002b42:	87aa                	mv	a5,a0
    80002b44:	cb89                	beqz	a5,80002b56 <kerneltrap+0x68>
    panic("kerneltrap: interrupts enabled");
    80002b46:	00008517          	auipc	a0,0x8
    80002b4a:	7aa50513          	addi	a0,a0,1962 # 8000b2f0 <etext+0x2f0>
    80002b4e:	00006097          	auipc	ra,0x6
    80002b52:	3e8080e7          	jalr	1000(ra) # 80008f36 <panic>

  if((which_dev = devintr()) == 0){
    80002b56:	00000097          	auipc	ra,0x0
    80002b5a:	118080e7          	jalr	280(ra) # 80002c6e <devintr>
    80002b5e:	87aa                	mv	a5,a0
    80002b60:	fcf42e23          	sw	a5,-36(s0)
    80002b64:	fdc42783          	lw	a5,-36(s0)
    80002b68:	2781                	sext.w	a5,a5
    80002b6a:	e7b9                	bnez	a5,80002bb8 <kerneltrap+0xca>
    printf("scause %p\n", scause);
    80002b6c:	fc043583          	ld	a1,-64(s0)
    80002b70:	00008517          	auipc	a0,0x8
    80002b74:	7a050513          	addi	a0,a0,1952 # 8000b310 <etext+0x310>
    80002b78:	00006097          	auipc	ra,0x6
    80002b7c:	168080e7          	jalr	360(ra) # 80008ce0 <printf>
    printf("sepc=%p stval=%p\n", r_sepc(), r_stval());
    80002b80:	00000097          	auipc	ra,0x0
    80002b84:	b8c080e7          	jalr	-1140(ra) # 8000270c <r_sepc>
    80002b88:	84aa                	mv	s1,a0
    80002b8a:	00000097          	auipc	ra,0x0
    80002b8e:	bea080e7          	jalr	-1046(ra) # 80002774 <r_stval>
    80002b92:	87aa                	mv	a5,a0
    80002b94:	863e                	mv	a2,a5
    80002b96:	85a6                	mv	a1,s1
    80002b98:	00008517          	auipc	a0,0x8
    80002b9c:	78850513          	addi	a0,a0,1928 # 8000b320 <etext+0x320>
    80002ba0:	00006097          	auipc	ra,0x6
    80002ba4:	140080e7          	jalr	320(ra) # 80008ce0 <printf>
    panic("kerneltrap");
    80002ba8:	00008517          	auipc	a0,0x8
    80002bac:	79050513          	addi	a0,a0,1936 # 8000b338 <etext+0x338>
    80002bb0:	00006097          	auipc	ra,0x6
    80002bb4:	386080e7          	jalr	902(ra) # 80008f36 <panic>
  }

  // give up the CPU if this is a timer interrupt.
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80002bb8:	fdc42783          	lw	a5,-36(s0)
    80002bbc:	0007871b          	sext.w	a4,a5
    80002bc0:	4789                	li	a5,2
    80002bc2:	02f71663          	bne	a4,a5,80002bee <kerneltrap+0x100>
    80002bc6:	fffff097          	auipc	ra,0xfffff
    80002bca:	a3a080e7          	jalr	-1478(ra) # 80001600 <myproc>
    80002bce:	87aa                	mv	a5,a0
    80002bd0:	cf99                	beqz	a5,80002bee <kerneltrap+0x100>
    80002bd2:	fffff097          	auipc	ra,0xfffff
    80002bd6:	a2e080e7          	jalr	-1490(ra) # 80001600 <myproc>
    80002bda:	87aa                	mv	a5,a0
    80002bdc:	4f9c                	lw	a5,24(a5)
    80002bde:	873e                	mv	a4,a5
    80002be0:	4791                	li	a5,4
    80002be2:	00f71663          	bne	a4,a5,80002bee <kerneltrap+0x100>
    yield();
    80002be6:	fffff097          	auipc	ra,0xfffff
    80002bea:	55a080e7          	jalr	1370(ra) # 80002140 <yield>

  // the yield() may have caused some traps to occur,
  // so restore trap registers for use by kernelvec.S's sepc instruction.
  w_sepc(sepc);
    80002bee:	fd043503          	ld	a0,-48(s0)
    80002bf2:	00000097          	auipc	ra,0x0
    80002bf6:	b00080e7          	jalr	-1280(ra) # 800026f2 <w_sepc>
  w_sstatus(sstatus);
    80002bfa:	fc843503          	ld	a0,-56(s0)
    80002bfe:	00000097          	auipc	ra,0x0
    80002c02:	aa6080e7          	jalr	-1370(ra) # 800026a4 <w_sstatus>
}
    80002c06:	0001                	nop
    80002c08:	70e2                	ld	ra,56(sp)
    80002c0a:	7442                	ld	s0,48(sp)
    80002c0c:	74a2                	ld	s1,40(sp)
    80002c0e:	6121                	addi	sp,sp,64
    80002c10:	8082                	ret

0000000080002c12 <clockintr>:

void
clockintr()
{
    80002c12:	1141                	addi	sp,sp,-16
    80002c14:	e406                	sd	ra,8(sp)
    80002c16:	e022                	sd	s0,0(sp)
    80002c18:	0800                	addi	s0,sp,16
  acquire(&tickslock);
    80002c1a:	0000f517          	auipc	a0,0xf
    80002c1e:	eae50513          	addi	a0,a0,-338 # 80011ac8 <tickslock>
    80002c22:	00006097          	auipc	ra,0x6
    80002c26:	75c080e7          	jalr	1884(ra) # 8000937e <acquire>
  ticks++;
    80002c2a:	00009797          	auipc	a5,0x9
    80002c2e:	e2678793          	addi	a5,a5,-474 # 8000ba50 <ticks>
    80002c32:	439c                	lw	a5,0(a5)
    80002c34:	2785                	addiw	a5,a5,1
    80002c36:	0007871b          	sext.w	a4,a5
    80002c3a:	00009797          	auipc	a5,0x9
    80002c3e:	e1678793          	addi	a5,a5,-490 # 8000ba50 <ticks>
    80002c42:	c398                	sw	a4,0(a5)
  wakeup(&ticks);
    80002c44:	00009517          	auipc	a0,0x9
    80002c48:	e0c50513          	addi	a0,a0,-500 # 8000ba50 <ticks>
    80002c4c:	fffff097          	auipc	ra,0xfffff
    80002c50:	60a080e7          	jalr	1546(ra) # 80002256 <wakeup>
  release(&tickslock);
    80002c54:	0000f517          	auipc	a0,0xf
    80002c58:	e7450513          	addi	a0,a0,-396 # 80011ac8 <tickslock>
    80002c5c:	00006097          	auipc	ra,0x6
    80002c60:	786080e7          	jalr	1926(ra) # 800093e2 <release>
}
    80002c64:	0001                	nop
    80002c66:	60a2                	ld	ra,8(sp)
    80002c68:	6402                	ld	s0,0(sp)
    80002c6a:	0141                	addi	sp,sp,16
    80002c6c:	8082                	ret

0000000080002c6e <devintr>:
// returns 2 if timer interrupt,
// 1 if other device,
// 0 if not recognized.
int
devintr()
{
    80002c6e:	1101                	addi	sp,sp,-32
    80002c70:	ec06                	sd	ra,24(sp)
    80002c72:	e822                	sd	s0,16(sp)
    80002c74:	1000                	addi	s0,sp,32
  uint64 scause = r_scause();
    80002c76:	00000097          	auipc	ra,0x0
    80002c7a:	ae4080e7          	jalr	-1308(ra) # 8000275a <r_scause>
    80002c7e:	fea43423          	sd	a0,-24(s0)

  if((scause & 0x8000000000000000L) &&
    80002c82:	fe843783          	ld	a5,-24(s0)
    80002c86:	0807d463          	bgez	a5,80002d0e <devintr+0xa0>
     (scause & 0xff) == 9){
    80002c8a:	fe843783          	ld	a5,-24(s0)
    80002c8e:	0ff7f713          	zext.b	a4,a5
  if((scause & 0x8000000000000000L) &&
    80002c92:	47a5                	li	a5,9
    80002c94:	06f71d63          	bne	a4,a5,80002d0e <devintr+0xa0>
    // this is a supervisor external interrupt, via PLIC.

    // irq indicates which device interrupted.
    int irq = plic_claim();
    80002c98:	00005097          	auipc	ra,0x5
    80002c9c:	b5a080e7          	jalr	-1190(ra) # 800077f2 <plic_claim>
    80002ca0:	87aa                	mv	a5,a0
    80002ca2:	fef42223          	sw	a5,-28(s0)

    if(irq == UART0_IRQ){
    80002ca6:	fe442783          	lw	a5,-28(s0)
    80002caa:	0007871b          	sext.w	a4,a5
    80002cae:	47a9                	li	a5,10
    80002cb0:	00f71763          	bne	a4,a5,80002cbe <devintr+0x50>
      uartintr();
    80002cb4:	00006097          	auipc	ra,0x6
    80002cb8:	57e080e7          	jalr	1406(ra) # 80009232 <uartintr>
    80002cbc:	a825                	j	80002cf4 <devintr+0x86>
    } else if(irq == VIRTIO0_IRQ){
    80002cbe:	fe442783          	lw	a5,-28(s0)
    80002cc2:	0007871b          	sext.w	a4,a5
    80002cc6:	4785                	li	a5,1
    80002cc8:	00f71763          	bne	a4,a5,80002cd6 <devintr+0x68>
      virtio_disk_intr();
    80002ccc:	00005097          	auipc	ra,0x5
    80002cd0:	4e8080e7          	jalr	1256(ra) # 800081b4 <virtio_disk_intr>
    80002cd4:	a005                	j	80002cf4 <devintr+0x86>
    } else if(irq){
    80002cd6:	fe442783          	lw	a5,-28(s0)
    80002cda:	2781                	sext.w	a5,a5
    80002cdc:	cf81                	beqz	a5,80002cf4 <devintr+0x86>
      printf("unexpected interrupt irq=%d\n", irq);
    80002cde:	fe442783          	lw	a5,-28(s0)
    80002ce2:	85be                	mv	a1,a5
    80002ce4:	00008517          	auipc	a0,0x8
    80002ce8:	66450513          	addi	a0,a0,1636 # 8000b348 <etext+0x348>
    80002cec:	00006097          	auipc	ra,0x6
    80002cf0:	ff4080e7          	jalr	-12(ra) # 80008ce0 <printf>
    }

    // the PLIC allows each device to raise at most one
    // interrupt at a time; tell the PLIC the device is
    // now allowed to interrupt again.
    if(irq)
    80002cf4:	fe442783          	lw	a5,-28(s0)
    80002cf8:	2781                	sext.w	a5,a5
    80002cfa:	cb81                	beqz	a5,80002d0a <devintr+0x9c>
      plic_complete(irq);
    80002cfc:	fe442783          	lw	a5,-28(s0)
    80002d00:	853e                	mv	a0,a5
    80002d02:	00005097          	auipc	ra,0x5
    80002d06:	b2e080e7          	jalr	-1234(ra) # 80007830 <plic_complete>

    return 1;
    80002d0a:	4785                	li	a5,1
    80002d0c:	a081                	j	80002d4c <devintr+0xde>
  } else if(scause == 0x8000000000000001L){
    80002d0e:	fe843703          	ld	a4,-24(s0)
    80002d12:	57fd                	li	a5,-1
    80002d14:	17fe                	slli	a5,a5,0x3f
    80002d16:	0785                	addi	a5,a5,1
    80002d18:	02f71963          	bne	a4,a5,80002d4a <devintr+0xdc>
    // software interrupt from a machine-mode timer interrupt,
    // forwarded by timervec in kernelvec.S.

    if(cpuid() == 0){
    80002d1c:	fffff097          	auipc	ra,0xfffff
    80002d20:	886080e7          	jalr	-1914(ra) # 800015a2 <cpuid>
    80002d24:	87aa                	mv	a5,a0
    80002d26:	e789                	bnez	a5,80002d30 <devintr+0xc2>
      clockintr();
    80002d28:	00000097          	auipc	ra,0x0
    80002d2c:	eea080e7          	jalr	-278(ra) # 80002c12 <clockintr>
    }
    
    // acknowledge the software interrupt by clearing
    // the SSIP bit in sip.
    w_sip(r_sip() & ~2);
    80002d30:	00000097          	auipc	ra,0x0
    80002d34:	98e080e7          	jalr	-1650(ra) # 800026be <r_sip>
    80002d38:	87aa                	mv	a5,a0
    80002d3a:	9bf5                	andi	a5,a5,-3
    80002d3c:	853e                	mv	a0,a5
    80002d3e:	00000097          	auipc	ra,0x0
    80002d42:	99a080e7          	jalr	-1638(ra) # 800026d8 <w_sip>

    return 2;
    80002d46:	4789                	li	a5,2
    80002d48:	a011                	j	80002d4c <devintr+0xde>
  } else {
    return 0;
    80002d4a:	4781                	li	a5,0
  }
}
    80002d4c:	853e                	mv	a0,a5
    80002d4e:	60e2                	ld	ra,24(sp)
    80002d50:	6442                	ld	s0,16(sp)
    80002d52:	6105                	addi	sp,sp,32
    80002d54:	8082                	ret

0000000080002d56 <fetchaddr>:
#include "defs.h"

// Fetch the uint64 at addr from the current process.
int
fetchaddr(uint64 addr, uint64 *ip)
{
    80002d56:	7179                	addi	sp,sp,-48
    80002d58:	f406                	sd	ra,40(sp)
    80002d5a:	f022                	sd	s0,32(sp)
    80002d5c:	1800                	addi	s0,sp,48
    80002d5e:	fca43c23          	sd	a0,-40(s0)
    80002d62:	fcb43823          	sd	a1,-48(s0)
  struct proc *p = myproc();
    80002d66:	fffff097          	auipc	ra,0xfffff
    80002d6a:	89a080e7          	jalr	-1894(ra) # 80001600 <myproc>
    80002d6e:	fea43423          	sd	a0,-24(s0)
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz) // both tests needed, in case of overflow
    80002d72:	fe843783          	ld	a5,-24(s0)
    80002d76:	67bc                	ld	a5,72(a5)
    80002d78:	fd843703          	ld	a4,-40(s0)
    80002d7c:	00f77b63          	bgeu	a4,a5,80002d92 <fetchaddr+0x3c>
    80002d80:	fd843783          	ld	a5,-40(s0)
    80002d84:	00878713          	addi	a4,a5,8
    80002d88:	fe843783          	ld	a5,-24(s0)
    80002d8c:	67bc                	ld	a5,72(a5)
    80002d8e:	00e7f463          	bgeu	a5,a4,80002d96 <fetchaddr+0x40>
    return -1;
    80002d92:	57fd                	li	a5,-1
    80002d94:	a01d                	j	80002dba <fetchaddr+0x64>
  if(copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
    80002d96:	fe843783          	ld	a5,-24(s0)
    80002d9a:	6bbc                	ld	a5,80(a5)
    80002d9c:	46a1                	li	a3,8
    80002d9e:	fd843603          	ld	a2,-40(s0)
    80002da2:	fd043583          	ld	a1,-48(s0)
    80002da6:	853e                	mv	a0,a5
    80002da8:	ffffe097          	auipc	ra,0xffffe
    80002dac:	3f0080e7          	jalr	1008(ra) # 80001198 <copyin>
    80002db0:	87aa                	mv	a5,a0
    80002db2:	c399                	beqz	a5,80002db8 <fetchaddr+0x62>
    return -1;
    80002db4:	57fd                	li	a5,-1
    80002db6:	a011                	j	80002dba <fetchaddr+0x64>
  return 0;
    80002db8:	4781                	li	a5,0
}
    80002dba:	853e                	mv	a0,a5
    80002dbc:	70a2                	ld	ra,40(sp)
    80002dbe:	7402                	ld	s0,32(sp)
    80002dc0:	6145                	addi	sp,sp,48
    80002dc2:	8082                	ret

0000000080002dc4 <fetchstr>:

// Fetch the nul-terminated string at addr from the current process.
// Returns length of string, not including nul, or -1 for error.
int
fetchstr(uint64 addr, char *buf, int max)
{
    80002dc4:	7139                	addi	sp,sp,-64
    80002dc6:	fc06                	sd	ra,56(sp)
    80002dc8:	f822                	sd	s0,48(sp)
    80002dca:	0080                	addi	s0,sp,64
    80002dcc:	fca43c23          	sd	a0,-40(s0)
    80002dd0:	fcb43823          	sd	a1,-48(s0)
    80002dd4:	87b2                	mv	a5,a2
    80002dd6:	fcf42623          	sw	a5,-52(s0)
  struct proc *p = myproc();
    80002dda:	fffff097          	auipc	ra,0xfffff
    80002dde:	826080e7          	jalr	-2010(ra) # 80001600 <myproc>
    80002de2:	fea43423          	sd	a0,-24(s0)
  if(copyinstr(p->pagetable, buf, addr, max) < 0)
    80002de6:	fe843783          	ld	a5,-24(s0)
    80002dea:	6bbc                	ld	a5,80(a5)
    80002dec:	fcc42703          	lw	a4,-52(s0)
    80002df0:	86ba                	mv	a3,a4
    80002df2:	fd843603          	ld	a2,-40(s0)
    80002df6:	fd043583          	ld	a1,-48(s0)
    80002dfa:	853e                	mv	a0,a5
    80002dfc:	ffffe097          	auipc	ra,0xffffe
    80002e00:	46a080e7          	jalr	1130(ra) # 80001266 <copyinstr>
    80002e04:	87aa                	mv	a5,a0
    80002e06:	0007d463          	bgez	a5,80002e0e <fetchstr+0x4a>
    return -1;
    80002e0a:	57fd                	li	a5,-1
    80002e0c:	a801                	j	80002e1c <fetchstr+0x58>
  return strlen(buf);
    80002e0e:	fd043503          	ld	a0,-48(s0)
    80002e12:	ffffd097          	auipc	ra,0xffffd
    80002e16:	77a080e7          	jalr	1914(ra) # 8000058c <strlen>
    80002e1a:	87aa                	mv	a5,a0
}
    80002e1c:	853e                	mv	a0,a5
    80002e1e:	70e2                	ld	ra,56(sp)
    80002e20:	7442                	ld	s0,48(sp)
    80002e22:	6121                	addi	sp,sp,64
    80002e24:	8082                	ret

0000000080002e26 <argraw>:

static uint64
argraw(int n)
{
    80002e26:	7179                	addi	sp,sp,-48
    80002e28:	f406                	sd	ra,40(sp)
    80002e2a:	f022                	sd	s0,32(sp)
    80002e2c:	1800                	addi	s0,sp,48
    80002e2e:	87aa                	mv	a5,a0
    80002e30:	fcf42e23          	sw	a5,-36(s0)
  struct proc *p = myproc();
    80002e34:	ffffe097          	auipc	ra,0xffffe
    80002e38:	7cc080e7          	jalr	1996(ra) # 80001600 <myproc>
    80002e3c:	fea43423          	sd	a0,-24(s0)
  switch (n) {
    80002e40:	fdc42783          	lw	a5,-36(s0)
    80002e44:	0007871b          	sext.w	a4,a5
    80002e48:	4795                	li	a5,5
    80002e4a:	06e7e263          	bltu	a5,a4,80002eae <argraw+0x88>
    80002e4e:	fdc46783          	lwu	a5,-36(s0)
    80002e52:	00279713          	slli	a4,a5,0x2
    80002e56:	00008797          	auipc	a5,0x8
    80002e5a:	51a78793          	addi	a5,a5,1306 # 8000b370 <etext+0x370>
    80002e5e:	97ba                	add	a5,a5,a4
    80002e60:	439c                	lw	a5,0(a5)
    80002e62:	0007871b          	sext.w	a4,a5
    80002e66:	00008797          	auipc	a5,0x8
    80002e6a:	50a78793          	addi	a5,a5,1290 # 8000b370 <etext+0x370>
    80002e6e:	97ba                	add	a5,a5,a4
    80002e70:	8782                	jr	a5
  case 0:
    return p->trapframe->a0;
    80002e72:	fe843783          	ld	a5,-24(s0)
    80002e76:	6fbc                	ld	a5,88(a5)
    80002e78:	7bbc                	ld	a5,112(a5)
    80002e7a:	a091                	j	80002ebe <argraw+0x98>
  case 1:
    return p->trapframe->a1;
    80002e7c:	fe843783          	ld	a5,-24(s0)
    80002e80:	6fbc                	ld	a5,88(a5)
    80002e82:	7fbc                	ld	a5,120(a5)
    80002e84:	a82d                	j	80002ebe <argraw+0x98>
  case 2:
    return p->trapframe->a2;
    80002e86:	fe843783          	ld	a5,-24(s0)
    80002e8a:	6fbc                	ld	a5,88(a5)
    80002e8c:	63dc                	ld	a5,128(a5)
    80002e8e:	a805                	j	80002ebe <argraw+0x98>
  case 3:
    return p->trapframe->a3;
    80002e90:	fe843783          	ld	a5,-24(s0)
    80002e94:	6fbc                	ld	a5,88(a5)
    80002e96:	67dc                	ld	a5,136(a5)
    80002e98:	a01d                	j	80002ebe <argraw+0x98>
  case 4:
    return p->trapframe->a4;
    80002e9a:	fe843783          	ld	a5,-24(s0)
    80002e9e:	6fbc                	ld	a5,88(a5)
    80002ea0:	6bdc                	ld	a5,144(a5)
    80002ea2:	a831                	j	80002ebe <argraw+0x98>
  case 5:
    return p->trapframe->a5;
    80002ea4:	fe843783          	ld	a5,-24(s0)
    80002ea8:	6fbc                	ld	a5,88(a5)
    80002eaa:	6fdc                	ld	a5,152(a5)
    80002eac:	a809                	j	80002ebe <argraw+0x98>
  }
  panic("argraw");
    80002eae:	00008517          	auipc	a0,0x8
    80002eb2:	4ba50513          	addi	a0,a0,1210 # 8000b368 <etext+0x368>
    80002eb6:	00006097          	auipc	ra,0x6
    80002eba:	080080e7          	jalr	128(ra) # 80008f36 <panic>
  return -1;
}
    80002ebe:	853e                	mv	a0,a5
    80002ec0:	70a2                	ld	ra,40(sp)
    80002ec2:	7402                	ld	s0,32(sp)
    80002ec4:	6145                	addi	sp,sp,48
    80002ec6:	8082                	ret

0000000080002ec8 <argint>:

// Fetch the nth 32-bit system call argument.
void
argint(int n, int *ip)
{
    80002ec8:	1101                	addi	sp,sp,-32
    80002eca:	ec06                	sd	ra,24(sp)
    80002ecc:	e822                	sd	s0,16(sp)
    80002ece:	1000                	addi	s0,sp,32
    80002ed0:	87aa                	mv	a5,a0
    80002ed2:	feb43023          	sd	a1,-32(s0)
    80002ed6:	fef42623          	sw	a5,-20(s0)
  *ip = argraw(n);
    80002eda:	fec42783          	lw	a5,-20(s0)
    80002ede:	853e                	mv	a0,a5
    80002ee0:	00000097          	auipc	ra,0x0
    80002ee4:	f46080e7          	jalr	-186(ra) # 80002e26 <argraw>
    80002ee8:	87aa                	mv	a5,a0
    80002eea:	0007871b          	sext.w	a4,a5
    80002eee:	fe043783          	ld	a5,-32(s0)
    80002ef2:	c398                	sw	a4,0(a5)
}
    80002ef4:	0001                	nop
    80002ef6:	60e2                	ld	ra,24(sp)
    80002ef8:	6442                	ld	s0,16(sp)
    80002efa:	6105                	addi	sp,sp,32
    80002efc:	8082                	ret

0000000080002efe <argaddr>:
// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
void
argaddr(int n, uint64 *ip)
{
    80002efe:	1101                	addi	sp,sp,-32
    80002f00:	ec06                	sd	ra,24(sp)
    80002f02:	e822                	sd	s0,16(sp)
    80002f04:	1000                	addi	s0,sp,32
    80002f06:	87aa                	mv	a5,a0
    80002f08:	feb43023          	sd	a1,-32(s0)
    80002f0c:	fef42623          	sw	a5,-20(s0)
  *ip = argraw(n);
    80002f10:	fec42783          	lw	a5,-20(s0)
    80002f14:	853e                	mv	a0,a5
    80002f16:	00000097          	auipc	ra,0x0
    80002f1a:	f10080e7          	jalr	-240(ra) # 80002e26 <argraw>
    80002f1e:	872a                	mv	a4,a0
    80002f20:	fe043783          	ld	a5,-32(s0)
    80002f24:	e398                	sd	a4,0(a5)
}
    80002f26:	0001                	nop
    80002f28:	60e2                	ld	ra,24(sp)
    80002f2a:	6442                	ld	s0,16(sp)
    80002f2c:	6105                	addi	sp,sp,32
    80002f2e:	8082                	ret

0000000080002f30 <argstr>:
// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int
argstr(int n, char *buf, int max)
{
    80002f30:	7179                	addi	sp,sp,-48
    80002f32:	f406                	sd	ra,40(sp)
    80002f34:	f022                	sd	s0,32(sp)
    80002f36:	1800                	addi	s0,sp,48
    80002f38:	87aa                	mv	a5,a0
    80002f3a:	fcb43823          	sd	a1,-48(s0)
    80002f3e:	8732                	mv	a4,a2
    80002f40:	fcf42e23          	sw	a5,-36(s0)
    80002f44:	87ba                	mv	a5,a4
    80002f46:	fcf42c23          	sw	a5,-40(s0)
  uint64 addr;
  argaddr(n, &addr);
    80002f4a:	fe840713          	addi	a4,s0,-24
    80002f4e:	fdc42783          	lw	a5,-36(s0)
    80002f52:	85ba                	mv	a1,a4
    80002f54:	853e                	mv	a0,a5
    80002f56:	00000097          	auipc	ra,0x0
    80002f5a:	fa8080e7          	jalr	-88(ra) # 80002efe <argaddr>
  return fetchstr(addr, buf, max);
    80002f5e:	fe843783          	ld	a5,-24(s0)
    80002f62:	fd842703          	lw	a4,-40(s0)
    80002f66:	863a                	mv	a2,a4
    80002f68:	fd043583          	ld	a1,-48(s0)
    80002f6c:	853e                	mv	a0,a5
    80002f6e:	00000097          	auipc	ra,0x0
    80002f72:	e56080e7          	jalr	-426(ra) # 80002dc4 <fetchstr>
    80002f76:	87aa                	mv	a5,a0
}
    80002f78:	853e                	mv	a0,a5
    80002f7a:	70a2                	ld	ra,40(sp)
    80002f7c:	7402                	ld	s0,32(sp)
    80002f7e:	6145                	addi	sp,sp,48
    80002f80:	8082                	ret

0000000080002f82 <syscall>:
[SYS_sysinfo] "sysinfo",
};

void
syscall(void)
{
    80002f82:	7179                	addi	sp,sp,-48
    80002f84:	f406                	sd	ra,40(sp)
    80002f86:	f022                	sd	s0,32(sp)
    80002f88:	ec26                	sd	s1,24(sp)
    80002f8a:	1800                	addi	s0,sp,48
  int num;
  struct proc *p = myproc();
    80002f8c:	ffffe097          	auipc	ra,0xffffe
    80002f90:	674080e7          	jalr	1652(ra) # 80001600 <myproc>
    80002f94:	fca43c23          	sd	a0,-40(s0)

  num = p->trapframe->a7;
    80002f98:	fd843783          	ld	a5,-40(s0)
    80002f9c:	6fbc                	ld	a5,88(a5)
    80002f9e:	77dc                	ld	a5,168(a5)
    80002fa0:	fcf42a23          	sw	a5,-44(s0)
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    80002fa4:	fd442783          	lw	a5,-44(s0)
    80002fa8:	2781                	sext.w	a5,a5
    80002faa:	08f05c63          	blez	a5,80003042 <syscall+0xc0>
    80002fae:	fd442783          	lw	a5,-44(s0)
    80002fb2:	873e                	mv	a4,a5
    80002fb4:	47dd                	li	a5,23
    80002fb6:	08e7e663          	bltu	a5,a4,80003042 <syscall+0xc0>
    80002fba:	00009717          	auipc	a4,0x9
    80002fbe:	8ee70713          	addi	a4,a4,-1810 # 8000b8a8 <syscalls>
    80002fc2:	fd442783          	lw	a5,-44(s0)
    80002fc6:	078e                	slli	a5,a5,0x3
    80002fc8:	97ba                	add	a5,a5,a4
    80002fca:	639c                	ld	a5,0(a5)
    80002fcc:	cbbd                	beqz	a5,80003042 <syscall+0xc0>
    // Use num to lookup the system call function for num, call it,
    // and store its return value in p->trapframe->a0
    p->trapframe->a0 = syscalls[num]();
    80002fce:	00009717          	auipc	a4,0x9
    80002fd2:	8da70713          	addi	a4,a4,-1830 # 8000b8a8 <syscalls>
    80002fd6:	fd442783          	lw	a5,-44(s0)
    80002fda:	078e                	slli	a5,a5,0x3
    80002fdc:	97ba                	add	a5,a5,a4
    80002fde:	639c                	ld	a5,0(a5)
    80002fe0:	fd843703          	ld	a4,-40(s0)
    80002fe4:	6f24                	ld	s1,88(a4)
    80002fe6:	9782                	jalr	a5
    80002fe8:	87aa                	mv	a5,a0
    80002fea:	f8bc                	sd	a5,112(s1)

    if ((1 << num) & p->trace_mask) {
    80002fec:	fd442783          	lw	a5,-44(s0)
    80002ff0:	873e                	mv	a4,a5
    80002ff2:	4785                	li	a5,1
    80002ff4:	00e797bb          	sllw	a5,a5,a4
    80002ff8:	2781                	sext.w	a5,a5
    80002ffa:	0007871b          	sext.w	a4,a5
    80002ffe:	fd843783          	ld	a5,-40(s0)
    80003002:	1687a783          	lw	a5,360(a5)
    80003006:	8ff9                	and	a5,a5,a4
    80003008:	2781                	sext.w	a5,a5
    8000300a:	c7ad                	beqz	a5,80003074 <syscall+0xf2>
      printf("%d: syscall %s -> %d\n", p->pid, syscalls_str[num], p->trapframe->a0);
    8000300c:	fd843783          	ld	a5,-40(s0)
    80003010:	5b8c                	lw	a1,48(a5)
    80003012:	00009717          	auipc	a4,0x9
    80003016:	95670713          	addi	a4,a4,-1706 # 8000b968 <syscalls_str>
    8000301a:	fd442783          	lw	a5,-44(s0)
    8000301e:	078e                	slli	a5,a5,0x3
    80003020:	97ba                	add	a5,a5,a4
    80003022:	6398                	ld	a4,0(a5)
    80003024:	fd843783          	ld	a5,-40(s0)
    80003028:	6fbc                	ld	a5,88(a5)
    8000302a:	7bbc                	ld	a5,112(a5)
    8000302c:	86be                	mv	a3,a5
    8000302e:	863a                	mv	a2,a4
    80003030:	00008517          	auipc	a0,0x8
    80003034:	41050513          	addi	a0,a0,1040 # 8000b440 <etext+0x440>
    80003038:	00006097          	auipc	ra,0x6
    8000303c:	ca8080e7          	jalr	-856(ra) # 80008ce0 <printf>
    if ((1 << num) & p->trace_mask) {
    80003040:	a815                	j	80003074 <syscall+0xf2>
    }
  } else {
    printf("%d %s: unknown sys call %d\n",
    80003042:	fd843783          	ld	a5,-40(s0)
    80003046:	5b98                	lw	a4,48(a5)
            p->pid, p->name, num);
    80003048:	fd843783          	ld	a5,-40(s0)
    8000304c:	15878793          	addi	a5,a5,344
    printf("%d %s: unknown sys call %d\n",
    80003050:	fd442683          	lw	a3,-44(s0)
    80003054:	863e                	mv	a2,a5
    80003056:	85ba                	mv	a1,a4
    80003058:	00008517          	auipc	a0,0x8
    8000305c:	40050513          	addi	a0,a0,1024 # 8000b458 <etext+0x458>
    80003060:	00006097          	auipc	ra,0x6
    80003064:	c80080e7          	jalr	-896(ra) # 80008ce0 <printf>
    p->trapframe->a0 = -1;
    80003068:	fd843783          	ld	a5,-40(s0)
    8000306c:	6fbc                	ld	a5,88(a5)
    8000306e:	577d                	li	a4,-1
    80003070:	fbb8                	sd	a4,112(a5)
  }
}
    80003072:	0001                	nop
    80003074:	0001                	nop
    80003076:	70a2                	ld	ra,40(sp)
    80003078:	7402                	ld	s0,32(sp)
    8000307a:	64e2                	ld	s1,24(sp)
    8000307c:	6145                	addi	sp,sp,48
    8000307e:	8082                	ret

0000000080003080 <sys_exit>:
#include "proc.h"
#include "sysinfo.h"

uint64
sys_exit(void)
{
    80003080:	1101                	addi	sp,sp,-32
    80003082:	ec06                	sd	ra,24(sp)
    80003084:	e822                	sd	s0,16(sp)
    80003086:	1000                	addi	s0,sp,32
  int n;
  argint(0, &n);
    80003088:	fec40793          	addi	a5,s0,-20
    8000308c:	85be                	mv	a1,a5
    8000308e:	4501                	li	a0,0
    80003090:	00000097          	auipc	ra,0x0
    80003094:	e38080e7          	jalr	-456(ra) # 80002ec8 <argint>
  exit(n);
    80003098:	fec42783          	lw	a5,-20(s0)
    8000309c:	853e                	mv	a0,a5
    8000309e:	fffff097          	auipc	ra,0xfffff
    800030a2:	c6c080e7          	jalr	-916(ra) # 80001d0a <exit>
  return 0;  // not reached
    800030a6:	4781                	li	a5,0
}
    800030a8:	853e                	mv	a0,a5
    800030aa:	60e2                	ld	ra,24(sp)
    800030ac:	6442                	ld	s0,16(sp)
    800030ae:	6105                	addi	sp,sp,32
    800030b0:	8082                	ret

00000000800030b2 <sys_getpid>:

uint64
sys_getpid(void)
{
    800030b2:	1141                	addi	sp,sp,-16
    800030b4:	e406                	sd	ra,8(sp)
    800030b6:	e022                	sd	s0,0(sp)
    800030b8:	0800                	addi	s0,sp,16
  return myproc()->pid;
    800030ba:	ffffe097          	auipc	ra,0xffffe
    800030be:	546080e7          	jalr	1350(ra) # 80001600 <myproc>
    800030c2:	87aa                	mv	a5,a0
    800030c4:	5b9c                	lw	a5,48(a5)
}
    800030c6:	853e                	mv	a0,a5
    800030c8:	60a2                	ld	ra,8(sp)
    800030ca:	6402                	ld	s0,0(sp)
    800030cc:	0141                	addi	sp,sp,16
    800030ce:	8082                	ret

00000000800030d0 <sys_fork>:

uint64
sys_fork(void)
{
    800030d0:	1141                	addi	sp,sp,-16
    800030d2:	e406                	sd	ra,8(sp)
    800030d4:	e022                	sd	s0,0(sp)
    800030d6:	0800                	addi	s0,sp,16
  return fork();
    800030d8:	fffff097          	auipc	ra,0xfffff
    800030dc:	a00080e7          	jalr	-1536(ra) # 80001ad8 <fork>
    800030e0:	87aa                	mv	a5,a0
}
    800030e2:	853e                	mv	a0,a5
    800030e4:	60a2                	ld	ra,8(sp)
    800030e6:	6402                	ld	s0,0(sp)
    800030e8:	0141                	addi	sp,sp,16
    800030ea:	8082                	ret

00000000800030ec <sys_wait>:

uint64
sys_wait(void)
{
    800030ec:	1101                	addi	sp,sp,-32
    800030ee:	ec06                	sd	ra,24(sp)
    800030f0:	e822                	sd	s0,16(sp)
    800030f2:	1000                	addi	s0,sp,32
  uint64 p;
  argaddr(0, &p);
    800030f4:	fe840793          	addi	a5,s0,-24
    800030f8:	85be                	mv	a1,a5
    800030fa:	4501                	li	a0,0
    800030fc:	00000097          	auipc	ra,0x0
    80003100:	e02080e7          	jalr	-510(ra) # 80002efe <argaddr>
  return wait(p);
    80003104:	fe843783          	ld	a5,-24(s0)
    80003108:	853e                	mv	a0,a5
    8000310a:	fffff097          	auipc	ra,0xfffff
    8000310e:	d3c080e7          	jalr	-708(ra) # 80001e46 <wait>
    80003112:	87aa                	mv	a5,a0
}
    80003114:	853e                	mv	a0,a5
    80003116:	60e2                	ld	ra,24(sp)
    80003118:	6442                	ld	s0,16(sp)
    8000311a:	6105                	addi	sp,sp,32
    8000311c:	8082                	ret

000000008000311e <sys_sbrk>:

uint64
sys_sbrk(void)
{
    8000311e:	1101                	addi	sp,sp,-32
    80003120:	ec06                	sd	ra,24(sp)
    80003122:	e822                	sd	s0,16(sp)
    80003124:	1000                	addi	s0,sp,32
  uint64 addr;
  int n;

  argint(0, &n);
    80003126:	fe440793          	addi	a5,s0,-28
    8000312a:	85be                	mv	a1,a5
    8000312c:	4501                	li	a0,0
    8000312e:	00000097          	auipc	ra,0x0
    80003132:	d9a080e7          	jalr	-614(ra) # 80002ec8 <argint>
  addr = myproc()->sz;
    80003136:	ffffe097          	auipc	ra,0xffffe
    8000313a:	4ca080e7          	jalr	1226(ra) # 80001600 <myproc>
    8000313e:	87aa                	mv	a5,a0
    80003140:	67bc                	ld	a5,72(a5)
    80003142:	fef43423          	sd	a5,-24(s0)
  if(growproc(n) < 0)
    80003146:	fe442783          	lw	a5,-28(s0)
    8000314a:	853e                	mv	a0,a5
    8000314c:	fffff097          	auipc	ra,0xfffff
    80003150:	8ec080e7          	jalr	-1812(ra) # 80001a38 <growproc>
    80003154:	87aa                	mv	a5,a0
    80003156:	0007d463          	bgez	a5,8000315e <sys_sbrk+0x40>
    return -1;
    8000315a:	57fd                	li	a5,-1
    8000315c:	a019                	j	80003162 <sys_sbrk+0x44>
  return addr;
    8000315e:	fe843783          	ld	a5,-24(s0)
}
    80003162:	853e                	mv	a0,a5
    80003164:	60e2                	ld	ra,24(sp)
    80003166:	6442                	ld	s0,16(sp)
    80003168:	6105                	addi	sp,sp,32
    8000316a:	8082                	ret

000000008000316c <sys_sleep>:

uint64
sys_sleep(void)
{
    8000316c:	1101                	addi	sp,sp,-32
    8000316e:	ec06                	sd	ra,24(sp)
    80003170:	e822                	sd	s0,16(sp)
    80003172:	1000                	addi	s0,sp,32
  int n;
  uint ticks0;

  argint(0, &n);
    80003174:	fe840793          	addi	a5,s0,-24
    80003178:	85be                	mv	a1,a5
    8000317a:	4501                	li	a0,0
    8000317c:	00000097          	auipc	ra,0x0
    80003180:	d4c080e7          	jalr	-692(ra) # 80002ec8 <argint>
  if(n < 0)
    80003184:	fe842783          	lw	a5,-24(s0)
    80003188:	0007d463          	bgez	a5,80003190 <sys_sleep+0x24>
    n = 0;
    8000318c:	fe042423          	sw	zero,-24(s0)
  acquire(&tickslock);
    80003190:	0000f517          	auipc	a0,0xf
    80003194:	93850513          	addi	a0,a0,-1736 # 80011ac8 <tickslock>
    80003198:	00006097          	auipc	ra,0x6
    8000319c:	1e6080e7          	jalr	486(ra) # 8000937e <acquire>
  ticks0 = ticks;
    800031a0:	00009797          	auipc	a5,0x9
    800031a4:	8b078793          	addi	a5,a5,-1872 # 8000ba50 <ticks>
    800031a8:	439c                	lw	a5,0(a5)
    800031aa:	fef42623          	sw	a5,-20(s0)
  while(ticks - ticks0 < n){
    800031ae:	a099                	j	800031f4 <sys_sleep+0x88>
    if(killed(myproc())){
    800031b0:	ffffe097          	auipc	ra,0xffffe
    800031b4:	450080e7          	jalr	1104(ra) # 80001600 <myproc>
    800031b8:	87aa                	mv	a5,a0
    800031ba:	853e                	mv	a0,a5
    800031bc:	fffff097          	auipc	ra,0xfffff
    800031c0:	208080e7          	jalr	520(ra) # 800023c4 <killed>
    800031c4:	87aa                	mv	a5,a0
    800031c6:	cb99                	beqz	a5,800031dc <sys_sleep+0x70>
      release(&tickslock);
    800031c8:	0000f517          	auipc	a0,0xf
    800031cc:	90050513          	addi	a0,a0,-1792 # 80011ac8 <tickslock>
    800031d0:	00006097          	auipc	ra,0x6
    800031d4:	212080e7          	jalr	530(ra) # 800093e2 <release>
      return -1;
    800031d8:	57fd                	li	a5,-1
    800031da:	a0a9                	j	80003224 <sys_sleep+0xb8>
    }
    sleep(&ticks, &tickslock);
    800031dc:	0000f597          	auipc	a1,0xf
    800031e0:	8ec58593          	addi	a1,a1,-1812 # 80011ac8 <tickslock>
    800031e4:	00009517          	auipc	a0,0x9
    800031e8:	86c50513          	addi	a0,a0,-1940 # 8000ba50 <ticks>
    800031ec:	fffff097          	auipc	ra,0xfffff
    800031f0:	fee080e7          	jalr	-18(ra) # 800021da <sleep>
  while(ticks - ticks0 < n){
    800031f4:	00009797          	auipc	a5,0x9
    800031f8:	85c78793          	addi	a5,a5,-1956 # 8000ba50 <ticks>
    800031fc:	439c                	lw	a5,0(a5)
    800031fe:	fec42703          	lw	a4,-20(s0)
    80003202:	9f99                	subw	a5,a5,a4
    80003204:	0007871b          	sext.w	a4,a5
    80003208:	fe842783          	lw	a5,-24(s0)
    8000320c:	2781                	sext.w	a5,a5
    8000320e:	faf761e3          	bltu	a4,a5,800031b0 <sys_sleep+0x44>
  }
  release(&tickslock);
    80003212:	0000f517          	auipc	a0,0xf
    80003216:	8b650513          	addi	a0,a0,-1866 # 80011ac8 <tickslock>
    8000321a:	00006097          	auipc	ra,0x6
    8000321e:	1c8080e7          	jalr	456(ra) # 800093e2 <release>
  return 0;
    80003222:	4781                	li	a5,0
}
    80003224:	853e                	mv	a0,a5
    80003226:	60e2                	ld	ra,24(sp)
    80003228:	6442                	ld	s0,16(sp)
    8000322a:	6105                	addi	sp,sp,32
    8000322c:	8082                	ret

000000008000322e <sys_kill>:

uint64
sys_kill(void)
{
    8000322e:	1101                	addi	sp,sp,-32
    80003230:	ec06                	sd	ra,24(sp)
    80003232:	e822                	sd	s0,16(sp)
    80003234:	1000                	addi	s0,sp,32
  int pid;

  argint(0, &pid);
    80003236:	fec40793          	addi	a5,s0,-20
    8000323a:	85be                	mv	a1,a5
    8000323c:	4501                	li	a0,0
    8000323e:	00000097          	auipc	ra,0x0
    80003242:	c8a080e7          	jalr	-886(ra) # 80002ec8 <argint>
  return kill(pid);
    80003246:	fec42783          	lw	a5,-20(s0)
    8000324a:	853e                	mv	a0,a5
    8000324c:	fffff097          	auipc	ra,0xfffff
    80003250:	09e080e7          	jalr	158(ra) # 800022ea <kill>
    80003254:	87aa                	mv	a5,a0
}
    80003256:	853e                	mv	a0,a5
    80003258:	60e2                	ld	ra,24(sp)
    8000325a:	6442                	ld	s0,16(sp)
    8000325c:	6105                	addi	sp,sp,32
    8000325e:	8082                	ret

0000000080003260 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    80003260:	1101                	addi	sp,sp,-32
    80003262:	ec06                	sd	ra,24(sp)
    80003264:	e822                	sd	s0,16(sp)
    80003266:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    80003268:	0000f517          	auipc	a0,0xf
    8000326c:	86050513          	addi	a0,a0,-1952 # 80011ac8 <tickslock>
    80003270:	00006097          	auipc	ra,0x6
    80003274:	10e080e7          	jalr	270(ra) # 8000937e <acquire>
  xticks = ticks;
    80003278:	00008797          	auipc	a5,0x8
    8000327c:	7d878793          	addi	a5,a5,2008 # 8000ba50 <ticks>
    80003280:	439c                	lw	a5,0(a5)
    80003282:	fef42623          	sw	a5,-20(s0)
  release(&tickslock);
    80003286:	0000f517          	auipc	a0,0xf
    8000328a:	84250513          	addi	a0,a0,-1982 # 80011ac8 <tickslock>
    8000328e:	00006097          	auipc	ra,0x6
    80003292:	154080e7          	jalr	340(ra) # 800093e2 <release>
  return xticks;
    80003296:	fec46783          	lwu	a5,-20(s0)
}
    8000329a:	853e                	mv	a0,a5
    8000329c:	60e2                	ld	ra,24(sp)
    8000329e:	6442                	ld	s0,16(sp)
    800032a0:	6105                	addi	sp,sp,32
    800032a2:	8082                	ret

00000000800032a4 <sys_trace>:

uint64
sys_trace(void)
{
    800032a4:	1101                	addi	sp,sp,-32
    800032a6:	ec06                	sd	ra,24(sp)
    800032a8:	e822                	sd	s0,16(sp)
    800032aa:	1000                	addi	s0,sp,32
  uint32 mask;
  argint(0, (int *)&mask);
    800032ac:	fe440793          	addi	a5,s0,-28
    800032b0:	85be                	mv	a1,a5
    800032b2:	4501                	li	a0,0
    800032b4:	00000097          	auipc	ra,0x0
    800032b8:	c14080e7          	jalr	-1004(ra) # 80002ec8 <argint>

  struct proc *p = myproc();
    800032bc:	ffffe097          	auipc	ra,0xffffe
    800032c0:	344080e7          	jalr	836(ra) # 80001600 <myproc>
    800032c4:	fea43423          	sd	a0,-24(s0)
  p->trace_mask = mask;
    800032c8:	fe442703          	lw	a4,-28(s0)
    800032cc:	fe843783          	ld	a5,-24(s0)
    800032d0:	16e7a423          	sw	a4,360(a5)

  return 0;
    800032d4:	4781                	li	a5,0
}
    800032d6:	853e                	mv	a0,a5
    800032d8:	60e2                	ld	ra,24(sp)
    800032da:	6442                	ld	s0,16(sp)
    800032dc:	6105                	addi	sp,sp,32
    800032de:	8082                	ret

00000000800032e0 <sys_sysinfo>:

uint64
sys_sysinfo(void) {
    800032e0:	7179                	addi	sp,sp,-48
    800032e2:	f406                	sd	ra,40(sp)
    800032e4:	f022                	sd	s0,32(sp)
    800032e6:	1800                	addi	s0,sp,48
  struct proc *p = myproc(); 
    800032e8:	ffffe097          	auipc	ra,0xffffe
    800032ec:	318080e7          	jalr	792(ra) # 80001600 <myproc>
    800032f0:	fea43423          	sd	a0,-24(s0)

  uint64 dst_vaddr;
  argaddr(0, &dst_vaddr);
    800032f4:	fe040793          	addi	a5,s0,-32
    800032f8:	85be                	mv	a1,a5
    800032fa:	4501                	li	a0,0
    800032fc:	00000097          	auipc	ra,0x0
    80003300:	c02080e7          	jalr	-1022(ra) # 80002efe <argaddr>

  struct sysinfo info;
  info.nproc = get_nproc();
    80003304:	fffff097          	auipc	ra,0xfffff
    80003308:	2ca080e7          	jalr	714(ra) # 800025ce <get_nproc>
    8000330c:	87aa                	mv	a5,a0
    8000330e:	fcf43c23          	sd	a5,-40(s0)
  info.freemem = get_freemem();
    80003312:	ffffd097          	auipc	ra,0xffffd
    80003316:	eb6080e7          	jalr	-330(ra) # 800001c8 <get_freemem>
    8000331a:	87aa                	mv	a5,a0
    8000331c:	fcf43823          	sd	a5,-48(s0)

  if (copyout(p->pagetable, dst_vaddr, (char*)&info, sizeof(struct sysinfo)) == -1) {
    80003320:	fe843783          	ld	a5,-24(s0)
    80003324:	6bbc                	ld	a5,80(a5)
    80003326:	fe043703          	ld	a4,-32(s0)
    8000332a:	fd040613          	addi	a2,s0,-48
    8000332e:	46c1                	li	a3,16
    80003330:	85ba                	mv	a1,a4
    80003332:	853e                	mv	a0,a5
    80003334:	ffffe097          	auipc	ra,0xffffe
    80003338:	d96080e7          	jalr	-618(ra) # 800010ca <copyout>
    8000333c:	87aa                	mv	a5,a0
    8000333e:	873e                	mv	a4,a5
    80003340:	57fd                	li	a5,-1
    80003342:	00f71463          	bne	a4,a5,8000334a <sys_sysinfo+0x6a>
    return -1;
    80003346:	57fd                	li	a5,-1
    80003348:	a011                	j	8000334c <sys_sysinfo+0x6c>
  }

  return 0;
    8000334a:	4781                	li	a5,0
}
    8000334c:	853e                	mv	a0,a5
    8000334e:	70a2                	ld	ra,40(sp)
    80003350:	7402                	ld	s0,32(sp)
    80003352:	6145                	addi	sp,sp,48
    80003354:	8082                	ret

0000000080003356 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
    80003356:	1101                	addi	sp,sp,-32
    80003358:	ec06                	sd	ra,24(sp)
    8000335a:	e822                	sd	s0,16(sp)
    8000335c:	1000                	addi	s0,sp,32
  struct buf *b;

  initlock(&bcache.lock, "bcache");
    8000335e:	00008597          	auipc	a1,0x8
    80003362:	11a58593          	addi	a1,a1,282 # 8000b478 <etext+0x478>
    80003366:	0000e517          	auipc	a0,0xe
    8000336a:	77a50513          	addi	a0,a0,1914 # 80011ae0 <bcache>
    8000336e:	00006097          	auipc	ra,0x6
    80003372:	fe0080e7          	jalr	-32(ra) # 8000934e <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
    80003376:	0000e717          	auipc	a4,0xe
    8000337a:	76a70713          	addi	a4,a4,1898 # 80011ae0 <bcache>
    8000337e:	67a1                	lui	a5,0x8
    80003380:	97ba                	add	a5,a5,a4
    80003382:	00017717          	auipc	a4,0x17
    80003386:	9c670713          	addi	a4,a4,-1594 # 80019d48 <bcache+0x8268>
    8000338a:	2ae7b823          	sd	a4,688(a5) # 82b0 <_entry-0x7fff7d50>
  bcache.head.next = &bcache.head;
    8000338e:	0000e717          	auipc	a4,0xe
    80003392:	75270713          	addi	a4,a4,1874 # 80011ae0 <bcache>
    80003396:	67a1                	lui	a5,0x8
    80003398:	97ba                	add	a5,a5,a4
    8000339a:	00017717          	auipc	a4,0x17
    8000339e:	9ae70713          	addi	a4,a4,-1618 # 80019d48 <bcache+0x8268>
    800033a2:	2ae7bc23          	sd	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    800033a6:	0000e797          	auipc	a5,0xe
    800033aa:	75278793          	addi	a5,a5,1874 # 80011af8 <bcache+0x18>
    800033ae:	fef43423          	sd	a5,-24(s0)
    800033b2:	a895                	j	80003426 <binit+0xd0>
    b->next = bcache.head.next;
    800033b4:	0000e717          	auipc	a4,0xe
    800033b8:	72c70713          	addi	a4,a4,1836 # 80011ae0 <bcache>
    800033bc:	67a1                	lui	a5,0x8
    800033be:	97ba                	add	a5,a5,a4
    800033c0:	2b87b703          	ld	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
    800033c4:	fe843783          	ld	a5,-24(s0)
    800033c8:	ebb8                	sd	a4,80(a5)
    b->prev = &bcache.head;
    800033ca:	fe843783          	ld	a5,-24(s0)
    800033ce:	00017717          	auipc	a4,0x17
    800033d2:	97a70713          	addi	a4,a4,-1670 # 80019d48 <bcache+0x8268>
    800033d6:	e7b8                	sd	a4,72(a5)
    initsleeplock(&b->lock, "buffer");
    800033d8:	fe843783          	ld	a5,-24(s0)
    800033dc:	07c1                	addi	a5,a5,16
    800033de:	00008597          	auipc	a1,0x8
    800033e2:	0a258593          	addi	a1,a1,162 # 8000b480 <etext+0x480>
    800033e6:	853e                	mv	a0,a5
    800033e8:	00002097          	auipc	ra,0x2
    800033ec:	01e080e7          	jalr	30(ra) # 80005406 <initsleeplock>
    bcache.head.next->prev = b;
    800033f0:	0000e717          	auipc	a4,0xe
    800033f4:	6f070713          	addi	a4,a4,1776 # 80011ae0 <bcache>
    800033f8:	67a1                	lui	a5,0x8
    800033fa:	97ba                	add	a5,a5,a4
    800033fc:	2b87b783          	ld	a5,696(a5) # 82b8 <_entry-0x7fff7d48>
    80003400:	fe843703          	ld	a4,-24(s0)
    80003404:	e7b8                	sd	a4,72(a5)
    bcache.head.next = b;
    80003406:	0000e717          	auipc	a4,0xe
    8000340a:	6da70713          	addi	a4,a4,1754 # 80011ae0 <bcache>
    8000340e:	67a1                	lui	a5,0x8
    80003410:	97ba                	add	a5,a5,a4
    80003412:	fe843703          	ld	a4,-24(s0)
    80003416:	2ae7bc23          	sd	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    8000341a:	fe843783          	ld	a5,-24(s0)
    8000341e:	45878793          	addi	a5,a5,1112
    80003422:	fef43423          	sd	a5,-24(s0)
    80003426:	00017797          	auipc	a5,0x17
    8000342a:	92278793          	addi	a5,a5,-1758 # 80019d48 <bcache+0x8268>
    8000342e:	fe843703          	ld	a4,-24(s0)
    80003432:	f8f761e3          	bltu	a4,a5,800033b4 <binit+0x5e>
  }
}
    80003436:	0001                	nop
    80003438:	0001                	nop
    8000343a:	60e2                	ld	ra,24(sp)
    8000343c:	6442                	ld	s0,16(sp)
    8000343e:	6105                	addi	sp,sp,32
    80003440:	8082                	ret

0000000080003442 <bget>:
// Look through buffer cache for block on device dev.
// If not found, allocate a buffer.
// In either case, return locked buffer.
static struct buf*
bget(uint dev, uint blockno)
{
    80003442:	7179                	addi	sp,sp,-48
    80003444:	f406                	sd	ra,40(sp)
    80003446:	f022                	sd	s0,32(sp)
    80003448:	1800                	addi	s0,sp,48
    8000344a:	87aa                	mv	a5,a0
    8000344c:	872e                	mv	a4,a1
    8000344e:	fcf42e23          	sw	a5,-36(s0)
    80003452:	87ba                	mv	a5,a4
    80003454:	fcf42c23          	sw	a5,-40(s0)
  struct buf *b;

  acquire(&bcache.lock);
    80003458:	0000e517          	auipc	a0,0xe
    8000345c:	68850513          	addi	a0,a0,1672 # 80011ae0 <bcache>
    80003460:	00006097          	auipc	ra,0x6
    80003464:	f1e080e7          	jalr	-226(ra) # 8000937e <acquire>

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    80003468:	0000e717          	auipc	a4,0xe
    8000346c:	67870713          	addi	a4,a4,1656 # 80011ae0 <bcache>
    80003470:	67a1                	lui	a5,0x8
    80003472:	97ba                	add	a5,a5,a4
    80003474:	2b87b783          	ld	a5,696(a5) # 82b8 <_entry-0x7fff7d48>
    80003478:	fef43423          	sd	a5,-24(s0)
    8000347c:	a095                	j	800034e0 <bget+0x9e>
    if(b->dev == dev && b->blockno == blockno){
    8000347e:	fe843783          	ld	a5,-24(s0)
    80003482:	4798                	lw	a4,8(a5)
    80003484:	fdc42783          	lw	a5,-36(s0)
    80003488:	2781                	sext.w	a5,a5
    8000348a:	04e79663          	bne	a5,a4,800034d6 <bget+0x94>
    8000348e:	fe843783          	ld	a5,-24(s0)
    80003492:	47d8                	lw	a4,12(a5)
    80003494:	fd842783          	lw	a5,-40(s0)
    80003498:	2781                	sext.w	a5,a5
    8000349a:	02e79e63          	bne	a5,a4,800034d6 <bget+0x94>
      b->refcnt++;
    8000349e:	fe843783          	ld	a5,-24(s0)
    800034a2:	43bc                	lw	a5,64(a5)
    800034a4:	2785                	addiw	a5,a5,1
    800034a6:	0007871b          	sext.w	a4,a5
    800034aa:	fe843783          	ld	a5,-24(s0)
    800034ae:	c3b8                	sw	a4,64(a5)
      release(&bcache.lock);
    800034b0:	0000e517          	auipc	a0,0xe
    800034b4:	63050513          	addi	a0,a0,1584 # 80011ae0 <bcache>
    800034b8:	00006097          	auipc	ra,0x6
    800034bc:	f2a080e7          	jalr	-214(ra) # 800093e2 <release>
      acquiresleep(&b->lock);
    800034c0:	fe843783          	ld	a5,-24(s0)
    800034c4:	07c1                	addi	a5,a5,16
    800034c6:	853e                	mv	a0,a5
    800034c8:	00002097          	auipc	ra,0x2
    800034cc:	f8a080e7          	jalr	-118(ra) # 80005452 <acquiresleep>
      return b;
    800034d0:	fe843783          	ld	a5,-24(s0)
    800034d4:	a07d                	j	80003582 <bget+0x140>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    800034d6:	fe843783          	ld	a5,-24(s0)
    800034da:	6bbc                	ld	a5,80(a5)
    800034dc:	fef43423          	sd	a5,-24(s0)
    800034e0:	fe843703          	ld	a4,-24(s0)
    800034e4:	00017797          	auipc	a5,0x17
    800034e8:	86478793          	addi	a5,a5,-1948 # 80019d48 <bcache+0x8268>
    800034ec:	f8f719e3          	bne	a4,a5,8000347e <bget+0x3c>
    }
  }

  // Not cached.
  // Recycle the least recently used (LRU) unused buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    800034f0:	0000e717          	auipc	a4,0xe
    800034f4:	5f070713          	addi	a4,a4,1520 # 80011ae0 <bcache>
    800034f8:	67a1                	lui	a5,0x8
    800034fa:	97ba                	add	a5,a5,a4
    800034fc:	2b07b783          	ld	a5,688(a5) # 82b0 <_entry-0x7fff7d50>
    80003500:	fef43423          	sd	a5,-24(s0)
    80003504:	a8b9                	j	80003562 <bget+0x120>
    if(b->refcnt == 0) {
    80003506:	fe843783          	ld	a5,-24(s0)
    8000350a:	43bc                	lw	a5,64(a5)
    8000350c:	e7b1                	bnez	a5,80003558 <bget+0x116>
      b->dev = dev;
    8000350e:	fe843783          	ld	a5,-24(s0)
    80003512:	fdc42703          	lw	a4,-36(s0)
    80003516:	c798                	sw	a4,8(a5)
      b->blockno = blockno;
    80003518:	fe843783          	ld	a5,-24(s0)
    8000351c:	fd842703          	lw	a4,-40(s0)
    80003520:	c7d8                	sw	a4,12(a5)
      b->valid = 0;
    80003522:	fe843783          	ld	a5,-24(s0)
    80003526:	0007a023          	sw	zero,0(a5)
      b->refcnt = 1;
    8000352a:	fe843783          	ld	a5,-24(s0)
    8000352e:	4705                	li	a4,1
    80003530:	c3b8                	sw	a4,64(a5)
      release(&bcache.lock);
    80003532:	0000e517          	auipc	a0,0xe
    80003536:	5ae50513          	addi	a0,a0,1454 # 80011ae0 <bcache>
    8000353a:	00006097          	auipc	ra,0x6
    8000353e:	ea8080e7          	jalr	-344(ra) # 800093e2 <release>
      acquiresleep(&b->lock);
    80003542:	fe843783          	ld	a5,-24(s0)
    80003546:	07c1                	addi	a5,a5,16
    80003548:	853e                	mv	a0,a5
    8000354a:	00002097          	auipc	ra,0x2
    8000354e:	f08080e7          	jalr	-248(ra) # 80005452 <acquiresleep>
      return b;
    80003552:	fe843783          	ld	a5,-24(s0)
    80003556:	a035                	j	80003582 <bget+0x140>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80003558:	fe843783          	ld	a5,-24(s0)
    8000355c:	67bc                	ld	a5,72(a5)
    8000355e:	fef43423          	sd	a5,-24(s0)
    80003562:	fe843703          	ld	a4,-24(s0)
    80003566:	00016797          	auipc	a5,0x16
    8000356a:	7e278793          	addi	a5,a5,2018 # 80019d48 <bcache+0x8268>
    8000356e:	f8f71ce3          	bne	a4,a5,80003506 <bget+0xc4>
    }
  }
  panic("bget: no buffers");
    80003572:	00008517          	auipc	a0,0x8
    80003576:	f1650513          	addi	a0,a0,-234 # 8000b488 <etext+0x488>
    8000357a:	00006097          	auipc	ra,0x6
    8000357e:	9bc080e7          	jalr	-1604(ra) # 80008f36 <panic>
}
    80003582:	853e                	mv	a0,a5
    80003584:	70a2                	ld	ra,40(sp)
    80003586:	7402                	ld	s0,32(sp)
    80003588:	6145                	addi	sp,sp,48
    8000358a:	8082                	ret

000000008000358c <bread>:

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
    8000358c:	7179                	addi	sp,sp,-48
    8000358e:	f406                	sd	ra,40(sp)
    80003590:	f022                	sd	s0,32(sp)
    80003592:	1800                	addi	s0,sp,48
    80003594:	87aa                	mv	a5,a0
    80003596:	872e                	mv	a4,a1
    80003598:	fcf42e23          	sw	a5,-36(s0)
    8000359c:	87ba                	mv	a5,a4
    8000359e:	fcf42c23          	sw	a5,-40(s0)
  struct buf *b;

  b = bget(dev, blockno);
    800035a2:	fd842703          	lw	a4,-40(s0)
    800035a6:	fdc42783          	lw	a5,-36(s0)
    800035aa:	85ba                	mv	a1,a4
    800035ac:	853e                	mv	a0,a5
    800035ae:	00000097          	auipc	ra,0x0
    800035b2:	e94080e7          	jalr	-364(ra) # 80003442 <bget>
    800035b6:	fea43423          	sd	a0,-24(s0)
  if(!b->valid) {
    800035ba:	fe843783          	ld	a5,-24(s0)
    800035be:	439c                	lw	a5,0(a5)
    800035c0:	ef81                	bnez	a5,800035d8 <bread+0x4c>
    virtio_disk_rw(b, 0);
    800035c2:	4581                	li	a1,0
    800035c4:	fe843503          	ld	a0,-24(s0)
    800035c8:	00005097          	auipc	ra,0x5
    800035cc:	8aa080e7          	jalr	-1878(ra) # 80007e72 <virtio_disk_rw>
    b->valid = 1;
    800035d0:	fe843783          	ld	a5,-24(s0)
    800035d4:	4705                	li	a4,1
    800035d6:	c398                	sw	a4,0(a5)
  }
  return b;
    800035d8:	fe843783          	ld	a5,-24(s0)
}
    800035dc:	853e                	mv	a0,a5
    800035de:	70a2                	ld	ra,40(sp)
    800035e0:	7402                	ld	s0,32(sp)
    800035e2:	6145                	addi	sp,sp,48
    800035e4:	8082                	ret

00000000800035e6 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
    800035e6:	1101                	addi	sp,sp,-32
    800035e8:	ec06                	sd	ra,24(sp)
    800035ea:	e822                	sd	s0,16(sp)
    800035ec:	1000                	addi	s0,sp,32
    800035ee:	fea43423          	sd	a0,-24(s0)
  if(!holdingsleep(&b->lock))
    800035f2:	fe843783          	ld	a5,-24(s0)
    800035f6:	07c1                	addi	a5,a5,16
    800035f8:	853e                	mv	a0,a5
    800035fa:	00002097          	auipc	ra,0x2
    800035fe:	f18080e7          	jalr	-232(ra) # 80005512 <holdingsleep>
    80003602:	87aa                	mv	a5,a0
    80003604:	eb89                	bnez	a5,80003616 <bwrite+0x30>
    panic("bwrite");
    80003606:	00008517          	auipc	a0,0x8
    8000360a:	e9a50513          	addi	a0,a0,-358 # 8000b4a0 <etext+0x4a0>
    8000360e:	00006097          	auipc	ra,0x6
    80003612:	928080e7          	jalr	-1752(ra) # 80008f36 <panic>
  virtio_disk_rw(b, 1);
    80003616:	4585                	li	a1,1
    80003618:	fe843503          	ld	a0,-24(s0)
    8000361c:	00005097          	auipc	ra,0x5
    80003620:	856080e7          	jalr	-1962(ra) # 80007e72 <virtio_disk_rw>
}
    80003624:	0001                	nop
    80003626:	60e2                	ld	ra,24(sp)
    80003628:	6442                	ld	s0,16(sp)
    8000362a:	6105                	addi	sp,sp,32
    8000362c:	8082                	ret

000000008000362e <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    8000362e:	1101                	addi	sp,sp,-32
    80003630:	ec06                	sd	ra,24(sp)
    80003632:	e822                	sd	s0,16(sp)
    80003634:	1000                	addi	s0,sp,32
    80003636:	fea43423          	sd	a0,-24(s0)
  if(!holdingsleep(&b->lock))
    8000363a:	fe843783          	ld	a5,-24(s0)
    8000363e:	07c1                	addi	a5,a5,16
    80003640:	853e                	mv	a0,a5
    80003642:	00002097          	auipc	ra,0x2
    80003646:	ed0080e7          	jalr	-304(ra) # 80005512 <holdingsleep>
    8000364a:	87aa                	mv	a5,a0
    8000364c:	eb89                	bnez	a5,8000365e <brelse+0x30>
    panic("brelse");
    8000364e:	00008517          	auipc	a0,0x8
    80003652:	e5a50513          	addi	a0,a0,-422 # 8000b4a8 <etext+0x4a8>
    80003656:	00006097          	auipc	ra,0x6
    8000365a:	8e0080e7          	jalr	-1824(ra) # 80008f36 <panic>

  releasesleep(&b->lock);
    8000365e:	fe843783          	ld	a5,-24(s0)
    80003662:	07c1                	addi	a5,a5,16
    80003664:	853e                	mv	a0,a5
    80003666:	00002097          	auipc	ra,0x2
    8000366a:	e5a080e7          	jalr	-422(ra) # 800054c0 <releasesleep>

  acquire(&bcache.lock);
    8000366e:	0000e517          	auipc	a0,0xe
    80003672:	47250513          	addi	a0,a0,1138 # 80011ae0 <bcache>
    80003676:	00006097          	auipc	ra,0x6
    8000367a:	d08080e7          	jalr	-760(ra) # 8000937e <acquire>
  b->refcnt--;
    8000367e:	fe843783          	ld	a5,-24(s0)
    80003682:	43bc                	lw	a5,64(a5)
    80003684:	37fd                	addiw	a5,a5,-1
    80003686:	0007871b          	sext.w	a4,a5
    8000368a:	fe843783          	ld	a5,-24(s0)
    8000368e:	c3b8                	sw	a4,64(a5)
  if (b->refcnt == 0) {
    80003690:	fe843783          	ld	a5,-24(s0)
    80003694:	43bc                	lw	a5,64(a5)
    80003696:	e7b5                	bnez	a5,80003702 <brelse+0xd4>
    // no one is waiting for it.
    b->next->prev = b->prev;
    80003698:	fe843783          	ld	a5,-24(s0)
    8000369c:	6bbc                	ld	a5,80(a5)
    8000369e:	fe843703          	ld	a4,-24(s0)
    800036a2:	6738                	ld	a4,72(a4)
    800036a4:	e7b8                	sd	a4,72(a5)
    b->prev->next = b->next;
    800036a6:	fe843783          	ld	a5,-24(s0)
    800036aa:	67bc                	ld	a5,72(a5)
    800036ac:	fe843703          	ld	a4,-24(s0)
    800036b0:	6b38                	ld	a4,80(a4)
    800036b2:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    800036b4:	0000e717          	auipc	a4,0xe
    800036b8:	42c70713          	addi	a4,a4,1068 # 80011ae0 <bcache>
    800036bc:	67a1                	lui	a5,0x8
    800036be:	97ba                	add	a5,a5,a4
    800036c0:	2b87b703          	ld	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
    800036c4:	fe843783          	ld	a5,-24(s0)
    800036c8:	ebb8                	sd	a4,80(a5)
    b->prev = &bcache.head;
    800036ca:	fe843783          	ld	a5,-24(s0)
    800036ce:	00016717          	auipc	a4,0x16
    800036d2:	67a70713          	addi	a4,a4,1658 # 80019d48 <bcache+0x8268>
    800036d6:	e7b8                	sd	a4,72(a5)
    bcache.head.next->prev = b;
    800036d8:	0000e717          	auipc	a4,0xe
    800036dc:	40870713          	addi	a4,a4,1032 # 80011ae0 <bcache>
    800036e0:	67a1                	lui	a5,0x8
    800036e2:	97ba                	add	a5,a5,a4
    800036e4:	2b87b783          	ld	a5,696(a5) # 82b8 <_entry-0x7fff7d48>
    800036e8:	fe843703          	ld	a4,-24(s0)
    800036ec:	e7b8                	sd	a4,72(a5)
    bcache.head.next = b;
    800036ee:	0000e717          	auipc	a4,0xe
    800036f2:	3f270713          	addi	a4,a4,1010 # 80011ae0 <bcache>
    800036f6:	67a1                	lui	a5,0x8
    800036f8:	97ba                	add	a5,a5,a4
    800036fa:	fe843703          	ld	a4,-24(s0)
    800036fe:	2ae7bc23          	sd	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
  }
  
  release(&bcache.lock);
    80003702:	0000e517          	auipc	a0,0xe
    80003706:	3de50513          	addi	a0,a0,990 # 80011ae0 <bcache>
    8000370a:	00006097          	auipc	ra,0x6
    8000370e:	cd8080e7          	jalr	-808(ra) # 800093e2 <release>
}
    80003712:	0001                	nop
    80003714:	60e2                	ld	ra,24(sp)
    80003716:	6442                	ld	s0,16(sp)
    80003718:	6105                	addi	sp,sp,32
    8000371a:	8082                	ret

000000008000371c <bpin>:

void
bpin(struct buf *b) {
    8000371c:	1101                	addi	sp,sp,-32
    8000371e:	ec06                	sd	ra,24(sp)
    80003720:	e822                	sd	s0,16(sp)
    80003722:	1000                	addi	s0,sp,32
    80003724:	fea43423          	sd	a0,-24(s0)
  acquire(&bcache.lock);
    80003728:	0000e517          	auipc	a0,0xe
    8000372c:	3b850513          	addi	a0,a0,952 # 80011ae0 <bcache>
    80003730:	00006097          	auipc	ra,0x6
    80003734:	c4e080e7          	jalr	-946(ra) # 8000937e <acquire>
  b->refcnt++;
    80003738:	fe843783          	ld	a5,-24(s0)
    8000373c:	43bc                	lw	a5,64(a5)
    8000373e:	2785                	addiw	a5,a5,1
    80003740:	0007871b          	sext.w	a4,a5
    80003744:	fe843783          	ld	a5,-24(s0)
    80003748:	c3b8                	sw	a4,64(a5)
  release(&bcache.lock);
    8000374a:	0000e517          	auipc	a0,0xe
    8000374e:	39650513          	addi	a0,a0,918 # 80011ae0 <bcache>
    80003752:	00006097          	auipc	ra,0x6
    80003756:	c90080e7          	jalr	-880(ra) # 800093e2 <release>
}
    8000375a:	0001                	nop
    8000375c:	60e2                	ld	ra,24(sp)
    8000375e:	6442                	ld	s0,16(sp)
    80003760:	6105                	addi	sp,sp,32
    80003762:	8082                	ret

0000000080003764 <bunpin>:

void
bunpin(struct buf *b) {
    80003764:	1101                	addi	sp,sp,-32
    80003766:	ec06                	sd	ra,24(sp)
    80003768:	e822                	sd	s0,16(sp)
    8000376a:	1000                	addi	s0,sp,32
    8000376c:	fea43423          	sd	a0,-24(s0)
  acquire(&bcache.lock);
    80003770:	0000e517          	auipc	a0,0xe
    80003774:	37050513          	addi	a0,a0,880 # 80011ae0 <bcache>
    80003778:	00006097          	auipc	ra,0x6
    8000377c:	c06080e7          	jalr	-1018(ra) # 8000937e <acquire>
  b->refcnt--;
    80003780:	fe843783          	ld	a5,-24(s0)
    80003784:	43bc                	lw	a5,64(a5)
    80003786:	37fd                	addiw	a5,a5,-1
    80003788:	0007871b          	sext.w	a4,a5
    8000378c:	fe843783          	ld	a5,-24(s0)
    80003790:	c3b8                	sw	a4,64(a5)
  release(&bcache.lock);
    80003792:	0000e517          	auipc	a0,0xe
    80003796:	34e50513          	addi	a0,a0,846 # 80011ae0 <bcache>
    8000379a:	00006097          	auipc	ra,0x6
    8000379e:	c48080e7          	jalr	-952(ra) # 800093e2 <release>
}
    800037a2:	0001                	nop
    800037a4:	60e2                	ld	ra,24(sp)
    800037a6:	6442                	ld	s0,16(sp)
    800037a8:	6105                	addi	sp,sp,32
    800037aa:	8082                	ret

00000000800037ac <readsb>:
struct superblock sb; 

// Read the super block.
static void
readsb(int dev, struct superblock *sb)
{
    800037ac:	7179                	addi	sp,sp,-48
    800037ae:	f406                	sd	ra,40(sp)
    800037b0:	f022                	sd	s0,32(sp)
    800037b2:	1800                	addi	s0,sp,48
    800037b4:	87aa                	mv	a5,a0
    800037b6:	fcb43823          	sd	a1,-48(s0)
    800037ba:	fcf42e23          	sw	a5,-36(s0)
  struct buf *bp;

  bp = bread(dev, 1);
    800037be:	fdc42783          	lw	a5,-36(s0)
    800037c2:	4585                	li	a1,1
    800037c4:	853e                	mv	a0,a5
    800037c6:	00000097          	auipc	ra,0x0
    800037ca:	dc6080e7          	jalr	-570(ra) # 8000358c <bread>
    800037ce:	fea43423          	sd	a0,-24(s0)
  memmove(sb, bp->data, sizeof(*sb));
    800037d2:	fe843783          	ld	a5,-24(s0)
    800037d6:	05878793          	addi	a5,a5,88
    800037da:	02000613          	li	a2,32
    800037de:	85be                	mv	a1,a5
    800037e0:	fd043503          	ld	a0,-48(s0)
    800037e4:	ffffd097          	auipc	ra,0xffffd
    800037e8:	b0c080e7          	jalr	-1268(ra) # 800002f0 <memmove>
  brelse(bp);
    800037ec:	fe843503          	ld	a0,-24(s0)
    800037f0:	00000097          	auipc	ra,0x0
    800037f4:	e3e080e7          	jalr	-450(ra) # 8000362e <brelse>
}
    800037f8:	0001                	nop
    800037fa:	70a2                	ld	ra,40(sp)
    800037fc:	7402                	ld	s0,32(sp)
    800037fe:	6145                	addi	sp,sp,48
    80003800:	8082                	ret

0000000080003802 <fsinit>:

// Init fs
void
fsinit(int dev) {
    80003802:	1101                	addi	sp,sp,-32
    80003804:	ec06                	sd	ra,24(sp)
    80003806:	e822                	sd	s0,16(sp)
    80003808:	1000                	addi	s0,sp,32
    8000380a:	87aa                	mv	a5,a0
    8000380c:	fef42623          	sw	a5,-20(s0)
  readsb(dev, &sb);
    80003810:	fec42783          	lw	a5,-20(s0)
    80003814:	00017597          	auipc	a1,0x17
    80003818:	98c58593          	addi	a1,a1,-1652 # 8001a1a0 <sb>
    8000381c:	853e                	mv	a0,a5
    8000381e:	00000097          	auipc	ra,0x0
    80003822:	f8e080e7          	jalr	-114(ra) # 800037ac <readsb>
  if(sb.magic != FSMAGIC)
    80003826:	00017797          	auipc	a5,0x17
    8000382a:	97a78793          	addi	a5,a5,-1670 # 8001a1a0 <sb>
    8000382e:	439c                	lw	a5,0(a5)
    80003830:	873e                	mv	a4,a5
    80003832:	102037b7          	lui	a5,0x10203
    80003836:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    8000383a:	00f70a63          	beq	a4,a5,8000384e <fsinit+0x4c>
    panic("invalid file system");
    8000383e:	00008517          	auipc	a0,0x8
    80003842:	c7250513          	addi	a0,a0,-910 # 8000b4b0 <etext+0x4b0>
    80003846:	00005097          	auipc	ra,0x5
    8000384a:	6f0080e7          	jalr	1776(ra) # 80008f36 <panic>
  initlog(dev, &sb);
    8000384e:	fec42783          	lw	a5,-20(s0)
    80003852:	00017597          	auipc	a1,0x17
    80003856:	94e58593          	addi	a1,a1,-1714 # 8001a1a0 <sb>
    8000385a:	853e                	mv	a0,a5
    8000385c:	00001097          	auipc	ra,0x1
    80003860:	48e080e7          	jalr	1166(ra) # 80004cea <initlog>
}
    80003864:	0001                	nop
    80003866:	60e2                	ld	ra,24(sp)
    80003868:	6442                	ld	s0,16(sp)
    8000386a:	6105                	addi	sp,sp,32
    8000386c:	8082                	ret

000000008000386e <bzero>:

// Zero a block.
static void
bzero(int dev, int bno)
{
    8000386e:	7179                	addi	sp,sp,-48
    80003870:	f406                	sd	ra,40(sp)
    80003872:	f022                	sd	s0,32(sp)
    80003874:	1800                	addi	s0,sp,48
    80003876:	87aa                	mv	a5,a0
    80003878:	872e                	mv	a4,a1
    8000387a:	fcf42e23          	sw	a5,-36(s0)
    8000387e:	87ba                	mv	a5,a4
    80003880:	fcf42c23          	sw	a5,-40(s0)
  struct buf *bp;

  bp = bread(dev, bno);
    80003884:	fdc42783          	lw	a5,-36(s0)
    80003888:	fd842703          	lw	a4,-40(s0)
    8000388c:	85ba                	mv	a1,a4
    8000388e:	853e                	mv	a0,a5
    80003890:	00000097          	auipc	ra,0x0
    80003894:	cfc080e7          	jalr	-772(ra) # 8000358c <bread>
    80003898:	fea43423          	sd	a0,-24(s0)
  memset(bp->data, 0, BSIZE);
    8000389c:	fe843783          	ld	a5,-24(s0)
    800038a0:	05878793          	addi	a5,a5,88
    800038a4:	40000613          	li	a2,1024
    800038a8:	4581                	li	a1,0
    800038aa:	853e                	mv	a0,a5
    800038ac:	ffffd097          	auipc	ra,0xffffd
    800038b0:	960080e7          	jalr	-1696(ra) # 8000020c <memset>
  log_write(bp);
    800038b4:	fe843503          	ld	a0,-24(s0)
    800038b8:	00002097          	auipc	ra,0x2
    800038bc:	a1a080e7          	jalr	-1510(ra) # 800052d2 <log_write>
  brelse(bp);
    800038c0:	fe843503          	ld	a0,-24(s0)
    800038c4:	00000097          	auipc	ra,0x0
    800038c8:	d6a080e7          	jalr	-662(ra) # 8000362e <brelse>
}
    800038cc:	0001                	nop
    800038ce:	70a2                	ld	ra,40(sp)
    800038d0:	7402                	ld	s0,32(sp)
    800038d2:	6145                	addi	sp,sp,48
    800038d4:	8082                	ret

00000000800038d6 <balloc>:

// Allocate a zeroed disk block.
// returns 0 if out of disk space.
static uint
balloc(uint dev)
{
    800038d6:	7139                	addi	sp,sp,-64
    800038d8:	fc06                	sd	ra,56(sp)
    800038da:	f822                	sd	s0,48(sp)
    800038dc:	0080                	addi	s0,sp,64
    800038de:	87aa                	mv	a5,a0
    800038e0:	fcf42623          	sw	a5,-52(s0)
  int b, bi, m;
  struct buf *bp;

  bp = 0;
    800038e4:	fe043023          	sd	zero,-32(s0)
  for(b = 0; b < sb.size; b += BPB){
    800038e8:	fe042623          	sw	zero,-20(s0)
    800038ec:	a295                	j	80003a50 <balloc+0x17a>
    bp = bread(dev, BBLOCK(b, sb));
    800038ee:	fec42783          	lw	a5,-20(s0)
    800038f2:	41f7d71b          	sraiw	a4,a5,0x1f
    800038f6:	0137571b          	srliw	a4,a4,0x13
    800038fa:	9fb9                	addw	a5,a5,a4
    800038fc:	40d7d79b          	sraiw	a5,a5,0xd
    80003900:	2781                	sext.w	a5,a5
    80003902:	0007871b          	sext.w	a4,a5
    80003906:	00017797          	auipc	a5,0x17
    8000390a:	89a78793          	addi	a5,a5,-1894 # 8001a1a0 <sb>
    8000390e:	4fdc                	lw	a5,28(a5)
    80003910:	9fb9                	addw	a5,a5,a4
    80003912:	0007871b          	sext.w	a4,a5
    80003916:	fcc42783          	lw	a5,-52(s0)
    8000391a:	85ba                	mv	a1,a4
    8000391c:	853e                	mv	a0,a5
    8000391e:	00000097          	auipc	ra,0x0
    80003922:	c6e080e7          	jalr	-914(ra) # 8000358c <bread>
    80003926:	fea43023          	sd	a0,-32(s0)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    8000392a:	fe042423          	sw	zero,-24(s0)
    8000392e:	a8e9                	j	80003a08 <balloc+0x132>
      m = 1 << (bi % 8);
    80003930:	fe842783          	lw	a5,-24(s0)
    80003934:	8b9d                	andi	a5,a5,7
    80003936:	2781                	sext.w	a5,a5
    80003938:	4705                	li	a4,1
    8000393a:	00f717bb          	sllw	a5,a4,a5
    8000393e:	fcf42e23          	sw	a5,-36(s0)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    80003942:	fe842783          	lw	a5,-24(s0)
    80003946:	41f7d71b          	sraiw	a4,a5,0x1f
    8000394a:	01d7571b          	srliw	a4,a4,0x1d
    8000394e:	9fb9                	addw	a5,a5,a4
    80003950:	4037d79b          	sraiw	a5,a5,0x3
    80003954:	2781                	sext.w	a5,a5
    80003956:	fe043703          	ld	a4,-32(s0)
    8000395a:	97ba                	add	a5,a5,a4
    8000395c:	0587c783          	lbu	a5,88(a5)
    80003960:	2781                	sext.w	a5,a5
    80003962:	fdc42703          	lw	a4,-36(s0)
    80003966:	8ff9                	and	a5,a5,a4
    80003968:	2781                	sext.w	a5,a5
    8000396a:	ebd1                	bnez	a5,800039fe <balloc+0x128>
        bp->data[bi/8] |= m;  // Mark block in use.
    8000396c:	fe842783          	lw	a5,-24(s0)
    80003970:	41f7d71b          	sraiw	a4,a5,0x1f
    80003974:	01d7571b          	srliw	a4,a4,0x1d
    80003978:	9fb9                	addw	a5,a5,a4
    8000397a:	4037d79b          	sraiw	a5,a5,0x3
    8000397e:	2781                	sext.w	a5,a5
    80003980:	fe043703          	ld	a4,-32(s0)
    80003984:	973e                	add	a4,a4,a5
    80003986:	05874703          	lbu	a4,88(a4)
    8000398a:	0187169b          	slliw	a3,a4,0x18
    8000398e:	4186d69b          	sraiw	a3,a3,0x18
    80003992:	fdc42703          	lw	a4,-36(s0)
    80003996:	0187171b          	slliw	a4,a4,0x18
    8000399a:	4187571b          	sraiw	a4,a4,0x18
    8000399e:	8f55                	or	a4,a4,a3
    800039a0:	0187171b          	slliw	a4,a4,0x18
    800039a4:	4187571b          	sraiw	a4,a4,0x18
    800039a8:	0ff77713          	zext.b	a4,a4
    800039ac:	fe043683          	ld	a3,-32(s0)
    800039b0:	97b6                	add	a5,a5,a3
    800039b2:	04e78c23          	sb	a4,88(a5)
        log_write(bp);
    800039b6:	fe043503          	ld	a0,-32(s0)
    800039ba:	00002097          	auipc	ra,0x2
    800039be:	918080e7          	jalr	-1768(ra) # 800052d2 <log_write>
        brelse(bp);
    800039c2:	fe043503          	ld	a0,-32(s0)
    800039c6:	00000097          	auipc	ra,0x0
    800039ca:	c68080e7          	jalr	-920(ra) # 8000362e <brelse>
        bzero(dev, b + bi);
    800039ce:	fcc42783          	lw	a5,-52(s0)
    800039d2:	fec42703          	lw	a4,-20(s0)
    800039d6:	86ba                	mv	a3,a4
    800039d8:	fe842703          	lw	a4,-24(s0)
    800039dc:	9f35                	addw	a4,a4,a3
    800039de:	2701                	sext.w	a4,a4
    800039e0:	85ba                	mv	a1,a4
    800039e2:	853e                	mv	a0,a5
    800039e4:	00000097          	auipc	ra,0x0
    800039e8:	e8a080e7          	jalr	-374(ra) # 8000386e <bzero>
        return b + bi;
    800039ec:	fec42783          	lw	a5,-20(s0)
    800039f0:	873e                	mv	a4,a5
    800039f2:	fe842783          	lw	a5,-24(s0)
    800039f6:	9fb9                	addw	a5,a5,a4
    800039f8:	2781                	sext.w	a5,a5
    800039fa:	2781                	sext.w	a5,a5
    800039fc:	a8a5                	j	80003a74 <balloc+0x19e>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    800039fe:	fe842783          	lw	a5,-24(s0)
    80003a02:	2785                	addiw	a5,a5,1
    80003a04:	fef42423          	sw	a5,-24(s0)
    80003a08:	fe842783          	lw	a5,-24(s0)
    80003a0c:	0007871b          	sext.w	a4,a5
    80003a10:	6789                	lui	a5,0x2
    80003a12:	02f75263          	bge	a4,a5,80003a36 <balloc+0x160>
    80003a16:	fec42783          	lw	a5,-20(s0)
    80003a1a:	873e                	mv	a4,a5
    80003a1c:	fe842783          	lw	a5,-24(s0)
    80003a20:	9fb9                	addw	a5,a5,a4
    80003a22:	2781                	sext.w	a5,a5
    80003a24:	0007871b          	sext.w	a4,a5
    80003a28:	00016797          	auipc	a5,0x16
    80003a2c:	77878793          	addi	a5,a5,1912 # 8001a1a0 <sb>
    80003a30:	43dc                	lw	a5,4(a5)
    80003a32:	eef76fe3          	bltu	a4,a5,80003930 <balloc+0x5a>
      }
    }
    brelse(bp);
    80003a36:	fe043503          	ld	a0,-32(s0)
    80003a3a:	00000097          	auipc	ra,0x0
    80003a3e:	bf4080e7          	jalr	-1036(ra) # 8000362e <brelse>
  for(b = 0; b < sb.size; b += BPB){
    80003a42:	fec42783          	lw	a5,-20(s0)
    80003a46:	873e                	mv	a4,a5
    80003a48:	6789                	lui	a5,0x2
    80003a4a:	9fb9                	addw	a5,a5,a4
    80003a4c:	fef42623          	sw	a5,-20(s0)
    80003a50:	00016797          	auipc	a5,0x16
    80003a54:	75078793          	addi	a5,a5,1872 # 8001a1a0 <sb>
    80003a58:	43d8                	lw	a4,4(a5)
    80003a5a:	fec42783          	lw	a5,-20(s0)
    80003a5e:	e8e7e8e3          	bltu	a5,a4,800038ee <balloc+0x18>
  }
  printf("balloc: out of blocks\n");
    80003a62:	00008517          	auipc	a0,0x8
    80003a66:	a6650513          	addi	a0,a0,-1434 # 8000b4c8 <etext+0x4c8>
    80003a6a:	00005097          	auipc	ra,0x5
    80003a6e:	276080e7          	jalr	630(ra) # 80008ce0 <printf>
  return 0;
    80003a72:	4781                	li	a5,0
}
    80003a74:	853e                	mv	a0,a5
    80003a76:	70e2                	ld	ra,56(sp)
    80003a78:	7442                	ld	s0,48(sp)
    80003a7a:	6121                	addi	sp,sp,64
    80003a7c:	8082                	ret

0000000080003a7e <bfree>:

// Free a disk block.
static void
bfree(int dev, uint b)
{
    80003a7e:	7179                	addi	sp,sp,-48
    80003a80:	f406                	sd	ra,40(sp)
    80003a82:	f022                	sd	s0,32(sp)
    80003a84:	1800                	addi	s0,sp,48
    80003a86:	87aa                	mv	a5,a0
    80003a88:	872e                	mv	a4,a1
    80003a8a:	fcf42e23          	sw	a5,-36(s0)
    80003a8e:	87ba                	mv	a5,a4
    80003a90:	fcf42c23          	sw	a5,-40(s0)
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    80003a94:	fdc42683          	lw	a3,-36(s0)
    80003a98:	fd842783          	lw	a5,-40(s0)
    80003a9c:	00d7d79b          	srliw	a5,a5,0xd
    80003aa0:	0007871b          	sext.w	a4,a5
    80003aa4:	00016797          	auipc	a5,0x16
    80003aa8:	6fc78793          	addi	a5,a5,1788 # 8001a1a0 <sb>
    80003aac:	4fdc                	lw	a5,28(a5)
    80003aae:	9fb9                	addw	a5,a5,a4
    80003ab0:	2781                	sext.w	a5,a5
    80003ab2:	85be                	mv	a1,a5
    80003ab4:	8536                	mv	a0,a3
    80003ab6:	00000097          	auipc	ra,0x0
    80003aba:	ad6080e7          	jalr	-1322(ra) # 8000358c <bread>
    80003abe:	fea43423          	sd	a0,-24(s0)
  bi = b % BPB;
    80003ac2:	fd842703          	lw	a4,-40(s0)
    80003ac6:	6789                	lui	a5,0x2
    80003ac8:	17fd                	addi	a5,a5,-1 # 1fff <_entry-0x7fffe001>
    80003aca:	8ff9                	and	a5,a5,a4
    80003acc:	fef42223          	sw	a5,-28(s0)
  m = 1 << (bi % 8);
    80003ad0:	fe442783          	lw	a5,-28(s0)
    80003ad4:	8b9d                	andi	a5,a5,7
    80003ad6:	2781                	sext.w	a5,a5
    80003ad8:	4705                	li	a4,1
    80003ada:	00f717bb          	sllw	a5,a4,a5
    80003ade:	fef42023          	sw	a5,-32(s0)
  if((bp->data[bi/8] & m) == 0)
    80003ae2:	fe442783          	lw	a5,-28(s0)
    80003ae6:	41f7d71b          	sraiw	a4,a5,0x1f
    80003aea:	01d7571b          	srliw	a4,a4,0x1d
    80003aee:	9fb9                	addw	a5,a5,a4
    80003af0:	4037d79b          	sraiw	a5,a5,0x3
    80003af4:	2781                	sext.w	a5,a5
    80003af6:	fe843703          	ld	a4,-24(s0)
    80003afa:	97ba                	add	a5,a5,a4
    80003afc:	0587c783          	lbu	a5,88(a5)
    80003b00:	2781                	sext.w	a5,a5
    80003b02:	fe042703          	lw	a4,-32(s0)
    80003b06:	8ff9                	and	a5,a5,a4
    80003b08:	2781                	sext.w	a5,a5
    80003b0a:	eb89                	bnez	a5,80003b1c <bfree+0x9e>
    panic("freeing free block");
    80003b0c:	00008517          	auipc	a0,0x8
    80003b10:	9d450513          	addi	a0,a0,-1580 # 8000b4e0 <etext+0x4e0>
    80003b14:	00005097          	auipc	ra,0x5
    80003b18:	422080e7          	jalr	1058(ra) # 80008f36 <panic>
  bp->data[bi/8] &= ~m;
    80003b1c:	fe442783          	lw	a5,-28(s0)
    80003b20:	41f7d71b          	sraiw	a4,a5,0x1f
    80003b24:	01d7571b          	srliw	a4,a4,0x1d
    80003b28:	9fb9                	addw	a5,a5,a4
    80003b2a:	4037d79b          	sraiw	a5,a5,0x3
    80003b2e:	2781                	sext.w	a5,a5
    80003b30:	fe843703          	ld	a4,-24(s0)
    80003b34:	973e                	add	a4,a4,a5
    80003b36:	05874703          	lbu	a4,88(a4)
    80003b3a:	0187169b          	slliw	a3,a4,0x18
    80003b3e:	4186d69b          	sraiw	a3,a3,0x18
    80003b42:	fe042703          	lw	a4,-32(s0)
    80003b46:	0187171b          	slliw	a4,a4,0x18
    80003b4a:	4187571b          	sraiw	a4,a4,0x18
    80003b4e:	fff74713          	not	a4,a4
    80003b52:	0187171b          	slliw	a4,a4,0x18
    80003b56:	4187571b          	sraiw	a4,a4,0x18
    80003b5a:	8f75                	and	a4,a4,a3
    80003b5c:	0187171b          	slliw	a4,a4,0x18
    80003b60:	4187571b          	sraiw	a4,a4,0x18
    80003b64:	0ff77713          	zext.b	a4,a4
    80003b68:	fe843683          	ld	a3,-24(s0)
    80003b6c:	97b6                	add	a5,a5,a3
    80003b6e:	04e78c23          	sb	a4,88(a5)
  log_write(bp);
    80003b72:	fe843503          	ld	a0,-24(s0)
    80003b76:	00001097          	auipc	ra,0x1
    80003b7a:	75c080e7          	jalr	1884(ra) # 800052d2 <log_write>
  brelse(bp);
    80003b7e:	fe843503          	ld	a0,-24(s0)
    80003b82:	00000097          	auipc	ra,0x0
    80003b86:	aac080e7          	jalr	-1364(ra) # 8000362e <brelse>
}
    80003b8a:	0001                	nop
    80003b8c:	70a2                	ld	ra,40(sp)
    80003b8e:	7402                	ld	s0,32(sp)
    80003b90:	6145                	addi	sp,sp,48
    80003b92:	8082                	ret

0000000080003b94 <iinit>:
  struct inode inode[NINODE];
} itable;

void
iinit()
{
    80003b94:	1101                	addi	sp,sp,-32
    80003b96:	ec06                	sd	ra,24(sp)
    80003b98:	e822                	sd	s0,16(sp)
    80003b9a:	1000                	addi	s0,sp,32
  int i = 0;
    80003b9c:	fe042623          	sw	zero,-20(s0)
  
  initlock(&itable.lock, "itable");
    80003ba0:	00008597          	auipc	a1,0x8
    80003ba4:	95858593          	addi	a1,a1,-1704 # 8000b4f8 <etext+0x4f8>
    80003ba8:	00016517          	auipc	a0,0x16
    80003bac:	61850513          	addi	a0,a0,1560 # 8001a1c0 <itable>
    80003bb0:	00005097          	auipc	ra,0x5
    80003bb4:	79e080e7          	jalr	1950(ra) # 8000934e <initlock>
  for(i = 0; i < NINODE; i++) {
    80003bb8:	fe042623          	sw	zero,-20(s0)
    80003bbc:	a82d                	j	80003bf6 <iinit+0x62>
    initsleeplock(&itable.inode[i].lock, "inode");
    80003bbe:	fec42703          	lw	a4,-20(s0)
    80003bc2:	87ba                	mv	a5,a4
    80003bc4:	0792                	slli	a5,a5,0x4
    80003bc6:	97ba                	add	a5,a5,a4
    80003bc8:	078e                	slli	a5,a5,0x3
    80003bca:	02078713          	addi	a4,a5,32
    80003bce:	00016797          	auipc	a5,0x16
    80003bd2:	5f278793          	addi	a5,a5,1522 # 8001a1c0 <itable>
    80003bd6:	97ba                	add	a5,a5,a4
    80003bd8:	07a1                	addi	a5,a5,8
    80003bda:	00008597          	auipc	a1,0x8
    80003bde:	92658593          	addi	a1,a1,-1754 # 8000b500 <etext+0x500>
    80003be2:	853e                	mv	a0,a5
    80003be4:	00002097          	auipc	ra,0x2
    80003be8:	822080e7          	jalr	-2014(ra) # 80005406 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
    80003bec:	fec42783          	lw	a5,-20(s0)
    80003bf0:	2785                	addiw	a5,a5,1
    80003bf2:	fef42623          	sw	a5,-20(s0)
    80003bf6:	fec42783          	lw	a5,-20(s0)
    80003bfa:	0007871b          	sext.w	a4,a5
    80003bfe:	03100793          	li	a5,49
    80003c02:	fae7dee3          	bge	a5,a4,80003bbe <iinit+0x2a>
  }
}
    80003c06:	0001                	nop
    80003c08:	0001                	nop
    80003c0a:	60e2                	ld	ra,24(sp)
    80003c0c:	6442                	ld	s0,16(sp)
    80003c0e:	6105                	addi	sp,sp,32
    80003c10:	8082                	ret

0000000080003c12 <ialloc>:
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode,
// or NULL if there is no free inode.
struct inode*
ialloc(uint dev, short type)
{
    80003c12:	7139                	addi	sp,sp,-64
    80003c14:	fc06                	sd	ra,56(sp)
    80003c16:	f822                	sd	s0,48(sp)
    80003c18:	0080                	addi	s0,sp,64
    80003c1a:	87aa                	mv	a5,a0
    80003c1c:	872e                	mv	a4,a1
    80003c1e:	fcf42623          	sw	a5,-52(s0)
    80003c22:	87ba                	mv	a5,a4
    80003c24:	fcf41523          	sh	a5,-54(s0)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
    80003c28:	4785                	li	a5,1
    80003c2a:	fef42623          	sw	a5,-20(s0)
    80003c2e:	a855                	j	80003ce2 <ialloc+0xd0>
    bp = bread(dev, IBLOCK(inum, sb));
    80003c30:	fec42783          	lw	a5,-20(s0)
    80003c34:	8391                	srli	a5,a5,0x4
    80003c36:	0007871b          	sext.w	a4,a5
    80003c3a:	00016797          	auipc	a5,0x16
    80003c3e:	56678793          	addi	a5,a5,1382 # 8001a1a0 <sb>
    80003c42:	4f9c                	lw	a5,24(a5)
    80003c44:	9fb9                	addw	a5,a5,a4
    80003c46:	0007871b          	sext.w	a4,a5
    80003c4a:	fcc42783          	lw	a5,-52(s0)
    80003c4e:	85ba                	mv	a1,a4
    80003c50:	853e                	mv	a0,a5
    80003c52:	00000097          	auipc	ra,0x0
    80003c56:	93a080e7          	jalr	-1734(ra) # 8000358c <bread>
    80003c5a:	fea43023          	sd	a0,-32(s0)
    dip = (struct dinode*)bp->data + inum%IPB;
    80003c5e:	fe043783          	ld	a5,-32(s0)
    80003c62:	05878713          	addi	a4,a5,88
    80003c66:	fec42783          	lw	a5,-20(s0)
    80003c6a:	8bbd                	andi	a5,a5,15
    80003c6c:	079a                	slli	a5,a5,0x6
    80003c6e:	97ba                	add	a5,a5,a4
    80003c70:	fcf43c23          	sd	a5,-40(s0)
    if(dip->type == 0){  // a free inode
    80003c74:	fd843783          	ld	a5,-40(s0)
    80003c78:	00079783          	lh	a5,0(a5)
    80003c7c:	eba1                	bnez	a5,80003ccc <ialloc+0xba>
      memset(dip, 0, sizeof(*dip));
    80003c7e:	04000613          	li	a2,64
    80003c82:	4581                	li	a1,0
    80003c84:	fd843503          	ld	a0,-40(s0)
    80003c88:	ffffc097          	auipc	ra,0xffffc
    80003c8c:	584080e7          	jalr	1412(ra) # 8000020c <memset>
      dip->type = type;
    80003c90:	fd843783          	ld	a5,-40(s0)
    80003c94:	fca45703          	lhu	a4,-54(s0)
    80003c98:	00e79023          	sh	a4,0(a5)
      log_write(bp);   // mark it allocated on the disk
    80003c9c:	fe043503          	ld	a0,-32(s0)
    80003ca0:	00001097          	auipc	ra,0x1
    80003ca4:	632080e7          	jalr	1586(ra) # 800052d2 <log_write>
      brelse(bp);
    80003ca8:	fe043503          	ld	a0,-32(s0)
    80003cac:	00000097          	auipc	ra,0x0
    80003cb0:	982080e7          	jalr	-1662(ra) # 8000362e <brelse>
      return iget(dev, inum);
    80003cb4:	fec42703          	lw	a4,-20(s0)
    80003cb8:	fcc42783          	lw	a5,-52(s0)
    80003cbc:	85ba                	mv	a1,a4
    80003cbe:	853e                	mv	a0,a5
    80003cc0:	00000097          	auipc	ra,0x0
    80003cc4:	138080e7          	jalr	312(ra) # 80003df8 <iget>
    80003cc8:	87aa                	mv	a5,a0
    80003cca:	a835                	j	80003d06 <ialloc+0xf4>
    }
    brelse(bp);
    80003ccc:	fe043503          	ld	a0,-32(s0)
    80003cd0:	00000097          	auipc	ra,0x0
    80003cd4:	95e080e7          	jalr	-1698(ra) # 8000362e <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
    80003cd8:	fec42783          	lw	a5,-20(s0)
    80003cdc:	2785                	addiw	a5,a5,1
    80003cde:	fef42623          	sw	a5,-20(s0)
    80003ce2:	00016797          	auipc	a5,0x16
    80003ce6:	4be78793          	addi	a5,a5,1214 # 8001a1a0 <sb>
    80003cea:	47d8                	lw	a4,12(a5)
    80003cec:	fec42783          	lw	a5,-20(s0)
    80003cf0:	f4e7e0e3          	bltu	a5,a4,80003c30 <ialloc+0x1e>
  }
  printf("ialloc: no inodes\n");
    80003cf4:	00008517          	auipc	a0,0x8
    80003cf8:	81450513          	addi	a0,a0,-2028 # 8000b508 <etext+0x508>
    80003cfc:	00005097          	auipc	ra,0x5
    80003d00:	fe4080e7          	jalr	-28(ra) # 80008ce0 <printf>
  return 0;
    80003d04:	4781                	li	a5,0
}
    80003d06:	853e                	mv	a0,a5
    80003d08:	70e2                	ld	ra,56(sp)
    80003d0a:	7442                	ld	s0,48(sp)
    80003d0c:	6121                	addi	sp,sp,64
    80003d0e:	8082                	ret

0000000080003d10 <iupdate>:
// Must be called after every change to an ip->xxx field
// that lives on disk.
// Caller must hold ip->lock.
void
iupdate(struct inode *ip)
{
    80003d10:	7179                	addi	sp,sp,-48
    80003d12:	f406                	sd	ra,40(sp)
    80003d14:	f022                	sd	s0,32(sp)
    80003d16:	1800                	addi	s0,sp,48
    80003d18:	fca43c23          	sd	a0,-40(s0)
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80003d1c:	fd843783          	ld	a5,-40(s0)
    80003d20:	4394                	lw	a3,0(a5)
    80003d22:	fd843783          	ld	a5,-40(s0)
    80003d26:	43dc                	lw	a5,4(a5)
    80003d28:	0047d79b          	srliw	a5,a5,0x4
    80003d2c:	0007871b          	sext.w	a4,a5
    80003d30:	00016797          	auipc	a5,0x16
    80003d34:	47078793          	addi	a5,a5,1136 # 8001a1a0 <sb>
    80003d38:	4f9c                	lw	a5,24(a5)
    80003d3a:	9fb9                	addw	a5,a5,a4
    80003d3c:	2781                	sext.w	a5,a5
    80003d3e:	85be                	mv	a1,a5
    80003d40:	8536                	mv	a0,a3
    80003d42:	00000097          	auipc	ra,0x0
    80003d46:	84a080e7          	jalr	-1974(ra) # 8000358c <bread>
    80003d4a:	fea43423          	sd	a0,-24(s0)
  dip = (struct dinode*)bp->data + ip->inum%IPB;
    80003d4e:	fe843783          	ld	a5,-24(s0)
    80003d52:	05878713          	addi	a4,a5,88
    80003d56:	fd843783          	ld	a5,-40(s0)
    80003d5a:	43dc                	lw	a5,4(a5)
    80003d5c:	1782                	slli	a5,a5,0x20
    80003d5e:	9381                	srli	a5,a5,0x20
    80003d60:	8bbd                	andi	a5,a5,15
    80003d62:	079a                	slli	a5,a5,0x6
    80003d64:	97ba                	add	a5,a5,a4
    80003d66:	fef43023          	sd	a5,-32(s0)
  dip->type = ip->type;
    80003d6a:	fd843783          	ld	a5,-40(s0)
    80003d6e:	04479703          	lh	a4,68(a5)
    80003d72:	fe043783          	ld	a5,-32(s0)
    80003d76:	00e79023          	sh	a4,0(a5)
  dip->major = ip->major;
    80003d7a:	fd843783          	ld	a5,-40(s0)
    80003d7e:	04679703          	lh	a4,70(a5)
    80003d82:	fe043783          	ld	a5,-32(s0)
    80003d86:	00e79123          	sh	a4,2(a5)
  dip->minor = ip->minor;
    80003d8a:	fd843783          	ld	a5,-40(s0)
    80003d8e:	04879703          	lh	a4,72(a5)
    80003d92:	fe043783          	ld	a5,-32(s0)
    80003d96:	00e79223          	sh	a4,4(a5)
  dip->nlink = ip->nlink;
    80003d9a:	fd843783          	ld	a5,-40(s0)
    80003d9e:	04a79703          	lh	a4,74(a5)
    80003da2:	fe043783          	ld	a5,-32(s0)
    80003da6:	00e79323          	sh	a4,6(a5)
  dip->size = ip->size;
    80003daa:	fd843783          	ld	a5,-40(s0)
    80003dae:	47f8                	lw	a4,76(a5)
    80003db0:	fe043783          	ld	a5,-32(s0)
    80003db4:	c798                	sw	a4,8(a5)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    80003db6:	fe043783          	ld	a5,-32(s0)
    80003dba:	00c78713          	addi	a4,a5,12
    80003dbe:	fd843783          	ld	a5,-40(s0)
    80003dc2:	05078793          	addi	a5,a5,80
    80003dc6:	03400613          	li	a2,52
    80003dca:	85be                	mv	a1,a5
    80003dcc:	853a                	mv	a0,a4
    80003dce:	ffffc097          	auipc	ra,0xffffc
    80003dd2:	522080e7          	jalr	1314(ra) # 800002f0 <memmove>
  log_write(bp);
    80003dd6:	fe843503          	ld	a0,-24(s0)
    80003dda:	00001097          	auipc	ra,0x1
    80003dde:	4f8080e7          	jalr	1272(ra) # 800052d2 <log_write>
  brelse(bp);
    80003de2:	fe843503          	ld	a0,-24(s0)
    80003de6:	00000097          	auipc	ra,0x0
    80003dea:	848080e7          	jalr	-1976(ra) # 8000362e <brelse>
}
    80003dee:	0001                	nop
    80003df0:	70a2                	ld	ra,40(sp)
    80003df2:	7402                	ld	s0,32(sp)
    80003df4:	6145                	addi	sp,sp,48
    80003df6:	8082                	ret

0000000080003df8 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
    80003df8:	7179                	addi	sp,sp,-48
    80003dfa:	f406                	sd	ra,40(sp)
    80003dfc:	f022                	sd	s0,32(sp)
    80003dfe:	1800                	addi	s0,sp,48
    80003e00:	87aa                	mv	a5,a0
    80003e02:	872e                	mv	a4,a1
    80003e04:	fcf42e23          	sw	a5,-36(s0)
    80003e08:	87ba                	mv	a5,a4
    80003e0a:	fcf42c23          	sw	a5,-40(s0)
  struct inode *ip, *empty;

  acquire(&itable.lock);
    80003e0e:	00016517          	auipc	a0,0x16
    80003e12:	3b250513          	addi	a0,a0,946 # 8001a1c0 <itable>
    80003e16:	00005097          	auipc	ra,0x5
    80003e1a:	568080e7          	jalr	1384(ra) # 8000937e <acquire>

  // Is the inode already in the table?
  empty = 0;
    80003e1e:	fe043023          	sd	zero,-32(s0)
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80003e22:	00016797          	auipc	a5,0x16
    80003e26:	3b678793          	addi	a5,a5,950 # 8001a1d8 <itable+0x18>
    80003e2a:	fef43423          	sd	a5,-24(s0)
    80003e2e:	a89d                	j	80003ea4 <iget+0xac>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
    80003e30:	fe843783          	ld	a5,-24(s0)
    80003e34:	479c                	lw	a5,8(a5)
    80003e36:	04f05663          	blez	a5,80003e82 <iget+0x8a>
    80003e3a:	fe843783          	ld	a5,-24(s0)
    80003e3e:	4398                	lw	a4,0(a5)
    80003e40:	fdc42783          	lw	a5,-36(s0)
    80003e44:	2781                	sext.w	a5,a5
    80003e46:	02e79e63          	bne	a5,a4,80003e82 <iget+0x8a>
    80003e4a:	fe843783          	ld	a5,-24(s0)
    80003e4e:	43d8                	lw	a4,4(a5)
    80003e50:	fd842783          	lw	a5,-40(s0)
    80003e54:	2781                	sext.w	a5,a5
    80003e56:	02e79663          	bne	a5,a4,80003e82 <iget+0x8a>
      ip->ref++;
    80003e5a:	fe843783          	ld	a5,-24(s0)
    80003e5e:	479c                	lw	a5,8(a5)
    80003e60:	2785                	addiw	a5,a5,1
    80003e62:	0007871b          	sext.w	a4,a5
    80003e66:	fe843783          	ld	a5,-24(s0)
    80003e6a:	c798                	sw	a4,8(a5)
      release(&itable.lock);
    80003e6c:	00016517          	auipc	a0,0x16
    80003e70:	35450513          	addi	a0,a0,852 # 8001a1c0 <itable>
    80003e74:	00005097          	auipc	ra,0x5
    80003e78:	56e080e7          	jalr	1390(ra) # 800093e2 <release>
      return ip;
    80003e7c:	fe843783          	ld	a5,-24(s0)
    80003e80:	a069                	j	80003f0a <iget+0x112>
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    80003e82:	fe043783          	ld	a5,-32(s0)
    80003e86:	eb89                	bnez	a5,80003e98 <iget+0xa0>
    80003e88:	fe843783          	ld	a5,-24(s0)
    80003e8c:	479c                	lw	a5,8(a5)
    80003e8e:	e789                	bnez	a5,80003e98 <iget+0xa0>
      empty = ip;
    80003e90:	fe843783          	ld	a5,-24(s0)
    80003e94:	fef43023          	sd	a5,-32(s0)
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80003e98:	fe843783          	ld	a5,-24(s0)
    80003e9c:	08878793          	addi	a5,a5,136
    80003ea0:	fef43423          	sd	a5,-24(s0)
    80003ea4:	fe843703          	ld	a4,-24(s0)
    80003ea8:	00018797          	auipc	a5,0x18
    80003eac:	dc078793          	addi	a5,a5,-576 # 8001bc68 <log>
    80003eb0:	f8f760e3          	bltu	a4,a5,80003e30 <iget+0x38>
  }

  // Recycle an inode entry.
  if(empty == 0)
    80003eb4:	fe043783          	ld	a5,-32(s0)
    80003eb8:	eb89                	bnez	a5,80003eca <iget+0xd2>
    panic("iget: no inodes");
    80003eba:	00007517          	auipc	a0,0x7
    80003ebe:	66650513          	addi	a0,a0,1638 # 8000b520 <etext+0x520>
    80003ec2:	00005097          	auipc	ra,0x5
    80003ec6:	074080e7          	jalr	116(ra) # 80008f36 <panic>

  ip = empty;
    80003eca:	fe043783          	ld	a5,-32(s0)
    80003ece:	fef43423          	sd	a5,-24(s0)
  ip->dev = dev;
    80003ed2:	fe843783          	ld	a5,-24(s0)
    80003ed6:	fdc42703          	lw	a4,-36(s0)
    80003eda:	c398                	sw	a4,0(a5)
  ip->inum = inum;
    80003edc:	fe843783          	ld	a5,-24(s0)
    80003ee0:	fd842703          	lw	a4,-40(s0)
    80003ee4:	c3d8                	sw	a4,4(a5)
  ip->ref = 1;
    80003ee6:	fe843783          	ld	a5,-24(s0)
    80003eea:	4705                	li	a4,1
    80003eec:	c798                	sw	a4,8(a5)
  ip->valid = 0;
    80003eee:	fe843783          	ld	a5,-24(s0)
    80003ef2:	0407a023          	sw	zero,64(a5)
  release(&itable.lock);
    80003ef6:	00016517          	auipc	a0,0x16
    80003efa:	2ca50513          	addi	a0,a0,714 # 8001a1c0 <itable>
    80003efe:	00005097          	auipc	ra,0x5
    80003f02:	4e4080e7          	jalr	1252(ra) # 800093e2 <release>

  return ip;
    80003f06:	fe843783          	ld	a5,-24(s0)
}
    80003f0a:	853e                	mv	a0,a5
    80003f0c:	70a2                	ld	ra,40(sp)
    80003f0e:	7402                	ld	s0,32(sp)
    80003f10:	6145                	addi	sp,sp,48
    80003f12:	8082                	ret

0000000080003f14 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
    80003f14:	1101                	addi	sp,sp,-32
    80003f16:	ec06                	sd	ra,24(sp)
    80003f18:	e822                	sd	s0,16(sp)
    80003f1a:	1000                	addi	s0,sp,32
    80003f1c:	fea43423          	sd	a0,-24(s0)
  acquire(&itable.lock);
    80003f20:	00016517          	auipc	a0,0x16
    80003f24:	2a050513          	addi	a0,a0,672 # 8001a1c0 <itable>
    80003f28:	00005097          	auipc	ra,0x5
    80003f2c:	456080e7          	jalr	1110(ra) # 8000937e <acquire>
  ip->ref++;
    80003f30:	fe843783          	ld	a5,-24(s0)
    80003f34:	479c                	lw	a5,8(a5)
    80003f36:	2785                	addiw	a5,a5,1
    80003f38:	0007871b          	sext.w	a4,a5
    80003f3c:	fe843783          	ld	a5,-24(s0)
    80003f40:	c798                	sw	a4,8(a5)
  release(&itable.lock);
    80003f42:	00016517          	auipc	a0,0x16
    80003f46:	27e50513          	addi	a0,a0,638 # 8001a1c0 <itable>
    80003f4a:	00005097          	auipc	ra,0x5
    80003f4e:	498080e7          	jalr	1176(ra) # 800093e2 <release>
  return ip;
    80003f52:	fe843783          	ld	a5,-24(s0)
}
    80003f56:	853e                	mv	a0,a5
    80003f58:	60e2                	ld	ra,24(sp)
    80003f5a:	6442                	ld	s0,16(sp)
    80003f5c:	6105                	addi	sp,sp,32
    80003f5e:	8082                	ret

0000000080003f60 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
    80003f60:	7179                	addi	sp,sp,-48
    80003f62:	f406                	sd	ra,40(sp)
    80003f64:	f022                	sd	s0,32(sp)
    80003f66:	1800                	addi	s0,sp,48
    80003f68:	fca43c23          	sd	a0,-40(s0)
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    80003f6c:	fd843783          	ld	a5,-40(s0)
    80003f70:	c791                	beqz	a5,80003f7c <ilock+0x1c>
    80003f72:	fd843783          	ld	a5,-40(s0)
    80003f76:	479c                	lw	a5,8(a5)
    80003f78:	00f04a63          	bgtz	a5,80003f8c <ilock+0x2c>
    panic("ilock");
    80003f7c:	00007517          	auipc	a0,0x7
    80003f80:	5b450513          	addi	a0,a0,1460 # 8000b530 <etext+0x530>
    80003f84:	00005097          	auipc	ra,0x5
    80003f88:	fb2080e7          	jalr	-78(ra) # 80008f36 <panic>

  acquiresleep(&ip->lock);
    80003f8c:	fd843783          	ld	a5,-40(s0)
    80003f90:	07c1                	addi	a5,a5,16
    80003f92:	853e                	mv	a0,a5
    80003f94:	00001097          	auipc	ra,0x1
    80003f98:	4be080e7          	jalr	1214(ra) # 80005452 <acquiresleep>

  if(ip->valid == 0){
    80003f9c:	fd843783          	ld	a5,-40(s0)
    80003fa0:	43bc                	lw	a5,64(a5)
    80003fa2:	e7e5                	bnez	a5,8000408a <ilock+0x12a>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80003fa4:	fd843783          	ld	a5,-40(s0)
    80003fa8:	4394                	lw	a3,0(a5)
    80003faa:	fd843783          	ld	a5,-40(s0)
    80003fae:	43dc                	lw	a5,4(a5)
    80003fb0:	0047d79b          	srliw	a5,a5,0x4
    80003fb4:	0007871b          	sext.w	a4,a5
    80003fb8:	00016797          	auipc	a5,0x16
    80003fbc:	1e878793          	addi	a5,a5,488 # 8001a1a0 <sb>
    80003fc0:	4f9c                	lw	a5,24(a5)
    80003fc2:	9fb9                	addw	a5,a5,a4
    80003fc4:	2781                	sext.w	a5,a5
    80003fc6:	85be                	mv	a1,a5
    80003fc8:	8536                	mv	a0,a3
    80003fca:	fffff097          	auipc	ra,0xfffff
    80003fce:	5c2080e7          	jalr	1474(ra) # 8000358c <bread>
    80003fd2:	fea43423          	sd	a0,-24(s0)
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    80003fd6:	fe843783          	ld	a5,-24(s0)
    80003fda:	05878713          	addi	a4,a5,88
    80003fde:	fd843783          	ld	a5,-40(s0)
    80003fe2:	43dc                	lw	a5,4(a5)
    80003fe4:	1782                	slli	a5,a5,0x20
    80003fe6:	9381                	srli	a5,a5,0x20
    80003fe8:	8bbd                	andi	a5,a5,15
    80003fea:	079a                	slli	a5,a5,0x6
    80003fec:	97ba                	add	a5,a5,a4
    80003fee:	fef43023          	sd	a5,-32(s0)
    ip->type = dip->type;
    80003ff2:	fe043783          	ld	a5,-32(s0)
    80003ff6:	00079703          	lh	a4,0(a5)
    80003ffa:	fd843783          	ld	a5,-40(s0)
    80003ffe:	04e79223          	sh	a4,68(a5)
    ip->major = dip->major;
    80004002:	fe043783          	ld	a5,-32(s0)
    80004006:	00279703          	lh	a4,2(a5)
    8000400a:	fd843783          	ld	a5,-40(s0)
    8000400e:	04e79323          	sh	a4,70(a5)
    ip->minor = dip->minor;
    80004012:	fe043783          	ld	a5,-32(s0)
    80004016:	00479703          	lh	a4,4(a5)
    8000401a:	fd843783          	ld	a5,-40(s0)
    8000401e:	04e79423          	sh	a4,72(a5)
    ip->nlink = dip->nlink;
    80004022:	fe043783          	ld	a5,-32(s0)
    80004026:	00679703          	lh	a4,6(a5)
    8000402a:	fd843783          	ld	a5,-40(s0)
    8000402e:	04e79523          	sh	a4,74(a5)
    ip->size = dip->size;
    80004032:	fe043783          	ld	a5,-32(s0)
    80004036:	4798                	lw	a4,8(a5)
    80004038:	fd843783          	ld	a5,-40(s0)
    8000403c:	c7f8                	sw	a4,76(a5)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    8000403e:	fd843783          	ld	a5,-40(s0)
    80004042:	05078713          	addi	a4,a5,80
    80004046:	fe043783          	ld	a5,-32(s0)
    8000404a:	07b1                	addi	a5,a5,12
    8000404c:	03400613          	li	a2,52
    80004050:	85be                	mv	a1,a5
    80004052:	853a                	mv	a0,a4
    80004054:	ffffc097          	auipc	ra,0xffffc
    80004058:	29c080e7          	jalr	668(ra) # 800002f0 <memmove>
    brelse(bp);
    8000405c:	fe843503          	ld	a0,-24(s0)
    80004060:	fffff097          	auipc	ra,0xfffff
    80004064:	5ce080e7          	jalr	1486(ra) # 8000362e <brelse>
    ip->valid = 1;
    80004068:	fd843783          	ld	a5,-40(s0)
    8000406c:	4705                	li	a4,1
    8000406e:	c3b8                	sw	a4,64(a5)
    if(ip->type == 0)
    80004070:	fd843783          	ld	a5,-40(s0)
    80004074:	04479783          	lh	a5,68(a5)
    80004078:	eb89                	bnez	a5,8000408a <ilock+0x12a>
      panic("ilock: no type");
    8000407a:	00007517          	auipc	a0,0x7
    8000407e:	4be50513          	addi	a0,a0,1214 # 8000b538 <etext+0x538>
    80004082:	00005097          	auipc	ra,0x5
    80004086:	eb4080e7          	jalr	-332(ra) # 80008f36 <panic>
  }
}
    8000408a:	0001                	nop
    8000408c:	70a2                	ld	ra,40(sp)
    8000408e:	7402                	ld	s0,32(sp)
    80004090:	6145                	addi	sp,sp,48
    80004092:	8082                	ret

0000000080004094 <iunlock>:

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
    80004094:	1101                	addi	sp,sp,-32
    80004096:	ec06                	sd	ra,24(sp)
    80004098:	e822                	sd	s0,16(sp)
    8000409a:	1000                	addi	s0,sp,32
    8000409c:	fea43423          	sd	a0,-24(s0)
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    800040a0:	fe843783          	ld	a5,-24(s0)
    800040a4:	c385                	beqz	a5,800040c4 <iunlock+0x30>
    800040a6:	fe843783          	ld	a5,-24(s0)
    800040aa:	07c1                	addi	a5,a5,16
    800040ac:	853e                	mv	a0,a5
    800040ae:	00001097          	auipc	ra,0x1
    800040b2:	464080e7          	jalr	1124(ra) # 80005512 <holdingsleep>
    800040b6:	87aa                	mv	a5,a0
    800040b8:	c791                	beqz	a5,800040c4 <iunlock+0x30>
    800040ba:	fe843783          	ld	a5,-24(s0)
    800040be:	479c                	lw	a5,8(a5)
    800040c0:	00f04a63          	bgtz	a5,800040d4 <iunlock+0x40>
    panic("iunlock");
    800040c4:	00007517          	auipc	a0,0x7
    800040c8:	48450513          	addi	a0,a0,1156 # 8000b548 <etext+0x548>
    800040cc:	00005097          	auipc	ra,0x5
    800040d0:	e6a080e7          	jalr	-406(ra) # 80008f36 <panic>

  releasesleep(&ip->lock);
    800040d4:	fe843783          	ld	a5,-24(s0)
    800040d8:	07c1                	addi	a5,a5,16
    800040da:	853e                	mv	a0,a5
    800040dc:	00001097          	auipc	ra,0x1
    800040e0:	3e4080e7          	jalr	996(ra) # 800054c0 <releasesleep>
}
    800040e4:	0001                	nop
    800040e6:	60e2                	ld	ra,24(sp)
    800040e8:	6442                	ld	s0,16(sp)
    800040ea:	6105                	addi	sp,sp,32
    800040ec:	8082                	ret

00000000800040ee <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
    800040ee:	1101                	addi	sp,sp,-32
    800040f0:	ec06                	sd	ra,24(sp)
    800040f2:	e822                	sd	s0,16(sp)
    800040f4:	1000                	addi	s0,sp,32
    800040f6:	fea43423          	sd	a0,-24(s0)
  acquire(&itable.lock);
    800040fa:	00016517          	auipc	a0,0x16
    800040fe:	0c650513          	addi	a0,a0,198 # 8001a1c0 <itable>
    80004102:	00005097          	auipc	ra,0x5
    80004106:	27c080e7          	jalr	636(ra) # 8000937e <acquire>

  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    8000410a:	fe843783          	ld	a5,-24(s0)
    8000410e:	479c                	lw	a5,8(a5)
    80004110:	873e                	mv	a4,a5
    80004112:	4785                	li	a5,1
    80004114:	06f71f63          	bne	a4,a5,80004192 <iput+0xa4>
    80004118:	fe843783          	ld	a5,-24(s0)
    8000411c:	43bc                	lw	a5,64(a5)
    8000411e:	cbb5                	beqz	a5,80004192 <iput+0xa4>
    80004120:	fe843783          	ld	a5,-24(s0)
    80004124:	04a79783          	lh	a5,74(a5)
    80004128:	e7ad                	bnez	a5,80004192 <iput+0xa4>
    // inode has no links and no other references: truncate and free.

    // ip->ref == 1 means no other process can have ip locked,
    // so this acquiresleep() won't block (or deadlock).
    acquiresleep(&ip->lock);
    8000412a:	fe843783          	ld	a5,-24(s0)
    8000412e:	07c1                	addi	a5,a5,16
    80004130:	853e                	mv	a0,a5
    80004132:	00001097          	auipc	ra,0x1
    80004136:	320080e7          	jalr	800(ra) # 80005452 <acquiresleep>

    release(&itable.lock);
    8000413a:	00016517          	auipc	a0,0x16
    8000413e:	08650513          	addi	a0,a0,134 # 8001a1c0 <itable>
    80004142:	00005097          	auipc	ra,0x5
    80004146:	2a0080e7          	jalr	672(ra) # 800093e2 <release>

    itrunc(ip);
    8000414a:	fe843503          	ld	a0,-24(s0)
    8000414e:	00000097          	auipc	ra,0x0
    80004152:	21a080e7          	jalr	538(ra) # 80004368 <itrunc>
    ip->type = 0;
    80004156:	fe843783          	ld	a5,-24(s0)
    8000415a:	04079223          	sh	zero,68(a5)
    iupdate(ip);
    8000415e:	fe843503          	ld	a0,-24(s0)
    80004162:	00000097          	auipc	ra,0x0
    80004166:	bae080e7          	jalr	-1106(ra) # 80003d10 <iupdate>
    ip->valid = 0;
    8000416a:	fe843783          	ld	a5,-24(s0)
    8000416e:	0407a023          	sw	zero,64(a5)

    releasesleep(&ip->lock);
    80004172:	fe843783          	ld	a5,-24(s0)
    80004176:	07c1                	addi	a5,a5,16
    80004178:	853e                	mv	a0,a5
    8000417a:	00001097          	auipc	ra,0x1
    8000417e:	346080e7          	jalr	838(ra) # 800054c0 <releasesleep>

    acquire(&itable.lock);
    80004182:	00016517          	auipc	a0,0x16
    80004186:	03e50513          	addi	a0,a0,62 # 8001a1c0 <itable>
    8000418a:	00005097          	auipc	ra,0x5
    8000418e:	1f4080e7          	jalr	500(ra) # 8000937e <acquire>
  }

  ip->ref--;
    80004192:	fe843783          	ld	a5,-24(s0)
    80004196:	479c                	lw	a5,8(a5)
    80004198:	37fd                	addiw	a5,a5,-1
    8000419a:	0007871b          	sext.w	a4,a5
    8000419e:	fe843783          	ld	a5,-24(s0)
    800041a2:	c798                	sw	a4,8(a5)
  release(&itable.lock);
    800041a4:	00016517          	auipc	a0,0x16
    800041a8:	01c50513          	addi	a0,a0,28 # 8001a1c0 <itable>
    800041ac:	00005097          	auipc	ra,0x5
    800041b0:	236080e7          	jalr	566(ra) # 800093e2 <release>
}
    800041b4:	0001                	nop
    800041b6:	60e2                	ld	ra,24(sp)
    800041b8:	6442                	ld	s0,16(sp)
    800041ba:	6105                	addi	sp,sp,32
    800041bc:	8082                	ret

00000000800041be <iunlockput>:

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
    800041be:	1101                	addi	sp,sp,-32
    800041c0:	ec06                	sd	ra,24(sp)
    800041c2:	e822                	sd	s0,16(sp)
    800041c4:	1000                	addi	s0,sp,32
    800041c6:	fea43423          	sd	a0,-24(s0)
  iunlock(ip);
    800041ca:	fe843503          	ld	a0,-24(s0)
    800041ce:	00000097          	auipc	ra,0x0
    800041d2:	ec6080e7          	jalr	-314(ra) # 80004094 <iunlock>
  iput(ip);
    800041d6:	fe843503          	ld	a0,-24(s0)
    800041da:	00000097          	auipc	ra,0x0
    800041de:	f14080e7          	jalr	-236(ra) # 800040ee <iput>
}
    800041e2:	0001                	nop
    800041e4:	60e2                	ld	ra,24(sp)
    800041e6:	6442                	ld	s0,16(sp)
    800041e8:	6105                	addi	sp,sp,32
    800041ea:	8082                	ret

00000000800041ec <bmap>:
// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
// returns 0 if out of disk space.
static uint
bmap(struct inode *ip, uint bn)
{
    800041ec:	7139                	addi	sp,sp,-64
    800041ee:	fc06                	sd	ra,56(sp)
    800041f0:	f822                	sd	s0,48(sp)
    800041f2:	0080                	addi	s0,sp,64
    800041f4:	fca43423          	sd	a0,-56(s0)
    800041f8:	87ae                	mv	a5,a1
    800041fa:	fcf42223          	sw	a5,-60(s0)
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    800041fe:	fc442783          	lw	a5,-60(s0)
    80004202:	0007871b          	sext.w	a4,a5
    80004206:	47ad                	li	a5,11
    80004208:	04e7ee63          	bltu	a5,a4,80004264 <bmap+0x78>
    if((addr = ip->addrs[bn]) == 0){
    8000420c:	fc843703          	ld	a4,-56(s0)
    80004210:	fc446783          	lwu	a5,-60(s0)
    80004214:	07d1                	addi	a5,a5,20
    80004216:	078a                	slli	a5,a5,0x2
    80004218:	97ba                	add	a5,a5,a4
    8000421a:	439c                	lw	a5,0(a5)
    8000421c:	fef42623          	sw	a5,-20(s0)
    80004220:	fec42783          	lw	a5,-20(s0)
    80004224:	2781                	sext.w	a5,a5
    80004226:	ef85                	bnez	a5,8000425e <bmap+0x72>
      addr = balloc(ip->dev);
    80004228:	fc843783          	ld	a5,-56(s0)
    8000422c:	439c                	lw	a5,0(a5)
    8000422e:	853e                	mv	a0,a5
    80004230:	fffff097          	auipc	ra,0xfffff
    80004234:	6a6080e7          	jalr	1702(ra) # 800038d6 <balloc>
    80004238:	87aa                	mv	a5,a0
    8000423a:	fef42623          	sw	a5,-20(s0)
      if(addr == 0)
    8000423e:	fec42783          	lw	a5,-20(s0)
    80004242:	2781                	sext.w	a5,a5
    80004244:	e399                	bnez	a5,8000424a <bmap+0x5e>
        return 0;
    80004246:	4781                	li	a5,0
    80004248:	aa19                	j	8000435e <bmap+0x172>
      ip->addrs[bn] = addr;
    8000424a:	fc843703          	ld	a4,-56(s0)
    8000424e:	fc446783          	lwu	a5,-60(s0)
    80004252:	07d1                	addi	a5,a5,20
    80004254:	078a                	slli	a5,a5,0x2
    80004256:	97ba                	add	a5,a5,a4
    80004258:	fec42703          	lw	a4,-20(s0)
    8000425c:	c398                	sw	a4,0(a5)
    }
    return addr;
    8000425e:	fec42783          	lw	a5,-20(s0)
    80004262:	a8f5                	j	8000435e <bmap+0x172>
  }
  bn -= NDIRECT;
    80004264:	fc442783          	lw	a5,-60(s0)
    80004268:	37d1                	addiw	a5,a5,-12
    8000426a:	fcf42223          	sw	a5,-60(s0)

  if(bn < NINDIRECT){
    8000426e:	fc442783          	lw	a5,-60(s0)
    80004272:	0007871b          	sext.w	a4,a5
    80004276:	0ff00793          	li	a5,255
    8000427a:	0ce7ea63          	bltu	a5,a4,8000434e <bmap+0x162>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0){
    8000427e:	fc843783          	ld	a5,-56(s0)
    80004282:	0807a783          	lw	a5,128(a5)
    80004286:	fef42623          	sw	a5,-20(s0)
    8000428a:	fec42783          	lw	a5,-20(s0)
    8000428e:	2781                	sext.w	a5,a5
    80004290:	eb85                	bnez	a5,800042c0 <bmap+0xd4>
      addr = balloc(ip->dev);
    80004292:	fc843783          	ld	a5,-56(s0)
    80004296:	439c                	lw	a5,0(a5)
    80004298:	853e                	mv	a0,a5
    8000429a:	fffff097          	auipc	ra,0xfffff
    8000429e:	63c080e7          	jalr	1596(ra) # 800038d6 <balloc>
    800042a2:	87aa                	mv	a5,a0
    800042a4:	fef42623          	sw	a5,-20(s0)
      if(addr == 0)
    800042a8:	fec42783          	lw	a5,-20(s0)
    800042ac:	2781                	sext.w	a5,a5
    800042ae:	e399                	bnez	a5,800042b4 <bmap+0xc8>
        return 0;
    800042b0:	4781                	li	a5,0
    800042b2:	a075                	j	8000435e <bmap+0x172>
      ip->addrs[NDIRECT] = addr;
    800042b4:	fc843783          	ld	a5,-56(s0)
    800042b8:	fec42703          	lw	a4,-20(s0)
    800042bc:	08e7a023          	sw	a4,128(a5)
    }
    bp = bread(ip->dev, addr);
    800042c0:	fc843783          	ld	a5,-56(s0)
    800042c4:	439c                	lw	a5,0(a5)
    800042c6:	fec42703          	lw	a4,-20(s0)
    800042ca:	85ba                	mv	a1,a4
    800042cc:	853e                	mv	a0,a5
    800042ce:	fffff097          	auipc	ra,0xfffff
    800042d2:	2be080e7          	jalr	702(ra) # 8000358c <bread>
    800042d6:	fea43023          	sd	a0,-32(s0)
    a = (uint*)bp->data;
    800042da:	fe043783          	ld	a5,-32(s0)
    800042de:	05878793          	addi	a5,a5,88
    800042e2:	fcf43c23          	sd	a5,-40(s0)
    if((addr = a[bn]) == 0){
    800042e6:	fc446783          	lwu	a5,-60(s0)
    800042ea:	078a                	slli	a5,a5,0x2
    800042ec:	fd843703          	ld	a4,-40(s0)
    800042f0:	97ba                	add	a5,a5,a4
    800042f2:	439c                	lw	a5,0(a5)
    800042f4:	fef42623          	sw	a5,-20(s0)
    800042f8:	fec42783          	lw	a5,-20(s0)
    800042fc:	2781                	sext.w	a5,a5
    800042fe:	ef9d                	bnez	a5,8000433c <bmap+0x150>
      addr = balloc(ip->dev);
    80004300:	fc843783          	ld	a5,-56(s0)
    80004304:	439c                	lw	a5,0(a5)
    80004306:	853e                	mv	a0,a5
    80004308:	fffff097          	auipc	ra,0xfffff
    8000430c:	5ce080e7          	jalr	1486(ra) # 800038d6 <balloc>
    80004310:	87aa                	mv	a5,a0
    80004312:	fef42623          	sw	a5,-20(s0)
      if(addr){
    80004316:	fec42783          	lw	a5,-20(s0)
    8000431a:	2781                	sext.w	a5,a5
    8000431c:	c385                	beqz	a5,8000433c <bmap+0x150>
        a[bn] = addr;
    8000431e:	fc446783          	lwu	a5,-60(s0)
    80004322:	078a                	slli	a5,a5,0x2
    80004324:	fd843703          	ld	a4,-40(s0)
    80004328:	97ba                	add	a5,a5,a4
    8000432a:	fec42703          	lw	a4,-20(s0)
    8000432e:	c398                	sw	a4,0(a5)
        log_write(bp);
    80004330:	fe043503          	ld	a0,-32(s0)
    80004334:	00001097          	auipc	ra,0x1
    80004338:	f9e080e7          	jalr	-98(ra) # 800052d2 <log_write>
      }
    }
    brelse(bp);
    8000433c:	fe043503          	ld	a0,-32(s0)
    80004340:	fffff097          	auipc	ra,0xfffff
    80004344:	2ee080e7          	jalr	750(ra) # 8000362e <brelse>
    return addr;
    80004348:	fec42783          	lw	a5,-20(s0)
    8000434c:	a809                	j	8000435e <bmap+0x172>
  }

  panic("bmap: out of range");
    8000434e:	00007517          	auipc	a0,0x7
    80004352:	20250513          	addi	a0,a0,514 # 8000b550 <etext+0x550>
    80004356:	00005097          	auipc	ra,0x5
    8000435a:	be0080e7          	jalr	-1056(ra) # 80008f36 <panic>
}
    8000435e:	853e                	mv	a0,a5
    80004360:	70e2                	ld	ra,56(sp)
    80004362:	7442                	ld	s0,48(sp)
    80004364:	6121                	addi	sp,sp,64
    80004366:	8082                	ret

0000000080004368 <itrunc>:

// Truncate inode (discard contents).
// Caller must hold ip->lock.
void
itrunc(struct inode *ip)
{
    80004368:	7139                	addi	sp,sp,-64
    8000436a:	fc06                	sd	ra,56(sp)
    8000436c:	f822                	sd	s0,48(sp)
    8000436e:	0080                	addi	s0,sp,64
    80004370:	fca43423          	sd	a0,-56(s0)
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    80004374:	fe042623          	sw	zero,-20(s0)
    80004378:	a899                	j	800043ce <itrunc+0x66>
    if(ip->addrs[i]){
    8000437a:	fc843703          	ld	a4,-56(s0)
    8000437e:	fec42783          	lw	a5,-20(s0)
    80004382:	07d1                	addi	a5,a5,20
    80004384:	078a                	slli	a5,a5,0x2
    80004386:	97ba                	add	a5,a5,a4
    80004388:	439c                	lw	a5,0(a5)
    8000438a:	cf8d                	beqz	a5,800043c4 <itrunc+0x5c>
      bfree(ip->dev, ip->addrs[i]);
    8000438c:	fc843783          	ld	a5,-56(s0)
    80004390:	439c                	lw	a5,0(a5)
    80004392:	0007869b          	sext.w	a3,a5
    80004396:	fc843703          	ld	a4,-56(s0)
    8000439a:	fec42783          	lw	a5,-20(s0)
    8000439e:	07d1                	addi	a5,a5,20
    800043a0:	078a                	slli	a5,a5,0x2
    800043a2:	97ba                	add	a5,a5,a4
    800043a4:	439c                	lw	a5,0(a5)
    800043a6:	85be                	mv	a1,a5
    800043a8:	8536                	mv	a0,a3
    800043aa:	fffff097          	auipc	ra,0xfffff
    800043ae:	6d4080e7          	jalr	1748(ra) # 80003a7e <bfree>
      ip->addrs[i] = 0;
    800043b2:	fc843703          	ld	a4,-56(s0)
    800043b6:	fec42783          	lw	a5,-20(s0)
    800043ba:	07d1                	addi	a5,a5,20
    800043bc:	078a                	slli	a5,a5,0x2
    800043be:	97ba                	add	a5,a5,a4
    800043c0:	0007a023          	sw	zero,0(a5)
  for(i = 0; i < NDIRECT; i++){
    800043c4:	fec42783          	lw	a5,-20(s0)
    800043c8:	2785                	addiw	a5,a5,1
    800043ca:	fef42623          	sw	a5,-20(s0)
    800043ce:	fec42783          	lw	a5,-20(s0)
    800043d2:	0007871b          	sext.w	a4,a5
    800043d6:	47ad                	li	a5,11
    800043d8:	fae7d1e3          	bge	a5,a4,8000437a <itrunc+0x12>
    }
  }

  if(ip->addrs[NDIRECT]){
    800043dc:	fc843783          	ld	a5,-56(s0)
    800043e0:	0807a783          	lw	a5,128(a5)
    800043e4:	cbc5                	beqz	a5,80004494 <itrunc+0x12c>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    800043e6:	fc843783          	ld	a5,-56(s0)
    800043ea:	4398                	lw	a4,0(a5)
    800043ec:	fc843783          	ld	a5,-56(s0)
    800043f0:	0807a783          	lw	a5,128(a5)
    800043f4:	85be                	mv	a1,a5
    800043f6:	853a                	mv	a0,a4
    800043f8:	fffff097          	auipc	ra,0xfffff
    800043fc:	194080e7          	jalr	404(ra) # 8000358c <bread>
    80004400:	fea43023          	sd	a0,-32(s0)
    a = (uint*)bp->data;
    80004404:	fe043783          	ld	a5,-32(s0)
    80004408:	05878793          	addi	a5,a5,88
    8000440c:	fcf43c23          	sd	a5,-40(s0)
    for(j = 0; j < NINDIRECT; j++){
    80004410:	fe042423          	sw	zero,-24(s0)
    80004414:	a081                	j	80004454 <itrunc+0xec>
      if(a[j])
    80004416:	fe842783          	lw	a5,-24(s0)
    8000441a:	078a                	slli	a5,a5,0x2
    8000441c:	fd843703          	ld	a4,-40(s0)
    80004420:	97ba                	add	a5,a5,a4
    80004422:	439c                	lw	a5,0(a5)
    80004424:	c39d                	beqz	a5,8000444a <itrunc+0xe2>
        bfree(ip->dev, a[j]);
    80004426:	fc843783          	ld	a5,-56(s0)
    8000442a:	439c                	lw	a5,0(a5)
    8000442c:	0007869b          	sext.w	a3,a5
    80004430:	fe842783          	lw	a5,-24(s0)
    80004434:	078a                	slli	a5,a5,0x2
    80004436:	fd843703          	ld	a4,-40(s0)
    8000443a:	97ba                	add	a5,a5,a4
    8000443c:	439c                	lw	a5,0(a5)
    8000443e:	85be                	mv	a1,a5
    80004440:	8536                	mv	a0,a3
    80004442:	fffff097          	auipc	ra,0xfffff
    80004446:	63c080e7          	jalr	1596(ra) # 80003a7e <bfree>
    for(j = 0; j < NINDIRECT; j++){
    8000444a:	fe842783          	lw	a5,-24(s0)
    8000444e:	2785                	addiw	a5,a5,1
    80004450:	fef42423          	sw	a5,-24(s0)
    80004454:	fe842783          	lw	a5,-24(s0)
    80004458:	873e                	mv	a4,a5
    8000445a:	0ff00793          	li	a5,255
    8000445e:	fae7fce3          	bgeu	a5,a4,80004416 <itrunc+0xae>
    }
    brelse(bp);
    80004462:	fe043503          	ld	a0,-32(s0)
    80004466:	fffff097          	auipc	ra,0xfffff
    8000446a:	1c8080e7          	jalr	456(ra) # 8000362e <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    8000446e:	fc843783          	ld	a5,-56(s0)
    80004472:	439c                	lw	a5,0(a5)
    80004474:	0007871b          	sext.w	a4,a5
    80004478:	fc843783          	ld	a5,-56(s0)
    8000447c:	0807a783          	lw	a5,128(a5)
    80004480:	85be                	mv	a1,a5
    80004482:	853a                	mv	a0,a4
    80004484:	fffff097          	auipc	ra,0xfffff
    80004488:	5fa080e7          	jalr	1530(ra) # 80003a7e <bfree>
    ip->addrs[NDIRECT] = 0;
    8000448c:	fc843783          	ld	a5,-56(s0)
    80004490:	0807a023          	sw	zero,128(a5)
  }

  ip->size = 0;
    80004494:	fc843783          	ld	a5,-56(s0)
    80004498:	0407a623          	sw	zero,76(a5)
  iupdate(ip);
    8000449c:	fc843503          	ld	a0,-56(s0)
    800044a0:	00000097          	auipc	ra,0x0
    800044a4:	870080e7          	jalr	-1936(ra) # 80003d10 <iupdate>
}
    800044a8:	0001                	nop
    800044aa:	70e2                	ld	ra,56(sp)
    800044ac:	7442                	ld	s0,48(sp)
    800044ae:	6121                	addi	sp,sp,64
    800044b0:	8082                	ret

00000000800044b2 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
    800044b2:	1101                	addi	sp,sp,-32
    800044b4:	ec22                	sd	s0,24(sp)
    800044b6:	1000                	addi	s0,sp,32
    800044b8:	fea43423          	sd	a0,-24(s0)
    800044bc:	feb43023          	sd	a1,-32(s0)
  st->dev = ip->dev;
    800044c0:	fe843783          	ld	a5,-24(s0)
    800044c4:	439c                	lw	a5,0(a5)
    800044c6:	0007871b          	sext.w	a4,a5
    800044ca:	fe043783          	ld	a5,-32(s0)
    800044ce:	c398                	sw	a4,0(a5)
  st->ino = ip->inum;
    800044d0:	fe843783          	ld	a5,-24(s0)
    800044d4:	43d8                	lw	a4,4(a5)
    800044d6:	fe043783          	ld	a5,-32(s0)
    800044da:	c3d8                	sw	a4,4(a5)
  st->type = ip->type;
    800044dc:	fe843783          	ld	a5,-24(s0)
    800044e0:	04479703          	lh	a4,68(a5)
    800044e4:	fe043783          	ld	a5,-32(s0)
    800044e8:	00e79423          	sh	a4,8(a5)
  st->nlink = ip->nlink;
    800044ec:	fe843783          	ld	a5,-24(s0)
    800044f0:	04a79703          	lh	a4,74(a5)
    800044f4:	fe043783          	ld	a5,-32(s0)
    800044f8:	00e79523          	sh	a4,10(a5)
  st->size = ip->size;
    800044fc:	fe843783          	ld	a5,-24(s0)
    80004500:	47fc                	lw	a5,76(a5)
    80004502:	02079713          	slli	a4,a5,0x20
    80004506:	9301                	srli	a4,a4,0x20
    80004508:	fe043783          	ld	a5,-32(s0)
    8000450c:	eb98                	sd	a4,16(a5)
}
    8000450e:	0001                	nop
    80004510:	6462                	ld	s0,24(sp)
    80004512:	6105                	addi	sp,sp,32
    80004514:	8082                	ret

0000000080004516 <readi>:
// Caller must hold ip->lock.
// If user_dst==1, then dst is a user virtual address;
// otherwise, dst is a kernel address.
int
readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
    80004516:	715d                	addi	sp,sp,-80
    80004518:	e486                	sd	ra,72(sp)
    8000451a:	e0a2                	sd	s0,64(sp)
    8000451c:	0880                	addi	s0,sp,80
    8000451e:	fca43423          	sd	a0,-56(s0)
    80004522:	87ae                	mv	a5,a1
    80004524:	fac43c23          	sd	a2,-72(s0)
    80004528:	fcf42223          	sw	a5,-60(s0)
    8000452c:	87b6                	mv	a5,a3
    8000452e:	fcf42023          	sw	a5,-64(s0)
    80004532:	87ba                	mv	a5,a4
    80004534:	faf42a23          	sw	a5,-76(s0)
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80004538:	fc843783          	ld	a5,-56(s0)
    8000453c:	47f8                	lw	a4,76(a5)
    8000453e:	fc042783          	lw	a5,-64(s0)
    80004542:	2781                	sext.w	a5,a5
    80004544:	00f76f63          	bltu	a4,a5,80004562 <readi+0x4c>
    80004548:	fc042783          	lw	a5,-64(s0)
    8000454c:	873e                	mv	a4,a5
    8000454e:	fb442783          	lw	a5,-76(s0)
    80004552:	9fb9                	addw	a5,a5,a4
    80004554:	0007871b          	sext.w	a4,a5
    80004558:	fc042783          	lw	a5,-64(s0)
    8000455c:	2781                	sext.w	a5,a5
    8000455e:	00f77463          	bgeu	a4,a5,80004566 <readi+0x50>
    return 0;
    80004562:	4781                	li	a5,0
    80004564:	a299                	j	800046aa <readi+0x194>
  if(off + n > ip->size)
    80004566:	fc042783          	lw	a5,-64(s0)
    8000456a:	873e                	mv	a4,a5
    8000456c:	fb442783          	lw	a5,-76(s0)
    80004570:	9fb9                	addw	a5,a5,a4
    80004572:	0007871b          	sext.w	a4,a5
    80004576:	fc843783          	ld	a5,-56(s0)
    8000457a:	47fc                	lw	a5,76(a5)
    8000457c:	00e7fa63          	bgeu	a5,a4,80004590 <readi+0x7a>
    n = ip->size - off;
    80004580:	fc843783          	ld	a5,-56(s0)
    80004584:	47fc                	lw	a5,76(a5)
    80004586:	fc042703          	lw	a4,-64(s0)
    8000458a:	9f99                	subw	a5,a5,a4
    8000458c:	faf42a23          	sw	a5,-76(s0)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80004590:	fe042623          	sw	zero,-20(s0)
    80004594:	a8f5                	j	80004690 <readi+0x17a>
    uint addr = bmap(ip, off/BSIZE);
    80004596:	fc042783          	lw	a5,-64(s0)
    8000459a:	00a7d79b          	srliw	a5,a5,0xa
    8000459e:	2781                	sext.w	a5,a5
    800045a0:	85be                	mv	a1,a5
    800045a2:	fc843503          	ld	a0,-56(s0)
    800045a6:	00000097          	auipc	ra,0x0
    800045aa:	c46080e7          	jalr	-954(ra) # 800041ec <bmap>
    800045ae:	87aa                	mv	a5,a0
    800045b0:	fef42423          	sw	a5,-24(s0)
    if(addr == 0)
    800045b4:	fe842783          	lw	a5,-24(s0)
    800045b8:	2781                	sext.w	a5,a5
    800045ba:	c7ed                	beqz	a5,800046a4 <readi+0x18e>
      break;
    bp = bread(ip->dev, addr);
    800045bc:	fc843783          	ld	a5,-56(s0)
    800045c0:	439c                	lw	a5,0(a5)
    800045c2:	fe842703          	lw	a4,-24(s0)
    800045c6:	85ba                	mv	a1,a4
    800045c8:	853e                	mv	a0,a5
    800045ca:	fffff097          	auipc	ra,0xfffff
    800045ce:	fc2080e7          	jalr	-62(ra) # 8000358c <bread>
    800045d2:	fea43023          	sd	a0,-32(s0)
    m = min(n - tot, BSIZE - off%BSIZE);
    800045d6:	fc042783          	lw	a5,-64(s0)
    800045da:	3ff7f793          	andi	a5,a5,1023
    800045de:	2781                	sext.w	a5,a5
    800045e0:	40000713          	li	a4,1024
    800045e4:	40f707bb          	subw	a5,a4,a5
    800045e8:	2781                	sext.w	a5,a5
    800045ea:	fb442703          	lw	a4,-76(s0)
    800045ee:	86ba                	mv	a3,a4
    800045f0:	fec42703          	lw	a4,-20(s0)
    800045f4:	40e6873b          	subw	a4,a3,a4
    800045f8:	2701                	sext.w	a4,a4
    800045fa:	863a                	mv	a2,a4
    800045fc:	0007869b          	sext.w	a3,a5
    80004600:	0006071b          	sext.w	a4,a2
    80004604:	00d77363          	bgeu	a4,a3,8000460a <readi+0xf4>
    80004608:	87b2                	mv	a5,a2
    8000460a:	fcf42e23          	sw	a5,-36(s0)
    if(either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    8000460e:	fe043783          	ld	a5,-32(s0)
    80004612:	05878713          	addi	a4,a5,88
    80004616:	fc046783          	lwu	a5,-64(s0)
    8000461a:	3ff7f793          	andi	a5,a5,1023
    8000461e:	973e                	add	a4,a4,a5
    80004620:	fdc46683          	lwu	a3,-36(s0)
    80004624:	fc442783          	lw	a5,-60(s0)
    80004628:	863a                	mv	a2,a4
    8000462a:	fb843583          	ld	a1,-72(s0)
    8000462e:	853e                	mv	a0,a5
    80004630:	ffffe097          	auipc	ra,0xffffe
    80004634:	dd4080e7          	jalr	-556(ra) # 80002404 <either_copyout>
    80004638:	87aa                	mv	a5,a0
    8000463a:	873e                	mv	a4,a5
    8000463c:	57fd                	li	a5,-1
    8000463e:	00f71c63          	bne	a4,a5,80004656 <readi+0x140>
      brelse(bp);
    80004642:	fe043503          	ld	a0,-32(s0)
    80004646:	fffff097          	auipc	ra,0xfffff
    8000464a:	fe8080e7          	jalr	-24(ra) # 8000362e <brelse>
      tot = -1;
    8000464e:	57fd                	li	a5,-1
    80004650:	fef42623          	sw	a5,-20(s0)
      break;
    80004654:	a889                	j	800046a6 <readi+0x190>
    }
    brelse(bp);
    80004656:	fe043503          	ld	a0,-32(s0)
    8000465a:	fffff097          	auipc	ra,0xfffff
    8000465e:	fd4080e7          	jalr	-44(ra) # 8000362e <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80004662:	fec42783          	lw	a5,-20(s0)
    80004666:	873e                	mv	a4,a5
    80004668:	fdc42783          	lw	a5,-36(s0)
    8000466c:	9fb9                	addw	a5,a5,a4
    8000466e:	fef42623          	sw	a5,-20(s0)
    80004672:	fc042783          	lw	a5,-64(s0)
    80004676:	873e                	mv	a4,a5
    80004678:	fdc42783          	lw	a5,-36(s0)
    8000467c:	9fb9                	addw	a5,a5,a4
    8000467e:	fcf42023          	sw	a5,-64(s0)
    80004682:	fdc46783          	lwu	a5,-36(s0)
    80004686:	fb843703          	ld	a4,-72(s0)
    8000468a:	97ba                	add	a5,a5,a4
    8000468c:	faf43c23          	sd	a5,-72(s0)
    80004690:	fec42783          	lw	a5,-20(s0)
    80004694:	873e                	mv	a4,a5
    80004696:	fb442783          	lw	a5,-76(s0)
    8000469a:	2701                	sext.w	a4,a4
    8000469c:	2781                	sext.w	a5,a5
    8000469e:	eef76ce3          	bltu	a4,a5,80004596 <readi+0x80>
    800046a2:	a011                	j	800046a6 <readi+0x190>
      break;
    800046a4:	0001                	nop
  }
  return tot;
    800046a6:	fec42783          	lw	a5,-20(s0)
}
    800046aa:	853e                	mv	a0,a5
    800046ac:	60a6                	ld	ra,72(sp)
    800046ae:	6406                	ld	s0,64(sp)
    800046b0:	6161                	addi	sp,sp,80
    800046b2:	8082                	ret

00000000800046b4 <writei>:
// Returns the number of bytes successfully written.
// If the return value is less than the requested n,
// there was an error of some kind.
int
writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
    800046b4:	715d                	addi	sp,sp,-80
    800046b6:	e486                	sd	ra,72(sp)
    800046b8:	e0a2                	sd	s0,64(sp)
    800046ba:	0880                	addi	s0,sp,80
    800046bc:	fca43423          	sd	a0,-56(s0)
    800046c0:	87ae                	mv	a5,a1
    800046c2:	fac43c23          	sd	a2,-72(s0)
    800046c6:	fcf42223          	sw	a5,-60(s0)
    800046ca:	87b6                	mv	a5,a3
    800046cc:	fcf42023          	sw	a5,-64(s0)
    800046d0:	87ba                	mv	a5,a4
    800046d2:	faf42a23          	sw	a5,-76(s0)
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    800046d6:	fc843783          	ld	a5,-56(s0)
    800046da:	47f8                	lw	a4,76(a5)
    800046dc:	fc042783          	lw	a5,-64(s0)
    800046e0:	2781                	sext.w	a5,a5
    800046e2:	00f76f63          	bltu	a4,a5,80004700 <writei+0x4c>
    800046e6:	fc042783          	lw	a5,-64(s0)
    800046ea:	873e                	mv	a4,a5
    800046ec:	fb442783          	lw	a5,-76(s0)
    800046f0:	9fb9                	addw	a5,a5,a4
    800046f2:	0007871b          	sext.w	a4,a5
    800046f6:	fc042783          	lw	a5,-64(s0)
    800046fa:	2781                	sext.w	a5,a5
    800046fc:	00f77463          	bgeu	a4,a5,80004704 <writei+0x50>
    return -1;
    80004700:	57fd                	li	a5,-1
    80004702:	a295                	j	80004866 <writei+0x1b2>
  if(off + n > MAXFILE*BSIZE)
    80004704:	fc042783          	lw	a5,-64(s0)
    80004708:	873e                	mv	a4,a5
    8000470a:	fb442783          	lw	a5,-76(s0)
    8000470e:	9fb9                	addw	a5,a5,a4
    80004710:	2781                	sext.w	a5,a5
    80004712:	873e                	mv	a4,a5
    80004714:	000437b7          	lui	a5,0x43
    80004718:	00e7f463          	bgeu	a5,a4,80004720 <writei+0x6c>
    return -1;
    8000471c:	57fd                	li	a5,-1
    8000471e:	a2a1                	j	80004866 <writei+0x1b2>

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80004720:	fe042623          	sw	zero,-20(s0)
    80004724:	a209                	j	80004826 <writei+0x172>
    uint addr = bmap(ip, off/BSIZE);
    80004726:	fc042783          	lw	a5,-64(s0)
    8000472a:	00a7d79b          	srliw	a5,a5,0xa
    8000472e:	2781                	sext.w	a5,a5
    80004730:	85be                	mv	a1,a5
    80004732:	fc843503          	ld	a0,-56(s0)
    80004736:	00000097          	auipc	ra,0x0
    8000473a:	ab6080e7          	jalr	-1354(ra) # 800041ec <bmap>
    8000473e:	87aa                	mv	a5,a0
    80004740:	fef42423          	sw	a5,-24(s0)
    if(addr == 0)
    80004744:	fe842783          	lw	a5,-24(s0)
    80004748:	2781                	sext.w	a5,a5
    8000474a:	cbe5                	beqz	a5,8000483a <writei+0x186>
      break;
    bp = bread(ip->dev, addr);
    8000474c:	fc843783          	ld	a5,-56(s0)
    80004750:	439c                	lw	a5,0(a5)
    80004752:	fe842703          	lw	a4,-24(s0)
    80004756:	85ba                	mv	a1,a4
    80004758:	853e                	mv	a0,a5
    8000475a:	fffff097          	auipc	ra,0xfffff
    8000475e:	e32080e7          	jalr	-462(ra) # 8000358c <bread>
    80004762:	fea43023          	sd	a0,-32(s0)
    m = min(n - tot, BSIZE - off%BSIZE);
    80004766:	fc042783          	lw	a5,-64(s0)
    8000476a:	3ff7f793          	andi	a5,a5,1023
    8000476e:	2781                	sext.w	a5,a5
    80004770:	40000713          	li	a4,1024
    80004774:	40f707bb          	subw	a5,a4,a5
    80004778:	2781                	sext.w	a5,a5
    8000477a:	fb442703          	lw	a4,-76(s0)
    8000477e:	86ba                	mv	a3,a4
    80004780:	fec42703          	lw	a4,-20(s0)
    80004784:	40e6873b          	subw	a4,a3,a4
    80004788:	2701                	sext.w	a4,a4
    8000478a:	863a                	mv	a2,a4
    8000478c:	0007869b          	sext.w	a3,a5
    80004790:	0006071b          	sext.w	a4,a2
    80004794:	00d77363          	bgeu	a4,a3,8000479a <writei+0xe6>
    80004798:	87b2                	mv	a5,a2
    8000479a:	fcf42e23          	sw	a5,-36(s0)
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    8000479e:	fe043783          	ld	a5,-32(s0)
    800047a2:	05878713          	addi	a4,a5,88 # 43058 <_entry-0x7ffbcfa8>
    800047a6:	fc046783          	lwu	a5,-64(s0)
    800047aa:	3ff7f793          	andi	a5,a5,1023
    800047ae:	97ba                	add	a5,a5,a4
    800047b0:	fdc46683          	lwu	a3,-36(s0)
    800047b4:	fc442703          	lw	a4,-60(s0)
    800047b8:	fb843603          	ld	a2,-72(s0)
    800047bc:	85ba                	mv	a1,a4
    800047be:	853e                	mv	a0,a5
    800047c0:	ffffe097          	auipc	ra,0xffffe
    800047c4:	cb8080e7          	jalr	-840(ra) # 80002478 <either_copyin>
    800047c8:	87aa                	mv	a5,a0
    800047ca:	873e                	mv	a4,a5
    800047cc:	57fd                	li	a5,-1
    800047ce:	00f71963          	bne	a4,a5,800047e0 <writei+0x12c>
      brelse(bp);
    800047d2:	fe043503          	ld	a0,-32(s0)
    800047d6:	fffff097          	auipc	ra,0xfffff
    800047da:	e58080e7          	jalr	-424(ra) # 8000362e <brelse>
      break;
    800047de:	a8b9                	j	8000483c <writei+0x188>
    }
    log_write(bp);
    800047e0:	fe043503          	ld	a0,-32(s0)
    800047e4:	00001097          	auipc	ra,0x1
    800047e8:	aee080e7          	jalr	-1298(ra) # 800052d2 <log_write>
    brelse(bp);
    800047ec:	fe043503          	ld	a0,-32(s0)
    800047f0:	fffff097          	auipc	ra,0xfffff
    800047f4:	e3e080e7          	jalr	-450(ra) # 8000362e <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    800047f8:	fec42783          	lw	a5,-20(s0)
    800047fc:	873e                	mv	a4,a5
    800047fe:	fdc42783          	lw	a5,-36(s0)
    80004802:	9fb9                	addw	a5,a5,a4
    80004804:	fef42623          	sw	a5,-20(s0)
    80004808:	fc042783          	lw	a5,-64(s0)
    8000480c:	873e                	mv	a4,a5
    8000480e:	fdc42783          	lw	a5,-36(s0)
    80004812:	9fb9                	addw	a5,a5,a4
    80004814:	fcf42023          	sw	a5,-64(s0)
    80004818:	fdc46783          	lwu	a5,-36(s0)
    8000481c:	fb843703          	ld	a4,-72(s0)
    80004820:	97ba                	add	a5,a5,a4
    80004822:	faf43c23          	sd	a5,-72(s0)
    80004826:	fec42783          	lw	a5,-20(s0)
    8000482a:	873e                	mv	a4,a5
    8000482c:	fb442783          	lw	a5,-76(s0)
    80004830:	2701                	sext.w	a4,a4
    80004832:	2781                	sext.w	a5,a5
    80004834:	eef769e3          	bltu	a4,a5,80004726 <writei+0x72>
    80004838:	a011                	j	8000483c <writei+0x188>
      break;
    8000483a:	0001                	nop
  }

  if(off > ip->size)
    8000483c:	fc843783          	ld	a5,-56(s0)
    80004840:	47f8                	lw	a4,76(a5)
    80004842:	fc042783          	lw	a5,-64(s0)
    80004846:	2781                	sext.w	a5,a5
    80004848:	00f77763          	bgeu	a4,a5,80004856 <writei+0x1a2>
    ip->size = off;
    8000484c:	fc843783          	ld	a5,-56(s0)
    80004850:	fc042703          	lw	a4,-64(s0)
    80004854:	c7f8                	sw	a4,76(a5)

  // write the i-node back to disk even if the size didn't change
  // because the loop above might have called bmap() and added a new
  // block to ip->addrs[].
  iupdate(ip);
    80004856:	fc843503          	ld	a0,-56(s0)
    8000485a:	fffff097          	auipc	ra,0xfffff
    8000485e:	4b6080e7          	jalr	1206(ra) # 80003d10 <iupdate>

  return tot;
    80004862:	fec42783          	lw	a5,-20(s0)
}
    80004866:	853e                	mv	a0,a5
    80004868:	60a6                	ld	ra,72(sp)
    8000486a:	6406                	ld	s0,64(sp)
    8000486c:	6161                	addi	sp,sp,80
    8000486e:	8082                	ret

0000000080004870 <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
    80004870:	1101                	addi	sp,sp,-32
    80004872:	ec06                	sd	ra,24(sp)
    80004874:	e822                	sd	s0,16(sp)
    80004876:	1000                	addi	s0,sp,32
    80004878:	fea43423          	sd	a0,-24(s0)
    8000487c:	feb43023          	sd	a1,-32(s0)
  return strncmp(s, t, DIRSIZ);
    80004880:	4639                	li	a2,14
    80004882:	fe043583          	ld	a1,-32(s0)
    80004886:	fe843503          	ld	a0,-24(s0)
    8000488a:	ffffc097          	auipc	ra,0xffffc
    8000488e:	b7a080e7          	jalr	-1158(ra) # 80000404 <strncmp>
    80004892:	87aa                	mv	a5,a0
}
    80004894:	853e                	mv	a0,a5
    80004896:	60e2                	ld	ra,24(sp)
    80004898:	6442                	ld	s0,16(sp)
    8000489a:	6105                	addi	sp,sp,32
    8000489c:	8082                	ret

000000008000489e <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
    8000489e:	715d                	addi	sp,sp,-80
    800048a0:	e486                	sd	ra,72(sp)
    800048a2:	e0a2                	sd	s0,64(sp)
    800048a4:	0880                	addi	s0,sp,80
    800048a6:	fca43423          	sd	a0,-56(s0)
    800048aa:	fcb43023          	sd	a1,-64(s0)
    800048ae:	fac43c23          	sd	a2,-72(s0)
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    800048b2:	fc843783          	ld	a5,-56(s0)
    800048b6:	04479783          	lh	a5,68(a5)
    800048ba:	873e                	mv	a4,a5
    800048bc:	4785                	li	a5,1
    800048be:	00f70a63          	beq	a4,a5,800048d2 <dirlookup+0x34>
    panic("dirlookup not DIR");
    800048c2:	00007517          	auipc	a0,0x7
    800048c6:	ca650513          	addi	a0,a0,-858 # 8000b568 <etext+0x568>
    800048ca:	00004097          	auipc	ra,0x4
    800048ce:	66c080e7          	jalr	1644(ra) # 80008f36 <panic>

  for(off = 0; off < dp->size; off += sizeof(de)){
    800048d2:	fe042623          	sw	zero,-20(s0)
    800048d6:	a849                	j	80004968 <dirlookup+0xca>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800048d8:	fd840793          	addi	a5,s0,-40
    800048dc:	fec42683          	lw	a3,-20(s0)
    800048e0:	4741                	li	a4,16
    800048e2:	863e                	mv	a2,a5
    800048e4:	4581                	li	a1,0
    800048e6:	fc843503          	ld	a0,-56(s0)
    800048ea:	00000097          	auipc	ra,0x0
    800048ee:	c2c080e7          	jalr	-980(ra) # 80004516 <readi>
    800048f2:	87aa                	mv	a5,a0
    800048f4:	873e                	mv	a4,a5
    800048f6:	47c1                	li	a5,16
    800048f8:	00f70a63          	beq	a4,a5,8000490c <dirlookup+0x6e>
      panic("dirlookup read");
    800048fc:	00007517          	auipc	a0,0x7
    80004900:	c8450513          	addi	a0,a0,-892 # 8000b580 <etext+0x580>
    80004904:	00004097          	auipc	ra,0x4
    80004908:	632080e7          	jalr	1586(ra) # 80008f36 <panic>
    if(de.inum == 0)
    8000490c:	fd845783          	lhu	a5,-40(s0)
    80004910:	c7b1                	beqz	a5,8000495c <dirlookup+0xbe>
      continue;
    if(namecmp(name, de.name) == 0){
    80004912:	fd840793          	addi	a5,s0,-40
    80004916:	0789                	addi	a5,a5,2
    80004918:	85be                	mv	a1,a5
    8000491a:	fc043503          	ld	a0,-64(s0)
    8000491e:	00000097          	auipc	ra,0x0
    80004922:	f52080e7          	jalr	-174(ra) # 80004870 <namecmp>
    80004926:	87aa                	mv	a5,a0
    80004928:	eb9d                	bnez	a5,8000495e <dirlookup+0xc0>
      // entry matches path element
      if(poff)
    8000492a:	fb843783          	ld	a5,-72(s0)
    8000492e:	c791                	beqz	a5,8000493a <dirlookup+0x9c>
        *poff = off;
    80004930:	fb843783          	ld	a5,-72(s0)
    80004934:	fec42703          	lw	a4,-20(s0)
    80004938:	c398                	sw	a4,0(a5)
      inum = de.inum;
    8000493a:	fd845783          	lhu	a5,-40(s0)
    8000493e:	fef42423          	sw	a5,-24(s0)
      return iget(dp->dev, inum);
    80004942:	fc843783          	ld	a5,-56(s0)
    80004946:	439c                	lw	a5,0(a5)
    80004948:	fe842703          	lw	a4,-24(s0)
    8000494c:	85ba                	mv	a1,a4
    8000494e:	853e                	mv	a0,a5
    80004950:	fffff097          	auipc	ra,0xfffff
    80004954:	4a8080e7          	jalr	1192(ra) # 80003df8 <iget>
    80004958:	87aa                	mv	a5,a0
    8000495a:	a005                	j	8000497a <dirlookup+0xdc>
      continue;
    8000495c:	0001                	nop
  for(off = 0; off < dp->size; off += sizeof(de)){
    8000495e:	fec42783          	lw	a5,-20(s0)
    80004962:	27c1                	addiw	a5,a5,16
    80004964:	fef42623          	sw	a5,-20(s0)
    80004968:	fc843783          	ld	a5,-56(s0)
    8000496c:	47f8                	lw	a4,76(a5)
    8000496e:	fec42783          	lw	a5,-20(s0)
    80004972:	2781                	sext.w	a5,a5
    80004974:	f6e7e2e3          	bltu	a5,a4,800048d8 <dirlookup+0x3a>
    }
  }

  return 0;
    80004978:	4781                	li	a5,0
}
    8000497a:	853e                	mv	a0,a5
    8000497c:	60a6                	ld	ra,72(sp)
    8000497e:	6406                	ld	s0,64(sp)
    80004980:	6161                	addi	sp,sp,80
    80004982:	8082                	ret

0000000080004984 <dirlink>:

// Write a new directory entry (name, inum) into the directory dp.
// Returns 0 on success, -1 on failure (e.g. out of disk blocks).
int
dirlink(struct inode *dp, char *name, uint inum)
{
    80004984:	715d                	addi	sp,sp,-80
    80004986:	e486                	sd	ra,72(sp)
    80004988:	e0a2                	sd	s0,64(sp)
    8000498a:	0880                	addi	s0,sp,80
    8000498c:	fca43423          	sd	a0,-56(s0)
    80004990:	fcb43023          	sd	a1,-64(s0)
    80004994:	87b2                	mv	a5,a2
    80004996:	faf42e23          	sw	a5,-68(s0)
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    8000499a:	4601                	li	a2,0
    8000499c:	fc043583          	ld	a1,-64(s0)
    800049a0:	fc843503          	ld	a0,-56(s0)
    800049a4:	00000097          	auipc	ra,0x0
    800049a8:	efa080e7          	jalr	-262(ra) # 8000489e <dirlookup>
    800049ac:	fea43023          	sd	a0,-32(s0)
    800049b0:	fe043783          	ld	a5,-32(s0)
    800049b4:	cb89                	beqz	a5,800049c6 <dirlink+0x42>
    iput(ip);
    800049b6:	fe043503          	ld	a0,-32(s0)
    800049ba:	fffff097          	auipc	ra,0xfffff
    800049be:	734080e7          	jalr	1844(ra) # 800040ee <iput>
    return -1;
    800049c2:	57fd                	li	a5,-1
    800049c4:	a075                	j	80004a70 <dirlink+0xec>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
    800049c6:	fe042623          	sw	zero,-20(s0)
    800049ca:	a0a1                	j	80004a12 <dirlink+0x8e>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800049cc:	fd040793          	addi	a5,s0,-48
    800049d0:	fec42683          	lw	a3,-20(s0)
    800049d4:	4741                	li	a4,16
    800049d6:	863e                	mv	a2,a5
    800049d8:	4581                	li	a1,0
    800049da:	fc843503          	ld	a0,-56(s0)
    800049de:	00000097          	auipc	ra,0x0
    800049e2:	b38080e7          	jalr	-1224(ra) # 80004516 <readi>
    800049e6:	87aa                	mv	a5,a0
    800049e8:	873e                	mv	a4,a5
    800049ea:	47c1                	li	a5,16
    800049ec:	00f70a63          	beq	a4,a5,80004a00 <dirlink+0x7c>
      panic("dirlink read");
    800049f0:	00007517          	auipc	a0,0x7
    800049f4:	ba050513          	addi	a0,a0,-1120 # 8000b590 <etext+0x590>
    800049f8:	00004097          	auipc	ra,0x4
    800049fc:	53e080e7          	jalr	1342(ra) # 80008f36 <panic>
    if(de.inum == 0)
    80004a00:	fd045783          	lhu	a5,-48(s0)
    80004a04:	cf99                	beqz	a5,80004a22 <dirlink+0x9e>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80004a06:	fec42783          	lw	a5,-20(s0)
    80004a0a:	27c1                	addiw	a5,a5,16
    80004a0c:	2781                	sext.w	a5,a5
    80004a0e:	fef42623          	sw	a5,-20(s0)
    80004a12:	fc843783          	ld	a5,-56(s0)
    80004a16:	47f8                	lw	a4,76(a5)
    80004a18:	fec42783          	lw	a5,-20(s0)
    80004a1c:	fae7e8e3          	bltu	a5,a4,800049cc <dirlink+0x48>
    80004a20:	a011                	j	80004a24 <dirlink+0xa0>
      break;
    80004a22:	0001                	nop
  }

  strncpy(de.name, name, DIRSIZ);
    80004a24:	fd040793          	addi	a5,s0,-48
    80004a28:	0789                	addi	a5,a5,2
    80004a2a:	4639                	li	a2,14
    80004a2c:	fc043583          	ld	a1,-64(s0)
    80004a30:	853e                	mv	a0,a5
    80004a32:	ffffc097          	auipc	ra,0xffffc
    80004a36:	a5c080e7          	jalr	-1444(ra) # 8000048e <strncpy>
  de.inum = inum;
    80004a3a:	fbc42783          	lw	a5,-68(s0)
    80004a3e:	17c2                	slli	a5,a5,0x30
    80004a40:	93c1                	srli	a5,a5,0x30
    80004a42:	fcf41823          	sh	a5,-48(s0)
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004a46:	fd040793          	addi	a5,s0,-48
    80004a4a:	fec42683          	lw	a3,-20(s0)
    80004a4e:	4741                	li	a4,16
    80004a50:	863e                	mv	a2,a5
    80004a52:	4581                	li	a1,0
    80004a54:	fc843503          	ld	a0,-56(s0)
    80004a58:	00000097          	auipc	ra,0x0
    80004a5c:	c5c080e7          	jalr	-932(ra) # 800046b4 <writei>
    80004a60:	87aa                	mv	a5,a0
    80004a62:	873e                	mv	a4,a5
    80004a64:	47c1                	li	a5,16
    80004a66:	00f70463          	beq	a4,a5,80004a6e <dirlink+0xea>
    return -1;
    80004a6a:	57fd                	li	a5,-1
    80004a6c:	a011                	j	80004a70 <dirlink+0xec>

  return 0;
    80004a6e:	4781                	li	a5,0
}
    80004a70:	853e                	mv	a0,a5
    80004a72:	60a6                	ld	ra,72(sp)
    80004a74:	6406                	ld	s0,64(sp)
    80004a76:	6161                	addi	sp,sp,80
    80004a78:	8082                	ret

0000000080004a7a <skipelem>:
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
static char*
skipelem(char *path, char *name)
{
    80004a7a:	7179                	addi	sp,sp,-48
    80004a7c:	f406                	sd	ra,40(sp)
    80004a7e:	f022                	sd	s0,32(sp)
    80004a80:	1800                	addi	s0,sp,48
    80004a82:	fca43c23          	sd	a0,-40(s0)
    80004a86:	fcb43823          	sd	a1,-48(s0)
  char *s;
  int len;

  while(*path == '/')
    80004a8a:	a031                	j	80004a96 <skipelem+0x1c>
    path++;
    80004a8c:	fd843783          	ld	a5,-40(s0)
    80004a90:	0785                	addi	a5,a5,1
    80004a92:	fcf43c23          	sd	a5,-40(s0)
  while(*path == '/')
    80004a96:	fd843783          	ld	a5,-40(s0)
    80004a9a:	0007c783          	lbu	a5,0(a5)
    80004a9e:	873e                	mv	a4,a5
    80004aa0:	02f00793          	li	a5,47
    80004aa4:	fef704e3          	beq	a4,a5,80004a8c <skipelem+0x12>
  if(*path == 0)
    80004aa8:	fd843783          	ld	a5,-40(s0)
    80004aac:	0007c783          	lbu	a5,0(a5)
    80004ab0:	e399                	bnez	a5,80004ab6 <skipelem+0x3c>
    return 0;
    80004ab2:	4781                	li	a5,0
    80004ab4:	a06d                	j	80004b5e <skipelem+0xe4>
  s = path;
    80004ab6:	fd843783          	ld	a5,-40(s0)
    80004aba:	fef43423          	sd	a5,-24(s0)
  while(*path != '/' && *path != 0)
    80004abe:	a031                	j	80004aca <skipelem+0x50>
    path++;
    80004ac0:	fd843783          	ld	a5,-40(s0)
    80004ac4:	0785                	addi	a5,a5,1
    80004ac6:	fcf43c23          	sd	a5,-40(s0)
  while(*path != '/' && *path != 0)
    80004aca:	fd843783          	ld	a5,-40(s0)
    80004ace:	0007c783          	lbu	a5,0(a5)
    80004ad2:	873e                	mv	a4,a5
    80004ad4:	02f00793          	li	a5,47
    80004ad8:	00f70763          	beq	a4,a5,80004ae6 <skipelem+0x6c>
    80004adc:	fd843783          	ld	a5,-40(s0)
    80004ae0:	0007c783          	lbu	a5,0(a5)
    80004ae4:	fff1                	bnez	a5,80004ac0 <skipelem+0x46>
  len = path - s;
    80004ae6:	fd843703          	ld	a4,-40(s0)
    80004aea:	fe843783          	ld	a5,-24(s0)
    80004aee:	40f707b3          	sub	a5,a4,a5
    80004af2:	fef42223          	sw	a5,-28(s0)
  if(len >= DIRSIZ)
    80004af6:	fe442783          	lw	a5,-28(s0)
    80004afa:	0007871b          	sext.w	a4,a5
    80004afe:	47b5                	li	a5,13
    80004b00:	00e7dc63          	bge	a5,a4,80004b18 <skipelem+0x9e>
    memmove(name, s, DIRSIZ);
    80004b04:	4639                	li	a2,14
    80004b06:	fe843583          	ld	a1,-24(s0)
    80004b0a:	fd043503          	ld	a0,-48(s0)
    80004b0e:	ffffb097          	auipc	ra,0xffffb
    80004b12:	7e2080e7          	jalr	2018(ra) # 800002f0 <memmove>
    80004b16:	a80d                	j	80004b48 <skipelem+0xce>
  else {
    memmove(name, s, len);
    80004b18:	fe442783          	lw	a5,-28(s0)
    80004b1c:	863e                	mv	a2,a5
    80004b1e:	fe843583          	ld	a1,-24(s0)
    80004b22:	fd043503          	ld	a0,-48(s0)
    80004b26:	ffffb097          	auipc	ra,0xffffb
    80004b2a:	7ca080e7          	jalr	1994(ra) # 800002f0 <memmove>
    name[len] = 0;
    80004b2e:	fe442783          	lw	a5,-28(s0)
    80004b32:	fd043703          	ld	a4,-48(s0)
    80004b36:	97ba                	add	a5,a5,a4
    80004b38:	00078023          	sb	zero,0(a5)
  }
  while(*path == '/')
    80004b3c:	a031                	j	80004b48 <skipelem+0xce>
    path++;
    80004b3e:	fd843783          	ld	a5,-40(s0)
    80004b42:	0785                	addi	a5,a5,1
    80004b44:	fcf43c23          	sd	a5,-40(s0)
  while(*path == '/')
    80004b48:	fd843783          	ld	a5,-40(s0)
    80004b4c:	0007c783          	lbu	a5,0(a5)
    80004b50:	873e                	mv	a4,a5
    80004b52:	02f00793          	li	a5,47
    80004b56:	fef704e3          	beq	a4,a5,80004b3e <skipelem+0xc4>
  return path;
    80004b5a:	fd843783          	ld	a5,-40(s0)
}
    80004b5e:	853e                	mv	a0,a5
    80004b60:	70a2                	ld	ra,40(sp)
    80004b62:	7402                	ld	s0,32(sp)
    80004b64:	6145                	addi	sp,sp,48
    80004b66:	8082                	ret

0000000080004b68 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
    80004b68:	7139                	addi	sp,sp,-64
    80004b6a:	fc06                	sd	ra,56(sp)
    80004b6c:	f822                	sd	s0,48(sp)
    80004b6e:	0080                	addi	s0,sp,64
    80004b70:	fca43c23          	sd	a0,-40(s0)
    80004b74:	87ae                	mv	a5,a1
    80004b76:	fcc43423          	sd	a2,-56(s0)
    80004b7a:	fcf42a23          	sw	a5,-44(s0)
  struct inode *ip, *next;

  if(*path == '/')
    80004b7e:	fd843783          	ld	a5,-40(s0)
    80004b82:	0007c783          	lbu	a5,0(a5)
    80004b86:	873e                	mv	a4,a5
    80004b88:	02f00793          	li	a5,47
    80004b8c:	00f71b63          	bne	a4,a5,80004ba2 <namex+0x3a>
    ip = iget(ROOTDEV, ROOTINO);
    80004b90:	4585                	li	a1,1
    80004b92:	4505                	li	a0,1
    80004b94:	fffff097          	auipc	ra,0xfffff
    80004b98:	264080e7          	jalr	612(ra) # 80003df8 <iget>
    80004b9c:	fea43423          	sd	a0,-24(s0)
    80004ba0:	a845                	j	80004c50 <namex+0xe8>
  else
    ip = idup(myproc()->cwd);
    80004ba2:	ffffd097          	auipc	ra,0xffffd
    80004ba6:	a5e080e7          	jalr	-1442(ra) # 80001600 <myproc>
    80004baa:	87aa                	mv	a5,a0
    80004bac:	1507b783          	ld	a5,336(a5)
    80004bb0:	853e                	mv	a0,a5
    80004bb2:	fffff097          	auipc	ra,0xfffff
    80004bb6:	362080e7          	jalr	866(ra) # 80003f14 <idup>
    80004bba:	fea43423          	sd	a0,-24(s0)

  while((path = skipelem(path, name)) != 0){
    80004bbe:	a849                	j	80004c50 <namex+0xe8>
    ilock(ip);
    80004bc0:	fe843503          	ld	a0,-24(s0)
    80004bc4:	fffff097          	auipc	ra,0xfffff
    80004bc8:	39c080e7          	jalr	924(ra) # 80003f60 <ilock>
    if(ip->type != T_DIR){
    80004bcc:	fe843783          	ld	a5,-24(s0)
    80004bd0:	04479783          	lh	a5,68(a5)
    80004bd4:	873e                	mv	a4,a5
    80004bd6:	4785                	li	a5,1
    80004bd8:	00f70a63          	beq	a4,a5,80004bec <namex+0x84>
      iunlockput(ip);
    80004bdc:	fe843503          	ld	a0,-24(s0)
    80004be0:	fffff097          	auipc	ra,0xfffff
    80004be4:	5de080e7          	jalr	1502(ra) # 800041be <iunlockput>
      return 0;
    80004be8:	4781                	li	a5,0
    80004bea:	a871                	j	80004c86 <namex+0x11e>
    }
    if(nameiparent && *path == '\0'){
    80004bec:	fd442783          	lw	a5,-44(s0)
    80004bf0:	2781                	sext.w	a5,a5
    80004bf2:	cf99                	beqz	a5,80004c10 <namex+0xa8>
    80004bf4:	fd843783          	ld	a5,-40(s0)
    80004bf8:	0007c783          	lbu	a5,0(a5)
    80004bfc:	eb91                	bnez	a5,80004c10 <namex+0xa8>
      // Stop one level early.
      iunlock(ip);
    80004bfe:	fe843503          	ld	a0,-24(s0)
    80004c02:	fffff097          	auipc	ra,0xfffff
    80004c06:	492080e7          	jalr	1170(ra) # 80004094 <iunlock>
      return ip;
    80004c0a:	fe843783          	ld	a5,-24(s0)
    80004c0e:	a8a5                	j	80004c86 <namex+0x11e>
    }
    if((next = dirlookup(ip, name, 0)) == 0){
    80004c10:	4601                	li	a2,0
    80004c12:	fc843583          	ld	a1,-56(s0)
    80004c16:	fe843503          	ld	a0,-24(s0)
    80004c1a:	00000097          	auipc	ra,0x0
    80004c1e:	c84080e7          	jalr	-892(ra) # 8000489e <dirlookup>
    80004c22:	fea43023          	sd	a0,-32(s0)
    80004c26:	fe043783          	ld	a5,-32(s0)
    80004c2a:	eb89                	bnez	a5,80004c3c <namex+0xd4>
      iunlockput(ip);
    80004c2c:	fe843503          	ld	a0,-24(s0)
    80004c30:	fffff097          	auipc	ra,0xfffff
    80004c34:	58e080e7          	jalr	1422(ra) # 800041be <iunlockput>
      return 0;
    80004c38:	4781                	li	a5,0
    80004c3a:	a0b1                	j	80004c86 <namex+0x11e>
    }
    iunlockput(ip);
    80004c3c:	fe843503          	ld	a0,-24(s0)
    80004c40:	fffff097          	auipc	ra,0xfffff
    80004c44:	57e080e7          	jalr	1406(ra) # 800041be <iunlockput>
    ip = next;
    80004c48:	fe043783          	ld	a5,-32(s0)
    80004c4c:	fef43423          	sd	a5,-24(s0)
  while((path = skipelem(path, name)) != 0){
    80004c50:	fc843583          	ld	a1,-56(s0)
    80004c54:	fd843503          	ld	a0,-40(s0)
    80004c58:	00000097          	auipc	ra,0x0
    80004c5c:	e22080e7          	jalr	-478(ra) # 80004a7a <skipelem>
    80004c60:	fca43c23          	sd	a0,-40(s0)
    80004c64:	fd843783          	ld	a5,-40(s0)
    80004c68:	ffa1                	bnez	a5,80004bc0 <namex+0x58>
  }
  if(nameiparent){
    80004c6a:	fd442783          	lw	a5,-44(s0)
    80004c6e:	2781                	sext.w	a5,a5
    80004c70:	cb89                	beqz	a5,80004c82 <namex+0x11a>
    iput(ip);
    80004c72:	fe843503          	ld	a0,-24(s0)
    80004c76:	fffff097          	auipc	ra,0xfffff
    80004c7a:	478080e7          	jalr	1144(ra) # 800040ee <iput>
    return 0;
    80004c7e:	4781                	li	a5,0
    80004c80:	a019                	j	80004c86 <namex+0x11e>
  }
  return ip;
    80004c82:	fe843783          	ld	a5,-24(s0)
}
    80004c86:	853e                	mv	a0,a5
    80004c88:	70e2                	ld	ra,56(sp)
    80004c8a:	7442                	ld	s0,48(sp)
    80004c8c:	6121                	addi	sp,sp,64
    80004c8e:	8082                	ret

0000000080004c90 <namei>:

struct inode*
namei(char *path)
{
    80004c90:	7179                	addi	sp,sp,-48
    80004c92:	f406                	sd	ra,40(sp)
    80004c94:	f022                	sd	s0,32(sp)
    80004c96:	1800                	addi	s0,sp,48
    80004c98:	fca43c23          	sd	a0,-40(s0)
  char name[DIRSIZ];
  return namex(path, 0, name);
    80004c9c:	fe040793          	addi	a5,s0,-32
    80004ca0:	863e                	mv	a2,a5
    80004ca2:	4581                	li	a1,0
    80004ca4:	fd843503          	ld	a0,-40(s0)
    80004ca8:	00000097          	auipc	ra,0x0
    80004cac:	ec0080e7          	jalr	-320(ra) # 80004b68 <namex>
    80004cb0:	87aa                	mv	a5,a0
}
    80004cb2:	853e                	mv	a0,a5
    80004cb4:	70a2                	ld	ra,40(sp)
    80004cb6:	7402                	ld	s0,32(sp)
    80004cb8:	6145                	addi	sp,sp,48
    80004cba:	8082                	ret

0000000080004cbc <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
    80004cbc:	1101                	addi	sp,sp,-32
    80004cbe:	ec06                	sd	ra,24(sp)
    80004cc0:	e822                	sd	s0,16(sp)
    80004cc2:	1000                	addi	s0,sp,32
    80004cc4:	fea43423          	sd	a0,-24(s0)
    80004cc8:	feb43023          	sd	a1,-32(s0)
  return namex(path, 1, name);
    80004ccc:	fe043603          	ld	a2,-32(s0)
    80004cd0:	4585                	li	a1,1
    80004cd2:	fe843503          	ld	a0,-24(s0)
    80004cd6:	00000097          	auipc	ra,0x0
    80004cda:	e92080e7          	jalr	-366(ra) # 80004b68 <namex>
    80004cde:	87aa                	mv	a5,a0
}
    80004ce0:	853e                	mv	a0,a5
    80004ce2:	60e2                	ld	ra,24(sp)
    80004ce4:	6442                	ld	s0,16(sp)
    80004ce6:	6105                	addi	sp,sp,32
    80004ce8:	8082                	ret

0000000080004cea <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev, struct superblock *sb)
{
    80004cea:	1101                	addi	sp,sp,-32
    80004cec:	ec06                	sd	ra,24(sp)
    80004cee:	e822                	sd	s0,16(sp)
    80004cf0:	1000                	addi	s0,sp,32
    80004cf2:	87aa                	mv	a5,a0
    80004cf4:	feb43023          	sd	a1,-32(s0)
    80004cf8:	fef42623          	sw	a5,-20(s0)
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  initlock(&log.lock, "log");
    80004cfc:	00007597          	auipc	a1,0x7
    80004d00:	8a458593          	addi	a1,a1,-1884 # 8000b5a0 <etext+0x5a0>
    80004d04:	00017517          	auipc	a0,0x17
    80004d08:	f6450513          	addi	a0,a0,-156 # 8001bc68 <log>
    80004d0c:	00004097          	auipc	ra,0x4
    80004d10:	642080e7          	jalr	1602(ra) # 8000934e <initlock>
  log.start = sb->logstart;
    80004d14:	fe043783          	ld	a5,-32(s0)
    80004d18:	4bdc                	lw	a5,20(a5)
    80004d1a:	0007871b          	sext.w	a4,a5
    80004d1e:	00017797          	auipc	a5,0x17
    80004d22:	f4a78793          	addi	a5,a5,-182 # 8001bc68 <log>
    80004d26:	cf98                	sw	a4,24(a5)
  log.size = sb->nlog;
    80004d28:	fe043783          	ld	a5,-32(s0)
    80004d2c:	4b9c                	lw	a5,16(a5)
    80004d2e:	0007871b          	sext.w	a4,a5
    80004d32:	00017797          	auipc	a5,0x17
    80004d36:	f3678793          	addi	a5,a5,-202 # 8001bc68 <log>
    80004d3a:	cfd8                	sw	a4,28(a5)
  log.dev = dev;
    80004d3c:	00017797          	auipc	a5,0x17
    80004d40:	f2c78793          	addi	a5,a5,-212 # 8001bc68 <log>
    80004d44:	fec42703          	lw	a4,-20(s0)
    80004d48:	d798                	sw	a4,40(a5)
  recover_from_log();
    80004d4a:	00000097          	auipc	ra,0x0
    80004d4e:	272080e7          	jalr	626(ra) # 80004fbc <recover_from_log>
}
    80004d52:	0001                	nop
    80004d54:	60e2                	ld	ra,24(sp)
    80004d56:	6442                	ld	s0,16(sp)
    80004d58:	6105                	addi	sp,sp,32
    80004d5a:	8082                	ret

0000000080004d5c <install_trans>:

// Copy committed blocks from log to their home location
static void
install_trans(int recovering)
{
    80004d5c:	7139                	addi	sp,sp,-64
    80004d5e:	fc06                	sd	ra,56(sp)
    80004d60:	f822                	sd	s0,48(sp)
    80004d62:	0080                	addi	s0,sp,64
    80004d64:	87aa                	mv	a5,a0
    80004d66:	fcf42623          	sw	a5,-52(s0)
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    80004d6a:	fe042623          	sw	zero,-20(s0)
    80004d6e:	a0f9                	j	80004e3c <install_trans+0xe0>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    80004d70:	00017797          	auipc	a5,0x17
    80004d74:	ef878793          	addi	a5,a5,-264 # 8001bc68 <log>
    80004d78:	579c                	lw	a5,40(a5)
    80004d7a:	0007871b          	sext.w	a4,a5
    80004d7e:	00017797          	auipc	a5,0x17
    80004d82:	eea78793          	addi	a5,a5,-278 # 8001bc68 <log>
    80004d86:	4f9c                	lw	a5,24(a5)
    80004d88:	fec42683          	lw	a3,-20(s0)
    80004d8c:	9fb5                	addw	a5,a5,a3
    80004d8e:	2781                	sext.w	a5,a5
    80004d90:	2785                	addiw	a5,a5,1
    80004d92:	2781                	sext.w	a5,a5
    80004d94:	2781                	sext.w	a5,a5
    80004d96:	85be                	mv	a1,a5
    80004d98:	853a                	mv	a0,a4
    80004d9a:	ffffe097          	auipc	ra,0xffffe
    80004d9e:	7f2080e7          	jalr	2034(ra) # 8000358c <bread>
    80004da2:	fea43023          	sd	a0,-32(s0)
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
    80004da6:	00017797          	auipc	a5,0x17
    80004daa:	ec278793          	addi	a5,a5,-318 # 8001bc68 <log>
    80004dae:	579c                	lw	a5,40(a5)
    80004db0:	0007869b          	sext.w	a3,a5
    80004db4:	00017717          	auipc	a4,0x17
    80004db8:	eb470713          	addi	a4,a4,-332 # 8001bc68 <log>
    80004dbc:	fec42783          	lw	a5,-20(s0)
    80004dc0:	07a1                	addi	a5,a5,8
    80004dc2:	078a                	slli	a5,a5,0x2
    80004dc4:	97ba                	add	a5,a5,a4
    80004dc6:	4b9c                	lw	a5,16(a5)
    80004dc8:	2781                	sext.w	a5,a5
    80004dca:	85be                	mv	a1,a5
    80004dcc:	8536                	mv	a0,a3
    80004dce:	ffffe097          	auipc	ra,0xffffe
    80004dd2:	7be080e7          	jalr	1982(ra) # 8000358c <bread>
    80004dd6:	fca43c23          	sd	a0,-40(s0)
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    80004dda:	fd843783          	ld	a5,-40(s0)
    80004dde:	05878713          	addi	a4,a5,88
    80004de2:	fe043783          	ld	a5,-32(s0)
    80004de6:	05878793          	addi	a5,a5,88
    80004dea:	40000613          	li	a2,1024
    80004dee:	85be                	mv	a1,a5
    80004df0:	853a                	mv	a0,a4
    80004df2:	ffffb097          	auipc	ra,0xffffb
    80004df6:	4fe080e7          	jalr	1278(ra) # 800002f0 <memmove>
    bwrite(dbuf);  // write dst to disk
    80004dfa:	fd843503          	ld	a0,-40(s0)
    80004dfe:	ffffe097          	auipc	ra,0xffffe
    80004e02:	7e8080e7          	jalr	2024(ra) # 800035e6 <bwrite>
    if(recovering == 0)
    80004e06:	fcc42783          	lw	a5,-52(s0)
    80004e0a:	2781                	sext.w	a5,a5
    80004e0c:	e799                	bnez	a5,80004e1a <install_trans+0xbe>
      bunpin(dbuf);
    80004e0e:	fd843503          	ld	a0,-40(s0)
    80004e12:	fffff097          	auipc	ra,0xfffff
    80004e16:	952080e7          	jalr	-1710(ra) # 80003764 <bunpin>
    brelse(lbuf);
    80004e1a:	fe043503          	ld	a0,-32(s0)
    80004e1e:	fffff097          	auipc	ra,0xfffff
    80004e22:	810080e7          	jalr	-2032(ra) # 8000362e <brelse>
    brelse(dbuf);
    80004e26:	fd843503          	ld	a0,-40(s0)
    80004e2a:	fffff097          	auipc	ra,0xfffff
    80004e2e:	804080e7          	jalr	-2044(ra) # 8000362e <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80004e32:	fec42783          	lw	a5,-20(s0)
    80004e36:	2785                	addiw	a5,a5,1
    80004e38:	fef42623          	sw	a5,-20(s0)
    80004e3c:	00017797          	auipc	a5,0x17
    80004e40:	e2c78793          	addi	a5,a5,-468 # 8001bc68 <log>
    80004e44:	57d8                	lw	a4,44(a5)
    80004e46:	fec42783          	lw	a5,-20(s0)
    80004e4a:	2781                	sext.w	a5,a5
    80004e4c:	f2e7c2e3          	blt	a5,a4,80004d70 <install_trans+0x14>
  }
}
    80004e50:	0001                	nop
    80004e52:	0001                	nop
    80004e54:	70e2                	ld	ra,56(sp)
    80004e56:	7442                	ld	s0,48(sp)
    80004e58:	6121                	addi	sp,sp,64
    80004e5a:	8082                	ret

0000000080004e5c <read_head>:

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
    80004e5c:	7179                	addi	sp,sp,-48
    80004e5e:	f406                	sd	ra,40(sp)
    80004e60:	f022                	sd	s0,32(sp)
    80004e62:	1800                	addi	s0,sp,48
  struct buf *buf = bread(log.dev, log.start);
    80004e64:	00017797          	auipc	a5,0x17
    80004e68:	e0478793          	addi	a5,a5,-508 # 8001bc68 <log>
    80004e6c:	579c                	lw	a5,40(a5)
    80004e6e:	0007871b          	sext.w	a4,a5
    80004e72:	00017797          	auipc	a5,0x17
    80004e76:	df678793          	addi	a5,a5,-522 # 8001bc68 <log>
    80004e7a:	4f9c                	lw	a5,24(a5)
    80004e7c:	2781                	sext.w	a5,a5
    80004e7e:	85be                	mv	a1,a5
    80004e80:	853a                	mv	a0,a4
    80004e82:	ffffe097          	auipc	ra,0xffffe
    80004e86:	70a080e7          	jalr	1802(ra) # 8000358c <bread>
    80004e8a:	fea43023          	sd	a0,-32(s0)
  struct logheader *lh = (struct logheader *) (buf->data);
    80004e8e:	fe043783          	ld	a5,-32(s0)
    80004e92:	05878793          	addi	a5,a5,88
    80004e96:	fcf43c23          	sd	a5,-40(s0)
  int i;
  log.lh.n = lh->n;
    80004e9a:	fd843783          	ld	a5,-40(s0)
    80004e9e:	4398                	lw	a4,0(a5)
    80004ea0:	00017797          	auipc	a5,0x17
    80004ea4:	dc878793          	addi	a5,a5,-568 # 8001bc68 <log>
    80004ea8:	d7d8                	sw	a4,44(a5)
  for (i = 0; i < log.lh.n; i++) {
    80004eaa:	fe042623          	sw	zero,-20(s0)
    80004eae:	a03d                	j	80004edc <read_head+0x80>
    log.lh.block[i] = lh->block[i];
    80004eb0:	fd843703          	ld	a4,-40(s0)
    80004eb4:	fec42783          	lw	a5,-20(s0)
    80004eb8:	078a                	slli	a5,a5,0x2
    80004eba:	97ba                	add	a5,a5,a4
    80004ebc:	43d8                	lw	a4,4(a5)
    80004ebe:	00017697          	auipc	a3,0x17
    80004ec2:	daa68693          	addi	a3,a3,-598 # 8001bc68 <log>
    80004ec6:	fec42783          	lw	a5,-20(s0)
    80004eca:	07a1                	addi	a5,a5,8
    80004ecc:	078a                	slli	a5,a5,0x2
    80004ece:	97b6                	add	a5,a5,a3
    80004ed0:	cb98                	sw	a4,16(a5)
  for (i = 0; i < log.lh.n; i++) {
    80004ed2:	fec42783          	lw	a5,-20(s0)
    80004ed6:	2785                	addiw	a5,a5,1
    80004ed8:	fef42623          	sw	a5,-20(s0)
    80004edc:	00017797          	auipc	a5,0x17
    80004ee0:	d8c78793          	addi	a5,a5,-628 # 8001bc68 <log>
    80004ee4:	57d8                	lw	a4,44(a5)
    80004ee6:	fec42783          	lw	a5,-20(s0)
    80004eea:	2781                	sext.w	a5,a5
    80004eec:	fce7c2e3          	blt	a5,a4,80004eb0 <read_head+0x54>
  }
  brelse(buf);
    80004ef0:	fe043503          	ld	a0,-32(s0)
    80004ef4:	ffffe097          	auipc	ra,0xffffe
    80004ef8:	73a080e7          	jalr	1850(ra) # 8000362e <brelse>
}
    80004efc:	0001                	nop
    80004efe:	70a2                	ld	ra,40(sp)
    80004f00:	7402                	ld	s0,32(sp)
    80004f02:	6145                	addi	sp,sp,48
    80004f04:	8082                	ret

0000000080004f06 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
    80004f06:	7179                	addi	sp,sp,-48
    80004f08:	f406                	sd	ra,40(sp)
    80004f0a:	f022                	sd	s0,32(sp)
    80004f0c:	1800                	addi	s0,sp,48
  struct buf *buf = bread(log.dev, log.start);
    80004f0e:	00017797          	auipc	a5,0x17
    80004f12:	d5a78793          	addi	a5,a5,-678 # 8001bc68 <log>
    80004f16:	579c                	lw	a5,40(a5)
    80004f18:	0007871b          	sext.w	a4,a5
    80004f1c:	00017797          	auipc	a5,0x17
    80004f20:	d4c78793          	addi	a5,a5,-692 # 8001bc68 <log>
    80004f24:	4f9c                	lw	a5,24(a5)
    80004f26:	2781                	sext.w	a5,a5
    80004f28:	85be                	mv	a1,a5
    80004f2a:	853a                	mv	a0,a4
    80004f2c:	ffffe097          	auipc	ra,0xffffe
    80004f30:	660080e7          	jalr	1632(ra) # 8000358c <bread>
    80004f34:	fea43023          	sd	a0,-32(s0)
  struct logheader *hb = (struct logheader *) (buf->data);
    80004f38:	fe043783          	ld	a5,-32(s0)
    80004f3c:	05878793          	addi	a5,a5,88
    80004f40:	fcf43c23          	sd	a5,-40(s0)
  int i;
  hb->n = log.lh.n;
    80004f44:	00017797          	auipc	a5,0x17
    80004f48:	d2478793          	addi	a5,a5,-732 # 8001bc68 <log>
    80004f4c:	57d8                	lw	a4,44(a5)
    80004f4e:	fd843783          	ld	a5,-40(s0)
    80004f52:	c398                	sw	a4,0(a5)
  for (i = 0; i < log.lh.n; i++) {
    80004f54:	fe042623          	sw	zero,-20(s0)
    80004f58:	a03d                	j	80004f86 <write_head+0x80>
    hb->block[i] = log.lh.block[i];
    80004f5a:	00017717          	auipc	a4,0x17
    80004f5e:	d0e70713          	addi	a4,a4,-754 # 8001bc68 <log>
    80004f62:	fec42783          	lw	a5,-20(s0)
    80004f66:	07a1                	addi	a5,a5,8
    80004f68:	078a                	slli	a5,a5,0x2
    80004f6a:	97ba                	add	a5,a5,a4
    80004f6c:	4b98                	lw	a4,16(a5)
    80004f6e:	fd843683          	ld	a3,-40(s0)
    80004f72:	fec42783          	lw	a5,-20(s0)
    80004f76:	078a                	slli	a5,a5,0x2
    80004f78:	97b6                	add	a5,a5,a3
    80004f7a:	c3d8                	sw	a4,4(a5)
  for (i = 0; i < log.lh.n; i++) {
    80004f7c:	fec42783          	lw	a5,-20(s0)
    80004f80:	2785                	addiw	a5,a5,1
    80004f82:	fef42623          	sw	a5,-20(s0)
    80004f86:	00017797          	auipc	a5,0x17
    80004f8a:	ce278793          	addi	a5,a5,-798 # 8001bc68 <log>
    80004f8e:	57d8                	lw	a4,44(a5)
    80004f90:	fec42783          	lw	a5,-20(s0)
    80004f94:	2781                	sext.w	a5,a5
    80004f96:	fce7c2e3          	blt	a5,a4,80004f5a <write_head+0x54>
  }
  bwrite(buf);
    80004f9a:	fe043503          	ld	a0,-32(s0)
    80004f9e:	ffffe097          	auipc	ra,0xffffe
    80004fa2:	648080e7          	jalr	1608(ra) # 800035e6 <bwrite>
  brelse(buf);
    80004fa6:	fe043503          	ld	a0,-32(s0)
    80004faa:	ffffe097          	auipc	ra,0xffffe
    80004fae:	684080e7          	jalr	1668(ra) # 8000362e <brelse>
}
    80004fb2:	0001                	nop
    80004fb4:	70a2                	ld	ra,40(sp)
    80004fb6:	7402                	ld	s0,32(sp)
    80004fb8:	6145                	addi	sp,sp,48
    80004fba:	8082                	ret

0000000080004fbc <recover_from_log>:

static void
recover_from_log(void)
{
    80004fbc:	1141                	addi	sp,sp,-16
    80004fbe:	e406                	sd	ra,8(sp)
    80004fc0:	e022                	sd	s0,0(sp)
    80004fc2:	0800                	addi	s0,sp,16
  read_head();
    80004fc4:	00000097          	auipc	ra,0x0
    80004fc8:	e98080e7          	jalr	-360(ra) # 80004e5c <read_head>
  install_trans(1); // if committed, copy from log to disk
    80004fcc:	4505                	li	a0,1
    80004fce:	00000097          	auipc	ra,0x0
    80004fd2:	d8e080e7          	jalr	-626(ra) # 80004d5c <install_trans>
  log.lh.n = 0;
    80004fd6:	00017797          	auipc	a5,0x17
    80004fda:	c9278793          	addi	a5,a5,-878 # 8001bc68 <log>
    80004fde:	0207a623          	sw	zero,44(a5)
  write_head(); // clear the log
    80004fe2:	00000097          	auipc	ra,0x0
    80004fe6:	f24080e7          	jalr	-220(ra) # 80004f06 <write_head>
}
    80004fea:	0001                	nop
    80004fec:	60a2                	ld	ra,8(sp)
    80004fee:	6402                	ld	s0,0(sp)
    80004ff0:	0141                	addi	sp,sp,16
    80004ff2:	8082                	ret

0000000080004ff4 <begin_op>:

// called at the start of each FS system call.
void
begin_op(void)
{
    80004ff4:	1141                	addi	sp,sp,-16
    80004ff6:	e406                	sd	ra,8(sp)
    80004ff8:	e022                	sd	s0,0(sp)
    80004ffa:	0800                	addi	s0,sp,16
  acquire(&log.lock);
    80004ffc:	00017517          	auipc	a0,0x17
    80005000:	c6c50513          	addi	a0,a0,-916 # 8001bc68 <log>
    80005004:	00004097          	auipc	ra,0x4
    80005008:	37a080e7          	jalr	890(ra) # 8000937e <acquire>
  while(1){
    if(log.committing){
    8000500c:	00017797          	auipc	a5,0x17
    80005010:	c5c78793          	addi	a5,a5,-932 # 8001bc68 <log>
    80005014:	53dc                	lw	a5,36(a5)
    80005016:	cf91                	beqz	a5,80005032 <begin_op+0x3e>
      sleep(&log, &log.lock);
    80005018:	00017597          	auipc	a1,0x17
    8000501c:	c5058593          	addi	a1,a1,-944 # 8001bc68 <log>
    80005020:	00017517          	auipc	a0,0x17
    80005024:	c4850513          	addi	a0,a0,-952 # 8001bc68 <log>
    80005028:	ffffd097          	auipc	ra,0xffffd
    8000502c:	1b2080e7          	jalr	434(ra) # 800021da <sleep>
    80005030:	bff1                	j	8000500c <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    80005032:	00017797          	auipc	a5,0x17
    80005036:	c3678793          	addi	a5,a5,-970 # 8001bc68 <log>
    8000503a:	57d8                	lw	a4,44(a5)
    8000503c:	00017797          	auipc	a5,0x17
    80005040:	c2c78793          	addi	a5,a5,-980 # 8001bc68 <log>
    80005044:	539c                	lw	a5,32(a5)
    80005046:	2785                	addiw	a5,a5,1
    80005048:	2781                	sext.w	a5,a5
    8000504a:	86be                	mv	a3,a5
    8000504c:	87b6                	mv	a5,a3
    8000504e:	0027979b          	slliw	a5,a5,0x2
    80005052:	9fb5                	addw	a5,a5,a3
    80005054:	0017979b          	slliw	a5,a5,0x1
    80005058:	2781                	sext.w	a5,a5
    8000505a:	9fb9                	addw	a5,a5,a4
    8000505c:	2781                	sext.w	a5,a5
    8000505e:	873e                	mv	a4,a5
    80005060:	47f9                	li	a5,30
    80005062:	00e7df63          	bge	a5,a4,80005080 <begin_op+0x8c>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    80005066:	00017597          	auipc	a1,0x17
    8000506a:	c0258593          	addi	a1,a1,-1022 # 8001bc68 <log>
    8000506e:	00017517          	auipc	a0,0x17
    80005072:	bfa50513          	addi	a0,a0,-1030 # 8001bc68 <log>
    80005076:	ffffd097          	auipc	ra,0xffffd
    8000507a:	164080e7          	jalr	356(ra) # 800021da <sleep>
    8000507e:	b779                	j	8000500c <begin_op+0x18>
    } else {
      log.outstanding += 1;
    80005080:	00017797          	auipc	a5,0x17
    80005084:	be878793          	addi	a5,a5,-1048 # 8001bc68 <log>
    80005088:	539c                	lw	a5,32(a5)
    8000508a:	2785                	addiw	a5,a5,1
    8000508c:	0007871b          	sext.w	a4,a5
    80005090:	00017797          	auipc	a5,0x17
    80005094:	bd878793          	addi	a5,a5,-1064 # 8001bc68 <log>
    80005098:	d398                	sw	a4,32(a5)
      release(&log.lock);
    8000509a:	00017517          	auipc	a0,0x17
    8000509e:	bce50513          	addi	a0,a0,-1074 # 8001bc68 <log>
    800050a2:	00004097          	auipc	ra,0x4
    800050a6:	340080e7          	jalr	832(ra) # 800093e2 <release>
      break;
    800050aa:	0001                	nop
    }
  }
}
    800050ac:	0001                	nop
    800050ae:	60a2                	ld	ra,8(sp)
    800050b0:	6402                	ld	s0,0(sp)
    800050b2:	0141                	addi	sp,sp,16
    800050b4:	8082                	ret

00000000800050b6 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
    800050b6:	1101                	addi	sp,sp,-32
    800050b8:	ec06                	sd	ra,24(sp)
    800050ba:	e822                	sd	s0,16(sp)
    800050bc:	1000                	addi	s0,sp,32
  int do_commit = 0;
    800050be:	fe042623          	sw	zero,-20(s0)

  acquire(&log.lock);
    800050c2:	00017517          	auipc	a0,0x17
    800050c6:	ba650513          	addi	a0,a0,-1114 # 8001bc68 <log>
    800050ca:	00004097          	auipc	ra,0x4
    800050ce:	2b4080e7          	jalr	692(ra) # 8000937e <acquire>
  log.outstanding -= 1;
    800050d2:	00017797          	auipc	a5,0x17
    800050d6:	b9678793          	addi	a5,a5,-1130 # 8001bc68 <log>
    800050da:	539c                	lw	a5,32(a5)
    800050dc:	37fd                	addiw	a5,a5,-1
    800050de:	0007871b          	sext.w	a4,a5
    800050e2:	00017797          	auipc	a5,0x17
    800050e6:	b8678793          	addi	a5,a5,-1146 # 8001bc68 <log>
    800050ea:	d398                	sw	a4,32(a5)
  if(log.committing)
    800050ec:	00017797          	auipc	a5,0x17
    800050f0:	b7c78793          	addi	a5,a5,-1156 # 8001bc68 <log>
    800050f4:	53dc                	lw	a5,36(a5)
    800050f6:	cb89                	beqz	a5,80005108 <end_op+0x52>
    panic("log.committing");
    800050f8:	00006517          	auipc	a0,0x6
    800050fc:	4b050513          	addi	a0,a0,1200 # 8000b5a8 <etext+0x5a8>
    80005100:	00004097          	auipc	ra,0x4
    80005104:	e36080e7          	jalr	-458(ra) # 80008f36 <panic>
  if(log.outstanding == 0){
    80005108:	00017797          	auipc	a5,0x17
    8000510c:	b6078793          	addi	a5,a5,-1184 # 8001bc68 <log>
    80005110:	539c                	lw	a5,32(a5)
    80005112:	eb99                	bnez	a5,80005128 <end_op+0x72>
    do_commit = 1;
    80005114:	4785                	li	a5,1
    80005116:	fef42623          	sw	a5,-20(s0)
    log.committing = 1;
    8000511a:	00017797          	auipc	a5,0x17
    8000511e:	b4e78793          	addi	a5,a5,-1202 # 8001bc68 <log>
    80005122:	4705                	li	a4,1
    80005124:	d3d8                	sw	a4,36(a5)
    80005126:	a809                	j	80005138 <end_op+0x82>
  } else {
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
    80005128:	00017517          	auipc	a0,0x17
    8000512c:	b4050513          	addi	a0,a0,-1216 # 8001bc68 <log>
    80005130:	ffffd097          	auipc	ra,0xffffd
    80005134:	126080e7          	jalr	294(ra) # 80002256 <wakeup>
  }
  release(&log.lock);
    80005138:	00017517          	auipc	a0,0x17
    8000513c:	b3050513          	addi	a0,a0,-1232 # 8001bc68 <log>
    80005140:	00004097          	auipc	ra,0x4
    80005144:	2a2080e7          	jalr	674(ra) # 800093e2 <release>

  if(do_commit){
    80005148:	fec42783          	lw	a5,-20(s0)
    8000514c:	2781                	sext.w	a5,a5
    8000514e:	c3b9                	beqz	a5,80005194 <end_op+0xde>
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    80005150:	00000097          	auipc	ra,0x0
    80005154:	134080e7          	jalr	308(ra) # 80005284 <commit>
    acquire(&log.lock);
    80005158:	00017517          	auipc	a0,0x17
    8000515c:	b1050513          	addi	a0,a0,-1264 # 8001bc68 <log>
    80005160:	00004097          	auipc	ra,0x4
    80005164:	21e080e7          	jalr	542(ra) # 8000937e <acquire>
    log.committing = 0;
    80005168:	00017797          	auipc	a5,0x17
    8000516c:	b0078793          	addi	a5,a5,-1280 # 8001bc68 <log>
    80005170:	0207a223          	sw	zero,36(a5)
    wakeup(&log);
    80005174:	00017517          	auipc	a0,0x17
    80005178:	af450513          	addi	a0,a0,-1292 # 8001bc68 <log>
    8000517c:	ffffd097          	auipc	ra,0xffffd
    80005180:	0da080e7          	jalr	218(ra) # 80002256 <wakeup>
    release(&log.lock);
    80005184:	00017517          	auipc	a0,0x17
    80005188:	ae450513          	addi	a0,a0,-1308 # 8001bc68 <log>
    8000518c:	00004097          	auipc	ra,0x4
    80005190:	256080e7          	jalr	598(ra) # 800093e2 <release>
  }
}
    80005194:	0001                	nop
    80005196:	60e2                	ld	ra,24(sp)
    80005198:	6442                	ld	s0,16(sp)
    8000519a:	6105                	addi	sp,sp,32
    8000519c:	8082                	ret

000000008000519e <write_log>:

// Copy modified blocks from cache to log.
static void
write_log(void)
{
    8000519e:	7179                	addi	sp,sp,-48
    800051a0:	f406                	sd	ra,40(sp)
    800051a2:	f022                	sd	s0,32(sp)
    800051a4:	1800                	addi	s0,sp,48
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    800051a6:	fe042623          	sw	zero,-20(s0)
    800051aa:	a86d                	j	80005264 <write_log+0xc6>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    800051ac:	00017797          	auipc	a5,0x17
    800051b0:	abc78793          	addi	a5,a5,-1348 # 8001bc68 <log>
    800051b4:	579c                	lw	a5,40(a5)
    800051b6:	0007871b          	sext.w	a4,a5
    800051ba:	00017797          	auipc	a5,0x17
    800051be:	aae78793          	addi	a5,a5,-1362 # 8001bc68 <log>
    800051c2:	4f9c                	lw	a5,24(a5)
    800051c4:	fec42683          	lw	a3,-20(s0)
    800051c8:	9fb5                	addw	a5,a5,a3
    800051ca:	2781                	sext.w	a5,a5
    800051cc:	2785                	addiw	a5,a5,1
    800051ce:	2781                	sext.w	a5,a5
    800051d0:	2781                	sext.w	a5,a5
    800051d2:	85be                	mv	a1,a5
    800051d4:	853a                	mv	a0,a4
    800051d6:	ffffe097          	auipc	ra,0xffffe
    800051da:	3b6080e7          	jalr	950(ra) # 8000358c <bread>
    800051de:	fea43023          	sd	a0,-32(s0)
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
    800051e2:	00017797          	auipc	a5,0x17
    800051e6:	a8678793          	addi	a5,a5,-1402 # 8001bc68 <log>
    800051ea:	579c                	lw	a5,40(a5)
    800051ec:	0007869b          	sext.w	a3,a5
    800051f0:	00017717          	auipc	a4,0x17
    800051f4:	a7870713          	addi	a4,a4,-1416 # 8001bc68 <log>
    800051f8:	fec42783          	lw	a5,-20(s0)
    800051fc:	07a1                	addi	a5,a5,8
    800051fe:	078a                	slli	a5,a5,0x2
    80005200:	97ba                	add	a5,a5,a4
    80005202:	4b9c                	lw	a5,16(a5)
    80005204:	2781                	sext.w	a5,a5
    80005206:	85be                	mv	a1,a5
    80005208:	8536                	mv	a0,a3
    8000520a:	ffffe097          	auipc	ra,0xffffe
    8000520e:	382080e7          	jalr	898(ra) # 8000358c <bread>
    80005212:	fca43c23          	sd	a0,-40(s0)
    memmove(to->data, from->data, BSIZE);
    80005216:	fe043783          	ld	a5,-32(s0)
    8000521a:	05878713          	addi	a4,a5,88
    8000521e:	fd843783          	ld	a5,-40(s0)
    80005222:	05878793          	addi	a5,a5,88
    80005226:	40000613          	li	a2,1024
    8000522a:	85be                	mv	a1,a5
    8000522c:	853a                	mv	a0,a4
    8000522e:	ffffb097          	auipc	ra,0xffffb
    80005232:	0c2080e7          	jalr	194(ra) # 800002f0 <memmove>
    bwrite(to);  // write the log
    80005236:	fe043503          	ld	a0,-32(s0)
    8000523a:	ffffe097          	auipc	ra,0xffffe
    8000523e:	3ac080e7          	jalr	940(ra) # 800035e6 <bwrite>
    brelse(from);
    80005242:	fd843503          	ld	a0,-40(s0)
    80005246:	ffffe097          	auipc	ra,0xffffe
    8000524a:	3e8080e7          	jalr	1000(ra) # 8000362e <brelse>
    brelse(to);
    8000524e:	fe043503          	ld	a0,-32(s0)
    80005252:	ffffe097          	auipc	ra,0xffffe
    80005256:	3dc080e7          	jalr	988(ra) # 8000362e <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    8000525a:	fec42783          	lw	a5,-20(s0)
    8000525e:	2785                	addiw	a5,a5,1
    80005260:	fef42623          	sw	a5,-20(s0)
    80005264:	00017797          	auipc	a5,0x17
    80005268:	a0478793          	addi	a5,a5,-1532 # 8001bc68 <log>
    8000526c:	57d8                	lw	a4,44(a5)
    8000526e:	fec42783          	lw	a5,-20(s0)
    80005272:	2781                	sext.w	a5,a5
    80005274:	f2e7cce3          	blt	a5,a4,800051ac <write_log+0xe>
  }
}
    80005278:	0001                	nop
    8000527a:	0001                	nop
    8000527c:	70a2                	ld	ra,40(sp)
    8000527e:	7402                	ld	s0,32(sp)
    80005280:	6145                	addi	sp,sp,48
    80005282:	8082                	ret

0000000080005284 <commit>:

static void
commit()
{
    80005284:	1141                	addi	sp,sp,-16
    80005286:	e406                	sd	ra,8(sp)
    80005288:	e022                	sd	s0,0(sp)
    8000528a:	0800                	addi	s0,sp,16
  if (log.lh.n > 0) {
    8000528c:	00017797          	auipc	a5,0x17
    80005290:	9dc78793          	addi	a5,a5,-1572 # 8001bc68 <log>
    80005294:	57dc                	lw	a5,44(a5)
    80005296:	02f05963          	blez	a5,800052c8 <commit+0x44>
    write_log();     // Write modified blocks from cache to log
    8000529a:	00000097          	auipc	ra,0x0
    8000529e:	f04080e7          	jalr	-252(ra) # 8000519e <write_log>
    write_head();    // Write header to disk -- the real commit
    800052a2:	00000097          	auipc	ra,0x0
    800052a6:	c64080e7          	jalr	-924(ra) # 80004f06 <write_head>
    install_trans(0); // Now install writes to home locations
    800052aa:	4501                	li	a0,0
    800052ac:	00000097          	auipc	ra,0x0
    800052b0:	ab0080e7          	jalr	-1360(ra) # 80004d5c <install_trans>
    log.lh.n = 0;
    800052b4:	00017797          	auipc	a5,0x17
    800052b8:	9b478793          	addi	a5,a5,-1612 # 8001bc68 <log>
    800052bc:	0207a623          	sw	zero,44(a5)
    write_head();    // Erase the transaction from the log
    800052c0:	00000097          	auipc	ra,0x0
    800052c4:	c46080e7          	jalr	-954(ra) # 80004f06 <write_head>
  }
}
    800052c8:	0001                	nop
    800052ca:	60a2                	ld	ra,8(sp)
    800052cc:	6402                	ld	s0,0(sp)
    800052ce:	0141                	addi	sp,sp,16
    800052d0:	8082                	ret

00000000800052d2 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
    800052d2:	7179                	addi	sp,sp,-48
    800052d4:	f406                	sd	ra,40(sp)
    800052d6:	f022                	sd	s0,32(sp)
    800052d8:	1800                	addi	s0,sp,48
    800052da:	fca43c23          	sd	a0,-40(s0)
  int i;

  acquire(&log.lock);
    800052de:	00017517          	auipc	a0,0x17
    800052e2:	98a50513          	addi	a0,a0,-1654 # 8001bc68 <log>
    800052e6:	00004097          	auipc	ra,0x4
    800052ea:	098080e7          	jalr	152(ra) # 8000937e <acquire>
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    800052ee:	00017797          	auipc	a5,0x17
    800052f2:	97a78793          	addi	a5,a5,-1670 # 8001bc68 <log>
    800052f6:	57dc                	lw	a5,44(a5)
    800052f8:	873e                	mv	a4,a5
    800052fa:	47f5                	li	a5,29
    800052fc:	02e7c063          	blt	a5,a4,8000531c <log_write+0x4a>
    80005300:	00017797          	auipc	a5,0x17
    80005304:	96878793          	addi	a5,a5,-1688 # 8001bc68 <log>
    80005308:	57d8                	lw	a4,44(a5)
    8000530a:	00017797          	auipc	a5,0x17
    8000530e:	95e78793          	addi	a5,a5,-1698 # 8001bc68 <log>
    80005312:	4fdc                	lw	a5,28(a5)
    80005314:	37fd                	addiw	a5,a5,-1
    80005316:	2781                	sext.w	a5,a5
    80005318:	00f74a63          	blt	a4,a5,8000532c <log_write+0x5a>
    panic("too big a transaction");
    8000531c:	00006517          	auipc	a0,0x6
    80005320:	29c50513          	addi	a0,a0,668 # 8000b5b8 <etext+0x5b8>
    80005324:	00004097          	auipc	ra,0x4
    80005328:	c12080e7          	jalr	-1006(ra) # 80008f36 <panic>
  if (log.outstanding < 1)
    8000532c:	00017797          	auipc	a5,0x17
    80005330:	93c78793          	addi	a5,a5,-1732 # 8001bc68 <log>
    80005334:	539c                	lw	a5,32(a5)
    80005336:	00f04a63          	bgtz	a5,8000534a <log_write+0x78>
    panic("log_write outside of trans");
    8000533a:	00006517          	auipc	a0,0x6
    8000533e:	29650513          	addi	a0,a0,662 # 8000b5d0 <etext+0x5d0>
    80005342:	00004097          	auipc	ra,0x4
    80005346:	bf4080e7          	jalr	-1036(ra) # 80008f36 <panic>

  for (i = 0; i < log.lh.n; i++) {
    8000534a:	fe042623          	sw	zero,-20(s0)
    8000534e:	a03d                	j	8000537c <log_write+0xaa>
    if (log.lh.block[i] == b->blockno)   // log absorption
    80005350:	00017717          	auipc	a4,0x17
    80005354:	91870713          	addi	a4,a4,-1768 # 8001bc68 <log>
    80005358:	fec42783          	lw	a5,-20(s0)
    8000535c:	07a1                	addi	a5,a5,8
    8000535e:	078a                	slli	a5,a5,0x2
    80005360:	97ba                	add	a5,a5,a4
    80005362:	4b9c                	lw	a5,16(a5)
    80005364:	0007871b          	sext.w	a4,a5
    80005368:	fd843783          	ld	a5,-40(s0)
    8000536c:	47dc                	lw	a5,12(a5)
    8000536e:	02f70263          	beq	a4,a5,80005392 <log_write+0xc0>
  for (i = 0; i < log.lh.n; i++) {
    80005372:	fec42783          	lw	a5,-20(s0)
    80005376:	2785                	addiw	a5,a5,1
    80005378:	fef42623          	sw	a5,-20(s0)
    8000537c:	00017797          	auipc	a5,0x17
    80005380:	8ec78793          	addi	a5,a5,-1812 # 8001bc68 <log>
    80005384:	57d8                	lw	a4,44(a5)
    80005386:	fec42783          	lw	a5,-20(s0)
    8000538a:	2781                	sext.w	a5,a5
    8000538c:	fce7c2e3          	blt	a5,a4,80005350 <log_write+0x7e>
    80005390:	a011                	j	80005394 <log_write+0xc2>
      break;
    80005392:	0001                	nop
  }
  log.lh.block[i] = b->blockno;
    80005394:	fd843783          	ld	a5,-40(s0)
    80005398:	47dc                	lw	a5,12(a5)
    8000539a:	0007871b          	sext.w	a4,a5
    8000539e:	00017697          	auipc	a3,0x17
    800053a2:	8ca68693          	addi	a3,a3,-1846 # 8001bc68 <log>
    800053a6:	fec42783          	lw	a5,-20(s0)
    800053aa:	07a1                	addi	a5,a5,8
    800053ac:	078a                	slli	a5,a5,0x2
    800053ae:	97b6                	add	a5,a5,a3
    800053b0:	cb98                	sw	a4,16(a5)
  if (i == log.lh.n) {  // Add new block to log?
    800053b2:	00017797          	auipc	a5,0x17
    800053b6:	8b678793          	addi	a5,a5,-1866 # 8001bc68 <log>
    800053ba:	57d8                	lw	a4,44(a5)
    800053bc:	fec42783          	lw	a5,-20(s0)
    800053c0:	2781                	sext.w	a5,a5
    800053c2:	02e79563          	bne	a5,a4,800053ec <log_write+0x11a>
    bpin(b);
    800053c6:	fd843503          	ld	a0,-40(s0)
    800053ca:	ffffe097          	auipc	ra,0xffffe
    800053ce:	352080e7          	jalr	850(ra) # 8000371c <bpin>
    log.lh.n++;
    800053d2:	00017797          	auipc	a5,0x17
    800053d6:	89678793          	addi	a5,a5,-1898 # 8001bc68 <log>
    800053da:	57dc                	lw	a5,44(a5)
    800053dc:	2785                	addiw	a5,a5,1
    800053de:	0007871b          	sext.w	a4,a5
    800053e2:	00017797          	auipc	a5,0x17
    800053e6:	88678793          	addi	a5,a5,-1914 # 8001bc68 <log>
    800053ea:	d7d8                	sw	a4,44(a5)
  }
  release(&log.lock);
    800053ec:	00017517          	auipc	a0,0x17
    800053f0:	87c50513          	addi	a0,a0,-1924 # 8001bc68 <log>
    800053f4:	00004097          	auipc	ra,0x4
    800053f8:	fee080e7          	jalr	-18(ra) # 800093e2 <release>
}
    800053fc:	0001                	nop
    800053fe:	70a2                	ld	ra,40(sp)
    80005400:	7402                	ld	s0,32(sp)
    80005402:	6145                	addi	sp,sp,48
    80005404:	8082                	ret

0000000080005406 <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    80005406:	1101                	addi	sp,sp,-32
    80005408:	ec06                	sd	ra,24(sp)
    8000540a:	e822                	sd	s0,16(sp)
    8000540c:	1000                	addi	s0,sp,32
    8000540e:	fea43423          	sd	a0,-24(s0)
    80005412:	feb43023          	sd	a1,-32(s0)
  initlock(&lk->lk, "sleep lock");
    80005416:	fe843783          	ld	a5,-24(s0)
    8000541a:	07a1                	addi	a5,a5,8
    8000541c:	00006597          	auipc	a1,0x6
    80005420:	1d458593          	addi	a1,a1,468 # 8000b5f0 <etext+0x5f0>
    80005424:	853e                	mv	a0,a5
    80005426:	00004097          	auipc	ra,0x4
    8000542a:	f28080e7          	jalr	-216(ra) # 8000934e <initlock>
  lk->name = name;
    8000542e:	fe843783          	ld	a5,-24(s0)
    80005432:	fe043703          	ld	a4,-32(s0)
    80005436:	f398                	sd	a4,32(a5)
  lk->locked = 0;
    80005438:	fe843783          	ld	a5,-24(s0)
    8000543c:	0007a023          	sw	zero,0(a5)
  lk->pid = 0;
    80005440:	fe843783          	ld	a5,-24(s0)
    80005444:	0207a423          	sw	zero,40(a5)
}
    80005448:	0001                	nop
    8000544a:	60e2                	ld	ra,24(sp)
    8000544c:	6442                	ld	s0,16(sp)
    8000544e:	6105                	addi	sp,sp,32
    80005450:	8082                	ret

0000000080005452 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    80005452:	1101                	addi	sp,sp,-32
    80005454:	ec06                	sd	ra,24(sp)
    80005456:	e822                	sd	s0,16(sp)
    80005458:	1000                	addi	s0,sp,32
    8000545a:	fea43423          	sd	a0,-24(s0)
  acquire(&lk->lk);
    8000545e:	fe843783          	ld	a5,-24(s0)
    80005462:	07a1                	addi	a5,a5,8
    80005464:	853e                	mv	a0,a5
    80005466:	00004097          	auipc	ra,0x4
    8000546a:	f18080e7          	jalr	-232(ra) # 8000937e <acquire>
  while (lk->locked) {
    8000546e:	a819                	j	80005484 <acquiresleep+0x32>
    sleep(lk, &lk->lk);
    80005470:	fe843783          	ld	a5,-24(s0)
    80005474:	07a1                	addi	a5,a5,8
    80005476:	85be                	mv	a1,a5
    80005478:	fe843503          	ld	a0,-24(s0)
    8000547c:	ffffd097          	auipc	ra,0xffffd
    80005480:	d5e080e7          	jalr	-674(ra) # 800021da <sleep>
  while (lk->locked) {
    80005484:	fe843783          	ld	a5,-24(s0)
    80005488:	439c                	lw	a5,0(a5)
    8000548a:	f3fd                	bnez	a5,80005470 <acquiresleep+0x1e>
  }
  lk->locked = 1;
    8000548c:	fe843783          	ld	a5,-24(s0)
    80005490:	4705                	li	a4,1
    80005492:	c398                	sw	a4,0(a5)
  lk->pid = myproc()->pid;
    80005494:	ffffc097          	auipc	ra,0xffffc
    80005498:	16c080e7          	jalr	364(ra) # 80001600 <myproc>
    8000549c:	87aa                	mv	a5,a0
    8000549e:	5b98                	lw	a4,48(a5)
    800054a0:	fe843783          	ld	a5,-24(s0)
    800054a4:	d798                	sw	a4,40(a5)
  release(&lk->lk);
    800054a6:	fe843783          	ld	a5,-24(s0)
    800054aa:	07a1                	addi	a5,a5,8
    800054ac:	853e                	mv	a0,a5
    800054ae:	00004097          	auipc	ra,0x4
    800054b2:	f34080e7          	jalr	-204(ra) # 800093e2 <release>
}
    800054b6:	0001                	nop
    800054b8:	60e2                	ld	ra,24(sp)
    800054ba:	6442                	ld	s0,16(sp)
    800054bc:	6105                	addi	sp,sp,32
    800054be:	8082                	ret

00000000800054c0 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    800054c0:	1101                	addi	sp,sp,-32
    800054c2:	ec06                	sd	ra,24(sp)
    800054c4:	e822                	sd	s0,16(sp)
    800054c6:	1000                	addi	s0,sp,32
    800054c8:	fea43423          	sd	a0,-24(s0)
  acquire(&lk->lk);
    800054cc:	fe843783          	ld	a5,-24(s0)
    800054d0:	07a1                	addi	a5,a5,8
    800054d2:	853e                	mv	a0,a5
    800054d4:	00004097          	auipc	ra,0x4
    800054d8:	eaa080e7          	jalr	-342(ra) # 8000937e <acquire>
  lk->locked = 0;
    800054dc:	fe843783          	ld	a5,-24(s0)
    800054e0:	0007a023          	sw	zero,0(a5)
  lk->pid = 0;
    800054e4:	fe843783          	ld	a5,-24(s0)
    800054e8:	0207a423          	sw	zero,40(a5)
  wakeup(lk);
    800054ec:	fe843503          	ld	a0,-24(s0)
    800054f0:	ffffd097          	auipc	ra,0xffffd
    800054f4:	d66080e7          	jalr	-666(ra) # 80002256 <wakeup>
  release(&lk->lk);
    800054f8:	fe843783          	ld	a5,-24(s0)
    800054fc:	07a1                	addi	a5,a5,8
    800054fe:	853e                	mv	a0,a5
    80005500:	00004097          	auipc	ra,0x4
    80005504:	ee2080e7          	jalr	-286(ra) # 800093e2 <release>
}
    80005508:	0001                	nop
    8000550a:	60e2                	ld	ra,24(sp)
    8000550c:	6442                	ld	s0,16(sp)
    8000550e:	6105                	addi	sp,sp,32
    80005510:	8082                	ret

0000000080005512 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    80005512:	7139                	addi	sp,sp,-64
    80005514:	fc06                	sd	ra,56(sp)
    80005516:	f822                	sd	s0,48(sp)
    80005518:	f426                	sd	s1,40(sp)
    8000551a:	0080                	addi	s0,sp,64
    8000551c:	fca43423          	sd	a0,-56(s0)
  int r;
  
  acquire(&lk->lk);
    80005520:	fc843783          	ld	a5,-56(s0)
    80005524:	07a1                	addi	a5,a5,8
    80005526:	853e                	mv	a0,a5
    80005528:	00004097          	auipc	ra,0x4
    8000552c:	e56080e7          	jalr	-426(ra) # 8000937e <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    80005530:	fc843783          	ld	a5,-56(s0)
    80005534:	439c                	lw	a5,0(a5)
    80005536:	cf99                	beqz	a5,80005554 <holdingsleep+0x42>
    80005538:	fc843783          	ld	a5,-56(s0)
    8000553c:	5784                	lw	s1,40(a5)
    8000553e:	ffffc097          	auipc	ra,0xffffc
    80005542:	0c2080e7          	jalr	194(ra) # 80001600 <myproc>
    80005546:	87aa                	mv	a5,a0
    80005548:	5b9c                	lw	a5,48(a5)
    8000554a:	8726                	mv	a4,s1
    8000554c:	00f71463          	bne	a4,a5,80005554 <holdingsleep+0x42>
    80005550:	4785                	li	a5,1
    80005552:	a011                	j	80005556 <holdingsleep+0x44>
    80005554:	4781                	li	a5,0
    80005556:	fcf42e23          	sw	a5,-36(s0)
  release(&lk->lk);
    8000555a:	fc843783          	ld	a5,-56(s0)
    8000555e:	07a1                	addi	a5,a5,8
    80005560:	853e                	mv	a0,a5
    80005562:	00004097          	auipc	ra,0x4
    80005566:	e80080e7          	jalr	-384(ra) # 800093e2 <release>
  return r;
    8000556a:	fdc42783          	lw	a5,-36(s0)
}
    8000556e:	853e                	mv	a0,a5
    80005570:	70e2                	ld	ra,56(sp)
    80005572:	7442                	ld	s0,48(sp)
    80005574:	74a2                	ld	s1,40(sp)
    80005576:	6121                	addi	sp,sp,64
    80005578:	8082                	ret

000000008000557a <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    8000557a:	1141                	addi	sp,sp,-16
    8000557c:	e406                	sd	ra,8(sp)
    8000557e:	e022                	sd	s0,0(sp)
    80005580:	0800                	addi	s0,sp,16
  initlock(&ftable.lock, "ftable");
    80005582:	00006597          	auipc	a1,0x6
    80005586:	07e58593          	addi	a1,a1,126 # 8000b600 <etext+0x600>
    8000558a:	00017517          	auipc	a0,0x17
    8000558e:	82650513          	addi	a0,a0,-2010 # 8001bdb0 <ftable>
    80005592:	00004097          	auipc	ra,0x4
    80005596:	dbc080e7          	jalr	-580(ra) # 8000934e <initlock>
}
    8000559a:	0001                	nop
    8000559c:	60a2                	ld	ra,8(sp)
    8000559e:	6402                	ld	s0,0(sp)
    800055a0:	0141                	addi	sp,sp,16
    800055a2:	8082                	ret

00000000800055a4 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    800055a4:	1101                	addi	sp,sp,-32
    800055a6:	ec06                	sd	ra,24(sp)
    800055a8:	e822                	sd	s0,16(sp)
    800055aa:	1000                	addi	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    800055ac:	00017517          	auipc	a0,0x17
    800055b0:	80450513          	addi	a0,a0,-2044 # 8001bdb0 <ftable>
    800055b4:	00004097          	auipc	ra,0x4
    800055b8:	dca080e7          	jalr	-566(ra) # 8000937e <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    800055bc:	00017797          	auipc	a5,0x17
    800055c0:	80c78793          	addi	a5,a5,-2036 # 8001bdc8 <ftable+0x18>
    800055c4:	fef43423          	sd	a5,-24(s0)
    800055c8:	a815                	j	800055fc <filealloc+0x58>
    if(f->ref == 0){
    800055ca:	fe843783          	ld	a5,-24(s0)
    800055ce:	43dc                	lw	a5,4(a5)
    800055d0:	e385                	bnez	a5,800055f0 <filealloc+0x4c>
      f->ref = 1;
    800055d2:	fe843783          	ld	a5,-24(s0)
    800055d6:	4705                	li	a4,1
    800055d8:	c3d8                	sw	a4,4(a5)
      release(&ftable.lock);
    800055da:	00016517          	auipc	a0,0x16
    800055de:	7d650513          	addi	a0,a0,2006 # 8001bdb0 <ftable>
    800055e2:	00004097          	auipc	ra,0x4
    800055e6:	e00080e7          	jalr	-512(ra) # 800093e2 <release>
      return f;
    800055ea:	fe843783          	ld	a5,-24(s0)
    800055ee:	a805                	j	8000561e <filealloc+0x7a>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    800055f0:	fe843783          	ld	a5,-24(s0)
    800055f4:	02878793          	addi	a5,a5,40
    800055f8:	fef43423          	sd	a5,-24(s0)
    800055fc:	00017797          	auipc	a5,0x17
    80005600:	76c78793          	addi	a5,a5,1900 # 8001cd68 <disk>
    80005604:	fe843703          	ld	a4,-24(s0)
    80005608:	fcf761e3          	bltu	a4,a5,800055ca <filealloc+0x26>
    }
  }
  release(&ftable.lock);
    8000560c:	00016517          	auipc	a0,0x16
    80005610:	7a450513          	addi	a0,a0,1956 # 8001bdb0 <ftable>
    80005614:	00004097          	auipc	ra,0x4
    80005618:	dce080e7          	jalr	-562(ra) # 800093e2 <release>
  return 0;
    8000561c:	4781                	li	a5,0
}
    8000561e:	853e                	mv	a0,a5
    80005620:	60e2                	ld	ra,24(sp)
    80005622:	6442                	ld	s0,16(sp)
    80005624:	6105                	addi	sp,sp,32
    80005626:	8082                	ret

0000000080005628 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    80005628:	1101                	addi	sp,sp,-32
    8000562a:	ec06                	sd	ra,24(sp)
    8000562c:	e822                	sd	s0,16(sp)
    8000562e:	1000                	addi	s0,sp,32
    80005630:	fea43423          	sd	a0,-24(s0)
  acquire(&ftable.lock);
    80005634:	00016517          	auipc	a0,0x16
    80005638:	77c50513          	addi	a0,a0,1916 # 8001bdb0 <ftable>
    8000563c:	00004097          	auipc	ra,0x4
    80005640:	d42080e7          	jalr	-702(ra) # 8000937e <acquire>
  if(f->ref < 1)
    80005644:	fe843783          	ld	a5,-24(s0)
    80005648:	43dc                	lw	a5,4(a5)
    8000564a:	00f04a63          	bgtz	a5,8000565e <filedup+0x36>
    panic("filedup");
    8000564e:	00006517          	auipc	a0,0x6
    80005652:	fba50513          	addi	a0,a0,-70 # 8000b608 <etext+0x608>
    80005656:	00004097          	auipc	ra,0x4
    8000565a:	8e0080e7          	jalr	-1824(ra) # 80008f36 <panic>
  f->ref++;
    8000565e:	fe843783          	ld	a5,-24(s0)
    80005662:	43dc                	lw	a5,4(a5)
    80005664:	2785                	addiw	a5,a5,1
    80005666:	0007871b          	sext.w	a4,a5
    8000566a:	fe843783          	ld	a5,-24(s0)
    8000566e:	c3d8                	sw	a4,4(a5)
  release(&ftable.lock);
    80005670:	00016517          	auipc	a0,0x16
    80005674:	74050513          	addi	a0,a0,1856 # 8001bdb0 <ftable>
    80005678:	00004097          	auipc	ra,0x4
    8000567c:	d6a080e7          	jalr	-662(ra) # 800093e2 <release>
  return f;
    80005680:	fe843783          	ld	a5,-24(s0)
}
    80005684:	853e                	mv	a0,a5
    80005686:	60e2                	ld	ra,24(sp)
    80005688:	6442                	ld	s0,16(sp)
    8000568a:	6105                	addi	sp,sp,32
    8000568c:	8082                	ret

000000008000568e <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    8000568e:	715d                	addi	sp,sp,-80
    80005690:	e486                	sd	ra,72(sp)
    80005692:	e0a2                	sd	s0,64(sp)
    80005694:	0880                	addi	s0,sp,80
    80005696:	faa43c23          	sd	a0,-72(s0)
  struct file ff;

  acquire(&ftable.lock);
    8000569a:	00016517          	auipc	a0,0x16
    8000569e:	71650513          	addi	a0,a0,1814 # 8001bdb0 <ftable>
    800056a2:	00004097          	auipc	ra,0x4
    800056a6:	cdc080e7          	jalr	-804(ra) # 8000937e <acquire>
  if(f->ref < 1)
    800056aa:	fb843783          	ld	a5,-72(s0)
    800056ae:	43dc                	lw	a5,4(a5)
    800056b0:	00f04a63          	bgtz	a5,800056c4 <fileclose+0x36>
    panic("fileclose");
    800056b4:	00006517          	auipc	a0,0x6
    800056b8:	f5c50513          	addi	a0,a0,-164 # 8000b610 <etext+0x610>
    800056bc:	00004097          	auipc	ra,0x4
    800056c0:	87a080e7          	jalr	-1926(ra) # 80008f36 <panic>
  if(--f->ref > 0){
    800056c4:	fb843783          	ld	a5,-72(s0)
    800056c8:	43dc                	lw	a5,4(a5)
    800056ca:	37fd                	addiw	a5,a5,-1
    800056cc:	0007871b          	sext.w	a4,a5
    800056d0:	fb843783          	ld	a5,-72(s0)
    800056d4:	c3d8                	sw	a4,4(a5)
    800056d6:	fb843783          	ld	a5,-72(s0)
    800056da:	43dc                	lw	a5,4(a5)
    800056dc:	00f05b63          	blez	a5,800056f2 <fileclose+0x64>
    release(&ftable.lock);
    800056e0:	00016517          	auipc	a0,0x16
    800056e4:	6d050513          	addi	a0,a0,1744 # 8001bdb0 <ftable>
    800056e8:	00004097          	auipc	ra,0x4
    800056ec:	cfa080e7          	jalr	-774(ra) # 800093e2 <release>
    800056f0:	a879                	j	8000578e <fileclose+0x100>
    return;
  }
  ff = *f;
    800056f2:	fb843783          	ld	a5,-72(s0)
    800056f6:	638c                	ld	a1,0(a5)
    800056f8:	6790                	ld	a2,8(a5)
    800056fa:	6b94                	ld	a3,16(a5)
    800056fc:	6f98                	ld	a4,24(a5)
    800056fe:	739c                	ld	a5,32(a5)
    80005700:	fcb43423          	sd	a1,-56(s0)
    80005704:	fcc43823          	sd	a2,-48(s0)
    80005708:	fcd43c23          	sd	a3,-40(s0)
    8000570c:	fee43023          	sd	a4,-32(s0)
    80005710:	fef43423          	sd	a5,-24(s0)
  f->ref = 0;
    80005714:	fb843783          	ld	a5,-72(s0)
    80005718:	0007a223          	sw	zero,4(a5)
  f->type = FD_NONE;
    8000571c:	fb843783          	ld	a5,-72(s0)
    80005720:	0007a023          	sw	zero,0(a5)
  release(&ftable.lock);
    80005724:	00016517          	auipc	a0,0x16
    80005728:	68c50513          	addi	a0,a0,1676 # 8001bdb0 <ftable>
    8000572c:	00004097          	auipc	ra,0x4
    80005730:	cb6080e7          	jalr	-842(ra) # 800093e2 <release>

  if(ff.type == FD_PIPE){
    80005734:	fc842783          	lw	a5,-56(s0)
    80005738:	873e                	mv	a4,a5
    8000573a:	4785                	li	a5,1
    8000573c:	00f71e63          	bne	a4,a5,80005758 <fileclose+0xca>
    pipeclose(ff.pipe, ff.writable);
    80005740:	fd843783          	ld	a5,-40(s0)
    80005744:	fd144703          	lbu	a4,-47(s0)
    80005748:	2701                	sext.w	a4,a4
    8000574a:	85ba                	mv	a1,a4
    8000574c:	853e                	mv	a0,a5
    8000574e:	00000097          	auipc	ra,0x0
    80005752:	5a6080e7          	jalr	1446(ra) # 80005cf4 <pipeclose>
    80005756:	a825                	j	8000578e <fileclose+0x100>
  } else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
    80005758:	fc842783          	lw	a5,-56(s0)
    8000575c:	873e                	mv	a4,a5
    8000575e:	4789                	li	a5,2
    80005760:	00f70863          	beq	a4,a5,80005770 <fileclose+0xe2>
    80005764:	fc842783          	lw	a5,-56(s0)
    80005768:	873e                	mv	a4,a5
    8000576a:	478d                	li	a5,3
    8000576c:	02f71163          	bne	a4,a5,8000578e <fileclose+0x100>
    begin_op();
    80005770:	00000097          	auipc	ra,0x0
    80005774:	884080e7          	jalr	-1916(ra) # 80004ff4 <begin_op>
    iput(ff.ip);
    80005778:	fe043783          	ld	a5,-32(s0)
    8000577c:	853e                	mv	a0,a5
    8000577e:	fffff097          	auipc	ra,0xfffff
    80005782:	970080e7          	jalr	-1680(ra) # 800040ee <iput>
    end_op();
    80005786:	00000097          	auipc	ra,0x0
    8000578a:	930080e7          	jalr	-1744(ra) # 800050b6 <end_op>
  }
}
    8000578e:	60a6                	ld	ra,72(sp)
    80005790:	6406                	ld	s0,64(sp)
    80005792:	6161                	addi	sp,sp,80
    80005794:	8082                	ret

0000000080005796 <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    80005796:	7139                	addi	sp,sp,-64
    80005798:	fc06                	sd	ra,56(sp)
    8000579a:	f822                	sd	s0,48(sp)
    8000579c:	0080                	addi	s0,sp,64
    8000579e:	fca43423          	sd	a0,-56(s0)
    800057a2:	fcb43023          	sd	a1,-64(s0)
  struct proc *p = myproc();
    800057a6:	ffffc097          	auipc	ra,0xffffc
    800057aa:	e5a080e7          	jalr	-422(ra) # 80001600 <myproc>
    800057ae:	fea43423          	sd	a0,-24(s0)
  struct stat st;
  
  if(f->type == FD_INODE || f->type == FD_DEVICE){
    800057b2:	fc843783          	ld	a5,-56(s0)
    800057b6:	439c                	lw	a5,0(a5)
    800057b8:	873e                	mv	a4,a5
    800057ba:	4789                	li	a5,2
    800057bc:	00f70963          	beq	a4,a5,800057ce <filestat+0x38>
    800057c0:	fc843783          	ld	a5,-56(s0)
    800057c4:	439c                	lw	a5,0(a5)
    800057c6:	873e                	mv	a4,a5
    800057c8:	478d                	li	a5,3
    800057ca:	06f71263          	bne	a4,a5,8000582e <filestat+0x98>
    ilock(f->ip);
    800057ce:	fc843783          	ld	a5,-56(s0)
    800057d2:	6f9c                	ld	a5,24(a5)
    800057d4:	853e                	mv	a0,a5
    800057d6:	ffffe097          	auipc	ra,0xffffe
    800057da:	78a080e7          	jalr	1930(ra) # 80003f60 <ilock>
    stati(f->ip, &st);
    800057de:	fc843783          	ld	a5,-56(s0)
    800057e2:	6f9c                	ld	a5,24(a5)
    800057e4:	fd040713          	addi	a4,s0,-48
    800057e8:	85ba                	mv	a1,a4
    800057ea:	853e                	mv	a0,a5
    800057ec:	fffff097          	auipc	ra,0xfffff
    800057f0:	cc6080e7          	jalr	-826(ra) # 800044b2 <stati>
    iunlock(f->ip);
    800057f4:	fc843783          	ld	a5,-56(s0)
    800057f8:	6f9c                	ld	a5,24(a5)
    800057fa:	853e                	mv	a0,a5
    800057fc:	fffff097          	auipc	ra,0xfffff
    80005800:	898080e7          	jalr	-1896(ra) # 80004094 <iunlock>
    if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    80005804:	fe843783          	ld	a5,-24(s0)
    80005808:	6bbc                	ld	a5,80(a5)
    8000580a:	fd040713          	addi	a4,s0,-48
    8000580e:	46e1                	li	a3,24
    80005810:	863a                	mv	a2,a4
    80005812:	fc043583          	ld	a1,-64(s0)
    80005816:	853e                	mv	a0,a5
    80005818:	ffffc097          	auipc	ra,0xffffc
    8000581c:	8b2080e7          	jalr	-1870(ra) # 800010ca <copyout>
    80005820:	87aa                	mv	a5,a0
    80005822:	0007d463          	bgez	a5,8000582a <filestat+0x94>
      return -1;
    80005826:	57fd                	li	a5,-1
    80005828:	a021                	j	80005830 <filestat+0x9a>
    return 0;
    8000582a:	4781                	li	a5,0
    8000582c:	a011                	j	80005830 <filestat+0x9a>
  }
  return -1;
    8000582e:	57fd                	li	a5,-1
}
    80005830:	853e                	mv	a0,a5
    80005832:	70e2                	ld	ra,56(sp)
    80005834:	7442                	ld	s0,48(sp)
    80005836:	6121                	addi	sp,sp,64
    80005838:	8082                	ret

000000008000583a <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    8000583a:	7139                	addi	sp,sp,-64
    8000583c:	fc06                	sd	ra,56(sp)
    8000583e:	f822                	sd	s0,48(sp)
    80005840:	0080                	addi	s0,sp,64
    80005842:	fca43c23          	sd	a0,-40(s0)
    80005846:	fcb43823          	sd	a1,-48(s0)
    8000584a:	87b2                	mv	a5,a2
    8000584c:	fcf42623          	sw	a5,-52(s0)
  int r = 0;
    80005850:	fe042623          	sw	zero,-20(s0)

  if(f->readable == 0)
    80005854:	fd843783          	ld	a5,-40(s0)
    80005858:	0087c783          	lbu	a5,8(a5)
    8000585c:	e399                	bnez	a5,80005862 <fileread+0x28>
    return -1;
    8000585e:	57fd                	li	a5,-1
    80005860:	a23d                	j	8000598e <fileread+0x154>

  if(f->type == FD_PIPE){
    80005862:	fd843783          	ld	a5,-40(s0)
    80005866:	439c                	lw	a5,0(a5)
    80005868:	873e                	mv	a4,a5
    8000586a:	4785                	li	a5,1
    8000586c:	02f71363          	bne	a4,a5,80005892 <fileread+0x58>
    r = piperead(f->pipe, addr, n);
    80005870:	fd843783          	ld	a5,-40(s0)
    80005874:	6b9c                	ld	a5,16(a5)
    80005876:	fcc42703          	lw	a4,-52(s0)
    8000587a:	863a                	mv	a2,a4
    8000587c:	fd043583          	ld	a1,-48(s0)
    80005880:	853e                	mv	a0,a5
    80005882:	00000097          	auipc	ra,0x0
    80005886:	66e080e7          	jalr	1646(ra) # 80005ef0 <piperead>
    8000588a:	87aa                	mv	a5,a0
    8000588c:	fef42623          	sw	a5,-20(s0)
    80005890:	a8ed                	j	8000598a <fileread+0x150>
  } else if(f->type == FD_DEVICE){
    80005892:	fd843783          	ld	a5,-40(s0)
    80005896:	439c                	lw	a5,0(a5)
    80005898:	873e                	mv	a4,a5
    8000589a:	478d                	li	a5,3
    8000589c:	06f71463          	bne	a4,a5,80005904 <fileread+0xca>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    800058a0:	fd843783          	ld	a5,-40(s0)
    800058a4:	02479783          	lh	a5,36(a5)
    800058a8:	0207c663          	bltz	a5,800058d4 <fileread+0x9a>
    800058ac:	fd843783          	ld	a5,-40(s0)
    800058b0:	02479783          	lh	a5,36(a5)
    800058b4:	873e                	mv	a4,a5
    800058b6:	47a5                	li	a5,9
    800058b8:	00e7ce63          	blt	a5,a4,800058d4 <fileread+0x9a>
    800058bc:	fd843783          	ld	a5,-40(s0)
    800058c0:	02479783          	lh	a5,36(a5)
    800058c4:	00016717          	auipc	a4,0x16
    800058c8:	44c70713          	addi	a4,a4,1100 # 8001bd10 <devsw>
    800058cc:	0792                	slli	a5,a5,0x4
    800058ce:	97ba                	add	a5,a5,a4
    800058d0:	639c                	ld	a5,0(a5)
    800058d2:	e399                	bnez	a5,800058d8 <fileread+0x9e>
      return -1;
    800058d4:	57fd                	li	a5,-1
    800058d6:	a865                	j	8000598e <fileread+0x154>
    r = devsw[f->major].read(1, addr, n);
    800058d8:	fd843783          	ld	a5,-40(s0)
    800058dc:	02479783          	lh	a5,36(a5)
    800058e0:	00016717          	auipc	a4,0x16
    800058e4:	43070713          	addi	a4,a4,1072 # 8001bd10 <devsw>
    800058e8:	0792                	slli	a5,a5,0x4
    800058ea:	97ba                	add	a5,a5,a4
    800058ec:	639c                	ld	a5,0(a5)
    800058ee:	fcc42703          	lw	a4,-52(s0)
    800058f2:	863a                	mv	a2,a4
    800058f4:	fd043583          	ld	a1,-48(s0)
    800058f8:	4505                	li	a0,1
    800058fa:	9782                	jalr	a5
    800058fc:	87aa                	mv	a5,a0
    800058fe:	fef42623          	sw	a5,-20(s0)
    80005902:	a061                	j	8000598a <fileread+0x150>
  } else if(f->type == FD_INODE){
    80005904:	fd843783          	ld	a5,-40(s0)
    80005908:	439c                	lw	a5,0(a5)
    8000590a:	873e                	mv	a4,a5
    8000590c:	4789                	li	a5,2
    8000590e:	06f71663          	bne	a4,a5,8000597a <fileread+0x140>
    ilock(f->ip);
    80005912:	fd843783          	ld	a5,-40(s0)
    80005916:	6f9c                	ld	a5,24(a5)
    80005918:	853e                	mv	a0,a5
    8000591a:	ffffe097          	auipc	ra,0xffffe
    8000591e:	646080e7          	jalr	1606(ra) # 80003f60 <ilock>
    if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    80005922:	fd843783          	ld	a5,-40(s0)
    80005926:	6f88                	ld	a0,24(a5)
    80005928:	fd843783          	ld	a5,-40(s0)
    8000592c:	539c                	lw	a5,32(a5)
    8000592e:	fcc42703          	lw	a4,-52(s0)
    80005932:	86be                	mv	a3,a5
    80005934:	fd043603          	ld	a2,-48(s0)
    80005938:	4585                	li	a1,1
    8000593a:	fffff097          	auipc	ra,0xfffff
    8000593e:	bdc080e7          	jalr	-1060(ra) # 80004516 <readi>
    80005942:	87aa                	mv	a5,a0
    80005944:	fef42623          	sw	a5,-20(s0)
    80005948:	fec42783          	lw	a5,-20(s0)
    8000594c:	2781                	sext.w	a5,a5
    8000594e:	00f05d63          	blez	a5,80005968 <fileread+0x12e>
      f->off += r;
    80005952:	fd843783          	ld	a5,-40(s0)
    80005956:	5398                	lw	a4,32(a5)
    80005958:	fec42783          	lw	a5,-20(s0)
    8000595c:	9fb9                	addw	a5,a5,a4
    8000595e:	0007871b          	sext.w	a4,a5
    80005962:	fd843783          	ld	a5,-40(s0)
    80005966:	d398                	sw	a4,32(a5)
    iunlock(f->ip);
    80005968:	fd843783          	ld	a5,-40(s0)
    8000596c:	6f9c                	ld	a5,24(a5)
    8000596e:	853e                	mv	a0,a5
    80005970:	ffffe097          	auipc	ra,0xffffe
    80005974:	724080e7          	jalr	1828(ra) # 80004094 <iunlock>
    80005978:	a809                	j	8000598a <fileread+0x150>
  } else {
    panic("fileread");
    8000597a:	00006517          	auipc	a0,0x6
    8000597e:	ca650513          	addi	a0,a0,-858 # 8000b620 <etext+0x620>
    80005982:	00003097          	auipc	ra,0x3
    80005986:	5b4080e7          	jalr	1460(ra) # 80008f36 <panic>
  }

  return r;
    8000598a:	fec42783          	lw	a5,-20(s0)
}
    8000598e:	853e                	mv	a0,a5
    80005990:	70e2                	ld	ra,56(sp)
    80005992:	7442                	ld	s0,48(sp)
    80005994:	6121                	addi	sp,sp,64
    80005996:	8082                	ret

0000000080005998 <filewrite>:

// Write to file f.
// addr is a user virtual address.
int
filewrite(struct file *f, uint64 addr, int n)
{
    80005998:	715d                	addi	sp,sp,-80
    8000599a:	e486                	sd	ra,72(sp)
    8000599c:	e0a2                	sd	s0,64(sp)
    8000599e:	0880                	addi	s0,sp,80
    800059a0:	fca43423          	sd	a0,-56(s0)
    800059a4:	fcb43023          	sd	a1,-64(s0)
    800059a8:	87b2                	mv	a5,a2
    800059aa:	faf42e23          	sw	a5,-68(s0)
  int r, ret = 0;
    800059ae:	fe042623          	sw	zero,-20(s0)

  if(f->writable == 0)
    800059b2:	fc843783          	ld	a5,-56(s0)
    800059b6:	0097c783          	lbu	a5,9(a5)
    800059ba:	e399                	bnez	a5,800059c0 <filewrite+0x28>
    return -1;
    800059bc:	57fd                	li	a5,-1
    800059be:	aae1                	j	80005b96 <filewrite+0x1fe>

  if(f->type == FD_PIPE){
    800059c0:	fc843783          	ld	a5,-56(s0)
    800059c4:	439c                	lw	a5,0(a5)
    800059c6:	873e                	mv	a4,a5
    800059c8:	4785                	li	a5,1
    800059ca:	02f71363          	bne	a4,a5,800059f0 <filewrite+0x58>
    ret = pipewrite(f->pipe, addr, n);
    800059ce:	fc843783          	ld	a5,-56(s0)
    800059d2:	6b9c                	ld	a5,16(a5)
    800059d4:	fbc42703          	lw	a4,-68(s0)
    800059d8:	863a                	mv	a2,a4
    800059da:	fc043583          	ld	a1,-64(s0)
    800059de:	853e                	mv	a0,a5
    800059e0:	00000097          	auipc	ra,0x0
    800059e4:	3bc080e7          	jalr	956(ra) # 80005d9c <pipewrite>
    800059e8:	87aa                	mv	a5,a0
    800059ea:	fef42623          	sw	a5,-20(s0)
    800059ee:	a255                	j	80005b92 <filewrite+0x1fa>
  } else if(f->type == FD_DEVICE){
    800059f0:	fc843783          	ld	a5,-56(s0)
    800059f4:	439c                	lw	a5,0(a5)
    800059f6:	873e                	mv	a4,a5
    800059f8:	478d                	li	a5,3
    800059fa:	06f71463          	bne	a4,a5,80005a62 <filewrite+0xca>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    800059fe:	fc843783          	ld	a5,-56(s0)
    80005a02:	02479783          	lh	a5,36(a5)
    80005a06:	0207c663          	bltz	a5,80005a32 <filewrite+0x9a>
    80005a0a:	fc843783          	ld	a5,-56(s0)
    80005a0e:	02479783          	lh	a5,36(a5)
    80005a12:	873e                	mv	a4,a5
    80005a14:	47a5                	li	a5,9
    80005a16:	00e7ce63          	blt	a5,a4,80005a32 <filewrite+0x9a>
    80005a1a:	fc843783          	ld	a5,-56(s0)
    80005a1e:	02479783          	lh	a5,36(a5)
    80005a22:	00016717          	auipc	a4,0x16
    80005a26:	2ee70713          	addi	a4,a4,750 # 8001bd10 <devsw>
    80005a2a:	0792                	slli	a5,a5,0x4
    80005a2c:	97ba                	add	a5,a5,a4
    80005a2e:	679c                	ld	a5,8(a5)
    80005a30:	e399                	bnez	a5,80005a36 <filewrite+0x9e>
      return -1;
    80005a32:	57fd                	li	a5,-1
    80005a34:	a28d                	j	80005b96 <filewrite+0x1fe>
    ret = devsw[f->major].write(1, addr, n);
    80005a36:	fc843783          	ld	a5,-56(s0)
    80005a3a:	02479783          	lh	a5,36(a5)
    80005a3e:	00016717          	auipc	a4,0x16
    80005a42:	2d270713          	addi	a4,a4,722 # 8001bd10 <devsw>
    80005a46:	0792                	slli	a5,a5,0x4
    80005a48:	97ba                	add	a5,a5,a4
    80005a4a:	679c                	ld	a5,8(a5)
    80005a4c:	fbc42703          	lw	a4,-68(s0)
    80005a50:	863a                	mv	a2,a4
    80005a52:	fc043583          	ld	a1,-64(s0)
    80005a56:	4505                	li	a0,1
    80005a58:	9782                	jalr	a5
    80005a5a:	87aa                	mv	a5,a0
    80005a5c:	fef42623          	sw	a5,-20(s0)
    80005a60:	aa0d                	j	80005b92 <filewrite+0x1fa>
  } else if(f->type == FD_INODE){
    80005a62:	fc843783          	ld	a5,-56(s0)
    80005a66:	439c                	lw	a5,0(a5)
    80005a68:	873e                	mv	a4,a5
    80005a6a:	4789                	li	a5,2
    80005a6c:	10f71b63          	bne	a4,a5,80005b82 <filewrite+0x1ea>
    // the maximum log transaction size, including
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
    80005a70:	6785                	lui	a5,0x1
    80005a72:	c0078793          	addi	a5,a5,-1024 # c00 <_entry-0x7ffff400>
    80005a76:	fef42023          	sw	a5,-32(s0)
    int i = 0;
    80005a7a:	fe042423          	sw	zero,-24(s0)
    while(i < n){
    80005a7e:	a0f9                	j	80005b4c <filewrite+0x1b4>
      int n1 = n - i;
    80005a80:	fbc42783          	lw	a5,-68(s0)
    80005a84:	873e                	mv	a4,a5
    80005a86:	fe842783          	lw	a5,-24(s0)
    80005a8a:	40f707bb          	subw	a5,a4,a5
    80005a8e:	fef42223          	sw	a5,-28(s0)
      if(n1 > max)
    80005a92:	fe442783          	lw	a5,-28(s0)
    80005a96:	873e                	mv	a4,a5
    80005a98:	fe042783          	lw	a5,-32(s0)
    80005a9c:	2701                	sext.w	a4,a4
    80005a9e:	2781                	sext.w	a5,a5
    80005aa0:	00e7d663          	bge	a5,a4,80005aac <filewrite+0x114>
        n1 = max;
    80005aa4:	fe042783          	lw	a5,-32(s0)
    80005aa8:	fef42223          	sw	a5,-28(s0)

      begin_op();
    80005aac:	fffff097          	auipc	ra,0xfffff
    80005ab0:	548080e7          	jalr	1352(ra) # 80004ff4 <begin_op>
      ilock(f->ip);
    80005ab4:	fc843783          	ld	a5,-56(s0)
    80005ab8:	6f9c                	ld	a5,24(a5)
    80005aba:	853e                	mv	a0,a5
    80005abc:	ffffe097          	auipc	ra,0xffffe
    80005ac0:	4a4080e7          	jalr	1188(ra) # 80003f60 <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    80005ac4:	fc843783          	ld	a5,-56(s0)
    80005ac8:	6f88                	ld	a0,24(a5)
    80005aca:	fe842703          	lw	a4,-24(s0)
    80005ace:	fc043783          	ld	a5,-64(s0)
    80005ad2:	00f70633          	add	a2,a4,a5
    80005ad6:	fc843783          	ld	a5,-56(s0)
    80005ada:	539c                	lw	a5,32(a5)
    80005adc:	fe442703          	lw	a4,-28(s0)
    80005ae0:	86be                	mv	a3,a5
    80005ae2:	4585                	li	a1,1
    80005ae4:	fffff097          	auipc	ra,0xfffff
    80005ae8:	bd0080e7          	jalr	-1072(ra) # 800046b4 <writei>
    80005aec:	87aa                	mv	a5,a0
    80005aee:	fcf42e23          	sw	a5,-36(s0)
    80005af2:	fdc42783          	lw	a5,-36(s0)
    80005af6:	2781                	sext.w	a5,a5
    80005af8:	00f05d63          	blez	a5,80005b12 <filewrite+0x17a>
        f->off += r;
    80005afc:	fc843783          	ld	a5,-56(s0)
    80005b00:	5398                	lw	a4,32(a5)
    80005b02:	fdc42783          	lw	a5,-36(s0)
    80005b06:	9fb9                	addw	a5,a5,a4
    80005b08:	0007871b          	sext.w	a4,a5
    80005b0c:	fc843783          	ld	a5,-56(s0)
    80005b10:	d398                	sw	a4,32(a5)
      iunlock(f->ip);
    80005b12:	fc843783          	ld	a5,-56(s0)
    80005b16:	6f9c                	ld	a5,24(a5)
    80005b18:	853e                	mv	a0,a5
    80005b1a:	ffffe097          	auipc	ra,0xffffe
    80005b1e:	57a080e7          	jalr	1402(ra) # 80004094 <iunlock>
      end_op();
    80005b22:	fffff097          	auipc	ra,0xfffff
    80005b26:	594080e7          	jalr	1428(ra) # 800050b6 <end_op>

      if(r != n1){
    80005b2a:	fdc42783          	lw	a5,-36(s0)
    80005b2e:	873e                	mv	a4,a5
    80005b30:	fe442783          	lw	a5,-28(s0)
    80005b34:	2701                	sext.w	a4,a4
    80005b36:	2781                	sext.w	a5,a5
    80005b38:	02f71463          	bne	a4,a5,80005b60 <filewrite+0x1c8>
        // error from writei
        break;
      }
      i += r;
    80005b3c:	fe842783          	lw	a5,-24(s0)
    80005b40:	873e                	mv	a4,a5
    80005b42:	fdc42783          	lw	a5,-36(s0)
    80005b46:	9fb9                	addw	a5,a5,a4
    80005b48:	fef42423          	sw	a5,-24(s0)
    while(i < n){
    80005b4c:	fe842783          	lw	a5,-24(s0)
    80005b50:	873e                	mv	a4,a5
    80005b52:	fbc42783          	lw	a5,-68(s0)
    80005b56:	2701                	sext.w	a4,a4
    80005b58:	2781                	sext.w	a5,a5
    80005b5a:	f2f743e3          	blt	a4,a5,80005a80 <filewrite+0xe8>
    80005b5e:	a011                	j	80005b62 <filewrite+0x1ca>
        break;
    80005b60:	0001                	nop
    }
    ret = (i == n ? n : -1);
    80005b62:	fe842783          	lw	a5,-24(s0)
    80005b66:	873e                	mv	a4,a5
    80005b68:	fbc42783          	lw	a5,-68(s0)
    80005b6c:	2701                	sext.w	a4,a4
    80005b6e:	2781                	sext.w	a5,a5
    80005b70:	00f71563          	bne	a4,a5,80005b7a <filewrite+0x1e2>
    80005b74:	fbc42783          	lw	a5,-68(s0)
    80005b78:	a011                	j	80005b7c <filewrite+0x1e4>
    80005b7a:	57fd                	li	a5,-1
    80005b7c:	fef42623          	sw	a5,-20(s0)
    80005b80:	a809                	j	80005b92 <filewrite+0x1fa>
  } else {
    panic("filewrite");
    80005b82:	00006517          	auipc	a0,0x6
    80005b86:	aae50513          	addi	a0,a0,-1362 # 8000b630 <etext+0x630>
    80005b8a:	00003097          	auipc	ra,0x3
    80005b8e:	3ac080e7          	jalr	940(ra) # 80008f36 <panic>
  }

  return ret;
    80005b92:	fec42783          	lw	a5,-20(s0)
}
    80005b96:	853e                	mv	a0,a5
    80005b98:	60a6                	ld	ra,72(sp)
    80005b9a:	6406                	ld	s0,64(sp)
    80005b9c:	6161                	addi	sp,sp,80
    80005b9e:	8082                	ret

0000000080005ba0 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    80005ba0:	7179                	addi	sp,sp,-48
    80005ba2:	f406                	sd	ra,40(sp)
    80005ba4:	f022                	sd	s0,32(sp)
    80005ba6:	1800                	addi	s0,sp,48
    80005ba8:	fca43c23          	sd	a0,-40(s0)
    80005bac:	fcb43823          	sd	a1,-48(s0)
  struct pipe *pi;

  pi = 0;
    80005bb0:	fe043423          	sd	zero,-24(s0)
  *f0 = *f1 = 0;
    80005bb4:	fd043783          	ld	a5,-48(s0)
    80005bb8:	0007b023          	sd	zero,0(a5)
    80005bbc:	fd043783          	ld	a5,-48(s0)
    80005bc0:	6398                	ld	a4,0(a5)
    80005bc2:	fd843783          	ld	a5,-40(s0)
    80005bc6:	e398                	sd	a4,0(a5)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    80005bc8:	00000097          	auipc	ra,0x0
    80005bcc:	9dc080e7          	jalr	-1572(ra) # 800055a4 <filealloc>
    80005bd0:	872a                	mv	a4,a0
    80005bd2:	fd843783          	ld	a5,-40(s0)
    80005bd6:	e398                	sd	a4,0(a5)
    80005bd8:	fd843783          	ld	a5,-40(s0)
    80005bdc:	639c                	ld	a5,0(a5)
    80005bde:	c3e9                	beqz	a5,80005ca0 <pipealloc+0x100>
    80005be0:	00000097          	auipc	ra,0x0
    80005be4:	9c4080e7          	jalr	-1596(ra) # 800055a4 <filealloc>
    80005be8:	872a                	mv	a4,a0
    80005bea:	fd043783          	ld	a5,-48(s0)
    80005bee:	e398                	sd	a4,0(a5)
    80005bf0:	fd043783          	ld	a5,-48(s0)
    80005bf4:	639c                	ld	a5,0(a5)
    80005bf6:	c7cd                	beqz	a5,80005ca0 <pipealloc+0x100>
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    80005bf8:	ffffa097          	auipc	ra,0xffffa
    80005bfc:	560080e7          	jalr	1376(ra) # 80000158 <kalloc>
    80005c00:	fea43423          	sd	a0,-24(s0)
    80005c04:	fe843783          	ld	a5,-24(s0)
    80005c08:	cfd1                	beqz	a5,80005ca4 <pipealloc+0x104>
    goto bad;
  pi->readopen = 1;
    80005c0a:	fe843783          	ld	a5,-24(s0)
    80005c0e:	4705                	li	a4,1
    80005c10:	22e7a023          	sw	a4,544(a5)
  pi->writeopen = 1;
    80005c14:	fe843783          	ld	a5,-24(s0)
    80005c18:	4705                	li	a4,1
    80005c1a:	22e7a223          	sw	a4,548(a5)
  pi->nwrite = 0;
    80005c1e:	fe843783          	ld	a5,-24(s0)
    80005c22:	2007ae23          	sw	zero,540(a5)
  pi->nread = 0;
    80005c26:	fe843783          	ld	a5,-24(s0)
    80005c2a:	2007ac23          	sw	zero,536(a5)
  initlock(&pi->lock, "pipe");
    80005c2e:	fe843783          	ld	a5,-24(s0)
    80005c32:	00006597          	auipc	a1,0x6
    80005c36:	a0e58593          	addi	a1,a1,-1522 # 8000b640 <etext+0x640>
    80005c3a:	853e                	mv	a0,a5
    80005c3c:	00003097          	auipc	ra,0x3
    80005c40:	712080e7          	jalr	1810(ra) # 8000934e <initlock>
  (*f0)->type = FD_PIPE;
    80005c44:	fd843783          	ld	a5,-40(s0)
    80005c48:	639c                	ld	a5,0(a5)
    80005c4a:	4705                	li	a4,1
    80005c4c:	c398                	sw	a4,0(a5)
  (*f0)->readable = 1;
    80005c4e:	fd843783          	ld	a5,-40(s0)
    80005c52:	639c                	ld	a5,0(a5)
    80005c54:	4705                	li	a4,1
    80005c56:	00e78423          	sb	a4,8(a5)
  (*f0)->writable = 0;
    80005c5a:	fd843783          	ld	a5,-40(s0)
    80005c5e:	639c                	ld	a5,0(a5)
    80005c60:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    80005c64:	fd843783          	ld	a5,-40(s0)
    80005c68:	639c                	ld	a5,0(a5)
    80005c6a:	fe843703          	ld	a4,-24(s0)
    80005c6e:	eb98                	sd	a4,16(a5)
  (*f1)->type = FD_PIPE;
    80005c70:	fd043783          	ld	a5,-48(s0)
    80005c74:	639c                	ld	a5,0(a5)
    80005c76:	4705                	li	a4,1
    80005c78:	c398                	sw	a4,0(a5)
  (*f1)->readable = 0;
    80005c7a:	fd043783          	ld	a5,-48(s0)
    80005c7e:	639c                	ld	a5,0(a5)
    80005c80:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    80005c84:	fd043783          	ld	a5,-48(s0)
    80005c88:	639c                	ld	a5,0(a5)
    80005c8a:	4705                	li	a4,1
    80005c8c:	00e784a3          	sb	a4,9(a5)
  (*f1)->pipe = pi;
    80005c90:	fd043783          	ld	a5,-48(s0)
    80005c94:	639c                	ld	a5,0(a5)
    80005c96:	fe843703          	ld	a4,-24(s0)
    80005c9a:	eb98                	sd	a4,16(a5)
  return 0;
    80005c9c:	4781                	li	a5,0
    80005c9e:	a0b1                	j	80005cea <pipealloc+0x14a>
    goto bad;
    80005ca0:	0001                	nop
    80005ca2:	a011                	j	80005ca6 <pipealloc+0x106>
    goto bad;
    80005ca4:	0001                	nop

 bad:
  if(pi)
    80005ca6:	fe843783          	ld	a5,-24(s0)
    80005caa:	c799                	beqz	a5,80005cb8 <pipealloc+0x118>
    kfree((char*)pi);
    80005cac:	fe843503          	ld	a0,-24(s0)
    80005cb0:	ffffa097          	auipc	ra,0xffffa
    80005cb4:	404080e7          	jalr	1028(ra) # 800000b4 <kfree>
  if(*f0)
    80005cb8:	fd843783          	ld	a5,-40(s0)
    80005cbc:	639c                	ld	a5,0(a5)
    80005cbe:	cb89                	beqz	a5,80005cd0 <pipealloc+0x130>
    fileclose(*f0);
    80005cc0:	fd843783          	ld	a5,-40(s0)
    80005cc4:	639c                	ld	a5,0(a5)
    80005cc6:	853e                	mv	a0,a5
    80005cc8:	00000097          	auipc	ra,0x0
    80005ccc:	9c6080e7          	jalr	-1594(ra) # 8000568e <fileclose>
  if(*f1)
    80005cd0:	fd043783          	ld	a5,-48(s0)
    80005cd4:	639c                	ld	a5,0(a5)
    80005cd6:	cb89                	beqz	a5,80005ce8 <pipealloc+0x148>
    fileclose(*f1);
    80005cd8:	fd043783          	ld	a5,-48(s0)
    80005cdc:	639c                	ld	a5,0(a5)
    80005cde:	853e                	mv	a0,a5
    80005ce0:	00000097          	auipc	ra,0x0
    80005ce4:	9ae080e7          	jalr	-1618(ra) # 8000568e <fileclose>
  return -1;
    80005ce8:	57fd                	li	a5,-1
}
    80005cea:	853e                	mv	a0,a5
    80005cec:	70a2                	ld	ra,40(sp)
    80005cee:	7402                	ld	s0,32(sp)
    80005cf0:	6145                	addi	sp,sp,48
    80005cf2:	8082                	ret

0000000080005cf4 <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    80005cf4:	1101                	addi	sp,sp,-32
    80005cf6:	ec06                	sd	ra,24(sp)
    80005cf8:	e822                	sd	s0,16(sp)
    80005cfa:	1000                	addi	s0,sp,32
    80005cfc:	fea43423          	sd	a0,-24(s0)
    80005d00:	87ae                	mv	a5,a1
    80005d02:	fef42223          	sw	a5,-28(s0)
  acquire(&pi->lock);
    80005d06:	fe843783          	ld	a5,-24(s0)
    80005d0a:	853e                	mv	a0,a5
    80005d0c:	00003097          	auipc	ra,0x3
    80005d10:	672080e7          	jalr	1650(ra) # 8000937e <acquire>
  if(writable){
    80005d14:	fe442783          	lw	a5,-28(s0)
    80005d18:	2781                	sext.w	a5,a5
    80005d1a:	cf99                	beqz	a5,80005d38 <pipeclose+0x44>
    pi->writeopen = 0;
    80005d1c:	fe843783          	ld	a5,-24(s0)
    80005d20:	2207a223          	sw	zero,548(a5)
    wakeup(&pi->nread);
    80005d24:	fe843783          	ld	a5,-24(s0)
    80005d28:	21878793          	addi	a5,a5,536
    80005d2c:	853e                	mv	a0,a5
    80005d2e:	ffffc097          	auipc	ra,0xffffc
    80005d32:	528080e7          	jalr	1320(ra) # 80002256 <wakeup>
    80005d36:	a831                	j	80005d52 <pipeclose+0x5e>
  } else {
    pi->readopen = 0;
    80005d38:	fe843783          	ld	a5,-24(s0)
    80005d3c:	2207a023          	sw	zero,544(a5)
    wakeup(&pi->nwrite);
    80005d40:	fe843783          	ld	a5,-24(s0)
    80005d44:	21c78793          	addi	a5,a5,540
    80005d48:	853e                	mv	a0,a5
    80005d4a:	ffffc097          	auipc	ra,0xffffc
    80005d4e:	50c080e7          	jalr	1292(ra) # 80002256 <wakeup>
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    80005d52:	fe843783          	ld	a5,-24(s0)
    80005d56:	2207a783          	lw	a5,544(a5)
    80005d5a:	e785                	bnez	a5,80005d82 <pipeclose+0x8e>
    80005d5c:	fe843783          	ld	a5,-24(s0)
    80005d60:	2247a783          	lw	a5,548(a5)
    80005d64:	ef99                	bnez	a5,80005d82 <pipeclose+0x8e>
    release(&pi->lock);
    80005d66:	fe843783          	ld	a5,-24(s0)
    80005d6a:	853e                	mv	a0,a5
    80005d6c:	00003097          	auipc	ra,0x3
    80005d70:	676080e7          	jalr	1654(ra) # 800093e2 <release>
    kfree((char*)pi);
    80005d74:	fe843503          	ld	a0,-24(s0)
    80005d78:	ffffa097          	auipc	ra,0xffffa
    80005d7c:	33c080e7          	jalr	828(ra) # 800000b4 <kfree>
    80005d80:	a809                	j	80005d92 <pipeclose+0x9e>
  } else
    release(&pi->lock);
    80005d82:	fe843783          	ld	a5,-24(s0)
    80005d86:	853e                	mv	a0,a5
    80005d88:	00003097          	auipc	ra,0x3
    80005d8c:	65a080e7          	jalr	1626(ra) # 800093e2 <release>
}
    80005d90:	0001                	nop
    80005d92:	0001                	nop
    80005d94:	60e2                	ld	ra,24(sp)
    80005d96:	6442                	ld	s0,16(sp)
    80005d98:	6105                	addi	sp,sp,32
    80005d9a:	8082                	ret

0000000080005d9c <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    80005d9c:	715d                	addi	sp,sp,-80
    80005d9e:	e486                	sd	ra,72(sp)
    80005da0:	e0a2                	sd	s0,64(sp)
    80005da2:	0880                	addi	s0,sp,80
    80005da4:	fca43423          	sd	a0,-56(s0)
    80005da8:	fcb43023          	sd	a1,-64(s0)
    80005dac:	87b2                	mv	a5,a2
    80005dae:	faf42e23          	sw	a5,-68(s0)
  int i = 0;
    80005db2:	fe042623          	sw	zero,-20(s0)
  struct proc *pr = myproc();
    80005db6:	ffffc097          	auipc	ra,0xffffc
    80005dba:	84a080e7          	jalr	-1974(ra) # 80001600 <myproc>
    80005dbe:	fea43023          	sd	a0,-32(s0)

  acquire(&pi->lock);
    80005dc2:	fc843783          	ld	a5,-56(s0)
    80005dc6:	853e                	mv	a0,a5
    80005dc8:	00003097          	auipc	ra,0x3
    80005dcc:	5b6080e7          	jalr	1462(ra) # 8000937e <acquire>
  while(i < n){
    80005dd0:	a8f1                	j	80005eac <pipewrite+0x110>
    if(pi->readopen == 0 || killed(pr)){
    80005dd2:	fc843783          	ld	a5,-56(s0)
    80005dd6:	2207a783          	lw	a5,544(a5)
    80005dda:	cb89                	beqz	a5,80005dec <pipewrite+0x50>
    80005ddc:	fe043503          	ld	a0,-32(s0)
    80005de0:	ffffc097          	auipc	ra,0xffffc
    80005de4:	5e4080e7          	jalr	1508(ra) # 800023c4 <killed>
    80005de8:	87aa                	mv	a5,a0
    80005dea:	cb91                	beqz	a5,80005dfe <pipewrite+0x62>
      release(&pi->lock);
    80005dec:	fc843783          	ld	a5,-56(s0)
    80005df0:	853e                	mv	a0,a5
    80005df2:	00003097          	auipc	ra,0x3
    80005df6:	5f0080e7          	jalr	1520(ra) # 800093e2 <release>
      return -1;
    80005dfa:	57fd                	li	a5,-1
    80005dfc:	a0ed                	j	80005ee6 <pipewrite+0x14a>
    }
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
    80005dfe:	fc843783          	ld	a5,-56(s0)
    80005e02:	21c7a703          	lw	a4,540(a5)
    80005e06:	fc843783          	ld	a5,-56(s0)
    80005e0a:	2187a783          	lw	a5,536(a5)
    80005e0e:	2007879b          	addiw	a5,a5,512
    80005e12:	2781                	sext.w	a5,a5
    80005e14:	02f71863          	bne	a4,a5,80005e44 <pipewrite+0xa8>
      wakeup(&pi->nread);
    80005e18:	fc843783          	ld	a5,-56(s0)
    80005e1c:	21878793          	addi	a5,a5,536
    80005e20:	853e                	mv	a0,a5
    80005e22:	ffffc097          	auipc	ra,0xffffc
    80005e26:	434080e7          	jalr	1076(ra) # 80002256 <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    80005e2a:	fc843783          	ld	a5,-56(s0)
    80005e2e:	21c78793          	addi	a5,a5,540
    80005e32:	fc843703          	ld	a4,-56(s0)
    80005e36:	85ba                	mv	a1,a4
    80005e38:	853e                	mv	a0,a5
    80005e3a:	ffffc097          	auipc	ra,0xffffc
    80005e3e:	3a0080e7          	jalr	928(ra) # 800021da <sleep>
    80005e42:	a0ad                	j	80005eac <pipewrite+0x110>
    } else {
      char ch;
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80005e44:	fe043783          	ld	a5,-32(s0)
    80005e48:	6ba8                	ld	a0,80(a5)
    80005e4a:	fec42703          	lw	a4,-20(s0)
    80005e4e:	fc043783          	ld	a5,-64(s0)
    80005e52:	973e                	add	a4,a4,a5
    80005e54:	fdf40793          	addi	a5,s0,-33
    80005e58:	4685                	li	a3,1
    80005e5a:	863a                	mv	a2,a4
    80005e5c:	85be                	mv	a1,a5
    80005e5e:	ffffb097          	auipc	ra,0xffffb
    80005e62:	33a080e7          	jalr	826(ra) # 80001198 <copyin>
    80005e66:	87aa                	mv	a5,a0
    80005e68:	873e                	mv	a4,a5
    80005e6a:	57fd                	li	a5,-1
    80005e6c:	04f70a63          	beq	a4,a5,80005ec0 <pipewrite+0x124>
        break;
      pi->data[pi->nwrite++ % PIPESIZE] = ch;
    80005e70:	fc843783          	ld	a5,-56(s0)
    80005e74:	21c7a783          	lw	a5,540(a5)
    80005e78:	2781                	sext.w	a5,a5
    80005e7a:	0017871b          	addiw	a4,a5,1
    80005e7e:	0007069b          	sext.w	a3,a4
    80005e82:	fc843703          	ld	a4,-56(s0)
    80005e86:	20d72e23          	sw	a3,540(a4)
    80005e8a:	1ff7f793          	andi	a5,a5,511
    80005e8e:	2781                	sext.w	a5,a5
    80005e90:	fdf44703          	lbu	a4,-33(s0)
    80005e94:	fc843683          	ld	a3,-56(s0)
    80005e98:	1782                	slli	a5,a5,0x20
    80005e9a:	9381                	srli	a5,a5,0x20
    80005e9c:	97b6                	add	a5,a5,a3
    80005e9e:	00e78c23          	sb	a4,24(a5)
      i++;
    80005ea2:	fec42783          	lw	a5,-20(s0)
    80005ea6:	2785                	addiw	a5,a5,1
    80005ea8:	fef42623          	sw	a5,-20(s0)
  while(i < n){
    80005eac:	fec42783          	lw	a5,-20(s0)
    80005eb0:	873e                	mv	a4,a5
    80005eb2:	fbc42783          	lw	a5,-68(s0)
    80005eb6:	2701                	sext.w	a4,a4
    80005eb8:	2781                	sext.w	a5,a5
    80005eba:	f0f74ce3          	blt	a4,a5,80005dd2 <pipewrite+0x36>
    80005ebe:	a011                	j	80005ec2 <pipewrite+0x126>
        break;
    80005ec0:	0001                	nop
    }
  }
  wakeup(&pi->nread);
    80005ec2:	fc843783          	ld	a5,-56(s0)
    80005ec6:	21878793          	addi	a5,a5,536
    80005eca:	853e                	mv	a0,a5
    80005ecc:	ffffc097          	auipc	ra,0xffffc
    80005ed0:	38a080e7          	jalr	906(ra) # 80002256 <wakeup>
  release(&pi->lock);
    80005ed4:	fc843783          	ld	a5,-56(s0)
    80005ed8:	853e                	mv	a0,a5
    80005eda:	00003097          	auipc	ra,0x3
    80005ede:	508080e7          	jalr	1288(ra) # 800093e2 <release>

  return i;
    80005ee2:	fec42783          	lw	a5,-20(s0)
}
    80005ee6:	853e                	mv	a0,a5
    80005ee8:	60a6                	ld	ra,72(sp)
    80005eea:	6406                	ld	s0,64(sp)
    80005eec:	6161                	addi	sp,sp,80
    80005eee:	8082                	ret

0000000080005ef0 <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    80005ef0:	715d                	addi	sp,sp,-80
    80005ef2:	e486                	sd	ra,72(sp)
    80005ef4:	e0a2                	sd	s0,64(sp)
    80005ef6:	0880                	addi	s0,sp,80
    80005ef8:	fca43423          	sd	a0,-56(s0)
    80005efc:	fcb43023          	sd	a1,-64(s0)
    80005f00:	87b2                	mv	a5,a2
    80005f02:	faf42e23          	sw	a5,-68(s0)
  int i;
  struct proc *pr = myproc();
    80005f06:	ffffb097          	auipc	ra,0xffffb
    80005f0a:	6fa080e7          	jalr	1786(ra) # 80001600 <myproc>
    80005f0e:	fea43023          	sd	a0,-32(s0)
  char ch;

  acquire(&pi->lock);
    80005f12:	fc843783          	ld	a5,-56(s0)
    80005f16:	853e                	mv	a0,a5
    80005f18:	00003097          	auipc	ra,0x3
    80005f1c:	466080e7          	jalr	1126(ra) # 8000937e <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80005f20:	a835                	j	80005f5c <piperead+0x6c>
    if(killed(pr)){
    80005f22:	fe043503          	ld	a0,-32(s0)
    80005f26:	ffffc097          	auipc	ra,0xffffc
    80005f2a:	49e080e7          	jalr	1182(ra) # 800023c4 <killed>
    80005f2e:	87aa                	mv	a5,a0
    80005f30:	cb91                	beqz	a5,80005f44 <piperead+0x54>
      release(&pi->lock);
    80005f32:	fc843783          	ld	a5,-56(s0)
    80005f36:	853e                	mv	a0,a5
    80005f38:	00003097          	auipc	ra,0x3
    80005f3c:	4aa080e7          	jalr	1194(ra) # 800093e2 <release>
      return -1;
    80005f40:	57fd                	li	a5,-1
    80005f42:	a8e5                	j	8000603a <piperead+0x14a>
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80005f44:	fc843783          	ld	a5,-56(s0)
    80005f48:	21878793          	addi	a5,a5,536
    80005f4c:	fc843703          	ld	a4,-56(s0)
    80005f50:	85ba                	mv	a1,a4
    80005f52:	853e                	mv	a0,a5
    80005f54:	ffffc097          	auipc	ra,0xffffc
    80005f58:	286080e7          	jalr	646(ra) # 800021da <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80005f5c:	fc843783          	ld	a5,-56(s0)
    80005f60:	2187a703          	lw	a4,536(a5)
    80005f64:	fc843783          	ld	a5,-56(s0)
    80005f68:	21c7a783          	lw	a5,540(a5)
    80005f6c:	00f71763          	bne	a4,a5,80005f7a <piperead+0x8a>
    80005f70:	fc843783          	ld	a5,-56(s0)
    80005f74:	2247a783          	lw	a5,548(a5)
    80005f78:	f7cd                	bnez	a5,80005f22 <piperead+0x32>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80005f7a:	fe042623          	sw	zero,-20(s0)
    80005f7e:	a8bd                	j	80005ffc <piperead+0x10c>
    if(pi->nread == pi->nwrite)
    80005f80:	fc843783          	ld	a5,-56(s0)
    80005f84:	2187a703          	lw	a4,536(a5)
    80005f88:	fc843783          	ld	a5,-56(s0)
    80005f8c:	21c7a783          	lw	a5,540(a5)
    80005f90:	08f70063          	beq	a4,a5,80006010 <piperead+0x120>
      break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    80005f94:	fc843783          	ld	a5,-56(s0)
    80005f98:	2187a783          	lw	a5,536(a5)
    80005f9c:	2781                	sext.w	a5,a5
    80005f9e:	0017871b          	addiw	a4,a5,1
    80005fa2:	0007069b          	sext.w	a3,a4
    80005fa6:	fc843703          	ld	a4,-56(s0)
    80005faa:	20d72c23          	sw	a3,536(a4)
    80005fae:	1ff7f793          	andi	a5,a5,511
    80005fb2:	2781                	sext.w	a5,a5
    80005fb4:	fc843703          	ld	a4,-56(s0)
    80005fb8:	1782                	slli	a5,a5,0x20
    80005fba:	9381                	srli	a5,a5,0x20
    80005fbc:	97ba                	add	a5,a5,a4
    80005fbe:	0187c783          	lbu	a5,24(a5)
    80005fc2:	fcf40fa3          	sb	a5,-33(s0)
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80005fc6:	fe043783          	ld	a5,-32(s0)
    80005fca:	6ba8                	ld	a0,80(a5)
    80005fcc:	fec42703          	lw	a4,-20(s0)
    80005fd0:	fc043783          	ld	a5,-64(s0)
    80005fd4:	97ba                	add	a5,a5,a4
    80005fd6:	fdf40713          	addi	a4,s0,-33
    80005fda:	4685                	li	a3,1
    80005fdc:	863a                	mv	a2,a4
    80005fde:	85be                	mv	a1,a5
    80005fe0:	ffffb097          	auipc	ra,0xffffb
    80005fe4:	0ea080e7          	jalr	234(ra) # 800010ca <copyout>
    80005fe8:	87aa                	mv	a5,a0
    80005fea:	873e                	mv	a4,a5
    80005fec:	57fd                	li	a5,-1
    80005fee:	02f70363          	beq	a4,a5,80006014 <piperead+0x124>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80005ff2:	fec42783          	lw	a5,-20(s0)
    80005ff6:	2785                	addiw	a5,a5,1
    80005ff8:	fef42623          	sw	a5,-20(s0)
    80005ffc:	fec42783          	lw	a5,-20(s0)
    80006000:	873e                	mv	a4,a5
    80006002:	fbc42783          	lw	a5,-68(s0)
    80006006:	2701                	sext.w	a4,a4
    80006008:	2781                	sext.w	a5,a5
    8000600a:	f6f74be3          	blt	a4,a5,80005f80 <piperead+0x90>
    8000600e:	a021                	j	80006016 <piperead+0x126>
      break;
    80006010:	0001                	nop
    80006012:	a011                	j	80006016 <piperead+0x126>
      break;
    80006014:	0001                	nop
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    80006016:	fc843783          	ld	a5,-56(s0)
    8000601a:	21c78793          	addi	a5,a5,540
    8000601e:	853e                	mv	a0,a5
    80006020:	ffffc097          	auipc	ra,0xffffc
    80006024:	236080e7          	jalr	566(ra) # 80002256 <wakeup>
  release(&pi->lock);
    80006028:	fc843783          	ld	a5,-56(s0)
    8000602c:	853e                	mv	a0,a5
    8000602e:	00003097          	auipc	ra,0x3
    80006032:	3b4080e7          	jalr	948(ra) # 800093e2 <release>
  return i;
    80006036:	fec42783          	lw	a5,-20(s0)
}
    8000603a:	853e                	mv	a0,a5
    8000603c:	60a6                	ld	ra,72(sp)
    8000603e:	6406                	ld	s0,64(sp)
    80006040:	6161                	addi	sp,sp,80
    80006042:	8082                	ret

0000000080006044 <flags2perm>:
#include "elf.h"

static int loadseg(pde_t *, uint64, struct inode *, uint, uint);

int flags2perm(int flags)
{
    80006044:	7179                	addi	sp,sp,-48
    80006046:	f422                	sd	s0,40(sp)
    80006048:	1800                	addi	s0,sp,48
    8000604a:	87aa                	mv	a5,a0
    8000604c:	fcf42e23          	sw	a5,-36(s0)
    int perm = 0;
    80006050:	fe042623          	sw	zero,-20(s0)
    if(flags & 0x1)
    80006054:	fdc42783          	lw	a5,-36(s0)
    80006058:	8b85                	andi	a5,a5,1
    8000605a:	2781                	sext.w	a5,a5
    8000605c:	c781                	beqz	a5,80006064 <flags2perm+0x20>
      perm = PTE_X;
    8000605e:	47a1                	li	a5,8
    80006060:	fef42623          	sw	a5,-20(s0)
    if(flags & 0x2)
    80006064:	fdc42783          	lw	a5,-36(s0)
    80006068:	8b89                	andi	a5,a5,2
    8000606a:	2781                	sext.w	a5,a5
    8000606c:	c799                	beqz	a5,8000607a <flags2perm+0x36>
      perm |= PTE_W;
    8000606e:	fec42783          	lw	a5,-20(s0)
    80006072:	0047e793          	ori	a5,a5,4
    80006076:	fef42623          	sw	a5,-20(s0)
    return perm;
    8000607a:	fec42783          	lw	a5,-20(s0)
}
    8000607e:	853e                	mv	a0,a5
    80006080:	7422                	ld	s0,40(sp)
    80006082:	6145                	addi	sp,sp,48
    80006084:	8082                	ret

0000000080006086 <exec>:

int
exec(char *path, char **argv)
{
    80006086:	de010113          	addi	sp,sp,-544
    8000608a:	20113c23          	sd	ra,536(sp)
    8000608e:	20813823          	sd	s0,528(sp)
    80006092:	20913423          	sd	s1,520(sp)
    80006096:	1400                	addi	s0,sp,544
    80006098:	dea43423          	sd	a0,-536(s0)
    8000609c:	deb43023          	sd	a1,-544(s0)
  char *s, *last;
  int i, off;
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    800060a0:	fa043c23          	sd	zero,-72(s0)
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
    800060a4:	fa043023          	sd	zero,-96(s0)
  struct proc *p = myproc();
    800060a8:	ffffb097          	auipc	ra,0xffffb
    800060ac:	558080e7          	jalr	1368(ra) # 80001600 <myproc>
    800060b0:	f8a43c23          	sd	a0,-104(s0)

  begin_op();
    800060b4:	fffff097          	auipc	ra,0xfffff
    800060b8:	f40080e7          	jalr	-192(ra) # 80004ff4 <begin_op>

  if((ip = namei(path)) == 0){
    800060bc:	de843503          	ld	a0,-536(s0)
    800060c0:	fffff097          	auipc	ra,0xfffff
    800060c4:	bd0080e7          	jalr	-1072(ra) # 80004c90 <namei>
    800060c8:	faa43423          	sd	a0,-88(s0)
    800060cc:	fa843783          	ld	a5,-88(s0)
    800060d0:	e799                	bnez	a5,800060de <exec+0x58>
    end_op();
    800060d2:	fffff097          	auipc	ra,0xfffff
    800060d6:	fe4080e7          	jalr	-28(ra) # 800050b6 <end_op>
    return -1;
    800060da:	57fd                	li	a5,-1
    800060dc:	a199                	j	80006522 <exec+0x49c>
  }
  ilock(ip);
    800060de:	fa843503          	ld	a0,-88(s0)
    800060e2:	ffffe097          	auipc	ra,0xffffe
    800060e6:	e7e080e7          	jalr	-386(ra) # 80003f60 <ilock>

  // Check ELF header
  if(readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    800060ea:	e3040793          	addi	a5,s0,-464
    800060ee:	04000713          	li	a4,64
    800060f2:	4681                	li	a3,0
    800060f4:	863e                	mv	a2,a5
    800060f6:	4581                	li	a1,0
    800060f8:	fa843503          	ld	a0,-88(s0)
    800060fc:	ffffe097          	auipc	ra,0xffffe
    80006100:	41a080e7          	jalr	1050(ra) # 80004516 <readi>
    80006104:	87aa                	mv	a5,a0
    80006106:	873e                	mv	a4,a5
    80006108:	04000793          	li	a5,64
    8000610c:	3af71563          	bne	a4,a5,800064b6 <exec+0x430>
    goto bad;

  if(elf.magic != ELF_MAGIC)
    80006110:	e3042783          	lw	a5,-464(s0)
    80006114:	873e                	mv	a4,a5
    80006116:	464c47b7          	lui	a5,0x464c4
    8000611a:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    8000611e:	38f71e63          	bne	a4,a5,800064ba <exec+0x434>
    goto bad;

  if((pagetable = proc_pagetable(p)) == 0)
    80006122:	f9843503          	ld	a0,-104(s0)
    80006126:	ffffb097          	auipc	ra,0xffffb
    8000612a:	73c080e7          	jalr	1852(ra) # 80001862 <proc_pagetable>
    8000612e:	faa43023          	sd	a0,-96(s0)
    80006132:	fa043783          	ld	a5,-96(s0)
    80006136:	38078463          	beqz	a5,800064be <exec+0x438>
    goto bad;

  // Load program into memory.
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    8000613a:	fc042623          	sw	zero,-52(s0)
    8000613e:	e5043783          	ld	a5,-432(s0)
    80006142:	fcf42423          	sw	a5,-56(s0)
    80006146:	a0fd                	j	80006234 <exec+0x1ae>
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    80006148:	df840793          	addi	a5,s0,-520
    8000614c:	fc842683          	lw	a3,-56(s0)
    80006150:	03800713          	li	a4,56
    80006154:	863e                	mv	a2,a5
    80006156:	4581                	li	a1,0
    80006158:	fa843503          	ld	a0,-88(s0)
    8000615c:	ffffe097          	auipc	ra,0xffffe
    80006160:	3ba080e7          	jalr	954(ra) # 80004516 <readi>
    80006164:	87aa                	mv	a5,a0
    80006166:	873e                	mv	a4,a5
    80006168:	03800793          	li	a5,56
    8000616c:	34f71b63          	bne	a4,a5,800064c2 <exec+0x43c>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
    80006170:	df842783          	lw	a5,-520(s0)
    80006174:	873e                	mv	a4,a5
    80006176:	4785                	li	a5,1
    80006178:	0af71163          	bne	a4,a5,8000621a <exec+0x194>
      continue;
    if(ph.memsz < ph.filesz)
    8000617c:	e2043703          	ld	a4,-480(s0)
    80006180:	e1843783          	ld	a5,-488(s0)
    80006184:	34f76163          	bltu	a4,a5,800064c6 <exec+0x440>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
    80006188:	e0843703          	ld	a4,-504(s0)
    8000618c:	e2043783          	ld	a5,-480(s0)
    80006190:	973e                	add	a4,a4,a5
    80006192:	e0843783          	ld	a5,-504(s0)
    80006196:	32f76a63          	bltu	a4,a5,800064ca <exec+0x444>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
    8000619a:	e0843703          	ld	a4,-504(s0)
    8000619e:	6785                	lui	a5,0x1
    800061a0:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    800061a2:	8ff9                	and	a5,a5,a4
    800061a4:	32079563          	bnez	a5,800064ce <exec+0x448>
      goto bad;
    uint64 sz1;
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz, flags2perm(ph.flags))) == 0)
    800061a8:	e0843703          	ld	a4,-504(s0)
    800061ac:	e2043783          	ld	a5,-480(s0)
    800061b0:	00f704b3          	add	s1,a4,a5
    800061b4:	dfc42783          	lw	a5,-516(s0)
    800061b8:	2781                	sext.w	a5,a5
    800061ba:	853e                	mv	a0,a5
    800061bc:	00000097          	auipc	ra,0x0
    800061c0:	e88080e7          	jalr	-376(ra) # 80006044 <flags2perm>
    800061c4:	87aa                	mv	a5,a0
    800061c6:	86be                	mv	a3,a5
    800061c8:	8626                	mv	a2,s1
    800061ca:	fb843583          	ld	a1,-72(s0)
    800061ce:	fa043503          	ld	a0,-96(s0)
    800061d2:	ffffb097          	auipc	ra,0xffffb
    800061d6:	b0c080e7          	jalr	-1268(ra) # 80000cde <uvmalloc>
    800061da:	f6a43823          	sd	a0,-144(s0)
    800061de:	f7043783          	ld	a5,-144(s0)
    800061e2:	2e078863          	beqz	a5,800064d2 <exec+0x44c>
      goto bad;
    sz = sz1;
    800061e6:	f7043783          	ld	a5,-144(s0)
    800061ea:	faf43c23          	sd	a5,-72(s0)
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    800061ee:	e0843783          	ld	a5,-504(s0)
    800061f2:	e0043703          	ld	a4,-512(s0)
    800061f6:	0007069b          	sext.w	a3,a4
    800061fa:	e1843703          	ld	a4,-488(s0)
    800061fe:	2701                	sext.w	a4,a4
    80006200:	fa843603          	ld	a2,-88(s0)
    80006204:	85be                	mv	a1,a5
    80006206:	fa043503          	ld	a0,-96(s0)
    8000620a:	00000097          	auipc	ra,0x0
    8000620e:	32c080e7          	jalr	812(ra) # 80006536 <loadseg>
    80006212:	87aa                	mv	a5,a0
    80006214:	2c07c163          	bltz	a5,800064d6 <exec+0x450>
    80006218:	a011                	j	8000621c <exec+0x196>
      continue;
    8000621a:	0001                	nop
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    8000621c:	fcc42783          	lw	a5,-52(s0)
    80006220:	2785                	addiw	a5,a5,1
    80006222:	fcf42623          	sw	a5,-52(s0)
    80006226:	fc842783          	lw	a5,-56(s0)
    8000622a:	0387879b          	addiw	a5,a5,56
    8000622e:	2781                	sext.w	a5,a5
    80006230:	fcf42423          	sw	a5,-56(s0)
    80006234:	e6845783          	lhu	a5,-408(s0)
    80006238:	0007871b          	sext.w	a4,a5
    8000623c:	fcc42783          	lw	a5,-52(s0)
    80006240:	2781                	sext.w	a5,a5
    80006242:	f0e7c3e3          	blt	a5,a4,80006148 <exec+0xc2>
      goto bad;
  }
  iunlockput(ip);
    80006246:	fa843503          	ld	a0,-88(s0)
    8000624a:	ffffe097          	auipc	ra,0xffffe
    8000624e:	f74080e7          	jalr	-140(ra) # 800041be <iunlockput>
  end_op();
    80006252:	fffff097          	auipc	ra,0xfffff
    80006256:	e64080e7          	jalr	-412(ra) # 800050b6 <end_op>
  ip = 0;
    8000625a:	fa043423          	sd	zero,-88(s0)

  p = myproc();
    8000625e:	ffffb097          	auipc	ra,0xffffb
    80006262:	3a2080e7          	jalr	930(ra) # 80001600 <myproc>
    80006266:	f8a43c23          	sd	a0,-104(s0)
  uint64 oldsz = p->sz;
    8000626a:	f9843783          	ld	a5,-104(s0)
    8000626e:	67bc                	ld	a5,72(a5)
    80006270:	f8f43823          	sd	a5,-112(s0)

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible as a stack guard.
  // Use the second as the user stack.
  sz = PGROUNDUP(sz);
    80006274:	fb843703          	ld	a4,-72(s0)
    80006278:	6785                	lui	a5,0x1
    8000627a:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    8000627c:	973e                	add	a4,a4,a5
    8000627e:	77fd                	lui	a5,0xfffff
    80006280:	8ff9                	and	a5,a5,a4
    80006282:	faf43c23          	sd	a5,-72(s0)
  uint64 sz1;
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE, PTE_W)) == 0)
    80006286:	fb843703          	ld	a4,-72(s0)
    8000628a:	6789                	lui	a5,0x2
    8000628c:	97ba                	add	a5,a5,a4
    8000628e:	4691                	li	a3,4
    80006290:	863e                	mv	a2,a5
    80006292:	fb843583          	ld	a1,-72(s0)
    80006296:	fa043503          	ld	a0,-96(s0)
    8000629a:	ffffb097          	auipc	ra,0xffffb
    8000629e:	a44080e7          	jalr	-1468(ra) # 80000cde <uvmalloc>
    800062a2:	f8a43423          	sd	a0,-120(s0)
    800062a6:	f8843783          	ld	a5,-120(s0)
    800062aa:	22078863          	beqz	a5,800064da <exec+0x454>
    goto bad;
  sz = sz1;
    800062ae:	f8843783          	ld	a5,-120(s0)
    800062b2:	faf43c23          	sd	a5,-72(s0)
  uvmclear(pagetable, sz-2*PGSIZE);
    800062b6:	fb843703          	ld	a4,-72(s0)
    800062ba:	77f9                	lui	a5,0xffffe
    800062bc:	97ba                	add	a5,a5,a4
    800062be:	85be                	mv	a1,a5
    800062c0:	fa043503          	ld	a0,-96(s0)
    800062c4:	ffffb097          	auipc	ra,0xffffb
    800062c8:	db0080e7          	jalr	-592(ra) # 80001074 <uvmclear>
  sp = sz;
    800062cc:	fb843783          	ld	a5,-72(s0)
    800062d0:	faf43823          	sd	a5,-80(s0)
  stackbase = sp - PGSIZE;
    800062d4:	fb043703          	ld	a4,-80(s0)
    800062d8:	77fd                	lui	a5,0xfffff
    800062da:	97ba                	add	a5,a5,a4
    800062dc:	f8f43023          	sd	a5,-128(s0)

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    800062e0:	fc043023          	sd	zero,-64(s0)
    800062e4:	a07d                	j	80006392 <exec+0x30c>
    if(argc >= MAXARG)
    800062e6:	fc043703          	ld	a4,-64(s0)
    800062ea:	47fd                	li	a5,31
    800062ec:	1ee7e963          	bltu	a5,a4,800064de <exec+0x458>
      goto bad;
    sp -= strlen(argv[argc]) + 1;
    800062f0:	fc043783          	ld	a5,-64(s0)
    800062f4:	078e                	slli	a5,a5,0x3
    800062f6:	de043703          	ld	a4,-544(s0)
    800062fa:	97ba                	add	a5,a5,a4
    800062fc:	639c                	ld	a5,0(a5)
    800062fe:	853e                	mv	a0,a5
    80006300:	ffffa097          	auipc	ra,0xffffa
    80006304:	28c080e7          	jalr	652(ra) # 8000058c <strlen>
    80006308:	87aa                	mv	a5,a0
    8000630a:	2785                	addiw	a5,a5,1 # fffffffffffff001 <end+0xffffffff7ffd9f11>
    8000630c:	2781                	sext.w	a5,a5
    8000630e:	873e                	mv	a4,a5
    80006310:	fb043783          	ld	a5,-80(s0)
    80006314:	8f99                	sub	a5,a5,a4
    80006316:	faf43823          	sd	a5,-80(s0)
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    8000631a:	fb043783          	ld	a5,-80(s0)
    8000631e:	9bc1                	andi	a5,a5,-16
    80006320:	faf43823          	sd	a5,-80(s0)
    if(sp < stackbase)
    80006324:	fb043703          	ld	a4,-80(s0)
    80006328:	f8043783          	ld	a5,-128(s0)
    8000632c:	1af76b63          	bltu	a4,a5,800064e2 <exec+0x45c>
      goto bad;
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    80006330:	fc043783          	ld	a5,-64(s0)
    80006334:	078e                	slli	a5,a5,0x3
    80006336:	de043703          	ld	a4,-544(s0)
    8000633a:	97ba                	add	a5,a5,a4
    8000633c:	6384                	ld	s1,0(a5)
    8000633e:	fc043783          	ld	a5,-64(s0)
    80006342:	078e                	slli	a5,a5,0x3
    80006344:	de043703          	ld	a4,-544(s0)
    80006348:	97ba                	add	a5,a5,a4
    8000634a:	639c                	ld	a5,0(a5)
    8000634c:	853e                	mv	a0,a5
    8000634e:	ffffa097          	auipc	ra,0xffffa
    80006352:	23e080e7          	jalr	574(ra) # 8000058c <strlen>
    80006356:	87aa                	mv	a5,a0
    80006358:	2785                	addiw	a5,a5,1
    8000635a:	2781                	sext.w	a5,a5
    8000635c:	86be                	mv	a3,a5
    8000635e:	8626                	mv	a2,s1
    80006360:	fb043583          	ld	a1,-80(s0)
    80006364:	fa043503          	ld	a0,-96(s0)
    80006368:	ffffb097          	auipc	ra,0xffffb
    8000636c:	d62080e7          	jalr	-670(ra) # 800010ca <copyout>
    80006370:	87aa                	mv	a5,a0
    80006372:	1607ca63          	bltz	a5,800064e6 <exec+0x460>
      goto bad;
    ustack[argc] = sp;
    80006376:	fc043783          	ld	a5,-64(s0)
    8000637a:	078e                	slli	a5,a5,0x3
    8000637c:	1781                	addi	a5,a5,-32
    8000637e:	97a2                	add	a5,a5,s0
    80006380:	fb043703          	ld	a4,-80(s0)
    80006384:	e8e7b823          	sd	a4,-368(a5)
  for(argc = 0; argv[argc]; argc++) {
    80006388:	fc043783          	ld	a5,-64(s0)
    8000638c:	0785                	addi	a5,a5,1
    8000638e:	fcf43023          	sd	a5,-64(s0)
    80006392:	fc043783          	ld	a5,-64(s0)
    80006396:	078e                	slli	a5,a5,0x3
    80006398:	de043703          	ld	a4,-544(s0)
    8000639c:	97ba                	add	a5,a5,a4
    8000639e:	639c                	ld	a5,0(a5)
    800063a0:	f3b9                	bnez	a5,800062e6 <exec+0x260>
  }
  ustack[argc] = 0;
    800063a2:	fc043783          	ld	a5,-64(s0)
    800063a6:	078e                	slli	a5,a5,0x3
    800063a8:	1781                	addi	a5,a5,-32
    800063aa:	97a2                	add	a5,a5,s0
    800063ac:	e807b823          	sd	zero,-368(a5)

  // push the array of argv[] pointers.
  sp -= (argc+1) * sizeof(uint64);
    800063b0:	fc043783          	ld	a5,-64(s0)
    800063b4:	0785                	addi	a5,a5,1
    800063b6:	078e                	slli	a5,a5,0x3
    800063b8:	fb043703          	ld	a4,-80(s0)
    800063bc:	40f707b3          	sub	a5,a4,a5
    800063c0:	faf43823          	sd	a5,-80(s0)
  sp -= sp % 16;
    800063c4:	fb043783          	ld	a5,-80(s0)
    800063c8:	9bc1                	andi	a5,a5,-16
    800063ca:	faf43823          	sd	a5,-80(s0)
  if(sp < stackbase)
    800063ce:	fb043703          	ld	a4,-80(s0)
    800063d2:	f8043783          	ld	a5,-128(s0)
    800063d6:	10f76a63          	bltu	a4,a5,800064ea <exec+0x464>
    goto bad;
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    800063da:	fc043783          	ld	a5,-64(s0)
    800063de:	0785                	addi	a5,a5,1
    800063e0:	00379713          	slli	a4,a5,0x3
    800063e4:	e7040793          	addi	a5,s0,-400
    800063e8:	86ba                	mv	a3,a4
    800063ea:	863e                	mv	a2,a5
    800063ec:	fb043583          	ld	a1,-80(s0)
    800063f0:	fa043503          	ld	a0,-96(s0)
    800063f4:	ffffb097          	auipc	ra,0xffffb
    800063f8:	cd6080e7          	jalr	-810(ra) # 800010ca <copyout>
    800063fc:	87aa                	mv	a5,a0
    800063fe:	0e07c863          	bltz	a5,800064ee <exec+0x468>
    goto bad;

  // arguments to user main(argc, argv)
  // argc is returned via the system call return
  // value, which goes in a0.
  p->trapframe->a1 = sp;
    80006402:	f9843783          	ld	a5,-104(s0)
    80006406:	6fbc                	ld	a5,88(a5)
    80006408:	fb043703          	ld	a4,-80(s0)
    8000640c:	ffb8                	sd	a4,120(a5)

  // Save program name for debugging.
  for(last=s=path; *s; s++)
    8000640e:	de843783          	ld	a5,-536(s0)
    80006412:	fcf43c23          	sd	a5,-40(s0)
    80006416:	fd843783          	ld	a5,-40(s0)
    8000641a:	fcf43823          	sd	a5,-48(s0)
    8000641e:	a025                	j	80006446 <exec+0x3c0>
    if(*s == '/')
    80006420:	fd843783          	ld	a5,-40(s0)
    80006424:	0007c783          	lbu	a5,0(a5)
    80006428:	873e                	mv	a4,a5
    8000642a:	02f00793          	li	a5,47
    8000642e:	00f71763          	bne	a4,a5,8000643c <exec+0x3b6>
      last = s+1;
    80006432:	fd843783          	ld	a5,-40(s0)
    80006436:	0785                	addi	a5,a5,1
    80006438:	fcf43823          	sd	a5,-48(s0)
  for(last=s=path; *s; s++)
    8000643c:	fd843783          	ld	a5,-40(s0)
    80006440:	0785                	addi	a5,a5,1
    80006442:	fcf43c23          	sd	a5,-40(s0)
    80006446:	fd843783          	ld	a5,-40(s0)
    8000644a:	0007c783          	lbu	a5,0(a5)
    8000644e:	fbe9                	bnez	a5,80006420 <exec+0x39a>
  safestrcpy(p->name, last, sizeof(p->name));
    80006450:	f9843783          	ld	a5,-104(s0)
    80006454:	15878793          	addi	a5,a5,344
    80006458:	4641                	li	a2,16
    8000645a:	fd043583          	ld	a1,-48(s0)
    8000645e:	853e                	mv	a0,a5
    80006460:	ffffa097          	auipc	ra,0xffffa
    80006464:	0b0080e7          	jalr	176(ra) # 80000510 <safestrcpy>
    
  // Commit to the user image.
  oldpagetable = p->pagetable;
    80006468:	f9843783          	ld	a5,-104(s0)
    8000646c:	6bbc                	ld	a5,80(a5)
    8000646e:	f6f43c23          	sd	a5,-136(s0)
  p->pagetable = pagetable;
    80006472:	f9843783          	ld	a5,-104(s0)
    80006476:	fa043703          	ld	a4,-96(s0)
    8000647a:	ebb8                	sd	a4,80(a5)
  p->sz = sz;
    8000647c:	f9843783          	ld	a5,-104(s0)
    80006480:	fb843703          	ld	a4,-72(s0)
    80006484:	e7b8                	sd	a4,72(a5)
  p->trapframe->epc = elf.entry;  // initial program counter = main
    80006486:	f9843783          	ld	a5,-104(s0)
    8000648a:	6fbc                	ld	a5,88(a5)
    8000648c:	e4843703          	ld	a4,-440(s0)
    80006490:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    80006492:	f9843783          	ld	a5,-104(s0)
    80006496:	6fbc                	ld	a5,88(a5)
    80006498:	fb043703          	ld	a4,-80(s0)
    8000649c:	fb98                	sd	a4,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    8000649e:	f9043583          	ld	a1,-112(s0)
    800064a2:	f7843503          	ld	a0,-136(s0)
    800064a6:	ffffb097          	auipc	ra,0xffffb
    800064aa:	47c080e7          	jalr	1148(ra) # 80001922 <proc_freepagetable>

  return argc; // this ends up in a0, the first argument to main(argc, argv)
    800064ae:	fc043783          	ld	a5,-64(s0)
    800064b2:	2781                	sext.w	a5,a5
    800064b4:	a0bd                	j	80006522 <exec+0x49c>
    goto bad;
    800064b6:	0001                	nop
    800064b8:	a825                	j	800064f0 <exec+0x46a>
    goto bad;
    800064ba:	0001                	nop
    800064bc:	a815                	j	800064f0 <exec+0x46a>
    goto bad;
    800064be:	0001                	nop
    800064c0:	a805                	j	800064f0 <exec+0x46a>
      goto bad;
    800064c2:	0001                	nop
    800064c4:	a035                	j	800064f0 <exec+0x46a>
      goto bad;
    800064c6:	0001                	nop
    800064c8:	a025                	j	800064f0 <exec+0x46a>
      goto bad;
    800064ca:	0001                	nop
    800064cc:	a015                	j	800064f0 <exec+0x46a>
      goto bad;
    800064ce:	0001                	nop
    800064d0:	a005                	j	800064f0 <exec+0x46a>
      goto bad;
    800064d2:	0001                	nop
    800064d4:	a831                	j	800064f0 <exec+0x46a>
      goto bad;
    800064d6:	0001                	nop
    800064d8:	a821                	j	800064f0 <exec+0x46a>
    goto bad;
    800064da:	0001                	nop
    800064dc:	a811                	j	800064f0 <exec+0x46a>
      goto bad;
    800064de:	0001                	nop
    800064e0:	a801                	j	800064f0 <exec+0x46a>
      goto bad;
    800064e2:	0001                	nop
    800064e4:	a031                	j	800064f0 <exec+0x46a>
      goto bad;
    800064e6:	0001                	nop
    800064e8:	a021                	j	800064f0 <exec+0x46a>
    goto bad;
    800064ea:	0001                	nop
    800064ec:	a011                	j	800064f0 <exec+0x46a>
    goto bad;
    800064ee:	0001                	nop

 bad:
  if(pagetable)
    800064f0:	fa043783          	ld	a5,-96(s0)
    800064f4:	cb89                	beqz	a5,80006506 <exec+0x480>
    proc_freepagetable(pagetable, sz);
    800064f6:	fb843583          	ld	a1,-72(s0)
    800064fa:	fa043503          	ld	a0,-96(s0)
    800064fe:	ffffb097          	auipc	ra,0xffffb
    80006502:	424080e7          	jalr	1060(ra) # 80001922 <proc_freepagetable>
  if(ip){
    80006506:	fa843783          	ld	a5,-88(s0)
    8000650a:	cb99                	beqz	a5,80006520 <exec+0x49a>
    iunlockput(ip);
    8000650c:	fa843503          	ld	a0,-88(s0)
    80006510:	ffffe097          	auipc	ra,0xffffe
    80006514:	cae080e7          	jalr	-850(ra) # 800041be <iunlockput>
    end_op();
    80006518:	fffff097          	auipc	ra,0xfffff
    8000651c:	b9e080e7          	jalr	-1122(ra) # 800050b6 <end_op>
  }
  return -1;
    80006520:	57fd                	li	a5,-1
}
    80006522:	853e                	mv	a0,a5
    80006524:	21813083          	ld	ra,536(sp)
    80006528:	21013403          	ld	s0,528(sp)
    8000652c:	20813483          	ld	s1,520(sp)
    80006530:	22010113          	addi	sp,sp,544
    80006534:	8082                	ret

0000000080006536 <loadseg>:
// va must be page-aligned
// and the pages from va to va+sz must already be mapped.
// Returns 0 on success, -1 on failure.
static int
loadseg(pagetable_t pagetable, uint64 va, struct inode *ip, uint offset, uint sz)
{
    80006536:	7139                	addi	sp,sp,-64
    80006538:	fc06                	sd	ra,56(sp)
    8000653a:	f822                	sd	s0,48(sp)
    8000653c:	0080                	addi	s0,sp,64
    8000653e:	fca43c23          	sd	a0,-40(s0)
    80006542:	fcb43823          	sd	a1,-48(s0)
    80006546:	fcc43423          	sd	a2,-56(s0)
    8000654a:	87b6                	mv	a5,a3
    8000654c:	fcf42223          	sw	a5,-60(s0)
    80006550:	87ba                	mv	a5,a4
    80006552:	fcf42023          	sw	a5,-64(s0)
  uint i, n;
  uint64 pa;

  for(i = 0; i < sz; i += PGSIZE){
    80006556:	fe042623          	sw	zero,-20(s0)
    8000655a:	a07d                	j	80006608 <loadseg+0xd2>
    pa = walkaddr(pagetable, va + i);
    8000655c:	fec46703          	lwu	a4,-20(s0)
    80006560:	fd043783          	ld	a5,-48(s0)
    80006564:	97ba                	add	a5,a5,a4
    80006566:	85be                	mv	a1,a5
    80006568:	fd843503          	ld	a0,-40(s0)
    8000656c:	ffffa097          	auipc	ra,0xffffa
    80006570:	3fe080e7          	jalr	1022(ra) # 8000096a <walkaddr>
    80006574:	fea43023          	sd	a0,-32(s0)
    if(pa == 0)
    80006578:	fe043783          	ld	a5,-32(s0)
    8000657c:	eb89                	bnez	a5,8000658e <loadseg+0x58>
      panic("loadseg: address should exist");
    8000657e:	00005517          	auipc	a0,0x5
    80006582:	0ca50513          	addi	a0,a0,202 # 8000b648 <etext+0x648>
    80006586:	00003097          	auipc	ra,0x3
    8000658a:	9b0080e7          	jalr	-1616(ra) # 80008f36 <panic>
    if(sz - i < PGSIZE)
    8000658e:	fc042783          	lw	a5,-64(s0)
    80006592:	873e                	mv	a4,a5
    80006594:	fec42783          	lw	a5,-20(s0)
    80006598:	40f707bb          	subw	a5,a4,a5
    8000659c:	2781                	sext.w	a5,a5
    8000659e:	873e                	mv	a4,a5
    800065a0:	6785                	lui	a5,0x1
    800065a2:	00f77c63          	bgeu	a4,a5,800065ba <loadseg+0x84>
      n = sz - i;
    800065a6:	fc042783          	lw	a5,-64(s0)
    800065aa:	873e                	mv	a4,a5
    800065ac:	fec42783          	lw	a5,-20(s0)
    800065b0:	40f707bb          	subw	a5,a4,a5
    800065b4:	fef42423          	sw	a5,-24(s0)
    800065b8:	a021                	j	800065c0 <loadseg+0x8a>
    else
      n = PGSIZE;
    800065ba:	6785                	lui	a5,0x1
    800065bc:	fef42423          	sw	a5,-24(s0)
    if(readi(ip, 0, (uint64)pa, offset+i, n) != n)
    800065c0:	fc442783          	lw	a5,-60(s0)
    800065c4:	873e                	mv	a4,a5
    800065c6:	fec42783          	lw	a5,-20(s0)
    800065ca:	9fb9                	addw	a5,a5,a4
    800065cc:	2781                	sext.w	a5,a5
    800065ce:	fe842703          	lw	a4,-24(s0)
    800065d2:	86be                	mv	a3,a5
    800065d4:	fe043603          	ld	a2,-32(s0)
    800065d8:	4581                	li	a1,0
    800065da:	fc843503          	ld	a0,-56(s0)
    800065de:	ffffe097          	auipc	ra,0xffffe
    800065e2:	f38080e7          	jalr	-200(ra) # 80004516 <readi>
    800065e6:	87aa                	mv	a5,a0
    800065e8:	0007871b          	sext.w	a4,a5
    800065ec:	fe842783          	lw	a5,-24(s0)
    800065f0:	2781                	sext.w	a5,a5
    800065f2:	00e78463          	beq	a5,a4,800065fa <loadseg+0xc4>
      return -1;
    800065f6:	57fd                	li	a5,-1
    800065f8:	a015                	j	8000661c <loadseg+0xe6>
  for(i = 0; i < sz; i += PGSIZE){
    800065fa:	fec42783          	lw	a5,-20(s0)
    800065fe:	873e                	mv	a4,a5
    80006600:	6785                	lui	a5,0x1
    80006602:	9fb9                	addw	a5,a5,a4
    80006604:	fef42623          	sw	a5,-20(s0)
    80006608:	fec42783          	lw	a5,-20(s0)
    8000660c:	873e                	mv	a4,a5
    8000660e:	fc042783          	lw	a5,-64(s0)
    80006612:	2701                	sext.w	a4,a4
    80006614:	2781                	sext.w	a5,a5
    80006616:	f4f763e3          	bltu	a4,a5,8000655c <loadseg+0x26>
  }
  
  return 0;
    8000661a:	4781                	li	a5,0
}
    8000661c:	853e                	mv	a0,a5
    8000661e:	70e2                	ld	ra,56(sp)
    80006620:	7442                	ld	s0,48(sp)
    80006622:	6121                	addi	sp,sp,64
    80006624:	8082                	ret

0000000080006626 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    80006626:	7139                	addi	sp,sp,-64
    80006628:	fc06                	sd	ra,56(sp)
    8000662a:	f822                	sd	s0,48(sp)
    8000662c:	0080                	addi	s0,sp,64
    8000662e:	87aa                	mv	a5,a0
    80006630:	fcb43823          	sd	a1,-48(s0)
    80006634:	fcc43423          	sd	a2,-56(s0)
    80006638:	fcf42e23          	sw	a5,-36(s0)
  int fd;
  struct file *f;

  argint(n, &fd);
    8000663c:	fe440713          	addi	a4,s0,-28
    80006640:	fdc42783          	lw	a5,-36(s0)
    80006644:	85ba                	mv	a1,a4
    80006646:	853e                	mv	a0,a5
    80006648:	ffffd097          	auipc	ra,0xffffd
    8000664c:	880080e7          	jalr	-1920(ra) # 80002ec8 <argint>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    80006650:	fe442783          	lw	a5,-28(s0)
    80006654:	0207c863          	bltz	a5,80006684 <argfd+0x5e>
    80006658:	fe442783          	lw	a5,-28(s0)
    8000665c:	873e                	mv	a4,a5
    8000665e:	47bd                	li	a5,15
    80006660:	02e7c263          	blt	a5,a4,80006684 <argfd+0x5e>
    80006664:	ffffb097          	auipc	ra,0xffffb
    80006668:	f9c080e7          	jalr	-100(ra) # 80001600 <myproc>
    8000666c:	872a                	mv	a4,a0
    8000666e:	fe442783          	lw	a5,-28(s0)
    80006672:	07e9                	addi	a5,a5,26 # 101a <_entry-0x7fffefe6>
    80006674:	078e                	slli	a5,a5,0x3
    80006676:	97ba                	add	a5,a5,a4
    80006678:	639c                	ld	a5,0(a5)
    8000667a:	fef43423          	sd	a5,-24(s0)
    8000667e:	fe843783          	ld	a5,-24(s0)
    80006682:	e399                	bnez	a5,80006688 <argfd+0x62>
    return -1;
    80006684:	57fd                	li	a5,-1
    80006686:	a015                	j	800066aa <argfd+0x84>
  if(pfd)
    80006688:	fd043783          	ld	a5,-48(s0)
    8000668c:	c791                	beqz	a5,80006698 <argfd+0x72>
    *pfd = fd;
    8000668e:	fe442703          	lw	a4,-28(s0)
    80006692:	fd043783          	ld	a5,-48(s0)
    80006696:	c398                	sw	a4,0(a5)
  if(pf)
    80006698:	fc843783          	ld	a5,-56(s0)
    8000669c:	c791                	beqz	a5,800066a8 <argfd+0x82>
    *pf = f;
    8000669e:	fc843783          	ld	a5,-56(s0)
    800066a2:	fe843703          	ld	a4,-24(s0)
    800066a6:	e398                	sd	a4,0(a5)
  return 0;
    800066a8:	4781                	li	a5,0
}
    800066aa:	853e                	mv	a0,a5
    800066ac:	70e2                	ld	ra,56(sp)
    800066ae:	7442                	ld	s0,48(sp)
    800066b0:	6121                	addi	sp,sp,64
    800066b2:	8082                	ret

00000000800066b4 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    800066b4:	7179                	addi	sp,sp,-48
    800066b6:	f406                	sd	ra,40(sp)
    800066b8:	f022                	sd	s0,32(sp)
    800066ba:	1800                	addi	s0,sp,48
    800066bc:	fca43c23          	sd	a0,-40(s0)
  int fd;
  struct proc *p = myproc();
    800066c0:	ffffb097          	auipc	ra,0xffffb
    800066c4:	f40080e7          	jalr	-192(ra) # 80001600 <myproc>
    800066c8:	fea43023          	sd	a0,-32(s0)

  for(fd = 0; fd < NOFILE; fd++){
    800066cc:	fe042623          	sw	zero,-20(s0)
    800066d0:	a825                	j	80006708 <fdalloc+0x54>
    if(p->ofile[fd] == 0){
    800066d2:	fe043703          	ld	a4,-32(s0)
    800066d6:	fec42783          	lw	a5,-20(s0)
    800066da:	07e9                	addi	a5,a5,26
    800066dc:	078e                	slli	a5,a5,0x3
    800066de:	97ba                	add	a5,a5,a4
    800066e0:	639c                	ld	a5,0(a5)
    800066e2:	ef91                	bnez	a5,800066fe <fdalloc+0x4a>
      p->ofile[fd] = f;
    800066e4:	fe043703          	ld	a4,-32(s0)
    800066e8:	fec42783          	lw	a5,-20(s0)
    800066ec:	07e9                	addi	a5,a5,26
    800066ee:	078e                	slli	a5,a5,0x3
    800066f0:	97ba                	add	a5,a5,a4
    800066f2:	fd843703          	ld	a4,-40(s0)
    800066f6:	e398                	sd	a4,0(a5)
      return fd;
    800066f8:	fec42783          	lw	a5,-20(s0)
    800066fc:	a831                	j	80006718 <fdalloc+0x64>
  for(fd = 0; fd < NOFILE; fd++){
    800066fe:	fec42783          	lw	a5,-20(s0)
    80006702:	2785                	addiw	a5,a5,1
    80006704:	fef42623          	sw	a5,-20(s0)
    80006708:	fec42783          	lw	a5,-20(s0)
    8000670c:	0007871b          	sext.w	a4,a5
    80006710:	47bd                	li	a5,15
    80006712:	fce7d0e3          	bge	a5,a4,800066d2 <fdalloc+0x1e>
    }
  }
  return -1;
    80006716:	57fd                	li	a5,-1
}
    80006718:	853e                	mv	a0,a5
    8000671a:	70a2                	ld	ra,40(sp)
    8000671c:	7402                	ld	s0,32(sp)
    8000671e:	6145                	addi	sp,sp,48
    80006720:	8082                	ret

0000000080006722 <sys_dup>:

uint64
sys_dup(void)
{
    80006722:	1101                	addi	sp,sp,-32
    80006724:	ec06                	sd	ra,24(sp)
    80006726:	e822                	sd	s0,16(sp)
    80006728:	1000                	addi	s0,sp,32
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    8000672a:	fe040793          	addi	a5,s0,-32
    8000672e:	863e                	mv	a2,a5
    80006730:	4581                	li	a1,0
    80006732:	4501                	li	a0,0
    80006734:	00000097          	auipc	ra,0x0
    80006738:	ef2080e7          	jalr	-270(ra) # 80006626 <argfd>
    8000673c:	87aa                	mv	a5,a0
    8000673e:	0007d463          	bgez	a5,80006746 <sys_dup+0x24>
    return -1;
    80006742:	57fd                	li	a5,-1
    80006744:	a81d                	j	8000677a <sys_dup+0x58>
  if((fd=fdalloc(f)) < 0)
    80006746:	fe043783          	ld	a5,-32(s0)
    8000674a:	853e                	mv	a0,a5
    8000674c:	00000097          	auipc	ra,0x0
    80006750:	f68080e7          	jalr	-152(ra) # 800066b4 <fdalloc>
    80006754:	87aa                	mv	a5,a0
    80006756:	fef42623          	sw	a5,-20(s0)
    8000675a:	fec42783          	lw	a5,-20(s0)
    8000675e:	2781                	sext.w	a5,a5
    80006760:	0007d463          	bgez	a5,80006768 <sys_dup+0x46>
    return -1;
    80006764:	57fd                	li	a5,-1
    80006766:	a811                	j	8000677a <sys_dup+0x58>
  filedup(f);
    80006768:	fe043783          	ld	a5,-32(s0)
    8000676c:	853e                	mv	a0,a5
    8000676e:	fffff097          	auipc	ra,0xfffff
    80006772:	eba080e7          	jalr	-326(ra) # 80005628 <filedup>
  return fd;
    80006776:	fec42783          	lw	a5,-20(s0)
}
    8000677a:	853e                	mv	a0,a5
    8000677c:	60e2                	ld	ra,24(sp)
    8000677e:	6442                	ld	s0,16(sp)
    80006780:	6105                	addi	sp,sp,32
    80006782:	8082                	ret

0000000080006784 <sys_read>:

uint64
sys_read(void)
{
    80006784:	7179                	addi	sp,sp,-48
    80006786:	f406                	sd	ra,40(sp)
    80006788:	f022                	sd	s0,32(sp)
    8000678a:	1800                	addi	s0,sp,48
  struct file *f;
  int n;
  uint64 p;

  argaddr(1, &p);
    8000678c:	fd840793          	addi	a5,s0,-40
    80006790:	85be                	mv	a1,a5
    80006792:	4505                	li	a0,1
    80006794:	ffffc097          	auipc	ra,0xffffc
    80006798:	76a080e7          	jalr	1898(ra) # 80002efe <argaddr>
  argint(2, &n);
    8000679c:	fe440793          	addi	a5,s0,-28
    800067a0:	85be                	mv	a1,a5
    800067a2:	4509                	li	a0,2
    800067a4:	ffffc097          	auipc	ra,0xffffc
    800067a8:	724080e7          	jalr	1828(ra) # 80002ec8 <argint>
  if(argfd(0, 0, &f) < 0)
    800067ac:	fe840793          	addi	a5,s0,-24
    800067b0:	863e                	mv	a2,a5
    800067b2:	4581                	li	a1,0
    800067b4:	4501                	li	a0,0
    800067b6:	00000097          	auipc	ra,0x0
    800067ba:	e70080e7          	jalr	-400(ra) # 80006626 <argfd>
    800067be:	87aa                	mv	a5,a0
    800067c0:	0007d463          	bgez	a5,800067c8 <sys_read+0x44>
    return -1;
    800067c4:	57fd                	li	a5,-1
    800067c6:	a839                	j	800067e4 <sys_read+0x60>
  return fileread(f, p, n);
    800067c8:	fe843783          	ld	a5,-24(s0)
    800067cc:	fd843703          	ld	a4,-40(s0)
    800067d0:	fe442683          	lw	a3,-28(s0)
    800067d4:	8636                	mv	a2,a3
    800067d6:	85ba                	mv	a1,a4
    800067d8:	853e                	mv	a0,a5
    800067da:	fffff097          	auipc	ra,0xfffff
    800067de:	060080e7          	jalr	96(ra) # 8000583a <fileread>
    800067e2:	87aa                	mv	a5,a0
}
    800067e4:	853e                	mv	a0,a5
    800067e6:	70a2                	ld	ra,40(sp)
    800067e8:	7402                	ld	s0,32(sp)
    800067ea:	6145                	addi	sp,sp,48
    800067ec:	8082                	ret

00000000800067ee <sys_write>:

uint64
sys_write(void)
{
    800067ee:	7179                	addi	sp,sp,-48
    800067f0:	f406                	sd	ra,40(sp)
    800067f2:	f022                	sd	s0,32(sp)
    800067f4:	1800                	addi	s0,sp,48
  struct file *f;
  int n;
  uint64 p;
  
  argaddr(1, &p);
    800067f6:	fd840793          	addi	a5,s0,-40
    800067fa:	85be                	mv	a1,a5
    800067fc:	4505                	li	a0,1
    800067fe:	ffffc097          	auipc	ra,0xffffc
    80006802:	700080e7          	jalr	1792(ra) # 80002efe <argaddr>
  argint(2, &n);
    80006806:	fe440793          	addi	a5,s0,-28
    8000680a:	85be                	mv	a1,a5
    8000680c:	4509                	li	a0,2
    8000680e:	ffffc097          	auipc	ra,0xffffc
    80006812:	6ba080e7          	jalr	1722(ra) # 80002ec8 <argint>
  if(argfd(0, 0, &f) < 0)
    80006816:	fe840793          	addi	a5,s0,-24
    8000681a:	863e                	mv	a2,a5
    8000681c:	4581                	li	a1,0
    8000681e:	4501                	li	a0,0
    80006820:	00000097          	auipc	ra,0x0
    80006824:	e06080e7          	jalr	-506(ra) # 80006626 <argfd>
    80006828:	87aa                	mv	a5,a0
    8000682a:	0007d463          	bgez	a5,80006832 <sys_write+0x44>
    return -1;
    8000682e:	57fd                	li	a5,-1
    80006830:	a839                	j	8000684e <sys_write+0x60>

  return filewrite(f, p, n);
    80006832:	fe843783          	ld	a5,-24(s0)
    80006836:	fd843703          	ld	a4,-40(s0)
    8000683a:	fe442683          	lw	a3,-28(s0)
    8000683e:	8636                	mv	a2,a3
    80006840:	85ba                	mv	a1,a4
    80006842:	853e                	mv	a0,a5
    80006844:	fffff097          	auipc	ra,0xfffff
    80006848:	154080e7          	jalr	340(ra) # 80005998 <filewrite>
    8000684c:	87aa                	mv	a5,a0
}
    8000684e:	853e                	mv	a0,a5
    80006850:	70a2                	ld	ra,40(sp)
    80006852:	7402                	ld	s0,32(sp)
    80006854:	6145                	addi	sp,sp,48
    80006856:	8082                	ret

0000000080006858 <sys_close>:

uint64
sys_close(void)
{
    80006858:	1101                	addi	sp,sp,-32
    8000685a:	ec06                	sd	ra,24(sp)
    8000685c:	e822                	sd	s0,16(sp)
    8000685e:	1000                	addi	s0,sp,32
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    80006860:	fe040713          	addi	a4,s0,-32
    80006864:	fec40793          	addi	a5,s0,-20
    80006868:	863a                	mv	a2,a4
    8000686a:	85be                	mv	a1,a5
    8000686c:	4501                	li	a0,0
    8000686e:	00000097          	auipc	ra,0x0
    80006872:	db8080e7          	jalr	-584(ra) # 80006626 <argfd>
    80006876:	87aa                	mv	a5,a0
    80006878:	0007d463          	bgez	a5,80006880 <sys_close+0x28>
    return -1;
    8000687c:	57fd                	li	a5,-1
    8000687e:	a02d                	j	800068a8 <sys_close+0x50>
  myproc()->ofile[fd] = 0;
    80006880:	ffffb097          	auipc	ra,0xffffb
    80006884:	d80080e7          	jalr	-640(ra) # 80001600 <myproc>
    80006888:	872a                	mv	a4,a0
    8000688a:	fec42783          	lw	a5,-20(s0)
    8000688e:	07e9                	addi	a5,a5,26
    80006890:	078e                	slli	a5,a5,0x3
    80006892:	97ba                	add	a5,a5,a4
    80006894:	0007b023          	sd	zero,0(a5)
  fileclose(f);
    80006898:	fe043783          	ld	a5,-32(s0)
    8000689c:	853e                	mv	a0,a5
    8000689e:	fffff097          	auipc	ra,0xfffff
    800068a2:	df0080e7          	jalr	-528(ra) # 8000568e <fileclose>
  return 0;
    800068a6:	4781                	li	a5,0
}
    800068a8:	853e                	mv	a0,a5
    800068aa:	60e2                	ld	ra,24(sp)
    800068ac:	6442                	ld	s0,16(sp)
    800068ae:	6105                	addi	sp,sp,32
    800068b0:	8082                	ret

00000000800068b2 <sys_fstat>:

uint64
sys_fstat(void)
{
    800068b2:	1101                	addi	sp,sp,-32
    800068b4:	ec06                	sd	ra,24(sp)
    800068b6:	e822                	sd	s0,16(sp)
    800068b8:	1000                	addi	s0,sp,32
  struct file *f;
  uint64 st; // user pointer to struct stat

  argaddr(1, &st);
    800068ba:	fe040793          	addi	a5,s0,-32
    800068be:	85be                	mv	a1,a5
    800068c0:	4505                	li	a0,1
    800068c2:	ffffc097          	auipc	ra,0xffffc
    800068c6:	63c080e7          	jalr	1596(ra) # 80002efe <argaddr>
  if(argfd(0, 0, &f) < 0)
    800068ca:	fe840793          	addi	a5,s0,-24
    800068ce:	863e                	mv	a2,a5
    800068d0:	4581                	li	a1,0
    800068d2:	4501                	li	a0,0
    800068d4:	00000097          	auipc	ra,0x0
    800068d8:	d52080e7          	jalr	-686(ra) # 80006626 <argfd>
    800068dc:	87aa                	mv	a5,a0
    800068de:	0007d463          	bgez	a5,800068e6 <sys_fstat+0x34>
    return -1;
    800068e2:	57fd                	li	a5,-1
    800068e4:	a821                	j	800068fc <sys_fstat+0x4a>
  return filestat(f, st);
    800068e6:	fe843783          	ld	a5,-24(s0)
    800068ea:	fe043703          	ld	a4,-32(s0)
    800068ee:	85ba                	mv	a1,a4
    800068f0:	853e                	mv	a0,a5
    800068f2:	fffff097          	auipc	ra,0xfffff
    800068f6:	ea4080e7          	jalr	-348(ra) # 80005796 <filestat>
    800068fa:	87aa                	mv	a5,a0
}
    800068fc:	853e                	mv	a0,a5
    800068fe:	60e2                	ld	ra,24(sp)
    80006900:	6442                	ld	s0,16(sp)
    80006902:	6105                	addi	sp,sp,32
    80006904:	8082                	ret

0000000080006906 <sys_link>:

// Create the path new as a link to the same inode as old.
uint64
sys_link(void)
{
    80006906:	7169                	addi	sp,sp,-304
    80006908:	f606                	sd	ra,296(sp)
    8000690a:	f222                	sd	s0,288(sp)
    8000690c:	1a00                	addi	s0,sp,304
  char name[DIRSIZ], new[MAXPATH], old[MAXPATH];
  struct inode *dp, *ip;

  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    8000690e:	ed040793          	addi	a5,s0,-304
    80006912:	08000613          	li	a2,128
    80006916:	85be                	mv	a1,a5
    80006918:	4501                	li	a0,0
    8000691a:	ffffc097          	auipc	ra,0xffffc
    8000691e:	616080e7          	jalr	1558(ra) # 80002f30 <argstr>
    80006922:	87aa                	mv	a5,a0
    80006924:	0007cf63          	bltz	a5,80006942 <sys_link+0x3c>
    80006928:	f5040793          	addi	a5,s0,-176
    8000692c:	08000613          	li	a2,128
    80006930:	85be                	mv	a1,a5
    80006932:	4505                	li	a0,1
    80006934:	ffffc097          	auipc	ra,0xffffc
    80006938:	5fc080e7          	jalr	1532(ra) # 80002f30 <argstr>
    8000693c:	87aa                	mv	a5,a0
    8000693e:	0007d463          	bgez	a5,80006946 <sys_link+0x40>
    return -1;
    80006942:	57fd                	li	a5,-1
    80006944:	aaad                	j	80006abe <sys_link+0x1b8>

  begin_op();
    80006946:	ffffe097          	auipc	ra,0xffffe
    8000694a:	6ae080e7          	jalr	1710(ra) # 80004ff4 <begin_op>
  if((ip = namei(old)) == 0){
    8000694e:	ed040793          	addi	a5,s0,-304
    80006952:	853e                	mv	a0,a5
    80006954:	ffffe097          	auipc	ra,0xffffe
    80006958:	33c080e7          	jalr	828(ra) # 80004c90 <namei>
    8000695c:	fea43423          	sd	a0,-24(s0)
    80006960:	fe843783          	ld	a5,-24(s0)
    80006964:	e799                	bnez	a5,80006972 <sys_link+0x6c>
    end_op();
    80006966:	ffffe097          	auipc	ra,0xffffe
    8000696a:	750080e7          	jalr	1872(ra) # 800050b6 <end_op>
    return -1;
    8000696e:	57fd                	li	a5,-1
    80006970:	a2b9                	j	80006abe <sys_link+0x1b8>
  }

  ilock(ip);
    80006972:	fe843503          	ld	a0,-24(s0)
    80006976:	ffffd097          	auipc	ra,0xffffd
    8000697a:	5ea080e7          	jalr	1514(ra) # 80003f60 <ilock>
  if(ip->type == T_DIR){
    8000697e:	fe843783          	ld	a5,-24(s0)
    80006982:	04479783          	lh	a5,68(a5)
    80006986:	873e                	mv	a4,a5
    80006988:	4785                	li	a5,1
    8000698a:	00f71e63          	bne	a4,a5,800069a6 <sys_link+0xa0>
    iunlockput(ip);
    8000698e:	fe843503          	ld	a0,-24(s0)
    80006992:	ffffe097          	auipc	ra,0xffffe
    80006996:	82c080e7          	jalr	-2004(ra) # 800041be <iunlockput>
    end_op();
    8000699a:	ffffe097          	auipc	ra,0xffffe
    8000699e:	71c080e7          	jalr	1820(ra) # 800050b6 <end_op>
    return -1;
    800069a2:	57fd                	li	a5,-1
    800069a4:	aa29                	j	80006abe <sys_link+0x1b8>
  }

  ip->nlink++;
    800069a6:	fe843783          	ld	a5,-24(s0)
    800069aa:	04a79783          	lh	a5,74(a5)
    800069ae:	17c2                	slli	a5,a5,0x30
    800069b0:	93c1                	srli	a5,a5,0x30
    800069b2:	2785                	addiw	a5,a5,1
    800069b4:	17c2                	slli	a5,a5,0x30
    800069b6:	93c1                	srli	a5,a5,0x30
    800069b8:	0107971b          	slliw	a4,a5,0x10
    800069bc:	4107571b          	sraiw	a4,a4,0x10
    800069c0:	fe843783          	ld	a5,-24(s0)
    800069c4:	04e79523          	sh	a4,74(a5)
  iupdate(ip);
    800069c8:	fe843503          	ld	a0,-24(s0)
    800069cc:	ffffd097          	auipc	ra,0xffffd
    800069d0:	344080e7          	jalr	836(ra) # 80003d10 <iupdate>
  iunlock(ip);
    800069d4:	fe843503          	ld	a0,-24(s0)
    800069d8:	ffffd097          	auipc	ra,0xffffd
    800069dc:	6bc080e7          	jalr	1724(ra) # 80004094 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
    800069e0:	fd040713          	addi	a4,s0,-48
    800069e4:	f5040793          	addi	a5,s0,-176
    800069e8:	85ba                	mv	a1,a4
    800069ea:	853e                	mv	a0,a5
    800069ec:	ffffe097          	auipc	ra,0xffffe
    800069f0:	2d0080e7          	jalr	720(ra) # 80004cbc <nameiparent>
    800069f4:	fea43023          	sd	a0,-32(s0)
    800069f8:	fe043783          	ld	a5,-32(s0)
    800069fc:	cba5                	beqz	a5,80006a6c <sys_link+0x166>
    goto bad;
  ilock(dp);
    800069fe:	fe043503          	ld	a0,-32(s0)
    80006a02:	ffffd097          	auipc	ra,0xffffd
    80006a06:	55e080e7          	jalr	1374(ra) # 80003f60 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    80006a0a:	fe043783          	ld	a5,-32(s0)
    80006a0e:	4398                	lw	a4,0(a5)
    80006a10:	fe843783          	ld	a5,-24(s0)
    80006a14:	439c                	lw	a5,0(a5)
    80006a16:	02f71263          	bne	a4,a5,80006a3a <sys_link+0x134>
    80006a1a:	fe843783          	ld	a5,-24(s0)
    80006a1e:	43d8                	lw	a4,4(a5)
    80006a20:	fd040793          	addi	a5,s0,-48
    80006a24:	863a                	mv	a2,a4
    80006a26:	85be                	mv	a1,a5
    80006a28:	fe043503          	ld	a0,-32(s0)
    80006a2c:	ffffe097          	auipc	ra,0xffffe
    80006a30:	f58080e7          	jalr	-168(ra) # 80004984 <dirlink>
    80006a34:	87aa                	mv	a5,a0
    80006a36:	0007d963          	bgez	a5,80006a48 <sys_link+0x142>
    iunlockput(dp);
    80006a3a:	fe043503          	ld	a0,-32(s0)
    80006a3e:	ffffd097          	auipc	ra,0xffffd
    80006a42:	780080e7          	jalr	1920(ra) # 800041be <iunlockput>
    goto bad;
    80006a46:	a025                	j	80006a6e <sys_link+0x168>
  }
  iunlockput(dp);
    80006a48:	fe043503          	ld	a0,-32(s0)
    80006a4c:	ffffd097          	auipc	ra,0xffffd
    80006a50:	772080e7          	jalr	1906(ra) # 800041be <iunlockput>
  iput(ip);
    80006a54:	fe843503          	ld	a0,-24(s0)
    80006a58:	ffffd097          	auipc	ra,0xffffd
    80006a5c:	696080e7          	jalr	1686(ra) # 800040ee <iput>

  end_op();
    80006a60:	ffffe097          	auipc	ra,0xffffe
    80006a64:	656080e7          	jalr	1622(ra) # 800050b6 <end_op>

  return 0;
    80006a68:	4781                	li	a5,0
    80006a6a:	a891                	j	80006abe <sys_link+0x1b8>
    goto bad;
    80006a6c:	0001                	nop

bad:
  ilock(ip);
    80006a6e:	fe843503          	ld	a0,-24(s0)
    80006a72:	ffffd097          	auipc	ra,0xffffd
    80006a76:	4ee080e7          	jalr	1262(ra) # 80003f60 <ilock>
  ip->nlink--;
    80006a7a:	fe843783          	ld	a5,-24(s0)
    80006a7e:	04a79783          	lh	a5,74(a5)
    80006a82:	17c2                	slli	a5,a5,0x30
    80006a84:	93c1                	srli	a5,a5,0x30
    80006a86:	37fd                	addiw	a5,a5,-1
    80006a88:	17c2                	slli	a5,a5,0x30
    80006a8a:	93c1                	srli	a5,a5,0x30
    80006a8c:	0107971b          	slliw	a4,a5,0x10
    80006a90:	4107571b          	sraiw	a4,a4,0x10
    80006a94:	fe843783          	ld	a5,-24(s0)
    80006a98:	04e79523          	sh	a4,74(a5)
  iupdate(ip);
    80006a9c:	fe843503          	ld	a0,-24(s0)
    80006aa0:	ffffd097          	auipc	ra,0xffffd
    80006aa4:	270080e7          	jalr	624(ra) # 80003d10 <iupdate>
  iunlockput(ip);
    80006aa8:	fe843503          	ld	a0,-24(s0)
    80006aac:	ffffd097          	auipc	ra,0xffffd
    80006ab0:	712080e7          	jalr	1810(ra) # 800041be <iunlockput>
  end_op();
    80006ab4:	ffffe097          	auipc	ra,0xffffe
    80006ab8:	602080e7          	jalr	1538(ra) # 800050b6 <end_op>
  return -1;
    80006abc:	57fd                	li	a5,-1
}
    80006abe:	853e                	mv	a0,a5
    80006ac0:	70b2                	ld	ra,296(sp)
    80006ac2:	7412                	ld	s0,288(sp)
    80006ac4:	6155                	addi	sp,sp,304
    80006ac6:	8082                	ret

0000000080006ac8 <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
static int
isdirempty(struct inode *dp)
{
    80006ac8:	7139                	addi	sp,sp,-64
    80006aca:	fc06                	sd	ra,56(sp)
    80006acc:	f822                	sd	s0,48(sp)
    80006ace:	0080                	addi	s0,sp,64
    80006ad0:	fca43423          	sd	a0,-56(s0)
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80006ad4:	02000793          	li	a5,32
    80006ad8:	fef42623          	sw	a5,-20(s0)
    80006adc:	a0b1                	j	80006b28 <isdirempty+0x60>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80006ade:	fd840793          	addi	a5,s0,-40
    80006ae2:	fec42683          	lw	a3,-20(s0)
    80006ae6:	4741                	li	a4,16
    80006ae8:	863e                	mv	a2,a5
    80006aea:	4581                	li	a1,0
    80006aec:	fc843503          	ld	a0,-56(s0)
    80006af0:	ffffe097          	auipc	ra,0xffffe
    80006af4:	a26080e7          	jalr	-1498(ra) # 80004516 <readi>
    80006af8:	87aa                	mv	a5,a0
    80006afa:	873e                	mv	a4,a5
    80006afc:	47c1                	li	a5,16
    80006afe:	00f70a63          	beq	a4,a5,80006b12 <isdirempty+0x4a>
      panic("isdirempty: readi");
    80006b02:	00005517          	auipc	a0,0x5
    80006b06:	b6650513          	addi	a0,a0,-1178 # 8000b668 <etext+0x668>
    80006b0a:	00002097          	auipc	ra,0x2
    80006b0e:	42c080e7          	jalr	1068(ra) # 80008f36 <panic>
    if(de.inum != 0)
    80006b12:	fd845783          	lhu	a5,-40(s0)
    80006b16:	c399                	beqz	a5,80006b1c <isdirempty+0x54>
      return 0;
    80006b18:	4781                	li	a5,0
    80006b1a:	a839                	j	80006b38 <isdirempty+0x70>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80006b1c:	fec42783          	lw	a5,-20(s0)
    80006b20:	27c1                	addiw	a5,a5,16
    80006b22:	2781                	sext.w	a5,a5
    80006b24:	fef42623          	sw	a5,-20(s0)
    80006b28:	fc843783          	ld	a5,-56(s0)
    80006b2c:	47f8                	lw	a4,76(a5)
    80006b2e:	fec42783          	lw	a5,-20(s0)
    80006b32:	fae7e6e3          	bltu	a5,a4,80006ade <isdirempty+0x16>
  }
  return 1;
    80006b36:	4785                	li	a5,1
}
    80006b38:	853e                	mv	a0,a5
    80006b3a:	70e2                	ld	ra,56(sp)
    80006b3c:	7442                	ld	s0,48(sp)
    80006b3e:	6121                	addi	sp,sp,64
    80006b40:	8082                	ret

0000000080006b42 <sys_unlink>:

uint64
sys_unlink(void)
{
    80006b42:	7155                	addi	sp,sp,-208
    80006b44:	e586                	sd	ra,200(sp)
    80006b46:	e1a2                	sd	s0,192(sp)
    80006b48:	0980                	addi	s0,sp,208
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], path[MAXPATH];
  uint off;

  if(argstr(0, path, MAXPATH) < 0)
    80006b4a:	f4040793          	addi	a5,s0,-192
    80006b4e:	08000613          	li	a2,128
    80006b52:	85be                	mv	a1,a5
    80006b54:	4501                	li	a0,0
    80006b56:	ffffc097          	auipc	ra,0xffffc
    80006b5a:	3da080e7          	jalr	986(ra) # 80002f30 <argstr>
    80006b5e:	87aa                	mv	a5,a0
    80006b60:	0007d463          	bgez	a5,80006b68 <sys_unlink+0x26>
    return -1;
    80006b64:	57fd                	li	a5,-1
    80006b66:	a2d5                	j	80006d4a <sys_unlink+0x208>

  begin_op();
    80006b68:	ffffe097          	auipc	ra,0xffffe
    80006b6c:	48c080e7          	jalr	1164(ra) # 80004ff4 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
    80006b70:	fc040713          	addi	a4,s0,-64
    80006b74:	f4040793          	addi	a5,s0,-192
    80006b78:	85ba                	mv	a1,a4
    80006b7a:	853e                	mv	a0,a5
    80006b7c:	ffffe097          	auipc	ra,0xffffe
    80006b80:	140080e7          	jalr	320(ra) # 80004cbc <nameiparent>
    80006b84:	fea43423          	sd	a0,-24(s0)
    80006b88:	fe843783          	ld	a5,-24(s0)
    80006b8c:	e799                	bnez	a5,80006b9a <sys_unlink+0x58>
    end_op();
    80006b8e:	ffffe097          	auipc	ra,0xffffe
    80006b92:	528080e7          	jalr	1320(ra) # 800050b6 <end_op>
    return -1;
    80006b96:	57fd                	li	a5,-1
    80006b98:	aa4d                	j	80006d4a <sys_unlink+0x208>
  }

  ilock(dp);
    80006b9a:	fe843503          	ld	a0,-24(s0)
    80006b9e:	ffffd097          	auipc	ra,0xffffd
    80006ba2:	3c2080e7          	jalr	962(ra) # 80003f60 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    80006ba6:	fc040793          	addi	a5,s0,-64
    80006baa:	00005597          	auipc	a1,0x5
    80006bae:	ad658593          	addi	a1,a1,-1322 # 8000b680 <etext+0x680>
    80006bb2:	853e                	mv	a0,a5
    80006bb4:	ffffe097          	auipc	ra,0xffffe
    80006bb8:	cbc080e7          	jalr	-836(ra) # 80004870 <namecmp>
    80006bbc:	87aa                	mv	a5,a0
    80006bbe:	16078863          	beqz	a5,80006d2e <sys_unlink+0x1ec>
    80006bc2:	fc040793          	addi	a5,s0,-64
    80006bc6:	00005597          	auipc	a1,0x5
    80006bca:	ac258593          	addi	a1,a1,-1342 # 8000b688 <etext+0x688>
    80006bce:	853e                	mv	a0,a5
    80006bd0:	ffffe097          	auipc	ra,0xffffe
    80006bd4:	ca0080e7          	jalr	-864(ra) # 80004870 <namecmp>
    80006bd8:	87aa                	mv	a5,a0
    80006bda:	14078a63          	beqz	a5,80006d2e <sys_unlink+0x1ec>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
    80006bde:	f3c40713          	addi	a4,s0,-196
    80006be2:	fc040793          	addi	a5,s0,-64
    80006be6:	863a                	mv	a2,a4
    80006be8:	85be                	mv	a1,a5
    80006bea:	fe843503          	ld	a0,-24(s0)
    80006bee:	ffffe097          	auipc	ra,0xffffe
    80006bf2:	cb0080e7          	jalr	-848(ra) # 8000489e <dirlookup>
    80006bf6:	fea43023          	sd	a0,-32(s0)
    80006bfa:	fe043783          	ld	a5,-32(s0)
    80006bfe:	12078a63          	beqz	a5,80006d32 <sys_unlink+0x1f0>
    goto bad;
  ilock(ip);
    80006c02:	fe043503          	ld	a0,-32(s0)
    80006c06:	ffffd097          	auipc	ra,0xffffd
    80006c0a:	35a080e7          	jalr	858(ra) # 80003f60 <ilock>

  if(ip->nlink < 1)
    80006c0e:	fe043783          	ld	a5,-32(s0)
    80006c12:	04a79783          	lh	a5,74(a5)
    80006c16:	00f04a63          	bgtz	a5,80006c2a <sys_unlink+0xe8>
    panic("unlink: nlink < 1");
    80006c1a:	00005517          	auipc	a0,0x5
    80006c1e:	a7650513          	addi	a0,a0,-1418 # 8000b690 <etext+0x690>
    80006c22:	00002097          	auipc	ra,0x2
    80006c26:	314080e7          	jalr	788(ra) # 80008f36 <panic>
  if(ip->type == T_DIR && !isdirempty(ip)){
    80006c2a:	fe043783          	ld	a5,-32(s0)
    80006c2e:	04479783          	lh	a5,68(a5)
    80006c32:	873e                	mv	a4,a5
    80006c34:	4785                	li	a5,1
    80006c36:	02f71163          	bne	a4,a5,80006c58 <sys_unlink+0x116>
    80006c3a:	fe043503          	ld	a0,-32(s0)
    80006c3e:	00000097          	auipc	ra,0x0
    80006c42:	e8a080e7          	jalr	-374(ra) # 80006ac8 <isdirempty>
    80006c46:	87aa                	mv	a5,a0
    80006c48:	eb81                	bnez	a5,80006c58 <sys_unlink+0x116>
    iunlockput(ip);
    80006c4a:	fe043503          	ld	a0,-32(s0)
    80006c4e:	ffffd097          	auipc	ra,0xffffd
    80006c52:	570080e7          	jalr	1392(ra) # 800041be <iunlockput>
    goto bad;
    80006c56:	a8f9                	j	80006d34 <sys_unlink+0x1f2>
  }

  memset(&de, 0, sizeof(de));
    80006c58:	fd040793          	addi	a5,s0,-48
    80006c5c:	4641                	li	a2,16
    80006c5e:	4581                	li	a1,0
    80006c60:	853e                	mv	a0,a5
    80006c62:	ffff9097          	auipc	ra,0xffff9
    80006c66:	5aa080e7          	jalr	1450(ra) # 8000020c <memset>
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80006c6a:	fd040793          	addi	a5,s0,-48
    80006c6e:	f3c42683          	lw	a3,-196(s0)
    80006c72:	4741                	li	a4,16
    80006c74:	863e                	mv	a2,a5
    80006c76:	4581                	li	a1,0
    80006c78:	fe843503          	ld	a0,-24(s0)
    80006c7c:	ffffe097          	auipc	ra,0xffffe
    80006c80:	a38080e7          	jalr	-1480(ra) # 800046b4 <writei>
    80006c84:	87aa                	mv	a5,a0
    80006c86:	873e                	mv	a4,a5
    80006c88:	47c1                	li	a5,16
    80006c8a:	00f70a63          	beq	a4,a5,80006c9e <sys_unlink+0x15c>
    panic("unlink: writei");
    80006c8e:	00005517          	auipc	a0,0x5
    80006c92:	a1a50513          	addi	a0,a0,-1510 # 8000b6a8 <etext+0x6a8>
    80006c96:	00002097          	auipc	ra,0x2
    80006c9a:	2a0080e7          	jalr	672(ra) # 80008f36 <panic>
  if(ip->type == T_DIR){
    80006c9e:	fe043783          	ld	a5,-32(s0)
    80006ca2:	04479783          	lh	a5,68(a5)
    80006ca6:	873e                	mv	a4,a5
    80006ca8:	4785                	li	a5,1
    80006caa:	02f71963          	bne	a4,a5,80006cdc <sys_unlink+0x19a>
    dp->nlink--;
    80006cae:	fe843783          	ld	a5,-24(s0)
    80006cb2:	04a79783          	lh	a5,74(a5)
    80006cb6:	17c2                	slli	a5,a5,0x30
    80006cb8:	93c1                	srli	a5,a5,0x30
    80006cba:	37fd                	addiw	a5,a5,-1
    80006cbc:	17c2                	slli	a5,a5,0x30
    80006cbe:	93c1                	srli	a5,a5,0x30
    80006cc0:	0107971b          	slliw	a4,a5,0x10
    80006cc4:	4107571b          	sraiw	a4,a4,0x10
    80006cc8:	fe843783          	ld	a5,-24(s0)
    80006ccc:	04e79523          	sh	a4,74(a5)
    iupdate(dp);
    80006cd0:	fe843503          	ld	a0,-24(s0)
    80006cd4:	ffffd097          	auipc	ra,0xffffd
    80006cd8:	03c080e7          	jalr	60(ra) # 80003d10 <iupdate>
  }
  iunlockput(dp);
    80006cdc:	fe843503          	ld	a0,-24(s0)
    80006ce0:	ffffd097          	auipc	ra,0xffffd
    80006ce4:	4de080e7          	jalr	1246(ra) # 800041be <iunlockput>

  ip->nlink--;
    80006ce8:	fe043783          	ld	a5,-32(s0)
    80006cec:	04a79783          	lh	a5,74(a5)
    80006cf0:	17c2                	slli	a5,a5,0x30
    80006cf2:	93c1                	srli	a5,a5,0x30
    80006cf4:	37fd                	addiw	a5,a5,-1
    80006cf6:	17c2                	slli	a5,a5,0x30
    80006cf8:	93c1                	srli	a5,a5,0x30
    80006cfa:	0107971b          	slliw	a4,a5,0x10
    80006cfe:	4107571b          	sraiw	a4,a4,0x10
    80006d02:	fe043783          	ld	a5,-32(s0)
    80006d06:	04e79523          	sh	a4,74(a5)
  iupdate(ip);
    80006d0a:	fe043503          	ld	a0,-32(s0)
    80006d0e:	ffffd097          	auipc	ra,0xffffd
    80006d12:	002080e7          	jalr	2(ra) # 80003d10 <iupdate>
  iunlockput(ip);
    80006d16:	fe043503          	ld	a0,-32(s0)
    80006d1a:	ffffd097          	auipc	ra,0xffffd
    80006d1e:	4a4080e7          	jalr	1188(ra) # 800041be <iunlockput>

  end_op();
    80006d22:	ffffe097          	auipc	ra,0xffffe
    80006d26:	394080e7          	jalr	916(ra) # 800050b6 <end_op>

  return 0;
    80006d2a:	4781                	li	a5,0
    80006d2c:	a839                	j	80006d4a <sys_unlink+0x208>
    goto bad;
    80006d2e:	0001                	nop
    80006d30:	a011                	j	80006d34 <sys_unlink+0x1f2>
    goto bad;
    80006d32:	0001                	nop

bad:
  iunlockput(dp);
    80006d34:	fe843503          	ld	a0,-24(s0)
    80006d38:	ffffd097          	auipc	ra,0xffffd
    80006d3c:	486080e7          	jalr	1158(ra) # 800041be <iunlockput>
  end_op();
    80006d40:	ffffe097          	auipc	ra,0xffffe
    80006d44:	376080e7          	jalr	886(ra) # 800050b6 <end_op>
  return -1;
    80006d48:	57fd                	li	a5,-1
}
    80006d4a:	853e                	mv	a0,a5
    80006d4c:	60ae                	ld	ra,200(sp)
    80006d4e:	640e                	ld	s0,192(sp)
    80006d50:	6169                	addi	sp,sp,208
    80006d52:	8082                	ret

0000000080006d54 <create>:

static struct inode*
create(char *path, short type, short major, short minor)
{
    80006d54:	7139                	addi	sp,sp,-64
    80006d56:	fc06                	sd	ra,56(sp)
    80006d58:	f822                	sd	s0,48(sp)
    80006d5a:	0080                	addi	s0,sp,64
    80006d5c:	fca43423          	sd	a0,-56(s0)
    80006d60:	87ae                	mv	a5,a1
    80006d62:	8736                	mv	a4,a3
    80006d64:	fcf41323          	sh	a5,-58(s0)
    80006d68:	87b2                	mv	a5,a2
    80006d6a:	fcf41223          	sh	a5,-60(s0)
    80006d6e:	87ba                	mv	a5,a4
    80006d70:	fcf41123          	sh	a5,-62(s0)
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    80006d74:	fd040793          	addi	a5,s0,-48
    80006d78:	85be                	mv	a1,a5
    80006d7a:	fc843503          	ld	a0,-56(s0)
    80006d7e:	ffffe097          	auipc	ra,0xffffe
    80006d82:	f3e080e7          	jalr	-194(ra) # 80004cbc <nameiparent>
    80006d86:	fea43423          	sd	a0,-24(s0)
    80006d8a:	fe843783          	ld	a5,-24(s0)
    80006d8e:	e399                	bnez	a5,80006d94 <create+0x40>
    return 0;
    80006d90:	4781                	li	a5,0
    80006d92:	a2dd                	j	80006f78 <create+0x224>

  ilock(dp);
    80006d94:	fe843503          	ld	a0,-24(s0)
    80006d98:	ffffd097          	auipc	ra,0xffffd
    80006d9c:	1c8080e7          	jalr	456(ra) # 80003f60 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
    80006da0:	fd040793          	addi	a5,s0,-48
    80006da4:	4601                	li	a2,0
    80006da6:	85be                	mv	a1,a5
    80006da8:	fe843503          	ld	a0,-24(s0)
    80006dac:	ffffe097          	auipc	ra,0xffffe
    80006db0:	af2080e7          	jalr	-1294(ra) # 8000489e <dirlookup>
    80006db4:	fea43023          	sd	a0,-32(s0)
    80006db8:	fe043783          	ld	a5,-32(s0)
    80006dbc:	cfb9                	beqz	a5,80006e1a <create+0xc6>
    iunlockput(dp);
    80006dbe:	fe843503          	ld	a0,-24(s0)
    80006dc2:	ffffd097          	auipc	ra,0xffffd
    80006dc6:	3fc080e7          	jalr	1020(ra) # 800041be <iunlockput>
    ilock(ip);
    80006dca:	fe043503          	ld	a0,-32(s0)
    80006dce:	ffffd097          	auipc	ra,0xffffd
    80006dd2:	192080e7          	jalr	402(ra) # 80003f60 <ilock>
    if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    80006dd6:	fc641783          	lh	a5,-58(s0)
    80006dda:	0007871b          	sext.w	a4,a5
    80006dde:	4789                	li	a5,2
    80006de0:	02f71563          	bne	a4,a5,80006e0a <create+0xb6>
    80006de4:	fe043783          	ld	a5,-32(s0)
    80006de8:	04479783          	lh	a5,68(a5)
    80006dec:	873e                	mv	a4,a5
    80006dee:	4789                	li	a5,2
    80006df0:	00f70a63          	beq	a4,a5,80006e04 <create+0xb0>
    80006df4:	fe043783          	ld	a5,-32(s0)
    80006df8:	04479783          	lh	a5,68(a5)
    80006dfc:	873e                	mv	a4,a5
    80006dfe:	478d                	li	a5,3
    80006e00:	00f71563          	bne	a4,a5,80006e0a <create+0xb6>
      return ip;
    80006e04:	fe043783          	ld	a5,-32(s0)
    80006e08:	aa85                	j	80006f78 <create+0x224>
    iunlockput(ip);
    80006e0a:	fe043503          	ld	a0,-32(s0)
    80006e0e:	ffffd097          	auipc	ra,0xffffd
    80006e12:	3b0080e7          	jalr	944(ra) # 800041be <iunlockput>
    return 0;
    80006e16:	4781                	li	a5,0
    80006e18:	a285                	j	80006f78 <create+0x224>
  }

  if((ip = ialloc(dp->dev, type)) == 0){
    80006e1a:	fe843783          	ld	a5,-24(s0)
    80006e1e:	439c                	lw	a5,0(a5)
    80006e20:	fc641703          	lh	a4,-58(s0)
    80006e24:	85ba                	mv	a1,a4
    80006e26:	853e                	mv	a0,a5
    80006e28:	ffffd097          	auipc	ra,0xffffd
    80006e2c:	dea080e7          	jalr	-534(ra) # 80003c12 <ialloc>
    80006e30:	fea43023          	sd	a0,-32(s0)
    80006e34:	fe043783          	ld	a5,-32(s0)
    80006e38:	eb89                	bnez	a5,80006e4a <create+0xf6>
    iunlockput(dp);
    80006e3a:	fe843503          	ld	a0,-24(s0)
    80006e3e:	ffffd097          	auipc	ra,0xffffd
    80006e42:	380080e7          	jalr	896(ra) # 800041be <iunlockput>
    return 0;
    80006e46:	4781                	li	a5,0
    80006e48:	aa05                	j	80006f78 <create+0x224>
  }

  ilock(ip);
    80006e4a:	fe043503          	ld	a0,-32(s0)
    80006e4e:	ffffd097          	auipc	ra,0xffffd
    80006e52:	112080e7          	jalr	274(ra) # 80003f60 <ilock>
  ip->major = major;
    80006e56:	fe043783          	ld	a5,-32(s0)
    80006e5a:	fc445703          	lhu	a4,-60(s0)
    80006e5e:	04e79323          	sh	a4,70(a5)
  ip->minor = minor;
    80006e62:	fe043783          	ld	a5,-32(s0)
    80006e66:	fc245703          	lhu	a4,-62(s0)
    80006e6a:	04e79423          	sh	a4,72(a5)
  ip->nlink = 1;
    80006e6e:	fe043783          	ld	a5,-32(s0)
    80006e72:	4705                	li	a4,1
    80006e74:	04e79523          	sh	a4,74(a5)
  iupdate(ip);
    80006e78:	fe043503          	ld	a0,-32(s0)
    80006e7c:	ffffd097          	auipc	ra,0xffffd
    80006e80:	e94080e7          	jalr	-364(ra) # 80003d10 <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
    80006e84:	fc641783          	lh	a5,-58(s0)
    80006e88:	0007871b          	sext.w	a4,a5
    80006e8c:	4785                	li	a5,1
    80006e8e:	04f71463          	bne	a4,a5,80006ed6 <create+0x182>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    80006e92:	fe043783          	ld	a5,-32(s0)
    80006e96:	43dc                	lw	a5,4(a5)
    80006e98:	863e                	mv	a2,a5
    80006e9a:	00004597          	auipc	a1,0x4
    80006e9e:	7e658593          	addi	a1,a1,2022 # 8000b680 <etext+0x680>
    80006ea2:	fe043503          	ld	a0,-32(s0)
    80006ea6:	ffffe097          	auipc	ra,0xffffe
    80006eaa:	ade080e7          	jalr	-1314(ra) # 80004984 <dirlink>
    80006eae:	87aa                	mv	a5,a0
    80006eb0:	0807ca63          	bltz	a5,80006f44 <create+0x1f0>
    80006eb4:	fe843783          	ld	a5,-24(s0)
    80006eb8:	43dc                	lw	a5,4(a5)
    80006eba:	863e                	mv	a2,a5
    80006ebc:	00004597          	auipc	a1,0x4
    80006ec0:	7cc58593          	addi	a1,a1,1996 # 8000b688 <etext+0x688>
    80006ec4:	fe043503          	ld	a0,-32(s0)
    80006ec8:	ffffe097          	auipc	ra,0xffffe
    80006ecc:	abc080e7          	jalr	-1348(ra) # 80004984 <dirlink>
    80006ed0:	87aa                	mv	a5,a0
    80006ed2:	0607c963          	bltz	a5,80006f44 <create+0x1f0>
      goto fail;
  }

  if(dirlink(dp, name, ip->inum) < 0)
    80006ed6:	fe043783          	ld	a5,-32(s0)
    80006eda:	43d8                	lw	a4,4(a5)
    80006edc:	fd040793          	addi	a5,s0,-48
    80006ee0:	863a                	mv	a2,a4
    80006ee2:	85be                	mv	a1,a5
    80006ee4:	fe843503          	ld	a0,-24(s0)
    80006ee8:	ffffe097          	auipc	ra,0xffffe
    80006eec:	a9c080e7          	jalr	-1380(ra) # 80004984 <dirlink>
    80006ef0:	87aa                	mv	a5,a0
    80006ef2:	0407cb63          	bltz	a5,80006f48 <create+0x1f4>
    goto fail;

  if(type == T_DIR){
    80006ef6:	fc641783          	lh	a5,-58(s0)
    80006efa:	0007871b          	sext.w	a4,a5
    80006efe:	4785                	li	a5,1
    80006f00:	02f71963          	bne	a4,a5,80006f32 <create+0x1de>
    // now that success is guaranteed:
    dp->nlink++;  // for ".."
    80006f04:	fe843783          	ld	a5,-24(s0)
    80006f08:	04a79783          	lh	a5,74(a5)
    80006f0c:	17c2                	slli	a5,a5,0x30
    80006f0e:	93c1                	srli	a5,a5,0x30
    80006f10:	2785                	addiw	a5,a5,1
    80006f12:	17c2                	slli	a5,a5,0x30
    80006f14:	93c1                	srli	a5,a5,0x30
    80006f16:	0107971b          	slliw	a4,a5,0x10
    80006f1a:	4107571b          	sraiw	a4,a4,0x10
    80006f1e:	fe843783          	ld	a5,-24(s0)
    80006f22:	04e79523          	sh	a4,74(a5)
    iupdate(dp);
    80006f26:	fe843503          	ld	a0,-24(s0)
    80006f2a:	ffffd097          	auipc	ra,0xffffd
    80006f2e:	de6080e7          	jalr	-538(ra) # 80003d10 <iupdate>
  }

  iunlockput(dp);
    80006f32:	fe843503          	ld	a0,-24(s0)
    80006f36:	ffffd097          	auipc	ra,0xffffd
    80006f3a:	288080e7          	jalr	648(ra) # 800041be <iunlockput>

  return ip;
    80006f3e:	fe043783          	ld	a5,-32(s0)
    80006f42:	a81d                	j	80006f78 <create+0x224>
      goto fail;
    80006f44:	0001                	nop
    80006f46:	a011                	j	80006f4a <create+0x1f6>
    goto fail;
    80006f48:	0001                	nop

 fail:
  // something went wrong. de-allocate ip.
  ip->nlink = 0;
    80006f4a:	fe043783          	ld	a5,-32(s0)
    80006f4e:	04079523          	sh	zero,74(a5)
  iupdate(ip);
    80006f52:	fe043503          	ld	a0,-32(s0)
    80006f56:	ffffd097          	auipc	ra,0xffffd
    80006f5a:	dba080e7          	jalr	-582(ra) # 80003d10 <iupdate>
  iunlockput(ip);
    80006f5e:	fe043503          	ld	a0,-32(s0)
    80006f62:	ffffd097          	auipc	ra,0xffffd
    80006f66:	25c080e7          	jalr	604(ra) # 800041be <iunlockput>
  iunlockput(dp);
    80006f6a:	fe843503          	ld	a0,-24(s0)
    80006f6e:	ffffd097          	auipc	ra,0xffffd
    80006f72:	250080e7          	jalr	592(ra) # 800041be <iunlockput>
  return 0;
    80006f76:	4781                	li	a5,0
}
    80006f78:	853e                	mv	a0,a5
    80006f7a:	70e2                	ld	ra,56(sp)
    80006f7c:	7442                	ld	s0,48(sp)
    80006f7e:	6121                	addi	sp,sp,64
    80006f80:	8082                	ret

0000000080006f82 <sys_open>:

uint64
sys_open(void)
{
    80006f82:	7131                	addi	sp,sp,-192
    80006f84:	fd06                	sd	ra,184(sp)
    80006f86:	f922                	sd	s0,176(sp)
    80006f88:	0180                	addi	s0,sp,192
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  argint(1, &omode);
    80006f8a:	f4c40793          	addi	a5,s0,-180
    80006f8e:	85be                	mv	a1,a5
    80006f90:	4505                	li	a0,1
    80006f92:	ffffc097          	auipc	ra,0xffffc
    80006f96:	f36080e7          	jalr	-202(ra) # 80002ec8 <argint>
  if((n = argstr(0, path, MAXPATH)) < 0)
    80006f9a:	f5040793          	addi	a5,s0,-176
    80006f9e:	08000613          	li	a2,128
    80006fa2:	85be                	mv	a1,a5
    80006fa4:	4501                	li	a0,0
    80006fa6:	ffffc097          	auipc	ra,0xffffc
    80006faa:	f8a080e7          	jalr	-118(ra) # 80002f30 <argstr>
    80006fae:	87aa                	mv	a5,a0
    80006fb0:	fef42223          	sw	a5,-28(s0)
    80006fb4:	fe442783          	lw	a5,-28(s0)
    80006fb8:	2781                	sext.w	a5,a5
    80006fba:	0007d463          	bgez	a5,80006fc2 <sys_open+0x40>
    return -1;
    80006fbe:	57fd                	li	a5,-1
    80006fc0:	aafd                	j	800071be <sys_open+0x23c>

  begin_op();
    80006fc2:	ffffe097          	auipc	ra,0xffffe
    80006fc6:	032080e7          	jalr	50(ra) # 80004ff4 <begin_op>

  if(omode & O_CREATE){
    80006fca:	f4c42783          	lw	a5,-180(s0)
    80006fce:	2007f793          	andi	a5,a5,512
    80006fd2:	2781                	sext.w	a5,a5
    80006fd4:	c795                	beqz	a5,80007000 <sys_open+0x7e>
    ip = create(path, T_FILE, 0, 0);
    80006fd6:	f5040793          	addi	a5,s0,-176
    80006fda:	4681                	li	a3,0
    80006fdc:	4601                	li	a2,0
    80006fde:	4589                	li	a1,2
    80006fe0:	853e                	mv	a0,a5
    80006fe2:	00000097          	auipc	ra,0x0
    80006fe6:	d72080e7          	jalr	-654(ra) # 80006d54 <create>
    80006fea:	fea43423          	sd	a0,-24(s0)
    if(ip == 0){
    80006fee:	fe843783          	ld	a5,-24(s0)
    80006ff2:	e7b5                	bnez	a5,8000705e <sys_open+0xdc>
      end_op();
    80006ff4:	ffffe097          	auipc	ra,0xffffe
    80006ff8:	0c2080e7          	jalr	194(ra) # 800050b6 <end_op>
      return -1;
    80006ffc:	57fd                	li	a5,-1
    80006ffe:	a2c1                	j	800071be <sys_open+0x23c>
    }
  } else {
    if((ip = namei(path)) == 0){
    80007000:	f5040793          	addi	a5,s0,-176
    80007004:	853e                	mv	a0,a5
    80007006:	ffffe097          	auipc	ra,0xffffe
    8000700a:	c8a080e7          	jalr	-886(ra) # 80004c90 <namei>
    8000700e:	fea43423          	sd	a0,-24(s0)
    80007012:	fe843783          	ld	a5,-24(s0)
    80007016:	e799                	bnez	a5,80007024 <sys_open+0xa2>
      end_op();
    80007018:	ffffe097          	auipc	ra,0xffffe
    8000701c:	09e080e7          	jalr	158(ra) # 800050b6 <end_op>
      return -1;
    80007020:	57fd                	li	a5,-1
    80007022:	aa71                	j	800071be <sys_open+0x23c>
    }
    ilock(ip);
    80007024:	fe843503          	ld	a0,-24(s0)
    80007028:	ffffd097          	auipc	ra,0xffffd
    8000702c:	f38080e7          	jalr	-200(ra) # 80003f60 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
    80007030:	fe843783          	ld	a5,-24(s0)
    80007034:	04479783          	lh	a5,68(a5)
    80007038:	873e                	mv	a4,a5
    8000703a:	4785                	li	a5,1
    8000703c:	02f71163          	bne	a4,a5,8000705e <sys_open+0xdc>
    80007040:	f4c42783          	lw	a5,-180(s0)
    80007044:	cf89                	beqz	a5,8000705e <sys_open+0xdc>
      iunlockput(ip);
    80007046:	fe843503          	ld	a0,-24(s0)
    8000704a:	ffffd097          	auipc	ra,0xffffd
    8000704e:	174080e7          	jalr	372(ra) # 800041be <iunlockput>
      end_op();
    80007052:	ffffe097          	auipc	ra,0xffffe
    80007056:	064080e7          	jalr	100(ra) # 800050b6 <end_op>
      return -1;
    8000705a:	57fd                	li	a5,-1
    8000705c:	a28d                	j	800071be <sys_open+0x23c>
    }
  }

  if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    8000705e:	fe843783          	ld	a5,-24(s0)
    80007062:	04479783          	lh	a5,68(a5)
    80007066:	873e                	mv	a4,a5
    80007068:	478d                	li	a5,3
    8000706a:	02f71c63          	bne	a4,a5,800070a2 <sys_open+0x120>
    8000706e:	fe843783          	ld	a5,-24(s0)
    80007072:	04679783          	lh	a5,70(a5)
    80007076:	0007ca63          	bltz	a5,8000708a <sys_open+0x108>
    8000707a:	fe843783          	ld	a5,-24(s0)
    8000707e:	04679783          	lh	a5,70(a5)
    80007082:	873e                	mv	a4,a5
    80007084:	47a5                	li	a5,9
    80007086:	00e7de63          	bge	a5,a4,800070a2 <sys_open+0x120>
    iunlockput(ip);
    8000708a:	fe843503          	ld	a0,-24(s0)
    8000708e:	ffffd097          	auipc	ra,0xffffd
    80007092:	130080e7          	jalr	304(ra) # 800041be <iunlockput>
    end_op();
    80007096:	ffffe097          	auipc	ra,0xffffe
    8000709a:	020080e7          	jalr	32(ra) # 800050b6 <end_op>
    return -1;
    8000709e:	57fd                	li	a5,-1
    800070a0:	aa39                	j	800071be <sys_open+0x23c>
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    800070a2:	ffffe097          	auipc	ra,0xffffe
    800070a6:	502080e7          	jalr	1282(ra) # 800055a4 <filealloc>
    800070aa:	fca43c23          	sd	a0,-40(s0)
    800070ae:	fd843783          	ld	a5,-40(s0)
    800070b2:	cf99                	beqz	a5,800070d0 <sys_open+0x14e>
    800070b4:	fd843503          	ld	a0,-40(s0)
    800070b8:	fffff097          	auipc	ra,0xfffff
    800070bc:	5fc080e7          	jalr	1532(ra) # 800066b4 <fdalloc>
    800070c0:	87aa                	mv	a5,a0
    800070c2:	fcf42a23          	sw	a5,-44(s0)
    800070c6:	fd442783          	lw	a5,-44(s0)
    800070ca:	2781                	sext.w	a5,a5
    800070cc:	0207d763          	bgez	a5,800070fa <sys_open+0x178>
    if(f)
    800070d0:	fd843783          	ld	a5,-40(s0)
    800070d4:	c799                	beqz	a5,800070e2 <sys_open+0x160>
      fileclose(f);
    800070d6:	fd843503          	ld	a0,-40(s0)
    800070da:	ffffe097          	auipc	ra,0xffffe
    800070de:	5b4080e7          	jalr	1460(ra) # 8000568e <fileclose>
    iunlockput(ip);
    800070e2:	fe843503          	ld	a0,-24(s0)
    800070e6:	ffffd097          	auipc	ra,0xffffd
    800070ea:	0d8080e7          	jalr	216(ra) # 800041be <iunlockput>
    end_op();
    800070ee:	ffffe097          	auipc	ra,0xffffe
    800070f2:	fc8080e7          	jalr	-56(ra) # 800050b6 <end_op>
    return -1;
    800070f6:	57fd                	li	a5,-1
    800070f8:	a0d9                	j	800071be <sys_open+0x23c>
  }

  if(ip->type == T_DEVICE){
    800070fa:	fe843783          	ld	a5,-24(s0)
    800070fe:	04479783          	lh	a5,68(a5)
    80007102:	873e                	mv	a4,a5
    80007104:	478d                	li	a5,3
    80007106:	00f71f63          	bne	a4,a5,80007124 <sys_open+0x1a2>
    f->type = FD_DEVICE;
    8000710a:	fd843783          	ld	a5,-40(s0)
    8000710e:	470d                	li	a4,3
    80007110:	c398                	sw	a4,0(a5)
    f->major = ip->major;
    80007112:	fe843783          	ld	a5,-24(s0)
    80007116:	04679703          	lh	a4,70(a5)
    8000711a:	fd843783          	ld	a5,-40(s0)
    8000711e:	02e79223          	sh	a4,36(a5)
    80007122:	a809                	j	80007134 <sys_open+0x1b2>
  } else {
    f->type = FD_INODE;
    80007124:	fd843783          	ld	a5,-40(s0)
    80007128:	4709                	li	a4,2
    8000712a:	c398                	sw	a4,0(a5)
    f->off = 0;
    8000712c:	fd843783          	ld	a5,-40(s0)
    80007130:	0207a023          	sw	zero,32(a5)
  }
  f->ip = ip;
    80007134:	fd843783          	ld	a5,-40(s0)
    80007138:	fe843703          	ld	a4,-24(s0)
    8000713c:	ef98                	sd	a4,24(a5)
  f->readable = !(omode & O_WRONLY);
    8000713e:	f4c42783          	lw	a5,-180(s0)
    80007142:	8b85                	andi	a5,a5,1
    80007144:	2781                	sext.w	a5,a5
    80007146:	0017b793          	seqz	a5,a5
    8000714a:	0ff7f793          	zext.b	a5,a5
    8000714e:	873e                	mv	a4,a5
    80007150:	fd843783          	ld	a5,-40(s0)
    80007154:	00e78423          	sb	a4,8(a5)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    80007158:	f4c42783          	lw	a5,-180(s0)
    8000715c:	8b85                	andi	a5,a5,1
    8000715e:	2781                	sext.w	a5,a5
    80007160:	e791                	bnez	a5,8000716c <sys_open+0x1ea>
    80007162:	f4c42783          	lw	a5,-180(s0)
    80007166:	8b89                	andi	a5,a5,2
    80007168:	2781                	sext.w	a5,a5
    8000716a:	c399                	beqz	a5,80007170 <sys_open+0x1ee>
    8000716c:	4785                	li	a5,1
    8000716e:	a011                	j	80007172 <sys_open+0x1f0>
    80007170:	4781                	li	a5,0
    80007172:	0ff7f713          	zext.b	a4,a5
    80007176:	fd843783          	ld	a5,-40(s0)
    8000717a:	00e784a3          	sb	a4,9(a5)

  if((omode & O_TRUNC) && ip->type == T_FILE){
    8000717e:	f4c42783          	lw	a5,-180(s0)
    80007182:	4007f793          	andi	a5,a5,1024
    80007186:	2781                	sext.w	a5,a5
    80007188:	cf99                	beqz	a5,800071a6 <sys_open+0x224>
    8000718a:	fe843783          	ld	a5,-24(s0)
    8000718e:	04479783          	lh	a5,68(a5)
    80007192:	873e                	mv	a4,a5
    80007194:	4789                	li	a5,2
    80007196:	00f71863          	bne	a4,a5,800071a6 <sys_open+0x224>
    itrunc(ip);
    8000719a:	fe843503          	ld	a0,-24(s0)
    8000719e:	ffffd097          	auipc	ra,0xffffd
    800071a2:	1ca080e7          	jalr	458(ra) # 80004368 <itrunc>
  }

  iunlock(ip);
    800071a6:	fe843503          	ld	a0,-24(s0)
    800071aa:	ffffd097          	auipc	ra,0xffffd
    800071ae:	eea080e7          	jalr	-278(ra) # 80004094 <iunlock>
  end_op();
    800071b2:	ffffe097          	auipc	ra,0xffffe
    800071b6:	f04080e7          	jalr	-252(ra) # 800050b6 <end_op>

  return fd;
    800071ba:	fd442783          	lw	a5,-44(s0)
}
    800071be:	853e                	mv	a0,a5
    800071c0:	70ea                	ld	ra,184(sp)
    800071c2:	744a                	ld	s0,176(sp)
    800071c4:	6129                	addi	sp,sp,192
    800071c6:	8082                	ret

00000000800071c8 <sys_mkdir>:

uint64
sys_mkdir(void)
{
    800071c8:	7135                	addi	sp,sp,-160
    800071ca:	ed06                	sd	ra,152(sp)
    800071cc:	e922                	sd	s0,144(sp)
    800071ce:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;

  begin_op();
    800071d0:	ffffe097          	auipc	ra,0xffffe
    800071d4:	e24080e7          	jalr	-476(ra) # 80004ff4 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    800071d8:	f6840793          	addi	a5,s0,-152
    800071dc:	08000613          	li	a2,128
    800071e0:	85be                	mv	a1,a5
    800071e2:	4501                	li	a0,0
    800071e4:	ffffc097          	auipc	ra,0xffffc
    800071e8:	d4c080e7          	jalr	-692(ra) # 80002f30 <argstr>
    800071ec:	87aa                	mv	a5,a0
    800071ee:	0207c163          	bltz	a5,80007210 <sys_mkdir+0x48>
    800071f2:	f6840793          	addi	a5,s0,-152
    800071f6:	4681                	li	a3,0
    800071f8:	4601                	li	a2,0
    800071fa:	4585                	li	a1,1
    800071fc:	853e                	mv	a0,a5
    800071fe:	00000097          	auipc	ra,0x0
    80007202:	b56080e7          	jalr	-1194(ra) # 80006d54 <create>
    80007206:	fea43423          	sd	a0,-24(s0)
    8000720a:	fe843783          	ld	a5,-24(s0)
    8000720e:	e799                	bnez	a5,8000721c <sys_mkdir+0x54>
    end_op();
    80007210:	ffffe097          	auipc	ra,0xffffe
    80007214:	ea6080e7          	jalr	-346(ra) # 800050b6 <end_op>
    return -1;
    80007218:	57fd                	li	a5,-1
    8000721a:	a821                	j	80007232 <sys_mkdir+0x6a>
  }
  iunlockput(ip);
    8000721c:	fe843503          	ld	a0,-24(s0)
    80007220:	ffffd097          	auipc	ra,0xffffd
    80007224:	f9e080e7          	jalr	-98(ra) # 800041be <iunlockput>
  end_op();
    80007228:	ffffe097          	auipc	ra,0xffffe
    8000722c:	e8e080e7          	jalr	-370(ra) # 800050b6 <end_op>
  return 0;
    80007230:	4781                	li	a5,0
}
    80007232:	853e                	mv	a0,a5
    80007234:	60ea                	ld	ra,152(sp)
    80007236:	644a                	ld	s0,144(sp)
    80007238:	610d                	addi	sp,sp,160
    8000723a:	8082                	ret

000000008000723c <sys_mknod>:

uint64
sys_mknod(void)
{
    8000723c:	7135                	addi	sp,sp,-160
    8000723e:	ed06                	sd	ra,152(sp)
    80007240:	e922                	sd	s0,144(sp)
    80007242:	1100                	addi	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op();
    80007244:	ffffe097          	auipc	ra,0xffffe
    80007248:	db0080e7          	jalr	-592(ra) # 80004ff4 <begin_op>
  argint(1, &major);
    8000724c:	f6440793          	addi	a5,s0,-156
    80007250:	85be                	mv	a1,a5
    80007252:	4505                	li	a0,1
    80007254:	ffffc097          	auipc	ra,0xffffc
    80007258:	c74080e7          	jalr	-908(ra) # 80002ec8 <argint>
  argint(2, &minor);
    8000725c:	f6040793          	addi	a5,s0,-160
    80007260:	85be                	mv	a1,a5
    80007262:	4509                	li	a0,2
    80007264:	ffffc097          	auipc	ra,0xffffc
    80007268:	c64080e7          	jalr	-924(ra) # 80002ec8 <argint>
  if((argstr(0, path, MAXPATH)) < 0 ||
    8000726c:	f6840793          	addi	a5,s0,-152
    80007270:	08000613          	li	a2,128
    80007274:	85be                	mv	a1,a5
    80007276:	4501                	li	a0,0
    80007278:	ffffc097          	auipc	ra,0xffffc
    8000727c:	cb8080e7          	jalr	-840(ra) # 80002f30 <argstr>
    80007280:	87aa                	mv	a5,a0
    80007282:	0207cc63          	bltz	a5,800072ba <sys_mknod+0x7e>
     (ip = create(path, T_DEVICE, major, minor)) == 0){
    80007286:	f6442783          	lw	a5,-156(s0)
    8000728a:	0107971b          	slliw	a4,a5,0x10
    8000728e:	4107571b          	sraiw	a4,a4,0x10
    80007292:	f6042783          	lw	a5,-160(s0)
    80007296:	0107969b          	slliw	a3,a5,0x10
    8000729a:	4106d69b          	sraiw	a3,a3,0x10
    8000729e:	f6840793          	addi	a5,s0,-152
    800072a2:	863a                	mv	a2,a4
    800072a4:	458d                	li	a1,3
    800072a6:	853e                	mv	a0,a5
    800072a8:	00000097          	auipc	ra,0x0
    800072ac:	aac080e7          	jalr	-1364(ra) # 80006d54 <create>
    800072b0:	fea43423          	sd	a0,-24(s0)
  if((argstr(0, path, MAXPATH)) < 0 ||
    800072b4:	fe843783          	ld	a5,-24(s0)
    800072b8:	e799                	bnez	a5,800072c6 <sys_mknod+0x8a>
    end_op();
    800072ba:	ffffe097          	auipc	ra,0xffffe
    800072be:	dfc080e7          	jalr	-516(ra) # 800050b6 <end_op>
    return -1;
    800072c2:	57fd                	li	a5,-1
    800072c4:	a821                	j	800072dc <sys_mknod+0xa0>
  }
  iunlockput(ip);
    800072c6:	fe843503          	ld	a0,-24(s0)
    800072ca:	ffffd097          	auipc	ra,0xffffd
    800072ce:	ef4080e7          	jalr	-268(ra) # 800041be <iunlockput>
  end_op();
    800072d2:	ffffe097          	auipc	ra,0xffffe
    800072d6:	de4080e7          	jalr	-540(ra) # 800050b6 <end_op>
  return 0;
    800072da:	4781                	li	a5,0
}
    800072dc:	853e                	mv	a0,a5
    800072de:	60ea                	ld	ra,152(sp)
    800072e0:	644a                	ld	s0,144(sp)
    800072e2:	610d                	addi	sp,sp,160
    800072e4:	8082                	ret

00000000800072e6 <sys_chdir>:

uint64
sys_chdir(void)
{
    800072e6:	7135                	addi	sp,sp,-160
    800072e8:	ed06                	sd	ra,152(sp)
    800072ea:	e922                	sd	s0,144(sp)
    800072ec:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    800072ee:	ffffa097          	auipc	ra,0xffffa
    800072f2:	312080e7          	jalr	786(ra) # 80001600 <myproc>
    800072f6:	fea43423          	sd	a0,-24(s0)
  
  begin_op();
    800072fa:	ffffe097          	auipc	ra,0xffffe
    800072fe:	cfa080e7          	jalr	-774(ra) # 80004ff4 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    80007302:	f6040793          	addi	a5,s0,-160
    80007306:	08000613          	li	a2,128
    8000730a:	85be                	mv	a1,a5
    8000730c:	4501                	li	a0,0
    8000730e:	ffffc097          	auipc	ra,0xffffc
    80007312:	c22080e7          	jalr	-990(ra) # 80002f30 <argstr>
    80007316:	87aa                	mv	a5,a0
    80007318:	0007ce63          	bltz	a5,80007334 <sys_chdir+0x4e>
    8000731c:	f6040793          	addi	a5,s0,-160
    80007320:	853e                	mv	a0,a5
    80007322:	ffffe097          	auipc	ra,0xffffe
    80007326:	96e080e7          	jalr	-1682(ra) # 80004c90 <namei>
    8000732a:	fea43023          	sd	a0,-32(s0)
    8000732e:	fe043783          	ld	a5,-32(s0)
    80007332:	e799                	bnez	a5,80007340 <sys_chdir+0x5a>
    end_op();
    80007334:	ffffe097          	auipc	ra,0xffffe
    80007338:	d82080e7          	jalr	-638(ra) # 800050b6 <end_op>
    return -1;
    8000733c:	57fd                	li	a5,-1
    8000733e:	a0ad                	j	800073a8 <sys_chdir+0xc2>
  }
  ilock(ip);
    80007340:	fe043503          	ld	a0,-32(s0)
    80007344:	ffffd097          	auipc	ra,0xffffd
    80007348:	c1c080e7          	jalr	-996(ra) # 80003f60 <ilock>
  if(ip->type != T_DIR){
    8000734c:	fe043783          	ld	a5,-32(s0)
    80007350:	04479783          	lh	a5,68(a5)
    80007354:	873e                	mv	a4,a5
    80007356:	4785                	li	a5,1
    80007358:	00f70e63          	beq	a4,a5,80007374 <sys_chdir+0x8e>
    iunlockput(ip);
    8000735c:	fe043503          	ld	a0,-32(s0)
    80007360:	ffffd097          	auipc	ra,0xffffd
    80007364:	e5e080e7          	jalr	-418(ra) # 800041be <iunlockput>
    end_op();
    80007368:	ffffe097          	auipc	ra,0xffffe
    8000736c:	d4e080e7          	jalr	-690(ra) # 800050b6 <end_op>
    return -1;
    80007370:	57fd                	li	a5,-1
    80007372:	a81d                	j	800073a8 <sys_chdir+0xc2>
  }
  iunlock(ip);
    80007374:	fe043503          	ld	a0,-32(s0)
    80007378:	ffffd097          	auipc	ra,0xffffd
    8000737c:	d1c080e7          	jalr	-740(ra) # 80004094 <iunlock>
  iput(p->cwd);
    80007380:	fe843783          	ld	a5,-24(s0)
    80007384:	1507b783          	ld	a5,336(a5)
    80007388:	853e                	mv	a0,a5
    8000738a:	ffffd097          	auipc	ra,0xffffd
    8000738e:	d64080e7          	jalr	-668(ra) # 800040ee <iput>
  end_op();
    80007392:	ffffe097          	auipc	ra,0xffffe
    80007396:	d24080e7          	jalr	-732(ra) # 800050b6 <end_op>
  p->cwd = ip;
    8000739a:	fe843783          	ld	a5,-24(s0)
    8000739e:	fe043703          	ld	a4,-32(s0)
    800073a2:	14e7b823          	sd	a4,336(a5)
  return 0;
    800073a6:	4781                	li	a5,0
}
    800073a8:	853e                	mv	a0,a5
    800073aa:	60ea                	ld	ra,152(sp)
    800073ac:	644a                	ld	s0,144(sp)
    800073ae:	610d                	addi	sp,sp,160
    800073b0:	8082                	ret

00000000800073b2 <sys_exec>:

uint64
sys_exec(void)
{
    800073b2:	7161                	addi	sp,sp,-432
    800073b4:	f706                	sd	ra,424(sp)
    800073b6:	f322                	sd	s0,416(sp)
    800073b8:	1b00                	addi	s0,sp,432
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  argaddr(1, &uargv);
    800073ba:	e6040793          	addi	a5,s0,-416
    800073be:	85be                	mv	a1,a5
    800073c0:	4505                	li	a0,1
    800073c2:	ffffc097          	auipc	ra,0xffffc
    800073c6:	b3c080e7          	jalr	-1220(ra) # 80002efe <argaddr>
  if(argstr(0, path, MAXPATH) < 0) {
    800073ca:	f6840793          	addi	a5,s0,-152
    800073ce:	08000613          	li	a2,128
    800073d2:	85be                	mv	a1,a5
    800073d4:	4501                	li	a0,0
    800073d6:	ffffc097          	auipc	ra,0xffffc
    800073da:	b5a080e7          	jalr	-1190(ra) # 80002f30 <argstr>
    800073de:	87aa                	mv	a5,a0
    800073e0:	0007d463          	bgez	a5,800073e8 <sys_exec+0x36>
    return -1;
    800073e4:	57fd                	li	a5,-1
    800073e6:	aa8d                	j	80007558 <sys_exec+0x1a6>
  }
  memset(argv, 0, sizeof(argv));
    800073e8:	e6840793          	addi	a5,s0,-408
    800073ec:	10000613          	li	a2,256
    800073f0:	4581                	li	a1,0
    800073f2:	853e                	mv	a0,a5
    800073f4:	ffff9097          	auipc	ra,0xffff9
    800073f8:	e18080e7          	jalr	-488(ra) # 8000020c <memset>
  for(i=0;; i++){
    800073fc:	fe042623          	sw	zero,-20(s0)
    if(i >= NELEM(argv)){
    80007400:	fec42783          	lw	a5,-20(s0)
    80007404:	873e                	mv	a4,a5
    80007406:	47fd                	li	a5,31
    80007408:	0ee7ee63          	bltu	a5,a4,80007504 <sys_exec+0x152>
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    8000740c:	fec42783          	lw	a5,-20(s0)
    80007410:	00379713          	slli	a4,a5,0x3
    80007414:	e6043783          	ld	a5,-416(s0)
    80007418:	97ba                	add	a5,a5,a4
    8000741a:	e5840713          	addi	a4,s0,-424
    8000741e:	85ba                	mv	a1,a4
    80007420:	853e                	mv	a0,a5
    80007422:	ffffc097          	auipc	ra,0xffffc
    80007426:	934080e7          	jalr	-1740(ra) # 80002d56 <fetchaddr>
    8000742a:	87aa                	mv	a5,a0
    8000742c:	0c07ce63          	bltz	a5,80007508 <sys_exec+0x156>
      goto bad;
    }
    if(uarg == 0){
    80007430:	e5843783          	ld	a5,-424(s0)
    80007434:	eb8d                	bnez	a5,80007466 <sys_exec+0xb4>
      argv[i] = 0;
    80007436:	fec42783          	lw	a5,-20(s0)
    8000743a:	078e                	slli	a5,a5,0x3
    8000743c:	17c1                	addi	a5,a5,-16
    8000743e:	97a2                	add	a5,a5,s0
    80007440:	e607bc23          	sd	zero,-392(a5)
      break;
    80007444:	0001                	nop
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
      goto bad;
  }

  int ret = exec(path, argv);
    80007446:	e6840713          	addi	a4,s0,-408
    8000744a:	f6840793          	addi	a5,s0,-152
    8000744e:	85ba                	mv	a1,a4
    80007450:	853e                	mv	a0,a5
    80007452:	fffff097          	auipc	ra,0xfffff
    80007456:	c34080e7          	jalr	-972(ra) # 80006086 <exec>
    8000745a:	87aa                	mv	a5,a0
    8000745c:	fef42423          	sw	a5,-24(s0)

  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80007460:	fe042623          	sw	zero,-20(s0)
    80007464:	a8bd                	j	800074e2 <sys_exec+0x130>
    argv[i] = kalloc();
    80007466:	ffff9097          	auipc	ra,0xffff9
    8000746a:	cf2080e7          	jalr	-782(ra) # 80000158 <kalloc>
    8000746e:	872a                	mv	a4,a0
    80007470:	fec42783          	lw	a5,-20(s0)
    80007474:	078e                	slli	a5,a5,0x3
    80007476:	17c1                	addi	a5,a5,-16
    80007478:	97a2                	add	a5,a5,s0
    8000747a:	e6e7bc23          	sd	a4,-392(a5)
    if(argv[i] == 0)
    8000747e:	fec42783          	lw	a5,-20(s0)
    80007482:	078e                	slli	a5,a5,0x3
    80007484:	17c1                	addi	a5,a5,-16
    80007486:	97a2                	add	a5,a5,s0
    80007488:	e787b783          	ld	a5,-392(a5)
    8000748c:	c3c1                	beqz	a5,8000750c <sys_exec+0x15a>
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    8000748e:	e5843703          	ld	a4,-424(s0)
    80007492:	fec42783          	lw	a5,-20(s0)
    80007496:	078e                	slli	a5,a5,0x3
    80007498:	17c1                	addi	a5,a5,-16
    8000749a:	97a2                	add	a5,a5,s0
    8000749c:	e787b783          	ld	a5,-392(a5)
    800074a0:	6605                	lui	a2,0x1
    800074a2:	85be                	mv	a1,a5
    800074a4:	853a                	mv	a0,a4
    800074a6:	ffffc097          	auipc	ra,0xffffc
    800074aa:	91e080e7          	jalr	-1762(ra) # 80002dc4 <fetchstr>
    800074ae:	87aa                	mv	a5,a0
    800074b0:	0607c063          	bltz	a5,80007510 <sys_exec+0x15e>
  for(i=0;; i++){
    800074b4:	fec42783          	lw	a5,-20(s0)
    800074b8:	2785                	addiw	a5,a5,1
    800074ba:	fef42623          	sw	a5,-20(s0)
    if(i >= NELEM(argv)){
    800074be:	b789                	j	80007400 <sys_exec+0x4e>
    kfree(argv[i]);
    800074c0:	fec42783          	lw	a5,-20(s0)
    800074c4:	078e                	slli	a5,a5,0x3
    800074c6:	17c1                	addi	a5,a5,-16
    800074c8:	97a2                	add	a5,a5,s0
    800074ca:	e787b783          	ld	a5,-392(a5)
    800074ce:	853e                	mv	a0,a5
    800074d0:	ffff9097          	auipc	ra,0xffff9
    800074d4:	be4080e7          	jalr	-1052(ra) # 800000b4 <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    800074d8:	fec42783          	lw	a5,-20(s0)
    800074dc:	2785                	addiw	a5,a5,1
    800074de:	fef42623          	sw	a5,-20(s0)
    800074e2:	fec42783          	lw	a5,-20(s0)
    800074e6:	873e                	mv	a4,a5
    800074e8:	47fd                	li	a5,31
    800074ea:	00e7ea63          	bltu	a5,a4,800074fe <sys_exec+0x14c>
    800074ee:	fec42783          	lw	a5,-20(s0)
    800074f2:	078e                	slli	a5,a5,0x3
    800074f4:	17c1                	addi	a5,a5,-16
    800074f6:	97a2                	add	a5,a5,s0
    800074f8:	e787b783          	ld	a5,-392(a5)
    800074fc:	f3f1                	bnez	a5,800074c0 <sys_exec+0x10e>

  return ret;
    800074fe:	fe842783          	lw	a5,-24(s0)
    80007502:	a899                	j	80007558 <sys_exec+0x1a6>
      goto bad;
    80007504:	0001                	nop
    80007506:	a031                	j	80007512 <sys_exec+0x160>
      goto bad;
    80007508:	0001                	nop
    8000750a:	a021                	j	80007512 <sys_exec+0x160>
      goto bad;
    8000750c:	0001                	nop
    8000750e:	a011                	j	80007512 <sys_exec+0x160>
      goto bad;
    80007510:	0001                	nop

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80007512:	fe042623          	sw	zero,-20(s0)
    80007516:	a015                	j	8000753a <sys_exec+0x188>
    kfree(argv[i]);
    80007518:	fec42783          	lw	a5,-20(s0)
    8000751c:	078e                	slli	a5,a5,0x3
    8000751e:	17c1                	addi	a5,a5,-16
    80007520:	97a2                	add	a5,a5,s0
    80007522:	e787b783          	ld	a5,-392(a5)
    80007526:	853e                	mv	a0,a5
    80007528:	ffff9097          	auipc	ra,0xffff9
    8000752c:	b8c080e7          	jalr	-1140(ra) # 800000b4 <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80007530:	fec42783          	lw	a5,-20(s0)
    80007534:	2785                	addiw	a5,a5,1
    80007536:	fef42623          	sw	a5,-20(s0)
    8000753a:	fec42783          	lw	a5,-20(s0)
    8000753e:	873e                	mv	a4,a5
    80007540:	47fd                	li	a5,31
    80007542:	00e7ea63          	bltu	a5,a4,80007556 <sys_exec+0x1a4>
    80007546:	fec42783          	lw	a5,-20(s0)
    8000754a:	078e                	slli	a5,a5,0x3
    8000754c:	17c1                	addi	a5,a5,-16
    8000754e:	97a2                	add	a5,a5,s0
    80007550:	e787b783          	ld	a5,-392(a5)
    80007554:	f3f1                	bnez	a5,80007518 <sys_exec+0x166>
  return -1;
    80007556:	57fd                	li	a5,-1
}
    80007558:	853e                	mv	a0,a5
    8000755a:	70ba                	ld	ra,424(sp)
    8000755c:	741a                	ld	s0,416(sp)
    8000755e:	615d                	addi	sp,sp,432
    80007560:	8082                	ret

0000000080007562 <sys_pipe>:

uint64
sys_pipe(void)
{
    80007562:	7139                	addi	sp,sp,-64
    80007564:	fc06                	sd	ra,56(sp)
    80007566:	f822                	sd	s0,48(sp)
    80007568:	0080                	addi	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    8000756a:	ffffa097          	auipc	ra,0xffffa
    8000756e:	096080e7          	jalr	150(ra) # 80001600 <myproc>
    80007572:	fea43423          	sd	a0,-24(s0)

  argaddr(0, &fdarray);
    80007576:	fe040793          	addi	a5,s0,-32
    8000757a:	85be                	mv	a1,a5
    8000757c:	4501                	li	a0,0
    8000757e:	ffffc097          	auipc	ra,0xffffc
    80007582:	980080e7          	jalr	-1664(ra) # 80002efe <argaddr>
  if(pipealloc(&rf, &wf) < 0)
    80007586:	fd040713          	addi	a4,s0,-48
    8000758a:	fd840793          	addi	a5,s0,-40
    8000758e:	85ba                	mv	a1,a4
    80007590:	853e                	mv	a0,a5
    80007592:	ffffe097          	auipc	ra,0xffffe
    80007596:	60e080e7          	jalr	1550(ra) # 80005ba0 <pipealloc>
    8000759a:	87aa                	mv	a5,a0
    8000759c:	0007d463          	bgez	a5,800075a4 <sys_pipe+0x42>
    return -1;
    800075a0:	57fd                	li	a5,-1
    800075a2:	a219                	j	800076a8 <sys_pipe+0x146>
  fd0 = -1;
    800075a4:	57fd                	li	a5,-1
    800075a6:	fcf42623          	sw	a5,-52(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    800075aa:	fd843783          	ld	a5,-40(s0)
    800075ae:	853e                	mv	a0,a5
    800075b0:	fffff097          	auipc	ra,0xfffff
    800075b4:	104080e7          	jalr	260(ra) # 800066b4 <fdalloc>
    800075b8:	87aa                	mv	a5,a0
    800075ba:	fcf42623          	sw	a5,-52(s0)
    800075be:	fcc42783          	lw	a5,-52(s0)
    800075c2:	0207c063          	bltz	a5,800075e2 <sys_pipe+0x80>
    800075c6:	fd043783          	ld	a5,-48(s0)
    800075ca:	853e                	mv	a0,a5
    800075cc:	fffff097          	auipc	ra,0xfffff
    800075d0:	0e8080e7          	jalr	232(ra) # 800066b4 <fdalloc>
    800075d4:	87aa                	mv	a5,a0
    800075d6:	fcf42423          	sw	a5,-56(s0)
    800075da:	fc842783          	lw	a5,-56(s0)
    800075de:	0207df63          	bgez	a5,8000761c <sys_pipe+0xba>
    if(fd0 >= 0)
    800075e2:	fcc42783          	lw	a5,-52(s0)
    800075e6:	0007cb63          	bltz	a5,800075fc <sys_pipe+0x9a>
      p->ofile[fd0] = 0;
    800075ea:	fcc42783          	lw	a5,-52(s0)
    800075ee:	fe843703          	ld	a4,-24(s0)
    800075f2:	07e9                	addi	a5,a5,26
    800075f4:	078e                	slli	a5,a5,0x3
    800075f6:	97ba                	add	a5,a5,a4
    800075f8:	0007b023          	sd	zero,0(a5)
    fileclose(rf);
    800075fc:	fd843783          	ld	a5,-40(s0)
    80007600:	853e                	mv	a0,a5
    80007602:	ffffe097          	auipc	ra,0xffffe
    80007606:	08c080e7          	jalr	140(ra) # 8000568e <fileclose>
    fileclose(wf);
    8000760a:	fd043783          	ld	a5,-48(s0)
    8000760e:	853e                	mv	a0,a5
    80007610:	ffffe097          	auipc	ra,0xffffe
    80007614:	07e080e7          	jalr	126(ra) # 8000568e <fileclose>
    return -1;
    80007618:	57fd                	li	a5,-1
    8000761a:	a079                	j	800076a8 <sys_pipe+0x146>
  }
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    8000761c:	fe843783          	ld	a5,-24(s0)
    80007620:	6bbc                	ld	a5,80(a5)
    80007622:	fe043703          	ld	a4,-32(s0)
    80007626:	fcc40613          	addi	a2,s0,-52
    8000762a:	4691                	li	a3,4
    8000762c:	85ba                	mv	a1,a4
    8000762e:	853e                	mv	a0,a5
    80007630:	ffffa097          	auipc	ra,0xffffa
    80007634:	a9a080e7          	jalr	-1382(ra) # 800010ca <copyout>
    80007638:	87aa                	mv	a5,a0
    8000763a:	0207c463          	bltz	a5,80007662 <sys_pipe+0x100>
     copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    8000763e:	fe843783          	ld	a5,-24(s0)
    80007642:	6bb8                	ld	a4,80(a5)
    80007644:	fe043783          	ld	a5,-32(s0)
    80007648:	0791                	addi	a5,a5,4
    8000764a:	fc840613          	addi	a2,s0,-56
    8000764e:	4691                	li	a3,4
    80007650:	85be                	mv	a1,a5
    80007652:	853a                	mv	a0,a4
    80007654:	ffffa097          	auipc	ra,0xffffa
    80007658:	a76080e7          	jalr	-1418(ra) # 800010ca <copyout>
    8000765c:	87aa                	mv	a5,a0
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    8000765e:	0407d463          	bgez	a5,800076a6 <sys_pipe+0x144>
    p->ofile[fd0] = 0;
    80007662:	fcc42783          	lw	a5,-52(s0)
    80007666:	fe843703          	ld	a4,-24(s0)
    8000766a:	07e9                	addi	a5,a5,26
    8000766c:	078e                	slli	a5,a5,0x3
    8000766e:	97ba                	add	a5,a5,a4
    80007670:	0007b023          	sd	zero,0(a5)
    p->ofile[fd1] = 0;
    80007674:	fc842783          	lw	a5,-56(s0)
    80007678:	fe843703          	ld	a4,-24(s0)
    8000767c:	07e9                	addi	a5,a5,26
    8000767e:	078e                	slli	a5,a5,0x3
    80007680:	97ba                	add	a5,a5,a4
    80007682:	0007b023          	sd	zero,0(a5)
    fileclose(rf);
    80007686:	fd843783          	ld	a5,-40(s0)
    8000768a:	853e                	mv	a0,a5
    8000768c:	ffffe097          	auipc	ra,0xffffe
    80007690:	002080e7          	jalr	2(ra) # 8000568e <fileclose>
    fileclose(wf);
    80007694:	fd043783          	ld	a5,-48(s0)
    80007698:	853e                	mv	a0,a5
    8000769a:	ffffe097          	auipc	ra,0xffffe
    8000769e:	ff4080e7          	jalr	-12(ra) # 8000568e <fileclose>
    return -1;
    800076a2:	57fd                	li	a5,-1
    800076a4:	a011                	j	800076a8 <sys_pipe+0x146>
  }
  return 0;
    800076a6:	4781                	li	a5,0
}
    800076a8:	853e                	mv	a0,a5
    800076aa:	70e2                	ld	ra,56(sp)
    800076ac:	7442                	ld	s0,48(sp)
    800076ae:	6121                	addi	sp,sp,64
    800076b0:	8082                	ret
	...

00000000800076c0 <kernelvec>:
    800076c0:	7111                	addi	sp,sp,-256
    800076c2:	e006                	sd	ra,0(sp)
    800076c4:	e40a                	sd	sp,8(sp)
    800076c6:	e80e                	sd	gp,16(sp)
    800076c8:	ec12                	sd	tp,24(sp)
    800076ca:	f016                	sd	t0,32(sp)
    800076cc:	f41a                	sd	t1,40(sp)
    800076ce:	f81e                	sd	t2,48(sp)
    800076d0:	fc22                	sd	s0,56(sp)
    800076d2:	e0a6                	sd	s1,64(sp)
    800076d4:	e4aa                	sd	a0,72(sp)
    800076d6:	e8ae                	sd	a1,80(sp)
    800076d8:	ecb2                	sd	a2,88(sp)
    800076da:	f0b6                	sd	a3,96(sp)
    800076dc:	f4ba                	sd	a4,104(sp)
    800076de:	f8be                	sd	a5,112(sp)
    800076e0:	fcc2                	sd	a6,120(sp)
    800076e2:	e146                	sd	a7,128(sp)
    800076e4:	e54a                	sd	s2,136(sp)
    800076e6:	e94e                	sd	s3,144(sp)
    800076e8:	ed52                	sd	s4,152(sp)
    800076ea:	f156                	sd	s5,160(sp)
    800076ec:	f55a                	sd	s6,168(sp)
    800076ee:	f95e                	sd	s7,176(sp)
    800076f0:	fd62                	sd	s8,184(sp)
    800076f2:	e1e6                	sd	s9,192(sp)
    800076f4:	e5ea                	sd	s10,200(sp)
    800076f6:	e9ee                	sd	s11,208(sp)
    800076f8:	edf2                	sd	t3,216(sp)
    800076fa:	f1f6                	sd	t4,224(sp)
    800076fc:	f5fa                	sd	t5,232(sp)
    800076fe:	f9fe                	sd	t6,240(sp)
    80007700:	beefb0ef          	jal	ra,80002aee <kerneltrap>
    80007704:	6082                	ld	ra,0(sp)
    80007706:	6122                	ld	sp,8(sp)
    80007708:	61c2                	ld	gp,16(sp)
    8000770a:	7282                	ld	t0,32(sp)
    8000770c:	7322                	ld	t1,40(sp)
    8000770e:	73c2                	ld	t2,48(sp)
    80007710:	7462                	ld	s0,56(sp)
    80007712:	6486                	ld	s1,64(sp)
    80007714:	6526                	ld	a0,72(sp)
    80007716:	65c6                	ld	a1,80(sp)
    80007718:	6666                	ld	a2,88(sp)
    8000771a:	7686                	ld	a3,96(sp)
    8000771c:	7726                	ld	a4,104(sp)
    8000771e:	77c6                	ld	a5,112(sp)
    80007720:	7866                	ld	a6,120(sp)
    80007722:	688a                	ld	a7,128(sp)
    80007724:	692a                	ld	s2,136(sp)
    80007726:	69ca                	ld	s3,144(sp)
    80007728:	6a6a                	ld	s4,152(sp)
    8000772a:	7a8a                	ld	s5,160(sp)
    8000772c:	7b2a                	ld	s6,168(sp)
    8000772e:	7bca                	ld	s7,176(sp)
    80007730:	7c6a                	ld	s8,184(sp)
    80007732:	6c8e                	ld	s9,192(sp)
    80007734:	6d2e                	ld	s10,200(sp)
    80007736:	6dce                	ld	s11,208(sp)
    80007738:	6e6e                	ld	t3,216(sp)
    8000773a:	7e8e                	ld	t4,224(sp)
    8000773c:	7f2e                	ld	t5,232(sp)
    8000773e:	7fce                	ld	t6,240(sp)
    80007740:	6111                	addi	sp,sp,256
    80007742:	10200073          	sret
    80007746:	00000013          	nop
    8000774a:	00000013          	nop
    8000774e:	0001                	nop

0000000080007750 <timervec>:
    80007750:	34051573          	csrrw	a0,mscratch,a0
    80007754:	e10c                	sd	a1,0(a0)
    80007756:	e510                	sd	a2,8(a0)
    80007758:	e914                	sd	a3,16(a0)
    8000775a:	6d0c                	ld	a1,24(a0)
    8000775c:	7110                	ld	a2,32(a0)
    8000775e:	6194                	ld	a3,0(a1)
    80007760:	96b2                	add	a3,a3,a2
    80007762:	e194                	sd	a3,0(a1)
    80007764:	4589                	li	a1,2
    80007766:	14459073          	csrw	sip,a1
    8000776a:	6914                	ld	a3,16(a0)
    8000776c:	6510                	ld	a2,8(a0)
    8000776e:	610c                	ld	a1,0(a0)
    80007770:	34051573          	csrrw	a0,mscratch,a0
    80007774:	30200073          	mret
	...

000000008000777a <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    8000777a:	1141                	addi	sp,sp,-16
    8000777c:	e422                	sd	s0,8(sp)
    8000777e:	0800                	addi	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ*4) = 1;
    80007780:	0c0007b7          	lui	a5,0xc000
    80007784:	02878793          	addi	a5,a5,40 # c000028 <_entry-0x73ffffd8>
    80007788:	4705                	li	a4,1
    8000778a:	c398                	sw	a4,0(a5)
  *(uint32*)(PLIC + VIRTIO0_IRQ*4) = 1;
    8000778c:	0c0007b7          	lui	a5,0xc000
    80007790:	0791                	addi	a5,a5,4 # c000004 <_entry-0x73fffffc>
    80007792:	4705                	li	a4,1
    80007794:	c398                	sw	a4,0(a5)
}
    80007796:	0001                	nop
    80007798:	6422                	ld	s0,8(sp)
    8000779a:	0141                	addi	sp,sp,16
    8000779c:	8082                	ret

000000008000779e <plicinithart>:

void
plicinithart(void)
{
    8000779e:	1101                	addi	sp,sp,-32
    800077a0:	ec06                	sd	ra,24(sp)
    800077a2:	e822                	sd	s0,16(sp)
    800077a4:	1000                	addi	s0,sp,32
  int hart = cpuid();
    800077a6:	ffffa097          	auipc	ra,0xffffa
    800077aa:	dfc080e7          	jalr	-516(ra) # 800015a2 <cpuid>
    800077ae:	87aa                	mv	a5,a0
    800077b0:	fef42623          	sw	a5,-20(s0)
  
  // set enable bits for this hart's S-mode
  // for the uart and virtio disk.
  *(uint32*)PLIC_SENABLE(hart) = (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    800077b4:	fec42783          	lw	a5,-20(s0)
    800077b8:	0087979b          	slliw	a5,a5,0x8
    800077bc:	2781                	sext.w	a5,a5
    800077be:	873e                	mv	a4,a5
    800077c0:	0c0027b7          	lui	a5,0xc002
    800077c4:	08078793          	addi	a5,a5,128 # c002080 <_entry-0x73ffdf80>
    800077c8:	97ba                	add	a5,a5,a4
    800077ca:	873e                	mv	a4,a5
    800077cc:	40200793          	li	a5,1026
    800077d0:	c31c                	sw	a5,0(a4)

  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    800077d2:	fec42783          	lw	a5,-20(s0)
    800077d6:	00d7979b          	slliw	a5,a5,0xd
    800077da:	2781                	sext.w	a5,a5
    800077dc:	873e                	mv	a4,a5
    800077de:	0c2017b7          	lui	a5,0xc201
    800077e2:	97ba                	add	a5,a5,a4
    800077e4:	0007a023          	sw	zero,0(a5) # c201000 <_entry-0x73dff000>
}
    800077e8:	0001                	nop
    800077ea:	60e2                	ld	ra,24(sp)
    800077ec:	6442                	ld	s0,16(sp)
    800077ee:	6105                	addi	sp,sp,32
    800077f0:	8082                	ret

00000000800077f2 <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    800077f2:	1101                	addi	sp,sp,-32
    800077f4:	ec06                	sd	ra,24(sp)
    800077f6:	e822                	sd	s0,16(sp)
    800077f8:	1000                	addi	s0,sp,32
  int hart = cpuid();
    800077fa:	ffffa097          	auipc	ra,0xffffa
    800077fe:	da8080e7          	jalr	-600(ra) # 800015a2 <cpuid>
    80007802:	87aa                	mv	a5,a0
    80007804:	fef42623          	sw	a5,-20(s0)
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    80007808:	fec42783          	lw	a5,-20(s0)
    8000780c:	00d7979b          	slliw	a5,a5,0xd
    80007810:	2781                	sext.w	a5,a5
    80007812:	873e                	mv	a4,a5
    80007814:	0c2017b7          	lui	a5,0xc201
    80007818:	0791                	addi	a5,a5,4 # c201004 <_entry-0x73dfeffc>
    8000781a:	97ba                	add	a5,a5,a4
    8000781c:	439c                	lw	a5,0(a5)
    8000781e:	fef42423          	sw	a5,-24(s0)
  return irq;
    80007822:	fe842783          	lw	a5,-24(s0)
}
    80007826:	853e                	mv	a0,a5
    80007828:	60e2                	ld	ra,24(sp)
    8000782a:	6442                	ld	s0,16(sp)
    8000782c:	6105                	addi	sp,sp,32
    8000782e:	8082                	ret

0000000080007830 <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    80007830:	7179                	addi	sp,sp,-48
    80007832:	f406                	sd	ra,40(sp)
    80007834:	f022                	sd	s0,32(sp)
    80007836:	1800                	addi	s0,sp,48
    80007838:	87aa                	mv	a5,a0
    8000783a:	fcf42e23          	sw	a5,-36(s0)
  int hart = cpuid();
    8000783e:	ffffa097          	auipc	ra,0xffffa
    80007842:	d64080e7          	jalr	-668(ra) # 800015a2 <cpuid>
    80007846:	87aa                	mv	a5,a0
    80007848:	fef42623          	sw	a5,-20(s0)
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    8000784c:	fec42783          	lw	a5,-20(s0)
    80007850:	00d7979b          	slliw	a5,a5,0xd
    80007854:	2781                	sext.w	a5,a5
    80007856:	873e                	mv	a4,a5
    80007858:	0c2017b7          	lui	a5,0xc201
    8000785c:	0791                	addi	a5,a5,4 # c201004 <_entry-0x73dfeffc>
    8000785e:	97ba                	add	a5,a5,a4
    80007860:	873e                	mv	a4,a5
    80007862:	fdc42783          	lw	a5,-36(s0)
    80007866:	c31c                	sw	a5,0(a4)
}
    80007868:	0001                	nop
    8000786a:	70a2                	ld	ra,40(sp)
    8000786c:	7402                	ld	s0,32(sp)
    8000786e:	6145                	addi	sp,sp,48
    80007870:	8082                	ret

0000000080007872 <virtio_disk_init>:
  
} disk;

void
virtio_disk_init(void)
{
    80007872:	7179                	addi	sp,sp,-48
    80007874:	f406                	sd	ra,40(sp)
    80007876:	f022                	sd	s0,32(sp)
    80007878:	1800                	addi	s0,sp,48
  uint32 status = 0;
    8000787a:	fe042423          	sw	zero,-24(s0)

  initlock(&disk.vdisk_lock, "virtio_disk");
    8000787e:	00004597          	auipc	a1,0x4
    80007882:	e3a58593          	addi	a1,a1,-454 # 8000b6b8 <etext+0x6b8>
    80007886:	00015517          	auipc	a0,0x15
    8000788a:	60a50513          	addi	a0,a0,1546 # 8001ce90 <disk+0x128>
    8000788e:	00002097          	auipc	ra,0x2
    80007892:	ac0080e7          	jalr	-1344(ra) # 8000934e <initlock>

  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80007896:	100017b7          	lui	a5,0x10001
    8000789a:	439c                	lw	a5,0(a5)
    8000789c:	2781                	sext.w	a5,a5
    8000789e:	873e                	mv	a4,a5
    800078a0:	747277b7          	lui	a5,0x74727
    800078a4:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    800078a8:	04f71063          	bne	a4,a5,800078e8 <virtio_disk_init+0x76>
     *R(VIRTIO_MMIO_VERSION) != 2 ||
    800078ac:	100017b7          	lui	a5,0x10001
    800078b0:	0791                	addi	a5,a5,4 # 10001004 <_entry-0x6fffeffc>
    800078b2:	439c                	lw	a5,0(a5)
    800078b4:	2781                	sext.w	a5,a5
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    800078b6:	873e                	mv	a4,a5
    800078b8:	4789                	li	a5,2
    800078ba:	02f71763          	bne	a4,a5,800078e8 <virtio_disk_init+0x76>
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    800078be:	100017b7          	lui	a5,0x10001
    800078c2:	07a1                	addi	a5,a5,8 # 10001008 <_entry-0x6fffeff8>
    800078c4:	439c                	lw	a5,0(a5)
    800078c6:	2781                	sext.w	a5,a5
     *R(VIRTIO_MMIO_VERSION) != 2 ||
    800078c8:	873e                	mv	a4,a5
    800078ca:	4789                	li	a5,2
    800078cc:	00f71e63          	bne	a4,a5,800078e8 <virtio_disk_init+0x76>
     *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551){
    800078d0:	100017b7          	lui	a5,0x10001
    800078d4:	07b1                	addi	a5,a5,12 # 1000100c <_entry-0x6fffeff4>
    800078d6:	439c                	lw	a5,0(a5)
    800078d8:	2781                	sext.w	a5,a5
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    800078da:	873e                	mv	a4,a5
    800078dc:	554d47b7          	lui	a5,0x554d4
    800078e0:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    800078e4:	00f70a63          	beq	a4,a5,800078f8 <virtio_disk_init+0x86>
    panic("could not find virtio disk");
    800078e8:	00004517          	auipc	a0,0x4
    800078ec:	de050513          	addi	a0,a0,-544 # 8000b6c8 <etext+0x6c8>
    800078f0:	00001097          	auipc	ra,0x1
    800078f4:	646080e7          	jalr	1606(ra) # 80008f36 <panic>
  }
  
  // reset device
  *R(VIRTIO_MMIO_STATUS) = status;
    800078f8:	100017b7          	lui	a5,0x10001
    800078fc:	07078793          	addi	a5,a5,112 # 10001070 <_entry-0x6fffef90>
    80007900:	fe842703          	lw	a4,-24(s0)
    80007904:	c398                	sw	a4,0(a5)

  // set ACKNOWLEDGE status bit
  status |= VIRTIO_CONFIG_S_ACKNOWLEDGE;
    80007906:	fe842783          	lw	a5,-24(s0)
    8000790a:	0017e793          	ori	a5,a5,1
    8000790e:	fef42423          	sw	a5,-24(s0)
  *R(VIRTIO_MMIO_STATUS) = status;
    80007912:	100017b7          	lui	a5,0x10001
    80007916:	07078793          	addi	a5,a5,112 # 10001070 <_entry-0x6fffef90>
    8000791a:	fe842703          	lw	a4,-24(s0)
    8000791e:	c398                	sw	a4,0(a5)

  // set DRIVER status bit
  status |= VIRTIO_CONFIG_S_DRIVER;
    80007920:	fe842783          	lw	a5,-24(s0)
    80007924:	0027e793          	ori	a5,a5,2
    80007928:	fef42423          	sw	a5,-24(s0)
  *R(VIRTIO_MMIO_STATUS) = status;
    8000792c:	100017b7          	lui	a5,0x10001
    80007930:	07078793          	addi	a5,a5,112 # 10001070 <_entry-0x6fffef90>
    80007934:	fe842703          	lw	a4,-24(s0)
    80007938:	c398                	sw	a4,0(a5)

  // negotiate features
  uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    8000793a:	100017b7          	lui	a5,0x10001
    8000793e:	07c1                	addi	a5,a5,16 # 10001010 <_entry-0x6fffeff0>
    80007940:	439c                	lw	a5,0(a5)
    80007942:	2781                	sext.w	a5,a5
    80007944:	1782                	slli	a5,a5,0x20
    80007946:	9381                	srli	a5,a5,0x20
    80007948:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_BLK_F_RO);
    8000794c:	fe043783          	ld	a5,-32(s0)
    80007950:	fdf7f793          	andi	a5,a5,-33
    80007954:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_BLK_F_SCSI);
    80007958:	fe043783          	ld	a5,-32(s0)
    8000795c:	f7f7f793          	andi	a5,a5,-129
    80007960:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_BLK_F_CONFIG_WCE);
    80007964:	fe043703          	ld	a4,-32(s0)
    80007968:	77fd                	lui	a5,0xfffff
    8000796a:	7ff78793          	addi	a5,a5,2047 # fffffffffffff7ff <end+0xffffffff7ffda70f>
    8000796e:	8ff9                	and	a5,a5,a4
    80007970:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_BLK_F_MQ);
    80007974:	fe043703          	ld	a4,-32(s0)
    80007978:	77fd                	lui	a5,0xfffff
    8000797a:	17fd                	addi	a5,a5,-1 # ffffffffffffefff <end+0xffffffff7ffd9f0f>
    8000797c:	8ff9                	and	a5,a5,a4
    8000797e:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_F_ANY_LAYOUT);
    80007982:	fe043703          	ld	a4,-32(s0)
    80007986:	f80007b7          	lui	a5,0xf8000
    8000798a:	17fd                	addi	a5,a5,-1 # fffffffff7ffffff <end+0xffffffff77fdaf0f>
    8000798c:	8ff9                	and	a5,a5,a4
    8000798e:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_RING_F_EVENT_IDX);
    80007992:	fe043703          	ld	a4,-32(s0)
    80007996:	e00007b7          	lui	a5,0xe0000
    8000799a:	17fd                	addi	a5,a5,-1 # ffffffffdfffffff <end+0xffffffff5ffdaf0f>
    8000799c:	8ff9                	and	a5,a5,a4
    8000799e:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
    800079a2:	fe043703          	ld	a4,-32(s0)
    800079a6:	f00007b7          	lui	a5,0xf0000
    800079aa:	17fd                	addi	a5,a5,-1 # ffffffffefffffff <end+0xffffffff6ffdaf0f>
    800079ac:	8ff9                	and	a5,a5,a4
    800079ae:	fef43023          	sd	a5,-32(s0)
  *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    800079b2:	100017b7          	lui	a5,0x10001
    800079b6:	02078793          	addi	a5,a5,32 # 10001020 <_entry-0x6fffefe0>
    800079ba:	fe043703          	ld	a4,-32(s0)
    800079be:	2701                	sext.w	a4,a4
    800079c0:	c398                	sw	a4,0(a5)

  // tell device that feature negotiation is complete.
  status |= VIRTIO_CONFIG_S_FEATURES_OK;
    800079c2:	fe842783          	lw	a5,-24(s0)
    800079c6:	0087e793          	ori	a5,a5,8
    800079ca:	fef42423          	sw	a5,-24(s0)
  *R(VIRTIO_MMIO_STATUS) = status;
    800079ce:	100017b7          	lui	a5,0x10001
    800079d2:	07078793          	addi	a5,a5,112 # 10001070 <_entry-0x6fffef90>
    800079d6:	fe842703          	lw	a4,-24(s0)
    800079da:	c398                	sw	a4,0(a5)

  // re-read status to ensure FEATURES_OK is set.
  status = *R(VIRTIO_MMIO_STATUS);
    800079dc:	100017b7          	lui	a5,0x10001
    800079e0:	07078793          	addi	a5,a5,112 # 10001070 <_entry-0x6fffef90>
    800079e4:	439c                	lw	a5,0(a5)
    800079e6:	fef42423          	sw	a5,-24(s0)
  if(!(status & VIRTIO_CONFIG_S_FEATURES_OK))
    800079ea:	fe842783          	lw	a5,-24(s0)
    800079ee:	8ba1                	andi	a5,a5,8
    800079f0:	2781                	sext.w	a5,a5
    800079f2:	eb89                	bnez	a5,80007a04 <virtio_disk_init+0x192>
    panic("virtio disk FEATURES_OK unset");
    800079f4:	00004517          	auipc	a0,0x4
    800079f8:	cf450513          	addi	a0,a0,-780 # 8000b6e8 <etext+0x6e8>
    800079fc:	00001097          	auipc	ra,0x1
    80007a00:	53a080e7          	jalr	1338(ra) # 80008f36 <panic>

  // initialize queue 0.
  *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    80007a04:	100017b7          	lui	a5,0x10001
    80007a08:	03078793          	addi	a5,a5,48 # 10001030 <_entry-0x6fffefd0>
    80007a0c:	0007a023          	sw	zero,0(a5)

  // ensure queue 0 is not in use.
  if(*R(VIRTIO_MMIO_QUEUE_READY))
    80007a10:	100017b7          	lui	a5,0x10001
    80007a14:	04478793          	addi	a5,a5,68 # 10001044 <_entry-0x6fffefbc>
    80007a18:	439c                	lw	a5,0(a5)
    80007a1a:	2781                	sext.w	a5,a5
    80007a1c:	cb89                	beqz	a5,80007a2e <virtio_disk_init+0x1bc>
    panic("virtio disk should not be ready");
    80007a1e:	00004517          	auipc	a0,0x4
    80007a22:	cea50513          	addi	a0,a0,-790 # 8000b708 <etext+0x708>
    80007a26:	00001097          	auipc	ra,0x1
    80007a2a:	510080e7          	jalr	1296(ra) # 80008f36 <panic>

  // check maximum queue size.
  uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    80007a2e:	100017b7          	lui	a5,0x10001
    80007a32:	03478793          	addi	a5,a5,52 # 10001034 <_entry-0x6fffefcc>
    80007a36:	439c                	lw	a5,0(a5)
    80007a38:	fcf42e23          	sw	a5,-36(s0)
  if(max == 0)
    80007a3c:	fdc42783          	lw	a5,-36(s0)
    80007a40:	2781                	sext.w	a5,a5
    80007a42:	eb89                	bnez	a5,80007a54 <virtio_disk_init+0x1e2>
    panic("virtio disk has no queue 0");
    80007a44:	00004517          	auipc	a0,0x4
    80007a48:	ce450513          	addi	a0,a0,-796 # 8000b728 <etext+0x728>
    80007a4c:	00001097          	auipc	ra,0x1
    80007a50:	4ea080e7          	jalr	1258(ra) # 80008f36 <panic>
  if(max < NUM)
    80007a54:	fdc42783          	lw	a5,-36(s0)
    80007a58:	0007871b          	sext.w	a4,a5
    80007a5c:	479d                	li	a5,7
    80007a5e:	00e7ea63          	bltu	a5,a4,80007a72 <virtio_disk_init+0x200>
    panic("virtio disk max queue too short");
    80007a62:	00004517          	auipc	a0,0x4
    80007a66:	ce650513          	addi	a0,a0,-794 # 8000b748 <etext+0x748>
    80007a6a:	00001097          	auipc	ra,0x1
    80007a6e:	4cc080e7          	jalr	1228(ra) # 80008f36 <panic>

  // allocate and zero queue memory.
  disk.desc = kalloc();
    80007a72:	ffff8097          	auipc	ra,0xffff8
    80007a76:	6e6080e7          	jalr	1766(ra) # 80000158 <kalloc>
    80007a7a:	872a                	mv	a4,a0
    80007a7c:	00015797          	auipc	a5,0x15
    80007a80:	2ec78793          	addi	a5,a5,748 # 8001cd68 <disk>
    80007a84:	e398                	sd	a4,0(a5)
  disk.avail = kalloc();
    80007a86:	ffff8097          	auipc	ra,0xffff8
    80007a8a:	6d2080e7          	jalr	1746(ra) # 80000158 <kalloc>
    80007a8e:	872a                	mv	a4,a0
    80007a90:	00015797          	auipc	a5,0x15
    80007a94:	2d878793          	addi	a5,a5,728 # 8001cd68 <disk>
    80007a98:	e798                	sd	a4,8(a5)
  disk.used = kalloc();
    80007a9a:	ffff8097          	auipc	ra,0xffff8
    80007a9e:	6be080e7          	jalr	1726(ra) # 80000158 <kalloc>
    80007aa2:	872a                	mv	a4,a0
    80007aa4:	00015797          	auipc	a5,0x15
    80007aa8:	2c478793          	addi	a5,a5,708 # 8001cd68 <disk>
    80007aac:	eb98                	sd	a4,16(a5)
  if(!disk.desc || !disk.avail || !disk.used)
    80007aae:	00015797          	auipc	a5,0x15
    80007ab2:	2ba78793          	addi	a5,a5,698 # 8001cd68 <disk>
    80007ab6:	639c                	ld	a5,0(a5)
    80007ab8:	cf89                	beqz	a5,80007ad2 <virtio_disk_init+0x260>
    80007aba:	00015797          	auipc	a5,0x15
    80007abe:	2ae78793          	addi	a5,a5,686 # 8001cd68 <disk>
    80007ac2:	679c                	ld	a5,8(a5)
    80007ac4:	c799                	beqz	a5,80007ad2 <virtio_disk_init+0x260>
    80007ac6:	00015797          	auipc	a5,0x15
    80007aca:	2a278793          	addi	a5,a5,674 # 8001cd68 <disk>
    80007ace:	6b9c                	ld	a5,16(a5)
    80007ad0:	eb89                	bnez	a5,80007ae2 <virtio_disk_init+0x270>
    panic("virtio disk kalloc");
    80007ad2:	00004517          	auipc	a0,0x4
    80007ad6:	c9650513          	addi	a0,a0,-874 # 8000b768 <etext+0x768>
    80007ada:	00001097          	auipc	ra,0x1
    80007ade:	45c080e7          	jalr	1116(ra) # 80008f36 <panic>
  memset(disk.desc, 0, PGSIZE);
    80007ae2:	00015797          	auipc	a5,0x15
    80007ae6:	28678793          	addi	a5,a5,646 # 8001cd68 <disk>
    80007aea:	639c                	ld	a5,0(a5)
    80007aec:	6605                	lui	a2,0x1
    80007aee:	4581                	li	a1,0
    80007af0:	853e                	mv	a0,a5
    80007af2:	ffff8097          	auipc	ra,0xffff8
    80007af6:	71a080e7          	jalr	1818(ra) # 8000020c <memset>
  memset(disk.avail, 0, PGSIZE);
    80007afa:	00015797          	auipc	a5,0x15
    80007afe:	26e78793          	addi	a5,a5,622 # 8001cd68 <disk>
    80007b02:	679c                	ld	a5,8(a5)
    80007b04:	6605                	lui	a2,0x1
    80007b06:	4581                	li	a1,0
    80007b08:	853e                	mv	a0,a5
    80007b0a:	ffff8097          	auipc	ra,0xffff8
    80007b0e:	702080e7          	jalr	1794(ra) # 8000020c <memset>
  memset(disk.used, 0, PGSIZE);
    80007b12:	00015797          	auipc	a5,0x15
    80007b16:	25678793          	addi	a5,a5,598 # 8001cd68 <disk>
    80007b1a:	6b9c                	ld	a5,16(a5)
    80007b1c:	6605                	lui	a2,0x1
    80007b1e:	4581                	li	a1,0
    80007b20:	853e                	mv	a0,a5
    80007b22:	ffff8097          	auipc	ra,0xffff8
    80007b26:	6ea080e7          	jalr	1770(ra) # 8000020c <memset>

  // set queue size.
  *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    80007b2a:	100017b7          	lui	a5,0x10001
    80007b2e:	03878793          	addi	a5,a5,56 # 10001038 <_entry-0x6fffefc8>
    80007b32:	4721                	li	a4,8
    80007b34:	c398                	sw	a4,0(a5)

  // write physical addresses.
  *R(VIRTIO_MMIO_QUEUE_DESC_LOW) = (uint64)disk.desc;
    80007b36:	00015797          	auipc	a5,0x15
    80007b3a:	23278793          	addi	a5,a5,562 # 8001cd68 <disk>
    80007b3e:	639c                	ld	a5,0(a5)
    80007b40:	873e                	mv	a4,a5
    80007b42:	100017b7          	lui	a5,0x10001
    80007b46:	08078793          	addi	a5,a5,128 # 10001080 <_entry-0x6fffef80>
    80007b4a:	2701                	sext.w	a4,a4
    80007b4c:	c398                	sw	a4,0(a5)
  *R(VIRTIO_MMIO_QUEUE_DESC_HIGH) = (uint64)disk.desc >> 32;
    80007b4e:	00015797          	auipc	a5,0x15
    80007b52:	21a78793          	addi	a5,a5,538 # 8001cd68 <disk>
    80007b56:	639c                	ld	a5,0(a5)
    80007b58:	0207d713          	srli	a4,a5,0x20
    80007b5c:	100017b7          	lui	a5,0x10001
    80007b60:	08478793          	addi	a5,a5,132 # 10001084 <_entry-0x6fffef7c>
    80007b64:	2701                	sext.w	a4,a4
    80007b66:	c398                	sw	a4,0(a5)
  *R(VIRTIO_MMIO_DRIVER_DESC_LOW) = (uint64)disk.avail;
    80007b68:	00015797          	auipc	a5,0x15
    80007b6c:	20078793          	addi	a5,a5,512 # 8001cd68 <disk>
    80007b70:	679c                	ld	a5,8(a5)
    80007b72:	873e                	mv	a4,a5
    80007b74:	100017b7          	lui	a5,0x10001
    80007b78:	09078793          	addi	a5,a5,144 # 10001090 <_entry-0x6fffef70>
    80007b7c:	2701                	sext.w	a4,a4
    80007b7e:	c398                	sw	a4,0(a5)
  *R(VIRTIO_MMIO_DRIVER_DESC_HIGH) = (uint64)disk.avail >> 32;
    80007b80:	00015797          	auipc	a5,0x15
    80007b84:	1e878793          	addi	a5,a5,488 # 8001cd68 <disk>
    80007b88:	679c                	ld	a5,8(a5)
    80007b8a:	0207d713          	srli	a4,a5,0x20
    80007b8e:	100017b7          	lui	a5,0x10001
    80007b92:	09478793          	addi	a5,a5,148 # 10001094 <_entry-0x6fffef6c>
    80007b96:	2701                	sext.w	a4,a4
    80007b98:	c398                	sw	a4,0(a5)
  *R(VIRTIO_MMIO_DEVICE_DESC_LOW) = (uint64)disk.used;
    80007b9a:	00015797          	auipc	a5,0x15
    80007b9e:	1ce78793          	addi	a5,a5,462 # 8001cd68 <disk>
    80007ba2:	6b9c                	ld	a5,16(a5)
    80007ba4:	873e                	mv	a4,a5
    80007ba6:	100017b7          	lui	a5,0x10001
    80007baa:	0a078793          	addi	a5,a5,160 # 100010a0 <_entry-0x6fffef60>
    80007bae:	2701                	sext.w	a4,a4
    80007bb0:	c398                	sw	a4,0(a5)
  *R(VIRTIO_MMIO_DEVICE_DESC_HIGH) = (uint64)disk.used >> 32;
    80007bb2:	00015797          	auipc	a5,0x15
    80007bb6:	1b678793          	addi	a5,a5,438 # 8001cd68 <disk>
    80007bba:	6b9c                	ld	a5,16(a5)
    80007bbc:	0207d713          	srli	a4,a5,0x20
    80007bc0:	100017b7          	lui	a5,0x10001
    80007bc4:	0a478793          	addi	a5,a5,164 # 100010a4 <_entry-0x6fffef5c>
    80007bc8:	2701                	sext.w	a4,a4
    80007bca:	c398                	sw	a4,0(a5)

  // queue is ready.
  *R(VIRTIO_MMIO_QUEUE_READY) = 0x1;
    80007bcc:	100017b7          	lui	a5,0x10001
    80007bd0:	04478793          	addi	a5,a5,68 # 10001044 <_entry-0x6fffefbc>
    80007bd4:	4705                	li	a4,1
    80007bd6:	c398                	sw	a4,0(a5)

  // all NUM descriptors start out unused.
  for(int i = 0; i < NUM; i++)
    80007bd8:	fe042623          	sw	zero,-20(s0)
    80007bdc:	a005                	j	80007bfc <virtio_disk_init+0x38a>
    disk.free[i] = 1;
    80007bde:	00015717          	auipc	a4,0x15
    80007be2:	18a70713          	addi	a4,a4,394 # 8001cd68 <disk>
    80007be6:	fec42783          	lw	a5,-20(s0)
    80007bea:	97ba                	add	a5,a5,a4
    80007bec:	4705                	li	a4,1
    80007bee:	00e78c23          	sb	a4,24(a5)
  for(int i = 0; i < NUM; i++)
    80007bf2:	fec42783          	lw	a5,-20(s0)
    80007bf6:	2785                	addiw	a5,a5,1
    80007bf8:	fef42623          	sw	a5,-20(s0)
    80007bfc:	fec42783          	lw	a5,-20(s0)
    80007c00:	0007871b          	sext.w	a4,a5
    80007c04:	479d                	li	a5,7
    80007c06:	fce7dce3          	bge	a5,a4,80007bde <virtio_disk_init+0x36c>

  // tell device we're completely ready.
  status |= VIRTIO_CONFIG_S_DRIVER_OK;
    80007c0a:	fe842783          	lw	a5,-24(s0)
    80007c0e:	0047e793          	ori	a5,a5,4
    80007c12:	fef42423          	sw	a5,-24(s0)
  *R(VIRTIO_MMIO_STATUS) = status;
    80007c16:	100017b7          	lui	a5,0x10001
    80007c1a:	07078793          	addi	a5,a5,112 # 10001070 <_entry-0x6fffef90>
    80007c1e:	fe842703          	lw	a4,-24(s0)
    80007c22:	c398                	sw	a4,0(a5)

  // plic.c and trap.c arrange for interrupts from VIRTIO0_IRQ.
}
    80007c24:	0001                	nop
    80007c26:	70a2                	ld	ra,40(sp)
    80007c28:	7402                	ld	s0,32(sp)
    80007c2a:	6145                	addi	sp,sp,48
    80007c2c:	8082                	ret

0000000080007c2e <alloc_desc>:

// find a free descriptor, mark it non-free, return its index.
static int
alloc_desc()
{
    80007c2e:	1101                	addi	sp,sp,-32
    80007c30:	ec22                	sd	s0,24(sp)
    80007c32:	1000                	addi	s0,sp,32
  for(int i = 0; i < NUM; i++){
    80007c34:	fe042623          	sw	zero,-20(s0)
    80007c38:	a825                	j	80007c70 <alloc_desc+0x42>
    if(disk.free[i]){
    80007c3a:	00015717          	auipc	a4,0x15
    80007c3e:	12e70713          	addi	a4,a4,302 # 8001cd68 <disk>
    80007c42:	fec42783          	lw	a5,-20(s0)
    80007c46:	97ba                	add	a5,a5,a4
    80007c48:	0187c783          	lbu	a5,24(a5)
    80007c4c:	cf89                	beqz	a5,80007c66 <alloc_desc+0x38>
      disk.free[i] = 0;
    80007c4e:	00015717          	auipc	a4,0x15
    80007c52:	11a70713          	addi	a4,a4,282 # 8001cd68 <disk>
    80007c56:	fec42783          	lw	a5,-20(s0)
    80007c5a:	97ba                	add	a5,a5,a4
    80007c5c:	00078c23          	sb	zero,24(a5)
      return i;
    80007c60:	fec42783          	lw	a5,-20(s0)
    80007c64:	a831                	j	80007c80 <alloc_desc+0x52>
  for(int i = 0; i < NUM; i++){
    80007c66:	fec42783          	lw	a5,-20(s0)
    80007c6a:	2785                	addiw	a5,a5,1
    80007c6c:	fef42623          	sw	a5,-20(s0)
    80007c70:	fec42783          	lw	a5,-20(s0)
    80007c74:	0007871b          	sext.w	a4,a5
    80007c78:	479d                	li	a5,7
    80007c7a:	fce7d0e3          	bge	a5,a4,80007c3a <alloc_desc+0xc>
    }
  }
  return -1;
    80007c7e:	57fd                	li	a5,-1
}
    80007c80:	853e                	mv	a0,a5
    80007c82:	6462                	ld	s0,24(sp)
    80007c84:	6105                	addi	sp,sp,32
    80007c86:	8082                	ret

0000000080007c88 <free_desc>:

// mark a descriptor as free.
static void
free_desc(int i)
{
    80007c88:	1101                	addi	sp,sp,-32
    80007c8a:	ec06                	sd	ra,24(sp)
    80007c8c:	e822                	sd	s0,16(sp)
    80007c8e:	1000                	addi	s0,sp,32
    80007c90:	87aa                	mv	a5,a0
    80007c92:	fef42623          	sw	a5,-20(s0)
  if(i >= NUM)
    80007c96:	fec42783          	lw	a5,-20(s0)
    80007c9a:	0007871b          	sext.w	a4,a5
    80007c9e:	479d                	li	a5,7
    80007ca0:	00e7da63          	bge	a5,a4,80007cb4 <free_desc+0x2c>
    panic("free_desc 1");
    80007ca4:	00004517          	auipc	a0,0x4
    80007ca8:	adc50513          	addi	a0,a0,-1316 # 8000b780 <etext+0x780>
    80007cac:	00001097          	auipc	ra,0x1
    80007cb0:	28a080e7          	jalr	650(ra) # 80008f36 <panic>
  if(disk.free[i])
    80007cb4:	00015717          	auipc	a4,0x15
    80007cb8:	0b470713          	addi	a4,a4,180 # 8001cd68 <disk>
    80007cbc:	fec42783          	lw	a5,-20(s0)
    80007cc0:	97ba                	add	a5,a5,a4
    80007cc2:	0187c783          	lbu	a5,24(a5)
    80007cc6:	cb89                	beqz	a5,80007cd8 <free_desc+0x50>
    panic("free_desc 2");
    80007cc8:	00004517          	auipc	a0,0x4
    80007ccc:	ac850513          	addi	a0,a0,-1336 # 8000b790 <etext+0x790>
    80007cd0:	00001097          	auipc	ra,0x1
    80007cd4:	266080e7          	jalr	614(ra) # 80008f36 <panic>
  disk.desc[i].addr = 0;
    80007cd8:	00015797          	auipc	a5,0x15
    80007cdc:	09078793          	addi	a5,a5,144 # 8001cd68 <disk>
    80007ce0:	6398                	ld	a4,0(a5)
    80007ce2:	fec42783          	lw	a5,-20(s0)
    80007ce6:	0792                	slli	a5,a5,0x4
    80007ce8:	97ba                	add	a5,a5,a4
    80007cea:	0007b023          	sd	zero,0(a5)
  disk.desc[i].len = 0;
    80007cee:	00015797          	auipc	a5,0x15
    80007cf2:	07a78793          	addi	a5,a5,122 # 8001cd68 <disk>
    80007cf6:	6398                	ld	a4,0(a5)
    80007cf8:	fec42783          	lw	a5,-20(s0)
    80007cfc:	0792                	slli	a5,a5,0x4
    80007cfe:	97ba                	add	a5,a5,a4
    80007d00:	0007a423          	sw	zero,8(a5)
  disk.desc[i].flags = 0;
    80007d04:	00015797          	auipc	a5,0x15
    80007d08:	06478793          	addi	a5,a5,100 # 8001cd68 <disk>
    80007d0c:	6398                	ld	a4,0(a5)
    80007d0e:	fec42783          	lw	a5,-20(s0)
    80007d12:	0792                	slli	a5,a5,0x4
    80007d14:	97ba                	add	a5,a5,a4
    80007d16:	00079623          	sh	zero,12(a5)
  disk.desc[i].next = 0;
    80007d1a:	00015797          	auipc	a5,0x15
    80007d1e:	04e78793          	addi	a5,a5,78 # 8001cd68 <disk>
    80007d22:	6398                	ld	a4,0(a5)
    80007d24:	fec42783          	lw	a5,-20(s0)
    80007d28:	0792                	slli	a5,a5,0x4
    80007d2a:	97ba                	add	a5,a5,a4
    80007d2c:	00079723          	sh	zero,14(a5)
  disk.free[i] = 1;
    80007d30:	00015717          	auipc	a4,0x15
    80007d34:	03870713          	addi	a4,a4,56 # 8001cd68 <disk>
    80007d38:	fec42783          	lw	a5,-20(s0)
    80007d3c:	97ba                	add	a5,a5,a4
    80007d3e:	4705                	li	a4,1
    80007d40:	00e78c23          	sb	a4,24(a5)
  wakeup(&disk.free[0]);
    80007d44:	00015517          	auipc	a0,0x15
    80007d48:	03c50513          	addi	a0,a0,60 # 8001cd80 <disk+0x18>
    80007d4c:	ffffa097          	auipc	ra,0xffffa
    80007d50:	50a080e7          	jalr	1290(ra) # 80002256 <wakeup>
}
    80007d54:	0001                	nop
    80007d56:	60e2                	ld	ra,24(sp)
    80007d58:	6442                	ld	s0,16(sp)
    80007d5a:	6105                	addi	sp,sp,32
    80007d5c:	8082                	ret

0000000080007d5e <free_chain>:

// free a chain of descriptors.
static void
free_chain(int i)
{
    80007d5e:	7179                	addi	sp,sp,-48
    80007d60:	f406                	sd	ra,40(sp)
    80007d62:	f022                	sd	s0,32(sp)
    80007d64:	1800                	addi	s0,sp,48
    80007d66:	87aa                	mv	a5,a0
    80007d68:	fcf42e23          	sw	a5,-36(s0)
  while(1){
    int flag = disk.desc[i].flags;
    80007d6c:	00015797          	auipc	a5,0x15
    80007d70:	ffc78793          	addi	a5,a5,-4 # 8001cd68 <disk>
    80007d74:	6398                	ld	a4,0(a5)
    80007d76:	fdc42783          	lw	a5,-36(s0)
    80007d7a:	0792                	slli	a5,a5,0x4
    80007d7c:	97ba                	add	a5,a5,a4
    80007d7e:	00c7d783          	lhu	a5,12(a5)
    80007d82:	fef42623          	sw	a5,-20(s0)
    int nxt = disk.desc[i].next;
    80007d86:	00015797          	auipc	a5,0x15
    80007d8a:	fe278793          	addi	a5,a5,-30 # 8001cd68 <disk>
    80007d8e:	6398                	ld	a4,0(a5)
    80007d90:	fdc42783          	lw	a5,-36(s0)
    80007d94:	0792                	slli	a5,a5,0x4
    80007d96:	97ba                	add	a5,a5,a4
    80007d98:	00e7d783          	lhu	a5,14(a5)
    80007d9c:	fef42423          	sw	a5,-24(s0)
    free_desc(i);
    80007da0:	fdc42783          	lw	a5,-36(s0)
    80007da4:	853e                	mv	a0,a5
    80007da6:	00000097          	auipc	ra,0x0
    80007daa:	ee2080e7          	jalr	-286(ra) # 80007c88 <free_desc>
    if(flag & VRING_DESC_F_NEXT)
    80007dae:	fec42783          	lw	a5,-20(s0)
    80007db2:	8b85                	andi	a5,a5,1
    80007db4:	2781                	sext.w	a5,a5
    80007db6:	c791                	beqz	a5,80007dc2 <free_chain+0x64>
      i = nxt;
    80007db8:	fe842783          	lw	a5,-24(s0)
    80007dbc:	fcf42e23          	sw	a5,-36(s0)
  while(1){
    80007dc0:	b775                	j	80007d6c <free_chain+0xe>
    else
      break;
    80007dc2:	0001                	nop
  }
}
    80007dc4:	0001                	nop
    80007dc6:	70a2                	ld	ra,40(sp)
    80007dc8:	7402                	ld	s0,32(sp)
    80007dca:	6145                	addi	sp,sp,48
    80007dcc:	8082                	ret

0000000080007dce <alloc3_desc>:

// allocate three descriptors (they need not be contiguous).
// disk transfers always use three descriptors.
static int
alloc3_desc(int *idx)
{
    80007dce:	7139                	addi	sp,sp,-64
    80007dd0:	fc06                	sd	ra,56(sp)
    80007dd2:	f822                	sd	s0,48(sp)
    80007dd4:	f426                	sd	s1,40(sp)
    80007dd6:	0080                	addi	s0,sp,64
    80007dd8:	fca43423          	sd	a0,-56(s0)
  for(int i = 0; i < 3; i++){
    80007ddc:	fc042e23          	sw	zero,-36(s0)
    80007de0:	a89d                	j	80007e56 <alloc3_desc+0x88>
    idx[i] = alloc_desc();
    80007de2:	fdc42783          	lw	a5,-36(s0)
    80007de6:	078a                	slli	a5,a5,0x2
    80007de8:	fc843703          	ld	a4,-56(s0)
    80007dec:	00f704b3          	add	s1,a4,a5
    80007df0:	00000097          	auipc	ra,0x0
    80007df4:	e3e080e7          	jalr	-450(ra) # 80007c2e <alloc_desc>
    80007df8:	87aa                	mv	a5,a0
    80007dfa:	c09c                	sw	a5,0(s1)
    if(idx[i] < 0){
    80007dfc:	fdc42783          	lw	a5,-36(s0)
    80007e00:	078a                	slli	a5,a5,0x2
    80007e02:	fc843703          	ld	a4,-56(s0)
    80007e06:	97ba                	add	a5,a5,a4
    80007e08:	439c                	lw	a5,0(a5)
    80007e0a:	0407d163          	bgez	a5,80007e4c <alloc3_desc+0x7e>
      for(int j = 0; j < i; j++)
    80007e0e:	fc042c23          	sw	zero,-40(s0)
    80007e12:	a015                	j	80007e36 <alloc3_desc+0x68>
        free_desc(idx[j]);
    80007e14:	fd842783          	lw	a5,-40(s0)
    80007e18:	078a                	slli	a5,a5,0x2
    80007e1a:	fc843703          	ld	a4,-56(s0)
    80007e1e:	97ba                	add	a5,a5,a4
    80007e20:	439c                	lw	a5,0(a5)
    80007e22:	853e                	mv	a0,a5
    80007e24:	00000097          	auipc	ra,0x0
    80007e28:	e64080e7          	jalr	-412(ra) # 80007c88 <free_desc>
      for(int j = 0; j < i; j++)
    80007e2c:	fd842783          	lw	a5,-40(s0)
    80007e30:	2785                	addiw	a5,a5,1
    80007e32:	fcf42c23          	sw	a5,-40(s0)
    80007e36:	fd842783          	lw	a5,-40(s0)
    80007e3a:	873e                	mv	a4,a5
    80007e3c:	fdc42783          	lw	a5,-36(s0)
    80007e40:	2701                	sext.w	a4,a4
    80007e42:	2781                	sext.w	a5,a5
    80007e44:	fcf748e3          	blt	a4,a5,80007e14 <alloc3_desc+0x46>
      return -1;
    80007e48:	57fd                	li	a5,-1
    80007e4a:	a831                	j	80007e66 <alloc3_desc+0x98>
  for(int i = 0; i < 3; i++){
    80007e4c:	fdc42783          	lw	a5,-36(s0)
    80007e50:	2785                	addiw	a5,a5,1
    80007e52:	fcf42e23          	sw	a5,-36(s0)
    80007e56:	fdc42783          	lw	a5,-36(s0)
    80007e5a:	0007871b          	sext.w	a4,a5
    80007e5e:	4789                	li	a5,2
    80007e60:	f8e7d1e3          	bge	a5,a4,80007de2 <alloc3_desc+0x14>
    }
  }
  return 0;
    80007e64:	4781                	li	a5,0
}
    80007e66:	853e                	mv	a0,a5
    80007e68:	70e2                	ld	ra,56(sp)
    80007e6a:	7442                	ld	s0,48(sp)
    80007e6c:	74a2                	ld	s1,40(sp)
    80007e6e:	6121                	addi	sp,sp,64
    80007e70:	8082                	ret

0000000080007e72 <virtio_disk_rw>:

void
virtio_disk_rw(struct buf *b, int write)
{
    80007e72:	7139                	addi	sp,sp,-64
    80007e74:	fc06                	sd	ra,56(sp)
    80007e76:	f822                	sd	s0,48(sp)
    80007e78:	0080                	addi	s0,sp,64
    80007e7a:	fca43423          	sd	a0,-56(s0)
    80007e7e:	87ae                	mv	a5,a1
    80007e80:	fcf42223          	sw	a5,-60(s0)
  uint64 sector = b->blockno * (BSIZE / 512);
    80007e84:	fc843783          	ld	a5,-56(s0)
    80007e88:	47dc                	lw	a5,12(a5)
    80007e8a:	0017979b          	slliw	a5,a5,0x1
    80007e8e:	2781                	sext.w	a5,a5
    80007e90:	1782                	slli	a5,a5,0x20
    80007e92:	9381                	srli	a5,a5,0x20
    80007e94:	fef43423          	sd	a5,-24(s0)

  acquire(&disk.vdisk_lock);
    80007e98:	00015517          	auipc	a0,0x15
    80007e9c:	ff850513          	addi	a0,a0,-8 # 8001ce90 <disk+0x128>
    80007ea0:	00001097          	auipc	ra,0x1
    80007ea4:	4de080e7          	jalr	1246(ra) # 8000937e <acquire>
  // data, one for a 1-byte status result.

  // allocate the three descriptors.
  int idx[3];
  while(1){
    if(alloc3_desc(idx) == 0) {
    80007ea8:	fd040793          	addi	a5,s0,-48
    80007eac:	853e                	mv	a0,a5
    80007eae:	00000097          	auipc	ra,0x0
    80007eb2:	f20080e7          	jalr	-224(ra) # 80007dce <alloc3_desc>
    80007eb6:	87aa                	mv	a5,a0
    80007eb8:	cf91                	beqz	a5,80007ed4 <virtio_disk_rw+0x62>
      break;
    }
    sleep(&disk.free[0], &disk.vdisk_lock);
    80007eba:	00015597          	auipc	a1,0x15
    80007ebe:	fd658593          	addi	a1,a1,-42 # 8001ce90 <disk+0x128>
    80007ec2:	00015517          	auipc	a0,0x15
    80007ec6:	ebe50513          	addi	a0,a0,-322 # 8001cd80 <disk+0x18>
    80007eca:	ffffa097          	auipc	ra,0xffffa
    80007ece:	310080e7          	jalr	784(ra) # 800021da <sleep>
    if(alloc3_desc(idx) == 0) {
    80007ed2:	bfd9                	j	80007ea8 <virtio_disk_rw+0x36>
      break;
    80007ed4:	0001                	nop
  }

  // format the three descriptors.
  // qemu's virtio-blk.c reads them.

  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    80007ed6:	fd042783          	lw	a5,-48(s0)
    80007eda:	07a9                	addi	a5,a5,10
    80007edc:	00479713          	slli	a4,a5,0x4
    80007ee0:	00015797          	auipc	a5,0x15
    80007ee4:	e8878793          	addi	a5,a5,-376 # 8001cd68 <disk>
    80007ee8:	97ba                	add	a5,a5,a4
    80007eea:	07a1                	addi	a5,a5,8
    80007eec:	fef43023          	sd	a5,-32(s0)

  if(write)
    80007ef0:	fc442783          	lw	a5,-60(s0)
    80007ef4:	2781                	sext.w	a5,a5
    80007ef6:	c791                	beqz	a5,80007f02 <virtio_disk_rw+0x90>
    buf0->type = VIRTIO_BLK_T_OUT; // write the disk
    80007ef8:	fe043783          	ld	a5,-32(s0)
    80007efc:	4705                	li	a4,1
    80007efe:	c398                	sw	a4,0(a5)
    80007f00:	a029                	j	80007f0a <virtio_disk_rw+0x98>
  else
    buf0->type = VIRTIO_BLK_T_IN; // read the disk
    80007f02:	fe043783          	ld	a5,-32(s0)
    80007f06:	0007a023          	sw	zero,0(a5)
  buf0->reserved = 0;
    80007f0a:	fe043783          	ld	a5,-32(s0)
    80007f0e:	0007a223          	sw	zero,4(a5)
  buf0->sector = sector;
    80007f12:	fe043783          	ld	a5,-32(s0)
    80007f16:	fe843703          	ld	a4,-24(s0)
    80007f1a:	e798                	sd	a4,8(a5)

  disk.desc[idx[0]].addr = (uint64) buf0;
    80007f1c:	00015797          	auipc	a5,0x15
    80007f20:	e4c78793          	addi	a5,a5,-436 # 8001cd68 <disk>
    80007f24:	6398                	ld	a4,0(a5)
    80007f26:	fd042783          	lw	a5,-48(s0)
    80007f2a:	0792                	slli	a5,a5,0x4
    80007f2c:	97ba                	add	a5,a5,a4
    80007f2e:	fe043703          	ld	a4,-32(s0)
    80007f32:	e398                	sd	a4,0(a5)
  disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    80007f34:	00015797          	auipc	a5,0x15
    80007f38:	e3478793          	addi	a5,a5,-460 # 8001cd68 <disk>
    80007f3c:	6398                	ld	a4,0(a5)
    80007f3e:	fd042783          	lw	a5,-48(s0)
    80007f42:	0792                	slli	a5,a5,0x4
    80007f44:	97ba                	add	a5,a5,a4
    80007f46:	4741                	li	a4,16
    80007f48:	c798                	sw	a4,8(a5)
  disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    80007f4a:	00015797          	auipc	a5,0x15
    80007f4e:	e1e78793          	addi	a5,a5,-482 # 8001cd68 <disk>
    80007f52:	6398                	ld	a4,0(a5)
    80007f54:	fd042783          	lw	a5,-48(s0)
    80007f58:	0792                	slli	a5,a5,0x4
    80007f5a:	97ba                	add	a5,a5,a4
    80007f5c:	4705                	li	a4,1
    80007f5e:	00e79623          	sh	a4,12(a5)
  disk.desc[idx[0]].next = idx[1];
    80007f62:	fd442683          	lw	a3,-44(s0)
    80007f66:	00015797          	auipc	a5,0x15
    80007f6a:	e0278793          	addi	a5,a5,-510 # 8001cd68 <disk>
    80007f6e:	6398                	ld	a4,0(a5)
    80007f70:	fd042783          	lw	a5,-48(s0)
    80007f74:	0792                	slli	a5,a5,0x4
    80007f76:	97ba                	add	a5,a5,a4
    80007f78:	03069713          	slli	a4,a3,0x30
    80007f7c:	9341                	srli	a4,a4,0x30
    80007f7e:	00e79723          	sh	a4,14(a5)

  disk.desc[idx[1]].addr = (uint64) b->data;
    80007f82:	fc843783          	ld	a5,-56(s0)
    80007f86:	05878693          	addi	a3,a5,88
    80007f8a:	00015797          	auipc	a5,0x15
    80007f8e:	dde78793          	addi	a5,a5,-546 # 8001cd68 <disk>
    80007f92:	6398                	ld	a4,0(a5)
    80007f94:	fd442783          	lw	a5,-44(s0)
    80007f98:	0792                	slli	a5,a5,0x4
    80007f9a:	97ba                	add	a5,a5,a4
    80007f9c:	8736                	mv	a4,a3
    80007f9e:	e398                	sd	a4,0(a5)
  disk.desc[idx[1]].len = BSIZE;
    80007fa0:	00015797          	auipc	a5,0x15
    80007fa4:	dc878793          	addi	a5,a5,-568 # 8001cd68 <disk>
    80007fa8:	6398                	ld	a4,0(a5)
    80007faa:	fd442783          	lw	a5,-44(s0)
    80007fae:	0792                	slli	a5,a5,0x4
    80007fb0:	97ba                	add	a5,a5,a4
    80007fb2:	40000713          	li	a4,1024
    80007fb6:	c798                	sw	a4,8(a5)
  if(write)
    80007fb8:	fc442783          	lw	a5,-60(s0)
    80007fbc:	2781                	sext.w	a5,a5
    80007fbe:	cf89                	beqz	a5,80007fd8 <virtio_disk_rw+0x166>
    disk.desc[idx[1]].flags = 0; // device reads b->data
    80007fc0:	00015797          	auipc	a5,0x15
    80007fc4:	da878793          	addi	a5,a5,-600 # 8001cd68 <disk>
    80007fc8:	6398                	ld	a4,0(a5)
    80007fca:	fd442783          	lw	a5,-44(s0)
    80007fce:	0792                	slli	a5,a5,0x4
    80007fd0:	97ba                	add	a5,a5,a4
    80007fd2:	00079623          	sh	zero,12(a5)
    80007fd6:	a829                	j	80007ff0 <virtio_disk_rw+0x17e>
  else
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
    80007fd8:	00015797          	auipc	a5,0x15
    80007fdc:	d9078793          	addi	a5,a5,-624 # 8001cd68 <disk>
    80007fe0:	6398                	ld	a4,0(a5)
    80007fe2:	fd442783          	lw	a5,-44(s0)
    80007fe6:	0792                	slli	a5,a5,0x4
    80007fe8:	97ba                	add	a5,a5,a4
    80007fea:	4709                	li	a4,2
    80007fec:	00e79623          	sh	a4,12(a5)
  disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    80007ff0:	00015797          	auipc	a5,0x15
    80007ff4:	d7878793          	addi	a5,a5,-648 # 8001cd68 <disk>
    80007ff8:	6398                	ld	a4,0(a5)
    80007ffa:	fd442783          	lw	a5,-44(s0)
    80007ffe:	0792                	slli	a5,a5,0x4
    80008000:	97ba                	add	a5,a5,a4
    80008002:	00c7d703          	lhu	a4,12(a5)
    80008006:	00015797          	auipc	a5,0x15
    8000800a:	d6278793          	addi	a5,a5,-670 # 8001cd68 <disk>
    8000800e:	6394                	ld	a3,0(a5)
    80008010:	fd442783          	lw	a5,-44(s0)
    80008014:	0792                	slli	a5,a5,0x4
    80008016:	97b6                	add	a5,a5,a3
    80008018:	00176713          	ori	a4,a4,1
    8000801c:	1742                	slli	a4,a4,0x30
    8000801e:	9341                	srli	a4,a4,0x30
    80008020:	00e79623          	sh	a4,12(a5)
  disk.desc[idx[1]].next = idx[2];
    80008024:	fd842683          	lw	a3,-40(s0)
    80008028:	00015797          	auipc	a5,0x15
    8000802c:	d4078793          	addi	a5,a5,-704 # 8001cd68 <disk>
    80008030:	6398                	ld	a4,0(a5)
    80008032:	fd442783          	lw	a5,-44(s0)
    80008036:	0792                	slli	a5,a5,0x4
    80008038:	97ba                	add	a5,a5,a4
    8000803a:	03069713          	slli	a4,a3,0x30
    8000803e:	9341                	srli	a4,a4,0x30
    80008040:	00e79723          	sh	a4,14(a5)

  disk.info[idx[0]].status = 0xff; // device writes 0 on success
    80008044:	fd042783          	lw	a5,-48(s0)
    80008048:	00015717          	auipc	a4,0x15
    8000804c:	d2070713          	addi	a4,a4,-736 # 8001cd68 <disk>
    80008050:	0789                	addi	a5,a5,2
    80008052:	0792                	slli	a5,a5,0x4
    80008054:	97ba                	add	a5,a5,a4
    80008056:	577d                	li	a4,-1
    80008058:	00e78823          	sb	a4,16(a5)
  disk.desc[idx[2]].addr = (uint64) &disk.info[idx[0]].status;
    8000805c:	fd042783          	lw	a5,-48(s0)
    80008060:	0789                	addi	a5,a5,2
    80008062:	00479713          	slli	a4,a5,0x4
    80008066:	00015797          	auipc	a5,0x15
    8000806a:	d0278793          	addi	a5,a5,-766 # 8001cd68 <disk>
    8000806e:	97ba                	add	a5,a5,a4
    80008070:	01078693          	addi	a3,a5,16
    80008074:	00015797          	auipc	a5,0x15
    80008078:	cf478793          	addi	a5,a5,-780 # 8001cd68 <disk>
    8000807c:	6398                	ld	a4,0(a5)
    8000807e:	fd842783          	lw	a5,-40(s0)
    80008082:	0792                	slli	a5,a5,0x4
    80008084:	97ba                	add	a5,a5,a4
    80008086:	8736                	mv	a4,a3
    80008088:	e398                	sd	a4,0(a5)
  disk.desc[idx[2]].len = 1;
    8000808a:	00015797          	auipc	a5,0x15
    8000808e:	cde78793          	addi	a5,a5,-802 # 8001cd68 <disk>
    80008092:	6398                	ld	a4,0(a5)
    80008094:	fd842783          	lw	a5,-40(s0)
    80008098:	0792                	slli	a5,a5,0x4
    8000809a:	97ba                	add	a5,a5,a4
    8000809c:	4705                	li	a4,1
    8000809e:	c798                	sw	a4,8(a5)
  disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    800080a0:	00015797          	auipc	a5,0x15
    800080a4:	cc878793          	addi	a5,a5,-824 # 8001cd68 <disk>
    800080a8:	6398                	ld	a4,0(a5)
    800080aa:	fd842783          	lw	a5,-40(s0)
    800080ae:	0792                	slli	a5,a5,0x4
    800080b0:	97ba                	add	a5,a5,a4
    800080b2:	4709                	li	a4,2
    800080b4:	00e79623          	sh	a4,12(a5)
  disk.desc[idx[2]].next = 0;
    800080b8:	00015797          	auipc	a5,0x15
    800080bc:	cb078793          	addi	a5,a5,-848 # 8001cd68 <disk>
    800080c0:	6398                	ld	a4,0(a5)
    800080c2:	fd842783          	lw	a5,-40(s0)
    800080c6:	0792                	slli	a5,a5,0x4
    800080c8:	97ba                	add	a5,a5,a4
    800080ca:	00079723          	sh	zero,14(a5)

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    800080ce:	fc843783          	ld	a5,-56(s0)
    800080d2:	4705                	li	a4,1
    800080d4:	c3d8                	sw	a4,4(a5)
  disk.info[idx[0]].b = b;
    800080d6:	fd042783          	lw	a5,-48(s0)
    800080da:	00015717          	auipc	a4,0x15
    800080de:	c8e70713          	addi	a4,a4,-882 # 8001cd68 <disk>
    800080e2:	0789                	addi	a5,a5,2
    800080e4:	0792                	slli	a5,a5,0x4
    800080e6:	97ba                	add	a5,a5,a4
    800080e8:	fc843703          	ld	a4,-56(s0)
    800080ec:	e798                	sd	a4,8(a5)

  // tell the device the first index in our chain of descriptors.
  disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    800080ee:	fd042703          	lw	a4,-48(s0)
    800080f2:	00015797          	auipc	a5,0x15
    800080f6:	c7678793          	addi	a5,a5,-906 # 8001cd68 <disk>
    800080fa:	6794                	ld	a3,8(a5)
    800080fc:	00015797          	auipc	a5,0x15
    80008100:	c6c78793          	addi	a5,a5,-916 # 8001cd68 <disk>
    80008104:	679c                	ld	a5,8(a5)
    80008106:	0027d783          	lhu	a5,2(a5)
    8000810a:	2781                	sext.w	a5,a5
    8000810c:	8b9d                	andi	a5,a5,7
    8000810e:	2781                	sext.w	a5,a5
    80008110:	1742                	slli	a4,a4,0x30
    80008112:	9341                	srli	a4,a4,0x30
    80008114:	0786                	slli	a5,a5,0x1
    80008116:	97b6                	add	a5,a5,a3
    80008118:	00e79223          	sh	a4,4(a5)

  __sync_synchronize();
    8000811c:	0ff0000f          	fence

  // tell the device another avail ring entry is available.
  disk.avail->idx += 1; // not % NUM ...
    80008120:	00015797          	auipc	a5,0x15
    80008124:	c4878793          	addi	a5,a5,-952 # 8001cd68 <disk>
    80008128:	679c                	ld	a5,8(a5)
    8000812a:	0027d703          	lhu	a4,2(a5)
    8000812e:	00015797          	auipc	a5,0x15
    80008132:	c3a78793          	addi	a5,a5,-966 # 8001cd68 <disk>
    80008136:	679c                	ld	a5,8(a5)
    80008138:	2705                	addiw	a4,a4,1
    8000813a:	1742                	slli	a4,a4,0x30
    8000813c:	9341                	srli	a4,a4,0x30
    8000813e:	00e79123          	sh	a4,2(a5)

  __sync_synchronize();
    80008142:	0ff0000f          	fence

  *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    80008146:	100017b7          	lui	a5,0x10001
    8000814a:	05078793          	addi	a5,a5,80 # 10001050 <_entry-0x6fffefb0>
    8000814e:	0007a023          	sw	zero,0(a5)

  // Wait for virtio_disk_intr() to say request has finished.
  while(b->disk == 1) {
    80008152:	a819                	j	80008168 <virtio_disk_rw+0x2f6>
    sleep(b, &disk.vdisk_lock);
    80008154:	00015597          	auipc	a1,0x15
    80008158:	d3c58593          	addi	a1,a1,-708 # 8001ce90 <disk+0x128>
    8000815c:	fc843503          	ld	a0,-56(s0)
    80008160:	ffffa097          	auipc	ra,0xffffa
    80008164:	07a080e7          	jalr	122(ra) # 800021da <sleep>
  while(b->disk == 1) {
    80008168:	fc843783          	ld	a5,-56(s0)
    8000816c:	43dc                	lw	a5,4(a5)
    8000816e:	873e                	mv	a4,a5
    80008170:	4785                	li	a5,1
    80008172:	fef701e3          	beq	a4,a5,80008154 <virtio_disk_rw+0x2e2>
  }

  disk.info[idx[0]].b = 0;
    80008176:	fd042783          	lw	a5,-48(s0)
    8000817a:	00015717          	auipc	a4,0x15
    8000817e:	bee70713          	addi	a4,a4,-1042 # 8001cd68 <disk>
    80008182:	0789                	addi	a5,a5,2
    80008184:	0792                	slli	a5,a5,0x4
    80008186:	97ba                	add	a5,a5,a4
    80008188:	0007b423          	sd	zero,8(a5)
  free_chain(idx[0]);
    8000818c:	fd042783          	lw	a5,-48(s0)
    80008190:	853e                	mv	a0,a5
    80008192:	00000097          	auipc	ra,0x0
    80008196:	bcc080e7          	jalr	-1076(ra) # 80007d5e <free_chain>

  release(&disk.vdisk_lock);
    8000819a:	00015517          	auipc	a0,0x15
    8000819e:	cf650513          	addi	a0,a0,-778 # 8001ce90 <disk+0x128>
    800081a2:	00001097          	auipc	ra,0x1
    800081a6:	240080e7          	jalr	576(ra) # 800093e2 <release>
}
    800081aa:	0001                	nop
    800081ac:	70e2                	ld	ra,56(sp)
    800081ae:	7442                	ld	s0,48(sp)
    800081b0:	6121                	addi	sp,sp,64
    800081b2:	8082                	ret

00000000800081b4 <virtio_disk_intr>:

void
virtio_disk_intr()
{
    800081b4:	1101                	addi	sp,sp,-32
    800081b6:	ec06                	sd	ra,24(sp)
    800081b8:	e822                	sd	s0,16(sp)
    800081ba:	1000                	addi	s0,sp,32
  acquire(&disk.vdisk_lock);
    800081bc:	00015517          	auipc	a0,0x15
    800081c0:	cd450513          	addi	a0,a0,-812 # 8001ce90 <disk+0x128>
    800081c4:	00001097          	auipc	ra,0x1
    800081c8:	1ba080e7          	jalr	442(ra) # 8000937e <acquire>
  // we've seen this interrupt, which the following line does.
  // this may race with the device writing new entries to
  // the "used" ring, in which case we may process the new
  // completion entries in this interrupt, and have nothing to do
  // in the next interrupt, which is harmless.
  *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    800081cc:	100017b7          	lui	a5,0x10001
    800081d0:	06078793          	addi	a5,a5,96 # 10001060 <_entry-0x6fffefa0>
    800081d4:	439c                	lw	a5,0(a5)
    800081d6:	0007871b          	sext.w	a4,a5
    800081da:	100017b7          	lui	a5,0x10001
    800081de:	06478793          	addi	a5,a5,100 # 10001064 <_entry-0x6fffef9c>
    800081e2:	8b0d                	andi	a4,a4,3
    800081e4:	2701                	sext.w	a4,a4
    800081e6:	c398                	sw	a4,0(a5)

  __sync_synchronize();
    800081e8:	0ff0000f          	fence

  // the device increments disk.used->idx when it
  // adds an entry to the used ring.

  while(disk.used_idx != disk.used->idx){
    800081ec:	a045                	j	8000828c <virtio_disk_intr+0xd8>
    __sync_synchronize();
    800081ee:	0ff0000f          	fence
    int id = disk.used->ring[disk.used_idx % NUM].id;
    800081f2:	00015797          	auipc	a5,0x15
    800081f6:	b7678793          	addi	a5,a5,-1162 # 8001cd68 <disk>
    800081fa:	6b98                	ld	a4,16(a5)
    800081fc:	00015797          	auipc	a5,0x15
    80008200:	b6c78793          	addi	a5,a5,-1172 # 8001cd68 <disk>
    80008204:	0207d783          	lhu	a5,32(a5)
    80008208:	2781                	sext.w	a5,a5
    8000820a:	8b9d                	andi	a5,a5,7
    8000820c:	2781                	sext.w	a5,a5
    8000820e:	078e                	slli	a5,a5,0x3
    80008210:	97ba                	add	a5,a5,a4
    80008212:	43dc                	lw	a5,4(a5)
    80008214:	fef42623          	sw	a5,-20(s0)

    if(disk.info[id].status != 0)
    80008218:	00015717          	auipc	a4,0x15
    8000821c:	b5070713          	addi	a4,a4,-1200 # 8001cd68 <disk>
    80008220:	fec42783          	lw	a5,-20(s0)
    80008224:	0789                	addi	a5,a5,2
    80008226:	0792                	slli	a5,a5,0x4
    80008228:	97ba                	add	a5,a5,a4
    8000822a:	0107c783          	lbu	a5,16(a5)
    8000822e:	cb89                	beqz	a5,80008240 <virtio_disk_intr+0x8c>
      panic("virtio_disk_intr status");
    80008230:	00003517          	auipc	a0,0x3
    80008234:	57050513          	addi	a0,a0,1392 # 8000b7a0 <etext+0x7a0>
    80008238:	00001097          	auipc	ra,0x1
    8000823c:	cfe080e7          	jalr	-770(ra) # 80008f36 <panic>

    struct buf *b = disk.info[id].b;
    80008240:	00015717          	auipc	a4,0x15
    80008244:	b2870713          	addi	a4,a4,-1240 # 8001cd68 <disk>
    80008248:	fec42783          	lw	a5,-20(s0)
    8000824c:	0789                	addi	a5,a5,2
    8000824e:	0792                	slli	a5,a5,0x4
    80008250:	97ba                	add	a5,a5,a4
    80008252:	679c                	ld	a5,8(a5)
    80008254:	fef43023          	sd	a5,-32(s0)
    b->disk = 0;   // disk is done with buf
    80008258:	fe043783          	ld	a5,-32(s0)
    8000825c:	0007a223          	sw	zero,4(a5)
    wakeup(b);
    80008260:	fe043503          	ld	a0,-32(s0)
    80008264:	ffffa097          	auipc	ra,0xffffa
    80008268:	ff2080e7          	jalr	-14(ra) # 80002256 <wakeup>

    disk.used_idx += 1;
    8000826c:	00015797          	auipc	a5,0x15
    80008270:	afc78793          	addi	a5,a5,-1284 # 8001cd68 <disk>
    80008274:	0207d783          	lhu	a5,32(a5)
    80008278:	2785                	addiw	a5,a5,1
    8000827a:	03079713          	slli	a4,a5,0x30
    8000827e:	9341                	srli	a4,a4,0x30
    80008280:	00015797          	auipc	a5,0x15
    80008284:	ae878793          	addi	a5,a5,-1304 # 8001cd68 <disk>
    80008288:	02e79023          	sh	a4,32(a5)
  while(disk.used_idx != disk.used->idx){
    8000828c:	00015797          	auipc	a5,0x15
    80008290:	adc78793          	addi	a5,a5,-1316 # 8001cd68 <disk>
    80008294:	0207d703          	lhu	a4,32(a5)
    80008298:	00015797          	auipc	a5,0x15
    8000829c:	ad078793          	addi	a5,a5,-1328 # 8001cd68 <disk>
    800082a0:	6b9c                	ld	a5,16(a5)
    800082a2:	0027d783          	lhu	a5,2(a5)
    800082a6:	2701                	sext.w	a4,a4
    800082a8:	2781                	sext.w	a5,a5
    800082aa:	f4f712e3          	bne	a4,a5,800081ee <virtio_disk_intr+0x3a>
  }

  release(&disk.vdisk_lock);
    800082ae:	00015517          	auipc	a0,0x15
    800082b2:	be250513          	addi	a0,a0,-1054 # 8001ce90 <disk+0x128>
    800082b6:	00001097          	auipc	ra,0x1
    800082ba:	12c080e7          	jalr	300(ra) # 800093e2 <release>
}
    800082be:	0001                	nop
    800082c0:	60e2                	ld	ra,24(sp)
    800082c2:	6442                	ld	s0,16(sp)
    800082c4:	6105                	addi	sp,sp,32
    800082c6:	8082                	ret

00000000800082c8 <r_mhartid>:
{
    800082c8:	1101                	addi	sp,sp,-32
    800082ca:	ec22                	sd	s0,24(sp)
    800082cc:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    800082ce:	f14027f3          	csrr	a5,mhartid
    800082d2:	fef43423          	sd	a5,-24(s0)
  return x;
    800082d6:	fe843783          	ld	a5,-24(s0)
}
    800082da:	853e                	mv	a0,a5
    800082dc:	6462                	ld	s0,24(sp)
    800082de:	6105                	addi	sp,sp,32
    800082e0:	8082                	ret

00000000800082e2 <r_mstatus>:
{
    800082e2:	1101                	addi	sp,sp,-32
    800082e4:	ec22                	sd	s0,24(sp)
    800082e6:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    800082e8:	300027f3          	csrr	a5,mstatus
    800082ec:	fef43423          	sd	a5,-24(s0)
  return x;
    800082f0:	fe843783          	ld	a5,-24(s0)
}
    800082f4:	853e                	mv	a0,a5
    800082f6:	6462                	ld	s0,24(sp)
    800082f8:	6105                	addi	sp,sp,32
    800082fa:	8082                	ret

00000000800082fc <w_mstatus>:
{
    800082fc:	1101                	addi	sp,sp,-32
    800082fe:	ec22                	sd	s0,24(sp)
    80008300:	1000                	addi	s0,sp,32
    80008302:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw mstatus, %0" : : "r" (x));
    80008306:	fe843783          	ld	a5,-24(s0)
    8000830a:	30079073          	csrw	mstatus,a5
}
    8000830e:	0001                	nop
    80008310:	6462                	ld	s0,24(sp)
    80008312:	6105                	addi	sp,sp,32
    80008314:	8082                	ret

0000000080008316 <w_mepc>:
{
    80008316:	1101                	addi	sp,sp,-32
    80008318:	ec22                	sd	s0,24(sp)
    8000831a:	1000                	addi	s0,sp,32
    8000831c:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw mepc, %0" : : "r" (x));
    80008320:	fe843783          	ld	a5,-24(s0)
    80008324:	34179073          	csrw	mepc,a5
}
    80008328:	0001                	nop
    8000832a:	6462                	ld	s0,24(sp)
    8000832c:	6105                	addi	sp,sp,32
    8000832e:	8082                	ret

0000000080008330 <r_sie>:
{
    80008330:	1101                	addi	sp,sp,-32
    80008332:	ec22                	sd	s0,24(sp)
    80008334:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sie" : "=r" (x) );
    80008336:	104027f3          	csrr	a5,sie
    8000833a:	fef43423          	sd	a5,-24(s0)
  return x;
    8000833e:	fe843783          	ld	a5,-24(s0)
}
    80008342:	853e                	mv	a0,a5
    80008344:	6462                	ld	s0,24(sp)
    80008346:	6105                	addi	sp,sp,32
    80008348:	8082                	ret

000000008000834a <w_sie>:
{
    8000834a:	1101                	addi	sp,sp,-32
    8000834c:	ec22                	sd	s0,24(sp)
    8000834e:	1000                	addi	s0,sp,32
    80008350:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw sie, %0" : : "r" (x));
    80008354:	fe843783          	ld	a5,-24(s0)
    80008358:	10479073          	csrw	sie,a5
}
    8000835c:	0001                	nop
    8000835e:	6462                	ld	s0,24(sp)
    80008360:	6105                	addi	sp,sp,32
    80008362:	8082                	ret

0000000080008364 <r_mie>:
{
    80008364:	1101                	addi	sp,sp,-32
    80008366:	ec22                	sd	s0,24(sp)
    80008368:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, mie" : "=r" (x) );
    8000836a:	304027f3          	csrr	a5,mie
    8000836e:	fef43423          	sd	a5,-24(s0)
  return x;
    80008372:	fe843783          	ld	a5,-24(s0)
}
    80008376:	853e                	mv	a0,a5
    80008378:	6462                	ld	s0,24(sp)
    8000837a:	6105                	addi	sp,sp,32
    8000837c:	8082                	ret

000000008000837e <w_mie>:
{
    8000837e:	1101                	addi	sp,sp,-32
    80008380:	ec22                	sd	s0,24(sp)
    80008382:	1000                	addi	s0,sp,32
    80008384:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw mie, %0" : : "r" (x));
    80008388:	fe843783          	ld	a5,-24(s0)
    8000838c:	30479073          	csrw	mie,a5
}
    80008390:	0001                	nop
    80008392:	6462                	ld	s0,24(sp)
    80008394:	6105                	addi	sp,sp,32
    80008396:	8082                	ret

0000000080008398 <w_medeleg>:
{
    80008398:	1101                	addi	sp,sp,-32
    8000839a:	ec22                	sd	s0,24(sp)
    8000839c:	1000                	addi	s0,sp,32
    8000839e:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw medeleg, %0" : : "r" (x));
    800083a2:	fe843783          	ld	a5,-24(s0)
    800083a6:	30279073          	csrw	medeleg,a5
}
    800083aa:	0001                	nop
    800083ac:	6462                	ld	s0,24(sp)
    800083ae:	6105                	addi	sp,sp,32
    800083b0:	8082                	ret

00000000800083b2 <w_mideleg>:
{
    800083b2:	1101                	addi	sp,sp,-32
    800083b4:	ec22                	sd	s0,24(sp)
    800083b6:	1000                	addi	s0,sp,32
    800083b8:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw mideleg, %0" : : "r" (x));
    800083bc:	fe843783          	ld	a5,-24(s0)
    800083c0:	30379073          	csrw	mideleg,a5
}
    800083c4:	0001                	nop
    800083c6:	6462                	ld	s0,24(sp)
    800083c8:	6105                	addi	sp,sp,32
    800083ca:	8082                	ret

00000000800083cc <w_mtvec>:
{
    800083cc:	1101                	addi	sp,sp,-32
    800083ce:	ec22                	sd	s0,24(sp)
    800083d0:	1000                	addi	s0,sp,32
    800083d2:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw mtvec, %0" : : "r" (x));
    800083d6:	fe843783          	ld	a5,-24(s0)
    800083da:	30579073          	csrw	mtvec,a5
}
    800083de:	0001                	nop
    800083e0:	6462                	ld	s0,24(sp)
    800083e2:	6105                	addi	sp,sp,32
    800083e4:	8082                	ret

00000000800083e6 <w_pmpcfg0>:
{
    800083e6:	1101                	addi	sp,sp,-32
    800083e8:	ec22                	sd	s0,24(sp)
    800083ea:	1000                	addi	s0,sp,32
    800083ec:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw pmpcfg0, %0" : : "r" (x));
    800083f0:	fe843783          	ld	a5,-24(s0)
    800083f4:	3a079073          	csrw	pmpcfg0,a5
}
    800083f8:	0001                	nop
    800083fa:	6462                	ld	s0,24(sp)
    800083fc:	6105                	addi	sp,sp,32
    800083fe:	8082                	ret

0000000080008400 <w_pmpaddr0>:
{
    80008400:	1101                	addi	sp,sp,-32
    80008402:	ec22                	sd	s0,24(sp)
    80008404:	1000                	addi	s0,sp,32
    80008406:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw pmpaddr0, %0" : : "r" (x));
    8000840a:	fe843783          	ld	a5,-24(s0)
    8000840e:	3b079073          	csrw	pmpaddr0,a5
}
    80008412:	0001                	nop
    80008414:	6462                	ld	s0,24(sp)
    80008416:	6105                	addi	sp,sp,32
    80008418:	8082                	ret

000000008000841a <w_satp>:
{
    8000841a:	1101                	addi	sp,sp,-32
    8000841c:	ec22                	sd	s0,24(sp)
    8000841e:	1000                	addi	s0,sp,32
    80008420:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw satp, %0" : : "r" (x));
    80008424:	fe843783          	ld	a5,-24(s0)
    80008428:	18079073          	csrw	satp,a5
}
    8000842c:	0001                	nop
    8000842e:	6462                	ld	s0,24(sp)
    80008430:	6105                	addi	sp,sp,32
    80008432:	8082                	ret

0000000080008434 <w_mscratch>:
{
    80008434:	1101                	addi	sp,sp,-32
    80008436:	ec22                	sd	s0,24(sp)
    80008438:	1000                	addi	s0,sp,32
    8000843a:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw mscratch, %0" : : "r" (x));
    8000843e:	fe843783          	ld	a5,-24(s0)
    80008442:	34079073          	csrw	mscratch,a5
}
    80008446:	0001                	nop
    80008448:	6462                	ld	s0,24(sp)
    8000844a:	6105                	addi	sp,sp,32
    8000844c:	8082                	ret

000000008000844e <w_tp>:
{
    8000844e:	1101                	addi	sp,sp,-32
    80008450:	ec22                	sd	s0,24(sp)
    80008452:	1000                	addi	s0,sp,32
    80008454:	fea43423          	sd	a0,-24(s0)
  asm volatile("mv tp, %0" : : "r" (x));
    80008458:	fe843783          	ld	a5,-24(s0)
    8000845c:	823e                	mv	tp,a5
}
    8000845e:	0001                	nop
    80008460:	6462                	ld	s0,24(sp)
    80008462:	6105                	addi	sp,sp,32
    80008464:	8082                	ret

0000000080008466 <start>:
extern void timervec();

// entry.S jumps here in machine mode on stack0.
void
start()
{
    80008466:	1101                	addi	sp,sp,-32
    80008468:	ec06                	sd	ra,24(sp)
    8000846a:	e822                	sd	s0,16(sp)
    8000846c:	1000                	addi	s0,sp,32
  // set M Previous Privilege mode to Supervisor, for mret.
  unsigned long x = r_mstatus();
    8000846e:	00000097          	auipc	ra,0x0
    80008472:	e74080e7          	jalr	-396(ra) # 800082e2 <r_mstatus>
    80008476:	fea43423          	sd	a0,-24(s0)
  x &= ~MSTATUS_MPP_MASK;
    8000847a:	fe843703          	ld	a4,-24(s0)
    8000847e:	77f9                	lui	a5,0xffffe
    80008480:	7ff78793          	addi	a5,a5,2047 # ffffffffffffe7ff <end+0xffffffff7ffd970f>
    80008484:	8ff9                	and	a5,a5,a4
    80008486:	fef43423          	sd	a5,-24(s0)
  x |= MSTATUS_MPP_S;
    8000848a:	fe843703          	ld	a4,-24(s0)
    8000848e:	6785                	lui	a5,0x1
    80008490:	80078793          	addi	a5,a5,-2048 # 800 <_entry-0x7ffff800>
    80008494:	8fd9                	or	a5,a5,a4
    80008496:	fef43423          	sd	a5,-24(s0)
  w_mstatus(x);
    8000849a:	fe843503          	ld	a0,-24(s0)
    8000849e:	00000097          	auipc	ra,0x0
    800084a2:	e5e080e7          	jalr	-418(ra) # 800082fc <w_mstatus>

  // set M Exception Program Counter to main, for mret.
  // requires gcc -mcmodel=medany
  w_mepc((uint64)main);
    800084a6:	ffff8797          	auipc	a5,0xffff8
    800084aa:	11c78793          	addi	a5,a5,284 # 800005c2 <main>
    800084ae:	853e                	mv	a0,a5
    800084b0:	00000097          	auipc	ra,0x0
    800084b4:	e66080e7          	jalr	-410(ra) # 80008316 <w_mepc>

  // disable paging for now.
  w_satp(0);
    800084b8:	4501                	li	a0,0
    800084ba:	00000097          	auipc	ra,0x0
    800084be:	f60080e7          	jalr	-160(ra) # 8000841a <w_satp>

  // delegate all interrupts and exceptions to supervisor mode.
  w_medeleg(0xffff);
    800084c2:	67c1                	lui	a5,0x10
    800084c4:	fff78513          	addi	a0,a5,-1 # ffff <_entry-0x7fff0001>
    800084c8:	00000097          	auipc	ra,0x0
    800084cc:	ed0080e7          	jalr	-304(ra) # 80008398 <w_medeleg>
  w_mideleg(0xffff);
    800084d0:	67c1                	lui	a5,0x10
    800084d2:	fff78513          	addi	a0,a5,-1 # ffff <_entry-0x7fff0001>
    800084d6:	00000097          	auipc	ra,0x0
    800084da:	edc080e7          	jalr	-292(ra) # 800083b2 <w_mideleg>
  w_sie(r_sie() | SIE_SEIE | SIE_STIE | SIE_SSIE);
    800084de:	00000097          	auipc	ra,0x0
    800084e2:	e52080e7          	jalr	-430(ra) # 80008330 <r_sie>
    800084e6:	87aa                	mv	a5,a0
    800084e8:	2227e793          	ori	a5,a5,546
    800084ec:	853e                	mv	a0,a5
    800084ee:	00000097          	auipc	ra,0x0
    800084f2:	e5c080e7          	jalr	-420(ra) # 8000834a <w_sie>

  // configure Physical Memory Protection to give supervisor mode
  // access to all of physical memory.
  w_pmpaddr0(0x3fffffffffffffull);
    800084f6:	57fd                	li	a5,-1
    800084f8:	00a7d513          	srli	a0,a5,0xa
    800084fc:	00000097          	auipc	ra,0x0
    80008500:	f04080e7          	jalr	-252(ra) # 80008400 <w_pmpaddr0>
  w_pmpcfg0(0xf);
    80008504:	453d                	li	a0,15
    80008506:	00000097          	auipc	ra,0x0
    8000850a:	ee0080e7          	jalr	-288(ra) # 800083e6 <w_pmpcfg0>

  // ask for clock interrupts.
  timerinit();
    8000850e:	00000097          	auipc	ra,0x0
    80008512:	032080e7          	jalr	50(ra) # 80008540 <timerinit>

  // keep each CPU's hartid in its tp register, for cpuid().
  int id = r_mhartid();
    80008516:	00000097          	auipc	ra,0x0
    8000851a:	db2080e7          	jalr	-590(ra) # 800082c8 <r_mhartid>
    8000851e:	87aa                	mv	a5,a0
    80008520:	fef42223          	sw	a5,-28(s0)
  w_tp(id);
    80008524:	fe442783          	lw	a5,-28(s0)
    80008528:	853e                	mv	a0,a5
    8000852a:	00000097          	auipc	ra,0x0
    8000852e:	f24080e7          	jalr	-220(ra) # 8000844e <w_tp>

  // switch to supervisor mode and jump to main().
  asm volatile("mret");
    80008532:	30200073          	mret
}
    80008536:	0001                	nop
    80008538:	60e2                	ld	ra,24(sp)
    8000853a:	6442                	ld	s0,16(sp)
    8000853c:	6105                	addi	sp,sp,32
    8000853e:	8082                	ret

0000000080008540 <timerinit>:
// at timervec in kernelvec.S,
// which turns them into software interrupts for
// devintr() in trap.c.
void
timerinit()
{
    80008540:	1101                	addi	sp,sp,-32
    80008542:	ec06                	sd	ra,24(sp)
    80008544:	e822                	sd	s0,16(sp)
    80008546:	1000                	addi	s0,sp,32
  // each CPU has a separate source of timer interrupts.
  int id = r_mhartid();
    80008548:	00000097          	auipc	ra,0x0
    8000854c:	d80080e7          	jalr	-640(ra) # 800082c8 <r_mhartid>
    80008550:	87aa                	mv	a5,a0
    80008552:	fef42623          	sw	a5,-20(s0)

  // ask the CLINT for a timer interrupt.
  int interval = 1000000; // cycles; about 1/10th second in qemu.
    80008556:	000f47b7          	lui	a5,0xf4
    8000855a:	24078793          	addi	a5,a5,576 # f4240 <_entry-0x7ff0bdc0>
    8000855e:	fef42423          	sw	a5,-24(s0)
  *(uint64*)CLINT_MTIMECMP(id) = *(uint64*)CLINT_MTIME + interval;
    80008562:	0200c7b7          	lui	a5,0x200c
    80008566:	17e1                	addi	a5,a5,-8 # 200bff8 <_entry-0x7dff4008>
    80008568:	6398                	ld	a4,0(a5)
    8000856a:	fe842783          	lw	a5,-24(s0)
    8000856e:	fec42683          	lw	a3,-20(s0)
    80008572:	0036969b          	slliw	a3,a3,0x3
    80008576:	2681                	sext.w	a3,a3
    80008578:	8636                	mv	a2,a3
    8000857a:	020046b7          	lui	a3,0x2004
    8000857e:	96b2                	add	a3,a3,a2
    80008580:	97ba                	add	a5,a5,a4
    80008582:	e29c                	sd	a5,0(a3)

  // prepare information in scratch[] for timervec.
  // scratch[0..2] : space for timervec to save registers.
  // scratch[3] : address of CLINT MTIMECMP register.
  // scratch[4] : desired interval (in cycles) between timer interrupts.
  uint64 *scratch = &timer_scratch[id][0];
    80008584:	fec42703          	lw	a4,-20(s0)
    80008588:	87ba                	mv	a5,a4
    8000858a:	078a                	slli	a5,a5,0x2
    8000858c:	97ba                	add	a5,a5,a4
    8000858e:	078e                	slli	a5,a5,0x3
    80008590:	0001d717          	auipc	a4,0x1d
    80008594:	92070713          	addi	a4,a4,-1760 # 80024eb0 <timer_scratch>
    80008598:	97ba                	add	a5,a5,a4
    8000859a:	fef43023          	sd	a5,-32(s0)
  scratch[3] = CLINT_MTIMECMP(id);
    8000859e:	fec42783          	lw	a5,-20(s0)
    800085a2:	0037979b          	slliw	a5,a5,0x3
    800085a6:	2781                	sext.w	a5,a5
    800085a8:	873e                	mv	a4,a5
    800085aa:	020047b7          	lui	a5,0x2004
    800085ae:	973e                	add	a4,a4,a5
    800085b0:	fe043783          	ld	a5,-32(s0)
    800085b4:	07e1                	addi	a5,a5,24 # 2004018 <_entry-0x7dffbfe8>
    800085b6:	e398                	sd	a4,0(a5)
  scratch[4] = interval;
    800085b8:	fe043783          	ld	a5,-32(s0)
    800085bc:	02078793          	addi	a5,a5,32
    800085c0:	fe842703          	lw	a4,-24(s0)
    800085c4:	e398                	sd	a4,0(a5)
  w_mscratch((uint64)scratch);
    800085c6:	fe043783          	ld	a5,-32(s0)
    800085ca:	853e                	mv	a0,a5
    800085cc:	00000097          	auipc	ra,0x0
    800085d0:	e68080e7          	jalr	-408(ra) # 80008434 <w_mscratch>

  // set the machine-mode trap handler.
  w_mtvec((uint64)timervec);
    800085d4:	fffff797          	auipc	a5,0xfffff
    800085d8:	17c78793          	addi	a5,a5,380 # 80007750 <timervec>
    800085dc:	853e                	mv	a0,a5
    800085de:	00000097          	auipc	ra,0x0
    800085e2:	dee080e7          	jalr	-530(ra) # 800083cc <w_mtvec>

  // enable machine-mode interrupts.
  w_mstatus(r_mstatus() | MSTATUS_MIE);
    800085e6:	00000097          	auipc	ra,0x0
    800085ea:	cfc080e7          	jalr	-772(ra) # 800082e2 <r_mstatus>
    800085ee:	87aa                	mv	a5,a0
    800085f0:	0087e793          	ori	a5,a5,8
    800085f4:	853e                	mv	a0,a5
    800085f6:	00000097          	auipc	ra,0x0
    800085fa:	d06080e7          	jalr	-762(ra) # 800082fc <w_mstatus>

  // enable machine-mode timer interrupts.
  w_mie(r_mie() | MIE_MTIE);
    800085fe:	00000097          	auipc	ra,0x0
    80008602:	d66080e7          	jalr	-666(ra) # 80008364 <r_mie>
    80008606:	87aa                	mv	a5,a0
    80008608:	0807e793          	ori	a5,a5,128
    8000860c:	853e                	mv	a0,a5
    8000860e:	00000097          	auipc	ra,0x0
    80008612:	d70080e7          	jalr	-656(ra) # 8000837e <w_mie>
}
    80008616:	0001                	nop
    80008618:	60e2                	ld	ra,24(sp)
    8000861a:	6442                	ld	s0,16(sp)
    8000861c:	6105                	addi	sp,sp,32
    8000861e:	8082                	ret

0000000080008620 <consputc>:
// called by printf(), and to echo input characters,
// but not from write().
//
void
consputc(int c)
{
    80008620:	1101                	addi	sp,sp,-32
    80008622:	ec06                	sd	ra,24(sp)
    80008624:	e822                	sd	s0,16(sp)
    80008626:	1000                	addi	s0,sp,32
    80008628:	87aa                	mv	a5,a0
    8000862a:	fef42623          	sw	a5,-20(s0)
  if(c == BACKSPACE){
    8000862e:	fec42783          	lw	a5,-20(s0)
    80008632:	0007871b          	sext.w	a4,a5
    80008636:	10000793          	li	a5,256
    8000863a:	02f71363          	bne	a4,a5,80008660 <consputc+0x40>
    // if the user typed backspace, overwrite with a space.
    uartputc_sync('\b'); uartputc_sync(' '); uartputc_sync('\b');
    8000863e:	4521                	li	a0,8
    80008640:	00001097          	auipc	ra,0x1
    80008644:	aba080e7          	jalr	-1350(ra) # 800090fa <uartputc_sync>
    80008648:	02000513          	li	a0,32
    8000864c:	00001097          	auipc	ra,0x1
    80008650:	aae080e7          	jalr	-1362(ra) # 800090fa <uartputc_sync>
    80008654:	4521                	li	a0,8
    80008656:	00001097          	auipc	ra,0x1
    8000865a:	aa4080e7          	jalr	-1372(ra) # 800090fa <uartputc_sync>
  } else {
    uartputc_sync(c);
  }
}
    8000865e:	a801                	j	8000866e <consputc+0x4e>
    uartputc_sync(c);
    80008660:	fec42783          	lw	a5,-20(s0)
    80008664:	853e                	mv	a0,a5
    80008666:	00001097          	auipc	ra,0x1
    8000866a:	a94080e7          	jalr	-1388(ra) # 800090fa <uartputc_sync>
}
    8000866e:	0001                	nop
    80008670:	60e2                	ld	ra,24(sp)
    80008672:	6442                	ld	s0,16(sp)
    80008674:	6105                	addi	sp,sp,32
    80008676:	8082                	ret

0000000080008678 <consolewrite>:
//
// user write()s to the console go here.
//
int
consolewrite(int user_src, uint64 src, int n)
{
    80008678:	7179                	addi	sp,sp,-48
    8000867a:	f406                	sd	ra,40(sp)
    8000867c:	f022                	sd	s0,32(sp)
    8000867e:	1800                	addi	s0,sp,48
    80008680:	87aa                	mv	a5,a0
    80008682:	fcb43823          	sd	a1,-48(s0)
    80008686:	8732                	mv	a4,a2
    80008688:	fcf42e23          	sw	a5,-36(s0)
    8000868c:	87ba                	mv	a5,a4
    8000868e:	fcf42c23          	sw	a5,-40(s0)
  int i;

  for(i = 0; i < n; i++){
    80008692:	fe042623          	sw	zero,-20(s0)
    80008696:	a0a1                	j	800086de <consolewrite+0x66>
    char c;
    if(either_copyin(&c, user_src, src+i, 1) == -1)
    80008698:	fec42703          	lw	a4,-20(s0)
    8000869c:	fd043783          	ld	a5,-48(s0)
    800086a0:	00f70633          	add	a2,a4,a5
    800086a4:	fdc42703          	lw	a4,-36(s0)
    800086a8:	feb40793          	addi	a5,s0,-21
    800086ac:	4685                	li	a3,1
    800086ae:	85ba                	mv	a1,a4
    800086b0:	853e                	mv	a0,a5
    800086b2:	ffffa097          	auipc	ra,0xffffa
    800086b6:	dc6080e7          	jalr	-570(ra) # 80002478 <either_copyin>
    800086ba:	87aa                	mv	a5,a0
    800086bc:	873e                	mv	a4,a5
    800086be:	57fd                	li	a5,-1
    800086c0:	02f70963          	beq	a4,a5,800086f2 <consolewrite+0x7a>
      break;
    uartputc(c);
    800086c4:	feb44783          	lbu	a5,-21(s0)
    800086c8:	2781                	sext.w	a5,a5
    800086ca:	853e                	mv	a0,a5
    800086cc:	00001097          	auipc	ra,0x1
    800086d0:	96e080e7          	jalr	-1682(ra) # 8000903a <uartputc>
  for(i = 0; i < n; i++){
    800086d4:	fec42783          	lw	a5,-20(s0)
    800086d8:	2785                	addiw	a5,a5,1
    800086da:	fef42623          	sw	a5,-20(s0)
    800086de:	fec42783          	lw	a5,-20(s0)
    800086e2:	873e                	mv	a4,a5
    800086e4:	fd842783          	lw	a5,-40(s0)
    800086e8:	2701                	sext.w	a4,a4
    800086ea:	2781                	sext.w	a5,a5
    800086ec:	faf746e3          	blt	a4,a5,80008698 <consolewrite+0x20>
    800086f0:	a011                	j	800086f4 <consolewrite+0x7c>
      break;
    800086f2:	0001                	nop
  }

  return i;
    800086f4:	fec42783          	lw	a5,-20(s0)
}
    800086f8:	853e                	mv	a0,a5
    800086fa:	70a2                	ld	ra,40(sp)
    800086fc:	7402                	ld	s0,32(sp)
    800086fe:	6145                	addi	sp,sp,48
    80008700:	8082                	ret

0000000080008702 <consoleread>:
// user_dist indicates whether dst is a user
// or kernel address.
//
int
consoleread(int user_dst, uint64 dst, int n)
{
    80008702:	7179                	addi	sp,sp,-48
    80008704:	f406                	sd	ra,40(sp)
    80008706:	f022                	sd	s0,32(sp)
    80008708:	1800                	addi	s0,sp,48
    8000870a:	87aa                	mv	a5,a0
    8000870c:	fcb43823          	sd	a1,-48(s0)
    80008710:	8732                	mv	a4,a2
    80008712:	fcf42e23          	sw	a5,-36(s0)
    80008716:	87ba                	mv	a5,a4
    80008718:	fcf42c23          	sw	a5,-40(s0)
  uint target;
  int c;
  char cbuf;

  target = n;
    8000871c:	fd842783          	lw	a5,-40(s0)
    80008720:	fef42623          	sw	a5,-20(s0)
  acquire(&cons.lock);
    80008724:	0001d517          	auipc	a0,0x1d
    80008728:	8cc50513          	addi	a0,a0,-1844 # 80024ff0 <cons>
    8000872c:	00001097          	auipc	ra,0x1
    80008730:	c52080e7          	jalr	-942(ra) # 8000937e <acquire>
  while(n > 0){
    80008734:	a23d                	j	80008862 <consoleread+0x160>
    // wait until interrupt handler has put some
    // input into cons.buffer.
    while(cons.r == cons.w){
      if(killed(myproc())){
    80008736:	ffff9097          	auipc	ra,0xffff9
    8000873a:	eca080e7          	jalr	-310(ra) # 80001600 <myproc>
    8000873e:	87aa                	mv	a5,a0
    80008740:	853e                	mv	a0,a5
    80008742:	ffffa097          	auipc	ra,0xffffa
    80008746:	c82080e7          	jalr	-894(ra) # 800023c4 <killed>
    8000874a:	87aa                	mv	a5,a0
    8000874c:	cb99                	beqz	a5,80008762 <consoleread+0x60>
        release(&cons.lock);
    8000874e:	0001d517          	auipc	a0,0x1d
    80008752:	8a250513          	addi	a0,a0,-1886 # 80024ff0 <cons>
    80008756:	00001097          	auipc	ra,0x1
    8000875a:	c8c080e7          	jalr	-884(ra) # 800093e2 <release>
        return -1;
    8000875e:	57fd                	li	a5,-1
    80008760:	aa25                	j	80008898 <consoleread+0x196>
      }
      sleep(&cons.r, &cons.lock);
    80008762:	0001d597          	auipc	a1,0x1d
    80008766:	88e58593          	addi	a1,a1,-1906 # 80024ff0 <cons>
    8000876a:	0001d517          	auipc	a0,0x1d
    8000876e:	91e50513          	addi	a0,a0,-1762 # 80025088 <cons+0x98>
    80008772:	ffffa097          	auipc	ra,0xffffa
    80008776:	a68080e7          	jalr	-1432(ra) # 800021da <sleep>
    while(cons.r == cons.w){
    8000877a:	0001d797          	auipc	a5,0x1d
    8000877e:	87678793          	addi	a5,a5,-1930 # 80024ff0 <cons>
    80008782:	0987a703          	lw	a4,152(a5)
    80008786:	0001d797          	auipc	a5,0x1d
    8000878a:	86a78793          	addi	a5,a5,-1942 # 80024ff0 <cons>
    8000878e:	09c7a783          	lw	a5,156(a5)
    80008792:	faf702e3          	beq	a4,a5,80008736 <consoleread+0x34>
    }

    c = cons.buf[cons.r++ % INPUT_BUF_SIZE];
    80008796:	0001d797          	auipc	a5,0x1d
    8000879a:	85a78793          	addi	a5,a5,-1958 # 80024ff0 <cons>
    8000879e:	0987a783          	lw	a5,152(a5)
    800087a2:	2781                	sext.w	a5,a5
    800087a4:	0017871b          	addiw	a4,a5,1
    800087a8:	0007069b          	sext.w	a3,a4
    800087ac:	0001d717          	auipc	a4,0x1d
    800087b0:	84470713          	addi	a4,a4,-1980 # 80024ff0 <cons>
    800087b4:	08d72c23          	sw	a3,152(a4)
    800087b8:	07f7f793          	andi	a5,a5,127
    800087bc:	2781                	sext.w	a5,a5
    800087be:	0001d717          	auipc	a4,0x1d
    800087c2:	83270713          	addi	a4,a4,-1998 # 80024ff0 <cons>
    800087c6:	1782                	slli	a5,a5,0x20
    800087c8:	9381                	srli	a5,a5,0x20
    800087ca:	97ba                	add	a5,a5,a4
    800087cc:	0187c783          	lbu	a5,24(a5)
    800087d0:	fef42423          	sw	a5,-24(s0)

    if(c == C('D')){  // end-of-file
    800087d4:	fe842783          	lw	a5,-24(s0)
    800087d8:	0007871b          	sext.w	a4,a5
    800087dc:	4791                	li	a5,4
    800087de:	02f71963          	bne	a4,a5,80008810 <consoleread+0x10e>
      if(n < target){
    800087e2:	fd842703          	lw	a4,-40(s0)
    800087e6:	fec42783          	lw	a5,-20(s0)
    800087ea:	2781                	sext.w	a5,a5
    800087ec:	08f77163          	bgeu	a4,a5,8000886e <consoleread+0x16c>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        cons.r--;
    800087f0:	0001d797          	auipc	a5,0x1d
    800087f4:	80078793          	addi	a5,a5,-2048 # 80024ff0 <cons>
    800087f8:	0987a783          	lw	a5,152(a5)
    800087fc:	37fd                	addiw	a5,a5,-1
    800087fe:	0007871b          	sext.w	a4,a5
    80008802:	0001c797          	auipc	a5,0x1c
    80008806:	7ee78793          	addi	a5,a5,2030 # 80024ff0 <cons>
    8000880a:	08e7ac23          	sw	a4,152(a5)
      }
      break;
    8000880e:	a085                	j	8000886e <consoleread+0x16c>
    }

    // copy the input byte to the user-space buffer.
    cbuf = c;
    80008810:	fe842783          	lw	a5,-24(s0)
    80008814:	0ff7f793          	zext.b	a5,a5
    80008818:	fef403a3          	sb	a5,-25(s0)
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    8000881c:	fe740713          	addi	a4,s0,-25
    80008820:	fdc42783          	lw	a5,-36(s0)
    80008824:	4685                	li	a3,1
    80008826:	863a                	mv	a2,a4
    80008828:	fd043583          	ld	a1,-48(s0)
    8000882c:	853e                	mv	a0,a5
    8000882e:	ffffa097          	auipc	ra,0xffffa
    80008832:	bd6080e7          	jalr	-1066(ra) # 80002404 <either_copyout>
    80008836:	87aa                	mv	a5,a0
    80008838:	873e                	mv	a4,a5
    8000883a:	57fd                	li	a5,-1
    8000883c:	02f70b63          	beq	a4,a5,80008872 <consoleread+0x170>
      break;

    dst++;
    80008840:	fd043783          	ld	a5,-48(s0)
    80008844:	0785                	addi	a5,a5,1
    80008846:	fcf43823          	sd	a5,-48(s0)
    --n;
    8000884a:	fd842783          	lw	a5,-40(s0)
    8000884e:	37fd                	addiw	a5,a5,-1
    80008850:	fcf42c23          	sw	a5,-40(s0)

    if(c == '\n'){
    80008854:	fe842783          	lw	a5,-24(s0)
    80008858:	0007871b          	sext.w	a4,a5
    8000885c:	47a9                	li	a5,10
    8000885e:	00f70c63          	beq	a4,a5,80008876 <consoleread+0x174>
  while(n > 0){
    80008862:	fd842783          	lw	a5,-40(s0)
    80008866:	2781                	sext.w	a5,a5
    80008868:	f0f049e3          	bgtz	a5,8000877a <consoleread+0x78>
    8000886c:	a031                	j	80008878 <consoleread+0x176>
      break;
    8000886e:	0001                	nop
    80008870:	a021                	j	80008878 <consoleread+0x176>
      break;
    80008872:	0001                	nop
    80008874:	a011                	j	80008878 <consoleread+0x176>
      // a whole line has arrived, return to
      // the user-level read().
      break;
    80008876:	0001                	nop
    }
  }
  release(&cons.lock);
    80008878:	0001c517          	auipc	a0,0x1c
    8000887c:	77850513          	addi	a0,a0,1912 # 80024ff0 <cons>
    80008880:	00001097          	auipc	ra,0x1
    80008884:	b62080e7          	jalr	-1182(ra) # 800093e2 <release>

  return target - n;
    80008888:	fd842783          	lw	a5,-40(s0)
    8000888c:	fec42703          	lw	a4,-20(s0)
    80008890:	40f707bb          	subw	a5,a4,a5
    80008894:	2781                	sext.w	a5,a5
    80008896:	2781                	sext.w	a5,a5
}
    80008898:	853e                	mv	a0,a5
    8000889a:	70a2                	ld	ra,40(sp)
    8000889c:	7402                	ld	s0,32(sp)
    8000889e:	6145                	addi	sp,sp,48
    800088a0:	8082                	ret

00000000800088a2 <consoleintr>:
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void
consoleintr(int c)
{
    800088a2:	1101                	addi	sp,sp,-32
    800088a4:	ec06                	sd	ra,24(sp)
    800088a6:	e822                	sd	s0,16(sp)
    800088a8:	1000                	addi	s0,sp,32
    800088aa:	87aa                	mv	a5,a0
    800088ac:	fef42623          	sw	a5,-20(s0)
  acquire(&cons.lock);
    800088b0:	0001c517          	auipc	a0,0x1c
    800088b4:	74050513          	addi	a0,a0,1856 # 80024ff0 <cons>
    800088b8:	00001097          	auipc	ra,0x1
    800088bc:	ac6080e7          	jalr	-1338(ra) # 8000937e <acquire>

  switch(c){
    800088c0:	fec42783          	lw	a5,-20(s0)
    800088c4:	0007871b          	sext.w	a4,a5
    800088c8:	07f00793          	li	a5,127
    800088cc:	0cf70763          	beq	a4,a5,8000899a <consoleintr+0xf8>
    800088d0:	fec42783          	lw	a5,-20(s0)
    800088d4:	0007871b          	sext.w	a4,a5
    800088d8:	07f00793          	li	a5,127
    800088dc:	10e7c363          	blt	a5,a4,800089e2 <consoleintr+0x140>
    800088e0:	fec42783          	lw	a5,-20(s0)
    800088e4:	0007871b          	sext.w	a4,a5
    800088e8:	47d5                	li	a5,21
    800088ea:	06f70163          	beq	a4,a5,8000894c <consoleintr+0xaa>
    800088ee:	fec42783          	lw	a5,-20(s0)
    800088f2:	0007871b          	sext.w	a4,a5
    800088f6:	47d5                	li	a5,21
    800088f8:	0ee7c563          	blt	a5,a4,800089e2 <consoleintr+0x140>
    800088fc:	fec42783          	lw	a5,-20(s0)
    80008900:	0007871b          	sext.w	a4,a5
    80008904:	47a1                	li	a5,8
    80008906:	08f70a63          	beq	a4,a5,8000899a <consoleintr+0xf8>
    8000890a:	fec42783          	lw	a5,-20(s0)
    8000890e:	0007871b          	sext.w	a4,a5
    80008912:	47c1                	li	a5,16
    80008914:	0cf71763          	bne	a4,a5,800089e2 <consoleintr+0x140>
  case C('P'):  // Print process list.
    procdump();
    80008918:	ffffa097          	auipc	ra,0xffffa
    8000891c:	bd4080e7          	jalr	-1068(ra) # 800024ec <procdump>
    break;
    80008920:	aad9                	j	80008af6 <consoleintr+0x254>
  case C('U'):  // Kill line.
    while(cons.e != cons.w &&
          cons.buf[(cons.e-1) % INPUT_BUF_SIZE] != '\n'){
      cons.e--;
    80008922:	0001c797          	auipc	a5,0x1c
    80008926:	6ce78793          	addi	a5,a5,1742 # 80024ff0 <cons>
    8000892a:	0a07a783          	lw	a5,160(a5)
    8000892e:	37fd                	addiw	a5,a5,-1
    80008930:	0007871b          	sext.w	a4,a5
    80008934:	0001c797          	auipc	a5,0x1c
    80008938:	6bc78793          	addi	a5,a5,1724 # 80024ff0 <cons>
    8000893c:	0ae7a023          	sw	a4,160(a5)
      consputc(BACKSPACE);
    80008940:	10000513          	li	a0,256
    80008944:	00000097          	auipc	ra,0x0
    80008948:	cdc080e7          	jalr	-804(ra) # 80008620 <consputc>
    while(cons.e != cons.w &&
    8000894c:	0001c797          	auipc	a5,0x1c
    80008950:	6a478793          	addi	a5,a5,1700 # 80024ff0 <cons>
    80008954:	0a07a703          	lw	a4,160(a5)
    80008958:	0001c797          	auipc	a5,0x1c
    8000895c:	69878793          	addi	a5,a5,1688 # 80024ff0 <cons>
    80008960:	09c7a783          	lw	a5,156(a5)
    80008964:	18f70463          	beq	a4,a5,80008aec <consoleintr+0x24a>
          cons.buf[(cons.e-1) % INPUT_BUF_SIZE] != '\n'){
    80008968:	0001c797          	auipc	a5,0x1c
    8000896c:	68878793          	addi	a5,a5,1672 # 80024ff0 <cons>
    80008970:	0a07a783          	lw	a5,160(a5)
    80008974:	37fd                	addiw	a5,a5,-1
    80008976:	2781                	sext.w	a5,a5
    80008978:	07f7f793          	andi	a5,a5,127
    8000897c:	2781                	sext.w	a5,a5
    8000897e:	0001c717          	auipc	a4,0x1c
    80008982:	67270713          	addi	a4,a4,1650 # 80024ff0 <cons>
    80008986:	1782                	slli	a5,a5,0x20
    80008988:	9381                	srli	a5,a5,0x20
    8000898a:	97ba                	add	a5,a5,a4
    8000898c:	0187c783          	lbu	a5,24(a5)
    while(cons.e != cons.w &&
    80008990:	873e                	mv	a4,a5
    80008992:	47a9                	li	a5,10
    80008994:	f8f717e3          	bne	a4,a5,80008922 <consoleintr+0x80>
    }
    break;
    80008998:	aa91                	j	80008aec <consoleintr+0x24a>
  case C('H'): // Backspace
  case '\x7f': // Delete key
    if(cons.e != cons.w){
    8000899a:	0001c797          	auipc	a5,0x1c
    8000899e:	65678793          	addi	a5,a5,1622 # 80024ff0 <cons>
    800089a2:	0a07a703          	lw	a4,160(a5)
    800089a6:	0001c797          	auipc	a5,0x1c
    800089aa:	64a78793          	addi	a5,a5,1610 # 80024ff0 <cons>
    800089ae:	09c7a783          	lw	a5,156(a5)
    800089b2:	12f70f63          	beq	a4,a5,80008af0 <consoleintr+0x24e>
      cons.e--;
    800089b6:	0001c797          	auipc	a5,0x1c
    800089ba:	63a78793          	addi	a5,a5,1594 # 80024ff0 <cons>
    800089be:	0a07a783          	lw	a5,160(a5)
    800089c2:	37fd                	addiw	a5,a5,-1
    800089c4:	0007871b          	sext.w	a4,a5
    800089c8:	0001c797          	auipc	a5,0x1c
    800089cc:	62878793          	addi	a5,a5,1576 # 80024ff0 <cons>
    800089d0:	0ae7a023          	sw	a4,160(a5)
      consputc(BACKSPACE);
    800089d4:	10000513          	li	a0,256
    800089d8:	00000097          	auipc	ra,0x0
    800089dc:	c48080e7          	jalr	-952(ra) # 80008620 <consputc>
    }
    break;
    800089e0:	aa01                	j	80008af0 <consoleintr+0x24e>
  default:
    if(c != 0 && cons.e-cons.r < INPUT_BUF_SIZE){
    800089e2:	fec42783          	lw	a5,-20(s0)
    800089e6:	2781                	sext.w	a5,a5
    800089e8:	10078663          	beqz	a5,80008af4 <consoleintr+0x252>
    800089ec:	0001c797          	auipc	a5,0x1c
    800089f0:	60478793          	addi	a5,a5,1540 # 80024ff0 <cons>
    800089f4:	0a07a703          	lw	a4,160(a5)
    800089f8:	0001c797          	auipc	a5,0x1c
    800089fc:	5f878793          	addi	a5,a5,1528 # 80024ff0 <cons>
    80008a00:	0987a783          	lw	a5,152(a5)
    80008a04:	40f707bb          	subw	a5,a4,a5
    80008a08:	2781                	sext.w	a5,a5
    80008a0a:	873e                	mv	a4,a5
    80008a0c:	07f00793          	li	a5,127
    80008a10:	0ee7e263          	bltu	a5,a4,80008af4 <consoleintr+0x252>
      c = (c == '\r') ? '\n' : c;
    80008a14:	fec42783          	lw	a5,-20(s0)
    80008a18:	0007871b          	sext.w	a4,a5
    80008a1c:	47b5                	li	a5,13
    80008a1e:	00f70563          	beq	a4,a5,80008a28 <consoleintr+0x186>
    80008a22:	fec42783          	lw	a5,-20(s0)
    80008a26:	a011                	j	80008a2a <consoleintr+0x188>
    80008a28:	47a9                	li	a5,10
    80008a2a:	fef42623          	sw	a5,-20(s0)

      // echo back to the user.
      consputc(c);
    80008a2e:	fec42783          	lw	a5,-20(s0)
    80008a32:	853e                	mv	a0,a5
    80008a34:	00000097          	auipc	ra,0x0
    80008a38:	bec080e7          	jalr	-1044(ra) # 80008620 <consputc>

      // store for consumption by consoleread().
      cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    80008a3c:	0001c797          	auipc	a5,0x1c
    80008a40:	5b478793          	addi	a5,a5,1460 # 80024ff0 <cons>
    80008a44:	0a07a783          	lw	a5,160(a5)
    80008a48:	2781                	sext.w	a5,a5
    80008a4a:	0017871b          	addiw	a4,a5,1
    80008a4e:	0007069b          	sext.w	a3,a4
    80008a52:	0001c717          	auipc	a4,0x1c
    80008a56:	59e70713          	addi	a4,a4,1438 # 80024ff0 <cons>
    80008a5a:	0ad72023          	sw	a3,160(a4)
    80008a5e:	07f7f793          	andi	a5,a5,127
    80008a62:	2781                	sext.w	a5,a5
    80008a64:	fec42703          	lw	a4,-20(s0)
    80008a68:	0ff77713          	zext.b	a4,a4
    80008a6c:	0001c697          	auipc	a3,0x1c
    80008a70:	58468693          	addi	a3,a3,1412 # 80024ff0 <cons>
    80008a74:	1782                	slli	a5,a5,0x20
    80008a76:	9381                	srli	a5,a5,0x20
    80008a78:	97b6                	add	a5,a5,a3
    80008a7a:	00e78c23          	sb	a4,24(a5)

      if(c == '\n' || c == C('D') || cons.e-cons.r == INPUT_BUF_SIZE){
    80008a7e:	fec42783          	lw	a5,-20(s0)
    80008a82:	0007871b          	sext.w	a4,a5
    80008a86:	47a9                	li	a5,10
    80008a88:	02f70d63          	beq	a4,a5,80008ac2 <consoleintr+0x220>
    80008a8c:	fec42783          	lw	a5,-20(s0)
    80008a90:	0007871b          	sext.w	a4,a5
    80008a94:	4791                	li	a5,4
    80008a96:	02f70663          	beq	a4,a5,80008ac2 <consoleintr+0x220>
    80008a9a:	0001c797          	auipc	a5,0x1c
    80008a9e:	55678793          	addi	a5,a5,1366 # 80024ff0 <cons>
    80008aa2:	0a07a703          	lw	a4,160(a5)
    80008aa6:	0001c797          	auipc	a5,0x1c
    80008aaa:	54a78793          	addi	a5,a5,1354 # 80024ff0 <cons>
    80008aae:	0987a783          	lw	a5,152(a5)
    80008ab2:	40f707bb          	subw	a5,a4,a5
    80008ab6:	2781                	sext.w	a5,a5
    80008ab8:	873e                	mv	a4,a5
    80008aba:	08000793          	li	a5,128
    80008abe:	02f71b63          	bne	a4,a5,80008af4 <consoleintr+0x252>
        // wake up consoleread() if a whole line (or end-of-file)
        // has arrived.
        cons.w = cons.e;
    80008ac2:	0001c797          	auipc	a5,0x1c
    80008ac6:	52e78793          	addi	a5,a5,1326 # 80024ff0 <cons>
    80008aca:	0a07a703          	lw	a4,160(a5)
    80008ace:	0001c797          	auipc	a5,0x1c
    80008ad2:	52278793          	addi	a5,a5,1314 # 80024ff0 <cons>
    80008ad6:	08e7ae23          	sw	a4,156(a5)
        wakeup(&cons.r);
    80008ada:	0001c517          	auipc	a0,0x1c
    80008ade:	5ae50513          	addi	a0,a0,1454 # 80025088 <cons+0x98>
    80008ae2:	ffff9097          	auipc	ra,0xffff9
    80008ae6:	774080e7          	jalr	1908(ra) # 80002256 <wakeup>
      }
    }
    break;
    80008aea:	a029                	j	80008af4 <consoleintr+0x252>
    break;
    80008aec:	0001                	nop
    80008aee:	a021                	j	80008af6 <consoleintr+0x254>
    break;
    80008af0:	0001                	nop
    80008af2:	a011                	j	80008af6 <consoleintr+0x254>
    break;
    80008af4:	0001                	nop
  }
  
  release(&cons.lock);
    80008af6:	0001c517          	auipc	a0,0x1c
    80008afa:	4fa50513          	addi	a0,a0,1274 # 80024ff0 <cons>
    80008afe:	00001097          	auipc	ra,0x1
    80008b02:	8e4080e7          	jalr	-1820(ra) # 800093e2 <release>
}
    80008b06:	0001                	nop
    80008b08:	60e2                	ld	ra,24(sp)
    80008b0a:	6442                	ld	s0,16(sp)
    80008b0c:	6105                	addi	sp,sp,32
    80008b0e:	8082                	ret

0000000080008b10 <consoleinit>:

void
consoleinit(void)
{
    80008b10:	1141                	addi	sp,sp,-16
    80008b12:	e406                	sd	ra,8(sp)
    80008b14:	e022                	sd	s0,0(sp)
    80008b16:	0800                	addi	s0,sp,16
  initlock(&cons.lock, "cons");
    80008b18:	00003597          	auipc	a1,0x3
    80008b1c:	ca058593          	addi	a1,a1,-864 # 8000b7b8 <etext+0x7b8>
    80008b20:	0001c517          	auipc	a0,0x1c
    80008b24:	4d050513          	addi	a0,a0,1232 # 80024ff0 <cons>
    80008b28:	00001097          	auipc	ra,0x1
    80008b2c:	826080e7          	jalr	-2010(ra) # 8000934e <initlock>

  uartinit();
    80008b30:	00000097          	auipc	ra,0x0
    80008b34:	490080e7          	jalr	1168(ra) # 80008fc0 <uartinit>

  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    80008b38:	00013797          	auipc	a5,0x13
    80008b3c:	1d878793          	addi	a5,a5,472 # 8001bd10 <devsw>
    80008b40:	00000717          	auipc	a4,0x0
    80008b44:	bc270713          	addi	a4,a4,-1086 # 80008702 <consoleread>
    80008b48:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    80008b4a:	00013797          	auipc	a5,0x13
    80008b4e:	1c678793          	addi	a5,a5,454 # 8001bd10 <devsw>
    80008b52:	00000717          	auipc	a4,0x0
    80008b56:	b2670713          	addi	a4,a4,-1242 # 80008678 <consolewrite>
    80008b5a:	ef98                	sd	a4,24(a5)
}
    80008b5c:	0001                	nop
    80008b5e:	60a2                	ld	ra,8(sp)
    80008b60:	6402                	ld	s0,0(sp)
    80008b62:	0141                	addi	sp,sp,16
    80008b64:	8082                	ret

0000000080008b66 <printint>:

static char digits[] = "0123456789abcdef";

static void
printint(int xx, int base, int sign)
{
    80008b66:	7139                	addi	sp,sp,-64
    80008b68:	fc06                	sd	ra,56(sp)
    80008b6a:	f822                	sd	s0,48(sp)
    80008b6c:	0080                	addi	s0,sp,64
    80008b6e:	87aa                	mv	a5,a0
    80008b70:	86ae                	mv	a3,a1
    80008b72:	8732                	mv	a4,a2
    80008b74:	fcf42623          	sw	a5,-52(s0)
    80008b78:	87b6                	mv	a5,a3
    80008b7a:	fcf42423          	sw	a5,-56(s0)
    80008b7e:	87ba                	mv	a5,a4
    80008b80:	fcf42223          	sw	a5,-60(s0)
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    80008b84:	fc442783          	lw	a5,-60(s0)
    80008b88:	2781                	sext.w	a5,a5
    80008b8a:	c78d                	beqz	a5,80008bb4 <printint+0x4e>
    80008b8c:	fcc42783          	lw	a5,-52(s0)
    80008b90:	01f7d79b          	srliw	a5,a5,0x1f
    80008b94:	0ff7f793          	zext.b	a5,a5
    80008b98:	fcf42223          	sw	a5,-60(s0)
    80008b9c:	fc442783          	lw	a5,-60(s0)
    80008ba0:	2781                	sext.w	a5,a5
    80008ba2:	cb89                	beqz	a5,80008bb4 <printint+0x4e>
    x = -xx;
    80008ba4:	fcc42783          	lw	a5,-52(s0)
    80008ba8:	40f007bb          	negw	a5,a5
    80008bac:	2781                	sext.w	a5,a5
    80008bae:	fef42423          	sw	a5,-24(s0)
    80008bb2:	a029                	j	80008bbc <printint+0x56>
  else
    x = xx;
    80008bb4:	fcc42783          	lw	a5,-52(s0)
    80008bb8:	fef42423          	sw	a5,-24(s0)

  i = 0;
    80008bbc:	fe042623          	sw	zero,-20(s0)
  do {
    buf[i++] = digits[x % base];
    80008bc0:	fc842783          	lw	a5,-56(s0)
    80008bc4:	fe842703          	lw	a4,-24(s0)
    80008bc8:	02f777bb          	remuw	a5,a4,a5
    80008bcc:	0007861b          	sext.w	a2,a5
    80008bd0:	fec42783          	lw	a5,-20(s0)
    80008bd4:	0017871b          	addiw	a4,a5,1
    80008bd8:	fee42623          	sw	a4,-20(s0)
    80008bdc:	00003697          	auipc	a3,0x3
    80008be0:	e4c68693          	addi	a3,a3,-436 # 8000ba28 <digits>
    80008be4:	02061713          	slli	a4,a2,0x20
    80008be8:	9301                	srli	a4,a4,0x20
    80008bea:	9736                	add	a4,a4,a3
    80008bec:	00074703          	lbu	a4,0(a4)
    80008bf0:	17c1                	addi	a5,a5,-16
    80008bf2:	97a2                	add	a5,a5,s0
    80008bf4:	fee78423          	sb	a4,-24(a5)
  } while((x /= base) != 0);
    80008bf8:	fc842783          	lw	a5,-56(s0)
    80008bfc:	fe842703          	lw	a4,-24(s0)
    80008c00:	02f757bb          	divuw	a5,a4,a5
    80008c04:	fef42423          	sw	a5,-24(s0)
    80008c08:	fe842783          	lw	a5,-24(s0)
    80008c0c:	2781                	sext.w	a5,a5
    80008c0e:	fbcd                	bnez	a5,80008bc0 <printint+0x5a>

  if(sign)
    80008c10:	fc442783          	lw	a5,-60(s0)
    80008c14:	2781                	sext.w	a5,a5
    80008c16:	cb95                	beqz	a5,80008c4a <printint+0xe4>
    buf[i++] = '-';
    80008c18:	fec42783          	lw	a5,-20(s0)
    80008c1c:	0017871b          	addiw	a4,a5,1
    80008c20:	fee42623          	sw	a4,-20(s0)
    80008c24:	17c1                	addi	a5,a5,-16
    80008c26:	97a2                	add	a5,a5,s0
    80008c28:	02d00713          	li	a4,45
    80008c2c:	fee78423          	sb	a4,-24(a5)

  while(--i >= 0)
    80008c30:	a829                	j	80008c4a <printint+0xe4>
    consputc(buf[i]);
    80008c32:	fec42783          	lw	a5,-20(s0)
    80008c36:	17c1                	addi	a5,a5,-16
    80008c38:	97a2                	add	a5,a5,s0
    80008c3a:	fe87c783          	lbu	a5,-24(a5)
    80008c3e:	2781                	sext.w	a5,a5
    80008c40:	853e                	mv	a0,a5
    80008c42:	00000097          	auipc	ra,0x0
    80008c46:	9de080e7          	jalr	-1570(ra) # 80008620 <consputc>
  while(--i >= 0)
    80008c4a:	fec42783          	lw	a5,-20(s0)
    80008c4e:	37fd                	addiw	a5,a5,-1
    80008c50:	fef42623          	sw	a5,-20(s0)
    80008c54:	fec42783          	lw	a5,-20(s0)
    80008c58:	2781                	sext.w	a5,a5
    80008c5a:	fc07dce3          	bgez	a5,80008c32 <printint+0xcc>
}
    80008c5e:	0001                	nop
    80008c60:	0001                	nop
    80008c62:	70e2                	ld	ra,56(sp)
    80008c64:	7442                	ld	s0,48(sp)
    80008c66:	6121                	addi	sp,sp,64
    80008c68:	8082                	ret

0000000080008c6a <printptr>:

static void
printptr(uint64 x)
{
    80008c6a:	7179                	addi	sp,sp,-48
    80008c6c:	f406                	sd	ra,40(sp)
    80008c6e:	f022                	sd	s0,32(sp)
    80008c70:	1800                	addi	s0,sp,48
    80008c72:	fca43c23          	sd	a0,-40(s0)
  int i;
  consputc('0');
    80008c76:	03000513          	li	a0,48
    80008c7a:	00000097          	auipc	ra,0x0
    80008c7e:	9a6080e7          	jalr	-1626(ra) # 80008620 <consputc>
  consputc('x');
    80008c82:	07800513          	li	a0,120
    80008c86:	00000097          	auipc	ra,0x0
    80008c8a:	99a080e7          	jalr	-1638(ra) # 80008620 <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    80008c8e:	fe042623          	sw	zero,-20(s0)
    80008c92:	a81d                	j	80008cc8 <printptr+0x5e>
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    80008c94:	fd843783          	ld	a5,-40(s0)
    80008c98:	93f1                	srli	a5,a5,0x3c
    80008c9a:	00003717          	auipc	a4,0x3
    80008c9e:	d8e70713          	addi	a4,a4,-626 # 8000ba28 <digits>
    80008ca2:	97ba                	add	a5,a5,a4
    80008ca4:	0007c783          	lbu	a5,0(a5)
    80008ca8:	2781                	sext.w	a5,a5
    80008caa:	853e                	mv	a0,a5
    80008cac:	00000097          	auipc	ra,0x0
    80008cb0:	974080e7          	jalr	-1676(ra) # 80008620 <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    80008cb4:	fec42783          	lw	a5,-20(s0)
    80008cb8:	2785                	addiw	a5,a5,1
    80008cba:	fef42623          	sw	a5,-20(s0)
    80008cbe:	fd843783          	ld	a5,-40(s0)
    80008cc2:	0792                	slli	a5,a5,0x4
    80008cc4:	fcf43c23          	sd	a5,-40(s0)
    80008cc8:	fec42783          	lw	a5,-20(s0)
    80008ccc:	873e                	mv	a4,a5
    80008cce:	47bd                	li	a5,15
    80008cd0:	fce7f2e3          	bgeu	a5,a4,80008c94 <printptr+0x2a>
}
    80008cd4:	0001                	nop
    80008cd6:	0001                	nop
    80008cd8:	70a2                	ld	ra,40(sp)
    80008cda:	7402                	ld	s0,32(sp)
    80008cdc:	6145                	addi	sp,sp,48
    80008cde:	8082                	ret

0000000080008ce0 <printf>:

// Print to the console. only understands %d, %x, %p, %s.
void
printf(char *fmt, ...)
{
    80008ce0:	7119                	addi	sp,sp,-128
    80008ce2:	fc06                	sd	ra,56(sp)
    80008ce4:	f822                	sd	s0,48(sp)
    80008ce6:	0080                	addi	s0,sp,64
    80008ce8:	fca43423          	sd	a0,-56(s0)
    80008cec:	e40c                	sd	a1,8(s0)
    80008cee:	e810                	sd	a2,16(s0)
    80008cf0:	ec14                	sd	a3,24(s0)
    80008cf2:	f018                	sd	a4,32(s0)
    80008cf4:	f41c                	sd	a5,40(s0)
    80008cf6:	03043823          	sd	a6,48(s0)
    80008cfa:	03143c23          	sd	a7,56(s0)
  va_list ap;
  int i, c, locking;
  char *s;

  locking = pr.locking;
    80008cfe:	0001c797          	auipc	a5,0x1c
    80008d02:	39a78793          	addi	a5,a5,922 # 80025098 <pr>
    80008d06:	4f9c                	lw	a5,24(a5)
    80008d08:	fcf42e23          	sw	a5,-36(s0)
  if(locking)
    80008d0c:	fdc42783          	lw	a5,-36(s0)
    80008d10:	2781                	sext.w	a5,a5
    80008d12:	cb89                	beqz	a5,80008d24 <printf+0x44>
    acquire(&pr.lock);
    80008d14:	0001c517          	auipc	a0,0x1c
    80008d18:	38450513          	addi	a0,a0,900 # 80025098 <pr>
    80008d1c:	00000097          	auipc	ra,0x0
    80008d20:	662080e7          	jalr	1634(ra) # 8000937e <acquire>

  if (fmt == 0)
    80008d24:	fc843783          	ld	a5,-56(s0)
    80008d28:	eb89                	bnez	a5,80008d3a <printf+0x5a>
    panic("null fmt");
    80008d2a:	00003517          	auipc	a0,0x3
    80008d2e:	a9650513          	addi	a0,a0,-1386 # 8000b7c0 <etext+0x7c0>
    80008d32:	00000097          	auipc	ra,0x0
    80008d36:	204080e7          	jalr	516(ra) # 80008f36 <panic>

  va_start(ap, fmt);
    80008d3a:	04040793          	addi	a5,s0,64
    80008d3e:	fcf43023          	sd	a5,-64(s0)
    80008d42:	fc043783          	ld	a5,-64(s0)
    80008d46:	fc878793          	addi	a5,a5,-56
    80008d4a:	fcf43823          	sd	a5,-48(s0)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80008d4e:	fe042623          	sw	zero,-20(s0)
    80008d52:	a24d                	j	80008ef4 <printf+0x214>
    if(c != '%'){
    80008d54:	fd842783          	lw	a5,-40(s0)
    80008d58:	0007871b          	sext.w	a4,a5
    80008d5c:	02500793          	li	a5,37
    80008d60:	00f70a63          	beq	a4,a5,80008d74 <printf+0x94>
      consputc(c);
    80008d64:	fd842783          	lw	a5,-40(s0)
    80008d68:	853e                	mv	a0,a5
    80008d6a:	00000097          	auipc	ra,0x0
    80008d6e:	8b6080e7          	jalr	-1866(ra) # 80008620 <consputc>
      continue;
    80008d72:	aaa5                	j	80008eea <printf+0x20a>
    }
    c = fmt[++i] & 0xff;
    80008d74:	fec42783          	lw	a5,-20(s0)
    80008d78:	2785                	addiw	a5,a5,1
    80008d7a:	fef42623          	sw	a5,-20(s0)
    80008d7e:	fec42783          	lw	a5,-20(s0)
    80008d82:	fc843703          	ld	a4,-56(s0)
    80008d86:	97ba                	add	a5,a5,a4
    80008d88:	0007c783          	lbu	a5,0(a5)
    80008d8c:	fcf42c23          	sw	a5,-40(s0)
    if(c == 0)
    80008d90:	fd842783          	lw	a5,-40(s0)
    80008d94:	2781                	sext.w	a5,a5
    80008d96:	16078e63          	beqz	a5,80008f12 <printf+0x232>
      break;
    switch(c){
    80008d9a:	fd842783          	lw	a5,-40(s0)
    80008d9e:	0007871b          	sext.w	a4,a5
    80008da2:	07800793          	li	a5,120
    80008da6:	08f70963          	beq	a4,a5,80008e38 <printf+0x158>
    80008daa:	fd842783          	lw	a5,-40(s0)
    80008dae:	0007871b          	sext.w	a4,a5
    80008db2:	07800793          	li	a5,120
    80008db6:	10e7cc63          	blt	a5,a4,80008ece <printf+0x1ee>
    80008dba:	fd842783          	lw	a5,-40(s0)
    80008dbe:	0007871b          	sext.w	a4,a5
    80008dc2:	07300793          	li	a5,115
    80008dc6:	0af70563          	beq	a4,a5,80008e70 <printf+0x190>
    80008dca:	fd842783          	lw	a5,-40(s0)
    80008dce:	0007871b          	sext.w	a4,a5
    80008dd2:	07300793          	li	a5,115
    80008dd6:	0ee7cc63          	blt	a5,a4,80008ece <printf+0x1ee>
    80008dda:	fd842783          	lw	a5,-40(s0)
    80008dde:	0007871b          	sext.w	a4,a5
    80008de2:	07000793          	li	a5,112
    80008de6:	06f70863          	beq	a4,a5,80008e56 <printf+0x176>
    80008dea:	fd842783          	lw	a5,-40(s0)
    80008dee:	0007871b          	sext.w	a4,a5
    80008df2:	07000793          	li	a5,112
    80008df6:	0ce7cc63          	blt	a5,a4,80008ece <printf+0x1ee>
    80008dfa:	fd842783          	lw	a5,-40(s0)
    80008dfe:	0007871b          	sext.w	a4,a5
    80008e02:	02500793          	li	a5,37
    80008e06:	0af70d63          	beq	a4,a5,80008ec0 <printf+0x1e0>
    80008e0a:	fd842783          	lw	a5,-40(s0)
    80008e0e:	0007871b          	sext.w	a4,a5
    80008e12:	06400793          	li	a5,100
    80008e16:	0af71c63          	bne	a4,a5,80008ece <printf+0x1ee>
    case 'd':
      printint(va_arg(ap, int), 10, 1);
    80008e1a:	fd043783          	ld	a5,-48(s0)
    80008e1e:	00878713          	addi	a4,a5,8
    80008e22:	fce43823          	sd	a4,-48(s0)
    80008e26:	439c                	lw	a5,0(a5)
    80008e28:	4605                	li	a2,1
    80008e2a:	45a9                	li	a1,10
    80008e2c:	853e                	mv	a0,a5
    80008e2e:	00000097          	auipc	ra,0x0
    80008e32:	d38080e7          	jalr	-712(ra) # 80008b66 <printint>
      break;
    80008e36:	a855                	j	80008eea <printf+0x20a>
    case 'x':
      printint(va_arg(ap, int), 16, 1);
    80008e38:	fd043783          	ld	a5,-48(s0)
    80008e3c:	00878713          	addi	a4,a5,8
    80008e40:	fce43823          	sd	a4,-48(s0)
    80008e44:	439c                	lw	a5,0(a5)
    80008e46:	4605                	li	a2,1
    80008e48:	45c1                	li	a1,16
    80008e4a:	853e                	mv	a0,a5
    80008e4c:	00000097          	auipc	ra,0x0
    80008e50:	d1a080e7          	jalr	-742(ra) # 80008b66 <printint>
      break;
    80008e54:	a859                	j	80008eea <printf+0x20a>
    case 'p':
      printptr(va_arg(ap, uint64));
    80008e56:	fd043783          	ld	a5,-48(s0)
    80008e5a:	00878713          	addi	a4,a5,8
    80008e5e:	fce43823          	sd	a4,-48(s0)
    80008e62:	639c                	ld	a5,0(a5)
    80008e64:	853e                	mv	a0,a5
    80008e66:	00000097          	auipc	ra,0x0
    80008e6a:	e04080e7          	jalr	-508(ra) # 80008c6a <printptr>
      break;
    80008e6e:	a8b5                	j	80008eea <printf+0x20a>
    case 's':
      if((s = va_arg(ap, char*)) == 0)
    80008e70:	fd043783          	ld	a5,-48(s0)
    80008e74:	00878713          	addi	a4,a5,8
    80008e78:	fce43823          	sd	a4,-48(s0)
    80008e7c:	639c                	ld	a5,0(a5)
    80008e7e:	fef43023          	sd	a5,-32(s0)
    80008e82:	fe043783          	ld	a5,-32(s0)
    80008e86:	e79d                	bnez	a5,80008eb4 <printf+0x1d4>
        s = "(null)";
    80008e88:	00003797          	auipc	a5,0x3
    80008e8c:	94878793          	addi	a5,a5,-1720 # 8000b7d0 <etext+0x7d0>
    80008e90:	fef43023          	sd	a5,-32(s0)
      for(; *s; s++)
    80008e94:	a005                	j	80008eb4 <printf+0x1d4>
        consputc(*s);
    80008e96:	fe043783          	ld	a5,-32(s0)
    80008e9a:	0007c783          	lbu	a5,0(a5)
    80008e9e:	2781                	sext.w	a5,a5
    80008ea0:	853e                	mv	a0,a5
    80008ea2:	fffff097          	auipc	ra,0xfffff
    80008ea6:	77e080e7          	jalr	1918(ra) # 80008620 <consputc>
      for(; *s; s++)
    80008eaa:	fe043783          	ld	a5,-32(s0)
    80008eae:	0785                	addi	a5,a5,1
    80008eb0:	fef43023          	sd	a5,-32(s0)
    80008eb4:	fe043783          	ld	a5,-32(s0)
    80008eb8:	0007c783          	lbu	a5,0(a5)
    80008ebc:	ffe9                	bnez	a5,80008e96 <printf+0x1b6>
      break;
    80008ebe:	a035                	j	80008eea <printf+0x20a>
    case '%':
      consputc('%');
    80008ec0:	02500513          	li	a0,37
    80008ec4:	fffff097          	auipc	ra,0xfffff
    80008ec8:	75c080e7          	jalr	1884(ra) # 80008620 <consputc>
      break;
    80008ecc:	a839                	j	80008eea <printf+0x20a>
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
    80008ece:	02500513          	li	a0,37
    80008ed2:	fffff097          	auipc	ra,0xfffff
    80008ed6:	74e080e7          	jalr	1870(ra) # 80008620 <consputc>
      consputc(c);
    80008eda:	fd842783          	lw	a5,-40(s0)
    80008ede:	853e                	mv	a0,a5
    80008ee0:	fffff097          	auipc	ra,0xfffff
    80008ee4:	740080e7          	jalr	1856(ra) # 80008620 <consputc>
      break;
    80008ee8:	0001                	nop
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80008eea:	fec42783          	lw	a5,-20(s0)
    80008eee:	2785                	addiw	a5,a5,1
    80008ef0:	fef42623          	sw	a5,-20(s0)
    80008ef4:	fec42783          	lw	a5,-20(s0)
    80008ef8:	fc843703          	ld	a4,-56(s0)
    80008efc:	97ba                	add	a5,a5,a4
    80008efe:	0007c783          	lbu	a5,0(a5)
    80008f02:	fcf42c23          	sw	a5,-40(s0)
    80008f06:	fd842783          	lw	a5,-40(s0)
    80008f0a:	2781                	sext.w	a5,a5
    80008f0c:	e40794e3          	bnez	a5,80008d54 <printf+0x74>
    80008f10:	a011                	j	80008f14 <printf+0x234>
      break;
    80008f12:	0001                	nop
    }
  }
  va_end(ap);

  if(locking)
    80008f14:	fdc42783          	lw	a5,-36(s0)
    80008f18:	2781                	sext.w	a5,a5
    80008f1a:	cb89                	beqz	a5,80008f2c <printf+0x24c>
    release(&pr.lock);
    80008f1c:	0001c517          	auipc	a0,0x1c
    80008f20:	17c50513          	addi	a0,a0,380 # 80025098 <pr>
    80008f24:	00000097          	auipc	ra,0x0
    80008f28:	4be080e7          	jalr	1214(ra) # 800093e2 <release>
}
    80008f2c:	0001                	nop
    80008f2e:	70e2                	ld	ra,56(sp)
    80008f30:	7442                	ld	s0,48(sp)
    80008f32:	6109                	addi	sp,sp,128
    80008f34:	8082                	ret

0000000080008f36 <panic>:

void
panic(char *s)
{
    80008f36:	1101                	addi	sp,sp,-32
    80008f38:	ec06                	sd	ra,24(sp)
    80008f3a:	e822                	sd	s0,16(sp)
    80008f3c:	1000                	addi	s0,sp,32
    80008f3e:	fea43423          	sd	a0,-24(s0)
  pr.locking = 0;
    80008f42:	0001c797          	auipc	a5,0x1c
    80008f46:	15678793          	addi	a5,a5,342 # 80025098 <pr>
    80008f4a:	0007ac23          	sw	zero,24(a5)
  printf("panic: ");
    80008f4e:	00003517          	auipc	a0,0x3
    80008f52:	88a50513          	addi	a0,a0,-1910 # 8000b7d8 <etext+0x7d8>
    80008f56:	00000097          	auipc	ra,0x0
    80008f5a:	d8a080e7          	jalr	-630(ra) # 80008ce0 <printf>
  printf(s);
    80008f5e:	fe843503          	ld	a0,-24(s0)
    80008f62:	00000097          	auipc	ra,0x0
    80008f66:	d7e080e7          	jalr	-642(ra) # 80008ce0 <printf>
  printf("\n");
    80008f6a:	00003517          	auipc	a0,0x3
    80008f6e:	87650513          	addi	a0,a0,-1930 # 8000b7e0 <etext+0x7e0>
    80008f72:	00000097          	auipc	ra,0x0
    80008f76:	d6e080e7          	jalr	-658(ra) # 80008ce0 <printf>
  panicked = 1; // freeze uart output from other CPUs
    80008f7a:	00003797          	auipc	a5,0x3
    80008f7e:	ada78793          	addi	a5,a5,-1318 # 8000ba54 <panicked>
    80008f82:	4705                	li	a4,1
    80008f84:	c398                	sw	a4,0(a5)
  for(;;)
    80008f86:	0001                	nop
    80008f88:	bffd                	j	80008f86 <panic+0x50>

0000000080008f8a <printfinit>:
    ;
}

void
printfinit(void)
{
    80008f8a:	1141                	addi	sp,sp,-16
    80008f8c:	e406                	sd	ra,8(sp)
    80008f8e:	e022                	sd	s0,0(sp)
    80008f90:	0800                	addi	s0,sp,16
  initlock(&pr.lock, "pr");
    80008f92:	00003597          	auipc	a1,0x3
    80008f96:	85658593          	addi	a1,a1,-1962 # 8000b7e8 <etext+0x7e8>
    80008f9a:	0001c517          	auipc	a0,0x1c
    80008f9e:	0fe50513          	addi	a0,a0,254 # 80025098 <pr>
    80008fa2:	00000097          	auipc	ra,0x0
    80008fa6:	3ac080e7          	jalr	940(ra) # 8000934e <initlock>
  pr.locking = 1;
    80008faa:	0001c797          	auipc	a5,0x1c
    80008fae:	0ee78793          	addi	a5,a5,238 # 80025098 <pr>
    80008fb2:	4705                	li	a4,1
    80008fb4:	cf98                	sw	a4,24(a5)
}
    80008fb6:	0001                	nop
    80008fb8:	60a2                	ld	ra,8(sp)
    80008fba:	6402                	ld	s0,0(sp)
    80008fbc:	0141                	addi	sp,sp,16
    80008fbe:	8082                	ret

0000000080008fc0 <uartinit>:

void uartstart();

void
uartinit(void)
{
    80008fc0:	1141                	addi	sp,sp,-16
    80008fc2:	e406                	sd	ra,8(sp)
    80008fc4:	e022                	sd	s0,0(sp)
    80008fc6:	0800                	addi	s0,sp,16
  // disable interrupts.
  WriteReg(IER, 0x00);
    80008fc8:	100007b7          	lui	a5,0x10000
    80008fcc:	0785                	addi	a5,a5,1 # 10000001 <_entry-0x6fffffff>
    80008fce:	00078023          	sb	zero,0(a5)

  // special mode to set baud rate.
  WriteReg(LCR, LCR_BAUD_LATCH);
    80008fd2:	100007b7          	lui	a5,0x10000
    80008fd6:	078d                	addi	a5,a5,3 # 10000003 <_entry-0x6ffffffd>
    80008fd8:	f8000713          	li	a4,-128
    80008fdc:	00e78023          	sb	a4,0(a5)

  // LSB for baud rate of 38.4K.
  WriteReg(0, 0x03);
    80008fe0:	100007b7          	lui	a5,0x10000
    80008fe4:	470d                	li	a4,3
    80008fe6:	00e78023          	sb	a4,0(a5) # 10000000 <_entry-0x70000000>

  // MSB for baud rate of 38.4K.
  WriteReg(1, 0x00);
    80008fea:	100007b7          	lui	a5,0x10000
    80008fee:	0785                	addi	a5,a5,1 # 10000001 <_entry-0x6fffffff>
    80008ff0:	00078023          	sb	zero,0(a5)

  // leave set-baud mode,
  // and set word length to 8 bits, no parity.
  WriteReg(LCR, LCR_EIGHT_BITS);
    80008ff4:	100007b7          	lui	a5,0x10000
    80008ff8:	078d                	addi	a5,a5,3 # 10000003 <_entry-0x6ffffffd>
    80008ffa:	470d                	li	a4,3
    80008ffc:	00e78023          	sb	a4,0(a5)

  // reset and enable FIFOs.
  WriteReg(FCR, FCR_FIFO_ENABLE | FCR_FIFO_CLEAR);
    80009000:	100007b7          	lui	a5,0x10000
    80009004:	0789                	addi	a5,a5,2 # 10000002 <_entry-0x6ffffffe>
    80009006:	471d                	li	a4,7
    80009008:	00e78023          	sb	a4,0(a5)

  // enable transmit and receive interrupts.
  WriteReg(IER, IER_TX_ENABLE | IER_RX_ENABLE);
    8000900c:	100007b7          	lui	a5,0x10000
    80009010:	0785                	addi	a5,a5,1 # 10000001 <_entry-0x6fffffff>
    80009012:	470d                	li	a4,3
    80009014:	00e78023          	sb	a4,0(a5)

  initlock(&uart_tx_lock, "uart");
    80009018:	00002597          	auipc	a1,0x2
    8000901c:	7d858593          	addi	a1,a1,2008 # 8000b7f0 <etext+0x7f0>
    80009020:	0001c517          	auipc	a0,0x1c
    80009024:	09850513          	addi	a0,a0,152 # 800250b8 <uart_tx_lock>
    80009028:	00000097          	auipc	ra,0x0
    8000902c:	326080e7          	jalr	806(ra) # 8000934e <initlock>
}
    80009030:	0001                	nop
    80009032:	60a2                	ld	ra,8(sp)
    80009034:	6402                	ld	s0,0(sp)
    80009036:	0141                	addi	sp,sp,16
    80009038:	8082                	ret

000000008000903a <uartputc>:
// because it may block, it can't be called
// from interrupts; it's only suitable for use
// by write().
void
uartputc(int c)
{
    8000903a:	1101                	addi	sp,sp,-32
    8000903c:	ec06                	sd	ra,24(sp)
    8000903e:	e822                	sd	s0,16(sp)
    80009040:	1000                	addi	s0,sp,32
    80009042:	87aa                	mv	a5,a0
    80009044:	fef42623          	sw	a5,-20(s0)
  acquire(&uart_tx_lock);
    80009048:	0001c517          	auipc	a0,0x1c
    8000904c:	07050513          	addi	a0,a0,112 # 800250b8 <uart_tx_lock>
    80009050:	00000097          	auipc	ra,0x0
    80009054:	32e080e7          	jalr	814(ra) # 8000937e <acquire>

  if(panicked){
    80009058:	00003797          	auipc	a5,0x3
    8000905c:	9fc78793          	addi	a5,a5,-1540 # 8000ba54 <panicked>
    80009060:	439c                	lw	a5,0(a5)
    80009062:	2781                	sext.w	a5,a5
    80009064:	cf99                	beqz	a5,80009082 <uartputc+0x48>
    for(;;)
    80009066:	0001                	nop
    80009068:	bffd                	j	80009066 <uartputc+0x2c>
      ;
  }
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    // buffer is full.
    // wait for uartstart() to open up space in the buffer.
    sleep(&uart_tx_r, &uart_tx_lock);
    8000906a:	0001c597          	auipc	a1,0x1c
    8000906e:	04e58593          	addi	a1,a1,78 # 800250b8 <uart_tx_lock>
    80009072:	00003517          	auipc	a0,0x3
    80009076:	9ee50513          	addi	a0,a0,-1554 # 8000ba60 <uart_tx_r>
    8000907a:	ffff9097          	auipc	ra,0xffff9
    8000907e:	160080e7          	jalr	352(ra) # 800021da <sleep>
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    80009082:	00003797          	auipc	a5,0x3
    80009086:	9de78793          	addi	a5,a5,-1570 # 8000ba60 <uart_tx_r>
    8000908a:	639c                	ld	a5,0(a5)
    8000908c:	02078713          	addi	a4,a5,32
    80009090:	00003797          	auipc	a5,0x3
    80009094:	9c878793          	addi	a5,a5,-1592 # 8000ba58 <uart_tx_w>
    80009098:	639c                	ld	a5,0(a5)
    8000909a:	fcf708e3          	beq	a4,a5,8000906a <uartputc+0x30>
  }
  uart_tx_buf[uart_tx_w % UART_TX_BUF_SIZE] = c;
    8000909e:	00003797          	auipc	a5,0x3
    800090a2:	9ba78793          	addi	a5,a5,-1606 # 8000ba58 <uart_tx_w>
    800090a6:	639c                	ld	a5,0(a5)
    800090a8:	8bfd                	andi	a5,a5,31
    800090aa:	fec42703          	lw	a4,-20(s0)
    800090ae:	0ff77713          	zext.b	a4,a4
    800090b2:	0001c697          	auipc	a3,0x1c
    800090b6:	01e68693          	addi	a3,a3,30 # 800250d0 <uart_tx_buf>
    800090ba:	97b6                	add	a5,a5,a3
    800090bc:	00e78023          	sb	a4,0(a5)
  uart_tx_w += 1;
    800090c0:	00003797          	auipc	a5,0x3
    800090c4:	99878793          	addi	a5,a5,-1640 # 8000ba58 <uart_tx_w>
    800090c8:	639c                	ld	a5,0(a5)
    800090ca:	00178713          	addi	a4,a5,1
    800090ce:	00003797          	auipc	a5,0x3
    800090d2:	98a78793          	addi	a5,a5,-1654 # 8000ba58 <uart_tx_w>
    800090d6:	e398                	sd	a4,0(a5)
  uartstart();
    800090d8:	00000097          	auipc	ra,0x0
    800090dc:	086080e7          	jalr	134(ra) # 8000915e <uartstart>
  release(&uart_tx_lock);
    800090e0:	0001c517          	auipc	a0,0x1c
    800090e4:	fd850513          	addi	a0,a0,-40 # 800250b8 <uart_tx_lock>
    800090e8:	00000097          	auipc	ra,0x0
    800090ec:	2fa080e7          	jalr	762(ra) # 800093e2 <release>
}
    800090f0:	0001                	nop
    800090f2:	60e2                	ld	ra,24(sp)
    800090f4:	6442                	ld	s0,16(sp)
    800090f6:	6105                	addi	sp,sp,32
    800090f8:	8082                	ret

00000000800090fa <uartputc_sync>:
// use interrupts, for use by kernel printf() and
// to echo characters. it spins waiting for the uart's
// output register to be empty.
void
uartputc_sync(int c)
{
    800090fa:	1101                	addi	sp,sp,-32
    800090fc:	ec06                	sd	ra,24(sp)
    800090fe:	e822                	sd	s0,16(sp)
    80009100:	1000                	addi	s0,sp,32
    80009102:	87aa                	mv	a5,a0
    80009104:	fef42623          	sw	a5,-20(s0)
  push_off();
    80009108:	00000097          	auipc	ra,0x0
    8000910c:	374080e7          	jalr	884(ra) # 8000947c <push_off>

  if(panicked){
    80009110:	00003797          	auipc	a5,0x3
    80009114:	94478793          	addi	a5,a5,-1724 # 8000ba54 <panicked>
    80009118:	439c                	lw	a5,0(a5)
    8000911a:	2781                	sext.w	a5,a5
    8000911c:	c399                	beqz	a5,80009122 <uartputc_sync+0x28>
    for(;;)
    8000911e:	0001                	nop
    80009120:	bffd                	j	8000911e <uartputc_sync+0x24>
      ;
  }

  // wait for Transmit Holding Empty to be set in LSR.
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    80009122:	0001                	nop
    80009124:	100007b7          	lui	a5,0x10000
    80009128:	0795                	addi	a5,a5,5 # 10000005 <_entry-0x6ffffffb>
    8000912a:	0007c783          	lbu	a5,0(a5)
    8000912e:	0ff7f793          	zext.b	a5,a5
    80009132:	2781                	sext.w	a5,a5
    80009134:	0207f793          	andi	a5,a5,32
    80009138:	2781                	sext.w	a5,a5
    8000913a:	d7ed                	beqz	a5,80009124 <uartputc_sync+0x2a>
    ;
  WriteReg(THR, c);
    8000913c:	100007b7          	lui	a5,0x10000
    80009140:	fec42703          	lw	a4,-20(s0)
    80009144:	0ff77713          	zext.b	a4,a4
    80009148:	00e78023          	sb	a4,0(a5) # 10000000 <_entry-0x70000000>

  pop_off();
    8000914c:	00000097          	auipc	ra,0x0
    80009150:	388080e7          	jalr	904(ra) # 800094d4 <pop_off>
}
    80009154:	0001                	nop
    80009156:	60e2                	ld	ra,24(sp)
    80009158:	6442                	ld	s0,16(sp)
    8000915a:	6105                	addi	sp,sp,32
    8000915c:	8082                	ret

000000008000915e <uartstart>:
// in the transmit buffer, send it.
// caller must hold uart_tx_lock.
// called from both the top- and bottom-half.
void
uartstart()
{
    8000915e:	1101                	addi	sp,sp,-32
    80009160:	ec06                	sd	ra,24(sp)
    80009162:	e822                	sd	s0,16(sp)
    80009164:	1000                	addi	s0,sp,32
  while(1){
    if(uart_tx_w == uart_tx_r){
    80009166:	00003797          	auipc	a5,0x3
    8000916a:	8f278793          	addi	a5,a5,-1806 # 8000ba58 <uart_tx_w>
    8000916e:	6398                	ld	a4,0(a5)
    80009170:	00003797          	auipc	a5,0x3
    80009174:	8f078793          	addi	a5,a5,-1808 # 8000ba60 <uart_tx_r>
    80009178:	639c                	ld	a5,0(a5)
    8000917a:	06f70a63          	beq	a4,a5,800091ee <uartstart+0x90>
      // transmit buffer is empty.
      return;
    }
    
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    8000917e:	100007b7          	lui	a5,0x10000
    80009182:	0795                	addi	a5,a5,5 # 10000005 <_entry-0x6ffffffb>
    80009184:	0007c783          	lbu	a5,0(a5)
    80009188:	0ff7f793          	zext.b	a5,a5
    8000918c:	2781                	sext.w	a5,a5
    8000918e:	0207f793          	andi	a5,a5,32
    80009192:	2781                	sext.w	a5,a5
    80009194:	cfb9                	beqz	a5,800091f2 <uartstart+0x94>
      // so we cannot give it another byte.
      // it will interrupt when it's ready for a new byte.
      return;
    }
    
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    80009196:	00003797          	auipc	a5,0x3
    8000919a:	8ca78793          	addi	a5,a5,-1846 # 8000ba60 <uart_tx_r>
    8000919e:	639c                	ld	a5,0(a5)
    800091a0:	8bfd                	andi	a5,a5,31
    800091a2:	0001c717          	auipc	a4,0x1c
    800091a6:	f2e70713          	addi	a4,a4,-210 # 800250d0 <uart_tx_buf>
    800091aa:	97ba                	add	a5,a5,a4
    800091ac:	0007c783          	lbu	a5,0(a5)
    800091b0:	fef42623          	sw	a5,-20(s0)
    uart_tx_r += 1;
    800091b4:	00003797          	auipc	a5,0x3
    800091b8:	8ac78793          	addi	a5,a5,-1876 # 8000ba60 <uart_tx_r>
    800091bc:	639c                	ld	a5,0(a5)
    800091be:	00178713          	addi	a4,a5,1
    800091c2:	00003797          	auipc	a5,0x3
    800091c6:	89e78793          	addi	a5,a5,-1890 # 8000ba60 <uart_tx_r>
    800091ca:	e398                	sd	a4,0(a5)
    
    // maybe uartputc() is waiting for space in the buffer.
    wakeup(&uart_tx_r);
    800091cc:	00003517          	auipc	a0,0x3
    800091d0:	89450513          	addi	a0,a0,-1900 # 8000ba60 <uart_tx_r>
    800091d4:	ffff9097          	auipc	ra,0xffff9
    800091d8:	082080e7          	jalr	130(ra) # 80002256 <wakeup>
    
    WriteReg(THR, c);
    800091dc:	100007b7          	lui	a5,0x10000
    800091e0:	fec42703          	lw	a4,-20(s0)
    800091e4:	0ff77713          	zext.b	a4,a4
    800091e8:	00e78023          	sb	a4,0(a5) # 10000000 <_entry-0x70000000>
  while(1){
    800091ec:	bfad                	j	80009166 <uartstart+0x8>
      return;
    800091ee:	0001                	nop
    800091f0:	a011                	j	800091f4 <uartstart+0x96>
      return;
    800091f2:	0001                	nop
  }
}
    800091f4:	60e2                	ld	ra,24(sp)
    800091f6:	6442                	ld	s0,16(sp)
    800091f8:	6105                	addi	sp,sp,32
    800091fa:	8082                	ret

00000000800091fc <uartgetc>:

// read one input character from the UART.
// return -1 if none is waiting.
int
uartgetc(void)
{
    800091fc:	1141                	addi	sp,sp,-16
    800091fe:	e422                	sd	s0,8(sp)
    80009200:	0800                	addi	s0,sp,16
  if(ReadReg(LSR) & 0x01){
    80009202:	100007b7          	lui	a5,0x10000
    80009206:	0795                	addi	a5,a5,5 # 10000005 <_entry-0x6ffffffb>
    80009208:	0007c783          	lbu	a5,0(a5)
    8000920c:	0ff7f793          	zext.b	a5,a5
    80009210:	2781                	sext.w	a5,a5
    80009212:	8b85                	andi	a5,a5,1
    80009214:	2781                	sext.w	a5,a5
    80009216:	cb89                	beqz	a5,80009228 <uartgetc+0x2c>
    // input data is ready.
    return ReadReg(RHR);
    80009218:	100007b7          	lui	a5,0x10000
    8000921c:	0007c783          	lbu	a5,0(a5) # 10000000 <_entry-0x70000000>
    80009220:	0ff7f793          	zext.b	a5,a5
    80009224:	2781                	sext.w	a5,a5
    80009226:	a011                	j	8000922a <uartgetc+0x2e>
  } else {
    return -1;
    80009228:	57fd                	li	a5,-1
  }
}
    8000922a:	853e                	mv	a0,a5
    8000922c:	6422                	ld	s0,8(sp)
    8000922e:	0141                	addi	sp,sp,16
    80009230:	8082                	ret

0000000080009232 <uartintr>:
// handle a uart interrupt, raised because input has
// arrived, or the uart is ready for more output, or
// both. called from devintr().
void
uartintr(void)
{
    80009232:	1101                	addi	sp,sp,-32
    80009234:	ec06                	sd	ra,24(sp)
    80009236:	e822                	sd	s0,16(sp)
    80009238:	1000                	addi	s0,sp,32
  // read and process incoming characters.
  while(1){
    int c = uartgetc();
    8000923a:	00000097          	auipc	ra,0x0
    8000923e:	fc2080e7          	jalr	-62(ra) # 800091fc <uartgetc>
    80009242:	87aa                	mv	a5,a0
    80009244:	fef42623          	sw	a5,-20(s0)
    if(c == -1)
    80009248:	fec42783          	lw	a5,-20(s0)
    8000924c:	0007871b          	sext.w	a4,a5
    80009250:	57fd                	li	a5,-1
    80009252:	00f70a63          	beq	a4,a5,80009266 <uartintr+0x34>
      break;
    consoleintr(c);
    80009256:	fec42783          	lw	a5,-20(s0)
    8000925a:	853e                	mv	a0,a5
    8000925c:	fffff097          	auipc	ra,0xfffff
    80009260:	646080e7          	jalr	1606(ra) # 800088a2 <consoleintr>
  while(1){
    80009264:	bfd9                	j	8000923a <uartintr+0x8>
      break;
    80009266:	0001                	nop
  }

  // send buffered characters.
  acquire(&uart_tx_lock);
    80009268:	0001c517          	auipc	a0,0x1c
    8000926c:	e5050513          	addi	a0,a0,-432 # 800250b8 <uart_tx_lock>
    80009270:	00000097          	auipc	ra,0x0
    80009274:	10e080e7          	jalr	270(ra) # 8000937e <acquire>
  uartstart();
    80009278:	00000097          	auipc	ra,0x0
    8000927c:	ee6080e7          	jalr	-282(ra) # 8000915e <uartstart>
  release(&uart_tx_lock);
    80009280:	0001c517          	auipc	a0,0x1c
    80009284:	e3850513          	addi	a0,a0,-456 # 800250b8 <uart_tx_lock>
    80009288:	00000097          	auipc	ra,0x0
    8000928c:	15a080e7          	jalr	346(ra) # 800093e2 <release>
}
    80009290:	0001                	nop
    80009292:	60e2                	ld	ra,24(sp)
    80009294:	6442                	ld	s0,16(sp)
    80009296:	6105                	addi	sp,sp,32
    80009298:	8082                	ret

000000008000929a <r_sstatus>:
{
    8000929a:	1101                	addi	sp,sp,-32
    8000929c:	ec22                	sd	s0,24(sp)
    8000929e:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800092a0:	100027f3          	csrr	a5,sstatus
    800092a4:	fef43423          	sd	a5,-24(s0)
  return x;
    800092a8:	fe843783          	ld	a5,-24(s0)
}
    800092ac:	853e                	mv	a0,a5
    800092ae:	6462                	ld	s0,24(sp)
    800092b0:	6105                	addi	sp,sp,32
    800092b2:	8082                	ret

00000000800092b4 <w_sstatus>:
{
    800092b4:	1101                	addi	sp,sp,-32
    800092b6:	ec22                	sd	s0,24(sp)
    800092b8:	1000                	addi	s0,sp,32
    800092ba:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800092be:	fe843783          	ld	a5,-24(s0)
    800092c2:	10079073          	csrw	sstatus,a5
}
    800092c6:	0001                	nop
    800092c8:	6462                	ld	s0,24(sp)
    800092ca:	6105                	addi	sp,sp,32
    800092cc:	8082                	ret

00000000800092ce <intr_on>:
{
    800092ce:	1141                	addi	sp,sp,-16
    800092d0:	e406                	sd	ra,8(sp)
    800092d2:	e022                	sd	s0,0(sp)
    800092d4:	0800                	addi	s0,sp,16
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    800092d6:	00000097          	auipc	ra,0x0
    800092da:	fc4080e7          	jalr	-60(ra) # 8000929a <r_sstatus>
    800092de:	87aa                	mv	a5,a0
    800092e0:	0027e793          	ori	a5,a5,2
    800092e4:	853e                	mv	a0,a5
    800092e6:	00000097          	auipc	ra,0x0
    800092ea:	fce080e7          	jalr	-50(ra) # 800092b4 <w_sstatus>
}
    800092ee:	0001                	nop
    800092f0:	60a2                	ld	ra,8(sp)
    800092f2:	6402                	ld	s0,0(sp)
    800092f4:	0141                	addi	sp,sp,16
    800092f6:	8082                	ret

00000000800092f8 <intr_off>:
{
    800092f8:	1141                	addi	sp,sp,-16
    800092fa:	e406                	sd	ra,8(sp)
    800092fc:	e022                	sd	s0,0(sp)
    800092fe:	0800                	addi	s0,sp,16
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80009300:	00000097          	auipc	ra,0x0
    80009304:	f9a080e7          	jalr	-102(ra) # 8000929a <r_sstatus>
    80009308:	87aa                	mv	a5,a0
    8000930a:	9bf5                	andi	a5,a5,-3
    8000930c:	853e                	mv	a0,a5
    8000930e:	00000097          	auipc	ra,0x0
    80009312:	fa6080e7          	jalr	-90(ra) # 800092b4 <w_sstatus>
}
    80009316:	0001                	nop
    80009318:	60a2                	ld	ra,8(sp)
    8000931a:	6402                	ld	s0,0(sp)
    8000931c:	0141                	addi	sp,sp,16
    8000931e:	8082                	ret

0000000080009320 <intr_get>:
{
    80009320:	1101                	addi	sp,sp,-32
    80009322:	ec06                	sd	ra,24(sp)
    80009324:	e822                	sd	s0,16(sp)
    80009326:	1000                	addi	s0,sp,32
  uint64 x = r_sstatus();
    80009328:	00000097          	auipc	ra,0x0
    8000932c:	f72080e7          	jalr	-142(ra) # 8000929a <r_sstatus>
    80009330:	fea43423          	sd	a0,-24(s0)
  return (x & SSTATUS_SIE) != 0;
    80009334:	fe843783          	ld	a5,-24(s0)
    80009338:	8b89                	andi	a5,a5,2
    8000933a:	00f037b3          	snez	a5,a5
    8000933e:	0ff7f793          	zext.b	a5,a5
    80009342:	2781                	sext.w	a5,a5
}
    80009344:	853e                	mv	a0,a5
    80009346:	60e2                	ld	ra,24(sp)
    80009348:	6442                	ld	s0,16(sp)
    8000934a:	6105                	addi	sp,sp,32
    8000934c:	8082                	ret

000000008000934e <initlock>:
#include "proc.h"
#include "defs.h"

void
initlock(struct spinlock *lk, char *name)
{
    8000934e:	1101                	addi	sp,sp,-32
    80009350:	ec22                	sd	s0,24(sp)
    80009352:	1000                	addi	s0,sp,32
    80009354:	fea43423          	sd	a0,-24(s0)
    80009358:	feb43023          	sd	a1,-32(s0)
  lk->name = name;
    8000935c:	fe843783          	ld	a5,-24(s0)
    80009360:	fe043703          	ld	a4,-32(s0)
    80009364:	e798                	sd	a4,8(a5)
  lk->locked = 0;
    80009366:	fe843783          	ld	a5,-24(s0)
    8000936a:	0007a023          	sw	zero,0(a5)
  lk->cpu = 0;
    8000936e:	fe843783          	ld	a5,-24(s0)
    80009372:	0007b823          	sd	zero,16(a5)
}
    80009376:	0001                	nop
    80009378:	6462                	ld	s0,24(sp)
    8000937a:	6105                	addi	sp,sp,32
    8000937c:	8082                	ret

000000008000937e <acquire>:

// Acquire the lock.
// Loops (spins) until the lock is acquired.
void
acquire(struct spinlock *lk)
{
    8000937e:	1101                	addi	sp,sp,-32
    80009380:	ec06                	sd	ra,24(sp)
    80009382:	e822                	sd	s0,16(sp)
    80009384:	1000                	addi	s0,sp,32
    80009386:	fea43423          	sd	a0,-24(s0)
  push_off(); // disable interrupts to avoid deadlock.
    8000938a:	00000097          	auipc	ra,0x0
    8000938e:	0f2080e7          	jalr	242(ra) # 8000947c <push_off>
  if(holding(lk))
    80009392:	fe843503          	ld	a0,-24(s0)
    80009396:	00000097          	auipc	ra,0x0
    8000939a:	0a2080e7          	jalr	162(ra) # 80009438 <holding>
    8000939e:	87aa                	mv	a5,a0
    800093a0:	cb89                	beqz	a5,800093b2 <acquire+0x34>
    panic("acquire");
    800093a2:	00002517          	auipc	a0,0x2
    800093a6:	45650513          	addi	a0,a0,1110 # 8000b7f8 <etext+0x7f8>
    800093aa:	00000097          	auipc	ra,0x0
    800093ae:	b8c080e7          	jalr	-1140(ra) # 80008f36 <panic>

  // On RISC-V, sync_lock_test_and_set turns into an atomic swap:
  //   a5 = 1
  //   s1 = &lk->locked
  //   amoswap.w.aq a5, a5, (s1)
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    800093b2:	0001                	nop
    800093b4:	fe843783          	ld	a5,-24(s0)
    800093b8:	4705                	li	a4,1
    800093ba:	0ce7a72f          	amoswap.w.aq	a4,a4,(a5)
    800093be:	0007079b          	sext.w	a5,a4
    800093c2:	fbed                	bnez	a5,800093b4 <acquire+0x36>

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen strictly after the lock is acquired.
  // On RISC-V, this emits a fence instruction.
  __sync_synchronize();
    800093c4:	0ff0000f          	fence

  // Record info about lock acquisition for holding() and debugging.
  lk->cpu = mycpu();
    800093c8:	ffff8097          	auipc	ra,0xffff8
    800093cc:	1fe080e7          	jalr	510(ra) # 800015c6 <mycpu>
    800093d0:	872a                	mv	a4,a0
    800093d2:	fe843783          	ld	a5,-24(s0)
    800093d6:	eb98                	sd	a4,16(a5)
}
    800093d8:	0001                	nop
    800093da:	60e2                	ld	ra,24(sp)
    800093dc:	6442                	ld	s0,16(sp)
    800093de:	6105                	addi	sp,sp,32
    800093e0:	8082                	ret

00000000800093e2 <release>:

// Release the lock.
void
release(struct spinlock *lk)
{
    800093e2:	1101                	addi	sp,sp,-32
    800093e4:	ec06                	sd	ra,24(sp)
    800093e6:	e822                	sd	s0,16(sp)
    800093e8:	1000                	addi	s0,sp,32
    800093ea:	fea43423          	sd	a0,-24(s0)
  if(!holding(lk))
    800093ee:	fe843503          	ld	a0,-24(s0)
    800093f2:	00000097          	auipc	ra,0x0
    800093f6:	046080e7          	jalr	70(ra) # 80009438 <holding>
    800093fa:	87aa                	mv	a5,a0
    800093fc:	eb89                	bnez	a5,8000940e <release+0x2c>
    panic("release");
    800093fe:	00002517          	auipc	a0,0x2
    80009402:	40250513          	addi	a0,a0,1026 # 8000b800 <etext+0x800>
    80009406:	00000097          	auipc	ra,0x0
    8000940a:	b30080e7          	jalr	-1232(ra) # 80008f36 <panic>

  lk->cpu = 0;
    8000940e:	fe843783          	ld	a5,-24(s0)
    80009412:	0007b823          	sd	zero,16(a5)
  // past this point, to ensure that all the stores in the critical
  // section are visible to other CPUs before the lock is released,
  // and that loads in the critical section occur strictly before
  // the lock is released.
  // On RISC-V, this emits a fence instruction.
  __sync_synchronize();
    80009416:	0ff0000f          	fence
  // implies that an assignment might be implemented with
  // multiple store instructions.
  // On RISC-V, sync_lock_release turns into an atomic swap:
  //   s1 = &lk->locked
  //   amoswap.w zero, zero, (s1)
  __sync_lock_release(&lk->locked);
    8000941a:	fe843783          	ld	a5,-24(s0)
    8000941e:	0f50000f          	fence	iorw,ow
    80009422:	0807a02f          	amoswap.w	zero,zero,(a5)

  pop_off();
    80009426:	00000097          	auipc	ra,0x0
    8000942a:	0ae080e7          	jalr	174(ra) # 800094d4 <pop_off>
}
    8000942e:	0001                	nop
    80009430:	60e2                	ld	ra,24(sp)
    80009432:	6442                	ld	s0,16(sp)
    80009434:	6105                	addi	sp,sp,32
    80009436:	8082                	ret

0000000080009438 <holding>:

// Check whether this cpu is holding the lock.
// Interrupts must be off.
int
holding(struct spinlock *lk)
{
    80009438:	7139                	addi	sp,sp,-64
    8000943a:	fc06                	sd	ra,56(sp)
    8000943c:	f822                	sd	s0,48(sp)
    8000943e:	f426                	sd	s1,40(sp)
    80009440:	0080                	addi	s0,sp,64
    80009442:	fca43423          	sd	a0,-56(s0)
  int r;
  r = (lk->locked && lk->cpu == mycpu());
    80009446:	fc843783          	ld	a5,-56(s0)
    8000944a:	439c                	lw	a5,0(a5)
    8000944c:	cf89                	beqz	a5,80009466 <holding+0x2e>
    8000944e:	fc843783          	ld	a5,-56(s0)
    80009452:	6b84                	ld	s1,16(a5)
    80009454:	ffff8097          	auipc	ra,0xffff8
    80009458:	172080e7          	jalr	370(ra) # 800015c6 <mycpu>
    8000945c:	87aa                	mv	a5,a0
    8000945e:	00f49463          	bne	s1,a5,80009466 <holding+0x2e>
    80009462:	4785                	li	a5,1
    80009464:	a011                	j	80009468 <holding+0x30>
    80009466:	4781                	li	a5,0
    80009468:	fcf42e23          	sw	a5,-36(s0)
  return r;
    8000946c:	fdc42783          	lw	a5,-36(s0)
}
    80009470:	853e                	mv	a0,a5
    80009472:	70e2                	ld	ra,56(sp)
    80009474:	7442                	ld	s0,48(sp)
    80009476:	74a2                	ld	s1,40(sp)
    80009478:	6121                	addi	sp,sp,64
    8000947a:	8082                	ret

000000008000947c <push_off>:
// it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
// are initially off, then push_off, pop_off leaves them off.

void
push_off(void)
{
    8000947c:	1101                	addi	sp,sp,-32
    8000947e:	ec06                	sd	ra,24(sp)
    80009480:	e822                	sd	s0,16(sp)
    80009482:	1000                	addi	s0,sp,32
  int old = intr_get();
    80009484:	00000097          	auipc	ra,0x0
    80009488:	e9c080e7          	jalr	-356(ra) # 80009320 <intr_get>
    8000948c:	87aa                	mv	a5,a0
    8000948e:	fef42623          	sw	a5,-20(s0)

  intr_off();
    80009492:	00000097          	auipc	ra,0x0
    80009496:	e66080e7          	jalr	-410(ra) # 800092f8 <intr_off>
  if(mycpu()->noff == 0)
    8000949a:	ffff8097          	auipc	ra,0xffff8
    8000949e:	12c080e7          	jalr	300(ra) # 800015c6 <mycpu>
    800094a2:	87aa                	mv	a5,a0
    800094a4:	5fbc                	lw	a5,120(a5)
    800094a6:	eb89                	bnez	a5,800094b8 <push_off+0x3c>
    mycpu()->intena = old;
    800094a8:	ffff8097          	auipc	ra,0xffff8
    800094ac:	11e080e7          	jalr	286(ra) # 800015c6 <mycpu>
    800094b0:	872a                	mv	a4,a0
    800094b2:	fec42783          	lw	a5,-20(s0)
    800094b6:	df7c                	sw	a5,124(a4)
  mycpu()->noff += 1;
    800094b8:	ffff8097          	auipc	ra,0xffff8
    800094bc:	10e080e7          	jalr	270(ra) # 800015c6 <mycpu>
    800094c0:	87aa                	mv	a5,a0
    800094c2:	5fb8                	lw	a4,120(a5)
    800094c4:	2705                	addiw	a4,a4,1
    800094c6:	2701                	sext.w	a4,a4
    800094c8:	dfb8                	sw	a4,120(a5)
}
    800094ca:	0001                	nop
    800094cc:	60e2                	ld	ra,24(sp)
    800094ce:	6442                	ld	s0,16(sp)
    800094d0:	6105                	addi	sp,sp,32
    800094d2:	8082                	ret

00000000800094d4 <pop_off>:

void
pop_off(void)
{
    800094d4:	1101                	addi	sp,sp,-32
    800094d6:	ec06                	sd	ra,24(sp)
    800094d8:	e822                	sd	s0,16(sp)
    800094da:	1000                	addi	s0,sp,32
  struct cpu *c = mycpu();
    800094dc:	ffff8097          	auipc	ra,0xffff8
    800094e0:	0ea080e7          	jalr	234(ra) # 800015c6 <mycpu>
    800094e4:	fea43423          	sd	a0,-24(s0)
  if(intr_get())
    800094e8:	00000097          	auipc	ra,0x0
    800094ec:	e38080e7          	jalr	-456(ra) # 80009320 <intr_get>
    800094f0:	87aa                	mv	a5,a0
    800094f2:	cb89                	beqz	a5,80009504 <pop_off+0x30>
    panic("pop_off - interruptible");
    800094f4:	00002517          	auipc	a0,0x2
    800094f8:	31450513          	addi	a0,a0,788 # 8000b808 <etext+0x808>
    800094fc:	00000097          	auipc	ra,0x0
    80009500:	a3a080e7          	jalr	-1478(ra) # 80008f36 <panic>
  if(c->noff < 1)
    80009504:	fe843783          	ld	a5,-24(s0)
    80009508:	5fbc                	lw	a5,120(a5)
    8000950a:	00f04a63          	bgtz	a5,8000951e <pop_off+0x4a>
    panic("pop_off");
    8000950e:	00002517          	auipc	a0,0x2
    80009512:	31250513          	addi	a0,a0,786 # 8000b820 <etext+0x820>
    80009516:	00000097          	auipc	ra,0x0
    8000951a:	a20080e7          	jalr	-1504(ra) # 80008f36 <panic>
  c->noff -= 1;
    8000951e:	fe843783          	ld	a5,-24(s0)
    80009522:	5fbc                	lw	a5,120(a5)
    80009524:	37fd                	addiw	a5,a5,-1
    80009526:	0007871b          	sext.w	a4,a5
    8000952a:	fe843783          	ld	a5,-24(s0)
    8000952e:	dfb8                	sw	a4,120(a5)
  if(c->noff == 0 && c->intena)
    80009530:	fe843783          	ld	a5,-24(s0)
    80009534:	5fbc                	lw	a5,120(a5)
    80009536:	eb89                	bnez	a5,80009548 <pop_off+0x74>
    80009538:	fe843783          	ld	a5,-24(s0)
    8000953c:	5ffc                	lw	a5,124(a5)
    8000953e:	c789                	beqz	a5,80009548 <pop_off+0x74>
    intr_on();
    80009540:	00000097          	auipc	ra,0x0
    80009544:	d8e080e7          	jalr	-626(ra) # 800092ce <intr_on>
}
    80009548:	0001                	nop
    8000954a:	60e2                	ld	ra,24(sp)
    8000954c:	6442                	ld	s0,16(sp)
    8000954e:	6105                	addi	sp,sp,32
    80009550:	8082                	ret
	...

000000008000a000 <_trampoline>:
    8000a000:	14051073          	csrw	sscratch,a0
    8000a004:	02000537          	lui	a0,0x2000
    8000a008:	357d                	addiw	a0,a0,-1 # 1ffffff <_entry-0x7e000001>
    8000a00a:	0536                	slli	a0,a0,0xd
    8000a00c:	02153423          	sd	ra,40(a0)
    8000a010:	02253823          	sd	sp,48(a0)
    8000a014:	02353c23          	sd	gp,56(a0)
    8000a018:	04453023          	sd	tp,64(a0)
    8000a01c:	04553423          	sd	t0,72(a0)
    8000a020:	04653823          	sd	t1,80(a0)
    8000a024:	04753c23          	sd	t2,88(a0)
    8000a028:	f120                	sd	s0,96(a0)
    8000a02a:	f524                	sd	s1,104(a0)
    8000a02c:	fd2c                	sd	a1,120(a0)
    8000a02e:	e150                	sd	a2,128(a0)
    8000a030:	e554                	sd	a3,136(a0)
    8000a032:	e958                	sd	a4,144(a0)
    8000a034:	ed5c                	sd	a5,152(a0)
    8000a036:	0b053023          	sd	a6,160(a0)
    8000a03a:	0b153423          	sd	a7,168(a0)
    8000a03e:	0b253823          	sd	s2,176(a0)
    8000a042:	0b353c23          	sd	s3,184(a0)
    8000a046:	0d453023          	sd	s4,192(a0)
    8000a04a:	0d553423          	sd	s5,200(a0)
    8000a04e:	0d653823          	sd	s6,208(a0)
    8000a052:	0d753c23          	sd	s7,216(a0)
    8000a056:	0f853023          	sd	s8,224(a0)
    8000a05a:	0f953423          	sd	s9,232(a0)
    8000a05e:	0fa53823          	sd	s10,240(a0)
    8000a062:	0fb53c23          	sd	s11,248(a0)
    8000a066:	11c53023          	sd	t3,256(a0)
    8000a06a:	11d53423          	sd	t4,264(a0)
    8000a06e:	11e53823          	sd	t5,272(a0)
    8000a072:	11f53c23          	sd	t6,280(a0)
    8000a076:	140022f3          	csrr	t0,sscratch
    8000a07a:	06553823          	sd	t0,112(a0)
    8000a07e:	00853103          	ld	sp,8(a0)
    8000a082:	02053203          	ld	tp,32(a0)
    8000a086:	01053283          	ld	t0,16(a0)
    8000a08a:	00053303          	ld	t1,0(a0)
    8000a08e:	12000073          	sfence.vma
    8000a092:	18031073          	csrw	satp,t1
    8000a096:	12000073          	sfence.vma
    8000a09a:	8282                	jr	t0

000000008000a09c <userret>:
    8000a09c:	12000073          	sfence.vma
    8000a0a0:	18051073          	csrw	satp,a0
    8000a0a4:	12000073          	sfence.vma
    8000a0a8:	02000537          	lui	a0,0x2000
    8000a0ac:	357d                	addiw	a0,a0,-1 # 1ffffff <_entry-0x7e000001>
    8000a0ae:	0536                	slli	a0,a0,0xd
    8000a0b0:	02853083          	ld	ra,40(a0)
    8000a0b4:	03053103          	ld	sp,48(a0)
    8000a0b8:	03853183          	ld	gp,56(a0)
    8000a0bc:	04053203          	ld	tp,64(a0)
    8000a0c0:	04853283          	ld	t0,72(a0)
    8000a0c4:	05053303          	ld	t1,80(a0)
    8000a0c8:	05853383          	ld	t2,88(a0)
    8000a0cc:	7120                	ld	s0,96(a0)
    8000a0ce:	7524                	ld	s1,104(a0)
    8000a0d0:	7d2c                	ld	a1,120(a0)
    8000a0d2:	6150                	ld	a2,128(a0)
    8000a0d4:	6554                	ld	a3,136(a0)
    8000a0d6:	6958                	ld	a4,144(a0)
    8000a0d8:	6d5c                	ld	a5,152(a0)
    8000a0da:	0a053803          	ld	a6,160(a0)
    8000a0de:	0a853883          	ld	a7,168(a0)
    8000a0e2:	0b053903          	ld	s2,176(a0)
    8000a0e6:	0b853983          	ld	s3,184(a0)
    8000a0ea:	0c053a03          	ld	s4,192(a0)
    8000a0ee:	0c853a83          	ld	s5,200(a0)
    8000a0f2:	0d053b03          	ld	s6,208(a0)
    8000a0f6:	0d853b83          	ld	s7,216(a0)
    8000a0fa:	0e053c03          	ld	s8,224(a0)
    8000a0fe:	0e853c83          	ld	s9,232(a0)
    8000a102:	0f053d03          	ld	s10,240(a0)
    8000a106:	0f853d83          	ld	s11,248(a0)
    8000a10a:	10053e03          	ld	t3,256(a0)
    8000a10e:	10853e83          	ld	t4,264(a0)
    8000a112:	11053f03          	ld	t5,272(a0)
    8000a116:	11853f83          	ld	t6,280(a0)
    8000a11a:	7928                	ld	a0,112(a0)
    8000a11c:	10200073          	sret
	...
