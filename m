Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A92966EF8
	for <lists+linux-erofs@lfdr.de>; Sat, 31 Aug 2024 04:54:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wwfjz6rGqz30Ts
	for <lists+linux-erofs@lfdr.de>; Sat, 31 Aug 2024 12:54:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725072853;
	cv=none; b=iUcPk57yHqv4Do7Z+E1kATLSOOyU0xamaXT+eCzSdd89+6vDoM38boVpyk7INrl+FQ0RArFrGQCI3eD+vY+a4vons1BEp2T+xFAaE5a/LvTqwpQivnN267iuT68N/AduQ5QWCpK0x/IeRHOUF8y7S+ie7eqrZpb9EvNgz5rq/ef5Adj0le0hp259+e2pwVSPGXQL/4duxWab8fayQ/FcmVxs+QEPNXsKsNu3CMMbARIzLzUKvirHoeCYq4N8QEEst4nndlqaqp5jPobKTq/kl69+T2ovybhCWslm7yPCMrWa+VgG35whAosCqtCqPd6WWP6AY7H7Z8qVypK7zrzMaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725072853; c=relaxed/relaxed;
	bh=zZJJrwNuQqZJmQm0d3gc2XhF2BtCX1ZJsTSpftN+ZuM=;
	h=DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=eqj6h2AxGnWaMPt6Ffnho7kfq85Pq4A93REV+hFj7GA4SIdqCzvB3798HizQRMAiPZrVg2V1nDkx4lk4PriA6Zu9dJe+s6ELbJR5xqNVjX2Q1FSHufwIcUVH6SrbUqHhHO4xHS1FQ66voW0bCWup7MBueFZOh7kIK3oNVnph5B8N9Qcl5bAohW+XVE5RCc3LxhKHnsCXbVbv0tXNslQmyAApK1HF+1NFJo96w+bj68+jRmh6k/FAnXRDUAgmhZ7k6aWfyBjW27xCHVLXus4ANpXokM+n+oPtfmk961FdSVSQhgoWOQ9U8khKtYppdL/yEVbyi9e+Mvp8Sxyrs4miTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tuCViTGo; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tuCViTGo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wwfjv5pyKz2xr4
	for <linux-erofs@lists.ozlabs.org>; Sat, 31 Aug 2024 12:54:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725072844; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=zZJJrwNuQqZJmQm0d3gc2XhF2BtCX1ZJsTSpftN+ZuM=;
	b=tuCViTGowY8L2WRteNhpHjNUv0hs2elohT7uiFJAPZblSMa3o/LC5zfqrJX4NrfC35N/FFBPSylFfUu6eJlr+oIh9oGH5gycR7F213ZKhP8YciJWjnz9fdYy8pnXhZ0cFNPD4ztamOPKQMR0HNj9yLKOsJmX8Bqnah9xk9abTRA=
Received: from 192.168.2.29(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WDyK-lV_1725072842)
          by smtp.aliyun-inc.com;
          Sat, 31 Aug 2024 10:54:03 +0800
