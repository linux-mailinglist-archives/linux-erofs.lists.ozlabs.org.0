Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE850666A56
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Jan 2023 05:34:44 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NssCQ3xZlz3cCF
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Jan 2023 15:34:42 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NssCK4S2fz3c5D
	for <linux-erofs@lists.ozlabs.org>; Thu, 12 Jan 2023 15:34:36 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VZPZhea_1673498070;
Received: from 30.221.131.229(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VZPZhea_1673498070)
          by smtp.aliyun-inc.com;
          Thu, 12 Jan 2023 12:34:31 +0800
Message-ID: <8b0af045-25c1-9848-3c8c-de7da94d06da@linux.alibaba.com>
Date: Thu, 12 Jan 2023 12:34:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH v2 2/2] fscache: Add the missing smp_mb__after_atomic()
 before wake_up_bit()
Content-Language: en-US
To: Hou Tao <houtao@huaweicloud.com>, linux-cachefs@redhat.com
References: <20221226103309.953112-1-houtao@huaweicloud.com>
 <20221226103309.953112-3-houtao@huaweicloud.com>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20221226103309.953112-3-houtao@huaweicloud.com>
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
Cc: David Howells <dhowells@redhat.com>, linux-erofs@lists.ozlabs.org, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, houtao1@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 12/26/22 6:33 PM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> fscache_create_volume_work() uses wake_up_bit() to wake up the processes
> which are waiting for the completion of volume creation. According to
> comments in wake_up_bit() and waitqueue_active(), an extra smp_mb() is
> needed to guarantee the memory order between FSCACHE_VOLUME_CREATING
> flag and waitqueue_active() before invoking wake_up_bit().
> 
> Considering clear_bit_unlock() before wake_up_bit() is an atomic
> operation, use smp_mb__after_atomic() instead of smp_mb() to provide
> such guarantee.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  fs/fscache/volume.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/fscache/volume.c b/fs/fscache/volume.c
> index fc3dd3bc851d..734d17f404e7 100644
> --- a/fs/fscache/volume.c
> +++ b/fs/fscache/volume.c
> @@ -281,6 +281,11 @@ static void fscache_create_volume_work(struct work_struct *work)
>  				 fscache_access_acquire_volume_end);
>  
>  	clear_bit_unlock(FSCACHE_VOLUME_CREATING, &volume->flags);
> +	/*
> +	 * Paired with barrier in wait_on_bit(). Check wake_up_bit() and
> +	 * waitqueue_active() for details.
> +	 */
> +	smp_mb__after_atomic();
>  	wake_up_bit(&volume->flags, FSCACHE_VOLUME_CREATING);
>  	fscache_put_volume(volume, fscache_volume_put_create_work);
>  }

LGTM.

Actually I'm thinking if clear_and_wake_up_bit() could be used here.
Ditto for patch 1.

-- 
Thanks,
Jingbo
