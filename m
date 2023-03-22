Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC896C548A
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Mar 2023 20:09:42 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PhdM81FLGz3cdG
	for <lists+linux-erofs@lfdr.de>; Thu, 23 Mar 2023 06:09:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PhdM064f4z3cLx
	for <linux-erofs@lists.ozlabs.org>; Thu, 23 Mar 2023 06:09:31 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VeRUxgh_1679512164;
Received: from 30.13.187.145(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VeRUxgh_1679512164)
          by smtp.aliyun-inc.com;
          Thu, 23 Mar 2023 03:09:26 +0800
Message-ID: <287798df-2da6-0158-cbdc-616e587e58bd@linux.alibaba.com>
Date: Thu, 23 Mar 2023 03:09:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v3 03/10] erofs: convert to kobject_del_and_put()
To: Yangtao Li <frank.li@vivo.com>, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>
References: <20230322165905.55389-1-frank.li@vivo.com>
 <20230322165905.55389-2-frank.li@vivo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230322165905.55389-2-frank.li@vivo.com>
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Damien Le Moal <damien.lemoal@opensource.wdc.com>, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/3/23 00:58, Yangtao Li wrote:
> Use kobject_del_and_put() to simplify code.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Acked-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>   fs/erofs/sysfs.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
> index 435e515c0792..9ed7d6552155 100644
> --- a/fs/erofs/sysfs.c
> +++ b/fs/erofs/sysfs.c
> @@ -241,8 +241,7 @@ void erofs_unregister_sysfs(struct super_block *sb)
>   	struct erofs_sb_info *sbi = EROFS_SB(sb);
>   
>   	if (sbi->s_kobj.state_in_sysfs) {
> -		kobject_del(&sbi->s_kobj);
> -		kobject_put(&sbi->s_kobj);
> +		kobject_del_and_put(&sbi->s_kobj);
>   		wait_for_completion(&sbi->s_kobj_unregister);
>   	}
>   }
