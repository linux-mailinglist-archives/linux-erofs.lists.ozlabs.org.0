Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9B263D154
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Nov 2022 10:02:41 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NMYBR4GcKz3bVf
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Nov 2022 20:02:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.56; helo=out30-56.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NMYBN1P30z2ybK
	for <linux-erofs@lists.ozlabs.org>; Wed, 30 Nov 2022 20:02:35 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VW2Gp4j_1669798948;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VW2Gp4j_1669798948)
          by smtp.aliyun-inc.com;
          Wed, 30 Nov 2022 17:02:30 +0800
Date: Wed, 30 Nov 2022 17:02:27 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: [PATCH v3] erofs-utils: mkfs: support fragment deduplication
Message-ID: <Y4ccIxv5HfVWTQAe@B-P7TQMD6M-0146.local>
References: <20221129100053.10665-1-zbestahu@gmail.com>
 <Y4cTKeWowrg9FySM@B-P7TQMD6M-0146.local>
 <20221130165534.00004006.zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221130165534.00004006.zbestahu@gmail.com>
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
Cc: Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, zbestahu@163.com, shaojunjun@coolpad.com, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Nov 30, 2022 at 04:55:34PM +0800, Yue Hu wrote:

...

> > > @@ -782,22 +846,25 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
> > >  	ctx.head = ctx.tail = 0;
> > >  	ctx.clusterofs = 0;
> > >  	ctx.e.length = 0;
> > > -	remaining = inode->i_size;
> > > +	ctx.e.compressedblks = 0;
> > > +	ctx.pclustersize = z_erofs_get_max_pclusterblks(inode) * EROFS_BLKSIZ;
> > > +	ctx.remaining = inode->i_size - inode->fragment_size;
> > >  
> > > -	while (remaining) {
> > > -		const u64 readcount = min_t(u64, remaining,
> > > +	while (ctx.remaining) {
> > > +		const u64 readcount = min_t(u64, ctx.remaining,
> > >  					    sizeof(ctx.queue) - ctx.tail);
> > > +		bool fixup = ret < 0;  
> > 
> > 	drop this one;
> > 
> > >  
> > >  		ret = read(fd, ctx.queue + ctx.tail, readcount);
> > >  		if (ret != readcount) {
> > >  			ret = -errno;
> > >  			goto err_bdrop;
> > >  		}
> > > -		remaining -= readcount;
> > > +		ctx.remaining -= readcount;
> > >  		ctx.tail += readcount;
> > >  
> > > -		ret = vle_compress_one(&ctx, !remaining);  
> > 
> > 					     ret == -EAGAIN
> 
> Just move 'fixup' in 'ctx'?

Yes.

> 
> > 
> > > -		if (ret)
> > > +		ret = vle_compress_one(&ctx, fixup);
> > > +		if (ret && ret != -EAGAIN)
> > >  			goto err_free_idata;
> > >  	}
> > >  	DBG_BUGON(ctx.head != ctx.tail);
> > > @@ -807,6 +874,16 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
> > >  	DBG_BUGON(compressed_blocks < !!inode->idata_size);
> > >  	compressed_blocks -= !!inode->idata_size;
> > >  
> > > +	if (inode->fragment_size && ctx.e.compressedblks) {  
> > 
> > why not moving into z_erofs_fragments_dedupe_update()?
> 
> I consider this before, it's a bit awkward for me due to non updating case.
> 
> Let me reconsider.

What does that mean? "non updating case", could you please write down
some formal words to describe this case?

Thanks,
Gao Xiang
