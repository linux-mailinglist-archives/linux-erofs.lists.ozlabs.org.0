Return-Path: <linux-erofs+bounces-659-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A1AB08617
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Jul 2025 09:08:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bjPCW0zTvz3064;
	Thu, 17 Jul 2025 17:08:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752736103;
	cv=none; b=e/hL+fQl7080+ARm/+y2HhowQWspYD/6Wp2ZpeI2aNUiTVnT4Ga3H67X/1ZMga1iYZp0K7KkReOJBeSl09wGloy/Rzf36a3rFhZZounklEA1QN/L6fnB2c738emF4A9rGF96R63BEgY15OPF9ZEGteketn3Hj55aX3Ktg/QKYOUIGCoUB7WS8CoP/ckfgTQKIEG2zgp/PHxPFgOtE0FN9SQdMDvHibLqwW05dM9T60B6yWkgpxOkW3OSDJZuHPQVLlFxeBLbd0nOFHMuA+aKhoPejYeEPjAp34lAa3NPfWlOejTSDgcoWW8RBVUl3XKk9IOliOfurZ6D29ADwRDCxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752736103; c=relaxed/relaxed;
	bh=Cb3feXgviGMzdQwYcgHxk5CDMQwohzJIr1oowKwCh7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GSdZfSQosKln2KsR/zifo/3swY9UHzWUOi8TTGCsHrOXbVHQGtP23s/3QDkABa2pC8aJc8myEVeChZZfvXH0OrHBAiWj2u9nfsew09Qxer27UECcl00w+K340tI3nEQQkqtFh9LKf9HISeBdllcmaI/IRHu4e7OEI326yHGFTxzn3OivS8rblzEHv2Y0TT9+vAbhkZxZU37mLFUfjIsbk9CuYt7KbtOMSeflejtbxFXRrsacloDRqBA08TyvcBdhZYXYe8wqW40O4/DNWsezMwwCeGx1n9Tf9W7dYircgTHETNvygGdLFLupzbWEP9e4Shl+AyiVgrIG6kjVuVXAhg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=GkhxJdpt; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=GkhxJdpt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bjPCT48l0z2yDk
	for <linux-erofs@lists.ozlabs.org>; Thu, 17 Jul 2025 17:08:21 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752736097; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Cb3feXgviGMzdQwYcgHxk5CDMQwohzJIr1oowKwCh7Q=;
	b=GkhxJdpth4nhBqBZMQyjMj7OBVfKzx7jv0ynOvtmUgJ+hpzNq+p6lfhqh0C5J2TJG9Rjh9hFAY1CeAuHmandcnDqme7+6ozxZbHYF5kPXIWKzq8FE0Wy//cbTLBpZ/jbA6VNb2glvvJIdoQoN09evEkDqv5qV3dDo2t5ozX9cYc=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wj791lz_1752736094 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Jul 2025 15:08:15 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v5 1/2] erofs: add on-disk definition for metadata compression
Date: Thu, 17 Jul 2025 15:08:03 +0800
Message-ID: <20250717070804.1446345-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250717070804.1446345-1-hsiangkao@linux.alibaba.com>
References: <20250716173314.308744-1-hsiangkao@linux.alibaba.com>
 <20250717070804.1446345-1-hsiangkao@linux.alibaba.com>
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

Filesystem metadata has a high degree of redundancy, so it should
compress well in the general case.

Although metadata compression can increase overall I/O latency, many
users care more about minimized image sizes than extreme runtime
performance.  Let's implement metadata compression in response to user
requests [1].

Actually, it's quite simple to implement metadata compression: since
EROFS already supports per-inode compression, we can simply treat a
special inode (called `the metabox inode`) as a container for compressed
inode metadata.  Since EROFS supports multiple algorithms, users can
even specify LZ4 for metadata and LZMA for data.

To better support incremental builds, the MSB of NIDs indicates where
the inode metadata is located: if bit 63 is set, the inode itself should
be read from `the metabox inode`.

Optionally, shared xattrs can also be kept in `the metabox inode` if
COMPAT_SHARED_EA_IN_METABOX is set.

