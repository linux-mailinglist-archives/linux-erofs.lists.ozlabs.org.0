Return-Path: <linux-erofs+bounces-3755-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0gfxLdgZPGp0jwgAu9opvQ
	(envelope-from <linux-erofs+bounces-3755-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Jun 2026 19:54:32 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5236C0841
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Jun 2026 19:54:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ohfBN4CZ;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3755-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3755-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4glqM40ytTz2xwL;
	Thu, 25 Jun 2026 03:54:24 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782323664;
	cv=none; b=K/r8havvkfRxdGsOI2h74uHXDmCYNJ27cBxFMcCPpCgrZMmz0PzFE5q4KI0ubcrd0k8N7tgCUnLG4B3LNLL9SdPUecvoo/DE6tvltc/ksf0rcVL/jE6s2cEtJ3PALu1WTRN4h7BDOV9xjqPDTAxbWXPHAy4o1RGX+JLA/b/+IgFb37fd1MjahzsJeVLB/bzYpRbI9ByfyAcTdt7kYMD0bCwKaSUIotQCJIhqjaJQ4rb1BgO4tH3q1OKtiKrSib8rkBwzIqqb1p9NeO/9WQlHWxav2dzCdDz+jZoM/Y7L8PVDJ+L8WUaXU28/R35i66ChgoeAGvZ9ZcxpDc75K36czg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782323664; c=relaxed/relaxed;
	bh=n2E8Koujq0uvPGlna4mr7jMR9YCJEf6gPjQNGHvZ2Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8LFdY8aecmZVz4H1sPC2pgv2vU8rC1emHteeRTWQlXfxhd9zP1c7ZvzznphcZRhs0Qli3uZYXUoE4PzqJvBP84yEbmbXeDd6k5oQUUI38d1KGxZO66mRBt8wPPg/QmQpoffdrbva8Q+CcVj2aFqTMAgBUytUgjM9uvC+yP4wZcPf4BikcsJXIGVW5GLengXMjXe6FqwPRHXf92IPNjbbVjD8Fnovk9M0hhC3UXpYxeieumqR8YQ5eDKCiEBa48owum5YNHgYjhp8kpRKwdXgN5IAAkizi9r4tG/kL2VSnUu3+B9MX7qn/BiKeEqQFlYfTw6R+gJ5H1seq6+ZW2HBQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ohfBN4CZ; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=djwong@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4glqM22f3Gz2xnK
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 Jun 2026 03:54:21 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with UTF8SMTP id 9D06260018;
	Wed, 24 Jun 2026 17:54:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 45C4B1F000E9;
	Wed, 24 Jun 2026 17:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782323658;
	bh=n2E8Koujq0uvPGlna4mr7jMR9YCJEf6gPjQNGHvZ2Xo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ohfBN4CZZ+vdeOflw8EvU1hiNw7Nq80ZI6Zr27sQqO5v8JF7ljFlttrPJC1sI5V/N
	 0zSO9m3aJYF+OYHHOgJVoU/sFRfwrs57uyo3jWjdYtWVA7J0RZDzkqD+RNB746PVoV
	 gfADQGfGId9SX4S1M4EgpByHV3jDu57fG/RWw2HRXjHnfG88CbLSg1bSQg3gIdgHDt
	 FXBy+ovvi91tczo0SiyacfoLP6MhlbuwJdrmDN7+b5zyIcw27QgL/Iizbs11DMIIn6
	 JmsmUQGUUx/poPPzQu+y/eSgjIgeucDjs/jOr6H7PZsqVBTMC1m9EOtnMSNdh6E0Cw
	 h5Z9XbPkv00ug==
Date: Wed, 24 Jun 2026 10:54:17 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Carlos Maiolino <cem@kernel.org>,
	linux-xfs@vger.kernel.org, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
	Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH RFC v2 17/18] fs: look up the superblock via the device
 table in user_get_super()
