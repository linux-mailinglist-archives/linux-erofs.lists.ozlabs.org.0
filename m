Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B72AC769692
	for <lists+linux-erofs@lfdr.de>; Mon, 31 Jul 2023 14:43:50 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QQib0nQA;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RDybS4Ynkz30M1
	for <lists+linux-erofs@lfdr.de>; Mon, 31 Jul 2023 22:43:48 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QQib0nQA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RDybL3rRKz2yw0
	for <linux-erofs@lists.ozlabs.org>; Mon, 31 Jul 2023 22:43:42 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 7029160909;
	Mon, 31 Jul 2023 12:43:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD173C433C8;
	Mon, 31 Jul 2023 12:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690807418;
	bh=EJYQmky5MRQWTs/BzAO6qxitvyCrK779971jP7CGnMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QQib0nQAlua30FPPY+CgnForzZCp0adBhrIDFMwqUnm+OcklNSq1YjanT0axZ8Xc6
	 eSC/Mf0F2nnX3QNMBzATOwqQubXDFvHWjig7fbnLPueuYLZpS3wHyQHMQHQ9OzwogC
	 AwCJ+I0libuB3dz+lUjrMpUNlIJIwGnpuAaUP4HhZcZkCP0e1vw9QPM1kRhqQ5VrVD
	 A3DWwLek2OnG4hCUNl7Bj+bguc0YyPIAqCq0KKfgY38kgbS4AqR3B+l8ChNP2mWomZ
	 aduUaCu6TDn1Mvip2q09x+j1/JvMGSCLtKuKz3BIvHrD2/+h/rtOmFUd+/ZjZbsVrd
	 7q4USvLDI/8jg==
Date: Mon, 31 Jul 2023 14:43:33 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [syzbot] [erofs?] [fat?] WARNING in erofs_kill_sb
Message-ID: <20230731-augapfel-penibel-196c3453f809@brauner>
References: <000000000000f43cab0601c3c902@google.com>
 <20230731093744.GA1788@lst.de>
 <9b57e5f7-62b6-fd65-4dac-a71c9dc08abc@linux.alibaba.com>
 <20230731111622.GA3511@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230731111622.GA3511@lst.de>
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
Cc: jack@suse.cz, syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, huyue2@coolpad.com, syzbot <syzbot+69c477e882e44ce41ad9@syzkaller.appspotmail.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, sj1557.seo@samsung.com, linux-erofs@lists.ozlabs.org, linkinjeon@kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Jul 31, 2023 at 01:16:22PM +0200, Christoph Hellwig wrote:
> On Mon, Jul 31, 2023 at 06:58:14PM +0800, Gao Xiang wrote:
> > Previously, deactivate_locked_super() or .kill_sb() will only be
> > called after fill_super is called, and .s_magic will be set at
> > the very beginning of erofs_fc_fill_super().
> >
> > After ("fs: open block device after superblock creation"), such
> > convension is changed now.  Yet at a quick glance,
> >
> > WARN_ON(sb->s_magic != EROFS_SUPER_MAGIC);
> >
> > in erofs_kill_sb() can be removed since deactivate_locked_super()
> > will also be called if setup_bdev_super() is falled.  I'd suggest
> > that removing this WARN_ON() in the related commit, or as
> > a following commit of the related branch of the pull request if
> > possible.
> 
> Agreed.  I wonder if we should really call into ->kill_sb before
> calling into fill_super, but I need to carefull look into the
> details.

I think checking for s_magic in erofs kill sb is wrong as it introduces
a dependency on both fill_super() having been called and that s_magic is
initialized first. If someone reorders erofs_kill_sb() such that s_magic
is only filled in once everything else succeeded it would cause the same
bug. That doesn't sound nice to me.

I think ->fill_super() should only be called after successfull
superblock allocation and after the device has been successfully opened.
Just as this code does now. So ->kill_sb() should only be called after
we're guaranteed that ->fill_super() has been called.

We already mostly express that logic through the fs_context object.
Anything that's allocated in fs_context->init_fs_context() is freed in
fs_context->free() before fill_super() is called. After ->fill_super()
is called fs_context->s_fs_info will have been transferred to
sb->s_fs_info and will have to be killed via ->kill_sb().

Does that make sense?
