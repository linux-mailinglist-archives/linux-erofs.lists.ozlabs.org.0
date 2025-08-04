Return-Path: <linux-erofs+bounces-763-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 78111B1A62A
	for <lists+linux-erofs@lfdr.de>; Mon,  4 Aug 2025 17:38:05 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bwggH2wFPz3bsy;
	Tue,  5 Aug 2025 01:38:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.187
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754321883;
	cv=none; b=XfZ2AcCV6AX/Kt/z0/0HLH59wOpXulvmy13zR+Xh47IOPi1+xrJ8XGDfv1Lzj+oF6i1Bni7cP4MwUbHUV5QuxMz/F4rsWs6LU9ei/zbiXQa5yhcrlfskkwoP/ijUgta9j7IjjmaMWST5lDi/KAtLCLpNvdBgMJYAhfWzMU+0s9wRVKQ84Ahe2Lj4CQjP8ba9IxMBWbssbDUQRKtfjSbIoxpcTOV4Qug0je4FG7VKOX3dp8NnXZ+/tsMb/gHSF2limVtH/W578aWBWzr3q9a8h1h2s/61MH6jpAfB7AC8/4A+GpRS85c2WRd4xiZjRibli0LHliLT+Ki3JIw6gHB1Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754321883; c=relaxed/relaxed;
	bh=rcWuE7zMjpy2bAR+xn5kXF4SqV5zwnxO4AiOJa7BzIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Y4Cv57GKfH5UwzG5dgx41e5hFZl70Vka6I44j6dqXk1gSFQxU+MWaxRpwtvTVemOwteEHCwuVccumUSHcnSjAZOEWlanTgbs47TNBr0lMeNRZoWa2zQIps06ldhyQcOUPI5xqwCunPtun24KpWmxnDrr1SRZn35sQ1laSBOrmGqr9szTkh4cn9MuBjLgNUE0Cyzt38uKfpXv1xEX8aLMiWlSIoN4MXoqsnGoiowigdGdMpU+bFyfRaRLhdYGPg8DwfKH9mgTQjPdhX9b4FXIkY2/ogg5+rs/OeO9bbqSKz5OY9u1wO7/kqHOV/5bay16DZLkEDSmWprXXNXTK9B+2w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bwggG3Xz3z3bsM
	for <linux-erofs@lists.ozlabs.org>; Tue,  5 Aug 2025 01:38:02 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bwgYW1fRdz14M7G;
	Mon,  4 Aug 2025 23:33:03 +0800 (CST)
Received: from kwepemp500007.china.huawei.com (unknown [7.202.195.151])
	by mail.maildlp.com (Postfix) with ESMTPS id A6BD0180B60;
	Mon,  4 Aug 2025 23:37:58 +0800 (CST)
