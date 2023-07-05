Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FC9747C89
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Jul 2023 07:39:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QwpQH5LkGz30XV
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Jul 2023 15:39:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QwpQ83TQVz307K
	for <linux-erofs@lists.ozlabs.org>; Wed,  5 Jul 2023 15:39:42 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VmfOgEO_1688535576;
Received: from 30.221.144.239(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VmfOgEO_1688535576)
          by smtp.aliyun-inc.com;
          Wed, 05 Jul 2023 13:39:38 +0800
Message-ID: <32504245-f018-8d79-1916-6ec00bf61b7d@linux.alibaba.com>
Date: Wed, 5 Jul 2023 13:39:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] erofs-utils: mkfs: don't clean cached xattr items
 prematurely
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, chao@kernel.org,
 huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
References: <20230705021040.76265-1-jefflexu@linux.alibaba.com>
 <60263449-74c1-a713-fec9-ce23af65427d@linux.alibaba.com>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <60263449-74c1-a713-fec9-ce23af65427d@linux.alibaba.com>
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



On 7/5/23 10:21 AM, Gao Xiang wrote:
> 
> 
> On 2023/7/5 10:10, Jingbo Xu wrote:
>> Extended attributes read from file are cached in a hash table when
>> building shared extended attributes.  However the cached xattr items
>> for inline xattrs are cleaned up from the hash table when the processing
>> for shared extended attributes has finished, while later the hash table
>> is reconstructed from scratch when building the inode tree (see
>> erofs_mkfs_build_tree_from_path()).
>>
>> Don't clean up the xattr hash table halfway until mkfs exits.  Also move
>> the logic of cleaning long xattr name prefixes into erofs_cleanxattrs().
>>
>> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
>> ---
>>   include/erofs/xattr.h |  2 +-
>>   lib/xattr.c           | 30 ++++++++----------------------
>>   mkfs/main.c           |  2 +-
>>   3 files changed, 10 insertions(+), 24 deletions(-)
>>
>> diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
>> index 14fc081..b202f78 100644
>> --- a/include/erofs/xattr.h
>> +++ b/include/erofs/xattr.h
>> @@ -75,9 +75,9 @@ static inline unsigned int
>> xattrblock_offset(unsigned int xattr_id)
>>   int erofs_prepare_xattr_ibody(struct erofs_inode *inode);
>>   char *erofs_export_xattr_ibody(struct list_head *ixattrs, unsigned
>> int size);
>>   int erofs_build_shared_xattrs_from_path(const char *path);
>> +void erofs_cleanxattrs(void);
>>     int erofs_xattr_insert_name_prefix(const char *prefix);
>> -void erofs_xattr_cleanup_name_prefixes(void);
>>   int erofs_xattr_write_name_prefixes(FILE *f);
>>     #ifdef __cplusplus
>> diff --git a/lib/xattr.c b/lib/xattr.c
>> index 7d7dc54..8d0079f 100644
>> --- a/lib/xattr.c
>> +++ b/lib/xattr.c
>> @@ -547,24 +547,23 @@ fail:
>>       return ret;
>>   }
>>   -static void erofs_cleanxattrs(bool sharedxattrs)
>> +void erofs_cleanxattrs(void)
>>   {
>>       unsigned int i;
>>       struct xattr_item *item;
>>       struct hlist_node *tmp;
>> +    struct ea_type_node *tnode, *n;
>>         hash_for_each_safe(ea_hashtable, i, tmp, item, node) {
>> -        if (sharedxattrs && item->shared_xattr_id >= 0)
>> -            continue;
> 
> I'm not sure it's the expected behavior. Previously we will remove
> all non-shared xattrs which are below xattr threshold in the shared
> xattr generation process.

What's the purpose of removing these non-shared xattrs while leaving
shared xattrs there?

> 
> But now, such non-shared xattrs will be left in memory.  What
> the benefits of this?  In addition, I'm not sure if we need to add
> non-shared (inline) xattrs to hash table as well.

Later erofs_mkfs_build_tree_from_path() needs to reconstruct these
non-shared xattrs, which have been previously removed.

erofs_mkfs_build_tree_from_path
  erofs_mkfs_build_tree
    erofs_prepare_xattr_ibody
      read_xattrs_from_file


-- 
Thanks,
Jingbo
