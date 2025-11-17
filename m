Return-Path: <linux-erofs+bounces-1394-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A754FC64648
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Nov 2025 14:37:34 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d981h5cfCz2yv9;
	Tue, 18 Nov 2025 00:37:28 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.221
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763386648;
	cv=none; b=VuVDGgPTTJErchRqUx0FmeF+YWGdgIeJtHfUVFl/0vhPHRjTpiW75RY4DxFe20nJDmde6upQ4V00n46d+eH2ZWEm8CERaBMF9swApx9FGj9NL1P4ggHk1GWvKDo+ABxb24CQUanrheB1mkMsNLFodabpuWPePcAyS8W5qZ+gH9ek37d5kRkijiCUQVbcBTc6gpXbylG3m5cz3luy2npHqocxROVnx+X8nLt8Udd8fHPPHoMhDPJZ4D1Ses4Ukdxmd1hs5ElUjTw1ESqlJ7H8A6AETRbFzud0IFsacOgzmjgR5NwKRZUTntjXsG1pqHjSROn9MNZjBwF2StIQXrX7ww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763386648; c=relaxed/relaxed;
	bh=+yTAZNkUZ6BJVhksgxaanaIqjrrIgHHIwTRXiBhCoe4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AhHbyqlJA5uJMhxlzI75L2JnxBHfgJ64nLbYGymCyYiwuqOXHrRZEmE/rXMuE5yJdgoWv7zZ2hTLtgqjtd1kp100WVi+rVpacA2yuA+6+7+6KjQ/UPLVAIHcEz/vCqwQmomIFqJMpnb8JtxiY35ZPVi753d4FXEBxIjZoEsKR8xeXPc8Oz4nNcwqr6FB/noB9UUa/C3NOFsR2rZMBK6IG0Sci2H9wZEVBwVAjtFFjm5DJ8GLJg1NUEeGnGTpVdwg4iB/6/ue22qcSnLkKnjVhvmSarOpc/rudo6aq4c+Irvb82hCAsHBADivUcqsHvw2p+GSybWY+8ArmrQudkQ4Nw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=1bTGghAn; dkim-atps=neutral; spf=pass (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=1bTGghAn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d981c50k5z302l
	for <linux-erofs@lists.ozlabs.org>; Tue, 18 Nov 2025 00:37:24 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=+yTAZNkUZ6BJVhksgxaanaIqjrrIgHHIwTRXiBhCoe4=;
	b=1bTGghAnrzxS0UD9Jne+KfXgyEcOMlZMCNE1RPXycNBiBDOTgNy527uiPsOGy0y/l9Riuq4Ag
	B/xmFlKECrNDsKpuXfk+s1dk8oEAfxpCmvT0Z/Yqt8vB4kDy/+HTeCev2RMQGO6u2C3OwejsOIu
	5wOjzw5f982xBPLjnQTds0I=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4d97zW4GJSzRhrk;
	Mon, 17 Nov 2025 21:35:35 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id D0AC8140132;
	Mon, 17 Nov 2025 21:37:17 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 17 Nov
 2025 21:37:17 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>,
	<djwong@kernel.org>, <amir73il@gmail.com>, <joannelkoong@gmail.com>
CC: <lihongbo22@huawei.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 05/10] erofs: support user-defined fingerprint name
Date: Mon, 17 Nov 2025 13:25:32 +0000
Message-ID: <20251117132537.227116-6-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20251117132537.227116-1-lihongbo22@huawei.com>
References: <20251117132537.227116-1-lihongbo22@huawei.com>
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
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
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
---
 fs/erofs/Kconfig    |  9 +++++++++
 fs/erofs/erofs_fs.h |  6 ++++--
 fs/erofs/internal.h |  2 ++
 fs/erofs/super.c    |  5 +++--
 fs/erofs/xattr.c    | 15 +++++++++++++++
 5 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index d81f3318417d..c88b6d0714a4 100644
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
+	  content fingerprints on the same device.
+
+	  If unsure, say N.
diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 3d5738f80072..9b9fe1abe0b9 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -35,8 +35,9 @@
 #define EROFS_FEATURE_INCOMPAT_XATTR_PREFIXES	0x00000040
 #define EROFS_FEATURE_INCOMPAT_48BIT		0x00000080
 #define EROFS_FEATURE_INCOMPAT_METABOX		0x00000100
+#define EROFS_FEATURE_INCOMPAT_ISHARE_KEY	0x00000200
 #define EROFS_ALL_FEATURE_INCOMPAT		\
