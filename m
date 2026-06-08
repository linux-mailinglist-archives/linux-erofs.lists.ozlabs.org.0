Return-Path: <linux-erofs+bounces-3529-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /t9LK+uSJmrNYwIAu9opvQ
	(envelope-from <linux-erofs+bounces-3529-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 08 Jun 2026 12:01:15 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E01654D02
	for <lists+linux-erofs@lfdr.de>; Mon, 08 Jun 2026 12:01:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=rRGiR2I3;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="uTb/eIj1";
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=rRGiR2I3;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="uTb/eIj1";
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3529-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3529-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=none;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYncS54gtz2yR5;
	Mon, 08 Jun 2026 20:01:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780912872;
	cv=none; b=E/mqJjIs5+7rKaV3OoHHDsVFSLxoFUCoGbLz6fmWMN44M5S7P/KYKWnWyiohnnSANSybVxHnwNI/SwYp8k1PmtmTRFVbS79rtEinTjihE6xxAcx08hI6W2zoSli0XMMAWfIlKo3RLgulCyQb24aHkJQXUe2ypjmuOumBxjctn4n2RWhmihayg+lBlF1GDWP8o4uR7R6N32OYNueCNYWMhiuvJnsooJ2YpIuslncw+ogKEqGwEP8WcBgX1SFgWCsxk5iK1CLchL0VR/SjSzGGgKaM6p+VsgY7Yetq3waRHwCWzCrwOnwYLPn0qws3gtW/a+qCHUSrmq4V9/ecIvaDDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780912872; c=relaxed/relaxed;
	bh=MIDE+rHXoUrjVltLbrUUw2XWHk0UZNkmIFDDfUGj8p0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCEnoD8O1Q5yHHnpOGtEhNToEg2btD+LpWSn5skNKd1uaKdo/6U9Lv2cotU5SX64D3mNW9a6goNb4h8wUfy2McQTrvNjms1eWcYzIkP7f2fWU/4t54KhZty6GmgbT0+N7Nfm9XW4YkdT/k+A8er6Sdne8aBqr86YDgtRqhv9idx2fiIyV7ABvmITvi1NVuzEv41ijk46nQIrOJMRv/palocyuiHfj31zgLql+8PRMWlUMfMqSWV1GaqVuNkyeowFP63SHZoWdEYcz+Tt4+X/NSh+a/MoJxlYT/2W/UDTMqTpzg8cA7FlO5mp+E+iKxGgc/xgYGSUifIdNf6ccW0xCQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=suse.cz; dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=rRGiR2I3; dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=uTb/eIj1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=rRGiR2I3; dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=uTb/eIj1; dkim-atps=neutral; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=jack@suse.cz; receiver=lists.ozlabs.org) smtp.mailfrom=suse.cz
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gYncS0m6Cz2xWP
	for <linux-erofs@lists.ozlabs.org>; Mon, 08 Jun 2026 20:01:12 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B826A67C9D;
	Mon,  8 Jun 2026 10:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780912869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MIDE+rHXoUrjVltLbrUUw2XWHk0UZNkmIFDDfUGj8p0=;
	b=rRGiR2I3YRUllXedB6of680cGQ8l8kLSW/ZGz+GDOxHgQQ9p4XjrcZ0nrv7fv71dPjCqvx
	y/Ptq2nOSFOByR4kX3ci4W6gGhOIhVUZbF7Q1GAfH4iAImUjk2tCwLgFky6z8BYNJnb8Pe
	xJCPN5urKkFhy9Xpbj9Hdnp2L7zKXFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780912869;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MIDE+rHXoUrjVltLbrUUw2XWHk0UZNkmIFDDfUGj8p0=;
	b=uTb/eIj16FpASc44P3EjTeP4SHzsflhbLmYs6/N68mpyrKvRFd20/GoFyJXifi7QR1dgW9
	ALaTxzDXN+BM0YDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780912869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MIDE+rHXoUrjVltLbrUUw2XWHk0UZNkmIFDDfUGj8p0=;
	b=rRGiR2I3YRUllXedB6of680cGQ8l8kLSW/ZGz+GDOxHgQQ9p4XjrcZ0nrv7fv71dPjCqvx
	y/Ptq2nOSFOByR4kX3ci4W6gGhOIhVUZbF7Q1GAfH4iAImUjk2tCwLgFky6z8BYNJnb8Pe
	xJCPN5urKkFhy9Xpbj9Hdnp2L7zKXFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780912869;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MIDE+rHXoUrjVltLbrUUw2XWHk0UZNkmIFDDfUGj8p0=;
	b=uTb/eIj16FpASc44P3EjTeP4SHzsflhbLmYs6/N68mpyrKvRFd20/GoFyJXifi7QR1dgW9
	ALaTxzDXN+BM0YDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF226779A7;
	Mon,  8 Jun 2026 10:01:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U/aqKuWSJmoDJwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 08 Jun 2026 10:01:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5B6AFA10CB; Mon, 08 Jun 2026 12:01:09 +0200 (CEST)
Date: Mon, 8 Jun 2026 12:01:09 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>, 
	Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, 
	linux-ext4@vger.kernel.org, Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH RFC 3/8] fs: refuse to claim any frozen block device
Message-ID: <tm5nvcqgcyi37gpjvayettp22wkovzk3wr5wj5mcmmkmygj5f5@teavlw6bbmwf>
References: <20260602-work-super-bdev_holder_global-v1-0-bb0fd82f3861@kernel.org>
 <20260602-work-super-bdev_holder_global-v1-3-bb0fd82f3861@kernel.org>
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
In-Reply-To: <20260602-work-super-bdev_holder_global-v1-3-bb0fd82f3861@kernel.org>
X-Spam-Score: -3.80
X-Spam-Level: 
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
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:hch@lst.de,m:jack@suse.cz,m:axboe@kernel.dk,m:viro@zeniv.linux.org.uk,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:cem@kernel.org,m:linux-xfs@vger.kernel.org,m:clm@fb.com,m:dsterba@suse.com,m:linux-btrfs@vger.kernel.org,m:tytso@mit.edu,m:linux-ext4@vger.kernel.org,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[suse.cz];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jack@suse.cz,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-3529-lists,linux-erofs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C9E01654D02

On Tue 02-06-26 12:10:09, Christian Brauner wrote:
> setup_bdev_super() already refuses to bring a filesystem up on a frozen
> block device but only for the primary device. Now that filesystems claim
> every device through fs_bdev_file_open_by_{dev,path}(), do that check
> once in the registration helper so it covers all of them.
> 
> Drop the now-redundant check from setup_bdev_super().
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/super.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index e0174d5819a0..cea743f699e4 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1690,6 +1690,17 @@ static int fs_bdev_register(struct file *bdev_file, struct super_block *sb)
>  	sb->s_count++;
>  	spin_unlock(&sb_lock);
>  
> +	/*
> +	 * Don't bring a filesystem up on a frozen device.  The entry is already
> +	 * published, so a freeze either is seen here or finds it and waits in
> +	 * super_lock() until this mount is born or (on -EBUSY) dies.  The mount
> +	 * aborts, so the entry is torn down without rebalancing @fs_bdev_active.
> +	 */
> +	if (atomic_read(&file_bdev(bdev_file)->bd_fsfreeze_count) > 0) {
> +		fs_bdev_holder_put(h);
> +		return -EBUSY;
> +	}
> +
>  	return 0;
>  }

Shouldn't this check be common also for the branch where we only increase
the refcount? Or is a filesystem where a superblock claims the bdev
multiple times and can get frozen inbetween too insane?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

