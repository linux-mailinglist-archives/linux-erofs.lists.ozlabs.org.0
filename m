Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A7D77C81D
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Aug 2023 08:50:55 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=GTtw7kcS;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RQ23J6HDgz3bc0
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Aug 2023 16:50:52 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=GTtw7kcS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RQ23D53dHz2yVp
	for <linux-erofs@lists.ozlabs.org>; Tue, 15 Aug 2023 16:50:47 +1000 (AEST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bdbbede5d4so31174045ad.2
        for <linux-erofs@lists.ozlabs.org>; Mon, 14 Aug 2023 23:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692082244; x=1692687044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1HEp3XtRdvIs5VDLFrCQX4zg0yyTRrj4tszI8loP4A=;
        b=GTtw7kcS1mmjV31pp+8NvCPLzu0HL+sNIaXarpa0U8xraztJip+x4wlxgnTLEvJQGx
         uKSs+AxXUpImHtAyBa8eY7pkEh87JiIwSehrbXxC/QT0Q1D+ltDekdQ7bbxrH9XmDF1g
         hQnUXgHAWrcL/2+nfFtXNjnRXiPxo/bdg8I7qlhVUJGQ43Nq6oVbmloYeDyMU6dI3f/M
         xNo5Nv610ge+vSz3OiRmYh6N9dX9z632imiBKj4oJgb7mlxbn6k91fmopPQy5C43nYSE
         u+LA33lSWANKotSB1QMhl4xQhvSb2mVuzhMItKOn8K/DM2+gTmM6g7kQAmut+MEi5DHg
         FCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692082244; x=1692687044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K1HEp3XtRdvIs5VDLFrCQX4zg0yyTRrj4tszI8loP4A=;
        b=RXJMzte6b+Eet5sbld1vOrcCIeewP27eSiAsRvSHhD2HJIjJbntxwWwbvgVv+eaC1O
         a+IHY2ojuI31uePmDCVYaTbZCG50bWQumPDn8zrHdB8GeYPIG6aO2QWt0umVNOECcHyt
         QJ3i7jb7ejxcmBQvjnPCpQ9zwaeHQ2I+7wvRGKnRQbna5ftjnUgPy+jSQIHFs+TdSSaa
         bUDToqD3GUxLbgj48K5c6zeGKyWnDIyuDaZBxBVoSc68jwxxDMdNy1whTyQSsBOh0rBL
         aOXFLo5130zcvL0LmZeQyUQX5yr4FnS3TalrTqyj9BILYMeV994uGjczFQHbvS4eh+8k
         FPIA==
X-Gm-Message-State: AOJu0YxA5Ul6yZ66vXR3vcv6OgBXzt3oiEDtca0HHLFcEgEOy45RoErX
	M24jJYy21ZkTBO93BK4vicR1GdL0bIU=
X-Google-Smtp-Source: AGHT+IENJL3+ztq6ePULZA9o6rv0DAb2uWKHF9wR+hWJHa+YXTKFgDGRT6KVhFkBSCyoZVKyvJqEpg==
X-Received: by 2002:a17:903:41d2:b0:1bc:210d:635f with SMTP id u18-20020a17090341d200b001bc210d635fmr15709863ple.28.1692082244298;
        Mon, 14 Aug 2023 23:50:44 -0700 (PDT)
Received: from localhost ([156.236.96.163])
        by smtp.gmail.com with ESMTPSA id 4-20020a170902c14400b001bdeb6bdfbasm2534675plj.241.2023.08.14.23.50.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Aug 2023 23:50:44 -0700 (PDT)
Date: Tue, 15 Aug 2023 15:00:23 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 1/2 v2] AOSP: erofs-utils: pass a parameter to write
 tail end in block list
Message-ID: <20230815150023.00001c8b.zbestahu@gmail.com>
In-Reply-To: <c31a3fb2-eb7a-9b99-6e2c-981f108db671@linux.alibaba.com>
References: <20230815045525.17990-1-zbestahu@gmail.com>
	<953e0c41-c3a1-9681-b1a4-723596b0f89c@linux.alibaba.com>
	<20230815134010.0000268a.zbestahu@gmail.com>
	<52a561ce-8e57-8f59-c366-c6b3fd9724ba@linux.alibaba.com>
	<20230815142107.00007b58.zbestahu@gmail.com>
	<70f6cf8e-16e2-b08f-9ded-ae0edcb29cb0@linux.alibaba.com>
	<20230815144515.000031b7.zbestahu@gmail.com>
	<c31a3fb2-eb7a-9b99-6e2c-981f108db671@linux.alibaba.com>
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

