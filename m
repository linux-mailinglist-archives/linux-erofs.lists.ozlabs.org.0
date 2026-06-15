Return-Path: <linux-erofs+bounces-3590-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HXnvE1CfL2rRDQUAu9opvQ
	(envelope-from <linux-erofs+bounces-3590-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Jun 2026 08:44:32 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 81850683E7B
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Jun 2026 08:44:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=iX98TP1Y;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3590-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3590-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gf0wB6tgdz3bqD;
	Mon, 15 Jun 2026 16:44:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781505866;
	cv=none; b=OuPYqCP7eWgpyQA7xOSO5MM1xriTL1Uce0D2bNIf0KoIrLqnhx0kH0Uk8M8gFtgHPsZQpI3KBxoGh0iirObn7eCxE8Bd9zov3canuQVbDHrNSCQ9/KMj2wl3NWoWwPBd9JOQPx2Yb4LWHwA1LhpOF1mUBRdXKigkAu2aAbJUXkzU58hD7Y0HIwdsT0YCSWOtroaLhViPbam5MELQH/lRmhmh0UEQ3w99yj1gAIseELJFiFgttVMS5cVTva41Ezn7rZKcYT/9nwA1ugybSlg6wswTDRDjW3Wwq0Qb5ZxVlJc5Ev6Iv58hV/q2B6qanOg64+0shEvteJBWxMfGEUbRUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781505866; c=relaxed/relaxed;
	bh=P4wIl9xSFpVj4vrwIFfOXDRHyQ7flztTZcTDombHaeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gTFaExnOGApUzpeotwnvY0tT5vXCL7g9QDP5qM746WB0sQS7MWVlncDuV5sQM4DK4ICDyNkjmmQtDejgBo8XVa45rxcY7dC+ympoyJ88FS73VkTR8xHRWJbmH1Ij84+21GYHDnRM0cjTCMbwe6afLz04UZiqkhQ1quWy0HCQuOGfsnOKX1WKbLMC8cNIBdPsT3Rq6Japg7OzRbkPEZ07TF0qh93bmulToPK6V9cogQEwUoKa/ccU+DfIC9h4BLZXLow/MaPCmhnmAaBM5c3NaB6FuG33L5vsOq75DblrY1RX+laCLwkqzUkK7+qGPsmi/r6WhL/Mhq+2qaMQOynl1A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=iX98TP1Y; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gf0w84hlpz2xls
	for <linux-erofs@lists.ozlabs.org>; Mon, 15 Jun 2026 16:44:22 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781505858; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=P4wIl9xSFpVj4vrwIFfOXDRHyQ7flztTZcTDombHaeI=;
	b=iX98TP1Y0vKTE/FFOCom8p+0rkqhMXvnT1Wpf/6t/HwB2BZ3e8zsOGEoFldjjTkNVngztXl91Uk4Dy2jnAqk9qlx5TMzNKqXJnp/rz/RdrmNemMDS+EasDiR9EY8bcuTEk3BLxHnI9JAvcJl0KWHWlAtSHlx5dQ9DMAveZLIfXo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X4q35O8_1781505853;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X4q35O8_1781505853 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 15 Jun 2026 14:44:17 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	oliver.yang@linux.alibaba.com,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2] erofs: introduce erofs_map_chunks()
Date: Mon, 15 Jun 2026 14:44:12 +0800
Message-ID: <20260615064412.160228-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260615051016.27430-1-hsiangkao@linux.alibaba.com>
References: <20260615051016.27430-1-hsiangkao@linux.alibaba.com>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3590-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp,alibaba.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 81850683E7B

Try to map more chunks in the same metadata on-disk block for
more efficient IO performance.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
changes since v1:
 - recover m_plen to avoid any uninitialized field.
 - need to increase map->m_llen if not due to last != addr.

 fs/erofs/data.c | 131 ++++++++++++++++++++++++++----------------------
 1 file changed, 71 insertions(+), 60 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 44da21c9d777..d1861af32f40 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -98,17 +98,73 @@ void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
 	return erofs_bread(buf, offset, true);
 }
 
