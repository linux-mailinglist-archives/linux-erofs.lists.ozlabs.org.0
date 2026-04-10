Return-Path: <linux-erofs+bounces-3261-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJN9K3e52GmmhQgAu9opvQ
	(envelope-from <linux-erofs+bounces-3261-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Apr 2026 10:48:55 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0613D44D3
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Apr 2026 10:48:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsVpD0J67z2xTh;
	Fri, 10 Apr 2026 18:48:52 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775810931;
	cv=none; b=gOkIUPb08Snk2Ro7etIYFW5Y87D3wTW+l1dVebc589XbuoH5tmRKpkSFR4zJ5doxWTsI6OVUUsLbj4w4Xnaxo97Ev7nwWlM1cQSpoGL7PtLF9bN+/DXZLnp8OTQwOrBCAJ4Q4YNRwo4ac+QRMYhOY2j0mlB4t1+Oaw4n4JGVy4GwhCDmBl51Ejxhp2AlH9/HHHCkocF4NUjvO9G+a9NcX9dsG9wGEOX0XiHnm4GBHTpYAwEbmCbVs0JZFYV29TQsQ/KULALWlSVC1P6sxZNK88TUPw2klIG8MUSF/4pF70n+9nGjLqRluImqcjFTqhHfJR/bz9q8l1A4EpZKCS5FnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775810931; c=relaxed/relaxed;
	bh=5bdLJHxFgFfW+R50YBGbULVXJ7cD+hC8TyONzQEyGrM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ftj0SBKNuyCC+8p/9f8GtYmbF5SvD52GWjZ8D9n5Xg0rtzRXYOkt4rpRUqxLalTu0rYxfT9ZwU/n4bhrXr5B5BguAL739l559A9BCjWSDhxWnBcVWfvQQC3fQu/q5gPVmDJpMBQ+pMmmBlvmb1FNAMu9uyTXt5L7gd7PVefq31SVaVEvf/Kk9FE5a03BVZ0CRjermNknQiQSpZydC6ki8Ib9wujcXB2UYsrSBqUBcl7MX9wOv6IEVB/Tc0sp+wu7EXONdkgkTaml2EVkFB356CNgabEgPkFDTfgNrPRG7jtAuWBJ45aufdzaUnUJPMaGiXIrSFjPYg2QrYCSeuQ/2g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=kOQ6klai; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=kOQ6klai;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsVpB16gXz2yZ6
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Apr 2026 18:48:48 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775810924; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=5bdLJHxFgFfW+R50YBGbULVXJ7cD+hC8TyONzQEyGrM=;
	b=kOQ6klai1hci1OjLQYuU8T0wb57T6In017Oe3JbBp1CyPZev0pkioRjYDg3J+C6GkjLtKWutsHFuTIYCOwxJBEi0MooaTe3wapTRviwlheuvV2xickDsxzTt4YyzuE/CZM03yIfC4QH+QTeHbBkqzTzSFPB9I9BlhH7WAq/VuxA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0X0kmhZK_1775810919;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X0kmhZK_1775810919 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 10 Apr 2026 16:48:43 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/2] erofs: clean up encoded map flags
Date: Fri, 10 Apr 2026 16:48:37 +0800
Message-ID: <20260410084838.512795-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3261-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid,alibaba.com:email]
X-Rspamd-Queue-Id: 2D0613D44D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

- Remove EROFS_MAP_ENCODED since it was always set together with
  EROFS_MAP_MAPPED for compressed extents and checked redundantly;

- Replace the EROFS_MAP_FULL_MAPPED flag with the opposite
  EROFS_MAP_PARTIAL_MAPPED flag so that extents are implicitly
  fully mapped initially to simplify the logic;

- Make fragment extents independent of EROFS_MAP_MAPPED since
  they are not directly allocated on disk; thus fragment extents
  are no longer twisted with mapped extents.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/internal.h          | 23 +++++++++++------------
 fs/erofs/zdata.c             | 19 +++++++++----------
 fs/erofs/zmap.c              | 19 ++++++++++---------
 include/trace/events/erofs.h |  7 +++----
 4 files changed, 33 insertions(+), 35 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index a4f0a42cf8c3..4792490161ec 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -360,20 +360,19 @@ static inline struct folio *erofs_grab_folio_nowait(struct address_space *as,
 			readahead_gfp_mask(as) & ~__GFP_RECLAIM);
 }
 
-/* Has a disk mapping */
-#define EROFS_MAP_MAPPED	0x0001
+/* Allocated on disk at @m_pa (e.g. NOT a fragment extent) */
+#define EROFS_MAP_MAPPED		0x0001
 /* Located in metadata (could be copied from bd_inode) */
