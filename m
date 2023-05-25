Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D31E7105DE
	for <lists+linux-erofs@lfdr.de>; Thu, 25 May 2023 08:58:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QRf6G1C4Dz3f7H
	for <lists+linux-erofs@lfdr.de>; Thu, 25 May 2023 16:58:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=pYqBGlyA;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=pYqBGlyA;
	dkim-atps=neutral
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QRf6852ryz3bkk
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 May 2023 16:58:39 +1000 (AEST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-2532c2c419dso823154a91.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 24 May 2023 23:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684997917; x=1687589917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76cyFsl2b2nTdh3+cZxDim2urSf6JLnxU9wqhFG5ggU=;
        b=pYqBGlyAqWE90ctUYKEbyJzhJ7DpOZ+1KSSGEhvTCgkchRc9TvJ0aLbi8RAAGWXEQj
         sicDjePVjx8/yyszMCfiG4q/Qr1JltIyUNANz9iz/r2BfUsu5akNUHbpL+/dtwT4Oq1X
         z1k5JftXCm6QUuVlZ8f2t3h3FgbFVQNpij8UwKR9s5PvZlCMwopkacNqi+D9V9ZrQ7cM
         jCyz9Uv+xTBfvmHTUcuQr4CJUSj266x0dStzP5Hk0aJfTU0eybwJSVABte0vnZScIAlo
         VCBj6Au+s28WA6LnqSE+EJlT/IvzAI5g+VK6Pna0mLOKaQCp1U0R3GBc52QmnSM4XDnP
         yknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684997917; x=1687589917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=76cyFsl2b2nTdh3+cZxDim2urSf6JLnxU9wqhFG5ggU=;
        b=U5dfMbDuXFgDa8eD59trnojjMPY/2mHtKAkXPV6MC6KMPjo+cTyCOKvNIEGvtT3u43
         Q25nVOaBJAKM3w81rMYPH3y4T2/plmJtAsYern4CJlE+PB+rMGKa8ATId/jQucmgvxIf
         dUJyhWxPk1NMx9QJF0x1PlugHBtF5iFKIwaVeruANuAoGN8ye6trmhwSfko5lIIJ3s1W
         TOh6gE4wEU4wNm29ewCG9elZidFxGYhZk3BquymMQdkSZwZY3ax8CKMICL09lAWJC9w/
         fBBr9P8Jc1KleMjXx4MAYGU2kej+7cgn5LLpGQxY8Zb2Z33FGwrAYlPyu6PmCcAl66YK
         G1Rg==
X-Gm-Message-State: AC+VfDxOlDFr91/f513plZNSvz2x4K+aknGQ556QPL+iHFh8plX5Ljeb
	59lGkISKUH2o2x+OGgzpuvw=
X-Google-Smtp-Source: ACHHUZ4+MJzn5XoqZQWfZ0jYR4AVC6gVamQpUPZWjUIH/tlw6ChugTewBGvgXPckl+CzKGdmQJHAHQ==
X-Received: by 2002:a17:90b:a12:b0:255:e753:dcaf with SMTP id gg18-20020a17090b0a1200b00255e753dcafmr772052pjb.16.1684997916701;
        Wed, 24 May 2023 23:58:36 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id o5-20020a17090aac0500b0024e2230fdafsm546727pjq.54.2023.05.24.23.58.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 May 2023 23:58:36 -0700 (PDT)
Date: Thu, 25 May 2023 15:06:37 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] erofs: don't calculate new start when expanding read
 length
Message-ID: <20230525150637.00000a55.zbestahu@gmail.com>
In-Reply-To: <c3dbd82a-75c2-969d-02ce-b7a31b29a95e@linux.alibaba.com>
References: <20230525055147.13220-1-zbestahu@gmail.com>
	<c3dbd82a-75c2-969d-02ce-b7a31b29a95e@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org, zhangwen@coolpad.com, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, 25 May 2023 13:56:14 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> On 2023/5/25 22:51, Yue Hu wrote:
> > From: Yue Hu <huyue2@coolpad.com>
> > 
> > We only expand the trailing edge and not the leading edge.  So no need
> > to obtain new start again.  Let's use the existing ->headoffset instead.
> > 
> > Signed-off-by: Yue Hu <huyue2@coolpad.com>
> > ---
> >   fs/erofs/zdata.c | 12 +++++-------
> >   1 file changed, 5 insertions(+), 7 deletions(-)
> > 
> > diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> > index 874fee35af32..bab8dcb8e848 100644
> > --- a/fs/erofs/zdata.c
> > +++ b/fs/erofs/zdata.c
> > @@ -1828,26 +1828,24 @@ static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
> >   {
> >   	struct inode *inode = f->inode;
> >   	struct erofs_map_blocks *map = &f->map;
> > -	erofs_off_t cur, end;
> > +	erofs_off_t cur, end, headoffset = f->headoffset;  
> 
> 
> That is not quite useful, or could you merge this info the original patch?

Okay, i will do the merge later.

> 
> Thanks,
> Gao Xiang
> 
> >   	int err;
> >   
> >   	if (backmost) {
> >   		if (rac)
> > -			end = f->headoffset + readahead_length(rac) - 1;
> > +			end = headoffset + readahead_length(rac) - 1;
> >   		else
> > -			end = f->headoffset + PAGE_SIZE - 1;
> > +			end = headoffset + PAGE_SIZE - 1;
> >   		map->m_la = end;
> >   		err = z_erofs_map_blocks_iter(inode, map,
> >   					      EROFS_GET_BLOCKS_READMORE);
> >   		if (err)
> >   			return;
> >   
> > -		/* expend ra for the trailing edge if readahead */
> > +		/* expand ra for the trailing edge if readahead */
> >   		if (rac) {
> > -			loff_t newstart = readahead_pos(rac);
> > -
> >   			cur = round_up(map->m_la + map->m_llen, PAGE_SIZE);
> > -			readahead_expand(rac, newstart, cur - newstart);
> > +			readahead_expand(rac, headoffset, cur - headoffset);
> >   			return;
> >   		}
> >   		end = round_up(end, PAGE_SIZE);  

