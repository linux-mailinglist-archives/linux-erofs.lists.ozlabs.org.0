Return-Path: <linux-erofs+bounces-3363-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNCvJBI58GmbQAEAu9opvQ
	(envelope-from <linux-erofs+bounces-3363-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Apr 2026 06:35:30 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2A247D661
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Apr 2026 06:35:27 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g4SKR5dDnz2ynv;
	Tue, 28 Apr 2026 14:35:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777350923;
	cv=none; b=fhOMrW2Dl1amjJU99Y0BM1/WIZ4h0xA3yCcehMfXjTeQGHPof52R7aEBaIasYvrPzQsd5JJZfWqHDj3ZnzLQtLDO+qnf8X40tH/MM3M+ms8vDB697i685JjZ2hGUAKd0IU6jDpONmZ8yCpm3rgt7MKDHwNfWtplr5PrRt4pjMc6V6sPYkS5j7w7n8KArYyutlYSJ1rHZ+yUZ6b4qoRhXLvoBjI2F3KaaO2itMUUdskUlCs8Tz1hXW1Be9jVYfkKrdXNnhMyN44RAiaC6/USnOdx/gb+vsJKOShJ1VBLxKPRMkhUdtjXMA5OpwKkpWXXVsDk8UdXxCBcoSPzLyEX64w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777350923; c=relaxed/relaxed;
	bh=1HmIYKms2Pk20pKBvwG8hyZ867nq6aggCBcgiYGDzQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ap6GXOAcgLrMjLPkOSe/kPDq9L1C+Z1ErZPMeizNkT9DYScqb2+ARhDoOQAYpBh7LuY59fy6XTQSiqEIHvIMTEWPIV4jB8XjDXzCRu4xYZMCrz4IYTesx67iEVcsOSz8ou4i735kVqKhY2HQd875O/RSYUGhr4hVulJtlCoKtKO7bw8MSZREUyx98aIaCfCf5vAuBDyyJ/vqOqUGme8NvulzVC01qhrfiQeRFdCR6Bv7PeRkvgE3XD5m31RgCbPHLGevpir48l5dZiy3sLH9e0OSNwNVZMTj8WanMnVp4A9RDNvyHHc+IuBU5C1IxqrfKGPstrmySBQlmkQjUfEqoA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ALTzS4xb; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ALTzS4xb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g4SKN0pNDz2xYw
	for <linux-erofs@lists.ozlabs.org>; Tue, 28 Apr 2026 14:35:18 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1777350878; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=1HmIYKms2Pk20pKBvwG8hyZ867nq6aggCBcgiYGDzQM=;
	b=ALTzS4xbdAzeUp/sj1iCwXanRx2Ky6ZKuVL/M8j2Kd5RL021Y1/pwtqYAGrni+QdkIwTjshX2WkKgIRmmpiCH/dTO9clWCE6LLiGTc+wcQZ4hwx+8yE7fX4DCbOxk+MD0twJyHZfPXtSniJF/WXooH3YphJcx+BnlvwdsrwNhE4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0X1tOy73_1777350872;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X1tOy73_1777350872 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 28 Apr 2026 12:34:36 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Chao Yu <chao@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	kernel@salutedevices.com,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>
Subject: [PATCH] erofs: fix managed cache race for unaligned extents
Date: Tue, 28 Apr 2026 12:34:31 +0800
Message-ID: <20260428043431.1883069-1-hsiangkao@linux.alibaba.com>
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
X-Rspamd-Queue-Id: DF2A247D661
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-3363-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zbv.page:url,linux.alibaba.com:dkim,linux.alibaba.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]

After unaligned compressed extents were introduced, the following race
could occur:

[Thread 1]                                   [Thread 2]
(z_erofs_fill_bio_vec)
<handle a Z_EROFS_PREALLOCATED_FOLIO folio>
...
filemap_add_folio (1)
                                             (z_erofs_bind_cache)
                                             <the same folio is found..>
                                             ..
                                             ..
folio_attach_private (2)
                                             filemap_add_folio (3) again

Since (1) is executed but (2) hasn't been executed yet, it's possible
that another thread finds the same managed folio in z_erofs_bind_cache()
for a different pcluster and calls filemap_add_folio() again since
folio->private is still Z_EROFS_PREALLOCATED_FOLIO.

Fix this by explicitly clearing folio->private before making the folio
visible in the managed cache so that another pcluster can simply wait
on the locked managed folio as what we did for other shared cases [1].

This only impacts unaligned data compression (`-E48bit` with zstd,
for example).

[1] Commit 9e2f9d34dd12 ("erofs: handle overlapped pclusters out of
 crafted images properly") was originally introduced to handle crafted
 overlapped extents, but it addresses unaligned extents as well.

Fixes: 7361d1e3763b ("erofs: support unaligned encoded data")
Reported-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
Closes: https://lore.kernel.org/r/4a2f3801-fac1-42fe-ae75-da315822e088@salutedevices.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 8a0b15511931..6b647e75ec04 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1509,8 +1509,15 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
 	DBG_BUGON(z_erofs_is_shortlived_page(bvec->bv_page));
 
 	folio = page_folio(zbv.page);
-	/* For preallocated managed folios, add them to page cache here */
+	/*
+	 * Preallocated folios are added to the managed cache here rather than
+	 * in z_erofs_bind_cache() in order to keep these folios locked in
+	 * increasing (physical) address order.
+	 * Clear folio->private before these folios become visible to others in
+	 * the managed cache to avoid duplicate additions for unaligned extents.
+	 */
 	if (folio->private == Z_EROFS_PREALLOCATED_FOLIO) {
+		folio->private = NULL;
 		tocache = true;
 		goto out_tocache;
 	}
@@ -1546,14 +1553,8 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
 			}
 			return;
 		}
-		/*
-		 * Already linked with another pcluster, which only appears in
-		 * crafted images by fuzzers for now.  But handle this anyway.
-		 */
-		tocache = false;	/* use temporary short-lived pages */
 	} else {
 		DBG_BUGON(1); /* referenced managed folios can't be truncated */
-		tocache = true;
 	}
 	folio_unlock(folio);
 	folio_put(folio);
-- 
2.43.5