-#define EROFS_MAP_META		0x0002
-/* The extent is encoded */
-#define EROFS_MAP_ENCODED	0x0004
-/* The length of extent is full */
-#define EROFS_MAP_FULL_MAPPED	0x0008
+#define EROFS_MAP_META			0x0002
+/* @m_llen may be truncated by the runtime compared to the on-disk record */
+#define EROFS_MAP_PARTIAL_MAPPED	0x0004
+/* The on-disk @m_llen may cover only part of the encoded data */
+#define EROFS_MAP_PARTIAL_REF		0x0008
 /* Located in the special packed inode */
-#define __EROFS_MAP_FRAGMENT	0x0010
-/* The extent refers to partial decompressed data */
-#define EROFS_MAP_PARTIAL_REF	0x0020
-
-#define EROFS_MAP_FRAGMENT	(EROFS_MAP_MAPPED | __EROFS_MAP_FRAGMENT)
+#define EROFS_MAP_FRAGMENT		0x0010
+/* The encoded on-disk data will be fully handled (decompressed) */
+#define EROFS_MAP_FULL(f)	(!((f) & (EROFS_MAP_PARTIAL_MAPPED | \
+					  EROFS_MAP_PARTIAL_REF)))
 
 struct erofs_map_blocks {
 	struct erofs_buf buf;
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index b566996a0d1a..8a0b15511931 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -520,7 +520,7 @@ static bool z_erofs_should_alloc_cache(struct z_erofs_frontend *fe)
 	if (cachestrategy <= EROFS_ZIP_CACHE_DISABLED)
 		return false;
 
-	if (!(fe->map.m_flags & EROFS_MAP_FULL_MAPPED))
+	if (fe->map.m_flags & EROFS_MAP_PARTIAL_MAPPED)
 		return true;
 
 	if (cachestrategy >= EROFS_ZIP_CACHE_READAROUND &&
@@ -1033,10 +1033,7 @@ static int z_erofs_scan_folio(struct z_erofs_frontend *f,
 		/* bump split parts first to avoid several separate cases */
 		++split;
 
-		if (!(map->m_flags & EROFS_MAP_MAPPED)) {
-			folio_zero_segment(folio, cur, end);
-			tight = false;
-		} else if (map->m_flags & __EROFS_MAP_FRAGMENT) {
+		if (map->m_flags & EROFS_MAP_FRAGMENT) {
 			erofs_off_t fpos = offset + cur - map->m_la;
 
 			err = z_erofs_read_fragment(inode->i_sb, folio, cur,
@@ -1045,6 +1042,9 @@ static int z_erofs_scan_folio(struct z_erofs_frontend *f,
 			if (err)
 				break;
 			tight = false;
+		} else if (!(map->m_flags & EROFS_MAP_MAPPED)) {
+			folio_zero_segment(folio, cur, end);
+			tight = false;
 		} else {
 			if (!f->pcl) {
 				err = z_erofs_pcluster_begin(f);
@@ -1080,14 +1080,13 @@ static int z_erofs_scan_folio(struct z_erofs_frontend *f,
 				f->pcl->length = offset + end - map->m_la;
 				f->pcl->pageofs_out = map->m_la & ~PAGE_MASK;
 			}
-			if ((map->m_flags & EROFS_MAP_FULL_MAPPED) &&
-			    !(map->m_flags & EROFS_MAP_PARTIAL_REF) &&
+			if (EROFS_MAP_FULL(map->m_flags) &&
 			    f->pcl->length == map->m_llen)
 				f->pcl->partial = false;
 		}
 		/* shorten the remaining extent to update progress */
 		map->m_llen = offset + cur - map->m_la;
-		map->m_flags &= ~EROFS_MAP_FULL_MAPPED;
+		map->m_flags |= EROFS_MAP_PARTIAL_MAPPED;
 		if (cur <= pgs) {
 			split = cur < pgs;
 			tight = (bs == PAGE_SIZE);
@@ -1841,7 +1840,7 @@ static void z_erofs_pcluster_readmore(struct z_erofs_frontend *f,
 		map->m_la = end;
 		err = z_erofs_map_blocks_iter(inode, map,
 					      EROFS_GET_BLOCKS_READMORE);
-		if (err || !(map->m_flags & EROFS_MAP_ENCODED))
+		if (err || !(map->m_flags & EROFS_MAP_MAPPED))
 			return;
 
 		/* expand ra for the trailing edge if readahead */
@@ -1853,7 +1852,7 @@ static void z_erofs_pcluster_readmore(struct z_erofs_frontend *f,
 		end = round_up(end, PAGE_SIZE);
 	} else {
 		end = round_up(map->m_la, PAGE_SIZE);
-		if (!(map->m_flags & EROFS_MAP_ENCODED) || !map->m_llen)
+		if (!(map->m_flags & EROFS_MAP_MAPPED) || !map->m_llen)
 			return;
 	}
 
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 30775502b56d..67f55b9b57af 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -419,7 +419,7 @@ static int z_erofs_map_blocks_fo(struct inode *inode,
 
 	if ((flags & EROFS_GET_BLOCKS_FINDTAIL) && ztailpacking)
 		vi->z_fragmentoff = m.nextpackoff;
-	map->m_flags = EROFS_MAP_MAPPED | EROFS_MAP_ENCODED;
+	map->m_flags = EROFS_MAP_MAPPED | EROFS_MAP_PARTIAL_MAPPED;
 	end = (m.lcn + 1ULL) << lclusterbits;
 
 	if (m.type != Z_EROFS_LCLUSTER_TYPE_NONHEAD && endoff >= m.clusterofs) {
@@ -435,7 +435,7 @@ static int z_erofs_map_blocks_fo(struct inode *inode,
 	} else {
 		if (m.type != Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
 			end = (m.lcn << lclusterbits) | m.clusterofs;
-			map->m_flags |= EROFS_MAP_FULL_MAPPED;
+			map->m_flags &= ~EROFS_MAP_PARTIAL_MAPPED;
 			m.delta[0] = 1;
 		}
 		/* get the corresponding first chunk */
@@ -496,7 +496,7 @@ static int z_erofs_map_blocks_fo(struct inode *inode,
 	      map->m_llen >= i_blocksize(inode))) {
 		err = z_erofs_get_extent_decompressedlen(&m);
 		if (!err)
-			map->m_flags |= EROFS_MAP_FULL_MAPPED;
+			map->m_flags &= ~EROFS_MAP_PARTIAL_MAPPED;
 	}
 
 unmap_out:
@@ -594,8 +594,7 @@ static int z_erofs_map_blocks_ext(struct inode *inode,
 			if (recsz > offsetof(struct z_erofs_extent, pstart_lo))
 				vi->z_fragmentoff |= map->m_pa << 32;
 		} else if (map->m_plen & Z_EROFS_EXTENT_PLEN_MASK) {
-			map->m_flags |= EROFS_MAP_MAPPED |
-				EROFS_MAP_FULL_MAPPED | EROFS_MAP_ENCODED;
+			map->m_flags |= EROFS_MAP_MAPPED;
 			fmt = map->m_plen >> Z_EROFS_EXTENT_PLEN_FMT_BIT;
 			if (map->m_plen & Z_EROFS_EXTENT_PLEN_PARTIAL)
 				map->m_flags |= EROFS_MAP_PARTIAL_REF;
@@ -714,7 +713,7 @@ static int z_erofs_map_sanity_check(struct inode *inode,
 	struct erofs_sb_info *sbi = EROFS_I_SB(inode);
 	u64 pend;
 
-	if (!(map->m_flags & EROFS_MAP_ENCODED))
+	if (!(map->m_flags & EROFS_MAP_MAPPED))
 		return 0;
 	if (unlikely(map->m_algorithmformat >= Z_EROFS_COMPRESSION_RUNTIME_MAX)) {
 		erofs_err(inode->i_sb, "unknown algorithm %d @ pos %llu for nid %llu, please upgrade kernel",
@@ -781,10 +780,12 @@ static int z_erofs_iomap_begin_report(struct inode *inode, loff_t offset,
 	iomap->bdev = inode->i_sb->s_bdev;
 	iomap->offset = map.m_la;
 	iomap->length = map.m_llen;
-	if (map.m_flags & EROFS_MAP_MAPPED) {
+	if (map.m_flags & EROFS_MAP_FRAGMENT) {
 		iomap->type = IOMAP_MAPPED;
-		iomap->addr = map.m_flags & __EROFS_MAP_FRAGMENT ?
-			      IOMAP_NULL_ADDR : map.m_pa;
+		iomap->addr = IOMAP_NULL_ADDR;
+	} else if (map.m_flags & EROFS_MAP_MAPPED) {
+		iomap->type = IOMAP_MAPPED;
+		iomap->addr = map.m_pa;
 	} else {
 		iomap->type = IOMAP_HOLE;
 		iomap->addr = IOMAP_NULL_ADDR;
diff --git a/include/trace/events/erofs.h b/include/trace/events/erofs.h
index def20d06507b..cd0e3fd8c23f 100644
--- a/include/trace/events/erofs.h
+++ b/include/trace/events/erofs.h
@@ -26,10 +26,9 @@ struct erofs_map_blocks;
 #define show_mflags(flags) __print_flags(flags, "",	\
 	{ EROFS_MAP_MAPPED,		"M" },		\
 	{ EROFS_MAP_META,		"I" },		\
-	{ EROFS_MAP_ENCODED,		"E" },		\
-	{ EROFS_MAP_FULL_MAPPED,	"F" },		\
-	{ EROFS_MAP_FRAGMENT,		"R" },		\
-	{ EROFS_MAP_PARTIAL_REF,	"P" })
+	{ EROFS_MAP_PARTIAL_MAPPED,	"T" },		\
+	{ EROFS_MAP_PARTIAL_REF,	"P" },		\
+	{ EROFS_MAP_FRAGMENT,		"R" })
 
 TRACE_EVENT(erofs_lookup,
 
-- 
2.43.5


