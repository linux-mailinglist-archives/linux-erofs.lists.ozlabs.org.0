Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B5C2EFEAA
	for <lists+linux-erofs@lfdr.de>; Sat,  9 Jan 2021 09:48:43 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DCYXm4MsPzDr1Q
	for <lists+linux-erofs@lfdr.de>; Sat,  9 Jan 2021 19:48:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=mail.scut.edu.cn (client-ip=202.38.213.20; helo=mail.scut.edu.cn;
 envelope-from=sehuww@mail.scut.edu.cn; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none)
 header.from=mail.scut.edu.cn
X-Greylist: delayed 1145 seconds by postgrey-1.36 at bilbo;
 Sat, 09 Jan 2021 19:48:29 AEDT
Received: from mail.scut.edu.cn (stumail1.scut.edu.cn [202.38.213.20])
 by lists.ozlabs.org (Postfix) with ESMTP id 4DCYXY5WJfzDr0T
 for <linux-erofs@lists.ozlabs.org>; Sat,  9 Jan 2021 19:48:28 +1100 (AEDT)
Received: from DESKTOP-N4CECTO.scut-smil.cn (unknown [125.216.246.30])
 by front (Coremail) with SMTP id AWSowAAnLeEbaflfXVeLAQ--.39566S6;
 Sat, 09 Jan 2021 16:28:23 +0800 (CST)
From: Hu Weiwen <sehuww@mail.scut.edu.cn>
To: Gao Xiang <hsiangkao@redhat.com>, Li Guifu <bluce.liguifu@huawei.com>,
 Miao Xie <miaoxie@huawei.com>, Fang Wei <fangwei1@huawei.com>
Subject: [PATCH v2 2/2] erofs-utils: refactor: remove end argument from
 erofs_mapbh
Date: Sat,  9 Jan 2021 16:28:10 +0800
Message-Id: <20210109082810.32169-3-sehuww@mail.scut.edu.cn>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210109082810.32169-1-sehuww@mail.scut.edu.cn>
References: <20210108181545.GA613131@xiangao.remote.csb>
 <20210109082810.32169-1-sehuww@mail.scut.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AWSowAAnLeEbaflfXVeLAQ--.39566S6
X-Coremail-Antispam: 1UD129KBjvJXoWxAF4UJw48Jw4kCFW8tF1UJrb_yoWrCr18pF
 yjkFy8Gr9Yqrn8uFn7Gw4Dt3yrta4kKF48Ca18CrnYvw45Jr92qFyDJ39rWr48Wr4ktrZI
 qF129345Cr17KFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBq14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
 x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
 Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
 ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr0_GcWl
 e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
 8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
 jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r43MxAIw2
 8IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
 x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrw
 CI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI
 42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
 80aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUUc18PUUUUU==
X-CM-SenderInfo: qsqrljqqwxllyrt6zt1loo2ulxwovvfxof0/1tbiAQAIBlepTBC2twAOsi
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
Cc: Hu Weiwen <sehuww@mail.scut.edu.cn>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>
---
 include/erofs/cache.h |  2 +-
 lib/cache.c           |  3 +--
 lib/compress.c        |  2 +-
 lib/inode.c           | 10 +++++-----
 lib/xattr.c           |  2 +-
 mkfs/main.c           |  2 +-
 6 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/include/erofs/cache.h b/include/erofs/cache.h
index b5bf6c0..26d341e 100644
--- a/include/erofs/cache.h
+++ b/include/erofs/cache.h
@@ -96,7 +96,7 @@ struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
 struct erofs_buffer_head *erofs_battach(struct erofs_buffer_head *bh,
 					int type, unsigned int size);
 
-erofs_blk_t erofs_mapbh(struct erofs_buffer_block *bb, bool end);
+erofs_blk_t erofs_mapbh(struct erofs_buffer_block *bb);
 bool erofs_bflush(struct erofs_buffer_block *bb);
 
 void erofs_bdrop(struct erofs_buffer_head *bh, bool tryrevoke);
diff --git a/lib/cache.c b/lib/cache.c
index aa972d8..bddb237 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -316,9 +316,8 @@ static erofs_blk_t __erofs_mapbh(struct erofs_buffer_block *bb)
 	return blkaddr;
 }
 
