Return-Path: <linux-erofs+bounces-3712-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EqjRGUU6OWqaowcAu9opvQ
	(envelope-from <linux-erofs+bounces-3712-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jun 2026 15:36:05 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D94C66AFE8A
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jun 2026 15:36:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=c3IjOeoA;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=pTObOnwz;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="aCK/J0Dg";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=R9Y2ILYW;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3712-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3712-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=none;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gkTjs30LCz2xyh;
	Mon, 22 Jun 2026 23:36:01 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782135361;
	cv=none; b=byfrOIDAFu9FlZ1CYURvmrNGEtCL/23j6Xy14+lNM3VzuoNq0zRG/ZkVlHKL/G7GM+waIb4dhdYaQyuVc54UW2foZaHGiTaSN7PcDv5rOnEJAH9y20MdMA8mLq0TapnbupLQ0UlUTHwqdKtSoozLrs4pWjHZKDb3kCpzsrqQCmXROuAny0+8P7afDZNEQ8XQbB+TPubb0KPDq4Yb0XW+pBx7mT2qKa5dyKGeo/QqipKVOv52XeyiwCjDk5C9A8c4NHSe2McPSjebwrTUEqLvc/CoWhlGMA7Uli3D/cog7H91nK3rufyyXhdpA8i9kuORq+IIHToox9MClPKQ2sx2gA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782135361; c=relaxed/relaxed;
	bh=klHx9ZWC+iv1arsVCPKl7bjBSJ7l+Dg5khZq7zu+UWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlOXkc4n0kt0Uuq7MvQm+Vv2Y4ivx8cTjTRixHrTheb2LvsUHIW1huHwTso+IZAJ4v+ZtOgMS/aVvZsaZA6kjBcmV4W2HR89wW43tVmrRwL0guj2KlUuH3HwC84+JObLTTvmfI87yzlpwpvWQFfiAOq0FcrktXI2Pf7MdBCToAkt9jPK9+SpXIqcA3j9/FY4BKIhWT8dH9yuXm7SVcG3MjQ3tzhbdwK4w8guQdOJQRyY0YFPZ5wNJeYDOpdip5Tdi5Se32JswZ0XK53NQ4+oOtQp2CduhtebtvgzFCUfZWwzMAlKlE0BnbtTxlifvFaj6hDClhGbecs4CyDZdt63Fw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=suse.cz; dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=c3IjOeoA; dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=pTObOnwz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=aCK/J0Dg; dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=R9Y2ILYW; dkim-atps=neutral; spf=pass (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=jack@suse.cz; receiver=lists.ozlabs.org) smtp.mailfrom=suse.cz
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gkTjq1jLzz2xSN
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Jun 2026 23:35:58 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D277275CC2;
	Mon, 22 Jun 2026 13:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782135355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=klHx9ZWC+iv1arsVCPKl7bjBSJ7l+Dg5khZq7zu+UWs=;
	b=c3IjOeoAiqHBStIClfAkdBrQ81syPvT60HMpyaCi8OCJO7SRqMspy88/oqPJPyNe7FfpJD
	Kb6/2PAOfqTrF1WFj63A+c200oC1vNbyoGP/aOf84FEAjzbXYcNWWIoB9QXhwdLGbmP+67
	2pMzcebI1Nmju9mSahIYbkamOn9F28g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782135355;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=klHx9ZWC+iv1arsVCPKl7bjBSJ7l+Dg5khZq7zu+UWs=;
	b=pTObOnwzJKLeZNkaE+dbeKEhi3V/oOUzjBkVEYEasSKXX+RDKXM2xiqCox86wO155vzeHo
	Qw/Jz1E2aTjZBUDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782135353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=klHx9ZWC+iv1arsVCPKl7bjBSJ7l+Dg5khZq7zu+UWs=;
	b=aCK/J0DgzlDu0PkQWF53wPRQemLRiciaQEpCAYcnBmb35l5RhbllXz5eReXSW22M/N5M4S
	oDu93z93H60JJ5oSkB0p19x7Iq28s9Q8uJB3nKqu+RGmDFDrWIRWVtOs+Z5m25wrm+YlNT
	JeHcCHymlwqZ+raJ0kFyj6V9N/yY00A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782135353;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=klHx9ZWC+iv1arsVCPKl7bjBSJ7l+Dg5khZq7zu+UWs=;
	b=R9Y2ILYW4cwgfwgw0UOJGwlHo6W4aIaPAQKOAYw8Ww+Rf6CRGBYsJiIi/EmVu2qXEVFP0u
	pHijboeLS4BrhHCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C6698779A8;
	Mon, 22 Jun 2026 13:35:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rn1tMDk6OWqbLAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 22 Jun 2026 13:35:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5C7D7A093E; Mon, 22 Jun 2026 15:35:53 +0200 (CEST)
Date: Mon, 22 Jun 2026 15:35:53 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, 
	linux-ext4@vger.kernel.org, Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH RFC v2 01/18] xfs: fix the error unwind in
 xfs_open_devices()
Message-ID: <mz2myo6clekydj7y7vyro3ebzi43irhmzcueypgjv43ra7rcp7@tsgf3enlgvrm>
References: <20260616-work-super-bdev_holder_global-v2-0-7df6b864028e@kernel.org>
 <20260616-work-super-bdev_holder_global-v2-1-7df6b864028e@kernel.org>
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
In-Reply-To: <20260616-work-super-bdev_holder_global-v2-1-7df6b864028e@kernel.org>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
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
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-3712-lists,linux-erofs=lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[jack@suse.cz,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D94C66AFE8A

On Tue 16-06-26 16:08:17, Christian Brauner wrote:
> Since the rt and log block devices are closed in xfs_free_buftarg() the
> buftarg owns the device file. The error unwind does not respect that:
> when the log buftarg allocation fails, out_free_rtdev_targ frees the rt
> buftarg - releasing rtdev_file - and then falls through to
> out_close_rtdev and releases it a second time.
> 
> The unwind also leaves mp->m_rtdev_targp and mp->m_ddev_targp pointing
> to the freed buftargs. The failed mount continues into
> deactivate_locked_super() -> xfs_kill_sb() -> xfs_mount_free(), which
> frees them again.
> 
> Clear the buftarg pointers once the unwind freed them and clear
> rtdev_file once the rt buftarg owns it, so nothing is released twice.
> 
> Reachable when a buftarg allocation fails after the data buftarg was
> set up: an I/O error in sync_blockdev() or an allocation failure in
> xfs_init_buftarg() while mounting with external rt and log devices.
> 
> Fixes: 41233576e9a4 ("xfs: close the RT and log block devices in xfs_free_buftarg")
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Looks good to me. As a small nit I'd probably do rtdev_file = NULL just
after we've successfully allocated m_rtdev_targp but that's really minor.
Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/xfs/xfs_super.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index eac7f9503805..8531d526fc44 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -534,8 +534,11 @@ xfs_open_devices(
>   out_free_rtdev_targ:
>  	if (mp->m_rtdev_targp)
>  		xfs_free_buftarg(mp->m_rtdev_targp);
> +	mp->m_rtdev_targp = NULL;
> +	rtdev_file = NULL;	/* released by xfs_free_buftarg() */
>   out_free_ddev_targ:
>  	xfs_free_buftarg(mp->m_ddev_targp);
> +	mp->m_ddev_targp = NULL;
>   out_close_rtdev:
>  	 if (rtdev_file)
>  		bdev_fput(rtdev_file);
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

