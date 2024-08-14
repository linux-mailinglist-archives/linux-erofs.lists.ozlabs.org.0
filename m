Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B76495138E
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Aug 2024 06:45:51 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Qe3GxjTA;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WkG0V70ZTz2yQ9
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Aug 2024 14:45:46 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Qe3GxjTA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WkG0P4BGxz2xY6
	for <linux-erofs@lists.ozlabs.org>; Wed, 14 Aug 2024 14:45:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723610735; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=DUNKVHlhWUbTZWh1tDOvURgOQH6zw5ODwL/YI91qohg=;
	b=Qe3GxjTAwlV/FcVWx+nu6wB0IoIYDTT0ZQ7EDRP1sIhHauMEFv7FX4QCQaC8d9RnhNHvumFheL9t9kFY4YnJK8Y29kdlq19e5rcMaAGmORTxMlcmPlkVLpZ0xwQ+Et+0IXQ2NQ31dsAlY5r0+GQhZuXDzqRyemgIHbQqNiHo5QE=
Received: from 30.221.133.173(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WCr3Y-a_1723610722)
          by smtp.aliyun-inc.com;
          Wed, 14 Aug 2024 12:45:34 +0800
Message-ID: <1f527588-b5da-48a4-abc4-9d23b336539b@linux.alibaba.com>
Date: Wed, 14 Aug 2024 12:45:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs-utils: fix invalid argument type in erofs_err()
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240814033813.1605825-1-hongzhen@linux.alibaba.com>
 <0a51ac3e-695b-4e6c-aeee-337e1c2f8023@linux.alibaba.com>
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
In-Reply-To: <0a51ac3e-695b-4e6c-aeee-337e1c2f8023@linux.alibaba.com>
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


