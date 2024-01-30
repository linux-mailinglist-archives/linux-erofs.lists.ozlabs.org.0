Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8132841E95
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Jan 2024 10:01:48 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Ephm4Edh;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TPK0p4sljz3bsT
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Jan 2024 20:01:46 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Ephm4Edh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::234; helo=mail-lj1-x234.google.com; envelope-from=huangzhaoyang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TPK0d3wfFz3bYx
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Jan 2024 20:01:36 +1100 (AEDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2cf206e4d56so39447351fa.3
        for <linux-erofs@lists.ozlabs.org>; Tue, 30 Jan 2024 01:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706605289; x=1707210089; darn=lists.ozlabs.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TlxCmrxPs6PLlAUkYhD4PiszEPv9bX5RZ7OlIjJRLX8=;
        b=Ephm4EdhlxmU83ZscBVU6qqy/Q+4vA4GvtrWWVsaSFkz0SasjpunDU23C28p8AUeCR
         ZMpNfaumKezOif9+CRrnLZ+KdtNgrx6/r1Z/uMO0w72NVUNTJMobsYcSaBXhlff7+bIh
         m4E0B/+i+RLJ7cud4BpbUMpO4j/gHfNWuKqivTCc50kS3U19miDIoRcJyX7fp8t5pH41
         AjaPFxelRGfuN3yC7OHlg35vvCWrZ0b0XxXAc1ONL+ovDI49s8yDhWNLin9wSD5SeR/0
         cBF7IDISXUw1PI1NzTMZk6YrneBiTjXMPDQZOHM8/Dqrtqa+6RvqFSauQO6qFKtzznPn
         XA4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706605289; x=1707210089;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TlxCmrxPs6PLlAUkYhD4PiszEPv9bX5RZ7OlIjJRLX8=;
        b=pbYkFx7h7cT5oFdiv3PggGYEkGWZO2p9/u85Ps0ZrLJXE5jjISa2NS8EPVtGv0oWy/
         /fSYUqkhuZ+SmH4QONBTK3Cfj/Z2RFne7oUH8Wq+rjDWKbMpxTaUnzkD2C/reVl+eHRd
         XChBVwX7Tr0g847eK7gB5X+SKA2zxopIBTYFt/tnsKHO8C4jb3HcUwtxYyM4fHQ2Jbed
         abTWDzGSwDoahn6lzEZG0agBLbpuGUZGYNRRbt7K2eZWEOOphLZTchrEoQkV1uVR7VES
         nCO7dn1cn/PNHDXDnuE3uXeyM4fBinSaXjMbZzmpK0o3nKHx4L/YE+VhoFEzkyR5v9AG
         /SSw==
X-Gm-Message-State: AOJu0YzUJDwKk0cE6VjguMO1n0T0Nz23bZyi7YRJnitJNOyOhvgC/qOa
	5H2lZzkjgxEERXtkIBScn9y1/KjAvG+WnW/ejtckunLk72YvHbmehi/5O5lWJrN3IEgACxjmOf4
	z/mJdNxtjIz+mxBUK+iRCXSsXxgA=
X-Google-Smtp-Source: AGHT+IGlv80G1A7suh1RSH2TzSSnQi3IVvjDIeRecUF0qyPJeq9GwXiAlV2gJLAckb9SfAf4PXwE7MNMANPzIr1zrdA=
X-Received: by 2002:a2e:808b:0:b0:2cf:1c9c:a43b with SMTP id
 i11-20020a2e808b000000b002cf1c9ca43bmr4732983ljg.18.1706605288416; Tue, 30
 Jan 2024 01:01:28 -0800 (PST)
MIME-Version: 1.0
References: <20240130084207.3760518-1-zhaoyang.huang@unisoc.com>
In-Reply-To: <20240130084207.3760518-1-zhaoyang.huang@unisoc.com>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Tue, 30 Jan 2024 17:01:17 +0800
Message-ID: <CAGWkznE1tT3Fj9R7ZjmMh_ixsoOiCkjPnxKAjfq-3P0panNOkA@mail.gmail.com>
Subject: Fwd: [PATCHv5 1/1] block: introduce content activity based ioprio
To: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Dear erofs guys,
I would like to have you notice this commit which introduces an MGLRU
based ioprio feature which is proved to be effective in benchmark and
real scenarios. May I get any feedback from you if you are interested.
Thank you

ps: you can verify this patch by applying this patch, enable
CONFIG_CONTENT_ACT_BASED_IOPRIO and include the header file as below.

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 036f610e044b..76bea610f699 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -7,6 +7,7 @@
 #include "compress.h"
 #include <linux/psi.h>
 #include <linux/cpuhotplug.h>
+#include <linux/act_ioprio.h>
 #include <trace/events/erofs.h>

 #define Z_EROFS_PCLUSTER_MAX_PAGES     (Z_EROFS_PCLUSTER_MAX_SIZE / PAGE_S=
IZE)

