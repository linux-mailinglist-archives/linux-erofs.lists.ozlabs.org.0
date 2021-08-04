Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 035643DFBDC
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Aug 2021 09:14:49 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gfjft6RbLz3bX6
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Aug 2021 17:14:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SOnpiaXk;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=SOnpiaXk; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gfjfq38m0z30Dd
 for <linux-erofs@lists.ozlabs.org>; Wed,  4 Aug 2021 17:14:43 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A05660F0F;
 Wed,  4 Aug 2021 07:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628061280;
 bh=mvlkShP42NWDPWxCxm2gbZR/HIAhA+gr4IfzVLEKKTE=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=SOnpiaXkVYfjkleO8zecw6tgT328VcdP3DweZC2p5jqGyOEE3G6V7lSTDj4SlCQbu
 AfAYLcRJmIgL4Ebpf8+3lvK4DF8V4uZ7qudSJPdC5KvapgqHRUmySu0ZJNo3mofqeO
 K8oAWeWV7ZZmGNeuuCVpl2X6BXZeSIyHxLToYwwLg/WiA+KszqZ8MS5xfL8LHi/USm
 DkvRGqeEPFx1vr0FwLHd4qABIMoYz604IjtAOougdjwFsqLUUd/pbOitMu2M5MMBLV
 Lx5UMyj3pGrIP1d8JPcA4kgl8+AHNCbN4q2y21jm4+FYlxHF7zcU9TCSuOztCHaMv9
 mSdtUNoVQdrZQ==
Subject: Re: [PATCH v2 2/3] erofs: dax support for non-tailpacking regular file
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20210730194625.93856-1-hsiangkao@linux.alibaba.com>
 <20210730194625.93856-3-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <4de79cbb-6977-1172-4e69-5e9040caadf2@kernel.org>
Date: Wed, 4 Aug 2021 15:14:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210730194625.93856-3-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
Cc: nvdimm@lists.linux.dev, "Darrick J. Wong" <djwong@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 Liu Bo <bo.liu@linux.alibaba.com>, Tao Ma <boyu.mt@taobao.com>,
 linux-fsdevel@vger.kernel.org, Liu Jiang <gerry@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2021/7/31 3:46, Gao Xiang wrote:
