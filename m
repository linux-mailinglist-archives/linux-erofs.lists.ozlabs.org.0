Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E0E5518AC
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Jun 2022 14:20:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LRTHZ25J9z3bv2
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Jun 2022 22:20:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.56; helo=out30-56.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LRTHR1Cwbz3blT
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 Jun 2022 22:20:00 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VGx.DGq_1655727584;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VGx.DGq_1655727584)
          by smtp.aliyun-inc.com;
          Mon, 20 Jun 2022 20:19:45 +0800
Date: Mon, 20 Jun 2022 20:19:44 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: hongnanLi <hongnan.li@linux.alibaba.com>
Subject: Re: [PATCH v2] erofs: update ctx->pos for every emitted dirent
Message-ID: <YrBl4CMZUiO6YqNM@B-P7TQMD6M-0146.local>
References: <20220527072536.68516-1-hongnan.li@linux.alibaba.com>
 <20220609034006.76649-1-hongnan.li@linux.alibaba.com>
 <0c139517-e976-5017-8e7a-d34c38f0f6bb@kernel.org>
 <70fe93a3-7af5-b563-dcb7-3f7be81348ed@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70fe93a3-7af5-b563-dcb7-3f7be81348ed@linux.alibaba.com>
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Hongnan,

On Mon, Jun 20, 2022 at 05:37:07PM +0800, hongnanLi wrote:
> on 2022/6/19 8:19, Chao Yu wrote:
> > On 2022/6/9 11:40, Hongnan Li wrote:
> > > erofs_readdir update ctx->pos after filling a batch of dentries
> > > and it may cause dir/files duplication for NFS readdirplus which
> > > depends on ctx->pos to fill dir correctly. So update ctx->pos for
> > > every emitted dirent in erofs_fill_dentries to fix it.
> > > 
> > > Fixes: 3e917cc305c6 ("erofs: make filesystem exportable")
> > > Signed-off-by: Hongnan Li <hongnan.li@linux.alibaba.com>
> > > ---
> > >   fs/erofs/dir.c | 20 ++++++++++----------
> > >   1 file changed, 10 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
> > > index 18e59821c597..94ef5287237a 100644
> > > --- a/fs/erofs/dir.c
> > > +++ b/fs/erofs/dir.c
> > > @@ -22,10 +22,9 @@ static void debug_one_dentry(unsigned char
> > > d_type, const char *de_name,
> > >   }
> > >   static int erofs_fill_dentries(struct inode *dir, struct
> > > dir_context *ctx,
> > > -                   void *dentry_blk, unsigned int *ofs,
> > > +                   void *dentry_blk, struct erofs_dirent *de,
> > >                      unsigned int nameoff, unsigned int maxsize)
> > >   {
> > > -    struct erofs_dirent *de = dentry_blk + *ofs;
> > >       const struct erofs_dirent *end = dentry_blk + nameoff;
> > >       while (de < end) {
> > > @@ -59,9 +58,8 @@ static int erofs_fill_dentries(struct inode *dir,
> > > struct dir_context *ctx,
> > >               /* stopped by some reason */
> > >               return 1;
> > >           ++de;
> > > -        *ofs += sizeof(struct erofs_dirent);
> > > +        ctx->pos += sizeof(struct erofs_dirent);
> > >       }
> > > -    *ofs = maxsize;
> > >       return 0;
> > >   }
> > > @@ -95,7 +93,7 @@ static int erofs_readdir(struct file *f, struct
> > > dir_context *ctx)
> > >                     "invalid de[0].nameoff %u @ nid %llu",
> > >                     nameoff, EROFS_I(dir)->nid);
> > >               err = -EFSCORRUPTED;
> > > -            goto skip_this;
> > > +            break;
> > >           }
> > >           maxsize = min_t(unsigned int,
> > > @@ -106,17 +104,19 @@ static int erofs_readdir(struct file *f,
> > > struct dir_context *ctx)
> > >               initial = false;
> > >               ofs = roundup(ofs, sizeof(struct erofs_dirent));
> > > -            if (ofs >= nameoff)
> > > +            if (ofs >= nameoff) {
> > > +                ctx->pos = blknr_to_addr(i) + ofs;
> > >                   goto skip_this;
> > > +            }
> > >           }
> > > -        err = erofs_fill_dentries(dir, ctx, de, &ofs,
> > > -                      nameoff, maxsize);
> > > -skip_this:
> > >           ctx->pos = blknr_to_addr(i) + ofs;
> > 
> > Why updating ctx->pos before erofs_fill_dentries()?
> > 
> > Thanks,
> 
> It’s to ensure the ctx->pos is correct and up to date in
> erofs_fill_dentries() so that we can update ctx->pos instead of ofs for
> every emitted dirent.
> 

How about this, since blknr_to_addr(i) + maxsize should be the start of
the next dir block.

	if (initial) {
		ofs = roundup(ofs, sizeof(struct erofs_dirent));
		ctx->pos = blknr_to_addr(i) + ofs;
		if (ofs >= nameoff)
			goto skip_this;
	}
	err = erofs_fill_dentries(dir, ctx, de, (void *)de + ofs,
				  nameoff, maxsize);
	if (err)
		break;
	ctx->pos = blknr_to_addr(i) + maxsize;

Thanks,
Gao Xiang
