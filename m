Return-Path: <linux-erofs+bounces-3666-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JVVtE62XM2q2DwYAu9opvQ
	(envelope-from <linux-erofs+bounces-3666-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jun 2026 09:01:01 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B36BB69DF64
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jun 2026 09:01:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=1XGTALCB;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3666-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3666-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ggs7n36jMz2yNn;
	Thu, 18 Jun 2026 17:00:53 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781766053;
	cv=none; b=DBft22qr7JQgAcwSO/93coVXxeD7tkTWxC+ky68BpZnyUWJK9ZpqTwSst30VO9LWv2L/qt7iR2zONNYGGT3Kjlb1s8sD0btrG/1VXB9hnDv/cbsdlg86WBHAyQ4GLYnS2+6y/gPa45evj8BFZjDFPqqf3Usf6cdkDMLRmlKsBIFYX3P0aZkWmS2Yv8u3rpfCJsLJP2n+oAEBeeJDe3cwWB93+esv1d8cTkemqIX391AjupzQqsb4mTelg+y1KdvoYutS5BJT38IZT5apNEmqFLSVQbqQNIkWkcR+jUzdy5UINKfbDgAaUQR0lf2LjEkfxcb3aYibdqtFXLKrGZuakA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781766053; c=relaxed/relaxed;
	bh=vRwwREO5k81aD87ERvuO+z/kQ/xU42w+4eD1CKIxNog=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o3e9dBfppYhGs7pJyUkREJv4Cn46XeswdHAoK6vrtxqDfP/AMMozPEHyIQfmmi2OTOq4AIhVUhaZaQjMfB3w+qGNl2EmTWFcWh2wOy5KqvWbZ/L68yjAymALpp3Y7ArW4jcxGlPgxQwwZdBUPsSpGEHo1/hLL8qHpQpf/2pMyOZa6TAK3IVezrBBZyZWg4XBc5i4U3CO7rghO/CT3e0QHR2iQ9PE7417OSU/LaLfhcpc3FeIJXkRGxWi5dpPgDZrMKiJDmwd9zllJv9BY+NalRWvGnA9Kz0usFm2kvXLJS0cUadOmPAM8vy7exCxmon9N3KODIc3U62uUbYNt3RU7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=1XGTALCB; dkim-atps=neutral; spf=pass (client-ip=113.46.200.223; helo=canpmsgout08.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ggs7f08wgz2xLm
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Jun 2026 17:00:44 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=vRwwREO5k81aD87ERvuO+z/kQ/xU42w+4eD1CKIxNog=;
	b=1XGTALCBcuQ6ZL5NUANV1NIM48M2kGXWIPM6KypdBf+0gbnEWLCG17M1JhgKWUO/I9NxoyLEA
	H4n7wPk3S/f7nWjBI0EEmMZ5Xeg+DzT6/dycqtDFBQxdhBQthb9qVTx+FE+RJ0p/G14SxYJBX+5
	NF6/EF++hwcM9ITqbJkQBMQ=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4ggryG5t7BzmVC8;
	Thu, 18 Jun 2026 14:52:38 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 1B9EB4056C;
	Thu, 18 Jun 2026 15:00:39 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 18 Jun
 2026 15:00:38 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>, <hsiangkao@linux.alibaba.com>
CC: <yekelu1@huawei.com>, <jingrui@huawei.com>, <zhukeqian1@huawei.com>,
	<zhaoyifan28@huawei.com>
Subject: [RFC PATCH 3/3] erofs-utils: support incremental file merge
Date: Thu, 18 Jun 2026 14:59:22 +0800
Message-ID: <20260618065922.1004653-4-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260618065922.1004653-1-zhaoyifan28@huawei.com>
References: <20260618065922.1004653-1-zhaoyifan28@huawei.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.159.234]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[huawei.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3666-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaoyifan28@huawei.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ALIAS_RESOLVED(0.00)[];
	HAS_XOIP(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:dkim,huawei.com:email,huawei.com:mid,huawei.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B36BB69DF64

Add --incremental=file-merge for local directory incremental builds.
The mode targets overlayfs-style copy-up outputs, where a sparse upper
file contains only bytes dirtied by the upper layer, while holes mean
that data from the lower image is still valid.

The desired merge looks like this:

                0            a            b            c            EOF
  result:       | inherit    | promote    | inherit    | promote      |
  upper source: | hole       | dirty      | hole       | dirty        |
  lower image:  |<-------- compressed extent A -------->|<- extent B->|

For compressed files, walk the sparse upper source and lower file
mappings together.  If a lower compressed extent is unchanged in the
upper source, inherit it directly.  If upper data appears inside a
lower extent, inherit only the clean prefix and recompress the dirty
suffix from the upper source.

                0            d                                  end
  result:       | inherit    | recompress promoted suffix         |
  upper source: | hole       | dirty bytes ...                    |
  lower extent: |<-------------- compressed extent -------------->|

Assisted-by: Codex:GPT-5.5
Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
 include/erofs/importer.h  |   1 +
 include/erofs/internal.h  |   1 +
 lib/Makefile.am           |   4 +-
 lib/compress.c            | 211 +++++++++++++++++++++++++++++++++++++-
 lib/file_merge.c          | 118 +++++++++++++++++++++
 lib/inode.c               | 107 +++++++++++++------
 lib/liberofs_compress.h   |   3 +
 lib/liberofs_file_merge.h |  22 ++++
 lib/liberofs_rebuild.h    |   3 +-
 lib/rebuild.c             |  77 +++++++++++++-
 man/mkfs.erofs.1          |  11 +-
 mkfs/main.c               |  17 ++-
 12 files changed, 533 insertions(+), 42 deletions(-)
 create mode 100644 lib/file_merge.c
 create mode 100644 lib/liberofs_file_merge.h

diff --git a/include/erofs/importer.h b/include/erofs/importer.h
index 07e40b4..e194743 100644
--- a/include/erofs/importer.h
+++ b/include/erofs/importer.h
@@ -57,6 +57,7 @@ struct erofs_importer_params {
 	bool dot_omitted;
 	bool no_xattrs;			/* don't store extended attributes */
 	bool no_zcompact;
+	bool incremental_file_merge;
 	bool ztailpacking;
 	char dedupe;
 	bool fragments;
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index cba1348..e7cb041 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -214,6 +214,7 @@ enum erofs_inode_data_source_type {
 
 struct erofs_inode_datasource {
 	unsigned char type;
+	struct erofs_inode *lower_inode;
 	union {
 		struct erofs_diskbuf *diskbuf;
 		struct {
diff --git a/lib/Makefile.am b/lib/Makefile.am
index cecbe36..780df25 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -26,6 +26,7 @@ noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
       $(top_srcdir)/lib/liberofs_base64.h \
       $(top_srcdir)/lib/liberofs_cache.h \
       $(top_srcdir)/lib/liberofs_compress.h \
+      $(top_srcdir)/lib/liberofs_file_merge.h \
       $(top_srcdir)/lib/liberofs_fragments.h \
       $(top_srcdir)/lib/liberofs_private.h \
       $(top_srcdir)/lib/liberofs_rebuild.h \
@@ -46,7 +47,8 @@ liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
 		      compress_hints.c hashmap.c sha256.c blobchunk.c dir.c \
 		      fragments.c dedupe.c uuid_unparse.c uuid.c tar.c \
 		      block_list.c rebuild.c diskbuf.c bitops.c dedupe_ext.c \
-		      vmdk.c metabox.c global.c importer.c base64.c
+		      vmdk.c metabox.c global.c importer.c base64.c \
+		      file_merge.c
 
 liberofs_la_CFLAGS = -Wall ${libuuid_CFLAGS} -I$(top_srcdir)/include
 liberofs_la_LDFLAGS = ${libselinux_LIBS} ${libuuid_LIBS} ${liblz4_LIBS} \
diff --git a/lib/compress.c b/lib/compress.c
index 633b69a..b6ea3ba 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -1398,7 +1398,8 @@ int erofs_commit_compressed_file(struct z_erofs_compress_ictx *ictx,
 
 	if (ptotal)
 		(void)erofs_bh_balloon(bh, ptotal);
-	else if (!params->fragments && params->dedupe != EROFS_DEDUPE_FORCE_ON)
+	else if (!params->fragments && params->dedupe != EROFS_DEDUPE_FORCE_ON &&
+		 !ictx->dedupe)
 		DBG_BUGON(!inode->idata_size);
 
 	erofs_info("compressed %s (%llu bytes) into %llu bytes",
@@ -1820,6 +1821,8 @@ void *erofs_prepare_compressed_file(struct erofs_importer *im,
 	bool frag = params->fragments && !erofs_is_packed_inode(inode) &&
 		!erofs_is_metabox_inode(inode);
 	bool all_fragments = params->all_fragments && frag;
+	bool file_merge = params->incremental_file_merge &&
+			  inode->datasource.lower_inode;
 
 	/* initialize per-file compression setting */
 	inode->z_advise = 0;
@@ -1837,7 +1840,7 @@ void *erofs_prepare_compressed_file(struct erofs_importer *im,
 	inode->idata_size = 0;
 	inode->fragment_size = 0;
 
-	if (!z_erofs_mt_enabled || all_fragments) {
+	if (!z_erofs_mt_enabled || all_fragments || file_merge) {
 #ifdef EROFS_MT_ENABLED
 		pthread_mutex_lock(&g_ictx.mutex);
 		while (g_ictx.seg_num) {
@@ -2047,6 +2050,210 @@ out:
 	return ret;
 }
 
+static erofs_off_t z_erofs_file_merge_next_data(struct erofs_vfile *dirty_vf,
+						erofs_off_t start,
+						erofs_off_t end)
+{
+	off_t dataoff;
+
+	dataoff = erofs_io_lseek(dirty_vf, start, SEEK_DATA);
+	if (dataoff < 0)
+		return dataoff == -ENXIO ? end : start;
+	if ((erofs_off_t)dataoff >= end)
+		return end;
+	return max_t(erofs_off_t, dataoff, start);
+}
+
+static bool z_erofs_file_merge_can_inherit(struct z_erofs_compress_ictx *ictx,
+					   struct erofs_map_blocks *map)
+{
+	struct erofs_sb_info *sbi = ictx->inode->sbi;
+	unsigned int blksz = erofs_blksiz(sbi);
+
+	if (!(map->m_flags & EROFS_MAP_MAPPED) ||
+	    !(map->m_flags & EROFS_MAP_ENCODED))
+		return false;
+	if (map->m_flags & (EROFS_MAP_META | __EROFS_MAP_FRAGMENT |
+			    EROFS_MAP_PARTIAL_REF))
+		return false;
+	if (map->m_deviceid)
+		return false;
+	if ((map->m_pa | map->m_plen) & (blksz - 1))
+		return false;
+	if (map->m_algorithmformat != ictx->inode->z_algorithmtype[0])
+		return false;
+	if (map->m_llen > UINT_MAX)
+		return false;
+	return true;
+}
+
+static int z_erofs_file_merge_inherit_extent(struct z_erofs_compress_ictx *ictx,
+					     struct erofs_map_blocks *map,
+					     erofs_off_t length, bool partial)
+{
+	struct z_erofs_extent_item *ei;
+
+	if (length > UINT_MAX)
+		return -EOPNOTSUPP;
+	ei = malloc(sizeof(*ei));
+	if (!ei)
+		return -ENOMEM;
+	init_list_head(&ei->list);
+	ei->e = (struct z_erofs_inmem_extent) {
+		.pstart = map->m_pa,
+		.plen = map->m_plen,
+		.length = length,
+		.raw = false,
+		.partial = partial,
+	};
+	list_add_tail(&ei->list, &ictx->extents);
+	ictx->dedupe = true;
+	erofs_sb_set_dedupe(ictx->inode->sbi);
+	ictx->inode->sbi->saved_by_deduplication += map->m_plen;
+	return 0;
+}
+
+static int z_erofs_file_merge_promote_extent(struct z_erofs_compress_ictx *ictx,
+					     erofs_off_t lstart,
+					     erofs_off_t length,
+					     erofs_off_t *pstart)
+{
+	static u8 g_queue[Z_EROFS_COMPR_QUEUE_SZ];
+	struct z_erofs_compress_sctx sctx;
+	int ret;
+
+	if (length > UINT_MAX)
+		return -EOPNOTSUPP;
+	sctx = (struct z_erofs_compress_sctx) {
+		.ictx = ictx,
+		.queue = g_queue,
+		.chandle = &ictx->ccfg->handle,
+		.remaining = length,
+		.seg_idx = 0,
+		.pivot = &dummy_pivot,
+		.pclustersize = z_erofs_get_pclustersize(ictx),
+	};
+	init_list_head(&sctx.extents);
+
+	ret = z_erofs_compress_segment(&sctx, lstart, *pstart);
+	if (ret)
+		return ret;
+
+	list_splice_tail(&sctx.extents, &ictx->extents);
+	*pstart = sctx.pstart;
+	return 0;
+}
+
+int erofs_write_compressed_file_file_merge(struct z_erofs_compress_ictx *ictx,
+					   struct erofs_vfile *dirty_vf,
+					   struct erofs_inode *lower)
+{
+	struct erofs_buffer_head *bh;
+	struct erofs_inode *inode = ictx->inode;
+	struct erofs_sb_info *sbi = inode->sbi;
+	erofs_off_t pstart, pcur, pos;
+	int ret;
+
+#ifdef EROFS_MT_ENABLED
+	if (ictx != &g_ictx)
+		return erofs_write_compressed_file(ictx);
+#endif
+	if (ictx->im->params->fragments || ictx->im->params->ztailpacking ||
+	    ictx->data_unaligned)
+		return erofs_write_compressed_file(ictx);
+
+	bh = erofs_balloc(sbi->bmgr, DATA, 0, 0);
+	if (IS_ERR(bh)) {
+		ret = PTR_ERR(bh);
+		goto err_free_idata;
+	}
+	pstart = erofs_pos(sbi, erofs_mapbh(NULL, bh->block));
+	pcur = pstart;
+
+	for (pos = 0; pos < inode->i_size; ) {
+		struct erofs_map_blocks map = {
+			.buf = __EROFS_BUF_INITIALIZER,
+			.m_la = pos,
+		};
+		erofs_off_t end, promote_start;
+		bool can_inherit;
+
+		ret = erofs_map_blocks(lower, &map, EROFS_GET_BLOCKS_FIEMAP);
+		if (ret)
+			goto err_bdrop;
+		if (!map.m_llen) {
+			ret = -EIO;
+			goto err_bdrop;
+		}
+		if (map.m_la < pos) {
+			if (map.m_la + map.m_llen <= pos) {
+				ret = -EIO;
+				goto err_bdrop;
+			}
+			map.m_llen -= pos - map.m_la;
+			map.m_la = pos;
+		}
+		if (map.m_la != pos) {
+			ret = -EIO;
+			goto err_bdrop;
+		}
+		if (map.m_la + map.m_llen > inode->i_size)
+			map.m_llen = inode->i_size - map.m_la;
+
+		end = map.m_la + map.m_llen;
+		can_inherit = z_erofs_file_merge_can_inherit(ictx, &map);
+		promote_start = map.m_la;
+		if (can_inherit) {
+			erofs_off_t dataoff;
+
+			dataoff = z_erofs_file_merge_next_data(dirty_vf,
+							       map.m_la, end);
+			if (dataoff >= end) {
+				ret = z_erofs_file_merge_inherit_extent(ictx,
+						&map, map.m_llen, false);
+				if (ret)
+					goto err_bdrop;
+				pos = end;
+				continue;
+			}
+
+			promote_start = round_down(dataoff, erofs_blksiz(sbi));
+			if (promote_start > map.m_la) {
+				ret = z_erofs_file_merge_inherit_extent(ictx,
+						&map, promote_start - map.m_la,
+						true);
+				if (ret)
+					goto err_bdrop;
+			}
+		}
+		ret = z_erofs_file_merge_promote_extent(ictx, promote_start,
+							end - promote_start,
+							&pcur);
+		if (ret)
+			goto err_bdrop;
+		pos = end;
+	}
+
+	ret = erofs_commit_compressed_file(ictx, bh, pstart, pcur - pstart);
+	goto out;
+
+err_bdrop:
+	erofs_bdrop(bh, true);
+err_free_idata:
+	if (inode->idata) {
+		free(inode->idata);
+		inode->idata = NULL;
+	}
+out:
+#ifdef EROFS_MT_ENABLED
+	pthread_mutex_lock(&ictx->mutex);
+	ictx->seg_num = ret < 0 ? INT_MAX : 0;
+	pthread_cond_signal(&ictx->cond);
+	pthread_mutex_unlock(&ictx->mutex);
+#endif
+	return ret;
+}
+
 int erofs_begin_compress_dir(struct erofs_importer *im,
 			     struct erofs_inode *inode)
 
diff --git a/lib/file_merge.c b/lib/file_merge.c
new file mode 100644
index 0000000..169947f
--- /dev/null
+++ b/lib/file_merge.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+#define _GNU_SOURCE
+#include <errno.h>
+#include <config.h>
+#include "liberofs_file_merge.h"
+
+bool erofs_inode_dvf_is_file_merge(struct erofs_inode_datasource_vfile *dvf)
+{
+	return dvf->inode->datasource.type == EROFS_INODE_DATA_SOURCE_LOCALPATH &&
+	       dvf->inode->datasource.lower_inode;
+}
+
+bool erofs_inode_vfile_is_file_merge(struct erofs_vfile *vf,
+				     const struct erofs_vfops *inode_vfops)
+{
+	if (vf->ops != inode_vfops)
+		return false;
+	return erofs_inode_dvf_is_file_merge(
+			container_of(vf, struct erofs_inode_datasource_vfile,
+				     vf));
+}
+
+static bool erofs_inode_vfseek_fallback(off_t ret)
+{
+	return ret == -ENXIO || ret == -EOPNOTSUPP || ret == -EINVAL;
+}
+
+static int erofs_inode_vfnext_data(struct erofs_vfile *vf, u64 pos, u64 end,
+				   u64 *next, bool *data)
+{
+	off_t dataoff, holeoff;
+
+	dataoff = erofs_io_lseek(&(struct erofs_vfile){ .fd = vf->fd },
+				 pos, SEEK_DATA);
+	if (dataoff < 0) {
+		if (dataoff == -ENXIO) {
+			*data = false;
+			*next = end;
+			return 0;
+		}
+		if (erofs_inode_vfseek_fallback(dataoff)) {
+			*data = true;
+			*next = end;
+			return 0;
+		}
+		return dataoff;
+	}
+
+	if ((u64)dataoff > pos) {
+		*data = false;
+		*next = min_t(u64, dataoff, end);
+		return 0;
+	}
+
+	holeoff = erofs_io_lseek(&(struct erofs_vfile){ .fd = vf->fd },
+				 pos, SEEK_HOLE);
+	if (holeoff < 0) {
+		if (erofs_inode_vfseek_fallback(holeoff)) {
+			*data = true;
+			*next = end;
+			return 0;
+		}
+		return holeoff;
+	}
+	*data = true;
+	*next = min_t(u64, holeoff, end);
+	return 0;
+}
+
+ssize_t erofs_inode_dvf_pread_file_merge(
+		struct erofs_inode_datasource_vfile *dvf, void *buf,
+		size_t len, u64 offset)
+{
+	struct erofs_inode *inode = dvf->inode;
+	struct erofs_vfile *vf = &dvf->vf;
+	struct erofs_vfile lower = {};
+	u64 end;
+	size_t done = 0;
+	int err;
+
+	if (offset >= inode->i_size)
+		return 0;
+	len = min_t(u64, len, inode->i_size - offset);
+	end = offset + len;
+
+	if (!inode->datasource.lower_inode)
+		return -EINVAL;
+	err = erofs_iopen(&lower, inode->datasource.lower_inode);
+	if (err)
+		return err;
+
+	while (offset < end) {
+		bool data = false;
+		u64 next = offset;
+		ssize_t ret;
+
+		ret = erofs_inode_vfnext_data(vf, offset, end, &next, &data);
+		if (ret < 0)
+			return ret;
+		if (next <= offset)
+			return -EIO;
+
+		if (data)
+			ret = erofs_io_pread(&(struct erofs_vfile){ .fd = vf->fd },
+					     (char *)buf + done, next - offset,
+					     offset);
+		else
+			ret = erofs_io_pread(&lower, (char *)buf + done,
+					     next - offset, offset);
+		if (ret < 0)
+			return ret;
+		if (!ret)
+			break;
+		done += ret;
+		offset += ret;
+	}
+	return done;
+}
diff --git a/lib/inode.c b/lib/inode.c
index 328215b..b4abef0 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -28,6 +28,7 @@
 #include "liberofs_cache.h"
 #include "liberofs_compress.h"
 #include "liberofs_fragments.h"
+#include "liberofs_file_merge.h"
 #include "liberofs_metabox.h"
 #include "liberofs_private.h"
 #include "liberofs_rebuild.h"
@@ -76,13 +77,6 @@ static const umode_t erofs_dtype_by_umode[EROFS_FT_MAX] = {
 	[EROFS_FT_SYMLINK]	= S_IFLNK
 };
 
-struct erofs_inode_datasource_vfile {
-	struct erofs_vfile vf;
-	struct erofs_inode *inode;
-	u64 base;
-	u64 pos;
-};
-
 umode_t erofs_ftype_to_mode(unsigned int ftype, unsigned int perm)
 {
 	if (ftype >= EROFS_FT_MAX)
@@ -147,6 +141,11 @@ struct erofs_inode *erofs_iget(dev_t dev, ino_t ino)
 
 static void erofs_inode_free_datasource(struct erofs_inode *inode)
 {
+	if (inode->datasource.lower_inode) {
+		erofs_iput(inode->datasource.lower_inode);
+		inode->datasource.lower_inode = NULL;
+	}
+
 	switch (inode->datasource.type) {
 	case EROFS_INODE_DATA_SOURCE_DISKBUF:
 		erofs_diskbuf_close(inode->datasource.diskbuf);
@@ -169,6 +168,9 @@ static ssize_t erofs_inode_vfpread(struct erofs_vfile *vf, void *buf,
 	struct erofs_inode_datasource_vfile *dvf =
 		container_of(vf, struct erofs_inode_datasource_vfile, vf);
 
+	if (erofs_inode_dvf_is_file_merge(dvf))
+		return erofs_inode_dvf_pread_file_merge(dvf, buf, len, offset);
+
 	return erofs_io_pread(&(struct erofs_vfile){ .fd = vf->fd },
 			      buf, len, dvf->base + offset);
 }
@@ -213,6 +215,8 @@ static off_t erofs_inode_vflseek(struct erofs_vfile *vf, u64 offset,
 		break;
 	case SEEK_DATA:
 	case SEEK_HOLE:
+		if (erofs_inode_dvf_is_file_merge(dvf))
+			return -EOPNOTSUPP;
 		if (offset > dvf->inode->i_size)
 			return -ENXIO;
 		if (offset == dvf->inode->i_size) {
@@ -305,10 +309,12 @@ static struct erofs_inode_datasource_vfile *erofs_inode_open_data_vfile(
 	if (dvf->vf.fd < 0) {
 		ret = inode->datasource.type == EROFS_INODE_DATA_SOURCE_DISKBUF ?
 		      dvf->vf.fd : -errno;
-		free(dvf);
-		return ERR_PTR(ret);
+		goto err_free;
 	}
 	return dvf;
+err_free:
+	free(dvf);
+	return ERR_PTR(ret);
 }
 
 unsigned int erofs_iput(struct erofs_inode *inode)
@@ -868,31 +874,38 @@ static int erofs_write_unencoded_data(struct erofs_inode *inode,
 }
 
 static int erofs_write_unencoded_file(struct erofs_inode *inode,
-				      struct erofs_inode_datasource_vfile *src)
+				      struct erofs_vfile *vf)
 {
-	int ret;
+	bool rebuild_blob = inode->datasource.type ==
+			    EROFS_INODE_DATA_SOURCE_REBUILD_BLOB;
+	off_t off;
 
-	ret = erofs_io_lseek(&src->vf, 0, SEEK_SET);
-	if (ret)
-		return ret;
+	off = erofs_io_lseek(vf, 0, SEEK_SET);
+	if (off < 0)
+		return off;
+	if (off)
+		return -EIO;
 
 	if (cfg.c_chunkbits &&
-	    inode->datasource.type != EROFS_INODE_DATA_SOURCE_REBUILD_BLOB) {
+	    vf->fd >= 0 &&
+	    !erofs_inode_vfile_is_file_merge(vf, &erofs_inode_vfops) &&
+	    !rebuild_blob) {
 		inode->u.chunkbits = cfg.c_chunkbits;
 		/* chunk indexes when explicitly specified */
 		inode->u.chunkformat = 0;
 		if (cfg.c_force_chunkformat == FORCE_INODE_CHUNK_INDEXES)
 			inode->u.chunkformat = EROFS_CHUNK_FORMAT_INDEXES;
-		return erofs_blob_write_chunked_file(inode, &src->vf);
+		return erofs_blob_write_chunked_file(inode, vf);
 	}
 
-	if (inode->datasource.type != EROFS_INODE_DATA_SOURCE_REBUILD_BLOB)
+	if (!rebuild_blob)
 		inode->datalayout = EROFS_INODE_FLAT_INLINE;
 	/* fallback to all data uncompressed */
-	return erofs_write_unencoded_data(inode, &src->vf, 0,
+	return erofs_write_unencoded_data(inode, vf, 0,
+			vf->fd < 0 ||
+			erofs_inode_vfile_is_file_merge(vf, &erofs_inode_vfops) ||
 			inode->datasource.type == EROFS_INODE_DATA_SOURCE_DISKBUF ||
-			inode->datasource.type == EROFS_INODE_DATA_SOURCE_REBUILD_BLOB,
-			false);
+			rebuild_blob, false);
 }
 
 static int erofs_write_dir_file(const struct erofs_importer *im,
@@ -1665,22 +1678,37 @@ struct erofs_mkfs_job_ndir_ctx {
 static int erofs_mkfs_job_write_file(struct erofs_mkfs_job_ndir_ctx *ctx)
 {
 	struct erofs_inode *inode = ctx->inode;
+	struct erofs_vfile *vf = &ctx->src->vf;
 	int ret;
 
 	if (ctx->ictx) {
-		ret = erofs_io_lseek(&ctx->src->vf, 0, SEEK_SET);
-		if (ret)
+		off_t off;
+
+		off = erofs_io_lseek(vf, 0, SEEK_SET);
+		if (off < 0) {
+			ret = off;
+			goto out;
+		}
+		if (off) {
+			ret = -EIO;
 			goto out;
-		ret = erofs_write_compressed_file(ctx->ictx);
+		}
+		if (erofs_inode_dvf_is_file_merge(ctx->src))
+			ret = erofs_write_compressed_file_file_merge(ctx->ictx,
+				&(struct erofs_vfile){ .fd = ctx->src->vf.fd },
+				inode->datasource.lower_inode);
+		else
+			ret = erofs_write_compressed_file(ctx->ictx);
 		if (ret != -ENOSPC)
 			goto out;
 	}
 	/* fallback to all data uncompressed */
-	ret = erofs_write_unencoded_file(inode, ctx->src);
+	ret = erofs_write_unencoded_file(inode, vf);
 out:
-	DBG_BUGON(!ctx->src || ctx->src->vf.fd < 0);
-	erofs_io_close(&ctx->src->vf);
-	ctx->src = NULL;
+	if (ctx->src) {
+		erofs_io_close(&ctx->src->vf);
+		ctx->src = NULL;
+	}
 	return ret;
 }
 
@@ -2101,7 +2129,9 @@ static int erofs_prepare_dir_inode(const struct erofs_mkfs_btctx *ctx,
 	}
 
 	if (ctx->incremental && dir->dev == sbi->dev && !dir->opaque) {
-		ret = erofs_rebuild_load_basedir(dir, &nr_subdirs, &i_nlink);
+		ret = erofs_rebuild_load_basedir(dir, &nr_subdirs, &i_nlink,
+						 im->params->incremental_file_merge,
+						 im->params->hard_dereference);
 		if (ret)
 			return ret;
 	}
@@ -2178,17 +2208,23 @@ static int erofs_mkfs_begin_nondirectory(const struct erofs_mkfs_btctx *btctx,
 	int ret;
 
 	if (S_ISREG(inode->i_mode) && inode->i_size) {
+		bool rebuild_blob;
+		struct erofs_vfile *vf;
+
 		ctx.src = erofs_inode_open_data_vfile(inode);
 		if (IS_ERR(ctx.src))
 			return PTR_ERR(ctx.src);
 		if (!ctx.src)
 			goto out;
+		vf = &ctx.src->vf;
 
-		ret = erofs_set_inode_fingerprint(inode, &ctx.src->vf);
+		ret = erofs_set_inode_fingerprint(inode, vf);
 		if (ret < 0)
 			goto err_close;
 
-		if (inode->datasource.type != EROFS_INODE_DATA_SOURCE_REBUILD_BLOB &&
+		rebuild_blob = inode->datasource.type ==
+			EROFS_INODE_DATA_SOURCE_REBUILD_BLOB;
+		if (!rebuild_blob &&
 		    inode->sbi->available_compr_algs &&
 		    erofs_file_is_compressible(im, inode)) {
 			ctx.ictx = erofs_prepare_compressed_file(im, inode);
@@ -2197,7 +2233,7 @@ static int erofs_mkfs_begin_nondirectory(const struct erofs_mkfs_btctx *btctx,
 				goto err_close;
 			}
 			erofs_bind_compressed_file_with_vfile(ctx.ictx,
-							      &ctx.src->vf);
+							      vf);
 			ret = erofs_begin_compressed_file(ctx.ictx);
 			if (ret)
 				goto err_close;
@@ -2206,12 +2242,15 @@ static int erofs_mkfs_begin_nondirectory(const struct erofs_mkfs_btctx *btctx,
 out:
 	ret = erofs_mkfs_go(btctx, EROFS_MKFS_JOB_NDIR, &ctx, sizeof(ctx));
 #ifdef EROFS_MT_ENABLED
-	if (ret && ctx.src)
-		erofs_io_close(&ctx.src->vf);
+	if (ret) {
+		if (ctx.src)
+			erofs_io_close(&ctx.src->vf);
+	}
 #endif
 	return ret;
 err_close:
-	erofs_io_close(&ctx.src->vf);
+	if (ctx.src)
+		erofs_io_close(&ctx.src->vf);
 	return ret;
 }
 
diff --git a/lib/liberofs_compress.h b/lib/liberofs_compress.h
index 55a8943..73cdfbe 100644
--- a/lib/liberofs_compress.h
+++ b/lib/liberofs_compress.h
@@ -23,6 +23,9 @@ void erofs_bind_compressed_file_with_fd(struct z_erofs_compress_ictx *ictx,
 					int fd, u64 fpos);
 int erofs_begin_compressed_file(struct z_erofs_compress_ictx *ictx);
 int erofs_write_compressed_file(struct z_erofs_compress_ictx *ictx);
+int erofs_write_compressed_file_file_merge(struct z_erofs_compress_ictx *ictx,
+					   struct erofs_vfile *dirty_vf,
+					   struct erofs_inode *lower);
 
 int erofs_begin_compress_dir(struct erofs_importer *im,
 			     struct erofs_inode *inode);
diff --git a/lib/liberofs_file_merge.h b/lib/liberofs_file_merge.h
new file mode 100644
index 0000000..6652d4e
--- /dev/null
+++ b/lib/liberofs_file_merge.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
+#ifndef __EROFS_LIB_LIBEROFS_FILE_MERGE_H
+#define __EROFS_LIB_LIBEROFS_FILE_MERGE_H
+
+#include "erofs/internal.h"
+#include "erofs/io.h"
+
+struct erofs_inode_datasource_vfile {
+	struct erofs_vfile vf;
+	struct erofs_inode *inode;
+	u64 base;
+	u64 pos;
+};
+
+bool erofs_inode_dvf_is_file_merge(struct erofs_inode_datasource_vfile *dvf);
+bool erofs_inode_vfile_is_file_merge(struct erofs_vfile *vf,
+				     const struct erofs_vfops *inode_vfops);
+ssize_t erofs_inode_dvf_pread_file_merge(
+		struct erofs_inode_datasource_vfile *dvf, void *buf,
+		size_t len, u64 offset);
+
+#endif
diff --git a/lib/liberofs_rebuild.h b/lib/liberofs_rebuild.h
index 6459dbd..c1c5916 100644
--- a/lib/liberofs_rebuild.h
+++ b/lib/liberofs_rebuild.h
@@ -17,5 +17,6 @@ int erofs_rebuild_load_tree(struct erofs_inode *root, struct erofs_sb_info *sbi,
 			    enum erofs_rebuild_datamode mode);
 
 int erofs_rebuild_load_basedir(struct erofs_inode *dir, u64 *nr_subdirs,
-			       unsigned int *i_nlink);
+			       unsigned int *i_nlink, bool file_merge,
+			       bool hard_dereference);
 #endif
diff --git a/lib/rebuild.c b/lib/rebuild.c
index abe3b74..a4ea2ec 100644
--- a/lib/rebuild.c
+++ b/lib/rebuild.c
@@ -26,6 +26,9 @@
 #define AUFS_WH_DIROPQ		AUFS_WH_PFX AUFS_DIROPQ_NAME
 #endif
 
+static struct erofs_inode *erofs_rebuild_read_inode(struct erofs_sb_info *sbi,
+						    erofs_nid_t nid);
+
 /*
  * These non-existent parent directories are created with the same permissions
  * as their parent directories.  It is expected that a call to create these
@@ -356,8 +359,45 @@ struct erofs_rebuild_dir_context {
 			unsigned int *i_nlink;
 		};
 	};
+	bool file_merge;
+	bool hard_dereference;
 };
 
+static struct erofs_inode *erofs_rebuild_read_inode(struct erofs_sb_info *sbi,
+						    erofs_nid_t nid)
+{
+	struct erofs_inode *inode;
+	int ret;
+
+	inode = erofs_new_inode(sbi);
+	if (IS_ERR(inode))
+		return inode;
+	inode->nid = nid;
+	ret = erofs_read_inode_from_disk(inode);
+	if (ret) {
+		erofs_iput(inode);
+		return ERR_PTR(ret);
+	}
+	return inode;
+}
+
+static int erofs_rebuild_source_is_hardlink(struct erofs_inode *inode,
+					    bool hard_dereference,
+					    bool *is_hardlink)
+{
+	struct stat st;
+
+	*is_hardlink = false;
+	if (hard_dereference ||
+	    inode->datasource.type != EROFS_INODE_DATA_SOURCE_LOCALPATH)
+		return 0;
+
+	if (lstat(inode->i_srcpath, &st))
+		return -errno;
+	*is_hardlink = S_ISREG(st.st_mode) && st.st_nlink > 1;
+	return 0;
+}
+
 static int erofs_rebuild_dirent_iter(struct erofs_dir_context *ctx)
 {
 	struct erofs_rebuild_dir_context *rctx = (void *)ctx;
@@ -571,6 +611,38 @@ static int erofs_rebuild_basedir_dirent_iter(struct erofs_dir_context *ctx)
 	} else {
 		struct erofs_inode *inode = d->inode;
 
+		if (rctx->file_merge && S_ISREG(inode->i_mode) &&
+		    ctx->de_ftype == EROFS_FT_REG_FILE) {
+			struct erofs_inode *lower;
+			bool source_is_hardlink;
+
+			ret = erofs_rebuild_source_is_hardlink(inode,
+					rctx->hard_dereference,
+					&source_is_hardlink);
+			if (ret)
+				goto out;
+			if (!source_is_hardlink) {
+				lower = erofs_rebuild_read_inode(dir->sbi,
+								 ctx->de_nid);
+				if (IS_ERR(lower)) {
+					ret = PTR_ERR(lower);
+					goto out;
+				}
+				if (!S_ISREG(lower->i_mode)) {
+					erofs_iput(lower);
+					ret = -EOPNOTSUPP;
+					goto out;
+				}
+				if (lower->i_size == inode->i_size) {
+					if (inode->datasource.lower_inode)
+						erofs_iput(inode->datasource.lower_inode);
+					inode->datasource.lower_inode = lower;
+				} else {
+					erofs_iput(lower);
+				}
+			}
+		}
+
 		/* update sub-directories only for recursively loading */
 		if (S_ISDIR(inode->i_mode) &&
 		    (ctx->de_ftype == EROFS_FT_DIR ||
@@ -588,7 +660,8 @@ out:
 }
 
 int erofs_rebuild_load_basedir(struct erofs_inode *dir, u64 *nr_subdirs,
-			       unsigned int *i_nlink)
+			       unsigned int *i_nlink, bool file_merge,
+			       bool hard_dereference)
 {
 	struct erofs_inode fakeinode = {
 		.sbi = dir->sbi,
@@ -622,6 +695,8 @@ int erofs_rebuild_load_basedir(struct erofs_inode *dir, u64 *nr_subdirs,
 		.mergedir = dir,
 		.nr_subdirs = nr_subdirs,
 		.i_nlink = i_nlink,
+		.file_merge = file_merge,
+		.hard_dereference = hard_dereference,
 	};
 	return erofs_iterate_dir(&ctx.ctx, false);
 }
diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index 65ec807..f7adec6 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -319,7 +319,8 @@ can reduce total metadata size. Implied by
 .BI "\-\-incremental=" MODE
 Run an incremental build where DESTINATION is an existing EROFS image,
 and the data specified by SOURCE will be incrementally appended to the image.
-\fIMODE\fR has the same meaning as in \fB\-\-clean\fR above.
+\fIMODE\fR generally has the same meaning as in \fB\-\-clean\fR above.
+The special \fBfile-merge\fR mode is only valid for \fB\-\-incremental\fR.
 Incremental build is unsupported for \fB\-\-s3\fR and \fB\-\-oci\fR sources.
 
 If \fB\-\-incremental\fR is specified without an explicit value, it is treated
@@ -329,7 +330,13 @@ The current source-specific support for \fIMODE\fR:
 .RS 1.2i
 .TP
 .I Local directory source
-Only \fBdata\fR is supported. \fBrvsp\fR and \fB0\fR will be ignored.
+\fBdata\fR and \fBfile-merge\fR are supported. \fBrvsp\fR and \fB0\fR will be ignored.
+\fBfile-merge\fR keeps the normal incremental append behavior, but when a
+regular file from SOURCE has the same path and size as an existing lower
+regular file, sparse holes in the SOURCE file are inherited from the lower
+file while allocated data ranges replace the lower content.  An all-zero
+overwrite must therefore be represented as allocated zero data rather than a
+sparse hole.
 .TP
 .I Tar source (\fB\-\-tar\fR)
 \fBdata\fR and \fBrvsp\fR are supported. \fB0\fR will be ignored.
diff --git a/mkfs/main.c b/mkfs/main.c
index 4fadb56..9054ca3 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -193,7 +193,8 @@ static void usage(int argc, char **argv)
 		" --chunksize=#          generate chunk-based files with #-byte chunks\n"
 		" --clean=X              run full clean build (default) or:\n"
 		" --incremental=X        run incremental build\n"
-		"                        X = data|rvsp|0 (data: full data, rvsp: space fallocated\n"
+		"                        X = data|rvsp|0|file-merge (data: full data,\n"
+		"                                         rvsp: space fallocated,\n"
 		"                                         0: inodes zeroed)\n"
 		" --compress-hints=X     specify a file to configure per-file compression strategy\n"
 		" --dsunit=#             align all data block addresses to multiples of #\n"
@@ -1352,12 +1353,20 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 			break;
 		case 522:
 		case 523:
+			params->incremental_file_merge = false;
 			if (!optarg || !strcmp(optarg, "data")) {
 				dataimport_mode = EROFS_MKFS_DATA_IMPORT_FULLDATA;
 			} else if (!strcmp(optarg, "rvsp")) {
 				dataimport_mode = EROFS_MKFS_DATA_IMPORT_RVSP;
 			} else if (!strcmp(optarg, "0")) {
 				dataimport_mode = EROFS_MKFS_DATA_IMPORT_ZEROFILL;
+			} else if (!strcmp(optarg, "file-merge")) {
+				if (opt != 523) {
+					erofs_err("--clean=file-merge is invalid");
+					return -EINVAL;
+				}
+				dataimport_mode = EROFS_MKFS_DATA_IMPORT_FULLDATA;
+				params->incremental_file_merge = true;
 			} else {
 				errno = 0;
 				dataimport_mode = strtol(optarg, &endptr, 0);
@@ -1550,6 +1559,12 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 		cfg.c_showprogress = false;
 	}
 
+	if (params->incremental_file_merge &&
+	    source_mode != EROFS_MKFS_SOURCE_LOCALDIR) {
+		erofs_err("--incremental=file-merge requires a local directory source");
+		return -EINVAL;
+	}
+
 	if (pclustersize_max) {
 		if (pclustersize_max < (1U << mkfs_blkszbits) ||
 		    pclustersize_max % (1U << mkfs_blkszbits)) {
-- 
2.47.3