---------- Forwarded message ---------
From: zhaoyang.huang <zhaoyang.huang@unisoc.com>
Date: Tue, Jan 30, 2024 at 4:43=E2=80=AFPM
Subject: [PATCHv5 1/1] block: introduce content activity based ioprio
To: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe
<axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>, Yu Zhao
<yuzhao@google.com>, Damien Le Moal <dlemoal@kernel.org>, Niklas
Cassel <niklas.cassel@wdc.com>, Martin K . Petersen
<martin.petersen@oracle.com>, Hannes Reinecke <hare@suse.de>, Linus
Walleij <linus.walleij@linaro.org>, <linux-mm@kvack.org>,
<linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
<linux-kernel@vger.kernel.org>, Zhaoyang Huang
<huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>


From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Currently, request's ioprio are set via task's schedule priority(when no
blkcg configured), which has high priority tasks possess the privilege on
both of CPU and IO scheduling.
This commit works as a hint of original policy by promoting the request iop=
rio
based on the page/folio's activity. The original idea comes from LRU_GEN
which provides more precised folio activity than before. This commit try
to adjust the request's ioprio when certain part of its folios are hot,
which indicate that this request carry important contents and need be
scheduled ealier.

This commit is verified on a v6.6 6GB RAM android14 system via 4 test cases
by changing the bio_add_page/folio API in erofs, ext4 and f2fs in
another commit.

Case 1:
script[a] which get significant improved fault time as expected[b]
where dd's cost also shrink from 55s to 40s.
(1). fault_latency.bin is an ebpf based test tool which measure all task's
   iowait latency during page fault when scheduled out/in.
(2). costmem generate page fault by mmaping a file and access the VA.
(3). dd generate concurrent vfs io.

[a]
./fault_latency.bin 1 5 > /data/dd_costmem &
costmem -c0 -a2048000 -b128000 -o0 1>/dev/null &
costmem -c0 -a2048000 -b128000 -o0 1>/dev/null &
costmem -c0 -a2048000 -b128000 -o0 1>/dev/null &
costmem -c0 -a2048000 -b128000 -o0 1>/dev/null &
dd if=3D/dev/block/sda of=3D/data/ddtest bs=3D1024 count=3D2048000 &
dd if=3D/dev/block/sda of=3D/data/ddtest1 bs=3D1024 count=3D2048000 &
dd if=3D/dev/block/sda of=3D/data/ddtest2 bs=3D1024 count=3D2048000 &
dd if=3D/dev/block/sda of=3D/data/ddtest3 bs=3D1024 count=3D2048000
[b]
                       mainline         commit
io wait                836us            156us

