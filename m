Return-Path: <linux-erofs+bounces-334-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1BAAB9E24
	for <lists+linux-erofs@lfdr.de>; Fri, 16 May 2025 16:05:07 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZzTNv1RFmz2yLT;
	Sat, 17 May 2025 00:05:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747404303;
	cv=none; b=YYsYmWj1taJMEfb0hGkk03PVzLR/ayrnpJjtbkx+/Y2lUz76BnNl4VXT0Rr/yggZdlitoCJzktEymivpOaYUWLi4dEr0oB821ynaFCZwBVitjDPGcAHrd+J7JeLWuW8E3/Q6C71rN8xj+8ZAEyD1SkrJBlIjAw2tik/nhjJaeXdhPfs///9B0ayMFQ/oXO/a3suEZWEa0TIIutVfo87i5UzvqBPuqmBPGsnJi9MG/Z1iaeFrFz2+isGZTQlnHfzbG3DC2uBngTzWRq/q/vPcpZMBnLy4DY75Z0AyRMUfduBeFp0s5ChsFkSFRd22mHdcA39I7Kfye5jfTo86HMHTGw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747404303; c=relaxed/relaxed;
	bh=/ZSrtVJHRWxqli6VwCLHlssALJbjN7Fk1roT6+hMXiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U9corTnHLYCZ3JDuXvOnHMSyPaV9Mts6WTcgnDjAB6OTjUnBwzBM88JpaRbIBVdeZAgv9zI0wbYrLQEAYHFC0T5/9orbd+O8/AAxwhxdcBTVqWx8r/zCtLoxvGML+WP2xMy8HagsdlR/6JDvuXqnQ6M+eogs18O6Ks99ImJaOebEN3WrjsAD/e2H6M5v39fLULdJII8TkCK30VvBT0L2D2uDVlmiY5Q/Z+dbI0EFuvzicd+uVZDYYNN5hh/RZsiMO06JQQz9j3YwYXj/zwCsMkEEB4DbrzyuPXmTHmVUmEAPJQj/mEda7QtKgCwunK0QHP/lHBDu4NBaULDHCUrmAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bS0Sgnqo; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bS0Sgnqo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZzTNr4HSqz2y8l
	for <linux-erofs@lists.ozlabs.org>; Sat, 17 May 2025 00:04:58 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1747404294; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=/ZSrtVJHRWxqli6VwCLHlssALJbjN7Fk1roT6+hMXiM=;
	b=bS0SgnqoXqolXEYoYpUL4qdq8e6UZKHfhtjgwqnBurh7JtjzoHWR1bwpMPcrkg27hxLr494W/754D5qj801hgAR/cHSkDareY5GsdzCirt9K2FltP/aWX7EGFMJDTA+SGwylaGzxohZuBG8g6y2ElytLIKhVat0ALuK082XQnYs=
Received: from 30.134.100.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WawIU3z_1747404291 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 16 May 2025 22:04:52 +0800
Message-ID: <6b456e0d-04cf-4ecd-a23a-e91c7d58b592@linux.alibaba.com>
Date: Fri, 16 May 2025 22:04:51 +0800
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
Subject: Re: [PATCH v6] erofs: add 'fsoffset' mount option for file-backed &
 bdev-based mounts
To: Sheng Yong <shengyong2021@gmail.com>, xiang@kernel.org, chao@kernel.org,
 zbestahu@gmail.com, jefflexu@linux.alibaba.com, dhavale@google.com,
 lihongbo22@huawei.com
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Sheng Yong <shengyong1@xiaomi.com>, Wang Shuai <wangshuai12@xiaomi.com>
References: <20250516090055.3343777-1-shengyong1@xiaomi.com>
 <b91b9f2c-3a07-4726-95d9-75d36bb59871@linux.alibaba.com>
 <4f26b365-bca1-4ca7-99b7-f4b80cff26be@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <4f26b365-bca1-4ca7-99b7-f4b80cff26be@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/5/16 21:50, Sheng Yong wrote:
