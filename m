Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6E477C6DD
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Aug 2023 07:00:18 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RPzbc3Jjxz30fF
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Aug 2023 15:00:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RPzbW6566z2yVf
	for <linux-erofs@lists.ozlabs.org>; Tue, 15 Aug 2023 15:00:06 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VpqOgLC_1692075597;
Received: from 30.97.49.12(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VpqOgLC_1692075597)
          by smtp.aliyun-inc.com;
          Tue, 15 Aug 2023 12:59:59 +0800
Message-ID: <953e0c41-c3a1-9681-b1a4-723596b0f89c@linux.alibaba.com>
Date: Tue, 15 Aug 2023 12:59:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2 v2] AOSP: erofs-utils: pass a parameter to write tail
 end in block list
To: Yue Hu <zbestahu@gmail.com>, linux-erofs@lists.ozlabs.org
References: <20230815045525.17990-1-zbestahu@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230815045525.17990-1-zbestahu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: Yue Hu <huyue2@coolpad.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/8/15 12:55, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> We can determine whether the tail block is the first one or not during
> the writing process.  Therefore, instead of internally checking the
> block number for the tail block map, just simply pass the flag.
> 
> Also, add the missing sbi argument to macro erofs_blknr.

Could you submit a patch to fix this issue first?

> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>
> ---
> v2: change commit message a bit
> 
>   include/erofs/block_list.h | 4 ++--
>   lib/block_list.c           | 5 ++---
>   lib/inode.c                | 9 +++++++--
>   3 files changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/include/erofs/block_list.h b/include/erofs/block_list.h
> index 78fab44..e0dced8 100644
> --- a/include/erofs/block_list.h
> +++ b/include/erofs/block_list.h
> @@ -19,7 +19,7 @@ void erofs_droid_blocklist_fclose(void);
>   void erofs_droid_blocklist_write(struct erofs_inode *inode,
>   				 erofs_blk_t blk_start, erofs_blk_t nblocks);
>   void erofs_droid_blocklist_write_tail_end(struct erofs_inode *inode,
> -					  erofs_blk_t blkaddr);
> +					  erofs_blk_t blkaddr, bool first_block);

I still have no idea why we need this, could you describe the Android
block map details for discussion?

Thanks,
Gao Xiang
