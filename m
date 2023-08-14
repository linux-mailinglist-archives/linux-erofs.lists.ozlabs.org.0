Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 929EF77B1DD
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Aug 2023 08:55:16 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RPQBp2rYVz30D2
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Aug 2023 16:55:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RPQBl09Gfz2yW5
	for <linux-erofs@lists.ozlabs.org>; Mon, 14 Aug 2023 16:55:09 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VpgzW2Y_1691996101;
Received: from 30.97.49.36(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VpgzW2Y_1691996101)
          by smtp.aliyun-inc.com;
          Mon, 14 Aug 2023 14:55:04 +0800
Message-ID: <478771d2-d73e-0bf7-0e8e-179c8f8a55c9@linux.alibaba.com>
Date: Mon, 14 Aug 2023 14:55:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 05/13] erofs-utils: lib: keep self maintained devname
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
 linux-erofs@lists.ozlabs.org
References: <20230814034239.54660-1-jefflexu@linux.alibaba.com>
 <20230814034239.54660-6-jefflexu@linux.alibaba.com>
 <b141d8aa-c8a4-63db-3400-901492c92dd0@linux.alibaba.com>
In-Reply-To: <b141d8aa-c8a4-63db-3400-901492c92dd0@linux.alibaba.com>
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



On 2023/8/14 14:43, Gao Xiang wrote:
> 
> 
> On 2023/8/14 11:42, Jingbo Xu wrote:
>> Keep self allocated and maintained devname in erofs_sb_info.
>>
>> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
>> ---

...


>> @@ -95,7 +97,11 @@ int dev_open(struct erofs_sb_info *sbi, const char *dev)
>>           return -EINVAL;
>>       }
>> -    sbi->devname = dev;
>> +    sbi->devname = strdup(dev);
> 
> Could we move sbi->devname assignment to the beginning of the function?
> e.g.
> 
>      ..
>          sbi->devname = strdup(dev);
>          if (!sbi->devname)
>                  return -ENOMEM;
> 
>          fd = open(dev, O_RDWR | O_CREAT | O_BINARY, 0644);
>      ...
> 
> 
>> +    if (!sbi->devname) {
>> +        close(fd);
>> +        return -ENOMEM;
>> +    }

After a second thought, since there are already several `close(fd);` in the
error paths and they are unavoidable.  So it looks good to me now:

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