Received: from [100.103.109.96] (100.103.109.96) by
 kwepemp500007.china.huawei.com (7.202.195.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 4 Aug 2025 23:37:58 +0800
Message-ID: <52ca5fee-f36d-4238-99ef-8af8888df884@huawei.com>
Date: Mon, 4 Aug 2025 23:37:57 +0800
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
Subject: Re: [PATCH v2 4/4] erofs-utils: mkfs: support EROFS index-only image
 generation from S3
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
CC: <jingrui@huawei.com>, <lihongbo22@huawei.com>
References: <97aa3cdb-076b-4af2-a110-79250b74fc7a@linux.alibaba.com>
 <20250801073046.1900016-1-zhaoyifan28@huawei.com>
 <20250801073046.1900016-3-zhaoyifan28@huawei.com>
 <c52b2552-5e2c-41bc-b754-66508aeddff2@linux.alibaba.com>
From: "zhaoyifan (H)" <zhaoyifan28@huawei.com>
In-Reply-To: <c52b2552-5e2c-41bc-b754-66508aeddff2@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [100.103.109.96]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemp500007.china.huawei.com (7.202.195.151)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org


On 2025/8/1 15:52, Gao Xiang wrote:
>
>
> On 2025/8/1 15:30, Yifan Zhao wrote:
>> From: zhaoyifan <zhaoyifan28@huawei.com>
>>
>> This patch introduces experimental S3 support for mkfs.erofs, 
>> allowing EROFS
>> images to be generated from AWS S3 (and other S3 API compatible 
>> services).
>>
>> Currently the functionality is limited:
>> - only index-only EROFS image generation are supported
>> - only AWS Signature Version 2 is supported
>> - only S3 object name and size are respected during image generation
>>
>> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
>> ---
>> change since v1:
>> - get rid of erofs_init_empty_dir() as described in commit cea8581
>>
>>   lib/liberofs_s3.h |   2 +
>>   lib/remotes/s3.c  | 605 +++++++++++++++++++++++++++++++++++++++++++++-
>>   mkfs/main.c       |   5 +-
>>   3 files changed, 609 insertions(+), 3 deletions(-)
>>
>> diff --git a/lib/liberofs_s3.h b/lib/liberofs_s3.h
>> index 16a06c9..a975fbb 100644
>> --- a/lib/liberofs_s3.h
>> +++ b/lib/liberofs_s3.h
>> @@ -33,6 +33,8 @@ struct erofs_s3 {
>>       enum s3erofs_signature_version sig;
>>   };
>>   +int s3erofs_build_trees(struct erofs_inode *root, struct erofs_s3 
>> *s3cfg);
>> +
>>   #ifdef __cplusplus
>>   }
>>   #endif
>> diff --git a/lib/remotes/s3.c b/lib/remotes/s3.c
>> index 358ee91..a062a50 100644
>> --- a/lib/remotes/s3.c
>> +++ b/lib/remotes/s3.c
>> @@ -4,4 +4,607 @@
>>    *             http://www.huawei.com/
>>    * Created by Yifan Zhao <zhaoyifan28@huawei.com>
>>    */
>> -#include "liberofs_s3.h"
>> \ No newline at end of file
>
> "\ No newline at end of file"
>
> Let's check the editor first, in principle the patches
> shouldn't have this.
>
I forget to add a newline in newly added files. Fix it in v3.
>> ...
>> +
>> +static struct s3erofs_object_info *
>> +s3erofs_get_next_object(struct s3erofs_object_iterator *it)
>> +{
>> +    int ret = 0;
>> +
>> +    if (it->cur < it->total) {
>> +        return &it->objects[it->cur++];
>> +    }
>> +
>> +    if (it->is_truncated) {
>> +        ret = s3erofs_list_objects(it);
>> +        if (ret < 0)
>> +            return ERR_PTR(ret);
>> +
>> +        it->cur = 0;
>> +        return &it->objects[it->cur++];
>> +    }
>> +
>> +    return NULL;
>> +}
>> +
>> +static int s3erofs_global_init(void)
>> +{
>> +    int ret;
>
> Does it support multiple remotes?
>
> Use a mutex to protect this for multiple instances?

For now we only support one remote and there is no race issues here.

Could we add the mutex in the following patches, together with multi

remotes/multithreading support?

>
>> +
>> +    ret = curl_global_init(CURL_GLOBAL_DEFAULT);
>> +    if (ret != CURLE_OK)
>> +        return -EIO;
>> +
>> +    easy_curl = curl_easy_init();
>> +    if (!easy_curl) {
>> +        curl_global_cleanup();
>> +        return -EIO;
>> +    }
>> +
>> +    curl_easy_setopt(easy_curl, CURLOPT_WRITEFUNCTION, 
>> s3erofs_request_write_memory_cb);
>> +    curl_easy_setopt(easy_curl, CURLOPT_FOLLOWLOCATION, 1L);
>> +    curl_easy_setopt(easy_curl, CURLOPT_TIMEOUT, 30L);
>> +
>> +    xmlInitParser();
>> +
>> +    return ret;
>> +}
>> +
>> +static void s3erofs_global_exit(void)
>> +{
>> +    if (!easy_curl)
>> +        return;
>> +
>> +    xmlCleanupParser();
>> +
>> +    curl_easy_cleanup(easy_curl);
>> +    easy_curl = NULL;
>> +
>> +    curl_global_cleanup();
>> +}
>> +
>> +int s3erofs_build_trees(struct erofs_inode *root, struct erofs_s3 
>> *s3cfg)
>> +{
>> +    struct erofs_sb_info *sbi = root->sbi;
>> +    struct s3erofs_object_iterator *iter;
>> +    struct s3erofs_object_info *obj;
>> +    struct erofs_dentry *d;
>> +    struct erofs_inode *inode;
>> +    struct stat st;
>> +    bool dumb;
>> +    int ret = 0;
>> +
>> +    st.st_uid = getuid();
>> +    st.st_gid = getgid();
>> +
>> +    /* XXX */
>> +    st.st_mtime = sbi->epoch;
>
>
>     st.st_mtime = sbi->epoch + sbi->build_time?
>
> build_time can be specified by users too.

Fixed in v3.


Thanks,

Yifan Zhao

>
> Thanks,
> Gao Xiang