Message-ID: <474573b0-14d3-4534-82ad-8b4942567008@linux.alibaba.com>
Date: Sat, 31 Aug 2024 10:54:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] erofs: support unencoded inodes for fileio
To: Sandeep Dhavale <dhavale@google.com>
References: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com>
 <20240830032840.3783206-2-hsiangkao@linux.alibaba.com>
 <CAB=BE-Q1X2ossOkSUJcW_m-GBnzQngTMnCxUWUBD=qei-J7_=g@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAB=BE-Q1X2ossOkSUJcW_m-GBnzQngTMnCxUWUBD=qei-J7_=g@mail.gmail.com>
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/8/31 08:19, Sandeep Dhavale wrote:
> On Thu, Aug 29, 2024 at 8:29 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>> Since EROFS only needs to handle read requests in simple contexts,
>> Just directly use vfs_iocb_iter_read() for data I/Os.
>>
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
>> v2:
>>   - fix redundant refcount which cause hanging on chunked inodes.
>>
>>   fs/erofs/Makefile   |   1 +
>>   fs/erofs/data.c     |  50 +++++++++++-
>>   fs/erofs/fileio.c   | 181 ++++++++++++++++++++++++++++++++++++++++++++
>>   fs/erofs/inode.c    |  17 +++--
>>   fs/erofs/internal.h |   7 +-
>>   fs/erofs/zdata.c    |  46 ++---------
>>   6 files changed, 251 insertions(+), 51 deletions(-)
>>   create mode 100644 fs/erofs/fileio.c
>>
>> diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
>> index 097d672e6b14..4331d53c7109 100644
>> --- a/fs/erofs/Makefile
>> +++ b/fs/erofs/Makefile
>> @@ -7,4 +7,5 @@ erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o zutil.o
>>   erofs-$(CONFIG_EROFS_FS_ZIP_LZMA) += decompressor_lzma.o
>>   erofs-$(CONFIG_EROFS_FS_ZIP_DEFLATE) += decompressor_deflate.o
>>   erofs-$(CONFIG_EROFS_FS_ZIP_ZSTD) += decompressor_zstd.o
>> +erofs-$(CONFIG_EROFS_FS_BACKED_BY_FILE) += fileio.o
>>   erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
>> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
>> index 0fb31c588ae0..b4c07ce7a294 100644
>> --- a/fs/erofs/data.c
>> +++ b/fs/erofs/data.c
>> @@ -132,7 +132,7 @@ int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map)
>>          if (map->m_la >= inode->i_size) {
>>                  /* leave out-of-bound access unmapped */
>>                  map->m_flags = 0;
>> -               map->m_plen = 0;
>> +               map->m_plen = map->m_llen;
>>                  goto out;
>>          }
>>
>> @@ -197,8 +197,13 @@ static void erofs_fill_from_devinfo(struct erofs_map_dev *map,
>>                                      struct erofs_device_info *dif)
>>   {
>>          map->m_bdev = NULL;
>> -       if (dif->file && S_ISBLK(file_inode(dif->file)->i_mode))
>> -               map->m_bdev = file_bdev(dif->file);
>> +       map->m_fp = NULL;
>> +       if (dif->file) {
>> +               if (S_ISBLK(file_inode(dif->file)->i_mode))
>> +                       map->m_bdev = file_bdev(dif->file);
>> +               else
>> +                       map->m_fp = dif->file;
>> +       }
>>          map->m_daxdev = dif->dax_dev;
>>          map->m_dax_part_off = dif->dax_part_off;
>>          map->m_fscache = dif->fscache;
>> @@ -215,6 +220,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
>>          map->m_daxdev = EROFS_SB(sb)->dax_dev;
>>          map->m_dax_part_off = EROFS_SB(sb)->dax_part_off;
>>          map->m_fscache = EROFS_SB(sb)->s_fscache;
>> +       map->m_fp = EROFS_SB(sb)->fdev;
>>
>>          if (map->m_deviceid) {
>>                  down_read(&devs->rwsem);
>> @@ -250,6 +256,42 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
>>          return 0;
>>   }
>>
>> +/*
>> + * bit 30: I/O error occurred on this folio
>> + * bit 0 - 29: remaining parts to complete this folio
>> + */
>> +#define EROFS_ONLINEFOLIO_EIO                  (1 << 30)
>> +
>> +void erofs_onlinefolio_init(struct folio *folio)
>> +{
>> +       union {
>> +               atomic_t o;
>> +               void *v;
>> +       } u = { .o = ATOMIC_INIT(1) };
>> +
>> +       folio->private = u.v;   /* valid only if file-backed folio is locked */
>> +}
>> +
>> +void erofs_onlinefolio_split(struct folio *folio)
>> +{
>> +       atomic_inc((atomic_t *)&folio->private);
>> +}
>> +
>> +void erofs_onlinefolio_end(struct folio *folio, int err)
>> +{
>> +       int orig, v;
>> +
>> +       do {
>> +               orig = atomic_read((atomic_t *)&folio->private);
>> +               v = (orig - 1) | (err ? EROFS_ONLINEFOLIO_EIO : 0);
>> +       } while (atomic_cmpxchg((atomic_t *)&folio->private, orig, v) != orig);
>> +
>> +       if (v & ~EROFS_ONLINEFOLIO_EIO)
>> +               return;
>> +       folio->private = 0;
>> +       folio_end_read(folio, !(v & EROFS_ONLINEFOLIO_EIO));
>> +}
>> +
>>   static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>>                  unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
>>   {
>> @@ -399,7 +441,7 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>>   }
>>
>>   /* for uncompressed (aligned) files and raw access for other files */
>> -const struct address_space_operations erofs_raw_access_aops = {
>> +const struct address_space_operations erofs_aops = {
>>          .read_folio = erofs_read_folio,
>>          .readahead = erofs_readahead,
>>          .bmap = erofs_bmap,
>> diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
>> new file mode 100644
>> index 000000000000..eab52b8abd0b
>> --- /dev/null
>> +++ b/fs/erofs/fileio.c
>> @@ -0,0 +1,181 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2024, Alibaba Cloud
>> + */
>> +#include "internal.h"
>> +#include <trace/events/erofs.h>
>> +
>> +struct erofs_fileio_rq {
>> +       struct bio_vec bvecs[BIO_MAX_VECS];
>> +       struct bio bio;
>> +       struct kiocb iocb;
>> +};
>> +
>> +struct erofs_fileio {
>> +       struct erofs_map_blocks map;
>> +       struct erofs_map_dev dev;
>> +       struct erofs_fileio_rq *rq;
>> +};
>> +
>> +static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
>> +{
>> +       struct erofs_fileio_rq *rq =
>> +                       container_of(iocb, struct erofs_fileio_rq, iocb);
>> +       struct folio_iter fi;
>> +
>> +       DBG_BUGON(rq->bio.bi_end_io);
>> +       if (ret > 0) {
>> +               if (ret != rq->bio.bi_iter.bi_size) {
>> +                       bio_advance(&rq->bio, ret);
>> +                       zero_fill_bio(&rq->bio);
>> +               }
>> +               ret = 0;
>> +       }
>> +       bio_for_each_folio_all(fi, &rq->bio) {
>> +               DBG_BUGON(folio_test_uptodate(fi.folio));
>> +               erofs_onlinefolio_end(fi.folio, ret);
>> +       }
>> +       kfree(rq);
>> +}
>> +
>> +static void erofs_fileio_rq_submit(struct erofs_fileio_rq *rq)
>> +{
>> +       struct iov_iter iter;
>> +       int ret;
>> +
>> +       if (!rq)
>> +               return;
>> +       rq->iocb.ki_pos = rq->bio.bi_iter.bi_sector << 9;
>> +       rq->iocb.ki_ioprio = get_current_ioprio();
>> +       rq->iocb.ki_complete = erofs_fileio_ki_complete;
>> +       rq->iocb.ki_flags = (rq->iocb.ki_filp->f_mode & FMODE_CAN_ODIRECT) ?
>> +                               IOCB_DIRECT : 0;
> Hi Gao,
> Does this mean, direct IO by default if the backing file supports it
> (technically filesystem where image/backing file reside)?

Yes.

Thanks,
Gao Xiang
