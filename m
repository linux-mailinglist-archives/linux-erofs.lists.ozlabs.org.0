Return-Path: <linux-erofs+bounces-661-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF63B087DD
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Jul 2025 10:26:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bjQy76pGMz2yDk;
	Thu, 17 Jul 2025 18:26:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752740815;
	cv=none; b=CyqaBhUe+bmHsixI1E6owKsmNM+3qkSo4M2vKnWbiIDs3ZjiyoAI4TmOn3LGCXe34Qf/nwJzuRqhlHb0JukoQOXRdoy8zhKFiYuyhoPyJg6R1djW21tEFXBxTMiduBzkrY8/8hXWws/YBapDEIozBG9hrkq2T+c+P7y02EfVrbtKOYWAYtMK1Y06lw1gSjL0JNbn6fZCjR5F5iiG/U3IdvVl4kqMsl1lCHxFJwaS3TGKKwVceJAOTOd0TBFhqqLzHkctLsd5gaWSAQNeM+Cxa86mJxG0DD3ihbc5WwOgfHXscuNSfoUXNmySr3AFzKTDETer9CTYcrW2PeoPh73mkg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752740815; c=relaxed/relaxed;
	bh=J2Hks8QCYq4evKvuvI8+y/woADFExPZk3G6ixGR9F4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZsGczzVVoEJmStNtCh/mHGjn126C4Ic4dhVVvPA83cWXtPen7c3QXxrqACTHUL2T7O/0lUbF3GyYYv8VmdFUV7Fvi9JY0ai1vaM6NmCy54UofNvn4RAMONRBhd7wUrrXAlO8T1VBBKW5DdrPwdPYoM0XuAZKRVkp4x45McXKI3zerKr83OW0LCvLio+gCErYxn9g4H76B3wvvDrX6kEpjnnNpVRSGhpmV1fu79JY8b0Ax21pkwU4dxSEKky8qROuF2jTRbXXNP1iYtKpeuOK7BIfSeBGz99AGfBxFUccgtMgSb9H6AanzxlyivaLxJtllhLDiTPvQK2lcOeJmXVZhg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=kUZVe8Mf; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=kUZVe8Mf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bjQy54hPqz2xlL
	for <linux-erofs@lists.ozlabs.org>; Thu, 17 Jul 2025 18:26:52 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752740807; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=J2Hks8QCYq4evKvuvI8+y/woADFExPZk3G6ixGR9F4o=;
	b=kUZVe8MfnxoOqZB+TFXtxSzZ7CFWLpizYCOBJJxBsM3x2wq0RSxnVQmd9ik5zgyGhxwfbNxHuH2VW0+NYrPBES0Jx2JeqhyDWPixUhaSlT5Xp1PP6AvxcSWYUnn8FPcC0+fBFOLB1zz4NWT2wLABXfqlkRdxmj0bcHDp1lxqKiQ=
Received: from 30.221.131.143(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wj7NBkg_1752740805 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Jul 2025 16:26:46 +0800
Message-ID: <631728e2-2808-47af-8db7-28cd8ae17622@linux.alibaba.com>
Date: Thu, 17 Jul 2025 16:26:44 +0800
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
Subject: Re: [PATCH v3] erofs: support to readahead dirent blocks in
 erofs_readdir()
To: Chao Yu <chao@kernel.org>, xiang@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>
References: <20250714093935.200749-1-chao@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250714093935.200749-1-chao@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Chao,

On 2025/7/14 17:39, Chao Yu wrote:
> This patch supports to readahead more blocks in erofs_readdir(), it can
> enhance readdir performance in large direcotry.
> 
> readdir test in a large directory which contains 12000 sub-files.
> 
> 		files_per_second
> Before:		926385.54
> After:		2380435.562
> 
> Meanwhile, let's introduces a new sysfs entry to control readahead
> bytes to provide more flexible policy for readahead of readdir().
> - location: /sys/fs/erofs/<disk>/dir_ra_bytes
> - default value: 16384
> - disable readahead: set the value to 0
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v3:
> - add EROFS prefix for macro
> - update new sysfs interface to 1) use bytes instead of pages
> 2) remove upper boundary limitation
> - fix bug of pageidx calculation
>   Documentation/ABI/testing/sysfs-fs-erofs |  8 ++++++++
>   fs/erofs/dir.c                           | 13 +++++++++++++
>   fs/erofs/internal.h                      |  4 ++++
>   fs/erofs/super.c                         |  2 ++
>   fs/erofs/sysfs.c                         |  2 ++
>   5 files changed, 29 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ABI/testing/sysfs-fs-erofs
> index bf3b6299c15e..85fa56ca092c 100644
> --- a/Documentation/ABI/testing/sysfs-fs-erofs
> +++ b/Documentation/ABI/testing/sysfs-fs-erofs
> @@ -35,3 +35,11 @@ Description:	Used to set or show hardware accelerators in effect
>   		and multiple accelerators are separated by '\n'.
>   		Supported accelerator(s): qat_deflate.
>   		Disable all accelerators with an empty string (echo > accel).
> +
> +What:		/sys/fs/erofs/<disk>/dir_ra_bytes
> +Date:		July 2025
> +Contact:	"Chao Yu" <chao@kernel.org>
> +Description:	Used to set or show readahead bytes during readdir(), by
> +		default the value is 16384.
> +
> +		- 0: disable readahead.
> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
> index 3e4b38bec0aa..950d6b0046f4 100644
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

	pgoff_t ra_pages = PAGE_ALIGN(EROFS_SB(dir)->dir_ra_bytes);

>   	int err = 0;
>   	bool initial = true;
>   
> @@ -63,6 +65,17 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>   			break;
>   		}
>   
> +		/* readahead blocks to enhance performance in large directory */
> +		if (EROFS_I_SB(dir)->dir_ra_bytes) {

		if (ra_pages) {

> +			unsigned long idx = DIV_ROUND_UP(ctx->pos, PAGE_SIZE);
> +			pgoff_t ra_pages = DIV_ROUND_UP(
> +				EROFS_I_SB(dir)->dir_ra_bytes, PAGE_SIZE);

			pgoff_t idx = PAGE_ALIGN(ctx->pos);
			pgoff_t pages = min(nr_pages - idx, ra_pages);

> +
> +			if (nr_pages - idx > 1 && !ra_has_index(ra, idx))

			if (pages > 1 && !ra_has_index(ra, idx))
				page_cache_sync_readahead(dir->i_mapping, ra,
							  f, idx, pages)?


> +				page_cache_sync_readahead(dir->i_mapping, ra,
> +					f, idx, min(nr_pages - idx, ra_pages));
> +		}
> +
>   		de = erofs_bread(&buf, dbstart, true);
>   		if (IS_ERR(de)) {
>   			erofs_err(sb, "failed to readdir of logical block %llu of nid %llu",
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 0d19bde8c094..4399b9332307 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -157,6 +157,7 @@ struct erofs_sb_info {
>   	/* sysfs support */
>   	struct kobject s_kobj;		/* /sys/fs/erofs/<devname> */
>   	struct completion s_kobj_unregister;
> +	erofs_off_t dir_ra_bytes;
>   
>   	/* fscache support */
>   	struct fscache_volume *volume;
> @@ -238,6 +239,9 @@ EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
>   #define EROFS_I_BL_XATTR_BIT	(BITS_PER_LONG - 1)
>   #define EROFS_I_BL_Z_BIT	(BITS_PER_LONG - 2)
>   
> +/* default readahead size of directory */

/* default readahead size of directories */

Otherwise it looks good to me.

Thanks,
Gao Xiang

> +#define EROFS_DIR_RA_BYTES	16384

