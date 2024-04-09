Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AEB89D4D3
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Apr 2024 10:48:00 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=n+3nZD00;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VDKNY73sNz3dRY
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Apr 2024 18:47:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=n+3nZD00;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VDKNT2VfFz30gK
	for <linux-erofs@lists.ozlabs.org>; Tue,  9 Apr 2024 18:47:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712652466; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=NLmQBJY/YAR0kMQs21Xq2pa2nHPXvvDmIRP/f0OQLFw=;
	b=n+3nZD00jTkSfMN5CsxOR+vqo34YQRfEQzuVa7b95pOPeSp/Ph/CBJc3VZHXsu85OthO1bktIIrShcrH5eYuATTYO689WPHetEbzlfacNYc7N3Y2SCX1TVEE12AutkpUVECtHBmFYxmo5J+7uFuBIvWc/sGag8zaBoSOUpNy7GA=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W4E2Dby_1712652464;
Received: from 30.97.48.141(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W4E2Dby_1712652464)
          by smtp.aliyun-inc.com;
          Tue, 09 Apr 2024 16:47:46 +0800
Message-ID: <51fd6e0b-6fa2-4473-b22b-68c11230b2f5@linux.alibaba.com>
Date: Tue, 9 Apr 2024 16:47:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: derive fsid from on-disk UUID for .statfs() if
 possible
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
References: <20240409081135.6102-1-hongzhen@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240409081135.6102-1-hongzhen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: huyue2@coolpad.com, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/4/9 16:11, Hongzhen Luo wrote:
> Use the superblock's UUID to generate the fsid when it's non-null.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>   fs/erofs/super.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index c0eb139adb07..83bd8ee3b5ba 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -923,22 +923,20 @@ static int erofs_statfs(struct dentry *dentry, struct kstatfs *buf)
>   {
>   	struct super_block *sb = dentry->d_sb;
>   	struct erofs_sb_info *sbi = EROFS_SB(sb);
> -	u64 id = 0;
> -
> -	if (!erofs_is_fscache_mode(sb))
> -		id = huge_encode_dev(sb->s_bdev->bd_dev);
>   
>   	buf->f_type = sb->s_magic;
>   	buf->f_bsize = sb->s_blocksize;
>   	buf->f_blocks = sbi->total_blocks;
>   	buf->f_bfree = buf->f_bavail = 0;
> -
>   	buf->f_files = ULLONG_MAX;
>   	buf->f_ffree = ULLONG_MAX - sbi->inos;
> -
>   	buf->f_namelen = EROFS_NAME_LEN;
>   
> -	buf->f_fsid    = u64_to_fsid(id);
> +	if (uuid_is_null(&sb->s_uuid))
> +		buf->f_fsid = u64_to_fsid(erofs_is_fscache_mode(sb) ? 0 :
> +				huge_encode_dev(sb->s_bdev->bd_dev));
> +	else
> +		buf->f_fsid = uuid_to_fsid((__u8 *)&sb->s_uuid);
>   	return 0;
>   }
>   
