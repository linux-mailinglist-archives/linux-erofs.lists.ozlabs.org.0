Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBC6641716
	for <lists+linux-erofs@lfdr.de>; Sat,  3 Dec 2022 14:41:14 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NPWDS59SHz3bcT
	for <lists+linux-erofs@lfdr.de>; Sun,  4 Dec 2022 00:41:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XH2wVCtJ;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XH2wVCtJ;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NPWDM1n16z30Qq
	for <linux-erofs@lists.ozlabs.org>; Sun,  4 Dec 2022 00:41:07 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 02094B80188;
	Sat,  3 Dec 2022 13:41:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE19CC433C1;
	Sat,  3 Dec 2022 13:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670074861;
	bh=lC3cJFofR+zhCmLhUsHeRFJ6ctKIcQkmqm79H+YLWlc=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=XH2wVCtJYOCFs6yyHoyLeHaMoThm7IW3y/yb+kk5N0EKl6Uqd+0U2VRdRHquXrNuT
	 q8BwMWOL6tJfsHdNNCNVkAWCLhJ/92PecS45JNwjR45/PDVSNQ+R6SYOrJQTtXkyj3
	 zf5HDURt1VjLARMpIUN49JYWwobQ2WBL8+odTF0p2DTNZguaU9qP6nvdL1iPUE22Rs
	 jKOFc+XB7AW7XFQwTX6AYIkLfrrkPZdKyB+gLPmbiQA8z8kDT5KwNTB2XvHLAbeagX
	 I9QIKD52Zfg3O6bwIl2D4LjjcAxhcTEaHci55TbGDiDeOp7pdhULxGwRErT6DYWSHW
	 4/6hbYLwnulug==
Date: Sat, 3 Dec 2022 21:40:55 +0800
From: Gao Xiang <xiang@kernel.org>
To: Chen Zhongjin <chenzhongjin@huawei.com>,
	syzbot+6f8cd9a0155b366d227f@syzkaller.appspotmail.com,
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
	jefflexu@linux.alibaba.com
Subject: Re: [PATCH] erofs: Fix pcluster become inline when m_pa is zero
Message-ID: <Y4tR52dEWMhRMC2C@debian>
Mail-Followup-To: Chen Zhongjin <chenzhongjin@huawei.com>,
	syzbot+6f8cd9a0155b366d227f@syzkaller.appspotmail.com,
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
	jefflexu@linux.alibaba.com
References: <20221203094527.129869-1-chenzhongjin@huawei.com>
 <Y4tNEUupN/1/AFOW@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y4tNEUupN/1/AFOW@debian>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, Dec 03, 2022 at 09:20:17PM +0800, Gao Xiang wrote:
> Hi Zhongjin,
> 
> On Sat, Dec 03, 2022 at 05:45:27PM +0800, Chen Zhongjin wrote:
> > syzkaller reported a memleak:
> > https://syzkaller.appspot.com/bug?id=62f37ff612f0021641eda5b17f056f1668aa9aed
> > 
> > unreferenced object 0xffff88811009c7f8 (size 136):
> >   ...
> >   backtrace:
> >     [<ffffffff821db19b>] z_erofs_do_read_page+0x99b/0x1740
> >     [<ffffffff821dee9e>] z_erofs_readahead+0x24e/0x580
> >     [<ffffffff814bc0d6>] read_pages+0x86/0x3d0
> >     ...
> > 
> > syzkaller constructed a case: in z_erofs_register_pcluster(),
> > ztailpacking = false and map->m_pa = zero. This makes pcl->obj.index
> > become zero although pcl is not an inline pcluster.
> 
> Thanks for the patch!
> 
> We should just fail out if map->m_pa / EROFS_BLKSIZ == 0.
> 
> > 
> > Then following path adds refcount for grp, but the it won't be put
> > because pcl is inline, which makes pcl not released when shrink.
> > 
> > z_erofs_readahead()
> >   z_erofs_do_read_page() # for another page
> >     z_erofs_collector_begin()
> >       erofs_find_workgroup()
> >         erofs_workgroup_get()
> > 
> > To fix this, add an attribute in z_erofs_pcluster to mark the inline
> > state which not depends on index of grp.
> 
> I think the main reason is "inline pcluster _always_ did memory leak
> before since I don't find any chance to these free inline pclusters
> in the current codebase.
> 
> Actually I submitted a patch for this, could you check/review this
> if possible?
> https://lore.kernel.org/r/20221202033327.52702-1-hsiangkao@linux.alibaba.com

Oh, I just realized my patch may be incorrect, I think we need to
just fail out this (since m_pblk == 0 cannot be a real pcluster,
since it has on-disk super block at least):

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index ab22100be861..e14e6c32e70d 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -496,7 +496,8 @@ static int z_erofs_register_pcluster(struct
z_erofs_decompress_frontend *fe)
 	struct erofs_workgroup *grp;
 	int err;
 
-	if (!(map->m_flags & EROFS_MAP_ENCODED)) {
+	if (!(map->m_flags & EROFS_MAP_ENCODED) ||
+	    !(map->m_pa >> PAGE_SHIFT)) {
 		DBG_BUGON(1);
 		return -EFSCORRUPTED;


Could you resend next version behaving like the above?

Thanks,
Gao Xiang

> 
> Thanks,
> Gao Xiang
> 
> > 
> > Fixes: cecf864d3d76 ("erofs: support inline data decompression")
> > Reported-by: syzbot+6f8cd9a0155b366d227f@syzkaller.appspotmail.com
> > Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
> > ---
> >  fs/erofs/zdata.c | 2 +-
> >  fs/erofs/zdata.h | 5 ++++-
> >  2 files changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> > index b792d424d774..fef2624d19e3 100644
> > --- a/fs/erofs/zdata.c
> > +++ b/fs/erofs/zdata.c
> > @@ -517,7 +517,7 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
> >  	DBG_BUGON(!mutex_trylock(&pcl->lock));
> >  
> >  	if (ztailpacking) {
> > -		pcl->obj.index = 0;	/* which indicates ztailpacking */
> > +		pcl->is_inline = true;  /* which indicates ztailpacking */
> >  		pcl->pageofs_in = erofs_blkoff(map->m_pa);
> >  		pcl->tailpacking_size = map->m_plen;
> >  	} else {
> > diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
> > index d98c95212985..35051ad27521 100644
> > --- a/fs/erofs/zdata.h
> > +++ b/fs/erofs/zdata.h
> > @@ -78,6 +78,9 @@ struct z_erofs_pcluster {
> >  		unsigned short tailpacking_size;
> >  	};
> >  
> > +	/* I:  whether it is inline or not */
> > +	bool is_inline;
> > +
> >  	/* I: compression algorithm format */
> >  	unsigned char algorithmformat;
> >  
> > @@ -115,7 +118,7 @@ struct z_erofs_decompressqueue {
> >  
> >  static inline bool z_erofs_is_inline_pcluster(struct z_erofs_pcluster *pcl)
> >  {
> > -	return !pcl->obj.index;
> > +	return pcl->is_inline;
> >  }
> >  
> >  static inline unsigned int z_erofs_pclusterpages(struct z_erofs_pcluster *pcl)
> > -- 
> > 2.17.1
> > 