Case 2:
fio -filename=3D/dev/block/by-name/userdata -rw=3Drandread -direct=3D0
-bs=3D4k -size=3D2000M -numjobs=3D8 -group_reporting -name=3Dmytest
mainline: 513MiB/s
READ: bw=3D531MiB/s (557MB/s), 531MiB/s-531MiB/s (557MB/s-557MB/s),
io=3D15.6GiB (16.8GB), run=3D30137-30137msec
READ: bw=3D543MiB/s (569MB/s), 543MiB/s-543MiB/s (569MB/s-569MB/s),
io=3D15.6GiB (16.8GB), run=3D29469-29469msec
READ: bw=3D474MiB/s (497MB/s), 474MiB/s-474MiB/s (497MB/s-497MB/s),
io=3D15.6GiB (16.8GB), run=3D33724-33724msec
READ: bw=3D535MiB/s (561MB/s), 535MiB/s-535MiB/s (561MB/s-561MB/s),
io=3D15.6GiB (16.8GB), run=3D29928-29928msec
READ: bw=3D523MiB/s (548MB/s), 523MiB/s-523MiB/s (548MB/s-548MB/s),
io=3D15.6GiB (16.8GB), run=3D30617-30617msec
READ: bw=3D492MiB/s (516MB/s), 492MiB/s-492MiB/s (516MB/s-516MB/s),
io=3D15.6GiB (16.8GB), run=3D32518-32518msec
READ: bw=3D533MiB/s (559MB/s), 533MiB/s-533MiB/s (559MB/s-559MB/s),
io=3D15.6GiB (16.8GB), run=3D29993-29993msec
READ: bw=3D524MiB/s (550MB/s), 524MiB/s-524MiB/s (550MB/s-550MB/s),
io=3D15.6GiB (16.8GB), run=3D30526-30526msec
READ: bw=3D529MiB/s (554MB/s), 529MiB/s-529MiB/s (554MB/s-554MB/s),
io=3D15.6GiB (16.8GB), run=3D30269-30269msec
READ: bw=3D449MiB/s (471MB/s), 449MiB/s-449MiB/s (471MB/s-471MB/s),
io=3D15.6GiB (16.8GB), run=3D35629-35629msec

commit: 633MiB/s
READ: bw=3D668MiB/s (700MB/s), 668MiB/s-668MiB/s (700MB/s-700MB/s),
io=3D15.6GiB (16.8GB), run=3D23952-23952msec
READ: bw=3D589MiB/s (618MB/s), 589MiB/s-589MiB/s (618MB/s-618MB/s),
io=3D15.6GiB (16.8GB), run=3D27164-27164msec
READ: bw=3D638MiB/s (669MB/s), 638MiB/s-638MiB/s (669MB/s-669MB/s),
io=3D15.6GiB (16.8GB), run=3D25071-25071msec
READ: bw=3D714MiB/s (749MB/s), 714MiB/s-714MiB/s (749MB/s-749MB/s),
io=3D15.6GiB (16.8GB), run=3D22409-22409msec
READ: bw=3D600MiB/s (629MB/s), 600MiB/s-600MiB/s (629MB/s-629MB/s),
io=3D15.6GiB (16.8GB), run=3D26669-26669msec
READ: bw=3D592MiB/s (621MB/s), 592MiB/s-592MiB/s (621MB/s-621MB/s),
io=3D15.6GiB (16.8GB), run=3D27036-27036msec
READ: bw=3D691MiB/s (725MB/s), 691MiB/s-691MiB/s (725MB/s-725MB/s),
io=3D15.6GiB (16.8GB), run=3D23150-23150msec
READ: bw=3D569MiB/s (596MB/s), 569MiB/s-569MiB/s (596MB/s-596MB/s),
io=3D15.6GiB (16.8GB), run=3D28142-28142msec
READ: bw=3D563MiB/s (590MB/s), 563MiB/s-563MiB/s (590MB/s-590MB/s),
io=3D15.6GiB (16.8GB), run=3D28429-28429msec
READ: bw=3D712MiB/s (746MB/s), 712MiB/s-712MiB/s (746MB/s-746MB/s),
io=3D15.6GiB (16.8GB), run=3D22478-22478msec

Case 3:
This commit is also verified by the case of launching camera APP which is
usually considered as heavy working load on both of memory and IO, which
shows 12%-24% improvement.

                ttl =3D 0         ttl =3D 50        ttl =3D 100
mainline        2267ms          2420ms          2316ms
commit          1992ms          1806ms          1998ms

case 4:
androbench has no improvment as well as regression which supposed to be
its test time is short which MGLRU hasn't take effect yet.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
change of v2: calculate page's activity via helper function
change of v3: solve layer violation by move API into mm
change of v4: keep block clean by removing the page related API
change of v5: introduce the macros of bio_add_folio/page for read dir.
---
---
 include/linux/act_ioprio.h  | 60 +++++++++++++++++++++++++++++++++++++
 include/uapi/linux/ioprio.h | 38 +++++++++++++++++++++++
 mm/Kconfig                  |  8 +++++
 3 files changed, 106 insertions(+)
 create mode 100644 include/linux/act_ioprio.h

