Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4887A16B5
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Sep 2023 08:59:56 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rn4nQ5Cbrz3cHH
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Sep 2023 16:59:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rn4nJ01J4z3bVS
	for <linux-erofs@lists.ozlabs.org>; Fri, 15 Sep 2023 16:59:46 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vs6ADc6_1694761179;
Received: from 30.221.146.201(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vs6ADc6_1694761179)
          by smtp.aliyun-inc.com;
          Fri, 15 Sep 2023 14:59:40 +0800
Message-ID: <089695ae-31dd-ae8b-e7ad-fa8dada28f41@linux.alibaba.com>
Date: Fri, 15 Sep 2023 14:59:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] erofs-utils: mkfs: support flatdev for multi-blob images
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20230915062735.124203-1-jefflexu@linux.alibaba.com>
 <b0489f60-5183-d7d4-7550-33c300c23a18@linux.alibaba.com>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <b0489f60-5183-d7d4-7550-33c300c23a18@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 9/15/23 2:35 PM, Gao Xiang wrote:
> 
> 
> On 2023/9/15 14:27, Jingbo Xu wrote:
>> Since kernel commit 8b465fecc35a ("erofs: support flattened block device
>> for multi-blob images"), flatdev feature is introduced to support for
>> mounting multi-blobs container image as a single block device.
>>
>> Introduce "-Eflatdev" option to generate images in flatdev mode.
> 
> Why need introducing such an option
> 
> mapped_blkaddr cannot be filled/fixed up all the time?

Okay. Will be updated in the next version.

> 
>> Currently this can only work with rebuild mode, where the device tag is
>> filled with the uuid of the corresponding source image.
> 
> ...
> 
> 
>> +    if (cfg.c_flatdev && !rebuild_mode) {
>> +        erofs_err("--flatdev is supported only in rebuild mode
>> currently");
> 
> I don't think we need this, all multiple device mode can use this.
> 
> 
>> +        return -EINVAL;
>> +    }
>> +
>>       if (cfg.c_compr_alg[0] && erofs_blksiz(&sbi) != getpagesize())
>>           erofs_warn("Please note that subpage blocksize with
>> compression isn't yet supported in kernel. "
>>                  "This compressed image will only work with bs = ps =
>> %u bytes",
>> @@ -765,8 +774,15 @@ static void erofs_mkfs_default_options(void)
>>       sbi.feature_compat = EROFS_FEATURE_COMPAT_SB_CHKSUM |
>>                    EROFS_FEATURE_COMPAT_MTIME;
>>   -    /* generate a default uuid first */
>> -    erofs_uuid_generate(sbi.uuid);
>> +    /*
>> +     * Generate a default uuid first.  In rebuild mode the uuid of the
>> +     * source image is used as the device slot's tag.  The kernel will
>> +     * identify the tag as empty and fail the mount if its first byte is
>> +     * zero.  Apply this constraint to uuid to work around it.
>> +     */
>> +    do {
>> +        erofs_uuid_generate(sbi.uuid);
>> +    } while (!sbi.uuid[0]);
> 
> why need a loop here?

To ensure the first byte of the device tag (i.e. the uuid of the source
image) is not zero, so that it won't block the mounting in flatdev mode.

-- 
Thanks,
Jingbo
