Return-Path: <linux-erofs+bounces-3746-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id g1PBBXSKO2rpZQgAu9opvQ
	(envelope-from <linux-erofs+bounces-3746-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Jun 2026 09:42:44 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B34C16BC446
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Jun 2026 09:42:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=kMth0IhV;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3746-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3746-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4glYnC2vvpz2yYq;
	Wed, 24 Jun 2026 17:42:39 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782286959;
	cv=none; b=FORNb1YgtXHzrgFRNepNoW+yu3aKpaB45nbZCLkSxZHyijxsy0tW5QmxjENnvSumHTZVBkV2ZsOvYwaY3FN65xfVe7QUlfpH1NWjBmwy1XdcPovh3eFmMfLE3FqryGREEIbBlk+6CtyTuMs6WTRERB2sA1wSqkQBbIaPTp1qjl26u/bhJTOeGOC/5eHJv4GRTfrLzkW4PW1YWR+/zmhrOiX8V0/0JmbsTjnQ6zZZc3UjLs5YK9xnJUl+zaebuhGu/DI3AVJKpX8hUcWCRAJMAmrPEhIqDQyEnKRs+U2k0KHtKQDvmxCIEYnthEw/cPL4MHsolVQEfqIeCCxby6YLsg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782286959; c=relaxed/relaxed;
	bh=5xDrHg5co1KjSFEmIZ6auURsrEp+oa0yaiOnWqSSwPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VPnBwV5MBnml3SRTpTMfMoK5qhUtUh/EFGAQ3AYSe2uubSOOvG1moifYj/2WLuZ1go3KS/CyD24px3gPJXt/jV0aPWLSEKIFZVFx4/vjtsPYitU62b3mdBOJmRY4MoWdoj53qUzrPpkx2xpk9qPG78gWABUqpXdnvRHsUBV1tFF8o5xb5EoTpQcO+WnY9JcCb980xTHfporNkaGBon9L9XvOsC9kW4JLJHzkMfkR6kr+4QyOryO3j2vNsJiIpGT2GlSitFNJZtr5/fSxb9s3P7BwRKGxJegwMpp9Tx85/F/WGe2JuOUYMUtFsa8CfkDDh5yn6nzqZTRCNBwre9iEbQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=kMth0IhV; dkim-atps=neutral; spf=pass (client-ip=113.46.200.224; helo=canpmsgout09.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4glYn85mLbz2yQn
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Jun 2026 17:42:35 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=5xDrHg5co1KjSFEmIZ6auURsrEp+oa0yaiOnWqSSwPk=;
	b=kMth0IhVUn8FmeJ56ZYykk8M83S72RZr0s4gXnR4Ckb0aDsAwmWlnlqD1zmyYHHeR9rp0gbHJ
	dSvivNfA7MGujqXtX/SxxPB6j9ba3in+6jo+V0SW6aG4zc3kGujZQXuDEtrugpysfShgR0XOncB
	wV/GY7Zki+gGCNOHjfdF3JA=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4glYZb4BTnz1cyTj;
	Wed, 24 Jun 2026 15:33:27 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 6F4924056E;
	Wed, 24 Jun 2026 15:42:31 +0800 (CST)
Received: from [100.102.28.251] (100.102.28.251) by
 kwepemr100010.china.huawei.com (7.202.195.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 24 Jun 2026 15:42:30 +0800
Message-ID: <02ca0fdf-590a-42da-a0a2-828dac464a2b@huawei.com>
Date: Wed, 24 Jun 2026 15:42:29 +0800
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iomap: submit read bio after each extent
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
CC: Kelu Ye <yekelu1@huawei.com>, Ritesh Harjani <ritesh.list@gmail.com>,
	Joanne Koong <joannelkoong@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>, Hyunchul Lee <hyc.lee@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Miklos Szeredi
	<miklos@szeredi.hu>, <fuse-devel@lists.linux.dev>, <ntfs3@lists.linux.dev>,
	<linux-erofs@lists.ozlabs.org>, <linux-xfs@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>
References: <20260623135208.1812933-1-hch@lst.de>
 <20260623135208.1812933-3-hch@lst.de>
From: "zhaoyifan (H)" <zhaoyifan28@huawei.com>
In-Reply-To: <20260623135208.1812933-3-hch@lst.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [100.102.28.251]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[huawei.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[huawei.com,gmail.com,kernel.org,samsung.com,paragon-software.com,szeredi.hu,lists.linux.dev,lists.ozlabs.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-3746-lists,linux-erofs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[zhaoyifan28@huawei.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS(0.00)[m:hch@lst.de,m:brauner@kernel.org,m:djwong@kernel.org,m:yekelu1@huawei.com,m:ritesh.list@gmail.com,m:joannelkoong@gmail.com,m:linkinjeon@kernel.org,m:sj1557.seo@samsung.com,m:hyc.lee@gmail.com,m:almaz.alexandrovich@paragon-software.com,m:miklos@szeredi.hu,m:fuse-devel@lists.linux.dev,m:ntfs3@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-xfs@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:riteshlist@gmail.com,m:hyclee@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaoyifan28@huawei.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[huawei.com:+];
	HAS_XOIP(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,huawei.com:dkim,huawei.com:email,huawei.com:mid,huawei.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B34C16BC446

The issue where EROFS could merge bios across devices when using iomap 
API no longer exists.

Tested-by: Yifan Zhao <zhaoyifan28@huawei.com>

On 2026/6/23 21:51, Christoph Hellwig wrote:
> Currently the iomap buffered read path tries to build up read context
> (i.e. bios for the typical block based case) over multiple iomaps as
> long as the sector matches.  This does not take into account files
> that can map to multiple different devices.  While this could be fixed
> by a bdev check in iomap_bio_read_folio_range, the building up of I/O
> over iomaps actually was a problem for the not yet merged ext2 iomap
> port, as that does want to send out I/O at the end of an indirect
> block mapped range.
>
> So instead of adding more checks move over to a model where a bio only
> spans a single iomap.  Change ->submit_read to be called after each
> iteration, and pass a force argument to indicate that the bio must
> be submitted set on the last iteration.  Switch the bio based users
> to always submit, while keeping the single submit for fuse.
>
> Fixes: dfeab2e95a75 ("erofs: add multiple device support")
> Reported-by: Kelu Ye <yekelu1@huawei.com>
> Reported-by: Yifan Zhao <zhaoyifan28@huawei.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/exfat/iomap.c       |  4 ++--
>   fs/fuse/file.c         |  6 +++++-
>   fs/iomap/bio.c         | 11 +++++++----
>   fs/iomap/buffered-io.c | 23 +++++++++++++++--------
>   fs/ntfs/aops.c         |  4 ++--
>   fs/ntfs3/inode.c       |  4 ++--
>   fs/xfs/xfs_aops.c      |  5 +++--
>   include/linux/iomap.h  |  5 +++--
>   8 files changed, 39 insertions(+), 23 deletions(-)
>
> diff --git a/fs/exfat/iomap.c b/fs/exfat/iomap.c
> index 190fc6471f84..58e25c4e8587 100644
> --- a/fs/exfat/iomap.c
> +++ b/fs/exfat/iomap.c
> @@ -251,9 +251,9 @@ static void exfat_iomap_read_end_io(struct bio *bio)
>   }
>   
>   static void exfat_iomap_bio_submit_read(const struct iomap_iter *iter,
> -		struct iomap_read_folio_ctx *ctx)
> +		struct iomap_read_folio_ctx *ctx, bool force)
>   {
> -	iomap_bio_submit_read_endio(iter, ctx, exfat_iomap_read_end_io);
> +	iomap_bio_submit_read_endio(iter, ctx, force, exfat_iomap_read_end_io);
>   }
>   
>   const struct iomap_read_ops exfat_iomap_bio_read_ops = {
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index e052a0d44dee..6fa3b1f55c95 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -982,13 +982,17 @@ static int fuse_iomap_read_folio_range_async(const struct iomap_iter *iter,
>   }
>   
>   static void fuse_iomap_submit_read(const struct iomap_iter *iter,
> -		struct iomap_read_folio_ctx *ctx)
> +		struct iomap_read_folio_ctx *ctx, bool force)
>   {
>   	struct fuse_fill_read_data *data = ctx->read_ctx;
>   
> +	if (!force)
> +		return;
> +
>   	if (data->ia)
>   		fuse_send_readpages(data->ia, data->file, data->nr_bytes,
>   				    data->fc->async_read);
> +	ctx->read_ctx = NULL;
>   }
>   
>   static const struct iomap_read_ops fuse_iomap_read_ops = {
> diff --git a/fs/iomap/bio.c b/fs/iomap/bio.c
> index 0f31e35567b4..f71aaaf60301 100644
> --- a/fs/iomap/bio.c
> +++ b/fs/iomap/bio.c
> @@ -79,7 +79,8 @@ u32 iomap_finish_ioend_buffered_read(struct iomap_ioend *ioend)
>   }
>   
>   void iomap_bio_submit_read_endio(const struct iomap_iter *iter,
> -		struct iomap_read_folio_ctx *ctx, bio_end_io_t end_io)
> +		struct iomap_read_folio_ctx *ctx, bool force,
> +		bio_end_io_t end_io)
>   {
>   	struct bio *bio = ctx->read_ctx;
>   
> @@ -87,13 +88,15 @@ void iomap_bio_submit_read_endio(const struct iomap_iter *iter,
>   	if (iter->iomap.flags & IOMAP_F_INTEGRITY)
>   		fs_bio_integrity_alloc(bio);
>   	submit_bio(bio);
> +
> +	ctx->read_ctx = NULL;
>   }
>   EXPORT_SYMBOL_GPL(iomap_bio_submit_read_endio);
>   
>   static void iomap_bio_submit_read(const struct iomap_iter *iter,
> -		struct iomap_read_folio_ctx *ctx)
> +		struct iomap_read_folio_ctx *ctx, bool force)
>   {
> -	return iomap_bio_submit_read_endio(iter, ctx, iomap_read_end_io);
> +	return iomap_bio_submit_read_endio(iter, ctx, force, iomap_read_end_io);
>   }
>   
>   static struct bio_set *iomap_read_bio_set(struct iomap_read_folio_ctx *ctx)
> @@ -116,7 +119,7 @@ static void iomap_read_alloc_bio(const struct iomap_iter *iter,
>   
>   	/* Submit the existing range if there was one. */
>   	if (ctx->read_ctx)
> -		ctx->ops->submit_read(iter, ctx);
> +		ctx->ops->submit_read(iter, ctx, true);
>   
>   	/* Same as readahead_gfp_mask: */
>   	if (ctx->rac)
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 8d4806dc46d4..06a216d37548 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -524,6 +524,13 @@ static void iomap_read_end(struct folio *folio, size_t bytes_submitted)
>   	}
>   }
>   
> +static void iomap_submit_read(struct iomap_iter *iter,
> +		struct iomap_read_folio_ctx *ctx, bool force)
> +{
> +	if (ctx->read_ctx && ctx->ops->submit_read)
> +		ctx->ops->submit_read(iter, ctx, force);
> +}
> +
>   static int iomap_read_folio_iter(struct iomap_iter *iter,
>   		struct iomap_read_folio_ctx *ctx, size_t *bytes_submitted)
>   {
> @@ -642,12 +649,12 @@ void iomap_read_folio(const struct iomap_ops *ops,
>   		fsverity_readahead(ctx->vi, folio->index,
>   				   folio_nr_pages(folio));
>   
> -	while ((ret = iomap_iter(&iter, ops)) > 0)
> +	while ((ret = iomap_iter(&iter, ops)) > 0) {
> +		iomap_submit_read(&iter, ctx, false);
>   		iter.status = iomap_read_folio_iter(&iter, ctx,
>   				&bytes_submitted);
> -
> -	if (ctx->read_ctx && ctx->ops->submit_read)
> -		ctx->ops->submit_read(&iter, ctx);
> +	}
> +	iomap_submit_read(&iter, ctx, true);
>   
>   	if (ctx->cur_folio)
>   		iomap_read_end(ctx->cur_folio, bytes_submitted);
> @@ -718,12 +725,12 @@ void iomap_readahead(const struct iomap_ops *ops,
>   		fsverity_readahead(ctx->vi, readahead_index(rac),
>   				readahead_count(rac));
>   
> -	while (iomap_iter(&iter, ops) > 0)
> +	while (iomap_iter(&iter, ops) > 0) {
> +		iomap_submit_read(&iter, ctx, false);
>   		iter.status = iomap_readahead_iter(&iter, ctx,
>   					&cur_bytes_submitted);
> -
> -	if (ctx->read_ctx && ctx->ops->submit_read)
> -		ctx->ops->submit_read(&iter, ctx);
> +	}
> +	iomap_submit_read(&iter, ctx, true);
>   
>   	if (ctx->cur_folio)
>   		iomap_read_end(ctx->cur_folio, cur_bytes_submitted);
> diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
> index f2bb56506046..c32ecc28cb52 100644
> --- a/fs/ntfs/aops.c
> +++ b/fs/ntfs/aops.c
> @@ -38,9 +38,9 @@ static void ntfs_iomap_read_end_io(struct bio *bio)
>   }
>   
>   static void ntfs_iomap_bio_submit_read(const struct iomap_iter *iter,
> -		struct iomap_read_folio_ctx *ctx)
> +		struct iomap_read_folio_ctx *ctx, bool force)
>   {
> -	iomap_bio_submit_read_endio(iter, ctx, ntfs_iomap_read_end_io);
> +	iomap_bio_submit_read_endio(iter, ctx, force, ntfs_iomap_read_end_io);
>   }
>   
>   static const struct iomap_read_ops ntfs_iomap_bio_read_ops = {
> diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
> index f9600aba1548..110c9b8208e1 100644
> --- a/fs/ntfs3/inode.c
> +++ b/fs/ntfs3/inode.c
> @@ -607,9 +607,9 @@ static void ntfs_iomap_read_end_io(struct bio *bio)
>   }
>   
>   static void ntfs_iomap_bio_submit_read(const struct iomap_iter *iter,
> -		struct iomap_read_folio_ctx *ctx)
> +		struct iomap_read_folio_ctx *ctx, bool force)
>   {
> -	iomap_bio_submit_read_endio(iter, ctx, ntfs_iomap_read_end_io);
> +	iomap_bio_submit_read_endio(iter, ctx, force, ntfs_iomap_read_end_io);
>   }
>   
>   static const struct iomap_read_ops ntfs_iomap_bio_read_ops = {
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 51293b6f331f..42ebb2265408 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -758,13 +758,14 @@ xfs_vm_bmap(
>   static void
>   xfs_bio_submit_read(
>   	const struct iomap_iter		*iter,
> -	struct iomap_read_folio_ctx	*ctx)
> +	struct iomap_read_folio_ctx	*ctx,
> +	bool				force)
>   {
>   	struct bio			*bio = ctx->read_ctx;
>   
>   	/* defer read completions to the ioend workqueue */
>   	iomap_init_ioend(iter->inode, bio, ctx->read_ctx_file_offset, 0);
> -	iomap_bio_submit_read_endio(iter, ctx, xfs_end_bio);
> +	iomap_bio_submit_read_endio(iter, ctx, force, xfs_end_bio);
>   }
>   
>   static const struct iomap_read_ops xfs_iomap_read_ops = {
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 56b43d594e6e..266844b62372 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -528,7 +528,7 @@ struct iomap_read_ops {
>   	 * This is optional.
>   	 */
>   	void (*submit_read)(const struct iomap_iter *iter,
> -			struct iomap_read_folio_ctx *ctx);
> +			struct iomap_read_folio_ctx *ctx, bool force);
>   
>   	/*
>   	 * Optional, allows filesystem to specify own bio_set, so new bio's
> @@ -623,7 +623,8 @@ extern struct bio_set iomap_ioend_bioset;
>   int iomap_bio_read_folio_range(const struct iomap_iter *iter,
>   		struct iomap_read_folio_ctx *ctx, size_t plen);
>   void iomap_bio_submit_read_endio(const struct iomap_iter *iter,
> -		struct iomap_read_folio_ctx *ctx, bio_end_io_t end_io);
> +		struct iomap_read_folio_ctx *ctx, bool force,
> +		bio_end_io_t end_io);
>   
>   extern const struct iomap_read_ops iomap_bio_read_ops;
>   

