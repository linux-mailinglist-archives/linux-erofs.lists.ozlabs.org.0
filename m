Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B49619651
	for <lists+linux-erofs@lfdr.de>; Fri,  4 Nov 2022 13:36:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4N3g9G6SHlz3cLX
	for <lists+linux-erofs@lfdr.de>; Fri,  4 Nov 2022 23:36:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=cmpxchg-org.20210112.gappssmtp.com header.i=@cmpxchg-org.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=Xl+hI6yV;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cmpxchg.org (client-ip=2607:f8b0:4864:20::f30; helo=mail-qv1-xf30.google.com; envelope-from=hannes@cmpxchg.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=cmpxchg-org.20210112.gappssmtp.com header.i=@cmpxchg-org.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=Xl+hI6yV;
	dkim-atps=neutral
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4N3g98010wz3bb2
	for <linux-erofs@lists.ozlabs.org>; Fri,  4 Nov 2022 23:36:24 +1100 (AEDT)
Received: by mail-qv1-xf30.google.com with SMTP id u7so3056793qvn.13
        for <linux-erofs@lists.ozlabs.org>; Fri, 04 Nov 2022 05:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cVKzsOjD+sfLgtcPLOe8okSlSe7+hnLyI1SXbQlGr1s=;
        b=Xl+hI6yV80ad83IdDSuB/aAZDXDDtn9hvd1CvQ5JEBTksIXBr1kZXmSNNb7ySwqtI7
         kvMbnp37uOS5VKMbxbtkmYJb7K/sUSrwgu3y2xx3bnhWuhwSBTB9YLvzBjJRLzkgKtss
         Ntea5LBo9G+0s4G+Atso9Ic9O4yFGutuvMxIPPtaCrhqrzvw8n1+u/g4UGyIW3H05HVE
         hPTEeIpjbnwXFzlfYqY7Og/1pSVaIDW+TF5c34O+8s/rpfUIuYn9mfeCWXw40mRXEN5T
         Ub5FdredG/krZh1kJ8tevx4gvJi0SYth9FbNKWmNqXfG+0/czSiW9KkMSJcalWuINBcT
         i4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVKzsOjD+sfLgtcPLOe8okSlSe7+hnLyI1SXbQlGr1s=;
        b=IX/MQXPpcTgPaLztzbyFN8WoC5Sr+lCbw2UyDm1+bYNb0CcnMXn0Gd+6OTYevDfbse
         Wfw89M8Xsd3ljrxZENFxyE1BChdvkuMJOTf9xpEqpcU5a34C+AAhkQ5gzE5BQoucYE3q
         pjqfuApewGs75mQRkL8sMYSSJeA0+POP0EV2OBmXSsqtOiYpVWRuYhHK/+OKrEUVDDkZ
         1npnuTFcYTK6B+tLWgVfNCobe99ATA6VvovBJ7GdZbdsVTOp2w3TaM7KYykUai5PU6jC
         2OsLqTyxnyYzBjTb33i7OhqbgZzIHm8plcwjvPK3/fZIeobnysZ7tYC0rM9t7hmnRL4R
         sRWw==
X-Gm-Message-State: ACrzQf1eEOM6w+Yd+mher1NJzW6ZpsN1uotDI1jbZ1c/tRCCwNNI/1wI
	E7HRGFgVVEK76/kSbODkr/9d3A==
X-Google-Smtp-Source: AMsMyM7orsCm+qY2qjv712AQbMjBnLx3DSr7IJ18oQAMH2tDtnuRQlxFQq8bAy47Si3WY93+jqxrYA==
X-Received: by 2002:a05:6214:2601:b0:4bb:f5ef:998a with SMTP id gu1-20020a056214260100b004bbf5ef998amr24936059qvb.69.1667565380190;
        Fri, 04 Nov 2022 05:36:20 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::25f1])
        by smtp.gmail.com with ESMTPSA id m4-20020ac866c4000000b0039cc7ebf46bsm2302141qtp.93.2022.11.04.05.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 05:36:19 -0700 (PDT)
Date: Fri, 4 Nov 2022 08:36:22 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [REGESSION] systemd-oomd overreacting due to PSI changes for
 Btrfs (was: Re: [PATCH 3/5] btrfs: add manual PSI accounting for compressed
 reads)
Message-ID: <Y2UHRqthNUwuIQGS@cmpxchg.org>
References: <20220915094200.139713-1-hch@lst.de>
 <20220915094200.139713-4-hch@lst.de>
 <d20a0a85-e415-cf78-27f9-77dd7a94bc8d@leemhuis.info>
 <Y2Q+y8t9PV5nrjud@cmpxchg.org>
 <5f7bac77-c088-6fb7-ccb5-bef9267f7186@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f7bac77-c088-6fb7-ccb5-bef9267f7186@leemhuis.info>
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
Cc: Jens Axboe <axboe@kernel.dk>, "regressions@lists.linux.dev" <regressions@lists.linux.dev>, linux-mm@kvack.org, linux-erofs@lists.ozlabs.org, Thorsten Leemhuis <linux@leemhuis.info>, Matthew Wilcox <willy@infradead.org>, Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>, Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Nov 04, 2022 at 08:32:22AM +0100, Thorsten Leemhuis wrote:
> On 03.11.22 23:20, Johannes Weiner wrote:
> > Can you try this patch?
> 
> It apparently does the trick -- at least my test setup that usually
> triggers the bug within a minute or two survived for nearly an hour now, so:
> 
> Tested-by: Thorsten Leemhuis <linux@leemhuis.info>

Great, thanks Thorsten.

