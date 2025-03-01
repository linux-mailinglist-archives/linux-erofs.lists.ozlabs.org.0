Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E49E5A4AC67
	for <lists+linux-erofs@lfdr.de>; Sat,  1 Mar 2025 15:50:40 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z4p0S2h8Vz3d3W
	for <lists+linux-erofs@lfdr.de>; Sun,  2 Mar 2025 01:50:32 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740840626;
	cv=none; b=Eauhnjt9k0MLe221MdzwxKe7cLycIT5K0U6xip6aWIXQPrp8U8bglCs1jqrHWXT2j5inoqzUpEpPZwHmDBEaX3tHy+kBBMQxCBSwWINNZg3GTjLvEN+m8rAV1RvPRfuDqNVrXShgXnk1poMZQjAytNeN0a3cbv5hy0Ae29Ds2CiWgA3glLxSgzlqkq5/OwOv3ri6o9zdZvEg1rpEBoZhwwlthWzF4uCEfBR1Gr8MzsUxaButTCys/5/J23+Un0WQa5uHW1G/iYFqWb96fDN9cteIPzxzLRytR12OpHXdVy1sYQccnvo1BfMIgEkD7rqm/GSBW8z+5Gf4RCJr26K/9w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740840626; c=relaxed/relaxed;
	bh=LsN4AVILIAF5l64ooZXWfDVtzbln1b/ogW51HXy4MRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XzyzmO4Re531+NiVoyxJw7ewKrIB6nBTEi6xLDCvh3n8lf0pcvoK8IRyrYd7s4kifn+YvcnZDS9o8sGII+p1uyN9HUeKggwH7iOCbLk403JzbUXgKQO39D885+EI+L9bGnzfIZg1KzSK+28H/My6JQLC6GVwVrgUBJ0IcfXnc/B+pIDUGuGPlzHHPUXMChZyRtFJWpFeK8V5lV8AkL6heWBuoNS1yE/7jqAE6OX+Ig41YSu7nnoLX3df0IFR70H/2XpGKrAKvw5KXBNO4hBXwyaxHg42IrBCJ52Vhs3dkQGTD/nwpfd3+YruLZD5QuPoXMAebiYI/UbtesDJRAxTyQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=B5F3CPmV; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=B5F3CPmV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z4p0G24HXz2xGC
	for <linux-erofs@lists.ozlabs.org>; Sun,  2 Mar 2025 01:50:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740840618; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=LsN4AVILIAF5l64ooZXWfDVtzbln1b/ogW51HXy4MRg=;
	b=B5F3CPmVrptC4nafYB2La266UwPWmytf4kxNsaAjWBilVE27yjdkNVnfio9nxU+FzaP8WO+ibfoCofF3eNaLecfhN1Sei7ysc74u1rbmQLtxn9Tj4I4Y/A/GZ3OSmRlqC4P3leG5cLJPdHKHugbp4AB41YoXKmsKmH7QsCuvKj8=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WQSfpYr_1740840617 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 01 Mar 2025 22:50:17 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH v6 6/7] erofs: support compressed inodes for page cache share
Date: Sat,  1 Mar 2025 22:49:43 +0800
Message-ID: <20250301145002.2420830-7-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250301145002.2420830-1-hongzhen@linux.alibaba.com>
References: <20250301145002.2420830-1-hongzhen@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This patch adds page cache sharing functionality for compressed inodes.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
 fs/erofs/zdata.c | 57 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 47 insertions(+), 10 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index aff09f94afb2..b6383cb26acb 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2022 Alibaba Cloud
  */
 #include "compress.h"
+#include "ishare.h"
 #include <linux/psi.h>
 #include <linux/cpuhotplug.h>
 #include <trace/events/erofs.h>
