Return-Path: <linux-erofs+bounces-1769-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B1449D06F18
	for <lists+linux-erofs@lfdr.de>; Fri, 09 Jan 2026 04:15:18 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dnRj75bz5z2yFy;
	Fri, 09 Jan 2026 14:15:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.218
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767928507;
	cv=none; b=D4er2VdvEYuwCfsTtSHGhbBFXgCYhVcpldHbl/U+3f80uAFYBxi/G6qbJ4KkQuhVAJrMh+xRJBO1SO7G/Z/zKuqbpe1rSGgoU+P/QuEj4WVPY8nsWYdBUIAjTHU/gT/g3g2rruWxecFK+IEn+2C9VJJsm5J7YOqWbEMMZH3hsfClB4oBHU2lvJK2mwrzOjtlsdVJ7TiMtHK/4iGSEyFKOJ6S1886N5RZZtjPxOjt+1SSgwFSPExq6tM4qgIlFDY7TEjxbCdWFHCCvqORKUEl1AVODA5qMGBVUrTh4R9rVWCndiuFq1hWw379x/1/KnjU/dD0FweKrCuQ05cZMAfmhg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767928507; c=relaxed/relaxed;
	bh=hQ8B+kTJ87A5bJZYLMwSH+1zUPwX+xL11pHpPAvyQBc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AYnB6uDvYCdkhSHx65y4EJl9LoIUmPYTCD/2T6b4+3rQ8NYyMc3mQbh4ROxUQvMhiSmrKwkf4UuzdyZ4yuXPd6H1ZRWiZhKPno5PRh8JekNUFhm9dYH1HDdhH15ierv5H3cbTM03zSULF9Jg2ipp+pmdrj7SMIr/1Z7SdM6e3+bVtsGTY88eUa7XC9FLAmk03s1LAswGB9KApknjLk9GaIW551NZIaAuKl5le5+BIhzkzi/SHprIIKII5SaUVnd5rAWByaDO1dYY34XDnR9gcoheu4usInh/VtpuAEdWemiX1NHHMVHgiabim9YZDRjWDmH24vDJH3NU02zMLJQ/qA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=hUIhslzj; dkim-atps=neutral; spf=pass (client-ip=113.46.200.218; helo=canpmsgout03.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=hUIhslzj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.218; helo=canpmsgout03.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dnRhy6Cc6z2yFs
	for <linux-erofs@lists.ozlabs.org>; Fri, 09 Jan 2026 14:14:58 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=hQ8B+kTJ87A5bJZYLMwSH+1zUPwX+xL11pHpPAvyQBc=;
	b=hUIhslzjt+3TiLa4Crz2+1YnA91y/cGKGQTyech0JJnAPNHvsHF+2TckCPxjmEZl/eywQaxv1
	LY/cPzAWdwuceaZe2HTeYECY0LdqlqdpyOL5mkxbNWs0RFlF/gDYq+Gv6FcAF8TWMHxW4MOjvUY
	euvz90ggx++3rtD+NGzdA9c=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4dnRcz4wpjzpSyw;
	Fri,  9 Jan 2026 11:11:31 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id EC6894036C;
	Fri,  9 Jan 2026 11:14:55 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 9 Jan
 2026 11:14:55 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>
CC: <djwong@kernel.org>, <amir73il@gmail.com>, <hch@lst.de>,
	<linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH v13 09/10] erofs: support compressed inodes for page cache share
Date: Fri, 9 Jan 2026 03:01:39 +0000
Message-ID: <20260109030140.594936-10-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20260109030140.594936-1-lihongbo22@huawei.com>
References: <20260109030140.594936-1-lihongbo22@huawei.com>
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
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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
 fs/erofs/zdata.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 3d31f7840ca0..62d9dca90822 100644
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
@@ -1883,8 +1883,10 @@ static void z_erofs_pcluster_readmore(struct z_erofs_frontend *f,
 
 static int z_erofs_read_folio(struct file *file, struct folio *folio)
 {
-	struct inode *const inode = folio->mapping->host;
-	Z_EROFS_DEFINE_FRONTEND(f, inode, folio_pos(folio));
+	struct inode *sharedinode = folio->mapping->host;
+	bool need_iput;
+	struct inode *realinode = erofs_real_inode(sharedinode, &need_iput);
+	Z_EROFS_DEFINE_FRONTEND(f, realinode, sharedinode, folio_pos(folio));
 	int err;
 
 	trace_erofs_read_folio(folio, false);
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