-int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map)
+static int erofs_map_chunks(struct inode *inode, struct erofs_map_blocks *map)
 {
 	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 	struct super_block *sb = inode->i_sb;
-	unsigned int unit, blksz = sb->s_blocksize;
 	struct erofs_inode *vi = EROFS_I(inode);
 	struct erofs_inode_chunk_index *idx;
-	erofs_blk_t startblk, addrmask;
-	bool tailpacking;
+	unsigned int unit = vi->chunkformat & EROFS_CHUNK_FORMAT_INDEXES ?
+		sizeof(*idx) : EROFS_BLOCK_MAP_ENTRY_SIZE;
+	erofs_blk_t addrmask = (vi->chunkformat & EROFS_CHUNK_FORMAT_48BIT) ?
+		BIT_ULL(48) - 1 : BIT_ULL(32) - 1;
+	u64 nr = map->m_la >> vi->chunkbits;
+	erofs_off_t pos = ALIGN(erofs_iloc(inode) + vi->inode_isize +
+				vi->xattr_isize, unit) + unit * nr;
+	/* m_llen will be clamped to EOF in the end */
+	erofs_off_t endpos = round_up(pos + 1, sb->s_blocksize);
+	u64 last, addr;
+
+	idx = erofs_read_metabuf(&buf, sb, pos, erofs_inode_in_metabox(inode));
+	if (IS_ERR(idx))
+		return PTR_ERR(idx);
+
+	map->m_la = nr << vi->chunkbits;
+	map->m_llen = 0;
+	nr = 0;
+	do {
+		if (unit == EROFS_BLOCK_MAP_ENTRY_SIZE) {
+			addr = le32_to_cpu(((__le32 *)idx)[nr]);
+			if (addr == (u32)EROFS_NULL_ADDR)
+				addr = EROFS_NULL_ADDR;
+		} else {
+			addr = (((u64)le16_to_cpu(idx[nr].startblk_hi) << 32) |
+				le32_to_cpu(idx[nr].startblk_lo)) & addrmask;
+			if (addr ^ (EROFS_NULL_ADDR & addrmask))
+				addr |= (u64)(le16_to_cpu(idx[nr].device_id) &
+					EROFS_SB(sb)->device_id_mask) << 48;
+			else
+				addr = EROFS_NULL_ADDR;
+		}
+		if (!nr) {
+			last = addr;
+			continue;
+		}
+		/* expand and account the prior chunk here */
+		map->m_llen += 1UL << vi->chunkbits;
+		if (last != EROFS_NULL_ADDR)
+			last += erofs_blknr(sb, 1UL << vi->chunkbits);
+	} while (addr == last && pos + (++nr) * unit < endpos);
+
+	if (last != EROFS_NULL_ADDR) {
+		map->m_pa = erofs_pos(sb, last & addrmask) - map->m_llen;
+		map->m_deviceid = last >> 48;
+		map->m_flags = EROFS_MAP_MAPPED;
+	}
+	if (addr == last)
+		map->m_llen += (1UL << vi->chunkbits);
+	map->m_llen = min_t(erofs_off_t, map->m_llen,
+			round_up(inode->i_size - map->m_la, sb->s_blocksize));
+	erofs_put_metabuf(&buf);
+	return 0;
+}
+
+int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map)
+{
+	struct super_block *sb = inode->i_sb;
+	struct erofs_inode *vi = EROFS_I(inode);
+	bool tailinline = (vi->datalayout == EROFS_INODE_FLAT_INLINE);
 	erofs_off_t pos;
-	u64 chunknr;
 	int err = 0;
 
 	trace_erofs_map_blocks_enter(inode, map, 0);
@@ -116,13 +172,10 @@ int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map)
 	map->m_flags = 0;
 	if (map->m_la >= inode->i_size)
 		goto out;
