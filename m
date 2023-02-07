Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA7068D174
	for <lists+linux-erofs@lfdr.de>; Tue,  7 Feb 2023 09:27:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4P9x806NHfz3cKB
	for <lists+linux-erofs@lfdr.de>; Tue,  7 Feb 2023 19:27:28 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4P9x7v5qMYz3bTS
	for <linux-erofs@lists.ozlabs.org>; Tue,  7 Feb 2023 19:27:22 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Vb6WRLm_1675758436;
Received: from 30.221.130.169(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vb6WRLm_1675758436)
          by smtp.aliyun-inc.com;
          Tue, 07 Feb 2023 16:27:17 +0800
Message-ID: <c08e9251-79ef-d43c-27e2-c5b5e535f322@linux.alibaba.com>
Date: Tue, 7 Feb 2023 16:27:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 1/6] erofs: get rid of erofs_inode_datablocks()
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org,
 Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>
References: <20230204093040.97967-1-hsiangkao@linux.alibaba.com>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20230204093040.97967-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2/4/23 5:30 PM, Gao Xiang wrote:
> erofs_inode_datablocks() has the only one caller, let's just get
> rid of it entirely.  No logic changes.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>


> ---
>  fs/erofs/internal.h |  6 ------
>  fs/erofs/namei.c    | 18 +++++-------------
>  2 files changed, 5 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 08ba817d6551..c18af21ba9c4 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -344,12 +344,6 @@ static inline erofs_off_t erofs_iloc(struct inode *inode)
>  		(EROFS_I(inode)->nid << sbi->islotbits);
>  }
>  
> -static inline unsigned long erofs_inode_datablocks(struct inode *inode)
> -{
> -	/* since i_size cannot be changed */
> -	return DIV_ROUND_UP(inode->i_size, EROFS_BLKSIZ);
> -}
> -
>  static inline unsigned int erofs_bitrange(unsigned int value, unsigned int bit,
>  					  unsigned int bits)
>  {
> diff --git a/fs/erofs/namei.c b/fs/erofs/namei.c
> index b64a108fac92..966eabc61c13 100644
> --- a/fs/erofs/namei.c
> +++ b/fs/erofs/namei.c
> @@ -5,7 +5,6 @@
>   * Copyright (C) 2022, Alibaba Cloud
>   */
>  #include "xattr.h"
> -
>  #include <trace/events/erofs.h>
>  
>  struct erofs_qstr {
> @@ -87,19 +86,13 @@ static struct erofs_dirent *find_target_dirent(struct erofs_qstr *name,
>  	return ERR_PTR(-ENOENT);
>  }
>  
> -static void *find_target_block_classic(struct erofs_buf *target,
> -				       struct inode *dir,
> -				       struct erofs_qstr *name,
> -				       int *_ndirents)
> +static void *erofs_find_target_block(struct erofs_buf *target,
> +		struct inode *dir, struct erofs_qstr *name, int *_ndirents)
>  {
> -	unsigned int startprfx, endprfx;
> -	int head, back;
> +	int head = 0, back = DIV_ROUND_UP(dir->i_size, EROFS_BLKSIZ) - 1;
> +	unsigned int startprfx = 0, endprfx = 0;
>  	void *candidate = ERR_PTR(-ENOENT);
>  
> -	startprfx = endprfx = 0;
> -	head = 0;
> -	back = erofs_inode_datablocks(dir) - 1;
> -
>  	while (head <= back) {
>  		const int mid = head + (back - head) / 2;
>  		struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
> @@ -180,8 +173,7 @@ int erofs_namei(struct inode *dir, const struct qstr *name, erofs_nid_t *nid,
>  	qn.end = name->name + name->len;
>  
>  	ndirents = 0;
> -
> -	de = find_target_block_classic(&buf, dir, &qn, &ndirents);
> +	de = erofs_find_target_block(&buf, dir, &qn, &ndirents);
>  	if (IS_ERR(de))
>  		return PTR_ERR(de);
>  

-- 
Thanks,
Jingbo
