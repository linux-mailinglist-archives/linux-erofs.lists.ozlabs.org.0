Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7F9A4AC64
	for <lists+linux-erofs@lfdr.de>; Sat,  1 Mar 2025 15:50:35 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z4p0P5GKsz3cWY
	for <lists+linux-erofs@lfdr.de>; Sun,  2 Mar 2025 01:50:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740840625;
	cv=none; b=UqRfmKHG7O/m+kVDftn+EZcZEmM+A7BN2gJnoLw4IJGuCcUYi/sAZ1v9rC/IfXkf9gHdyeQbS01GMqp/m3dqpeAVsBIeRlCL1P3yOSLrJptzJVWMZsCUfOhDi7H1jJEoq8QWtNHDdk+CmgF/TEBLPHQB7STF3CQhDbJwAWLI7lztzJfj2TOX089l6Yq0sUXA+REuH6FBkLKPLJ0kMtVhTyswHVzuLPPnD5MlnaLVlMTsm9xNV6C8C3Vjdhbuum9Tq/PnFJXCF9sDGH7/5hWFc9mR0a69LqWUWu81Ul/aCitMPFfKAy8qZnLw6FEmq8fCom6AeCQMB103XVAVL0gS3w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740840625; c=relaxed/relaxed;
	bh=wO9fUs9nTc63v3PD92iK3A86VObYSvLUKYRWlwxrLN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ai7CJtHxonUf+Gpt2cpGKtvoOTuUKR4Q/mJA9mM62CrX5p7C6mmGonVmpZ+Co0IGKo7R7ZxXRDdym9GjWv9mNUA69xGqXv7ESQZo6KXzCScXa9sB0HL0iPqwzFNcjKCVe/JbJH779hxSVz2J5veJA939dx29cRVjlo+l7mie9esUdx+SQqiQtBKkdeGvILrftzs7iQzQjOjw09od9NkJPuplXvCc+3vWVnOVkNj9aGC1JbFv8eZ60WYj9xFngGoE3U5GP7fybRhn4xpInHK2bC+1NTC/3kUPAO15i9QMujwkS9zvRnk2Ok4lJfA16HC26MMqgi131ceR3SImKjtBnw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=nvTWuCC6; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=nvTWuCC6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z4p0F0R35z2x9j
	for <linux-erofs@lists.ozlabs.org>; Sun,  2 Mar 2025 01:50:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740840616; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=wO9fUs9nTc63v3PD92iK3A86VObYSvLUKYRWlwxrLN8=;
	b=nvTWuCC6FGM5GE4mqDxiJDmY7jdB93lSqZohZZnhJz6n4zaSdsnVgClVVFXgxzdF8vr3AVbxebmgRtLErHy0DGCayZ/VkfL0MTNsoJUED74O0VVswsR2RckQLscRj/AN/lo5yWOItwoV/Z37p5PQFXx5lt3Xdp5Hhs1hFgAXjAE=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WQSfpY4_1740840614 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 01 Mar 2025 22:50:14 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH v6 2/7] erofs: support user-defined fingerprint name
Date: Sat,  1 Mar 2025 22:49:39 +0800
Message-ID: <20250301145002.2420830-3-hongzhen@linux.alibaba.com>
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

When creating the EROFS image, users can specify the fingerprint name.
This is to prepare for the upcoming inode page cache share.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
 fs/erofs/Kconfig    | 10 +++++++++
 fs/erofs/erofs_fs.h |  9 ++++++---
 fs/erofs/internal.h |  6 ++++++
 fs/erofs/super.c    |  4 ++++
 fs/erofs/xattr.c    | 49 +++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/xattr.h    |  6 ++++++
 6 files changed, 81 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 6ea60661fa55..d2416d35035a 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -178,3 +178,13 @@ config EROFS_FS_PCPU_KTHREAD_HIPRI
 	  at higher priority.
 
 	  If unsure, say N.
+
+config EROFS_FS_INODE_SHARE
+	bool "EROFS inode page cache share support"
+	depends on EROFS_FS && EROFS_FS_XATTR
+	default n
+	help
+	  This permits EROFS to share page cache for files with same
+	  fingerprints.
+
+	  If unsure, say N.
diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 199395ed1c1f..261bd9bd47c4 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -30,6 +30,7 @@
 #define EROFS_FEATURE_INCOMPAT_FRAGMENTS	0x00000020
 #define EROFS_FEATURE_INCOMPAT_DEDUPE		0x00000020
 #define EROFS_FEATURE_INCOMPAT_XATTR_PREFIXES	0x00000040
+#define EROFS_FEATURE_INCOMPAT_ISHARE_KEY	0x00000080
 #define EROFS_ALL_FEATURE_INCOMPAT		\
 	(EROFS_FEATURE_INCOMPAT_ZERO_PADDING | \
 	 EROFS_FEATURE_INCOMPAT_COMPR_CFGS | \
@@ -40,7 +41,8 @@
 	 EROFS_FEATURE_INCOMPAT_ZTAILPACKING | \
 	 EROFS_FEATURE_INCOMPAT_FRAGMENTS | \
 	 EROFS_FEATURE_INCOMPAT_DEDUPE | \
-	 EROFS_FEATURE_INCOMPAT_XATTR_PREFIXES)
+	 EROFS_FEATURE_INCOMPAT_XATTR_PREFIXES | \
+	 EROFS_FEATURE_INCOMPAT_ISHARE_KEY)
 
 #define EROFS_SB_EXTSLOT_SIZE	16
 
