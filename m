Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E32322414
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Feb 2021 03:18:55 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Dl2mF31Wjz3cGp
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Feb 2021 13:18:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=T6fokKNx;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=T6fokKNx;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=T6fokKNx; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=T6fokKNx; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Dl2mB6cpMz30KS
 for <linux-erofs@lists.ozlabs.org>; Tue, 23 Feb 2021 13:18:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614046726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WKe4Azi8WwIiPXoMMrb4cd81gevagx+y/HRGK1z0jns=;
 b=T6fokKNxTgfmFtistHick89Af7hE9KLjOHZdQLZx63KCvXeUQ+o1DsA9cjWI89FcghLSpb
 E4C38KTbqXNrarfc9LSVVPIdeGQSLx0T3Kwpl2D4NPCPdOnjK0u+zHGimdzB+j69uIOUzB
 AdlSH+dbZrvBJHmjV7NOa9cPQuZYQ6Q=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614046726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WKe4Azi8WwIiPXoMMrb4cd81gevagx+y/HRGK1z0jns=;
 b=T6fokKNxTgfmFtistHick89Af7hE9KLjOHZdQLZx63KCvXeUQ+o1DsA9cjWI89FcghLSpb
 E4C38KTbqXNrarfc9LSVVPIdeGQSLx0T3Kwpl2D4NPCPdOnjK0u+zHGimdzB+j69uIOUzB
 AdlSH+dbZrvBJHmjV7NOa9cPQuZYQ6Q=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-my36egpEO1GGSOpszsx80A-1; Mon, 22 Feb 2021 21:18:41 -0500
X-MC-Unique: my36egpEO1GGSOpszsx80A-1
Received: by mail-pg1-f200.google.com with SMTP id n2so9132803pgj.12
 for <linux-erofs@lists.ozlabs.org>; Mon, 22 Feb 2021 18:18:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=WKe4Azi8WwIiPXoMMrb4cd81gevagx+y/HRGK1z0jns=;
 b=UwUarQk1D7ZMUs2bl8xkMcLxsiqqmEiMVn3EteTz4hAhf1sdByaYdID0WNYnaUYjr/
 +KaDGdH1G4dMahCAxRc2dOEW37zvZEZtUy1PYDD84mrVNhoOvFKf5d9dh1Lyc3GkCL0X
 2L/chkwb5+muhql245Eq1TQfbQwUfqRHNX3dp9p3MWzDgrPxWLqnhfv8/C0WmiuEaYBR
 ijIRjfbbZfq1mxyT+ehpi4g00j6qY8vAvY2KDWDMDVF3Zl/aH8Zy+vTRrsywTPMTgqIW
 iMbiWR+/+o9IbKbwd4uB48eosGokMHTp4ICSbqT/lUSojsE6Lyclj2xeqTvUgXHQFVNs
 0BNQ==
X-Gm-Message-State: AOAM532PL6yefw5eSmg76z9a9GfuegwrxxH6AYZt8wxL2D6Ka8dS5YMz
 15NK1iGaW6XOcYE/SJ26w6PeE+t8FvkOkYdgue7lELjwEytSc+MEu6ksVk6xuYSfNz8n/JiVKNl
 WUfJdZAAEHdsq8ZvXktbVpB5j
X-Received: by 2002:a17:90b:1649:: with SMTP id
 il9mr25812007pjb.62.1614046720610; 
 Mon, 22 Feb 2021 18:18:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxCABFRKTwBkBymzTpVoMMO56FvbMPtfXCNp92kLo3rmNdJ3nsG52Gzgj08WWoovs6WQ/pxhw==
X-Received: by 2002:a17:90b:1649:: with SMTP id
 il9mr25811992pjb.62.1614046720337; 
 Mon, 22 Feb 2021 18:18:40 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id p8sm2105204pff.79.2021.02.22.18.18.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Feb 2021 18:18:40 -0800 (PST)
Date: Tue, 23 Feb 2021 10:18:30 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Huang Jianan <huangjianan@oppo.com>
Subject: Re: [PATCH] erofs: support adjust lz4 history window size
Message-ID: <20210223021830.GA1225203@xiangao.remote.csb>
References: <20210218120049.17265-1-huangjianan@oppo.com>
 <20210222044410.GA1038521@xiangao.remote.csb>
 <11afa9f6-109a-c660-1664-7a596d6836b6@oppo.com>
