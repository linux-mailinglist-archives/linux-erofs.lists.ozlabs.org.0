Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE558A6EEC
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Apr 2024 16:49:56 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BwJ6tVrV;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VJn4y16qvz3h05
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Apr 2024 00:49:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BwJ6tVrV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VJn4v0jxhz3c9r
	for <linux-erofs@lists.ozlabs.org>; Wed, 17 Apr 2024 00:49:51 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4185661229;
	Tue, 16 Apr 2024 14:49:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D70C113CE;
	Tue, 16 Apr 2024 14:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713278988;
	bh=slUT4zBHYjU9qi8tHgbYouEcTeqwtszCaEUoidxe348=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BwJ6tVrV6sLRveHEptvfeuji50XNganjw9kogO6idtAG3H8A9mSvncwvjCcmVfbFv
	 zTorwrpg9izqbjDm7SieTN/cb04YaKvWKn1by/rFzilt25q8cpJ1wZF+tIMBeA/U/B
	 UDXo9tIxYZb14rYbyO7KNFwbsyEgFfxBA5MDYw6O0a60pZHbNwdSMBS6oXVFydoPTi
	 9yIO+eUUOnaIHyhyIGxWx8vwo3kfJMFqVfbgANJ2M/va34gBiSExNvUTPHtdlRXmkn
	 wxi/FQwGYetQWXOU1gAsMir3XyQVjtFJUCjqdWqtwpbs2oFMLongmOukuOkXzABxkV
	 MxXrw2JZHDrSw==
Date: Tue, 16 Apr 2024 22:49:47 +0800
From: Gao Xiang <xiang@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] erofs: set SB_NODEV sb_flags when mounting with fsid
Message-ID: <Zh6QC0++kpUUL5nf@debian>
Mail-Followup-To: Christian Brauner <brauner@kernel.org>,
	Baokun Li <libaokun1@huawei.com>, xiang@kernel.org,
	linux-erofs@lists.ozlabs.org, chao@kernel.org, huyue2@coolpad.com,
	jefflexu@linux.alibaba.com, viro@zeniv.linux.org.uk,
	linux-kernel@vger.kernel.org, yangerkun@huawei.com,
	houtao1@huawei.com
References: <20240415121746.1207242-1-libaokun1@huawei.com>
 <20240415-betagten-querlatte-feb727ed56c1@brauner>
 <15ab9875-5123-7bc2-bb25-fc683129ad9e@huawei.com>
 <Zh3NAgWvNASTZSea@debian>
 <e70a28b4-074e-c48a-b717-3e17f1aae61d@huawei.com>
 <20240416-blumig-dachgeschoss-bc683f4ef1bf@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240416-blumig-dachgeschoss-bc683f4ef1bf@brauner>
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
Cc: yangerkun@huawei.com, linux-kernel@vger.kernel.org, huyue2@coolpad.com, viro@zeniv.linux.org.uk, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Apr 16, 2024 at 02:35:08PM +0200, Christian Brauner wrote:
> > > I'm not sure how to resolve it in EROFS itself, anyway...
> 
> Instead of allocating the erofs_sb_info in fill_super() allocate it
> during erofs_get_tree() and then you can ensure that you always have the
> info you need available during erofs_kill_sb(). See the appended
> (untested) patch.

Hi Christian,

Yeah, that is a good way I think.  Although sbi will be allocated
unconditionally instead but that is minor.

I'm on OSSNA this week, will test this patch more when returning.

Hi Baokun,

Could you also check this on your side?

Thanks,
Gao Xiang


> From e4f586a41748b6edc05aca36d49b7b39e55def81 Mon Sep 17 00:00:00 2001
> From: Christian Brauner <brauner@kernel.org>
> Date: Mon, 15 Apr 2024 20:17:46 +0800
> Subject: [PATCH] erofs: reliably distinguish block based and fscache mode
> 
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
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/erofs/super.c | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index c0eb139adb07..4ed80154edf8 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -581,7 +581,7 @@ static const struct export_operations erofs_export_ops = {
>  static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  {
>  	struct inode *inode;
> -	struct erofs_sb_info *sbi;
> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
>  	struct erofs_fs_context *ctx = fc->fs_private;
>  	int err;
>  
> @@ -590,15 +590,10 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  	sb->s_maxbytes = MAX_LFS_FILESIZE;
>  	sb->s_op = &erofs_sops;
>  
> -	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
> -	if (!sbi)
> -		return -ENOMEM;
> -
>  	sb->s_fs_info = sbi;
>  	sbi->opt = ctx->opt;
>  	sbi->devs = ctx->devs;
>  	ctx->devs = NULL;
> -	sbi->fsid = ctx->fsid;
>  	ctx->fsid = NULL;
>  	sbi->domain_id = ctx->domain_id;
>  	ctx->domain_id = NULL;
> @@ -707,8 +702,15 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  static int erofs_fc_get_tree(struct fs_context *fc)
>  {
>  	struct erofs_fs_context *ctx = fc->fs_private;
> +	struct erofs_sb_info *sbi;
> +
> +	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
> +	if (!sbi)
> +		return -ENOMEM;
>  
> -	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && ctx->fsid)
> +	fc->s_fs_info = sbi;
> +	sbi->fsid = ctx->fsid;
> +	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && sbi->fsid)
>  		return get_tree_nodev(fc, erofs_fc_fill_super);
>  
>  	return get_tree_bdev(fc, erofs_fc_fill_super);
> @@ -762,11 +764,15 @@ static void erofs_free_dev_context(struct erofs_dev_context *devs)
>  static void erofs_fc_free(struct fs_context *fc)
>  {
>  	struct erofs_fs_context *ctx = fc->fs_private;
> +	struct erofs_sb_info *sbi = fc->s_fs_info;
>  
>  	erofs_free_dev_context(ctx->devs);
>  	kfree(ctx->fsid);
>  	kfree(ctx->domain_id);
>  	kfree(ctx);
> +
> +	if (sbi)
> +		kfree(sbi);
>  }
>  
>  static const struct fs_context_operations erofs_context_ops = {
> @@ -783,6 +789,7 @@ static int erofs_init_fs_context(struct fs_context *fc)
>  	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
>  	if (!ctx)
>  		return -ENOMEM;
> +
>  	ctx->devs = kzalloc(sizeof(struct erofs_dev_context), GFP_KERNEL);
>  	if (!ctx->devs) {
>  		kfree(ctx);
> @@ -799,17 +806,13 @@ static int erofs_init_fs_context(struct fs_context *fc)
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
> -- 
> 2.43.0
> 

