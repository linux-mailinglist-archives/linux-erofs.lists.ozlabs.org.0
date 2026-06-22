Return-Path: <linux-erofs+bounces-3719-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rdwlMs1iOWqarQcAu9opvQ
	(envelope-from <linux-erofs+bounces-3719-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jun 2026 18:29:01 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 378046B121B
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jun 2026 18:29:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=m5E0imAO;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=3Nm+2sw+;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=m5E0imAO;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=3Nm+2sw+;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3719-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3719-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=none;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gkYYN3PHlz2yVZ;
	Tue, 23 Jun 2026 02:28:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782145736;
	cv=none; b=jHXLbjFnfAWdmBibsThvOJ0ujot3FMDuO8KmH+gW2/no2Fr6pIHjFIiMPv2qapoTCzmfnlUYWDx4+n9S16vP3X3F7d1kyLvLSGAPjecObIjj38XK7KioZbSxZO/ItEIdbLRakMt9ju/j0WYtl/d4PD5RtWcUCPHX6A6qBhWH3SBRLb2B5euLy4xeU4nJbogt+GXrx+RtUpjWjXIUpHBFzVochXYMGeFS4pI1CrIo4ABrNnIfPOlzJM+tokRr64s/Z0svxhes2fm0boxTJMjhRsU36BhwJ30gXo0HZb1PJnzXKd1mRGtrIqxEZjeL88+pkqgvHHXT5JsBho0np6ME/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782145736; c=relaxed/relaxed;
	bh=t/zIwZ/HvE8Yfxq7RM+nQeQTJMtF0UIyIKXMFqtvFcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APAQs3+gpwxPFO3bzxXJU+AZLixQ6vSZfGwgU3QN3oc289YwR2A5QP+B8NhUpIRDlMfLstUowzseuuXcwLmRG4Mw07f0Q0Xv10taeBKmWoa7fspKu7QGXOEiV1agppWRpQP0DFgODkBndInrMQ9MKhrQz6e/JpAftjWtb4tCUQZ86ivAnTSmh4T/r5vcpj9o8FRBSOg2KdYUkio9ttTevgYOSS0mc1EcMiIDg/hcU8B3DsEthTSLaWN4PQ65EawtHuPqQuQ6xw6clKZ2aNM6Uy3pmcNbebVJdMOX+G7fYRw+9t8lF+tvOF3M2vmdkCuSNZLfT25oEntXsFVz1Ku2Fg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=suse.cz; dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=m5E0imAO; dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=3Nm+2sw+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=m5E0imAO; dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=3Nm+2sw+; dkim-atps=neutral; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de; envelope-from=jack@suse.cz; receiver=lists.ozlabs.org) smtp.mailfrom=suse.cz
X-Greylist: delayed 9514 seconds by postgrey-1.37 at boromir; Tue, 23 Jun 2026 02:28:55 AEST
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gkYYM0zJqz2xWR
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Jun 2026 02:28:53 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 474EB70913;
	Mon, 22 Jun 2026 16:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782145731; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t/zIwZ/HvE8Yfxq7RM+nQeQTJMtF0UIyIKXMFqtvFcM=;
	b=m5E0imAO7nBDkaG++YGb4yf6ftMPphP5MiMtSfS56RaYMUVKuNa1Lv8lzU3lGhpMAzddDB
	e7BHVNlSQQtFUGI+S8uE5dg34d4UydZWG7srcIkVoBCpxE7iZ42X6ZqmRf7hIxyt11MyJv
	QUP1n4EKalh20E27jjbi8Y/GUn4W8PY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782145731;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t/zIwZ/HvE8Yfxq7RM+nQeQTJMtF0UIyIKXMFqtvFcM=;
	b=3Nm+2sw+NjcJRwBbu3UEKlsq9NEl+Jxwhlg2J5WOiissqx1pnwqor/8HJjPt/6hhCUWEmk
	ymJ4m6lhUr/FQwAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782145731; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t/zIwZ/HvE8Yfxq7RM+nQeQTJMtF0UIyIKXMFqtvFcM=;
	b=m5E0imAO7nBDkaG++YGb4yf6ftMPphP5MiMtSfS56RaYMUVKuNa1Lv8lzU3lGhpMAzddDB
	e7BHVNlSQQtFUGI+S8uE5dg34d4UydZWG7srcIkVoBCpxE7iZ42X6ZqmRf7hIxyt11MyJv
	QUP1n4EKalh20E27jjbi8Y/GUn4W8PY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782145731;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t/zIwZ/HvE8Yfxq7RM+nQeQTJMtF0UIyIKXMFqtvFcM=;
	b=3Nm+2sw+NjcJRwBbu3UEKlsq9NEl+Jxwhlg2J5WOiissqx1pnwqor/8HJjPt/6hhCUWEmk
	ymJ4m6lhUr/FQwAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D974779A8;
	Mon, 22 Jun 2026 16:28:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id viUHD8NiOWo5VAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 22 Jun 2026 16:28:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D8F1BA093E; Mon, 22 Jun 2026 18:28:50 +0200 (CEST)
Date: Mon, 22 Jun 2026 18:28:50 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, 
	linux-ext4@vger.kernel.org, Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH RFC v2 08/18] fs: add dedicated block device open helpers
 for filesystems
