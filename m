Return-Path: <linux-erofs+bounces-2649-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIF7N6EksWkOrQIAu9opvQ
	(envelope-from <linux-erofs+bounces-2649-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Mar 2026 09:15:29 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 86ED625EC6C
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Mar 2026 09:15:28 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fW3TV0L4Nz3dL8;
	Wed, 11 Mar 2026 19:15:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=222.66.158.135
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773216925;
	cv=none; b=QKQnyNHQfe2r1mU+G1jtcaQ49mIhVLxT/iT3QOrjKMviZxcVQhO3BdjIMdlHJkIlmV2CeqIE9ANjuV/oytxJPQv7LlCm2ieQSqXlXR7Nqn2cJqMlq6s3ZgS+FTIV9/mT/HDOHavyCBAg1lBasPH7JrelF4fHdVwxNJq6rnAgJxf2YKjsVNOH9lUvV27BsjdVXPhE2Fn8vNrWcRB5qvJL3IhMv2ESIu3usILjyzo0aktMH7tjKses7IlZ6oEPSPZWBK2zpG6ALYMHYpeY5NANJds/RqDN/UdZYlw1GCX96jBvtByb+VE+N/KsUtbBpgeqqNAk9Guyz2D+Ag8STBPgyg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773216925; c=relaxed/relaxed;
	bh=mn4JdX4cluuKDrNcVWcQTsjjpB/XUkaXo/Sbe9KLXD8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c4EdstjuDJzSx0RTeUO9GMbHHQRtl8GRpBgwsB+LdyHCu94EM1gtG3IbXdJVBfaFxDHX9sJk+qFS3ILHTE+5EIds2DnbsJOIRkDcrvQNOHRFar8B8epVbq1uvd0bMCRXv/tbpm+2llLQLS4Gy4qjlxy+xArzHx8YMsm1DyQ/BuBmNqYmSpNmXP22vL9PL2NZPfSI5P2PCEFAIu0Qsxl0NcEG3k083sXzBUnd1+8tXyKtyayhpRo4zgHIdfn7VG14Av7vDLk4tszfCcFLGaRSGG7UcrYv0Gur1paWr1HLy4xQMl5hEDtTFxsgCUENIlkzCj1Ho79eYWbg9HOxdZhFow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com; dkim=pass (2048-bit key; unprotected) header.d=unisoc.com header.i=@unisoc.com header.a=rsa-sha256 header.s=default header.b=CFOSnrFL; dkim-atps=neutral; spf=pass (client-ip=222.66.158.135; helo=shsqr01.spreadtrum.com; envelope-from=zhiguo.niu@unisoc.com; receiver=lists.ozlabs.org) smtp.mailfrom=unisoc.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=unisoc.com header.i=@unisoc.com header.a=rsa-sha256 header.s=default header.b=CFOSnrFL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=unisoc.com (client-ip=222.66.158.135; helo=shsqr01.spreadtrum.com; envelope-from=zhiguo.niu@unisoc.com; receiver=lists.ozlabs.org)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fW3TQ4j69z3d8y
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Mar 2026 19:15:18 +1100 (AEDT)
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 62B8DNcj076304;
	Wed, 11 Mar 2026 16:13:23 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (BJMBX02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4fW3Ph2NpFz2Nb3Wk;
	Wed, 11 Mar 2026 16:12:08 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Wed, 11 Mar 2026 16:13:21 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <stable@vger.kernel.org>, <gregkh@linuxfoundation.org>
CC: <niuzhiguo84@gmail.com>, <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>,
        <Hao_hao.Wang@unisoc.com>, <hsiangkao@linux.alibaba.com>,
        <linux-erofs@lists.ozlabs.org>
Subject: [PATCH 6.12.y v2] erofs: fix inline data read failure for ztailpacking pclusters
Date: Wed, 11 Mar 2026 16:14:29 +0800
Message-ID: <1773216869-2760-1-git-send-email-zhiguo.niu@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 62B8DNcj076304
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unisoc.com;
	s=default; t=1773216814;
	bh=mn4JdX4cluuKDrNcVWcQTsjjpB/XUkaXo/Sbe9KLXD8=;
	h=From:To:CC:Subject:Date;
	b=CFOSnrFL3A3XQ/cECBJWPmdEws68MXp8bduxeqq2RrttaEVB6ghEuQ4WDxt2J0SZT
	 Qou8ZYwYD08/P+vE5HgxolwqRVdeINYwvjnrhkXmOCMuct5IzmFc4Im9TOD+1frzZl
	 MwI9KIw9Vli98oN0MDvv2JTWOb17C/ogwdi6MPNor9WzZ886yCmS3GSreJvb56tpzy
	 P+Biputup0U+iK/z0xQQhLM7b8Ay5wFQb12OwkQG2hBX2rcAsnOWBoRHQd2zCTm2pe
	 hodkxjiGvkakGCPUQjo1WeiOgzHnM+eGilFr7pXzwxmH4uo9iFPCub+Dg1+9LAh3vW
	 AdBmJtFyuNpVA==
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 86ED625EC6C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[unisoc.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[unisoc.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2649-lists,linux-erofs=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,unisoc.com,linux.alibaba.com,lists.ozlabs.org];
	RCVD_COUNT_FIVE(0.00)[5];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:niuzhiguo84@gmail.com,m:zhiguo.niu@unisoc.com,m:ke.wang@unisoc.com,m:Hao_hao.Wang@unisoc.com,m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[zhiguo.niu@unisoc.com,linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[zhiguo.niu@unisoc.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	HAS_XOIP(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[unisoc.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,lists.ozlabs.org:rdns,lists.ozlabs.org:helo,unisoc.com:dkim,unisoc.com:email,unisoc.com:mid]
X-Rspamd-Action: no action

From: Gao Xiang <hsiangkao@linux.alibaba.com>

[ Upstream commit c134a40f86efb8d6b5a949ef70e06d5752209be5 ]

Compressed folios for ztailpacking pclusters must be valid before adding
these pclusters to I/O chains. Otherwise, z_erofs_decompress_pcluster()
may assume they are already valid and then trigger a NULL pointer
dereference.

It is somewhat hard to reproduce because the inline data is in the same
block as the tail of the compressed indexes, which are usually read just
before. However, it may still happen if a fatal signal arrives while
read_mapping_folio() is running, as shown below:

 erofs: (device dm-1): z_erofs_pcluster_begin: failed to get inline data -4
 Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008

 ...

 pc : z_erofs_decompress_queue+0x4c8/0xa14
 lr : z_erofs_decompress_queue+0x160/0xa14
 sp : ffffffc08b3eb3a0
 x29: ffffffc08b3eb570 x28: ffffffc08b3eb418 x27: 0000000000001000
 x26: ffffff8086ebdbb8 x25: ffffff8086ebdbb8 x24: 0000000000000001
 x23: 0000000000000008 x22: 00000000fffffffb x21: dead000000000700
 x20: 00000000000015e7 x19: ffffff808babb400 x18: ffffffc089edc098
 x17: 00000000c006287d x16: 00000000c006287d x15: 0000000000000004
 x14: ffffff80ba8f8000 x13: 0000000000000004 x12: 00000006589a77c9
 x11: 0000000000000015 x10: 0000000000000000 x9 : 0000000000000000
 x8 : 0000000000000000 x7 : 0000000000000000 x6 : 000000000000003f
 x5 : 0000000000000040 x4 : ffffffffffffffe0 x3 : 0000000000000020
 x2 : 0000000000000008 x1 : 0000000000000000 x0 : 0000000000000000
 Call trace:
  z_erofs_decompress_queue+0x4c8/0xa14
  z_erofs_runqueue+0x908/0x97c
  z_erofs_read_folio+0x128/0x228
  filemap_read_folio+0x68/0x128
  filemap_get_pages+0x44c/0x8b4
  filemap_read+0x12c/0x5b8
  generic_file_read_iter+0x4c/0x15c
  do_iter_readv_writev+0x188/0x1e0
  vfs_iter_read+0xac/0x1a4
  backing_file_read_iter+0x170/0x34c
  ovl_read_iter+0xf0/0x140
  vfs_read+0x28c/0x344
  ksys_read+0x80/0xf0
  __arm64_sys_read+0x24/0x34
  invoke_syscall+0x60/0x114
  el0_svc_common+0x88/0xe4
  do_el0_svc+0x24/0x30
  el0_svc+0x40/0xa8
  el0t_64_sync_handler+0x70/0xbc
  el0t_64_sync+0x1bc/0x1c0

Fix this by reading the inline data before allocating and adding
the pclusters to the I/O chains.

Fixes: cecf864d3d76 ("erofs: support inline data decompression")
Reported-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Reviewed-and-tested-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
v2: align with upstream var naming,code order,error report
---
 fs/erofs/zdata.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 7116f20..6e369d1 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -787,6 +787,7 @@ static int z_erofs_pcluster_begin(struct z_erofs_frontend *fe)
 	struct super_block *sb = fe->inode->i_sb;
 	erofs_blk_t blknr = erofs_blknr(sb, map->m_pa);
 	struct z_erofs_pcluster *pcl = NULL;
+	void *ptr = NULL;
 	int ret;
 
 	DBG_BUGON(fe->pcl);
@@ -807,6 +808,14 @@ static int z_erofs_pcluster_begin(struct z_erofs_frontend *fe)
 	} else if ((map->m_pa & ~PAGE_MASK) + map->m_plen > PAGE_SIZE) {
 		DBG_BUGON(1);
 		return -EFSCORRUPTED;
+	} else {
+		ptr = erofs_read_metabuf(&map->buf, sb, map->m_pa, EROFS_NO_KMAP);
+		if (IS_ERR(ptr)) {
+			erofs_err(sb, "failed to read inline data %pe @ pa %llu of nid %llu",
+				  ptr, map->m_pa, EROFS_I(fe->inode)->nid);
+			return PTR_ERR(ptr);
+		}
+		ptr = map->buf.page;
 	}
 
 	if (pcl) {
@@ -836,16 +845,8 @@ static int z_erofs_pcluster_begin(struct z_erofs_frontend *fe)
 		/* bind cache first when cached decompression is preferred */
 		z_erofs_bind_cache(fe);
 	} else {
-		void *mptr;
-
-		mptr = erofs_read_metabuf(&map->buf, sb, map->m_pa, EROFS_NO_KMAP);
-		if (IS_ERR(mptr)) {
-			ret = PTR_ERR(mptr);
-			erofs_err(sb, "failed to get inline data %d", ret);
-			return ret;
-		}
-		get_page(map->buf.page);
-		WRITE_ONCE(fe->pcl->compressed_bvecs[0].page, map->buf.page);
+		get_page((struct page *)ptr);
+		WRITE_ONCE(fe->pcl->compressed_bvecs[0].page, ptr);
 		fe->pcl->pageofs_in = map->m_pa & ~PAGE_MASK;
 		fe->mode = Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE;
 	}
-- 
1.9.1


