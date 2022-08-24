Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D8359F5C6
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Aug 2022 10:56:53 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MCKhx5HqCz2xKh
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Aug 2022 18:56:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=nxCv8QAz;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=nxCv8QAz;
	dkim-atps=neutral
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MCKhv011cz2xGy
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Aug 2022 18:56:46 +1000 (AEST)
Received: by mail-pj1-x102d.google.com with SMTP id r15-20020a17090a1bcf00b001fabf42a11cso856192pjr.3
        for <linux-erofs@lists.ozlabs.org>; Wed, 24 Aug 2022 01:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc;
        bh=4bV6z+6FfcJ7cJn+nq244xoagWmfQtuzU4q5Yb/IRik=;
        b=nxCv8QAzVeY+0krvyhbL8dvZNd22jYyJ8u0zMxFlUGPM9Ij8EWn3KojS6MsA7S2KH6
         +wFOYLslmTCyUQJyM0LdbxDZaeGF1+lJ8hmqOeHaA1nrFExZseNlqfYLOMNJH8x6tlvl
         LriFLG2lk3uNVGoxruKqYSZiXhFil41MhVI/EGLh4B3TMcVpFC6MZYsbsDZ9r7IyRNCh
         mQJnJw0oRfWV5MRzzUiVnHroD948ZoWNizm5Pg3HtBcMXKCYSWQtwDrCcZKU0hXC2TfU
         2KyChyjH3sIq8X31Lrstl+WNA9J7wZ3j1C6/YA7m63rLXDR43myUFD4WkxxMaLWu7X23
         0ZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=4bV6z+6FfcJ7cJn+nq244xoagWmfQtuzU4q5Yb/IRik=;
        b=6EAo5MbmtxgxYQq+NwZH4qEmJyHXewvQ33nBauA+aYLhsE9H7+lsQN4EyM0cnkcOCA
         Uz3Ek7SQLpTczq3Hyi+d3eUuMuJzKRgxWBiSM3grnQ34KUoYtXzCxZ/VYF+xPrWYS7Br
         j1QTCwKK6JrX3bFvMfgtnVrO0e2pN4woiDVnsuFVgXoiineLo22lJfoEdQ7yKb9sklcF
         FPfEaBodO1RG/YGJ0j3R8tPQpwm2y9f6SKT8otzv8hApTvIQ+UJIF+wIiXaVo64JTMEd
         F4QCkqEbLcHvyn/pegJB3992qhqBD00QDu1dSqney/qVkyP9kA0dhUn0Rzqrvp9bZ/1e
         Nfhw==
X-Gm-Message-State: ACgBeo3UvJPqVWWRMQ7MLar9SoBjWU7THptxpwnYWbpV1iWctx53Bf0b
	J8D4OlgL3GLxypU6yp3USGo=
X-Google-Smtp-Source: AA6agR4LYqb/MKKoGRN5v4FtS/R015K5DJ7v1j1bep4yjkichbwIRO+JOIRmDe81ehtwH8bwuxXPkA==
X-Received: by 2002:a17:902:a5cc:b0:170:d1cf:ac83 with SMTP id t12-20020a170902a5cc00b00170d1cfac83mr27468633plq.14.1661331402514;
        Wed, 24 Aug 2022 01:56:42 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id q7-20020a17090311c700b0016bffc59718sm12193385plh.58.2022.08.24.01.56.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Aug 2022 01:56:42 -0700 (PDT)
Date: Wed, 24 Aug 2022 16:58:52 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [RFC PATCH v4 2/3] erofs-utils: lib: support on-disk offset for
 shifted decompression
