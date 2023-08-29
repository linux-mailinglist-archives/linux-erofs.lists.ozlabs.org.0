Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D2678C742
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Aug 2023 16:20:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RZqMr009Wz3Wts
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Aug 2023 00:20:40 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RZqMm5VVQz2xr6
	for <linux-erofs@lists.ozlabs.org>; Wed, 30 Aug 2023 00:20:35 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vqrogp6_1693318829;
Received: from 30.236.24.176(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vqrogp6_1693318829)
          by smtp.aliyun-inc.com;
          Tue, 29 Aug 2023 22:20:29 +0800
Message-ID: <f3b8c680-3a7c-dc95-29f4-92f88b92b4c4@linux.alibaba.com>
Date: Tue, 29 Aug 2023 22:20:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v6 3/3] erofs-utils: mkfs: enable xattr name filter
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20230829124127.36719-1-jefflexu@linux.alibaba.com>
 <20230829124127.36719-4-jefflexu@linux.alibaba.com>
 <a6655c7a-9506-eb7e-5961-5f660ecb6e44@linux.alibaba.com>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <a6655c7a-9506-eb7e-5961-5f660ecb6e44@linux.alibaba.com>
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



On 8/29/23 8:53 PM, Gao Xiang wrote:
> 
> 
> On 2023/8/29 20:41, Jingbo Xu wrote:
>> Introduce "-Exattr-name-filter" option to enable the xattr name bloom
>> filter feature.
>>
>> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
>> ---
>>   include/erofs/config.h   |  1 +
>>   include/erofs/internal.h |  1 +
>>   lib/xattr.c              | 63 ++++++++++++++++++++++++++++++++++++++++
>>   mkfs/main.c              |  7 +++++
>>   4 files changed, 72 insertions(+)
>>
>> diff --git a/include/erofs/config.h b/include/erofs/config.h
>> index 8f52d2c..c51f0cd 100644
>> --- a/include/erofs/config.h
>> +++ b/include/erofs/config.h
>> @@ -53,6 +53,7 @@ struct erofs_configure {
>>       bool c_ignore_mtime;
>>       bool c_showprogress;
>>       bool c_extra_ea_name_prefixes;
>> +    bool c_xattr_name_filter;
>>     #ifdef HAVE_LIBSELINUX
>>       struct selabel_handle *sehnd;
>> diff --git a/include/erofs/internal.h b/include/erofs/internal.h
>> index 3e73eef..382024a 100644
>> --- a/include/erofs/internal.h
>> +++ b/include/erofs/internal.h
>> @@ -139,6 +139,7 @@ EROFS_FEATURE_FUNCS(fragments, incompat,
>> INCOMPAT_FRAGMENTS)
>>   EROFS_FEATURE_FUNCS(dedupe, incompat, INCOMPAT_DEDUPE)
>>   EROFS_FEATURE_FUNCS(xattr_prefixes, incompat, INCOMPAT_XATTR_PREFIXES)
>>   EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
>> +EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
>>     #define EROFS_I_EA_INITED    (1 << 0)
>>   #define EROFS_I_Z_INITED    (1 << 1)
>> diff --git a/lib/xattr.c b/lib/xattr.c
>> index 46a301a..325241d 100644
>> --- a/lib/xattr.c
>> +++ b/lib/xattr.c
>> @@ -18,6 +18,7 @@
>>   #include "erofs/cache.h"
>>   #include "erofs/io.h"
>>   #include "erofs/fragments.h"
>> +#include "erofs/xxhash.h"
>>   #include "liberofs_private.h"
>>     #define EA_HASHTABLE_BITS 16
>> @@ -783,6 +784,63 @@ out:
>>       return ret;
>>   }
>>   +
>> +static int erofs_xattr_filter_hashbit(struct xattr_item *item)
>> +{
>> +    u8 prefix = item->prefix;
>> +    const char *key = item->kvbuf;
>> +    unsigned int len = item->len[0];
>> +    char *name = NULL;
>> +    uint32_t hashbit;
>> +
>> +    if (prefix & EROFS_XATTR_LONG_PREFIX) {
>> +        struct ea_type_node *tnode;
>> +        u16 prefix_len;
>> +        int ret;
>> +
>> +        list_for_each_entry(tnode, &ea_name_prefixes, list) {
>> +            if (tnode->index == item->prefix) {
>> +                ret = asprintf(&name, "%s%.*s",
>> +                           tnode->type.prefix, len, key);
>> +                if (ret < 0)
>> +                    return -ENOMEM;
>> +                break;
>> +            }
>> +        }
>> +        if (!name)
>> +            return -ENOENT;
>> +
>> +        if (!match_base_prefix(name, &prefix, &prefix_len)) {
>> +            free(name);
>> +            return -ENOENT;
>> +        }
>> +        key = name + prefix_len;
>> +        len = strlen(key);
>> +    }
>> +
>> +    hashbit = xxh32(key, len, EROFS_XATTR_FILTER_SEED + prefix) &
>> +          (EROFS_XATTR_FILTER_BITS - 1);
>> +    if (name)
>> +        free(name);
>> +    return hashbit;
>> +}
>> +
>> +static u32 erofs_xattr_filter_map(struct list_head *ixattrs)
>> +{
>> +    struct inode_xattr_node *node, *n;
>> +    u32 name_filter;
>> +    int hashbit;
>> +
>> +    name_filter = 0;
>> +    list_for_each_entry_safe(node, n, ixattrs, list) {
>> +        hashbit = erofs_xattr_filter_hashbit(node->item);
>> +        if (hashbit < 0)
> 
> I'd suggest to clear feature bit instead:
> 
> erofs_sb_clear_xattr_filter(&sbi);

Good idea.


> 
>> +            return 0;
>> +        name_filter |= (1UL << hashbit);
>> +    }
>> +    return EROFS_XATTR_FILTER_DEFAULT & ~name_filter;
>> +}
>> +
>>   char *erofs_export_xattr_ibody(struct list_head *ixattrs, unsigned
>> int size)
>>   {
>>       struct inode_xattr_node *node, *n;
>> @@ -797,6 +855,11 @@ char *erofs_export_xattr_ibody(struct list_head
>> *ixattrs, unsigned int size)
>>       header = (struct erofs_xattr_ibody_header *)buf;
>>       header->h_shared_count = 0;
>>   +    if (cfg.c_xattr_name_filter) {
>> +        u32 name_filter = erofs_xattr_filter_map(ixattrs);
> 
> Leave a blank line here.
> 
>> +        header->h_name_filter = cpu_to_le32(name_filter);
> 
> Or
>         header->h_name_filter =
>             cpu_to_le32(erofs_xattr_filter_map(ixattrs));
> 

Okay.  I would prefer the latter.

-- 
Thanks,
Jingbo
