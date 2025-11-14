Return-Path: <linux-erofs+bounces-1366-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B48FC5C722
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Nov 2025 11:07:09 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d7CVK2nGTz302l;
	Fri, 14 Nov 2025 21:07:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.226
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763114825;
	cv=none; b=RnifyHv4jD0DFNFrC9QYW206psrjpNol3uwFkdiW3y7q04U+sNFRsIXbMljlTNG/wj7ncTNftBSpysBJoPcF64Eb/9ExsAmD0Ym2r1meKHRoHtGjciDzMf6URClgUMth4n8br9g25HqKpARMvHbbEu8MAjmb4709fkkh28Y6cRjbLoRte3XkxCphvndR9syHBhcVg7+45m+Cxh9M2NKuuSVJDMeSsn5m7CrYKlALDMDUidpfF7QER37RvBwqcQKjcvpD+1/WuOYE04ewkFYtPMoy5rmCtn1IYwjv2j0CPeJIzHSgn5IytVb9LTgd8ilbY5VCv/5e72F2vkLbIw2deA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763114825; c=relaxed/relaxed;
	bh=YL/tWdSMyJnhT69kjA2piGvwBmgoM2UAWnLITs3jTEg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OeB0bU5EL1E9J5Cxo035OpI7DUAa3voV27G91RURgWCSqZZA/nAI3y8aI/3e7k3v/h1G+ur4f8puOyDgU6jX1BvzS7JXskmlQbPidJNloTYDK3L3Zst9vti4mGmPTi1cK0H5ha8hyeW+285HCVUEpQ6vVYSGf2Yz16jbLxwuNMGwxWyLh8auUgXL8qkyT6clPATmXrjXXDtCe0yoaPJOBRDBb0SL8p+J5RsNwKajVp3EtwiJu1cW4YdQZ9vS8RlpQ2iI6OR2fO09x4Yt1rx5IBqEbonB0fczW+zNx7ZGZqfNiWD5ycfpNG1ooTHk+rP3y2kDfBxbHv3v2dvLeWRA5g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=V+TmuZrY; dkim-atps=neutral; spf=pass (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=V+TmuZrY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d7CVF1rF0z2xnh
	for <linux-erofs@lists.ozlabs.org>; Fri, 14 Nov 2025 21:07:00 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=YL/tWdSMyJnhT69kjA2piGvwBmgoM2UAWnLITs3jTEg=;
	b=V+TmuZrYmgHvOsWxyuHKiGIRN7ibFSt+AxOTCD9SrXmlbNoUuTqDaNvpnOf30R2wDLrlB7gv7
	ZLw5E25Ga8cOAzgfmSZ7qwj2ATBqTSLfjnpWWhlk/TeMbiSQNcdPo/zTRXPZ5Iks+YUnlB3Gvqw
	ISmjrPMwBRGUeBFlKftEXAM=
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d7CSC3NMRzKm5f;
	Fri, 14 Nov 2025 18:05:15 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id C6EA9180044;
	Fri, 14 Nov 2025 18:06:56 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 14 Nov
 2025 18:06:56 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>,
	<djwong@kernel.org>, <amir73il@gmail.com>, <joannelkoong@gmail.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v8 4/9] erofs: support user-defined fingerprint name
Date: Fri, 14 Nov 2025 09:55:11 +0000
Message-ID: <20251114095516.207555-5-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20251114095516.207555-1-lihongbo22@huawei.com>
References: <20251114095516.207555-1-lihongbo22@huawei.com>
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
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
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
 fs/erofs/internal.h |  6 ++++++
 fs/erofs/super.c    |  5 ++++-
 fs/erofs/xattr.c    | 26 ++++++++++++++++++++++++++
 fs/erofs/xattr.h    |  6 ++++++
 6 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index d81f3318417d..1b5c0cd99203 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -194,3 +194,12 @@ config EROFS_FS_PCPU_KTHREAD_HIPRI
 	  at higher priority.
 
 	  If unsure, say N.
