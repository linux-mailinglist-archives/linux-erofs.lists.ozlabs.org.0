Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 046FB5B6C30
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Sep 2022 13:07:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MRgdw61nFz3bnH
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Sep 2022 21:07:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=WRRnMuQ5;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=WRRnMuQ5;
	dkim-atps=neutral
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MRgdh4v5Gz2xvJ
	for <linux-erofs@lists.ozlabs.org>; Tue, 13 Sep 2022 21:06:48 +1000 (AEST)
Received: by mail-pj1-x102c.google.com with SMTP id q15-20020a17090a304f00b002002ac83485so11009212pjl.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 13 Sep 2022 04:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=8mkzjSRjFKMU3g2uHBonaE+/cKBJcje4WHjCeYyn5Xs=;
        b=WRRnMuQ5Lf48hM8gQi6eeTIMn8UwJnvuDDpNilFcVdEIGaCsl9ERnAJriqEa1ZEfHN
         taPqlIEkH+OFk/LszRMqoYTit2d/0poDUZzo8T87CgsdSb2x8asvQS1jShoMpWyct+j/
         FW+oHP3VvO35i2v2agVfE4FxT6GRPRHtRKbjtBQK0rlVFO1WhKmOeHHCYMPOMyJxXjfc
         vPo+SWwFsmh4sKXnrgSPEKz9GCVEFXe7hnrxlxt0bT1nTR08dOhbIkf84oKUay6BEH6x
         0D0PT2JytXPkvA0/rpoUlPg2VYKKV9niGVtGHSbqcqhBhONJYcpU+pYlvIUfby+kGaIc
         pR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=8mkzjSRjFKMU3g2uHBonaE+/cKBJcje4WHjCeYyn5Xs=;
        b=yqIvlcQgigfDxh26ii/RgH9DHufthVIir4Q4flZ81S9giD0PRd9LX+w8Il13WZNlJf
         1C+trhW7rzFuPJzeK968bjtBh/lnUCvBH2dmVa1pWxn8P65Ul++Yg4ELvE99ryvKkV4C
         Q/sQG1Mo97s0AWBG6aSemBJgIDJNISQrw9vynm1dVY93TZIQ3kYlhEfLxb7Em0CCn/Kx
         rB10j3huEM5oqrqJ7xVjkTxUVZKfFS4EHaLExrroh2A3KqlZp/kYQaRqFopF0BP6mVEa
         Dmo8u2V1MymFg+bcPsNGijxunrh/iNKgRmgoeKwtWeMcK+ypDdpxqTVlOHebKku7GbzW
         V97g==
X-Gm-Message-State: ACgBeo2m/wVb9ehZZWA/nTdjKr3tP1ImjxPc9S7hoNx+Hae0P3aD+164
	/4nrHFjtpmFGbw7mFNYqEMmFwcI6CZA=
X-Google-Smtp-Source: AA6agR60i5Jmhi23RnPgayTyVAQVNdUGw6XHH2oPUEweOmGWsirHXAJ9qzxrdsZQNxE7kKnr0MKL2Q==
X-Received: by 2002:a17:90b:4a89:b0:202:d56e:e202 with SMTP id lp9-20020a17090b4a8900b00202d56ee202mr3340730pjb.22.1663067206251;
        Tue, 13 Sep 2022 04:06:46 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id cm3-20020a17090afa0300b002000d577cc3sm6888658pjb.55.2022.09.13.04.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 04:06:46 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: xiang@kernel.org,
	chao@kernel.org
Subject: [RFC PATCH v4 2/2] erofs: support on-disk compressed fragments data
Date: Tue, 13 Sep 2022 19:05:52 +0800
Message-Id: <6ded0c212d7da65b70c853fd04f21da229cdefb1.1663066966.git.huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1663065625.git.huyue2@coolpad.com>
References: <cover.1663065625.git.huyue2@coolpad.com>
In-Reply-To: <cover.1663066966.git.huyue2@coolpad.com>
References: <cover.1663066966.git.huyue2@coolpad.com>
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
Cc: linux-kernel@vger.kernel.org, zhangwen@coolpad.com, Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, shaojunjun@coolpad.com
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
 fs/erofs/erofs_fs.h | 29 +++++++++++++++++++++------
 fs/erofs/internal.h | 16 ++++++++++++---
 fs/erofs/super.c    | 15 ++++++++++++++
 fs/erofs/sysfs.c    |  2 ++
 fs/erofs/zdata.c    | 48 ++++++++++++++++++++++++++++++++++++++++++++-
 fs/erofs/zmap.c     | 48 +++++++++++++++++++++++++++++++++++++++++++--
 6 files changed, 146 insertions(+), 12 deletions(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 5c1de6d7ad71..aa976757328b 100644
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
@@ -421,6 +435,9 @@ static inline void erofs_check_ondisk_layout_definitions(void)
 
 	BUILD_BUG_ON(BIT(Z_EROFS_VLE_DI_CLUSTER_TYPE_BITS) <
 		     Z_EROFS_VLE_CLUSTER_TYPE_MAX - 1);
+	WARN_ON(*(__le64 *)&(struct z_erofs_map_header) {
+			.h_clusterbits = 1 << Z_EROFS_FRAGMENT_INODE_BIT
+		} != cpu_to_le64(1ULL << 63));
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
index 5792ca9e0d5e..aa2a3cdeea57 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -650,6 +650,33 @@ static bool should_alloc_managed_pages(struct z_erofs_decompress_frontend *fe,
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
+		if (IS_ERR(src))
+			return PTR_ERR(src);
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
@@ -688,7 +715,8 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 		/* didn't get a valid pcluster previously (very rare) */
 	}
 
-	if (!(map->m_flags & EROFS_MAP_MAPPED))
+	if (!(map->m_flags & EROFS_MAP_MAPPED) ||
+	    map->m_flags & EROFS_MAP_FRAGMENT)
 		goto hitted;
 
 	err = z_erofs_collector_begin(fe);
@@ -735,6 +763,24 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
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