-erofs_blk_t erofs_mapbh(struct erofs_buffer_block *bb, bool end)
+erofs_blk_t erofs_mapbh(struct erofs_buffer_block *bb)
 {
-	DBG_BUGON(!end);
 	struct erofs_buffer_block *t = last_mapped_block;
 	while (1) {
 		t = list_next_entry(t, list);
diff --git a/lib/compress.c b/lib/compress.c
index 86db940..2b1f93c 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -416,7 +416,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 
 	memset(compressmeta, 0, Z_EROFS_LEGACY_MAP_HEADER_SIZE);
 
-	blkaddr = erofs_mapbh(bh->block, true);	/* start_blkaddr */
+	blkaddr = erofs_mapbh(bh->block);	/* start_blkaddr */
 	ctx.blkaddr = blkaddr;
 	ctx.metacur = compressmeta + Z_EROFS_LEGACY_MAP_HEADER_SIZE;
 	ctx.head = ctx.tail = 0;
diff --git a/lib/inode.c b/lib/inode.c
index d0b4d51..4ed6aed 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -148,7 +148,7 @@ static int __allocate_inode_bh_data(struct erofs_inode *inode,
 	inode->bh_data = bh;
 
 	/* get blkaddr of the bh */
-	ret = erofs_mapbh(bh->block, true);
+	ret = erofs_mapbh(bh->block);
 	DBG_BUGON(ret < 0);
 
 	/* write blocks except for the tail-end block */
@@ -522,7 +522,7 @@ int erofs_prepare_tail_block(struct erofs_inode *inode)
 		bh->op = &erofs_skip_write_bhops;
 
 		/* get blkaddr of bh */
-		ret = erofs_mapbh(bh->block, true);
+		ret = erofs_mapbh(bh->block);
 		DBG_BUGON(ret < 0);
 		inode->u.i_blkaddr = bh->block->blkaddr;
 
@@ -632,7 +632,7 @@ int erofs_write_tail_end(struct erofs_inode *inode)
 		int ret;
 		erofs_off_t pos;
 
-		erofs_mapbh(bh->block, true);
+		erofs_mapbh(bh->block);
 		pos = erofs_btell(bh, true) - EROFS_BLKSIZ;
 		ret = dev_write(inode->idata, pos, inode->idata_size);
 		if (ret)
@@ -879,7 +879,7 @@ void erofs_fixup_meta_blkaddr(struct erofs_inode *rootdir)
 	struct erofs_buffer_head *const bh = rootdir->bh;
 	erofs_off_t off, meta_offset;
 
-	erofs_mapbh(bh->block, true);
+	erofs_mapbh(bh->block);
 	off = erofs_btell(bh, false);
 
 	if (off > rootnid_maxoffset)
@@ -898,7 +898,7 @@ erofs_nid_t erofs_lookupnid(struct erofs_inode *inode)
 	if (!bh)
 		return inode->nid;
 
-	erofs_mapbh(bh->block, true);
+	erofs_mapbh(bh->block);
 	off = erofs_btell(bh, false);
 
 	meta_offset = blknr_to_addr(sbi.meta_blkaddr);
diff --git a/lib/xattr.c b/lib/xattr.c
index 49ebb9c..8b7bcb1 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -575,7 +575,7 @@ int erofs_build_shared_xattrs_from_path(const char *path)
 	}
 	bh->op = &erofs_skip_write_bhops;
 
-	erofs_mapbh(bh->block, true);
+	erofs_mapbh(bh->block);
 	off = erofs_btell(bh, false);
 
 	sbi.xattr_blkaddr = off / EROFS_BLKSIZ;
diff --git a/mkfs/main.c b/mkfs/main.c
index abd48be..d9c4c7f 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -304,7 +304,7 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 		round_up(EROFS_SUPER_END, EROFS_BLKSIZ);
 	char *buf;
 
-	*blocks         = erofs_mapbh(NULL, true);
+	*blocks         = erofs_mapbh(NULL);
 	sb.blocks       = cpu_to_le32(*blocks);
 	sb.root_nid     = cpu_to_le16(root_nid);
 	memcpy(sb.uuid, sbi.uuid, sizeof(sb.uuid));
-- 
2.17.1

