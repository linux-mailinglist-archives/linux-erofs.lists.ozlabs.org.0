Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B00F2702896
	for <lists+linux-erofs@lfdr.de>; Mon, 15 May 2023 11:30:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QKYxZ4gYXz3f3k
	for <lists+linux-erofs@lfdr.de>; Mon, 15 May 2023 19:30:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QKYxW0XJtz3bdm
	for <linux-erofs@lists.ozlabs.org>; Mon, 15 May 2023 19:30:06 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VigEqxN_1684143000;
Received: from 30.97.49.11(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VigEqxN_1684143000)
          by smtp.aliyun-inc.com;
          Mon, 15 May 2023 17:30:02 +0800
Message-ID: <ee7d8f0f-042f-57d8-1195-45e3a49e8003@linux.alibaba.com>
Date: Mon, 15 May 2023 17:30:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] erofs: fix null-ptr-deref caused by
 erofs_xattr_prefixes_init
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
 chao@kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
References: <20230515092148.1485-1-jefflexu@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230515092148.1485-1-jefflexu@linux.alibaba.com>
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



On 2023/5/15 02:21, Jingbo Xu wrote:
> Fragments and dedup share one feature bit, and thus packed inode may not
please use the formal name "dedupe".

> exist when fragment feature bit (dedup feature bit exactly) is set, e.g.
                                    ^ dedupe

> when deduplication feature is in use while fragments feature is not.  In
> this case, sbi->packed_inode could be NULL while fragments feature bit
> is set.
> 
> Fix this by accessing packed inode only when it exists.
> 
> Reported-by: syzbot+902d5a9373ae8f748a94@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=902d5a9373ae8f748a94
> Fixes: 9e382914617c ("erofs: add helpers to load long xattr name prefixes")
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
>   fs/erofs/xattr.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
> index cd80499351e0..bbfe7ce170d2 100644
> --- a/fs/erofs/xattr.c
> +++ b/fs/erofs/xattr.c
> @@ -675,7 +675,7 @@ int erofs_xattr_prefixes_init(struct super_block *sb)
>   	if (!pfs)
>   		return -ENOMEM;
>   
> -	if (erofs_sb_has_fragments(sbi))
> +	if (sbi->packed_inode)
>   		buf.inode = sbi->packed_inode;
>   	else
>   		erofs_init_metabuf(&buf, sb);
