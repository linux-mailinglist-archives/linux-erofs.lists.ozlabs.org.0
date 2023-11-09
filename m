Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B1A7E6B14
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Nov 2023 14:15:02 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SR2Vr2BMDz3cBQ
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Nov 2023 00:15:00 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=47.90.199.12; helo=out199-12.us.a.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out199-12.us.a.mail.aliyun.com (out199-12.us.a.mail.aliyun.com [47.90.199.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SR2Vk1jLlz3byP
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Nov 2023 00:14:51 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vw14L0V_1699535659;
Received: from 30.27.116.104(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vw14L0V_1699535659)
          by smtp.aliyun-inc.com;
          Thu, 09 Nov 2023 21:14:21 +0800
Message-ID: <4d4202a7-6648-9d2c-3f0b-079a165c2ebf@linux.alibaba.com>
Date: Thu, 9 Nov 2023 21:14:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH -next V2] erofs: code clean up for function
 erofs_read_inode()
To: WoZ1zh1 <wozizhi@huawei.com>, xiang@kernel.org, chao@kernel.org
References: <20231109194821.1719430-1-wozizhi@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20231109194821.1719430-1-wozizhi@huawei.com>
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
Cc: yangerkun@huawei.com, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi,

On 2023/11/10 03:48, WoZ1zh1 wrote:
> Because variables "die" and "copied" only appear in case
> EROFS_INODE_LAYOUT_EXTENDED, move them from the outer space into this
> case. Also, call "kfree(copied)" earlier to avoid double free in the
> "error_out" branch. Some cleanups, no logic changes.
> 
> Signed-off-by: WoZ1zh1 <wozizhi@huawei.com>

Please help use your real name here...

> ---
>   fs/erofs/inode.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index b8ad05b4509d..a388c93eec34 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -19,7 +19,6 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>   	erofs_blk_t blkaddr, nblks = 0;
>   	void *kaddr;
>   	struct erofs_inode_compact *dic;
> -	struct erofs_inode_extended *die, *copied = NULL;
>   	unsigned int ifmt;
>   	int err;
>   
> @@ -53,6 +52,8 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>   
>   	switch (erofs_inode_version(ifmt)) {
>   	case EROFS_INODE_LAYOUT_EXTENDED:
> +		struct erofs_inode_extended *die, *copied = NULL;

Thanks for the patch, but in my own opinion:

1) It doesn't simplify the code

2) We'd like to avoid defining variables like this (in the
    switch block), and I even don't think this patch can compile.

3) The logic itself is also broken...

Thanks,
Gao Xiang

> +
>   		vi->inode_isize = sizeof(struct erofs_inode_extended);
>   		/* check if the extended inode acrosses block boundary */
>   		if (*ofs + vi->inode_isize <= sb->s_blocksize) {
> @@ -98,6 +99,7 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>   			inode->i_rdev = 0;
>   			break;
>   		default:
> +			kfree(copied);
>   			goto bogusimode;
>   		}
>   		i_uid_write(inode, le32_to_cpu(die->i_uid));
> @@ -117,7 +119,6 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>   			/* fill chunked inode summary info */
>   			vi->chunkformat = le16_to_cpu(die->i_u.c.format);
>   		kfree(copied);
> -		copied = NULL;
>   		break;
>   	case EROFS_INODE_LAYOUT_COMPACT:
>   		vi->inode_isize = sizeof(struct erofs_inode_compact);
> @@ -197,7 +198,6 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>   	err = -EFSCORRUPTED;
>   err_out:
>   	DBG_BUGON(1);
> -	kfree(copied);
>   	erofs_put_metabuf(buf);
>   	return ERR_PTR(err);
>   }
