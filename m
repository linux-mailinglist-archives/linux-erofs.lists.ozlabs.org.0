Return-Path: <linux-erofs+bounces-3718-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7MkrJvxbOWparAcAu9opvQ
	(envelope-from <linux-erofs+bounces-3718-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jun 2026 17:59:56 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BDD6B0EE5
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jun 2026 17:59:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Cabax5Pl;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=OIAY1LiX;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Cabax5Pl;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=OIAY1LiX;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3718-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3718-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=none;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gkXvs3NpJz2yVZ;
	Tue, 23 Jun 2026 01:59:53 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782143993;
	cv=none; b=QXeofscF42FI4A28MkYevf2rCGK7653PO4z96z8PUYMcEWNKPhBASc0oS8sNOxhZxrPJUGwprmjFzAgyPVgydAduZm/io/C9fZFA4itzIDyktq8befEJCVyfet6i6YbHHQNrceHAuQ9YRgaQKQterykVCHbMXYL33fZ002IduEjPwa91jLBTX1GJP5y2bba4VtFfQndwF96GfXqYwRhtZmKQ1oo80aNJu7YvseKZfImXY1mfnqXSfKReXwvOy62UiCDB3qKUXQc8KCOr+jMEvH/I6h/xoy9iQVLBZSjJK5ELmXD4Fq3qTA93J2tv0PzAU5M0k9T1o4BztBe+uKSAnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782143993; c=relaxed/relaxed;
	bh=h6knUy8F3m1oXi5b+TXPJbgR+BITHS6opkZcdu/3iK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onVeGwXeLA9octM2I80sACS2Eglw+R24EU4W2+TQQTfn+3AgYROiFPrINaurMKlrEwZkl85kAlxBn2Bf83+IJ3g+k5g/mYW778331dUxroeXQgnOvtZCeKARdQNy2FBXlPTyV3TiVe5GXZgIQQDo7wtVKV4QZoCunekE2/yxQ6k1QHRbwaBShyyfZUB/MKA6chznFGmSTy4tTtw5gjkNlEo/Dm6j7uUZK2YFxJSi3rSEVsshSqOthXNkmNVl/kS75fWf6LiRPMfRed8ww9gaM1SR5Y4aHuFf2MmR4WcvNZwhjSnDDTHuCVw3J2Fr0nI5Uq20L5qtb0K7jfTxcuXsPg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=suse.cz; dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=Cabax5Pl; dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=OIAY1LiX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=Cabax5Pl; dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=OIAY1LiX; dkim-atps=neutral; spf=pass (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=jack@suse.cz; receiver=lists.ozlabs.org) smtp.mailfrom=suse.cz
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gkXvr1pMtz2xSN
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Jun 2026 01:59:51 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 15ED575A6F;
	Mon, 22 Jun 2026 15:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782143989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h6knUy8F3m1oXi5b+TXPJbgR+BITHS6opkZcdu/3iK0=;
	b=Cabax5Pl3wsru4Et0M8skqd3LegoRFWpPxZ6xjCKkmOTiAS/5LoHvcglH3yg/XzRbeDSQZ
	rMucXdDy5LPmohjhZ6cIn0A+tzgGVIEag/IW68+y/HxSCUmJlDmhPI6o0XdvVxDPFOouPV
	7YPnCGlEo7oIUaW8s9UdFFELCRsJrgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782143989;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h6knUy8F3m1oXi5b+TXPJbgR+BITHS6opkZcdu/3iK0=;
	b=OIAY1LiXDw1e08TdfKG7mni+mYA/LJ97FfGIQz617LpXVuK6HEX+9C9b/K4NygjynAJ6EK
	qDqnleINAj8vdlDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782143989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h6knUy8F3m1oXi5b+TXPJbgR+BITHS6opkZcdu/3iK0=;
	b=Cabax5Pl3wsru4Et0M8skqd3LegoRFWpPxZ6xjCKkmOTiAS/5LoHvcglH3yg/XzRbeDSQZ
	rMucXdDy5LPmohjhZ6cIn0A+tzgGVIEag/IW68+y/HxSCUmJlDmhPI6o0XdvVxDPFOouPV
	7YPnCGlEo7oIUaW8s9UdFFELCRsJrgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782143989;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h6knUy8F3m1oXi5b+TXPJbgR+BITHS6opkZcdu/3iK0=;
	b=OIAY1LiXDw1e08TdfKG7mni+mYA/LJ97FfGIQz617LpXVuK6HEX+9C9b/K4NygjynAJ6EK
	qDqnleINAj8vdlDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 083E0779A8;
	Mon, 22 Jun 2026 15:59:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EF0BAvVbOWr3OAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 22 Jun 2026 15:59:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9A86EA093E; Mon, 22 Jun 2026 17:59:44 +0200 (CEST)
Date: Mon, 22 Jun 2026 17:59:44 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, 
	linux-ext4@vger.kernel.org, Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH RFC v2 07/18] fs: maintain a global device-to-superblock
 table
