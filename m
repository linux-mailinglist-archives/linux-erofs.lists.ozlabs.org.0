Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A50A49FA6
	for <lists+linux-erofs@lfdr.de>; Fri, 28 Feb 2025 18:01:54 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z4DyR3VTSz3cTs
	for <lists+linux-erofs@lfdr.de>; Sat,  1 Mar 2025 04:01:51 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=37.230.196.243
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740762108;
	cv=none; b=WxnjF9sKVoBM7kYcjYK/U/vLWnPxCsFSEP4ZDQfHq2J2oWw/33y3hxTF1pfvgAuKJexF2U8PuCnNVYr/3tFM5hImW7XPXQ2Y9FLrEEm2mw11Rd28/7O3nLpHhvL+Ili8PQZB13bAxH9L2zIBEnQ7VJO83+XVi50lfskBEnR0H1q+KZdY2+TkTkTnZchKmzbZqPhEVW/qkLn1+6SEd8WblPm2MSytof+QCjCSc6KpfhhhwqFuZDv+C4Bg933ZO09/d0Fh+uA/Zn/6rpYPnjTiYbhLDVu10nWQSbDfy5uEtI4vypCRJA85hWxZc6NcQyDTAC4x//JwUJfpCZIqeziXQA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740762108; c=relaxed/relaxed;
	bh=Vb9lsEGHmGaSFj7wHypaKae6L2UpKwYUm1zJtAEnI8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SufJB96NCYWY7e3w+iSD+9z26DRA07w8/U2ZFN4E+R9iv1KpPckmhAVvEDgjULLLrBtW3ykSR46R5q2NponEupV+wCdpcZzh4XA2M5A9MzEkVVeTurEO1frvyq4P/EZ54XCtSAxYtOr+ZSJOmnzWRbvaYx7xDFeaVzyxMdf7iCewOsc/RfGB0CV39f8+uJZOkF1idVKgTiZ84ucclCzj8Xj2vqmTlx8III+fI9kyIjjCXu399oKkXUPIK8sPOxf40Xop7uxyeu2yQLvANCxdAD9XAVhKeFE3dRuEjCQRqwVFIWVXk9qIgh7rog6mxF0hhKQEBFu5Ype/m3QaUhMLww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass (client-ip=37.230.196.243; helo=mail-gw01.astralinux.ru; envelope-from=apanov@astralinux.ru; receiver=lists.ozlabs.org) smtp.mailfrom=astralinux.ru
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=astralinux.ru (client-ip=37.230.196.243; helo=mail-gw01.astralinux.ru; envelope-from=apanov@astralinux.ru; receiver=lists.ozlabs.org)
Received: from mail-gw01.astralinux.ru (mail-gw01.astralinux.ru [37.230.196.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z4DyM3jLZz3brB
	for <linux-erofs@lists.ozlabs.org>; Sat,  1 Mar 2025 04:01:47 +1100 (AEDT)
Received: from gca-sc-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw01.astralinux.ru (Postfix) with ESMTP id 3234324C08;
	Fri, 28 Feb 2025 19:51:51 +0300 (MSK)
Received: from new-mail.astralinux.ru (gca-yc-ruca-srv-mail03.astralinux.ru [10.177.185.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw01.astralinux.ru (Postfix) with ESMTPS;
	Fri, 28 Feb 2025 19:51:50 +0300 (MSK)
Received: from rbta-msk-lt-156703.astralinux.ru (unknown [10.177.20.117])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4Z4Dks6cCrz1h0PW;
	Fri, 28 Feb 2025 19:51:49 +0300 (MSK)
From: Alexey Panov <apanov@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.1 1/2] erofs: handle overlapped pclusters out of crafted images properly
Date: Fri, 28 Feb 2025 19:51:02 +0300
Message-Id: <20250228165103.26775-2-apanov@astralinux.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250228165103.26775-1-apanov@astralinux.ru>
References: <20250228165103.26775-1-apanov@astralinux.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected, bases: 2025/02/28 15:31:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: apanov@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {Tracking_uf_ne_domains}, {Tracking_internal2}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;astralinux.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;new-mail.astralinux.ru:7.1.1;lore.kernel.org:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 191391 [Feb 28 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2025/02/28 06:44:00 #27492638
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2025/02/28 15:31:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: Max Kellermann <max.kellermann@ionos.com>, lvc-project@linuxtesting.org, syzbot+de04e06b28cfecf2281c@syzkaller.appspotmail.com, syzbot+c8c8238b394be4a1087d@syzkaller.appspotmail.com, Chao Yu <chao@kernel.org>, linux-kernel@vger.kernel.org, Alexey Panov <apanov@astralinux.ru>, Yue Hu <huyue2@coolpad.com>, syzbot+4fc98ed414ae63d1ada2@syzkaller.appspotmail.com, Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

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
[Alexey: minor fix to resolve merge conflict]
Signed-off-by: Alexey Panov <apanov@astralinux.ru>
---
Backport fix for CVE-2024-47736

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

