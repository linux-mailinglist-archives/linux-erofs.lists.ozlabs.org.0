Return-Path: <linux-erofs+bounces-3693-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nNMLJyw/OGpeaQcAu9opvQ
	(envelope-from <linux-erofs+bounces-3693-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sun, 21 Jun 2026 21:44:44 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2CF6AB857
	for <lists+linux-erofs@lfdr.de>; Sun, 21 Jun 2026 21:44:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=VE6XqAUH;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3693-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3693-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gk1xf0v31z2xQD;
	Mon, 22 Jun 2026 05:44:38 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782071078;
	cv=none; b=lvIiU40rRXEmBoFtUnkRjHdole569ZrPrGergiU26fW63t5xpBa1QWWS10ix4i1cVBVdv45JQ/NoHVhTptSoicVRw1J3+KEyHQWK6oTiN+p/2XvoSj+8XTK2t+izj6jDb7dGHETUe+/3PAvqx2yMfzhhObx0qqcJY53K6pkYloEfLdzq3oJaVPksBywul7R01Kfl2woY1yg/MM8OGbrrwIfWY9sTUj+QXDMc8toGbbqCoUMv5py/46T/vPT8g/iKF37Eoj28aPiWrkx4y4Zt9upPQCn6szcCwe1P5lYx1swoSiVx65DM2KWVwIt8XlcL7mNhArg822ko4MirjS+Chw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782071078; c=relaxed/relaxed;
	bh=R1UZcWbL1RbPDTCh+hQgusCuakzpaLeSYhzyIzqUZDw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sea9f3SCYPGvgRsRGJa8HLfRJq8ULnT40r6C25MFW1PectGZ/FiT2+5f8H9pNsyMgStR0abmaPntSRQ4OVG8nolKIZDI2lyhT6IFgF2hYqdGJ1eODGsJDcr7OFXmDlx07fYGobHpgbgbOKbf4xC/hQLZD6mQG5b+3EClNA6YZfsMxWgtjLwTKnBACH5vVHJM1ohsLn5kHvbZn8rCAoAgx6Swgrwd2WhXuWrMx6KIpkY2e7DNiu61Sdz1EidcN5lsKX/NtWR9qKgGgO9ShhBlllcCvp1yoop+SEFSA5aCMXzK43A9zCfiHiEH5M5T05SVO3sexvWGDIxbownzisvZCQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VE6XqAUH; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gk1xb2w6Yz2xPb
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Jun 2026 05:44:33 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782071068; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=R1UZcWbL1RbPDTCh+hQgusCuakzpaLeSYhzyIzqUZDw=;
	b=VE6XqAUH3h3bSVLzaIPxCfQnsEa3+P07/tQHnH5Jk8rudIslgo1xPYGgj/eSO/j3ZuCRB2fhMfN9cNJahyWc67m62wsszNqgqwqSRWBORUHtDcAXyCAQM9pydD1EpT6dgNrDnxbpd0/16HblHzMXpKtKD2BL6/pb2hU/YWOqA3s=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0X5FzGyt_1782071062;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X5FzGyt_1782071062 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 22 Jun 2026 03:44:27 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: oliver.yang@linux.alibaba.com,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: add sparse support to pcluster layout
Date: Mon, 22 Jun 2026 03:44:14 +0800
Message-ID: <20260621194414.489939-1-hsiangkao@linux.alibaba.com>
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
	TAGGED_FROM(0.00)[bounces-3693-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C2CF6AB857

Although zeros can be compressed transparently on EROFS using fixed-size
output compression so that it is never prioritized in the Android use
cases, indicating entire pclusters as holes is still useful to preserve
holes in the sparse datasets; otherwise overlayfs will allocate more
space when copying up, and SEEK_HOLE won't report any hole.

This patch introduces two ways to mark a pcluster as a hole:

 - A new Z_EROFS_LI_HOLE compatible flag (bit 14) in the HEAD lcluster
   advise field for non-compact (full) indexes;

 - A 0-block CBLKCNT value on the first NONHEAD lcluster.

The hole tag is preferred for maximum compatibility since pre-existing
kernels that do not understand Z_EROFS_LI_HOLE will decompress at the
stored blkaddr (the same blkaddr will be shared among all sparse
pclusters).  While the 0-block CBLKCNT approach also works for compact
indexes, it is limited to big pclusters and depends on a recent implied
behavior change (6.17+) out of commit 1a5223c182fd ("erofs: do sanity
check on m->type in z_erofs_load_compact_lcluster()").

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/erofs_fs.h |  2 ++
 fs/erofs/zmap.c     | 33 ++++++++++++++++++++++-----------
 2 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 7871b16c1d33..16ec4fd33ac6 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -396,6 +396,8 @@ enum {
 
 /* (noncompact only, HEAD) This pcluster refers to partial decompressed data */
 #define Z_EROFS_LI_PARTIAL_REF		(1 << 15)
+/* (noncompact only, HEAD) This pcluster can also be regarded as a HOLE */
+#define Z_EROFS_LI_HOLE			(1 << 14)
 
 /* Set on 1st non-head lcluster to store compressed block counti (in blocks) */
 #define Z_EROFS_LI_D0_CBLKCNT		(1 << 11)
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index e1a02a2c8406..bab521613552 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -15,8 +15,9 @@ struct z_erofs_maprecorder {
 	u8  type, headtype;
 	u16 clusterofs;
 	u16 delta[2];
-	erofs_blk_t pblk, compressedblks;
+	erofs_blk_t pblk;
 	erofs_off_t nextpackoff;
+	int compressedblks;
 	bool partialref, in_mbox;
 };
 
@@ -54,7 +55,12 @@ static int z_erofs_load_full_lcluster(struct z_erofs_maprecorder *m, u64 lcn)
 	} else {
 		m->partialref = !!(advise & Z_EROFS_LI_PARTIAL_REF);
 		m->clusterofs = le16_to_cpu(di->di_clusterofs);
-		m->pblk = le32_to_cpu(di->di_u.blkaddr);
+		if (advise & Z_EROFS_LI_HOLE) {
+			m->compressedblks = 0;
+			m->pblk = EROFS_NULL_ADDR;
+		} else {
+			m->pblk = le32_to_cpu(di->di_u.blkaddr);
+		}
 	}
 	return 0;
 }
@@ -309,9 +315,10 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 	    ((m->headtype == Z_EROFS_LCLUSTER_TYPE_PLAIN ||
 	      m->headtype == Z_EROFS_LCLUSTER_TYPE_HEAD2) && !bigpcl2) ||
 	    (lcn << vi->z_lclusterbits) >= inode->i_size)
-		m->compressedblks = 1;
+		if (m->compressedblks < 0)
+			m->compressedblks = 1;
 
-	if (m->compressedblks)
+	if (m->compressedblks >= 0)
 		goto out;
 
 	err = z_erofs_load_lcluster_from_disk(m, lcn, false);
@@ -329,19 +336,22 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 	DBG_BUGON(lcn == initial_lcn &&
 		  m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD);
 
-	if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD && m->delta[0] != 1) {
+	if (m->type != Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
+		/*
+		 * if the 1st NONHEAD lcluster is actually PLAIN or HEAD type
+		 * rather than CBLKCNT, it's a 1 block-sized pcluster.
+		 */
+		if (m->compressedblks < 0)
+			m->compressedblks = 1;
+	} else if (m->delta[0] != 1 || m->compressedblks < 0) {
 		erofs_err(sb, "bogus CBLKCNT @ lcn %llu of nid %llu", lcn, vi->nid);
 		DBG_BUGON(1);
 		return -EFSCORRUPTED;
 	}
 
-	/*
-	 * if the 1st NONHEAD lcluster is actually PLAIN or HEAD type rather
-	 * than CBLKCNT, it's a 1 block-sized pcluster.
-	 */
-	if (m->type != Z_EROFS_LCLUSTER_TYPE_NONHEAD || !m->compressedblks)
-		m->compressedblks = 1;
 out:
+	if (!m->compressedblks)
+		m->map->m_flags &= ~EROFS_MAP_MAPPED;
 	m->map->m_plen = erofs_pos(sb, m->compressedblks);
 	return 0;
 }
@@ -395,6 +405,7 @@ static int z_erofs_map_blocks_fo(struct inode *inode,
 		.inode = inode,
 		.map = map,
 		.in_mbox = erofs_inode_in_metabox(inode),
+		.compressedblks = -1,
 	};
 	unsigned int endoff;
 	unsigned long initial_lcn;
-- 
2.43.5


