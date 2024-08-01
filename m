Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48822944C00
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Aug 2024 15:00:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1722517203;
	bh=mFUGdWsSDpq7kJy9KqnKwrVR7zE2ugLpgGVL9GqTHqE=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=JYkjkwTbbzUIshnnfyxQiaP3bePp2MyeVlQwToZCALt9vNXYl1bebQDJjE2FNGLwm
	 1Zd6kE5gXxCvN2jju7te3ptsQ+3aAOlxdbhMt5WF3dkXKbchEbK3GuCDQeRnXInywB
	 i4Gy2cUlHDhSFHyXENyLNx+uLJ65Ce4o8Clh5bRZPBQ842EJ6addkDXGkhmK4GBaOF
	 KwibiwdhEABX3IWDj6gh3iS3muO/YRibafnmf+VynRIR2U9lZfuL8D1+nIRzgHN82C
	 giiMF7qTS4BQbUGAe5hOhlP9AdDzAfcNO8w2zdD992MVMWKue39nEBELwgfKnvgZk4
	 dIwpjxhHeDf1Q==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WZTZq1KMbz3dRP
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Aug 2024 23:00:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WZTZk4ZLZz2yPq
	for <linux-erofs@lists.ozlabs.org>; Thu,  1 Aug 2024 22:59:58 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WZTSJ0g5GzyNnn
	for <linux-erofs@lists.ozlabs.org>; Thu,  1 Aug 2024 20:54:24 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id A154818006C
	for <linux-erofs@lists.ozlabs.org>; Thu,  1 Aug 2024 20:59:23 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 1 Aug 2024 20:59:23 +0800
Message-ID: <216d4c7f-66c0-49e7-89ef-969576b21c13@huawei.com>
Date: Thu, 1 Aug 2024 20:59:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: simplify readdir operation
Content-Language: en-US
To: <linux-erofs@lists.ozlabs.org>
References: <20240801112622.2164029-1-hongzhen@linux.alibaba.com>
 <6c91643e-f55b-4998-b2b2-8eaa3ad747f3@linux.alibaba.com>
 <0f83044e-5024-4c99-a7f8-323cc2b2abe0@linux.alibaba.com>
In-Reply-To: <0f83044e-5024-4c99-a7f8-323cc2b2abe0@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500022.china.huawei.com (7.185.36.66)
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
From: Hongbo Li via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Hongbo Li <lihongbo22@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/8/1 19:35, Hongzhen Luo wrote:
> 
> On 2024/8/1 19:31, Gao Xiang wrote:
>>
>>
>> On 2024/8/1 19:26, Hongzhen Luo wrote:
>>>   - Use i_size instead of i_size_read() due to immutable fses;
>>>
>>>   - Get rid of an unneeded goto since erofs_fill_dentries() also works;
>>>
>>>   - Remove unnecessary lines.
>>>
>>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>>> ---
>>
>> What's the difference from the previous version? why not marking
>> it as v2?
>>
>> Thanks,
>> Gao Xiang
>>
> The previous version was corrupted and couldn't apply the patch using 
> `git am`. Sorry, I didn't write a changelog. I will provide a version 
> with the changelog added...
May be he also means the subject should be marked [PATCH v..]

Thanks,
Hongbo

