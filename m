Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D0C59B42D
	for <lists+linux-erofs@lfdr.de>; Sun, 21 Aug 2022 15:58:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4M9cXG2mdKz3bXn
	for <lists+linux-erofs@lfdr.de>; Sun, 21 Aug 2022 23:58:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=GinL856G;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=GinL856G;
	dkim-atps=neutral
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4M9cX21cG3z3bVt
	for <linux-erofs@lists.ozlabs.org>; Sun, 21 Aug 2022 23:58:08 +1000 (AEST)
Received: by mail-pl1-x631.google.com with SMTP id jm11so7781953plb.13
        for <linux-erofs@lists.ozlabs.org>; Sun, 21 Aug 2022 06:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc;
        bh=h7+d4bxxOAKDH29QAkP8+FC5vZkHhAiYJVacGyzC3SQ=;
        b=GinL856Ga4M+5enLtou5+jRG7snH3z81QZQfbKd0u6FIivmj13A1HWiqZGxDTUUG7p
         t6iceaRfF8HVjH6N1Vor+SBfhaBNEDFOtxFWOG5tUJPKK54H87G9ALsazElgg6DUvE40
         aq1JK1v9JCPPFYLHvAfPMk7rQrTtSqU5x1LWr1wkBh+JJhlywsGAxjtqgwh9DzfSCmoC
         9V1ixAgpuL/dcgWRJ77RGtjo+v6E/OqHW0ir6tpSoW1q6AXxGlrhWYBtNhPxNrKfnf/4
         4jdJ9b1r/dmRsMQRY4EKfIYZlbEwKhj2TLLNquLrYTOxXui+o6cdP594ZWs7fgyd4pZ5
         63QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=h7+d4bxxOAKDH29QAkP8+FC5vZkHhAiYJVacGyzC3SQ=;
        b=mYu2UehrU0ZPohM8ItHPLN48OCQvOphfVW42WTEwEAM7lrAQsKnw8+g1Tw58NaWiPZ
         mhm5Ctx48hL9pX5/emNfuXJ09C4Z752HQcTGKFtk5yl2YTDKPHHya+7F157lCwIOm5Od
         7MWl3TwnJeQu3MLBVDsIQmm0QivtqtQO5xAgJa8oI3vd7MGuPQq/5k/ziUMeN/wm5MH1
         ntScVTBJ72n/H/b93pmI+w/BDLeKdImD1fWOR79PM732nhgmZrnDrc7QAMFkjHY+0qkX
         6REjhSMSRhq8JBNTw864bORi3diQyR40Gr8dfLC7nHCI4jm0BpO6rE3JeJx28WTuuD6G
         FCVg==
X-Gm-Message-State: ACgBeo2K4PloQHEnKw0gTjqTiPjTLROGI+JulQKMVbPRsLk9T2pU6ZyY
	SBP/z3CZWB+AyhA0JQJAIfRhu9XiB+E=
X-Google-Smtp-Source: AA6agR4FtnUS2Ai6BHi5sKeGwWb6sOrWnIrFEso8dl4ju5ImCGbuF9rNMkDNM4wVXh3EatiH/UfDkg==
X-Received: by 2002:a17:90a:5d83:b0:1fa:c5ca:b90d with SMTP id t3-20020a17090a5d8300b001fac5cab90dmr19102145pji.89.1661090284909;
        Sun, 21 Aug 2022 06:58:04 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id g29-20020aa796bd000000b00535e46171c1sm6088318pfk.117.2022.08.21.06.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 06:58:04 -0700 (PDT)
From: zbestahu@gmail.com
X-Google-Original-From: huyue2@coolpad.com
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH v4 1/3] erofs-utils: lib: add support for fragments data decompression
Date: Sun, 21 Aug 2022 21:57:23 +0800
Message-Id: <206d70b7f0fa50e14f9b0f8a3386efd0f34cd3ed.1661087840.git.huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1661087840.git.huyue2@coolpad.com>
References: <cover.1661087840.git.huyue2@coolpad.com>
In-Reply-To: <cover.1661087840.git.huyue2@coolpad.com>
References: <cover.1661087840.git.huyue2@coolpad.com>
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
index 08f9761..2422e1c 100644
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
@@ -294,16 +298,25 @@ struct z_erofs_lzma_cfgs {
  * bit 1 : HEAD1 big pcluster (0 - off; 1 - on)
  * bit 2 : HEAD2 big pcluster (0 - off; 1 - on)
  * bit 3 : tailpacking inline pcluster (0 - off; 1 - on)
+ * bit 4 : fragment pcluster (0 - off; 1 - on)
  */
 #define Z_EROFS_ADVISE_COMPACTED_2B		0x0001
 #define Z_EROFS_ADVISE_BIG_PCLUSTER_1		0x0002
 #define Z_EROFS_ADVISE_BIG_PCLUSTER_2		0x0004
 #define Z_EROFS_ADVISE_INLINE_PCLUSTER		0x0008
+#define Z_EROFS_ADVISE_FRAGMENT_PCLUSTER	0x0010
 
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
@@ -312,7 +325,8 @@ struct z_erofs_map_header {
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
index ad7b2cb..2af73c7 100644
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

