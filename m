Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F6E69003D
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Feb 2023 07:14:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PC65l4tdGz3cht
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Feb 2023 17:14:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PC65g6CWHz3bY1
	for <linux-erofs@lists.ozlabs.org>; Thu,  9 Feb 2023 17:14:30 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VbEsIZ9_1675923266;
Received: from 30.221.133.91(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VbEsIZ9_1675923266)
          by smtp.aliyun-inc.com;
          Thu, 09 Feb 2023 14:14:27 +0800
Message-ID: <d18fbe06-fec1-2d9a-169e-145fd5ae7c79@linux.alibaba.com>
Date: Thu, 9 Feb 2023 14:14:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2 3/4] erofs: relinquish volume with mutex held
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org, zhujia.zj@bytedance.com
References: <20230209051838.33297-1-jefflexu@linux.alibaba.com>
 <20230209051838.33297-4-jefflexu@linux.alibaba.com>
 <fcb92d78-fc5a-8f51-8a1b-75fd878cf8a1@linux.alibaba.com>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <fcb92d78-fc5a-8f51-8a1b-75fd878cf8a1@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: huyue2@coolpad.com, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2/9/23 2:06 PM, Gao Xiang wrote:
> 
> 
> On 2023/2/9 13:18, Jingbo Xu wrote:
>> Relinquish fscache volume with mutex held.  Otherwise if a new domain is
>> registered when the old domain with the same name gets removed from the
>> list but not relinquished yet, fscache may complain the collision.
>>
>> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
>> Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
> 
> Do we need to backport this to old kernels?
> IOWs, whether "Fixes:" tag is needed?

Yeah the small fix is appropriate for being backported.

Fixes: 8b7adf1dff3d ("erofs: introduce fscache-based domain")

I will add the "Fixes" tag in the next version.


-- 
Thanks,
Jingbo
