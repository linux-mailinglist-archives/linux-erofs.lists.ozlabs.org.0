Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BD55B6C02
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Sep 2022 12:55:48 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MRgNy2WL5z3bc8
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Sep 2022 20:55:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=S41aa645;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=S41aa645;
	dkim-atps=neutral
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MRgNr1ghRz2xKh
	for <linux-erofs@lists.ozlabs.org>; Tue, 13 Sep 2022 20:55:39 +1000 (AEST)
Received: by mail-pf1-x429.google.com with SMTP id c198so11359187pfc.13
        for <linux-erofs@lists.ozlabs.org>; Tue, 13 Sep 2022 03:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=CY9QYDFISAembRXvRKnohn8bi/gRNBrzulkpL57S84E=;
        b=S41aa645zId+k7TVvtCr84Xoom2KFdMnJSgQju+n0Mmvy6tp+Jcp0y7dPU9wn12CHc
         b0nleEIiehmMyt909itkF6dZM5dDt3UjVRRqBfWzftLQqETB+AVl/6+IWCUDjBgY7V92
         JaOvtpzHxhG2nBJoMg/Bk6+Xh92xreyw8OcfqQuxivyhZcvhbnjK72R6h3ExytHlSSdB
         lU/Ij4b9gfaFRe/Fw3XZPJmubuCj7e60jSFT2dYHCCNXLopHp8QV91nI1uTdDxSLcFVY
         zeSBn04GU9/s5k6A1emEPbkXy9yFacZYzSPyMWOkL/KRiEvT98Eo4pFuT5C6WV3MnI9m
         Njdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=CY9QYDFISAembRXvRKnohn8bi/gRNBrzulkpL57S84E=;
        b=wnx4usu/A3WK75zZ5Bs4ZM0ecpCi9AQ2z3k2d1bnu74Gdx4m0VJfTXP4sBcsp5OW1f
         Cexo3ChCTDMLT55UZVmho6JSRHjp30e7r3YwEEirE4RdZaV6TgzCTmYA6sfsZHdxe3ll
         e2h7gHP4OtknK/ZbGvLAIWFAa6m0OIlEuiKDvM6xzyMJznAVzrHUkcD+wz5Tt4Mhewa6
         mF+qxNPnr8evbNTBshsy/NizzcsODKLYgoD3BwkPA/v3MmFP9KA48vBbLsqmn6h7En8t
         wTYrTtaPu1nTseZiImEYm5+MdzvDlucfxyMkmH29qHi5VARFBIgERyTAEeZig2WTH10j
         xs+g==
X-Gm-Message-State: ACgBeo2VPht524mzN9oNrExSUOxBwbl2wtu1aBytjwvkdZjhLMysn+6j
	XVkCXBMoSbUTpeqrh3cT4J0uVJYcBhQ=
X-Google-Smtp-Source: AA6agR5x1+IaNC4hObGdRmyW18d5JpY7kllvHdkoyncSf+FX7/qcMFMb6HYKY/gj0Quj+VMfDKZHGw==
X-Received: by 2002:aa7:9247:0:b0:544:6566:8ba0 with SMTP id 7-20020aa79247000000b0054465668ba0mr7858671pfp.11.1663066536996;
        Tue, 13 Sep 2022 03:55:36 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id g17-20020aa796b1000000b0054097cb2da6sm7475290pfk.38.2022.09.13.03.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 03:55:36 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH v8 2/4] erofs-utils: lib: support fragments data decompression
Date: Tue, 13 Sep 2022 18:54:47 +0800
Message-Id: <8df7954fdb1d63dbf7eed47234f6b3685547ba62.1663065968.git.huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1663065968.git.huyue2@coolpad.com>
References: <cover.1663065968.git.huyue2@coolpad.com>
In-Reply-To: <cover.1663065968.git.huyue2@coolpad.com>
References: <cover.1663065968.git.huyue2@coolpad.com>
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
Cc: Yue Hu <huyue2@coolpad.com>, shaojunjun@coolpad.com, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

Add compressed fragments support for erofsfuse.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 include/erofs/internal.h |  6 ++++++
 include/erofs_fs.h       | 26 +++++++++++++++++++------
 lib/data.c               | 29 +++++++++++++++++++++++++++
 lib/super.c              |  1 +
 lib/zmap.c               | 42 +++++++++++++++++++++++++++++++++++++++-
 5 files changed, 97 insertions(+), 7 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 2e0aae8..742bfed 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -102,6 +102,7 @@ struct erofs_sb_info {
 		u16 devt_slotoff;		/* used for mkfs */
 		u16 device_id_mask;		/* used for others */
 	};
+	erofs_nid_t packed_nid;
 };
 
 /* global sbi */
@@ -132,6 +133,7 @@ EROFS_FEATURE_FUNCS(big_pcluster, incompat, INCOMPAT_BIG_PCLUSTER)
 EROFS_FEATURE_FUNCS(chunked_file, incompat, INCOMPAT_CHUNKED_FILE)
 EROFS_FEATURE_FUNCS(device_table, incompat, INCOMPAT_DEVICE_TABLE)
 EROFS_FEATURE_FUNCS(ztailpacking, incompat, INCOMPAT_ZTAILPACKING)
