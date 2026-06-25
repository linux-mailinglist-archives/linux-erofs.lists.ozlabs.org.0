Return-Path: <linux-erofs+bounces-3761-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3PtMDNhpPWpk2wgAu9opvQ
	(envelope-from <linux-erofs+bounces-3761-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Jun 2026 19:48:08 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D63C96C7FF4
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Jun 2026 19:48:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bpZGbEY9;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3761-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3761-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmR9H3gpJz2y8p;
	Fri, 26 Jun 2026 03:48:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782409683;
	cv=none; b=lNZpuxvRvd6kl3GviYJHpgUd9PQWVI8QfS2n8jbAVYMANlvON/9lX2ASIuRmRPjgqi9tr7aVfMr7zYDly/Qgcs3Khfs3J2er1iYYIz5LAeijBelYbKBTrhMgx2rwI00qAO7TJR+fKp65STan4o1GP4XLskyWnS0gjgkY13j7fMikz0vU+mnPmtyWyF+hGkFN/2m1wYVPHginmT5UI+MAD0VXdzsIQSuymaWC/QLdr5uK4cstGH/eEV9zlj8T5I/2RYYZ3FZjsPisHT0xfeodRfwfGJzX5370S5TNrBMaIsFRDlgorhSrTcNRlPko/c+py1iNBXIPAaj8wqwNRlH7RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782409683; c=relaxed/relaxed;
	bh=FOPfdwn4WT7soBv45WuCMYiLXW+L3mRRpXlE+zmI+mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dAKQaqD2Fb38QILK+sTy4NTFaL4tZO49I9PPZHxMO9qioEF6LiDCIgbmvPxzSm9Q9Y556k8LAmP4LmMZufhT+qURjjleoGYsBNVlTqXifAvwhqGWbARJnwfObs/EgL8RF0+cHryR6VY5hMabyLgPZSHNdF66ul/LVzDd4sqO34MQX8JmPgqBoEII/ri/FbGtEY/9R+bGBpKO/zjMUY0aYe4xKmscfi3jrH1GFNw198SduwmyMBmKP6uxCV3fbIq+6DNfjJVezbKXwvOeXpueYoHBi5zIbKdG8FmUbcn2QemaXFExucVY24ZYl+Pq72brsANjL10PoQwtZqz4gLc6Mg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bpZGbEY9; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=djwong@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4gmR9G2sfqz2xM7
	for <linux-erofs@lists.ozlabs.org>; Fri, 26 Jun 2026 03:48:02 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with UTF8SMTP id 41CDB60098;
	Thu, 25 Jun 2026 17:47:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id DE3DA1F000E9;
	Thu, 25 Jun 2026 17:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782409679;
	bh=FOPfdwn4WT7soBv45WuCMYiLXW+L3mRRpXlE+zmI+mk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bpZGbEY99hKffV7pqxuiuUXyA6GGmd/85wm1zDFkzmvlCmBLNeXBs9e2iPjDdU4rl
	 FhEtt8uvABGrISroYt6e3B9WZgHeiw98BZEunP2sb1X4uh1stu3zO6MkzQyInYJb6V
	 ZmA5JWwkCktygNarpzfrrmsieSkeY665h+k+DZg9fqkSjMdtf2BwyV5K7fz6VQsYaJ
	 okWDrgLg9//QcsrCNTFE0LTMMJjE47N4dPj20nuGvfrIUAcO/RpE+boWGDiP+zqpux
	 2gZHxb/2IZvFTnddmo4f6ogWOocS4ug4mKZW6hNoQiEJj/pJL1I9UjnPeV1cnQTJgv
	 u1iwBL5YJzLmA==
Date: Thu, 25 Jun 2026 10:47:58 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, Kelu Ye <yekelu1@huawei.com>,
	Yifan Zhao <zhaoyifan28@huawei.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Miklos Szeredi <miklos@szeredi.hu>, fuse-devel@lists.linux.dev,
	ntfs3@lists.linux.dev, linux-erofs@lists.ozlabs.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] iomap: submit read bio after each extent
