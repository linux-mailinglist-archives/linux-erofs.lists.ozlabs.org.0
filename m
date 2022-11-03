Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3720C618B4F
	for <lists+linux-erofs@lfdr.de>; Thu,  3 Nov 2022 23:21:12 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4N3JBG054Lz3cLT
	for <lists+linux-erofs@lfdr.de>; Fri,  4 Nov 2022 09:21:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=cmpxchg-org.20210112.gappssmtp.com header.i=@cmpxchg-org.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=R6DRBzl5;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cmpxchg.org (client-ip=2607:f8b0:4864:20::731; helo=mail-qk1-x731.google.com; envelope-from=hannes@cmpxchg.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=cmpxchg-org.20210112.gappssmtp.com header.i=@cmpxchg-org.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=R6DRBzl5;
	dkim-atps=neutral
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4N3JB61y7mz3bjJ
	for <linux-erofs@lists.ozlabs.org>; Fri,  4 Nov 2022 09:21:00 +1100 (AEDT)
Received: by mail-qk1-x731.google.com with SMTP id z1so2100188qkl.9
        for <linux-erofs@lists.ozlabs.org>; Thu, 03 Nov 2022 15:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pMN0/mJYGvzCnOyvxtCJFIOn1RUzuH2afiVlhl8BJN8=;
        b=R6DRBzl5D7PmTiScz2q1QNrg5S/EVTQpn+C3LtM9SKPmz5cwA30hjj2kpsgOy9eZIa
         Myw7XsEbkbNfN0tnrvY0/O563gK9D+y0wMqMrdjnsBy6lIZVn7MiXBaIMIsfDB704urv
         fKP6U3VmiAXsIfqSTLdzXkih52xtbr96MBMR/pC7TTRGId/3MknjV3tU1EVNPCIn4xKI
         5YLvUn4crDDl0m7eR8kbF5vfBiHAe6I525XruQUlEH0EePJhA5MXVI/wGhUDlxBRV30O
         ADJH+Df8LJaWzNuMWaZamm1CxC0v1ci3yBoZFfYZv15out2MFkOVyQqJ5huIDjV9OnHg
         vosg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pMN0/mJYGvzCnOyvxtCJFIOn1RUzuH2afiVlhl8BJN8=;
        b=a3u1SLVRmG5c0ERpmv3WMEzsgZGI7M0aENHAzBCucyzfn5TGXDAPQNqTMCaYsNMfYH
         b2PQAMXN9ZfyCJqzQ5g0/Vo7/PIBdYo26WGGjFDor29M0rqNFlZss5ckgIb7SswVff1U
         A3n0yMDaBw6q6XrKwPtrxDAMDN8E7WemDgKTJb3L9RW0jbuijGdWq23faVgBjgNUfZ+8
         TBT3+C0aUovaUX06c3RZlUEp7MBDCOxRZnc90qj4pL07s3eo2OLpCYCIWQOc/4KQFRba
         ZIydwVI4P0v2xQhijIV4ooRfVrrufXt3oj8SRRxsu8KLxRvMwjQzuw4lnrujc+eqcf49
         Ek9A==
X-Gm-Message-State: ACrzQf3MnRzeAa8Q63oEFzc+1d/VoFo77+IdMUzRvZijEpC/xlZXLj9o
	mmYFmnTEG0gj4oI4uQO9Lo+6XQ==
X-Google-Smtp-Source: AMsMyM6xZDCV9zQJtAhUoSH5ufgDptRZU0dKTD699bnK6iH5NnhZ73hquRFyFxv1/SpheHjZZuwKeg==
X-Received: by 2002:a05:620a:152e:b0:6fa:3cb8:dd9c with SMTP id n14-20020a05620a152e00b006fa3cb8dd9cmr15550460qkk.82.1667514057172;
        Thu, 03 Nov 2022 15:20:57 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::25f1])
        by smtp.gmail.com with ESMTPSA id x18-20020a05620a259200b006bc192d277csm1559048qko.10.2022.11.03.15.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 15:20:56 -0700 (PDT)
