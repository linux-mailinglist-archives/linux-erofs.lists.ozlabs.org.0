Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE872FF02D
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Jan 2021 17:26:53 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DM77s6N37zDrR1
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jan 2021 03:26:49 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=mail.scut.edu.cn (client-ip=202.38.213.20; helo=mail.scut.edu.cn;
 envelope-from=sehuww@mail.scut.edu.cn; receiver=<UNKNOWN>)
Received: from mail.scut.edu.cn (stumail1.scut.edu.cn [202.38.213.20])
 by lists.ozlabs.org (Postfix) with ESMTP id 4DM77l31W0zDqlK
 for <linux-erofs@lists.ozlabs.org>; Fri, 22 Jan 2021 03:26:43 +1100 (AEDT)
Received: from DESKTOP-N4CECTO.huww98.cn (unknown [59.53.40.31])
 by front (Coremail) with SMTP id AWSowAD3_OApqwlghqPbAQ--.3667S4;
 Fri, 22 Jan 2021 00:26:18 +0800 (CST)
From: Hu Weiwen <sehuww@mail.scut.edu.cn>
To: hsiangkao@redhat.com
Subject: [PATCH v2] erofs-utils: fix battach on full buffer block
Date: Fri, 22 Jan 2021 00:26:06 +0800
Message-Id: <20210121162606.8168-1-sehuww@mail.scut.edu.cn>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210120051216.GA2688693@xiangao.remote.csb>
References: <20210120051216.GA2688693@xiangao.remote.csb>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AWSowAD3_OApqwlghqPbAQ--.3667S4
X-Coremail-Antispam: 1UD129KBjvJXoWxuF18KF4UCw1xZF1kAryrWFg_yoW5Ww15pr
 90kw18KrWkXw1rCFZ7Xr4vqa4ftas5ta1xC3y0g34rZrn8XF1IqrZ5tFZ8CF4fWr93Jrs2
 qF42v345CFWjqr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUka14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
 4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
 4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_JwCF
 04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
 18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vI
 r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
 1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
 6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUjYLkUUUUU=
X-CM-SenderInfo: qsqrljqqwxllyrt6zt1loo2ulxwovvfxof0/1tbiAQAHBlepTBDfZQAPsX
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
Cc: linux-erofs@lists.ozlabs.org
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
Hi Xiang,

I still think send this as a seperate patch would be better. In previous v6
patch, I have fixed the erofs_mapbh() behaviour so that there should be no
user-visible bug introduced in that patch. And this patch is almost unrelated
to that optimization.

Compared with v1, this version fixes an error when compression is enabled.

Thanks,
Hu Weiwen

 lib/cache.c    | 4 ++--
 lib/compress.c | 2 +-
 lib/inode.c    | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/cache.c b/lib/cache.c
index c9a8c50..a7de72d 100644
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
diff --git a/lib/compress.c b/lib/compress.c
index 2b1f93c..670ac72 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -457,7 +457,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode)

 	close(fd);
 	ret = erofs_bh_balloon(bh, blknr_to_addr(compressed_blocks));
-	DBG_BUGON(ret);
+	DBG_BUGON(ret < 0);

 	erofs_info("compressed %s (%llu bytes) into %u blocks",
 		   inode->i_srcpath, (unsigned long long)inode->i_size,
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

