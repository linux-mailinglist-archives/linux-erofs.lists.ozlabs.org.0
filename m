Return-Path: <linux-erofs+bounces-256-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C4856AA00CC
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Apr 2025 05:46:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZmmTN3NjNz301N;
	Tue, 29 Apr 2025 13:46:48 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.188
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745898408;
	cv=none; b=nL1oB5LqylQqDUEFqiOYCZEhI1EA7og9DgRKxhFJtGrYA7fEOtEkmV/almhnRA1S9jan3e8etBae33AlnaRJXaVVDSRkAVLlsXBk/zvQM0pt61wuwUNVa5hrYVgt3neGIH6CHTUE6s4lZiKKuyKCvFcOa9atUVknRxODNYG78BWXn+TU00274RM4njFtQURNPoC3S5VreNbro4drTut2qZIZF7lwQnMTCzLO6pd7JmoUhygv93ypn4SA9RP4909MznjXDdC+2usItR2BtM+eqLtH1tCsBprjHlkB4zGEteWo6J50qoww/KcOjrwJ28CPkyQCbHR3ZyAXZdvt/M8tFg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745898408; c=relaxed/relaxed;
	bh=TwvmIcX5fp01gfmyKIvMsK2qSrr+YliS5/jzHHUEnZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=e+VXZfMz+eRb2k2rS0yOrqRzAExmWEvjQGZCiYuv36pq2yirrrGWyAlWmtOtv+whmwRgEmrLfvB8zTU1l1f73s4LGVkvNgIb2Z7S1funKC3TgxbEI3PFGSe+qy/BgXo1ZjeaPNRXuZa560tRPMTfA5PXozrLcRADC06WNSRo3df4cN5HaGbhNLw/8mVNDjTKz6k21ZZ0G0hST7w2q3Orv6Zd4f3P7cQPEbxEuJzqhLKX2qHyHtp/8tCJ/USu/yvPdJGGB45w3T/NozutYchUlEz+02E6RtTKKVY4gGFSE9z7cD3YgyBbeCAtZ6PkKHrZ8vdRE7Bc5z4MKFSTUI3DPA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.188; helo=szxga02-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.188; helo=szxga02-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZmmTM2ckmz2yfv
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Apr 2025 13:46:45 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZmmRh5shNzQwPP
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Apr 2025 11:45:20 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id B9E91180B46
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Apr 2025 11:46:40 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 29 Apr 2025 11:46:40 +0800
Message-ID: <22e9fd7b-5e45-4f7c-b9fd-36e76118653f@huawei.com>
Date: Tue, 29 Apr 2025 11:46:39 +0800
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
Subject: Re: [PATCH] erofs: reject unknown option if it is not supported
Content-Language: en-US
To: <linux-erofs@lists.ozlabs.org>
References: <20250428142545.484818-1-lihongbo22@huawei.com>
 <aA+bsw09PHTQWUXK@debian>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <aA+bsw09PHTQWUXK@debian>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/4/28 23:16, Gao Xiang wrote:
> On Mon, Apr 28, 2025 at 02:25:45PM +0000, Hongbo Li wrote:
>> Some options are supported depending on different compiling config,
>> and these option will not fail during mount if they are not
>> supported. This is very weird, so we can reject them if they are
>> not supported.
>>
> 
> If it's an invalid option, we should reject it immediately.
> 
> But for unsupported options, I don't think we always error
> out. e.g. for some options like (acl, noacl) ext4 will just
> ignore if ACL is unsupported.
> 
Thanks for reviewing!
I will keep this in later version.

> I think EROFS should follows that, otherwise users might use
> "noacl" to disable ACL explicitly, but it will fail unexpectedly
> if unsupported.
> 
> But I agree that for "fsid", "domain_id" and "directio", we
> could error out instead.
> 
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>> ---
>>   fs/erofs/super.c | 39 ++++++++++++++++++---------------------
>>   1 file changed, 18 insertions(+), 21 deletions(-)
>>
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index cadec6b1b554..c1c350c6fbf4 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -374,16 +374,26 @@ static const struct constant_table erofs_dax_param_enums[] = {
>>   };
>>   
>>   static const struct fs_parameter_spec erofs_fs_parameters[] = {
>> +#ifdef CONFIG_EROFS_FS_XATTR
>>   	fsparam_flag_no("user_xattr",	Opt_user_xattr),
>> +#endif
> 
> Another thing is that I'm not sure if "user_xattr" option is really
> needed, we might just kill this option since all recent fses don't
> have such configuration and user_xattrs should be supported by default.
> 
Yeah, perhaps this option should be removed along with 
CONFIG_EROFS_FS_XATTR, as xattr can be also consider as a type of data 
that we cannot modify.

Thanks,
Hongbo

> Thanks,
> Gao Xiang
> 