Message-ID: <20260625174758.GE6078@frogsfrogsfrogs>
References: <20260625120803.2462291-1-hch@lst.de>
 <20260625120803.2462291-3-hch@lst.de>
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
In-Reply-To: <20260625120803.2462291-3-hch@lst.de>
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.20 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hch@lst.de,m:brauner@kernel.org,m:yekelu1@huawei.com,m:zhaoyifan28@huawei.com,m:ritesh.list@gmail.com,m:joannelkoong@gmail.com,m:linkinjeon@kernel.org,m:sj1557.seo@samsung.com,m:hyc.lee@gmail.com,m:almaz.alexandrovich@paragon-software.com,m:miklos@szeredi.hu,m:fuse-devel@lists.linux.dev,m:ntfs3@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-xfs@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:riteshlist@gmail.com,m:hyclee@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[djwong@kernel.org,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-3761-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[kernel.org,huawei.com,gmail.com,samsung.com,paragon-software.com,szeredi.hu,lists.linux.dev,lists.ozlabs.org,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[frogsfrogsfrogs:mid,lst.de:email,huawei.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D63C96C7FF4

On Thu, Jun 25, 2026 at 02:07:57PM +0200, Christoph Hellwig wrote:
> Currently the iomap buffered read path tries to build up read context
> (i.e. bios for the typical block based case) over multiple iomaps as
> long as the sector matches.  This does not take into account files
> that can map to multiple different devices.  While this could be fixed
> by a bdev check in iomap_bio_read_folio_range, the building up of I/O
> over iomaps actually was a problem for the not yet merged ext2 iomap
> port, as that does want to send out I/O at the end of an indirect
> block mapped range.

This really puts the onus on block-mapped filesystems (e.g. ext2) to
merge adjacent maps into extents.  Granted they *probably* already have
been doing that.

> So instead of adding more checks move over to a model where a bio only
> spans a single iomap.  Change ->submit_read to be called after each
> iteration, and pass a force argument to indicate that the bio must
> be submitted set on the last iteration.  Switch the bio based users
> to always submit, while keeping the single submit for fuse.

Is fuse the sole reason for the "force" parameter to exist?  I wonder if
fuse could drop its submit_read function and call fuse_send_readpages
after the iomap_read{ahead,folio} function returns?

--D

> Fixes: dfeab2e95a75 ("erofs: add multiple device support")
> Reported-by: Kelu Ye <yekelu1@huawei.com>
> Reported-by: Yifan Zhao <zhaoyifan28@huawei.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Yifan Zhao <zhaoyifan28@huawei.com>
> ---
>  fs/exfat/iomap.c       |  2 +-
>  fs/fuse/file.c         |  6 +++++-
>  fs/iomap/bio.c         |  6 ++++--
>  fs/iomap/buffered-io.c | 21 +++++++++++++--------
>  fs/ntfs/aops.c         |  2 +-
>  fs/ntfs3/inode.c       |  2 +-
>  fs/xfs/xfs_aops.c      |  3 ++-
>  include/linux/iomap.h  |  2 +-
>  8 files changed, 28 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/exfat/iomap.c b/fs/exfat/iomap.c
> index 190fc6471f84..c428a949120e 100644
> --- a/fs/exfat/iomap.c
> +++ b/fs/exfat/iomap.c
> @@ -251,7 +251,7 @@ static void exfat_iomap_read_end_io(struct bio *bio)
>  }
>  
>  static void exfat_iomap_bio_submit_read(const struct iomap_iter *iter,
> -		struct iomap_read_folio_ctx *ctx)
> +		struct iomap_read_folio_ctx *ctx, bool force)
>  {
>  	iomap_bio_submit_read_endio(iter, ctx, exfat_iomap_read_end_io);
>  }
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index e052a0d44dee..6fa3b1f55c95 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -982,13 +982,17 @@ static int fuse_iomap_read_folio_range_async(const struct iomap_iter *iter,
>  }
>  
>  static void fuse_iomap_submit_read(const struct iomap_iter *iter,
> -		struct iomap_read_folio_ctx *ctx)
> +		struct iomap_read_folio_ctx *ctx, bool force)
>  {
>  	struct fuse_fill_read_data *data = ctx->read_ctx;
>  
> +	if (!force)
> +		return;
> +
>  	if (data->ia)
>  		fuse_send_readpages(data->ia, data->file, data->nr_bytes,
>  				    data->fc->async_read);
> +	ctx->read_ctx = NULL;
>  }
>  
>  static const struct iomap_read_ops fuse_iomap_read_ops = {
> diff --git a/fs/iomap/bio.c b/fs/iomap/bio.c
> index 0f31e35567b4..6aca1cd0622c 100644
> --- a/fs/iomap/bio.c
> +++ b/fs/iomap/bio.c
> @@ -87,11 +87,13 @@ void iomap_bio_submit_read_endio(const struct iomap_iter *iter,
>  	if (iter->iomap.flags & IOMAP_F_INTEGRITY)
>  		fs_bio_integrity_alloc(bio);
>  	submit_bio(bio);
> +
> +	ctx->read_ctx = NULL;
>  }
>  EXPORT_SYMBOL_GPL(iomap_bio_submit_read_endio);
>  
>  static void iomap_bio_submit_read(const struct iomap_iter *iter,
> -		struct iomap_read_folio_ctx *ctx)
> +		struct iomap_read_folio_ctx *ctx, bool force)
>  {
>  	return iomap_bio_submit_read_endio(iter, ctx, iomap_read_end_io);
>  }
> @@ -116,7 +118,7 @@ static void iomap_read_alloc_bio(const struct iomap_iter *iter,
>  
>  	/* Submit the existing range if there was one. */
>  	if (ctx->read_ctx)
> -		ctx->ops->submit_read(iter, ctx);
> +		ctx->ops->submit_read(iter, ctx, true);
>  
>  	/* Same as readahead_gfp_mask: */
>  	if (ctx->rac)
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 8d4806dc46d4..b1c3da8a97dc 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -524,6 +524,13 @@ static void iomap_read_end(struct folio *folio, size_t bytes_submitted)
>  	}
>  }
>  
> +static void iomap_submit_read(struct iomap_iter *iter,
> +		struct iomap_read_folio_ctx *ctx, bool force)
> +{
> +	if (ctx->read_ctx && ctx->ops->submit_read)
> +		ctx->ops->submit_read(iter, ctx, force);
> +}
> +
>  static int iomap_read_folio_iter(struct iomap_iter *iter,
>  		struct iomap_read_folio_ctx *ctx, size_t *bytes_submitted)
>  {
> @@ -642,12 +649,11 @@ void iomap_read_folio(const struct iomap_ops *ops,
>  		fsverity_readahead(ctx->vi, folio->index,
>  				   folio_nr_pages(folio));
>  
> -	while ((ret = iomap_iter(&iter, ops)) > 0)
> +	while ((ret = iomap_iter(&iter, ops)) > 0) {
>  		iter.status = iomap_read_folio_iter(&iter, ctx,
>  				&bytes_submitted);
> -
> -	if (ctx->read_ctx && ctx->ops->submit_read)
> -		ctx->ops->submit_read(&iter, ctx);
> +		iomap_submit_read(&iter, ctx, !iter.iomap.length);
> +	}
>  
>  	if (ctx->cur_folio)
>  		iomap_read_end(ctx->cur_folio, bytes_submitted);
> @@ -718,12 +724,11 @@ void iomap_readahead(const struct iomap_ops *ops,
>  		fsverity_readahead(ctx->vi, readahead_index(rac),
>  				readahead_count(rac));
>  
> -	while (iomap_iter(&iter, ops) > 0)
> +	while (iomap_iter(&iter, ops) > 0) {
>  		iter.status = iomap_readahead_iter(&iter, ctx,
>  					&cur_bytes_submitted);
> -
> -	if (ctx->read_ctx && ctx->ops->submit_read)
> -		ctx->ops->submit_read(&iter, ctx);
> +		iomap_submit_read(&iter, ctx, !iter.iomap.length);
> +	}
>  
>  	if (ctx->cur_folio)
>  		iomap_read_end(ctx->cur_folio, cur_bytes_submitted);
> diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
> index f2bb56506046..f7bd55275d8c 100644
> --- a/fs/ntfs/aops.c
> +++ b/fs/ntfs/aops.c
> @@ -38,7 +38,7 @@ static void ntfs_iomap_read_end_io(struct bio *bio)
>  }
>  
>  static void ntfs_iomap_bio_submit_read(const struct iomap_iter *iter,
> -		struct iomap_read_folio_ctx *ctx)
> +		struct iomap_read_folio_ctx *ctx, bool force)
>  {
>  	iomap_bio_submit_read_endio(iter, ctx, ntfs_iomap_read_end_io);
>  }
> diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
> index f9600aba1548..cd05faebb806 100644
> --- a/fs/ntfs3/inode.c
> +++ b/fs/ntfs3/inode.c
> @@ -607,7 +607,7 @@ static void ntfs_iomap_read_end_io(struct bio *bio)
>  }
>  
>  static void ntfs_iomap_bio_submit_read(const struct iomap_iter *iter,
> -		struct iomap_read_folio_ctx *ctx)
> +		struct iomap_read_folio_ctx *ctx, bool force)
>  {
>  	iomap_bio_submit_read_endio(iter, ctx, ntfs_iomap_read_end_io);
>  }
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 51293b6f331f..1b9a55e2f4a7 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -758,7 +758,8 @@ xfs_vm_bmap(
>  static void
>  xfs_bio_submit_read(
>  	const struct iomap_iter		*iter,
> -	struct iomap_read_folio_ctx	*ctx)
> +	struct iomap_read_folio_ctx	*ctx,
> +	bool				force)
>  {
>  	struct bio			*bio = ctx->read_ctx;
>  
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 56b43d594e6e..4d8893b02aaf 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -528,7 +528,7 @@ struct iomap_read_ops {
>  	 * This is optional.
>  	 */
>  	void (*submit_read)(const struct iomap_iter *iter,
> -			struct iomap_read_folio_ctx *ctx);
> +			struct iomap_read_folio_ctx *ctx, bool force);
>  
>  	/*
>  	 * Optional, allows filesystem to specify own bio_set, so new bio's
> -- 
> 2.53.0
> 
> 

