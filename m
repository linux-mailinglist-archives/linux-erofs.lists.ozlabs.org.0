Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D63EB6E405B
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Apr 2023 09:08:06 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Q0J6X5Kwkz3cMT
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Apr 2023 17:08:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=OMA9QK5J;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=OMA9QK5J;
	dkim-atps=neutral
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Q0J6Q03NHz3c41
	for <linux-erofs@lists.ozlabs.org>; Mon, 17 Apr 2023 17:07:55 +1000 (AEST)
Received: by mail-pj1-x1030.google.com with SMTP id w11so25079617pjh.5
        for <linux-erofs@lists.ozlabs.org>; Mon, 17 Apr 2023 00:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681715273; x=1684307273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WU1Eelp74KzEr0sUsJWlhFF4mGcWamWpqWGCcEgLmck=;
        b=OMA9QK5JYfRz/6uRPusmZgaFyuzZt5tirWMC8362U7sSTgVunjwkfUw6WoxPQLFd4I
         fOaavt/27rhek78Lsx6Kh6C8r2GOBvJD5WY24nGd0ilJGcHI/svaw7C1Z4F+TfSKSQvu
         2jHbGBBvEdabMc5HkUiXU1O5mvMxg4Y6rkGDTv/lVGTNxG7GlVqAdXKXNSDMNItkBhkj
         PApZWgg8Ibaw+VYALquT8T/Q3P59PbPTyLQ6Y8mTNN4gCAKogMajuCcESqNH3moie2vi
         SfWU3qLXZgrc88BGOWx6qguUJC4o+FpWf3Y63GgHsts1FepuP+sEsW2RReROgLZmAvj1
         jW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681715273; x=1684307273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WU1Eelp74KzEr0sUsJWlhFF4mGcWamWpqWGCcEgLmck=;
        b=KDmxzZGQcGCCzOP+G87trjkKdO2d6TCHZiTmS5xjytChm+XHgjD0o8hJBGo3LaiWlK
         ethnzcTINtF+yY+HTqX7MGbHg5Z1U5YTU16kH+BvDE3NGGhlpIIAvT5XHnohzzacBuyU
         14LEtrALOz0mBbdHZ50Ge7e7fkvueyNHYzNhd2V2G7zKioLQ8JyCGtg3oNJr4sx32PAa
         A8kN5jnksa+J2RItATxQM8yZAadaFxthH4C9D3lZXvsjqQz/r4LrqUpWmW3HuVKdygkm
         j2hpHXanIfLUt1QQnI11QTMC8CfLk3E59+tqlbAqrZgc5bfO5dY1q06OtkCW9tsxvP3e
         VmQQ==
X-Gm-Message-State: AAQBX9fVOG8xRyZMa16e7hMUYOzBNCJEvUv4gzxD7mWE6jj2NbrlqtoS
	1KPRFII0E6+bEz4d0Von2pQ=
X-Google-Smtp-Source: AKy350a37xcV+yNa6vzHd2woK8VS5vGyFiU38w+9/N+bTeoFqC7Fx6g6Ob0pSKox9YhfeAxxxoX/Vg==
X-Received: by 2002:a17:902:ce8e:b0:1a6:b55c:8a7c with SMTP id f14-20020a170902ce8e00b001a6b55c8a7cmr9089032plg.57.1681715272965;
        Mon, 17 Apr 2023 00:07:52 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id a6-20020a170902b58600b001a19bde435fsm6945340pls.65.2023.04.17.00.07.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Apr 2023 00:07:52 -0700 (PDT)
Date: Mon, 17 Apr 2023 15:15:06 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] erofs: remove unneeded icur field from struct
 z_erofs_decompress_frontend
