Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E58A652E0A
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Dec 2022 09:38:17 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NcRfZ71y9z3c34
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Dec 2022 19:38:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=kJHt0sDC;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=kJHt0sDC;
	dkim-atps=neutral
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NcRfT37Mbz2xGn
	for <linux-erofs@lists.ozlabs.org>; Wed, 21 Dec 2022 19:38:07 +1100 (AEDT)
Received: by mail-pj1-x102f.google.com with SMTP id o8-20020a17090a9f8800b00223de0364beso1480537pjp.4
        for <linux-erofs@lists.ozlabs.org>; Wed, 21 Dec 2022 00:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QL9pEp2gcIaRXR0X2TFnc3iH9t3Oj+pHvpbF4BW9VqU=;
        b=kJHt0sDCvkwPd10wYUXytwFKw5489cC3mfUT3iYaovT0ws0+YhmwxVShdQnP73z0Zf
         39OTmoIaRaVBhJgstfmHcYmcCI0o6Y92yyi5QV8Fs+2UHyv2T/xDYyMr88FFs/mNdH3O
         iQAOPlbrHZDVM8gbPEcE9cO7BJ7+EwJ5K7b+BdtwKHOdBRcsHH75M7WbhHBBJerCyCzI
         r7x7wNRDGi8+6PeVIFgrInVygsDISnv0FU7mHVx76X6I61keqvHUlRBcy8DHZMzgWE//
         kt6NHY2hguaH8H0Do184zvMKAugnOLfDN5HgxdUQRSnRFxQGxdHNvWm7ng0NFri5Eezn
         4Ldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QL9pEp2gcIaRXR0X2TFnc3iH9t3Oj+pHvpbF4BW9VqU=;
        b=CubJFKwk5vzOUrUfRXCKLrLrW+UjV5pGqOpZ/Wfy5xk2vZv8X22WzMw0diZt5Rnkrq
         MkvnGT2EDY4MvTDqAiMoMhmonF4f6+MCOh4TDdDZbTUB/3+1ro68DA055dL4p30uhOEi
         T09GhTN9AAgUSm6ZSRjzkoXg/Sg3EDI7MhELxY/c0ptC1duWwIz3nt9ZpID3LGFWUjdk
         FDG1q22j9vhR4IEibdvzhONKZCQdnaEbEBlk8Hx3dCUNGT3ZOJtqF9coITNDYyEJYatA
         SgB9YJ5GV14RpG8AY/JyTpXl/wMmnpW1t9K/rG8Wqkww3X53sG8P9SKtZzhS29sCc1s9
         LVtA==
X-Gm-Message-State: AFqh2krCIKu9kMT2+kuGOr7NjS5dgLbZmR5/0joXkOyN/CYrsNSkpB0Z
	kDUceBq9N8XKhfwfymdBrivNfsovLZs=
X-Google-Smtp-Source: AMrXdXtFK7t7aW8SNb20/lUHVb3LBUK67G9QJcbvtkpv/f7aPB8vTtNKn/8etG6B7NyKU4Ai15Tl5Q==
X-Received: by 2002:a17:902:b418:b0:191:1fc4:5c14 with SMTP id x24-20020a170902b41800b001911fc45c14mr1144710plr.49.1671611885500;
        Wed, 21 Dec 2022 00:38:05 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id p22-20020a1709027ed600b00186748fe6ccsm10804198plb.214.2022.12.21.00.38.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Dec 2022 00:38:05 -0800 (PST)
Date: Wed, 21 Dec 2022 16:42:44 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] erofs-utils: fsck: support interlaced uncompressed
 pcluster
Message-ID: <20221221164244.00003309.zbestahu@gmail.com>
In-Reply-To: <Y6K6jkYwJW0ZE8F3@B-P7TQMD6M-0146.local>
References: <20221221074130.26034-1-zbestahu@gmail.com>
	<Y6K6jkYwJW0ZE8F3@B-P7TQMD6M-0146.local>
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
Cc: Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, 21 Dec 2022 15:49:34 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> On Wed, Dec 21, 2022 at 03:41:30PM +0800, Yue Hu wrote:
> > From: Yue Hu <huyue2@coolpad.com>
> > 
> > Support uncompressed data layout with on-disk interlaced offset in
> > compression mode for fsck.erofs.
> > 
> > Signed-off-by: Yue Hu <huyue2@coolpad.com>
> > ---
> >  fsck/main.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/fsck/main.c b/fsck/main.c
> > index 410e756..c2f57bc 100644
> > --- a/fsck/main.c
> > +++ b/fsck/main.c
> > @@ -458,12 +458,16 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
> >  				.in = raw,
> >  				.out = buffer,
> >  				.decodedskip = 0,
> > +				.interlaced_offset = 0,  
> 
> Could we use
> 	.interlace_offset =
> 		map.m_algorithmformat == Z_EROFS_COMPRESSION_INTERLACED ?
> 			rq.interlaced_offset : 0,
> 
> here instead?

Okay, let me send v2 in this way.

> 
> Thanks,
> Gao Xiang
> 
> >  				.inputsize = map.m_plen,
> >  				.decodedlength = map.m_llen,
> >  				.alg = map.m_algorithmformat,
> >  				.partial_decoding = 0
> >  			};
> >  
> > +			if (map.m_algorithmformat == Z_EROFS_COMPRESSION_INTERLACED)
> > +				rq.interlaced_offset = erofs_blkoff(map.m_la);
> > +
> >  			ret = z_erofs_decompress(&rq);
> >  			if (ret < 0) {
> >  				erofs_err("failed to decompress data of m_pa %" PRIu64 ", m_plen %" PRIu64 " @ nid %llu: %s",
> > -- 
> > 2.17.1  