Message-ID: <20260624175417.GU6078@frogsfrogsfrogs>
References: <20260616-work-super-bdev_holder_global-v2-0-7df6b864028e@kernel.org>
 <20260616-work-super-bdev_holder_global-v2-17-7df6b864028e@kernel.org>
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
In-Reply-To: <20260616-work-super-bdev_holder_global-v2-17-7df6b864028e@kernel.org>
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:jack@suse.cz,m:hch@lst.de,m:axboe@kernel.dk,m:viro@zeniv.linux.org.uk,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:cem@kernel.org,m:linux-xfs@vger.kernel.org,m:clm@fb.com,m:dsterba@suse.com,m:linux-btrfs@vger.kernel.org,m:tytso@mit.edu,m:linux-ext4@vger.kernel.org,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[djwong@kernel.org,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3755-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp,frogsfrogsfrogs:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BD5236C0841

On Tue, Jun 16, 2026 at 04:08:33PM +0200, Christian Brauner wrote:
> user_get_super() still finds the superblock for a device number by
> walking the global super_blocks list under sb_lock. Every superblock is
> registered in the device table under its s_dev since sget_fc() inserts
> it there, including superblocks on anonymous devices, so use the table
> instead.
> 
> The refcount-pinning cursor helpers super_dev_{get,first,next}() only
> touch table state and do not depend on CONFIG_BLOCK, so drop the
> CONFIG_BLOCK guard around them: their new caller serves anonymous
> devices as well (ustat() on e.g. tmpfs) and is built without
> CONFIG_BLOCK. The guard falls in this patch rather than separately
> since without this caller the helpers would be unused without
> CONFIG_BLOCK.
> 
> The pinned entry holds a passive reference on the superblock so
> super_lock() can be called directly; once the superblock is locked grab
> a passive reference for the caller before dropping the pin.
> 
> The device table contains more than the old walk could find: a
> superblock is also registered for every additional device it claims
> (the xfs log and realtime devices, btrfs member devices, the ext4
> external journal, erofs blob devices). Don't filter those out:
> specifying any device a filesystem uses now resolves to that
> filesystem, so ustat() and quotactl() work on e.g. the xfs log device
> or a btrfs member device (the latter used to fail outright as btrfs
> superblocks carry an anonymous s_dev that never matches a member
> device). When several superblocks share a device (erofs blob devices)
> the first live superblock wins.

Does erofs have a means to find the other superblocks that share a
device given a notification coming in on one of them?  As hch says, it
feels weird to have a lookup mechanism when there's also an upcall
mechanism.

<shrug> I've been on vacation for a while so maybe I missed that there's
another use for the bdev->sb lookup?  There are 1600 more emails for me
to go through... :P

--D

> 
> The cursor also keeps scanning past dying superblocks where the old
> walk gave up after the first s_dev match, so a mount racing with the
> unmount of the same device (or with the reuse of a recycled anonymous
> dev_t) finds the live superblock where the old walk could spuriously
> return NULL.
> 
> This removes the last s_dev-keyed walk of the super_blocks list and
> takes ustat() and quotactl()'s block device lookup off sb_lock
> entirely.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/super.c | 28 ++++++++--------------------
>  1 file changed, 8 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 2d0a07861bfc..93f24aea75c4 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -501,7 +501,6 @@ static int super_dev_register(struct super_block *sb)
>  	return err;
>  }
>  
> -#ifdef CONFIG_BLOCK
>  static struct super_dev *super_dev_get(struct rhlist_head *pos)
>  {
>  	struct super_dev *sb_dev;
> @@ -535,7 +534,6 @@ static struct super_dev *super_dev_next(struct super_dev *prev)
>  	super_dev_put(prev);
>  	return sb_dev;
>  }
> -#endif
>  
>  static void kill_super_notify(struct super_block *sb)
>  {
> @@ -1044,29 +1042,19 @@ EXPORT_SYMBOL(iterate_supers_type);
>  
>  struct super_block *user_get_super(dev_t dev, bool excl)
>  {
> -	struct super_block *sb;
> -
> -	spin_lock(&sb_lock);
> -	list_for_each_entry(sb, &super_blocks, s_list) {
> -		bool locked;
> +	struct super_dev *sb_dev;
>  
> -		if (sb->s_dev != dev)
> -			continue;
> +	for (sb_dev = super_dev_first(dev); sb_dev; sb_dev = super_dev_next(sb_dev)) {
> +		struct super_block *sb = sb_dev->sd_sb;
>  
> -		if (!refcount_inc_not_zero(&sb->s_passive))
> +		if (!super_lock(sb, excl))
>  			continue;
>  
> -		spin_unlock(&sb_lock);
> -
> -		locked = super_lock(sb, excl);
> -		if (locked)
> -			return sb;
> -
> -		put_super(sb);
> -		spin_lock(&sb_lock);
> -		break;
> +		/* The pinned entry holds a passive reference, take our own. */
> +		refcount_inc(&sb->s_passive);
> +		super_dev_put(sb_dev);
> +		return sb;
>  	}
> -	spin_unlock(&sb_lock);
>  	return NULL;
>  }
>  
> 
> -- 
> 2.47.3
> 
> 

