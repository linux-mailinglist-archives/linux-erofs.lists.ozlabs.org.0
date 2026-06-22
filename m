Return-Path: <linux-erofs+bounces-3714-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2IucMlE9OWpHpAcAu9opvQ
	(envelope-from <linux-erofs+bounces-3714-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jun 2026 15:49:05 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EABB26B0010
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jun 2026 15:49:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=S6GhM5Mv;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Ki6GgB3f;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=S6GhM5Mv;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Ki6GgB3f;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3714-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3714-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=none;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gkV0t5wRJz2xyh;
	Mon, 22 Jun 2026 23:49:02 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782136142;
	cv=none; b=XtkLFHBEV1JZC+Y1rA68g0Ge7zQKu6tm8jEX1AxDlaEnWX21D7IkFDBkwWX7OJrPfvLuWSiHyXygh9sHu3Yb6kquLrDoymqhnTqK+WHf/HbMhyYb8xJA7l3kyvKBUkhGvL7gnWYYa6Sqh6cWAVUoTlDomd5IKHUHBlW8t8e1AYrU6csE+mfdFUpVhxlcjAsIJfmub/RhK/qFm0QXcIOOdSM0+IYg1h8+6ADx6ThfT6idzSxiyU7jD9Qm9y3rkNYPxi+P01w6VIVyYJ2lS0xoSkVFYc0bPHy6HYgAUPQhtgeA6w9ZADrK6XGrTt4BtdJKTjCC55snxaSlHUYThI0xMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782136142; c=relaxed/relaxed;
	bh=MUDX91MsVhUVFXr0iW6meWtexXLIRn9u12ppWWQ8ZtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khu7rTJFxbOwtC6b6pXw/qh8X6MwBWRW3jYFvZGL5AD9bqm3uDmUs/Hl7CW0+BwixN1DuAbC6/nI10BcTsD0fMHfg3igq7LtmNJ7lzaLMBlYR7NlUAXVddZ6SSqG71VCaznIxiraOOP+55YyUzNIAb5bKTSx6IpFzHpXTxMFiwjDhSKAjcyFCT3frs3hcoXDj62tgX3lQP2Y0Y+261tk9c/nVHTRJT1rNuKqKtW6oPhPAgLVu/p2XVwnPTnvuRvMi/mV+Iq1N5FLeRi6jk+F10084yd2JyktlNagCyqZxba3pOkyg1dIZyZmYqMOBvxbVRwMTbPDNrByTjLxB5P3bw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=suse.cz; dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=S6GhM5Mv; dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Ki6GgB3f; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=S6GhM5Mv; dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Ki6GgB3f; dkim-atps=neutral; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=jack@suse.cz; receiver=lists.ozlabs.org) smtp.mailfrom=suse.cz
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gkV0p1fK9z2xSN
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Jun 2026 23:48:58 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B13C575BCD;
	Mon, 22 Jun 2026 13:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782136130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MUDX91MsVhUVFXr0iW6meWtexXLIRn9u12ppWWQ8ZtM=;
	b=S6GhM5Mvl0muVGAQvjp6ji4mhxU6HNVr+flCUaWJQBg9jCESmw5wR9aZuw+08k+iSC0bNR
	apozSNF2EGBLsKus6Tg54HwInUO/I533ytSpU4nquM3Z+hDjC9EzNciGYPzu2XjTRxqTWW
	hsbHvZTzr5hbHWwxXrst2PMZvV3ixmU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782136130;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MUDX91MsVhUVFXr0iW6meWtexXLIRn9u12ppWWQ8ZtM=;
	b=Ki6GgB3fnd/LVz5LAy0KPbQ0tnyDaLgKoBX3qnycEJI5yL/FYbOvlrQmx8PTJawh93xY/+
	1YEMacP1LqyjmSAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782136130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MUDX91MsVhUVFXr0iW6meWtexXLIRn9u12ppWWQ8ZtM=;
	b=S6GhM5Mvl0muVGAQvjp6ji4mhxU6HNVr+flCUaWJQBg9jCESmw5wR9aZuw+08k+iSC0bNR
	apozSNF2EGBLsKus6Tg54HwInUO/I533ytSpU4nquM3Z+hDjC9EzNciGYPzu2XjTRxqTWW
	hsbHvZTzr5hbHWwxXrst2PMZvV3ixmU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782136130;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MUDX91MsVhUVFXr0iW6meWtexXLIRn9u12ppWWQ8ZtM=;
	b=Ki6GgB3fnd/LVz5LAy0KPbQ0tnyDaLgKoBX3qnycEJI5yL/FYbOvlrQmx8PTJawh93xY/+
	1YEMacP1LqyjmSAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 994EB779A8;
	Mon, 22 Jun 2026 13:48:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iB9sJUI9OWp7OQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 22 Jun 2026 13:48:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 487B6A093E; Mon, 22 Jun 2026 15:48:42 +0200 (CEST)
Date: Mon, 22 Jun 2026 15:48:42 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, 
	linux-ext4@vger.kernel.org, Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH RFC v2 02/18] super: convert s_count to refcount_t
 s_passive
Message-ID: <qwij4swmsnvwgdt6zxz5ymy2mdvzgillz2u7fwaol22mdc4kv4@c6pptdtzpqkt>
References: <20260616-work-super-bdev_holder_global-v2-0-7df6b864028e@kernel.org>
 <20260616-work-super-bdev_holder_global-v2-2-7df6b864028e@kernel.org>
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
In-Reply-To: <20260616-work-super-bdev_holder_global-v2-2-7df6b864028e@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:jack@suse.cz,m:hch@lst.de,m:axboe@kernel.dk,m:viro@zeniv.linux.org.uk,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:cem@kernel.org,m:linux-xfs@vger.kernel.org,m:clm@fb.com,m:dsterba@suse.com,m:linux-btrfs@vger.kernel.org,m:tytso@mit.edu,m:linux-ext4@vger.kernel.org,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[suse.cz];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jack@suse.cz,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-3714-lists,linux-erofs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp,suse.com:email,suse.cz:dkim,suse.cz:email,suse.cz:from_mime,c6pptdtzpqkt:mid,et.al:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EABB26B0010

