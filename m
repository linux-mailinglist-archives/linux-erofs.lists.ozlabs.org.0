Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id F07E6A4797
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Sep 2019 07:52:16 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Lj624XxyzDqst
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Sep 2019 15:52:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1567317130;
	bh=Q7sMdcPkbzYYJgkv4N07M+1GrvX0heM5iljSTfEgABs=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=YUS2/Q0aMhRhRxRn7uUXL35kii7LrJdgU4fYXJ+6YAxDu6TiBltvdkgLqpxZC+oZ+
	 jFu7ggPXTJDifQSnfry7x283oT1x4h94S4f4gJ+EkoiPLl4AjT4Syti7enpWyfuFhJ
	 3rkdNA/8DREQoHTPukHvKYsCJkB0NI8gMJ1a/tqZVyPUFQVxNSiSG0+ODR95aX20mo
	 GfO+wFnquWRV/5oTYJs+4AdwlN4xAtPMQp3Wjs0eavB1Z83cwzG1ZBjX+MROETDN6g
	 yQATt8sIvUA03oNgG34Li24aSGtBihR8+fBwItozQWIEqScuNwPVaP7MztBex2XxzJ
	 VJyTFikKBmxHg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.65.148; helo=sonic309-22.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="h+u3cYR7"; 
 dkim-atps=neutral
