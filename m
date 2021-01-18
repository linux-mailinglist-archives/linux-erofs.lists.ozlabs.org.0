Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD05D2FA233
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Jan 2021 14:54:44 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DKCvj2LfjzDr27
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Jan 2021 00:54:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=MsLJsIjp; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MsLJsIjp; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DKCvL5t8MzDr1Q
 for <linux-erofs@lists.ozlabs.org>; Tue, 19 Jan 2021 00:54:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610978058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B5is/Aje3b+j/LqR0h56afAQAORry8F3h9T/sTdQKCo=;
 b=MsLJsIjptky1BwjeF6xEafELzKEtKFLAfL1b0X2maG2Uf27dBw+X6gRSS9r5pQn8W5pCZ2
 jvw09nGuuPRwKjYXXla9N389X4KSwYZ5nMuvi/6NN0w3M+iYmSfM+bnrhwWn255VxStLIu
 XKGnBkYDx1ccGxCBizloKIyH/7RCaUM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610978058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B5is/Aje3b+j/LqR0h56afAQAORry8F3h9T/sTdQKCo=;
 b=MsLJsIjptky1BwjeF6xEafELzKEtKFLAfL1b0X2maG2Uf27dBw+X6gRSS9r5pQn8W5pCZ2
 jvw09nGuuPRwKjYXXla9N389X4KSwYZ5nMuvi/6NN0w3M+iYmSfM+bnrhwWn255VxStLIu
 XKGnBkYDx1ccGxCBizloKIyH/7RCaUM=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-tRjlkSgJNz2vuQJwIznGGg-1; Mon, 18 Jan 2021 08:54:15 -0500
X-MC-Unique: tRjlkSgJNz2vuQJwIznGGg-1
Received: by mail-pl1-f198.google.com with SMTP id l11so11570649plt.2
 for <linux-erofs@lists.ozlabs.org>; Mon, 18 Jan 2021 05:54:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=B5is/Aje3b+j/LqR0h56afAQAORry8F3h9T/sTdQKCo=;
 b=ZKIICDDKG5Ie9Y1JFXV/cfvzjSXO1oS71BrHKfWKVH9P6BG1TPfEdqtF8dlcep8LKa
 liM5tWEK07GAc82N7bSiL5v/zsenrEU7YApMDamPbmirqJYK+iSc3L4PxGxj7S9eL6fS
 t53XyLR7P5/mPpmNqTF33o12afLPOQO6rdiVJd6bItab8A3/JngGwWeKbnrlVlX7F2lY
 iN9hAbfr/zzoJTn5X55kJdA5zyhHxMC+bIRkY06/MpwrBjUjcfVL6NCArWKgRQDi9XeK
 hnvf+6+tsB8I8ZoHROXjMegv490ysRcgqYdMJs5XJhPkPVyYt7bfnqHscw06zPRThfgi
 xh8w==
X-Gm-Message-State: AOAM532IVGQXlfm3nYnL1W3TCwNOafCPGIIVGdlYry2rt5WWHtct9FJa
 +27NPjQMSAyAsj5hvOWkGSeId8crXDy9VnttNj0B8WdcT6u1TBTLcnQoFsGEDiZEy1AecAUdpmh
 9t85DEh7mye2LFT+E5XwciHaP
X-Received: by 2002:a63:5541:: with SMTP id f1mr7928200pgm.322.1610978054540; 
 Mon, 18 Jan 2021 05:54:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwvLXbBmjr9SBNKoOr3TWW/kM3rBV6nFbtV1Aa4i8Ts4Mo6ivcV2A4QlKHHB460o8Y2R4w9+w==
X-Received: by 2002:a63:5541:: with SMTP id f1mr7928177pgm.322.1610978054138; 
 Mon, 18 Jan 2021 05:54:14 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id y16sm16383569pfb.83.2021.01.18.05.54.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Jan 2021 05:54:13 -0800 (PST)
