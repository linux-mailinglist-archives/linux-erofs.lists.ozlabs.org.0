Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 659F16D703D
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Apr 2023 00:41:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PrjRf3yglz3cj7
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Apr 2023 08:41:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Ml94zzFv;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Ml94zzFv;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PrjRY756kz3chb
	for <linux-erofs@lists.ozlabs.org>; Wed,  5 Apr 2023 08:41:29 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 1ADE563598;
	Tue,  4 Apr 2023 22:41:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96D8C433D2;
	Tue,  4 Apr 2023 22:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1680648085;
	bh=aM54U5iap6zscBuGqNsTwESIxnVITeGqVdCllwuI5x8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ml94zzFvd8sabIYbcobTwAoRXcLNGqW8xEpy1hwrJ+LGdNfLtPa8x+4xdHmRtKIUZ
	 fsZ9jJ75A5lmEpmdem7n1pLxe2UYcM3MNfdc3YAKViyebklATamdLl05Y60lpWwFf5
	 ofYhx2pJjFoCtq+GaiYkuINUe2JCSqF2pwFUFn6Zo0bfwhXouKVIOal+1AkwQaQ/YJ
	 bk44SX4AtKjSWCU9Xb6pe+BY0KJ/BHIrDRJrYOB//ATaeXL09P9aN3BQWNzXNZuWDp
	 3qrolO5LKpJQtkjeBwNaIywyLBY1yThisB/2n4A1Sn2mN235gQW98poQIAKB/WP56N
	 ajfrwoO4Xp5Tw==
Date: Tue, 4 Apr 2023 15:41:23 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Subject: Re: [PATCH v2 16/23] xfs: add inode on-disk VERITY flag
Message-ID: <20230404224123.GD1893@sol.localdomain>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404145319.2057051-17-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404145319.2057051-17-aalbersh@redhat.com>
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
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, agruenba@redhat.com, djwong@kernel.org, damien.lemoal@opensource.wdc.com, linux-f2fs-devel@lists.sourceforge.net, hch@infradead.org, cluster-devel@redhat.com, dchinner@redhat.com, rpeterso@redhat.com, jth@kernel.org, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Andrey,

On Tue, Apr 04, 2023 at 04:53:12PM +0200, Andrey Albershteyn wrote:
> Add flag to mark inodes which have fs-verity enabled on them (i.e.
> descriptor exist and tree is built).
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> ---
>  fs/ioctl.c                 | 4 ++++
>  fs/xfs/libxfs/xfs_format.h | 4 +++-
>  fs/xfs/xfs_inode.c         | 2 ++
>  fs/xfs/xfs_iops.c          | 2 ++
>  include/uapi/linux/fs.h    | 1 +
>  5 files changed, 12 insertions(+), 1 deletion(-)
[...]
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index b7b56871029c..5172a2eb902c 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -140,6 +140,7 @@ struct fsxattr {
>  #define FS_XFLAG_FILESTREAM	0x00004000	/* use filestream allocator */
>  #define FS_XFLAG_DAX		0x00008000	/* use DAX for IO */
>  #define FS_XFLAG_COWEXTSIZE	0x00010000	/* CoW extent size allocator hint */
> +#define FS_XFLAG_VERITY		0x00020000	/* fs-verity sealed inode */
>  #define FS_XFLAG_HASATTR	0x80000000	/* no DIFLAG for this	*/
>  

I don't think "xfs: add inode on-disk VERITY flag" is an accurate description of
a patch that involves adding something to the UAPI.

Should the other filesystems support this new flag too?

I'd also like all ways of getting the verity flag to continue to be mentioned in
Documentation/filesystems/fsverity.rst.  The existing methods (FS_IOC_GETFLAGS
and statx) are already mentioned there.

- Eric
