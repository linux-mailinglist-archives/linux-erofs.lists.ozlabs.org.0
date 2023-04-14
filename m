Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA966E1E4D
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Apr 2023 10:30:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PyV5N05zqz3cjK
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Apr 2023 18:30:48 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PyV5D4Rbtz3c99
	for <linux-erofs@lists.ozlabs.org>; Fri, 14 Apr 2023 18:30:39 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Vg2zKUI_1681461028;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vg2zKUI_1681461028)
          by smtp.aliyun-inc.com;
          Fri, 14 Apr 2023 16:30:34 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] erofs: sunset erofs_dbg()
Date: Fri, 14 Apr 2023 16:30:26 +0800
Message-Id: <20230414083027.12307-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Such debug messages are rarely used now.  Let's get rid of these,
and revert locally if they are needed for debugging.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/inode.c    | 3 ---
 fs/erofs/internal.h | 2 --
 fs/erofs/namei.c    | 9 +++------
 fs/erofs/zdata.c    | 5 -----
 fs/erofs/zmap.c     | 3 ---
 5 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index e196d453291b..d70b12b81507 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -26,9 +26,6 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 	blkaddr = erofs_blknr(sb, inode_loc);
 	*ofs = erofs_blkoff(sb, inode_loc);
 
-	erofs_dbg("%s, reading inode nid %llu at %u of blkaddr %u",
-		  __func__, vi->nid, *ofs, blkaddr);
-
 	kaddr = erofs_read_metabuf(buf, sb, blkaddr, EROFS_KMAP);
 	if (IS_ERR(kaddr)) {
 		erofs_err(sb, "failed to get inode (nid: %llu) page, err %ld",
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index f1268cb6a37c..6c8c0504032e 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -31,10 +31,8 @@ __printf(3, 4) void _erofs_info(struct super_block *sb,
 #define erofs_info(sb, fmt, ...) \
 	_erofs_info(sb, __func__, fmt "\n", ##__VA_ARGS__)
 #ifdef CONFIG_EROFS_FS_DEBUG
-#define erofs_dbg(x, ...)       pr_debug(x "\n", ##__VA_ARGS__)
 #define DBG_BUGON               BUG_ON
 #else
-#define erofs_dbg(x, ...)       ((void)0)
 #define DBG_BUGON(x)            ((void)(x))
 #endif	/* !CONFIG_EROFS_FS_DEBUG */
 
diff --git a/fs/erofs/namei.c b/fs/erofs/namei.c
index 43096bac4c99..d4f631d39f0f 100644
--- a/fs/erofs/namei.c
+++ b/fs/erofs/namei.c
@@ -205,16 +205,13 @@ static struct dentry *erofs_lookup(struct inode *dir, struct dentry *dentry,
 
 	err = erofs_namei(dir, &dentry->d_name, &nid, &d_type);
 
-	if (err == -ENOENT) {
+	if (err == -ENOENT)
 		/* negative dentry */
 		inode = NULL;
-	} else if (err) {
+	else if (err)
 		inode = ERR_PTR(err);
-	} else {
-		erofs_dbg("%s, %pd (nid %llu) found, d_type %u", __func__,
-			  dentry, nid, d_type);
+	else
 		inode = erofs_iget(dir->i_sb, nid);
-	}
 	return d_splice_alias(inode, dentry);
 }
 
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 34944e400037..45f21db2303a 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -979,8 +979,6 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 
 	if (offset + cur < map->m_la ||
 	    offset + cur >= map->m_la + map->m_llen) {
-		erofs_dbg("out-of-range map @ pos %llu", offset + cur);
-
 		if (z_erofs_collector_end(fe))
 			fe->backmost = false;
 		map->m_la = offset + cur;
@@ -1105,9 +1103,6 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	if (err)
 		z_erofs_page_mark_eio(page);
 	z_erofs_onlinepage_endio(page);
-
-	erofs_dbg("%s, finish page: %pK spiltted: %u map->m_llen %llu",
-		  __func__, page, spiltted, map->m_llen);
 	return err;
 }
 
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 14c21284d019..d37c5c89c728 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -585,9 +585,6 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 
 unmap_out:
 	erofs_unmap_metabuf(&m.map->buf);
-	erofs_dbg("%s, m_la %llu m_pa %llu m_llen %llu m_plen %llu m_flags 0%o",
-		  __func__, map->m_la, map->m_pa,
-		  map->m_llen, map->m_plen, map->m_flags);
 	return err;
 }
 
-- 
2.24.4