[1] https://issues.redhat.com/browse/RHEL-75783
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/erofs_fs.h | 13 ++++++++++---
 fs/erofs/internal.h |  2 ++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 767fb4acdc93..7b150ac64742 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -15,6 +15,7 @@
 #define EROFS_FEATURE_COMPAT_SB_CHKSUM          0x00000001
 #define EROFS_FEATURE_COMPAT_MTIME              0x00000002
 #define EROFS_FEATURE_COMPAT_XATTR_FILTER	0x00000004
+#define EROFS_FEATURE_COMPAT_SHARED_EA_IN_METABOX	0x00000008
 
 /*
  * Any bits that aren't in EROFS_ALL_FEATURE_INCOMPAT should
@@ -31,6 +32,7 @@
 #define EROFS_FEATURE_INCOMPAT_DEDUPE		0x00000020
 #define EROFS_FEATURE_INCOMPAT_XATTR_PREFIXES	0x00000040
 #define EROFS_FEATURE_INCOMPAT_48BIT		0x00000080
+#define EROFS_FEATURE_INCOMPAT_METABOX		0x00000100
 #define EROFS_ALL_FEATURE_INCOMPAT		\
 	((EROFS_FEATURE_INCOMPAT_48BIT << 1) - 1)
 
@@ -46,7 +48,7 @@ struct erofs_deviceslot {
 };
 #define EROFS_DEVT_SLOT_SIZE	sizeof(struct erofs_deviceslot)
 
-/* erofs on-disk super block (currently 128 bytes) */
+/* erofs on-disk super block (currently 144 bytes at maximum) */
 struct erofs_super_block {
 	__le32 magic;           /* file system magic number */
 	__le32 checksum;        /* crc32c to avoid unexpected on-disk overlap */
@@ -82,7 +84,9 @@ struct erofs_super_block {
 	__u8 reserved[3];
 	__le32 build_time;	/* seconds added to epoch for mkfs time */
 	__le64 rootnid_8b;	/* (48BIT on) nid of root directory */
-	__u8 reserved2[8];
+	__le64 reserved2;
+	__le64 metabox_nid;     /* (METABOX on) nid of the metabox inode */
+	__le64 reserved3;	/* [align to extslot 1] */
 };
 
 /*
@@ -267,6 +271,9 @@ struct erofs_inode_chunk_index {
 	__le32 startblk_lo;	/* starting block number of this chunk */
 };
 
+#define EROFS_DIRENT_NID_METABOX_BIT	63
+#define EROFS_DIRENT_NID_MASK	(BIT_ULL(EROFS_DIRENT_NID_METABOX_BIT) - 1)
+
 /* dirent sorts in alphabet order, thus we can do binary search */
 struct erofs_dirent {
 	__le64 nid;     /* node number */
@@ -434,7 +441,7 @@ static inline void erofs_check_ondisk_layout_definitions(void)
 		.h_clusterbits = 1 << Z_EROFS_FRAGMENT_INODE_BIT
 	};
 
-	BUILD_BUG_ON(sizeof(struct erofs_super_block) != 128);
+	BUILD_BUG_ON(sizeof(struct erofs_super_block) != 144);
 	BUILD_BUG_ON(sizeof(struct erofs_inode_compact) != 32);
 	BUILD_BUG_ON(sizeof(struct erofs_inode_extended) != 64);
 	BUILD_BUG_ON(sizeof(struct erofs_xattr_ibody_header) != 12);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index a7699114f6fe..ad932f670bb6 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -227,8 +227,10 @@ EROFS_FEATURE_FUNCS(fragments, incompat, INCOMPAT_FRAGMENTS)
 EROFS_FEATURE_FUNCS(dedupe, incompat, INCOMPAT_DEDUPE)
 EROFS_FEATURE_FUNCS(xattr_prefixes, incompat, INCOMPAT_XATTR_PREFIXES)
 EROFS_FEATURE_FUNCS(48bit, incompat, INCOMPAT_48BIT)
+EROFS_FEATURE_FUNCS(metabox, incompat, INCOMPAT_METABOX)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
+EROFS_FEATURE_FUNCS(shared_ea_in_metabox, compat, COMPAT_SHARED_EA_IN_METABOX)
 
 /* atomic flag definitions */
 #define EROFS_I_EA_INITED_BIT	0
-- 
2.43.5


