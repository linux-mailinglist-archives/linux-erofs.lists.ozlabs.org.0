Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9DF57EC6B
	for <lists+linux-erofs@lfdr.de>; Sat, 23 Jul 2022 09:17:54 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Lqd1X0v8jz3c2g
	for <lists+linux-erofs@lfdr.de>; Sat, 23 Jul 2022 17:17:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=nV4ujsIJ;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=nV4ujsIJ;
	dkim-atps=neutral
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Lqd1J725Hz302d
	for <linux-erofs@lists.ozlabs.org>; Sat, 23 Jul 2022 17:17:39 +1000 (AEST)
Received: by mail-pj1-x1033.google.com with SMTP id d7-20020a17090a564700b001f209736b89so9975344pji.0
        for <linux-erofs@lists.ozlabs.org>; Sat, 23 Jul 2022 00:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=uhRFyozIjIFHddgkFvvRdYDXh+HRdmOX50HJ8s71N74=;
        b=nV4ujsIJO4f64H1SFiYfEpbPdIdmz9wuISpsfQrMgSbTEVbrsvNejIxI0zkksO37O8
         4dk5twiqm9JHkbo0w8AAtYePS1kMpxGehYOmmyWI/JVk3zdQH8FH7lhm4xJXYVbDCbGq
         dk/rscwDSGJhAY48u3h1yPZY7pXX8VO9csxba8lqZR2kayZT3QtaOSnyeHC6EG1Y0vqp
         QyMp1uqf9Ar5vpPSe0MoQjU20F+1MV5zJ1i+WC7fNzKjtauExpbSB0xcxXAyoW5H4X5a
         NChJtXflU7sShq6J8595aIWvP/0kn83PNcVVk0xGVCLY/xSnVUfClOp97IGyEdeOk8D5
         /EVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=uhRFyozIjIFHddgkFvvRdYDXh+HRdmOX50HJ8s71N74=;
        b=XMT4yiR2oypRq//w7z+50ulTaTteWYV9IjtqM4hGsOd0/GjMlYuiK6jfm6tmCCuY8c
         70ecFEs0kvSPI3pDY4brI83p7mt2VEq690KjNlbIcxLhKDyzYtZR6Y4EgqwQributoFZ
         l0B3TRv+ndI0Mxlh8tHwEcZAUUg062yX2O5FRMhBQpfuBb2huM2F23aUZtMsGzbx0mEu
         pbfl6MiYTUW2gxMuQ41hL/6UO2DAo0OiKv5Dtv1yetA3+aZpZamCYdEGY9qEXGaeW5dA
         YCzixhwmyoiiT02Qf4Sx15uBQ8GW4lPD26cT56rLzWCf8aOBTYjE66g7hxS2kz1VJj7j
         NgLQ==
X-Gm-Message-State: AJIora8Tc1EHx0HLTPRWIWouWk4irAS+2sJeTaNyX5vQIWLYKWYO0b/C
	4a87tNqawM0sJd6CGS05WZL973U5w5s=
X-Google-Smtp-Source: AGRyM1v3+LDNwiXvhDo9jS7szfHgg195yAQ5j0NJRVQbRGWAQpuJBmP4HvI3HyHS9k09QEPR0owTnQ==
X-Received: by 2002:a17:90a:9a91:b0:1f2:34eb:6f8c with SMTP id e17-20020a17090a9a9100b001f234eb6f8cmr12448011pjp.91.1658560655461;
        Sat, 23 Jul 2022 00:17:35 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id y66-20020a633245000000b00411955c03e5sm4535290pgy.29.2022.07.23.00.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 00:17:35 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
X-Google-Original-From: Yue Hu <huyue2@coolpad.com>
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH v2 1/3] erofs-utils: lib: add support for fragments data decompression
Date: Sat, 23 Jul 2022 15:17:13 +0800
Message-Id: <1385bcc612436d7fa149950515b816347528e5d5.1658556336.git.huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1658556336.git.huyue2@coolpad.com>
References: <cover.1658556336.git.huyue2@coolpad.com>
In-Reply-To: <cover.1658556336.git.huyue2@coolpad.com>
References: <cover.1658556336.git.huyue2@coolpad.com>
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
 include/erofs/internal.h | 13 +++++++++++
 include/erofs_fs.h       | 19 +++++++++++----
 lib/data.c               | 50 ++++++++++++++++++++++++++++++++++++++--
 lib/zmap.c               | 18 ++++++++++++---
 4 files changed, 90 insertions(+), 10 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 48498fe..ce235de 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -102,6 +102,7 @@ struct erofs_sb_info {
 		u16 devt_slotoff;		/* used for mkfs */
 		u16 device_id_mask;		/* used for others */
 	};
+	struct erofs_inode *fragments_inode;
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
@@ -208,6 +213,11 @@ struct erofs_inode {
 #endif
 };
 
