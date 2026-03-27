Return-Path: <linux-erofs+bounces-3049-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Ar4BpwIxmkZFgUAu9opvQ
	(envelope-from <linux-erofs+bounces-3049-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Mar 2026 05:33:32 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B5433F1E0
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Mar 2026 05:33:30 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhnnz72J8z2xR4;
	Fri, 27 Mar 2026 15:33:27 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774586007;
	cv=none; b=TN/WxVFKmGhd0WHFIDpYVj5jwi3/F5uN+J1VTGmvEM5T7d5UBoH2c9IR7Dq0oLZyFAK9mmh5irAaNRp0yODO29MQzwBsA4jyaxbYBY2HqEVlqGLhVNB9JZxu7Sar7NUG1dMEkE4KUXg5otiQWcI1ji/skqLddiZyMmfDmLUVoFpCaqxj/6Vay3C6B9CdXfkHKwBbTTS8aJF3cNi4PFZ/XQhZhSGLHqDzCrHiV4xbdtkVWcKyFhxB/sIZ0dnnOk+2w1THu6jMKPMoLhQRSfJYGZvP+pb16ibNJ4Y6ABm0SVLg6yeJeieDKZ87jVAPfKvBb2soO83gkHaBKogaAA1muA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774586007; c=relaxed/relaxed;
	bh=qD5WGzY9SirQ9xlNJVoQqH4Rcm41JAwbu6EYRLwDR08=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bYUo6DhIEpxpYZhSsBTcZO1/r5bac4v7QavGQlADytdGKWf0CMz3hSNYZwmO3jSdwH/6PRpCrDdkawLlzFEeHWaRDUfsJKrDLVE0CkHiwgmswxjy3aWwbR+DTpneXEDBNDCN0xQ+DVd2xGSLtrS6U1yJAvbZseiEg1xuCIADuQ1zY58cBICK35GgyLat9ldPEWImjWiSxXpHr+HvOfrl5Q1PahVGzXSvjG5NNz7kurTcm+rkTTNbJ1PLcPt8Hgtl+6kYl712Fcx4RIHHq+cSzeOsd1wtv282lbSJci1SFkcI2cpeSeFtMx1QboaWineiSogmX4rWajSOSYRmeaucHg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=o8FlPOUh; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=o8FlPOUh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhnnx5BFVz2xHX
	for <linux-erofs@lists.ozlabs.org>; Fri, 27 Mar 2026 15:33:24 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774586000; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=qD5WGzY9SirQ9xlNJVoQqH4Rcm41JAwbu6EYRLwDR08=;
	b=o8FlPOUhj1/J9r/C/F9EyLyGWACp4S7LeQWVXu/RndYcVzPzmt3Ay2vmpbprLP3qq2uX/PtOAdORwkPtDztDRrzzXHSp3Lqzmxrqdod068sXl07fZYVSg9p+Z4GzHWLy5Ij+lxuBiQbz0cUrSj1qtk/34HutMEmVyrQNHJIWLOM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0X.mwfTV_1774585993;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.mwfTV_1774585993 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 27 Mar 2026 12:33:18 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-erofs@lists.ozlabs.org,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	syzbot+4fc98ed414ae63d1ada2@syzkaller.appspotmail.com,
	syzbot+de04e06b28cfecf2281c@syzkaller.appspotmail.com,
	syzbot+c8c8238b394be4a1087d@syzkaller.appspotmail.com,
	Alexey Panov <apanov@astralinux.ru>
Subject: [PATCH 6.1.y 1/2] erofs: handle overlapped pclusters out of crafted images properly
Date: Fri, 27 Mar 2026 12:33:12 +0800
Message-ID: <20260327043312.1118901-1-hsiangkao@linux.alibaba.com>
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
X-Spamd-Result: default: False [-6.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3049-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:linux-erofs@lists.ozlabs.org,m:hsiangkao@linux.alibaba.com,m:syzbot+4fc98ed414ae63d1ada2@syzkaller.appspotmail.com,m:syzbot+de04e06b28cfecf2281c@syzkaller.appspotmail.com,m:syzbot+c8c8238b394be4a1087d@syzkaller.appspotmail.com,m:apanov@astralinux.ru,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs,4fc98ed414ae63d1ada2,de04e06b28cfecf2281c,c8c8238b394be4a1087d];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid,alibaba.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: C9B5433F1E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit 9e2f9d34dd12e6e5b244ec488bcebd0c2d566c50 upstream.

syzbot reported a task hang issue due to a deadlock case where it is
waiting for the folio lock of a cached folio that will be used for
cache I/Os.

After looking into the crafted fuzzed image, I found it's formed with
several overlapped big pclusters as below:

 Ext:   logical offset   |  length :     physical offset    |  length
   0:        0..   16384 |   16384 :     151552..    167936 |   16384
   1:    16384..   32768 |   16384 :     155648..    172032 |   16384
   2:    32768..   49152 |   16384 :  537223168.. 537239552 |   16384
...

Here, extent 0/1 are physically overlapped although it's entirely
_impossible_ for normal filesystem images generated by mkfs.

First, managed folios containing compressed data will be marked as
up-to-date and then unlocked immediately (unlike in-place folios) when
compressed I/Os are complete.  If physical blocks are not submitted in
the incremental order, there should be separate BIOs to avoid dependency
issues.  However, the current code mis-arranges z_erofs_fill_bio_vec()
and BIO submission which causes unexpected BIO waits.

Second, managed folios will be connected to their own pclusters for
efficient inter-queries.  However, this is somewhat hard to implement
easily if overlapped big pclusters exist.  Again, these only appear in
fuzzed images so let's simply fall back to temporary short-lived pages
for correctness.

Additionally, it justifies that referenced managed folios cannot be
truncated for now and reverts part of commit 2080ca1ed3e4 ("erofs: tidy
up `struct z_erofs_bvec`") for simplicity although it shouldn't be any
difference.

[Alexey: This patch follows linux 6.6.y conflict resolution changes of
struct folio -> struct page]

Reported-by: syzbot+4fc98ed414ae63d1ada2@syzkaller.appspotmail.com
Reported-by: syzbot+de04e06b28cfecf2281c@syzkaller.appspotmail.com
Reported-by: syzbot+c8c8238b394be4a1087d@syzkaller.appspotmail.com
Tested-by: syzbot+4fc98ed414ae63d1ada2@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/0000000000002fda01061e334873@google.com
Fixes: 8e6c8fa9f2e9 ("erofs: enable big pcluster feature")
Link: https://lore.kernel.org/r/20240910070847.3356592-1-hsiangkao@linux.alibaba.com
Signed-off-by: Alexey Panov <apanov@astralinux.ru>
Link: https://lore.kernel.org/r/20250304110558.8315-2-apanov@astralinux.ru
Link: https://lore.kernel.org/r/20250304110558.8315-1-apanov@astralinux.ru
[ Gao Xiang: re-address the previous Alexey's backport. ]
CVE: CVE-2024-47736
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 60 ++++++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 28 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 5e6580217318..aa311aed0dd8 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1328,14 +1328,14 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
 		goto out;
 
 	lock_page(page);
-
-	/* only true if page reclaim goes wrong, should never happen */
-	DBG_BUGON(justfound && PagePrivate(page));
-
-	/* the page is still in manage cache */
-	if (page->mapping == mc) {
+	if (likely(page->mapping == mc)) {
 		WRITE_ONCE(pcl->compressed_bvecs[nr].page, page);
+		oldpage = page;
 
+		/*
+		 * The cached folio is still in managed cache but without
+		 * a valid `->private` pcluster hint.  Let's reconnect them.
+		 */
 		if (!PagePrivate(page)) {
 			/*
 			 * impossible to be !PagePrivate(page) for
@@ -1349,22 +1349,24 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
 			SetPagePrivate(page);
 		}
 
-		/* no need to submit io if it is already up-to-date */
-		if (PageUptodate(page)) {
-			unlock_page(page);
-			page = NULL;
+		if (likely(page->private == (unsigned long)pcl)) {
+			/* don't submit cache I/Os again if already uptodate */
+			if (PageUptodate(page)) {
+				unlock_page(page);
+				page = NULL;
+
+			}
+			goto out;
 		}
-		goto out;
+		/*
+		 * Already linked with another pcluster, which only appears in
+		 * crafted images by fuzzers for now.  But handle this anyway.
+		 */
+		tocache = false;	/* use temporary short-lived pages */
+	} else {
+		DBG_BUGON(1); /* referenced managed folios can't be truncated */
+		tocache = true;
 	}
-
-	/*
-	 * the managed page has been truncated, it's unsafe to
-	 * reuse this one, let's allocate a new cache-managed page.
-	 */
-	DBG_BUGON(page->mapping);
-	DBG_BUGON(!justfound);
-
-	tocache = true;
 	unlock_page(page);
 	put_page(page);
 out_allocpage:
@@ -1517,16 +1519,11 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 		end = cur + pcl->pclusterpages;
 
 		do {
-			struct page *page;
-
-			page = pickup_page_for_submission(pcl, i++,
-					&f->pagepool, mc);
-			if (!page)
-				continue;
+			struct page *page = NULL;
 
 			if (bio && (cur != last_index + 1 ||
 				    last_bdev != mdev.m_bdev)) {
-submit_bio_retry:
+drain_io:
 				submit_bio(bio);
 				if (memstall) {
 					psi_memstall_leave(&pflags);
@@ -1535,6 +1532,13 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 				bio = NULL;
 			}
 
+			if (!page) {
+				page = pickup_page_for_submission(pcl, i++,
+						&f->pagepool, mc);
+				if (!page)
+					continue;
+			}
+
 			if (unlikely(PageWorkingset(page)) && !memstall) {
 				psi_memstall_enter(&pflags);
 				memstall = 1;
@@ -1555,7 +1559,7 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 			}
 
 			if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE)
-				goto submit_bio_retry;
+				goto drain_io;
 
 			last_index = cur;
 			bypass = false;
-- 
2.43.5