@@ -474,7 +475,7 @@ enum z_erofs_pclustermode {
 };
 
 struct z_erofs_frontend {
-	struct inode *const inode;
+	struct inode *inode;
 	struct erofs_map_blocks map;
 	struct z_erofs_bvec_iter biter;
 
@@ -1835,11 +1836,24 @@ static void z_erofs_pcluster_readmore(struct z_erofs_frontend *f,
 
 static int z_erofs_read_folio(struct file *file, struct folio *folio)
 {
-	struct inode *const inode = folio->mapping->host;
-	Z_EROFS_DEFINE_FRONTEND(f, inode, folio_pos(folio));
+	struct inode *const inode = folio->mapping->host, *realinode;
+	Z_EROFS_DEFINE_FRONTEND(f, NULL, folio_pos(folio));
+	struct erofs_read_ctx rdctx = {
+		.file = file,
+		.inode = inode,
+	};
 	int err;
 
 	trace_erofs_read_folio(folio, false);
+
+	erofs_read_begin(&rdctx);
+
+	if (erofs_is_ishare_inode(inode))
+		realinode = erofs_ishare_iget(inode);
+	else
+		realinode = inode;
+
+	f.inode = realinode;
 	z_erofs_pcluster_readmore(&f, NULL, true);
 	err = z_erofs_scan_folio(&f, folio, false);
 	z_erofs_pcluster_readmore(&f, NULL, false);
@@ -1848,25 +1862,43 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)
 	/* if some pclusters are ready, need submit them anyway */
 	err = z_erofs_runqueue(&f, 0) ?: err;
 	if (err && err != -EINTR)
-		erofs_err(inode->i_sb, "read error %d @ %lu of nid %llu",
-			  err, folio->index, EROFS_I(inode)->nid);
+		erofs_err(realinode->i_sb, "read error %d @ %lu of nid %llu",
+			  err, folio->index, EROFS_I(realinode)->nid);
 
 	erofs_put_metabuf(&f.map.buf);
 	erofs_release_pages(&f.pagepool);
+
+	if (erofs_is_ishare_inode(inode))
+		erofs_ishare_iput(realinode);
+
+	erofs_read_end(&rdctx);
+
 	return err;
 }
 
 static void z_erofs_readahead(struct readahead_control *rac)
 {
-	struct inode *const inode = rac->mapping->host;
-	Z_EROFS_DEFINE_FRONTEND(f, inode, readahead_pos(rac));
+	struct inode *const inode = rac->mapping->host, *realinode;
+	Z_EROFS_DEFINE_FRONTEND(f, NULL, readahead_pos(rac));
 	struct folio *head = NULL, *folio;
 	unsigned int nrpages = readahead_count(rac);
+	struct erofs_read_ctx rdctx = {
+		.file = rac->file,
+		.inode = inode,
+	};
 	int err;
 
+	erofs_read_begin(&rdctx);
+
+	if (erofs_is_ishare_inode(inode))
+		realinode = erofs_ishare_iget(inode);
+	else
+		realinode = inode;
+
+	f.inode = realinode;
 	z_erofs_pcluster_readmore(&f, rac, true);
 	nrpages = readahead_count(rac);
-	trace_erofs_readpages(inode, readahead_index(rac), nrpages, false);
+	trace_erofs_readpages(realinode, readahead_index(rac), nrpages, false);
 	while ((folio = readahead_folio(rac))) {
 		folio->private = head;
 		head = folio;
@@ -1879,8 +1911,8 @@ static void z_erofs_readahead(struct readahead_control *rac)
 
 		err = z_erofs_scan_folio(&f, folio, true);
 		if (err && err != -EINTR)
-			erofs_err(inode->i_sb, "readahead error at folio %lu @ nid %llu",
-				  folio->index, EROFS_I(inode)->nid);
+			erofs_err(realinode->i_sb, "readahead error at folio %lu @ nid %llu",
+				  folio->index, EROFS_I(realinode)->nid);
 	}
 	z_erofs_pcluster_readmore(&f, rac, false);
 	z_erofs_pcluster_end(&f);
@@ -1888,6 +1920,11 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	(void)z_erofs_runqueue(&f, nrpages);
 	erofs_put_metabuf(&f.map.buf);
 	erofs_release_pages(&f.pagepool);
+
+	if (erofs_is_ishare_inode(inode))
+		erofs_ishare_iput(realinode);
+
+	erofs_read_end(&rdctx);
 }
 
 const struct address_space_operations z_erofs_aops = {
-- 
2.43.5

