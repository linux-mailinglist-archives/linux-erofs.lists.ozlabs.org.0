Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9DD996F29
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Oct 2024 17:04:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XNx4d4Xq5z2yQL
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Oct 2024 02:04:33 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728486271;
	cv=none; b=SKJyUHUkXtP4rJEER8CHFywsffOcZ78VG4EFkzOrZMbL3GMeINLRF+2bmMzbaO/9EpeGfewS3+cCsX6RP7H++WXt2FLnFkdGy3Y2pK0JMuQTGOJuxXE3IRT6YGVmM6JB+xzwK5oModkxQTlrH8XbEIAvPKBWYTdhn/EOTGDuzYqxjgKYCPueRtvng0EoQIhB9qyR/D3jv9NO/k6UqSEsUlEF2/0LNgWyHgDkn98hX+hcYb9wZLCjRQP56oXRzfxRfxYn+UlhXdQDr7hxcODnxSmj9IPJg9y1oSrFN5PKa6cfVQbAH/q4KJWLj0gaY/9167ohwG+WJZnX5jTcs1u+9A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728486271; c=relaxed/relaxed;
	bh=zGcpaV4qNzq+lgUWq35jWZvKxbgGv0AnFKORHfiNLxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCpU4n98g11b13jKqfD3kPGGbvlGHwSuTEWIlZtHC/BnmOB3Fpck0fe1ifVWenwxbXpZduGzh7mN+XthY7Qjh4jXtTpEp0rays97KtnW1Q6CQU12AADE48tfVv+uua2XEUKjrceOk5tvBQ/lyglw4yR4PqObcXoeVElTH8xwGu9VzJJUrzcG537CI30kVM4uE0Sy+i84k3qHeQ/0Emc8xIBJDfLKkkLx3cCqAyrAM9HNrwhshajhlx8ZP7Xp5h7Xs5DbQ2fD4LkaUEcZ4G4LKWcpPfB+drxM5A69yJE01SZUwSNszGLj93MrX+8UDV/eaXpzsWQqMfSS0h1Bi1Zcyw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=suse.cz; dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=LNWd22v4; dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=l2EyHGqb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=LNWd22v4; dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=l2EyHGqb; dkim-atps=neutral; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=jack@suse.cz; receiver=lists.ozlabs.org) smtp.mailfrom=suse.cz
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=LNWd22v4;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=l2EyHGqb;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=LNWd22v4;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=l2EyHGqb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=jack@suse.cz; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XNx4Y4KyKz30gn
	for <linux-erofs@lists.ozlabs.org>; Thu, 10 Oct 2024 02:04:28 +1100 (AEDT)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5045E1F896;
	Wed,  9 Oct 2024 15:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728486261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zGcpaV4qNzq+lgUWq35jWZvKxbgGv0AnFKORHfiNLxA=;
	b=LNWd22v4/oUdMQ3TXQa19FIA7ecl3NXAqfwRCF3ebyT/BQ7x3U08S4ERkMoihGN0SuzorU
	Nn8NgSqYrTa41WriQ1rNBgrV5HYPuDauZ1sN1Vr65bP5CCnQZ6VpxySarW6CibH0QDioVb
	ncZndUEGJJt0ZHBCzRVWfHR+dutUtz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728486261;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zGcpaV4qNzq+lgUWq35jWZvKxbgGv0AnFKORHfiNLxA=;
	b=l2EyHGqbKKU7MRPmRvyxwIcFVD64T+QFc5iCl4Be7MaAkQad6sQZwJI1lo0Citp+9QJkam
	a2T0z3iFsB0DzRCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728486261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zGcpaV4qNzq+lgUWq35jWZvKxbgGv0AnFKORHfiNLxA=;
	b=LNWd22v4/oUdMQ3TXQa19FIA7ecl3NXAqfwRCF3ebyT/BQ7x3U08S4ERkMoihGN0SuzorU
	Nn8NgSqYrTa41WriQ1rNBgrV5HYPuDauZ1sN1Vr65bP5CCnQZ6VpxySarW6CibH0QDioVb
	ncZndUEGJJt0ZHBCzRVWfHR+dutUtz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728486261;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zGcpaV4qNzq+lgUWq35jWZvKxbgGv0AnFKORHfiNLxA=;
	b=l2EyHGqbKKU7MRPmRvyxwIcFVD64T+QFc5iCl4Be7MaAkQad6sQZwJI1lo0Citp+9QJkam
	a2T0z3iFsB0DzRCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4232C136BA;
	Wed,  9 Oct 2024 15:04:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id J8YmEHWbBmdRUAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 09 Oct 2024 15:04:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EBBFFA0896; Wed,  9 Oct 2024 17:04:20 +0200 (CEST)
