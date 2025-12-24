Return-Path: <linux-erofs+bounces-1580-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D9851CDB4F3
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Dec 2025 05:22:40 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dbdyM6W3cz2yFl;
	Wed, 24 Dec 2025 15:22:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.218
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766550155;
	cv=none; b=SBOhe2tQJGaixahR/nahJ28Kbk7CZoU8l5DMfOF+pen6gw+yJC8TIv1ZF8hRi0eBIZAm/tzzY5AaHefAOkCPmQZX3KlflE5wR7PQrGiT89Xm3jKW7Zze4EQ1yrX+zXVOdtaLPjtP4083GBS7BrL+qF9rqv+8pPjT40HBQtJTzxCmScCZMK9tCsWv/Phxmdvxxm+q4qkf86B3tqpUSwlJkCKw33iXL2jC6+U1MmRYsQfTAyEsK7MB7x6QYYbYQxOeRornxhtiaq9yH/5gh7q4pO9snteGbHRAZSKix7ZffVzqbDe0sCABM/Wqt0eeA4yfp8X78EdGeriCbrJtN8mRdg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766550155; c=relaxed/relaxed;
	bh=dTQBklqP38GVCIoyDRY/ye9fFsGS5lZwx8F3niDAAyI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hmM6zBdVJvxK0s4i1Ga76L5g6nKwmTIOgDjux/D/pmXVMVrfqnoFWJc/HF5b4d/N33CFDT3UD8zXML97SUrp+cxADLNCb3g0vJQw1zvwCwVb/S/OUWIu6SnlpqcRyl6rDTZLes+pAZKYMxYl14+ERXW+rN8LeEzpIBn/bo9iqVF7L/+BaGKrQRV2J9mbsUn4ngdITW6OccSkTyi5VEzTIk0Gy2x6lq/1hBHvYnePJNwJnWLTev7UvMbKAfzR4EUlX2o7PQ/LSj7N3KfEkAGPAsFn6Vqmn4XZ/RQhQcsKIVUD2ALf5U2M7hgiu4gn3KJ0CeUtaJYqvG2Dx2CIYl+BbA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=xattSqXR; dkim-atps=neutral; spf=pass (client-ip=113.46.200.218; helo=canpmsgout03.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=xattSqXR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.218; helo=canpmsgout03.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dbdyL6V6Lz2yFd
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Dec 2025 15:22:34 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=dTQBklqP38GVCIoyDRY/ye9fFsGS5lZwx8F3niDAAyI=;
	b=xattSqXRHfe9h61fZvROfvHNYTlSXCB8cd42yDMmOaMdtw0UFPSur1cs+5CCmsVDerY1v7qlS
	0W409kpnSiGYxLLJIfLsYUDs0ptl+49kDeZNiuPCp74qp+b+EkJylsDwY6O5N+tFI9IdmYjka/a
	2OuupVHz3vjymm4szW3uRVU=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4dbdtv5lcGzpT06;
	Wed, 24 Dec 2025 12:19:35 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id E7AAA40538;
	Wed, 24 Dec 2025 12:22:31 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 24 Dec
 2025 12:22:31 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>,
	<djwong@kernel.org>, <amir73il@gmail.com>, <hch@lst.de>
CC: <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH v11 09/10] erofs: support compressed inodes for page cache share
Date: Wed, 24 Dec 2025 04:09:31 +0000
Message-ID: <20251224040932.496478-10-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20251224040932.496478-1-lihongbo22@huawei.com>
References: <20251224040932.496478-1-lihongbo22@huawei.com>
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
 fs/erofs/zdata.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 65da21504632..759f3fe225c9 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -493,7 +493,7 @@ enum z_erofs_pclustermode {
 };
 
 struct z_erofs_frontend {
-	struct inode *const inode;
+	struct inode *inode;
 	struct erofs_map_blocks map;
 	struct z_erofs_bvec_iter biter;
 
@@ -1884,9 +1884,13 @@ static void z_erofs_pcluster_readmore(struct z_erofs_frontend *f,
 static int z_erofs_read_folio(struct file *file, struct folio *folio)
 {
 	struct inode *const inode = folio->mapping->host;
-	Z_EROFS_DEFINE_FRONTEND(f, inode, folio_pos(folio));
+	bool need_iput = false;
+	struct inode *realinode = erofs_real_inode(inode, &need_iput);
+	Z_EROFS_DEFINE_FRONTEND(f, NULL, folio_pos(folio));
 	int err;
 
+	DBG_BUGON(!realinode);
+	f.inode = realinode;
 	trace_erofs_read_folio(folio, false);
 	z_erofs_pcluster_readmore(&f, NULL, true);
 	err = z_erofs_scan_folio(&f, folio, false);
@@ -1896,23 +1900,30 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)
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
 	struct inode *const inode = rac->mapping->host;
-	Z_EROFS_DEFINE_FRONTEND(f, inode, readahead_pos(rac));
+	bool need_iput;
+	struct inode *realinode = erofs_real_inode(inode, &need_iput);
+	Z_EROFS_DEFINE_FRONTEND(f, NULL, readahead_pos(rac));
 	unsigned int nrpages = readahead_count(rac);
 	struct folio *head = NULL, *folio;
 	int err;
 
-	trace_erofs_readahead(inode, readahead_index(rac), nrpages, false);
+	DBG_BUGON(!realinode);
+	f.inode = realinode;
+	trace_erofs_readahead(realinode, readahead_index(rac), nrpages, false);
 	z_erofs_pcluster_readmore(&f, rac, true);
 	while ((folio = readahead_folio(rac))) {
 		folio->private = head;
@@ -1926,8 +1937,8 @@ static void z_erofs_readahead(struct readahead_control *rac)
 
 		err = z_erofs_scan_folio(&f, folio, true);
 		if (err && err != -EINTR)
-			erofs_err(inode->i_sb, "readahead error at folio %lu @ nid %llu",
-				  folio->index, EROFS_I(inode)->nid);
+			erofs_err(realinode->i_sb, "readahead error at folio %lu @ nid %llu",
+				  folio->index, EROFS_I(realinode)->nid);
 	}
 	z_erofs_pcluster_readmore(&f, rac, false);
 	z_erofs_pcluster_end(&f);
@@ -1935,6 +1946,9 @@ static void z_erofs_readahead(struct readahead_control *rac)
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


