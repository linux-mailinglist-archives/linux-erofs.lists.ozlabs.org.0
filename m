Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF4E5E71CA
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Sep 2022 04:12:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MYbK46dbBz3c6N
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Sep 2022 12:12:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=eB4THW3H;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=eB4THW3H;
	dkim-atps=neutral
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MYbJy234qz3bfH
	for <linux-erofs@lists.ozlabs.org>; Fri, 23 Sep 2022 12:12:49 +1000 (AEST)
Received: by mail-pl1-x635.google.com with SMTP id f23so10496603plr.6
        for <linux-erofs@lists.ozlabs.org>; Thu, 22 Sep 2022 19:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=Soa9weVFXoOBJnhIq6RkE6s4YOBAR0rQsqqyIUPR6D0=;
        b=eB4THW3HrcIKj1gOBRDsoPFIwx2evGJugMdveGefuYO5YM0jH6Ioh502MucrR2Gwwp
         SUDetRpN/JRFl2NbCOK/2oex/TPk/ctlinaELONT7tjpRY0y+Xom2DJC/ZC5gd8aYJzT
         f9i7ngvRb4qax+Bp6CGo6Q51hd0Xt/tMf+mCIriD+PKaLuaW3vvAtGyl+S2ngJwM2jK4
         khT8EetL3nkE374cesUSOKScmnRxUQck0/GFPmyBrwd43i0qBhAHZ8K9vPFbdt/t+gMa
         iHqI6JlO4yqaElEhL3iy0oXGmmAgGeU9XnccWW8Uvw8IeMyiQ1PJZ85PZ8B282/UdVV5
         kreg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Soa9weVFXoOBJnhIq6RkE6s4YOBAR0rQsqqyIUPR6D0=;
        b=P4Vv2Yc/T39dTNXPSaf08Vhu8jHkBZxXucftG4yUBsHHXn9yoWOXyAd9JtCOdlGeZT
         F4EoP5V2DKbRr+jq9+wPoOoznmoYf6dfrSkAlObZSdstEkbJ+Sylpgda1lWrR25dEORW
         DvSmJvrvSZRBCgjpjbyH6pgPA44tl2bxit2IIVN9Ay41f/vpK+OVVSCB+B7Ic5wq8LaD
         Sp8R9F3v8XheUmEAu1wC9xLieqFxVv5qWrcQnQNslPE7SzWyncPqTJspoiiTDJb/kxlw
         +RvZc+lTNXNUbAMBdaDHhc2bT+iQXp94uc632CgTgnxAL2dC5L/ORmbj0D0U0zjZUgVu
         POXA==
X-Gm-Message-State: ACrzQf181cB+rXNdVI66ZNwBMaTBYXaWYQTYYsGGn4qA8/uM/H8Qa63o
	zC2WUJr4UsAJe0ORKhukoYM=
X-Google-Smtp-Source: AMsMyM6K7qyCL2EvgpRcd3Mm4IQ6FZhzuXY76RrUmADlCxZ3FL4qjQuzsjzKjywPDzTCsromPqwYqQ==
X-Received: by 2002:a17:903:32ca:b0:178:29e4:15b6 with SMTP id i10-20020a17090332ca00b0017829e415b6mr6081615plr.77.1663899166845;
        Thu, 22 Sep 2022 19:12:46 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902e54300b001768517f99esm4735204plf.244.2022.09.22.19.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 19:12:46 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: xiang@kernel.org,
	chao@kernel.org
Subject: [PATCH v6 2/2] erofs: support on-disk compressed fragments data
Date: Fri, 23 Sep 2022 10:11:22 +0800
Message-Id: <43059e8a573a424731e393442c7e06679b03cd78.1663898962.git.huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <8369112678604fdf4ef796626d59b1fdd0745a53.1663898962.git.huyue2@coolpad.com>
References: <8369112678604fdf4ef796626d59b1fdd0745a53.1663898962.git.huyue2@coolpad.com>
In-Reply-To: <cover.1663898962.git.huyue2@coolpad.com>
References: <cover.1663898962.git.huyue2@coolpad.com>
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
Cc: Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

Introduce on-disk compressed fragments data feature.

