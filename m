Return-Path: <linux-erofs+bounces-2-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0C9A4DC18
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Mar 2025 12:12:36 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z6Y1Y5xXJz3blH;
	Tue,  4 Mar 2025 22:12:33 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=37.230.196.243
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741086390;
	cv=none; b=HZGurY3vZiY1vESVFvJq2fhqjGWtUyBRz1lWyiUMb6A1mubHTPJj4DT31FztF33zhBee+lL7zstq+oJiGdZZ+JJABh2OI0YyqX4tNS1Zti5KqtubMR3TPqccVHsZnTIuXU9WsprdpPk3Ce4h7/MnAG3ngzyqHK1p1NP1rrl59YFGEeGYypEVSTr024TKlbtN/MRHAZHDzw9nxHizcZtIumlZKVo5YarebhmCvNN9KuC5Q7cWpOlzg9cI4WUP9DU+t2bGafbICrNwFzTjDc/b6OvJWrOk6IkBCjP6ONjjClB8EH6WWuDEksHu/J9DwKUeip2jvHV/jNqZdp4BZ/PEEA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741086390; c=relaxed/relaxed;
	bh=20hwp9Ba6pVEpXG0zgFugroo/7I9gWMzkChfjMOl848=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=athKFhpyQk3JArkXE7malFITSKAq8+YV8zMq7SSaS0sJbn7ebXE51A/qffUGErgfeDNeH0utvkqoNJdhJRZzaqjD11syP62S/GGlHA7UJOUAoZKuqGKzQLHHHy+17mYoK/n8ZHZ6vH8AReMiHMyGAMx++nrEdAteIu7w5KprfetOPL1NFJ2L755lqr+LPSNTLlf13fMPgiZwMLNBFWy/qeSbXbOp3u2YFBg3tnSydATZYKobyEXGT4cdzVPDP9JlSZL4M1Lo4fRRodQ0+tB3A4qyHlj4nC6ICSHUzKLnDKOppaXfinNu7ZfdreWcf7n9iHoTkCmFxjgFnAH6TOng4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass (client-ip=37.230.196.243; helo=mail-gw01.astralinux.ru; envelope-from=apanov@astralinux.ru; receiver=lists.ozlabs.org) smtp.mailfrom=astralinux.ru
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=astralinux.ru (client-ip=37.230.196.243; helo=mail-gw01.astralinux.ru; envelope-from=apanov@astralinux.ru; receiver=lists.ozlabs.org)
Received: from mail-gw01.astralinux.ru (mail-gw01.astralinux.ru [37.230.196.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z6XtY0zmNz3blH
	for <linux-erofs@lists.ozlabs.org>; Tue,  4 Mar 2025 22:06:26 +1100 (AEDT)
Received: from gca-sc-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw01.astralinux.ru (Postfix) with ESMTP id 7D5C424D0E;
	Tue,  4 Mar 2025 14:06:20 +0300 (MSK)
Received: from new-mail.astralinux.ru (gca-yc-ruca-srv-mail04.astralinux.ru [10.177.185.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw01.astralinux.ru (Postfix) with ESMTPS;
	Tue,  4 Mar 2025 14:06:18 +0300 (MSK)
Received: from rbta-msk-lt-156703.astralinux.ru (unknown [10.177.20.114])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4Z6XtK5RJwzkX1m;
	Tue,  4 Mar 2025 14:06:17 +0300 (MSK)
From: Alexey Panov <apanov@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexey Panov <apanov@astralinux.ru>,
	Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	syzbot+c8c8238b394be4a1087d@syzkaller.appspotmail.com,
	lvc-project@linuxtesting.org,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	syzbot+4fc98ed414ae63d1ada2@syzkaller.appspotmail.com,
	syzbot+de04e06b28cfecf2281c@syzkaller.appspotmail.com
Subject: [PATCH v2 6.1 1/2] erofs: handle overlapped pclusters out of crafted images properly
Date: Tue,  4 Mar 2025 14:05:57 +0300
Message-Id: <20250304110558.8315-2-apanov@astralinux.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250304110558.8315-1-apanov@astralinux.ru>
References: <20250304110558.8315-1-apanov@astralinux.ru>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected, bases: 2025/03/04 09:15:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: apanov@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {Tracking_uf_ne_domains}, {Tracking_internal2}, {Tracking_from_domain_doesnt_match_to}, new-mail.astralinux.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;lore.kernel.org:7.1.1;127.0.0.199:7.1.2;astralinux.ru:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 191453 [Mar 04 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2025/03/04 09:41:00 #27591543
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2025/03/04 09:15:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org

From: Gao Xiang <hsiangkao@linux.alibaba.com>

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

Reported-by: syzbot+4fc98ed414ae63d1ada2@syzkaller.appspotmail.com
Reported-by: syzbot+de04e06b28cfecf2281c@syzkaller.appspotmail.com
Reported-by: syzbot+c8c8238b394be4a1087d@syzkaller.appspotmail.com
Tested-by: syzbot+4fc98ed414ae63d1ada2@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/0000000000002fda01061e334873@google.com
Fixes: 8e6c8fa9f2e9 ("erofs: enable big pcluster feature")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Link: https://lore.kernel.org/r/20240910070847.3356592-1-hsiangkao@linux.alibaba.com
[Alexey: This patch follows linux 6.6.y conflict resolution changes of
struct folio -> struct page]
Signed-off-by: Alexey Panov <apanov@astralinux.ru>
---
Backport fix for CVE-2024-47736
---
v2: Corrected patch comment about a minor fix. I mistakenly assessed
the significance of the changes relative to the backport from 6.6.y.

 fs/erofs/zdata.c | 59 +++++++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 28 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 94e9e0bf3bbd..ac01c0ede7f7 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1346,14 +1346,13 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
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
 
+		/*
+		 * The cached folio is still in managed cache but without
+		 * a valid `->private` pcluster hint.  Let's reconnect them.
+		 */
 		if (!PagePrivate(page)) {
 			/*
 			 * impossible to be !PagePrivate(page) for
@@ -1367,22 +1366,24 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
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
@@ -1536,16 +1537,11 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 		end = cur + pcl->pclusterpages;
 
 		do {
-			struct page *page;
-
-			page = pickup_page_for_submission(pcl, i++, pagepool,
-							  mc);
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
@@ -1554,6 +1550,13 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 				bio = NULL;
 			}
 
+			if (!page) {
+				page = pickup_page_for_submission(pcl, i++,
+						pagepool, mc);
+				if (!page)
+					continue;
+			}
+
 			if (unlikely(PageWorkingset(page)) && !memstall) {
 				psi_memstall_enter(&pflags);
 				memstall = 1;
@@ -1574,7 +1577,7 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 			}
 
 			if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE)
-				goto submit_bio_retry;
+				goto drain_io;
 
 			last_index = cur;
 			bypass = false;
-- 
2.39.5


