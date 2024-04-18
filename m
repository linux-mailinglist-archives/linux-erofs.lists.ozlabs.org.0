Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE448A911A
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Apr 2024 04:16:41 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=HP2MFlm7;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VKhGs1kB6z3cVV
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Apr 2024 12:16:37 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=HP2MFlm7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VKhGk1r5Tz3bnv
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Apr 2024 12:16:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713406583; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=TM7yh3Pc+NlyrCnP/xTpDY59CYpvgC4vK6lCHL3DuuQ=;
	b=HP2MFlm7qWJowhNGLOJMmY7KKjkTDiOlpXfPLVkLBsEI5szXk8NetC/cPbWcHdI5jeIDhHDkv9NQLNhvj2XtUYs3JHH307hKsTJFCJc0JeOEKu3rkaS6td7JPrB+w7C04Wc4PR1+iW8MUqldjTEA0xy/KTogxHgKf/yyxj9s2j8=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W4mrYNk_1713406579;
Received: from 30.221.145.60(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W4mrYNk_1713406579)
          by smtp.aliyun-inc.com;
          Thu, 18 Apr 2024 10:16:21 +0800
Message-ID: <71e66b02-9c2b-4981-83e1-8af72d6c0975@linux.alibaba.com>
Date: Thu, 18 Apr 2024 10:16:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: reliably distinguish block based and fscache
 mode
To: Baokun Li <libaokun1@huawei.com>, linux-erofs@lists.ozlabs.org
References: <20240417065513.3409744-1-libaokun1@huawei.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240417065513.3409744-1-libaokun1@huawei.com>
Content-Type: text/plain; charset=UTF-8
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
Cc: brauner@kernel.org, yangerkun@huawei.com, linux-kernel@vger.kernel.org, huyue2@coolpad.com, viro@zeniv.linux.org.uk
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Baokun,

Thanks for catching this and move forward fixing this!


On 4/17/24 2:55 PM, Baokun Li wrote:
> When erofs_kill_sb() is called in block dev based mode, s_bdev may not have
> been initialised yet, and if CONFIG_EROFS_FS_ONDEMAND is enabled, it will
> be mistaken for fscache mode, and then attempt to free an anon_dev that has
> never been allocated, triggering the following warning:
> 
> ============================================
> ida_free called for id=0 which is not allocated.
> WARNING: CPU: 14 PID: 926 at lib/idr.c:525 ida_free+0x134/0x140
> Modules linked in:
> CPU: 14 PID: 926 Comm: mount Not tainted 6.9.0-rc3-dirty #630
> RIP: 0010:ida_free+0x134/0x140
> Call Trace:
>  <TASK>
>  erofs_kill_sb+0x81/0x90
>  deactivate_locked_super+0x35/0x80
>  get_tree_bdev+0x136/0x1e0
>  vfs_get_tree+0x2c/0xf0
>  do_new_mount+0x190/0x2f0
>  [...]
> ============================================
> 
> Instead of allocating the erofs_sb_info in fill_super() allocate it
> during erofs_get_tree() and ensure that erofs can always have the info
> available during erofs_kill_sb().


I'm not sure if allocating erofs_sb_info in erofs_init_fs_context() will
be better, as I see some filesystems (e.g. autofs) do this way.  Maybe
another potential advantage of doing this way is that erofs_fs_context
is not needed anymore and we can use sbi directly.


> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
> Changes since v1:
>   Allocate and initialise fc->s_fs_info in erofs_fc_get_tree() instead of
>   modifying fc->sb_flags.
> 
> V1: https://lore.kernel.org/r/20240415121746.1207242-1-libaokun1@huawei.com/
> 
>  fs/erofs/super.c | 51 ++++++++++++++++++++++++++----------------------
>  1 file changed, 28 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index b21bd8f78dc1..4104280be2ea 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -581,8 +581,7 @@ static const struct export_operations erofs_export_ops = {
>  static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  {
>  	struct inode *inode;
> -	struct erofs_sb_info *sbi;
> -	struct erofs_fs_context *ctx = fc->fs_private;
> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
>  	int err;
>  
>  	sb->s_magic = EROFS_SUPER_MAGIC;
> @@ -590,19 +589,6 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  	sb->s_maxbytes = MAX_LFS_FILESIZE;
>  	sb->s_op = &erofs_sops;
>  
> -	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
> -	if (!sbi)
> -		return -ENOMEM;
> -
> -	sb->s_fs_info = sbi;
> -	sbi->opt = ctx->opt;
> -	sbi->devs = ctx->devs;
> -	ctx->devs = NULL;
> -	sbi->fsid = ctx->fsid;
> -	ctx->fsid = NULL;
> -	sbi->domain_id = ctx->domain_id;
> -	ctx->domain_id = NULL;
> -
>  	sbi->blkszbits = PAGE_SHIFT;
>  	if (erofs_is_fscache_mode(sb)) {
>  		sb->s_blocksize = PAGE_SIZE;
> @@ -704,11 +690,32 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  	return 0;
>  }
>  
> -static int erofs_fc_get_tree(struct fs_context *fc)
> +static void erofs_ctx_to_info(struct fs_context *fc)
>  {
>  	struct erofs_fs_context *ctx = fc->fs_private;
> +	struct erofs_sb_info *sbi = fc->s_fs_info;
> +
> +	sbi->opt = ctx->opt;
> +	sbi->devs = ctx->devs;
> +	ctx->devs = NULL;
> +	sbi->fsid = ctx->fsid;
> +	ctx->fsid = NULL;
> +	sbi->domain_id = ctx->domain_id;
> +	ctx->domain_id = NULL;
> +}

I'm not sure if abstracting this logic into a seperate helper really
helps understanding the code as the logic itself is quite simple and
easy to be understood. Usually it's a hint of over-abstraction when a
simple helper has only one caller.


>  
> -	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && ctx->fsid)
> +static int erofs_fc_get_tree(struct fs_context *fc)
> +{
> +	struct erofs_sb_info *sbi;
> +
> +	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
> +	if (!sbi)
> +		return -ENOMEM;
> +
> +	fc->s_fs_info = sbi;
> +	erofs_ctx_to_info(fc);
> +
> +	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && sbi->fsid)
>  		return get_tree_nodev(fc, erofs_fc_fill_super);
>  
>  	return get_tree_bdev(fc, erofs_fc_fill_super);
> @@ -767,6 +774,7 @@ static void erofs_fc_free(struct fs_context *fc)
>  	kfree(ctx->fsid);
>  	kfree(ctx->domain_id);
>  	kfree(ctx);
> +	kfree(fc->s_fs_info);
>  }
>  
>  static const struct fs_context_operations erofs_context_ops = {
> @@ -783,6 +791,7 @@ static int erofs_init_fs_context(struct fs_context *fc)
>  	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
>  	if (!ctx)
>  		return -ENOMEM;
> +
>  	ctx->devs = kzalloc(sizeof(struct erofs_dev_context), GFP_KERNEL);
>  	if (!ctx->devs) {
>  		kfree(ctx);
> @@ -799,17 +808,13 @@ static int erofs_init_fs_context(struct fs_context *fc)
>  
>  static void erofs_kill_sb(struct super_block *sb)
>  {
> -	struct erofs_sb_info *sbi;
> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
>  
> -	if (erofs_is_fscache_mode(sb))
> +	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && sbi->fsid)
>  		kill_anon_super(sb);
>  	else
>  		kill_block_super(sb);
>  
> -	sbi = EROFS_SB(sb);
> -	if (!sbi)
> -		return;
> -
>  	erofs_free_dev_context(sbi->devs);
>  	fs_put_dax(sbi->dax_dev, NULL);
>  	erofs_fscache_unregister_fs(sb);

-- 
Thanks,
Jingbo
