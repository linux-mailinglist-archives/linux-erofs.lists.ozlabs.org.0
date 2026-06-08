Return-Path: <linux-erofs+bounces-3528-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yF8KKhKSJmqPYwIAu9opvQ
	(envelope-from <linux-erofs+bounces-3528-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 08 Jun 2026 11:57:38 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE06654C85
	for <lists+linux-erofs@lfdr.de>; Mon, 08 Jun 2026 11:57:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Z9sED5ks;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=AvA9Fjba;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Z9sED5ks;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=AvA9Fjba;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3528-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3528-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=none;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYnXD45z0z2yR5;
	Mon, 08 Jun 2026 19:57:32 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780912652;
	cv=none; b=XKdohsNCHf9EGWr84Oo+2KWngwnXW+rZmnfVVWtngqTo/25PGjJm6aLFWbjQcGWMfGSj9D+YrHouLzm+6Tph2BSVH3ZIT9SBdykeNCvArEBjgDPLv7wg7Qy0XLti4qndecz6oFU4s0tGKPbH76BV/1sGVN4K/uhQaaq3pAp9Od78fdOAVmDezIrIG3g1VDzElaFlnd+rPWKE1MfZqC6xmkEd4xmv2E7GD0WCeRLhQMKgTNCv2KJz1GkRR/CwApcSF8W2sOyhvm7rMGJ7mcR7MSGebsb/XhqUr9rRrYxz3hV00UbwPweMNqRnX9gzowFhxzKBVFkcsJFik2SVL/JiZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780912652; c=relaxed/relaxed;
	bh=4WHC6YGWDqkZpp81mnN/Um769+dyiH1mIzuumkwpAA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmZaqCGtD27U0WvLfPzLzEhRm8LBDqC/Kilnhg3vrlgvqk0rpsCzhChH/d+x5GM5zpmq74kwR2prJiVqHqwydK7QVBVwDer6jFocn4AjepKA2I9a0gvQQBnWXKq5TTKHBa5yp9oXD9BWg5gDDGRu7SllnMu82CWJrsaftTOW10n89qBcEZng2WdchAg+TRkjM3Ev/X0O770D8dHI1LRmJIKzRIQxoUEqZT0t4TEy39kN4Y7DL6Q7tecoYIYkPaf8C0NLok8bX3Hy8J/gAFvf53/FZ8xpQBEOHoeWzMgcclVnK8ZXQRH0tD/5Sdrm/ZLTZyZdHIspMfPhUuI18J05ZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=suse.cz; dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=Z9sED5ks; dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=AvA9Fjba; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=Z9sED5ks; dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=AvA9Fjba; dkim-atps=neutral; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=jack@suse.cz; receiver=lists.ozlabs.org) smtp.mailfrom=suse.cz
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gYnXB2dyTz2xWP
	for <linux-erofs@lists.ozlabs.org>; Mon, 08 Jun 2026 19:57:29 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0407867406;
	Mon,  8 Jun 2026 09:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780912646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4WHC6YGWDqkZpp81mnN/Um769+dyiH1mIzuumkwpAA4=;
	b=Z9sED5ksn+jtJc+hanT/IkmuDu3WcKNq4PGFSKY0FAWt0PqhgRyeVRBbrjq/XlNdTl73Z8
	BgcggrpMbrGlE9XqwyZDpYQxrXH7V9gH6EH0XoBh+zSz3bWp0hmIyOY62ESblhfqxPmPhd
	yrMn+qH3xT3ML9drFhf3TSOtZj9vaxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780912646;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4WHC6YGWDqkZpp81mnN/Um769+dyiH1mIzuumkwpAA4=;
	b=AvA9FjbaHx+Q41IJi1iHbubM1CWkC8j/PksWMoXIGAvcZIYjafEMnk2ZnCBLhorGQ20ore
	FyGA37dv0xCQ8aDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780912646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4WHC6YGWDqkZpp81mnN/Um769+dyiH1mIzuumkwpAA4=;
	b=Z9sED5ksn+jtJc+hanT/IkmuDu3WcKNq4PGFSKY0FAWt0PqhgRyeVRBbrjq/XlNdTl73Z8
	BgcggrpMbrGlE9XqwyZDpYQxrXH7V9gH6EH0XoBh+zSz3bWp0hmIyOY62ESblhfqxPmPhd
	yrMn+qH3xT3ML9drFhf3TSOtZj9vaxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780912646;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4WHC6YGWDqkZpp81mnN/Um769+dyiH1mIzuumkwpAA4=;
	b=AvA9FjbaHx+Q41IJi1iHbubM1CWkC8j/PksWMoXIGAvcZIYjafEMnk2ZnCBLhorGQ20ore
	FyGA37dv0xCQ8aDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA7DF779A7;
	Mon,  8 Jun 2026 09:57:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kVk3OQWSJmrZIgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 08 Jun 2026 09:57:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 954F9A10CB; Mon, 08 Jun 2026 11:57:21 +0200 (CEST)
