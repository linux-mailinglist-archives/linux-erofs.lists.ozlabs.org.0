Return-Path: <linux-erofs+bounces-579-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EF342AFFB47
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Jul 2025 09:46:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bd6P74lrYz30VZ;
	Thu, 10 Jul 2025 17:46:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752133611;
	cv=none; b=gYwPWyHf1/gXibj4247X+DrJbEI190aF1FzIi2Dd6A+M8CzPHsR0b8WdHg0XeGjBmrTrnJwTmsl/HEkFtRx4tzh9SE7GpJHRxoOabcTnl2Qz0cK+h+b1yWGO/8SeY2iGEHwkrs2PYs0M+kOYJLBoAjRFWGaNYQI3AVn7Z0DJSXKuqfieWRqTjoynTpLCbdnRLcjypxw7FQZKM2lf1OSs+f9mCFoSq/afwrJceQoEwgOjX3HdiJxov4T/2OTOsB6uo3I8V6vSZBkHGq2W3OzlBSGiVnIeY3ZBF6bBYxUGkH4/6HOJLvw+ltaGlXACzuap0MykKwO8W89eaKimLwJjfA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752133611; c=relaxed/relaxed;
	bh=0s3D/I0IgWK1k4rhAjUlxCvBQXJhoNVSk7AvaiTRwC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=isE/iWWRuhvkfd3YXhjTwJP6+leB6oR75Rd1JQeNBQ4XedQZ3U7+T7kqmQmSDIJvUYu+UG5IHBX9Muot+2omRqwWC9NoiXFPuiwnJLS5/nhnlJOmKNPuijZYsPEcElY66MXAGGj4LPvJfxDfDrigetBxI6NufVqd3mAl3spdwnQFBFfzBQ5koVDLQTxTBDy9qKjVwgdi5tKt1/myyyM2Gfv4UWom0WOgZTBVOTj97I8mqRd2ftYbEVj9Vsw03rHw8EwmgxyCGXcOxDrQuWN3zOGuZUF0WkjdQfn61+IY6fQDax4qrsdkiciqylGMwehAaAPSz7jDv0W7XCEQmFwHrQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bbcKsmH2; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bbcKsmH2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bd6P65k53z2yLJ
	for <linux-erofs@lists.ozlabs.org>; Thu, 10 Jul 2025 17:46:50 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752133606; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=0s3D/I0IgWK1k4rhAjUlxCvBQXJhoNVSk7AvaiTRwC0=;
	b=bbcKsmH2jnabY3r0HDe8iJoHO8O1lYRxMkO+7WLhPqPVagMxY7wctnLa9fTIbAj8wuAkzp88UTkesIuPcZ+BPz5k0MSGBqpVQvTKiKIM+Q4Kv/mmIKMV8aW6JLTSVeLelnsDHaiDhBOZZzT1bPICykFtuDYNyurGI2h1Jv2V98Y=
Received: from 30.221.128.137(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WibzTBy_1752133604 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 10 Jul 2025 15:46:44 +0800
Message-ID: <8cbaa76b-f6de-4242-bd6c-629980311f4a@linux.alibaba.com>
Date: Thu, 10 Jul 2025 15:46:44 +0800
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
Subject: Re: [PATCH 2/2] erofs: support to readahead dirent blocks in
 erofs_readdir()
To: Chao Yu <chao@kernel.org>, xiang@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>
References: <20250710073619.4083422-1-chao@kernel.org>
 <20250710073619.4083422-2-chao@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250710073619.4083422-2-chao@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Chao,

On 2025/7/10 15:36, Chao Yu wrote:
> This patch supports to readahead more blocks in erofs_readdir(),
> it can enhance performance in large direcotry.
> 
> readdir test in a large directory which contains 12000 sub-files.
> 
> 		files_per_second
> Before:		926385.54
> After:		2380435.562
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>   fs/erofs/dir.c      | 8 ++++++++
>   fs/erofs/internal.h | 3 +++
>   2 files changed, 11 insertions(+)
> 
> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
> index cff61c5a172b..04113851fc0f 100644
> --- a/fs/erofs/dir.c
> +++ b/fs/erofs/dir.c
> @@ -47,8 +47,10 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>   	struct inode *dir = file_inode(f);
>   	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
>   	struct super_block *sb = dir->i_sb;
> +	struct file_ra_state *ra = &f->f_ra;
>   	unsigned long bsz = sb->s_blocksize;
>   	unsigned int ofs = erofs_blkoff(sb, ctx->pos);
> +	unsigned long nr_pages = DIV_ROUND_UP_POW2(dir->i_size, PAGE_SIZE);
>   	int err = 0;
>   	bool initial = true;
>   
> @@ -65,6 +67,12 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>   		}
>   		cond_resched();
>   
> +		/* readahead blocks to enhance performance in large directory */
> +		if (nr_pages - dbstart > 1 && !ra_has_index(ra, dbstart))
> +			page_cache_sync_readahead(dir->i_mapping, ra, f,
> +				dbstart, min(nr_pages - dbstart,
> +				(pgoff_t)MAX_DIR_RA_PAGES));
> +
>   		de = erofs_bread(&buf, dbstart, true);
>   		if (IS_ERR(de)) {
>   			erofs_err(sb, "failed to readdir of logical block %llu of nid %llu",
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index a32c03a80c70..ef9d1ee8c688 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -238,6 +238,9 @@ EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
>   #define EROFS_I_BL_XATTR_BIT	(BITS_PER_LONG - 1)
>   #define EROFS_I_BL_Z_BIT	(BITS_PER_LONG - 2)
>   
> +/* maximum readahead pages of directory */
> +#define MAX_DIR_RA_PAGES	4

Could we set it as a per-sb sysfs configuration for users to config?

Thanks,
Gao Xiang

