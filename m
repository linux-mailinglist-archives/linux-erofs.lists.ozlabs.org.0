Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E37596D2E6
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Sep 2024 11:14:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wztwn2cNNz2ytm
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Sep 2024 19:14:49 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725527688;
	cv=none; b=KfwxbArzhH66Vq/lbt4zZ2FslOQ4TbSULR447j2q/gCxzTL270UsLZm3kl+OkJ1ikyTy+YL/jxOmEmoQQOrm0HPS5UoRA6jcBLT4CxLxCfzdmji+0b5GvIzSs5CNh1l/8WAA5E//gPxhQ4e3DlxUxt5y8H6ZSpvYMidXu7F3Cw6mZjW1X81VGuUOudBbKgV9PKNDy+giainzkODRcBglXXanB9syyzg+l3icSTZC6RQQ10L+5w5jU+pFsAQGEz4QL99WQhA8gtoIbOHXszgm7S2UPvglXUMjo6CxTp47YOPAdCdejFCwWfZ6EtX8j8yy0x4guJs+lG6Gbw1KIlRTSA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725527688; c=relaxed/relaxed;
	bh=MU0qbrEa7gSTdc2daza8St3Kc7emZKnwgOJ/IvOYM6U=;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type; b=hRL+X7ZwZMkVmlJl+fHy6pPk3YbC3xgAlRuKi27FJ24YqFoIm2vgju3FOZ861xjM9G9bCAgRCzrEiYxfcXv0e6GwfSuQ7rLjQCG3KoB2VQkCZdzPzm3rwcRWJsLsQDadLxqNksCCeTn7JTn/SteXR3r2uEyyokIS7uVJ5Ugn26qfOX93NMPQ075QuTckWk2qQvqdK9D4+Rx5K6ZUcxYideBtA5b7M7C2RGQuZsB8vReEYrr6f2kVDbgnKQ33/SNCE4fnemfVd83V/aA/9KYprgyxrcQdr4gBhgAvvyud3ZAVoYn9ojcmFh8HAg67C4C8UPATAwmEvEeH1JOGLttjDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=k3wu1dji; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=k3wu1dji;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wztwl4JDPz2xwH
	for <linux-erofs@lists.ozlabs.org>; Thu,  5 Sep 2024 19:14:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725527683; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=MU0qbrEa7gSTdc2daza8St3Kc7emZKnwgOJ/IvOYM6U=;
	b=k3wu1djiEo//Y7vnYe5TXxPaDyj61E7yqmTEr/AJQApIfKqgE+Vgv2PaoK7JvFc9KrT6rLzhoWCNnhqHgBRLZ6D1u/0+xi4zxKq9cgv/FU5F0fzUhnl/T1LIDG0NEX3KxAPJZuYjxxA01G9I+zAgHdWP7VSrQ/+3y1UpcsgfsPs=
Received: from 30.221.129.218(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WELAvGX_1725527682)
          by smtp.aliyun-inc.com;
          Thu, 05 Sep 2024 17:14:43 +0800
Message-ID: <41104317-993b-47c6-9c25-61ad26203d62@linux.alibaba.com>
Date: Thu, 5 Sep 2024 17:14:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] erofs: support compressed inodes for fileio
To: Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org
References: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com>
 <20240830032840.3783206-3-hsiangkao@linux.alibaba.com>
 <64a8c756-3cca-4e34-b907-b737569d7cec@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <64a8c756-3cca-4e34-b907-b737569d7cec@kernel.org>
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



