Return-Path: <linux-erofs+bounces-2332-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNQnO3mblWmsSgIAu9opvQ
	(envelope-from <linux-erofs+bounces-2332-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Feb 2026 11:59:05 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6F2155B8C
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Feb 2026 11:59:03 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fGD5r3CNTz2xlq;
	Wed, 18 Feb 2026 21:58:56 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771412336;
	cv=none; b=g9PtfDl18HJaOEmIRKwxbUiR7TUeqXg8oA66ziz9dITgxNpVFpVelZbSk3hyEHDElTcZXW616JILGNihcC/BajuYDfgaQc5y/km9J3HXjNTswo8f6vuVPcm98sAK5H2hEjcJembVdHmfcfDmE1QBz+lmw5QxVOttXX9mmCS/H9QwrJIPBIFOfm6E5Br1edq9b2lVUDhSWqJVk8gnoUox0mnhnYdoGJRc0FBYoN2Avg8d5cLLK4kMpUBe17Iws3NiHvBzdekmuwyd4LKL5OdUB9UQhpV7PO6N+QMdUXFxR/LcgWJMFVEBVBFnpZkjDui71oV3J3TMOQyElPaEiMAypQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771412336; c=relaxed/relaxed;
	bh=6FSbbUmT0kW9FrFKAQgMm0DpM0xB9BuAVHu/pEXcjQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IJskhV9POH9Xz0RHJJR1yqv6vLxEKREgaXSwQfcTOeUHoWFRexLkQBSPUBnBqUZWiyO97fBIUANJ2Srj+2rq8sw2Hcd7kbNfKbPflMtpVr49qQDTa9mzsi6B++dzLQue2FOqLTB16z2oGHgw8qghefyAyaBC2IU9PH8dychXow5aAEyn7JJSQ0yxGCKdlf7Ii8s+cQk52IYYPlEJN7flqV96fJ759sU4ftjU0VIrFZREqhgODSGx7jFpES6V5ldvhu81iBwszNZYYqI/QgE+6GDKRBu4cFRthERR8zwCCGuZrNazwEYrANjPLeqYtr0ktkQBNotNxf1rC7tUpYiA0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MmFgL2Oy; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MmFgL2Oy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fGD5p27dhz2x99
	for <linux-erofs@lists.ozlabs.org>; Wed, 18 Feb 2026 21:58:52 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1771412327; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=6FSbbUmT0kW9FrFKAQgMm0DpM0xB9BuAVHu/pEXcjQc=;
	b=MmFgL2OyoOAzIGMMQy9soeX3E6aoqLbhyNK/vFeBlu9Yfy0Sl+83Dt9pX9BM0r8U74qxCa11d845lRX2THsPHtfkUajJh5w8sW07sZ8XfZaAcxfiV08IdhsIEnpfvndL4m6VLghBjVNyFyqzktniwBD0Ah2wVrCdDJMD8F2wi6I=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WzSQDEH_1771412322 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 18 Feb 2026 18:58:46 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: oliver.yang@linux.alibaba.com,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: lib: set `bh->op` immediately for compressed buffers
Date: Wed, 18 Feb 2026 18:58:41 +0800
Message-ID: <20260218105841.100916-1-hsiangkao@linux.alibaba.com>
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
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2332-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: CF6F2155B8C
X-Rspamd-Action: no action

This fixes the following SIGSEGV that occurs when compression fails:

in __erofs_bflush (bmgr=0x7ffff695c010, bb=0x0, abort=true) at cache.c:482
482                             ret = bh->op->flush(bh, abort);
 0  0x0000000000413860 in __erofs_bflush (bmgr=0x7ffff695c010, bb=0x0, abort=true) at cache.c:482
 1  0x0000000000413cbe in erofs_buffer_exit (bmgr=0x7ffff695c010) at cache.c:549
 2  0x0000000000414f72 in erofs_put_super (sbi=0x493270 <g_sbi>) at super.c:193
 3  0x000000000040718d in main (argc=6, argv=0x7fffffffd628) at main.c:2165

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/compress.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index 995bc602b145..7e8142a48ae5 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -1388,12 +1388,10 @@ int erofs_commit_compressed_file(struct z_erofs_compress_ictx *ictx,
 	erofs_info("compressed %s (%llu bytes) into %llu bytes",
 		   inode->i_srcpath, inode->i_size | 0ULL, ptotal | 0ULL);
 
-	if (inode->idata_size) {
-		bh->op = &erofs_skip_write_bhops;
+	if (inode->idata_size)
 		inode->bh_data = bh;
-	} else {
+	else
 		erofs_bdrop(bh, false);
-	}
 
 	inode->u.i_blocks = BLK_ROUND_UP(sbi, ptotal);
 
@@ -1690,7 +1688,7 @@ int erofs_mt_write_compressed_file(struct z_erofs_compress_ictx *ictx)
 		ret = PTR_ERR(bh);
 		goto out;
 	}
-
+	bh->op = &erofs_skip_write_bhops;
 	DBG_BUGON(!head);
 	pstart = erofs_pos(sbi, erofs_mapbh(NULL, bh->block));
 
@@ -1985,6 +1983,7 @@ int erofs_write_compressed_file(struct z_erofs_compress_ictx *ictx)
 		ret = PTR_ERR(bh);
 		goto err_free_idata;
 	}
+	bh->op = &erofs_skip_write_bhops;
 	pstart = erofs_pos(sbi, erofs_mapbh(NULL, bh->block));
 
 	ictx->seg_num = 1;
-- 
2.43.5


