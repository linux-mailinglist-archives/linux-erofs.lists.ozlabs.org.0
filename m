Return-Path: <linux-erofs+bounces-3531-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id p6sHEluWJmrAZAIAu9opvQ
	(envelope-from <linux-erofs+bounces-3531-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 08 Jun 2026 12:15:55 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B4A654EF9
	for <lists+linux-erofs@lfdr.de>; Mon, 08 Jun 2026 12:15:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Gdm+VXTX;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="7w/dJW3n";
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Gdm+VXTX;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="7w/dJW3n";
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3531-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3531-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=none;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYnxN20h2z2yR5;
	Mon, 08 Jun 2026 20:15:52 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780913752;
	cv=none; b=Lno1QTEVUnaffrPRFtgyamiyrkVdIXKmefYoSU1Iwi2NzQAAmfHg9qz1r/UOKH74NWZHyIfi7reDB8740VKSzwpvJRav8yINbO6n32dJ8QRJyn7xRvWvHyQwhNkfk71jMthVlfTdBpnrhUfcFUr0MZ/u7g+8VdnxS+da0JIYqqoRhy8JomWEKihXg8+ALO0MUM6astx13m2IcZTTuoHzNDUijHgedut+he+7sjfEGqJwNjxUge/PmUga5WhSL4Nm71G+ZNfR81DuypV2NHxa1PUx8/qW08IWEKfH0K9Xy1iVQnzyXtbUGG5b4jJaetKHdMMCMf3YB6dUXYVc3eWz+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780913752; c=relaxed/relaxed;
	bh=ibD9Jz6QCBGfSwHuXe3bIKMHyOrx2qpjm8SibEUza44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fps8Ol8oBdchtuyeBKIHyKQPkzsXQe9pmz9Ak3wxF+8NbKPhf06r6iTMnGk3yK1WpwTx0X1B1OEWZO8iRRNE5B6eQJNwg7j58t6vseElZ9M1cKQFHZRi+UjcTBj8uSBwK3ntnPHC94O+uprtsaxU/S6dSSnNJzdlq3OueUo3xGRKsNdwjDNqeLt1KrmLwzdYFO+od5tNaVvDQyLMa6bPyPJ2loIwUP884nyzNyVpKKuShQJAkiPsA4d8ytRATgLNz4AZ+/zxlKd7YWTL3xBjBPRbFCh+frHgu7pCEW9ax2cprpSchke5ZzEvkeok/1aeemXhJgr2LFMyz3quVYus/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=suse.cz; dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=Gdm+VXTX; dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=7w/dJW3n; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=Gdm+VXTX; dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=7w/dJW3n; dkim-atps=neutral; spf=pass (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=jack@suse.cz; receiver=lists.ozlabs.org) smtp.mailfrom=suse.cz
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gYnxM4Spkz2xWP
	for <linux-erofs@lists.ozlabs.org>; Mon, 08 Jun 2026 20:15:51 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 638DB6A7C1;
	Mon,  8 Jun 2026 10:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780913746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ibD9Jz6QCBGfSwHuXe3bIKMHyOrx2qpjm8SibEUza44=;
	b=Gdm+VXTXgrXC9GqQWupyTSVjOWVRRbGWnrXWGmWuZxXRvwIAm7LdotifuHopidYFPNJu9B
	L/7UNFV+mGpvwRWHAjhwv9Wj2AHIMyesIcreKA/EbN2jtboJEIdKwpilbWgGXKUFenuhTf
	6RyarxzUoUKThz/hAuhu9gYaknXZEUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780913746;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ibD9Jz6QCBGfSwHuXe3bIKMHyOrx2qpjm8SibEUza44=;
	b=7w/dJW3nV2PS4azYFFwsCQIekDLJOW1tVTgUhwhY4z2Gr8fYKxHQnNo/6HYGJ/OINKesST
	FgRWaAJVldxBLZBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780913746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ibD9Jz6QCBGfSwHuXe3bIKMHyOrx2qpjm8SibEUza44=;
	b=Gdm+VXTXgrXC9GqQWupyTSVjOWVRRbGWnrXWGmWuZxXRvwIAm7LdotifuHopidYFPNJu9B
	L/7UNFV+mGpvwRWHAjhwv9Wj2AHIMyesIcreKA/EbN2jtboJEIdKwpilbWgGXKUFenuhTf
	6RyarxzUoUKThz/hAuhu9gYaknXZEUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780913746;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ibD9Jz6QCBGfSwHuXe3bIKMHyOrx2qpjm8SibEUza44=;
	b=7w/dJW3nV2PS4azYFFwsCQIekDLJOW1tVTgUhwhY4z2Gr8fYKxHQnNo/6HYGJ/OINKesST
	FgRWaAJVldxBLZBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 58082779A7;
	Mon,  8 Jun 2026 10:15:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QEJ7FVKWJmpJNgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 08 Jun 2026 10:15:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1659FA10CB; Mon, 08 Jun 2026 12:15:46 +0200 (CEST)
Date: Mon, 8 Jun 2026 12:15:46 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>, 
	Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, 
	linux-ext4@vger.kernel.org, Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH RFC 4/8] xfs: port to fs_bdev_file_open_by_path()
