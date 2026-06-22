Return-Path: <linux-erofs+bounces-3715-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GmdNHaM9OWpPpAcAu9opvQ
	(envelope-from <linux-erofs+bounces-3715-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jun 2026 15:50:27 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 960E16B0029
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jun 2026 15:50:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sCPFn2d7;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6sw3sDYH;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sCPFn2d7;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6sw3sDYH;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3715-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3715-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=none;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gkV2S3YRWz2xyh;
	Mon, 22 Jun 2026 23:50:24 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782136224;
	cv=none; b=TScs9ZiIb/XA7zgi9jeTjf69yQsZF/xH3HYM+5coCEI26O8jkZPpwNhog77VPl+QkBo/64XNyftZ6ScwVxxpRhldE9ypXtVycluvLhgab74wRCf+tPFBSEECKjgtpnitnnMnCwMkkba8YjS8JhSgt43T5wiU/QL3iut9VyAJN7oCOO0HwVOGGO6eqeAmiSRuZllLmCRgrs4G9NVT6xz1h0+NWPBy2jeQAVGeLmB8Eq4qS1BKYBAIitw5YAGqiAv5PAobtBncABAIshrjr1e9HQvmb60X1BR712I7/J+fqYk1ifnWF+7qieVquafR8BRj0d101v3KOvAK7tlxSHubag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782136224; c=relaxed/relaxed;
	bh=pwdldaccHLqFQeaduzHyGoRmVSJHAn2p6cOpABQhxBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eB7EmLc+NPsM5UVPOWZ8MIrcmvAufxE0DPs7abgYkvWuy9Wp4IBehoaeAEOkFnq2i5qtfnWm2Fo42dotEugUWMYrQgqrvpDgJwDg+UZY/NG3+bFcGDrdoopoPFZGEUlf+1Ev3HJcfeGhKQHgpg1u/smCjPGHIVh4aZSH2XpP8kogmDC7+v33supHTts1P8iXEuVfSoQtKTb1AbRaY5xDeYm5ujEKwQWNCJJmG4/GKxFXXfGvreu0J3EMoqLJPS2XL1IuE+t80Yzi7/B656FjVz/O8Y44P9D6mt0A+EAwg6HYURGUjjB3BlC6WBd0SlWzarCqLZeUBWspeTI8zoWGJA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=suse.cz; dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=sCPFn2d7; dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6sw3sDYH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=sCPFn2d7; dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6sw3sDYH; dkim-atps=neutral; spf=pass (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=jack@suse.cz; receiver=lists.ozlabs.org) smtp.mailfrom=suse.cz
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gkV2R51tFz2xSN
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Jun 2026 23:50:23 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 96F58704BB;
	Mon, 22 Jun 2026 13:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782136218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pwdldaccHLqFQeaduzHyGoRmVSJHAn2p6cOpABQhxBg=;
	b=sCPFn2d70ytK8uM+7am/4lVCEEva5/832BbzPLucrCQbcZbl9sCqMV5LCloY/u+fwJUWdP
	LAca2z1K/BesNFEHPBLcxVk1BWThf0t9EVogsScb4UGmjjsBPT1H4l6dI5j/Khk2v9XFSv
	yz/liunQfedntcKIGiSIR7RX5WsIiTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782136218;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pwdldaccHLqFQeaduzHyGoRmVSJHAn2p6cOpABQhxBg=;
	b=6sw3sDYHD0rKJ4cuy1fcFkpAZVhKTEnqqZgTXwYApQ5e9qJFAvoXjArJ3IjEF51c053v4h
	Tm81i5hE95XEHDCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782136218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pwdldaccHLqFQeaduzHyGoRmVSJHAn2p6cOpABQhxBg=;
	b=sCPFn2d70ytK8uM+7am/4lVCEEva5/832BbzPLucrCQbcZbl9sCqMV5LCloY/u+fwJUWdP
	LAca2z1K/BesNFEHPBLcxVk1BWThf0t9EVogsScb4UGmjjsBPT1H4l6dI5j/Khk2v9XFSv
	yz/liunQfedntcKIGiSIR7RX5WsIiTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782136218;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pwdldaccHLqFQeaduzHyGoRmVSJHAn2p6cOpABQhxBg=;
	b=6sw3sDYHD0rKJ4cuy1fcFkpAZVhKTEnqqZgTXwYApQ5e9qJFAvoXjArJ3IjEF51c053v4h
	Tm81i5hE95XEHDCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D44F779A8;
	Mon, 22 Jun 2026 13:50:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zTB6Ipo9OWpjOgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 22 Jun 2026 13:50:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 48C4CA093E; Mon, 22 Jun 2026 15:50:10 +0200 (CEST)
Date: Mon, 22 Jun 2026 15:50:10 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, 
	linux-ext4@vger.kernel.org, Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH RFC v2 03/18] super: take lock after last reference count
Message-ID: <p22dytpj26jz72sqohiqrhkacrc4r5wt7soanows744el5jzqb@3236bcjzmilk>
References: <20260616-work-super-bdev_holder_global-v2-0-7df6b864028e@kernel.org>
 <20260616-work-super-bdev_holder_global-v2-3-7df6b864028e@kernel.org>
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
In-Reply-To: <20260616-work-super-bdev_holder_global-v2-3-7df6b864028e@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-3715-lists,linux-erofs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp,suse.cz:dkim,suse.cz:email,suse.cz:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 960E16B0029

On Tue 16-06-26 16:08:19, Christian Brauner wrote:
> __put_super() required the caller to hold sb_lock, so put_super()
> wrapped it. The per-device superblock table introduced later drops its
> passive references from contexts that do not hold sb_lock, so make
> put_super() self-locking: drop the count first and take sb_lock only for
> the final list_del.
> 
> With the count now dropped outside sb_lock a superblock can briefly sit
> on @super_blocks with s_passive == 0 before it is unlinked, so the list
> walkers (__iterate_supers(), iterate_supers_type(), user_get_super())
> switch to refcount_inc_not_zero() and skip it.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Looks good, just one style nit below. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> -static void __put_super(struct super_block *s)
> +void put_super(struct super_block *s)
>  {
>  	if (refcount_dec_and_test(&s->s_passive)) {
> +

I'd delete this empty line.

> +		spin_lock(&sb_lock);
>  		list_del_init(&s->s_list);
> +		spin_unlock(&sb_lock);
> +


								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

