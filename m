Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5196F16F5C5
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Feb 2020 03:47:03 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48S0ZD4BrXzDqH1
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Feb 2020 13:47:00 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 48S0Xn65cnzDqQm
 for <linux-erofs@lists.ozlabs.org>; Wed, 26 Feb 2020 13:45:45 +1100 (AEDT)
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.54])
 by Forcepoint Email with ESMTP id 04FDB154E2232F5125A5;
 Wed, 26 Feb 2020 10:45:39 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 26 Feb 2020 10:45:35 +0800
Received: from architecture4 (10.160.196.180) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Wed, 26 Feb 2020 10:45:34 +0800
Date: Wed, 26 Feb 2020 10:44:08 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 3/3] erofs: handle corrupted images whose decompressed
 size less than it'd be
Message-ID: <20200226024408.GB106025@architecture4>
References: <20200226023011.103798-1-gaoxiang25@huawei.com>
 <20200226023011.103798-3-gaoxiang25@huawei.com>
 <20200226023458.GB1053@sol.localdomain>
 <20200226024047.GA106025@architecture4>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200226024047.GA106025@architecture4>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.160.196.180]
X-ClientProxiedBy: dggeme704-chm.china.huawei.com (10.1.199.100) To
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
 LKML <linux-kernel@vger.kernel.org>, Lasse Collin <lasse.collin@tukaani.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Feb 26, 2020 at 10:40:47AM +0800, Gao Xiang wrote:
> Hi Eric,
> 
> On Tue, Feb 25, 2020 at 06:34:58PM -0800, Eric Biggers wrote:
> > On Wed, Feb 26, 2020 at 10:30:11AM +0800, Gao Xiang wrote:
> > > As Lasse pointed out, "Looking at fs/erofs/decompress.c,
> > > the return value from LZ4_decompress_safe_partial is only
> > > checked for negative value to catch errors. ... So if
> > > I understood it correctly, if there is bad data whose
> > > uncompressed size is much less than it should be, it can
> > > leave part of the output buffer untouched and expose the
> > > previous data as the file content. "
> > > 
> > > Let's fix it now.
> > > 
> > > Cc: Lasse Collin <lasse.collin@tukaani.org>
> > > Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> > 
> > Shouldn't fixes like this have a Fixes tag and Cc stable?
> > 
> > - Eric
> 
> Thanks for pointing out. *thumb up*
> 
> I reminded Fixes and Cc tags when I sent out. Yet
> I'm not quite sure if these have some other potential
> concernes which could cause unexpected behavior for
> normal images (It seems impossible but not quite sure.)
> 
> I'd like to leave these two commits for corrupted images
> to mainline and our products for a while and manually
> backport to stable kernels and send them to stable
> mailing list later. I keep these fixes in mind all
> the time.

... Maybe I should add "Fixes:" tag in the commit message
anyway. Will resend them later.

Thanks,
Gao Xiang

> 
> Thanks,
> Gao Xiang
> 
