Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BD33F7A701E
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Sep 2023 04:07:34 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rr23m1DCNz3c1H
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Sep 2023 12:07:32 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rr23b6Mhkz2yV3
	for <linux-erofs@lists.ozlabs.org>; Wed, 20 Sep 2023 12:07:21 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VsT39-l_1695175632;
Received: from 30.97.48.198(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VsT39-l_1695175632)
          by smtp.aliyun-inc.com;
          Wed, 20 Sep 2023 10:07:13 +0800
Message-ID: <d5a14c5f-81df-bc60-ccd5-f70f7b13597d@linux.alibaba.com>
Date: Wed, 20 Sep 2023 10:07:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v1] erofs-utils: lib: Restore memory address before free()
To: Sandeep Dhavale <dhavale@google.com>, linux-erofs@lists.ozlabs.org
References: <20230919210220.3657736-1-dhavale@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230919210220.3657736-1-dhavale@google.com>
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
Cc: kernel-team@android.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Sandeep,

On 2023/9/20 05:02, Sandeep Dhavale wrote:
> We move `idx` pointer as we iterate through for loop based on `count`. If
> we error out from the loop, restore the pointer to allocated memory
> before calling free().
> 
> Fixes: 39147b48b76d ("erofs-utils: lib: add erofs_rebuild_load_tree() helper")
> Signed-off-by: Sandeep Dhavale <dhavale@google.com>

Thanks for the report!

> ---
>   lib/rebuild.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/lib/rebuild.c b/lib/rebuild.c
> index 27a1df4..8739c53 100644
> --- a/lib/rebuild.c
> +++ b/lib/rebuild.c
> @@ -188,6 +188,7 @@ static int erofs_rebuild_fixup_inode_index(struct erofs_inode *inode)
>   	inode->u.chunkformat |= chunkbits - sbi.blkszbits;
>   	return 0;
>   err:
> +	idx = inode->chunkindexes;
>   	free(idx);

I think we could just

	free(inode->chunkindexes);
	inode->chunkindexes = NULL;

I will apply like this directly.

Thanks,
Gao Xiang

>   	inode->chunkindexes = NULL;
>   	return ret;
