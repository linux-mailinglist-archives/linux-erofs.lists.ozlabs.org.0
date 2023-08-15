Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B03F77C7E4
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Aug 2023 08:35:47 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=Q45M/bUj;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RQ1js1kW3z3c5b
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Aug 2023 16:35:45 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=Q45M/bUj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RQ1jk3Tw6z30NN
	for <linux-erofs@lists.ozlabs.org>; Tue, 15 Aug 2023 16:35:38 +1000 (AEST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bb84194bf3so30788825ad.3
        for <linux-erofs@lists.ozlabs.org>; Mon, 14 Aug 2023 23:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692081336; x=1692686136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qBBs/DEqJXoMggl2yVzH01tWTLsJUgri1Cm87av8QRg=;
        b=Q45M/bUjx/2JenMci8kSm1lAF4yze+fKoQSCbJmDAXsFJTF5BFPrF0ak+CNN0eM8oV
         zuD1HcrRjyQyJNqW+o37HiFBsSKDly6geP9NRDnv5ji1rKBrXKlGA8IamAuKxfV65Y+q
         Tie5hMSvvm8kzJ8TlUgVGKQ641peIrcf51wXNNO8YoK1WJKJ0iDDtPmdlh20FRkK+aDg
         b7sUllmja29Rnqx8c0JRzFm2pC4oIcBMc88O4JR/oDqgcsgmw11sHSu2p7DJ7fc3qcMg
         dP3PnkbKQJC41fuawxNvUMYiVuHSN5jolnkDZ/TbJg8MRDRfLk/ObSFZmXAjDNCU9Z97
         AcAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692081336; x=1692686136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qBBs/DEqJXoMggl2yVzH01tWTLsJUgri1Cm87av8QRg=;
        b=kbiPwg2BdZUpyFpCdOmQfV9CyJuDC2jZ5eXCD83T/Pr45tYZKYDwPReo8ec7Dr/X7B
         nbKQaBc8JqcgBnxKW9kNVy7sLJKOmPHa9HrQqIcbFv+/hkj12xQm8yfUZS/yQ2Q3p04d
         nX5nj94fqvVK1tbnX7Z3BrG8g3ZL4o5D4g1pyUyGDTV/iF4ulp65URaJFiarHShT8UqA
         SAprGoLw1Dk8zOLBszNYGMceiUMqNmbkbelwtHVKOrqyn62Gwoz4Eznb0cKoTEnWbMrQ
         0VGXWuMrn4+E2y97wV0jQXBNukcD1Ib6hWCMgTL7XqYaVn6QEPGI7LqAWgfXH0osSloP
         MZuA==
X-Gm-Message-State: AOJu0YxufWi0huhFtJ7xMENb/xWW+VPXMJIdKdb+u2TZvwr5RWm/Namv
	me5ZFEptZDIex+iZCsJXeAc=
X-Google-Smtp-Source: AGHT+IHsRZ/5oGfaPFesQitESoMn537ghPLzE+pk273BWqz2sJT8xABpNC0RF3Gq/UOg9EA3gePWig==
X-Received: by 2002:a17:902:f68e:b0:1bc:3504:de35 with SMTP id l14-20020a170902f68e00b001bc3504de35mr13980113plg.62.1692081336160;
        Mon, 14 Aug 2023 23:35:36 -0700 (PDT)
Received: from localhost ([156.236.96.163])
        by smtp.gmail.com with ESMTPSA id s3-20020a170902ea0300b001bb9b87ac95sm10428418plg.103.2023.08.14.23.35.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Aug 2023 23:35:36 -0700 (PDT)
Date: Tue, 15 Aug 2023 14:45:15 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 1/2 v2] AOSP: erofs-utils: pass a parameter to write
 tail end in block list