Date: Mon, 18 Jan 2021 21:54:03 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: =?utf-8?B?6IOh546u5paH?= <sehuww@mail.scut.edu.cn>
Subject: Re: [PATCH v4 2/2] erofs-utils: optimize buffer allocation logic
Message-ID: <20210118135403.GA2423918@xiangao.remote.csb>
References: <77494F58-C017-4496-BA5E-08B6334DE251@mail.scut.edu.cn>
MIME-Version: 1.0
In-Reply-To: <77494F58-C017-4496-BA5E-08B6334DE251@mail.scut.edu.cn>
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

On Mon, Jan 18, 2021 at 08:29:23PM +0800, 胡玮文 wrote:
> ﻿Hi Xiang,
> 
> Thank you, your patch is indeed clearer. Could you explain why you don’t like my added erofs_dbg? I found them very useful when debugging.

I do like your erofs_dbg, but we might need to shift(e.g. rename to
erofs_verbose? not sure...) some likewise information

erofs_dbg("Writing %u uncompressed data to block %u",

to another dbglevel (since such message might be helpful for end
users... not only developers...)

Also, we might need to reorganize the English words ... Honestly,
I'm not good at this as well.

> 
> I’ve updated the commit message, with some fixes (see inline) in PATCH v5 (coming soon).

okay.

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
> > `erofs_mapbh` function.
> > 
> > * global `non_full_buffer_blocks` mantains a list of buffer block for
> > each type and each possible remaining bytes in the block. Then it is
> > used to identify the most suitable blocks in future `erofs_balloc`,
> > avoiding full scan.
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
> > 
> > Thanks,
> > Gao Xiang
> > 
> > include/erofs/cache.h |  1 +
> > lib/cache.c           | 91 +++++++++++++++++++++++++++++++++++++------
> > 2 files changed, 81 insertions(+), 11 deletions(-)
> > 
> > diff --git a/include/erofs/cache.h b/include/erofs/cache.h
> > index f8dff67b9736..611ca5b8432b 100644
> > --- a/include/erofs/cache.h
> > +++ b/include/erofs/cache.h
> > @@ -39,6 +39,7 @@ struct erofs_buffer_head {
> > 
> > struct erofs_buffer_block {
> > struct list_head list;
> > +    struct list_head mapped_list;
> > 
> > erofs_blk_t blkaddr;
> > int type;
> > diff --git a/lib/cache.c b/lib/cache.c
> > index 32a58311f563..a44e140bc77b 100644
> > --- a/lib/cache.c
> > +++ b/lib/cache.c
> > @@ -18,6 +18,11 @@ static struct erofs_buffer_block blkh = {
> > };
> > static erofs_blk_t tail_blkaddr;
> > 
> > +/* buckets for all mapped buffer blocks to boost up allocation */
> > +static struct list_head mapped_buckets[2][EROFS_BLKSIZ];
> > +/* last mapped buffer block to accelerate erofs_mapbh() */
> > +static struct erofs_buffer_block *last_mapped_block = &blkh;
> > +
> > static bool erofs_bh_flush_drop_directly(struct erofs_buffer_head *bh)
> > {
> > return erofs_bh_flush_generic_end(bh);
> > @@ -62,12 +67,17 @@ struct erofs_bhops erofs_buf_write_bhops = {
> > /* return buffer_head of erofs super block (with size 0) */
> > struct erofs_buffer_head *erofs_buffer_init(void)
> > {
> > +    int i, j;
> > struct erofs_buffer_head *bh = erofs_balloc(META, 0, 0, 0);
> > 
> > if (IS_ERR(bh))
> >   return bh;
> > 
> > bh->op = &erofs_skip_write_bhops;
> > +
> > +    for (i = 0; i < ARRAY_SIZE(mapped_buckets); i++)
> > +        for (j = 0; j < ARRAY_SIZE(mapped_buckets[0]); j++)
> > +            init_list_head(&mapped_buckets[i][j]);
> > return bh;
> > }
> > 
> > @@ -132,20 +142,55 @@ struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
> > struct erofs_buffer_block *cur, *bb;
> > struct erofs_buffer_head *bh;
> > unsigned int alignsize, used0, usedmax;
> > +    unsigned int used_before, used;
> > 
> > int ret = get_alignsize(type, &type);
> > 
> > if (ret < 0)
> >   return ERR_PTR(ret);
> > +
> > +    DBG_BUGON(type < 0 || type > META);
> > alignsize = ret;
> > 
> > used0 = (size + required_ext) % EROFS_BLKSIZ + inline_ext;
> > usedmax = 0;
> > bb = NULL;
> > 
> > -    list_for_each_entry(cur, &blkh.list, list) {
> > -        unsigned int used_before, used;
> > +    if (!used0 || alignsize == EROFS_BLKSIZ)
> > +        goto alloc;
> > +
> > +    /* try to find a most-fit mapped buffer block first */
> > +    for (used_before = EROFS_BLKSIZ; used_before > 1; ) {
> 
> I would argue that it is more efficient if we use a more specific initial value for used_before.

will see your next version later, I think I'm out of condition
for now...

> 
> > +        struct list_head *bt = mapped_buckets[type] + --used_before;
> > +
> > +        if (list_empty(bt))
> > +            continue;
> > +        cur = list_first_entry(bt, struct erofs_buffer_block,
> > +                       mapped_list);
> > +
> > +        /* last mapped block can be expended, don't handle it here */
> > +        if (cur == last_mapped_block)
> > +            continue;
> > +
> > +        ret = __erofs_battach(cur, NULL, size, alignsize,
> > +                      required_ext + inline_ext, true);
> > +        if (ret < 0)
> 
> If used_before is chosen properly, this should never fail.

Yeah, but my idea is that we shouldn't rely on the internal
implementation logic of __erofs_battach in case of its potential
logic change. Otherwise, we would suffer from it laterly...

> 
> > +            continue;
> > +
> > +        /* should contain all data in the current block */
> > +        used = ret + required_ext + inline_ext;
> > +        DBG_BUGON(used > EROFS_BLKSIZ);
> > +
> > +        bb = cur;
> > +        usedmax = used;
> > +        break;
> > +    }
> > 
> > +    /* try to start from the last mapped one, which can be expended */
> > +    cur = last_mapped_block;
> > +    if (cur == &blkh)
> > +        cur = list_next_entry(cur, list);
> > +    for (; cur != &blkh; cur = list_next_entry(cur, list)) {
> >   used_before = cur->buffers.off % EROFS_BLKSIZ;
> > 
> >   /* skip if buffer block is just full */
> > @@ -187,6 +232,7 @@ struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
> >   goto found;
> > }
> > 
> > +alloc:
> > /* allocate a new buffer block */
> > if (used0 > EROFS_BLKSIZ)
> >   return ERR_PTR(-ENOSPC);
> > @@ -200,6 +246,7 @@ struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
> > bb->buffers.off = 0;
> > init_list_head(&bb->buffers.list);
> > list_add_tail(&bb->list, &blkh.list);
> > +    init_list_head(&bb->mapped_list);
> > 
> > bh = malloc(sizeof(struct erofs_buffer_head));
> > if (!bh) {
> > @@ -214,6 +261,18 @@ found:
> > return bh;
> > }
> > 
> > +static void erofs_bupdate_mapped(struct erofs_buffer_block *bb)
> > +{
> > +    struct list_head *bkt;
> > +
> > +    if (bb->blkaddr == NULL_ADDR)
> > +        return;
> > +
> > +    bkt = mapped_buckets[bb->type] + bb->buffers.off % EROFS_BLKSIZ;
> > +    list_del(&bb->mapped_list);
> > +    list_add_tail(&bb->mapped_list, bkt);
> > +}
> > +
> > struct erofs_buffer_head *erofs_battach(struct erofs_buffer_head *bh,
> >               int type, unsigned int size)
> > {
> > @@ -239,6 +298,7 @@ struct erofs_buffer_head *erofs_battach(struct erofs_buffer_head *bh,
> >   free(nbh);
> >   return ERR_PTR(ret);
> > }
> > +    erofs_bupdate_mapped(bb);
> 
> This line should goes into “__erofs_battach()”? Since “erofs_balloc()” only calls that function.

(personally...) I'd like to keep this line here, since __erofs_battach also
includes dry_run, and it mainly focus on calculation and handling bh rather than bb....

Thanks,
Gao Xiang

