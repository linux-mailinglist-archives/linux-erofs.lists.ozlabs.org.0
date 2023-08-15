Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FEF77C781
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Aug 2023 08:11:45 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=rKeHCIeQ;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RQ1B72fQkz3bX1
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Aug 2023 16:11:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=rKeHCIeQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::c29; helo=mail-oo1-xc29.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RQ19z45rmz309D
	for <linux-erofs@lists.ozlabs.org>; Tue, 15 Aug 2023 16:11:33 +1000 (AEST)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-56c4c4e822eso3786034eaf.3
        for <linux-erofs@lists.ozlabs.org>; Mon, 14 Aug 2023 23:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692079888; x=1692684688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kg111ndsm5U7DPukON9q6Q9W0xIVYixt1Nv9+8KSHwI=;
        b=rKeHCIeQgwqGBVBgqqWJ5HfGCmQz1oKkeX5MIRQF8t4jzJ4xYN2KXkWlB7Lc7G8wCk
         o/IPE+DVEjNK//umFJ1XnVn0a2vkplhePxGwRATG/bwH9kjB1SivWD5K1qO7WJtkIPRI
         w8pzSh43kBEF57FKgIdB64EBm6sYPtbfIdRp3G0g6j8snqM2m+iaz/5lIDz4IMtzXHLH
         sIclo7NBzX3NPxUuyiRiDxlnqwr6IowzH2toWqJPRLMofkuQktxXQvo6PQlh0c+chCaf
         HL6j5W2RAyYJ/voOt6uaBiz5sS/Ydo98jjEYWF55xmhucf7DLlerV4uvdrcOUbM7720Z
         x99g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692079888; x=1692684688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kg111ndsm5U7DPukON9q6Q9W0xIVYixt1Nv9+8KSHwI=;
        b=eAhFpAAokleup0adSRJARHa41BoWZIXcw+ZrGapI/InoKNC/4JJc3+pjnHDbrw/hFX
         rHKLkD0vJUPjASKOCT6XYdRATT/5Bmuxp1055feFTE1UBQOAM5jy+rg3Tyiqs1ezwd2y
         P2nxzPntzoFFdC2XEMeYUio7HD0b4sIQsP+6qYf59GQlwmZYIiDmk6fuoY2dKZ0eJbip
         hBlaVV6odx7wAjDxdEkzFmV40akfEC0oPpg+asdjoBOIyZPzxE169oXGe/JXDvUlu3Xd
         nGcxtKV34dmRqOe1i0HZuItsZawHi7IEjTPEfcRTN/4aXUER9pPSdw3WQLBRxUUR1Ih7
         El6Q==
X-Gm-Message-State: AOJu0Yx4E80ro07tv/3DDwHQWB40SBnpm7mkfM+ZPGm76zwYtNPO8vRC
	V6H3F/iKa07HA2/VVbDO9dW/L/oYc1c=
X-Google-Smtp-Source: AGHT+IFKIxIS4S8vZgwjL5NNjERkk/t7aLzFbPnPrWrltVYAKq3Hvu8OxKyh9nqUlzdYsWCpcBYqAA==
X-Received: by 2002:a05:6871:28e:b0:1bb:e381:e1f1 with SMTP id i14-20020a056871028e00b001bbe381e1f1mr14136658oae.9.1692079888532;
        Mon, 14 Aug 2023 23:11:28 -0700 (PDT)
Received: from localhost ([156.236.96.163])
        by smtp.gmail.com with ESMTPSA id d7-20020a17090ad98700b002692e06bc36sm10763027pjv.30.2023.08.14.23.11.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Aug 2023 23:11:28 -0700 (PDT)
Date: Tue, 15 Aug 2023 14:21:07 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 1/2 v2] AOSP: erofs-utils: pass a parameter to write
 tail end in block list
Message-ID: <20230815142107.00007b58.zbestahu@gmail.com>
In-Reply-To: <52a561ce-8e57-8f59-c366-c6b3fd9724ba@linux.alibaba.com>
References: <20230815045525.17990-1-zbestahu@gmail.com>
	<953e0c41-c3a1-9681-b1a4-723596b0f89c@linux.alibaba.com>
	<20230815134010.0000268a.zbestahu@gmail.com>
	<52a561ce-8e57-8f59-c366-c6b3fd9724ba@linux.alibaba.com>
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

On Tue, 15 Aug 2023 13:36:46 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> On 2023/8/15 13:40, Yue Hu wrote:
> > On Tue, 15 Aug 2023 12:59:56 +0800
> > Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> >   
> >> On 2023/8/15 12:55, Yue Hu wrote:  
> >>> From: Yue Hu <huyue2@coolpad.com>
> >>>
> >>> We can determine whether the tail block is the first one or not during
> >>> the writing process.  Therefore, instead of internally checking the
> >>> block number for the tail block map, just simply pass the flag.
> >>>
> >>> Also, add the missing sbi argument to macro erofs_blknr.  
> >>
> >> Could you submit a patch to fix this issue first?  
> > 
> > ok, will do that.
> >   
> >>  
> >>>
> >>> Signed-off-by: Yue Hu <huyue2@coolpad.com>
> >>> ---
> >>> v2: change commit message a bit
> >>>
> >>>    include/erofs/block_list.h | 4 ++--
> >>>    lib/block_list.c           | 5 ++---
> >>>    lib/inode.c                | 9 +++++++--
> >>>    3 files changed, 11 insertions(+), 7 deletions(-)
> >>>
> >>> diff --git a/include/erofs/block_list.h b/include/erofs/block_list.h
> >>> index 78fab44..e0dced8 100644
> >>> --- a/include/erofs/block_list.h
> >>> +++ b/include/erofs/block_list.h
> >>> @@ -19,7 +19,7 @@ void erofs_droid_blocklist_fclose(void);
> >>>    void erofs_droid_blocklist_write(struct erofs_inode *inode,
> >>>    				 erofs_blk_t blk_start, erofs_blk_t nblocks);
> >>>    void erofs_droid_blocklist_write_tail_end(struct erofs_inode *inode,
> >>> -					  erofs_blk_t blkaddr);
> >>> +					  erofs_blk_t blkaddr, bool first_block);  
> >>
> >> I still have no idea why we need this, could you describe the Android
> >> block map details for discussion?  
> > 
> > Android block map is just adding file blocks to a range.
> > 
> > So, the tail block should be needed in this range as well.
> > I think one simple way is just appending the tail block address in it as below:
> > 
> > /`file_path` `block1_address`-`blockn_address` `tail_block_address`  
> 
> why `tail_block_address` needs a seperate field?

Well, `erofs_write_tail_end()` is a separate logic and i think appending this block is
simple enough since i don't need to consider whether the block address is contiguous
with previous one.

And i think Android block map can handle this since i have saw below in ext4:

/system/.../libclang_rt.ubsan_standalone-arm-android.so 51276-51309 0 51310-51403

> 
> > 
> > or
> > 
> > /`file_path` `tail_block_address`   //only one block  
> 
> how about recording the previous inode pointer as an internal global variable?
> if it's not the same inode, trigger "\n" immediately.
> 
> and generate files as:
> " `block1_address`-`blockn_address`"  for many blocks;
> " `block1_address`" for a single block?

Let me check.

> 
> Thanks,
> Gao Xiang

