Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C82D6976305
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Sep 2024 09:42:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X48Xj28smz2yVP
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Sep 2024 17:42:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726126930;
	cv=none; b=Urr9Fho/Ued0KpTs4QfjgOuxyFAzedUG3J70IFXcwSIQa7q9DHx04CiV83R1YYzGFFzjuHquTEhWBea62m0yoskivJaQgcYTuhDcv+FzBXSmhxHX83ZizYLSH5Ha25X5EIFwxICjBLdgcTc8EhxwCWCukhRnwJ3tolhKXScHbbYpPez7x+7b7WTNuQhqNRrSLW7lPJo+WHDKK8qy6WT8kLwHqMhrHrRCroVx1BZn/JNecY24mxClTZ0UcxfptWcrjw0a5nCWuTqt/kXMG2k8Ve8H8jPxoknTVWh+1MZK5oxCgIih5UgiGWZxphLk4xQl7G//UIEEa+sJFB7NoE1vCA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726126930; c=relaxed/relaxed;
	bh=U3zpUFdb+C2ZY/A+Fe1YciE/MRfJO397mZ/cfuh02Kk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o3SIazYpu4s1yaIpSSQWFnVJO1v/Gz04D2cC024AKIK1Yonkdz8VR/KM+aRq36BeKE2e3nhJ3tE1Yo/7dSWuWS3pa7P66+uVu84d+Hp6PokcBBnJ3YoJvMprZRSz5nJt0AGU2/rlpu97v8vFqbcHsB+isXseAErHDjL0AEpVExCyORZVqitSC6R6uGA91GkWh2j8deRDvlXOcsBZ6ckiBm/AE6Gvh5j9PC9R3zeb4EHjb1b9UAua9Fo1tP7n7fs1BveYkSKm6uCL1Y1H59wkGIXIphdUzBvyC3gBYt10JSHvtDUiWaLMIjZsrA9L0dgr71ZNEIAEi7oLs5db/UAAGA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=eoOyul7a; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=eoOyul7a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X48Xd0vRzz2yKD
	for <linux-erofs@lists.ozlabs.org>; Thu, 12 Sep 2024 17:42:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726126922; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=U3zpUFdb+C2ZY/A+Fe1YciE/MRfJO397mZ/cfuh02Kk=;
	b=eoOyul7aY7n6TW/BZrnQtpF2RnvluJVA43VVhICbJScNvPUPrzjhRmUD0nc5lLIMY7rwPT+2IxaNNF7WglN716XwF7QXaN3KJsiTN+tEghIDJHyU3sfS2a2FNEx0SQjhpAV9mC5vkcnlc2icQMAki2fPMoYCF1EZy0cs+mDNc1A=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WEqd5Ck_1726126917)
          by smtp.aliyun-inc.com;
          Thu, 12 Sep 2024 15:42:01 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: restrict pcluster size limitations
Date: Thu, 12 Sep 2024 15:41:56 +0800
Message-ID: <20240912074156.2925394-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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

Error out if {en,de}encoded size of a pcluster is unsupported:
  Maximum supported encoded size (of a pcluster):  1 MiB
  Maximum supported decoded size (of a pcluster): 12 MiB

Users can still choose to use supported large configurations (e.g.,
for archival purposes), but there may be performance penalties in
low-memory scenarios compared to smaller pclusters.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/erofs_fs.h |  5 ++++-
 fs/erofs/zmap.c     | 42 ++++++++++++++++++++----------------------
 2 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 6c0c270c42e1..c8f2ae845bd2 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -288,9 +288,12 @@ struct erofs_dirent {
 
 #define EROFS_NAME_LEN      255
 
-/* maximum supported size of a physical compression cluster */
+/* maximum supported encoded size of a physical compressed cluster */
 #define Z_EROFS_PCLUSTER_MAX_SIZE	(1024 * 1024)
 
+/* maximum supported decoded size of a physical compressed cluster */
+#define Z_EROFS_PCLUSTER_MAX_DSIZE	(12 * 1024 * 1024)
+
 /* available compression algorithm types (for h_algorithmtype) */
 enum {
 	Z_EROFS_COMPRESSION_LZ4		= 0,
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 403af6e31d5b..e980e29873a5 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -687,32 +687,30 @@ int z_erofs_map_blocks_iter(struct inode *inode, struct erofs_map_blocks *map,
 	int err = 0;
 
 	trace_erofs_map_blocks_enter(inode, map, flags);
-
-	/* when trying to read beyond EOF, leave it unmapped */
-	if (map->m_la >= inode->i_size) {
+	if (map->m_la >= inode->i_size) {	/* post-EOF unmapped extent */
 		map->m_llen = map->m_la + 1 - inode->i_size;
 		map->m_la = inode->i_size;
 		map->m_flags = 0;
-		goto out;
-	}
-
-	err = z_erofs_fill_inode_lazy(inode);
-	if (err)
-		goto out;
-
-	if ((vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER) &&
-	    !vi->z_tailextent_headlcn) {
-		map->m_la = 0;
-		map->m_llen = inode->i_size;
-		map->m_flags = EROFS_MAP_MAPPED | EROFS_MAP_FULL_MAPPED |
-				EROFS_MAP_FRAGMENT;
-		goto out;
+	} else {
+		err = z_erofs_fill_inode_lazy(inode);
+		if (!err) {
+			if ((vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER) &&
+			    !vi->z_tailextent_headlcn) {
+				map->m_la = 0;
+				map->m_llen = inode->i_size;
+				map->m_flags = EROFS_MAP_MAPPED |
+					EROFS_MAP_FULL_MAPPED | EROFS_MAP_FRAGMENT;
+			} else {
+				err = z_erofs_do_map_blocks(inode, map, flags);
+			}
+		}
+		if (!err && (map->m_flags & EROFS_MAP_ENCODED) &&
+		    unlikely(map->m_plen > Z_EROFS_PCLUSTER_MAX_SIZE ||
+			     map->m_llen > Z_EROFS_PCLUSTER_MAX_DSIZE))
+			err = -EOPNOTSUPP;
+		if (err)
+			map->m_llen = 0;
 	}
-
-	err = z_erofs_do_map_blocks(inode, map, flags);
-out:
-	if (err)
-		map->m_llen = 0;
 	trace_erofs_map_blocks_exit(inode, map, flags, err);
 	return err;
 }
-- 
2.43.5

