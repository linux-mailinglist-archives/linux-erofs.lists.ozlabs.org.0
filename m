Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A92977D9D8
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Aug 2023 07:39:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RQcQb31RVz3cP5
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Aug 2023 15:39:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RQcQW2lspz2xLN
	for <linux-erofs@lists.ozlabs.org>; Wed, 16 Aug 2023 15:39:29 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VpuakaK_1692164360;
Received: from 30.221.149.123(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VpuakaK_1692164360)
          by smtp.aliyun-inc.com;
          Wed, 16 Aug 2023 13:39:21 +0800
Message-ID: <50e1e1d6-d5ad-63e8-71ba-e6251555c65e@linux.alibaba.com>
Date: Wed, 16 Aug 2023 13:39:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2 3/4] erofs-utils: add erofs_read_metadata() helper
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, xiang@kernel.org,
 linux-erofs@lists.ozlabs.org
References: <20230816034941.126866-1-jefflexu@linux.alibaba.com>
 <20230816034941.126866-4-jefflexu@linux.alibaba.com>
 <9909fa9c-6526-d0d0-550f-d31157923a69@linux.alibaba.com>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <9909fa9c-6526-d0d0-550f-d31157923a69@linux.alibaba.com>
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



On 8/16/23 11:58 AM, Gao Xiang wrote:
> 
> 
> On 2023/8/16 11:49, Jingbo Xu wrote:
>> Add erofs_read_metadata() helper reading variable-sized metadata from
>> inode specified by @nid.  Read from meta inode if @nid is 0.
>>
>> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
>> ---
>>   include/erofs/internal.h |  2 +
>>   lib/data.c               | 84 ++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 86 insertions(+)
>>
>> diff --git a/include/erofs/internal.h b/include/erofs/internal.h
>> index a04e6a6..3e7319d 100644
>> --- a/include/erofs/internal.h
>> +++ b/include/erofs/internal.h
>> @@ -364,6 +364,8 @@ int erofs_read_one_data(struct erofs_inode *inode,
>> struct erofs_map_blocks *map,
>>   int z_erofs_read_one_data(struct erofs_inode *inode,
>>               struct erofs_map_blocks *map, char *raw, char *buffer,
>>               erofs_off_t skip, erofs_off_t length, bool trimmed);
>> +void *erofs_read_metadata(struct erofs_sb_info *sbi, erofs_nid_t nid,
>> +              erofs_off_t *offset, int *lengthp);
>>     static inline int erofs_get_occupied_size(const struct erofs_inode
>> *inode,
>>                         erofs_off_t *size)
>> diff --git a/lib/data.c b/lib/data.c
>> index a172bb5..3ec5330 100644
>> --- a/lib/data.c
>> +++ b/lib/data.c
>> @@ -372,3 +372,87 @@ int erofs_pread(struct erofs_inode *inode, char
>> *buf,
>>       }
>>       return -EINVAL;
>>   }
>> +
>> +static void *erofs_read_meta(struct erofs_sb_info *sbi, erofs_nid_t nid,
>> +                 erofs_off_t *offset, int *lengthp)
> 
> erofs_read_metadata_nid?

Okay.

> 
>> +{
>> +    struct erofs_inode vi = { .sbi = sbi, .nid = nid };
>> +    __le16 __len;
>> +    int ret, len;
>> +    char *buffer;
>> +
>> +    ret = erofs_read_inode_from_disk(&vi);
>> +    if (ret)
>> +        return ERR_PTR(ret);
>> +
>> +    *offset = round_up(*offset, 4);
>> +    ret = erofs_pread(&vi, (void *)&__len, sizeof(__le16), *offset);
>> +    if (ret)
>> +        return ERR_PTR(ret);
>> +
>> +    len = le16_to_cpu(__len);
>> +    if (!len)
>> +        return ERR_PTR(-EFSCORRUPTED);
>> +
>> +    buffer = malloc(len);
>> +    if (!buffer)
>> +        return ERR_PTR(-ENOMEM);
>> +    *offset += sizeof(__le16);
>> +    *lengthp = len;
>> +
>> +    ret = erofs_pread(&vi, buffer, len, *offset);
>> +    if (ret) {
>> +        free(buffer);
>> +        return ERR_PTR(ret);
>> +    }
>> +    *offset += len;
>> +    return buffer;
>> +}
>> +
>> +static void *erofs_read_metainode(struct erofs_sb_info *sbi,
>> +                  erofs_off_t *offset, int *lengthp)
> 
> erofs_read_metadata_bdi?

Okay.


-- 
Thanks,
Jingbo