Message-ID: <20220824165852.00002d6b.zbestahu@gmail.com>
In-Reply-To: <YwXlR0lL6eZPtTTC@B-P7TQMD6M-0146.local>
References: <cover.1661087840.git.huyue2@coolpad.com>
	<9f59c86102b06555e39e62c99ca288647120ee01.1661087840.git.huyue2@coolpad.com>
	<YwXlR0lL6eZPtTTC@B-P7TQMD6M-0146.local>
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
Cc: Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, shaojunjun@coolpad.com, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, 24 Aug 2022 16:45:59 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Hi Yue,
> 
> On Sun, Aug 21, 2022 at 09:57:24PM +0800, zbestahu@gmail.com wrote:
> > From: Yue Hu <huyue2@coolpad.com>
> > 
> > Add support to uncompressed data layout with on-disk offset for
> > compressed files.  
> 
> Sorry for some delay.
> 
> Add interlaced uncompressed data layout for compressed files.
> 
> > 
> > Signed-off-by: Yue Hu <huyue2@coolpad.com>
> > ---
> >  include/erofs/decompress.h |  3 +++
> >  lib/data.c                 |  8 +++++++-
> >  lib/decompress.c           | 10 ++++++++--
> >  3 files changed, 18 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/erofs/decompress.h b/include/erofs/decompress.h
> > index 82bf7b8..b622df5 100644
> > --- a/include/erofs/decompress.h
> > +++ b/include/erofs/decompress.h
> > @@ -23,6 +23,9 @@ struct z_erofs_decompress_req {
> >  	unsigned int decodedskip;
> >  	unsigned int inputsize, decodedlength;
> >  
> > +	/* head offset of uncompressed data */
> > +	unsigned int shiftedhead;  
> 
> 	/* cut point of interlaced uncompressed data */
> 	unsigned int interlaced_offset;
> 
> > +
> >  	/* indicate the algorithm will be used for decompression */
> >  	unsigned int alg;
> >  	bool partial_decoding;
> > diff --git a/lib/data.c b/lib/data.c
> > index 2af73c7..008790d 100644
> > --- a/lib/data.c
> > +++ b/lib/data.c
> > @@ -226,7 +226,7 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
> >  	};
> >  	struct erofs_map_dev mdev;
> >  	bool partial;
> > -	unsigned int bufsize = 0;
> > +	unsigned int bufsize = 0, head;
> >  	char *raw = NULL;
> >  	int ret = 0;
> >  
> > @@ -307,10 +307,16 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
> >  		if (ret < 0)
> >  			break;
> >  
> > +		head = 0;
> > +		if (erofs_sb_has_fragments() &&  
> 
> Can we add another Z_EROFS_ADVISE_ for this, such as
> Z_EROFS_ADVISE_INTERLACED_UNCOMPRESSED_DATA ?

Sounds good, let's do this.

Thanks.

> 
> > +		    map.m_algorithmformat == Z_EROFS_COMPRESSION_SHIFTED)
> > +			head = erofs_blkoff(end);
> > +
> >  		ret = z_erofs_decompress(&(struct z_erofs_decompress_req) {
> >  					.in = raw,
> >  					.out = buffer + end - offset,
> >  					.decodedskip = skip,
> > +					.shiftedhead = head,
> >  					.inputsize = map.m_plen,
> >  					.decodedlength = length,
> >  					.alg = map.m_algorithmformat,
> > diff --git a/lib/decompress.c b/lib/decompress.c
> > index 1661f91..08a0861 100644
> > --- a/lib/decompress.c
> > +++ b/lib/decompress.c
> > @@ -132,14 +132,20 @@ out:
> >  int z_erofs_decompress(struct z_erofs_decompress_req *rq)
> >  {
> >  	if (rq->alg == Z_EROFS_COMPRESSION_SHIFTED) {
> > +		unsigned int count, rightpart;
> > +
> >  		if (rq->inputsize > EROFS_BLKSIZ)
> >  			return -EFSCORRUPTED;
> >  
> >  		DBG_BUGON(rq->decodedlength > EROFS_BLKSIZ);
> >  		DBG_BUGON(rq->decodedlength < rq->decodedskip);
> >  
> > -		memcpy(rq->out, rq->in + rq->decodedskip,
> > -		       rq->decodedlength - rq->decodedskip);
> > +		count = rq->decodedlength - rq->decodedskip;
> > +		rightpart = min(EROFS_BLKSIZ - rq->shiftedhead, count);
> > +
> > +		memcpy(rq->out, rq->in + (erofs_sb_has_fragments() ?  
> 
> same here.
> 
> Thanks,
> Gao Xiang
> 
> > +		       rq->shiftedhead : rq->decodedskip), rightpart);
> > +		memcpy(rq->out + rightpart, rq->in, count - rightpart);
> >  		return 0;
> >  	}
> >  
> > -- 
> > 2.17.1  

