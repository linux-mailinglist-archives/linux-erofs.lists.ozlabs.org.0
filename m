Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45380163E8D
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Feb 2020 09:08:45 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48Mr2d2wNmzDqdp
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Feb 2020 19:08:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.189; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga03-in.huawei.com [45.249.212.189])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48Mr063ZzCzDqjQ
 for <linux-erofs@lists.ozlabs.org>; Wed, 19 Feb 2020 19:06:27 +1100 (AEDT)
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.53])
 by Forcepoint Email with ESMTP id 9B368CBC75E280C9FAF4;
 Wed, 19 Feb 2020 16:06:16 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 19 Feb 2020 16:06:15 +0800
Received: from architecture4 (10.160.196.180) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Wed, 19 Feb 2020 16:06:15 +0800
Date: Wed, 19 Feb 2020 16:04:57 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] erofs: convert workstn to XArray
Message-ID: <20200219080456.GA126843@architecture4>
References: <20200217033042.137855-1-gaoxiang25@huawei.com>
 <58f1ff26-e1f8-96a4-fa7b-ee86f972b0aa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <58f1ff26-e1f8-96a4-fa7b-ee86f972b0aa@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.160.196.180]
X-ClientProxiedBy: dggeme708-chm.china.huawei.com (10.1.199.104) To
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
Cc: Miao Xie <miaoxie@huawei.com>, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Chao,

On Wed, Feb 19, 2020 at 03:46:16PM +0800, Chao Yu wrote:
> On 2020/2/17 11:30, Gao Xiang wrote:

[]

> > -	return err;
> > +	sbi = EROFS_SB(sb);
> > +repeat:
> > +	xa_lock(&sbi->managed_pslots);
> > +	pre = __xa_cmpxchg(&sbi->managed_pslots, grp->index,
> > +			   NULL, grp, GFP_NOFS);
> > +	if (pre) {
> 
> It looks __xa_cmpxchg() could return negative value in case of failure, e.g.
> no memory case. We'd better handle that case and old valid workgroup separately?

Thanks, that is a quite good catch!

To be honest, I'm not quite sure whether __xa_cmpxchg
could fail due to no memory here (as a quick scan, it
will do __xas_nomem loop interally.)

But anyway, it needs bailing out all potential errors
by using xa_is_err(). Will do some research and send
v3 then.

Thanks,
Gao Xiang