+EROFS_FEATURE_FUNCS(fragments, incompat, INCOMPAT_FRAGMENTS)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 
 #define EROFS_I_EA_INITED	(1 << 0)
@@ -209,6 +211,7 @@ struct erofs_inode {
 #ifdef WITH_ANDROID
 	uint64_t capabilities;
 #endif
+	erofs_off_t fragmentoff;
 };
 
 static inline bool is_inode_layout_compression(struct erofs_inode *inode)
@@ -279,6 +282,7 @@ enum {
 	BH_Mapped,
 	BH_Encoded,
 	BH_FullMapped,
+	BH_Fragment,
 };
 
 /* Has a disk mapping */
@@ -289,6 +293,8 @@ enum {
 #define EROFS_MAP_ENCODED	(1 << BH_Encoded)
 /* The length of extent is full */
 #define EROFS_MAP_FULL_MAPPED	(1 << BH_FullMapped)
+/* Located in the special packed inode */
+#define EROFS_MAP_FRAGMENT	(1 << BH_Fragment)
 
 struct erofs_map_blocks {
 	char mpage[EROFS_BLKSIZ];
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index b8a7421..e492ad9 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -25,13 +25,15 @@
 #define EROFS_FEATURE_INCOMPAT_CHUNKED_FILE	0x00000004
 #define EROFS_FEATURE_INCOMPAT_DEVICE_TABLE	0x00000008
 #define EROFS_FEATURE_INCOMPAT_ZTAILPACKING	0x00000010
+#define EROFS_FEATURE_INCOMPAT_FRAGMENTS	0x00000020
 #define EROFS_ALL_FEATURE_INCOMPAT		\
 	(EROFS_FEATURE_INCOMPAT_LZ4_0PADDING | \
 	 EROFS_FEATURE_INCOMPAT_COMPR_CFGS | \
 	 EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER | \
 	 EROFS_FEATURE_INCOMPAT_CHUNKED_FILE | \
 	 EROFS_FEATURE_INCOMPAT_DEVICE_TABLE | \
-	 EROFS_FEATURE_INCOMPAT_ZTAILPACKING)
+	 EROFS_FEATURE_INCOMPAT_ZTAILPACKING | \
+	 EROFS_FEATURE_INCOMPAT_FRAGMENTS)
 
 #define EROFS_SB_EXTSLOT_SIZE	16
 
@@ -73,7 +75,9 @@ struct erofs_super_block {
 	} __packed u1;
 	__le16 extra_devices;	/* # of devices besides the primary device */
 	__le16 devt_slotoff;	/* startoff = devt_slotoff * devt_slotsize */
-	__u8 reserved2[38];
+	__u8 reserved[6];
+	__le64 packed_nid;	/* nid of the special packed inode */
+	__u8 reserved2[24];
 };
 
 /*
@@ -295,17 +299,26 @@ struct z_erofs_lzma_cfgs {
  * bit 2 : HEAD2 big pcluster (0 - off; 1 - on)
  * bit 3 : tailpacking inline pcluster (0 - off; 1 - on)
  * bit 4 : interlaced plain pcluster (0 - off; 1 - on)
+ * bit 5 : fragment pcluster (0 - off; 1 - on)
  */
 #define Z_EROFS_ADVISE_COMPACTED_2B		0x0001
 #define Z_EROFS_ADVISE_BIG_PCLUSTER_1		0x0002
 #define Z_EROFS_ADVISE_BIG_PCLUSTER_2		0x0004
 #define Z_EROFS_ADVISE_INLINE_PCLUSTER		0x0008
 #define Z_EROFS_ADVISE_INTERLACED_PCLUSTER	0x0010
+#define Z_EROFS_ADVISE_FRAGMENT_PCLUSTER	0x0020
 
+#define Z_EROFS_FRAGMENT_INODE_BIT		7
 struct z_erofs_map_header {
-	__le16	h_reserved1;
-	/* record the size of tailpacking data */
-	__le16  h_idata_size;
+	union {
+		/* direct addressing for fragment offset */
+		__le32	h_fragmentoff;
+		struct {
+			__le16  h_reserved1;
+			/* record the size of tailpacking data */
+			__le16	h_idata_size;
+		};
+	};
 	__le16	h_advise;
 	/*
 	 * bit 0-3 : algorithm type of head 1 (logical cluster type 01);
@@ -314,7 +327,8 @@ struct z_erofs_map_header {
 	__u8	h_algorithmtype;
 	/*
 	 * bit 0-2 : logical cluster bits - 12, e.g. 0 for 4096;
-	 * bit 3-7 : reserved.
+	 * bit 3-6 : reserved;
+	 * bit 7   : move the whole file into packed inode or not.
 	 */
 	__u8	h_clusterbits;
 };
diff --git a/lib/data.c b/lib/data.c
index 2d76816..8e85ae7 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -275,6 +275,35 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 			continue;
 		}
 