-
-	if (vi->datalayout != EROFS_INODE_CHUNK_BASED) {
-		tailpacking = (vi->datalayout == EROFS_INODE_FLAT_INLINE);
-		if (!tailpacking && vi->startblk == EROFS_NULL_ADDR)
-			goto out;
-		pos = erofs_pos(sb, erofs_iblks(inode) - tailpacking);
-
+	if (vi->datalayout == EROFS_INODE_CHUNK_BASED) {
+		err = erofs_map_chunks(inode, map);
+	} else if (tailinline || vi->startblk != EROFS_NULL_ADDR) {
+		pos = erofs_pos(sb, erofs_iblks(inode) - tailinline);
 		map->m_flags = EROFS_MAP_MAPPED;
 		if (map->m_la < pos) {
 			map->m_pa = erofs_pos(sb, vi->startblk) + map->m_la;
@@ -132,57 +185,15 @@ int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map)
 				vi->xattr_isize + erofs_blkoff(sb, map->m_la);
 			map->m_llen = inode->i_size - map->m_la;
 			map->m_flags |= EROFS_MAP_META;
-		}
-		goto out;
-	}
-
-	if (vi->chunkformat & EROFS_CHUNK_FORMAT_INDEXES)
-		unit = sizeof(*idx);			/* chunk index */
-	else
-		unit = EROFS_BLOCK_MAP_ENTRY_SIZE;	/* block map */
-
-	chunknr = map->m_la >> vi->chunkbits;
-	pos = ALIGN(erofs_iloc(inode) + vi->inode_isize +
-		    vi->xattr_isize, unit) + unit * chunknr;
-
-	idx = erofs_read_metabuf(&buf, sb, pos, erofs_inode_in_metabox(inode));
-	if (IS_ERR(idx)) {
-		err = PTR_ERR(idx);
-		goto out;
-	}
-	map->m_la = chunknr << vi->chunkbits;
-	map->m_llen = min_t(erofs_off_t, 1UL << vi->chunkbits,
-			    round_up(inode->i_size - map->m_la, blksz));
-	if (vi->chunkformat & EROFS_CHUNK_FORMAT_INDEXES) {
-		addrmask = (vi->chunkformat & EROFS_CHUNK_FORMAT_48BIT) ?
-			BIT_ULL(48) - 1 : BIT_ULL(32) - 1;
-		startblk = (((u64)le16_to_cpu(idx->startblk_hi) << 32) |
-			    le32_to_cpu(idx->startblk_lo)) & addrmask;
-		if ((startblk ^ EROFS_NULL_ADDR) & addrmask) {
-			map->m_deviceid = le16_to_cpu(idx->device_id) &
-				EROFS_SB(sb)->device_id_mask;
-			map->m_pa = erofs_pos(sb, startblk);
-			map->m_flags = EROFS_MAP_MAPPED;
-		}
-	} else {
-		startblk = le32_to_cpu(*(__le32 *)idx);
-		if (startblk != (u32)EROFS_NULL_ADDR) {
-			map->m_pa = erofs_pos(sb, startblk);
-			map->m_flags = EROFS_MAP_MAPPED;
+			if (erofs_blkoff(sb, map->m_pa) + map->m_llen >
+			    sb->s_blocksize) {
+				erofs_err(sb, "inline data across blocks @ nid %llu", vi->nid);
+				return -EFSCORRUPTED;
+			}
 		}
 	}
-	erofs_put_metabuf(&buf);
 out:
-	if (!err) {
-		map->m_plen = map->m_llen;
-		/* inline data should be located in the same meta block */
-		if ((map->m_flags & EROFS_MAP_META) &&
-		    erofs_blkoff(sb, map->m_pa) + map->m_plen > blksz) {
-			erofs_err(sb, "inline data across blocks @ nid %llu", vi->nid);
-			DBG_BUGON(1);
-			return -EFSCORRUPTED;
-		}
-	}
+	map->m_plen = err ? 0 : map->m_llen;
 	trace_erofs_map_blocks_exit(inode, map, 0, err);
 	return err;
 }
-- 
2.43.5


