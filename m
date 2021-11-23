Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B0545AF84
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Nov 2021 23:54:55 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HzKGP3zVnz2yfr
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Nov 2021 09:54:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fiDrCeIY;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=djwong@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=fiDrCeIY; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HzKGL2Z3zz2xXx
 for <linux-erofs@lists.ozlabs.org>; Wed, 24 Nov 2021 09:54:50 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4FDCD60F5B;
 Tue, 23 Nov 2021 22:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637708088;
 bh=u2lqdKGssL3PFQYc1p9ovLLGOLDvbfIo8L6k2g+j8/Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fiDrCeIYWisczQAnoc1pHa2hEiYS7fcUcSDBhfwV3mwv3UzsY4CXEzNg4rwjPtN2K
 melGoMO7lUvTIIuP0FQj1qr1HXwwMeb5MN7C8y6dyJERNmVA0v3hoJcv6ZFcsIGmnt
 /9brMCtm3rLalc0hQwS31cpWa0XkEJ69btMrxk56vjvS+hl/AGI//1YzkY7gjjAIvV
 t0zReHcaFkXKQWcEb67dQGWoZPjVM/EyA/W+pV1T3OFQxMMu8Z41zc43Z78GicC5um
 ftheaT3WHNw2tYmgoagJnVyOi1SfhbNc+8s6U6lQOHOh+szOVxmeKsWoGNRoX1smAD
 zh9Mw7ofmx7Jg==
Date: Tue, 23 Nov 2021 14:54:48 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 19/29] ext2: cleanup the dax handling in ext2_fill_super
Message-ID: <20211123225448.GO266024@magnolia>
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-20-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109083309.584081-20-hch@lst.de>
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
Cc: nvdimm@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-s390@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, linux-xfs@vger.kernel.org,
 dm-devel@redhat.com, linux-fsdevel@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>, linux-ext4@vger.kernel.org,
 Ira Weiny <ira.weiny@intel.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Nov 09, 2021 at 09:32:59AM +0100, Christoph Hellwig wrote:
> Only call fs_dax_get_by_bdev once the sbi has been allocated and remove
> the need for the dax_dev local variable.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/ext2/super.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ext2/super.c b/fs/ext2/super.c
> index a964066a80aa7..7e23482862e69 100644
> --- a/fs/ext2/super.c
> +++ b/fs/ext2/super.c
> @@ -802,7 +802,6 @@ static unsigned long descriptor_loc(struct super_block *sb,
>  
>  static int ext2_fill_super(struct super_block *sb, void *data, int silent)
>  {
> -	struct dax_device *dax_dev = fs_dax_get_by_bdev(sb->s_bdev);
>  	struct buffer_head * bh;
>  	struct ext2_sb_info * sbi;
>  	struct ext2_super_block * es;
> @@ -822,17 +821,17 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
>  
>  	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
>  	if (!sbi)
> -		goto failed;
> +		return -ENOMEM;
>  
>  	sbi->s_blockgroup_lock =
>  		kzalloc(sizeof(struct blockgroup_lock), GFP_KERNEL);
>  	if (!sbi->s_blockgroup_lock) {
>  		kfree(sbi);
> -		goto failed;
> +		return -ENOMEM;
>  	}
>  	sb->s_fs_info = sbi;
>  	sbi->s_sb_block = sb_block;
> -	sbi->s_daxdev = dax_dev;
> +	sbi->s_daxdev = fs_dax_get_by_bdev(sb->s_bdev);
>  
>  	spin_lock_init(&sbi->s_lock);
>  	ret = -EINVAL;
> @@ -946,7 +945,7 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
>  	blocksize = BLOCK_SIZE << le32_to_cpu(sbi->s_es->s_log_block_size);
>  
>  	if (test_opt(sb, DAX)) {
> -		if (!dax_dev) {
> +		if (!sbi->s_daxdev) {
>  			ext2_msg(sb, KERN_ERR,
>  				"DAX unsupported by block device. Turning off DAX.");
>  			clear_opt(sbi->s_mount_opt, DAX);
> @@ -1201,11 +1200,10 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
>  failed_mount:
>  	brelse(bh);
>  failed_sbi:
> +	fs_put_dax(sbi->s_daxdev);
>  	sb->s_fs_info = NULL;
>  	kfree(sbi->s_blockgroup_lock);
>  	kfree(sbi);
> -failed:
> -	fs_put_dax(dax_dev);
>  	return ret;
>  }
>  
> -- 
> 2.30.2
> 