+		if (map.m_flags & EROFS_MAP_FRAGMENT) {
+			struct erofs_inode packed_inode = {
+				.nid = sbi.packed_nid,
+			};
+			char *out;
+
+			ret = erofs_read_inode_from_disk(&packed_inode);
+			if (ret) {
+				erofs_err("failed to read packed inode from disk");
+				return ret;
+			}
+
+			out = malloc(length - skip);
+			if (!out) {
+				ret = -ENOMEM;
+				break;
+			}
+			ret = z_erofs_read_data(&packed_inode, out,
+						length - skip,
+						inode->fragmentoff + skip);
+			if (ret < 0) {
+				free(out);
+				break;
+			}
+			memcpy(buffer + end - offset, out, length - skip);
+			free(out);
+			continue;
+		}
+
 		if (map.m_plen > bufsize) {
 			bufsize = map.m_plen;
 			raw = realloc(raw, bufsize);
diff --git a/lib/super.c b/lib/super.c
index b267412..30aeb36 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -104,6 +104,7 @@ int erofs_read_superblock(void)
 	sbi.xattr_blkaddr = le32_to_cpu(dsb->xattr_blkaddr);
 	sbi.islotbits = EROFS_ISLOTBITS;
 	sbi.root_nid = le16_to_cpu(dsb->root_nid);
+	sbi.packed_nid = le64_to_cpu(dsb->packed_nid);
 	sbi.inos = le64_to_cpu(dsb->inos);
 	sbi.checksum = le32_to_cpu(dsb->checksum);
 
diff --git a/lib/zmap.c b/lib/zmap.c
index abe0d31..b3a681e 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -49,6 +49,17 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 		return -EIO;
 
 	h = (struct z_erofs_map_header *)buf;
+	/*
+	 * if the highest bit of the 8-byte map header is set, the whole file
+	 * is stored in the packed inode. The rest bits keeps z_fragmentoff.
+	 */
+	if (h->h_clusterbits >> Z_EROFS_FRAGMENT_INODE_BIT) {
+		vi->z_advise = Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
+		vi->fragmentoff = le64_to_cpu(*(__le64 *)h) ^ (1ULL << 63);
+		vi->z_tailextent_headlcn = 0;
+		goto out;
+	}
+
 	vi->z_advise = le16_to_cpu(h->h_advise);
 	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
 	vi->z_algorithmtype[1] = h->h_algorithmtype >> 4;
@@ -83,6 +94,17 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 		if (ret < 0)
 			return ret;
 	}
+	if (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER &&
+	    !(h->h_clusterbits >> Z_EROFS_FRAGMENT_INODE_BIT)) {
+		struct erofs_map_blocks map = { .index = UINT_MAX };
+
+		vi->fragmentoff = le32_to_cpu(h->h_fragmentoff);
+		ret = z_erofs_do_map_blocks(vi, &map,
+					    EROFS_GET_BLOCKS_FINDTAIL);
+		if (ret < 0)
+			return ret;
+	}
+out:
 	vi->flags |= EROFS_I_Z_INITED;
 	return 0;
 }
@@ -546,6 +568,7 @@ static int z_erofs_do_map_blocks(struct erofs_inode *vi,
 				 int flags)
 {
 	bool ztailpacking = vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER;
+	bool fragment = vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
 	struct z_erofs_maprecorder m = {
 		.inode = vi,
 		.map = map,
@@ -603,12 +626,20 @@ static int z_erofs_do_map_blocks(struct erofs_inode *vi,
 	}
 
 	map->m_llen = end - map->m_la;
-	if (flags & EROFS_GET_BLOCKS_FINDTAIL)
+	if (flags & EROFS_GET_BLOCKS_FINDTAIL) {
 		vi->z_tailextent_headlcn = m.lcn;
+		/* for non-compact indexes, fragmentoff is 64 bits */
+		if (fragment &&
+		    vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY)
+			vi->fragmentoff |= (u64)m.pblk << 32;
+	}
 	if (ztailpacking && m.lcn == vi->z_tailextent_headlcn) {
 		map->m_flags |= EROFS_MAP_META;
 		map->m_pa = vi->z_idataoff;
 		map->m_plen = vi->z_idata_size;
+	} else if (fragment && m.lcn == vi->z_tailextent_headlcn) {
+		map->m_flags |= EROFS_MAP_FRAGMENT;
+		DBG_BUGON(!map->m_la);
 	} else {
 		map->m_pa = blknr_to_addr(m.pblk);
 		err = z_erofs_get_extent_compressedlen(&m, initial_lcn);
@@ -652,6 +683,15 @@ int z_erofs_map_blocks_iter(struct erofs_inode *vi,
 	if (err)
 		goto out;
 
+	if ((vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER) &&
+	    !vi->z_tailextent_headlcn) {
+		map->m_la = 0;
+		map->m_llen = vi->i_size;
+		map->m_flags = EROFS_MAP_MAPPED | EROFS_MAP_FULL_MAPPED |
+				EROFS_MAP_FRAGMENT;
+		goto out;
+	}
+
 	err = z_erofs_do_map_blocks(vi, map, flags);
 out:
 	DBG_BUGON(err < 0 && err != -ENOMEM);
-- 
2.17.1

