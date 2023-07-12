Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC608750724
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Jul 2023 13:51:53 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R1GLH39bWz3c4m
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Jul 2023 21:51:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R1GL36Twkz30Kf
	for <linux-erofs@lists.ozlabs.org>; Wed, 12 Jul 2023 21:51:37 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VnCpXRC_1689162684;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VnCpXRC_1689162684)
          by smtp.aliyun-inc.com;
          Wed, 12 Jul 2023 19:51:25 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v3 1/2] erofs: update on-disk format for xattr name filter
Date: Wed, 12 Jul 2023 19:51:22 +0800
Message-Id: <20230712115123.33712-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230712115123.33712-1-jefflexu@linux.alibaba.com>
References: <20230712115123.33712-1-jefflexu@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org, alexl@redhat.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The xattr name bloom filter feature is going to be introduced to speed
up the negative xattr lookup, e.g. system.posix_acl_[access|default]
lookup when running "ls -lR" workload.

There are some commonly used extended attributes (n) and the total
number of these is approximately 30.

	trusted.overlay.opaque
	trusted.overlay.redirect
	trusted.overlay.origin
	trusted.overlay.impure
	trusted.overlay.nlink
	trusted.overlay.upper
	trusted.overlay.metacopy
	trusted.overlay.protattr
	user.overlay.opaque
	user.overlay.redirect
	user.overlay.origin
	user.overlay.impure
	user.overlay.nlink
	user.overlay.upper
	user.overlay.metacopy
	user.overlay.protattr
	security.evm
	security.ima
	security.selinux
	security.SMACK64
	security.SMACK64IPIN
	security.SMACK64IPOUT
	security.SMACK64EXEC
	security.SMACK64TRANSMUTE
	security.SMACK64MMAP
	security.apparmor
	security.capability
	system.posix_acl_access
	system.posix_acl_default
	user.mime_type

Given the number of bits of the bloom filter (m) is 32, the optimal
value for the number of the hash functions (k) is 1 (ln2 * m/n = 0.74).

The single hash function is implemented as:

	xxh32(name, strlen(name), EROFS_XATTR_FILTER_SEED + index)

where `index` represents the index of corresponding predefined short name
prefix, while `name` represents the name string after stripping the above
predefined name prefix.

The constant magic number EROFS_XATTR_FILTER_SEED, i.e. 0x25BBE08F, is
used to give a better spread when mapping these 30 extended attributes
into 32-bit bloom filter as:

	bit  0: security.ima
	bit  1:
	bit  2: trusted.overlay.nlink
	bit  3:
	bit  4: user.overlay.nlink
	bit  5: trusted.overlay.upper
	bit  6: user.overlay.origin
	bit  7: trusted.overlay.protattr
	bit  8: security.apparmor
	bit  9: user.overlay.protattr
	bit 10: user.overlay.opaque
	bit 11: security.selinux
	bit 12: security.SMACK64TRANSMUTE
	bit 13: security.SMACK64
	bit 14: security.SMACK64MMAP
	bit 15: user.overlay.impure
	bit 16: security.SMACK64IPIN
	bit 17: trusted.overlay.redirect
	bit 18: trusted.overlay.origin
	bit 19: security.SMACK64IPOUT
	bit 20: trusted.overlay.opaque
	bit 21: system.posix_acl_default
	bit 22:
	bit 23: user.mime_type
	bit 24: trusted.overlay.impure
	bit 25: security.SMACK64EXEC
	bit 26: user.overlay.redirect
	bit 27: user.overlay.upper
	bit 28: security.evm
	bit 29: security.capability
	bit 30: system.posix_acl_access
	bit 31: trusted.overlay.metacopy, user.overlay.metacopy

h_name_filter is introduced to the on-disk per-inode xattr header to
place the corresponding xattr name filter, where bit value 1 indicates
non-existence for compatibility.

This feature is indicated by EROFS_FEATURE_COMPAT_XATTR_FILTER
compatible feature bit.

Reserve one byte in on-disk superblock as the on-disk format for xattr
name filter may change in the future.  With this flag we don't need
bothering these compatible bits again at that time.

Suggested-by: Alexander Larsson <alexl@redhat.com>
Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/erofs_fs.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 2c7b16e340fe..e2944f4a6ff9 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -13,6 +13,7 @@
 
 #define EROFS_FEATURE_COMPAT_SB_CHKSUM          0x00000001
 #define EROFS_FEATURE_COMPAT_MTIME              0x00000002
+#define EROFS_FEATURE_COMPAT_XATTR_FILTER	0x00000004
 
 /*
  * Any bits that aren't in EROFS_ALL_FEATURE_INCOMPAT should
@@ -81,7 +82,8 @@ struct erofs_super_block {
 	__u8 xattr_prefix_count;	/* # of long xattr name prefixes */
 	__le32 xattr_prefix_start;	/* start of long xattr prefixes */
 	__le64 packed_nid;	/* nid of the special packed inode */
-	__u8 reserved2[24];
+	__u8 xattr_filter_reserved; /* reserved for xattr name filter */
+	__u8 reserved2[23];
 };
 
 /*
@@ -200,7 +202,7 @@ struct erofs_inode_extended {
  * for read-only fs, no need to introduce h_refcount
  */
 struct erofs_xattr_ibody_header {
-	__le32 h_reserved;
+	__le32 h_name_filter;		/* bit value 1 indicates not-present */
 	__u8   h_shared_count;
 	__u8   h_reserved2[7];
 	__le32 h_shared_xattrs[];       /* shared xattr id array */
@@ -221,6 +223,10 @@ struct erofs_xattr_ibody_header {
 #define EROFS_XATTR_LONG_PREFIX		0x80
 #define EROFS_XATTR_LONG_PREFIX_MASK	0x7f
 
+#define EROFS_XATTR_FILTER_BITS		32
+#define EROFS_XATTR_FILTER_DEFAULT	UINT32_MAX
+#define EROFS_XATTR_FILTER_SEED		0x25BBE08F
+
 /* xattr entry (for both inline & shared xattrs) */
 struct erofs_xattr_entry {
 	__u8   e_name_len;      /* length of name */
-- 
2.19.1.6.gb485710b