On Tue 16-06-26 16:08:18, Christian Brauner wrote:
> The superblock carries two counters: s_active, the active reference
> count that keeps the filesystem usable, and s_count, the passive
> reference count that merely keeps the structure itself alive. Turn the
> passive count into a refcount_t and rename it to s_passive to make the
> pairing with s_active obvious.
> 
> Everything is still serialized by sb_lock, so there is no functional
> change; the conversion buys the usual refcount_t saturation and
> underflow checking. The following patches start dropping passive
> references without holding sb_lock and make the device-to-superblock
> table hold one passive reference per registered entry, which a plain
> integer cannot support.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Yeah, looks like a reasonable cleanup. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/super.c                     | 18 +++++++++---------
>  include/linux/fs/super_types.h |  2 +-
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index a8fd61136aaf..25dd72b550e0 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -102,7 +102,7 @@ static bool super_flags(const struct super_block *sb, unsigned int flags)
>   * creation will succeed and SB_BORN is set by vfs_get_tree() or we're
>   * woken and we'll see SB_DYING.
>   *
> - * The caller must have acquired a temporary reference on @sb->s_count.
> + * The caller must have acquired a temporary reference on @sb->s_passive.
>   *
>   * Return: The function returns true if SB_BORN was set and with
>   *         s_umount held. The function returns false if SB_DYING was
> @@ -367,7 +367,7 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
>  	spin_lock_init(&s->s_inode_wblist_lock);
>  	fserror_mount(s);
>  
> -	s->s_count = 1;
> +	refcount_set(&s->s_passive, 1);
>  	atomic_set(&s->s_active, 1);
>  	mutex_init(&s->s_vfs_rename_mutex);
>  	lockdep_set_class(&s->s_vfs_rename_mutex, &type->s_vfs_rename_key);
> @@ -407,7 +407,7 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
>   */
>  static void __put_super(struct super_block *s)
>  {
> -	if (!--s->s_count) {
> +	if (refcount_dec_and_test(&s->s_passive)) {
>  		list_del_init(&s->s_list);
>  		WARN_ON(s->s_dentry_lru.node);
>  		WARN_ON(s->s_inode_lru.node);
> @@ -529,7 +529,7 @@ static bool grab_super(struct super_block *sb)
>  {
>  	bool locked;
>  
> -	sb->s_count++;
> +	refcount_inc(&sb->s_passive);
>  	spin_unlock(&sb_lock);
>  	locked = super_lock_excl(sb);
>  	if (locked) {
> @@ -556,7 +556,7 @@ static bool grab_super(struct super_block *sb)
>   *	lock held in read mode in case of success. On successful return,
>   *	the caller must drop the s_umount lock when done.
>   *
> - *	Note that unlike get_super() et.al. this one does *not* bump ->s_count.
> + *	Note that unlike get_super() et.al. this one does *not* bump ->s_passive.
>   *	The reason why it's safe is that we are OK with doing trylock instead
>   *	of down_read().  There's a couple of places that are OK with that, but
>   *	it's very much not a general-purpose interface.
> @@ -858,7 +858,7 @@ static void __iterate_supers(void (*f)(struct super_block *, void *), void *arg,
>  	     sb = next_super(sb, flags)) {
>  		if (super_flags(sb, SB_DYING))
>  			continue;
> -		sb->s_count++;
> +		refcount_inc(&sb->s_passive);
>  		spin_unlock(&sb_lock);
>  
>  		if (flags & SUPER_ITER_UNLOCKED) {
> @@ -903,7 +903,7 @@ void iterate_supers_type(struct file_system_type *type,
>  		if (super_flags(sb, SB_DYING))
>  			continue;
>  
> -		sb->s_count++;
> +		refcount_inc(&sb->s_passive);
>  		spin_unlock(&sb_lock);
>  
>  		locked = super_lock_shared(sb);
> @@ -935,7 +935,7 @@ struct super_block *user_get_super(dev_t dev, bool excl)
>  		if (sb->s_dev != dev)
>  			continue;
>  
> -		sb->s_count++;
> +		refcount_inc(&sb->s_passive);
>  		spin_unlock(&sb_lock);
>  
>  		locked = super_lock(sb, excl);
> @@ -1369,7 +1369,7 @@ static struct super_block *bdev_super_lock(struct block_device *bdev, bool excl)
>  
>  	/* Make sure sb doesn't go away from under us */
>  	spin_lock(&sb_lock);
> -	sb->s_count++;
> +	refcount_inc(&sb->s_passive);
>  	spin_unlock(&sb_lock);
>  
>  	mutex_unlock(&bdev->bd_holder_lock);
> diff --git a/include/linux/fs/super_types.h b/include/linux/fs/super_types.h
> index ef7941e9dc79..68747182abf9 100644
> --- a/include/linux/fs/super_types.h
> +++ b/include/linux/fs/super_types.h
> @@ -145,7 +145,7 @@ struct super_block {
>  	unsigned long				s_magic;
>  	struct dentry				*s_root;
>  	struct rw_semaphore			s_umount;
> -	int					s_count;
> +	refcount_t				s_passive;
>  	atomic_t				s_active;
>  #ifdef CONFIG_SECURITY
>  	void					*s_security;
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

