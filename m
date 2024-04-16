Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 899EE8A5F80
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Apr 2024 02:57:54 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MAPfjboq;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VJQcs40z3z3dKG
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Apr 2024 10:57:49 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MAPfjboq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VJQck6rxxz3cRd
	for <linux-erofs@lists.ozlabs.org>; Tue, 16 Apr 2024 10:57:42 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id CE37860EF0;
	Tue, 16 Apr 2024 00:57:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4398FC113CC;
	Tue, 16 Apr 2024 00:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713229060;
	bh=e+mZ8gSzLwQyrTBa4o3G3i7rgdxAvvnf8ZmX93KlrW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MAPfjboqItuLZRgArjOyRoVElAn/2mJFMZi1IqSXjmlOVjdECxiubReZqWyREN+oy
	 MC2KnpMq96rgwh4houoreP/85lJPdcFWxbyQMWKR2NvZruAp11HegcpIPkDKLT9F4A
	 lIKuvOP5wzhl8sx6zWdEfyZtv8CjfQqUcif9TtwlQH6zvRA3lAJCMqXxYqLhS6x3+S
	 bAN4tH+t+H6KRiMQbmHOshcr5JKBCFBbSWanTf4q7iS/KDQX/CAE58WUZTW7y1nyPy
	 CvWNSa6xiZmd2l8SJh0470bR67G4OiGXUEb3hxvaSgOvuYeXsP2adwiO/qpINC4kN5
	 P1Gq+kWKLykEw==
Date: Tue, 16 Apr 2024 08:57:38 +0800
From: Gao Xiang <xiang@kernel.org>
To: Baokun Li <libaokun1@huawei.com>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] erofs: set SB_NODEV sb_flags when mounting with fsid
Message-ID: <Zh3NAgWvNASTZSea@debian>
Mail-Followup-To: Baokun Li <libaokun1@huawei.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org,
	huyue2@coolpad.com, jefflexu@linux.alibaba.com,
	viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
	yangerkun@huawei.com, houtao1@huawei.com
References: <20240415121746.1207242-1-libaokun1@huawei.com>
 <20240415-betagten-querlatte-feb727ed56c1@brauner>
 <15ab9875-5123-7bc2-bb25-fc683129ad9e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <15ab9875-5123-7bc2-bb25-fc683129ad9e@huawei.com>
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

Hi Christian, Baokun,

On Mon, Apr 15, 2024 at 11:23:58PM +0800, Baokun Li wrote:
> On 2024/4/15 21:38, Christian Brauner wrote:
> > On Mon, Apr 15, 2024 at 08:17:46PM +0800, Baokun Li wrote:
> > > When erofs_kill_sb() is called in block dev based mode, s_bdev may not have
> > > been initialised yet, and if CONFIG_EROFS_FS_ONDEMAND is enabled, it will
> > > be mistaken for fscache mode, and then attempt to free an anon_dev that has
> > > never been allocated, triggering the following warning:
> > > 
> > > ============================================
> > > ida_free called for id=0 which is not allocated.
> > > WARNING: CPU: 14 PID: 926 at lib/idr.c:525 ida_free+0x134/0x140
> > > Modules linked in:
> > > CPU: 14 PID: 926 Comm: mount Not tainted 6.9.0-rc3-dirty #630
> > > RIP: 0010:ida_free+0x134/0x140
> > > Call Trace:
> > >   <TASK>
> > >   erofs_kill_sb+0x81/0x90
> > >   deactivate_locked_super+0x35/0x80
> > >   get_tree_bdev+0x136/0x1e0
> > >   vfs_get_tree+0x2c/0xf0
> > >   do_new_mount+0x190/0x2f0
> > >   [...]
> > > ============================================
> > > 
> > > To avoid this problem, add SB_NODEV to fc->sb_flags after successfully
> > > parsing the fsid, and then the superblock inherits this flag when it is
> > > allocated, so that the sb_flags can be used to distinguish whether it is
> > > in block dev based mode when calling erofs_kill_sb().
> > > 
> > > Signed-off-by: Baokun Li <libaokun1@huawei.com>
> > > ---
> > >   fs/erofs/super.c | 7 +++----
> > >   1 file changed, 3 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> > > index b21bd8f78dc1..7539ce7d64bc 100644
> > > --- a/fs/erofs/super.c
> > > +++ b/fs/erofs/super.c
> > > @@ -520,6 +520,7 @@ static int erofs_fc_parse_param(struct fs_context *fc,
> > >   		ctx->fsid = kstrdup(param->string, GFP_KERNEL);
> > >   		if (!ctx->fsid)
> > >   			return -ENOMEM;
> > > +		fc->sb_flags |= SB_NODEV;
> > Hm, I wouldn't do it this way. That's an abuse of that flag imho.
> > Record the information in the erofs_fs_context if you need to.
> The stack diagram that triggers the problem is as follows, the call to
> erofs_kill_sb() fails before fill_super() has been executed, and we can
> only use super_block to determine whether it is currently in nodev
> fscahe mode or block device based mode. So if it is recorded in
> erofs_fs_context (aka fc->fs_private), we can't access the recorded data
> unless we pass fc into erofs_kill_sb() as well.
> 

If I understand correctly, from the discussion above, I think
there exists a gap between alloc_super() and sb->s_bdev is set.
But .kill_sb() can be called between them and fc is not passed
into .kill_sb().

I'm not sure how to resolve it in EROFS itself, anyway...

Thanks,
Gao Xiang
