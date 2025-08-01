Return-Path: <linux-erofs+bounces-743-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A93F5B17E54
	for <lists+linux-erofs@lfdr.de>; Fri,  1 Aug 2025 10:32:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4btfMC6hT5z2yfL;
	Fri,  1 Aug 2025 18:32:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.32
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754037127;
	cv=none; b=SAMnjm5X2NbfCLcQaEQ+9ywQLMpru9fx0F2KQPojFaDiPAoOjkAfWuvqxx2CDNINDpg275rrh/tutJjxi/e9nbV4T6vlTA/wxsFgEK26F+9+x9GDl/WWJRi+1VV/yjhSqbiiWfmOTxv8GO+YwVvJp347eE9nK/aRrxdFRmuIO5vxEkbNd2CzPIrjauOVDu2KqFuYmRzoFB4aUpLWOSQjYiz0S1NVz3ql2p+hZT+ePwJ0esO1o6kZG/j7s1CwM3iv17lUt0toZ/KGEDfcN2xL1xF2XrdVUyzDIkvyRLejvIXsW660nh0L1UBH9eOIXwnx+U2LiSLkj7sLuro7rs7OUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754037127; c=relaxed/relaxed;
	bh=JGQqL2HX01yrzzDn1gKb/JoyZIxV2s/PgBt0EItsdXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LgwqEmg7sKyi3T8ts//rAtdbQbjvqrqKZGi8PLcvD3hkT6Cb2229feFuLFe46neV8zD+po53EP9eAsPnAsHHhCnC8ruc8SPYcvOhuFd4RBD7D/Cznnh6l1pHZvAAl90scwxceoOb2BSfxj+BVKwQGjwsslXbMHR8ceyShYHmrkyhwRPQclcHN+iayGZMNxmfGppjiSvR3JrRwMD3bO/5nDqjKV/PKT1hhzlmg2pdcS6bkzbeyKybJu4PvqSGWp8SUIsjdWUCHV0bY0apnf15/Dpaoy6ij/gQFakRkuHcTES703q0C79C8EG/UN3Zo2NneapTRTPtJOoKBvPvL6GZuA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.32; helo=szxga06-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.32; helo=szxga06-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4btfMB2d7cz2y82
	for <linux-erofs@lists.ozlabs.org>; Fri,  1 Aug 2025 18:32:03 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4btfND6jyzz27hcx;
	Fri,  1 Aug 2025 16:33:00 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 0FD511A016C;
	Fri,  1 Aug 2025 16:31:59 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 1 Aug 2025 16:31:58 +0800
