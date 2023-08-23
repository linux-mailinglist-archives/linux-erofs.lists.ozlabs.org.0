Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED68C785BF0
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Aug 2023 17:23:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RW92V5YHmz3c5P
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Aug 2023 01:22:58 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RW92M5wFCz2yhZ
	for <linux-erofs@lists.ozlabs.org>; Thu, 24 Aug 2023 01:22:50 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VqQfGU._1692804159;
Received: from 30.25.196.234(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VqQfGU._1692804159)
          by smtp.aliyun-inc.com;
          Wed, 23 Aug 2023 23:22:43 +0800
Message-ID: <4f6d7e71-d989-03d7-0d7b-832a539d1f36@linux.alibaba.com>
Date: Wed, 23 Aug 2023 23:22:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 3/8] erofs: move preparation logic into
 z_erofs_pcluster_begin()
To: Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org
References: <20230817082813.81180-1-hsiangkao@linux.alibaba.com>
 <20230817082813.81180-3-hsiangkao@linux.alibaba.com>
 <48235010-25e4-341f-77a3-a3399af3b6be@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <48235010-25e4-341f-77a3-a3399af3b6be@kernel.org>
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/8/23 23:05, Chao Yu wrote:
> On 2023/8/17 16:28, Gao Xiang wrote:
>> Some preparation logic should be part of z_erofs_pcluster_begin()
>> instead of z_erofs_do_read_page().  Let's move now.
>>
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
>>   fs/erofs/zdata.c | 59 +++++++++++++++++++++---------------------------
>>   1 file changed, 26 insertions(+), 33 deletions(-)
>>
>> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
>> index 4ed99346c4e1..30ecdfe41836 100644
>> --- a/fs/erofs/zdata.c
>> +++ b/fs/erofs/zdata.c
>> @@ -852,7 +852,10 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
>>   static int z_erofs_pcluster_begin(struct z_erofs_decompress_frontend *fe)
>>   {
>>       struct erofs_map_blocks *map = &fe->map;
>> +    struct super_block *sb = fe->inode->i_sb;
>> +    erofs_blk_t blknr = erofs_blknr(sb, map->m_pa);
>>       struct erofs_workgroup *grp = NULL;
>> +    void *mptr;
>>       int ret;
>>       DBG_BUGON(fe->pcl);
>> @@ -861,8 +864,7 @@ static int z_erofs_pcluster_begin(struct z_erofs_decompress_frontend *fe)
>>       DBG_BUGON(fe->owned_head == Z_EROFS_PCLUSTER_NIL);
>>       if (!(map->m_flags & EROFS_MAP_META)) {
>> -        grp = erofs_find_workgroup(fe->inode->i_sb,
>> -                       map->m_pa >> PAGE_SHIFT);
>> +        grp = erofs_find_workgroup(sb, blknr);
>>       } else if ((map->m_pa & ~PAGE_MASK) + map->m_plen > PAGE_SIZE) {
>>           DBG_BUGON(1);
>>           return -EFSCORRUPTED;
>> @@ -881,9 +883,24 @@ static int z_erofs_pcluster_begin(struct z_erofs_decompress_frontend *fe)
>>       } else if (ret) {
>>           return ret;
>>       }
>> +
>>       z_erofs_bvec_iter_begin(&fe->biter, &fe->pcl->bvset,
>>                   Z_EROFS_INLINE_BVECS, fe->pcl->vcnt);
>> -    /* since file-backed online pages are traversed in reverse order */
>> +    if (!z_erofs_is_inline_pcluster(fe->pcl)) {
>> +        /* bind cache first when cached decompression is preferred */
>> +        z_erofs_bind_cache(fe);
>> +    } else {
> 
> Nitpick, mptr can be defined here.

Okay, will apply the following diff directly:

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 3730775650f4..036f610e044b 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -848,7 +848,6 @@ static int z_erofs_pcluster_begin(struct z_erofs_decompress_frontend *fe)
         struct super_block *sb = fe->inode->i_sb;
         erofs_blk_t blknr = erofs_blknr(sb, map->m_pa);
         struct erofs_workgroup *grp = NULL;
-       void *mptr;
         int ret;

         DBG_BUGON(fe->pcl);
@@ -883,6 +882,8 @@ static int z_erofs_pcluster_begin(struct z_erofs_decompress_frontend *fe)
                 /* bind cache first when cached decompression is preferred */
                 z_erofs_bind_cache(fe);
         } else {
+               void *mptr;
+
                 mptr = erofs_read_metabuf(&map->buf, sb, blknr, EROFS_NO_KMAP);
                 if (IS_ERR(mptr)) {
                         ret = PTR_ERR(mptr);

> 
> Reviewed-by: Chao Yu <chao@kernel.org>

Thanks!

Thanks,
Gao Xiang

> 
> Thanks,
> 
