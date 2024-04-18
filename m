Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 119748A9463
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Apr 2024 09:49:36 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uuWjR6cA;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VKqg1683Nz3cVD
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Apr 2024 17:49:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uuWjR6cA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VKqfv4v3rz3cQq
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Apr 2024 17:49:27 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 87F24CE174E;
	Thu, 18 Apr 2024 07:49:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DD70C113CC;
	Thu, 18 Apr 2024 07:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713426563;
	bh=tOG2QuI93DOp+bJmmh7Zv4ScyQbFEf3WUpu5J3kJgB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uuWjR6cAbT8LcS5lff1QDoZC0Ukf9nBlj4mip5mHsTLHK2j25/bWNM6431AzE9ibF
	 Ovz8qVbXyw6t7TlFv/fVQP2gjEbp+z/+TWbgO1p24c1wpXUt0rpd/nkrmGoWvZDWVg
	 yR2C68ee7ejaQl7qg9PGHkur6zfg6dgTWKDm0zJ8yCAhMzx4B2wGZel06VuE9Jq8hL
	 9bxrcGqnihH/TDu29vqW9mVtXLh5H5d/mr3D9In9S1OX933jTwErWPX2+knEw+g1Vp
	 l9caeyllnKGDx9LXGHMToilBAtveSxRUZfgtOQRpGLn+G/tdKFCPeglJIZuSeRfLXM
	 cpkoks1YgxRsQ==
Date: Thu, 18 Apr 2024 15:49:22 +0800
From: Gao Xiang <xiang@kernel.org>
To: Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH v2] erofs: reliably distinguish block based and fscache
 mode
Message-ID: <ZiDQgmN0hC2uIiPA@debian>
Mail-Followup-To: Baokun Li <libaokun1@huawei.com>,
	Jingbo Xu <jefflexu@linux.alibaba.com>,
	linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org,
	huyue2@coolpad.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
	linux-kernel@vger.kernel.org, yangerkun@huawei.com,
	houtao1@huawei.com
References: <20240417065513.3409744-1-libaokun1@huawei.com>
 <71e66b02-9c2b-4981-83e1-8af72d6c0975@linux.alibaba.com>
 <7fdf4bff-2d3d-bdc0-5446-caa58aeca314@huawei.com>
 <fb65c7d0-c348-409e-b977-07616d28b279@linux.alibaba.com>
 <48b21671-19ae-0dbd-96cd-7300fd600c9b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <48b21671-19ae-0dbd-96cd-7300fd600c9b@huawei.com>
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
Cc: brauner@kernel.org, yangerkun@huawei.com, linux-kernel@vger.kernel.org, huyue2@coolpad.com, viro@zeniv.linux.org.uk, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi,

On Thu, Apr 18, 2024 at 02:12:39PM +0800, Baokun Li wrote:
> On 2024/4/18 13:50, Jingbo Xu wrote:
> > 
> > On 4/18/24 11:36 AM, Baokun Li wrote:
> > > On 2024/4/18 10:16, Jingbo Xu wrote:
> > > > Hi Baokun,
> > > > 
> > > > Thanks for catching this and move forward fixing this!
> > > Hi Jingbo，
> > > 
> > > Thanks for your review！
> > > 
> > > > On 4/17/24 2:55 PM, Baokun Li wrote:
> > > > > When erofs_kill_sb() is called in block dev based mode, s_bdev may
> > > > > not have
> > > > > been initialised yet, and if CONFIG_EROFS_FS_ONDEMAND is enabled, it
> > > > > will
> > > > > be mistaken for fscache mode, and then attempt to free an anon_dev
> > > > > that has
> > > > > never been allocated, triggering the following warning:
> > > > > 
> > > > > ============================================
> > > > > ida_free called for id=0 which is not allocated.
> > > > > WARNING: CPU: 14 PID: 926 at lib/idr.c:525 ida_free+0x134/0x140
> > > > > Modules linked in:
> > > > > CPU: 14 PID: 926 Comm: mount Not tainted 6.9.0-rc3-dirty #630
> > > > > RIP: 0010:ida_free+0x134/0x140
> > > > > Call Trace:
> > > > >    <TASK>
> > > > >    erofs_kill_sb+0x81/0x90
> > > > >    deactivate_locked_super+0x35/0x80
> > > > >    get_tree_bdev+0x136/0x1e0
> > > > >    vfs_get_tree+0x2c/0xf0
> > > > >    do_new_mount+0x190/0x2f0
> > > > >    [...]
> > > > > ============================================
> > > > > 
> > > > > Instead of allocating the erofs_sb_info in fill_super() allocate it
> > > > > during erofs_get_tree() and ensure that erofs can always have the info
> > > > > available during erofs_kill_sb().
> > > > I'm not sure if allocating erofs_sb_info in erofs_init_fs_context() will
> > > > be better, as I see some filesystems (e.g. autofs) do this way.  Maybe
> > > > another potential advantage of doing this way is that erofs_fs_context
> > > > is not needed anymore and we can use sbi directly.
> > > Yes, except for some extra memory usage when remounting,
> > > this idea sounds great. Let me send a version of v3 to get rid
> > > of erofs_fs_context.
> > I'm not sure if Gao Xaing also prefers this.  I think it would be better
> > to wait and listen for his thoughts before we sending v3.
>  Okay, there's no rush on this.

