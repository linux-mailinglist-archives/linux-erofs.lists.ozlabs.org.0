Return-Path: <linux-erofs+bounces-745-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C299B17EDC
	for <lists+linux-erofs@lfdr.de>; Fri,  1 Aug 2025 11:10:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4btgCT4m8dz2yfL;
	Fri,  1 Aug 2025 19:10:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.191
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754039429;
	cv=none; b=NPYWVM+fiRcSd/MdEbaM0AkviNpN5VmKT7m5J/SuqmBGXFfyT+yH00W/mAcqhBW0s4/6rYlwVOAWddHYVBXF/Lrln0e7BMBMXH9a3EbSmTBF9FVJz9B2/lqOqv59WotKJZzL5EOibv3HnrJau849sKXvIThp+/GEOgNIE6JjpOPvOC+3akwHWWOYMHJg01IaMRS1yNITWszK3ez9wCdBEV2Q8sfg/rC82omkVcma12zvvEkUE6EOotlkKF/uRJtHa6TX/JixkNpQh5SPOG1O+TsGBNud54CBQOFU/+Me6jWLKp/4BQPsQPIaTPMBrpEJfCx3l06ZaBlrPV/FUTjKEw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754039429; c=relaxed/relaxed;
	bh=E3MnqfmSauZ5wGbKG19IR7uNMhDaT9yg8J+e+DgQON4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jkUvoZ5c8SjtxVEV9K6T9YkzNWF9PTs91VPD/xn+Vft9aVwIv0HZvgE62nviYdpqMJKE/rX+D/gobRw9N0u/jUvWvhTW6oKCypiyi1S03JjKupgLZuGyA/BYFFnAr0yvMyZtfd4j4fa9d6DCEPJiFXUMECxInOiGJncmyVU3S4YATc4SQDivXAUt521gpvQO7+9I+HggUUVNTqiE1eW1aTNpJcGsVGZyEarcxXW1kJun0FzWHut3kVCMPCzNS2NIlgl0r40YCFW73XFWCwwtgp68NfaxcOMq6AOJipmk50nYlLfCI8JcIUbfhXN1s78mQRe0GtBjUkyWM/s5oPDn1A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4btgCR5nCYz2y82
	for <linux-erofs@lists.ozlabs.org>; Fri,  1 Aug 2025 19:10:25 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4btg886785z1R8pB;
	Fri,  1 Aug 2025 17:07:36 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 62753140145;
	Fri,  1 Aug 2025 17:10:21 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 1 Aug 2025 17:10:20 +0800
Message-ID: <2383c973-3072-4a39-bcab-097f5a5a46b1@huawei.com>
Date: Fri, 1 Aug 2025 17:10:21 +0800
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
Subject: Re: [PATCH v2 3/4] erofs-utils: mkfs: introduce `--s3=...` option
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
CC: <jingrui@huawei.com>, Yifan Zhao <zhaoyifan28@huawei.com>
References: <97aa3cdb-076b-4af2-a110-79250b74fc7a@linux.alibaba.com>
 <20250801073046.1900016-1-zhaoyifan28@huawei.com>
 <20250801073046.1900016-2-zhaoyifan28@huawei.com>
 <26bee370-2cd1-43d3-b83e-af6e91253939@linux.alibaba.com>
 <7cf57bb4-caff-4d27-af23-d69ca3b3b75b@huawei.com>
 <0f00d052-f7e5-4006-89ba-4fdbd1453269@linux.alibaba.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <0f00d052-f7e5-4006-89ba-4fdbd1453269@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/8/1 16:37, Gao Xiang wrote:
> Hi Hongbo,
> 
> On 2025/8/1 16:31, Hongbo Li wrote:
> 
> ...
> 
>>>> +#ifdef HAVE_S3
>>>
>>> HAVE_S3 is a bit odd, how about using
>>> S3_ENABLED (like LZ4_ENABLED?)
>>>
>>>
>>>> +        " --s3=X                generate an index-only image from 
>>>> s3-compatible object store backend\n"
>>>> +        "   [,passwd_file=Y]    X=endpoint, Y=s3 credentials file\n"
>>>
>>> What's s3 credentials file? Is it documented
>>> somewhere? Why is it named as passwd_file?
>>>
>>> Can we have an option to pass in accesskey
>>> too?
>>
>> This follows the format of s3fs-fuse. Storing the ak/sk in a file is 
>> for security purposes. The file permission is set to 600 to prevent 
>> non-root users from accessing the ak/sk.
> 
> Understood, I wonder if the format is documented in
> the AWS website or somewhere?

AFAIK, the user should download the file which records ak/sk at the 
first time when access the target console page. The ak/sk may be saved 
in the csv format file. And the AWS website only shows the way to help 
user to obtain the ak/sk, such as [1]?

[1] 
https://docs.aws.amazon.com/IAM/latest/UserGuide/access-key-self-managed.html

Thanks,
Hongbo
> 
> If it's only an implementation in s3fs-fuse, we might
> need to document the format in the mkfs.erofs manpage
> for example. (Although it's not needed in this patch,
> maybe a follow-up patch.)
> 
> Also even I agree it's useful for security purposes,
> it's still useful to have an _alternative_ way to
> pass in plain ak/sk if possible.
> 
> `passwd_file` makes sense to me now since s3fs-fuse
> uses this name too!
> 
> Thanks,
> Gao Xiang
> 
>>
>> [1] https://github.com/s3fs-fuse/s3fs-fuse
>>
>> Thanks,
>> Hongbo
>>

