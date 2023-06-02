Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D1471FE20
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Jun 2023 11:43:20 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QXdNQ0pw1z3dy2
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Jun 2023 19:43:18 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QXdNM73kdz3cCn
	for <linux-erofs@lists.ozlabs.org>; Fri,  2 Jun 2023 19:43:15 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Vk9Uqc._1685698989;
Received: from 30.97.48.207(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vk9Uqc._1685698989)
          by smtp.aliyun-inc.com;
          Fri, 02 Jun 2023 17:43:10 +0800
Message-ID: <03a4db6b-5134-ccd1-847c-90eb8a1b341f@linux.alibaba.com>
Date: Fri, 2 Jun 2023 17:43:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] erofs-utils: dump: read packed inode only by valid
 packed_nid
To: Yue Hu <zbestahu@gmail.com>, linux-erofs@lists.ozlabs.org
References: <b07be6197e879b8200b4c25f91957d6a206dc143.1685697802.git.huyue2@coolpad.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <b07be6197e879b8200b4c25f91957d6a206dc143.1685697802.git.huyue2@coolpad.com>
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
Cc: sunshijie@xiaomi.com, huyue2@coolpad.com, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/6/2 17:37, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> Since dedupe feature is also using the same feature bit as fragments.
> Meanwhile, add missing dedupe feature to feature_lists[].
> 
> Fixes: a6336feefe37 ("erofs-utils: dump: support fragments")
> Signed-off-by: Yue Hu <huyue2@coolpad.com>

We should check both
erofs_sb_has_fragments() && sbi.packed_nid > 0 here.

Thanks,
Gao Xiang

> ---
>   dump/main.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/dump/main.c b/dump/main.c
> index fd1923f..b9aa0f5 100644
> --- a/dump/main.c
> +++ b/dump/main.c
> @@ -99,6 +99,7 @@ static struct erofsdump_feature feature_lists[] = {
>   	{ false, EROFS_FEATURE_INCOMPAT_DEVICE_TABLE, "device_table" },
>   	{ false, EROFS_FEATURE_INCOMPAT_ZTAILPACKING, "ztailpacking" },
>   	{ false, EROFS_FEATURE_INCOMPAT_FRAGMENTS, "fragments" },
> +	{ false, EROFS_FEATURE_INCOMPAT_DEDUPE, "dedupe" },
>   };
>   
>   static int erofsdump_readdir(struct erofs_dir_context *ctx);
> @@ -273,7 +274,7 @@ static int erofsdump_read_packed_inode(void)
>   	erofs_off_t occupied_size = 0;
>   	struct erofs_inode vi = { .nid = sbi.packed_nid };
>   
> -	if (!erofs_sb_has_fragments())
> +	if (!sbi.packed_nid)
>   		return 0;
>   
>   	err = erofs_read_inode_from_disk(&vi);
> @@ -605,7 +606,7 @@ static void erofsdump_show_superblock(void)
>   			sbi.xattr_blkaddr);
>   	fprintf(stdout, "Filesystem root nid:                          %llu\n",
>   			sbi.root_nid | 0ULL);
> -	if (erofs_sb_has_fragments())
> +	if (sbi.packed_nid > 0)
>   		fprintf(stdout, "Filesystem packed nid:                        %llu\n",
>   			sbi.packed_nid | 0ULL);
>   	fprintf(stdout, "Filesystem inode count:                       %llu\n",
