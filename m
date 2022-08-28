Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FF55A3DDD
	for <lists+linux-erofs@lfdr.de>; Sun, 28 Aug 2022 15:52:04 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MFw3j5g8Mz3byL
	for <lists+linux-erofs@lfdr.de>; Sun, 28 Aug 2022 23:52:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Lu3urlhs;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Lu3urlhs;
	dkim-atps=neutral
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MFw3T5cj6z30Lb
	for <linux-erofs@lists.ozlabs.org>; Sun, 28 Aug 2022 23:51:49 +1000 (AEST)
Received: by mail-pg1-x52b.google.com with SMTP id q9so5518116pgq.6
        for <linux-erofs@lists.ozlabs.org>; Sun, 28 Aug 2022 06:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc;
        bh=eQSPl5KSTXVSqiDMggRJA72BTUg2Vuhnhno7l+Yl5KE=;
        b=Lu3urlhsBMieDqIkl7xyYy8GoZ6PmEMO4lbIyctcidO7B88ueqtv8oiasSgpAGUvN0
         e+PjBgWgSlY5uHegCvmNvb0Nhdk/tvpCUyJIJwOCAnXq1sVc3HGHG05GkXru09Xw8aSr
         VefM17X/b63YPcZ2KnVSMbLbtt4MqUztpsolbO8x2X5WDs+YdM1ukKvYFxK/JPec7u9c
         /rbo5yp/wrs9vI3y7kPowYiF0OM18H8sUee5kaEErpzEdfh41KyEAQ4btJoQX52D4PI9
         sVFq0cyrOpDlS4iy3ca60rBmr/ScShkrySauh0HNRFFTDeT9d/EradsG88iTyV5FUBzu
         fgSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=eQSPl5KSTXVSqiDMggRJA72BTUg2Vuhnhno7l+Yl5KE=;
        b=fJ2QW/rzIJz17BJnxliJgKilgCKm8XvEaR1LC0RZrU5o0L10OE5MSAyBHMOcwedG7D
         Yyp0ss0oeieGANjLSbq0/ZV9Ba7ZMd0nkK8hsgptXrxMP1MGosuON7Br/jBDwwv56wKd
         QFzgTg/Y7BLGmVsX64oWqHKoG/8bsd/GMca0Bb+ENr4Pu2prffu56I6egzp8DiXXR217
         31dp6LoGCiksYyKkR92tJsun32dQfXlP3W6b/dmTjzlojJLwkBM6nTdotZ4B+A/NWqsH
         ZGPgF59lfb4GyTgaGzpoGJKILHh9krfcqVHBidQt9Tb7Rz1tvPJkRQfzTqXloppBq51x
         pJCg==
X-Gm-Message-State: ACgBeo24lpm+D4RVBRJV9G5MTKVKoG02FK8TaWRFjAm0jRotNtFWtgdj
	Mk6WHE7Q2gt2/hDJPrGAoUGR2F6PrfQ=
X-Google-Smtp-Source: AA6agR5GHC1quaADbjeJrUU/+KfmAEWoYbNYGJTSpQm2O+mRHsleS+cTXnRBRwsssxI3Dax8GO16uw==
X-Received: by 2002:a05:6a02:286:b0:422:f1ba:745 with SMTP id bk6-20020a056a02028600b00422f1ba0745mr10142037pgb.569.1661694707113;
        Sun, 28 Aug 2022 06:51:47 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id o9-20020a17090a4b4900b001fbb0f0b00fsm4795754pjl.35.2022.08.28.06.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 06:51:46 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH v5 2/4] erofs-utils: lib: support fragments data decompression
Date: Sun, 28 Aug 2022 21:51:07 +0800
Message-Id: <c90ec035b4823a3847b90d209e40daeba1edd6d1.1661694414.git.huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1661687617.git.huyue2@coolpad.com>
References: <cover.1661687617.git.huyue2@coolpad.com>
In-Reply-To: <cover.1661694414.git.huyue2@coolpad.com>
References: <cover.1661694414.git.huyue2@coolpad.com>
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
 include/erofs_fs.h       | 26 ++++++++++++++++++++------
 lib/data.c               | 20 ++++++++++++++++++++
 lib/super.c              | 24 +++++++++++++++++++++++-
 lib/zmap.c               | 26 ++++++++++++++++++++++++++
 5 files changed, 95 insertions(+), 7 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 2e0aae8..58590ed 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -102,6 +102,7 @@ struct erofs_sb_info {
 		u16 devt_slotoff;		/* used for mkfs */
 		u16 device_id_mask;		/* used for others */
 	};
