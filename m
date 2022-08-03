Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AD632588616
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Aug 2022 05:52:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LyHwz4rbHz306m
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Aug 2022 13:52:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=fEFBuqJX;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=fEFBuqJX;
	dkim-atps=neutral
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LyHwt1QlSz2xGf
	for <linux-erofs@lists.ozlabs.org>; Wed,  3 Aug 2022 13:51:57 +1000 (AEST)
Received: by mail-pl1-x631.google.com with SMTP id w7so15228720ply.12
        for <linux-erofs@lists.ozlabs.org>; Tue, 02 Aug 2022 20:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc;
        bh=MaV7E1T4bXYJvOhebgj6oQ6urpDxqHXvJnDDd6JwiKM=;
        b=fEFBuqJXTdj1O4KkjvPnZkRsXCDOfVk4gABfRlcad4Hjbo5yxXTr/xA7gBI73DKyFF
         5bc0OG1eOiYT7PBjrOI23ybV+2dpck15N1cUDOc0dzf7OGcHVgzYx8SXUf0wZLjci3GW
         CPunI9GJ1dQTDMozdB9qrDljtCsHW6N2ElLUQH06pYxamwhXIOCi+snAsX0F7qGqljhc
         e11rlYgr+lwKRFKerG8Atcnte6W/m6SJLWXUHDvr+dx0Lju5hLKqZ8Y+ct7Y0UJtfBhv
         F9OJncROWnaROyq45uFGu9wskwOwkWnfGqp85KAaLIol+O0XdKvb1VCy6UQdHd2PWASp
         Nobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=MaV7E1T4bXYJvOhebgj6oQ6urpDxqHXvJnDDd6JwiKM=;
        b=l/TckVEnjyUFy9iv+eTKBiiyPNnqvit9eaa0igCP8S1bqYiR2K4yEvvg1J03Ymh8pm
         OdpbYCSTdV1kEr8WvBR6YDjH3PF9SxlPpRKbzRTiFiZGs96VBMNUgV3T0GpRUhcun2+i
         516f/MBx3XvpOJX+uewaupQ6cVv+cKRy136ELRxGxfDNOgGw8+Yxi11Uwb3IyciA3boM
         Hg1JWgY6emDJijOXs8DOwYBduoF3vOLJoqMwSdTaiJk8PHHqP5hS+DgEbKFpocnVLNku
         Tow16bl4tu8b1jlwFi3lKLvKxM2Z5bBGMNSA4I2BgxlO+QqODx4v0Oii+5MC9NGjUycd
         7bZg==
X-Gm-Message-State: ACgBeo1N81n2+MOa/5l9gxVVNeODRsaZfmU/QUlx8cg8mghdmDUMBbvx
	tCKpktaXiGeFHW+59ghnyuy+VmCjf04=
X-Google-Smtp-Source: AA6agR77ilDas1HMCdSfjJQhm/tW72FH5IAPAMcMqpzV7M6NoIuHGNMbNfZui1lFFFtXmCW0WxHPtA==
X-Received: by 2002:a17:902:7807:b0:16d:ce68:445d with SMTP id p7-20020a170902780700b0016dce68445dmr24111455pll.148.1659498714486;
        Tue, 02 Aug 2022 20:51:54 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id e11-20020aa7980b000000b00528a097aeffsm2464629pfl.118.2022.08.02.20.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 20:51:54 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
X-Google-Original-From: Yue Hu <huyue2@coolpad.com>
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH v3 1/3] erofs-utils: lib: add support for fragments data decompression
Date: Wed,  3 Aug 2022 11:51:28 +0800
Message-Id: <013f1dc6b6c8c67482a2d554ffb60462cc8ea125.1659496805.git.huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1659496805.git.huyue2@coolpad.com>
References: <cover.1659496805.git.huyue2@coolpad.com>
In-Reply-To: <cover.1659496805.git.huyue2@coolpad.com>
References: <cover.1659496805.git.huyue2@coolpad.com>
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
Cc: huyue2@coolpad.com, zbestahu@163.com, shaojunjun@coolpad.com, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add compressed fragments support for erofsfuse.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 include/erofs/internal.h |  8 ++++++++
 include/erofs_fs.h       | 26 ++++++++++++++++++++------
 lib/data.c               | 20 ++++++++++++++++++++
 lib/super.c              | 24 +++++++++++++++++++++++-
 lib/zmap.c               | 26 ++++++++++++++++++++++++++
 5 files changed, 97 insertions(+), 7 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 48498fe..5980db7 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -102,6 +102,7 @@ struct erofs_sb_info {
 		u16 devt_slotoff;		/* used for mkfs */
 		u16 device_id_mask;		/* used for others */
 	};
+	struct erofs_inode *frags_inode;
 };
 
 /* global sbi */
@@ -132,6 +133,7 @@ EROFS_FEATURE_FUNCS(big_pcluster, incompat, INCOMPAT_BIG_PCLUSTER)
 EROFS_FEATURE_FUNCS(chunked_file, incompat, INCOMPAT_CHUNKED_FILE)
 EROFS_FEATURE_FUNCS(device_table, incompat, INCOMPAT_DEVICE_TABLE)
 EROFS_FEATURE_FUNCS(ztailpacking, incompat, INCOMPAT_ZTAILPACKING)
+EROFS_FEATURE_FUNCS(fragments, incompat, INCOMPAT_FRAGMENTS)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 
 #define EROFS_I_EA_INITED	(1 << 0)