Date: Wed, 9 Oct 2024 17:04:20 +0200
From: Jan Kara <jack@suse.cz>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH v2 1/2] fs/super.c: introduce get_tree_bdev_flags()
Message-ID: <20241009150420.wan5f7pucgse7j2n@quack3>
References: <20241009033151.2334888-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009033151.2334888-1-hsiangkao@linux.alibaba.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email]
X-Spam-Score: -3.80
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, Allison Karlitskaya <allison.karlitskaya@redhat.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed 09-10-24 11:31:50, Gao Xiang wrote:
> As Allison reported [1], currently get_tree_bdev() will store
> "Can't lookup blockdev" error message.  Although it makes sense for
> pure bdev-based fses, this message may mislead users who try to use
> EROFS file-backed mounts since get_tree_nodev() is used as a fallback
> then.
> 
> Add get_tree_bdev_flags() to specify extensible flags [2] and
> GET_TREE_BDEV_QUIET_LOOKUP to silence "Can't lookup blockdev" message
> since it's misleading to EROFS file-backed mounts now.
> 
> [1] https://lore.kernel.org/r/CAOYeF9VQ8jKVmpy5Zy9DNhO6xmWSKMB-DO8yvBB0XvBE7=3Ugg@mail.gmail.com
> [2] https://lore.kernel.org/r/ZwUkJEtwIpUA4qMz@infradead.org
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> v1: https://lore.kernel.org/r/20241008095606.990466-1-hsiangkao@linux.alibaba.com
> change since v1:
>  - add get_tree_bdev_flags() suggested by Christoph.
> 
>  fs/super.c                 | 26 ++++++++++++++++++++------
>  include/linux/fs_context.h |  6 ++++++
>  2 files changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 1db230432960..c9c7223bc2a2 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1596,13 +1596,14 @@ int setup_bdev_super(struct super_block *sb, int sb_flags,
>  EXPORT_SYMBOL_GPL(setup_bdev_super);
>  
>  /**
> - * get_tree_bdev - Get a superblock based on a single block device
> + * get_tree_bdev_flags - Get a superblock based on a single block device
>   * @fc: The filesystem context holding the parameters
>   * @fill_super: Helper to initialise a new superblock
> + * @flags: GET_TREE_BDEV_* flags
>   */
> -int get_tree_bdev(struct fs_context *fc,
> -		int (*fill_super)(struct super_block *,
> -				  struct fs_context *))
> +int get_tree_bdev_flags(struct fs_context *fc,
> +		int (*fill_super)(struct super_block *sb,
> +				  struct fs_context *fc), unsigned int flags)
>  {
>  	struct super_block *s;
>  	int error = 0;
> @@ -1613,10 +1614,10 @@ int get_tree_bdev(struct fs_context *fc,
>  
>  	error = lookup_bdev(fc->source, &dev);
>  	if (error) {
> -		errorf(fc, "%s: Can't lookup blockdev", fc->source);
> +		if (!(flags & GET_TREE_BDEV_QUIET_LOOKUP))
> +			errorf(fc, "%s: Can't lookup blockdev", fc->source);
>  		return error;
>  	}
> -
>  	fc->sb_flags |= SB_NOSEC;
>  	s = sget_dev(fc, dev);
>  	if (IS_ERR(s))
> @@ -1644,6 +1645,19 @@ int get_tree_bdev(struct fs_context *fc,
>  	fc->root = dget(s->s_root);
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(get_tree_bdev_flags);
> +
> +/**
> + * get_tree_bdev - Get a superblock based on a single block device
> + * @fc: The filesystem context holding the parameters
> + * @fill_super: Helper to initialise a new superblock
> + */
> +int get_tree_bdev(struct fs_context *fc,
> +		int (*fill_super)(struct super_block *,
> +				  struct fs_context *))
> +{
> +	return get_tree_bdev_flags(fc, fill_super, 0);
> +}
>  EXPORT_SYMBOL(get_tree_bdev);
>  
>  static int test_bdev_super(struct super_block *s, void *data)
> diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
> index c13e99cbbf81..4b4bfef6f053 100644
> --- a/include/linux/fs_context.h
> +++ b/include/linux/fs_context.h
> @@ -160,6 +160,12 @@ extern int get_tree_keyed(struct fs_context *fc,
>  
>  int setup_bdev_super(struct super_block *sb, int sb_flags,
>  		struct fs_context *fc);
> +
> +#define GET_TREE_BDEV_QUIET_LOOKUP		0x0001
> +int get_tree_bdev_flags(struct fs_context *fc,
> +		int (*fill_super)(struct super_block *sb,
> +				  struct fs_context *fc), unsigned int flags);
> +
>  extern int get_tree_bdev(struct fs_context *fc,
>  			       int (*fill_super)(struct super_block *sb,
>  						 struct fs_context *fc));
> -- 
> 2.43.5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
