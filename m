Return-Path: <linux-erofs+bounces-3809-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FsTxOsmYRmqPZgsAu9opvQ
	(envelope-from <linux-erofs+bounces-3809-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Jul 2026 18:58:49 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2F26FAD11
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Jul 2026 18:58:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CrRX4a4t;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3809-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3809-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grjlB4YbCz2xPb;
	Fri, 03 Jul 2026 02:58:46 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783011526;
	cv=none; b=PTSVroo9N6Dlu/3NB2NYY+oRUn8XzA0cK1UNIidt+wx0SmPYpGT+OqUJIMrfNpcbh7Tt9jCeer8aQC92/27bge/t4XKywg/bcM276+GzxKTfAId0z/D5311W+wJFafrcCYmvfxx4D1HJOm6NhZ/yFQhBUp6d3DptAyExhZUwP8yW+70c6vOvSeNbdWAfC+b5lnS4nl6w1CxVWdJARHuqDDYr8yzQOXmh9hIW28gz8TfNgqLm1bSxPfx5NSd1Ze3k3kSw2CwRYypsP9ZJ/Onp+jfzPfuONtKLsROdH1niHOaDgaGlce/F+Vem3LkRZ/4hJ/weO490qYSlB7Ofve+SSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783011526; c=relaxed/relaxed;
	bh=Zb5EXf2ovo6UufrOrmxA5aKxNooLmPywNDd7EorJKw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2ZCSMckjSLIJ5NjTWrvmaIEewWYx6VY0W43xcZgtDGG3VSoV62LfQMRX8H8tB8doR3bIrO7JxcU7NDKnFt2FVC+0Zkk23xdTkjtes4AA8d9B1JDSIITfMBN1yYrZPo6sxDGiShg2gR8/MinLtpXOFS8uLqvCWGV4DIzIHb4YXNsbCOrC79Yls1pZrlRA8EXePGt/HsxcOINqqR/Kf0eU7A/FCiUGnAWymFgH3Ss+0V+qaUnHrqfylWo2H2OcosnZ8PC0U3MnQ20WIjXP5J0YuF+Q9k6chNO02BE1gaYpCqjTiWyJpJ59waVpQ5vDxxSahUBMhVEHU67CXgH++MrKQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CrRX4a4t; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=djwong@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4grjl90zngz2xLq
	for <linux-erofs@lists.ozlabs.org>; Fri, 03 Jul 2026 02:58:45 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with UTF8SMTP id 8F52A601E3;
	Thu,  2 Jul 2026 16:58:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 1D9BD1F00A3E;
	Thu,  2 Jul 2026 16:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783011522;
	bh=Zb5EXf2ovo6UufrOrmxA5aKxNooLmPywNDd7EorJKw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CrRX4a4txrvnJFsq8oC4/tLM23WGjr79R1MaXHPIntlbz2i82r3XLtXpgw8yN0y81
	 uVPZwMvQWPGXeBAGsB0vu+rPz0S+03F5LZog1LWuHUbljjzyinbiqS7hwgE6pMLtni
	 kIcIkwwmhVGuEVlC9PmMCFRyz83W7+dpUMYRGeF2PzLvkpPPvucfC2gc3XYHg0YTX1
	 34IGxmH9rtPnDL7P3ZRRwWGXsxm4IWB5M48pvwPNmXpuadV56EWnisVxXG+RilRucL
	 rWTku0kZz+GuPQWu4VyLMbxCf0ZeKbR+IM7Y8gEic3vFhVJd5LQ0CNduVtqkyxq6nk
	 4aGi0F4S/+HHA==
Date: Thu, 2 Jul 2026 09:58:41 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, hch@lst.de, willy@infradead.org,
	hsiangkao@linux.alibaba.com, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Dan Williams <djbw@kernel.org>, Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Chunhai Guo <guochunhai@vivo.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>, Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Zhang Yi <yi.zhang@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>,
	"open list:FILESYSTEM DIRECT ACCESS (DAX)" <nvdimm@lists.linux.dev>,
	"open list:EROFS FILE SYSTEM" <linux-erofs@lists.ozlabs.org>,
	"open list:EXT2 FILE SYSTEM" <linux-ext4@vger.kernel.org>,
	"open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>,
	"open list:FUSE FILESYSTEM [CORE]" <fuse-devel@lists.linux.dev>,
	"open list:GFS2 FILE SYSTEM" <gfs2@lists.linux.dev>,
	"open list:NTFS3 FILESYSTEM" <ntfs3@lists.linux.dev>
Subject: Re: [PATCH v2 17/18] iomap: pass iomap_next_fn directly instead of
 struct iomap_ops
Message-ID: <20260702165841.GM9392@frogsfrogsfrogs>
References: <20260701000949.1666714-1-joannelkoong@gmail.com>
 <20260701000949.1666714-18-joannelkoong@gmail.com>
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
In-Reply-To: <20260701000949.1666714-18-joannelkoong@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	FORGED_RECIPIENTS(0.00)[m:joannelkoong@gmail.com,m:brauner@kernel.org,m:hch@lst.de,m:willy@infradead.org,m:hsiangkao@linux.alibaba.com,m:linux-fsdevel@vger.kernel.org,m:linux-xfs@vger.kernel.org,m:axboe@kernel.dk,m:clm@fb.com,m:dsterba@suse.com,m:viro@zeniv.linux.org.uk,m:jack@suse.cz,m:djbw@kernel.org,m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:guochunhai@vivo.com,m:linkinjeon@kernel.org,m:sj1557.seo@samsung.com,m:yuezhang.mo@sony.com,m:tytso@mit.edu,m:adilger.kernel@dilger.ca,m:libaokun@linux.alibaba.com,m:ojaswin@linux.ibm.com,m:ritesh.list@gmail.com,m:yi.zhang@huawei.com,m:jaegeuk@kernel.org,m:miklos@szeredi.hu,m:agruenba@redhat.com,m:mikulas@artax.karlin.mff.cuni.cz,m:hyc.lee@gmail.com,m:almaz.alexandrovich@paragon-software.com,m:cem@kernel.org,m:dlemoal@kernel.org,m:naohiro.aota@wdc.com,m:jth@kernel.org,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-btrfs@vger.kernel
 .org,m:nvdimm@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-ext4@vger.kernel.org,m:linux-f2fs-devel@lists.sourceforge.net,m:fuse-devel@lists.linux.dev,m:gfs2@lists.linux.dev,m:ntfs3@lists.linux.dev,m:riteshlist@gmail.com,m:hyclee@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-3809-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[djwong@kernel.org,linux-erofs@lists.ozlabs.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[kernel.org,lst.de,infradead.org,linux.alibaba.com,vger.kernel.org,kernel.dk,fb.com,suse.com,zeniv.linux.org.uk,suse.cz,gmail.com,google.com,huawei.com,vivo.com,samsung.com,sony.com,mit.edu,dilger.ca,linux.ibm.com,szeredi.hu,redhat.com,artax.karlin.mff.cuni.cz,paragon-software.com,wdc.com,lists.linux.dev,lists.ozlabs.org,lists.sourceforge.net];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp,frogsfrogsfrogs:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1D2F26FAD11

On Tue, Jun 30, 2026 at 05:09:32PM -0700, Joanne Koong wrote:
> Now that all filesystems implement ->iomap_next() and the legacy
> ->iomap_begin()/->iomap_end() fallback is gone, struct iomap_ops only
> wraps a single iomap_next function pointer. Drop the struct entirely and
> pass the iomap_next_fn directly to iomap_iter() and all the iomap/dax
> entry points; filesystems pass their ->iomap_next function instead of an
> ops struct.
> 
> No functional change intended.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

I'm gonna cut out quite a bit of this patch to reduce the reply size.

> ---
<snip>
>  fs/iomap/buffered-io.c | 38 ++++++++++++++---------------
>  fs/iomap/direct-io.c   |  8 +++---
>  fs/iomap/fiemap.c      |  8 +++---
>  fs/iomap/iter.c        |  8 +++---
>  fs/iomap/seek.c        |  8 +++---
>  fs/iomap/swapfile.c    |  4 +--
<snip>
>  fs/remap_range.c       |  6 ++---
>  fs/xfs/xfs_aops.c      |  8 +++---
>  fs/xfs/xfs_file.c      | 40 +++++++++++++++---------------
>  fs/xfs/xfs_iomap.c     | 55 +++++++++---------------------------------
>  fs/xfs/xfs_iomap.h     | 24 ++++++++++++------
>  fs/xfs/xfs_iops.c      |  4 +--
>  fs/xfs/xfs_reflink.c   |  6 ++---
>  fs/zonefs/file.c       | 22 ++++++-----------
>  include/linux/dax.h    | 18 ++++++--------
>  include/linux/fs.h     |  7 ++++--
>  include/linux/iomap.h  | 46 +++++++++++++++--------------------
>  54 files changed, 302 insertions(+), 411 deletions(-)
> 
<snip>

> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 3f0932e46fd6..0aa8abc438c1 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -626,7 +626,7 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
>  	return 0;
>  }
>  
> -void iomap_read_folio(const struct iomap_ops *ops,
> +void iomap_read_folio(iomap_next_fn iomap_next,

If you took my earlier suggestion to rename the typedef to
iomap_iter_fn, then this parameter ought to be named iter_fn.

>  		struct iomap_read_folio_ctx *ctx, void *private)
>  {
>  	struct folio *folio = ctx->cur_folio;
> @@ -650,7 +650,7 @@ void iomap_read_folio(const struct iomap_ops *ops,
>  		fsverity_readahead(ctx->vi, folio->index,
>  				   folio_nr_pages(folio));
>  
> -	while ((ret = iomap_iter(&iter, ops)) > 0) {
> +	while ((ret = iomap_iter(&iter, iomap_next)) > 0) {
>  		iter.status = iomap_read_folio_iter(&iter, ctx,
>  				&bytes_submitted);
>  		iomap_read_submit(&iter, ctx);
> @@ -688,22 +688,22 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
>  
>  /**
>   * iomap_readahead - Attempt to read pages from a file.
> - * @ops: The operations vector for the filesystem.
> + * @iomap_next: The iomap_next callback for the filesystem.

"The iomap iteration function for the filesystem" ?

Using the term "iomap_next" in the definition for iomap_next isn't that
helpful.

>   * @ctx: The ctx used for issuing readahead.
>   * @private: The filesystem-specific information for issuing iomap_iter.
>   *
>   * This function is for filesystems to call to implement their readahead
>   * address_space operation.
>   *
> - * Context: The @ops callbacks may submit I/O (eg to read the addresses of
> + * Context: The @iomap_next callback may submit I/O (eg to read the addresses of
>   * blocks from disc), and may wait for it.  The caller may be trying to
>   * access a different page, and so sleeping excessively should be avoided.
>   * It may allocate memory, but should avoid costly allocations.  This
>   * function is called with memalloc_nofs set, so allocations will not cause
>   * the filesystem to be reentered.
>   */
> -void iomap_readahead(const struct iomap_ops *ops,
> -		struct iomap_read_folio_ctx *ctx, void *private)
> +void iomap_readahead(iomap_next_fn iomap_next, struct iomap_read_folio_ctx *ctx,
> +		void *private)
>  {
>  	struct readahead_control *rac = ctx->rac;
>  	struct iomap_iter iter = {
> @@ -725,7 +725,7 @@ void iomap_readahead(const struct iomap_ops *ops,
>  		fsverity_readahead(ctx->vi, readahead_index(rac),
>  				readahead_count(rac));
>  
> -	while (iomap_iter(&iter, ops) > 0) {
> +	while (iomap_iter(&iter, iomap_next) > 0) {
>  		iter.status = iomap_readahead_iter(&iter, ctx,
>  					&cur_bytes_submitted);
>  		iomap_read_submit(&iter, ctx);
> @@ -1268,7 +1268,7 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i,
>  
>  ssize_t
>  iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
> -		const struct iomap_ops *ops,
> +		iomap_next_fn iomap_next,
>  		const struct iomap_write_ops *write_ops, void *private)
>  {
>  	struct iomap_iter iter = {
> @@ -1285,7 +1285,7 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
>  	if (iocb->ki_flags & IOCB_DONTCACHE)
>  		iter.flags |= IOMAP_DONTCACHE;
>  
> -	while ((ret = iomap_iter(&iter, ops)) > 0)
> +	while ((ret = iomap_iter(&iter, iomap_next)) > 0)
>  		iter.status = iomap_write_iter(&iter, i, write_ops);
>  
>  	if (unlikely(iter.pos == iocb->ki_pos))
> @@ -1297,7 +1297,7 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
>  EXPORT_SYMBOL_GPL(iomap_file_buffered_write);
>  
>  int iomap_fsverity_write(struct file *file, loff_t pos, size_t length,
> -		const void *buf, const struct iomap_ops *ops,
> +		const void *buf, iomap_next_fn iomap_next,
>  		const struct iomap_write_ops *write_ops)
>  {
>  	int			ret;
> @@ -1314,7 +1314,7 @@ int iomap_fsverity_write(struct file *file, loff_t pos, size_t length,
>  
>  	iov_iter_kvec(&iiter, WRITE, &kvec, 1, length);
>  
> -	ret = iomap_file_buffered_write(&iocb, &iiter, ops, write_ops, NULL);
> +	ret = iomap_file_buffered_write(&iocb, &iiter, iomap_next, write_ops, NULL);
>  	if (ret < 0)
>  		return ret;
>  	return ret == length ? 0 : -EIO;
> @@ -1586,7 +1586,7 @@ static int iomap_unshare_iter(struct iomap_iter *iter,
>  
>  int
>  iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
> -		const struct iomap_ops *ops,
> +		iomap_next_fn iomap_next,
>  		const struct iomap_write_ops *write_ops)
>  {
>  	struct iomap_iter iter = {
> @@ -1601,7 +1601,7 @@ iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
>  		return 0;
>  
>  	iter.len = min(len, size - pos);
> -	while ((ret = iomap_iter(&iter, ops)) > 0)
> +	while ((ret = iomap_iter(&iter, iomap_next)) > 0)
>  		iter.status = iomap_unshare_iter(&iter, write_ops);
>  	return ret;
>  }
> @@ -1710,7 +1710,7 @@ EXPORT_SYMBOL_GPL(iomap_fill_dirty_folios);
>  
>  int
>  iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
> -		const struct iomap_ops *ops,
> +		iomap_next_fn iomap_next,
>  		const struct iomap_write_ops *write_ops, void *private)
>  {
>  	struct folio_batch fbatch;
> @@ -1735,7 +1735,7 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
>  	 */
>  	range_dirty = filemap_range_needs_writeback(mapping, iter.pos,
>  					iter.pos + iter.len - 1);
> -	while ((ret = iomap_iter(&iter, ops)) > 0) {
> +	while ((ret = iomap_iter(&iter, iomap_next)) > 0) {
>  		const struct iomap *srcmap = iomap_iter_srcmap(&iter);
>  
>  		if (!(iter.iomap.flags & IOMAP_F_FOLIO_BATCH) &&
> @@ -1761,7 +1761,7 @@ EXPORT_SYMBOL_GPL(iomap_zero_range);
>  
>  int
>  iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
> -		const struct iomap_ops *ops,
> +		iomap_next_fn iomap_next,
>  		const struct iomap_write_ops *write_ops, void *private)
>  {
>  	unsigned int blocksize = i_blocksize(inode);
> @@ -1770,7 +1770,7 @@ iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
>  	/* Block boundary? Nothing to do */
>  	if (!off)
>  		return 0;
> -	return iomap_zero_range(inode, pos, blocksize - off, did_zero, ops,
> +	return iomap_zero_range(inode, pos, blocksize - off, did_zero, iomap_next,
>  			write_ops, private);
>  }
>  EXPORT_SYMBOL_GPL(iomap_truncate_page);
> @@ -1795,7 +1795,7 @@ static int iomap_folio_mkwrite_iter(struct iomap_iter *iter,
>  	return iomap_iter_advance(iter, length);
>  }
>  
> -vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops,
> +vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, iomap_next_fn iomap_next,
>  		void *private)
>  {
>  	struct iomap_iter iter = {
> @@ -1812,7 +1812,7 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops,
>  		goto out_unlock;
>  	iter.pos = folio_pos(folio);
>  	iter.len = ret;
> -	while ((ret = iomap_iter(&iter, ops)) > 0)
> +	while ((ret = iomap_iter(&iter, iomap_next)) > 0)
>  		iter.status = iomap_folio_mkwrite_iter(&iter, folio);
>  
>  	if (ret < 0)
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index b485e3b191da..e299d186f743 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -676,7 +676,7 @@ static int iomap_dio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
>   */
>  struct iomap_dio *
>  __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> -		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
> +		iomap_next_fn iomap_next, const struct iomap_dio_ops *dops,
>  		unsigned int dio_flags, void *private, size_t done_before)
>  {
>  	struct inode *inode = file_inode(iocb->ki_filp);
> @@ -800,7 +800,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	inode_dio_begin(inode);
>  
>  	blk_start_plug(&plug);
> -	while ((ret = iomap_iter(&iomi, ops)) > 0) {
> +	while ((ret = iomap_iter(&iomi, iomap_next)) > 0) {
>  		iomi.status = iomap_dio_iter(&iomi, dio);
>  
>  		/*
> @@ -890,12 +890,12 @@ EXPORT_SYMBOL_GPL(__iomap_dio_rw);
>  
>  ssize_t
>  iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> -		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
> +		iomap_next_fn iomap_next, const struct iomap_dio_ops *dops,
>  		unsigned int dio_flags, void *private, size_t done_before)
>  {
>  	struct iomap_dio *dio;
>  
> -	dio = __iomap_dio_rw(iocb, iter, ops, dops, dio_flags, private,
> +	dio = __iomap_dio_rw(iocb, iter, iomap_next, dops, dio_flags, private,
>  			     done_before);
>  	if (IS_ERR_OR_NULL(dio))
>  		return PTR_ERR_OR_ZERO(dio);
> diff --git a/fs/iomap/fiemap.c b/fs/iomap/fiemap.c
> index d11dadff8286..fc488f05d8ce 100644
> --- a/fs/iomap/fiemap.c
> +++ b/fs/iomap/fiemap.c
> @@ -56,7 +56,7 @@ static int iomap_fiemap_iter(struct iomap_iter *iter,
>  }
>  
>  int iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fi,
> -		u64 start, u64 len, const struct iomap_ops *ops)
> +		u64 start, u64 len, iomap_next_fn iomap_next)
>  {
>  	struct iomap_iter iter = {
>  		.inode		= inode,
> @@ -73,7 +73,7 @@ int iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fi,
>  	if (ret)
>  		return ret;
>  
> -	while ((ret = iomap_iter(&iter, ops)) > 0)
> +	while ((ret = iomap_iter(&iter, iomap_next)) > 0)
>  		iter.status = iomap_fiemap_iter(&iter, fi, &prev);
>  
>  	if (prev.type != IOMAP_HOLE) {
> @@ -92,7 +92,7 @@ EXPORT_SYMBOL_GPL(iomap_fiemap);
>  /* legacy ->bmap interface.  0 is the error return (!) */
>  sector_t
>  iomap_bmap(struct address_space *mapping, sector_t bno,
> -		const struct iomap_ops *ops)
> +		iomap_next_fn iomap_next)
>  {
>  	struct iomap_iter iter = {
>  		.inode	= mapping->host,
> @@ -107,7 +107,7 @@ iomap_bmap(struct address_space *mapping, sector_t bno,
>  		return 0;
>  
>  	bno = 0;
> -	while ((ret = iomap_iter(&iter, ops)) > 0) {
> +	while ((ret = iomap_iter(&iter, iomap_next)) > 0) {
>  		if (iter.iomap.type == IOMAP_MAPPED)
>  			bno = iomap_sector(&iter.iomap, iter.pos) >> blkshift;
>  		/* leave iter.status unset to abort loop */
> diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
> index 466c491bdef6..984045af310a 100644
> --- a/fs/iomap/iter.c
> +++ b/fs/iomap/iter.c
> @@ -42,7 +42,7 @@ static inline void iomap_iter_done(struct iomap_iter *iter)
>  /**
>   * iomap_iter - iterate over a ranges in a file
>   * @iter: iteration structue
> - * @ops: iomap ops provided by the file system
> + * @iomap_next: iomap_next callback provided by the file system
>   *
>   * Iterate over filesystem-provided space mappings for the provided file range.
>   *
> @@ -54,13 +54,13 @@ static inline void iomap_iter_done(struct iomap_iter *iter)
>   * of the loop body:  leave @iter.status unchanged, or set it to a negative
>   * errno.
>   */
> -int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
> +int iomap_iter(struct iomap_iter *iter, iomap_next_fn iomap_next)
>  {
>  	int ret;
>  
> -	trace_iomap_iter(iter, ops, _RET_IP_);
> +	trace_iomap_iter(iter, iomap_next, _RET_IP_);
>  
> -	ret = ops->iomap_next(iter, &iter->iomap, &iter->srcmap);
> +	ret = iomap_next(iter, &iter->iomap, &iter->srcmap);
>  	iter->status = 0;
>  	if (ret > 0)
>  		iomap_iter_done(iter);
> diff --git a/fs/iomap/seek.c b/fs/iomap/seek.c
> index 6cbc587c93da..1bc5053d3fc1 100644
> --- a/fs/iomap/seek.c
> +++ b/fs/iomap/seek.c
> @@ -27,7 +27,7 @@ static int iomap_seek_hole_iter(struct iomap_iter *iter,
>  }
>  
>  loff_t
> -iomap_seek_hole(struct inode *inode, loff_t pos, const struct iomap_ops *ops)
> +iomap_seek_hole(struct inode *inode, loff_t pos, iomap_next_fn iomap_next)
>  {
>  	loff_t size = i_size_read(inode);
>  	struct iomap_iter iter = {
> @@ -42,7 +42,7 @@ iomap_seek_hole(struct inode *inode, loff_t pos, const struct iomap_ops *ops)
>  		return -ENXIO;
>  
>  	iter.len = size - pos;
> -	while ((ret = iomap_iter(&iter, ops)) > 0)
> +	while ((ret = iomap_iter(&iter, iomap_next)) > 0)
>  		iter.status = iomap_seek_hole_iter(&iter, &pos);
>  	if (ret < 0)
>  		return ret;
> @@ -73,7 +73,7 @@ static int iomap_seek_data_iter(struct iomap_iter *iter,
>  }
>  
>  loff_t
> -iomap_seek_data(struct inode *inode, loff_t pos, const struct iomap_ops *ops)
> +iomap_seek_data(struct inode *inode, loff_t pos, iomap_next_fn iomap_next)
>  {
>  	loff_t size = i_size_read(inode);
>  	struct iomap_iter iter = {
> @@ -88,7 +88,7 @@ iomap_seek_data(struct inode *inode, loff_t pos, const struct iomap_ops *ops)
>  		return -ENXIO;
>  
>  	iter.len = size - pos;
> -	while ((ret = iomap_iter(&iter, ops)) > 0)
> +	while ((ret = iomap_iter(&iter, iomap_next)) > 0)
>  		iter.status = iomap_seek_data_iter(&iter, &pos);
>  	if (ret < 0)
>  		return ret;
> diff --git a/fs/iomap/swapfile.c b/fs/iomap/swapfile.c
> index 0db77c449467..b8bb34deddfc 100644
> --- a/fs/iomap/swapfile.c
> +++ b/fs/iomap/swapfile.c
> @@ -139,7 +139,7 @@ static int iomap_swapfile_iter(struct iomap_iter *iter,
>   */
>  int iomap_swapfile_activate(struct swap_info_struct *sis,
>  		struct file *swap_file, sector_t *pagespan,
> -		const struct iomap_ops *ops)
> +		iomap_next_fn iomap_next)
>  {
>  	struct inode *inode = swap_file->f_mapping->host;
>  	struct iomap_iter iter = {
> @@ -163,7 +163,7 @@ int iomap_swapfile_activate(struct swap_info_struct *sis,
>  	if (ret)
>  		return ret;
>  
> -	while ((ret = iomap_iter(&iter, ops)) > 0)
> +	while ((ret = iomap_iter(&iter, iomap_next)) > 0)
>  		iter.status = iomap_swapfile_iter(&iter, &iter.iomap, &isi);
>  	if (ret < 0)
>  		return ret;

<snip>

> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 2a0c54256e93..91480cb6a4d8 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -752,7 +752,7 @@ xfs_vm_bmap(
>  	 */
>  	if (xfs_is_cow_inode(ip) || XFS_IS_REALTIME_INODE(ip))
>  		return 0;
> -	return iomap_bmap(mapping, block, &xfs_read_iomap_ops);
> +	return iomap_bmap(mapping, block, xfs_read_iomap_next);
>  }
>  
>  static void
> @@ -793,7 +793,7 @@ xfs_vm_read_folio(
>  	struct iomap_read_folio_ctx	ctx = { .cur_folio = folio };
>  
>  	ctx.ops = xfs_get_iomap_read_ops(folio->mapping);
> -	iomap_read_folio(&xfs_read_iomap_ops, &ctx, NULL);
> +	iomap_read_folio(xfs_read_iomap_next, &ctx, NULL);
>  	return 0;
>  }
>  
> @@ -804,7 +804,7 @@ xfs_vm_readahead(
>  	struct iomap_read_folio_ctx	ctx = { .rac = rac };
>  
>  	ctx.ops = xfs_get_iomap_read_ops(rac->mapping),
> -	iomap_readahead(&xfs_read_iomap_ops, &ctx, NULL);
> +	iomap_readahead(xfs_read_iomap_next, &ctx, NULL);
>  }
>  
>  static int
> @@ -850,7 +850,7 @@ xfs_vm_swap_activate(
>  	sis->bdev = xfs_inode_buftarg(ip)->bt_bdev;
>  
>  	return iomap_swapfile_activate(sis, swap_file, span,
> -			&xfs_read_iomap_ops);
> +			xfs_read_iomap_next);
>  }
>  
>  const struct address_space_operations xfs_address_space_operations = {
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 7f8bef1a9954..a987ffbf3c02 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -269,7 +269,7 @@ xfs_file_dio_read(
>  		dio_ops = &xfs_dio_read_bounce_ops;
>  		dio_flags |= IOMAP_DIO_BOUNCE;
>  	}
> -	ret = iomap_dio_rw(iocb, to, &xfs_read_iomap_ops, dio_ops, dio_flags,
> +	ret = iomap_dio_rw(iocb, to, xfs_read_iomap_next, dio_ops, dio_flags,
>  			NULL, 0);
>  	xfs_iunlock(ip, XFS_IOLOCK_SHARED);
>  
> @@ -292,7 +292,7 @@ xfs_file_dax_read(
>  	ret = xfs_ilock_iocb(iocb, XFS_IOLOCK_SHARED);
>  	if (ret)
>  		return ret;
> -	ret = dax_iomap_rw(iocb, to, &xfs_read_iomap_ops);
> +	ret = dax_iomap_rw(iocb, to, xfs_read_iomap_next);
>  	xfs_iunlock(ip, XFS_IOLOCK_SHARED);
>  
>  	file_accessed(iocb->ki_filp);
> @@ -742,7 +742,7 @@ xfs_file_dio_write_aligned(
>  	struct xfs_inode	*ip,
>  	struct kiocb		*iocb,
>  	struct iov_iter		*from,
> -	const struct iomap_ops	*ops,
> +	iomap_next_fn		iomap_next,
>  	const struct iomap_dio_ops *dops,
>  	struct xfs_zone_alloc_ctx *ac)
>  {
> @@ -777,7 +777,7 @@ xfs_file_dio_write_aligned(
>  	if (mapping_stable_writes(iocb->ki_filp->f_mapping))
>  		dio_flags |= IOMAP_DIO_BOUNCE;
>  	trace_xfs_file_direct_write(iocb, from);
> -	ret = iomap_dio_rw(iocb, from, ops, dops, dio_flags, ac, 0);
> +	ret = iomap_dio_rw(iocb, from, iomap_next, dops, dio_flags, ac, 0);
>  out_unlock:
>  	xfs_iunlock(ip, iolock);
>  	return ret;
> @@ -799,7 +799,7 @@ xfs_file_dio_write_zoned(
>  	if (ret < 0)
>  		return ret;
>  	ret = xfs_file_dio_write_aligned(ip, iocb, from,
> -			&xfs_zoned_direct_write_iomap_ops,
> +			xfs_zoned_direct_write_iomap_next,
>  			&xfs_dio_zoned_write_ops, &ac);
>  	xfs_zoned_space_unreserve(ip->i_mount, &ac);
>  	return ret;
> @@ -824,16 +824,16 @@ xfs_file_dio_write_atomic(
>  	unsigned int		iolock = XFS_IOLOCK_SHARED;
>  	ssize_t			ret, ocount = iov_iter_count(from);
>  	unsigned int		dio_flags = 0;
> -	const struct iomap_ops	*dops;
> +	iomap_next_fn		dops;
>  
>  	/*
>  	 * HW offload should be faster, so try that first if it is already
>  	 * known that the write length is not too large.
>  	 */
>  	if (ocount > xfs_inode_buftarg(ip)->bt_awu_max)
> -		dops = &xfs_atomic_write_cow_iomap_ops;
> +		dops = xfs_atomic_write_cow_iomap_next;
>  	else
> -		dops = &xfs_direct_write_iomap_ops;
> +		dops = xfs_direct_write_iomap_next;

Probably ought to be called iter_fn, or at least something that isn't
"dops".

>  
>  retry:
>  	ret = xfs_ilock_iocb_for_write(iocb, &iolock);
> @@ -862,9 +862,9 @@ xfs_file_dio_write_atomic(
>  	 * possible. The REQ_ATOMIC-based method is typically not possible if
>  	 * the write spans multiple extents or the disk blocks are misaligned.
>  	 */
> -	if (ret == -ENOPROTOOPT && dops == &xfs_direct_write_iomap_ops) {
> +	if (ret == -ENOPROTOOPT && dops == xfs_direct_write_iomap_next) {
>  		xfs_iunlock(ip, iolock);
> -		dops = &xfs_atomic_write_cow_iomap_ops;
> +		dops = xfs_atomic_write_cow_iomap_next;
>  		goto retry;
>  	}
>  
> @@ -947,7 +947,7 @@ xfs_file_dio_write_unaligned(
>  		flags |= IOMAP_DIO_BOUNCE;
>  
>  	trace_xfs_file_direct_write(iocb, from);
> -	ret = iomap_dio_rw(iocb, from, &xfs_direct_write_iomap_ops,
> +	ret = iomap_dio_rw(iocb, from, xfs_direct_write_iomap_next,
>  			   &xfs_dio_write_ops, flags, NULL, 0);
>  
>  	/*
> @@ -987,7 +987,7 @@ xfs_file_dio_write(
>  	if (iocb->ki_flags & IOCB_ATOMIC)
>  		return xfs_file_dio_write_atomic(ip, iocb, from);
>  	return xfs_file_dio_write_aligned(ip, iocb, from,
> -			&xfs_direct_write_iomap_ops, &xfs_dio_write_ops, NULL);
> +			xfs_direct_write_iomap_next, &xfs_dio_write_ops, NULL);
>  }
>  
>  static noinline ssize_t
> @@ -1011,7 +1011,7 @@ xfs_file_dax_write(
>  	pos = iocb->ki_pos;
>  
>  	trace_xfs_file_dax_write(iocb, from);
> -	ret = dax_iomap_rw(iocb, from, &xfs_dax_write_iomap_ops);
> +	ret = dax_iomap_rw(iocb, from, xfs_dax_write_iomap_next);
>  	if (ret > 0 && iocb->ki_pos > i_size_read(inode)) {
>  		i_size_write(inode, iocb->ki_pos);
>  		error = xfs_setfilesize(ip, pos, ret);
> @@ -1054,7 +1054,7 @@ xfs_file_buffered_write(
>  
>  	trace_xfs_file_buffered_write(iocb, from);
>  	ret = iomap_file_buffered_write(iocb, from,
> -			&xfs_buffered_write_iomap_ops, &xfs_iomap_write_ops,
> +			xfs_buffered_write_iomap_next, &xfs_iomap_write_ops,
>  			NULL);
>  
>  	/*
> @@ -1135,7 +1135,7 @@ xfs_file_buffered_write_zoned(
>  retry:
>  	trace_xfs_file_buffered_write(iocb, from);
>  	ret = iomap_file_buffered_write(iocb, from,
> -			&xfs_buffered_write_iomap_ops, &xfs_iomap_write_ops,
> +			xfs_buffered_write_iomap_next, &xfs_iomap_write_ops,
>  			&ac);
>  	if (ret == -ENOSPC && !cleared_space) {
>  		/*
> @@ -1856,10 +1856,10 @@ xfs_file_llseek(
>  	default:
>  		return generic_file_llseek(file, offset, whence);
>  	case SEEK_HOLE:
> -		offset = iomap_seek_hole(inode, offset, &xfs_seek_iomap_ops);
> +		offset = iomap_seek_hole(inode, offset, xfs_seek_iomap_next);
>  		break;
>  	case SEEK_DATA:
> -		offset = iomap_seek_data(inode, offset, &xfs_seek_iomap_ops);
> +		offset = iomap_seek_data(inode, offset, xfs_seek_iomap_next);
>  		break;
>  	}
>  
> @@ -1883,8 +1883,8 @@ xfs_dax_fault_locked(
>  	}
>  	ret = dax_iomap_fault(vmf, order, &pfn, NULL,
>  			(write_fault && !vmf->cow_page) ?
> -				&xfs_dax_write_iomap_ops :
> -				&xfs_read_iomap_ops);
> +				xfs_dax_write_iomap_next :
> +				xfs_read_iomap_next);
>  	if (ret & VM_FAULT_NEEDDSYNC)
>  		ret = dax_finish_sync_fault(vmf, order, pfn);
>  	return ret;
> @@ -1948,7 +1948,7 @@ __xfs_write_fault(
>  	if (IS_DAX(inode))
>  		ret = xfs_dax_fault_locked(vmf, order, true);
>  	else
> -		ret = iomap_page_mkwrite(vmf, &xfs_buffered_write_iomap_ops,
> +		ret = iomap_page_mkwrite(vmf, xfs_buffered_write_iomap_next,
>  				ac);
>  	xfs_iunlock(ip, lock_mode);
>  
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 4fa1a5c985db..71c4bb024f04 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1037,7 +1037,7 @@ xfs_direct_write_iomap_begin(
>  	return error;
>  }
>  
> -static int
> +int
>  xfs_direct_write_iomap_next(
>  	const struct iomap_iter *iter,
>  	struct iomap		*iomap,
> @@ -1047,10 +1047,6 @@ xfs_direct_write_iomap_next(
>  			NULL);
>  }
>  
> -const struct iomap_ops xfs_direct_write_iomap_ops = {
> -	.iomap_next		= xfs_direct_write_iomap_next,
> -};
> -
>  #ifdef CONFIG_XFS_RT
>  /*
>   * This is really simple.  The space has already been reserved before taking the
> @@ -1099,7 +1095,7 @@ xfs_zoned_direct_write_iomap_begin(
>  	return 0;
>  }
>  
> -static int
> +int
>  xfs_zoned_direct_write_iomap_next(
>  	const struct iomap_iter *iter,
>  	struct iomap		*iomap,
> @@ -1109,9 +1105,6 @@ xfs_zoned_direct_write_iomap_next(
>  			xfs_zoned_direct_write_iomap_begin, NULL);
>  }
>  
> -const struct iomap_ops xfs_zoned_direct_write_iomap_ops = {
> -	.iomap_next		= xfs_zoned_direct_write_iomap_next,
> -};
>  #endif /* CONFIG_XFS_RT */
>  
>  #ifdef DEBUG
> @@ -1294,7 +1287,7 @@ xfs_atomic_write_cow_iomap_begin(
>  	return error;
>  }
>  
> -static int
> +int
>  xfs_atomic_write_cow_iomap_next(
>  	const struct iomap_iter *iter,
>  	struct iomap		*iomap,
> @@ -1304,10 +1297,6 @@ xfs_atomic_write_cow_iomap_next(
>  			xfs_atomic_write_cow_iomap_begin, NULL);
>  }
>  
> -const struct iomap_ops xfs_atomic_write_cow_iomap_ops = {
> -	.iomap_next		= xfs_atomic_write_cow_iomap_next,
> -};
> -
>  static int
>  xfs_dax_write_iomap_end(
>  	struct inode		*inode,
> @@ -1328,7 +1317,7 @@ xfs_dax_write_iomap_end(
>  	return xfs_reflink_end_cow(ip, pos, written);
>  }
>  
> -static int
> +int
>  xfs_dax_write_iomap_next(
>  	const struct iomap_iter *iter,
>  	struct iomap		*iomap,
> @@ -1338,10 +1327,6 @@ xfs_dax_write_iomap_next(
>  			xfs_dax_write_iomap_end);
>  }
>  
> -const struct iomap_ops xfs_dax_write_iomap_ops = {
> -	.iomap_next	= xfs_dax_write_iomap_next,
> -};
> -
>  /*
>   * Convert a hole to a delayed allocation.
>   */
> @@ -2207,7 +2192,7 @@ xfs_buffered_write_iomap_end(
>  	return 0;
>  }
>  
> -static int
> +int
>  xfs_buffered_write_iomap_next(
>  	const struct iomap_iter *iter,
>  	struct iomap		*iomap,
> @@ -2218,10 +2203,6 @@ xfs_buffered_write_iomap_next(
>  			xfs_buffered_write_iomap_end);
>  }
>  
> -const struct iomap_ops xfs_buffered_write_iomap_ops = {
> -	.iomap_next		= xfs_buffered_write_iomap_next,
> -};
> -
>  static int
>  xfs_read_iomap_begin(
>  	struct inode		*inode,
> @@ -2263,7 +2244,7 @@ xfs_read_iomap_begin(
>  				 shared ? IOMAP_F_SHARED : 0, seq);
>  }
>  
> -static int
> +int
>  xfs_read_iomap_next(
>  	const struct iomap_iter *iter,
>  	struct iomap		*iomap,
> @@ -2272,10 +2253,6 @@ xfs_read_iomap_next(
>  	return iomap_process(iter, iomap, srcmap, xfs_read_iomap_begin, NULL);
>  }
>  
> -const struct iomap_ops xfs_read_iomap_ops = {
> -	.iomap_next		= xfs_read_iomap_next,
> -};
> -
>  static int
>  xfs_seek_iomap_begin(
>  	struct inode		*inode,
> @@ -2360,7 +2337,7 @@ xfs_seek_iomap_begin(
>  	return error;
>  }
>  
> -static int
> +int
>  xfs_seek_iomap_next(
>  	const struct iomap_iter *iter,
>  	struct iomap		*iomap,
> @@ -2369,10 +2346,6 @@ xfs_seek_iomap_next(
>  	return iomap_process(iter, iomap, srcmap, xfs_seek_iomap_begin, NULL);
>  }
>  
> -const struct iomap_ops xfs_seek_iomap_ops = {
> -	.iomap_next		= xfs_seek_iomap_next,
> -};
> -
>  static int
>  xfs_xattr_iomap_begin(
>  	struct inode		*inode,
> @@ -2416,7 +2389,7 @@ xfs_xattr_iomap_begin(
>  	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, IOMAP_F_XATTR, seq);
>  }
>  
> -static int
> +int
>  xfs_xattr_iomap_next(
>  	const struct iomap_iter *iter,
>  	struct iomap		*iomap,
> @@ -2425,10 +2398,6 @@ xfs_xattr_iomap_next(
>  	return iomap_process(iter, iomap, srcmap, xfs_xattr_iomap_begin, NULL);
>  }
>  
> -const struct iomap_ops xfs_xattr_iomap_ops = {
> -	.iomap_next		= xfs_xattr_iomap_next,
> -};
> -
>  int
>  xfs_zero_range(
>  	struct xfs_inode	*ip,
> @@ -2443,9 +2412,9 @@ xfs_zero_range(
>  
>  	if (IS_DAX(inode))
>  		return dax_zero_range(inode, pos, len, did_zero,
> -				      &xfs_dax_write_iomap_ops);
> +				      xfs_dax_write_iomap_next);
>  	return iomap_zero_range(inode, pos, len, did_zero,
> -			&xfs_buffered_write_iomap_ops, &xfs_iomap_write_ops,
> +			xfs_buffered_write_iomap_next, &xfs_iomap_write_ops,
>  			ac);
>  }
>  
> @@ -2460,8 +2429,8 @@ xfs_truncate_page(
>  
>  	if (IS_DAX(inode))
>  		return dax_truncate_page(inode, pos, did_zero,
> -					&xfs_dax_write_iomap_ops);
> +					xfs_dax_write_iomap_next);
>  	return iomap_truncate_page(inode, pos, did_zero,
> -			&xfs_buffered_write_iomap_ops, &xfs_iomap_write_ops,
> +			xfs_buffered_write_iomap_next, &xfs_iomap_write_ops,
>  			ac);
>  }
> diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
> index ebcce7d49446..01875d20fb66 100644
> --- a/fs/xfs/xfs_iomap.h
> +++ b/fs/xfs/xfs_iomap.h
> @@ -49,14 +49,22 @@ xfs_aligned_fsb_count(
>  	return count_fsb;
>  }
>  
> -extern const struct iomap_ops xfs_buffered_write_iomap_ops;
> -extern const struct iomap_ops xfs_direct_write_iomap_ops;
> -extern const struct iomap_ops xfs_zoned_direct_write_iomap_ops;
> -extern const struct iomap_ops xfs_read_iomap_ops;
> -extern const struct iomap_ops xfs_seek_iomap_ops;
> -extern const struct iomap_ops xfs_xattr_iomap_ops;
> -extern const struct iomap_ops xfs_dax_write_iomap_ops;
> -extern const struct iomap_ops xfs_atomic_write_cow_iomap_ops;
> +int xfs_buffered_write_iomap_next(const struct iomap_iter *iter,
> +		struct iomap *iomap, struct iomap *srcmap);
> +int xfs_direct_write_iomap_next(const struct iomap_iter *iter,
> +		struct iomap *iomap, struct iomap *srcmap);
> +int xfs_zoned_direct_write_iomap_next(const struct iomap_iter *iter,
> +		struct iomap *iomap, struct iomap *srcmap);
> +int xfs_read_iomap_next(const struct iomap_iter *iter, struct iomap *iomap,
> +		struct iomap *srcmap);
> +int xfs_seek_iomap_next(const struct iomap_iter *iter, struct iomap *iomap,
> +		struct iomap *srcmap);
> +int xfs_xattr_iomap_next(const struct iomap_iter *iter, struct iomap *iomap,
> +		struct iomap *srcmap);
> +int xfs_dax_write_iomap_next(const struct iomap_iter *iter, struct iomap *iomap,
> +		struct iomap *srcmap);
> +int xfs_atomic_write_cow_iomap_next(const struct iomap_iter *iter,
> +		struct iomap *iomap, struct iomap *srcmap);
>  extern const struct iomap_write_ops xfs_iomap_write_ops;
>  
>  #endif /* __XFS_IOMAP_H__*/
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 6339f4956ecb..5c3d9a365f93 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -1239,10 +1239,10 @@ xfs_vn_fiemap(
>  	if (fieinfo->fi_flags & FIEMAP_FLAG_XATTR) {
>  		fieinfo->fi_flags &= ~FIEMAP_FLAG_XATTR;
>  		error = iomap_fiemap(inode, fieinfo, start, length,
> -				&xfs_xattr_iomap_ops);
> +				xfs_xattr_iomap_next);
>  	} else {
>  		error = iomap_fiemap(inode, fieinfo, start, length,
> -				&xfs_read_iomap_ops);
> +				xfs_read_iomap_next);
>  	}
>  	xfs_iunlock(XFS_I(inode), XFS_IOLOCK_SHARED);
>  
> diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
> index a5c188b78138..2b9792626bab 100644
> --- a/fs/xfs/xfs_reflink.c
> +++ b/fs/xfs/xfs_reflink.c
> @@ -1683,7 +1683,7 @@ xfs_reflink_remap_prep(
>  				pos_out, len, remap_flags);
>  	else
>  		ret = dax_remap_file_range_prep(file_in, pos_in, file_out,
> -				pos_out, len, remap_flags, &xfs_read_iomap_ops);
> +				pos_out, len, remap_flags, xfs_read_iomap_next);
>  	if (ret || *len == 0)
>  		goto out_unlock;
>  
> @@ -1878,10 +1878,10 @@ xfs_reflink_unshare(
>  
>  	if (IS_DAX(inode))
>  		error = dax_file_unshare(inode, offset, len,
> -				&xfs_dax_write_iomap_ops);
> +				xfs_dax_write_iomap_next);
>  	else
>  		error = iomap_file_unshare(inode, offset, len,
> -				&xfs_buffered_write_iomap_ops,
> +				xfs_buffered_write_iomap_next,
>  				&xfs_iomap_write_ops);
>  	if (error)
>  		goto out;

Aside from the name bikeshedding, the logic looks solid. :)

--D

