Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7E582412E
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Jan 2024 13:02:21 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=mA9MLCSZ;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=jRA844eL;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=mA9MLCSZ;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=jRA844eL;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T5QF46ZKNz3cVG
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Jan 2024 23:02:16 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=mA9MLCSZ;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=jRA844eL;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=mA9MLCSZ;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=jRA844eL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=jack@suse.cz; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4T5QF00gVDz3cRP
	for <linux-erofs@lists.ozlabs.org>; Thu,  4 Jan 2024 23:02:11 +1100 (AEDT)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BC0A11F805;
	Thu,  4 Jan 2024 12:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704369727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mWvdmjnCrvMMkEad6Bqg+px5xJk89umEnoKGFgsKrCs=;
	b=mA9MLCSZPk9YYyGvchTGE7QGfjuvAxQPIOB5bSqI0ShVGuX15p8YvfG4RITiIv4B9Dzufr
	pBagJPjiR4Z4ZPrR4rSg3y7kRhQxg3YLJt/5Wk5xAtOKY9ZIcCpHalmOrCoqz7gQD2Ger5
	HIfrPy1FJ1h/ozC1qSJjAvouN5/Df8A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704369727;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mWvdmjnCrvMMkEad6Bqg+px5xJk89umEnoKGFgsKrCs=;
	b=jRA844eLB6Y1ZxCGnb1N6KdOvFnePFHAQGW/vxMgV1qx9TUjHNv+uXe5govpUflqSIzCOd
	q/MKgsENsW38BEBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704369727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mWvdmjnCrvMMkEad6Bqg+px5xJk89umEnoKGFgsKrCs=;
	b=mA9MLCSZPk9YYyGvchTGE7QGfjuvAxQPIOB5bSqI0ShVGuX15p8YvfG4RITiIv4B9Dzufr
	pBagJPjiR4Z4ZPrR4rSg3y7kRhQxg3YLJt/5Wk5xAtOKY9ZIcCpHalmOrCoqz7gQD2Ger5
	HIfrPy1FJ1h/ozC1qSJjAvouN5/Df8A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704369727;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mWvdmjnCrvMMkEad6Bqg+px5xJk89umEnoKGFgsKrCs=;
	b=jRA844eLB6Y1ZxCGnb1N6KdOvFnePFHAQGW/vxMgV1qx9TUjHNv+uXe5govpUflqSIzCOd
	q/MKgsENsW38BEBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA856137E8;
	Thu,  4 Jan 2024 12:02:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id B2+aKT+elmXdDwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 04 Jan 2024 12:02:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 46F2EA07EF; Thu,  4 Jan 2024 13:02:07 +0100 (CET)
Date: Thu, 4 Jan 2024 13:02:07 +0100
From: Jan Kara <jack@suse.cz>
To: Yu Kuai <yukuai1@huaweicloud.com>
Subject: Re: [PATCH RFC v3 for-6.8/block 11/17] erofs: use bdev api
Message-ID: <20240104120207.ig7tfc3mgckwkp2n@quack3>
References: <20231221085712.1766333-1-yukuai1@huaweicloud.com>
 <20231221085826.1768395-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221085826.1768395-1-yukuai1@huaweicloud.com>
X-Spam-Level: *****
X-Spamd-Bar: +++++
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mA9MLCSZ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jRA844eL
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [5.59 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_SPAM(5.10)[100.00%];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLhr85cyeg3mfw7iggddtjdkgs)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[48];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[kernel.dk,citrix.com,suse.de,gmail.com,lazybastard.org,bootlin.com,nod.at,ti.com,linux.ibm.com,oracle.com,fb.com,toxicpanda.com,suse.com,zeniv.linux.org.uk,kernel.org,fluxnic.net,mit.edu,dilger.ca,infradead.org,linux-foundation.org,samsung.com,vger.kernel.org,lists.xenproject.org,lists.infradead.org,lists.ozlabs.org,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: 5.59
X-Rspamd-Queue-Id: BC0A11F805
X-Spam-Flag: NO
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

On Thu 21-12-23 16:58:26, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Avoid to access bd_inode directly, prepare to remove bd_inode from
> block_device.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

I'm not erofs maintainer but IMO this is quite ugly and grows erofs_buf
unnecessarily. I'd rather store 'sb' pointer in erofs_buf and then do the
right thing in erofs_bread() which is the only place that seems to care
about the erofs_is_fscache_mode() distinction... Also blkszbits is then
trivially sb->s_blocksize_bits so it would all seem much more
straightforward.

								Honza

> ---
>  fs/erofs/data.c     | 18 ++++++++++++------
>  fs/erofs/internal.h |  2 ++
>  2 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index c98aeda8abb2..bbe2fe199bf3 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -32,8 +32,8 @@ void erofs_put_metabuf(struct erofs_buf *buf)
>  void *erofs_bread(struct erofs_buf *buf, erofs_blk_t blkaddr,
>  		  enum erofs_kmap_type type)
>  {
> -	struct inode *inode = buf->inode;
> -	erofs_off_t offset = (erofs_off_t)blkaddr << inode->i_blkbits;
> +	u8 blkszbits = buf->inode ? buf->inode->i_blkbits : buf->blkszbits;
> +	erofs_off_t offset = (erofs_off_t)blkaddr << blkszbits;
>  	pgoff_t index = offset >> PAGE_SHIFT;
>  	struct page *page = buf->page;
>  	struct folio *folio;
> @@ -43,7 +43,9 @@ void *erofs_bread(struct erofs_buf *buf, erofs_blk_t blkaddr,
>  		erofs_put_metabuf(buf);
>  
>  		nofs_flag = memalloc_nofs_save();
> -		folio = read_cache_folio(inode->i_mapping, index, NULL, NULL);
> +		folio = buf->inode ?
> +			read_mapping_folio(buf->inode->i_mapping, index, NULL) :
> +			bdev_read_folio(buf->bdev, offset);
>  		memalloc_nofs_restore(nofs_flag);
>  		if (IS_ERR(folio))
>  			return folio;
> @@ -67,10 +69,14 @@ void *erofs_bread(struct erofs_buf *buf, erofs_blk_t blkaddr,
>  
>  void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb)
>  {
> -	if (erofs_is_fscache_mode(sb))
> +	if (erofs_is_fscache_mode(sb)) {
>  		buf->inode = EROFS_SB(sb)->s_fscache->inode;
> -	else
> -		buf->inode = sb->s_bdev->bd_inode;
> +		buf->bdev = NULL;
> +	} else {
> +		buf->inode = NULL;
> +		buf->bdev = sb->s_bdev;
> +		buf->blkszbits = EROFS_SB(sb)->blkszbits;
> +	}
>  }
>  
>  void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index b0409badb017..c9206351b485 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -224,8 +224,10 @@ enum erofs_kmap_type {
>  
>  struct erofs_buf {
>  	struct inode *inode;
> +	struct block_device *bdev;
>  	struct page *page;
>  	void *base;
> +	u8 blkszbits;
>  	enum erofs_kmap_type kmap_type;
>  };
>  #define __EROFS_BUF_INITIALIZER	((struct erofs_buf){ .page = NULL })
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
