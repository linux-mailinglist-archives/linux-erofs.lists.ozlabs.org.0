Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E923A00C7
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Aug 2019 13:36:48 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46JNxT46xZzDr75
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Aug 2019 21:36:45 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=oracle.com
 (client-ip=141.146.126.78; helo=aserp2120.oracle.com;
 envelope-from=dan.carpenter@oracle.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=oracle.com header.i=@oracle.com header.b="BiEgDCCa"; 
 dkim-atps=neutral
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46JNxJ0D48zDr5s
 for <linux-erofs@lists.ozlabs.org>; Wed, 28 Aug 2019 21:36:34 +1000 (AEST)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7SBY2HT140489;
 Wed, 28 Aug 2019 11:36:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=9AoA1gM/fvBjW5lIuuBC63F6nJrrPs8+3bofSJiXP7k=;
 b=BiEgDCCayt3hMF6RsIGecSItpzv+vYlB3NltedbSa+B+GC0lZGF2w5vnnP0mPCwXe4Aw
 eCEGoZAD6A3CCnyxJqoXQmxGkCBf2ECrqfWV3md6jOiNKUSZ2ZXmFLpMSmNkochxwDJc
 B9QaxZIEU8nPYpjQ1Q+6+gaO7sZ3MiWcV3q9rDcbVnTiEC3VKMOfkNNbNM62wo7z4hNv
 nfaZxf+touuKVn86qjUTkLTZuAx91lZeNZ6C4BJTVOZb7r/AczalZlgQNtab/4N7aDdO
 bTeL9G/3D0pSuXmkQ5yOylHraPlgsj4Mz91QeZLODMaINnFDyqpoJ/qIUaAwGioMenmU Hw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 2unrr4r220-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Aug 2019 11:36:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7SBXxUD150964;
 Wed, 28 Aug 2019 11:36:21 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 2undupuqpd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Aug 2019 11:36:21 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7SBaJj1031772;
 Wed, 28 Aug 2019 11:36:20 GMT
Received: from kadam (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 28 Aug 2019 04:36:19 -0700
Date: Wed, 28 Aug 2019 14:36:13 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [bug report] staging: erofs: introduce erofs_grab_bio
Message-ID: <20190828113612.GB8372@kadam>
References: <20190828105541.GA21320@mwanda>
 <20190828110249.GA56298@architecture4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828110249.GA56298@architecture4>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9362
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908280125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9362
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908280125
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

On Wed, Aug 28, 2019 at 07:02:49PM +0800, Gao Xiang wrote:
> Hi Dan,
> 
> On Wed, Aug 28, 2019 at 01:55:41PM +0300, Dan Carpenter wrote:
> > Hello Gao Xiang,
> > 
> > The patch 8be31270362b: "staging: erofs: introduce erofs_grab_bio"
> > from Aug 21, 2018, leads to the following static checker warning:
> > 
> > 	fs/erofs/zdata.c:1272 z_erofs_vle_submit_all()
> > 	error: 'bio' dereferencing possible ERR_PTR()
> > 
> > fs/erofs/zdata.c
> >   1259                  if (bio && force_submit) {
> >   1260  submit_bio_retry:
> >   1261                          __submit_bio(bio, REQ_OP_READ, 0);
> >   1262                          bio = NULL;
> >   1263                  }
> >   1264  
> >   1265                  if (!bio) {
> >   1266                          bio = erofs_grab_bio(sb, first_index + i,
> >   1267                                               BIO_MAX_PAGES, bi_private,
> >   1268                                               z_erofs_vle_read_endio, true);
> > 
> > This assumes erofs_grab_bio() can't fail.  It returns ERR_PTR(-ENOMEM)
> > on failure.
> 
> I think there is no problem at all as well.
> The last argument of erofs_grab_bio is nofail, and here is "true".
> 
> 415 static inline struct bio *erofs_grab_bio(struct super_block *sb,
> 416                                          erofs_blk_t blkaddr,
> 417                                          unsigned int nr_pages,
> 418                                          void *bi_private, bio_end_io_t endio,
> 419                                          bool nofail)
> 420 {
> 421         const gfp_t gfp = GFP_NOIO;
> 422         struct bio *bio;
> 423
> 424         do {
> 425                 if (nr_pages == 1) {
> 426                         bio = bio_alloc(gfp | (nofail ? __GFP_NOFAIL : 0), 1);
> 427                         if (unlikely(!bio)) {
> 428                                 DBG_BUGON(nofail);
> 429                                 return ERR_PTR(-ENOMEM);
> 430                         }
> 431                         break;
> 432                 }
> 433                 bio = bio_alloc(gfp, nr_pages);
> 434                 nr_pages /= 2;
> 435         } while (unlikely(!bio));
> 436
> 437         bio->bi_end_io = endio;
> 438         bio_set_dev(bio, sb->s_bdev);
> 439         bio->bi_iter.bi_sector = (sector_t)blkaddr << LOG_SECTORS_PER_BLOCK;
> 440         bio->bi_private = bi_private;
> 441         return bio;
> 442 }
> 
> You can see __GFP_NOFAIL is set, Am I missing something?
> 

Ah.  Yes.  You're right.

regards,
dan 