Message-ID: <xlfnmwv2upjia6ozd4z5l5icaewor4a6cgkafnigulndzmt6r7@rhay3h3wablo>
References: <20260616-work-super-bdev_holder_global-v2-0-7df6b864028e@kernel.org>
 <20260616-work-super-bdev_holder_global-v2-8-7df6b864028e@kernel.org>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616-work-super-bdev_holder_global-v2-8-7df6b864028e@kernel.org>
X-Spam-Level: 
X-Spam-Score: -4.01
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:jack@suse.cz,m:hch@lst.de,m:axboe@kernel.dk,m:viro@zeniv.linux.org.uk,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:cem@kernel.org,m:linux-xfs@vger.kernel.org,m:clm@fb.com,m:dsterba@suse.com,m:linux-btrfs@vger.kernel.org,m:tytso@mit.edu,m:linux-ext4@vger.kernel.org,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[suse.cz];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jack@suse.cz,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-3719-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rhay3h3wablo:mid,suse.cz:dkim,suse.cz:from_mime,suse.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 378046B121B

On Tue 16-06-26 16:08:24, Christian Brauner wrote:
> Add fs_bdev_file_open_by_{dev,path}() and fs_bdev_file_release(). They
> open the device with fs_holder_ops and register a claim in the
> device-to-superblock table. Claims on the same (device, superblock)
> pair share one entry, so when a filesystem claims a device it already
> uses (xfs with its log on the data device), no second entry is added
> and each superblock will be acted on once.
> 
> The holder argument remains purely the block layer's exclusivity token:
> a superblock, or a file_system_type for a device shared by several
> superblocks of that type. The shared case only becomes usable once the
> fs_holder_ops callbacks resolve superblocks through the table instead
> of bdev->bd_holder.
> 
> Convert the main device, setup_bdev_super() and kill_block_super(),
> over: the open finds the entry registered by sget_fc() and claims it
> again. cramfs and romfs bypass kill_block_super() so they can handle
> MTD mounts and release the main device with a plain bdev_fput(), which
> would leave the claim behind: the (dev, sb) entry would never be
> unregistered and the passive reference it holds would keep the
> superblock alive forever. Convert their release paths in the same
> step.
> 
> The frozen-device check stays in setup_bdev_super() for the primary
> device and is added to fs_bdev_register() for new claims, i.e. every
> additional device a filesystem opens through the helpers. Only a
> (device, superblock) pair the superblock claimed earlier may be
> reopened while frozen (xfs with its log on the data device): the freeze
> already covers that superblock through the existing claim, so nothing
> escapes it. Without the setup_bdev_super() check a device frozen before
> the mount even started (dm lock_fs, loop) could be mounted and written
> to (journal replay) under an active freeze, because the primary open
> reuses the entry registered by sget_fc() and never takes the new-claim
> path.
> 
> Both checks read bd_fsfreeze_count only after the entry is published
> (by sget_fc() for the primary, by fs_bdev_register() for new claims)
> and pair with bdev_freeze() incrementing the count before walking the
> table: either the mount sees the elevated freeze count and fails with
> EBUSY, or the freeze finds the published entry and converges once
> SB_BORN is set.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

...

> +static int fs_bdev_register(struct file *bdev_file, struct super_block *sb)
> +{
> +	struct super_dev *sb_dev __free(kfree) = NULL;

Frankly I find the use of __free on sb_dev more confusing than helping in
this function. If you didn't use it, you could remove the somewhat
confusing retain_and_null_ptr() calls below, remove this initialization and
just put one kfree() into the error handling branch when super_dev_insert()
fails...

> +	dev_t dev = file_bdev(bdev_file)->bd_dev;
> +	int err;
> +
> +	scoped_guard(rcu) {
> +		sb_dev = super_dev_lookup(dev, sb);
> +		if (sb_dev && refcount_inc_not_zero(&sb_dev->sd_ref)) {
> +			retain_and_null_ptr(sb_dev);
> +			return 0;
> +		}
> +	}
> +
> +	sb_dev = super_dev_alloc(dev, sb);
> +	if (!sb_dev)
> +		return -ENOMEM;
> +
> +	err = super_dev_insert(sb_dev);
> +	if (err)
> +		return err;
> +
> +	/* Publish the entry before reading the count; pairs with bdev_freeze(). */
> +	smp_mb();
> +	if (atomic_read(&file_bdev(bdev_file)->bd_fsfreeze_count) > 0) {
> +		err = -EBUSY;
> +		super_dev_put(sb_dev);
> +	}
> +
> +	retain_and_null_ptr(sb_dev);
> +	return err;
> +}

...

> +/**
> + * fs_bdev_file_release - release a block device claimed for a superblock
> + * @bdev_file: file returned by fs_bdev_file_open_by_{dev,path}()
> + * @sb: superblock the device was claimed for
> + *
> + * Drop one claim on the {dev, @sb} entry; the last claim unregisters it (a
> + * pinning cursor defers the actual unlink).  Then close the block device.
> + */
> +void fs_bdev_file_release(struct file *bdev_file, struct super_block *sb)
> +{
> +	dev_t dev = file_bdev(bdev_file)->bd_dev;
> +	struct super_dev *sb_dev;
> +
> +	rcu_read_lock();
> +	sb_dev = super_dev_lookup(dev, sb);
> +	rcu_read_unlock();
> +	super_dev_put(sb_dev);
> +	bdev_fput(bdev_file);
> +}
> +EXPORT_SYMBOL_GPL(fs_bdev_file_release);

Why don't you use sb->s_super_dev in this function?

Otherwise the patch looks good to me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