Date: Mon, 8 Jun 2026 11:57:21 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>, 
	Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, 
	linux-ext4@vger.kernel.org, Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH RFC 1/8] fs, block: move blk_mode_t and fop_flags_t into
 <linux/types.h>
Message-ID: <lcq56poi7ebfdzbjevobd7fhbture7tn234wsxkk7q6kmr4cbx@zbit7mxburgd>
References: <20260602-work-super-bdev_holder_global-v1-0-bb0fd82f3861@kernel.org>
 <20260602-work-super-bdev_holder_global-v1-1-bb0fd82f3861@kernel.org>
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
In-Reply-To: <20260602-work-super-bdev_holder_global-v1-1-bb0fd82f3861@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:hch@lst.de,m:jack@suse.cz,m:axboe@kernel.dk,m:viro@zeniv.linux.org.uk,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:cem@kernel.org,m:linux-xfs@vger.kernel.org,m:clm@fb.com,m:dsterba@suse.com,m:linux-btrfs@vger.kernel.org,m:tytso@mit.edu,m:linux-ext4@vger.kernel.org,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[suse.cz];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jack@suse.cz,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-3528-lists,linux-erofs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:from_mime,suse.cz:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5BE06654C85

On Tue 02-06-26 12:10:07, Christian Brauner wrote:
> blk_mode_t and fop_flags_t are both plain 'unsigned int __bitwise' flag
> typedefs, exactly like the gfp_t, slab_flags_t and fmode_t that already
> live in <linux/types.h>. Move them there so they are available
> everywhere without having to drag in a subsystem header.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Makes sense. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/blkdev.h | 2 --
>  include/linux/fs.h     | 2 --
>  include/linux/types.h  | 2 ++
>  3 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 890128cdea1c..c8494d64a69d 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -126,8 +126,6 @@ struct blk_integrity {
>  	unsigned char				pi_tuple_size;
>  };
>  
> -typedef unsigned int __bitwise blk_mode_t;
> -
>  /* open for reading */
>  #define BLK_OPEN_READ		((__force blk_mode_t)(1 << 0))
>  /* open for writing */
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 11559c513dfb..e9346be8470f 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1921,8 +1921,6 @@ struct dir_context {
>  struct io_uring_cmd;
>  struct offset_ctx;
>  
> -typedef unsigned int __bitwise fop_flags_t;
> -
>  struct file_operations {
>  	struct module *owner;
>  	fop_flags_t fop_flags;
> diff --git a/include/linux/types.h b/include/linux/types.h
> index 608050dbca6a..ef026585420b 100644
> --- a/include/linux/types.h
> +++ b/include/linux/types.h
> @@ -163,6 +163,8 @@ typedef u32 dma_addr_t;
>  typedef unsigned int __bitwise gfp_t;
>  typedef unsigned int __bitwise slab_flags_t;
>  typedef unsigned int __bitwise fmode_t;
> +typedef unsigned int __bitwise blk_mode_t;
> +typedef unsigned int __bitwise fop_flags_t;
>  
>  #ifdef CONFIG_PHYS_ADDR_T_64BIT
>  typedef u64 phys_addr_t;
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