> Can you please also add this tag to help future archeologists, as
> explained by the kernel docs (for details see
> Documentation/process/submitting-patches.rst and
> Documentation/process/5.Posting.rst):
> 
> Link:
> https://lore.kernel.org/r/d20a0a85-e415-cf78-27f9-77dd7a94bc8d@leemhuis.info/
> 
> It also will make my regression tracking bot see further postings of
> this patch and mark the issue as resolved once the patch lands in mainline.

Done.

Looks like erofs has the same issue, I included a fix for that.

Andrew would you mind picking this up and sending it Linusward? Jens
routed the series originally, but I believe he is out today.

Thanks

From b668b261ed18105e91745f3d7676b6bca968476d Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Thu, 3 Nov 2022 17:34:31 -0400
Subject: [PATCH] fs: fix leaked psi pressure state

When psi annotations were added to to btrfs compression reads, the psi
state tracking over add_ra_bio_pages and btrfs_submit_compressed_read
was faulty. A pressure state, once entered, is never left. This
results in incorrectly elevated pressure, which triggers OOM kills.

pflags record the *previous* memstall state when we enter a new
one. The code tried to initialize pflags to 1, and then optimize the
leave call when we either didn't enter a memstall, or were already
inside a nested stall. However, there can be multiple PageWorkingset
pages in the bio, at which point it's that path itself that enters
repeatedly and overwrites pflags. This causes us to miss the exit.

Enter the stall only once if needed, then unwind correctly.

erofs has the same problem, fix that up too. And move the memstall
exit past submit_bio() to restore submit accounting originally added
by b8e24a9300b0 ("block: annotate refault stalls from IO submission").

Fixes: 4088a47e78f9 ("btrfs: add manual PSI accounting for compressed reads")
Fixes: 99486c511f68 ("erofs: add manual PSI accounting for the compressed address space")
Fixes: 118f3663fbc6 ("block: remove PSI accounting from the bio layer")
Link: https://lore.kernel.org/r/d20a0a85-e415-cf78-27f9-77dd7a94bc8d@leemhuis.info/
Reported-by: Thorsten Leemhuis <linux@leemhuis.info>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Tested-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 fs/btrfs/compression.c | 14 ++++++++------
 fs/erofs/zdata.c       | 18 +++++++++++-------
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index f1f051ad3147..e6635fe70067 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -512,7 +512,7 @@ static u64 bio_end_offset(struct bio *bio)
 static noinline int add_ra_bio_pages(struct inode *inode,
 				     u64 compressed_end,
 				     struct compressed_bio *cb,
-				     unsigned long *pflags)
+				     int *memstall, unsigned long *pflags)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	unsigned long end_index;
@@ -581,8 +581,10 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 			continue;
 		}
 
-		if (PageWorkingset(page))
+		if (!*memstall && PageWorkingset(page)) {
 			psi_memstall_enter(pflags);
+			*memstall = 1;
+		}
 
 		ret = set_page_extent_mapped(page);
 		if (ret < 0) {
@@ -670,8 +672,8 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	u64 em_len;
 	u64 em_start;
 	struct extent_map *em;
-	/* Initialize to 1 to make skip psi_memstall_leave unless needed */
-	unsigned long pflags = 1;
+	unsigned long pflags;
+	int memstall = 0;
 	blk_status_t ret;
 	int ret2;
 	int i;
@@ -727,7 +729,7 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 		goto fail;
 	}
 
-	add_ra_bio_pages(inode, em_start + em_len, cb, &pflags);
+	add_ra_bio_pages(inode, em_start + em_len, cb, &memstall, &pflags);
 
 	/* include any pages we added in add_ra-bio_pages */
 	cb->len = bio->bi_iter.bi_size;
@@ -807,7 +809,7 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 		}
 	}
 
-	if (!pflags)
+	if (memstall)
 		psi_memstall_leave(&pflags);
 
 	if (refcount_dec_and_test(&cb->pending_ios))
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index c7f24fc7efd5..064a166324a7 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1412,8 +1412,8 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 	struct block_device *last_bdev;
 	unsigned int nr_bios = 0;
 	struct bio *bio = NULL;
-	/* initialize to 1 to make skip psi_memstall_leave unless needed */
-	unsigned long pflags = 1;
+	unsigned long pflags;
+	int memstall = 0;
 
 	bi_private = jobqueueset_init(sb, q, fgq, force_fg);
 	qtail[JQ_BYPASS] = &q[JQ_BYPASS]->head;
@@ -1463,14 +1463,18 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 			if (bio && (cur != last_index + 1 ||
 				    last_bdev != mdev.m_bdev)) {
 submit_bio_retry:
-				if (!pflags)
-					psi_memstall_leave(&pflags);
 				submit_bio(bio);
+				if (memstall) {
+					psi_memstall_leave(&pflags);
+					memstall = 0;
+				}
 				bio = NULL;
 			}
 
-			if (unlikely(PageWorkingset(page)))
+			if (unlikely(PageWorkingset(page)) && !memstall) {
 				psi_memstall_enter(&pflags);
+				memstall = 1;
+			}
 
 			if (!bio) {
 				bio = bio_alloc(mdev.m_bdev, BIO_MAX_VECS,
@@ -1500,9 +1504,9 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 	} while (owned_head != Z_EROFS_PCLUSTER_TAIL);
 
 	if (bio) {
-		if (!pflags)
-			psi_memstall_leave(&pflags);
 		submit_bio(bio);
+		if (memstall)
+			psi_memstall_leave(&pflags);
 	}
 
 	/*
-- 
2.38.1

