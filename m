Return-Path: <linux-erofs+bounces-3760-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tRC6NBVlPWrd2QgAu9opvQ
	(envelope-from <linux-erofs+bounces-3760-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Jun 2026 19:27:49 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFB86C7C7A
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Jun 2026 19:27:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=iETBEHN+;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3760-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3760-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmQjr4zLHz2y8p;
	Fri, 26 Jun 2026 03:27:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782408464;
	cv=none; b=PCKQe+hxZ/NvzrkFqKvtflY5kPrWOIesMCilEDs2mS4jm4BbP2OiQ/pRoRyk64d7t07++p0lXMaI8KwBUVkWG6qCwPAamPEavfI65IuwwEvpwxfmzlsGO9bw+I6Y+2HHUXSONouFk7OSHyyt4Zj9bmIFk55FInvXg8bCiHqpTzYDtJDZDQrohHIe6w+9h03YnOrz8x3yZTD/fK9x760vxibngfnl+j5mrckKLM7Tyt9u21awzQZ9qAie+nnuLFh4RhwMnipat5tKi/HtpnhJX+9e10oPhCeGaur/Oz6JNkya0FFlI81jf5P1X7I1REbRjgudgOULws2cHGNjRvIR9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782408464; c=relaxed/relaxed;
	bh=tvuLwEQoSIdOrb203mC98VZ//kFDZO0IRJjscdA56ZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SrYIUn1wkAafWFOPwW6mEZC4Iu4lp8eJTPOPb6uMezC3fmgD4E3a4DvCrOLI3z6eEXqx1RTLnRTevZh+a6jYSHQzjARoUbv+x+p3+W/59sG1huBJ8gOD2eMCIsfWbR7YQcEIwBvbHWhRsw9kB9kQKBbpZXN4WSthwXTZIE30pcD/0rRDJU621gmu5CvOhXLz4paoxQO/3uDCrXPtYM6KSsFp31D0Rm5uc/nEpZq/ULQDiOfb1CUHpgGeDxjrO7wByCau4LcZ5okMZy+WJwd3QUP06AnMERn22iStmx5BMlPkFhwNCKrienAbp87Zwg80flhoWcsJQfm3UgHL2Nsb3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iETBEHN+; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=djwong@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4gmQjq1b1hz2xM7
	for <linux-erofs@lists.ozlabs.org>; Fri, 26 Jun 2026 03:27:43 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with UTF8SMTP id C974E4427E;
	Thu, 25 Jun 2026 17:27:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 9E6981F00A3D;
	Thu, 25 Jun 2026 17:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782408460;
	bh=tvuLwEQoSIdOrb203mC98VZ//kFDZO0IRJjscdA56ZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iETBEHN+38kSAJ3JIL3Qq/rSXmiT7OPU4aYA8tl8c0dE8Lv/owV2YCuBjNrvAPN3O
	 WjAa2ZhVko/j4rwJj2yX1UqXmy20zln/zPevRSO+M7SF2NjwXRSJecpUHR9QpA6ZhE
	 BWrsgrIt9MCuNfTf4xG7eSC5HjRU74eJf8TrzAivA2PrBOpDg2K8Pd2rYSuIejsa+J
	 kNjlMsey0+l/9zrhyvpeAk97s4BCmvS2AGj4ByxpfKmS4ufngvTBtJ5EBfGGev3/WL
	 ta/UsPme0xV9Hy+lgtJ/AUHvEDMbg0Tui3Z/9iJTka8YxVLsuiieVWlCRnTyZGjR6Y
	 3YUaLfHUGLZ+A==
Date: Thu, 25 Jun 2026 10:27:40 -0700
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
Subject: Re: [PATCH 1/2] iomap: consolidate bio submission
Message-ID: <20260625172740.GD6078@frogsfrogsfrogs>
References: <20260625120803.2462291-1-hch@lst.de>
 <20260625120803.2462291-2-hch@lst.de>
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
In-Reply-To: <20260625120803.2462291-2-hch@lst.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hch@lst.de,m:brauner@kernel.org,m:yekelu1@huawei.com,m:zhaoyifan28@huawei.com,m:ritesh.list@gmail.com,m:joannelkoong@gmail.com,m:linkinjeon@kernel.org,m:sj1557.seo@samsung.com,m:hyc.lee@gmail.com,m:almaz.alexandrovich@paragon-software.com,m:miklos@szeredi.hu,m:fuse-devel@lists.linux.dev,m:ntfs3@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-xfs@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:riteshlist@gmail.com,m:hyclee@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[djwong@kernel.org,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-3760-lists,linux-erofs=lfdr.de];
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
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3AFB86C7C7A

On Thu, Jun 25, 2026 at 02:07:56PM +0200, Christoph Hellwig wrote:
> Add a iomap_bio_submit_read_endio helper factored out of
> iomap_bio_submit_read to that all ->submit_read implementations for
> iomap_read_ops that use iomap_bio_read_folio_range can shared the
> logic.
> 
> Right now that logic is mostly trivial, but already has a bug for XFS
> because the XFS version is too trivial:  file system integrity validation
> needs a workqueue context and thus can't happen from the default iomap
> bi_end_io I/O handler.  Unfortunately the iomap refactoring just before
> fs integrity landed moved code around here and the call go misplaced,
> meaning it never got called.  The PI information still is verified by
> the block layer, but the offloading is less efficient (and the future
> userspace interface can't get at it).
> 
> Fixes: 0b10a370529c ("iomap: support T10 protection information")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/exfat/iomap.c      |  5 +----
>  fs/iomap/bio.c        | 13 ++++++++++---
>  fs/ntfs/aops.c        |  6 ++----
>  fs/ntfs3/inode.c      |  5 +----
>  fs/xfs/xfs_aops.c     |  3 +--
>  include/linux/iomap.h |  2 ++
>  6 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/exfat/iomap.c b/fs/exfat/iomap.c
> index 1aac38e63fe6..190fc6471f84 100644
> --- a/fs/exfat/iomap.c
> +++ b/fs/exfat/iomap.c
> @@ -253,10 +253,7 @@ static void exfat_iomap_read_end_io(struct bio *bio)
>  static void exfat_iomap_bio_submit_read(const struct iomap_iter *iter,
>  		struct iomap_read_folio_ctx *ctx)
>  {
> -	struct bio *bio = ctx->read_ctx;
> -
> -	bio->bi_end_io = exfat_iomap_read_end_io;
> -	submit_bio(bio);
> +	iomap_bio_submit_read_endio(iter, ctx, exfat_iomap_read_end_io);
>  }
>  
>  const struct iomap_read_ops exfat_iomap_bio_read_ops = {
> diff --git a/fs/iomap/bio.c b/fs/iomap/bio.c
> index 4504f4633f17..0f31e35567b4 100644
> --- a/fs/iomap/bio.c
> +++ b/fs/iomap/bio.c
> @@ -78,15 +78,23 @@ u32 iomap_finish_ioend_buffered_read(struct iomap_ioend *ioend)
>  	return __iomap_read_end_io(&ioend->io_bio, ioend->io_error);
>  }
>  
> -static void iomap_bio_submit_read(const struct iomap_iter *iter,
> -		struct iomap_read_folio_ctx *ctx)
> +void iomap_bio_submit_read_endio(const struct iomap_iter *iter,
> +		struct iomap_read_folio_ctx *ctx, bio_end_io_t end_io)
>  {
>  	struct bio *bio = ctx->read_ctx;
>  
> +	bio->bi_end_io = end_io;
>  	if (iter->iomap.flags & IOMAP_F_INTEGRITY)
>  		fs_bio_integrity_alloc(bio);

Ah, so the bug here is that all the pagecache readers should have been
allocating integrity information for the bio before submitting it?  And
because it doesn't, iomap_finish_ioend won't do the read verification?
So the block layer does it for us, and that's why we don't use the ioend
chaining?  And (I guess) the future userspace interface won't have any
means to get at the integrity data?

If the answers to all four questions is "yes" then I've understood this
fix well enough to declare

Cc: <stable@vger.kernel.org> # v7.1
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>


--D

>  	submit_bio(bio);
>  }
> +EXPORT_SYMBOL_GPL(iomap_bio_submit_read_endio);
> +
> +static void iomap_bio_submit_read(const struct iomap_iter *iter,
> +		struct iomap_read_folio_ctx *ctx)
> +{
> +	return iomap_bio_submit_read_endio(iter, ctx, iomap_read_end_io);
> +}
>  
>  static struct bio_set *iomap_read_bio_set(struct iomap_read_folio_ctx *ctx)
>  {
> @@ -127,7 +135,6 @@ static void iomap_read_alloc_bio(const struct iomap_iter *iter,
>  	if (ctx->rac)
>  		bio->bi_opf |= REQ_RAHEAD;
>  	bio->bi_iter.bi_sector = iomap_sector(iomap, iter->pos);
> -	bio->bi_end_io = iomap_read_end_io;
>  	bio_add_folio_nofail(bio, folio, plen,
>  			offset_in_folio(folio, iter->pos));
>  	ctx->read_ctx = bio;
> diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
> index 1fbf832ad165..f2bb56506046 100644
> --- a/fs/ntfs/aops.c
> +++ b/fs/ntfs/aops.c
> @@ -38,11 +38,9 @@ static void ntfs_iomap_read_end_io(struct bio *bio)
>  }
>  
>  static void ntfs_iomap_bio_submit_read(const struct iomap_iter *iter,
> -	struct iomap_read_folio_ctx *ctx)
> +		struct iomap_read_folio_ctx *ctx)
>  {
> -	struct bio *bio = ctx->read_ctx;
> -	bio->bi_end_io = ntfs_iomap_read_end_io;
> -	submit_bio(bio);
> +	iomap_bio_submit_read_endio(iter, ctx, ntfs_iomap_read_end_io);
>  }
>  
>  static const struct iomap_read_ops ntfs_iomap_bio_read_ops = {
> diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
> index 42af1abe17f8..f9600aba1548 100644
> --- a/fs/ntfs3/inode.c
> +++ b/fs/ntfs3/inode.c
> @@ -609,10 +609,7 @@ static void ntfs_iomap_read_end_io(struct bio *bio)
>  static void ntfs_iomap_bio_submit_read(const struct iomap_iter *iter,
>  		struct iomap_read_folio_ctx *ctx)
>  {
> -	struct bio *bio = ctx->read_ctx;
> -
> -	bio->bi_end_io = ntfs_iomap_read_end_io;
> -	submit_bio(bio);
> +	iomap_bio_submit_read_endio(iter, ctx, ntfs_iomap_read_end_io);
>  }
>  
>  static const struct iomap_read_ops ntfs_iomap_bio_read_ops = {
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 2a0c54256e93..51293b6f331f 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -764,8 +764,7 @@ xfs_bio_submit_read(
>  
>  	/* defer read completions to the ioend workqueue */
>  	iomap_init_ioend(iter->inode, bio, ctx->read_ctx_file_offset, 0);
> -	bio->bi_end_io = xfs_end_bio;
> -	submit_bio(bio);
> +	iomap_bio_submit_read_endio(iter, ctx, xfs_end_bio);
>  }
>  
>  static const struct iomap_read_ops xfs_iomap_read_ops = {
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 3582ed1fe236..56b43d594e6e 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -622,6 +622,8 @@ extern struct bio_set iomap_ioend_bioset;
>  #ifdef CONFIG_BLOCK
>  int iomap_bio_read_folio_range(const struct iomap_iter *iter,
>  		struct iomap_read_folio_ctx *ctx, size_t plen);
> +void iomap_bio_submit_read_endio(const struct iomap_iter *iter,
> +		struct iomap_read_folio_ctx *ctx, bio_end_io_t end_io);
>  
>  extern const struct iomap_read_ops iomap_bio_read_ops;
>  
> -- 
> 2.53.0
> 
> 