@@ -190,6 +192,8 @@ struct erofs_inode {
 	void *eof_tailraw;
 	unsigned int eof_tailrawsize;
 
+	erofs_off_t fragmentoff;
+
 	union {
 		void *compressmeta;
 		void *chunkindexes;
@@ -201,6 +205,7 @@ struct erofs_inode {
 			uint64_t z_tailextent_headlcn;
 			unsigned int    z_idataoff;
 #define z_idata_size	idata_size
+#define z_fragmentoff	fragmentoff
 		};
 	};
 #ifdef WITH_ANDROID
@@ -276,6 +281,7 @@ enum {
 	BH_Mapped,
 	BH_Encoded,
 	BH_FullMapped,
+	BH_Fragments,
 };
 
 /* Has a disk mapping */
@@ -286,6 +292,8 @@ enum {
 #define EROFS_MAP_ENCODED	(1 << BH_Encoded)
 /* The length of extent is full */
 #define EROFS_MAP_FULL_MAPPED	(1 << BH_FullMapped)
+/* Located in fragments */
+#define EROFS_MAP_FRAGMENTS	(1 << BH_Fragments)
 
 struct erofs_map_blocks {
 	char mpage[EROFS_BLKSIZ];
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index 08f9761..4e13566 100644
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
+	__le64 frags_nid;	/* nid of the special fragments inode */
+	__u8 reserved2[24];
 };
 
 /*
@@ -294,16 +298,24 @@ struct z_erofs_lzma_cfgs {
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
@@ -312,12 +324,14 @@ struct z_erofs_map_header {
 	__u8	h_algorithmtype;
 	/*
 	 * bit 0-2 : logical cluster bits - 12, e.g. 0 for 4096;
-	 * bit 3-7 : reserved.
+	 * bit 3-6 : reserved;
+	 * bit 7   : merge the whole file into fragments or not.
 	 */
 	__u8	h_clusterbits;
 };
 
 #define Z_EROFS_VLE_LEGACY_HEADER_PADDING       8
+#define Z_EROFS_FRAGMENT_INODE_BIT		7
 
 /*
  * Fixed-sized output compression ondisk Logical Extent cluster type:
diff --git a/lib/data.c b/lib/data.c
index 6bc554d..b9dd07b 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -275,6 +275,26 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 			continue;
 		}
 
+		if (map.m_flags & EROFS_MAP_FRAGMENTS) {
+			char *out;
+
+			out = malloc(length - skip);
+			if (!out) {
+				ret = -ENOMEM;
+				break;
+			}
+			ret = z_erofs_read_data(sbi.frags_inode, out,
+						length - skip,
+						inode->z_fragmentoff + skip);
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
index b267412..4d3ca00 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -104,6 +104,21 @@ int erofs_read_superblock(void)
 	sbi.xattr_blkaddr = le32_to_cpu(dsb->xattr_blkaddr);
 	sbi.islotbits = EROFS_ISLOTBITS;
 	sbi.root_nid = le16_to_cpu(dsb->root_nid);
+	sbi.frags_inode = NULL;
+	if (erofs_sb_has_fragments()) {
+		struct erofs_inode *inode;
+
+		inode = calloc(1, sizeof(struct erofs_inode));
+		if (!inode)
+			return -ENOMEM;
+		inode->nid = le64_to_cpu(dsb->frags_nid);
+		ret = erofs_read_inode_from_disk(inode);
+		if (ret) {
+			free(inode);
+			return ret;
+		}
+		sbi.frags_inode = inode;
+	}
 	sbi.inos = le64_to_cpu(dsb->inos);
 	sbi.checksum = le32_to_cpu(dsb->checksum);
 
@@ -111,11 +126,18 @@ int erofs_read_superblock(void)
 	sbi.build_time_nsec = le32_to_cpu(dsb->build_time_nsec);
 
 	memcpy(&sbi.uuid, dsb->uuid, sizeof(dsb->uuid));
-	return erofs_init_devices(&sbi, dsb);
+
+	ret = erofs_init_devices(&sbi, dsb);
+	if (ret && sbi.frags_inode)
+		free(sbi.frags_inode);
+	return ret;
 }
 
 void erofs_put_super(void)
 {
 	if (sbi.devs)
 		free(sbi.devs);
+
+	if (sbi.frags_inode)
+		free(sbi.frags_inode);
 }
diff --git a/lib/zmap.c b/lib/zmap.c
index 95745c5..16267ae 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -83,6 +83,20 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 		if (ret < 0)
 			return ret;
 	}
+	if (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER) {
+		vi->z_fragmentoff = le32_to_cpu(h->h_fragmentoff);
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
+	bool infrags = vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
 	struct z_erofs_maprecorder m = {
 		.inode = vi,
 		.map = map,
@@ -609,6 +624,9 @@ static int z_erofs_do_map_blocks(struct erofs_inode *vi,
 		map->m_flags |= EROFS_MAP_META;
 		map->m_pa = vi->z_idataoff;
 		map->m_plen = vi->z_idata_size;
+	} else if (infrags && m.lcn == vi->z_tailextent_headlcn) {
+		map->m_flags |= EROFS_MAP_FRAGMENTS;
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
+		map->m_flags = EROFS_MAP_MAPPED | EROFS_MAP_FRAGMENTS;
+		goto out;
+	}
+
 	err = z_erofs_do_map_blocks(vi, map, flags);
 out:
 	DBG_BUGON(err < 0 && err != -ENOMEM);
-- 
2.17.1

