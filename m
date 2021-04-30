Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 825E036F4C0
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Apr 2021 06:03:58 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FWdyy3c44z2yxj
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Apr 2021 14:03:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=r31yOX4a;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=r31yOX4a; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FWdyx1Cw2z2xZG
 for <linux-erofs@lists.ozlabs.org>; Fri, 30 Apr 2021 14:03:53 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 025FB60232;
 Fri, 30 Apr 2021 04:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1619755430;
 bh=RtZJHjChWV6cr9XFb3GvqY4zDdzMOyFr4ECpcRUOowU=;
 h=From:To:Cc:Subject:Date:From;
 b=r31yOX4aWSnqcaM+TZ/dW+tuXJKWQntJWDAFb4je6Q00DwEIfUY95WRa64FlPaG7Z
 VxZGP8XspOpuoSBxbgYYAD9xRHa8KDNbAEjW4G7mqLsbqNRuJbtafn4+SSlnzah5mJ
 h6Z7RTUaZvSb3MqP2uDkjQZpVrMnTah0y2xyhUrtvVVaU9CC5Yl2umpuuTdzhAY9ra
 QmLwVeAgYRTLtHxri2BlvNKLmyicOZqvi6yFn7R2fRGuEbpBQpsnlr7Gc2xA9RDHOY
 inyw9dLnf9rUI0reGC1yK+es8YVSrRGlBgTKJZWoQX2/pWo6Eudmb8KqAx2xVMEm7l
 rL2/Cf8efs3Bw==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org,
	Li Guifu <bluce.liguifu@huawei.com>
Subject: [PATCH v4 1/5] erofs-utils: sync up with in-kernel erofs_fs.h
Date: Fri, 30 Apr 2021 12:03:41 +0800
Message-Id: <20210430040345.17120-1-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
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
Cc: Gao Xiang <xiang@kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This matches the latest in-kernel version.

Signed-off-by: Gao Xiang <xiang@kernel.org>
---
changes since v3:
 - fix typos in commit messages of 4/5 and 5/5;

Note that I'll apply them to dev branch directly tomorrow if still
no response from Guifu since more further work needs stable dev
branch like more pclustersize strategy for different data pattern
and LZMA compression.

In addition, we're quite close to release erofs-utils v1.3 as well
and these patches are needed.

 include/erofs_fs.h | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index 52da7abaac92..18fc1820c58c 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -27,13 +27,15 @@
 	 EROFS_FEATURE_INCOMPAT_COMPR_CFGS | \
 	 EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER)
 
-/* 128-byte erofs on-disk super block */
+#define EROFS_SB_EXTSLOT_SIZE	16
+
+/* erofs on-disk super block (currently 128 bytes) */
 struct erofs_super_block {
 	__le32 magic;           /* file system magic number */
 	__le32 checksum;        /* crc32c(super_block) */
 	__le32 feature_compat;
 	__u8 blkszbits;         /* support block_size == PAGE_SIZE only */
-	__u8 reserved;
+	__u8 sb_extslots;	/* superblock size = 128 + sb_extslots * 16 */
 
 	__le16 root_nid;	/* nid of root directory */
 	__le64 inos;            /* total valid ino # (== f_files - f_favail) */
@@ -49,8 +51,9 @@ struct erofs_super_block {
 	union {
 		/* bitmap for available compression algorithms */
 		__le16 available_compr_algs;
+		/* customized sliding window size instead of 64k by default */
 		__le16 lz4_max_distance;
-	} u1;
+	} __packed u1;
 	__u8 reserved2[42];
 };
 
@@ -87,6 +90,9 @@ static inline bool erofs_inode_is_data_compressed(unsigned int datamode)
 #define EROFS_I_VERSION_BIT             0
 #define EROFS_I_DATALAYOUT_BIT          1
 
+#define EROFS_I_ALL	\
+	((1 << (EROFS_I_DATALAYOUT_BIT + EROFS_I_DATALAYOUT_BITS)) - 1)
+
 /* 32-byte reduced form of an ondisk inode */
 struct erofs_inode_compact {
 	__le16 i_format;	/* inode format hints */
@@ -209,6 +215,7 @@ enum {
 	Z_EROFS_COMPRESSION_LZ4	= 0,
 	Z_EROFS_COMPRESSION_MAX
 };
+#define Z_EROFS_ALL_COMPR_ALGS		(1 << (Z_EROFS_COMPRESSION_MAX - 1))
 
 /* 14 bytes (+ length field = 16 bytes) */
 struct z_erofs_lz4_cfgs {
@@ -238,9 +245,7 @@ struct z_erofs_map_header {
 	__u8	h_algorithmtype;
 	/*
 	 * bit 0-2 : logical cluster bits - 12, e.g. 0 for 4096;
-	 * bit 3-4 : (physical - logical) cluster bits of head 1:
-	 *       For example, if logical clustersize = 4096, 1 for 8192.
-	 * bit 5-7 : (physical - logical) cluster bits of head 2.
+	 * bit 3-7 : reserved.
 	 */
 	__u8	h_clusterbits;
 };
-- 
2.20.1

