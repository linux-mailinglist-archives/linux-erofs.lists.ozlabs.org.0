Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAAA5FE6B1
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Oct 2022 03:46:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MpTk952prz3c7B
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Oct 2022 12:45:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=XIzwHyqV;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=XIzwHyqV;
	dkim-atps=neutral
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MpTk11Hwrz2xyB
	for <linux-erofs@lists.ozlabs.org>; Fri, 14 Oct 2022 12:45:42 +1100 (AEDT)
Received: by mail-pf1-x435.google.com with SMTP id 67so3539056pfz.12
        for <linux-erofs@lists.ozlabs.org>; Thu, 13 Oct 2022 18:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8EnOlhLoJocEDglQGitiFvKlAWVQrQYRRzX5R2FHY0=;
        b=XIzwHyqVETJEE9Chtt3xcSbUOHc92oSX/cJ3ld3+1GjrU5E4lwlei3PlPAkgpYVVXX
         GrjnnrT7yXPIdBibRZ0MPB4XLOP16yvU7sONBK4oPb9CVqCHQHT9uqPFdNSUmYtY4roJ
         0jGP4HHO8IYA5WuXxe8MJzAcSl0Ieyk3lH85AYB+JYhwT3VTLwvGAmHiZFOXzxgl27To
         G2bauY/rS5z0qnqdbElBXLF1dfId+/M6G3Q9InBULlIqxjK2ItW4vDzxoCuP08Wji6xL
         XkvVnsRuXxtyiq3W0WLrmva8x6vKkcvGxGJBRuHDmP2f9cfSLQlZaF6hEDSvWLbUZRtx
         C4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M8EnOlhLoJocEDglQGitiFvKlAWVQrQYRRzX5R2FHY0=;
        b=d8iOz9Hb3J9Pl9h5Dsnb55DKpzmMwlmFSGS8HFeuJmRYuAIYSD9bnfpYgRxurQv8Q/
         RdVI9i8OICQdfXPzzXcGgoWlE2OHw4+PnmXXGcE644BfZyBiyK/oHugMkbj+TQp9gMCS
         JZtJ7S+P410Jm3s4ZkUVMK4+E8jkpyZOjaKTSYUql8S2RB+gD+W+sXUX5K0NIGXoHUcM
         rr68jcifBR1hXkGwXq5jx1o/KkibLZmwUG31AGlDiV+U0684YTrxkKSuC7xqZ2Zekpm5
         szLj+WyHEkhvp0PB7YeqZLi5Rxu3ys7q1G4MDQk6r4+/KTJA1Eg54NK0Dircrba7Rdkx
         YOlw==
X-Gm-Message-State: ACrzQf2grrefqxSinCPb7GQX26+PDDzBBMZgu1hsXBaW9IoGyWF3Y/n1
	gFK7ClmjxPFB3qWhOe3Cb0N4b89HGog=
X-Google-Smtp-Source: AMsMyM6rPgOQCPuXNji1d3oZpt3LtfWZtGGOAPRfY39BtsRvKA2dQDBcv9uO9a6U4sYrkFRitglBfg==
X-Received: by 2002:a63:4426:0:b0:464:4e1d:80e3 with SMTP id r38-20020a634426000000b004644e1d80e3mr2487186pga.106.1665711939847;
        Thu, 13 Oct 2022 18:45:39 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id t25-20020aa79479000000b0056126b79072sm362873pfq.21.2022.10.13.18.45.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Oct 2022 18:45:39 -0700 (PDT)
Date: Fri, 14 Oct 2022 09:48:46 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] erofs-utils: avoid unnecessary insert behavior when not
 deduplicating
Message-ID: <20221014094846.00005bdb.zbestahu@gmail.com>
In-Reply-To: <Y0fTbmoezlKid246@B-P7TQMD6M-0146.local>
References: <20221013040011.31944-1-zbestahu@gmail.com>
	<Y0fTbmoezlKid246@B-P7TQMD6M-0146.local>
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

On Thu, 13 Oct 2022 16:59:26 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Hi Yue,
> 
> On Thu, Oct 13, 2022 at 12:00:11PM +0800, Yue Hu wrote:
> > From: Yue Hu <huyue2@coolpad.com>
> > 
> > We should do nothing in dedupe inserting when it's not configured.
> > 
> > Signed-off-by: Yue Hu <huyue2@coolpad.com>
> > ---  
> 
> Thanks for the patch, do you observe some strange happening? 

I can see malloc/memcpy at runtime when dedupe is disabled. So, just skip.

> 
> IMO, If dedupe is not enabled, window_size will be 0 I think.
> However, I think we might need to disable it explicitly like below.
> 
> So,
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Thanks,
> Gao Xiang
> 
> 
> >  lib/dedupe.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/lib/dedupe.c b/lib/dedupe.c
> > index 7962014..9cad905 100644
> > --- a/lib/dedupe.c
> > +++ b/lib/dedupe.c
> > @@ -99,7 +99,7 @@ int z_erofs_dedupe_insert(struct z_erofs_inmem_extent *e,
> >  {
> >  	struct z_erofs_dedupe_item *di;
> >  
> > -	if (e->length < window_size)
> > +	if (!dedupe_subtree || e->length < window_size)
> >  		return 0;
> >  
> >  	di = malloc(sizeof(*di) + e->length - window_size);
> > -- 
> > 2.17.1  