diff --git a/include/linux/act_ioprio.h b/include/linux/act_ioprio.h
new file mode 100644
index 000000000000..ca7309b85758
--- /dev/null
+++ b/include/linux/act_ioprio.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _ACT_IOPRIO_H
+#define _ACT_IOPRIO_H
+
+#ifdef CONFIG_CONTENT_ACT_BASED_IOPRIO
+#include <linux/bio.h>
+
+static __maybe_unused
+bool act_bio_add_folio(struct bio *bio, struct folio *folio, size_t len,
+               size_t off)
+{
+       int class, level, hint, activity;
+       bool ret;
+
+       ret =3D bio_add_folio(bio, folio, len, off);
+       if (bio_op(bio) =3D=3D REQ_OP_READ && ret) {
+               class =3D IOPRIO_PRIO_CLASS(bio->bi_ioprio);
+               level =3D IOPRIO_PRIO_LEVEL(bio->bi_ioprio);
+               hint =3D IOPRIO_PRIO_HINT(bio->bi_ioprio);
+               activity =3D IOPRIO_PRIO_ACTIVITY(bio->bi_ioprio);
+               activity +=3D (activity < IOPRIO_NR_ACTIVITY &&
+                               folio_test_workingset(folio)) ? 1 : 0;
+               if (activity >=3D bio->bi_vcnt / 2)
+                       class =3D IOPRIO_CLASS_RT;
+               else if (activity >=3D bio->bi_vcnt / 4)
+                       class =3D
max(IOPRIO_PRIO_CLASS(get_current_ioprio()), IOPRIO_CLASS_BE);
+               activity =3D min(IOPRIO_NR_ACTIVITY - 1, activity);
+               bio->bi_ioprio =3D IOPRIO_PRIO_VALUE_ACTIVITY(class,
level, hint, activity);
+       }
+       return ret;
+}
+
+static __maybe_unused
+int act_bio_add_page(struct bio *bio, struct page *page,
+               unsigned int len, unsigned int offset)
+{
+       int class, level, hint, activity;
+       int ret =3D 0;
+
+       ret =3D bio_add_page(bio, page, len, offset);
+       if (bio_op(bio) =3D=3D REQ_OP_READ && ret > 0) {
+               class =3D IOPRIO_PRIO_CLASS(bio->bi_ioprio);
+               level =3D IOPRIO_PRIO_LEVEL(bio->bi_ioprio);
+               hint =3D IOPRIO_PRIO_HINT(bio->bi_ioprio);
+               activity =3D IOPRIO_PRIO_ACTIVITY(bio->bi_ioprio);
+               activity +=3D (activity < IOPRIO_NR_ACTIVITY &&
+                               PageWorkingset(page)) ? 1 : 0;
+               if (activity >=3D bio->bi_vcnt / 2)
+                       class =3D IOPRIO_CLASS_RT;
+               else if (activity >=3D bio->bi_vcnt / 4)
+                       class =3D
max(IOPRIO_PRIO_CLASS(get_current_ioprio()), IOPRIO_CLASS_BE);
+               activity =3D min(IOPRIO_NR_ACTIVITY - 1, activity);
+               bio->bi_ioprio =3D IOPRIO_PRIO_VALUE_ACTIVITY(class,
level, hint, activity);
+       }
+       return ret;
+}
+#define bio_add_folio(bio, folio, len, off)
act_bio_add_folio(bio, folio, len, off)
+#define bio_add_page(bio, page, len, offset)    act_bio_add_page(bio,
page, len, offset)
+#endif
+#endif
diff --git a/include/uapi/linux/ioprio.h b/include/uapi/linux/ioprio.h
index bee2bdb0eedb..64cf5ff0ac5f 100644
--- a/include/uapi/linux/ioprio.h
+++ b/include/uapi/linux/ioprio.h
@@ -71,12 +71,24 @@ enum {
  * class and level.
  */
 #define IOPRIO_HINT_SHIFT              IOPRIO_LEVEL_NR_BITS
+#ifdef CONFIG_CONTENT_ACT_BASED_IOPRIO
+#define IOPRIO_HINT_NR_BITS            3
+#else
 #define IOPRIO_HINT_NR_BITS            10
+#endif
 #define IOPRIO_NR_HINTS                        (1 << IOPRIO_HINT_NR_BITS)
 #define IOPRIO_HINT_MASK               (IOPRIO_NR_HINTS - 1)
 #define IOPRIO_PRIO_HINT(ioprio)       \
        (((ioprio) >> IOPRIO_HINT_SHIFT) & IOPRIO_HINT_MASK)

+#ifdef CONFIG_CONTENT_ACT_BASED_IOPRIO
+#define IOPRIO_ACTIVITY_SHIFT          (IOPRIO_HINT_NR_BITS +
IOPRIO_LEVEL_NR_BITS)
+#define IOPRIO_ACTIVITY_NR_BITS                7
+#define IOPRIO_NR_ACTIVITY             (1 << IOPRIO_ACTIVITY_NR_BITS)
+#define IOPRIO_ACTIVITY_MASK           (IOPRIO_NR_ACTIVITY - 1)
+#define IOPRIO_PRIO_ACTIVITY(ioprio)   \
+       (((ioprio) >> IOPRIO_ACTIVITY_SHIFT) & IOPRIO_ACTIVITY_MASK)
+#endif
 /*
  * I/O hints.
  */