> Hi Xiang,
> 
> On 5/16/25 17:15, Gao Xiang wrote:
>> Hi Yong,
>>
>> On 2025/5/16 17:00, Sheng Yong wrote:
>>
>> ...
>>
>>> diff --git a/Documentation/filesystems/erofs.rst b/Documentation/ filesystems/erofs.rst
>>> index c293f8e37468..b24cb0d5d4d6 100644
>>> --- a/Documentation/filesystems/erofs.rst
>>> +++ b/Documentation/filesystems/erofs.rst
>>> @@ -128,6 +128,7 @@ device=%s              Specify a path to an extra device to be used together.
>>>   fsid=%s                Specify a filesystem image ID for Fscache back-end.
>>>   domain_id=%s           Specify a domain ID in fscache mode so that different images
>>>                          with the same blobs under a given domain ID can share storage.
>>> +fsoffset=%lu           Specify image offset for file-backed or bdev- based mounts.
>>
>> Maybe document it as:
>> fsoffset=%lu              Specify filesystem offset for the primary device.
> 
> OK, this makes sense. But if we need to handle offset for extra devices,
> we might need to use an array or a string to temporarily store the values.
> This is because devices are not initialized during parsing parameters.
> And set `off' for each extra device during scan devices.
> For now, I prefer to add fsoffset for the primary device only. I think
> the primary device which has an offset is the more generic case.

Yes, I prefer to handle the primary device only too, but leave
some further extension with the new expression above.

Also I suggest using a new subject as:
"erofs: add 'fsoffset' mount option to specify filesystem offset"

> 
>>
>> Since I'm not sure if we need later
>> fsoffset=%lu,[%lu,...]    Specify filesystem offset for all devices.
>>
>>>   =================== =========================================================
>>>   Sysfs Entries
>>> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
>>> index 2409d2ab0c28..599a44d5d782 100644
>>> --- a/fs/erofs/data.c
>>> +++ b/fs/erofs/data.c
>>> @@ -27,9 +27,12 @@ void erofs_put_metabuf(struct erofs_buf *buf)
>>>   void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset, bool need_kmap)
>>>   {
>>> -    pgoff_t index = offset >> PAGE_SHIFT;
>>> +    pgoff_t index;
>>
>> How about just
>>      pgoff_t index = (offset + buf->off) >> PAGE_SHIFT;
>>
>> since it's not complex to break it into two statements..
>>
>>>       struct folio *folio = NULL;
>>> +    offset += buf->off;
>>> +    index = offset >> PAGE_SHIFT;
>>> +
>>>       if (buf->page) {
>>>           folio = page_folio(buf->page);
>>>           if (folio_file_page(folio, index) != buf->page)
>>> @@ -54,6 +57,7 @@ void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb)
>>>       struct erofs_sb_info *sbi = EROFS_SB(sb);
>>>       buf->file = NULL;
>>> +    buf->off = sbi->dif0.off;
>>>       if (erofs_is_fileio_mode(sbi)) {
>>>           buf->file = sbi->dif0.file;    /* some fs like FUSE needs it */
>>>           buf->mapping = buf->file->f_mapping;
>>> @@ -299,7 +303,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>>>           iomap->private = buf.base;
>>>       } else {
>>>           iomap->type = IOMAP_MAPPED;
>>> -        iomap->addr = mdev.m_pa;
>>> +        iomap->addr = mdev.m_dif->off + mdev.m_pa;
>>
>> I mean, could we update erofs_init_device() and then
>> `mdev.pa` is already an number added by `mdev.m_dif->off`...
>>
>> Is it possible? since mdev.pa is already a device-based
>> offset.
> 
> I think in most cases we can add `off' to mdev.m_pa directly in
> erofs_map_dev(). But for readdir, erofs_read_metabuf(mdev.m_pa)
> is called after erofs_map_dev() in dir's erofs_iomap_begin().
> However, read metabuf needs `off'.

Ok, I see.  Yes, it's somewhat tricky for EROFS_MAP_META,
so okay, let's leave it as-is.

> 
>>
>>>           if (flags & IOMAP_DAX)
>>>               iomap->addr += mdev.m_dif->dax_part_off;
>>>       }
>>> diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
>>> index 60c7cc4c105c..a2c7001ff789 100644
>>> --- a/fs/erofs/fileio.c
>>> +++ b/fs/erofs/fileio.c
>>> @@ -147,7 +147,8 @@ static int erofs_fileio_scan_folio(struct erofs_fileio *io, struct folio *folio)
>>>                   if (err)
>>>                       break;
>>>                   io->rq = erofs_fileio_rq_alloc(&io->dev);
>>> -                io->rq->bio.bi_iter.bi_sector = io->dev.m_pa >> 9;
>>> +                io->rq->bio.bi_iter.bi_sector =
>>> +                    (io->dev.m_dif->off + io->dev.m_pa) >> 9;
>>
>> So we don't need here.
>>
>>>                   attached = 0;
>>>               }unambiguous
>>>               if (!bio_add_folio(&io->rq->bio, folio, len, cur))
>>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>>> index 4ac188d5d894..cd8c738f5eb8 100644
>>> --- a/fs/erofs/internal.h
>>> +++ b/fs/erofs/internal.h
>>> @@ -43,6 +43,7 @@ struct erofs_device_info {
>>>       char *path;
>>>       struct erofs_fscache *fscache;
>>>       struct file *file;
>>> +    u64 off;
>>>       struct dax_device *dax_dev;
>>>       u64 dax_part_off;
>>
>> Maybe `u64 off, dax_part_off;` here?
>>
>> Also I'm still not quite sure `off` is unambiguous...
>> Maybe `dataoff`? not quite sure.
> 
> What about fsoff accroding to fsoffset?

`fsoff` is fine by me.

Thanks,
Gao Xiang