On 2024/9/5 17:01, Chao Yu wrote:
> On 2024/8/30 11:28, Gao Xiang wrote:
>> Use pseudo bios just like the previous fscache approach since
>> merged bio_vecs can be filled properly with unique interfaces.
>>
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
>>   fs/erofs/fileio.c   | 25 +++++++++++++++++++++----
>>   fs/erofs/inode.c    |  6 ------
>>   fs/erofs/internal.h |  8 ++++++++
>>   fs/erofs/zdata.c    | 27 +++++++++++++++++----------
>>   4 files changed, 46 insertions(+), 20 deletions(-)
>>
>> diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
>> index eab52b8abd0b..9e4b851d85c0 100644
>> --- a/fs/erofs/fileio.c
>> +++ b/fs/erofs/fileio.c
>> @@ -23,7 +23,6 @@ static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
>>               container_of(iocb, struct erofs_fileio_rq, iocb);
>>       struct folio_iter fi;
>> -    DBG_BUGON(rq->bio.bi_end_io);
>>       if (ret > 0) {
>>           if (ret != rq->bio.bi_iter.bi_size) {
>>               bio_advance(&rq->bio, ret);
>> @@ -31,9 +30,13 @@ static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
>>           }
>>           ret = 0;
>>       }
>> -    bio_for_each_folio_all(fi, &rq->bio) {
>> -        DBG_BUGON(folio_test_uptodate(fi.folio));
>> -        erofs_onlinefolio_end(fi.folio, ret);
>> +    if (rq->bio.bi_end_io) {
>> +        rq->bio.bi_end_io(&rq->bio);
>> +    } else {
>> +        bio_for_each_folio_all(fi, &rq->bio) {
>> +            DBG_BUGON(folio_test_uptodate(fi.folio));
>> +            erofs_onlinefolio_end(fi.folio, ret);
>> +        }
>>       }
>>       kfree(rq);
>>   }
>> @@ -68,6 +71,20 @@ static struct erofs_fileio_rq *erofs_fileio_rq_alloc(struct erofs_map_dev *mdev)
>>       return rq;
>>   }
>> +struct bio *erofs_fileio_bio_alloc(struct erofs_map_dev *mdev)
>> +{
>> +    struct erofs_fileio_rq *rq;
>> +
>> +    rq = erofs_fileio_rq_alloc(mdev);
>> +    return rq ? &rq->bio : NULL;
>> +}
>> +
>> +void erofs_fileio_submit_bio(struct bio *bio)
>> +{
>> +    return erofs_fileio_rq_submit(container_of(bio, struct erofs_fileio_rq,
>> +                           bio));
>> +}
>> +
>>   static int erofs_fileio_scan_folio(struct erofs_fileio *io, struct folio *folio)
>>   {
>>       struct inode *inode = folio_inode(folio);
>> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
>> index 4a902e6e69a5..82259553d9f6 100644
>> --- a/fs/erofs/inode.c
>> +++ b/fs/erofs/inode.c
>> @@ -260,12 +260,6 @@ static int erofs_fill_inode(struct inode *inode)
>>       mapping_set_large_folios(inode->i_mapping);
>>       if (erofs_inode_is_data_compressed(vi->datalayout)) {
>>   #ifdef CONFIG_EROFS_FS_ZIP
>> -#ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
>> -        if (erofs_is_fileio_mode(EROFS_SB(inode->i_sb))) {
>> -            err = -EOPNOTSUPP;
>> -            goto out_unlock;
>> -        }
>> -#endif
>>           DO_ONCE_LITE_IF(inode->i_blkbits != PAGE_SHIFT,
>>                 erofs_info, inode->i_sb,
>>                 "EXPERIMENTAL EROFS subpage compressed block support in use. Use at your own risk!");
>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>> index 9bc4dcfd06d7..4efd578d7c62 100644
>> --- a/fs/erofs/internal.h
>> +++ b/fs/erofs/internal.h
>> @@ -489,6 +489,14 @@ static inline void z_erofs_exit_subsystem(void) {}
>>   static inline int erofs_init_managed_cache(struct super_block *sb) { return 0; }
>>   #endif    /* !CONFIG_EROFS_FS_ZIP */
>> +#ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
>> +struct bio *erofs_fileio_bio_alloc(struct erofs_map_dev *mdev);
>> +void erofs_fileio_submit_bio(struct bio *bio);
>> +#else
>> +static inline struct bio *erofs_fileio_bio_alloc(struct erofs_map_dev *mdev) { return NULL; }
>> +static inline void erofs_fileio_submit_bio(struct bio *bio) {}
>> +#endif
>> +
>>   #ifdef CONFIG_EROFS_FS_ONDEMAND
>>   int erofs_fscache_register_fs(struct super_block *sb);
>>   void erofs_fscache_unregister_fs(struct super_block *sb);
>> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
>> index 350612f32ac6..2271cb74ae3a 100644
>> --- a/fs/erofs/zdata.c
>> +++ b/fs/erofs/zdata.c
>> @@ -1618,10 +1618,12 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
>>               if (bio && (cur != last_pa ||
>>                       bio->bi_bdev != mdev.m_bdev)) {
>>   io_retry:
>> -                if (!erofs_is_fscache_mode(sb))
>> -                    submit_bio(bio);
>> -                else
>> +                if (erofs_is_fileio_mode(EROFS_SB(sb)))
>> +                    erofs_fileio_submit_bio(bio);
>> +                else if (erofs_is_fscache_mode(sb))
>>                       erofs_fscache_submit_bio(bio);
>> +                else
>> +                    submit_bio(bio);
>>                   if (memstall) {
>>                       psi_memstall_leave(&pflags);
>> @@ -1637,10 +1639,13 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
>>               }
>>               if (!bio) {
>> -                bio = erofs_is_fscache_mode(sb) ?
>> -                    erofs_fscache_bio_alloc(&mdev) :
>> -                    bio_alloc(mdev.m_bdev, BIO_MAX_VECS,
>> -                          REQ_OP_READ, GFP_NOIO);
>> +                if (erofs_is_fileio_mode(EROFS_SB(sb)))
>> +                    bio = erofs_fileio_bio_alloc(&mdev);
> 
> It seems erofs_fileio_bio_alloc() can fail, it needs to handle NULL bio
> here?

I will mark it as __GFP_NOFAIL too in the previous patch.

Thanks,
Gao Xiang
