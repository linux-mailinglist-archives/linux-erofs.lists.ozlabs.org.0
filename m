Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 929F756F9E8
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Jul 2022 11:10:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LhJ5F3BSlz3c3R
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Jul 2022 19:10:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=BbV5jRU+;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=BbV5jRU+;
	dkim-atps=neutral
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LhJ532ydLz3brk
	for <linux-erofs@lists.ozlabs.org>; Mon, 11 Jul 2022 19:10:30 +1000 (AEST)
Received: by mail-pj1-x1034.google.com with SMTP id x18-20020a17090a8a9200b001ef83b332f5so7701769pjn.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 11 Jul 2022 02:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=6vbnxYtGOcoDdQFarFN5fP+O3u92P3/5Xq/oqc/SmuA=;
        b=BbV5jRU+3mOr9d3Wv+R8lhX9hOxi/OWOFf7hKqkxwloUgKtZBHbipyprB1Yx58X7Ke
         KKFs3cM6e7Ij9/caalYX+CrE3goZ3t4LUizZy2HsAxEKFNVa3A5z3YN6EempbgVb5PAZ
         RtAxpIfm9MeOTWQS11WIp0tpmclJjo+NSKLo71bogrWwNPlkIs+VqptKwsdp3Ikg1mgQ
         CUNE+/j3RW4mmEtJayj85cVKc+s6n/D4XUQ6NteZsnZlUIFY61/cDNJtfisOhe3GGlAw
         Dav0Zfs/56NE25B17+LE0wbhbp7hOD4CHoH8GRY8DcnEmF8VftaouAb+DGHkR0ZcTd31
         6agw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=6vbnxYtGOcoDdQFarFN5fP+O3u92P3/5Xq/oqc/SmuA=;
        b=bU8PY+8ZgE9QF6KphHBwAd0YZUPW4M/D/jJ8O4y3n6DUa7Q+e6R03ebU+xkNVIwBv9
         a7CSxRteGwww6l4lVMColTNZc367SfdMZOmhug82AbLj4oHEUOUFl48IfvrtFCQAOubI
         2e993S6KSoMY5dI8KAAYJ7oct9kzY7MH2y12OCyE/R9hbijl39INeXwCmYcpkXjhRBSD
         Y5pz7pGxxL9BcGowBxb46tqDhllz4psBjUmF7f1ah+rWPBu0bcT3j/3HtBVqGiFu9LGI
         mNsPYXnwuDh1TkLe9EBfm2z9qHY9fAvXO8YMbB7AjoCDvUgklYc3oIPV4Lg3rhJ+9eIv
         Exrw==
X-Gm-Message-State: AJIora/5Ceyo3UhVGcTCKBArZ7lV2RVaRBJfhTyN/Pc0x+JOzAO+myen
	LTQutbT4dcIOM7sI+Yxk68fwJ79q4QQ=
X-Google-Smtp-Source: AGRyM1uO6vtFf0wAxJyxhOHAiXPBFNABCiqUtr0MIX5Ede1kq2JBiDNYN22pZ8fgezVnl7ZCAtGvtw==
X-Received: by 2002:a17:903:124f:b0:16b:8167:e34e with SMTP id u15-20020a170903124f00b0016b8167e34emr17550164plh.52.1657530628017;
        Mon, 11 Jul 2022 02:10:28 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id n2-20020a170902968200b00165105518f6sm4145052plp.287.2022.07.11.02.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 02:10:27 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
X-Google-Original-From: Yue Hu <huyue2@coolpad.com>
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH 1/3] erofs-utils: lib: add support for fragments data decompression
Date: Mon, 11 Jul 2022 17:09:56 +0800
Message-Id: <dd0bd2a492096bd4c2e5e78070ab39667f49702a.1657530420.git.huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1657528899.git.huyue2@coolpad.com>
References: <cover.1657528899.git.huyue2@coolpad.com>
In-Reply-To: <cover.1657530420.git.huyue2@coolpad.com>
References: <cover.1657530420.git.huyue2@coolpad.com>
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
Cc: Yue Hu <huyue2@coolpad.com>, zhangwen@coolpad.com, shaojunjun@coolpad.com, zbestahu@163.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add compressed fragments support for erofsfuse.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 include/erofs/internal.h |  8 ++++++++
 include/erofs_fs.h       | 15 +++++++++++----
 lib/data.c               | 26 ++++++++++++++++++++++++++
 lib/zmap.c               | 14 ++++++++++++++
 4 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 6a70f11..129ea54 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -102,6 +102,7 @@ struct erofs_sb_info {
 		u16 devt_slotoff;		/* used for mkfs */
 		u16 device_id_mask;		/* used for others */
 	};
+	erofs_nid_t fragments_nid;
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
index 08f9761..4a0c74b 100644
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
diff --git a/lib/data.c b/lib/data.c
index 6bc554d..c2ecbc9 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -275,6 +275,32 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 			continue;
 		}
 
+		if (map.m_flags & EROFS_MAP_FRAGMENTS) {
+			struct erofs_inode fragments = {
+					.nid = sbi.fragments_nid,
+			};
+			char *out;
+
+			ret = erofs_read_inode_from_disk(&fragments);
+			if (ret)
+				break;
+			out = malloc(length);
+			if (!out) {
+				ret = -ENOMEM;
+				break;
+			}
+			ret = z_erofs_read_data(&fragments, out, length,
+						inode->z_fragmentoff);
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
diff --git a/lib/zmap.c b/lib/zmap.c
index 95745c5..2b45a4f 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -83,6 +83,17 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
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
@@ -546,6 +557,7 @@ static int z_erofs_do_map_blocks(struct erofs_inode *vi,
 				 int flags)
 {
 	bool ztailpacking = vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER;
+	bool in_fragments = vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
 	struct z_erofs_maprecorder m = {
 		.inode = vi,
 		.map = map,
@@ -609,6 +621,8 @@ static int z_erofs_do_map_blocks(struct erofs_inode *vi,
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

