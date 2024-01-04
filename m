Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9853824193
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Jan 2024 13:22:28 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=XFc8VLBs;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=BRLIxIrq;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=dWaipx2c;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=VFhD00b5;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T5QhL4Cg8z3cV6
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Jan 2024 23:22:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=XFc8VLBs;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=BRLIxIrq;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=dWaipx2c;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=VFhD00b5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=jack@suse.cz; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4T5QhC0Mf2z3cSJ
	for <linux-erofs@lists.ozlabs.org>; Thu,  4 Jan 2024 23:22:17 +1100 (AEDT)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C3FE921D3A;
	Thu,  4 Jan 2024 12:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704370935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dEOhbl6BxUdU6y2PPLv5OY3ZqGBD0PFejfclreExChI=;
	b=XFc8VLBsnl9aL7k3OjwpBjEyurAPHn/wozw7huEJg8Kh1XtexFXGnCOFrF5cdJObzIoVOB
	WSl0qwfGcHDQRAYaR70hDrxP5dEBoB1H4OgNdM9BCSFoyD0dNvFgWPJz8qJrVSt4tKq5qM
	SM0EzBf8FjQO8tP69JsU/iZJsUbAZBg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704370935;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dEOhbl6BxUdU6y2PPLv5OY3ZqGBD0PFejfclreExChI=;
	b=BRLIxIrqPa8P6c1xZvwUjFY/XF/4q/Hh7Fr9qUPo3HG8bI8kuWp+Geq4NwDCe18M+n1X29
	u6rW+t5czthqMXCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704370934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dEOhbl6BxUdU6y2PPLv5OY3ZqGBD0PFejfclreExChI=;
	b=dWaipx2c9mtfXsouDbDbhmlJanWKJIihT+c3mI9H4+BEJ9hmUZtaN5Uu4ae2qTdtLH7xKW
	DDYet+i2/F2cAa+agkhhbr3Cv4olBkJ/pv8A4qgM43c2v3EY3PHpUBczoq93IpuUDz4twc
	YFhcZIKVsPkTvaHSTOYEQ6iZivXOeek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704370934;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dEOhbl6BxUdU6y2PPLv5OY3ZqGBD0PFejfclreExChI=;
	b=VFhD00b5yP8kUic6tuTXvk6P7y+b439KNlXOG1em78AjaLBeb4nyWpSfko2ONapIBWJ8nM
	q4ULVr0ImRgl9xDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A408A137E8;
	Thu,  4 Jan 2024 12:22:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aIvDJ/ailmWuFQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 04 Jan 2024 12:22:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 12451A07EF; Thu,  4 Jan 2024 13:22:14 +0100 (CET)
Date: Thu, 4 Jan 2024 13:22:14 +0100
From: Jan Kara <jack@suse.cz>
To: Yu Kuai <yukuai1@huaweicloud.com>
Subject: Re: [PATCH RFC v3 for-6.8/block 14/17] buffer: add a new helper to
 read sb block
