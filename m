Return-Path: <linux-erofs+bounces-700-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 948ADB0D67E
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Jul 2025 12:00:49 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bmXp413W8z3bb2;
	Tue, 22 Jul 2025 20:00:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753178444;
	cv=none; b=AdpzAzJ1FTjYZYadjLD0rRJVqVnoaabPzeabLYEnZBzhgnbSLjD20OFw5E41j9j/6+YUcgkmt4dnLAE70mHJT4KwlEcAL/0yvgT4tSppylDBCFaN4RGgmvxMHdpvXifI4+IiISo/Yc6ZxL3zrJKB+k4HG0btpr5g4UzsN32974YoVl7U+YE+r1jYKeCWGbLYeUhgwsw8hIAGqZpXlA3GK8EErQscTGQQLViHJ7MfLD0WVjIY3Ffbe/xrAjhAzGaVeN+NJGf/FpRQM4yZU0HaMOnYmhb42mV9FHAIfGq186n2/5eUZy8Q9AAtBad0cUvjOMfsPXZQ7sezW+s/QSh9QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753178444; c=relaxed/relaxed;
	bh=5oAOIGk3wQoTxgJtJWrUbP/U+P36XOKJgL0cO17EcOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MMyVBvdepPYALpBesDzdKwJ9Ax/vchOkuhHGS5AOODiCtCc0p0V9DVyrFH81UuebveSX0/84pkDLu5BGlnVGw0/Vi8mAv5c8EC5mz5hnPh3qB2OhVxpaOAy9nHaK1iryT/eWERhNMr2xK+AeTKxKs1y8CsB/HQOs/9H/l//uG3VS2+lGHGqH9/ctzRlxR77Kl+aLjAL0wonOQd1euWCUI+1SWfdt/mdvipDMs0PHsa2f3QCjFaeGZk5WXQL7huU3y7Uh6kphqecI0BxKUbA7q/c3vXPxgQWJCtU6RQ15FXlM/7LEmWU3VpkJZ46qxu1bczTbrbmzLwebAGDOrs5xYA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LvPzRQDf; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LvPzRQDf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bmXp25VGrz2yhb
	for <linux-erofs@lists.ozlabs.org>; Tue, 22 Jul 2025 20:00:42 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753178438; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=5oAOIGk3wQoTxgJtJWrUbP/U+P36XOKJgL0cO17EcOQ=;
	b=LvPzRQDfJzYT9KMZlPozayRleCn7TZGJqY8Ocn7i6pBwkmcdFgK+/qWD6Z5BeuGc781V4A7dVjKyydZIGZ2F/+X2fOJ9ypKwRDjlTwxyP3Yk+0geIxbAm9ERrtkqfQL7d99TdTQtLNpxTxC0YRWHApUC7LYpN2u8Cl5q2DFavVI=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WjVvTq1_1753178436 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 22 Jul 2025 18:00:37 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Stefan Kerkmann <s.kerkmann@pengutronix.de>
Cc: linux-erofs@lists.ozlabs.org,
	LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 6.1.y 2/5] erofs: sunset erofs_dbg()
Date: Tue, 22 Jul 2025 18:00:26 +0800
Message-ID: <20250722100029.3052177-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250722100029.3052177-1-hsiangkao@linux.alibaba.com>
References: <20250722100029.3052177-1-hsiangkao@linux.alibaba.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

commit 10656f9ca60ed85f4cfc06bcbe1f240ee310fa8c upstream.

Such debug messages are rarely used now.  Let's get rid of these,
and revert locally if they are needed for debugging.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Link: https://lore.kernel.org/r/20230414083027.12307-1-hsiangkao@linux.alibaba.com
---
 fs/erofs/inode.c    | 3 ---
 fs/erofs/internal.h | 2 --
 fs/erofs/namei.c    | 9 +++------
 fs/erofs/zdata.c    | 5 -----
 fs/erofs/zmap.c     | 3 ---
 5 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 7dcf350b9fef..3cbef6318b7b 100644
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
index d7cd1e619d46..126970932805 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -32,10 +32,8 @@ __printf(3, 4) void _erofs_info(struct super_block *sb,
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
index 8332428b780c..c0d5ffb62420 100644
--- a/fs/erofs/namei.c
+++ b/fs/erofs/namei.c
@@ -203,16 +203,13 @@ static struct dentry *erofs_lookup(struct inode *dir, struct dentry *dentry,
 
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
index 32ca6d3e373a..5c0f855ab18d 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -818,8 +818,6 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 
 	if (offset + cur < map->m_la ||
 	    offset + cur >= map->m_la + map->m_llen) {
-		erofs_dbg("out-of-range map @ pos %llu", offset + cur);
-
 		if (z_erofs_collector_end(fe))
 			fe->backmost = false;
 		map->m_la = offset + cur;
@@ -935,9 +933,6 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	if (err)
 		z_erofs_page_mark_eio(page);
 	z_erofs_onlinepage_endio(page);
-
-	erofs_dbg("%s, finish page: %pK spiltted: %u map->m_llen %llu",
-		  __func__, page, spiltted, map->m_llen);
 	return err;
 }
 
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 2cd70cf4c8b2..d2d7fe826091 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -603,9 +603,6 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 
 unmap_out:
 	erofs_unmap_metabuf(&m.map->buf);
-	erofs_dbg("%s, m_la %llu m_pa %llu m_llen %llu m_plen %llu m_flags 0%o",
-		  __func__, map->m_la, map->m_pa,
-		  map->m_llen, map->m_plen, map->m_flags);
 	return err;
 }
 
-- 
2.43.5


