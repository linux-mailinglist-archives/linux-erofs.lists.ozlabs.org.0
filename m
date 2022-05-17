Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D602652A1AC
	for <lists+linux-erofs@lfdr.de>; Tue, 17 May 2022 14:38:46 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L2bJh5N9Gz3byT
	for <lists+linux-erofs@lfdr.de>; Tue, 17 May 2022 22:38:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=C2WXA3IU;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org;
 envelope-from=brauner@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=C2WXA3IU; 
 dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4L2bJd1wGFz3brS
 for <linux-erofs@lists.ozlabs.org>; Tue, 17 May 2022 22:38:41 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id C304FB81850;
 Tue, 17 May 2022 12:38:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84523C385B8;
 Tue, 17 May 2022 12:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652791115;
 bh=LIsIRcOqu8P2nmMmzUGL1U6NE+q60aQJTmKQGfMmfAE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=C2WXA3IU7f+pcEspYNUpYSbKwVwkd7y3B4VPfrrPmxD0wssaKhwxv874qnmfJ/fAD
 xJ7sziPtwz1QfjgE8Kz6fMGULDGXOy/rwGTw5mcNRX3lpz8K5LkMCVIU8PGj0URdpN
 gWd5UWy67WB4UgNadcYMiOymDT9M6PkPE1Zqx2OH9uGXqNdwRSc3MzP+lb4t3buPwg
 OqhMBzJl4/RdYsYuoQmRkP0EDrJqXboTZTpQYoSljVEjXs/bS7dvkWJN4IzZ54Jkh7
 C31eeotP9L+q1raCjAQTUpD6kt1vwcFtlwsoxAe1IjNt71uY59Fw1Cg6Xj+8apwh0f
 eYuwJFGqVkTsA==
Date: Tue, 17 May 2022 14:38:30 +0200
From: Christian Brauner <brauner@kernel.org>
To: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v2] erofs: support idmapped mounts
Message-ID: <20220517123830.thez6m7xzb3fpnpx@wittgenstein>
References: <20220517104103.3570721-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220517104103.3570721-1-chao@kernel.org>
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
Cc: linux-fsdevel@vger.kernel.org, Gao Xiang <hsiangkao@linux.alibaba.com>,
 linux-erofs@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
 Chao Yu <chao.yu@oppo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

[adding fsdevel for awareness]

On Tue, May 17, 2022 at 06:41:03PM +0800, Chao Yu wrote:
> This patch enables idmapped mounts for erofs, since all dedicated helpers
> for this functionality existsm, so, in this patch we just pass down the
> user_namespace argument from the VFS methods to the relevant helpers.
> 
> Simple idmap example on erofs image:
> 
> 1. mkdir dir
> 2. touch dir/file
> 3. mkfs.erofs erofs.img dir
> 4. mount -t erofs -o loop erofs.img  /mnt/erofs/
> 
> 5. ls -ln /mnt/erofs/
> total 0
> -rw-rw-r-- 1 1000 1000 0 May 17 15:26 file
> 
> 6. mount-idmapped --map-mount b:1000:1001:1 /mnt/erofs/ /mnt/scratch_erofs/
> 
> 7. ls -ln /mnt/scratch_erofs/
> total 0
> -rw-rw-r-- 1 1001 1001 0 May 17 15:26 file
> 
> Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Chao Yu <chao.yu@oppo.com>
> ---
> v2:
> - fix testcase pointed out by Christian Brauner.
>  fs/erofs/inode.c | 2 +-
>  fs/erofs/super.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index e8b37ba5e9ad..5320bf52c1ce 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -370,7 +370,7 @@ int erofs_getattr(struct user_namespace *mnt_userns, const struct path *path,
>  	stat->attributes_mask |= (STATX_ATTR_COMPRESSED |
>  				  STATX_ATTR_IMMUTABLE);
>  
> -	generic_fillattr(&init_user_ns, inode, stat);
> +	generic_fillattr(mnt_userns, inode, stat);
>  	return 0;
>  }
>  
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 0c4b41130c2f..7dc5f2e8ddee 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -781,7 +781,7 @@ static struct file_system_type erofs_fs_type = {
>  	.name           = "erofs",
>  	.init_fs_context = erofs_init_fs_context,
>  	.kill_sb        = erofs_kill_sb,
> -	.fs_flags       = FS_REQUIRES_DEV,
> +	.fs_flags       = FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
>  };
>  MODULE_ALIAS_FS("erofs");
>  
> -- 
> 2.25.1
> 
