Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 576932FA28D
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Jan 2021 15:07:34 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DKDBW389SzDr2g
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Jan 2021 01:07:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=63.128.21.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=aM1K66A3; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=aM1K66A3; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DKDBB6XbJzDqq3
 for <linux-erofs@lists.ozlabs.org>; Tue, 19 Jan 2021 01:07:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610978828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bxSWaWuXZZXylccafU+W3BvjMrBNAFXICHBueGvAz+U=;
 b=aM1K66A3I3w0IKoluJNswqkZImdrnubKOfrPOVLc9KvgZIaUK6q9sBctbsyvr53vVg3grs
 +kwnTmddYFrugNs7eW14TUUfL88/F87WfiZbKnVDUFFe5j6iGVO0ojTEWehSrbwR0B3ADH
 OeT7rFn/1cJQBskFcg9+1X8CCHhIpHE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610978828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bxSWaWuXZZXylccafU+W3BvjMrBNAFXICHBueGvAz+U=;
 b=aM1K66A3I3w0IKoluJNswqkZImdrnubKOfrPOVLc9KvgZIaUK6q9sBctbsyvr53vVg3grs
 +kwnTmddYFrugNs7eW14TUUfL88/F87WfiZbKnVDUFFe5j6iGVO0ojTEWehSrbwR0B3ADH
 OeT7rFn/1cJQBskFcg9+1X8CCHhIpHE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-548-n_FL5ytAOii90pc6Gj5xzQ-1; Mon, 18 Jan 2021 09:07:06 -0500
X-MC-Unique: n_FL5ytAOii90pc6Gj5xzQ-1
Received: by mail-pj1-f71.google.com with SMTP id a18so6425032pjs.2
 for <linux-erofs@lists.ozlabs.org>; Mon, 18 Jan 2021 06:07:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=bxSWaWuXZZXylccafU+W3BvjMrBNAFXICHBueGvAz+U=;
 b=JmNcfkB3DJMgowsjfBEe98/XQ7AGsr6Ino1glq9BgODO8zTWdO/qZZR0ypknYTpyru
 oI7KqiTY6nCxFYXo+zEsZdqdGQLJPR5IDLKgxoyht7XgyX0qVnRHzfUSGbL4DwGFBx6s
 7i4GZMBtXnWSitX1PEJLG63TOvfhvDBkOFnP7qpblAbHy1BImlCHOBiCUGygyocAcMzf
 TyuiQAX8Ii/Kew+X4MYasBd3W1wS0cmVUUyKuJ7n26wkJQ6e53ziUpshugUCNuSeM55Z
 6HAw3634ajQXrM6NG8SzG2EmtxNoCjy13aeSj1LA+zzm3bB+evJ3sIPxRb29oeNWeO4h
 Dp9g==
X-Gm-Message-State: AOAM531LZsifeJCZ8R+cVjCUEo9UyNVlmnekp3t5FtuvRPgtWLjfC1CW
 9v8uP8FUrL4bHgP47ewQ3+u5hyctjwXzn7X5qUx2jn9pSUZ/EhGMUy4E46RS62LxOQnTMg1a62T
 hblSUmYI3hnqSt0F4EdGG8P2I
X-Received: by 2002:a65:5c09:: with SMTP id u9mr25745269pgr.143.1610978824908; 
 Mon, 18 Jan 2021 06:07:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJztlhVJPC6OWCsdJc7EMnS1mwaubozOMJacszCKQDpqnG5Lo4d4mEzGr47VMy2v2MnJgBclyg==
X-Received: by 2002:a65:5c09:: with SMTP id u9mr25745258pgr.143.1610978824701; 
 Mon, 18 Jan 2021 06:07:04 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id o1sm15653667pgq.1.2021.01.18.06.07.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Jan 2021 06:07:04 -0800 (PST)
Date: Mon, 18 Jan 2021 22:06:54 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: =?utf-8?B?6IOh546u5paH?= <sehuww@mail.scut.edu.cn>
Subject: Re: [PATCH v4 2/2] erofs-utils: optimize buffer allocation logic
Message-ID: <20210118140654.GC2423918@xiangao.remote.csb>
References: <20210116063106.5031-1-hsiangkao@aol.com>
 <35F8431A-29B6-4211-8BB1-E5241238D45D@mail.scut.edu.cn>
MIME-Version: 1.0
In-Reply-To: <35F8431A-29B6-4211-8BB1-E5241238D45D@mail.scut.edu.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Weiwen,

On Mon, Jan 18, 2021 at 09:02:16PM +0800, 胡玮文 wrote:
> 
> > 在 2021年1月16日，14:41，Gao Xiang <hsiangkao@aol.com> 写道：
> > 
> > ﻿From: Hu Weiwen <sehuww@mail.scut.edu.cn>
> > 
> > When using EROFS to pack our dataset which consists of millions of
> > files, mkfs.erofs is very slow compared with mksquashfs.
> > 
> > The bottleneck is `erofs_balloc` and `erofs_mapbh` function, which
> > iterate over all previously allocated buffer blocks, making the
> > complexity of the algrithm O(N^2) where N is the number of files.
> > 
> > With this patch:
> > 
> > * global `last_mapped_block` is mantained to avoid full scan in
> >  `erofs_mapbh` function.
> > 
> > * global `non_full_buffer_blocks` mantains a list of buffer block for
> >  each type and each possible remaining bytes in the block. Then it is
> >  used to identify the most suitable blocks in future `erofs_balloc`,
> >  avoiding full scan.
> > 
> > Some new data structure is allocated in this patch, more RAM usage is
> > expected, but not much. When I test it with ImageNet dataset (1.33M
> > files), 7GiB RAM is consumed, and it takes about 4 hours. Most time is
> > spent on IO.
> > 
> > Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>
> > Signed-off-by: Gao Xiang <hsiangkao@aol.com>
> > ---
> > 
> > I've simplified the most-fit finding logic of v3... Since buffers.off
> > has to be aligned to alignsize, so I think it's better to use
> > buffers.off as the index of mapped_buckets compared to using remaining
> > size as it looks more straight-forward.
> > 
> > Also, I found the exist logic handling expended blocks might be
> > potential ineffective as well... we have to skip used < used0 only
> > after oob (extra blocks is allocated, so not expend such blocks but
> > allocate a new bb...) It might be more effective to reuse such
> > non-mapped buffer blocks...
> 
> I don’t get this. If not oob, then “used” should be larger than “used_before”, then we will not skip such block anyway, right?

Sorry, I think I was completely misleaded by the comment above the
code at that time. It's too far to get the original intention :(
I think you're right (anyway, I think the main purpose of this
condition was that I didn't want to introduce too many new bbs
with a lot of large unused space. But anyway such condition is
approximate since it's actually a 0-1 Knapsack problem). Please
ignore my previous words about this...

Thanks,
Gao Xiang