-	((EROFS_FEATURE_INCOMPAT_METABOX << 1) - 1)
+	((EROFS_FEATURE_INCOMPAT_ISHARE_KEY << 1) - 1)
 
 #define EROFS_SB_EXTSLOT_SIZE	16
 
@@ -83,7 +84,8 @@ struct erofs_super_block {
 	__le32 xattr_prefix_start;	/* start of long xattr prefixes */
 	__le64 packed_nid;	/* nid of the special packed inode */
 	__u8 xattr_filter_reserved; /* reserved for xattr name filter */
-	__u8 reserved[3];
+	__u8 ishare_xattr_prefix_id;	/* indice the ishare key in prefix xattr */
+	__u8 reserved[2];
 	__le32 build_time;	/* seconds added to epoch for mkfs time */
 	__le64 rootnid_8b;	/* (48BIT on) nid of root directory */
 	__le64 reserved2;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 98fe652aea33..3033252211ba 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -134,6 +134,7 @@ struct erofs_sb_info {
 	u32 xattr_blkaddr;
 	u32 xattr_prefix_start;
 	u8 xattr_prefix_count;
+	u8 ishare_xattr_pfx;	/* ishare prefix xattr index */
 	struct erofs_xattr_prefix_item *xattr_prefixes;
 	unsigned int xattr_filter_reserved;
 #endif
@@ -234,6 +235,7 @@ EROFS_FEATURE_FUNCS(dedupe, incompat, INCOMPAT_DEDUPE)
 EROFS_FEATURE_FUNCS(xattr_prefixes, incompat, INCOMPAT_XATTR_PREFIXES)
 EROFS_FEATURE_FUNCS(48bit, incompat, INCOMPAT_48BIT)
 EROFS_FEATURE_FUNCS(metabox, incompat, INCOMPAT_METABOX)
+EROFS_FEATURE_FUNCS(ishare_key, incompat, INCOMPAT_ISHARE_KEY)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
 EROFS_FEATURE_FUNCS(shared_ea_in_metabox, compat, COMPAT_SHARED_EA_IN_METABOX)
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 0d88c04684b9..80f032cb2cc3 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -298,6 +298,9 @@ static int erofs_read_superblock(struct super_block *sb)
 		if (ret)
 			goto out;
 	}
+	if (erofs_sb_has_ishare_key(sbi))
+		sbi->ishare_xattr_pfx =
+			dsb->ishare_xattr_prefix_id & EROFS_XATTR_LONG_PREFIX_MASK;
 
 	ret = -EINVAL;
 	sbi->feature_incompat = le32_to_cpu(dsb->feature_incompat);
@@ -339,7 +342,6 @@ static int erofs_read_superblock(struct super_block *sb)
 			return -EFSCORRUPTED;	/* self-loop detection */
 	}
 	sbi->inos = le64_to_cpu(dsb->inos);
-
 	sbi->epoch = (s64)le64_to_cpu(dsb->epoch);
 	sbi->fixed_nsec = le32_to_cpu(dsb->fixed_nsec);
 	super_set_uuid(sb, (void *)dsb->uuid, sizeof(dsb->uuid));
@@ -737,7 +739,6 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	err = erofs_xattr_prefixes_init(sb);
 	if (err)
 		return err;
-
 	erofs_set_sysfs_name(sb);
 	err = erofs_register_sysfs(sb);
 	if (err)
diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 396536d9a862..6cb76313c14c 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -519,6 +519,21 @@ int erofs_xattr_prefixes_init(struct super_block *sb)
 	}
 
 	erofs_put_metabuf(&buf);
+	if (!ret && erofs_sb_has_ishare_key(sbi)) {
+		struct erofs_xattr_long_prefix *new_pfx, *pfx =
+					pfs[sbi->ishare_xattr_pfx].prefix;
+
+		new_pfx = krealloc(pfx,
+				   sizeof(struct erofs_xattr_long_prefix) +
+				   pfs[sbi->ishare_xattr_pfx].infix_len + 1,
+				   GFP_KERNEL);
+		if (new_pfx) {
+			new_pfx->infix[pfs[sbi->ishare_xattr_pfx].infix_len] = '\0';
+			pfs[sbi->ishare_xattr_pfx].prefix = new_pfx;
+		} else {
+			ret = -ENOMEM;
+		}
+	}
 	sbi->xattr_prefixes = pfs;
 	if (ret)
 		erofs_xattr_prefixes_cleanup(sb);
-- 
2.22.0