Message-ID: <7cf57bb4-caff-4d27-af23-d69ca3b3b75b@huawei.com>
Date: Fri, 1 Aug 2025 16:31:58 +0800
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
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <26bee370-2cd1-43d3-b83e-af6e91253939@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/8/1 15:46, Gao Xiang wrote:
> 
> 
> On 2025/8/1 15:30, Yifan Zhao wrote:
>> From: zhaoyifan <zhaoyifan28@huawei.com>
>>
>> This patch introduces configuration options for the upcoming 
>> experimental S3
>> support, including configuration parsing and passwd_file reading logic.
>>
>> User could specify the following options:
>> - S3 service endpoint (Compulsory)
>> - S3 credentials file, in the format of "$ak:%sk" (Optional)
>> - S3 API calling style (Optional)
>> - S3 API signature version, only sigV2 supported yet (Optional)
>>
>> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
>> ---
>> change since v1:
>> - rename: include/erofs/s3.h => lib/liberofs_s3.h
>> - add liberofs_s3.h in this patch rather than previous one
>>
>>   lib/liberofs_s3.h |  40 +++++++++
>>   lib/remotes/s3.c  |   3 +-
>>   mkfs/main.c       | 220 ++++++++++++++++++++++++++++++++++++++++------
>>   3 files changed, 233 insertions(+), 30 deletions(-)
>>   create mode 100644 lib/liberofs_s3.h
>>
>> diff --git a/lib/liberofs_s3.h b/lib/liberofs_s3.h
>> new file mode 100644
>> index 0000000..16a06c9
>> --- /dev/null
>> +++ b/lib/liberofs_s3.h
>> @@ -0,0 +1,40 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
>> +/*
>> + * Copyright (C) 2025 HUAWEI, Inc.
>> + *             http://www.huawei.com/
>> + * Created by Yifan Zhao <zhaoyifan28@huawei.com>
>> + */
>> +#ifndef __EROFS_S3_H
>> +#define __EROFS_S3_H
>> +
>> +#ifdef __cplusplus
>> +extern "C" {
>> +#endif
>> +
>> +enum s3erofs_url_style {
>> +    S3EROFS_URL_STYLE_PATH,          // Path style: 
>> https://s3.amazonaws.com/bucket/object
>> +    S3EROFS_URL_STYLE_VIRTUAL_HOST,  // Virtual host style: 
>> https://bucket.s3.amazonaws.com/object
>> +};
>> +
>> +enum s3erofs_signature_version {
>> +    S3EROFS_SIGNATURE_VERSION_2,
>> +    S3EROFS_SIGNATURE_VERSION_4,
>> +};
>> +
>> +#define S3_ACCESS_KEY_LEN 256
>> +#define S3_SECRET_KEY_LEN 256
>> +
>> +struct erofs_s3 {
>> +    const char *endpoint, *bucket;
>> +    char access_key[S3_ACCESS_KEY_LEN + 1];
>> +    char secret_key[S3_SECRET_KEY_LEN + 1];
>> +
>> +    enum s3erofs_url_style url_style;
>> +    enum s3erofs_signature_version sig;
>> +};
>> +
>> +#ifdef __cplusplus
>> +}
>> +#endif
>> +
>> +#endif
>> \ No newline at end of file
>> diff --git a/lib/remotes/s3.c b/lib/remotes/s3.c
>> index ed2b023..358ee91 100644
>> --- a/lib/remotes/s3.c
>> +++ b/lib/remotes/s3.c
>> @@ -3,4 +3,5 @@
>>    * Copyright (C) 2025 HUAWEI, Inc.
>>    *             http://www.huawei.com/
>>    * Created by Yifan Zhao <zhaoyifan28@huawei.com>
>> - */
>> \ No newline at end of file
>> + */
>> +#include "liberofs_s3.h"
>> \ No newline at end of file
>> diff --git a/mkfs/main.c b/mkfs/main.c
>> index 3aa1421..f524f45 100644
>> --- a/mkfs/main.c
>> +++ b/mkfs/main.c
>> @@ -31,6 +31,7 @@
>>   #include "../lib/liberofs_private.h"
>>   #include "../lib/liberofs_uuid.h"
>>   #include "../lib/liberofs_metabox.h"
>> +#include "../lib/liberofs_s3.h"
>>   #include "../lib/compressor.h"
>>   static struct option long_options[] = {
>> @@ -59,6 +60,9 @@ static struct option long_options[] = {
>>       {"gid-offset", required_argument, NULL, 17},
>>       {"tar", optional_argument, NULL, 20},
>>       {"aufs", no_argument, NULL, 21},
>> +#ifdef HAVE_S3
>> +    {"s3", required_argument, NULL, 22},
>> +#endif
>>       {"mount-point", required_argument, NULL, 512},
>>       {"xattr-prefix", required_argument, NULL, 19},
>>   #ifdef WITH_ANDROID
>> @@ -197,6 +201,12 @@ static void usage(int argc, char **argv)
>>           " --root-xattr-isize=#  ensure the inline xattr size of the 
>> root directory is # bytes at least\n"
>>           " --aufs                replace aufs special files with 
>> overlayfs metadata\n"
>>           " --sort=<path,none>    data sorting order for tarballs as 
>> input (default: path)\n"
>> +#ifdef HAVE_S3
> 
> HAVE_S3 is a bit odd, how about using
> S3_ENABLED (like LZ4_ENABLED?)
> 
> 
>> +        " --s3=X                generate an index-only image from 
>> s3-compatible object store backend\n"
>> +        "   [,passwd_file=Y]    X=endpoint, Y=s3 credentials file\n"
> 
> What's s3 credentials file? Is it documented
> somewhere? Why is it named as passwd_file?
> 
> Can we have an option to pass in accesskey
> too?

This follows the format of s3fs-fuse. Storing the ak/sk in a file is for 
security purposes. The file permission is set to 600 to prevent non-root 
users from accessing the ak/sk.

[1] https://github.com/s3fs-fuse/s3fs-fuse

Thanks,
Hongbo

> 
> 
>> +        "   [,style=Z]          S3 API calling style (Z = vhost|path) 
>> (default: vhost)\n"
>> +        "   [,sig=<2,4>]        S3 API signature version (default: 2)\n"
>> +#endif
>>           " --tar=X               generate a full or index-only image 
>> from a tarball(-ish) source\n"
>>           "                       (X = f|i|headerball; f=full mode, 
>> i=index mode,\n"
>>           "                                            headerball=file 
>> data is omited in the source stream)\n"
>> @@ -247,6 +257,10 @@ static struct erofs_tarfile erofstar = {
>>   static bool incremental_mode;
>>   static u8 metabox_algorithmid;
>> +#ifdef HAVE_S3
>> +static struct erofs_s3 s3cfg;
>> +#endif
>> +
>>   enum {
>>       EROFS_MKFS_DATA_IMPORT_DEFAULT,
>>       EROFS_MKFS_DATA_IMPORT_FULLDATA,
>> @@ -257,6 +271,9 @@ enum {
>>   enum {
>>       EROFS_MKFS_SOURCE_DEFAULT,
> 
> EROFS_MKFS_SOURCE_LOCALDIR,
> 
> Thanks,
> Gao Xiang

