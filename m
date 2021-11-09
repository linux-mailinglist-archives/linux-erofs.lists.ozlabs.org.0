Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9303044AEB8
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Nov 2021 14:27:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HpTLH3KW4z2yQH
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Nov 2021 00:27:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AX81colq;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=AX81colq; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HpTLC6Wggz2xv8
 for <linux-erofs@lists.ozlabs.org>; Wed, 10 Nov 2021 00:27:31 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id E2E2261159;
 Tue,  9 Nov 2021 13:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1636464449;
 bh=HpU5yMi3I0oRYexnSAUrBIMuTdc6OxR7OPbDG9kAIA8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=AX81colqHSy015btlOq0G9JRoqwJgYyvl98sQy0zDgeZzWU5Rj1LX1HmPyjAwzJfT
 IP6hJaz58WeEw3Zv/9gP4fHPTd8T108+D2KQqFRUM+8h07s6p+iieUIxI//weoHc45
 14cJ2CMmbfN7NY3NAjN2f0u77isy8iha6vAaiEGiySKER1OFCxgA4xDHf5VGJtNanp
 MeeHYc6KVNebHfgMw0nX/PK/ar2bDxmtRFRM90GqxAX/yXpKVXRrE8XT7wMYq0LV/h
 k0Pz7hsw0adizpsrSJrrRtuuBqBxqhILNqAfGqjYPEhwUZnqKvaO04DVNRA7WEffdo
 6asVz4yyD1CUg==
Message-ID: <fa2eeb31-9579-a4a4-71b3-200509da1ed9@kernel.org>
Date: Tue, 9 Nov 2021 21:27:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2 2/2] erofs: add sysfs node to control sync
 decompression strategy
Content-Language: en-US
To: Huang Jianan <huangjianan@oppo.com>, linux-erofs@lists.ozlabs.org
References: <82f7c99e-b83f-90b7-fceb-b8436da94339@oppo.com>
 <20211109074536.23137-1-huangjianan@oppo.com>
 <20211109074536.23137-2-huangjianan@oppo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20211109074536.23137-2-huangjianan@oppo.com>
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
Cc: yh@oppo.com, zhangshiming@oppo.com, guoweichao@oppo.com,
 linux-kernel@vger.kernel.org, guanyuwei@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2021/11/9 15:45, Huang Jianan via Linux-erofs wrote:
> Although readpage is a synchronous path, there will be no additional
> kworker scheduling overhead in non-atomic contexts. So add a sysfs
> node to allow disable sync decompression.
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> ---
> changes since v1:
> - leave auto default
> - add a disable strategy for sync_decompress
> 
>   Documentation/ABI/testing/sysfs-fs-erofs |  9 +++++++++
>   fs/erofs/internal.h                      |  4 ++--
>   fs/erofs/super.c                         |  2 +-
>   fs/erofs/sysfs.c                         | 10 ++++++++++
>   fs/erofs/zdata.c                         | 19 ++++++++++++++-----
>   5 files changed, 36 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ABI/testing/sysfs-fs-erofs
> index 86d0d0234473..c84f12004f02 100644
> --- a/Documentation/ABI/testing/sysfs-fs-erofs
> +++ b/Documentation/ABI/testing/sysfs-fs-erofs
> @@ -5,3 +5,12 @@ Description:	Shows all enabled kernel features.
>   		Supported features:
>   		lz4_0padding, compr_cfgs, big_pcluster, device_table,
>   		sb_chksum.
> +
> +What:		/sys/fs/erofs/<disk>/sync_decompress
> +Date:		November 2021
> +Contact:	"Huang Jianan" <huangjianan@oppo.com>
> +Description:	Control strategy of sync decompression
> +		- 0 (defalut, auto): enable for readpage, and enable for
> +				     readahead on atomic contexts only,
> +		- 1 (force on): enable for readpage and readahead.
> +		- 2 (disable): disable for all situations.

1 (force on)
2 (force off)

> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index d0cd712dc222..06a8bbdb378f 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -60,8 +60,8 @@ struct erofs_mount_opts {
>   #ifdef CONFIG_EROFS_FS_ZIP
>   	/* current strategy of how to use managed cache */
>   	unsigned char cache_strategy;
> -	/* strategy of sync decompression (false - auto, true - force on) */
> -	bool readahead_sync_decompress;
> +	/* strategy of sync decompression (0 - auto, 1 - force on, 2 - disable) */

Ditto,

> +	unsigned int sync_decompress;
>   
>   	/* threshold for decompression synchronously */
>   	unsigned int max_sync_decompress_pages;
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index abc1da5d1719..ea223d6c7985 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -423,7 +423,7 @@ static void erofs_default_options(struct erofs_fs_context *ctx)
>   #ifdef CONFIG_EROFS_FS_ZIP
>   	ctx->opt.cache_strategy = EROFS_ZIP_CACHE_READAROUND;
>   	ctx->opt.max_sync_decompress_pages = 3;
> -	ctx->opt.readahead_sync_decompress = false;
> +	ctx->opt.sync_decompress = 0;
>   #endif
>   #ifdef CONFIG_EROFS_FS_XATTR
>   	set_opt(&ctx->opt, XATTR_USER);
> diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
> index dd328d20c451..a8889b2b65f3 100644
> --- a/fs/erofs/sysfs.c
> +++ b/fs/erofs/sysfs.c
> @@ -16,6 +16,7 @@ enum {
>   
>   enum {
>   	struct_erofs_sb_info,
> +	struct_erofs_mount_opts,
>   };
>   
>   struct erofs_attr {
> @@ -55,7 +56,10 @@ static struct erofs_attr erofs_attr_##_name = {			\
>   
>   #define ATTR_LIST(name) (&erofs_attr_##name.attr)
>   
> +EROFS_ATTR_RW_UI(sync_decompress, erofs_mount_opts);
> +
>   static struct attribute *erofs_attrs[] = {
> +	ATTR_LIST(sync_decompress),
>   	NULL,
>   };
>   ATTRIBUTE_GROUPS(erofs);
> @@ -82,6 +86,8 @@ static unsigned char *__struct_ptr(struct erofs_sb_info *sbi,
>   {
>   	if (struct_type == struct_erofs_sb_info)
>   		return (unsigned char *)sbi + offset;
> +	if (struct_type == struct_erofs_mount_opts)
> +		return (unsigned char *)&sbi->opt + offset;
>   	return NULL;
>   }
>   
> @@ -126,6 +132,10 @@ static ssize_t erofs_attr_store(struct kobject *kobj, struct attribute *attr,
>   		ret = kstrtoul(skip_spaces(buf), 0, &t);
>   		if (ret)
>   			return ret;
> +		
> +		if (!strcmp(a->attr.name, "sync_decompress") && (t > 2))

if (!strcmp()) {
	if (t > 2)
		return -EINVAL;
	*((unsigned int *) ptr) = t;
	return len;
}

How about adding enum instead of raw numbers to improve readability?

Thanks,

> +			return -EINVAL;
> +
>   		*((unsigned int *) ptr) = t;
>   		return len;
>   	case attr_pointer_bool:
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index bcb1b91b234f..70ec51fa7131 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -794,7 +794,8 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
>   	/* Use workqueue and sync decompression for atomic contexts only */
>   	if (in_atomic() || irqs_disabled()) {
>   		queue_work(z_erofs_workqueue, &io->u.work);
> -		sbi->opt.readahead_sync_decompress = true;
> +		if (sbi->opt.sync_decompress == 0)
> +			sbi->opt.sync_decompress = 1;
>   		return;
>   	}
>   	z_erofs_decompressqueue_work(&io->u.work);
> @@ -1454,9 +1455,11 @@ static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
>   static int z_erofs_readpage(struct file *file, struct page *page)
>   {
>   	struct inode *const inode = page->mapping->host;
> +	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
>   	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
>   	struct page *pagepool = NULL;
>   	int err;
> +	bool force_fg = true;
>   
>   	trace_erofs_readpage(page, false);
>   	f.headoffset = (erofs_off_t)page->index << PAGE_SHIFT;
> @@ -1468,8 +1471,11 @@ static int z_erofs_readpage(struct file *file, struct page *page)
>   
>   	(void)z_erofs_collector_end(&f.clt);
>   
> +	if (sbi->opt.sync_decompress == 2)
> +		force_fg = false;
> +
>   	/* if some compressed cluster ready, need submit them anyway */
> -	z_erofs_runqueue(inode->i_sb, &f, &pagepool, true);
> +	z_erofs_runqueue(inode->i_sb, &f, &pagepool, force_fg);
>   
>   	if (err)
>   		erofs_err(inode->i_sb, "failed to read, err [%d]", err);
> @@ -1488,6 +1494,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
>   	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
>   	struct page *pagepool = NULL, *head = NULL, *page;
>   	unsigned int nr_pages;
> +	bool force_fg = false;
>   
>   	f.readahead = true;
>   	f.headoffset = readahead_pos(rac);
> @@ -1519,9 +1526,11 @@ static void z_erofs_readahead(struct readahead_control *rac)
>   	z_erofs_pcluster_readmore(&f, rac, 0, &pagepool, false);
>   	(void)z_erofs_collector_end(&f.clt);
>   
> -	z_erofs_runqueue(inode->i_sb, &f, &pagepool,
> -			 sbi->opt.readahead_sync_decompress &&
> -			 nr_pages <= sbi->opt.max_sync_decompress_pages);
> +	if (sbi->opt.sync_decompress == 1)
> +		force_fg = true;
> +
> +	z_erofs_runqueue(inode->i_sb, &f, &pagepool, force_fg
> +			 && nr_pages <= sbi->opt.max_sync_decompress_pages);
>   	if (f.map.mpage)
>   		put_page(f.map.mpage);
>   	erofs_release_pages(&pagepool);
> 