Date: Thu, 3 Nov 2022 18:20:59 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [REGESSION] systemd-oomd overreacting due to PSI changes for
 Btrfs (was: Re: [PATCH 3/5] btrfs: add manual PSI accounting for compressed
 reads)
Message-ID: <Y2Q+y8t9PV5nrjud@cmpxchg.org>
References: <20220915094200.139713-1-hch@lst.de>
 <20220915094200.139713-4-hch@lst.de>
 <d20a0a85-e415-cf78-27f9-77dd7a94bc8d@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d20a0a85-e415-cf78-27f9-77dd7a94bc8d@leemhuis.info>
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
Cc: Jens Axboe <axboe@kernel.dk>, "regressions@lists.linux.dev" <regressions@lists.linux.dev>, linux-mm@kvack.org, linux-erofs@lists.ozlabs.org, Josef Bacik <josef@toxicpanda.com>, Matthew Wilcox <willy@infradead.org>, linux-block@vger.kernel.org, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Suren Baghdasaryan <surenb@google.com>, Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Nov 03, 2022 at 11:46:52AM +0100, Thorsten Leemhuis wrote:
> Hi Christoph!
> 
> On 15.09.22 11:41, Christoph Hellwig wrote:
> > btrfs compressed reads try to always read the entire compressed chunk,
> > even if only a subset is requested.  Currently this is covered by the
> > magic PSI accounting underneath submit_bio, but that is about to go
> > away. Instead add manual psi_memstall_{enter,leave} annotations.
> > 
> > Note that for readahead this really should be using readahead_expand,
> > but the additionals reads are also done for plain ->read_folio where
> > readahead_expand can't work, so this overall logic is left as-is for
> > now.
> 
> It seems this patch makes systemd-oomd overreact on my day-to-day
> machine and aggressively kill applications. I'm not the only one that
> noticed such a behavior with 6.1 pre-releases:
> https://bugzilla.redhat.com/show_bug.cgi?id=2133829
> https://bugzilla.redhat.com/show_bug.cgi?id=2134971
> 
> I think I have a pretty reliable way to trigger the issue that involves
> starting the apps that I normally use and a VM that I occasionally use,
> which up to now never resulted in such a behaviour.
> 
> On master as of today (8e5423e991e8) I can trigger the problem within a
> minute or two. But I fail to trigger it with v6.0.6 or when I revert
> 4088a47e78f9 ("btrfs: add manual PSI accounting for compressed reads").
> And yes, I use btrfs with compression for / and /home/.
> 
> See [1] for a log msg from systemd-oomd.
> 
> Note, I had some trouble with bisecting[2]. This series looked
> suspicious, so I removed it completely ontop of master and the problem
> went away. Then I tried reverting only 4088a47e78f9 which helped, too.
> Let me know if you want me to try another combination or need more data.

Oh, I think I see the bug. We can leak pressure state from the bio
submission, which causes the task to permanently drive up pressure.

Can you try this patch?

From 499e5cab7b39fc4c90a0f96e33cdc03274b316fd Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Thu, 3 Nov 2022 17:34:31 -0400
Subject: [PATCH] fs: btrfs: fix leaked psi pressure state

When psi annotations were added to to btrfs compression reads, the psi
state tracking over add_ra_bio_pages and btrfs_submit_compressed_read
was faulty. The task can remain in a stall state after the read. This
results in incorrectly elevated pressure, which triggers OOM kills.

pflags record the *previous* memstall state when we enter a new
one. The code tried to initialize pflags to 1, and then optimize the
leave call when we either didn't enter a memstall, or were already
inside a nested stall. However, there can be multiple PageWorkingset
pages in the bio, at which point it's that path itself that re-enters
the state and overwrites pflags. This causes us to miss the exit.

Enter the stall only once if needed, then unwind correctly.

Reported-by: Thorsten Leemhuis <linux@leemhuis.info>
Fixes: 4088a47e78f9 btrfs: add manual PSI accounting for compressed reads
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 fs/btrfs/compression.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

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
-- 
2.38.1
