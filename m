Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3A42FA01B
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Jan 2021 13:42:59 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DKBJv3MllzDr4C
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Jan 2021 23:42:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=mail.scut.edu.cn (client-ip=202.38.213.20; helo=mail.scut.edu.cn;
 envelope-from=sehuww@mail.scut.edu.cn; receiver=<UNKNOWN>)
Received: from mail.scut.edu.cn (stumail1.scut.edu.cn [202.38.213.20])
 by lists.ozlabs.org (Postfix) with ESMTP id 4DKBFb01RGzDr2w
 for <linux-erofs@lists.ozlabs.org>; Mon, 18 Jan 2021 23:39:59 +1100 (AEDT)
Received: from DESKTOP-N4CECTO.scut-smil.cn (unknown [125.216.246.30])
 by front (Coremail) with SMTP id AWSowACHjeGIgQVgkpLKAQ--.47859S4;
 Mon, 18 Jan 2021 20:39:37 +0800 (CST)
From: Hu Weiwen <sehuww@mail.scut.edu.cn>
To: Gao Xiang <hsiangkao@aol.com>,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fix battach on full buffer block
Date: Mon, 18 Jan 2021 20:39:45 +0800
Message-Id: <20210118123945.23676-1-sehuww@mail.scut.edu.cn>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AWSowACHjeGIgQVgkpLKAQ--.47859S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw1UCr18JFy3WrykCFW3KFg_yoW8Zw4rpr
 9Ik3W8KrWqyw1rCFZ2qrs0qa4Fqa4kta1xC3y8X3s3Zrn0qr1UXrZ5JrZ8Ars5Wr93JrsF
 gF42v3y3Cay2gr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkv14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
 1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
 6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
 0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW5
 JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
 1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij
 64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
 0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
 42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUq0PfUUUUU=
X-CM-SenderInfo: qsqrljqqwxllyrt6zt1loo2ulxwovvfxof0/1tbiAQAFBlepTBDbawADsT
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
Cc: Hu Weiwen <sehuww@mail.scut.edu.cn>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

When __erofs_battach() is called on an buffer block of which
(bb->buffers.off % EROFS_BLKSIZ == 0), `tail_blkaddr' will not be
updated correctly. This bug can be reproduced by:

mkdir bug-repo
head -c 4032 /dev/urandom > bug-repo/1
head -c 4095 /dev/urandom > bug-repo/2
head -c 12345 /dev/urandom > bug-repo/3  # arbitrary size
mkfs.erofs -Eforce-inode-compact bug-repo.erofs.img bug-repo

Then mount this image and see that file `3' in the image is different
from `bug-repo/3'.

This patch fix this by:

* Don't inline tail-end data in this case, since the tail-end data will
be in a different block from inode.
* Correctly handle `battach' in this case.

Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>
---
 lib/cache.c | 4 ++--
 lib/inode.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/cache.c b/lib/cache.c
index 9e65429..464a43c 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -102,7 +102,7 @@ static int __erofs_battach(struct erofs_buffer_block *bb,
 			   bool dryrun)
 {
 	const erofs_off_t alignedoffset = roundup(bb->buffers.off, alignsize);
-	const int oob = cmpsgn(roundup(bb->buffers.off % EROFS_BLKSIZ,
+	const int oob = cmpsgn(roundup((bb->buffers.off - 1) % EROFS_BLKSIZ + 1,
 				       alignsize) + incr + extrasize,
 			       EROFS_BLKSIZ);
 	bool tailupdate = false;
@@ -134,7 +134,7 @@ static int __erofs_battach(struct erofs_buffer_block *bb,
 			tail_blkaddr = blkaddr + BLK_ROUND_UP(bb->buffers.off);
 		erofs_bupdate_mapped(bb);
 	}
-	return (alignedoffset + incr) % EROFS_BLKSIZ;
+	return (alignedoffset + incr - 1) % EROFS_BLKSIZ + 1;
 }
 
 int erofs_bh_balloon(struct erofs_buffer_head *bh, erofs_off_t incr)
diff --git a/lib/inode.c b/lib/inode.c
index 4ed6aed..d6a64cc 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -531,7 +531,7 @@ int erofs_prepare_tail_block(struct erofs_inode *inode)
 	}
 	/* expend a block as the tail block (should be successful) */
 	ret = erofs_bh_balloon(bh, EROFS_BLKSIZ);
-	DBG_BUGON(ret);
+	DBG_BUGON(ret < 0);
 	return 0;
 }
 
-- 
2.30.0

