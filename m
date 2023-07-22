Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CD075DA88
	for <lists+linux-erofs@lfdr.de>; Sat, 22 Jul 2023 09:04:41 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R7HVG21h2z3bw9
	for <lists+linux-erofs@lfdr.de>; Sat, 22 Jul 2023 17:04:38 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R7HV84S1sz3bcD
	for <linux-erofs@lists.ozlabs.org>; Sat, 22 Jul 2023 17:04:31 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Vnwp-2U_1690009464;
Received: from 30.221.144.79(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vnwp-2U_1690009464)
          by smtp.aliyun-inc.com;
          Sat, 22 Jul 2023 15:04:25 +0800
Message-ID: <3de999b5-b8b8-6229-5041-99046e9a0e1a@linux.alibaba.com>
Date: Sat, 22 Jul 2023 15:04:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2] erofs-utils: lib: fix erofs_iterate_dir() recursion
Content-Language: en-US
To: hsiangkao@linux.alibaba.com, chao@kernel.org, huyue2@coolpad.com,
 linux-erofs@lists.ozlabs.org
References: <20230722054009.124119-1-jefflexu@linux.alibaba.com>
 <ZLt1KZTLCKyujlmS@debian>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <ZLt1KZTLCKyujlmS@debian>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 7/22/23 2:20 PM, Gao Xiang wrote:
> Hi Jingbo,
> 
> On Sat, Jul 22, 2023 at 01:40:09PM +0800, Jingbo Xu wrote:
>> ctx->dir may have changed when ctx is reused along erofs_iterate_dir()
>> recursion.
>>
>> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
>> ---
>> changes since last version:
>> since traverse_dirents() can be called multiple times in one single
>> erofs_iterate_dir() call, ctx->dir may have changed at the entry of
>> traverse_dirents().  The previous v1 shall be deprecated.
>>
>> v1: https://lore.kernel.org/all/20230718052101.124039-3-jefflexu@linux.alibaba.com/
> 
> I plan to drop this commit directly.  `struct erofs_dir_context` is not
> designed for reusing recursively. It's not the case just due to
> `ctx->dir` but also internal states.
> 
> You need to build another ctx for recursion.

It seems that ctx is reused to avoid stack overflow.  So we have to
allocate ctx on heap to avoid stack overflow?

-- 
Thanks,
Jingbo
