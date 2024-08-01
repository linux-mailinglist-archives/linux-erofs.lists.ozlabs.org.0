Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC99944A7C
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Aug 2024 13:35:52 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FHRHOdGZ;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WZRjd6dwRz3dRK
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Aug 2024 21:35:49 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FHRHOdGZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WZRjZ4sjTz3cQq
	for <linux-erofs@lists.ozlabs.org>; Thu,  1 Aug 2024 21:35:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722512142; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=G/YsuSle6DMFGCtRQo7viufzsspiEbdDHRyz4kG9u3s=;
	b=FHRHOdGZGmDZpWIB3z4MnYKbK/CCErIlKTQgYtFuM0yMUD0i4cufUWElp7PSIb5Qv8meIuckn1CQ/CCyAdLuw+Ww2UMDWPgMYytDQgHpyFyHwCep5JA9K0ycs2CjxpVWzVHJ8olZw+BTOk9OlpuGnrh+uXIX/JRhEVseQ+kV5uY=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0WBsdoCk_1722512141;
Received: from 30.221.131.84(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WBsdoCk_1722512141)
          by smtp.aliyun-inc.com;
          Thu, 01 Aug 2024 19:35:41 +0800
Message-ID: <0f83044e-5024-4c99-a7f8-323cc2b2abe0@linux.alibaba.com>
Date: Thu, 1 Aug 2024 19:35:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: simplify readdir operation
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240801112622.2164029-1-hongzhen@linux.alibaba.com>
 <6c91643e-f55b-4998-b2b2-8eaa3ad747f3@linux.alibaba.com>
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
In-Reply-To: <6c91643e-f55b-4998-b2b2-8eaa3ad747f3@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


On 2024/8/1 19:31, Gao Xiang wrote:
>
>
> On 2024/8/1 19:26, Hongzhen Luo wrote:
>>   - Use i_size instead of i_size_read() due to immutable fses;
>>
>>   - Get rid of an unneeded goto since erofs_fill_dentries() also works;
>>
>>   - Remove unnecessary lines.
>>
>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>> ---
>
> What's the difference from the previous version? why not marking
> it as v2?
>
> Thanks,
> Gao Xiang
>
The previous version was corrupted and couldn't apply the patch using 
`git am`. Sorry, I didn't write a changelog. I will provide a version 
with the changelog added...

Thanks,
Hongzhen Luo

>>   fs/erofs/dir.c      | 35 ++++++++++++-----------------------
>>   fs/erofs/internal.h |  2 +-
>>   2 files changed, 13 insertions(+), 24 deletions(-)
>>
>> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
>> index 2193a6710c8f..c3b90abdee37 100644
>> --- a/fs/erofs/dir.c
>> +++ b/fs/erofs/dir.c
>> @@ -8,19 +8,15 @@
>>     static int erofs_fill_dentries(struct inode *dir, struct 
>> dir_context *ctx,
>>                      void *dentry_blk, struct erofs_dirent *de,
>> -                   unsigned int nameoff, unsigned int maxsize)
>> +                   unsigned int nameoff0, unsigned int maxsize)
>>   {
>> -    const struct erofs_dirent *end = dentry_blk + nameoff;
>> +    const struct erofs_dirent *end = dentry_blk + nameoff0;
>>         while (de < end) {
>> -        const char *de_name;
>> +        unsigned char d_type = fs_ftype_to_dtype(de->file_type);
>> +        unsigned int nameoff = le16_to_cpu(de->nameoff);
>> +        const char *de_name = (char *)dentry_blk + nameoff;
>>           unsigned int de_namelen;
>> -        unsigned char d_type;
>> -
>> -        d_type = fs_ftype_to_dtype(de->file_type);
>> -
>> -        nameoff = le16_to_cpu(de->nameoff);
>> -        de_name = (char *)dentry_blk + nameoff;
>>             /* the last dirent in the block? */
>>           if (de + 1 >= end)
>> @@ -52,21 +48,20 @@ static int erofs_readdir(struct file *f, struct 
>> dir_context *ctx)
>>       struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
>>       struct super_block *sb = dir->i_sb;
>>       unsigned long bsz = sb->s_blocksize;
>> -    const size_t dirsize = i_size_read(dir);
>> -    unsigned int i = erofs_blknr(sb, ctx->pos);
>>       unsigned int ofs = erofs_blkoff(sb, ctx->pos);
>>       int err = 0;
>>       bool initial = true;
>>         buf.mapping = dir->i_mapping;
>> -    while (ctx->pos < dirsize) {
>> +    while (ctx->pos < dir->i_size) {
>> +        erofs_off_t dbstart = ctx->pos - ofs;
>>           struct erofs_dirent *de;
>>           unsigned int nameoff, maxsize;
>>   -        de = erofs_bread(&buf, erofs_pos(sb, i), EROFS_KMAP);
>> +        de = erofs_bread(&buf, dbstart, EROFS_KMAP);
>>           if (IS_ERR(de)) {
>>               erofs_err(sb, "fail to readdir of logical block %u of 
>> nid %llu",
>> -                  i, EROFS_I(dir)->nid);
>> +                  erofs_blknr(sb, dbstart), EROFS_I(dir)->nid);
>>               err = PTR_ERR(de);
>>               break;
>>           }
>> @@ -79,25 +74,19 @@ static int erofs_readdir(struct file *f, struct 
>> dir_context *ctx)
>>               break;
>>           }
>>   -        maxsize = min_t(unsigned int, dirsize - ctx->pos + ofs, bsz);
>> -
>> +        maxsize = min_t(unsigned int, dir->i_size - dbstart, bsz);
>>           /* search dirents at the arbitrary position */
>>           if (initial) {
>>               initial = false;
>> -
>>               ofs = roundup(ofs, sizeof(struct erofs_dirent));
>> -            ctx->pos = erofs_pos(sb, i) + ofs;
>> -            if (ofs >= nameoff)
>> -                goto skip_this;
>> +            ctx->pos = dbstart + ofs;
>>           }
>>             err = erofs_fill_dentries(dir, ctx, de, (void *)de + ofs,
>>                         nameoff, maxsize);
>>           if (err)
>>               break;
>> -skip_this:
>> -        ctx->pos = erofs_pos(sb, i) + maxsize;
>> -        ++i;
>> +        ctx->pos = dbstart + maxsize;
>>           ofs = 0;
>>       }
>>       erofs_put_metabuf(&buf);
>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>> index 736607675396..45dc15ebd870 100644
>> --- a/fs/erofs/internal.h
>> +++ b/fs/erofs/internal.h
>> @@ -220,7 +220,7 @@ struct erofs_buf {
>>   };
>>   #define __EROFS_BUF_INITIALIZER    ((struct erofs_buf){ .page = 
>> NULL })
>>   -#define erofs_blknr(sb, addr)    ((addr) >> (sb)->s_blocksize_bits)
>> +#define erofs_blknr(sb, addr)    ((erofs_blk_t)((addr) >> 
>> (sb)->s_blocksize_bits))
>>   #define erofs_blkoff(sb, addr)    ((addr) & ((sb)->s_blocksize - 1))
>>   #define erofs_pos(sb, blk)    ((erofs_off_t)(blk) << 
>> (sb)->s_blocksize_bits)
>>   #define erofs_iblks(i)    (round_up((i)->i_size, i_blocksize(i)) >> 
>> (i)->i_blkbits)
