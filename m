Return-Path: <linux-erofs+bounces-1791-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BC885D08A42
	for <lists+linux-erofs@lfdr.de>; Fri, 09 Jan 2026 11:42:04 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dndcc4CjRz2yG2;
	Fri, 09 Jan 2026 21:41:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.226
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767955312;
	cv=none; b=KAM9M2Um62l/WJts5eSPqSAJsAdy4QVTcrucr+eUNG/VykfoHqbTSYv6ot8zoCHuLK+omsbUsWun79k1eKzx/QwgqeCO4S56zkiBxaiWPDIc7kF23uKoHzqlRvnOa3R8jFhMYQGIGfifBNpzZ1rrLvMZg0UNgWmwwCNOk1qKwt4pmMh5/yZG6JkOBiiDOj6TkmlwFN6cYJsKaDp7wZsRRy4H8xW4phD4t0+N5A5e2h2K4hIdAtUSEDnd4D+X9TBxA8M4fwSVfg+NE+JzCE0PQn3a9BtacRJp+fV6vcayrYQRTQckbZ+1ngmq0FbXoyEYCPI9NaXJPaHNXTcrFeARrw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767955312; c=relaxed/relaxed;
	bh=15hkKSfpgVy2Gef7Z9q+RsD0COZ3AO40LmW6kBeI3K8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cIS5xLZfznJNF6XCbwyb/WzFJigoF/dCldu+kyVZRPzBSoOhCbPHyWCbU02dHrfjcYn47vjTIE5l5ZfKimufPE+qo+yzgMLV09eUZCF6fogi25qFUbJDjgapqirMcu/MalUlACC2gPclgQTSQCpljjxZVyVZOilG/hAX+Ol0S4wMIBV9I04jziJdKz8XGTFy08/ypWSmqTsdvRMm0jQ/NB4/nR9NseyzmYzBSj3408FQADX1FtoYEZUKi4lmaqz1Y4gac8P9aCbPysBdbfWWTvN7FppjES9o4HojjK6rdrwvekNYgKnwWr+6GNIWZdSvgi6UHTG7gutpYtxsx4hIpg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Z24fuybK; dkim-atps=neutral; spf=pass (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Z24fuybK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dndcW57zkz2yFm
	for <linux-erofs@lists.ozlabs.org>; Fri, 09 Jan 2026 21:41:47 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=15hkKSfpgVy2Gef7Z9q+RsD0COZ3AO40LmW6kBeI3K8=;
	b=Z24fuybKF60Tlz4KzAHSBpEOo5qJMuL4Lcgr6nwiTD95TkIijnNP8gBhL/2x9w+n9crNKf4Bu
	Fl6VAoF9hEHUv2PIYRZIsVob3/1wfLZFXbzQH/+GvSqV7b7epC64q0NgC5+6b95Wryxkyij9tj6
	ILln8auSlAxQip0Dup90qLA=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dndXf4y6bzKm4b;
	Fri,  9 Jan 2026 18:38:26 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 00FBB40562;
	Fri,  9 Jan 2026 18:41:44 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 9 Jan
 2026 18:41:43 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>
CC: <djwong@kernel.org>, <amir73il@gmail.com>, <hch@lst.de>,
	<linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH v14 09/10] erofs: support compressed inodes for page cache share
Date: Fri, 9 Jan 2026 10:28:55 +0000
Message-ID: <20260109102856.598531-10-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20260109102856.598531-1-lihongbo22@huawei.com>
References: <20260109102856.598531-1-lihongbo22@huawei.com>
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
Content-Type: text/plain
X-Originating-IP: [10.67.174.162]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: Hongzhen Luo <hongzhen@linux.alibaba.com>

This patch adds page cache sharing functionality for compressed inodes.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/erofs/ishare.c |  2 --
 fs/erofs/zdata.c  | 38 ++++++++++++++++++++++++--------------
 2 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
index 24bbd6a7a900..366f0d79e008 100644
--- a/fs/erofs/ishare.c
+++ b/fs/erofs/ishare.c
@@ -44,8 +44,6 @@ bool erofs_ishare_fill_inode(struct inode *inode)
 	struct inode *sharedinode;
 	unsigned long hash;
 