Message-ID: <20240104122214.jndsqygnmljxmj5d@quack3>
References: <20231221085712.1766333-1-yukuai1@huaweicloud.com>
 <20231221085853.1770062-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221085853.1770062-1-yukuai1@huaweicloud.com>
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.31 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 TO_DN_SOME(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLhr85cyeg3mfw7iggddtjdkgs)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[99.99%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[48];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[kernel.dk,citrix.com,suse.de,gmail.com,lazybastard.org,bootlin.com,nod.at,ti.com,linux.ibm.com,oracle.com,fb.com,toxicpanda.com,suse.com,zeniv.linux.org.uk,kernel.org,fluxnic.net,mit.edu,dilger.ca,infradead.org,linux-foundation.org,samsung.com,vger.kernel.org,lists.xenproject.org,lists.infradead.org,lists.ozlabs.org,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dWaipx2c;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VFhD00b5
X-Spam-Score: -1.31
X-Rspamd-Queue-Id: C3FE921D3A
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
Cc: hoeppner@linux.ibm.com, vigneshr@ti.com, yi.zhang@huawei.com, clm@fb.com, adilger.kernel@dilger.ca, miquel.raynal@bootlin.com, agordeev@linux.ibm.com, linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org, linux-scsi@vger.kernel.org, richard@nod.at, willy@infradead.org, linux-bcachefs@vger.kernel.org, xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org, jejb@linux.ibm.com, p.raghav@samsung.com, gor@linux.ibm.com, hca@linux.ibm.com, joern@lazybastard.org, josef@toxicpanda.com, colyli@suse.de, linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, viro@zeniv.linux.org.uk, yukuai3@huawei.com, dsterba@suse.com, konishi.ryusuke@gmail.com, axboe@kernel.dk, brauner@kernel.org, tytso@mit.edu, martin.petersen@oracle.com, nico@fluxnic.net, yangerkun@huawei.com, linux-kernel@vger.kernel.org, kent.overstreet@gmail.com, hare@suse.de, jack@suse.com, linux-fsdevel@vger.kernel.org, linux-mtd@lists.infradead.org, akpm@linux-foundation.org, roger.pau@citrix.com, linux-erofs@lists.ozla
 bs.org, linux-btrfs@vger.kernel.org, sth@linux.ibm.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu 21-12-23 16:58:53, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Unlike __bread_gfp(), ext4 has special handing while reading sb block:
> 
> 1) __GFP_NOFAIL is not set, and memory allocation can fail;
> 2) If buffer write failed before, set buffer uptodate and don't read
>    block from disk;
> 3) REQ_META is set for all IO, and REQ_PRIO is set for reading xattr;
> 4) If failed, return error ptr instead of NULL;
> 
> This patch add a new helper __bread_gfp2() that will match above 2 and 3(
> 1 will be used, and 4 will still be encapsulated by ext4), and prepare to
> prevent calling mapping_gfp_constraint() directly on bd_inode->i_mapping
> in ext4.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