+
+config EROFS_FS_INODE_SHARE
+	bool "EROFS inode page cache share support (experimental)"
+	depends on EROFS_FS && EROFS_FS_XATTR && !EROFS_FS_ONDEMAND
+	help
+	  This permits EROFS to share page cache for files with same
+	  fingerprints.
+
+	  If unsure, say N.
\ No newline at end of file
diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 3d5738f80072..104518cd161d 100644
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
+	__u8 ishare_key_start;	/* start of ishare key */
+	__u8 reserved[2];
 	__le32 build_time;	/* seconds added to epoch for mkfs time */
 	__le64 rootnid_8b;	/* (48BIT on) nid of root directory */
 	__le64 reserved2;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index e80b35db18e4..3ebbb7c5d085 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -167,6 +167,11 @@ struct erofs_sb_info {
 	struct erofs_domain *domain;
 	char *fsid;
 	char *domain_id;
+
+	/* inode page cache share support */
+	u8 ishare_key_start;
+	u8 ishare_key_idx;
+	char *ishare_key;
 };
 
 #define EROFS_SB(sb) ((struct erofs_sb_info *)(sb)->s_fs_info)
@@ -236,6 +241,7 @@ EROFS_FEATURE_FUNCS(dedupe, incompat, INCOMPAT_DEDUPE)
 EROFS_FEATURE_FUNCS(xattr_prefixes, incompat, INCOMPAT_XATTR_PREFIXES)
 EROFS_FEATURE_FUNCS(48bit, incompat, INCOMPAT_48BIT)
 EROFS_FEATURE_FUNCS(metabox, incompat, INCOMPAT_METABOX)
+EROFS_FEATURE_FUNCS(ishare_key, incompat, INCOMPAT_ISHARE_KEY)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
 EROFS_FEATURE_FUNCS(shared_ea_in_metabox, compat, COMPAT_SHARED_EA_IN_METABOX)
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 0d88c04684b9..3561473cb789 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -339,7 +339,7 @@ static int erofs_read_superblock(struct super_block *sb)
 			return -EFSCORRUPTED;	/* self-loop detection */
 	}
 	sbi->inos = le64_to_cpu(dsb->inos);
-
+	sbi->ishare_key_start = dsb->ishare_key_start;
 	sbi->epoch = (s64)le64_to_cpu(dsb->epoch);
 	sbi->fixed_nsec = le32_to_cpu(dsb->fixed_nsec);
 	super_set_uuid(sb, (void *)dsb->uuid, sizeof(dsb->uuid));
@@ -738,6 +738,9 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (err)
 		return err;
 
+	err = erofs_xattr_set_ishare_key(sb);
+	if (err)
+		return err;
 	erofs_set_sysfs_name(sb);
 	err = erofs_register_sysfs(sb);
 	if (err)
diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 396536d9a862..3c99091f39a5 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -564,3 +564,29 @@ struct posix_acl *erofs_get_acl(struct inode *inode, int type, bool rcu)
 	return acl;
 }
 #endif
+
+#ifdef CONFIG_EROFS_FS_INODE_SHARE
+int erofs_xattr_set_ishare_key(struct super_block *sb)
+{
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+	struct erofs_xattr_prefix_item *pf;
+	char *ishare_key;
+
+	if (!sbi->xattr_prefixes ||
+	    !(sbi->ishare_key_start & EROFS_XATTR_LONG_PREFIX))
+		return 0;
+
+	pf = sbi->xattr_prefixes +
+		(sbi->ishare_key_start & EROFS_XATTR_LONG_PREFIX_MASK);
+	if (!pf || pf >= sbi->xattr_prefixes + sbi->xattr_prefix_count)
+		return 0;
+	ishare_key = kmalloc(pf->infix_len + 1, GFP_KERNEL);
+	if (!ishare_key)
+		return -ENOMEM;
+	memcpy(ishare_key, pf->prefix->infix, pf->infix_len);
+	ishare_key[pf->infix_len] = '\0';
+	sbi->ishare_key = ishare_key;
+	sbi->ishare_key_idx = pf->prefix->base_index;
+	return 0;
+}
+#endif
diff --git a/fs/erofs/xattr.h b/fs/erofs/xattr.h
index 6317caa8413e..21684359662c 100644
--- a/fs/erofs/xattr.h
+++ b/fs/erofs/xattr.h
@@ -67,4 +67,10 @@ struct posix_acl *erofs_get_acl(struct inode *inode, int type, bool rcu);
 #define erofs_get_acl	(NULL)
 #endif
 
+#ifdef CONFIG_EROFS_FS_INODE_SHARE
+int erofs_xattr_set_ishare_key(struct super_block *sb);
+#else
+static inline int erofs_xattr_set_ishare_key(struct super_block *sb) { return 0; }
+#endif
+
 #endif
-- 
2.22.0