On 2024/8/14 11:48, Gao Xiang wrote:
>
>
> On 2024/8/14 11:38, Hongzhen Luo wrote:
>> Coverity-id: 502374, 502367, 502362, 502348, 502342, 502341,
>>          502340, 502358
>>
>> Fix several issues found by Coverity regarding "Invalid type in argument
>> for printf format specifier".
>>
>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>> ---
>> v2: Unified through %llu to output debugging information.
>> v1: 
>> https://lore.kernel.org/all/20240813121003.780870-1-hongzhen@linux.alibaba.com/
>> ---
>>   fsck/main.c     |  4 ++--
>>   lib/blobchunk.c |  3 ++-
>>   lib/compress.c  |  4 ++--
>>   lib/fragments.c | 10 +++++-----
>>   lib/super.c     |  3 ++-
>>   mkfs/main.c     |  2 +-
>>   6 files changed, 14 insertions(+), 12 deletions(-)
>>
>> diff --git a/fsck/main.c b/fsck/main.c
>> index 28f1e7e..89d87fb 100644
>> --- a/fsck/main.c
>> +++ b/fsck/main.c
>> @@ -807,8 +807,8 @@ static int erofsfsck_dirent_iter(struct 
>> erofs_dir_context *ctx)
>>       curr_pos = prev_pos;
>>         if (prev_pos + ctx->de_namelen >= PATH_MAX) {
>> -        erofs_err("unable to fsck since the path is too long (%u)",
>> -              curr_pos + ctx->de_namelen);
>> +        erofs_err("unable to fsck since the path is too long (%llu)",
>> +              (curr_pos + ctx->de_namelen) | 0ULL);
>>           return -EOPNOTSUPP;
>>       }
>>   diff --git a/lib/blobchunk.c b/lib/blobchunk.c
>> index 2835755..33b44e3 100644
>> --- a/lib/blobchunk.c
>> +++ b/lib/blobchunk.c
>> @@ -95,7 +95,8 @@ static struct erofs_blobchunk 
>> *erofs_blob_getchunk(struct erofs_sb_info *sbi,
>>           chunk->device_id = 0;
>>       chunk->blkaddr = erofs_blknr(sbi, blkpos);
>>   -    erofs_dbg("Writing chunk (%u bytes) to %u", chunksize, 
>> chunk->blkaddr);
>> +    erofs_dbg("Writing chunk (%llu bytes) to %llu", chunksize | 0ULL,
>> +                            chunk->blkaddr | 0ULL);
>
> Alignment issue?
My negligence, I will fix the alignment issue soon.
>
>>       ret = fwrite(buf, chunksize, 1, blobfile);
>>       if (ret == 1) {
>>           padding = erofs_blkoff(sbi, chunksize);
>> diff --git a/lib/compress.c b/lib/compress.c
>> index 8655e78..17e7112 100644
>> --- a/lib/compress.c
>> +++ b/lib/compress.c
>> @@ -497,8 +497,8 @@ static bool z_erofs_fixup_deduped_fragment(struct 
>> z_erofs_compress_sctx *ctx,
>>       inode->fragmentoff += inode->fragment_size - newsize;
>>       inode->fragment_size = newsize;
>>   -    erofs_dbg("Reducing fragment size to %u at %llu",
>> -          inode->fragment_size, inode->fragmentoff | 0ULL);
>> +    erofs_dbg("Reducing fragment size to %llu at %llu",
>> +          inode->fragment_size | 0ULL, inode->fragmentoff | 0ULL);
>>         /* it's the end */
>>       DBG_BUGON(ctx->tail - ctx->head + ctx->remaining != newsize);
>> diff --git a/lib/fragments.c b/lib/fragments.c
>> index 7591718..e2d3343 100644
>> --- a/lib/fragments.c
>> +++ b/lib/fragments.c
>> @@ -138,7 +138,7 @@ static int z_erofs_fragments_dedupe_find(struct 
>> erofs_inode *inode, int fd,
>>       inode->fragment_size = deduped;
>>       inode->fragmentoff = pos;
>>   -    erofs_dbg("Dedupe %u tail data at %llu", inode->fragment_size,
>> +    erofs_dbg("Dedupe %llu tail data at %llu", inode->fragment_size 
>> | 0ULL,
>>             inode->fragmentoff | 0ULL);
>>   out:
>>       free(data);
>> @@ -283,8 +283,8 @@ int z_erofs_pack_file_from_fd(struct erofs_inode 
>> *inode, int fd,
>>           goto out;
>>       }
>>   -    erofs_dbg("Recording %u fragment data at %lu", 
>> inode->fragment_size,
>> -          inode->fragmentoff);
>> +    erofs_dbg("Recording %llu fragment data at %llu",
>> +          inode->fragment_size | 0ULL, inode->fragmentoff | 0ULL);
>>         if (memblock)
>>           rc = z_erofs_fragments_dedupe_insert(memblock,
>> @@ -316,8 +316,8 @@ int z_erofs_pack_fragments(struct erofs_inode 
>> *inode, void *data,
>>       if (fwrite(data, len, 1, packedfile) != 1)
>>           return -EIO;
>>   -    erofs_dbg("Recording %u fragment data at %lu", 
>> inode->fragment_size,
>> -          inode->fragmentoff);
>> +    erofs_dbg("Recording %llu fragment data at %llu",
>> +          inode->fragment_size | 0ULL, inode->fragmentoff | 0ULL);
>>         ret = z_erofs_fragments_dedupe_insert(data, len, 
>> inode->fragmentoff,
>>                             tofcrc);
>> diff --git a/lib/super.c b/lib/super.c
>> index 32e10cd..7c4d7f2 100644
>> --- a/lib/super.c
>> +++ b/lib/super.c
>> @@ -213,7 +213,8 @@ struct erofs_buffer_head *erofs_reserve_sb(struct 
>> erofs_bufmgr *bmgr)
>>         bh = erofs_balloc(bmgr, META, 0, 0, 0);
>>       if (IS_ERR(bh)) {
>> -        erofs_err("failed to allocate super: %s", PTR_ERR(bh));
>> +        erofs_err("failed to allocate super: %s",
>> +                    erofs_strerror(PTR_ERR(bh)));
>
> Alignment issue again?
>
> Thanks,
> Gao Xiang
>
Same.

---

Thanks,

Hongzhen Luo

>>           return bh;
>>       }
>>       bh->op = &erofs_skip_write_bhops;
>> diff --git a/mkfs/main.c b/mkfs/main.c
>> index b7129eb..1027fc6 100644
>> --- a/mkfs/main.c
>> +++ b/mkfs/main.c
>> @@ -274,7 +274,7 @@ static int erofs_mkfs_feat_set_fragments(bool en, 
>> const char *val,
>>           u64 i = strtoull(val, &endptr, 0);
>>             if (endptr - val != vallen) {
>> -            erofs_err("invalid pcluster size %s for the packed file 
>> %s", val);
>> +            erofs_err("invalid pcluster size %s for the packed 
>> file", val);
>>               return -EINVAL;
>>           }
>>           pclustersize_packed = i;