Message-ID: <oeagmkdw57p4xevvqobz7fuszjjmvosab45gfos4eas7iqus3l@6abhneekgchc>
References: <20260616-work-super-bdev_holder_global-v2-0-7df6b864028e@kernel.org>
 <20260616-work-super-bdev_holder_global-v2-7-7df6b864028e@kernel.org>
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
In-Reply-To: <20260616-work-super-bdev_holder_global-v2-7-7df6b864028e@kernel.org>
X-Spam-Level: 
X-Spam-Score: -4.01
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:jack@suse.cz,m:hch@lst.de,m:axboe@kernel.dk,m:viro@zeniv.linux.org.uk,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:cem@kernel.org,m:linux-xfs@vger.kernel.org,m:clm@fb.com,m:dsterba@suse.com,m:linux-btrfs@vger.kernel.org,m:tytso@mit.edu,m:linux-ext4@vger.kernel.org,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[suse.cz];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jack@suse.cz,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-3718-lists,linux-erofs=lfdr.de];
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
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.cz:from_mime,suse.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A8BDD6B0EE5

On Tue 16-06-26 16:08:23, Christian Brauner wrote:
> fs_holder_ops recovers the owning superblock from bdev->bd_holder, which
> forces the holder to be exactly one superblock and prevents several
> superblocks from sharing one block device. That's what erofs is doing.
> 
> As a first step introduce a global dev_t-keyed rhltable mapping each
> device to the superblock(s) using it. The entry is preallocated in
> alloc_super() and registered under sb->s_dev by the set callback through
> set_anon_super() and set_bdev_super(), the two helpers every set
> callback assigns s_dev through. Registration is the final fallible act
> of a set callback, so an insert failure unwinds through sget_fc()'s
> existing set-failure path: the fs_context keeps ownership of s_fs_info
> and the callers' error paths stay correct. set_anon_super() releases
> the anonymous dev it allocated when registration fails. Unwinding
> through deactivate_locked_super() instead would run kill_sb() and free
> s_fs_info behind the caller's back: nfs and ceph free that object
> through a local pointer when sget_fc() fails and would double-free.
> 
> The superblock stashes the entry in sb->s_super_dev and
> kill_super_notify() drops the claim through it, so teardown doesn't
> depend on s_dev staying stable; an entry that was never registered is
> freed together with the superblock in destroy_super_work().
> 
> Each table entry holds a passive reference (s_passive) on its
> superblock, so the struct stays valid for as long as the entry is
> reachable. Entries are claim-counted through sd_ref: additional claims
> on the same (device, superblock) pair share the entry, and the unlink
> is deferred to the last put, so a later iteration cursor never resumes
> from a removed node.
> 
> The table is initialized from mnt_init(): the first superblocks (the
> tmpfs shm mount and rootfs) are created from start_kernel() long before
> any initcall runs, so an initcall would be too late.
> 
> The table has no readers yet; the fs_holder_ops callbacks are switched
> over once all devices a filesystem claims are registered.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/internal.h                  |   1 +
>  fs/namespace.c                 |   2 +
>  fs/super.c                     | 102 ++++++++++++++++++++++++++++++++++++++++-
>  include/linux/fs/super_types.h |   2 +
>  4 files changed, 105 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/internal.h b/fs/internal.h
> index d77578d66d42..83eb3e2a0f85 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -137,6 +137,7 @@ extern int reconfigure_super(struct fs_context *);
>  extern bool super_trylock_shared(struct super_block *sb);
>  struct super_block *user_get_super(dev_t, bool excl);
>  void put_super(struct super_block *sb);
> +void __init super_dev_init(void);
>  extern bool mount_capable(struct fs_context *);
>  int sb_init_dio_done_wq(struct super_block *sb);
>  
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 3d5cd5bf3b05..7cef6dae0854 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -6262,6 +6262,8 @@ void __init mnt_init(void)
>  	if (!mount_hashtable || !mountpoint_hashtable)
>  		panic("Failed to allocate mount hash table\n");
>  
> +	super_dev_init();
> +
>  	kernfs_init();
>  
>  	err = sysfs_init();
> diff --git a/fs/super.c b/fs/super.c
> index a771a0ad4c9a..ff5e305d0ab4 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -24,6 +24,7 @@
>  #include <linux/export.h>
>  #include <linux/slab.h>
>  #include <linux/blkdev.h>
> +#include <linux/rhashtable.h>
>  #include <linux/mount.h>
>  #include <linux/security.h>
>  #include <linux/writeback.h>		/* for the emergency remount stuff */
> @@ -272,6 +273,8 @@ static unsigned long super_cache_count(struct shrinker *shrink,
>  	return total_objects;
>  }
>  
> +static struct super_dev *super_dev_alloc(dev_t dev, struct super_block *sb);
> +
>  static void destroy_super_work(struct work_struct *work)
>  {
>  	struct super_block *s = container_of(work, struct super_block,
> @@ -279,6 +282,8 @@ static void destroy_super_work(struct work_struct *work)
>  	fsnotify_sb_free(s);
>  	security_sb_free(s);
>  	put_user_ns(s->s_user_ns);
> +	/* Only an unregistered entry is still owned by the superblock. */
> +	kfree(s->s_super_dev);
>  	kfree(s->s_subtype);
>  	for (int i = 0; i < SB_FREEZE_LEVELS; i++)
>  		percpu_free_rwsem(&s->s_writers.rw_sem[i]);
> @@ -392,6 +397,10 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
>  		goto fail;
>  	if (list_lru_init_memcg(&s->s_inode_lru, s->s_shrink))
>  		goto fail;
> +	s->s_super_dev = super_dev_alloc(0, s);
> +	if (!s->s_super_dev)
> +		goto fail;
> +
>  	s->s_min_writeback_pages = MIN_WRITEBACK_PAGES;
>  	return s;
>  
> @@ -421,6 +430,77 @@ void put_super(struct super_block *s)
>  	}
>  }
>  
> +struct super_dev {
> +	dev_t			sd_dev;
> +	struct super_block	*sd_sb;
> +	refcount_t		sd_ref;
> +	struct rhlist_head	sd_node;
> +	struct rcu_head		sd_rcu;
> +};
> +
> +static struct rhltable super_dev_table;
> +static const struct rhashtable_params super_dev_params = {
> +	.key_len	= sizeof(dev_t),
> +	.key_offset	= offsetof(struct super_dev, sd_dev),
> +	.head_offset	= offsetof(struct super_dev, sd_node),
> +};
> +
> +static struct super_dev *super_dev_alloc(dev_t dev, struct super_block *sb)
> +{
> +	struct super_dev *fsd;
> +
> +	fsd = kzalloc_obj(*fsd);
> +	if (!fsd)
> +		return NULL;
> +	fsd->sd_dev = dev;
> +	fsd->sd_sb = sb;
> +	refcount_set(&fsd->sd_ref, 1);
> +	return fsd;
> +}
> +
> +static void super_dev_put(struct super_dev *fsd)
> +{
> +	/* Unlink only once unpinned, so a cursor never resumes from a removed node. */
> +	if (fsd && refcount_dec_and_test(&fsd->sd_ref)) {
> +		rhltable_remove(&super_dev_table, &fsd->sd_node, super_dev_params);
> +		put_super(fsd->sd_sb);
> +		kfree_rcu(fsd, sd_rcu);
> +	}
> +}
> +
> +void __init super_dev_init(void)
> +{
> +	if (rhltable_init(&super_dev_table, &super_dev_params))
> +		panic("VFS: Cannot initialise super_dev_table\n");
> +}
> +
> +static int super_dev_insert(struct super_dev *fsd)
> +{
> +	int err;
> +
> +	err = rhltable_insert(&super_dev_table, &fsd->sd_node, super_dev_params);
> +	if (!err)
> +		refcount_inc(&fsd->sd_sb->s_passive);
> +	return err;
> +}
> +
> +/* Register @sb under @sb->s_dev as the final fallible act of a set callback. */
> +static int super_dev_register(struct super_block *sb)
> +{
> +	struct super_dev *fsd = sb->s_super_dev;
> +	int err;
> +
> +	lockdep_assert_held(&sb_lock);
> +	VFS_WARN_ON_ONCE(!sb->s_dev);
> +	VFS_WARN_ON_ONCE(!fsd || fsd->sd_dev);
> +
> +	fsd->sd_dev = sb->s_dev;
> +	err = super_dev_insert(fsd);
> +	if (err)
> +		fsd->sd_dev = 0;
> +	return err;
> +}
> +
>  static void kill_super_notify(struct super_block *sb)
>  {
>  	lockdep_assert_not_held(&sb->s_umount);
> @@ -440,6 +520,12 @@ static void kill_super_notify(struct super_block *sb)
>  	hlist_del_init(&sb->s_instances);
>  	spin_unlock(&sb_lock);
>  
> +	/* Drop sget_fc()'s claim; a never-registered entry stays with the sb. */
> +	if (sb->s_super_dev->sd_dev) {
> +		super_dev_put(sb->s_super_dev);
> +		sb->s_super_dev = NULL;
> +	}
> +
>  	/*
>  	 * Let concurrent mounts know that this thing is really dead.
>  	 * We don't need @sb->s_umount here as every concurrent caller
> @@ -750,6 +836,7 @@ struct super_block *sget_fc(struct fs_context *fc,
>  	}
>  	if (!s) {
>  		spin_unlock(&sb_lock);
> +
>  		s = alloc_super(fc->fs_type, fc->sb_flags, user_ns);
>  		if (!s)
>  			return ERR_PTR(-ENOMEM);
> @@ -759,11 +846,13 @@ struct super_block *sget_fc(struct fs_context *fc,
>  	s->s_fs_info = fc->s_fs_info;
>  	err = set(s, fc);
>  	if (err) {
> +		VFS_WARN_ON_ONCE(s->s_super_dev->sd_dev);
>  		s->s_fs_info = NULL;
>  		spin_unlock(&sb_lock);
>  		destroy_unused_super(s);
>  		return ERR_PTR(err);
>  	}
> +	VFS_WARN_ON_ONCE(!s->s_super_dev->sd_dev);
>  	fc->s_fs_info = NULL;
>  	s->s_type = fc->fs_type;
>  	s->s_iflags |= fc->s_iflags;
> @@ -1217,7 +1306,16 @@ EXPORT_SYMBOL(free_anon_bdev);
>  
>  int set_anon_super(struct super_block *s, void *data)
>  {
> -	return get_anon_bdev(&s->s_dev);
> +	int error;
> +
> +	error = get_anon_bdev(&s->s_dev);
> +	if (error)
> +		return error;
> +
> +	error = super_dev_register(s);
> +	if (error)
> +		free_anon_bdev(s->s_dev);
> +	return error;
>  }
>  EXPORT_SYMBOL(set_anon_super);
>  
> @@ -1303,7 +1401,7 @@ EXPORT_SYMBOL(get_tree_keyed);
>  static int set_bdev_super(struct super_block *s, void *data)
>  {
>  	s->s_dev = *(dev_t *)data;
> -	return 0;
> +	return super_dev_register(s);
>  }
>  
>  static int super_s_dev_set(struct super_block *s, struct fs_context *fc)
> diff --git a/include/linux/fs/super_types.h b/include/linux/fs/super_types.h
> index 68747182abf9..c8172558750f 100644
> --- a/include/linux/fs/super_types.h
> +++ b/include/linux/fs/super_types.h
> @@ -30,6 +30,7 @@ struct mount;
>  struct mtd_info;
>  struct quotactl_ops;
>  struct shrinker;
> +struct super_dev;
>  struct unicode_map;
>  struct user_namespace;
>  struct workqueue_struct;
> @@ -132,6 +133,7 @@ struct super_operations {
>  struct super_block {
>  	struct list_head			s_list;		/* Keep this first */
>  	dev_t					s_dev;		/* search index; _not_ kdev_t */
> +	struct super_dev			*s_super_dev;	/* sget_fc()'s device table claim */
>  	unsigned char				s_blocksize_bits;
>  	unsigned long				s_blocksize;
>  	loff_t					s_maxbytes;	/* Max file size */
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

