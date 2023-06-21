Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED63737DC6
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Jun 2023 10:47:40 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QmHFP6q3bz3dwL
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Jun 2023 18:47:37 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QmGvh3g7sz3bwJ
	for <linux-erofs@lists.ozlabs.org>; Wed, 21 Jun 2023 18:32:15 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VlfGJyV_1687336330;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VlfGJyV_1687336330)
          by smtp.aliyun-inc.com;
          Wed, 21 Jun 2023 16:32:10 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [RFC 1/2] erofs: update on-disk format for xattr bloom filter
Date: Wed, 21 Jun 2023 16:32:08 +0800
Message-Id: <20230621083209.116024-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230621083209.116024-1-jefflexu@linux.alibaba.com>
References: <20230621083209.116024-1-jefflexu@linux.alibaba.com>
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

The xattr bloom filter feature is going to be introduced to speed up the
negative xattr lookup, e.g. system.posix_acl_[access|default] lookup
when running "ls -lR" workload.

The number of common used xattr (n) is approximately 8, including
system.[posix_acl_access|posix_acl_default], security.[capability|selinux]
and security.[SMACK64|SMACK64TRANSMUTE|SMACK64EXEC|SMACK64MMAP].  Given the
number of bits of the bloom filter (m) is 32, the optimal value for the
number of the hash functions (k) is 2 (ln2 * m/n = 2.7).

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/erofs_fs.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 2c7b16e340fe..9daea86cdb52 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -13,6 +13,7 @@
 
 #define EROFS_FEATURE_COMPAT_SB_CHKSUM          0x00000001
 #define EROFS_FEATURE_COMPAT_MTIME              0x00000002
+#define EROFS_FEATURE_COMPAT_XATTR_BLOOM	0x00000003
 
 /*
  * Any bits that aren't in EROFS_ALL_FEATURE_INCOMPAT should
@@ -200,7 +201,7 @@ struct erofs_inode_extended {
  * for read-only fs, no need to introduce h_refcount
  */
 struct erofs_xattr_ibody_header {
-	__le32 h_reserved;
+	__le32 h_map;	/* bloom filter, bit value 1 indicates not-present */
 	__u8   h_shared_count;
 	__u8   h_reserved2[7];
 	__le32 h_shared_xattrs[];       /* shared xattr id array */
@@ -221,6 +222,11 @@ struct erofs_xattr_ibody_header {
 #define EROFS_XATTR_LONG_PREFIX		0x80
 #define EROFS_XATTR_LONG_PREFIX_MASK	0x7f
 
+#define EROFS_XATTR_BLOOM_BITS		32
+#define EROFS_XATTR_BLOOM_MASK		(EROFS_XATTR_BLOOM_BITS - 1)
+#define EROFS_XATTR_BLOOM_DEFAULT	UINT32_MAX
+#define EROFS_XATTR_BLOOM_COUNTS	2
+
 /* xattr entry (for both inline & shared xattrs) */
 struct erofs_xattr_entry {
 	__u8   e_name_len;      /* length of name */
-- 
2.19.1.6.gb485710b