@@ -104,6 +116,7 @@ enum {

 #define IOPRIO_BAD_VALUE(val, max) ((val) < 0 || (val) >=3D (max))

+#ifndef CONFIG_CONTENT_ACT_BASED_IOPRIO
 /*
  * Return an I/O priority value based on a class, a level and a hint.
  */
@@ -123,5 +136,30 @@ static __always_inline __u16 ioprio_value(int
prioclass, int priolevel,
        ioprio_value(prioclass, priolevel, IOPRIO_HINT_NONE)
 #define IOPRIO_PRIO_VALUE_HINT(prioclass, priolevel, priohint) \
        ioprio_value(prioclass, priolevel, priohint)
+#else
+/*
+ * Return an I/O priority value based on a class, a level, a hint and
+ * content's activities
+ */
+static __always_inline __u16 ioprio_value(int prioclass, int priolevel,
+               int priohint, int activity)
+{
+       if (IOPRIO_BAD_VALUE(prioclass, IOPRIO_NR_CLASSES) ||
+                       IOPRIO_BAD_VALUE(priolevel, IOPRIO_NR_LEVELS) ||
+                       IOPRIO_BAD_VALUE(priohint, IOPRIO_NR_HINTS) ||
+                       IOPRIO_BAD_VALUE(activity, IOPRIO_NR_ACTIVITY))
+               return IOPRIO_CLASS_INVALID << IOPRIO_CLASS_SHIFT;

+       return (prioclass << IOPRIO_CLASS_SHIFT) |
+               (activity << IOPRIO_ACTIVITY_SHIFT) |
+               (priohint << IOPRIO_HINT_SHIFT) | priolevel;
+}
+
+#define IOPRIO_PRIO_VALUE(prioclass, priolevel)                        \
+       ioprio_value(prioclass, priolevel, IOPRIO_HINT_NONE, 0)
+#define IOPRIO_PRIO_VALUE_HINT(prioclass, priolevel, priohint) \
+       ioprio_value(prioclass, priolevel, priohint, 0)
+#define IOPRIO_PRIO_VALUE_ACTIVITY(prioclass, priolevel, priohint,
activity)   \
+       ioprio_value(prioclass, priolevel, priohint, activity)
+#endif
 #endif /* _UAPI_LINUX_IOPRIO_H */
diff --git a/mm/Kconfig b/mm/Kconfig
index 264a2df5ecf5..e0e5a5a44ded 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1240,6 +1240,14 @@ config LRU_GEN_STATS
          from evicted generations for debugging purpose.

          This option has a per-memcg and per-node memory overhead.
+
+config CONTENT_ACT_BASED_IOPRIO
+       bool "Enable content activity based ioprio"
+       depends on LRU_GEN
+       default n
+       help
+         This item enable the feature of adjust bio's priority by
+         calculating its content's activity.
 # }

 config ARCH_SUPPORTS_PER_VMA_LOCK
--
2.25.1
