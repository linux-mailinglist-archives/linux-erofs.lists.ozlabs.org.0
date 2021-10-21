Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDBA435BAB
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Oct 2021 09:26:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HZfD0731Dz2yg4
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Oct 2021 18:26:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.44;
 helo=out30-44.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HZfCy1x3rz2xZ3
 for <linux-erofs@lists.ozlabs.org>; Thu, 21 Oct 2021 18:26:05 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R791e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=6; SR=0; TI=SMTPD_---0Ut73.mA_1634801149; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0Ut73.mA_1634801149) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 21 Oct 2021 15:25:51 +0800
Date: Thu, 21 Oct 2021 15:25:49 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Huang Jianan <huangjianan@oppo.com>
Subject: Re: [PATCH] erofs-utils: sort shared xattr
Message-ID: <YXEV/e/lGn4S5fym@B-P7TQMD6M-0146.local>
References: <20211021025847.1136-1-huangjianan@oppo.com>
 <20211021025847.1136-2-huangjianan@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211021025847.1136-2-huangjianan@oppo.com>
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
Cc: yh@oppo.com, guoweichao@oppo.com, linux-erofs@lists.ozlabs.org,
 zhangshiming@oppo.com, guanyuwei@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Jianan,

On Thu, Oct 21, 2021 at 10:58:47AM +0800, Huang Jianan via Linux-erofs wrote:
> Sort shared xattr before writing to disk to ensure the consistency
> of reproducible builds.

How about adding it as an option?

> ---
>  lib/xattr.c | 34 ++++++++++++++++++++++++++++++----
>  1 file changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/xattr.c b/lib/xattr.c
> index 196133a..f17e57e 100644
> --- a/lib/xattr.c
> +++ b/lib/xattr.c
> @@ -171,7 +171,7 @@ static struct xattr_item *parse_one_xattr(const char *path, const char *key,
>  	/* allocate key-value buffer */
>  	len[0] = keylen - prefixlen;
>  
> -	kvbuf = malloc(len[0] + len[1]);
> +	kvbuf = malloc(len[0] + len[1] + 1);
>  	if (!kvbuf)
>  		return ERR_PTR(-ENOMEM);
>  	memcpy(kvbuf, key + prefixlen, len[0]);
> @@ -196,6 +196,7 @@ static struct xattr_item *parse_one_xattr(const char *path, const char *key,
>  			len[1] = ret;
>  		}
>  	}
> +	kvbuf[len[0] + len[1]] = '\0';
>  	return get_xattritem(prefix, kvbuf, len);
>  }
>  
> @@ -398,7 +399,7 @@ static int erofs_droid_xattr_set_caps(struct erofs_inode *inode)
>  	len[0] = sizeof("capability") - 1;
>  	len[1] = sizeof(caps);
>  
> -	kvbuf = malloc(len[0] + len[1]);
> +	kvbuf = malloc(len[0] + len[1] + 1);
>  	if (!kvbuf)
>  		return -ENOMEM;
>  
> @@ -409,6 +410,7 @@ static int erofs_droid_xattr_set_caps(struct erofs_inode *inode)
>  	caps.data[1].permitted = (u32) (capabilities >> 32);
>  	caps.data[1].inheritable = 0;
>  	memcpy(kvbuf + len[0], &caps, len[1]);
> +	kvbuf[len[0] + len[1]] = '\0';
>  
>  	item = get_xattritem(EROFS_XATTR_INDEX_SECURITY, kvbuf, len);
>  	if (IS_ERR(item))
> @@ -562,13 +564,23 @@ static struct erofs_bhops erofs_write_shared_xattrs_bhops = {
>  	.flush = erofs_bh_flush_write_shared_xattrs,
>  };
>  
> +static int comp_xattr_item(const void *a, const void *b)
> +{
> +	const struct xattr_item *ia, *ib;
> +
> +	ia = (*((const struct inode_xattr_node **)a))->item;
> +	ib = (*((const struct inode_xattr_node **)b))->item;
> +
> +	return strcmp(ia->kvbuf, ib->kvbuf);

could we use strncmp (len[0] + len[1]) instead?

Thanks,
Gao Xiang
