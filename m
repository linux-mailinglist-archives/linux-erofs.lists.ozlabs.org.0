Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA6F4F8154
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Apr 2022 16:10:13 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KZ3Dg0wzYz2yZd
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Apr 2022 00:10:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fV03GPeB;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1;
 helo=ams.source.kernel.org; envelope-from=xiang@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=fV03GPeB; 
 dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KZ3DY16CFz2xsc
 for <linux-erofs@lists.ozlabs.org>; Fri,  8 Apr 2022 00:10:05 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 29220B82735;
 Thu,  7 Apr 2022 14:10:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 735B0C385A5;
 Thu,  7 Apr 2022 14:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649340599;
 bh=5IvxfxxDjdk54PPCzdkREMRze6Mrx0MFKG/E78j6HHU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fV03GPeBUFq2WwJ8Xnd7LTMHkbG5F8ZbQ44ia7yf8Sct+KL+YhVpLdwaulgiZVGd2
 CfLZ3gm+AjlBLX+dMhVkJcNxShVlP1lmN6TcX464S09O82LOoUMzoWwUKYrGl+tzCg
 06VeuM8SPGXdhxCiKYQxLjJOguTd9naHGg6u/KuWS6sfvCSI49OOS9CsmhV9jnMFII
 XMCLfN2ruJsheH6IGE9jdmzfygXJNrURiGs2URRDgD/kc7ymUfV6+caQ+fQte9Syb/
 HUFaMruuM8a4eINL391MeizikqbIQjodZle6KRiIFPECMQejglGI02YgnLYqHrNpms
 bI6ydkXuAQAjQ==
Date: Thu, 7 Apr 2022 22:09:50 +0800
From: Gao Xiang <xiang@kernel.org>
To: Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v8 14/20] erofs: register fscache context for primary
 data blob
Message-ID: <Yk7wrmKYHbhJM8CY@debian>
Mail-Followup-To: Jeffle Xu <jefflexu@linux.alibaba.com>,
 dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org,
 torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
 willy@infradead.org, linux-fsdevel@vger.kernel.org,
 joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
 tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
 eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
 luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
 fannaihao@baidu.com
References: <20220406075612.60298-1-jefflexu@linux.alibaba.com>
 <20220406075612.60298-15-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220406075612.60298-15-jefflexu@linux.alibaba.com>
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
Cc: tianzichen@kuaishou.com, linux-erofs@lists.ozlabs.org, fannaihao@baidu.com,
 willy@infradead.org, linux-kernel@vger.kernel.org, dhowells@redhat.com,
 joseph.qi@linux.alibaba.com, linux-cachefs@redhat.com,
 gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
 luodaowen.backend@bytedance.com, gerry@linux.alibaba.com,
 torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Apr 06, 2022 at 03:56:06PM +0800, Jeffle Xu wrote:
> Registers fscache context for primary data blob. Also move the
> initialization of s_op and related fields forward, since anonymous
> inode will be allocated under the super block when registering the
> fscache context.
> 
> Something worth mentioning about the cleanup routine.
> 
> 1. The fscache context will instantiate anonymous inodes under the super
> block. Release these anonymous inodes when .put_super() is called, or
> we'll get "VFS: Busy inodes after unmount." warning.
> 
> 2. The fscache context is initialized prior to the root inode. If
> .kill_sb() is called when mount failed, .put_super() won't be called
> when root inode has not been initialized yet. Thus .kill_sb() shall
> also contain the cleanup routine.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>  fs/erofs/internal.h |  1 +
>  fs/erofs/super.c    | 15 +++++++++++----
>  2 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 3a4a344cfed3..eb37b33bce37 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -155,6 +155,7 @@ struct erofs_sb_info {
>  
>  	/* fscache support */
>  	struct fscache_volume *volume;
> +	struct erofs_fscache *s_fscache;
>  };
>  
>  #define EROFS_SB(sb) ((struct erofs_sb_info *)(sb)->s_fs_info)
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 6590ed1b7d3b..9498b899b73b 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -585,6 +585,9 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  	int err;
>  
>  	sb->s_magic = EROFS_SUPER_MAGIC;
> +	sb->s_flags |= SB_RDONLY | SB_NOATIME;
> +	sb->s_maxbytes = MAX_LFS_FILESIZE;
> +	sb->s_op = &erofs_sops;
>  
>  	if (!sb_set_blocksize(sb, EROFS_BLKSIZ)) {
>  		erofs_err(sb, "failed to set erofs blksize");
> @@ -605,6 +608,11 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  		err = erofs_fscache_register_fs(sb);
>  		if (err)
>  			return err;
> +
> +		err = erofs_fscache_register_cookie(sb, &sbi->s_fscache,
> +						    sbi->opt.fsid, true);
> +		if (err)
> +			return err;
>  	}
>  
>  	err = erofs_read_superblock(sb);
> @@ -619,11 +627,8 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  			clear_opt(&sbi->opt, DAX_ALWAYS);
>  		}
>  	}
> -	sb->s_flags |= SB_RDONLY | SB_NOATIME;
> -	sb->s_maxbytes = MAX_LFS_FILESIZE;
> -	sb->s_time_gran = 1;
>  
> -	sb->s_op = &erofs_sops;
> +	sb->s_time_gran = 1;
>  	sb->s_xattr = erofs_xattr_handlers;
>  
>  	if (test_opt(&sbi->opt, POSIX_ACL))
> @@ -763,6 +768,7 @@ static void erofs_kill_sb(struct super_block *sb)
>  
>  	erofs_free_dev_context(sbi->devs);
>  	fs_put_dax(sbi->dax_dev);
> +	erofs_fscache_unregister_cookie(&sbi->s_fscache);
>  	erofs_fscache_unregister_fs(sb);
>  	kfree(sbi);
>  	sb->s_fs_info = NULL;
> @@ -781,6 +787,7 @@ static void erofs_put_super(struct super_block *sb)
>  	iput(sbi->managed_cache);
>  	sbi->managed_cache = NULL;
>  #endif
> +	erofs_fscache_unregister_cookie(&sbi->s_fscache);
>  }
>  
>  static struct file_system_type erofs_fs_type = {
> -- 
> 2.27.0
> 
