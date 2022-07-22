Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 531DF57D99B
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jul 2022 06:30:06 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LpxLH619kz3c6y
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jul 2022 14:29:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=VtpMkeg4;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=VtpMkeg4;
	dkim-atps=neutral
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LpxL91TKlz30LC
	for <linux-erofs@lists.ozlabs.org>; Fri, 22 Jul 2022 14:29:52 +1000 (AEST)
Received: by mail-pg1-x52a.google.com with SMTP id 6so3446895pgb.13
        for <linux-erofs@lists.ozlabs.org>; Thu, 21 Jul 2022 21:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RbVbMYDNOUlR2qUwK+NsBXPY+0E6tmhp6uA2+s4LM+w=;
        b=VtpMkeg4BdNYKuTIw3C+u+b7G90+S1V37PJ4nc4o/UbUJQBDWMgLOD7ameAKKzwfgv
         yoO4PHblbnRX3EsB5JYQM9J9+WENYx6hvUnnwGWYfX/CyHup+xh6QxlVNFGT4EVSYhOi
         mP57PEY0LSiNpm2YmZ2mzd5PhOZidydXwTw0Ga/JTlUw65G/FJVs6/wJ3nTKqOuqd8kt
         tuuTP0O+MFh9P/J+87kU0wWscRLcxUkpNEbnUt5zEOo/m+w4pubsTDUqayEHPWL00jym
         eH5/QSclub4+vkJf5pKIzmFTnkmJJTCktp42h3beUjS8OcCiW0SNPBOAhixC1xYf+SvB
         e2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RbVbMYDNOUlR2qUwK+NsBXPY+0E6tmhp6uA2+s4LM+w=;
        b=GlyNaZCvCsiOoLtc7GRff1zVIkvY8ECo6m9ChVQ5JwL3d7kfjMCNj2FmK9xWo1N9TH
         IL8iIY9904uYQok3905ilgSw9KSV5YB6Mz2P74x6OUAJyjK+gBQJtdDQoYrZg+a1suba
         i2pr3ArRYo1uDL6rspm0j5orLyCqequVxtB1H39sGo1A2o5w0GyfpKH9AfQWjMAnj59t
         M2R8d+J35l72MWKgxCfjus+e9U7ipGZFN/U9jmAIDh8HhKaNwpeJ5wrVd2Sp89t4fYZY
         5xTS6d/P5y5OieVLPmy7x0lARZYaZNfU/G3YIy8uuouQvMyCSGDQPVAEiyrhLuo74bDA
         KtIA==
X-Gm-Message-State: AJIora/xdDF2hv5x9oAU41ZPrEnHpV1I/V9168sfzycjzv0ZQgHwhYOY
	c3EYvsKxfYq38yiNQn2LNwY=
X-Google-Smtp-Source: AGRyM1uMV8BqmoTZMIfamWz4yIewoAMb//89lklc5QEcQduXxTpRLCZINsz4TxpCTTu1svLww24HVw==
X-Received: by 2002:a05:6a00:893:b0:528:646f:528a with SMTP id q19-20020a056a00089300b00528646f528amr1545152pfj.21.1658464188210;
        Thu, 21 Jul 2022 21:29:48 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id k19-20020a63f013000000b00416018b5bbbsm2357274pgh.76.2022.07.21.21.29.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jul 2022 21:29:48 -0700 (PDT)
Date: Fri, 22 Jul 2022 12:31:19 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH RESEND] erofs-utils: fix a memory leak of multiple
 devices
Message-ID: <20220722123119.00003b90.zbestahu@gmail.com>
In-Reply-To: <YtoZWyzXw97cXY+j@B-P7TQMD6M-0146.local>
References: <20220722031008.21819-1-huyue2@coolpad.com>
	<YtoZWyzXw97cXY+j@B-P7TQMD6M-0146.local>
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
Cc: huyue2@coolpad.com, linux-erofs@lists.ozlabs.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, 22 Jul 2022 11:28:27 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Hi Yue,
> 
> On Fri, Jul 22, 2022 at 11:10:08AM +0800, Yue Hu wrote:
> > The memory allocated for multiple devices should be freed when to exit.
> > Let's add a helper to fix it since there is more than one to use it.
> > 
> > Signed-off-by: Yue Hu <huyue2@coolpad.com>
> > ---
> >  dump/main.c              | 7 ++++---
> >  fsck/main.c              | 7 ++++---
> >  fuse/main.c              | 5 +++--
> >  include/erofs/internal.h | 1 +
> >  lib/super.c              | 6 ++++++
> >  5 files changed, 18 insertions(+), 8 deletions(-)
> > 
> > diff --git a/dump/main.c b/dump/main.c
> > index 40e850a..c9b3a8f 100644
> > --- a/dump/main.c
> > +++ b/dump/main.c
> > @@ -615,7 +615,7 @@ int main(int argc, char **argv)
> >  	err = erofs_read_superblock();
> >  	if (err) {
> >  		erofs_err("failed to read superblock");
> > -		goto exit_dev_close;
> > +		goto exit_put_super;
> >  	}
> >  
> >  	if (!dumpcfg.totalshow) {
> > @@ -630,13 +630,14 @@ int main(int argc, char **argv)
> >  
> >  	if (dumpcfg.show_extent && !dumpcfg.show_inode) {
> >  		usage();
> > -		goto exit_dev_close;
> > +		goto exit_put_super;
> >  	}
> >  
> >  	if (dumpcfg.show_inode)
> >  		erofsdump_show_fileinfo(dumpcfg.show_extent);
> >  
> > -exit_dev_close:
> > +exit_put_super:
> > +	erofs_put_super();
> >  	dev_close();
> >  exit:
> >  	blob_closeall();
> > diff --git a/fsck/main.c b/fsck/main.c
> > index 5a2f659..a8f0e24 100644
> > --- a/fsck/main.c
> > +++ b/fsck/main.c
> > @@ -813,12 +813,12 @@ int main(int argc, char **argv)
> >  	err = erofs_read_superblock();
> >  	if (err) {
> >  		erofs_err("failed to read superblock");
> > -		goto exit_dev_close;
> > +		goto exit_put_super;  
> 
> Why do we call erofs_put_super() again here? I think we don't need to
> call erofs_put_super for all failed paths.

There is a call to dev_read() which may fails after allocating memory.
Let me send v2 for this.

> 
> Thanks,
> Gao Xiang