> 
> Thanks,
> Hongzhen Luo
> 
>>>   fs/erofs/dir.c      | 35 ++++++++++++-----------------------
>>>   fs/erofs/internal.h |  2 +-
>>>   2 files changed, 13 insertions(+), 24 deletions(-)
>>>
>>> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
>>> index 2193a6710c8f..c3b90abdee37 100644
>>> --- a/fs/erofs/dir.c
>>> +++ b/fs/erofs/dir.c
>>> @@ -8,19 +8,15 @@
>>>     static int erofs_fill_dentries(struct inode *dir, struct 
>>> dir_context *ctx,
>>>                      void *dentry_blk, struct erofs_dirent *de,
>>> -                   unsigned int nameoff, unsigned int maxsize)
>>> +                   unsigned int nameoff0, unsigned int maxsize)
>>>   {
>>> -    const struct erofs_dirent *end = dentry_blk + nameoff;
>>> +    const struct erofs_dirent *end = dentry_blk + nameoff0;
>>>         while (de < end) {
>>> -        const char *de_name;
>>> +        unsigned char d_type = fs_ftype_to_dtype(de->file_type);
>>> +        unsigned int nameoff = le16_to_cpu(de->nameoff);
>>> +        const char *de_name = (char *)dentry_blk + nameoff;
>>>           unsigned int de_namelen;
>>> -        unsigned char d_type;
>>> -
>>> -        d_type = fs_ftype_to_dtype(de->file_type);
>>> -
>>> -        nameoff = le16_to_cpu(de->nameoff);
>>> -        de_name = (char *)dentry_blk + nameoff;
>>>             /* the last dirent in the block? */
>>>           if (de + 1 >= end)
>>> @@ -52,21 +48,20 @@ static int erofs_readdir(struct file *f, struct 
>>> dir_context *ctx)
>>>       struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
>>>       struct super_block *sb = dir->i_sb;
>>>       unsigned long bsz = sb->s_blocksize;
>>> -    const size_t dirsize = i_size_read(dir);
>>> -    unsigned int i = erofs_blknr(sb, ctx->pos);
>>>       unsigned int ofs = erofs_blkoff(sb, ctx->pos);
>>>       int err = 0;
>>>       bool initial = true;
>>>         buf.mapping = dir->i_mapping;
>>> -    while (ctx->pos < dirsize) {
>>> +    while (ctx->pos < dir->i_size) {
>>> +        erofs_off_t dbstart = ctx->pos - ofs;
>>>           struct erofs_dirent *de;
>>>           unsigned int nameoff, maxsize;
>>>   -        de = erofs_bread(&buf, erofs_pos(sb, i), EROFS_KMAP);
>>> +        de = erofs_bread(&buf, dbstart, EROFS_KMAP);
>>>           if (IS_ERR(de)) {
>>>               erofs_err(sb, "fail to readdir of logical block %u of 
>>> nid %llu",
>>> -                  i, EROFS_I(dir)->nid);
>>> +                  erofs_blknr(sb, dbstart), EROFS_I(dir)->nid);
>>>               err = PTR_ERR(de);
>>>               break;
>>>           }
>>> @@ -79,25 +74,19 @@ static int erofs_readdir(struct file *f, struct 
>>> dir_context *ctx)
>>>               break;
>>>           }
>>>   -        maxsize = min_t(unsigned int, dirsize - ctx->pos + ofs, bsz);
>>> -
>>> +        maxsize = min_t(unsigned int, dir->i_size - dbstart, bsz);
>>>           /* search dirents at the arbitrary position */
>>>           if (initial) {
>>>               initial = false;
>>> -
>>>               ofs = roundup(ofs, sizeof(struct erofs_dirent));
>>> -            ctx->pos = erofs_pos(sb, i) + ofs;
>>> -            if (ofs >= nameoff)
>>> -                goto skip_this;
>>> +            ctx->pos = dbstart + ofs;
>>>           }
>>>             err = erofs_fill_dentries(dir, ctx, de, (void *)de + ofs,
>>>                         nameoff, maxsize);
>>>           if (err)
>>>               break;
>>> -skip_this:
>>> -        ctx->pos = erofs_pos(sb, i) + maxsize;
>>> -        ++i;
>>> +        ctx->pos = dbstart + maxsize;
>>>           ofs = 0;
>>>       }
>>>       erofs_put_metabuf(&buf);
>>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>>> index 736607675396..45dc15ebd870 100644
>>> --- a/fs/erofs/internal.h
>>> +++ b/fs/erofs/internal.h
>>> @@ -220,7 +220,7 @@ struct erofs_buf {
>>>   };
>>>   #define __EROFS_BUF_INITIALIZER    ((struct erofs_buf){ .page = 
>>> NULL })
>>>   -#define erofs_blknr(sb, addr)    ((addr) >> (sb)->s_blocksize_bits)
>>> +#define erofs_blknr(sb, addr)    ((erofs_blk_t)((addr) >> 
>>> (sb)->s_blocksize_bits))
>>>   #define erofs_blkoff(sb, addr)    ((addr) & ((sb)->s_blocksize - 1))
>>>   #define erofs_pos(sb, blk)    ((erofs_off_t)(blk) << 
>>> (sb)->s_blocksize_bits)
>>>   #define erofs_iblks(i)    (round_up((i)->i_size, i_blocksize(i)) >> 
>>> (i)->i_blkbits)
