Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 082AC8A6A09
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Apr 2024 13:58:40 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VJjHK5fWGz3vbC
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Apr 2024 21:58:37 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sjtu.edu.cn (client-ip=202.120.2.232; helo=smtp232.sjtu.edu.cn; envelope-from=zhaoyifan@sjtu.edu.cn; receiver=lists.ozlabs.org)
Received: from smtp232.sjtu.edu.cn (smtp232.sjtu.edu.cn [202.120.2.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VJjHH1Qdyz3bWH
	for <linux-erofs@lists.ozlabs.org>; Tue, 16 Apr 2024 21:58:35 +1000 (AEST)
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
	by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id D9D291008C2C2;
	Tue, 16 Apr 2024 19:58:32 +0800 (CST)
Received: from [192.168.25.134] (unknown [202.120.40.82])
	by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 6007B37C91F;
	Tue, 16 Apr 2024 19:58:30 +0800 (CST)
Message-ID: <559882e2-8b8d-4dd3-890e-63e9c998d200@sjtu.edu.cn>
Date: Tue, 16 Apr 2024 19:58:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] erofs-utils: lib: prepare for later deferred work
To: Gao Xiang <xiang@kernel.org>
References: <20240416080419.32491-1-xiang@kernel.org>
 <20240416080419.32491-2-xiang@kernel.org>
Content-Language: en-US
From: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
In-Reply-To: <20240416080419.32491-2-xiang@kernel.org>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


On 4/16/24 4:04 PM, Gao Xiang wrote:
> From: Gao Xiang <hsiangkao@linux.alibaba.com>
>
> Split out ordered metadata operations and add the following helpers:
>
>   - erofs_mkfs_jobfn()
>
>   - erofs_mkfs_go()
>
> to handle these mkfs job items for multi-threadding support.
>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>   lib/inode.c | 68 +++++++++++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 58 insertions(+), 10 deletions(-)
>
> diff --git a/lib/inode.c b/lib/inode.c
> index 55969d9..8ef0604 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -1133,6 +1133,57 @@ static int erofs_mkfs_handle_nondirectory(struct erofs_inode *inode)
>   	return 0;
>   }
>   
> +enum erofs_mkfs_jobtype {	/* ordered job types */
> +	EROFS_MKFS_JOB_NDIR,
> +	EROFS_MKFS_JOB_DIR,
> +	EROFS_MKFS_JOB_DIR_BH,
> +};
> +
> +struct erofs_mkfs_jobitem {
> +	enum erofs_mkfs_jobtype type;
> +	union {
> +		struct erofs_inode *inode;
> +	} u;
> +};
> +
> +static int erofs_mkfs_jobfn(struct erofs_mkfs_jobitem *item)
> +{
> +	struct erofs_inode *inode = item->u.inode;
> +	int ret;
> +
> +	if (item->type == EROFS_MKFS_JOB_NDIR)
> +		return erofs_mkfs_handle_nondirectory(inode);
> +
> +	if (item->type == EROFS_MKFS_JOB_DIR) {
> +		ret = erofs_prepare_inode_buffer(inode);
> +		if (ret)
> +			return ret;
> +		inode->bh->op = &erofs_skip_write_bhops;
> +		if (IS_ROOT(inode))
> +			erofs_fixup_meta_blkaddr(inode);

I think this 2 line above does not exist in the logic replaced by 
`erofs_mkfs_jobfn`, should it appear in this patch, or need further 
explanation in the commit msg?


Thanks,

Yifan Zhao

> +		return 0;
> +	}
> +
> +	if (item->type == EROFS_MKFS_JOB_DIR_BH) {
> +		erofs_write_dir_file(inode);
> +		erofs_write_tail_end(inode);
> +		inode->bh->op = &erofs_write_inode_bhops;
> +		erofs_iput(inode);
> +		return 0;
> +	}
> +	return -EINVAL;
> +}
> +
> +int erofs_mkfs_go(struct erofs_sb_info *sbi,
> +		  enum erofs_mkfs_jobtype type, void *elem, int size)
> +{
> +	struct erofs_mkfs_jobitem item;
> +
> +	item.type = type;
> +	memcpy(&item.u, elem, size);
> +	return erofs_mkfs_jobfn(&item);
> +}
> +
>   static int erofs_mkfs_handle_directory(struct erofs_inode *dir)
>   {
>   	DIR *_dir;
> @@ -1213,11 +1264,7 @@ static int erofs_mkfs_handle_directory(struct erofs_inode *dir)
>   	else
>   		dir->i_nlink = i_nlink;
>   
> -	ret = erofs_prepare_inode_buffer(dir);
> -	if (ret)
> -		return ret;
> -	dir->bh->op = &erofs_skip_write_bhops;
> -	return 0;
> +	return erofs_mkfs_go(dir->sbi, EROFS_MKFS_JOB_DIR, &dir, sizeof(dir));
>   
>   err_closedir:
>   	closedir(_dir);
> @@ -1243,7 +1290,8 @@ static int erofs_mkfs_handle_inode(struct erofs_inode *inode)
>   		return ret;
>   
>   	if (!S_ISDIR(inode->i_mode))
> -		ret = erofs_mkfs_handle_nondirectory(inode);
> +		ret = erofs_mkfs_go(inode->sbi, EROFS_MKFS_JOB_NDIR,
> +				    &inode, sizeof(inode));
>   	else
>   		ret = erofs_mkfs_handle_directory(inode);
>   	erofs_info("file %s dumped (mode %05o)", erofs_fspath(inode->i_srcpath),
> @@ -1302,10 +1350,10 @@ struct erofs_inode *erofs_mkfs_build_tree_from_path(const char *path)
>   		}
>   		*last = dumpdir;	/* fixup the last (or the only) one */
>   		dumpdir = head;
> -		erofs_write_dir_file(dir);
> -		erofs_write_tail_end(dir);
> -		dir->bh->op = &erofs_write_inode_bhops;
> -		erofs_iput(dir);
> +		err = erofs_mkfs_go(dir->sbi, EROFS_MKFS_JOB_DIR_BH,
> +				    &dir, sizeof(dir));
> +		if (err)
> +			return ERR_PTR(err);
>   	} while (dumpdir);
>   
>   	return root;
