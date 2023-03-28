Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE086CB94A
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Mar 2023 10:24:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Pm2lV6dJHz3f3q
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Mar 2023 19:24:06 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Pm2lR5qbZz3cMn
	for <linux-erofs@lists.ozlabs.org>; Tue, 28 Mar 2023 19:24:03 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VesNAiw_1679991838;
Received: from 30.221.134.40(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VesNAiw_1679991838)
          by smtp.aliyun-inc.com;
          Tue, 28 Mar 2023 16:23:59 +0800
Message-ID: <ae65829a-b2a6-281d-8d46-2c93d32f506a@linux.alibaba.com>
Date: Tue, 28 Mar 2023 16:23:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH 2/8] erofs: rename init_inode_xattrs with erofs_ prefix
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
 chao@kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
References: <20230323000949.57608-1-jefflexu@linux.alibaba.com>
 <20230323000949.57608-3-jefflexu@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230323000949.57608-3-jefflexu@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/3/23 08:09, Jingbo Xu wrote:
> Rename init_inode_xattrs() to erofs_init_inode_xattrs() without logic
> change.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>   fs/erofs/xattr.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
> index 760ec864a39c..ab4517e5ec84 100644
> --- a/fs/erofs/xattr.c
> +++ b/fs/erofs/xattr.c
> @@ -29,7 +29,7 @@ struct xattr_iter {
>   	unsigned int ofs;
>   };
>   
> -static int init_inode_xattrs(struct inode *inode)
> +static int erofs_init_inode_xattrs(struct inode *inode)
>   {
>   	struct erofs_inode *const vi = EROFS_I(inode);
>   	struct xattr_iter it;
> @@ -404,7 +404,7 @@ static int erofs_getxattr(struct inode *inode, int index, const char *name,
>   	if (!name)
>   		return -EINVAL;
>   
> -	ret = init_inode_xattrs(inode);
> +	ret = erofs_init_inode_xattrs(inode);
>   	if (ret)
>   		return ret;
>   
> @@ -619,7 +619,7 @@ ssize_t erofs_listxattr(struct dentry *dentry,
>   	int ret;
>   	struct listxattr_iter it;
>   
> -	ret = init_inode_xattrs(d_inode(dentry));
> +	ret = erofs_init_inode_xattrs(d_inode(dentry));
>   	if (ret == -ENOATTR)
>   		return 0;
>   	if (ret)
