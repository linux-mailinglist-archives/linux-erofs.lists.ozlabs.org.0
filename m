Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE07749A20
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Jul 2023 13:00:22 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=fA38CEOB;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=eF9nF5Zt;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QxYTc1zB1z301r
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Jul 2023 21:00:20 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=fA38CEOB;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=eF9nF5Zt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=softfail (domain owner discourages use of this host) smtp.mailfrom=suse.cz (client-ip=2001:67c:2178:6::1c; helo=smtp-out1.suse.de; envelope-from=jack@suse.cz; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QxYTT2949z3bPV
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Jul 2023 21:00:11 +1000 (AEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AE8AF21C07;
	Thu,  6 Jul 2023 11:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1688641207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0tPUniIVIu0FAYmaWLGUdde+evUlDMjdaTm3qSZ/wTE=;
	b=fA38CEOBUbD7/EdBE57owBP6hc4uRNojoyc3zJKyF1n8EUi4Tgju0UNXdMD86z6yqwRP8T
	g4TpGuiXJGbYbKeUdhhuIYDfrqIaZI5HXmLXQugQuh6i8KZsinKy5xDvxAYz40fYT6/b26
	92Oq3AEnKF4Xr2UlauUObS19p+HTxXA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1688641207;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0tPUniIVIu0FAYmaWLGUdde+evUlDMjdaTm3qSZ/wTE=;
	b=eF9nF5ZtYckwI5G4yta0AyMW6sbL4N3hAL/HCE5CO3HFu9PVHczKS7CYWQQi+tBDboivGL
	jrdcoAenO/kf4TCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 95014138EE;
	Thu,  6 Jul 2023 11:00:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id SkNVJLeepmQcCAAAMHmgww
	(envelope-from <jack@suse.cz>); Thu, 06 Jul 2023 11:00:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 11265A0707; Thu,  6 Jul 2023 13:00:07 +0200 (CEST)
Date: Thu, 6 Jul 2023 13:00:07 +0200
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v2 39/92] erofs: convert to ctime accessor functions
Message-ID: <20230706110007.dc4tpyt5e6wxi5pt@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-37-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705190309.579783-37-jlayton@kernel.org>
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
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Yue Hu <huyue2@coolpad.com>, Al Viro <viro@zeniv.linux.org.uk>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed 05-07-23 15:01:04, Jeff Layton wrote:
> In later patches, we're going to change how the inode's ctime field is
> used. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Acked-by: Gao Xiang <xiang@kernel.org>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Just one nit below:

> @@ -176,10 +175,10 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>  		vi->chunkbits = sb->s_blocksize_bits +
>  			(vi->chunkformat & EROFS_CHUNK_FORMAT_BLKBITS_MASK);
>  	}
> -	inode->i_mtime.tv_sec = inode->i_ctime.tv_sec;
> -	inode->i_atime.tv_sec = inode->i_ctime.tv_sec;
> -	inode->i_mtime.tv_nsec = inode->i_ctime.tv_nsec;
> -	inode->i_atime.tv_nsec = inode->i_ctime.tv_nsec;
> +	inode->i_mtime.tv_sec = inode_get_ctime(inode).tv_sec;
> +	inode->i_atime.tv_sec = inode_get_ctime(inode).tv_sec;
> +	inode->i_mtime.tv_nsec = inode_get_ctime(inode).tv_nsec;
> +	inode->i_atime.tv_nsec = inode_get_ctime(inode).tv_nsec;

Isn't this just longer way to write:

	inode->i_atime = inode->i_mtime = inode_get_ctime(inode);

?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
