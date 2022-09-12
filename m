Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B9F5B5D43
	for <lists+linux-erofs@lfdr.de>; Mon, 12 Sep 2022 17:34:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MR9cf5nLTz3bVB
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Sep 2022 01:34:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=VWyqSWKb;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=hwTtR/8J;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz (client-ip=195.135.220.29; helo=smtp-out2.suse.de; envelope-from=dsterba@suse.cz; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=VWyqSWKb;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=hwTtR/8J;
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MR9cZ08xnz2xGS
	for <linux-erofs@lists.ozlabs.org>; Tue, 13 Sep 2022 01:34:05 +1000 (AEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E8E1B203C4;
	Mon, 12 Sep 2022 15:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1662996831;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eRpjiBTXPA34slJCEVvqta+I3LTtT85gBwO0gzk+thc=;
	b=VWyqSWKbD8LfsNkEZC6EfWdMhvQPVUdRjk4fuYRSvzsQEKrce6OwrVOAdkzMBS+wiq2JY5
	akEn052RhfK8DuSDzFpXLpel3PV/i3bgfauRV9s3y5tv1gP4xqAGKyh0U3fHMHaJXaMA0+
	qSbhiUWWNwPX7E4t4wrz8TraWqGJA7A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1662996831;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eRpjiBTXPA34slJCEVvqta+I3LTtT85gBwO0gzk+thc=;
	b=hwTtR/8JTQzhvO35pkm4yWhMWS+i/ViXhcrAXDNSu6OFhBd2TME2kaufjoQXSL7nbHj4M7
	lJhly5+/lT1fk1AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7D94F139E0;
	Mon, 12 Sep 2022 15:33:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id MKGgHV9RH2OaYgAAMHmgww
	(envelope-from <dsterba@suse.cz>); Mon, 12 Sep 2022 15:33:51 +0000
Date: Mon, 12 Sep 2022 17:28:25 +0200
From: David Sterba <dsterba@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/5] btrfs: add manual PSI accounting for compressed reads
Message-ID: <20220912152825.GH32411@suse.cz>
References: <20220910065058.3303831-1-hch@lst.de>
 <20220910065058.3303831-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910065058.3303831-4-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
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
Reply-To: dsterba@suse.cz
Cc: Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org, linux-erofs@lists.ozlabs.org, Josef Bacik <josef@toxicpanda.com>, Matthew Wilcox <willy@infradead.org>, linux-block@vger.kernel.org, Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>, David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Suren Baghdasaryan <surenb@google.com>, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, Sep 10, 2022 at 08:50:56AM +0200, Christoph Hellwig wrote:
> btrfs compressed reads try to always read the entire compressed chunk,
> even if only a subset is requested.  Currently this is covered by the
> magic PSI accounting underneath submit_bio, but that is about to go
> away. Instead add manual psi_memstall_{enter,leave} annotations.
> 
> Note that for readahead this really should be using readahead_expand,
> but the additionals reads are also done for plain ->read_folio where
> readahead_expand can't work, so this overall logic is left as-is for
> now.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

With some small fixups,

Acked-by: David Sterba <dsterba@suse.com>

>  fs/btrfs/compression.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index e84d22c5c6a83..f7889a00e0055 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -15,6 +15,7 @@
>  #include <linux/string.h>
>  #include <linux/backing-dev.h>
>  #include <linux/writeback.h>
> +#include <linux/psi.h>
>  #include <linux/slab.h>
>  #include <linux/sched/mm.h>
>  #include <linux/log2.h>
> @@ -519,7 +520,8 @@ static u64 bio_end_offset(struct bio *bio)
>   */
>  static noinline int add_ra_bio_pages(struct inode *inode,
>  				     u64 compressed_end,
> -				     struct compressed_bio *cb)
> +				     struct compressed_bio *cb,
> +				     unsigned long *pflags)
>  {
>  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>  	unsigned long end_index;
> @@ -588,6 +590,9 @@ static noinline int add_ra_bio_pages(struct inode *inode,
>  			continue;
>  		}
>  
> +		if (unlikely(PageWorkingset(page)))

Please drop the 'unlikely', in this case it does not seem to make much
sense.

> +			psi_memstall_enter(pflags);
> +
>  		ret = set_page_extent_mapped(page);
>  		if (ret < 0) {
>  			unlock_page(page);
> @@ -674,6 +679,8 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>  	u64 em_len;
>  	u64 em_start;
>  	struct extent_map *em;
> +	/* initialize to 1 to make skip psi_memstall_leave unless needed */

First letter in comment should be upper case unless it's an identifier.

> +	unsigned long pflags = 1;
>  	blk_status_t ret;
>  	int ret2;
>  	int i;
> @@ -729,7 +736,7 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>  		goto fail;
>  	}
>  
> -	add_ra_bio_pages(inode, em_start + em_len, cb);
> +	add_ra_bio_pages(inode, em_start + em_len, cb, &pflags);
>  
>  	/* include any pages we added in add_ra-bio_pages */
>  	cb->len = bio->bi_iter.bi_size;
> @@ -810,6 +817,9 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>  		}
>  	}
>  
> +	if (!pflags)
> +		psi_memstall_leave(&pflags);
> +
>  	if (refcount_dec_and_test(&cb->pending_ios))
>  		finish_compressed_bio_read(cb);
>  	return;
> -- 
> 2.30.2
> 