Message-ID: <eqckzzcpsb2ln6teneufzm7ki6q7ow3dam3ss3j2iwiqtv3vvq@sw4h3dtwva33>
References: <20260602-work-super-bdev_holder_global-v1-0-bb0fd82f3861@kernel.org>
 <20260602-work-super-bdev_holder_global-v1-4-bb0fd82f3861@kernel.org>
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
In-Reply-To: <20260602-work-super-bdev_holder_global-v1-4-bb0fd82f3861@kernel.org>
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
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:hch@lst.de,m:jack@suse.cz,m:axboe@kernel.dk,m:viro@zeniv.linux.org.uk,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:cem@kernel.org,m:linux-xfs@vger.kernel.org,m:clm@fb.com,m:dsterba@suse.com,m:linux-btrfs@vger.kernel.org,m:tytso@mit.edu,m:linux-ext4@vger.kernel.org,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[suse.cz];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jack@suse.cz,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-3531-lists,linux-erofs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:from_mime,suse.cz:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp,sw4h3dtwva33:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 64B4A654EF9

On Tue 02-06-26 12:10:10, Christian Brauner wrote:
> Route opens through fs_bdev_file_open_by_path() so each external device
> is registered against mp->m_super, and convert the matching releases.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/xfs/xfs_buf.c   |  2 +-
>  fs/xfs/xfs_super.c | 10 +++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> index 580d40a5ee57..3d3b29edb156 100644
> --- a/fs/xfs/xfs_buf.c
> +++ b/fs/xfs/xfs_buf.c
> @@ -1601,7 +1601,7 @@ xfs_free_buftarg(
>  	fs_put_dax(btp->bt_daxdev, btp->bt_mount);
>  	/* the main block device is closed by kill_block_super */
>  	if (btp->bt_bdev != btp->bt_mount->m_super->s_bdev)
> -		bdev_fput(btp->bt_file);
> +		fs_bdev_file_release(btp->bt_file, btp->bt_mount->m_super);
>  	kfree(btp);
>  }
>  
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index f8de44443e81..304667210695 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -400,8 +400,8 @@ xfs_blkdev_get(
>  	blk_mode_t		mode;
>  
>  	mode = sb_open_mode(mp->m_super->s_flags);
> -	*bdev_filep = bdev_file_open_by_path(name, mode,
> -			mp->m_super, &fs_holder_ops);
> +	*bdev_filep = fs_bdev_file_open_by_path(name, mode,
> +			mp->m_super, mp->m_super);
>  	if (IS_ERR(*bdev_filep)) {
>  		error = PTR_ERR(*bdev_filep);
>  		*bdev_filep = NULL;
> @@ -526,7 +526,7 @@ xfs_open_devices(
>  		mp->m_logdev_targp = mp->m_ddev_targp;
>  		/* Handle won't be used, drop it */
>  		if (logdev_file)
> -			bdev_fput(logdev_file);
> +			fs_bdev_file_release(logdev_file, mp->m_super);
>  	}
>  
>  	return 0;
> @@ -538,10 +538,10 @@ xfs_open_devices(
>  	xfs_free_buftarg(mp->m_ddev_targp);
>   out_close_rtdev:
>  	 if (rtdev_file)
> -		bdev_fput(rtdev_file);
> +		fs_bdev_file_release(rtdev_file, mp->m_super);
>   out_close_logdev:
>  	if (logdev_file)
> -		bdev_fput(logdev_file);
> +		fs_bdev_file_release(logdev_file, mp->m_super);
>  	return error;
>  }
>  
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

