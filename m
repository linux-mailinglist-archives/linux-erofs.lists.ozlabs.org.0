Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC59484370
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Jan 2022 15:33:56 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JSw8v0Yktz2ypn
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Jan 2022 01:33:51 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.45;
 helo=out30-45.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-45.freemail.mail.aliyun.com
 (out30-45.freemail.mail.aliyun.com [115.124.30.45])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JSw8l3ncvz2x9b
 for <linux-erofs@lists.ozlabs.org>; Wed,  5 Jan 2022 01:33:36 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=13; SR=0; TI=SMTPD_---0V0xwPNn_1641306806; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V0xwPNn_1641306806) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 04 Jan 2022 22:33:28 +0800
Date: Tue, 4 Jan 2022 22:33:26 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v1 07/23] erofs: add nodev mode
Message-ID: <YdRattisu+ITYvvZ@B-P7TQMD6M-0146.local>
Mail-Followup-To: Jeffle Xu <jefflexu@linux.alibaba.com>,
 dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org,
 linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
 bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
 gerry@linux.alibaba.com, eguan@linux.alibaba.com,
 linux-kernel@vger.kernel.org
References: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
 <20211227125444.21187-8-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211227125444.21187-8-jefflexu@linux.alibaba.com>
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
Cc: tao.peng@linux.alibaba.com, linux-kernel@vger.kernel.org,
 dhowells@redhat.com, joseph.qi@linux.alibaba.com, linux-cachefs@redhat.com,
 bo.liu@linux.alibaba.com, linux-fsdevel@vger.kernel.org,
 gerry@linux.alibaba.com, linux-erofs@lists.ozlabs.org, eguan@linux.alibaba.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Dec 27, 2021 at 08:54:28PM +0800, Jeffle Xu wrote:
> Until then erofs is exactly blockdev based filesystem. In other using
> scenarios (e.g. container image), erofs needs to run upon files.
> 
> This patch introduces a new nodev mode, in which erofs could be mounted
> from a bootstrap blob file containing the complete erofs image.
> 
> The following patch will introduce a new mount option "uuid", by which
> users could specify the bootstrap blob file.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>

I think the order of some patches in this patchset can be improved.

Take this patch as an example. This patch introduces a new mount
option called "uuid", so the kernel will just accept it (which
generates a user-visible impact) after this patch but it doesn't
actually work.

Therefore, we actually have three different behaviors here:
 - kernel doesn't support "uuid" mount option completely;
 - kernel support "uuid" but it doesn't work;
 - kernel support "uuid" correctly (maybe after some random patch);

Actually that is bad for bisecting since there are some commits
having temporary behaviors. And we don't know which commit
actually fully implements this "uuid" mount option.

So personally I think the proper order is just like the bottom-up
approach, and make sure each patch can be tested / bisected
independently.

> ---
>  fs/erofs/data.c     | 13 ++++++++---
>  fs/erofs/internal.h |  1 +
>  fs/erofs/super.c    | 56 +++++++++++++++++++++++++++++++++------------
>  3 files changed, 53 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 477aaff0c832..61fa431d0713 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -11,11 +11,18 @@
>  
>  struct page *erofs_get_meta_page(struct super_block *sb, erofs_blk_t blkaddr)
>  {
> -	struct address_space *const mapping = sb->s_bdev->bd_inode->i_mapping;
> +	struct address_space *mapping;
>  	struct page *page;
>  
> -	page = read_cache_page_gfp(mapping, blkaddr,
> -				   mapping_gfp_constraint(mapping, ~__GFP_FS));

Apart from the recommendation above, if my understanding is
correct, I think after we implement fscache_aops, 
read_cache_page_gfp() can work with proper fscache mapping.

So no need to implement something like erofs_readpage_from_fscache()
later (at least for the case here.)

Thanks,
Gao Xiang

> +	if (sb->s_bdev) {
> +		mapping = sb->s_bdev->bd_inode->i_mapping;
> +		page = read_cache_page_gfp(mapping, blkaddr,
> +				mapping_gfp_constraint(mapping, ~__GFP_FS));
> +	} else {
> +		/* TODO: data path in nodev mode */
> +		page = ERR_PTR(-EINVAL);
> +	}
> +
