Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 425658ACA93
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Apr 2024 12:28:45 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=K2WRiXI6;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VNM0p6fg8z3cXp
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Apr 2024 20:28:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=K2WRiXI6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VNM0j40xKz2xPV
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Apr 2024 20:28:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713781713; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=gWL5KmH7ENYsfhAdB+kRUH6QuA27iEhkYX5LDP+D93c=;
	b=K2WRiXI64HLMi/5kahyzpfKf2vu7TTJ1aYvfFuC/z40mnIHm+i9clTrA0Eb5K3qHOLnD29HGcz5n8ciFj2rHd8geBlpbf42YGvkEr/EPCjiDLCo3C0vW3OPrOMbapBB/Czdv/JHfUawFnuHe0Yn1Df9+YjX7Bemdl6XBNF68aQA=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W52KFS4_1713781709;
Received: from 30.97.48.197(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W52KFS4_1713781709)
          by smtp.aliyun-inc.com;
          Mon, 22 Apr 2024 18:28:31 +0800
Message-ID: <f84b259b-177f-46cc-831a-66aa1f4f4117@linux.alibaba.com>
Date: Mon, 22 Apr 2024 18:28:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: fsck: extract chunk-based file with hole
 correctly
To: Yifan Zhao <zhaoyifan@sjtu.edu.cn>, linux-erofs@lists.ozlabs.org
References: <20240422100521.206071-1-zhaoyifan@sjtu.edu.cn>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240422100521.206071-1-zhaoyifan@sjtu.edu.cn>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/4/22 18:05, Yifan Zhao wrote:
> Currently fsck skips file extraction if it finds that EROFS_MAP_MAPPED
> is unset, which is not the case for chunk-based files with hole. This
> patch handles the corner case correctly.
> 
> Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
> ---
>   fsck/main.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/fsck/main.c b/fsck/main.c
> index e5c37be..c10b68e 100644
> --- a/fsck/main.c
> +++ b/fsck/main.c
> @@ -470,7 +470,7 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
>   		pos += map.m_llen;
>   
>   		/* should skip decomp? */
> -		if (!(map.m_flags & EROFS_MAP_MAPPED) || !fsckcfg.check_decomp)
> +		if (map.m_la >= inode->i_size || !fsckcfg.check_decomp)
>   			continue;
>   
>   		if (map.m_plen > Z_EROFS_PCLUSTER_MAX_SIZE) {
> @@ -517,9 +517,14 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
>   				u64 count = min_t(u64, alloc_rawsize,
>   						  map.m_llen);
>   
> -				ret = erofs_read_one_data(inode, &map, raw, p, count);
> -				if (ret)
> -					goto out;
> +				if (!(map.m_flags & EROFS_MAP_MAPPED)) {
> +					memset(raw, 0, count);

I think we could use lseek instead of write
zeros explicitly..


Thanks,
Gao Xiang
