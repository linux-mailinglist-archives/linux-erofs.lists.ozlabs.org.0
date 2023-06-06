Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id F334C723AC1
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Jun 2023 09:58:23 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Qb2sT5YRwz3dxH
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Jun 2023 17:58:21 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Qb2sP04S1z3bTG
	for <linux-erofs@lists.ozlabs.org>; Tue,  6 Jun 2023 17:58:15 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VkVaZUV_1686038289;
Received: from 30.97.48.203(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VkVaZUV_1686038289)
          by smtp.aliyun-inc.com;
          Tue, 06 Jun 2023 15:58:10 +0800
Message-ID: <41910cd1-ea8a-cab4-af46-eea76d6f1761@linux.alibaba.com>
Date: Tue, 6 Jun 2023 15:58:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] erofs-utils: dump: add some superblock fields display
To: Guo Xuenan <guoxuenan@huaweicloud.com>, linux-erofs@lists.ozlabs.org
References: <20230606035511.1114101-1-guoxuenan@huawei.com>
 <95aeb6f0-348a-81e4-2180-a5dfaa18995f@linux.alibaba.com>
 <c1e01731-9922-e146-2008-b68c22926999@huaweicloud.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <c1e01731-9922-e146-2008-b68c22926999@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/6/6 15:28, Guo Xuenan wrote:

...

>>> +
>>> +struct available_alg {
>>> +    int type;
>>> +    const char *name;
>>> +};
>>
>> Could we use lib/compressor.c instead?
>>
> Take a look at the currently implemented interface, and I notice that
> compressor.c define different compressors for mkfs.erofs, but for
> dump.erofs we don't need care about that much, we only show compression
>   algothrims name of the image. It seems that it cannot be reused.

Please help add erofsfsck_ prefix to available_cfg like
erofsfsck_available_cfg.

Anyway, that is still not quite clean if you take a look at
erofs_get_compress_algorithm_id() if lib/compress.c.

We could address this later.

Thanks,
Gao Xiang