@@ -84,8 +86,9 @@ struct erofs_super_block {
 	__le32 xattr_prefix_start;	/* start of long xattr prefixes */
 	__le64 packed_nid;	/* nid of the special packed inode */
 	__u8 xattr_filter_reserved; /* reserved for xattr name filter */
-	__u8 reserved2[23];
-};
+	__le32 ishare_key_start; /* start of ishare key */
+	__u8 reserved2[19];
+} __packed;
 
 /*
  * EROFS inode datalayout (i_format in on-disk inode):
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 47004eb89838..21bf9b694048 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -166,6 +166,11 @@ struct erofs_sb_info {
 	struct erofs_domain *domain;
 	char *fsid;
 	char *domain_id;
+
+	/* inode page cache share support */
+	u32 ishare_key_start;
+	int ishare_key_idx;
+	char *ishare_key;
 };
 
 #define EROFS_SB(sb) ((struct erofs_sb_info *)(sb)->s_fs_info)
@@ -233,6 +238,7 @@ EROFS_FEATURE_FUNCS(ztailpacking, incompat, INCOMPAT_ZTAILPACKING)
 EROFS_FEATURE_FUNCS(fragments, incompat, INCOMPAT_FRAGMENTS)
 EROFS_FEATURE_FUNCS(dedupe, incompat, INCOMPAT_DEDUPE)
 EROFS_FEATURE_FUNCS(xattr_prefixes, incompat, INCOMPAT_XATTR_PREFIXES)
+EROFS_FEATURE_FUNCS(ishare_key, incompat, INCOMPAT_ISHARE_KEY)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
 
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index eb052a770088..6af02cc8b8c6 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -313,6 +313,8 @@ static int erofs_read_superblock(struct super_block *sb)
 	sbi->packed_nid = le64_to_cpu(dsb->packed_nid);
 	sbi->inos = le64_to_cpu(dsb->inos);
 
+	sbi->ishare_key_start = le32_to_cpu(dsb->ishare_key_start);
+
 	sbi->build_time = le64_to_cpu(dsb->build_time);
 	sbi->build_time_nsec = le32_to_cpu(dsb->build_time_nsec);
 
@@ -676,6 +678,8 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (err)
 		return err;
 
+	erofs_xattr_set_ishare_key(sb);
+
 	erofs_set_sysfs_name(sb);
 	err = erofs_register_sysfs(sb);
 	if (err)
diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 7940241d9355..30a64ac3239a 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -549,3 +549,52 @@ struct posix_acl *erofs_get_acl(struct inode *inode, int type, bool rcu)
 	return acl;
 }
 #endif
+
+#ifdef CONFIG_EROFS_FS_INODE_SHARE
+void erofs_xattr_set_ishare_key(struct super_block *sb)
+{
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
+	struct xattr_handler const *handler;
+	erofs_off_t pos;
+	char *key;
+	int len, i;
+	void *ptr;
+
+	if (!erofs_sb_has_fragments(sbi) || !erofs_sb_has_ishare_key(sbi) ||
+	    !sbi->packed_inode)
+		return;
+
+	buf.mapping = sbi->packed_inode->i_mapping;
+	pos = sbi->ishare_key_start << 2;
+	ptr = erofs_read_metadata(sb, &buf, &pos, &len);
+
+	if (IS_ERR(ptr)) {
+		erofs_put_metabuf(&buf);
+		return;
+	}
+
+	for (i = 0; ARRAY_SIZE(erofs_xattr_handlers); i++) {
+		handler = erofs_xattr_handlers[i];
+		if (!handler)
+			break;
+		if (!memcmp(handler->prefix, ptr, strlen(handler->prefix)))
+			break;
+	}
+
+	if (!handler)
+		return;
+
+	len -= strlen(handler->prefix);
+	key = kzalloc(len + 1, GFP_KERNEL);
+	if (!key) {
+		erofs_put_metabuf(&buf);
+		return;
+	}
+
+	memcpy(key, ptr + strlen(handler->prefix), len);
+	sbi->ishare_key = key;
+	sbi->ishare_key_idx = handler->flags;
+	erofs_put_metabuf(&buf);
+}
+#endif
diff --git a/fs/erofs/xattr.h b/fs/erofs/xattr.h
index b246cd0e135e..24a243165417 100644
--- a/fs/erofs/xattr.h
+++ b/fs/erofs/xattr.h
@@ -70,4 +70,10 @@ struct posix_acl *erofs_get_acl(struct inode *inode, int type, bool rcu);
 #define erofs_get_acl	(NULL)
 #endif
 
+#ifdef CONFIG_EROFS_FS_INODE_SHARE
+void erofs_xattr_set_ishare_key(struct super_block *sb);
+#else
+static inline void erofs_xattr_set_ishare_key(struct super_block *sb) {}
+#endif
+
 #endif
-- 
2.43.5

