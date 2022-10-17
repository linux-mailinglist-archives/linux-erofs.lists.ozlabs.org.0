Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5B3600614
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Oct 2022 06:59:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MrPsk1DHGz3drh
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Oct 2022 15:59:06 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MrPsb4vZXz3dqw
	for <linux-erofs@lists.ozlabs.org>; Mon, 17 Oct 2022 15:58:57 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VSHTNAs_1665982730;
Received: from 30.221.131.120(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VSHTNAs_1665982730)
          by smtp.aliyun-inc.com;
          Mon, 17 Oct 2022 12:58:51 +0800
Message-ID: <a8fee658-5538-0f6c-c6fb-d3dd56099e76@linux.alibaba.com>
Date: Mon, 17 Oct 2022 12:58:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: [PATCH v2] erofs: protect s_inodes with s_inode_list_lock
Content-Language: en-US
To: Dawei Li <set_pte_at@outlook.com>, xiang@kernel.org, chao@kernel.org
References: <TYCP286MB23238380DE3B74874E8D78ABCA299@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
From: JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <TYCP286MB23238380DE3B74874E8D78ABCA299@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
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
Cc: huyue2@coolpad.com, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 10/17/22 9:55 AM, Dawei Li wrote:
> s_inodes is superblock-specific resource, which should be
> protected by sb's specific lock s_inode_list_lock.
> 
> v2: update the locking mechanisim to protect mutual-exclusive access
> both for s_inode_list_lock & erofs_fscache_domain_init_cookie(), as the
> reviewing comments from Jia Zhu.
> 
> v1: https://lore.kernel.org/all/TYCP286MB23237A9993E0FFCFE5C2BDBECA269@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM/
> 
> base-commit: 8436c4a57bd147b0bd2943ab499bb8368981b9e1
> 
> Signed-off-by: Dawei Li <set_pte_at@outlook.com>

Fixes: 7d41963759fe ("erofs: Support sharing cookies in the same domain")

LGTM.

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>

> ---
>  fs/erofs/fscache.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 998cd26a1b3b..fe05bc51f9f2 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -590,14 +590,17 @@ struct erofs_fscache *erofs_domain_register_cookie(struct super_block *sb,
>  	struct super_block *psb = erofs_pseudo_mnt->mnt_sb;
>  
>  	mutex_lock(&erofs_domain_cookies_lock);
> +	spin_lock(&psb->s_inode_list_lock);
>  	list_for_each_entry(inode, &psb->s_inodes, i_sb_list) {
>  		ctx = inode->i_private;
>  		if (!ctx || ctx->domain != domain || strcmp(ctx->name, name))
>  			continue;
>  		igrab(inode);
> +		spin_unlock(&psb->s_inode_list_lock);
>  		mutex_unlock(&erofs_domain_cookies_lock);
>  		return ctx;
>  	}
> +	spin_unlock(&psb->s_inode_list_lock);
>  	ctx = erofs_fscache_domain_init_cookie(sb, name, need_inode);
>  	mutex_unlock(&erofs_domain_cookies_lock);
>  	return ctx;

-- 
Thanks,
Jingbo