This approach adds a new field called `h_fragmentoff' in the per-file
compression header to indicate the fragment offset of each tail pcluster
or the whole file in the special packed inode.

Similar to ztailpacking, it will also find and record the 'headlcn'
of the tail pcluster when initializing per-inode zmap for making
follow-on requests more easy.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fs/erofs/erofs_fs.h | 33 ++++++++++++++++++++++++------
 fs/erofs/internal.h | 16 ++++++++++++---
 fs/erofs/super.c    | 15 ++++++++++++++
 fs/erofs/sysfs.c    |  2 ++
 fs/erofs/zdata.c    | 50 ++++++++++++++++++++++++++++++++++++++++++++-
 fs/erofs/zmap.c     | 48 +++++++++++++++++++++++++++++++++++++++++--
 6 files changed, 152 insertions(+), 12 deletions(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 5c1de6d7ad71..5d8fefd8b3fb 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -25,6 +25,7 @@
 #define EROFS_FEATURE_INCOMPAT_DEVICE_TABLE	0x00000008
 #define EROFS_FEATURE_INCOMPAT_COMPR_HEAD2	0x00000008
 #define EROFS_FEATURE_INCOMPAT_ZTAILPACKING	0x00000010
+#define EROFS_FEATURE_INCOMPAT_FRAGMENTS	0x00000020
 #define EROFS_ALL_FEATURE_INCOMPAT		\
 	(EROFS_FEATURE_INCOMPAT_ZERO_PADDING | \
 	 EROFS_FEATURE_INCOMPAT_COMPR_CFGS | \
@@ -32,7 +33,8 @@
 	 EROFS_FEATURE_INCOMPAT_CHUNKED_FILE | \
 	 EROFS_FEATURE_INCOMPAT_DEVICE_TABLE | \
 	 EROFS_FEATURE_INCOMPAT_COMPR_HEAD2 | \
-	 EROFS_FEATURE_INCOMPAT_ZTAILPACKING)
+	 EROFS_FEATURE_INCOMPAT_ZTAILPACKING | \
+	 EROFS_FEATURE_INCOMPAT_FRAGMENTS)
 
 #define EROFS_SB_EXTSLOT_SIZE	16
 
@@ -71,7 +73,9 @@ struct erofs_super_block {
 	} __packed u1;
 	__le16 extra_devices;	/* # of devices besides the primary device */
 	__le16 devt_slotoff;	/* startoff = devt_slotoff * devt_slotsize */
-	__u8 reserved2[38];
+	__u8 reserved[6];
+	__le64 packed_nid;	/* nid of the special packed inode */
+	__u8 reserved2[24];
 };
 
 /*
@@ -296,17 +300,26 @@ struct z_erofs_lzma_cfgs {
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
 
+#define Z_EROFS_FRAGMENT_INODE_BIT              7
 struct z_erofs_map_header {
-	__le16	h_reserved1;
-	/* indicates the encoded size of tailpacking data */
-	__le16  h_idata_size;
+	union {
+		/* fragment data offset in the packed inode */
+		__le32  h_fragmentoff;
+		struct {
+			__le16  h_reserved1;
+			/* indicates the encoded size of tailpacking data */
+			__le16  h_idata_size;
+		};
+	};
 	__le16	h_advise;
 	/*
 	 * bit 0-3 : algorithm type of head 1 (logical cluster type 01);
@@ -315,7 +328,8 @@ struct z_erofs_map_header {
 	__u8	h_algorithmtype;
 	/*
 	 * bit 0-2 : logical cluster bits - 12, e.g. 0 for 4096;
-	 * bit 3-7 : reserved.
+	 * bit 3-6 : reserved;
+	 * bit 7   : move the whole file into packed inode or not.
 	 */
 	__u8	h_clusterbits;
 };
@@ -404,6 +418,10 @@ struct erofs_dirent {
 /* check the EROFS on-disk layout strictly at compile time */
 static inline void erofs_check_ondisk_layout_definitions(void)
 {
+	const __le64 fmh = *(__le64 *)&(struct z_erofs_map_header) {
+			.h_clusterbits = 1 << Z_EROFS_FRAGMENT_INODE_BIT
+			};
+
 	BUILD_BUG_ON(sizeof(struct erofs_super_block) != 128);
 	BUILD_BUG_ON(sizeof(struct erofs_inode_compact) != 32);
 	BUILD_BUG_ON(sizeof(struct erofs_inode_extended) != 64);
@@ -421,6 +439,9 @@ static inline void erofs_check_ondisk_layout_definitions(void)
 
 	BUILD_BUG_ON(BIT(Z_EROFS_VLE_DI_CLUSTER_TYPE_BITS) <
 		     Z_EROFS_VLE_CLUSTER_TYPE_MAX - 1);
+	/* exclude old compiler versions like gcc 7.5.0 */
+	BUILD_BUG_ON(__builtin_constant_p(fmh) ?
+		     fmh != cpu_to_le64(1ULL << 63) : 0);
 }
 
 #endif
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index f3ed36445d73..b133664b4ad2 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -120,6 +120,7 @@ struct erofs_sb_info {
 	struct inode *managed_cache;
 
 	struct erofs_sb_lz4_info lz4;
+	struct inode *packed_inode;
 #endif	/* CONFIG_EROFS_FS_ZIP */
 	struct erofs_dev_context *devs;
 	struct dax_device *dax_dev;
@@ -306,6 +307,7 @@ EROFS_FEATURE_FUNCS(chunked_file, incompat, INCOMPAT_CHUNKED_FILE)
 EROFS_FEATURE_FUNCS(device_table, incompat, INCOMPAT_DEVICE_TABLE)
 EROFS_FEATURE_FUNCS(compr_head2, incompat, INCOMPAT_COMPR_HEAD2)
 EROFS_FEATURE_FUNCS(ztailpacking, incompat, INCOMPAT_ZTAILPACKING)
+EROFS_FEATURE_FUNCS(fragments, incompat, INCOMPAT_FRAGMENTS)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 
 /* atomic flag definitions */
@@ -341,8 +343,13 @@ struct erofs_inode {
 			unsigned char  z_algorithmtype[2];
 			unsigned char  z_logical_clusterbits;
 			unsigned long  z_tailextent_headlcn;
-			erofs_off_t    z_idataoff;
-			unsigned short z_idata_size;
+			union {
+				struct {
+					erofs_off_t    z_idataoff;
+					unsigned short z_idata_size;
+				};
+				erofs_off_t z_fragmentoff;
+			};
 		};
 #endif	/* CONFIG_EROFS_FS_ZIP */
 	};
@@ -400,6 +407,7 @@ extern const struct address_space_operations z_erofs_aops;
 enum {
 	BH_Encoded = BH_PrivateStart,
 	BH_FullMapped,
+	BH_Fragment,
 };
 
 /* Has a disk mapping */
@@ -410,6 +418,8 @@ enum {
 #define EROFS_MAP_ENCODED	(1 << BH_Encoded)
 /* The length of extent is full */
 #define EROFS_MAP_FULL_MAPPED	(1 << BH_FullMapped)
+/* Located in the special packed inode */
+#define EROFS_MAP_FRAGMENT	(1 << BH_Fragment)
 
 struct erofs_map_blocks {
 	struct erofs_buf buf;
@@ -431,7 +441,7 @@ struct erofs_map_blocks {
 #define EROFS_GET_BLOCKS_FIEMAP	0x0002
 /* Used to map the whole extent if non-negligible data is requested for LZMA */
 #define EROFS_GET_BLOCKS_READMORE	0x0004
-/* Used to map tail extent for tailpacking inline pcluster */
+/* Used to map tail extent for tailpacking inline or fragment pcluster */
 #define EROFS_GET_BLOCKS_FINDTAIL	0x0008
 
 enum {
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 3173debeaa5a..8170c0d8ab92 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -381,6 +381,17 @@ static int erofs_read_superblock(struct super_block *sb)
 #endif
 	sbi->islotbits = ilog2(sizeof(struct erofs_inode_compact));
 	sbi->root_nid = le16_to_cpu(dsb->root_nid);
+#ifdef CONFIG_EROFS_FS_ZIP
+	sbi->packed_inode = NULL;
+	if (erofs_sb_has_fragments(sbi)) {
+		sbi->packed_inode =
+			erofs_iget(sb, le64_to_cpu(dsb->packed_nid), false);
+		if (IS_ERR(sbi->packed_inode)) {
+			ret = PTR_ERR(sbi->packed_inode);
+			goto out;
+		}
+	}
+#endif
 	sbi->inos = le64_to_cpu(dsb->inos);
 
 	sbi->build_time = le64_to_cpu(dsb->build_time);
@@ -411,6 +422,8 @@ static int erofs_read_superblock(struct super_block *sb)
 		erofs_info(sb, "EXPERIMENTAL compressed inline data feature in use. Use at your own risk!");
 	if (erofs_is_fscache_mode(sb))
 		erofs_info(sb, "EXPERIMENTAL fscache-based on-demand read feature in use. Use at your own risk!");
+	if (erofs_sb_has_fragments(sbi))
+		erofs_info(sb, "EXPERIMENTAL compressed fragments feature in use. Use at your own risk!");
 out:
 	erofs_put_metabuf(&buf);
 	return ret;
@@ -908,6 +921,8 @@ static void erofs_put_super(struct super_block *sb)
 #ifdef CONFIG_EROFS_FS_ZIP
 	iput(sbi->managed_cache);
 	sbi->managed_cache = NULL;
+	iput(sbi->packed_inode);
+	sbi->packed_inode = NULL;
 #endif
 	erofs_fscache_unregister_cookie(&sbi->s_fscache);
 }
diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index c1383e508bbe..1b52395be82a 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -76,6 +76,7 @@ EROFS_ATTR_FEATURE(device_table);
 EROFS_ATTR_FEATURE(compr_head2);
 EROFS_ATTR_FEATURE(sb_chksum);
 EROFS_ATTR_FEATURE(ztailpacking);
+EROFS_ATTR_FEATURE(fragments);
 
 static struct attribute *erofs_feat_attrs[] = {
 	ATTR_LIST(zero_padding),
@@ -86,6 +87,7 @@ static struct attribute *erofs_feat_attrs[] = {
 	ATTR_LIST(compr_head2),
 	ATTR_LIST(sb_chksum),
 	ATTR_LIST(ztailpacking),
+	ATTR_LIST(fragments),
 	NULL,
 };
 ATTRIBUTE_GROUPS(erofs_feat);
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 5792ca9e0d5e..c92a72f5bca6 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -650,6 +650,35 @@ static bool should_alloc_managed_pages(struct z_erofs_decompress_frontend *fe,
 		la < fe->headoffset;
 }
 
+static int z_erofs_read_fragment(struct inode *inode, erofs_off_t pos,
+				 struct page *page, unsigned int pageofs,
+				 unsigned int len)
+{
+	struct inode *packed_inode = EROFS_I_SB(inode)->packed_inode;
+	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
+	u8 *src, *dst;
+	unsigned int i, cnt;
+
+	pos += EROFS_I(inode)->z_fragmentoff;
+	for (i = 0; i < len; i += cnt) {
+		cnt = min_t(unsigned int, len - i,
+			    EROFS_BLKSIZ - erofs_blkoff(pos));
+		src = erofs_bread(&buf, packed_inode,
+				  erofs_blknr(pos), EROFS_KMAP);
+		if (IS_ERR(src)) {
+			erofs_put_metabuf(&buf);
+			return PTR_ERR(src);
+		}
+
+		dst = kmap_local_page(page);
+		memcpy(dst + pageofs + i, src + erofs_blkoff(pos), cnt);
+		kunmap_local(dst);
+		pos += cnt;
+	}
+	erofs_put_metabuf(&buf);
+	return 0;
+}
+
 static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 				struct page *page, struct page **pagepool)
 {
@@ -688,7 +717,8 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 		/* didn't get a valid pcluster previously (very rare) */
 	}
 
-	if (!(map->m_flags & EROFS_MAP_MAPPED))
+	if (!(map->m_flags & EROFS_MAP_MAPPED) ||
+	    map->m_flags & EROFS_MAP_FRAGMENT)
 		goto hitted;
 
 	err = z_erofs_collector_begin(fe);
@@ -735,6 +765,24 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 		zero_user_segment(page, cur, end);
 		goto next_part;
 	}
+	if (map->m_flags & EROFS_MAP_FRAGMENT) {
+		unsigned int pageofs, skip, len;
+
+		if (offset > map->m_la) {
+			pageofs = 0;
+			skip = offset - map->m_la;
+		} else {
+			pageofs = map->m_la & ~PAGE_MASK;
+			skip = 0;
+		}
+		len = min_t(unsigned int, map->m_llen - skip, end - cur);
+		err = z_erofs_read_fragment(inode, skip, page, pageofs, len);
+		if (err)
+			goto out;
+		++spiltted;
+		tight = false;
+		goto next_part;
+	}
 
 	exclusive = (!cur && (!spiltted || tight));
 	if (cur)
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 7196235a441c..6830999529d7 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -69,6 +69,16 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 	}
 
 	h = kaddr + erofs_blkoff(pos);
+	/*
+	 * if the highest bit of the 8-byte map header is set, the whole file
+	 * is stored in the packed inode. The rest bits keeps z_fragmentoff.
+	 */
+	if (h->h_clusterbits >> Z_EROFS_FRAGMENT_INODE_BIT) {
+		vi->z_advise = Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
+		vi->z_fragmentoff = le64_to_cpu(*(__le64 *)h) ^ (1ULL << 63);
+		vi->z_tailextent_headlcn = 0;
+		goto unmap_done;
+	}
 	vi->z_advise = le16_to_cpu(h->h_advise);
 	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
 	vi->z_algorithmtype[1] = h->h_algorithmtype >> 4;
@@ -123,6 +133,20 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 		if (err < 0)
 			goto out_unlock;
 	}
+
+	if (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER &&
+	    !(h->h_clusterbits >> Z_EROFS_FRAGMENT_INODE_BIT)) {
+		struct erofs_map_blocks map = {
+			.buf = __EROFS_BUF_INITIALIZER
+		};
+
+		vi->z_fragmentoff = le32_to_cpu(h->h_fragmentoff);
+		err = z_erofs_do_map_blocks(inode, &map,
+					    EROFS_GET_BLOCKS_FINDTAIL);
+		erofs_put_metabuf(&map.buf);
+		if (err < 0)
+			goto out_unlock;
+	}
 	/* paired with smp_mb() at the beginning of the function */
 	smp_mb();
 	set_bit(EROFS_I_Z_INITED_BIT, &vi->flags);
@@ -598,6 +622,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 {
 	struct erofs_inode *const vi = EROFS_I(inode);
 	bool ztailpacking = vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER;
+	bool fragment = vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
 	struct z_erofs_maprecorder m = {
 		.inode = inode,
 		.map = map,
@@ -666,12 +691,20 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 
 	map->m_llen = end - map->m_la;
 
-	if (flags & EROFS_GET_BLOCKS_FINDTAIL)
+	if (flags & EROFS_GET_BLOCKS_FINDTAIL) {
 		vi->z_tailextent_headlcn = m.lcn;
+		/* for non-compact indexes, fragmentoff is 64 bits */
+		if (fragment &&
+		    vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY)
+			vi->z_fragmentoff |= (u64)m.pblk << 32;
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
@@ -715,6 +748,7 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 			    struct erofs_map_blocks *map,
 			    int flags)
 {
+	struct erofs_inode *const vi = EROFS_I(inode);
 	int err = 0;
 
 	trace_z_erofs_map_blocks_iter_enter(inode, map, flags);
@@ -731,6 +765,15 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 	if (err)
 		goto out;
 
+	if ((vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER) &&
+	    !vi->z_tailextent_headlcn) {
+		map->m_la = 0;
+		map->m_llen = inode->i_size;
+		map->m_flags = EROFS_MAP_MAPPED | EROFS_MAP_FULL_MAPPED |
+				EROFS_MAP_FRAGMENT;
+		goto out;
+	}
+
 	err = z_erofs_do_map_blocks(inode, map, flags);
 out:
 	trace_z_erofs_map_blocks_iter_exit(inode, map, flags, err);
@@ -757,7 +800,8 @@ static int z_erofs_iomap_begin_report(struct inode *inode, loff_t offset,
 	iomap->length = map.m_llen;
 	if (map.m_flags & EROFS_MAP_MAPPED) {
 		iomap->type = IOMAP_MAPPED;
-		iomap->addr = map.m_pa;
+		iomap->addr = map.m_flags & EROFS_MAP_FRAGMENT ?
+			      IOMAP_NULL_ADDR : map.m_pa;
 	} else {
 		iomap->type = IOMAP_HOLE;
 		iomap->addr = IOMAP_NULL_ADDR;
-- 
2.17.1

