Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id CA28EA0073
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Aug 2019 13:05:44 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46JNFf1hS7zDr4t
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Aug 2019 21:05:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.188; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46JNCL72GjzDr55
 for <linux-erofs@lists.ozlabs.org>; Wed, 28 Aug 2019 21:03:42 +1000 (AEST)
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id 64B6B34AEBB75AD41776;
 Wed, 28 Aug 2019 19:03:36 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 28 Aug 2019 19:03:35 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 28 Aug 2019 19:03:35 +0800
Date: Wed, 28 Aug 2019 19:02:49 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [bug report] staging: erofs: introduce erofs_grab_bio
Message-ID: <20190828110249.GA56298@architecture4>
References: <20190828105541.GA21320@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190828105541.GA21320@mwanda>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme710-chm.china.huawei.com (10.1.199.106) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
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
Cc: miaoxie@huawei.com, xiang@kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Dan,

On Wed, Aug 28, 2019 at 01:55:41PM +0300, Dan Carpenter wrote:
> Hello Gao Xiang,
> 
> The patch 8be31270362b: "staging: erofs: introduce erofs_grab_bio"
> from Aug 21, 2018, leads to the following static checker warning:
> 
> 	fs/erofs/zdata.c:1272 z_erofs_vle_submit_all()
> 	error: 'bio' dereferencing possible ERR_PTR()
> 
> fs/erofs/zdata.c
>   1259                  if (bio && force_submit) {
>   1260  submit_bio_retry:
>   1261                          __submit_bio(bio, REQ_OP_READ, 0);
>   1262                          bio = NULL;
>   1263                  }
>   1264  
>   1265                  if (!bio) {
>   1266                          bio = erofs_grab_bio(sb, first_index + i,
>   1267                                               BIO_MAX_PAGES, bi_private,
>   1268                                               z_erofs_vle_read_endio, true);
> 
> This assumes erofs_grab_bio() can't fail.  It returns ERR_PTR(-ENOMEM)
> on failure.

I think there is no problem at all as well.
The last argument of erofs_grab_bio is nofail, and here is "true".

415 static inline struct bio *erofs_grab_bio(struct super_block *sb,
416                                          erofs_blk_t blkaddr,
417                                          unsigned int nr_pages,
418                                          void *bi_private, bio_end_io_t endio,
419                                          bool nofail)
420 {
421         const gfp_t gfp = GFP_NOIO;
422         struct bio *bio;
423
424         do {
425                 if (nr_pages == 1) {
426                         bio = bio_alloc(gfp | (nofail ? __GFP_NOFAIL : 0), 1);
427                         if (unlikely(!bio)) {
428                                 DBG_BUGON(nofail);
429                                 return ERR_PTR(-ENOMEM);
430                         }
431                         break;
432                 }
433                 bio = bio_alloc(gfp, nr_pages);
434                 nr_pages /= 2;
435         } while (unlikely(!bio));
436
437         bio->bi_end_io = endio;
438         bio_set_dev(bio, sb->s_bdev);
439         bio->bi_iter.bi_sector = (sector_t)blkaddr << LOG_SECTORS_PER_BLOCK;
440         bio->bi_private = bi_private;
441         return bio;
442 }

You can see __GFP_NOFAIL is set, Am I missing something?

Thanks,
Gao Xiang

> 
>   1269                          ++nr_bios;
>   1270                  }
>   1271  
>   1272                  err = bio_add_page(bio, page, PAGE_SIZE, 0);
>   1273                  if (err < PAGE_SIZE)
>   1274                          goto submit_bio_retry;
>   1275  
>   1276                  force_submit = false;
>   1277                  last_index = first_index + i;
>   1278  skippage:
>   1279                  if (++i < clusterpages)
>   1280                          goto repeat;
> 
> regards,
> dan carpenter
