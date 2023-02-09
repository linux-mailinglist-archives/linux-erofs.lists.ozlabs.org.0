Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A02968FFFA
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Feb 2023 06:44:52 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PC5RN57QKz3ch9
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Feb 2023 16:44:48 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PC5RJ0tfZz3bVr
	for <linux-erofs@lists.ozlabs.org>; Thu,  9 Feb 2023 16:44:42 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VbEiVu9_1675921476;
Received: from 30.97.49.34(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VbEiVu9_1675921476)
          by smtp.aliyun-inc.com;
          Thu, 09 Feb 2023 13:44:38 +0800
Message-ID: <1222a277-b55c-f0e1-7845-6dbd6887894b@linux.alibaba.com>
Date: Thu, 9 Feb 2023 13:44:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] Documentation/ABI: sysfs-fs-erofs: update supported
 features
To: Yue Hu <zbestahu@gmail.com>, xiang@kernel.org, chao@kernel.org,
 linux-erofs@lists.ozlabs.org
References: <20230209051128.10571-1-zbestahu@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230209051128.10571-1-zbestahu@gmail.com>
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
Cc: huyue2@coolpad.com, linux-kernel@vger.kernel.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/2/9 13:11, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> Add missing feaures for sysfs-fs-erofs feature doc.
> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>   Documentation/ABI/testing/sysfs-fs-erofs | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ABI/testing/sysfs-fs-erofs
> index bb4681a01811..284224d1b56f 100644
> --- a/Documentation/ABI/testing/sysfs-fs-erofs
> +++ b/Documentation/ABI/testing/sysfs-fs-erofs
> @@ -4,7 +4,8 @@ Contact:	"Huang Jianan" <huangjianan@oppo.com>
>   Description:	Shows all enabled kernel features.
>   		Supported features:
>   		zero_padding, compr_cfgs, big_pcluster, chunked_file,
> -		device_table, compr_head2, sb_chksum.
> +		device_table, compr_head2, sb_chksum, ztailpacking,
> +		dedupe, fragments.
>   
>   What:		/sys/fs/erofs/<disk>/sync_decompress
>   Date:		November 2021