+static inline erofs_off_t z_erofs_map_header_pos(struct erofs_inode *vi)
+{
+	return round_up(iloc(vi->nid) + vi->inode_isize + vi->xattr_isize, 8);
+}
+
 static inline bool is_inode_layout_compression(struct erofs_inode *inode)
 {
 	return erofs_inode_is_data_compressed(inode->datalayout);
@@ -276,6 +286,7 @@ enum {
 	BH_Mapped,
 	BH_Encoded,
 	BH_FullMapped,
+	BH_Fragments,
 };
 
 /* Has a disk mapping */
@@ -286,6 +297,8 @@ enum {
 #define EROFS_MAP_ENCODED	(1 << BH_Encoded)
 /* The length of extent is full */
 #define EROFS_MAP_FULL_MAPPED	(1 << BH_FullMapped)
+/* Located in fragments */
+#define EROFS_MAP_FRAGMENTS	(1 << BH_Fragments)
 
 struct erofs_map_blocks {
 	char mpage[EROFS_BLKSIZ];
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index 08f9761..d957ebb 100644
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
 
@@ -294,16 +296,21 @@ struct z_erofs_lzma_cfgs {
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
+		/* record the size of tailpacking data */
+		__le16	h_idata_size;
+	};
 	__le16	h_advise;
 	/*
 	 * bit 0-3 : algorithm type of head 1 (logical cluster type 01);
@@ -312,12 +319,14 @@ struct z_erofs_map_header {
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
index 6bc554d..2f3ebb8 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -217,8 +217,8 @@ static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
 	return 0;
 }
 
-static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
-			     erofs_off_t size, erofs_off_t offset)
+static int z_erofs_do_read_data(struct erofs_inode *inode, char *buffer,
+				erofs_off_t size, erofs_off_t offset)
 {
 	erofs_off_t end, length, skip;
 	struct erofs_map_blocks map = {
@@ -275,6 +275,27 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 			continue;
 		}
 
+		if (map.m_flags & EROFS_MAP_FRAGMENTS) {
+			char *out;
+
+			out = malloc(length);
+			if (!out) {
+				ret = -ENOMEM;
+				break;
+			}
+			ret = z_erofs_do_read_data(sbi.fragments_inode, out,
+						   length,
+						   inode->z_fragmentoff);
+			if (ret < 0) {
+				free(out);
+				break;
+			}
+			memcpy(buffer + end - offset, out + skip, length -
+			       skip);
+			free(out);
+			continue;
+		}
+
 		if (map.m_plen > bufsize) {
 			bufsize = map.m_plen;
 			raw = realloc(raw, bufsize);
@@ -304,6 +325,31 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 	return ret < 0 ? ret : 0;
 }
 
+static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
+			     erofs_off_t size, erofs_off_t offset)
+{
+	struct erofs_inode *vi = inode;
+
+	if (erofs_sb_has_fragments()) {
+		int ret;
+		struct z_erofs_map_header *h;
+		char buf[sizeof(struct z_erofs_map_header)];
+
+		ret = dev_read(0, buf, z_erofs_map_header_pos(inode),
+			       sizeof(buf));
+		if (ret < 0)
+			return -EIO;
+
+		h = (struct z_erofs_map_header *)buf;
+
+		if (h->h_clusterbits >> Z_EROFS_FRAGMENT_INODE_BIT) {
+			vi = sbi.fragments_inode;
+			offset += le32_to_cpu(h->h_fragmentoff);
+		}
+	}
+	return z_erofs_do_read_data(vi, buffer, size, offset);
+}
+
 int erofs_pread(struct erofs_inode *inode, char *buf,
 		erofs_off_t count, erofs_off_t offset)
 {
diff --git a/lib/zmap.c b/lib/zmap.c
index 95745c5..812bf32 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -32,7 +32,6 @@ int z_erofs_fill_inode(struct erofs_inode *vi)
 static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 {
 	int ret;
-	erofs_off_t pos;
 	struct z_erofs_map_header *h;
 	char buf[sizeof(struct z_erofs_map_header)];
 
@@ -42,9 +41,8 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 	DBG_BUGON(!erofs_sb_has_big_pcluster() &&
 		  !erofs_sb_has_ztailpacking() &&
 		  vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY);
-	pos = round_up(iloc(vi->nid) + vi->inode_isize + vi->xattr_isize, 8);
 
-	ret = dev_read(0, buf, pos, sizeof(buf));
+	ret = dev_read(0, buf, z_erofs_map_header_pos(vi), sizeof(buf));
 	if (ret < 0)
 		return -EIO;
 
@@ -83,6 +81,17 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 		if (ret < 0)
 			return ret;
 	}
+	if (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER) {
+		struct erofs_map_blocks map = { .index = UINT_MAX };
+
+		ret = z_erofs_do_map_blocks(vi, &map,
+					    EROFS_GET_BLOCKS_FINDTAIL);
+		if (ret < 0) {
+			erofs_err("failed to find tail for fragment pcluster");
+			return ret;
+		}
+		vi->z_fragmentoff = le32_to_cpu(h->h_fragmentoff);
+	}
 	vi->flags |= EROFS_I_Z_INITED;
 	return 0;
 }
@@ -546,6 +555,7 @@ static int z_erofs_do_map_blocks(struct erofs_inode *vi,
 				 int flags)
 {
 	bool ztailpacking = vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER;
+	bool in_fragments = vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
 	struct z_erofs_maprecorder m = {
 		.inode = vi,
 		.map = map,
@@ -609,6 +619,8 @@ static int z_erofs_do_map_blocks(struct erofs_inode *vi,
 		map->m_flags |= EROFS_MAP_META;
 		map->m_pa = vi->z_idataoff;
 		map->m_plen = vi->z_idata_size;
+	} else if (in_fragments && m.lcn == vi->z_tailextent_headlcn) {
+		map->m_flags |= EROFS_MAP_FRAGMENTS;
 	} else {
 		map->m_pa = blknr_to_addr(m.pblk);
 		err = z_erofs_get_extent_compressedlen(&m, initial_lcn);
-- 
2.17.1

