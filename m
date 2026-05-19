Return-Path: <linux-erofs+bounces-3448-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJuHG8QIDGo5UQUAu9opvQ
	(envelope-from <linux-erofs+bounces-3448-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 19 May 2026 08:52:52 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EFD578686
	for <lists+linux-erofs@lfdr.de>; Tue, 19 May 2026 08:52:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKQNH6kNMz2xwH;
	Tue, 19 May 2026 16:52:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=222.66.158.135
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779173567;
	cv=none; b=EvVKoRg6op9HNVqA5UyJE4fPpcqYwhGRNUSitsoAg05K1SywRngFZqOLmxQkTEbuB5/DnDe8IfGLPFZgiRiEI18J6lfUfkC2W6sPPsWP1Hw/si3AdTJvn7UFGNgGgOuwinvGnrhJkyVN2jZ2YwaNxRZ0grjw/5cguh2xWh9qyUejM30wOntRI7+odWtXpfCfA+1xIl2b/eOkx6UAfvMUz5sN97CcGM1ynb/xavuFFP0yWBBM2JyWYfk5gwFXS6HVrUkhaiEChOvUNsBwbKmd8aswayazfHJT0LDScER8y2aMDMhlMfUgDLG9kAWi/Rza1qNu8FR9l+CO6YVLBoX6jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779173567; c=relaxed/relaxed;
	bh=rZgGoeq7XA+PfJgCPVYpg/nstb2uIc3W/Fwyt4UWdwI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fUcObYJ+IOCZfGLlcIr16jXt/T7xQzNdyGYBOEVjS/YVL/sMC7BI6d8BwA5uqmtnOkLRoZGq/yas9AcMwkVUnw4B3dIKJaos3FRhim7wpU/JaahqqZwOoutfF8rj57r8kydJ6m/bRV3rPOs/gb/TzbxS71fupw3dbAPhhNRaHljf8Cmz6fnIJIpbr70ytvv1fXgN1NrachhiEldxROQtpDRPUOmp0K/nHxWdgAij4vfiPlGmLgUUw7bKhTIa0bmkWXx6vLrY2i5QvVCZ8tizn+H5NZJgm4/Sj0Q+lfoiw49DoHKbBSMrSW4c+BCTyNsCM0Ve9wWF26W2kyZ++NJ3ZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com; dkim=pass (2048-bit key; unprotected) header.d=unisoc.com header.i=@unisoc.com header.a=rsa-sha256 header.s=default header.b=DplxgYES; dkim-atps=neutral; spf=pass (client-ip=222.66.158.135; helo=shsqr01.spreadtrum.com; envelope-from=zhiguo.niu@unisoc.com; receiver=lists.ozlabs.org) smtp.mailfrom=unisoc.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=unisoc.com header.i=@unisoc.com header.a=rsa-sha256 header.s=default header.b=DplxgYES;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=unisoc.com (client-ip=222.66.158.135; helo=shsqr01.spreadtrum.com; envelope-from=zhiguo.niu@unisoc.com; receiver=lists.ozlabs.org)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKQNF2mFNz2xqv
	for <linux-erofs@lists.ozlabs.org>; Tue, 19 May 2026 16:52:40 +1000 (AEST)
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 64J6q2jM078490;
	Tue, 19 May 2026 14:52:02 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (BJMBX02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4gKQHG37r8z2MLY3d;
	Tue, 19 May 2026 14:48:26 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Tue, 19 May 2026 14:51:59 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <hsiangkao@linux.alibaba.com>
CC: <niuzhiguo84@gmail.com>, <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>,
        <linux-erofs@lists.ozlabs.org>
Subject: [PATCH v2] erofs-utils: mkfs: fix to handle last compacted_2B pack in z_erofs_drop_inline_pcluster
Date: Tue, 19 May 2026 14:53:09 +0800
Message-ID: <1779173589-18216-1-git-send-email-zhiguo.niu@unisoc.com>
X-Mailer: git-send-email 1.9.1
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
Content-Type: text/plain
X-Originating-IP: [10.0.73.87]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 64J6q2jM078490
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unisoc.com;
	s=default; t=1779173543;
	bh=rZgGoeq7XA+PfJgCPVYpg/nstb2uIc3W/Fwyt4UWdwI=;
	h=From:To:CC:Subject:Date;
	b=DplxgYESclDzNVrFwXO2rsHsINUXBzs734qYRhPAEYMcQT0EiZJoZazgqUkEZwifs
	 mZgakJ61YVIA8LyoYLkhKsz1jrAyHsiemNGYENxqTrxvWbK3G1DnzaDu3MMirK9Gc2
	 FsTlnA5mr5Y4YYmPnGcFw+eZg4AMTBdiC5FQ1WtMIn519r5/h4hILRZdC9+eQ761Js
	 TaRM2PxeS0ERyEHEPXzW8O3J9kdTzEz6qnC+hs4IMOJefk2gEf8QxPX5MaP8+P7tEp
	 pnGbh5scUYkCF0rTyrSbPEtzLNKb40e4ilgrsW7qNHhBO95m4bXrD9lS8Tz4JOrRda
	 Mod6+dDI0/5aQ==
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[unisoc.com,quarantine];
	R_DKIM_ALLOW(-0.20)[unisoc.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:niuzhiguo84@gmail.com,m:zhiguo.niu@unisoc.com,m:ke.wang@unisoc.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,unisoc.com,lists.ozlabs.org];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3448-lists,linux-erofs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[zhiguo.niu@unisoc.com,linux-erofs@lists.ozlabs.org];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[zhiguo.niu@unisoc.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[unisoc.com:+];
	TO_DN_NONE(0.00)[];
	HAS_XOIP(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Queue-Id: E1EFD578686
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

With ztailpacking enabled, the current process assumes that a compacted_4b_end
always exists in the compacted pack. However, in some specific files, the
compacted pack may not have a compacted_4b_end. This leads to an incorrect
modification of the last compacted_2B entry, resulting in incorrect modification
of its clusterofs. In subsequent fsck operations, incorrect parameters will
affect the decompression of the penultimate pcluster.

This patch also handle the last compacted_2B pack correctly.

Fixes: a7c1f0575ef8 ("erofs-utils: lib: refine tailpcluster compression approach")

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Suggested-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v2: modity according to Xiang's suggestions
---
 include/erofs/defs.h     |  5 +++++
 include/erofs/internal.h |  8 ++++++-
 lib/compress.c           | 55 ++++++++++++++++++++++++++++++------------------
 lib/inode.c              |  5 +++--
 4 files changed, 49 insertions(+), 24 deletions(-)

diff --git a/include/erofs/defs.h b/include/erofs/defs.h
index 5724c27..6b7952c 100644
--- a/include/erofs/defs.h
+++ b/include/erofs/defs.h
@@ -218,6 +218,11 @@ typedef int64_t         s64;
 #define get_unaligned(ptr)	__get_unaligned_t(typeof(*(ptr)), (ptr))
 #define put_unaligned(val, ptr) __put_unaligned_t(typeof(*(ptr)), (val), (ptr))
 
+static inline u16 get_unaligned_le16(const void *p)
+{
+	return le16_to_cpu(__get_unaligned_t(__le16, p));
+}
+
 static inline u32 get_unaligned_le32(const void *p)
 {
 	return le32_to_cpu(__get_unaligned_t(__le32, p));
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 450e264..2cc9cc8 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -210,6 +210,12 @@ struct erofs_diskbuf;
 #define EROFS_INODE_DATA_SOURCE_RESVSP		3
 #define EROFS_INODE_DATA_SOURCE_REBUILD_BLOB	4
 
+enum erofs_idata_type {
+	EROFS_IDATA_TYPE_RAW,
+	EROFS_IDATA_TYPE_COMPRESSED_DEFAULT,
+	EROFS_IDATA_TYPE_COMPRESSED_END_OF_2B,
+};
+
 #define EROFS_I_BLKADDR_DEV_ID_BIT		48
 
 struct erofs_inode {
@@ -262,7 +268,7 @@ struct erofs_inode {
 	unsigned short idata_size;
 	char datasource;
 	bool in_metabox;
-	bool compressed_idata;
+	char idata_type;
 	bool lazy_tailblock;
 	bool opaque;
 	/* OVL: non-merge dir that may contain whiteout entries */
diff --git a/lib/compress.c b/lib/compress.c
index 62d2672..03ed4d7 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -483,7 +483,7 @@ static int z_erofs_fill_inline_data(struct erofs_inode *inode, void *data,
 {
 	inode->z_advise |= Z_EROFS_ADVISE_INLINE_PCLUSTER;
 	inode->idata_size = len;
-	inode->compressed_idata = !raw;
+	inode->idata_type = EROFS_IDATA_TYPE_COMPRESSED_DEFAULT;
 
 	inode->idata = malloc(inode->idata_size);
 	if (!inode->idata)
@@ -973,14 +973,17 @@ int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
 	DBG_BUGON(compacted_4b_initial);
 
 	/* generate compacted_2b */
-	while (compacted_2b) {
-		in = parse_legacy_indexes(cv, 16, in);
-		out = write_compacted_indexes(out, cv, &blkaddr,
-					      2, logical_clusterbits, false,
-					      &dummy_head, big_pcluster);
-		compacted_2b -= 16;
+	if (compacted_2b) {
+		if (!compacted_4b_end && inode->idata_size)
+			inode->idata_type = EROFS_IDATA_TYPE_COMPRESSED_END_OF_2B;
+		do {
+			in = parse_legacy_indexes(cv, 16, in);
+			out = write_compacted_indexes(out, cv, &blkaddr,
+						      2, logical_clusterbits, false,
+						      &dummy_head, big_pcluster);
+			compacted_2b -= 16;
+		} while(compacted_2b);
 	}
-	DBG_BUGON(compacted_2b);
 
 	/* generate compacted_4b_end */
 	while (compacted_4b_end > 1) {
@@ -1210,10 +1213,11 @@ void z_erofs_drop_inline_pcluster(struct erofs_inode *inode)
 
 	h->h_advise = cpu_to_le16(le16_to_cpu(h->h_advise) &
 				  ~Z_EROFS_ADVISE_INLINE_PCLUSTER);
+	DBG_BUGON(inode->idata_size != le16_to_cpu(h->h_idata_size));
 	h->h_idata_size = 0;
 	if (!inode->eof_tailraw)
 		return;
-	DBG_BUGON(inode->compressed_idata != true);
+	DBG_BUGON(inode->idata_type == EROFS_IDATA_TYPE_RAW);
 
 	/* patch the EOF lcluster to uncompressed type first */
 	if (inode->datalayout == EROFS_INODE_COMPRESSED_FULL) {
@@ -1223,19 +1227,28 @@ void z_erofs_drop_inline_pcluster(struct erofs_inode *inode)
 
 		di->di_advise = cpu_to_le16(type);
 	} else if (inode->datalayout == EROFS_INODE_COMPRESSED_COMPACT) {
-		/* handle the last compacted 4B pack */
-		unsigned int eofs, base, pos, v, lo;
+		/* handle the last compacted pack */
+		unsigned int lclusterbits = inode->z_lclusterbits;
+		unsigned int lobits, eofs, base, pos, v;
 		u8 *out;
 
-		eofs = inode->extent_isize -
-			(4 << (BLK_ROUND_UP(sbi, inode->i_size) & 1));
-		base = round_down(eofs, 8);
-		pos = 16 /* encodebits */ * ((eofs - base) / 4);
-		out = inode->compressmeta + base;
-		lo = erofs_blkoff(sbi, get_unaligned_le32(out + pos / 8));
-		v = (type << sbi->blkszbits) | lo;
-		out[pos / 8] = v & 0xff;
-		out[pos / 8 + 1] = v >> 8;
+		lobits = max(lclusterbits, ilog2(Z_EROFS_LI_D0_CBLKCNT) + 1U);
+
+		if (inode->idata_type == EROFS_IDATA_TYPE_COMPRESSED_DEFAULT) {
+			eofs = inode->extent_isize -
+				(4 << (BLK_ROUND_UP(sbi, inode->i_size) & 1));
+			base = round_down(eofs, 8);
+			pos = 16 /* encodebits */ * ((eofs - base) / 4);
+			out = inode->compressmeta + base + pos / 8;
+		} else {
+			out = inode->compressmeta + inode->extent_isize - 4 - 2;
+			lobits = 16 - 14 /* encodebits */ + lobits;
+		}
+		v = (get_unaligned_le16(out) & (BIT(lobits) - 1)) |
+			(type << lobits);
+		*out = v & 0xff;
+		*(out + 1) = v >> 8;
+
 	} else {
 		DBG_BUGON(1);
 		return;
@@ -1244,7 +1257,7 @@ void z_erofs_drop_inline_pcluster(struct erofs_inode *inode)
 	/* replace idata with prepared uncompressed data */
 	inode->idata = inode->eof_tailraw;
 	inode->idata_size = inode->eof_tailrawsize;
-	inode->compressed_idata = false;
+	inode->idata_type = EROFS_IDATA_TYPE_RAW;
 	inode->eof_tailraw = NULL;
 }
 
diff --git a/lib/inode.c b/lib/inode.c
index 95fd93b..ce419c5 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1043,7 +1043,7 @@ noinline:
 		if (is_inode_layout_compression(inode)) {
 			DBG_BUGON(!params->ztailpacking);
 			erofs_dbg("Inline %scompressed data (%u bytes) to %s",
-				  inode->compressed_idata ? "" : "un",
+				  inode->idata_type == EROFS_IDATA_TYPE_RAW ? "un": "",
 				  inode->idata_size, inode->i_srcpath);
 			erofs_sb_set_ztailpacking(sbi);
 		} else {
@@ -1149,7 +1149,8 @@ static int erofs_write_tail_end(struct erofs_importer *im,
 		pos = erofs_btell(bh, true) - erofs_blksiz(sbi);
 
 		/* 0'ed data should be padded at head for 0padding conversion */
-		h0 = erofs_sb_has_lz4_0padding(sbi) && inode->compressed_idata;
+		h0 = erofs_sb_has_lz4_0padding(sbi) &&
+			inode->idata_type != EROFS_IDATA_TYPE_RAW;
 		DBG_BUGON(inode->idata_size > erofs_blksiz(sbi));
 
 		iov[h0] = (struct iovec) { .iov_base = inode->idata,
-- 
1.9.1


