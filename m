Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 298167318FB
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jun 2023 14:29:18 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QhhRw0X4Wz3bP2
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jun 2023 22:29:16 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QhhRs5yPZz2xpw
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Jun 2023 22:29:13 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VlBPezQ_1686832147;
Received: from 30.221.131.153(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VlBPezQ_1686832147)
          by smtp.aliyun-inc.com;
          Thu, 15 Jun 2023 20:29:09 +0800
Message-ID: <93e6ab67-2d88-318a-f422-8bd0e385e545@linux.alibaba.com>
Date: Thu, 15 Jun 2023 20:29:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v2 2/4] erofs-utils: lib: unify all identical compressor
 print function
To: Guo Xuenan <guoxuenan@huaweicloud.com>, jefflexu@linux.alibaba.com,
 linux-erofs@lists.ozlabs.org
References: <20230615101727.946446-1-guoxuenan@huawei.com>
 <20230615101727.946446-3-guoxuenan@huawei.com>
 <bccba1a8-b934-ea2e-04db-42da6ee63e3a@linux.alibaba.com>
 <b52aefc8-34bf-6d36-3a41-d8ded30d065b@huaweicloud.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <b52aefc8-34bf-6d36-3a41-d8ded30d065b@huaweicloud.com>
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
Cc: jack.qiu@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/6/15 20:01, Guo Xuenan wrote:
> 
> On 2023/6/15 18:46, Gao Xiang wrote:

...


>>> +
>>> +void erofs_print_available_compressors(FILE *f)
>>> +{
>>
>> Should just erofs_print_supported_compressors(f, ~0) and avoid this helper?
>>
> As commit message of this patch explained, available compressors means which algothrims are
> currentlyavailable to user in binary tools. I mean fsck/mkfs.erofs binary tools may only support
> lz4 compression.erofs_print_available_compressors should only print lz4; but for dump.erofs ,
> which is not used tomake erofs image, there is a bit difference here. dump.erofs should identify
> all supportedalgorithms.

Oh, that makes sense, sorry about the noise.

>> Thanks,
>> Gao Xiang
>>
> -- 
> Best regards
> Guo Xuenan
> 
