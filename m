Return-Path: <linux-erofs+bounces-608-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DB5B0350E
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Jul 2025 05:49:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bgSxd3RV6z3bqP;
	Mon, 14 Jul 2025 13:49:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752464981;
	cv=none; b=nQp3+peoLECb/oabFshvdACRGsDwWxZQKFMwqwIChFjh4Ti5//RbPOEJLWewSM/hCnhCjTXBn0YmwiH4haL3Gpx4i8ynPkj5mWbrMY49v3J/fZNXw6yUdQY9r919mgi6J3tjvTbQAJs7HxJA3A98VZB8fcuPp5K8MtGvJn/c0e2kRlfJv67AvhlQf/A+VYyRU6x7llos5DPQAf+o/Kj3Tlt/+QlPVsb/uuB5MUf6AtGJbj8/ERkTDDdpv/yk5Q4guKCurbpiZIrKEPnl5J4/Uw3mQ2NVoFsu5xEqjzpX7Zl3atYQZJB/WoNpiElRRgH+OHHpY+VIwtt+y9I1IfeS/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752464981; c=relaxed/relaxed;
	bh=ndtedV3xeHlGSyyPbawukZOShJ9c9Dr8tbzXkvBO1kY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GNN5RWZiD0j8FsDA89VIDLrLmq6cxpIc5peximgOyy2Yv/cB1eg3OvbTzWWblxYTcpFfq9AIjOGItA7sUnBNPAosoRo5a0Ewh5Quzhee+kZBPmN5fZvXuSIZzC6nF2pCWe92zGQMqvCxTuIX7AdFmDZcer/R/V71OHEb+h3WnR5EXOmiOjDTL3PtjaLopOtXOVraYTdmuGiehhOOCQ1XYo9UPE0HDFvm9tkOJBW6MD58bpb2fxFFsKcHg0FxdfLY3O1yQyOcdmRiVVUFnAiEgUe34Yzk99sIlGdnRWT051JOFQR/KwX1a6ztMqts0jj1+fbQKfN7bGXiQYTZoU661Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=g3TUz9TZ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=g3TUz9TZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bgSxZ6yX1z3bqM
	for <linux-erofs@lists.ozlabs.org>; Mon, 14 Jul 2025 13:49:36 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752464972; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ndtedV3xeHlGSyyPbawukZOShJ9c9Dr8tbzXkvBO1kY=;
	b=g3TUz9TZdN/nQbOBpKi+39y/9dvpDS6WgyVvpLZ4Tp2wIyxHXeOP9X8pkVA6Pt9+zJCdiZ88hPCniBqL2R3o5LT6wLEHAmOaOYnX6zVzMAVMuUgf+Rw9+mFWSVQwSSnro7HHMvhUGLIWIBh9jOy6GGDk2+L9j1xQG2t9kxOnwqo=
Received: from 30.221.131.165(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WioW9Ae_1752464970 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Jul 2025 11:49:30 +0800
Message-ID: <dcb197e7-8dea-4bd2-9344-b753c10c534d@linux.alibaba.com>
Date: Mon, 14 Jul 2025 11:49:29 +0800
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
Subject: Re: [PATCH v2 2/2] erofs: support to readahead dirent blocks in
 erofs_readdir()
To: Chao Yu <chao@kernel.org>, xiang@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>
References: <20250714033450.58298-1-chao@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250714033450.58298-1-chao@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Chao,

On 2025/7/14 11:34, Chao Yu wrote:
> This patch supports to readahead more blocks in erofs_readdir(), it can
> enhance readdir performance in large direcotry.
> 
> readdir test in a large directory which contains 12000 sub-files.
> 
> 		files_per_second
> Before:		926385.54
> After:		2380435.562
> 
> Meanwhile, let's introduces a new sysfs entry to control page count
> of readahead to provide more flexible policy for readahead of readdir().
> - location: /sys/fs/erofs/<disk>/dir_ra_pages
> - default value: 4
> - range: [0, 128]
> - disable readahead: set the value to 0
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - introduce sysfs node to control page count of readahead during
> readdir().
>   Documentation/ABI/testing/sysfs-fs-erofs | 7 +++++++
>   fs/erofs/dir.c                           | 9 +++++++++
>   fs/erofs/internal.h                      | 5 +++++
>   fs/erofs/super.c                         | 2 ++
>   fs/erofs/sysfs.c                         | 5 +++++
>   5 files changed, 28 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ABI/testing/sysfs-fs-erofs
> index bf3b6299c15e..500c93484e4c 100644
> --- a/Documentation/ABI/testing/sysfs-fs-erofs
> +++ b/Documentation/ABI/testing/sysfs-fs-erofs
> @@ -35,3 +35,10 @@ Description:	Used to set or show hardware accelerators in effect
>   		and multiple accelerators are separated by '\n'.
>   		Supported accelerator(s): qat_deflate.
>   		Disable all accelerators with an empty string (echo > accel).
> +
> +What:		/sys/fs/erofs/<disk>/dir_ra_pages
> +Date:		July 2025
> +Contact:	"Chao Yu" <chao@kernel.org>
> +Description:	Used to set or show page count of readahead during readdir(),
> +		the range of value is [0, 128], by default it is 4, set it to
> +		0 to disable readahead.
> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
> index 3e4b38bec0aa..40f828d5b670 100644
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

why using DIV_ROUND_UP_POW2 rather than DIV_ROUND_UP here?

>   	int err = 0;
>   	bool initial = true;
>   
> @@ -63,6 +65,13 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>   			break;
>   		}
>   
> +		/* readahead blocks to enhance performance in large directory */
> +		if (EROFS_I_SB(dir)->dir_ra_pages && nr_pages - dbstart > 1 &&

dbstart is a byte-oriented value, so I'm not sure if it
works as you expect..

> +		    !ra_has_index(ra, dbstart))
> +			page_cache_sync_readahead(dir->i_mapping, ra, f,
> +				dbstart, min(nr_pages - dbstart,

same here.

> +				(pgoff_t)EROFS_I_SB(dir)->dir_ra_pages));
> +
>   		de = erofs_bread(&buf, dbstart, true);
>   		if (IS_ERR(de)) {
>   			erofs_err(sb, "failed to readdir of logical block %llu of nid %llu",
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 0d19bde8c094..f0e5b4273aa8 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -157,6 +157,7 @@ struct erofs_sb_info {
>   	/* sysfs support */
>   	struct kobject s_kobj;		/* /sys/fs/erofs/<devname> */
>   	struct completion s_kobj_unregister;
> +	unsigned int dir_ra_pages;
>   
>   	/* fscache support */
>   	struct fscache_volume *volume;
> @@ -238,6 +239,10 @@ EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
>   #define EROFS_I_BL_XATTR_BIT	(BITS_PER_LONG - 1)
>   #define EROFS_I_BL_Z_BIT	(BITS_PER_LONG - 2)
>   
> +/* default/maximum readahead pages of directory */
> +#define DEFAULT_DIR_RA_PAGES	4
> +#define MAX_DIR_RA_PAGES	128

better to add EROFS_ prefix for them.

Also could we setup those blocks or bytes instead
of pages?

If users would like to setup values, they may don't
care more the page size since they only care about
images.

Also why do we limit maximum number even if users
would like to readahead more? (such as fadvise
allows -1 too)

Thanks,
Gao Xiang

