Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E103F3AB11C
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Jun 2021 12:14:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G5Hwn2wnRz3bsS
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Jun 2021 20:14:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=Yvil2jcN;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::536;
 helo=mail-pg1-x536.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=Yvil2jcN; dkim-atps=neutral
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G5Hwj0RFKz30C3
 for <linux-erofs@lists.ozlabs.org>; Thu, 17 Jun 2021 20:14:44 +1000 (AEST)
Received: by mail-pg1-x536.google.com with SMTP id q15so4546450pgg.12
 for <linux-erofs@lists.ozlabs.org>; Thu, 17 Jun 2021 03:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Uq1mh1fAP7ZZGx2a3h1U7Z6L+r4csC7jCRoxP3HapzE=;
 b=Yvil2jcNkQd1teUMc2/NDIbQgcQNtPzQ2sKc5ZoFqCqXR62k7BWpqZ3xh3MQ4HDmGF
 UjTKrV5+rM4a1J7U9R3BUgpwtx1IGJHXbvIjxkn7IxSDcPO1pBeQJLMm50+9ykXNRopA
 fWmMzheun6mAdwTygw2Y9Z3HsJ+QVjzN9YkbGVy4GbZzruRqomE1fiXAJJCys047Vb0Z
 LjXWFxq2C7Ta4fVZP2j6ChBe1NqEhsveLeBsESuhAwaTDEOc2j9ZQCADiSu+9/hTMweP
 7oIitQDwZPvcTX9r+5iSGZ9NULsZDkhy0P0y87+nQmebQLKqbexuvn9ttP4PreudGIRH
 jL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Uq1mh1fAP7ZZGx2a3h1U7Z6L+r4csC7jCRoxP3HapzE=;
 b=Pb75iB05MRGtrjoODp69tYW+2rh3l4JWiccjgB7gtQuBW468Mg8Lf2Y7qAeSEEEOlR
 +mglo4ho3KaxmYKRGjsuQHED+2jBwqnWHjKVtohAb1GAQOjIcHXcexPb8EEFTykcBU8q
 Y3TQD64v3ldrnOOtwQiTNVlojYvIwLVOUhvmXnA4W+S3xpxP9Sh+LabQguATzo4pYioX
 G3QvJC7Rd5b8wHzgH0j/lO7HK79CEshMtjccDoAyN8zgVwp6pJsSsMkXSKmwKZmWVfVz
 G2f2ZkMSGXgKQuR3ftYz4vc5SwUjidvTPukKLTbtNPuLqjd4yudIJb6WTcOcR6J1Ghuk
 vb+A==
X-Gm-Message-State: AOAM530jedE/bUTioBCzbQpndKtlmLdHgu8GGfaWn1JxlnuKq4gyGpSs
 QdaylJarxO2G1TF/9ibFirE=
X-Google-Smtp-Source: ABdhPJxK18J+SjdIHu5/m+DuqC7D0tQQ77YkXrF0/UAhQkQ8ZkWetTz9Kfg+DZ5eC/+1HDdqQqZg8A==
X-Received: by 2002:aa7:93d2:0:b029:2ea:5909:ebfc with SMTP id
 y18-20020aa793d20000b02902ea5909ebfcmr4634758pff.40.1623924879138; 
 Thu, 17 Jun 2021 03:14:39 -0700 (PDT)
Received: from localhost ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id b9sm677798pfm.124.2021.06.17.03.14.31
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 17 Jun 2021 03:14:38 -0700 (PDT)
Date: Thu, 17 Jun 2021 18:14:17 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] erofs-utils: do not check ->idata_size for compressed
 files in erofs_prepare_inode_buffer()
