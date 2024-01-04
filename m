Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6FF824159
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Jan 2024 13:12:09 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=e3sjw3qz;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=yQXb9LPj;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=e3sjw3qz;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=yQXb9LPj;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T5QSN2dvBz3cVG
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Jan 2024 23:12:04 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=e3sjw3qz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=yQXb9LPj;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=e3sjw3qz;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=yQXb9LPj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=jack@suse.cz; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4T5QSC49ZCz3cRP
	for <linux-erofs@lists.ozlabs.org>; Thu,  4 Jan 2024 23:11:54 +1100 (AEDT)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1152E1F805;
	Thu,  4 Jan 2024 12:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704370311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9ZeDUh4C7zA3YQ4fYm2i65EzKNR/mQAuN7BWkbo24yo=;
	b=e3sjw3qzaFj1bR2K3ph+SCgBs0W5KbKSkTDh6j9mOfMzcA4ll5T88VX7DvbyrfhjMaOgEU
	ULNk5uKyzCEeOrIlpEpgveioXn6k/trmuztnPHJGyuhf31ImQ2Y/fqDPmQvtkeijr8KG0S
	hbXlHYuGqhsgRPRLiscvp4MGINF5+lk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704370311;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9ZeDUh4C7zA3YQ4fYm2i65EzKNR/mQAuN7BWkbo24yo=;
	b=yQXb9LPjRaWSg2B28C8A0dOdwxgSX7f2zAKDyWfCb78V8RXDAvfljmM2SO6fP/MQIajAvj
	t7RHhrFKNOkLHNCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704370311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9ZeDUh4C7zA3YQ4fYm2i65EzKNR/mQAuN7BWkbo24yo=;
	b=e3sjw3qzaFj1bR2K3ph+SCgBs0W5KbKSkTDh6j9mOfMzcA4ll5T88VX7DvbyrfhjMaOgEU
	ULNk5uKyzCEeOrIlpEpgveioXn6k/trmuztnPHJGyuhf31ImQ2Y/fqDPmQvtkeijr8KG0S
	hbXlHYuGqhsgRPRLiscvp4MGINF5+lk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704370311;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9ZeDUh4C7zA3YQ4fYm2i65EzKNR/mQAuN7BWkbo24yo=;
	b=yQXb9LPjRaWSg2B28C8A0dOdwxgSX7f2zAKDyWfCb78V8RXDAvfljmM2SO6fP/MQIajAvj
	t7RHhrFKNOkLHNCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E4BA2137E8;
	Thu,  4 Jan 2024 12:11:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 63jMN4aglmWaEgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 04 Jan 2024 12:11:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3F4B9A07EF; Thu,  4 Jan 2024 13:11:50 +0100 (CET)
Date: Thu, 4 Jan 2024 13:11:50 +0100
From: Jan Kara <jack@suse.cz>
To: Yu Kuai <yukuai1@huaweicloud.com>
Subject: Re: [PATCH RFC v3 for-6.8/block 13/17] jbd2: use bdev apis
Message-ID: <20240104121150.cxrykpptpgnwkqge@quack3>
References: <20231221085712.1766333-1-yukuai1@huaweicloud.com>
 <20231221085846.1768977-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221085846.1768977-1-yukuai1@huaweicloud.com>
X-Spam-Score: 1.90
X-Spamd-Result: default: False [1.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 R_RATELIMIT(0.00)[to_ip_from(RLdan9jouj5dxnqx1npfmn4ucx)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[48];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[kernel.dk,citrix.com,suse.de,gmail.com,lazybastard.org,bootlin.com,nod.at,ti.com,linux.ibm.com,oracle.com,fb.com,toxicpanda.com,suse.com,zeniv.linux.org.uk,kernel.org,fluxnic.net,mit.edu,dilger.ca,infradead.org,linux-foundation.org,samsung.com,vger.kernel.org,lists.xenproject.org,lists.infradead.org,lists.ozlabs.org,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: *
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

On Thu 21-12-23 16:58:46, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Avoid to access bd_inode directly, prepare to remove bd_inode from
> block_device.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

But note there are changes pending to this code for the coming merge window
so you'll have to rebase...

								Honza

> ---
>  fs/jbd2/journal.c  | 3 +--
>  fs/jbd2/recovery.c | 6 ++----
>  2 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index ed53188472f9..f1b5ffeaf02a 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -2003,8 +2003,7 @@ static int __jbd2_journal_erase(journal_t *journal, unsigned int flags)
>  		byte_count = (block_stop - block_start + 1) *
>  				journal->j_blocksize;
>  
> -		truncate_inode_pages_range(journal->j_dev->bd_inode->i_mapping,
> -				byte_start, byte_stop);
> +		truncate_bdev_range(journal->j_dev, 0, byte_start, byte_stop);
>  
>  		if (flags & JBD2_JOURNAL_FLUSH_DISCARD) {
>  			err = blkdev_issue_discard(journal->j_dev,
> diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
> index 01f744cb97a4..6b6a2c4585fa 100644
> --- a/fs/jbd2/recovery.c
> +++ b/fs/jbd2/recovery.c
> @@ -290,7 +290,6 @@ int jbd2_journal_recover(journal_t *journal)
>  
>  	struct recovery_info	info;
>  	errseq_t		wb_err;
> -	struct address_space	*mapping;
>  
>  	memset(&info, 0, sizeof(info));
>  	sb = journal->j_superblock;
> @@ -309,8 +308,7 @@ int jbd2_journal_recover(journal_t *journal)
>  	}
>  
>  	wb_err = 0;
> -	mapping = journal->j_fs_dev->bd_inode->i_mapping;
> -	errseq_check_and_advance(&mapping->wb_err, &wb_err);
> +	bdev_wb_err_check_and_advance(journal->j_fs_dev, &wb_err);
>  	err = do_one_pass(journal, &info, PASS_SCAN);
>  	if (!err)
>  		err = do_one_pass(journal, &info, PASS_REVOKE);
> @@ -334,7 +332,7 @@ int jbd2_journal_recover(journal_t *journal)
>  	err2 = sync_blockdev(journal->j_fs_dev);
>  	if (!err)
>  		err = err2;
> -	err2 = errseq_check_and_advance(&mapping->wb_err, &wb_err);
> +	err2 = bdev_wb_err_check_and_advance(journal->j_fs_dev, &wb_err);
>  	if (!err)
>  		err = err2;
>  	/* Make sure all replayed data is on permanent storage */
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
