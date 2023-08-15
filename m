Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE83F77C716
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Aug 2023 07:30:42 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=ZFqWJSgx;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RQ0Gm4QXXz3bVp
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Aug 2023 15:30:40 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=ZFqWJSgx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RQ0Gh3stBz2yV8
	for <linux-erofs@lists.ozlabs.org>; Tue, 15 Aug 2023 15:30:34 +1000 (AEST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-688142a392eso3842902b3a.3
        for <linux-erofs@lists.ozlabs.org>; Mon, 14 Aug 2023 22:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692077432; x=1692682232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ti6Hb8TH6vlhIU8fUbylq4br6PfU0PeLoAXLYASrGdI=;
        b=ZFqWJSgxqPzI3zt6gc/bt2o9XDrVXGbndUxl7njd/lHcREZeLGGw0KQ2aYSXw3XfLI
         pE0mRT36KhQRVlDVeilkrV2kCLf3tIw0/S80yGSjNXj+oTL30RyR2ECgDKZ9of6ymEID
         iYxoEdo6KmcTUDZEmfzqTcWrHAATS2fWHTUhpu6qpbp3KfCu9kkEBJEwsVNInHJmpHUW
         hULY/Vv7mMejr9YEnU9aTA004klppV1+/mcdOJjND0L0RPQ/dMC4Vs0NTKi7WB81caLF
         M2eLtbphpNvFy7HrSiYZcvMUyFM0AlAbXfoWVtD9i0A3/F/2RfRhqRQSX9F+d4vdhBDM
         HQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692077432; x=1692682232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ti6Hb8TH6vlhIU8fUbylq4br6PfU0PeLoAXLYASrGdI=;
        b=e/sj+bJYqqP04lztpixTWe4z+Y7CeFnm0naUuqf/u6AMLCv6bspn5MXihPTdUH6nQH
         1QRzxzJ5/ejH5sJ3CezwzDH+u8qlVvHzlBGxCaT67sZUdAe3NFzbI/ZGt3gGemrAWc3k
         7xeyau2pmuo/aJzFIU781N8ENMElADs/MPueo7c/Hbn8YhdbKsIZPWMm7ch9A7SKM6yR
         zK60al9mf+CZ6moLc4kFtxB3ubcp/JX39WwCzHsElJX7pcR+BfgT8Cv1/sEb8bFb/O0M
         17XGVK2FcXxp8ZQ5ylO1Pf+q7F/ZzblJbwu0Xwn7XLELP91CxBvWXIZb2iFzYWaRVP5I
         d0qA==
X-Gm-Message-State: AOJu0Ywu+i3bMif7FPaGn2+mY18ecpCQMVorPZ+W7YpkT25qwY3+D0Do
	CpoU8d+XnXGQ0mzE0UesssE=
X-Google-Smtp-Source: AGHT+IF49i1d40GlVyjOjaS2v9n4LNaeelSQE2SPN/wXWg/fSCC1AJoZHDmQvpipkQT6oBQCVKKnIA==
X-Received: by 2002:a05:6a20:3d8e:b0:137:7add:b7cd with SMTP id s14-20020a056a203d8e00b001377addb7cdmr15829073pzi.17.1692077432039;
        Mon, 14 Aug 2023 22:30:32 -0700 (PDT)
Received: from localhost ([156.236.96.163])
        by smtp.gmail.com with ESMTPSA id e25-20020aa78c59000000b00682af82a9desm8984573pfd.98.2023.08.14.22.30.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Aug 2023 22:30:31 -0700 (PDT)
Date: Tue, 15 Aug 2023 13:40:10 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 1/2 v2] AOSP: erofs-utils: pass a parameter to write
 tail end in block list
Message-ID: <20230815134010.0000268a.zbestahu@gmail.com>
In-Reply-To: <953e0c41-c3a1-9681-b1a4-723596b0f89c@linux.alibaba.com>
References: <20230815045525.17990-1-zbestahu@gmail.com>
	<953e0c41-c3a1-9681-b1a4-723596b0f89c@linux.alibaba.com>
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

On Tue, 15 Aug 2023 12:59:56 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> On 2023/8/15 12:55, Yue Hu wrote:
> > From: Yue Hu <huyue2@coolpad.com>
> > 
> > We can determine whether the tail block is the first one or not during
> > the writing process.  Therefore, instead of internally checking the
> > block number for the tail block map, just simply pass the flag.
> > 
> > Also, add the missing sbi argument to macro erofs_blknr.  
> 
> Could you submit a patch to fix this issue first?

ok, will do that.

> 
> > 
> > Signed-off-by: Yue Hu <huyue2@coolpad.com>
> > ---
> > v2: change commit message a bit
> > 
> >   include/erofs/block_list.h | 4 ++--
> >   lib/block_list.c           | 5 ++---
> >   lib/inode.c                | 9 +++++++--
> >   3 files changed, 11 insertions(+), 7 deletions(-)
> > 
> > diff --git a/include/erofs/block_list.h b/include/erofs/block_list.h
> > index 78fab44..e0dced8 100644
> > --- a/include/erofs/block_list.h
> > +++ b/include/erofs/block_list.h
> > @@ -19,7 +19,7 @@ void erofs_droid_blocklist_fclose(void);
> >   void erofs_droid_blocklist_write(struct erofs_inode *inode,
> >   				 erofs_blk_t blk_start, erofs_blk_t nblocks);
> >   void erofs_droid_blocklist_write_tail_end(struct erofs_inode *inode,
> > -					  erofs_blk_t blkaddr);
> > +					  erofs_blk_t blkaddr, bool first_block);  
> 
> I still have no idea why we need this, could you describe the Android
> block map details for discussion?

Android block map is just adding file blocks to a range.

So, the tail block should be needed in this range as well. 
I think one simple way is just appending the tail block address in it as below:

/`file_path` `block1_address`-`blockn_address` `tail_block_address`

or

/`file_path` `tail_block_address`   //only one block

> 
> Thanks,
> Gao Xiang

