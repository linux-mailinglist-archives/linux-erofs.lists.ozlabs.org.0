Return-Path: <linux-erofs+bounces-808-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BB013B1E325
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Aug 2025 09:25:05 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bywXb4vr2z3cQx;
	Fri,  8 Aug 2025 17:25:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.188
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754637903;
	cv=none; b=bVQwvuNZp2devDar+uWi9GtMFZ4CwuaKhRL7VfhLpzelhU3z7xksgwilUwc6ecbA3M5p8+msATP92o4m6XzCAC/bvQJip61gqxHbQ3qK/IKpfu8xkktvDOgQ7aRUy7kYqFbEjMezNK1fXTV9PihsvmVhZvZWq7gEihNkKvcjAiIerq3iSMD9WFvh2F/Xsv+vuDt7pabPOqO/BiZL0GjrGyZzzE5qMXyiw0coRNIv33edes5VIWls0I9QRm6M5kTIOh3cRxy2UosjYSGHsN9GofR8PttZxDat9k71eOnpjHivActNfTdSG2awSDv13hdHR2Z9z9UM9F6xv7hVgbZiKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754637903; c=relaxed/relaxed;
	bh=DJFc143mYbJFSTn7a7LVzwI4c6uXMuGz8WDPQ3klDk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=E62QBHT5EswTxH+WUSKBULZxYa4ijuHgtjzA87rMsq04QovOybZAyWVMFbggw03DqiuqXbjPQ0HZNqPtuck+BfhwSILMQaIJIcs/vOG3cqPZIBPr+FOZTtqFL3h+LGbevdvAzJGNgyq6WBMjw3/HRM8UbX+Qs9EhyXCrGcwCUS/pM7lDnDmuoybguVjTy7G5ZYZfnb8ahpBowRm32s8lTTl1YVfLM+bxMm/oYdZAGYoKflhvIXfa9bYHJOf4BTVRw6nWohG5Vwbmia1wig7tNsBIQJ3XvK6P79IIlT1WWQri5hI87SxOGqCTD3vC6eOM3Auro4EM8AK8x2Jtc8sv6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.188; helo=szxga02-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.188; helo=szxga02-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bywXb0qT7z3cQs
	for <linux-erofs@lists.ozlabs.org>; Fri,  8 Aug 2025 17:25:02 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bywWK4DH7zqVgF;
	Fri,  8 Aug 2025 15:23:57 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id AE78C180080;
	Fri,  8 Aug 2025 15:24:58 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 8 Aug 2025 15:24:58 +0800
Message-ID: <c7daacfc-2cc9-447d-b13f-88b352d7eeca@huawei.com>
Date: Fri, 8 Aug 2025 15:24:58 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/4] erofs-utils: mkfs: support EROFS meta-only image
 generation from S3
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
CC: Yifan Zhao <zhaoyifan28@huawei.com>
References: <20250808031508.346771-1-hsiangkao@linux.alibaba.com>
 <20250808031508.346771-4-hsiangkao@linux.alibaba.com>
 <b9c8395a-e50a-46ad-89b9-5679f8b71fad@huawei.com>
 <c3326927-1202-4aee-a75e-ac4138b9cc0c@linux.alibaba.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <c3326927-1202-4aee-a75e-ac4138b9cc0c@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/8/8 15:23, Gao Xiang wrote:
> 
> 
> On 2025/8/8 15:16, Hongbo Li wrote:
> 
> ...
> 
>>> +                dataimport_mode != EROFS_MKFS_DATA_IMPORT_ZEROFILL)
>>
>> Did you forget setting dataimport_mode as 
>> EROFS_MKFS_DATA_IMPORT_ZEROFILL?
>>
>> diff --git a/mkfs/main.c b/mkfs/main.c
>> index 07bc3ed..edc8fff 100644
>> --- a/mkfs/main.c
>> +++ b/mkfs/main.c
>> @@ -1220,6 +1220,7 @@ static int mkfs_parse_options_cfg(int argc, char 
>> *argv[])
>>                          err = mkfs_parse_s3_cfg(optarg);
>>                          if (err)
>>                                  return err;
>> +                       dataimport_mode = 
>> EROFS_MKFS_DATA_IMPORT_ZEROFILL;
>>                          break;
>>   #endif
>>                  case 'V':
> 
> No, users need to specify `--clean=0` to make it work.
> 
> The default mode is still -EOPNOTSUPP.
> 

Ok.

Thanks,
Hongbo

> Thanks,
> Gao Xiang
> 
>>
>>
>> Thanks,
>> Hongbo
>>
>>> +                err = -EOPNOTSUPP;
>>> +            else
>>> +                err = s3erofs_build_trees(root, &s3cfg,
>>> +                              cfg.c_src_path);
>>> +            if (err)
>>> +                goto exit;
>>>   #endif
>>>           }
> 