-	if (erofs_inode_is_data_compressed(vi->datalayout))
-		return false;
 	if (erofs_xattr_fill_inode_fingerprint(&fp, inode, sbi->domain_id))
 		return false;
 	hash = xxh32(fp.opaque, fp.size, 0);
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 93ab6a481b64..59ee9a36d9eb 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -493,7 +493,7 @@ enum z_erofs_pclustermode {
 };
 
 struct z_erofs_frontend {
-	struct inode *const inode;
+	struct inode *inode, *sharedinode;
 	struct erofs_map_blocks map;
 	struct z_erofs_bvec_iter biter;
 
@@ -508,8 +508,8 @@ struct z_erofs_frontend {
 	unsigned int icur;
 };
 
-#define Z_EROFS_DEFINE_FRONTEND(fe, i, ho) struct z_erofs_frontend fe = { \
-	.inode = i, .head = Z_EROFS_PCLUSTER_TAIL, \
+#define Z_EROFS_DEFINE_FRONTEND(fe, i, si, ho) struct z_erofs_frontend fe = { \
+	.inode = i, .sharedinode = si, .head = Z_EROFS_PCLUSTER_TAIL, \
 	.mode = Z_EROFS_PCLUSTER_FOLLOWED, .headoffset = ho }
 
 static bool z_erofs_should_alloc_cache(struct z_erofs_frontend *fe)
@@ -1866,7 +1866,7 @@ static void z_erofs_pcluster_readmore(struct z_erofs_frontend *f,
 		pgoff_t index = cur >> PAGE_SHIFT;
 		struct folio *folio;
 
-		folio = erofs_grab_folio_nowait(inode->i_mapping, index);
+		folio = erofs_grab_folio_nowait(f->sharedinode->i_mapping, index);
 		if (!IS_ERR_OR_NULL(folio)) {
 			if (folio_test_uptodate(folio))
 				folio_unlock(folio);
@@ -1883,11 +1883,13 @@ static void z_erofs_pcluster_readmore(struct z_erofs_frontend *f,
 
 static int z_erofs_read_folio(struct file *file, struct folio *folio)
 {
-	struct inode *const inode = folio->mapping->host;
-	Z_EROFS_DEFINE_FRONTEND(f, inode, folio_pos(folio));
+	struct inode *sharedinode = folio->mapping->host;
+	bool need_iput;
+	struct inode *realinode = erofs_real_inode(sharedinode, &need_iput);
+	Z_EROFS_DEFINE_FRONTEND(f, realinode, sharedinode, folio_pos(folio));
 	int err;
 
-	trace_erofs_read_folio(inode, folio, false);
+	trace_erofs_read_folio(realinode, folio, false);
 	z_erofs_pcluster_readmore(&f, NULL, true);
 	err = z_erofs_scan_folio(&f, folio, false);
 	z_erofs_pcluster_readmore(&f, NULL, false);
@@ -1896,23 +1898,28 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)
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
+	if (need_iput)
+		iput(realinode);
 	return err;
 }
 
 static void z_erofs_readahead(struct readahead_control *rac)
 {
-	struct inode *const inode = rac->mapping->host;
-	Z_EROFS_DEFINE_FRONTEND(f, inode, readahead_pos(rac));
+	struct inode *sharedinode = rac->mapping->host;
+	bool need_iput;
+	struct inode *realinode = erofs_real_inode(sharedinode, &need_iput);
+	Z_EROFS_DEFINE_FRONTEND(f, realinode, sharedinode, readahead_pos(rac));
 	unsigned int nrpages = readahead_count(rac);
 	struct folio *head = NULL, *folio;
 	int err;
 
-	trace_erofs_readahead(inode, readahead_index(rac), nrpages, false);
+	trace_erofs_readahead(realinode, readahead_index(rac), nrpages, false);
 	z_erofs_pcluster_readmore(&f, rac, true);
 	while ((folio = readahead_folio(rac))) {
 		folio->private = head;
@@ -1926,8 +1933,8 @@ static void z_erofs_readahead(struct readahead_control *rac)
 
 		err = z_erofs_scan_folio(&f, folio, true);
 		if (err && err != -EINTR)
-			erofs_err(inode->i_sb, "readahead error at folio %lu @ nid %llu",
-				  folio->index, EROFS_I(inode)->nid);
+			erofs_err(realinode->i_sb, "readahead error at folio %lu @ nid %llu",
+				  folio->index, EROFS_I(realinode)->nid);
 	}
 	z_erofs_pcluster_readmore(&f, rac, false);
 	z_erofs_pcluster_end(&f);
@@ -1935,6 +1942,9 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	(void)z_erofs_runqueue(&f, nrpages);
 	erofs_put_metabuf(&f.map.buf);
 	erofs_release_pages(&f.pagepool);
+
+	if (need_iput)
+		iput(realinode);
 }
 
 const struct address_space_operations z_erofs_aops = {
-- 
2.22.0


