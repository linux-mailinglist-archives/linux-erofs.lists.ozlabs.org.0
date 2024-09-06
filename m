Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C18496EE96
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Sep 2024 10:54:34 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X0VQw0vHHz305v
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Sep 2024 18:54:32 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725612870;
	cv=none; b=gk7qRX2U7zvaym69mntglst0Ms0xRHBp73aTXUGL2z+itYRyEtKlabb1O82MoLS+ym8cseh9LYb7Pzq5EXU6JzejgR9l6p2qNucceWO6xMJzhoP/5qhhcf7fRQ+cY1YSNoAWo8pawjpilQ9l2+/ZAzZh/t4bW9wMtqeU4/v08PnuB81h9SDEX1ilQrlZp74SB9MnMMIG5trlkMntLVulN5Djrg74JB7WOwj5YHujxyFeQbIaMKdGLRlhBDCg7FthrYGV1hyrX+V3NseXEmNHx5Jc7p0AvSy3z9fRsRXGY1qEIrvQNuN/zhlY92RxzxHuOeEo6r/e21YPGg2LpWS11g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725612870; c=relaxed/relaxed;
	bh=Z3umYbpDXM/a8mq0K3SH+lD0n5Np50PwglM0JsPqWaM=;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:References:
	 From:In-Reply-To:Content-Type; b=nKkpSrQYObpbdaL6Er+NhQuMCFQmfPOgLa6fMHG98OGohwGUeDq3KOmyUOP7aOeqwdXrkL4aNhzIqdxe0itYG1rQZl0wyXIqSHfIPhNSI/RPLl86NKRmaONYC3doGCYalS9qdC5E/yqt89e8Cv9jLVVOxLk38UB44+POZngFajtTSgORSR7RyuGx2mdFg5xo2nysXUSKTNtFwbO4PtOeiYetlaV4OALoCVHo7WitTtBntKV5w2rAUyXHockJuYLWq+02NNd0CnstLMmNeV/oOnfLaXpBK9nCfddGbDyaC/FGVQ7t7A9XXvFH0XM+i77DDB1EztqDY+j/Uou+egG/ww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=TLhi6YRE; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=TLhi6YRE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X0VQs5R6Fz301G
	for <linux-erofs@lists.ozlabs.org>; Fri,  6 Sep 2024 18:54:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725612865; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Z3umYbpDXM/a8mq0K3SH+lD0n5Np50PwglM0JsPqWaM=;
	b=TLhi6YREr9gXEZ0+r03eVKnFrGtbDovpA/B9wuW2vo28JlWcQuHiF7w5D4QLnjxeNcrU9CW+MZjpZhlqF67dak7X8ldR1U08MIUgVpf/3KB55RLNgcAJ50fumMkMDZ1Juy//lTNkOr85Jil3aZtdR5u02RjTtAucipWjXQdUSHw=
Received: from 30.221.132.253(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WEOuisN_1725612864)
          by smtp.aliyun-inc.com;
          Fri, 06 Sep 2024 16:54:25 +0800
Message-ID: <3b867779-4233-4478-8199-d7df1f0ae9be@linux.alibaba.com>
Date: Fri, 6 Sep 2024 16:54:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] erofs-utils: lib: introduce
 erofs_xattr_prefix_index()
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240906083849.3090392-1-hongzhen@linux.alibaba.com>
 <b0f6bfaf-89ba-4dea-974a-69d2990aaf69@linux.alibaba.com>
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
In-Reply-To: <b0f6bfaf-89ba-4dea-974a-69d2990aaf69@linux.alibaba.com>
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


On 2024/9/6 16:49, Gao Xiang wrote:
>
>
> On 2024/9/6 16:38, Hongzhen Luo wrote:
>> Prepare for the feature of exporting extended attributes for
>> `fsck.erofs`, which requires obtaining the index based on the
>> name of the extended attribute.
>>
>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>> ---
>>   include/erofs/xattr.h | 2 ++
>>   lib/xattr.c           | 7 +++++++
>>   2 files changed, 9 insertions(+)
>>
>> diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
>> index 7643611..7848fe7 100644
>> --- a/include/erofs/xattr.h
>> +++ b/include/erofs/xattr.h
>> @@ -61,6 +61,8 @@ void erofs_clear_opaque_xattr(struct erofs_inode 
>> *inode);
>>   int erofs_set_origin_xattr(struct erofs_inode *inode);
>>   int erofs_read_xattrs_from_disk(struct erofs_inode *inode);
>>   +int erofs_xattr_prefix_index(const char *key);
>> +
>>   #ifdef __cplusplus
>>   }
>>   #endif
>> diff --git a/lib/xattr.c b/lib/xattr.c
>> index 9f31f2d..1fed7c0 100644
>> --- a/lib/xattr.c
>> +++ b/lib/xattr.c
>> @@ -1681,3 +1681,10 @@ out:
>>           erofs_xattr_prefixes_cleanup(sbi);
>>       return ret;
>>   }
>> +
>> +int erofs_xattr_prefix_index(const char *key)
>> +{
>> +    unsigned int index, len;
>> +
>> +    return match_prefix(key, &index, &len) ? index : -EINVAL;
>
> Can we export match_prefix as erofs_xattr_match_prefix()
> directly?
>
> Thanks,
> Gao Xiang
>
Yes, i will do this in the next patch.

Thanks,

Hongzhen

>> +}
