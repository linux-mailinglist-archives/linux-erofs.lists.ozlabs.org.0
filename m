Return-Path: <linux-erofs+bounces-3870-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KyQCKK+VT2rOkAIAu9opvQ
	(envelope-from <linux-erofs+bounces-3870-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 09 Jul 2026 14:35:59 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EBB7310A7
	for <lists+linux-erofs@lfdr.de>; Thu, 09 Jul 2026 14:35:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=ScofmLPM;
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3870-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3870-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwvZf26WPz3c9w;
	Thu, 09 Jul 2026 22:35:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783600554;
	cv=none; b=jmom2SfbWlcWC9OIH6RyGw0BBNNb3X7oQlZbyzmt9G8HdLE/qQE8dvMfHCT9G5R41Mm837geVknOMUwaIvMOOalI+Y8iyU7lsaG7s6lHp5VgWIYOPU09448PY4q6zbUeaG7lTNQk1Xso329XjyulJVmi7O90fwmHv5FQvC+kuEbd8HuUnS6ptOiwVyLMY0DJnpzLpE8oYEym15xEZmwTTZbtKovrqUAgc3kHXRgr+5+Yzv2IM9pN2ISuBBOkatKQTlV5HwyoSr/3KOMnQPvFCOAjsZGiO0Ga7qMisJz0EReny5BPDZPSToKAqzX2z10+mOvgJgI+HNA7k0f2ypft4A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783600554; c=relaxed/relaxed;
	bh=2c2WLhMpxXGd2zZ8xVVz1EOs2xJcw3p15TLm0SoZHu8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LpqTqh70u+HedEyA16cemIPZB1TFBHyUcZuw5rjw77ILYlIl/3l69AXoJz0y9a40SFMjDFuxTDAjofNud12sEyzQ0g4iyjEAM+H+uPpt57X6Y+sDdMWILbpxihZ47e+kopUvNQ7S0gKIXHwPVVSiyJRPguJmioqACmUDne6k3ljVbAyCb0IBBYJhf7g/os/GNkPHp604aC1HoXaKhDE83kiUfngToH2IwX/aZFhjR0KGHYUN8XMBg6EVh/m2D6qwDVRK9JHfScS/0TcOYJAtVZsae23JKspcJkDiOSk73xJ8fXk0eGpaRiVtLaMfROth209mE0HE1uuOxItK7W9QPg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=ScofmLPM; dkim-atps=neutral; spf=pass (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwvZZ2pqdz3c9k
	for <linux-erofs@lists.ozlabs.org>; Thu, 09 Jul 2026 22:35:48 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=2c2WLhMpxXGd2zZ8xVVz1EOs2xJcw3p15TLm0SoZHu8=;
	b=ScofmLPMBdIGTW3JVpSBDYWlwdl0Wz56AYMxOTGEos7gJJhz40kclutKcCghVp40oTi6OazGk
	yeDncZ3I7S3Lt6E+fTI9ZnDtpq8OpyH6NeOSr4aSuYa5FD3bol65LTIZ2FZhxWzPYih34ofnLQ4
	D/aBdZEpfEsCx9he5QpzTPo=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4gwvMj2wGyz1prlm;
	Thu,  9 Jul 2026 20:26:25 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 2238E40577;
	Thu,  9 Jul 2026 20:35:42 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 9 Jul
 2026 20:35:41 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>, <hsiangkao@linux.alibaba.com>
CC: <zhukeqian1@huawei.com>, <zhaoyifan28@huawei.com>
Subject: [PATCH] erofs-utils: lib: fix ztailpacking fallback across lclusters
Date: Thu, 9 Jul 2026 20:34:11 +0800
Message-ID: <20260709123411.1166770-1-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.47.3
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
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[huawei.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3870-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_XOIP(0.00)[];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaoyifan28@huawei.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_THREE(0.00)[4];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A5EBB7310A7

With ztailpacking, the final compressed pcluster is first stored as
inline data.  If the inode metadata area cannot hold it, mkfs falls back
to a normal tail block and drops the inline pcluster marker.

The current fallback path assumes that the inline tail pcluster belongs
to the EOF lcluster.  That is not always true: the tail pcluster can
start in the previous lcluster and end at EOF, while its raw size still
fits in one block.  In that case, patching the EOF lcluster is
semantically wrong.

Let's keep raw tail data whenever it fits in one block, and convert the
corresponding lcluster index to PLAIN during fallback.

Reported-by: Alberto Salvia Novella <es20490446e@gmail.com>
Closes: https://github.com/erofs/erofs-utils/issues/51
Assisted-by: Codex:GPT-5.5
Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
 include/erofs/internal.h |   5 +-
 lib/compress.c           | 109 ++++++++++++++++++++++++++++-----------
 2 files changed, 83 insertions(+), 31 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 2cc9cc8..bdde41f 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -212,8 +212,11 @@ struct erofs_diskbuf;
 
 enum erofs_idata_type {
 	EROFS_IDATA_TYPE_RAW,
-	EROFS_IDATA_TYPE_COMPRESSED_DEFAULT,
+	EROFS_IDATA_TYPE_COMPRESSED,
+	/* compressed idata follows a final 2B compacted index pack */
 	EROFS_IDATA_TYPE_COMPRESSED_END_OF_2B,
+	/* compressed idata follows a final single-entry 4B pack after a 2B pack */
+	EROFS_IDATA_TYPE_COMPRESSED_4B1_PREV2B,
 };
 
 #define EROFS_I_BLKADDR_DEV_ID_BIT		48
diff --git a/lib/compress.c b/lib/compress.c
index f7ad5a1..ec90f65 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -483,7 +483,7 @@ static int z_erofs_fill_inline_data(struct erofs_inode *inode, void *data,
 {
 	inode->z_advise |= Z_EROFS_ADVISE_INLINE_PCLUSTER;
 	inode->idata_size = len;
-	inode->idata_type = EROFS_IDATA_TYPE_COMPRESSED_DEFAULT;
+	inode->idata_type = EROFS_IDATA_TYPE_COMPRESSED;
 
 	inode->idata = malloc(inode->idata_size);
 	if (!inode->idata)
@@ -664,7 +664,7 @@ frag_packing:
 		ictx->fragemitted = true;
 	/* tailpcluster should be less than 1 block */
 	} else if (may_inline && len == e->length && compressedsize < blksz) {
-		if (ctx->clusterofs + len <= blksz) {
+		if (len <= blksz) {
 			inode->eof_tailraw = malloc(len);
 			if (!inode->eof_tailraw)
 				return -ENOMEM;
@@ -962,6 +962,14 @@ int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
 		dummy_head = true;
 	}
 
+	if (inode->idata_size) {
+		if (compacted_2b && !compacted_4b_end)
+			inode->idata_type = EROFS_IDATA_TYPE_COMPRESSED_END_OF_2B;
+		else if (compacted_2b && compacted_4b_end == 1)
+			inode->idata_type =
+				EROFS_IDATA_TYPE_COMPRESSED_4B1_PREV2B;
+	}
+
 	/* generate compacted_4b_initial */
 	while (compacted_4b_initial) {
 		in = parse_legacy_indexes(cv, 2, in);
@@ -974,8 +982,6 @@ int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
 
 	/* generate compacted_2b */
 	if (compacted_2b) {
-		if (!compacted_4b_end && inode->idata_size)
-			inode->idata_type = EROFS_IDATA_TYPE_COMPRESSED_END_OF_2B;
 		do {
 			in = parse_legacy_indexes(cv, 16, in);
 			out = write_compacted_indexes(out, cv, &blkaddr,
@@ -1205,11 +1211,65 @@ out:
 	return metabuf;
 }
 
+static void z_erofs_patch_tail_compacted_index(struct erofs_inode *inode,
+					       bool previous,
+					       unsigned int type)
+{
+	const unsigned int totalidx = BLK_ROUND_UP(inode->sbi, inode->i_size);
+	const unsigned int lobits = max_t(unsigned int, inode->z_lclusterbits,
+				ilog2(Z_EROFS_LI_D0_CBLKCNT) + 1U);
+	u8 *base = inode->compressmeta;
+	u8 *pack = base + inode->extent_isize;
+	unsigned int bitpos, bitoff;
+	u8 *out;
+	u32 v;
+
+	DBG_BUGON(!totalidx);
+	DBG_BUGON(inode->z_lclusterbits > 14);
+
+	if (inode->idata_type == EROFS_IDATA_TYPE_COMPRESSED_END_OF_2B) {
+		pack -= 32;
+		bitpos = 14 * (previous ? 14 : 15);
+		goto out;
+	}
+
+	/* Last compacted index pack is 4B */
+	pack -= 8;
+	if (!(totalidx & 1)) {
+		bitpos = previous ? 0 : 16;
+		goto out;
+	}
+
+	if (!previous) {
+		bitpos = 0;
+		goto out;
+	}
+
+	/* Second to last compacted index pack is 2B */
+	if (inode->idata_type == EROFS_IDATA_TYPE_COMPRESSED_4B1_PREV2B) {
+		pack -= 32;
+		bitpos = 14 * 15;
+	} else {
+		pack -= 8;
+		bitpos = 16;
+	}
+out:
+	DBG_BUGON(pack < base);
+	bitoff = bitpos & 7;
+	out = pack + bitpos / 8;
+	v = get_unaligned_le32(out);
+	v &= ~(Z_EROFS_LI_LCLUSTER_TYPE_MASK << (lobits + bitoff));
+	v |= type << (lobits + bitoff);
+	put_unaligned_le32(v, out);
+}
+
 void z_erofs_drop_inline_pcluster(struct erofs_inode *inode)
 {
 	struct erofs_sb_info *sbi = inode->sbi;
 	const unsigned int type = Z_EROFS_LCLUSTER_TYPE_PLAIN;
 	struct z_erofs_map_header *h = inode->compressmeta;
+	erofs_off_t rawstart;
+	erofs_blk_t head_lcn, eof_lcn;
 
 	h->h_advise = cpu_to_le16(le16_to_cpu(h->h_advise) &
 				  ~Z_EROFS_ADVISE_INLINE_PCLUSTER);
@@ -1218,38 +1278,27 @@ void z_erofs_drop_inline_pcluster(struct erofs_inode *inode)
 	if (!inode->eof_tailraw)
 		return;
 	DBG_BUGON(inode->idata_type == EROFS_IDATA_TYPE_RAW);
+	DBG_BUGON(!inode->i_size);
+	DBG_BUGON(inode->eof_tailrawsize > erofs_blksiz(sbi));
+	DBG_BUGON(inode->eof_tailrawsize > inode->i_size);
+
+	rawstart = inode->i_size - inode->eof_tailrawsize;
+	head_lcn = rawstart >> sbi->blkszbits;
+	eof_lcn = (inode->i_size - 1) >> sbi->blkszbits;
+	DBG_BUGON(head_lcn != eof_lcn && head_lcn + 1 != eof_lcn);
 
-	/* patch the EOF lcluster to uncompressed type first */
+	/* patch the tail pcluster head to uncompressed type first */
 	if (inode->datalayout == EROFS_INODE_COMPRESSED_FULL) {
 		struct z_erofs_lcluster_index *di =
-			(inode->compressmeta + inode->extent_isize) -
-			sizeof(struct z_erofs_lcluster_index);
+			(void *)((u8 *)inode->compressmeta +
+				 Z_EROFS_LEGACY_MAP_HEADER_SIZE +
+				 head_lcn *
+				 sizeof(struct z_erofs_lcluster_index));
 
 		di->di_advise = cpu_to_le16(type);
 	} else if (inode->datalayout == EROFS_INODE_COMPRESSED_COMPACT) {
-		/* handle the last compacted 4B/2B pack */
-		unsigned int lclusterbits = inode->z_lclusterbits;
-		unsigned int lobits, eofs, base, pos, v;
-		u8 *out;
-
-		lobits = max(lclusterbits, ilog2(Z_EROFS_LI_D0_CBLKCNT) + 1U);
-
-		if (inode->idata_type == EROFS_IDATA_TYPE_COMPRESSED_DEFAULT) {
-			eofs = inode->extent_isize -
-				(4 << (BLK_ROUND_UP(sbi, inode->i_size) & 1));
-			base = round_down(eofs, 8);
-			pos = 16 /* encodebits */ * ((eofs - base) / 4);
-			out = inode->compressmeta + base + pos / 8;
-		} else {
-			out = inode->compressmeta + inode->extent_isize -
-				sizeof(__le32) - sizeof(__le16);
-			lobits = 16 - 14 /* encodebits */ + lobits;
-		}
-
-		v = (get_unaligned_le16(out) & (BIT(lobits) - 1)) |
-			(type << lobits);
-		*out = v & 0xff;
-		*(out + 1) = v >> 8;
+		z_erofs_patch_tail_compacted_index(inode, head_lcn != eof_lcn,
+						   type);
 	} else {
 		DBG_BUGON(1);
 		return;
-- 
2.47.3


