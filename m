Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E630A018B
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Aug 2019 14:23:29 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46JPzL1jQQzDr0r
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Aug 2019 22:23:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.189; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga03-in.huawei.com [45.249.212.189])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46JPzG4Y2HzDqcx
 for <linux-erofs@lists.ozlabs.org>; Wed, 28 Aug 2019 22:23:21 +1000 (AEST)
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id A168E240C2175A5A0808;
 Wed, 28 Aug 2019 20:23:18 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 28 Aug 2019 20:23:17 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 28 Aug 2019 20:23:17 +0800
Date: Wed, 28 Aug 2019 20:22:29 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [bug report] staging: erofs: introduce erofs_grab_bio
Message-ID: <20190828122229.GA102412@architecture4>
References: <20190828105541.GA21320@mwanda>
 <20190828110249.GA56298@architecture4>
 <20190828113929.GA68628@architecture4>
 <20190828121143.GC8372@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190828121143.GC8372@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme711-chm.china.huawei.com (10.1.199.107) To
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
Cc: linux-erofs@lists.ozlabs.org, xiang@kernel.org, miaoxie@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Dan,

On Wed, Aug 28, 2019 at 03:11:44PM +0300, Dan Carpenter wrote:
> On Wed, Aug 28, 2019 at 07:39:29PM +0800, Gao Xiang wrote:
> > (p.s. It makes me little confused these subject prefixes are "[bug report]", if they are
> > really bugs, that is fine... If it be something unconfirmed (need our confirmation..,),
> > could you kindly change the prefix into some other representations...? I will still look
> > into all of them at least... and that makes me feel a bit better and easy.... thanks...)
> 
> Of course I thought it *was* a bug...
> 
> I've sent probably 1800 of these emails.  It's a script but I look over
> the email before sending.  Maybe when people start using the Link: tag
> I will be able to make these show up as reply to an email.

Thanks for your effort to communities [thumb]

> 
> Normally, I sent them out in a much more timely sort of way but all the
> erofs warnings show up as new with the move out of staging so I have
> been re-reviewing the warnings.
> 
> So last August when this code was new, I must have seen the warning but
> read the code correctly.  I checked before I sent this email to make
> sure we hadn't discusssed it before.
> 
> But this time I got confused by the DBG_BUGON().  I decided to treat it
> as a no-op because it can be configured to do nothing if you have
> CONFIG_EROFS_FS_DEBUG disabled.  Plus it has "DBG" in the name so it
> felt like debug code.  But I ended up focussing on it instead of seeing
> the "(nofail ? __GFP_NOFAIL : 0)" bit.  The DBG_BUGON() is unreachable
> and misleading nonsense fluff.  :(

I fully understand that :) That is fine.
In a word, thanks for reporting :)

Thanks,
Gao Xiang

> 
> regards,
> dan carpenter
> 