On Tue, 15 Aug 2023 14:44:23 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> On 2023/8/15 14:45, Yue Hu wrote:
> > On Tue, 15 Aug 2023 14:18:08 +0800
> > Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> >   
> >> On 2023/8/15 14:21, Yue Hu wrote:  
> >>> On Tue, 15 Aug 2023 13:36:46 +0800
> >>> Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> >>>      
> >>>> On 2023/8/15 13:40, Yue Hu wrote:  
> >>>>> On Tue, 15 Aug 2023 12:59:56 +0800
> >>>>> Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> >>>>>         
> >>>>>> On 2023/8/15 12:55, Yue Hu wrote:  
> >>>>>>> From: Yue Hu <huyue2@coolpad.com>
> >>>>>>>
> >>>>>>> We can determine whether the tail block is the first one or not during
> >>>>>>> the writing process.  Therefore, instead of internally checking the
> >>>>>>> block number for the tail block map, just simply pass the flag.
> >>>>>>>
> >>>>>>> Also, add the missing sbi argument to macro erofs_blknr.  
> >>>>>>
> >>>>>> Could you submit a patch to fix this issue first?  
> >>>>>
> >>>>> ok, will do that.
> >>>>>         
> >>>>>>        
> >>>>>>>
> >>>>>>> Signed-off-by: Yue Hu <huyue2@coolpad.com>
> >>>>>>> ---
> >>>>>>> v2: change commit message a bit
> >>>>>>>
> >>>>>>>      include/erofs/block_list.h | 4 ++--
> >>>>>>>      lib/block_list.c           | 5 ++---
> >>>>>>>      lib/inode.c                | 9 +++++++--
> >>>>>>>      3 files changed, 11 insertions(+), 7 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/include/erofs/block_list.h b/include/erofs/block_list.h
> >>>>>>> index 78fab44..e0dced8 100644
> >>>>>>> --- a/include/erofs/block_list.h
> >>>>>>> +++ b/include/erofs/block_list.h
> >>>>>>> @@ -19,7 +19,7 @@ void erofs_droid_blocklist_fclose(void);
> >>>>>>>      void erofs_droid_blocklist_write(struct erofs_inode *inode,
> >>>>>>>      				 erofs_blk_t blk_start, erofs_blk_t nblocks);
> >>>>>>>      void erofs_droid_blocklist_write_tail_end(struct erofs_inode *inode,
> >>>>>>> -					  erofs_blk_t blkaddr);
> >>>>>>> +					  erofs_blk_t blkaddr, bool first_block);  
> >>>>>>
> >>>>>> I still have no idea why we need this, could you describe the Android
> >>>>>> block map details for discussion?  
> >>>>>
> >>>>> Android block map is just adding file blocks to a range.
> >>>>>
> >>>>> So, the tail block should be needed in this range as well.
> >>>>> I think one simple way is just appending the tail block address in it as below:
> >>>>>
> >>>>> /`file_path` `block1_address`-`blockn_address` `tail_block_address`  
> >>>>
> >>>> why `tail_block_address` needs a seperate field?  
> >>>
> >>> Well, `erofs_write_tail_end()` is a separate logic and i think appending this block is
> >>> simple enough since i don't need to consider whether the block address is contiguous
> >>> with previous one.
> >>>
> >>> And i think Android block map can handle this since i have saw below in ext4:
> >>>
> >>> /system/.../libclang_rt.ubsan_standalone-arm-android.so 51276-51309 0 51310-51403  
> >>
> >> What's the meaning of 0 here?  
> > 
> > I have not check that yet, maybe i need to find time...
> > 
> > And check this: "/.../libxxx.so 87378-88630 0 0 0 88631 0 0 88632-88637 0 0 0 88638-88663"
> > 
> > so, i guess it looks like null block.  
> 
> So here erofs_droid_blocklist_write_tail_end is not actually needed in principle?
> 0 is just used for sparse block?

We need to confirm this.

> 
> Thanks,
> Gao Xiang

