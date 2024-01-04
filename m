Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 520808240FE
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Jan 2024 12:50:20 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=LPy9kLPa;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=RfDu2tLA;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=LPy9kLPa;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=RfDu2tLA;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T5PzG0Dfqz3cV2
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Jan 2024 22:50:18 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=LPy9kLPa;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=RfDu2tLA;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=LPy9kLPa;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=RfDu2tLA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de; envelope-from=jack@suse.cz; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4T5Pz647qXz3cR4
	for <linux-erofs@lists.ozlabs.org>; Thu,  4 Jan 2024 22:50:09 +1100 (AEDT)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 160C121EF5;
	Thu,  4 Jan 2024 11:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704369003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XeXpcnQhc7k5wPj1KeDdzxd8IqzZglYqdEMHG+1v698=;
	b=LPy9kLPa52w1LTjGtPYNG0ddRTaUsK2l/chyWjlrzN9YlPHEcnuQYee5oABFJTvAftkB9q
	FjI0zQ5uCaFFznkd94synnqXs7uXb8cRAAI7EO6ytDym9jLmWBPX0BO4sb7N9wbnW2+LFu
	0aOzGcbzAFq+5BQ61moeUz08HE5ZlKs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704369003;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XeXpcnQhc7k5wPj1KeDdzxd8IqzZglYqdEMHG+1v698=;
	b=RfDu2tLAXy86TXl7DP8sQxwxqulz8lo88WAB157ByWrDk4aXKD88/w5gosTD/z+q/d5Hzm
	g3+FRHbpwvRn6XCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704369003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XeXpcnQhc7k5wPj1KeDdzxd8IqzZglYqdEMHG+1v698=;
	b=LPy9kLPa52w1LTjGtPYNG0ddRTaUsK2l/chyWjlrzN9YlPHEcnuQYee5oABFJTvAftkB9q
	FjI0zQ5uCaFFznkd94synnqXs7uXb8cRAAI7EO6ytDym9jLmWBPX0BO4sb7N9wbnW2+LFu
	0aOzGcbzAFq+5BQ61moeUz08HE5ZlKs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704369003;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XeXpcnQhc7k5wPj1KeDdzxd8IqzZglYqdEMHG+1v698=;
	b=RfDu2tLAXy86TXl7DP8sQxwxqulz8lo88WAB157ByWrDk4aXKD88/w5gosTD/z+q/d5Hzm
	g3+FRHbpwvRn6XCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 05B81137E8;
	Thu,  4 Jan 2024 11:50:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id N5lgAWublmUQDAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 04 Jan 2024 11:50:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A9CF6A07EF; Thu,  4 Jan 2024 12:49:58 +0100 (CET)
Date: Thu, 4 Jan 2024 12:49:58 +0100
From: Jan Kara <jack@suse.cz>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH RFC v3 for-6.8/block 09/17] btrfs: use bdev apis
Message-ID: <20240104114958.f3cit5q7syp3tn3a@quack3>
References: <20231221085712.1766333-1-yukuai1@huaweicloud.com>
 <20231221085712.1766333-10-yukuai1@huaweicloud.com>
 <ZYcZi5YYvt5QHrG9@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYcZi5YYvt5QHrG9@casper.infradead.org>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 1.65
X-Spamd-Bar: +
X-Spam-Flag: NO
X-Spamd-Result: default: False [1.65 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 BAYES_HAM(-0.04)[57.99%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 R_RATELIMIT(0.00)[to_ip_from(RLhr85cyeg3mfw7iggddtjdkgs)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[48];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[huaweicloud.com,kernel.dk,citrix.com,suse.de,gmail.com,lazybastard.org,bootlin.com,nod.at,ti.com,linux.ibm.com,oracle.com,fb.com,toxicpanda.com,suse.com,zeniv.linux.org.uk,kernel.org,fluxnic.net,mit.edu,dilger.ca,linux-foundation.org,samsung.com,vger.kernel.org,lists.xenproject.org,lists.infradead.org,lists.ozlabs.org,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LPy9kLPa;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=RfDu2tLA
X-Spam-Level: *
X-Rspamd-Queue-Id: 160C121EF5
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
Cc: hoeppner@linux.ibm.com, vigneshr@ti.com, yi.zhang@huawei.com, clm@fb.com, adilger.kernel@dilger.ca, miquel.raynal@bootlin.com, agordeev@linux.ibm.com, linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org, linux-scsi@vger.kernel.org, richard@nod.at, linux-bcachefs@vger.kernel.org, xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org, Yu Kuai <yukuai1@huaweicloud.com>, jejb@linux.ibm.com, p.raghav@samsung.com, gor@linux.ibm.com, hca@linux.ibm.com, joern@lazybastard.org, josef@toxicpanda.com, colyli@suse.de, linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, viro@zeniv.linux.org.uk, yukuai3@huawei.com, dsterba@suse.com, konishi.ryusuke@gmail.com, axboe@kernel.dk, brauner@kernel.org, tytso@mit.edu, martin.petersen@oracle.com, nico@fluxnic.net, yangerkun@huawei.com, linux-kernel@vger.kernel.org, kent.overstreet@gmail.com, hare@suse.de, jack@suse.com, linux-fsdevel@vger.kernel.org, linux-mtd@lists.infradead.org, akpm@linux-foundation.org, roger.pau@citrix.com, linux-er
 ofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org, sth@linux.ibm.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat 23-12-23 17:31:55, Matthew Wilcox wrote:
> On Thu, Dec 21, 2023 at 04:57:04PM +0800, Yu Kuai wrote:
> > @@ -3674,16 +3670,17 @@ struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
> >  		 * Drop the page of the primary superblock, so later read will
> >  		 * always read from the device.
> >  		 */
> > -		invalidate_inode_pages2_range(mapping,
> > -				bytenr >> PAGE_SHIFT,
> > +		invalidate_bdev_range(bdev, bytenr >> PAGE_SHIFT,
> >  				(bytenr + BTRFS_SUPER_INFO_SIZE) >> PAGE_SHIFT);
> >  	}
> >  
> > -	page = read_cache_page_gfp(mapping, bytenr >> PAGE_SHIFT, GFP_NOFS);
> > -	if (IS_ERR(page))
> > -		return ERR_CAST(page);
> > +	nofs_flag = memalloc_nofs_save();
> > +	folio = bdev_read_folio(bdev, bytenr);
> > +	memalloc_nofs_restore(nofs_flag);
> 
> This is the wrong way to use memalloc_nofs_save/restore.  They should be
> used at the point that the filesystem takes/releases whatever lock is
> also used during reclaim.  I don't know btrfs well enough to suggest
> what lock is missing these annotations.

In principle I agree with you but in this particular case I agree the ask
is just too big. I suspect it is one of btrfs btree locks or maybe
chunk_mutex but I doubt even btrfs developers know and maybe it is just a
cargo cult. And it is not like this would be the first occurence of this
anti-pattern in btrfs - see e.g. device_list_add(), add_missing_dev(),
btrfs_destroy_delalloc_inodes() (here the wrapping around
invalidate_inode_pages2() looks really weird), and many others...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
