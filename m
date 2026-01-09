Return-Path: <linux-erofs+bounces-1794-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11913D08A49
	for <lists+linux-erofs@lfdr.de>; Fri, 09 Jan 2026 11:42:09 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dndcd5mDfz2yFk;
	Fri, 09 Jan 2026 21:41:53 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.224
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767955313;
	cv=none; b=bv/iKlHuA9CWnH7v/qLvkd7ey9Hy6ZE7w6cw5SIEY9bqO30dJlNtK0w8MQVXaN4BsJQ/vEAE7gW52RGbxeapqOYGKCPV/YTP/gXIoI41d/b2jANHRxU5IpBjOY6b8G2W2zF4TizH48GW6ugk+13JPSuSQ1bD0nrAmL56ACA1XuSoRnf32vmNSXbm9dShgSwNWaKx/gO5ItLAr2cCnsx8MMZJUkM9FxnGERvMz2+1H+KKkldoxroLc/AOWvfZlbxxZVlSDJXQ94s25d6Qj7wc8M9atwBXShqCbZXCq1KiKGcV1uqjR1uhDHHN5q8iyBHAeo4IUaH44Gprc+j0luWT0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767955313; c=relaxed/relaxed;
	bh=R7ApHnfNiBchhGXf8a8E/bOiMkaOH3q7V/YSP7S/uow=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bFWq6rFhvowX+lf5EjTyfZhPN5tAnKs9dn3yWWMfCKwsx56coRTHitAncrtukQ1J3zNAof9FEyqd3pLXL/9Qe97SqDD85X5yux/VmTypkMWY0d7DUMhW9obIu1Dv2OvSWesJnGv03rRdwjssY0I1vzadGn3brDkfa5ubsYwpaN/ApgE9hXMzdwARAzk9qyLvqjdHy5s9WDJSuVn9k1khSMdI84LhHZuUhjkGdxYMtgkGN3gHl6O9RDwWp37OO+zOojzY/yYsDoUxEaM8mEznwTkILK6LzZx8G7orhSrx8VW+h7RVpBIKO/x8+goxc2Zc0G1oBbBrFZ34BeV/aV16sg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=VpLGGUGK; dkim-atps=neutral; spf=pass (client-ip=113.46.200.224; helo=canpmsgout09.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=VpLGGUGK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.224; helo=canpmsgout09.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dndcW2TgTz2yFl
	for <linux-erofs@lists.ozlabs.org>; Fri, 09 Jan 2026 21:41:47 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=R7ApHnfNiBchhGXf8a8E/bOiMkaOH3q7V/YSP7S/uow=;
	b=VpLGGUGK+sRa0H7ow0v8gH347fWJZpEHkyBZ3bykf3XfoVbM3NPW+A+CBiyS787GwG0uZeAsy
	ruololEhaWwkPw29RrTxowpDFgVzkkLk4xJ2sTZwI9Q4ua+/fGcOQsKa6W7kUNaxDZdizCESOW3
	zJu9mBU9EfwJBzx/UWj/eLE=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4dndXf1GM5z1cyQq;
	Fri,  9 Jan 2026 18:38:26 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 4F37540536;
	Fri,  9 Jan 2026 18:41:42 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 9 Jan
 2026 18:41:41 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>
CC: <djwong@kernel.org>, <amir73il@gmail.com>, <hch@lst.de>,
	<linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH v14 05/10] erofs: support user-defined fingerprint name
Date: Fri, 9 Jan 2026 10:28:51 +0000
Message-ID: <20260109102856.598531-6-lihongbo22@huawei.com>
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

When creating the EROFS image, users can specify the fingerprint name.
This is to prepare for the upcoming inode page cache share.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/Kconfig    |  9 +++++++++
 fs/erofs/erofs_fs.h |  5 +++--
 fs/erofs/internal.h |  2 ++
 fs/erofs/super.c    |  9 +++++++++
 fs/erofs/xattr.c    | 13 +++++++++++++
 5 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index d81f3318417d..b71f2a8074fe 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -194,3 +194,12 @@ config EROFS_FS_PCPU_KTHREAD_HIPRI
 	  at higher priority.
 
 	  If unsure, say N.
