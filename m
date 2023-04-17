Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A28396E4133
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Apr 2023 09:37:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Q0Jm93N8lz3cMn
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Apr 2023 17:37:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=olHgJtXl;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=olHgJtXl;
	dkim-atps=neutral
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Q0Jm328Mhz3cFw
	for <linux-erofs@lists.ozlabs.org>; Mon, 17 Apr 2023 17:37:05 +1000 (AEST)
Received: by mail-pl1-x633.google.com with SMTP id w1so1868204plg.6
        for <linux-erofs@lists.ozlabs.org>; Mon, 17 Apr 2023 00:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681717022; x=1684309022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ql0iTP179pIhS3D2wVviSQ4v43IiJJy5uQQWSApfMgw=;
        b=olHgJtXl3xiBtP0Nv6bocud6SVVd0gwMTdXw8n/5ssQfoXMiSy2INA8TOLFP8Vp7TH
         Ku+SQ5nb+FwwYzAgVgF9hI7Q8ymhh4THiLGZMZJEIpXPaSdwr9d1Lu8hDifYSdXQFOV8
         +3t8C1DEdGkqKzFvhoGptiQtZTfbg/CEMSZctRk81+Jie5sX9rxu39Rw4VsF+zwvn7vQ
         1jA/ortoG/zVQWnuNBj+Cw9RGTW3KYlqOaLsYfb0T+/3ymr0rljTK73UcAWo0NjAQpJg
         093o8n4v1IBIM4ZzQ6rErOtJLTBxEycDdQakKYwvQ+5LcsD54D4CJpHIctbI0yZxgbIn
         geIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681717022; x=1684309022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ql0iTP179pIhS3D2wVviSQ4v43IiJJy5uQQWSApfMgw=;
        b=lwPcDAzlFAps0TLFanoLV+n6w/jpvRNPu07i2JaykmplW7tP1+VpKt/bKwjTIEF+gh
         5MayHQ3LKAWMwmMv6VexIT7NFcTXAM/8qdL7NQ8DdWVbQI/igL9Qcn3NNtN2DDdqc0GQ
         pLsYWr4vjaJYBWAWjtwxMMixnu9q1VI5XP9M1niZ50/aXdLTqOfVVfTOB+s1z2bM+HJ3
         MdhMidm7N/4SxUm0deMG7lCUOY2EQwiy4TEC74WYQ3fnvvgImgbVc4c8xa0KHnc7yZ6Y
         Y9GWU0Zk72Ok78xR4KxpgOeKsEunXy0DlCj7TaumPZMoZEpHIn07a8YqY38vYAj8qRmF
         cWfQ==
X-Gm-Message-State: AAQBX9eIz7NTjWx+zqF79Rnqulz0gmFQBDbGNoO8Uqv5rip4P5mHBzT/
	TiohgroDF2ol5d0a7xyRj+eIQ2/YC2A=
X-Google-Smtp-Source: AKy350YeY4lDiDKgaTbJgzkeVNGLeDCUGf6a016OYEmzHRIiSAmh720ZwkB11T8nqxSBGfp4/SD7jw==
X-Received: by 2002:a17:903:32c6:b0:1a6:566b:dd73 with SMTP id i6-20020a17090332c600b001a6566bdd73mr13990591plr.60.1681717022477;
        Mon, 17 Apr 2023 00:37:02 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id d22-20020a170902b71600b001a67759f9f8sm733233pls.106.2023.04.17.00.37.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Apr 2023 00:37:02 -0700 (PDT)
Date: Mon, 17 Apr 2023 15:44:15 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] erofs: remove unneeded icur field from struct
 z_erofs_decompress_frontend
Message-ID: <20230417154415.00006a18.zbestahu@gmail.com>
In-Reply-To: <a8b9a758-d469-b9a6-f5e8-8f3768e2ea81@linux.alibaba.com>
References: <20230417064136.5890-1-zbestahu@gmail.com>
	<26cdf7b0-5d7d-68ba-da76-1ad800708946@linux.alibaba.com>
	<dd1d75a6-38c3-771c-c1ed-2f5dca523c03@linux.alibaba.com>
	<20230417151506.00006565.zbestahu@gmail.com>
	<a8b9a758-d469-b9a6-f5e8-8f3768e2ea81@linux.alibaba.com>
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

On Mon, 17 Apr 2023 15:12:31 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> On 2023/4/17 15:15, Yue Hu wrote:
> > On Mon, 17 Apr 2023 15:00:25 +0800
> > Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> >   
> 
> ..
> 
> >>
> >> Although please help refine the comment below:
> >>
> >> 	/* scan & fill inplace I/O pages in the reverse order */  
> > 
> > Ok, will refine it in v2.  
> 
> I rethink this, I don't want to go far in this way, and this makes a
> O(n) scan into O(n^2) when a single inplace I/O page is added.

Yeah, i misread that, it should be global before submission, just ignore the change.

> 
> So sorry, I don't think it's a good way, although I also don't think
> `icur` is a good name and we might need to find a better name.
> 
> Thanks,
> Gao Xiang
> 
> >   
> >>
> >> Thanks,
> >> Gao Xiang
> >>  
> >>>> +    unsigned int icur = pcl->pclusterpages;
> >>>> -    while (fe->icur > 0) {
> >>>> -        if (!cmpxchg(&pcl->compressed_bvecs[--fe->icur].page,
> >>>> +    while (icur > 0) {
> >>>> +        if (!cmpxchg(&pcl->compressed_bvecs[--icur].page,
> >>>>                     NULL, bvec->page)) {
> >>>> -            pcl->compressed_bvecs[fe->icur] = *bvec;
> >>>> +            pcl->compressed_bvecs[icur] = *bvec;
> >>>>                return true;
> >>>>            }
> >>>>        }
> >>>> @@ -877,8 +876,6 @@ static int z_erofs_collector_begin(struct z_erofs_decompress_frontend *fe)
> >>>>        }
> >>>>        z_erofs_bvec_iter_begin(&fe->biter, &fe->pcl->bvset,
> >>>>                    Z_EROFS_INLINE_BVECS, fe->pcl->vcnt);
> >>>> -    /* since file-backed online pages are traversed in reverse order */
> >>>> -    fe->icur = z_erofs_pclusterpages(fe->pcl);
> >>>>        return 0;
> >>>>    }  

