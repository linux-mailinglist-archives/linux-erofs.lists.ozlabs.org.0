Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C210A3C89
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Aug 2019 18:49:31 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46KlnN2C4rzDqkk
	for <lists+linux-erofs@lfdr.de>; Sat, 31 Aug 2019 02:49:28 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.187; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46KlnG3f3LzDqcl
 for <linux-erofs@lists.ozlabs.org>; Sat, 31 Aug 2019 02:49:21 +1000 (AEST)
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.53])
 by Forcepoint Email with ESMTP id 6662DE36B8648C21C1E2;
 Sat, 31 Aug 2019 00:49:16 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 31 Aug 2019 00:49:15 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Sat, 31 Aug 2019 00:49:15 +0800
Date: Sat, 31 Aug 2019 00:48:27 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3 7/7] erofs: redundant assignment in
 __erofs_get_meta_page()
Message-ID: <20190830164827.GA107220@architecture4>
References: <20190830032006.GA20217@architecture4>
 <20190830033643.51019-1-gaoxiang25@huawei.com>
 <20190830033643.51019-7-gaoxiang25@huawei.com>
 <20190830162812.GA10694@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190830162812.GA10694@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme705-chm.china.huawei.com (10.1.199.101) To
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
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Miao Xie <miaoxie@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
 weidu.du@huawei.com, Joe Perches <joe@perches.com>,
 linux-erofs@lists.ozlabs.org, Dan Carpenter <dan.carpenter@oracle.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Christoph,

On Fri, Aug 30, 2019 at 09:28:12AM -0700, Christoph Hellwig wrote:
> > -		err = bio_add_page(bio, page, PAGE_SIZE, 0);
> > -		if (err != PAGE_SIZE) {
> > +		if (bio_add_page(bio, page, PAGE_SIZE, 0) != PAGE_SIZE) {
> >  			err = -EFAULT;
> >  			goto err_out;
> >  		}
> 
> This patch looks like an improvement.  But looking at that whole
> area just makes me cringe.

OK, I agree with you, I will improve it or just kill them all with
new iomap approach after it supports tail-end packing inline.

> 
> Why is there __erofs_get_meta_page with the two weird booleans instead
> of a single erofs_get_meta_page that gets and gfp_t for additional
> flags and an unsigned int for additional bio op flags.

I agree with you. Thanks for your suggestion.

> 
> Why do need ioprio support to start with?  Seeing that in a new
> fs look kinda odd.  Do you have benchmarks that show the difference?

I don't have some benchmark for all of these, can I just set
REQ_PRIO for all metadata? is that reasonable?
Could you kindly give some suggestion on this?

> 
> That function then calls erofs_grab_bio, which tries to handle a
> bio_alloc failure, except that the function will not actually fail
> due the mempool backing it.  It also seems like and awfully
> huge function to inline.

OK, I will simplify it. Thanks for your suggestion.

> 
> Why is there __submit_bio which really just obsfucates what is
> going on?  Also why is __submit_bio using bio_set_op_attrs instead
> of opencode it as the comment right next to it asks you to?

Originally, mainly due to backport consideration since some
of our smartphones use 3.x kernel as well...

> 
> Also I really don't understand why you can't just use read_cache_page
> or even read_cache_page_gfp instead of __erofs_get_meta_page.
> That function is a whole lot of duplication of functionality shared
> by a lot of other file systems.

OK, I have to admit, that code was originally just copied from f2fs
with some modification (maybe it's not a good example for us).

Thanks,
Gao Xiang

