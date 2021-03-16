Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 003BB33CADC
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Mar 2021 02:29:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Dzwgg73N6z303J
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Mar 2021 12:29:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z3zyYklz;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z3zyYklz;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=Z3zyYklz; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z3zyYklz; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Dzwgc6Y8xz2yxp
 for <linux-erofs@lists.ozlabs.org>; Tue, 16 Mar 2021 12:29:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615858168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FZHiTZwXf5sTvxAUH1ipIkf3/1wzr5cvwcSvdfU7CpE=;
 b=Z3zyYklzLmby8o6iYdrtj7vuGEYYMzbk1ehgmXY7vK4D2QWemVBYw7CjyDnh5oUBY7y562
 9YqgZeNiNKOage6xoXwpBc1l6voad1vaZIL25f7xrgIE5VZVsNvcj+/LHHOKPXEVuyQCN2
 aNeXFgVV8A+Rz0AbKt7Kgk00cuIPEtc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615858168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FZHiTZwXf5sTvxAUH1ipIkf3/1wzr5cvwcSvdfU7CpE=;
 b=Z3zyYklzLmby8o6iYdrtj7vuGEYYMzbk1ehgmXY7vK4D2QWemVBYw7CjyDnh5oUBY7y562
 9YqgZeNiNKOage6xoXwpBc1l6voad1vaZIL25f7xrgIE5VZVsNvcj+/LHHOKPXEVuyQCN2
 aNeXFgVV8A+Rz0AbKt7Kgk00cuIPEtc=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-U_55klbQNv2peTX65TL4Xw-1; Mon, 15 Mar 2021 21:29:23 -0400
X-MC-Unique: U_55klbQNv2peTX65TL4Xw-1
Received: by mail-pl1-f198.google.com with SMTP id f10so17589097plt.6
 for <linux-erofs@lists.ozlabs.org>; Mon, 15 Mar 2021 18:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=FZHiTZwXf5sTvxAUH1ipIkf3/1wzr5cvwcSvdfU7CpE=;
 b=JhiGvGDt3hMWufOkFwolUyM7/yF4e3le7CbZomyBMmE1skbkkrGDm4MhfrRVtJENJK
 tRC4pQYT2sBbprPn0qO+K0LzoPk5NKm/dOufAIkGJtopvSyG9j9/hVp7OV0UrADmN63L
 Dg6V9tl5IIG4OhQdLq2o3nHbjRKOEKQl+US/1PD6sckjXjMtpXkaYr5wXOOsaFlN6WfM
 B2NVvWNZVBgCRzL+Eb9rGaZWyao3NlavLk5UuRfXqKQ41v7ZUHl8VIxa3OCEgxOM0+n1
 QPiwPYJWdJUAUAVI8Sh859ygjW2oyZSNzQ8pC+s8wHbfwA98DRrRXIUWWgcXbfoUneGd
 Hz+g==
X-Gm-Message-State: AOAM531F6dZIy1U8E3Pt3JMSx78fI7C2UcoLDKo+LrV6BjhqH0NS5P1N
 s37jEAfpEjQ5TAL7nteW+9Is6/NZgbQQX0UqM7I4IJ9UpYAvNNmA3ekr1i7dusoCB9JY7vLaqfE
 X+zTcAx3gmq16mL8gSCsyHiyw
X-Received: by 2002:a63:4b5e:: with SMTP id k30mr1592370pgl.130.1615858162614; 
 Mon, 15 Mar 2021 18:29:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxiiVJoHyC1v3XTRSM9p4HatDVJojHr0fu5Xx4awKZWFd1YYRdVwO/FQnoKTZD56cw9PPyiCA==
X-Received: by 2002:a63:4b5e:: with SMTP id k30mr1592361pgl.130.1615858162405; 
 Mon, 15 Mar 2021 18:29:22 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id s7sm835378pjr.18.2021.03.15.18.29.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Mar 2021 18:29:22 -0700 (PDT)
Date: Tue, 16 Mar 2021 09:29:11 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Chao Yu <yuchao0@huawei.com>, Huang Jianan <huangjianan@oppo.com>
Subject: Re: [PATCH v5 1/2] erofs: avoid memory allocation failure during
 rolling decompression
Message-ID: <20210316012911.GA931077@xiangao.remote.csb>
References: <20210305062219.557128-1-huangjianan@oppo.com>
 <20210305095840.31025-1-huangjianan@oppo.com>
 <110aa688-515d-7569-80fc-546bbeedc8c5@huawei.com>
MIME-Version: 1.0
In-Reply-To: <110aa688-515d-7569-80fc-546bbeedc8c5@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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
Cc: zhangshiming@oppo.com, linux-erofs@lists.ozlabs.org, guoweichao@oppo.com,
 linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Mar 16, 2021 at 09:11:02AM +0800, Chao Yu wrote:
> On 2021/3/5 17:58, Huang Jianan via Linux-erofs wrote:
> > Currently, err would be treated as io error. Therefore, it'd be
> > better to ensure memory allocation during rolling decompression
> > to avoid such io error.
> > 
> > In the long term, we might consider adding another !Uptodate case
> > for such case.
> > 
> > Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> > Signed-off-by: Guo Weichao <guoweichao@oppo.com>
> > ---
> >   fs/erofs/decompressor.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> > index 1cb1ffd10569..3d276a8aad86 100644
> > --- a/fs/erofs/decompressor.c
> > +++ b/fs/erofs/decompressor.c
> > @@ -73,7 +73,8 @@ static int z_erofs_lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
> >   			victim = availables[--top];
> >   			get_page(victim);
> >   		} else {
> > -			victim = erofs_allocpage(pagepool, GFP_KERNEL);
> > +			victim = erofs_allocpage(pagepool,
> > +						 GFP_KERNEL | __GFP_NOFAIL);
> >   			if (!victim)
> >   				return -ENOMEM;
> 
> A little bit weird that we still need to check return value of erofs_allocpage()
> after we pass __GFP_NOFAIL parameter.

Yeah, good point! sorry I forgot that.

Jianan,
Could you take some time resending the next version with all new things
updated?... thus Chao could review easily, Thanks!

Thanks,
Gao Xiang

> 
> Thanks,
> 
> >   			set_page_private(victim, Z_EROFS_SHORTLIVED_PAGE);
> > 
> 

