Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB0C50F006
	for <lists+linux-erofs@lfdr.de>; Tue, 26 Apr 2022 06:46:16 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KnTqB1dpqz2yQ9
	for <lists+linux-erofs@lfdr.de>; Tue, 26 Apr 2022 14:46:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=47.90.199.18;
 helo=out199-18.us.a.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com;
 receiver=<UNKNOWN>)
Received: from out199-18.us.a.mail.aliyun.com (out199-18.us.a.mail.aliyun.com
 [47.90.199.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KnTq66PxNz2xsG
 for <linux-erofs@lists.ozlabs.org>; Tue, 26 Apr 2022 14:46:05 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R921e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0VBJV9GX_1650948355; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0VBJV9GX_1650948355) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 26 Apr 2022 12:45:57 +0800
Date: Tue, 26 Apr 2022 12:45:55 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Hongnan Li <hongnan.li@linux.alibaba.com>
Subject: Re: [PATCH v2 resend] erofs: make filesystem exportable
Message-ID: <Ymd5A5ZaCprBx0w9@B-P7TQMD6M-0146.local>
References: <20220424130104.102365-1-hongnan.li@linux.alibaba.com>
 <20220425040712.91685-1-hongnan.li@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220425040712.91685-1-hongnan.li@linux.alibaba.com>
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Apr 25, 2022 at 12:07:12PM +0800, Hongnan Li wrote:
> Implement export operations in order to make EROFS support accessing
> inodes with filehandles so that it can be exported via NFS and used
> by overlayfs.
> 
> Without this patch, 'exportfs -rv' will report:
> exportfs: /root/erofs_mp does not support NFS export
> 
> Also tested with unionmount-testsuite and the testcase below passes now:
> ./run --ov --erofs --verify hard-link
> 
> For more details about the testcase, see:
> https://github.com/amir73il/unionmount-testsuite/pull/6
> 
> Signed-off-by: Hongnan Li <hongnan.li@linux.alibaba.com>
> ---
>  fs/erofs/internal.h |  2 +-
>  fs/erofs/namei.c    |  5 ++---
>  fs/erofs/super.c    | 40 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 43 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 5298c4ee277d..12c65f647324 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -509,7 +509,7 @@ int erofs_getattr(struct user_namespace *mnt_userns, const struct path *path,
>  /* namei.c */
>  extern const struct inode_operations erofs_dir_iops;
>  
> -int erofs_namei(struct inode *dir, struct qstr *name,
> +int erofs_namei(struct inode *dir, const struct qstr *name,
>  		erofs_nid_t *nid, unsigned int *d_type);
>  
>  /* dir.c */
> diff --git a/fs/erofs/namei.c b/fs/erofs/namei.c
> index 554efa363317..fd75506799c4 100644
> --- a/fs/erofs/namei.c
> +++ b/fs/erofs/namei.c
> @@ -165,9 +165,8 @@ static void *find_target_block_classic(struct erofs_buf *target,
>  	return candidate;
>  }
>  
> -int erofs_namei(struct inode *dir,
> -		struct qstr *name,
> -		erofs_nid_t *nid, unsigned int *d_type)
> +int erofs_namei(struct inode *dir, const struct qstr *name, erofs_nid_t *nid,
> +		unsigned int *d_type)
>  {
>  	int ndirents;
>  	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 0c4b41130c2f..1c77b7acabd0 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -13,6 +13,7 @@
>  #include <linux/fs_context.h>
>  #include <linux/fs_parser.h>
>  #include <linux/dax.h>
> +#include <linux/exportfs.h>
>  #include "xattr.h"
>  
>  #define CREATE_TRACE_POINTS
> @@ -577,6 +578,44 @@ static int erofs_init_managed_cache(struct super_block *sb)
>  static int erofs_init_managed_cache(struct super_block *sb) { return 0; }
>  #endif
>  
> +static struct inode *erofs_nfs_get_inode(struct super_block *sb,
> +		u64 ino, u32 generation)
> +{
> +	return erofs_iget(sb, ino, false);
> +}
> +
> +static struct dentry *erofs_fh_to_dentry(struct super_block *sb, struct fid *fid,
> +		int fh_len, int fh_type)
> +{
> +	return generic_fh_to_dentry(sb, fid, fh_len, fh_type,
> +				    erofs_nfs_get_inode);
> +}
> +
> +static struct dentry *erofs_fh_to_parent(struct super_block *sb, struct fid *fid,
> +		int fh_len, int fh_type)
> +{
> +	return generic_fh_to_parent(sb, fid, fh_len, fh_type,
> +				    erofs_nfs_get_inode);
> +}
> +
> +static struct dentry *erofs_get_parent(struct dentry *child)
> +{
> +	erofs_nid_t nid;
> +	unsigned int d_type;
> +	int err;
> +
> +	err = erofs_namei(d_inode(child), &dotdot_name, &nid, &d_type);
> +	if (err)
> +		return ERR_PTR(err);
> +	return d_obtain_alias(erofs_iget(child->d_sb, nid, d_type == FT_DIR));
> +}
> +
> +static const struct export_operations erofs_export_ops = {
> +	.fh_to_dentry = erofs_fh_to_dentry,
> +	.fh_to_parent = erofs_fh_to_parent,
> +	.get_parent = erofs_get_parent,
> +};
> +
>  static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  {
>  	struct inode *inode;
> @@ -618,6 +657,7 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  	sb->s_time_gran = 1;
>  
>  	sb->s_op = &erofs_sops;
> +	sb->s_export_op = &erofs_export_ops;

I might need to rearrange this part later since it has a slight conflict
with the fscache patchset. Otherwise looks good to me,

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

>  	sb->s_xattr = erofs_xattr_handlers;
>  
>  	if (test_opt(&sbi->opt, POSIX_ACL))
> -- 
> 2.19.1.6.gb485710b
