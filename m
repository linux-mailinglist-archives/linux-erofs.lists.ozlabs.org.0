Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B5C4AEB7E
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Feb 2022 08:53:17 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JtsZ26bZqz30Nx
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Feb 2022 18:53:14 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.44;
 helo=out30-44.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JtsZ011qbz2yN3
 for <linux-erofs@lists.ozlabs.org>; Wed,  9 Feb 2022 18:53:08 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=16; SR=0; TI=SMTPD_---0V3zwdmU_1644393177; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V3zwdmU_1644393177) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 09 Feb 2022 15:52:59 +0800
Date: Wed, 9 Feb 2022 15:52:55 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v3 06/22] erofs: use meta buffers for
 erofs_read_superblock()
Message-ID: <YgNy121L0gYjqj6K@B-P7TQMD6M-0146.local>
Mail-Followup-To: Jeffle Xu <jefflexu@linux.alibaba.com>,
 dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org,
 torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
 willy@infradead.org, linux-fsdevel@vger.kernel.org,
 joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
 tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
 eguan@linux.alibaba.com, linux-kernel@vger.kernel.org
References: <20220209060108.43051-1-jefflexu@linux.alibaba.com>
 <20220209060108.43051-7-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220209060108.43051-7-jefflexu@linux.alibaba.com>
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
Cc: linux-erofs@lists.ozlabs.org, willy@infradead.org,
 linux-kernel@vger.kernel.org, dhowells@redhat.com, joseph.qi@linux.alibaba.com,
 linux-cachefs@redhat.com, gregkh@linuxfoundation.org,
 linux-fsdevel@vger.kernel.org, gerry@linux.alibaba.com,
 torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Feb 09, 2022 at 02:00:52PM +0800, Jeffle Xu wrote:
> The only change is that, meta buffers read cache page without __GFP_FS
> flag, which shall not matter.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

(If this patchset left behind anyway, I will submit this cleanup
 independently for the next cycle.)

Thanks,
Gao Xiang

> ---
>  fs/erofs/super.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 915eefe0d7e2..12755217631f 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -281,21 +281,19 @@ static int erofs_init_devices(struct super_block *sb,
>  static int erofs_read_superblock(struct super_block *sb)
>  {
>  	struct erofs_sb_info *sbi;
> -	struct page *page;
> +	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
>  	struct erofs_super_block *dsb;
>  	unsigned int blkszbits;
>  	void *data;
>  	int ret;
>  
> -	page = read_mapping_page(sb->s_bdev->bd_inode->i_mapping, 0, NULL);
> -	if (IS_ERR(page)) {
> +	data = erofs_read_metabuf(&buf, sb, 0, EROFS_KMAP);
> +	if (IS_ERR(data)) {
>  		erofs_err(sb, "cannot read erofs superblock");
> -		return PTR_ERR(page);
> +		return PTR_ERR(data);
>  	}
>  
>  	sbi = EROFS_SB(sb);
> -
> -	data = kmap(page);
>  	dsb = (struct erofs_super_block *)(data + EROFS_SUPER_OFFSET);
>  
>  	ret = -EINVAL;
> @@ -365,8 +363,7 @@ static int erofs_read_superblock(struct super_block *sb)
>  	if (erofs_sb_has_ztailpacking(sbi))
>  		erofs_info(sb, "EXPERIMENTAL compressed inline data feature in use. Use at your own risk!");
>  out:
> -	kunmap(page);
> -	put_page(page);
> +	erofs_put_metabuf(&buf);
>  	return ret;
>  }
>  
> -- 
> 2.27.0
