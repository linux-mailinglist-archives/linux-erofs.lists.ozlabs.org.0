Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2406A9170
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Mar 2023 08:10:15 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PSfHm4xbBz3cNF
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Mar 2023 18:10:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PSfHd2Tn9z3cJY
	for <linux-erofs@lists.ozlabs.org>; Fri,  3 Mar 2023 18:10:03 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Vd-FtCD_1677827398;
Received: from 30.97.48.241(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vd-FtCD_1677827398)
          by smtp.aliyun-inc.com;
          Fri, 03 Mar 2023 15:09:59 +0800
Message-ID: <1c512eff-c465-40a9-06c7-901a6660cda2@linux.alibaba.com>
Date: Fri, 3 Mar 2023 15:09:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] erofs: fix validation in z_erofs_do_map_blocks()
To: Noboru Asai <asai@sijam.com>, xiang@kernel.org, chao@kernel.org,
 huyue2@coolpad.com
References: <20230303065228.662722-1-asai@sijam.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230303065228.662722-1-asai@sijam.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Noboru,

On 2023/3/3 14:52, Noboru Asai wrote:
> In case of reading fragment data, map->m_plen is invalid.
> 
> Fixes: c505feba4c0d ("erofs: validate the extent length for uncompressed pclusters")
> Signed-off-by: Noboru Asai <asai@sijam.com>

Thanks for the report and patch!

I've already found this issue and I think it's actually
a misuse to Z_EROFS_VLE_CLUSTER_TYPE_PLAIN for fragment
pclusters in mkfs.erofs.

So I fixed in erofs-utils:
https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/commit/?id=ef74e215647e0d602d5e24039acbcfb18e55e516

Since erofs-utils v1.6 is not released yet, so it won't impact
anything at all.

Thanks,
Gao Xiang


> ---
>   fs/erofs/zmap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> index 8bf6d30518b6..902b166a5a5e 100644
> --- a/fs/erofs/zmap.c
> +++ b/fs/erofs/zmap.c
> @@ -572,7 +572,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
>   	}
>   
>   	if (m.headtype == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN) {
> -		if (map->m_llen > map->m_plen) {
> +		if (!(map->m_flags & EROFS_MAP_FRAGMENT) && (map->m_llen > map->m_plen) {
>   			DBG_BUGON(1);
>   			err = -EFSCORRUPTED;
>   			goto unmap_out;