+
+config EROFS_FS_PAGE_CACHE_SHARE
+	bool "EROFS page cache share support (experimental)"
+	depends on EROFS_FS && EROFS_FS_XATTR && !EROFS_FS_ONDEMAND
+	help
+	  This enables page cache sharing among inodes with identical
+	  content fingerprints on the same machine.
+
+	  If unsure, say N.
diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index e24268acdd62..b30a74d307c5 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -17,7 +17,7 @@
 #define EROFS_FEATURE_COMPAT_XATTR_FILTER		0x00000004
 #define EROFS_FEATURE_COMPAT_SHARED_EA_IN_METABOX	0x00000008
 #define EROFS_FEATURE_COMPAT_PLAIN_XATTR_PFX		0x00000010
-
+#define EROFS_FEATURE_COMPAT_ISHARE_XATTRS		0x00000020
 
 /*
  * Any bits that aren't in EROFS_ALL_FEATURE_INCOMPAT should
@@ -83,7 +83,8 @@ struct erofs_super_block {
 	__le32 xattr_prefix_start;	/* start of long xattr prefixes */
 	__le64 packed_nid;	/* nid of the special packed inode */
 	__u8 xattr_filter_reserved; /* reserved for xattr name filter */
-	__u8 reserved[3];
+	__u8 ishare_xattr_prefix_id;
+	__u8 reserved[2];
 	__le32 build_time;	/* seconds added to epoch for mkfs time */
 	__le64 rootnid_8b;	/* (48BIT on) nid of root directory */
 	__le64 reserved2;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 98fe652aea33..ec79e8b44d3b 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -134,6 +134,7 @@ struct erofs_sb_info {
 	u32 xattr_blkaddr;
 	u32 xattr_prefix_start;
 	u8 xattr_prefix_count;
+	u8 ishare_xattr_prefix_id;
 	struct erofs_xattr_prefix_item *xattr_prefixes;
 	unsigned int xattr_filter_reserved;
 #endif
@@ -238,6 +239,7 @@ EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
 EROFS_FEATURE_FUNCS(shared_ea_in_metabox, compat, COMPAT_SHARED_EA_IN_METABOX)
 EROFS_FEATURE_FUNCS(plain_xattr_pfx, compat, COMPAT_PLAIN_XATTR_PFX)
+EROFS_FEATURE_FUNCS(ishare_xattrs, compat, COMPAT_ISHARE_XATTRS)
 
 static inline u64 erofs_nid_to_ino64(struct erofs_sb_info *sbi, erofs_nid_t nid)
 {
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index f18f43b78fca..dca1445f6c92 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -320,6 +320,15 @@ static int erofs_read_superblock(struct super_block *sb)
 	sbi->xattr_prefix_start = le32_to_cpu(dsb->xattr_prefix_start);
 	sbi->xattr_prefix_count = dsb->xattr_prefix_count;
 	sbi->xattr_filter_reserved = dsb->xattr_filter_reserved;
+	if (erofs_sb_has_ishare_xattrs(sbi)) {
+		if (dsb->ishare_xattr_prefix_id >= sbi->xattr_prefix_count) {
+			erofs_err(sb, "invalid ishare xattr prefix id %u",
+				  dsb->ishare_xattr_prefix_id);
+			ret = -EFSCORRUPTED;
+			goto out;
+		}
+		sbi->ishare_xattr_prefix_id = dsb->ishare_xattr_prefix_id;
+	}
 #endif
 	sbi->islotbits = ilog2(sizeof(struct erofs_inode_compact));
 	if (erofs_sb_has_48bit(sbi) && dsb->rootnid_8b) {
diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 396536d9a862..ae61f20cb861 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -519,6 +519,19 @@ int erofs_xattr_prefixes_init(struct super_block *sb)
 	}
 
 	erofs_put_metabuf(&buf);
+	if (!ret && erofs_sb_has_ishare_xattrs(sbi)) {
+		struct erofs_xattr_prefix_item *pf = pfs + sbi->ishare_xattr_prefix_id;
+		struct erofs_xattr_long_prefix *newpfx;
+
+		newpfx = krealloc(pf->prefix,
+			sizeof(*newpfx) + pf->infix_len + 1, GFP_KERNEL);
+		if (newpfx) {
+			newpfx->infix[pf->infix_len] = '\0';
+			pf->prefix = newpfx;
+		} else {
+			ret = -ENOMEM;
+		}
+	}
 	sbi->xattr_prefixes = pfs;
 	if (ret)
 		erofs_xattr_prefixes_cleanup(sb);
-- 
2.22.0