+	struct erofs_inode *packed_inode;
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
index 2d76816..5ac18f3 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -275,6 +275,26 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 			continue;
 		}
 
+		if (map.m_flags & EROFS_MAP_FRAGMENT) {
+			char *out;
+
+			out = malloc(length - skip);
+			if (!out) {
+				ret = -ENOMEM;
+				break;
+			}
+			ret = z_erofs_read_data(sbi.packed_inode, out,
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
index b267412..074abf6 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -104,6 +104,21 @@ int erofs_read_superblock(void)
 	sbi.xattr_blkaddr = le32_to_cpu(dsb->xattr_blkaddr);
 	sbi.islotbits = EROFS_ISLOTBITS;
 	sbi.root_nid = le16_to_cpu(dsb->root_nid);
+	sbi.packed_inode = NULL;
+	if (erofs_sb_has_fragments()) {
+		struct erofs_inode *inode;
+
+		inode = calloc(1, sizeof(struct erofs_inode));
+		if (!inode)
+			return -ENOMEM;
+		inode->nid = le64_to_cpu(dsb->packed_nid);
+		ret = erofs_read_inode_from_disk(inode);
+		if (ret) {
+			free(inode);
+			return ret;
+		}
+		sbi.packed_inode = inode;
+	}
 	sbi.inos = le64_to_cpu(dsb->inos);
 	sbi.checksum = le32_to_cpu(dsb->checksum);
 
@@ -111,11 +126,18 @@ int erofs_read_superblock(void)
 	sbi.build_time_nsec = le32_to_cpu(dsb->build_time_nsec);
 
 	memcpy(&sbi.uuid, dsb->uuid, sizeof(dsb->uuid));
-	return erofs_init_devices(&sbi, dsb);
+
+	ret = erofs_init_devices(&sbi, dsb);
+	if (ret && sbi.packed_inode)
+		free(sbi.packed_inode);
+	return ret;
 }
 
 void erofs_put_super(void)
 {
 	if (sbi.devs)
 		free(sbi.devs);
+
+	if (sbi.packed_inode)
+		free(sbi.packed_inode);
 }
diff --git a/lib/zmap.c b/lib/zmap.c
index abe0d31..f9d8d5f 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -83,6 +83,20 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 		if (ret < 0)
 			return ret;
 	}
+	if (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER) {
+		vi->fragmentoff = le32_to_cpu(h->h_fragmentoff);
+
+		if (h->h_clusterbits >> Z_EROFS_FRAGMENT_INODE_BIT) {
+			vi->z_tailextent_headlcn = 0;
+		} else {
+			struct erofs_map_blocks map = { .index = UINT_MAX };
+
+			ret = z_erofs_do_map_blocks(vi, &map,
+						    EROFS_GET_BLOCKS_FINDTAIL);
+			if (ret < 0)
+				return ret;
+		}
+	}
 	vi->flags |= EROFS_I_Z_INITED;
 	return 0;
 }
@@ -546,6 +560,7 @@ static int z_erofs_do_map_blocks(struct erofs_inode *vi,
 				 int flags)
 {
 	bool ztailpacking = vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER;
+	bool inpacked = vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
 	struct z_erofs_maprecorder m = {
 		.inode = vi,
 		.map = map,
@@ -609,6 +624,9 @@ static int z_erofs_do_map_blocks(struct erofs_inode *vi,
 		map->m_flags |= EROFS_MAP_META;
 		map->m_pa = vi->z_idataoff;
 		map->m_plen = vi->z_idata_size;
+	} else if (inpacked && m.lcn == vi->z_tailextent_headlcn) {
+		map->m_flags |= EROFS_MAP_FRAGMENT;
+		DBG_BUGON(!map->m_la);
 	} else {
 		map->m_pa = blknr_to_addr(m.pblk);
 		err = z_erofs_get_extent_compressedlen(&m, initial_lcn);
@@ -652,6 +670,14 @@ int z_erofs_map_blocks_iter(struct erofs_inode *vi,
 	if (err)
 		goto out;
 
+	if ((vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER) &&
+	    !vi->z_tailextent_headlcn) {
+		map->m_llen = map->m_la + 1;
+		map->m_la = 0;
+		map->m_flags = EROFS_MAP_MAPPED | EROFS_MAP_FRAGMENT;
+		goto out;
+	}
+
 	err = z_erofs_do_map_blocks(vi, map, flags);
 out:
 	DBG_BUGON(err < 0 && err != -ENOMEM);
-- 
2.17.1

