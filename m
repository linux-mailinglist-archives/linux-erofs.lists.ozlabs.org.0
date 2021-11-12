Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A7744E54A
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Nov 2021 11:58:30 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HrFtr59Gdz2ynr
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Nov 2021 21:58:28 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=47.88.44.36;
 helo=out4436.biz.mail.alibaba.com; envelope-from=hsiangkao@linux.alibaba.com;
 receiver=<UNKNOWN>)
Received: from out4436.biz.mail.alibaba.com (out4436.biz.mail.alibaba.com
 [47.88.44.36])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HrFth53jVz2xX8
 for <linux-erofs@lists.ozlabs.org>; Fri, 12 Nov 2021 21:58:18 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=9; SR=0; TI=SMTPD_---0UwBxaTg_1636714678; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UwBxaTg_1636714678) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 12 Nov 2021 18:58:00 +0800
Date: Fri, 12 Nov 2021 18:57:58 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Huang Jianan <huangjianan@oppo.com>
Subject: Re: [PATCH v5 1/2] erofs: add sysfs interface
Message-ID: <YY5ItpTScHI+f2p+@B-P7TQMD6M-0146.local>
References: <20211112023003.10712-1-huangjianan@oppo.com>
 <YY39YZcn/a6F0PMh@B-P7TQMD6M-0146.local>
 <67b86422-3133-ff7b-ddb7-c25939bee549@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67b86422-3133-ff7b-ddb7-c25939bee549@oppo.com>
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
Cc: zhangshiming@oppo.com, linux-kernel@vger.kernel.org, yh@oppo.com,
 guanyuwei@oppo.com, guoweichao@oppo.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Nov 12, 2021 at 06:10:37PM +0800, Huang Jianan wrote:
> 在 2021/11/12 13:36, Gao Xiang 写道:
> > Hi Jianan,
> > 
> > On Fri, Nov 12, 2021 at 10:30:02AM +0800, Huang Jianan wrote:
> > > Add sysfs interface to configure erofs related parameters later.
> > > 
> > > Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> > > Reviewed-by: Chao Yu <chao@kernel.org>
> > > ---
> > > since v4:
> > > - Resend in a clean chain.
> > > 
> > > since v3:
> > > - Add description of sysfs in erofs documentation.
> > > 
> > > since v2:
> > > - Check whether t in erofs_attr_store is illegal.
> > > - Print raw value for bool entry.
> > > 
> > > since v1:
> > > - Add sysfs API documentation.
> > > - Use sysfs_emit over snprintf.
> > > 
> > >   Documentation/ABI/testing/sysfs-fs-erofs |   7 +
> > >   Documentation/filesystems/erofs.rst      |   8 +
> > >   fs/erofs/Makefile                        |   2 +-
> > >   fs/erofs/internal.h                      |  10 +
> > >   fs/erofs/super.c                         |  12 ++
> > >   fs/erofs/sysfs.c                         | 240 +++++++++++++++++++++++
> > >   6 files changed, 278 insertions(+), 1 deletion(-)
> > >   create mode 100644 Documentation/ABI/testing/sysfs-fs-erofs
> > >   create mode 100644 fs/erofs/sysfs.c
> > > 
> > > diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ABI/testing/sysfs-fs-erofs
> > > new file mode 100644
> > > index 000000000000..86d0d0234473
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-fs-erofs
> > > @@ -0,0 +1,7 @@
> > > +What:		/sys/fs/erofs/features/
> > > +Date:		November 2021
> > > +Contact:	"Huang Jianan" <huangjianan@oppo.com>
> > > +Description:	Shows all enabled kernel features.
> > > +		Supported features:
> > > +		lz4_0padding, compr_cfgs, big_pcluster, device_table,
> > > +		sb_chksum.
> > Please help submit a patch renaming lz4_0padding to 0padding globally
> > since LZMA and later algorithms also need that...
> > 
> > Also, lack of chunked_file and compr_head2 as well?
> 
> It seems that these features are also missing in internal.h, I will send a
> new
> patchset containing these fixes.

Yeah, these were not used before, but as you're introducing the sysfs
directories, they need to be filled up.

Thanks,
Gao Xiang

> 
> Thanks,
> Jianan
> 
> > Thanks,
> > Gao Xiang