Message-ID: <20210617181350.000005e6.zbestahu@gmail.com>
In-Reply-To: <YMsWMhNg6yC+osEK@bogon>
References: <20210617082954.1001-1-zbestahu@gmail.com> <YMsQHU+iSKE+FRO5@bogon>
 <20210617171555.0000673e.zbestahu@gmail.com>
 <YMsVhf2JgQOm1fDE@bogon> <YMsWMhNg6yC+osEK@bogon>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: zbestahu@163.com, huyue2@yulong.com, xiang@kernel.org,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, 17 Jun 2021 17:30:26 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> On Thu, Jun 17, 2021 at 05:27:33PM +0800, Gao Xiang wrote:
> > On Thu, Jun 17, 2021 at 05:15:55PM +0800, Yue Hu wrote:  
> > > On Thu, 17 Jun 2021 17:04:29 +0800
> > > Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> > >   
> > > > Hi Yue,
> > > > 
> > > > On Thu, Jun 17, 2021 at 04:29:54PM +0800, Yue Hu wrote:  
> > > > > From: Yue Hu <huyue2@yulong.com>
> > > > > 
> > > > > erofs_write_compressed_file() will always set inode->idata_size = 0
> > > > > if succeed, that means no tail-end data for compressed files. So, no
> > > > > need to call erofs_prepare_tail_block() which is used to handle
> > > > > tail-end data for that case. Just skip it.    
> > > > 
> > > > Thanks for the patch, due to somewhat long time so I don't quite
> > > > remember the exact logic here now...
> > > > 
> > > > Yet from the description before, it's not strictly correct
> > > > since my original intention would be to support tail-packing
> > > > inline compressed data which is similar to uncompressed case
> > > > to decrease tail extent I/O and save more space.  
> > > 
> > > nice.
> > >   
> > > > 
> > > > BTW, if you have some interest, would you like to implement it? :)  
> > > 
> > > I don't know if i can finish it. But i would like to have a try :)  
> > 
> > My rough thought is to try to inline the last tail compresseed
> > extent after the on-disk compressed extents, maybe we could let
> > it work for non-compact (legacy) compress index format cases...  
> 
> I mean try to implement non-compact (legacy) compress index format cases
> first.

Ok, let me try to implement it.

Thanks.

> 
> > 
> > Yeah, if you have extra time and interest, more ideas / thoughts /
> > discussions are always welcomed ;)
> > 
> > Thanks,
> > Gao Xiang
> > 
> >   
> > > 
> > > Thanks.
> > >   
> > > > 
> > > > Thanks,
> > > > Gao Xiang
> > > >   
> > > > > 
> > > > > Also, correct 'a inode' -> 'an inode'.
> > > > > 
> > > > > Signed-off-by: Yue Hu <huyue2@yulong.com>
> > > > > ---
> > > > >  lib/inode.c | 4 ++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/lib/inode.c b/lib/inode.c
> > > > > index b6108db..b5f66de 100644
> > > > > --- a/lib/inode.c
> > > > > +++ b/lib/inode.c
> > > > > @@ -111,7 +111,7 @@ struct erofs_dentry *erofs_d_alloc(struct erofs_inode *parent,
> > > > >  	return d;
> > > > >  }
> > > > >  
> > > > > -/* allocate main data for a inode */
> > > > > +/* allocate main data for an inode */
> > > > >  static int __allocate_inode_bh_data(struct erofs_inode *inode,
> > > > >  				    unsigned long nblocks)
> > > > >  {
> > > > > @@ -572,11 +572,11 @@ static int erofs_prepare_inode_buffer(struct erofs_inode *inode)
> > > > >  		int ret;
> > > > >  
> > > > >  		inode->datalayout = EROFS_INODE_FLAT_PLAIN;
> > > > > -noinline:
> > > > >  		/* expend an extra block for tail-end data */
> > > > >  		ret = erofs_prepare_tail_block(inode);
> > > > >  		if (ret)
> > > > >  			return ret;
> > > > > +noinline:
> > > > >  		bh = erofs_balloc(INODE, inodesize, 0, 0);
> > > > >  		if (IS_ERR(bh))
> > > > >  			return PTR_ERR(bh);
> > > > > -- 
> > > > > 1.9.1    

