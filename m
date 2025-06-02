Return-Path: <linux-erofs+bounces-377-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E1AACADF6
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Jun 2025 14:23:36 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b9tKx5nJ4z2yNB;
	Mon,  2 Jun 2025 22:23:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1748867013;
	cv=none; b=jlBD2vYtl7xzxVpu/JrHdwqmu0Iwq924EGupg4EnDSHPwLxkaOyO6xBWxJ/STiIYFPjz4j5Uze/wUByVQQdmUHZApu7K8XfRglF5YOA3PvRCdCFnsJOwzYkAK34IFgk2rE8NSGeLyuzZGsLiE5+SC8bY8lFlcg2ady34nCz5pchYu/rjVoyToRonmXkAGyYtScx8pjDfjhhYKRLbWuGnemVG5ZSHynAECf11RzNRfrGvu06Ge7TqplyZ4zTaEGXUVpqshFeERbY1ZU7dW2U/Qzhql+1HfgTRHDqY/YiPSTAONlljJP+EUvhpT/vYNruelrm9Wbyow8ne9dD7B+2+iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1748867013; c=relaxed/relaxed;
	bh=fak+WkSqiPdJZbecyuMzIPAJvetwhbqk0/Rzyiic1jA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ra1iJDlXh3/4p7MY5dcPsQ100TFxk9+FiWf6kA5Wqvga4tyLjSTznPgTXvUGLmDboqLIWeBagt36ge5ojA4H4KW6x5h4qa5+Ng6NoUY6XiIA+TC442vYde70/1LhyoCDxG1PGPX5pN+ojagEriRLfNj/DiS/8JguXBfAVA+hfYt3IMApeTSF4KL4HvNIdiUEO9zg2FM/hAZb1crB//AbPtL9DojTb5YXIQqydbDFOavpR6G6tDVORNa5k7pxyiyN5l6HCT3L1z7El0hkp0cReVRtb5J0PHAHclaZNe1eNKMfJ87s9Lc2k6nLLDitEiOoaXVGVNwoDlaWMwXbXs/UIw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=N/Hf4+r/; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=N/Hf4+r/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b9tKv6XpRz2yN2
	for <linux-erofs@lists.ozlabs.org>; Mon,  2 Jun 2025 22:23:29 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1748867006; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=fak+WkSqiPdJZbecyuMzIPAJvetwhbqk0/Rzyiic1jA=;
	b=N/Hf4+r/DTqZsYM5e6g+w9GFqd1/ytPwas1+ijORN+nNzMjP4SGgm01aArS15P+suQOjWr5h/f4GCaebZzyUl1ELHZCaJeSaltneHWbaKhc+045LGrqIyMqaFv8ZesGaZA5cxHVElHoQLEFBE6TRDUVm/eFqyAlSVEPqL1JgbZA=
Received: from 30.170.233.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WcZVZhX_1748867003 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 02 Jun 2025 20:23:23 +0800
Message-ID: <afdfdab2-bc8d-4ba2-90b6-b38845c111e9@linux.alibaba.com>
Date: Mon, 2 Jun 2025 20:23:23 +0800
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
Subject: Re: [PATCH] erofs-utils: mkfs: fix image reproducibility of
 `-E(all-)fragments`
To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-erofs@lists.ozlabs.org
References: <20250531002954.432151-1-hsiangkao@linux.alibaba.com>
 <9a234fc8-2ef0-435b-bc25-47881182d6c5@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <9a234fc8-2ef0-435b-bc25-47881182d6c5@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Hongbo,

On 2025/6/2 17:31, Hongbo Li wrote:
> Hi, Xiang,
> 
> On 2025/5/31 8:29, Gao Xiang wrote:
>> The timestamp of the packed inode should be fixed to the build time.
>>
>> Fixes: 9fa9b017f773 ("erofs-utils: mkfs: support fragments")
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
>>   lib/inode.c | 14 ++++++++++----
>>   1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/lib/inode.c b/lib/inode.c
>> index 7a10624..ca49a80 100644
>> --- a/lib/inode.c
>> +++ b/lib/inode.c
>> @@ -910,7 +910,8 @@ out:
>>       return 0;
>>   }
>> -static bool erofs_should_use_inode_extended(struct erofs_inode *inode)
>> +static bool erofs_should_use_inode_extended(struct erofs_inode *inode,
>> +                        const char *path)
>>   {
>>       if (cfg.c_force_inodeversion == FORCE_INODE_EXTENDED)
>>           return true;
>> @@ -924,7 +925,8 @@ static bool erofs_should_use_inode_extended(struct erofs_inode *inode)
>>           return true;
>>       if (inode->i_nlink > USHRT_MAX)
>>           return true;
>> -    if ((inode->i_mtime != inode->sbi->build_time ||
>> +    if (path != EROFS_PACKED_INODE &&
>> +        (inode->i_mtime != inode->sbi->build_time ||
>>            inode->i_mtime_nsec != inode->sbi->build_time_nsec) &&
>>           !cfg.c_ignore_mtime)
>>           return true;
>> @@ -1016,6 +1018,10 @@ int __erofs_fill_inode(struct erofs_inode *inode, struct stat *st,
>>           erofs_err("gid overflow @ %s", path);
>>       inode->i_gid += cfg.c_gid_offset;
>> +    if (path == EROFS_PACKED_INODE) {
>> +        inode->i_mtime = sbi->build_time;
>> +        inode->i_mtime_nsec = 0;
>> +    }
>>       inode->i_mtime = st->st_mtime;
>>       inode->i_mtime_nsec = ST_MTIM_NSEC(st);
> 
> Should we put the condition in here? Because it will be reassigned if we do like this.

Oh, that is my fault, I will fix it soon.

> 
> And what about assigning sbi->build_time_nsec to inode->i_mtime_nsec like the FIXED case?

I just would like a quick fix for this because I have
other features to work on.

If you want to improve that, could you submit a patch?

Thanks,
Gao Xiang

> 
> Thanks,
> Hongbo
> 

