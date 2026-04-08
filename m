Return-Path: <linux-erofs+bounces-3226-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NclIKJY1mlJEAgAu9opvQ
	(envelope-from <linux-erofs+bounces-3226-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 08 Apr 2026 15:31:14 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D193BCF25
	for <lists+linux-erofs@lfdr.de>; Wed, 08 Apr 2026 15:31:13 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frP8t0Dpfz2yj1;
	Wed, 08 Apr 2026 23:31:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775655069;
	cv=none; b=W7Di2/bz312B7TXJ35LWyrSnRP8e09KkcUwAW6YcQoUN+itOp2pb7LyrxlCMsvhbGFSonuMfiNnsPkcMybl6ObqgiXtSwVeKlFBLtz0sflEUiaAEFxIx1UY+YM15sDSXpIQId303epWGtLRQwUE3bJ/lRyhx/F1Dp87nQ7mvDbwMDLiyEetu0eESKvB1tC5y8oM4OAcXz2eg1fvtZ/Zts/+Wjw/DLzUJAVZW+qV5lANmu0KU6RoScbT1fZ0bQScoqyUw1URLhdbpnEI1U3ov5A6Mz+wDZ4qpB+8SwqBfxuzNcysJ3fyZgHsEOU4DgGNP+ySNFBCf/mv9rw8jWjDPJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775655069; c=relaxed/relaxed;
	bh=OfuVzvZ+klOUos2wh1pnrOMLwREVGpFBha75A9aX/14=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=TGvBcutJ7pGUUKjATyux++tAfbRWl332RC1v8WjnWv/ov+U3lubPbm394a8u7amNJ0uMLifHX319M+ymwqF0A0z4AnEOKEY+7BCJ50zJXUgzinzGx68cUg50W9PDNgmU/lLuwnOui1MaPj/f3rlO/4EVSW6tt8EG0LGpCwjQkdXIUAwyTfDIa8QsoatqA2mbKONQcsUg8NDPV2YsHQCdsbeubG6x/Aw/4DrHXwm7R4+kpfCKNudcwjAnt9tKn0lLQOBgdOoWZPx9kCx28EAs8uS+s2QUAcKQjwc9BYPwdhJ8uXj2oW/zL3U7SFRRVSckVS5L829HPTNRxeaGu7ewWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=GHyN3pa2; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=GHyN3pa2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frP8s1KJyz2xc8
	for <linux-erofs@lists.ozlabs.org>; Wed, 08 Apr 2026 23:31:09 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id F20CA4437F;
	Wed,  8 Apr 2026 13:31:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849F6C19421;
	Wed,  8 Apr 2026 13:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775655066;
	bh=7c/YbjPcJt4NtvqE8fB3ooJkxvq54uKAXRdk+MVuy0o=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=GHyN3pa2BwwIjcMY9t/u/witje+ePTvA56grQETaPZXe/CBbXODHknkhoN2YJuZ/N
	 83oNa9JQC8l6hpdo9hgWPP9fZyiT3CBe0SrVg50gPwfvxuYVch7gm4fzofLCHU7Ocp
	 WCmGUfCYQ0ziw2Ig7Rgl7bwWAmX48qOthOAabAUU=
Subject: Patch "erofs: handle overlapped pclusters out of crafted images properly" has been added to the 6.1-stable tree
To: apanov@astralinux.ru,gregkh@linuxfoundation.org,hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org,syzbot+4fc98ed414ae63d1ada2@syzkaller.appspotmail.com,syzbot+c8c8238b394be4a1087d@syzkaller.appspotmail.com,syzbot+de04e06b28cfecf2281c@syzkaller.appspotmail.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 08 Apr 2026 15:30:51 +0200
In-Reply-To: <20260327043312.1118901-1-hsiangkao@linux.alibaba.com>
Message-ID: <2026040851-tubular-devouring-a7c9@gregkh>
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
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [3.80 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3226-lists,linux-erofs=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-erofs@lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS(0.00)[m:apanov@astralinux.ru,m:gregkh@linuxfoundation.org,m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:syzbot+4fc98ed414ae63d1ada2@syzkaller.appspotmail.com,m:syzbot+c8c8238b394be4a1087d@syzkaller.appspotmail.com,m:syzbot+de04e06b28cfecf2281c@syzkaller.appspotmail.com,m:stable-commits@vger.kernel.org,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs,4fc98ed414ae63d1ada2,c8c8238b394be4a1087d,de04e06b28cfecf2281c];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,ozlabs.org:email,alibaba.com:email,appspotmail.com:email]
X-Rspamd-Queue-Id: A7D193BCF25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


This is a note to let you know that I've just added the patch titled

    erofs: handle overlapped pclusters out of crafted images properly

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     erofs-handle-overlapped-pclusters-out-of-crafted-images-properly.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-230583-greg=kroah.com@vger.kernel.org Fri Mar 27 05:33:33 2026
From: Gao Xiang <hsiangkao@linux.alibaba.com>
Date: Fri, 27 Mar 2026 12:33:12 +0800
Subject: erofs: handle overlapped pclusters out of crafted images properly
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-erofs@lists.ozlabs.org, Gao Xiang <hsiangkao@linux.alibaba.com>, syzbot+4fc98ed414ae63d1ada2@syzkaller.appspotmail.com, syzbot+de04e06b28cfecf2281c@syzkaller.appspotmail.com, syzbot+c8c8238b394be4a1087d@syzkaller.appspotmail.com, Alexey Panov <apanov@astralinux.ru>
Message-ID: <20260327043312.1118901-1-hsiangkao@linux.alibaba.com>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/erofs/zdata.c |   60 +++++++++++++++++++++++++++++--------------------------
 1 file changed, 32 insertions(+), 28 deletions(-)

--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1331,14 +1331,14 @@ repeat:
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
@@ -1352,22 +1352,24 @@ repeat:
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
@@ -1520,16 +1522,11 @@ static void z_erofs_submit_queue(struct
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
@@ -1538,6 +1535,13 @@ submit_bio_retry:
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
@@ -1558,7 +1562,7 @@ submit_bio_retry:
 			}
 
 			if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE)
-				goto submit_bio_retry;
+				goto drain_io;
 
 			last_index = cur;
 			bypass = false;


Patches currently in stable-queue which might be from hsiangkao@linux.alibaba.com are

queue-6.1/erofs-fix-psi-memstall-accounting.patch
queue-6.1/erofs-add-gfp_noio-in-the-bio-completion-if-needed.patch
queue-6.1/erofs-handle-overlapped-pclusters-out-of-crafted-images-properly.patch
queue-6.1/erofs-fix-the-slab-out-of-bounds-in-drop_buffers.patch