Received: from sonic309-22.consmr.mail.gq1.yahoo.com
 (sonic309-22.consmr.mail.gq1.yahoo.com [98.137.65.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Lj5p4FF1zDqlm
 for <linux-erofs@lists.ozlabs.org>; Sun,  1 Sep 2019 15:51:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1567317114; bh=lhPqVmPtFAqasXSfwHulauKZorqIQw16X3KiLzmwXV0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=h+u3cYR7pSOBaa7e3v6MLKi6hmmvOhdSbz7Rx9Pb2rJIwWkxfraOQ0r4VceRiy3+KM825tsNehiggBKgrZ5/c1aDA+MJjWdgfhqO+vRNqwtJsJCVaT6C5FENTKvGFndtcm5AuxmR8yFA70HQewg8lDXTaXiXGHRP/3wY2gQeR6VXsb9B+42Kl8FSw3iXfdGrjvt7XEmkTik9qMS3L05xqUC1E+gmaAB/xR/PZdu/IZBSkefZjueKprEmPJHGAojFaTuJjoFZawg3PhdvzEKozgHYFt3y41SLISVGV+LIjd8fQdrhcKfQ5xhw7csLkM0dN7IUk4GiFGWQUGTp1gTV3g==
X-YMail-OSG: wKKhWNYVM1lEBFNYGY2pWhq_zpGNbv9wbZMV0BpLPGfbha6QFIBNPdxUL8SmqF6
 D5cdjuJX00bJN0C6HESLwbsGt.ST7.XqMjYuB5t9i6On.cQk1Wvwbj1Ydt9C_rTwY0Sgqa2CRxW3
 HxfBlxacu6L5Uh_EOsXSR8ilYKHTh1Xcd6M12EBIu8ps43XZa8lB6staJ45EFuOvJfp_0hEWAfI2
 UoExpQKnedWEDPwfcFeNR25x1n9LK9r7T1Oliu.fCAgNXP9t2yi5zomzfOGj_B.6RI_FC_mhZqUK
 FGLs7ExT2.AXMt5EPdD3r1RBE7KXQklg9HzkcKxESewBr.JIvlLGk3u0CjStCnV3C1Qrm_5FDbzX
 vjNNMos5GxCcZPqgDT__PErxE9xPx7w06LL9SwwKCCdFgJrEhn0xQ6sgds7YPptL4r2plygVouZz
 CpdR2LybKwT0LR35tF5E3Mpzg0MGzlgwfQRo5FO8G3EJBso7YHybKe.J_6yup_UEzEccmctBNMAb
 7PJxcZoTnaK8zyu4.8X8a0c_D3zMaknOjqQprYsS5S8sQK5KJXfb.3MtcpXlLQ6Eiy.N7Un83lZ_
 Yf5w7MHrf7Che.BUUMYSawIH4rscgw_OAYVs7aUeUUeDnlBvuM2qwLrF0e7LevknH3rMokl.JwRc
 lOhQ1GzStFUN0dlMGaBN96chkdEl7EQRfSnk7Qlh0jq5Ple1cSq2ETFr5bcGSOFj3oQ6hMCdHhL9
 3JjFFYgeXM5ZOP0cFbNUf22fqIYnwBfSk2VFrg2Ju1Mmyyi.KnJAqUNFWWh.t6AvYhJ4ykFkxVtc
 DdY1v.GMyqcwt8TPg2aXvRF3YqHr3W8pNlhHo_ida2qTp8oe5GT7C9DjK_k6csRmDNdMFApZ3XWg
 cTCzeP8ct0e3OzL7CSSr4Zt6JLSKlAsCM6m_H6ufRkrzpwjsQH4ECsdG9OKUEq3vqHrtNHhdt.Az
 pSlT8k9E9DZvhZuKLfL.UTLzKXtt81kvYCnlTYC5nu49xIx_S0cZibFgBmdaWHXmvY2deWWiADta
 onbXJsLx53VBsFCpaZsbHYCNEB1gC3Kb3chaTfCH_MAVzesMvzrM_DM8ks5DGzqI7q8pnJzMLiKP
 5GNZ6WygSxhKjrT7z0g1BJaC4oeRJaHqCanIldnYKWNoNS32y7sEgmLtJn9hIVO0Kexj8reuhn5l
 aJrm4p7UWOwvBBQ8csxJuum_86jkNnTR4zpzvImHOG2gksr9J.Ar2McRrIJJp7Sg548zkM.1C__n
 iGPmLTnoxxCaF8NXOuAvDrRG8MGANbgAHP6NQ
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic309.consmr.mail.gq1.yahoo.com with HTTP; Sun, 1 Sep 2019 05:51:54 +0000
Received: by smtp406.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 426e3b5ec1af9e36f409445c51071a70; 
 Sun, 01 Sep 2019 05:51:52 +0000 (UTC)
To: Christoph Hellwig <hch@infradead.org>, Chao Yu <yuchao0@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 01/21] erofs: remove all the byte offset comments
Date: Sun,  1 Sep 2019 13:51:10 +0800
Message-Id: <20190901055130.30572-2-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190901055130.30572-1-hsiangkao@aol.com>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <gaoxiang25@huawei.com>

As Christoph suggested [1], "Please remove all the byte offset comments.
that is something that can easily be checked with gdb or pahole."

[1] https://lore.kernel.org/r/20190829095954.GB20598@infradead.org/
Reported-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/erofs_fs.h | 105 +++++++++++++++++++++++---------------------
 1 file changed, 54 insertions(+), 51 deletions(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index afa7d45ca958..49335fff9d65 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -17,27 +17,28 @@
 #define EROFS_REQUIREMENT_LZ4_0PADDING	0x00000001
 #define EROFS_ALL_REQUIREMENTS		EROFS_REQUIREMENT_LZ4_0PADDING
 
+/* 128-byte erofs on-disk super block */
 struct erofs_super_block {
-/*  0 */__le32 magic;           /* in the little endian */
-/*  4 */__le32 checksum;        /* crc32c(super_block) */
-/*  8 */__le32 features;        /* (aka. feature_compat) */
-/* 12 */__u8 blkszbits;         /* support block_size == PAGE_SIZE only */
-/* 13 */__u8 reserved;
-
-/* 14 */__le16 root_nid;
-/* 16 */__le64 inos;            /* total valid ino # (== f_files - f_favail) */
-
-/* 24 */__le64 build_time;      /* inode v1 time derivation */
-/* 32 */__le32 build_time_nsec;
-/* 36 */__le32 blocks;          /* used for statfs */
-/* 40 */__le32 meta_blkaddr;
-/* 44 */__le32 xattr_blkaddr;
-/* 48 */__u8 uuid[16];          /* 128-bit uuid for volume */
-/* 64 */__u8 volume_name[16];   /* volume name */
-/* 80 */__le32 requirements;    /* (aka. feature_incompat) */
-
-/* 84 */__u8 reserved2[44];
-} __packed;                     /* 128 bytes */
+	__le32 magic;           /* file system magic number */
+	__le32 checksum;        /* crc32c(super_block) */
+	__le32 features;        /* (aka. feature_compat) */
+	__u8 blkszbits;         /* support block_size == PAGE_SIZE only */
+	__u8 reserved;
+
+	__le16 root_nid;	/* nid of root directory */
+	__le64 inos;            /* total valid ino # (== f_files - f_favail) */
+
+	__le64 build_time;      /* inode v1 time derivation */
+	__le32 build_time_nsec;	/* inode v1 time derivation in nano scale */
+	__le32 blocks;          /* used for statfs */
+	__le32 meta_blkaddr;	/* start block address of metadata area */
+	__le32 xattr_blkaddr;	/* start block address of shared xattr area */
+	__u8 uuid[16];          /* 128-bit uuid for volume */
+	__u8 volume_name[16];   /* volume name */
+	__le32 requirements;    /* (aka. feature_incompat) */
+
+	__u8 reserved2[44];
+} __packed;
 
 /*
  * erofs inode data mapping:
@@ -73,16 +74,17 @@ static inline bool erofs_inode_is_data_compressed(unsigned int datamode)
 #define EROFS_I_VERSION_BIT             0
 #define EROFS_I_DATA_MAPPING_BIT        1
 
+/* 32-byte reduced form of an ondisk inode */
 struct erofs_inode_v1 {
-/*  0 */__le16 i_advise;
+	__le16 i_advise;	/* inode hints */
 
 /* 1 header + n-1 * 4 bytes inline xattr to keep continuity */
-/*  2 */__le16 i_xattr_icount;
-/*  4 */__le16 i_mode;
-/*  6 */__le16 i_nlink;
-/*  8 */__le32 i_size;
-/* 12 */__le32 i_reserved;
-/* 16 */union {
+	__le16 i_xattr_icount;
+	__le16 i_mode;
+	__le16 i_nlink;
+	__le32 i_size;
+	__le32 i_reserved;
+	union {
 		/* file total compressed blocks for data mapping 1 */
 		__le32 compressed_blocks;
 		__le32 raw_blkaddr;
@@ -90,10 +92,10 @@ struct erofs_inode_v1 {
 		/* for device files, used to indicate old/new device # */
 		__le32 rdev;
 	} i_u __packed;
-/* 20 */__le32 i_ino;           /* only used for 32-bit stat compatibility */
-/* 24 */__le16 i_uid;
-/* 26 */__le16 i_gid;
-/* 28 */__le32 i_reserved2;
+	__le32 i_ino;           /* only used for 32-bit stat compatibility */
+	__le16 i_uid;
+	__le16 i_gid;
+	__le32 i_reserved2;
 } __packed;
 
 /* 32 bytes on-disk inode */
@@ -101,15 +103,16 @@ struct erofs_inode_v1 {
 /* 64 bytes on-disk inode */
 #define EROFS_INODE_LAYOUT_V2   1
 
+/* 64-byte complete form of an ondisk inode */
 struct erofs_inode_v2 {
-/*  0 */__le16 i_advise;
+	__le16 i_advise;	/* inode hints */
 
 /* 1 header + n-1 * 4 bytes inline xattr to keep continuity */
-/*  2 */__le16 i_xattr_icount;
-/*  4 */__le16 i_mode;
-/*  6 */__le16 i_reserved;
-/*  8 */__le64 i_size;
-/* 16 */union {
+	__le16 i_xattr_icount;
+	__le16 i_mode;
+	__le16 i_reserved;
+	__le64 i_size;
+	union {
 		/* file total compressed blocks for data mapping 1 */
 		__le32 compressed_blocks;
 		__le32 raw_blkaddr;
@@ -119,15 +122,15 @@ struct erofs_inode_v2 {
 	} i_u __packed;
 
 	/* only used for 32-bit stat compatibility */
-/* 20 */__le32 i_ino;
-
-/* 24 */__le32 i_uid;
-/* 28 */__le32 i_gid;
-/* 32 */__le64 i_ctime;
-/* 40 */__le32 i_ctime_nsec;
-/* 44 */__le32 i_nlink;
-/* 48 */__u8   i_reserved2[16];
-} __packed;                     /* 64 bytes */
+	__le32 i_ino;
+
+	__le32 i_uid;
+	__le32 i_gid;
+	__le64 i_ctime;
+	__le32 i_ctime_nsec;
+	__le32 i_nlink;
+	__u8   i_reserved2[16];
+} __packed;
 
 #define EROFS_MAX_SHARED_XATTRS         (128)
 /* h_shared_count between 129 ... 255 are special # */
@@ -264,7 +267,7 @@ struct z_erofs_vle_decompressed_index {
 		 * [1] - pointing to the tail cluster
 		 */
 		__le16 delta[2];
-	} di_u __packed;		/* 8 bytes */
+	} di_u __packed;
 } __packed;
 
 #define Z_EROFS_VLE_LEGACY_INDEX_ALIGN(size) \
@@ -273,10 +276,10 @@ struct z_erofs_vle_decompressed_index {
 
 /* dirent sorts in alphabet order, thus we can do binary search */
 struct erofs_dirent {
-	__le64 nid;     /*  0, node number */
-	__le16 nameoff; /*  8, start offset of file name */
-	__u8 file_type; /* 10, file type */
-	__u8 reserved;  /* 11, reserved */
+	__le64 nid;     /* node number */
+	__le16 nameoff; /* start offset of file name */
+	__u8 file_type; /* file type */
+	__u8 reserved;  /* reserved */
 } __packed;
 
 /*
-- 
2.17.1

