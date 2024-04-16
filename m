Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DAB8A6F1E
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Apr 2024 16:57:36 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dj6wlscH;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VJnFp2jvhz3vWy
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Apr 2024 00:57:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dj6wlscH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VJnFl4gRCz3d3Z
	for <linux-erofs@lists.ozlabs.org>; Wed, 17 Apr 2024 00:57:31 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8129261239;
	Tue, 16 Apr 2024 14:57:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D3BC113CE;
	Tue, 16 Apr 2024 14:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713279449;
	bh=2ZrW72WzRrY0N5TRxs1zbRaC2am+h0QMeFgESSX5EQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dj6wlscH+csyHTHkHZD4WNyc61GOKAuUagcLfrC4UlXULGJjbx/AF9ZIdCe8UoUki
	 mCYeW4MSX1CGMsMGaFhz07BUCbubD5NhQmaZGDhUYWCydAeiJkspzDanBugDjQbu2K
	 0ISvQ2TvOPoIwZ7MnulYxzz3As/xmzYhMy3NfIjK3qB6pPueo1/J8vcPSjblTY5tSo
	 vmw9j/bMH+MorJgKvcf2/HMewpDWaAE/KtKOfDHGXbiChX8eSTRzrcc+iP/lGg1zc/
	 ENUHJ4rHPcLzDX0zN7IWg3DbP1isy8Igt4UGthqGuu5RsTk9zk+YW3eiHDJVCtD9Ka
	 yp8Yl70KlRP2Q==
Date: Tue, 16 Apr 2024 22:57:27 +0800
From: Gao Xiang <xiang@kernel.org>
To: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
Subject: Re: [PATCH 2/8] erofs-utils: lib: prepare for later deferred work
Message-ID: <Zh6R12AWgaGhjpmG@debian>
Mail-Followup-To: Yifan Zhao <zhaoyifan@sjtu.edu.cn>,
	linux-erofs@lists.ozlabs.org
References: <20240416080419.32491-1-xiang@kernel.org>
 <20240416080419.32491-2-xiang@kernel.org>
 <559882e2-8b8d-4dd3-890e-63e9c998d200@sjtu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <559882e2-8b8d-4dd3-890e-63e9c998d200@sjtu.edu.cn>
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

Hi Yifan,

On Tue, Apr 16, 2024 at 07:58:30PM +0800, Yifan Zhao wrote:
> 
> On 4/16/24 4:04 PM, Gao Xiang wrote:
> > From: Gao Xiang <hsiangkao@linux.alibaba.com>
> > 
> > Split out ordered metadata operations and add the following helpers:
> > 
> >   - erofs_mkfs_jobfn()
> > 
> >   - erofs_mkfs_go()
> > 
> > to handle these mkfs job items for multi-threadding support.
> > 
> > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > ---
> >   lib/inode.c | 68 +++++++++++++++++++++++++++++++++++++++++++++--------
> >   1 file changed, 58 insertions(+), 10 deletions(-)
> > 
> > diff --git a/lib/inode.c b/lib/inode.c
> > index 55969d9..8ef0604 100644
> > --- a/lib/inode.c
> > +++ b/lib/inode.c
> > @@ -1133,6 +1133,57 @@ static int erofs_mkfs_handle_nondirectory(struct erofs_inode *inode)
> >   	return 0;
> >   }
> > +enum erofs_mkfs_jobtype {	/* ordered job types */
> > +	EROFS_MKFS_JOB_NDIR,
> > +	EROFS_MKFS_JOB_DIR,
> > +	EROFS_MKFS_JOB_DIR_BH,
> > +};
> > +
> > +struct erofs_mkfs_jobitem {
> > +	enum erofs_mkfs_jobtype type;
> > +	union {
> > +		struct erofs_inode *inode;
> > +	} u;
> > +};
> > +
> > +static int erofs_mkfs_jobfn(struct erofs_mkfs_jobitem *item)
> > +{
> > +	struct erofs_inode *inode = item->u.inode;
> > +	int ret;
> > +
> > +	if (item->type == EROFS_MKFS_JOB_NDIR)
> > +		return erofs_mkfs_handle_nondirectory(inode);
> > +
> > +	if (item->type == EROFS_MKFS_JOB_DIR) {
> > +		ret = erofs_prepare_inode_buffer(inode);
> > +		if (ret)
> > +			return ret;
> > +		inode->bh->op = &erofs_skip_write_bhops;
> > +		if (IS_ROOT(inode))
> > +			erofs_fixup_meta_blkaddr(inode);
> 
> I think this 2 line above does not exist in the logic replaced by
> `erofs_mkfs_jobfn`, should it appear in this patch, or need further
> explanation in the commit msg?

Because erofs_fixup_meta_blkaddr() needs to be called
strictly after erofs_prepare_inode_buffer(root) is
done, which allocates on-disk inode so NID is also
meaningful then.

But you're right. This part is not quite good, let me
think more about it.

Thanks,
Gao Xiang

> 
> 
> Thanks,
> 
> Yifan Zhao