> DAX is quite useful for some VM use cases in order to save guest
> memory extremely with minimal lightweight EROFS.
> 
> In order to prepare for such use cases, add preliminary dax support
> for non-tailpacking regular files for now.
> 
> Tested with the DRAM-emulated PMEM and the EROFS image generated by
> "mkfs.erofs -Enoinline_data enwik9.fsdax.img enwik9"
> 
> Cc: nvdimm@lists.linux.dev
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>   fs/erofs/data.c     | 42 +++++++++++++++++++++++++++++--
>   fs/erofs/inode.c    |  4 +++
>   fs/erofs/internal.h |  3 +++
>   fs/erofs/super.c    | 60 +++++++++++++++++++++++++++++++++++++++++++--
>   4 files changed, 105 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 1f97151a9f90..911521293b20 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -6,7 +6,7 @@
>   #include "internal.h"
>   #include <linux/prefetch.h>
>   #include <linux/iomap.h>
> -
> +#include <linux/dax.h>
>   #include <trace/events/erofs.h>
>   
>   static void erofs_readendio(struct bio *bio)
> @@ -323,6 +323,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   		return ret;
>   
>   	iomap->bdev = inode->i_sb->s_bdev;
> +	iomap->dax_dev = EROFS_I_SB(inode)->dax_dev;
>   	iomap->offset = map.m_la;
>   	iomap->length = map.m_llen;
>   	iomap->flags = 0;
> @@ -382,6 +383,10 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>   	if (!iov_iter_count(to))
>   		return 0;
>   
> +#ifdef CONFIG_FS_DAX
> +	if (IS_DAX(iocb->ki_filp->f_mapping->host))
> +		return dax_iomap_rw(iocb, to, &erofs_iomap_ops);
> +#endif
>   	if (iocb->ki_flags & IOCB_DIRECT) {
>   		int err = erofs_prepare_dio(iocb, to);
>   
> @@ -410,9 +415,42 @@ const struct address_space_operations erofs_raw_access_aops = {
>   	.direct_IO = noop_direct_IO,
>   };
>   
> +#ifdef CONFIG_FS_DAX
> +static vm_fault_t erofs_dax_huge_fault(struct vm_fault *vmf,
> +		enum page_entry_size pe_size)
> +{
> +	return dax_iomap_fault(vmf, pe_size, NULL, NULL, &erofs_iomap_ops);
> +}
> +
> +static vm_fault_t erofs_dax_fault(struct vm_fault *vmf)
> +{
> +	return erofs_dax_huge_fault(vmf, PE_SIZE_PTE);
> +}
> +
> +static const struct vm_operations_struct erofs_dax_vm_ops = {
> +	.fault		= erofs_dax_fault,
> +	.huge_fault	= erofs_dax_huge_fault,
> +};
> +
> +static int erofs_file_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +	if (!IS_DAX(file_inode(file)))
> +		return generic_file_readonly_mmap(file, vma);
> +
> +	if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_MAYWRITE))
> +		return -EINVAL;
> +
> +	vma->vm_ops = &erofs_dax_vm_ops;
> +	vma->vm_flags |= VM_HUGEPAGE;
> +	return 0;
> +}
> +#else
> +#define erofs_file_mmap	generic_file_readonly_mmap
> +#endif
> +
>   const struct file_operations erofs_file_fops = {
>   	.llseek		= generic_file_llseek,
>   	.read_iter	= erofs_file_read_iter,
> -	.mmap		= generic_file_readonly_mmap,
> +	.mmap		= erofs_file_mmap,
>   	.splice_read	= generic_file_splice_read,
>   };
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index 00edb7562fea..e875fba18159 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -174,6 +174,10 @@ static struct page *erofs_read_inode(struct inode *inode,
>   	inode->i_mtime.tv_nsec = inode->i_ctime.tv_nsec;
>   	inode->i_atime.tv_nsec = inode->i_ctime.tv_nsec;
>   
> +	inode->i_flags &= ~S_DAX;
> +	if (test_opt(&sbi->ctx, DAX_ALWAYS) && S_ISREG(inode->i_mode) &&
> +	    vi->datalayout == EROFS_INODE_FLAT_PLAIN)
> +		inode->i_flags |= S_DAX;
>   	if (!nblks)
>   		/* measure inode.i_blocks as generic filesystems */
>   		inode->i_blocks = roundup(inode->i_size, EROFS_BLKSIZ) >> 9;
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 2669c785d548..7c9abfc93109 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -83,6 +83,7 @@ struct erofs_sb_info {
>   
>   	struct erofs_sb_lz4_info lz4;
>   #endif	/* CONFIG_EROFS_FS_ZIP */
> +	struct dax_device *dax_dev;
>   	u32 blocks;
>   	u32 meta_blkaddr;
>   #ifdef CONFIG_EROFS_FS_XATTR
> @@ -115,6 +116,8 @@ struct erofs_sb_info {
>   /* Mount flags set via mount options or defaults */
>   #define EROFS_MOUNT_XATTR_USER		0x00000010
>   #define EROFS_MOUNT_POSIX_ACL		0x00000020
> +#define EROFS_MOUNT_DAX_ALWAYS		0x00000040
> +#define EROFS_MOUNT_DAX_NEVER		0x00000080
>   
>   #define clear_opt(ctx, option)	((ctx)->mount_opt &= ~EROFS_MOUNT_##option)
>   #define set_opt(ctx, option)	((ctx)->mount_opt |= EROFS_MOUNT_##option)
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 8fc6c04b54f4..d5b110fd365d 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -11,6 +11,7 @@
>   #include <linux/crc32c.h>
>   #include <linux/fs_context.h>
>   #include <linux/fs_parser.h>
> +#include <linux/dax.h>
>   #include "xattr.h"
>   
>   #define CREATE_TRACE_POINTS
> @@ -355,6 +356,8 @@ enum {
>   	Opt_user_xattr,
>   	Opt_acl,
>   	Opt_cache_strategy,
> +	Opt_dax,
> +	Opt_dax_enum,

We need to update doc for those new dax mount options.

>   	Opt_err
>   };
>   
> @@ -365,14 +368,47 @@ static const struct constant_table erofs_param_cache_strategy[] = {
>   	{}
>   };
>   
> +static const struct constant_table erofs_dax_param_enums[] = {
> +	{"always",	EROFS_MOUNT_DAX_ALWAYS},
> +	{"never",	EROFS_MOUNT_DAX_NEVER},
> +	{}
> +};
> +
>   static const struct fs_parameter_spec erofs_fs_parameters[] = {
>   	fsparam_flag_no("user_xattr",	Opt_user_xattr),
>   	fsparam_flag_no("acl",		Opt_acl),
>   	fsparam_enum("cache_strategy",	Opt_cache_strategy,
>   		     erofs_param_cache_strategy),
> +	fsparam_flag("dax",             Opt_dax),
> +	fsparam_enum("dax",		Opt_dax_enum, erofs_dax_param_enums),
>   	{}
>   };
>   
> +static bool erofs_fc_set_dax_mode(struct fs_context *fc, unsigned int mode)
> +{
> +#ifdef CONFIG_FS_DAX
> +	struct erofs_fs_context *ctx = fc->fs_private;
> +
> +	switch (mode) {
> +	case EROFS_MOUNT_DAX_ALWAYS:
> +		warnfc(fc, "DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
> +		set_opt(ctx, DAX_ALWAYS);
> +		clear_opt(ctx, DAX_NEVER);
> +		return true;
> +	case EROFS_MOUNT_DAX_NEVER:
> +		set_opt(ctx, DAX_NEVER);
> +		clear_opt(ctx, DAX_ALWAYS);
> +		return true;
> +	default:
> +		DBG_BUGON(1);
> +		return false;
> +	}
> +#else
> +	errorfc(fc, "dax options not supported");
> +	return false;
> +#endif
> +}
> +
>   static int erofs_fc_parse_param(struct fs_context *fc,
>   				struct fs_parameter *param)
>   {
> @@ -412,6 +448,14 @@ static int erofs_fc_parse_param(struct fs_context *fc,
>   		errorfc(fc, "compression not supported, cache_strategy ignored");
>   #endif
>   		break;
> +	case Opt_dax:
> +		if (!erofs_fc_set_dax_mode(fc, EROFS_MOUNT_DAX_ALWAYS))
> +			return -EINVAL;
> +		break;
> +	case Opt_dax_enum:
> +		if (!erofs_fc_set_dax_mode(fc, result.uint_32))
> +			return -EINVAL;
> +		break;
>   	default:
>   		return -ENOPARAM;
>   	}
> @@ -496,10 +540,16 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>   		return -ENOMEM;
>   
>   	sb->s_fs_info = sbi;
> +	sbi->dax_dev = fs_dax_get_by_bdev(sb->s_bdev);
>   	err = erofs_read_superblock(sb);
>   	if (err)
>   		return err;
>   
> +	if (test_opt(ctx, DAX_ALWAYS) &&
> +	    !bdev_dax_supported(sb->s_bdev, EROFS_BLKSIZ)) {
> +		errorfc(fc, "DAX unsupported by block device. Turning off DAX.");
> +		clear_opt(ctx, DAX_ALWAYS);
> +	}
>   	sb->s_flags |= SB_RDONLY | SB_NOATIME;
>   	sb->s_maxbytes = MAX_LFS_FILESIZE;
>   	sb->s_time_gran = 1;
> @@ -609,6 +659,8 @@ static void erofs_kill_sb(struct super_block *sb)
>   	sbi = EROFS_SB(sb);
>   	if (!sbi)
>   		return;
> +	if (sbi->dax_dev)
> +		fs_put_dax(sbi->dax_dev);

fs_put_dax(sbi->dax_dev);

Thanks,

>   	kfree(sbi);
>   	sb->s_fs_info = NULL;
>   }
> @@ -711,8 +763,8 @@ static int erofs_statfs(struct dentry *dentry, struct kstatfs *buf)
>   
>   static int erofs_show_options(struct seq_file *seq, struct dentry *root)
>   {
> -	struct erofs_sb_info *sbi __maybe_unused = EROFS_SB(root->d_sb);
> -	struct erofs_fs_context *ctx __maybe_unused = &sbi->ctx;
> +	struct erofs_sb_info *sbi = EROFS_SB(root->d_sb);
> +	struct erofs_fs_context *ctx = &sbi->ctx;
>   
>   #ifdef CONFIG_EROFS_FS_XATTR
>   	if (test_opt(ctx, XATTR_USER))
> @@ -734,6 +786,10 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
>   	else if (ctx->cache_strategy == EROFS_ZIP_CACHE_READAROUND)
>   		seq_puts(seq, ",cache_strategy=readaround");
>   #endif
> +	if (test_opt(ctx, DAX_ALWAYS))
> +		seq_puts(seq, ",dax=always");
> +	if (test_opt(ctx, DAX_NEVER))
> +		seq_puts(seq, ",dax=never");
>   	return 0;
>   }
>   
> 
