Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE7136BD66
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Apr 2021 04:37:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FTmBj5DMBz2yx2
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Apr 2021 12:37:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ivhd711K;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ivhd711K; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FTmBg3Xdxz2xYZ
 for <linux-erofs@lists.ozlabs.org>; Tue, 27 Apr 2021 12:37:31 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3523D61073;
 Tue, 27 Apr 2021 02:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1619491048;
 bh=kW4waYApMV+LHrJe+lsqQTspTkGpF1dZjnXg+v3qAPA=;
 h=From:To:Cc:Subject:Date:From;
 b=ivhd711K09fiaTNW2jIJsD20snroBnz/Msqu2cnDcYuSw/xozKvjOF4dUv6lXaAh5
 mKTpjUL8GmpXcqOlMKnb+DIpnpgu0jMCWiVbWJaZH6I9uGQGox84FEDeKFnYUljvl8
 BHXzq7gFrc3bxkJAsWizEBQ47SAhfDRNHPP8VUuTXEQqF8bHcinTtPio0KxrNPBVcZ
 lCJ8mF4mVVhY5ZIgSTC/dV0eqJD0LNTUvIYrZJKafgTwMmQ/cPhChh06dA+Ok6IRJJ
 rZCGwFoq0Lqa6c54lYJJcQ8RXubV1gXaGDS5T87wPiF1CsJrpw6MIFY2PMQMt0baYZ
 OMAS+TFjb0SWA==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org,
	Li Guifu <bluce.liguifu@huawei.com>
Subject: [PATCH 1/3] erofs-utils: sync up with in-kernel erofs_fs.h
Date: Tue, 27 Apr 2021 10:37:20 +0800
Message-Id: <20210427023722.7996-1-xiang@kernel.org>
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