Message-ID: <20230815144515.000031b7.zbestahu@gmail.com>
In-Reply-To: <70f6cf8e-16e2-b08f-9ded-ae0edcb29cb0@linux.alibaba.com>
References: <20230815045525.17990-1-zbestahu@gmail.com>
	<953e0c41-c3a1-9681-b1a4-723596b0f89c@linux.alibaba.com>
	<20230815134010.0000268a.zbestahu@gmail.com>
	<52a561ce-8e57-8f59-c366-c6b3fd9724ba@linux.alibaba.com>
	<20230815142107.00007b58.zbestahu@gmail.com>
	<70f6cf8e-16e2-b08f-9ded-ae0edcb29cb0@linux.alibaba.com>
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

On Tue, 15 Aug 2023 14:18:08 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> On 2023/8/15 14:21, Yue Hu wrote:
> > On Tue, 15 Aug 2023 13:36:46 +0800
> > Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> >   
> >> On 2023/8/15 13:40, Yue Hu wrote:  
> >>> On Tue, 15 Aug 2023 12:59:56 +0800
> >>> Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> >>>      
> >>>> On 2023/8/15 12:55, Yue Hu wrote:  
> >>>>> From: Yue Hu <huyue2@coolpad.com>
> >>>>>
> >>>>> We can determine whether the tail block is the first one or not during
> >>>>> the writing process.  Therefore, instead of internally checking the
> >>>>> block number for the tail block map, just simply pass the flag.
> >>>>>
> >>>>> Also, add the missing sbi argument to macro erofs_blknr.  
> >>>>
> >>>> Could you submit a patch to fix this issue first?  
> >>>
> >>> ok, will do that.
> >>>      
> >>>>     
> >>>>>
> >>>>> Signed-off-by: Yue Hu <huyue2@coolpad.com>
> >>>>> ---
> >>>>> v2: change commit message a bit
> >>>>>
> >>>>>     include/erofs/block_list.h | 4 ++--
> >>>>>     lib/block_list.c           | 5 ++---
> >>>>>     lib/inode.c                | 9 +++++++--
> >>>>>     3 files changed, 11 insertions(+), 7 deletions(-)
> >>>>>
> >>>>> diff --git a/include/erofs/block_list.h b/include/erofs/block_list.h
> >>>>> index 78fab44..e0dced8 100644
> >>>>> --- a/include/erofs/block_list.h
> >>>>> +++ b/include/erofs/block_list.h
> >>>>> @@ -19,7 +19,7 @@ void erofs_droid_blocklist_fclose(void);
> >>>>>     void erofs_droid_blocklist_write(struct erofs_inode *inode,
> >>>>>     				 erofs_blk_t blk_start, erofs_blk_t nblocks);
> >>>>>     void erofs_droid_blocklist_write_tail_end(struct erofs_inode *inode,
> >>>>> -					  erofs_blk_t blkaddr);
> >>>>> +					  erofs_blk_t blkaddr, bool first_block);  
> >>>>
> >>>> I still have no idea why we need this, could you describe the Android
> >>>> block map details for discussion?  
> >>>
> >>> Android block map is just adding file blocks to a range.
> >>>
> >>> So, the tail block should be needed in this range as well.
> >>> I think one simple way is just appending the tail block address in it as below:
> >>>
> >>> /`file_path` `block1_address`-`blockn_address` `tail_block_address`  
> >>
> >> why `tail_block_address` needs a seperate field?  
> > 
> > Well, `erofs_write_tail_end()` is a separate logic and i think appending this block is
> > simple enough since i don't need to consider whether the block address is contiguous
> > with previous one.
> > 
> > And i think Android block map can handle this since i have saw below in ext4:
> > 
> > /system/.../libclang_rt.ubsan_standalone-arm-android.so 51276-51309 0 51310-51403  
> 
> What's the meaning of 0 here?

I have not check that yet, maybe i need to find time... 

And check this: "/.../libxxx.so 87378-88630 0 0 0 88631 0 0 88632-88637 0 0 0 88638-88663"

so, i guess it looks like null block.

> 
> Thanks,
> Gao Xiang
> 