Message-ID: <20230417151506.00006565.zbestahu@gmail.com>
In-Reply-To: <dd1d75a6-38c3-771c-c1ed-2f5dca523c03@linux.alibaba.com>
References: <20230417064136.5890-1-zbestahu@gmail.com>
	<26cdf7b0-5d7d-68ba-da76-1ad800708946@linux.alibaba.com>
	<dd1d75a6-38c3-771c-c1ed-2f5dca523c03@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=GB18030
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
Cc: linux-kernel@vger.kernel.org, zhangwen@coolpad.com, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, 17 Apr 2023 15:00:25 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> On 2023/4/17 14:52, Gao Xiang wrote:
> > 
> > 
> > On 2023/4/17 14:41, Yue Hu wrote:  
> >> From: Yue Hu <huyue2@coolpad.com>
> >>
> >> The icur field is only used in z_erofs_try_inplace_io(). Let's just use
> >> a local variable instead. And no need to check if the pcluster is inline
> >> when setting icur since inline page cannot be used for inplace I/O.  
> 
> Where do we check if the pcluster is inline?

       /* since file-backed online pages are traversed in reverse order */
       fe->icur = z_erofs_pclusterpages(fe->pcl);


static inline unsigned int z_erofs_pclusterpages(struct z_erofs_pcluster *pcl)
{
        if (z_erofs_is_inline_pcluster(pcl))
                return 1;
	[...]

> 
> >>
> >> Signed-off-by: Yue Hu <huyue2@coolpad.com>  
> > 
> > Nope, it's a behavior change.
> > Other users could feed more inplace I/O pages before I/O submission
> > to reduce memory consumption, it's common when applying stress model
> > in low memory scenarios.  
> 
> Oh, I misread it.  I think it can be done in this way although
> each following users will now rescan the whole array all the time.
> 
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> > 
> > Thanks,
> > Gao Xiang
> >   
> >> ---
> >>   fs/erofs/zdata.c | 13 +++++--------
> >>   1 file changed, 5 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> >> index f759152feffa..f8bf2b227942 100644
> >> --- a/fs/erofs/zdata.c
> >> +++ b/fs/erofs/zdata.c
> >> @@ -554,9 +554,6 @@ struct z_erofs_decompress_frontend {
> >>       /* used for applying cache strategy on the fly */
> >>       bool backmost;
> >>       erofs_off_t headoffset;
> >> -
> >> -    /* a pointer used to pick up inplace I/O pages */
> >> -    unsigned int icur;
> >>   };
> >>   #define DECOMPRESS_FRONTEND_INIT(__i) { \
> >> @@ -707,11 +704,13 @@ static bool z_erofs_try_inplace_io(struct z_erofs_decompress_frontend *fe,
> >>                      struct z_erofs_bvec *bvec)
> >>   {
> >>       struct z_erofs_pcluster *const pcl = fe->pcl;
> >> +    /* file-backed online pages are traversed in reverse order */  
> 
> Although please help refine the comment below:
> 
> 	/* scan & fill inplace I/O pages in the reverse order */

Ok, will refine it in v2.

> 
> Thanks,
> Gao Xiang
> 
> >> +    unsigned int icur = pcl->pclusterpages;
> >> -    while (fe->icur > 0) {
> >> -        if (!cmpxchg(&pcl->compressed_bvecs[--fe->icur].page,
> >> +    while (icur > 0) {
> >> +        if (!cmpxchg(&pcl->compressed_bvecs[--icur].page,
> >>                    NULL, bvec->page)) {
> >> -            pcl->compressed_bvecs[fe->icur] = *bvec;
> >> +            pcl->compressed_bvecs[icur] = *bvec;
> >>               return true;
> >>           }
> >>       }
> >> @@ -877,8 +876,6 @@ static int z_erofs_collector_begin(struct z_erofs_decompress_frontend *fe)
> >>       }
> >>       z_erofs_bvec_iter_begin(&fe->biter, &fe->pcl->bvset,
> >>                   Z_EROFS_INLINE_BVECS, fe->pcl->vcnt);
> >> -    /* since file-backed online pages are traversed in reverse order */
> >> -    fe->icur = z_erofs_pclusterpages(fe->pcl);
> >>       return 0;
> >>   }  

