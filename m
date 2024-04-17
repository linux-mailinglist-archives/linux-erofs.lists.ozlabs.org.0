Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 506248A7AE9
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Apr 2024 05:11:56 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=X/lrgA20;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VK5Y60hKwz3dRp
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Apr 2024 13:11:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=X/lrgA20;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VK5Y23LMHz3brZ
	for <linux-erofs@lists.ozlabs.org>; Wed, 17 Apr 2024 13:11:50 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0CCAF6140D;
	Wed, 17 Apr 2024 03:11:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77300C113CE;
	Wed, 17 Apr 2024 03:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713323507;
	bh=UONd/W0nJEXdL+M6NCBHpupjmfaKOELcAVnYMGiHm5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X/lrgA202YESfUXdVr9ed/qonB7AzNsjISkdJ0ajEy3mR/ES4gQwQJsEQpalSTL7+
	 ZrP2jTYMff0sS4vPwoaxO7LJar5po5NUaS3p0p+MjBwLCfzFbiPgUMok69EwXqsMuU
	 XCZw34FvVoC7qCTNZFphpfnF58G6fr9sYBDpx/0d83Ucjm3maKFpiuzETFy3r1wpu9
	 +F6EDr1c4dyHnZp68OPod5mf3E8uheYZ+3mNbWlkR7UU/zRPaVWIaYzQMf1URHyA24
	 awzNGEVv4McX4Zqk5RHH/1TJ45/KKU9+m0S6nbkeX1ma440YqtXjqB8AV6KsvZtFDQ
	 OLTaOXv3osaEw==
Date: Wed, 17 Apr 2024 11:11:46 +0800
From: Gao Xiang <xiang@kernel.org>
To: Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH] erofs: set SB_NODEV sb_flags when mounting with fsid
Message-ID: <Zh898uJW0AFtE0Rk@debian>
Mail-Followup-To: Baokun Li <libaokun1@huawei.com>,
	Christian Brauner <brauner@kernel.org>, xiang@kernel.org,
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
 <Zh6QC0++kpUUL5nf@debian>
 <779ff32f-3f3b-c602-5da8-c88b361716ac@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <779ff32f-3f3b-c602-5da8-c88b361716ac@huawei.com>
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
Cc: Christian Brauner <brauner@kernel.org>, yangerkun@huawei.com, linux-kernel@vger.kernel.org, huyue2@coolpad.com, viro@zeniv.linux.org.uk, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Apr 17, 2024 at 10:59:53AM +0800, Baokun Li wrote:
> On 2024/4/16 22:49, Gao Xiang wrote:
> > On Tue, Apr 16, 2024 at 02:35:08PM +0200, Christian Brauner wrote:
> > > > > I'm not sure how to resolve it in EROFS itself, anyway...
> > > Instead of allocating the erofs_sb_info in fill_super() allocate it
> > > during erofs_get_tree() and then you can ensure that you always have the
> > > info you need available during erofs_kill_sb(). See the appended
> > > (untested) patch.
> > Hi Christian,
> > 
> > Yeah, that is a good way I think.  Although sbi will be allocated
> > unconditionally instead but that is minor.
> > 
> > I'm on OSSNA this week, will test this patch more when returning.
> > 
> > Hi Baokun,
> > 
> > Could you also check this on your side?
> > 
> > Thanks,
> > Gao Xiang
> Hi Xiang,
> 
> This patch does fix the initial problem.
> 
> 
> Hi Christian,
> 
> Thanks for the patch, this is a good idea. Just with nits below.
> Otherwise feel free to add.
> 
> Reviewed-and-tested-by: Baokun Li <libaokun1@huawei.com>
> > 
> > >  From e4f586a41748b6edc05aca36d49b7b39e55def81 Mon Sep 17 00:00:00 2001
> > > From: Christian Brauner <brauner@kernel.org>
> > > Date: Mon, 15 Apr 2024 20:17:46 +0800
> > > Subject: [PATCH] erofs: reliably distinguish block based and fscache mode
> > > 
> SNIP
> 
> > > 
> > > diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> > > index c0eb139adb07..4ed80154edf8 100644
> > > --- a/fs/erofs/super.c
> > > +++ b/fs/erofs/super.c
> > > @@ -581,7 +581,7 @@ static const struct export_operations erofs_export_ops = {
> > >   static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
> > >   {
> > >   	struct inode *inode;
> > > -	struct erofs_sb_info *sbi;
> > > +	struct erofs_sb_info *sbi = EROFS_SB(sb);
> > >   	struct erofs_fs_context *ctx = fc->fs_private;
> > >   	int err;
> > > @@ -590,15 +590,10 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
> > >   	sb->s_maxbytes = MAX_LFS_FILESIZE;
> > >   	sb->s_op = &erofs_sops;
> > > -	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
> > > -	if (!sbi)
> > > -		return -ENOMEM;
> > > -
> > >   	sb->s_fs_info = sbi;
> This line is no longer needed.
> > >   	sbi->opt = ctx->opt;
> > >   	sbi->devs = ctx->devs;
> > >   	ctx->devs = NULL;
> > > -	sbi->fsid = ctx->fsid;
> > >   	ctx->fsid = NULL;
> > >   	sbi->domain_id = ctx->domain_id;
> > >   	ctx->domain_id = NULL;
> Since erofs_sb_info is now allocated in erofs_fc_get_tree(), why not
> encapsulate the above lines as erofs_ctx_to_info() helper function
> to be called in erofs_fc_get_tree()？Then erofs_fc_fill_super() wouldn't
> have to use erofs_fs_context and would prevent the fsid from being
> freed twice.

Hi Baokun,

I'm not sure if Christian has enough time to polish the whole
codebase (I'm happy if do so).  Basically, that is just a hint
to the issue, if you have more time, I guess you could also help
revive this patch together (also because you also have a real
EROFS test environment).

Let me also check this next week after OSSNA travelling.

Thanks,
Gao Xiang