I checked days ago, for example, XFS is also worked in this way.
And .reconfigure() needs to be carefully handled too.

> > > > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > > > Signed-off-by: Baokun Li <libaokun1@huawei.com>
> > > > > ---
> > > > > Changes since v1:
> > > > >     Allocate and initialise fc->s_fs_info in erofs_fc_get_tree()
> > > > > instead of
> > > > >     modifying fc->sb_flags.
> > > > > 
> > > > > V1:
> > > > > https://lore.kernel.org/r/20240415121746.1207242-1-libaokun1@huawei.com/
> > > > > 
> > > > >    fs/erofs/super.c | 51 ++++++++++++++++++++++++++----------------------
> > > > >    1 file changed, 28 insertions(+), 23 deletions(-)
> > > > > 
> > > > > diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> > > > > index b21bd8f78dc1..4104280be2ea 100644
> > > > > --- a/fs/erofs/super.c
> > > > > +++ b/fs/erofs/super.c
> > > > > @@ -581,8 +581,7 @@ static const struct export_operations
> > > > > erofs_export_ops = {
> > > > >    static int erofs_fc_fill_super(struct super_block *sb, struct
> > > > > fs_context *fc)
> > > > >    {
> > > > >        struct inode *inode;
> > > > > -    struct erofs_sb_info *sbi;
> > > > > -    struct erofs_fs_context *ctx = fc->fs_private;
> > > > > +    struct erofs_sb_info *sbi = EROFS_SB(sb);
> > > > >        int err;
> > > > >          sb->s_magic = EROFS_SUPER_MAGIC;
> > > > > @@ -590,19 +589,6 @@ static int erofs_fc_fill_super(struct
> > > > > super_block *sb, struct fs_context *fc)
> > > > >        sb->s_maxbytes = MAX_LFS_FILESIZE;
> > > > >        sb->s_op = &erofs_sops;
> > > > >    -    sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
> > > > > -    if (!sbi)
> > > > > -        return -ENOMEM;
> > > > > -
> > > > > -    sb->s_fs_info = sbi;
> > > > > -    sbi->opt = ctx->opt;
> > > > > -    sbi->devs = ctx->devs;
> > > > > -    ctx->devs = NULL;
> > > > > -    sbi->fsid = ctx->fsid;
> > > > > -    ctx->fsid = NULL;
> > > > > -    sbi->domain_id = ctx->domain_id;
> > > > > -    ctx->domain_id = NULL;
> > > > > -
> > > > >        sbi->blkszbits = PAGE_SHIFT;
> > > > >        if (erofs_is_fscache_mode(sb)) {
> > > > >            sb->s_blocksize = PAGE_SIZE;
> > > > > @@ -704,11 +690,32 @@ static int erofs_fc_fill_super(struct
> > > > > super_block *sb, struct fs_context *fc)
> > > > >        return 0;
> > > > >    }
> > > > >    -static int erofs_fc_get_tree(struct fs_context *fc)
> > > > > +static void erofs_ctx_to_info(struct fs_context *fc)
> > > > >    {
> > > > >        struct erofs_fs_context *ctx = fc->fs_private;
> > > > > +    struct erofs_sb_info *sbi = fc->s_fs_info;
> > > > > +
> > > > > +    sbi->opt = ctx->opt;
> > > > > +    sbi->devs = ctx->devs;
> > > > > +    ctx->devs = NULL;
> > > > > +    sbi->fsid = ctx->fsid;
> > > > > +    ctx->fsid = NULL;
> > > > > +    sbi->domain_id = ctx->domain_id;
> > > > > +    ctx->domain_id = NULL;
> > > > > +}
> > > > I'm not sure if abstracting this logic into a seperate helper really
> > > > helps understanding the code as the logic itself is quite simple and
> > > > easy to be understood. Usually it's a hint of over-abstraction when a
> > > > simple helper has only one caller.
> > > > 
> > > Static functions that have only one caller are compiled inline, so we
> > > don't have to worry about how that affects the code.
> > > 
> > > The reason these codes are encapsulated in a separate function is so
> > > that the code reader understands that these codes are integrated
> > > as a whole, and that we shouldn't have to move one or two of these
> > > lines individually.
> > > 
> > > But after we get rid of erofs_fs_context, those won't be needed
> > > anymore.
> > Yeah, I understand. It's only coding style concerns.
> > 
> > 
> > 
> Okay, thanks！

I'm fine to get rid of those (erofs_fs_context) as long as the codebase
is more clearer and simple.  BTW, for the current codebase, I also think
it's unneeded to have a separate helper called once without extra actual
meaning...

Thanks,
Gao Xiang

> 
> -- 
> With Best Regards,
> Baokun Li