MIME-Version: 1.0
In-Reply-To: <11afa9f6-109a-c660-1664-7a596d6836b6@oppo.com>
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
Cc: zhangshiming@oppo.com, guoweichao@oppo.com, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Feb 23, 2021 at 10:03:59AM +0800, Huang Jianan wrote:
> Hi Xiang,
> 
> On 2021/2/22 12:44, Gao Xiang wrote:
> > Hi Jianan,
> > 
> > On Thu, Feb 18, 2021 at 08:00:49PM +0800, Huang Jianan via Linux-erofs wrote:
> > > From: huangjianan <huangjianan@oppo.com>
> > > 
> > > lz4 uses LZ4_DISTANCE_MAX to record history preservation. When
> > > using rolling decompression, a block with a higher compression
> > > ratio will cause a larger memory allocation (up to 64k). It may
> > > cause a large resource burden in extreme cases on devices with
> > > small memory and a large number of concurrent IOs. So appropriately
> > > reducing this value can improve performance.
> > > 
> > > Decreasing this value will reduce the compression ratio (except
> > > when input_size <LZ4_DISTANCE_MAX). But considering that erofs
> > > currently only supports 4k output, reducing this value will not
> > > significantly reduce the compression benefits.
> > > 
> > > Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> > > Signed-off-by: Guo Weichao <guoweichao@oppo.com>
> > > ---
> > >   fs/erofs/decompressor.c | 13 +++++++++----
> > >   fs/erofs/erofs_fs.h     |  3 ++-
> > >   fs/erofs/internal.h     |  3 +++
> > >   fs/erofs/super.c        |  3 +++
> > >   4 files changed, 17 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> > > index 1cb1ffd10569..94ae56b3ff71 100644
> > > --- a/fs/erofs/decompressor.c
> > > +++ b/fs/erofs/decompressor.c
> > > @@ -36,22 +36,27 @@ static int z_erofs_lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
> > >   	struct page *availables[LZ4_MAX_DISTANCE_PAGES] = { NULL };
> > >   	unsigned long bounced[DIV_ROUND_UP(LZ4_MAX_DISTANCE_PAGES,
> > >   					   BITS_PER_LONG)] = { 0 };
> > > +	unsigned int lz4_distance_pages = LZ4_MAX_DISTANCE_PAGES;
> > >   	void *kaddr = NULL;
> > >   	unsigned int i, j, top;
> > > +	if (EROFS_SB(rq->sb)->compr_alg)
> > > +		lz4_distance_pages = DIV_ROUND_UP(EROFS_SB(rq->sb)->compr_alg,
> > > +						  PAGE_SIZE) + 1;
> > > +
> > Thanks for your patch, I agree that will reduce runtime memory
> > footpoint. and keep max sliding window ondisk in bytes (rather
> > than in blocks) is better., but could we calculate lz4_distance_pages
> > ahead when reading super_block?
> Thanks for suggestion, i will update it soon.
> > Also, in the next cycle, I'd like to introduce a bitmap for available
> > algorithms (maximum 16-bit) for the next LZMA algorithm, and for each
> > available algorithm introduces an on-disk variable-array like below:
> > bitmap(16-bit)    2       1       0
> >                  ...     LZMA    LZ4
> > __le16		compr_opt_off;      /* get the opt array start offset
> >                                         (I think also in 4-byte) */
> > 
> > compr alg 0 (lz4)	__le16	alg_opt_size;
> > 	/* next opt off = roundup(off + alg_opt_size, 4); */
> > 			__le16	lz4_max_distance;
> > 
> > /* 4-byte aligned */
> > compr alg x (if available)	u8	alg_opt_size;
> > 				...
> > 
> > ...
> > 
> > When reading sb, first, it scans the whole bitmap, and get all the
> > available algorithms in the image at once. And then read such compr
> > opts one-by-one.
> > 
> > Do you have some interest and extra time to implement it? :) That
> > makes me work less since I'm debugging mbpcluster compression now...
> 
> Sounds good, I will try to do this part of the work.

Yeah, but it seems to be part of the next LZMA algorithm patchset (with
a new brand new INCOMPET feature). I think we could introduce a __le16
lz4_max_distance field from sb reserved for now as a simple backporting
solution (since we only use < 64kb sliding window, so the image would
be forward compatibility with old kernels. 0 means 64kb sliding window,
otherwise it will < 64kb.)

And with the new INCOMPAT_COMPR_OPT feature, lz4_max_distance field
will be turned into compr_opt_off instead. And variable-array will be
used then.

So could you revise the patchset as above? Thanks!

Thanks,
Gao Xiang

> 
> Thanks,
> 
> Jianan
> 
> > Thanks,
> > Gao Xiang
> > 
> 