I'm not enthusiastic about this but I guess it is as good as it gets
without larger cleanups in this area. So feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/buffer.c                 | 68 ++++++++++++++++++++++++++-----------
>  include/linux/buffer_head.h | 18 +++++++++-
>  2 files changed, 65 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 967f34b70aa8..188bd36c9fea 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -1255,16 +1255,19 @@ void __bforget(struct buffer_head *bh)
>  }
>  EXPORT_SYMBOL(__bforget);
>  
> -static struct buffer_head *__bread_slow(struct buffer_head *bh)
> +static struct buffer_head *__bread_slow(struct buffer_head *bh,
> +					blk_opf_t op_flags,
> +					bool check_write_error)
>  {
>  	lock_buffer(bh);
> -	if (buffer_uptodate(bh)) {
> +	if (buffer_uptodate(bh) ||
> +	    (check_write_error && buffer_uptodate_or_error(bh))) {
>  		unlock_buffer(bh);
>  		return bh;
>  	} else {
>  		get_bh(bh);
>  		bh->b_end_io = end_buffer_read_sync;
> -		submit_bh(REQ_OP_READ, bh);
> +		submit_bh(REQ_OP_READ | op_flags, bh);
>  		wait_on_buffer(bh);
>  		if (buffer_uptodate(bh))
>  			return bh;
> @@ -1445,6 +1448,31 @@ void __breadahead(struct block_device *bdev, sector_t block, unsigned size)
>  }
>  EXPORT_SYMBOL(__breadahead);
>  
> +static struct buffer_head *
> +bread_gfp(struct block_device *bdev, sector_t block, unsigned int size,
> +	  blk_opf_t op_flags, gfp_t gfp, bool check_write_error)
> +{
> +	struct buffer_head *bh;
> +
> +	gfp |= mapping_gfp_constraint(bdev->bd_inode->i_mapping, ~__GFP_FS);
> +
> +	/*
> +	 * Prefer looping in the allocator rather than here, at least that
> +	 * code knows what it's doing.
> +	 */
> +	gfp |= __GFP_NOFAIL;
> +
> +	bh = bdev_getblk(bdev, block, size, gfp);
> +	if (unlikely(!bh))
> +		return NULL;
> +
> +	if (buffer_uptodate(bh) ||
> +	    (check_write_error && buffer_uptodate_or_error(bh)))
> +		return bh;
> +
> +	return __bread_slow(bh, op_flags, check_write_error);
> +}
> +
>  /**
>   *  __bread_gfp() - reads a specified block and returns the bh
>   *  @bdev: the block_device to read from
> @@ -1458,27 +1486,27 @@ EXPORT_SYMBOL(__breadahead);
>   *  It returns NULL if the block was unreadable.
>   */
>  struct buffer_head *
> -__bread_gfp(struct block_device *bdev, sector_t block,
> -		   unsigned size, gfp_t gfp)
> +__bread_gfp(struct block_device *bdev, sector_t block, unsigned int size,
> +	    gfp_t gfp)
>  {
> -	struct buffer_head *bh;
> -
> -	gfp |= mapping_gfp_constraint(bdev->bd_inode->i_mapping, ~__GFP_FS);
> -
> -	/*
> -	 * Prefer looping in the allocator rather than here, at least that
> -	 * code knows what it's doing.
> -	 */
> -	gfp |= __GFP_NOFAIL;
> -
> -	bh = bdev_getblk(bdev, block, size, gfp);
> -
> -	if (likely(bh) && !buffer_uptodate(bh))
> -		bh = __bread_slow(bh);
> -	return bh;
> +	return bread_gfp(bdev, block, size, 0, gfp, false);
>  }
>  EXPORT_SYMBOL(__bread_gfp);
>  
> +/*
> + * This works like __bread_gfp() except:
> + * 1) If buffer write failed before, set buffer uptodate and don't read
> + * block from disk;
> + * 2) Caller can pass in additional op_flags like REQ_META;
> + */
> +struct buffer_head *
> +__bread_gfp2(struct block_device *bdev, sector_t block, unsigned int size,
> +	     blk_opf_t op_flags, gfp_t gfp)
> +{
> +	return bread_gfp(bdev, block, size, op_flags, gfp, true);
> +}
> +EXPORT_SYMBOL(__bread_gfp2);
> +
>  static void __invalidate_bh_lrus(struct bh_lru *b)
>  {
>  	int i;
> diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
> index 5f23ee599889..751b2744b4ae 100644
> --- a/include/linux/buffer_head.h
> +++ b/include/linux/buffer_head.h
> @@ -171,6 +171,18 @@ static __always_inline int buffer_uptodate(const struct buffer_head *bh)
>  	return test_bit_acquire(BH_Uptodate, &bh->b_state);
>  }
>  
> +static __always_inline int buffer_uptodate_or_error(struct buffer_head *bh)
> +{
> +	/*
> +	 * If the buffer has the write error flag, data was failed to write
> +	 * out in the block. In this case, set buffer uptodate to prevent
> +	 * reading old data.
> +	 */
> +	if (buffer_write_io_error(bh))
> +		set_buffer_uptodate(bh);
> +	return buffer_uptodate(bh);
> +}
> +
>  static inline unsigned long bh_offset(const struct buffer_head *bh)
>  {
>  	return (unsigned long)(bh)->b_data & (page_size(bh->b_page) - 1);
> @@ -231,7 +243,11 @@ void __brelse(struct buffer_head *);
>  void __bforget(struct buffer_head *);
>  void __breadahead(struct block_device *, sector_t block, unsigned int size);
>  struct buffer_head *__bread_gfp(struct block_device *,
> -				sector_t block, unsigned size, gfp_t gfp);
> +				sector_t block, unsigned int size, gfp_t gfp);
> +struct buffer_head *__bread_gfp2(struct block_device *bdev, sector_t block,
> +				 unsigned int size, blk_opf_t op_flags,
> +				 gfp_t gfp);
> +
>  struct buffer_head *alloc_buffer_head(gfp_t gfp_flags);
>  void free_buffer_head(struct buffer_head * bh);
>  void unlock_buffer(struct buffer_head *bh);
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
