Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8A83FBA0C
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Aug 2021 18:23:52 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GywcQ1Hjkz2yJn
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Aug 2021 02:23:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.44;
 helo=out30-44.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GywcH5nmrz2xfN
 for <linux-erofs@lists.ozlabs.org>; Tue, 31 Aug 2021 02:23:39 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R581e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=7; SR=0; TI=SMTPD_---0UmfUSxR_1630340599; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UmfUSxR_1630340599) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 31 Aug 2021 00:23:20 +0800
Date: Tue, 31 Aug 2021 00:23:18 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 1/3] fs/erofs: add erofs filesystem support
Message-ID: <YS0F9mFDrUFXGbH3@B-P7TQMD6M-0146.local>
References: <20210822154843.10971-1-jnhuang95@gmail.com>
 <20210823123646.9765-1-jnhuang95@gmail.com>
 <20210823123646.9765-2-jnhuang95@gmail.com>
 <20210825223947.GD858@bill-the-cat>
 <177141f0-ebbd-017e-ab63-9445b3f53ac1@gmail.com>
 <35ce7ab3-a21c-0401-c677-eb2140ea908d@gmail.com>
 <20210830160646.GY858@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210830160646.GY858@bill-the-cat>
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
Cc: u-boot@lists.denx.de, xiang@kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Aug 30, 2021 at 12:06:46PM -0400, Tom Rini wrote:
> On Mon, Aug 30, 2021 at 11:31:28PM +0800, Huang Jianan wrote:
> > 在 2021/8/30 21:27, Huang Jianan 写道:
> > > 
> > > 
> > > 在 2021/8/26 6:39, Tom Rini 写道:
> > > > On Mon, Aug 23, 2021 at 08:36:44PM +0800, Huang Jianan wrote:
> > > > 
> > > > > From: Huang Jianan <huangjianan@oppo.com>
> > > > > 
> > > > > This patch mainly deals with uncompressed files.
> > > > > 
> > > > > Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> > > > > ---
> > > > >   fs/Kconfig          |   1 +
> > > > >   fs/Makefile         |   1 +
> > > > >   fs/erofs/Kconfig    |  12 ++
> > > > >   fs/erofs/Makefile   |   7 +
> > > > >   fs/erofs/data.c     | 124 ++++++++++++++
> > > > >   fs/erofs/erofs_fs.h | 384
> > > > > ++++++++++++++++++++++++++++++++++++++++++++
> > > > >   fs/erofs/fs.c       | 231 ++++++++++++++++++++++++++
> > > > >   fs/erofs/internal.h | 203 +++++++++++++++++++++++
> > > > >   fs/erofs/namei.c    | 238 +++++++++++++++++++++++++++
> > > > >   fs/erofs/super.c    |  65 ++++++++
> > > > >   fs/fs.c             |  22 +++
> > > > >   include/erofs.h     |  19 +++
> > > > >   include/fs.h        |   1 +
> > > > >   13 files changed, 1308 insertions(+)
> > > > >   create mode 100644 fs/erofs/Kconfig
> > > > >   create mode 100644 fs/erofs/Makefile
> > > > >   create mode 100644 fs/erofs/data.c
> > > > >   create mode 100644 fs/erofs/erofs_fs.h
> > > > >   create mode 100644 fs/erofs/fs.c
> > > > >   create mode 100644 fs/erofs/internal.h
> > > > >   create mode 100644 fs/erofs/namei.c
> > > > >   create mode 100644 fs/erofs/super.c
> > > > >   create mode 100644 include/erofs.h
> > > > Do the style problems checkpatch.pl complains about here match what's in
> > > > the linux kernel?  I expect at lease some of them come from using custom
> > > > debug/etc macros rather than the standard logging functions. Thanks.
> > > 
> > > The code is mainly come from erofs-utils, thems it has the same problem,
> > > i
> > > will fix it ASAP.
> > > 
> > > Thanks,
> > > Jianan
> > > 
> > I have checked checkpatch.pl complains, some need to be fixed, and some
> > come frome using custom macros. It seems that there are still some warnings
> > that are inconsistent with the linux kernel, such as :
> > 
> > WARNING: Use 'if (IS_ENABLED(CONFIG...))' instead of '#if or #ifdef' where
> > possible
> > #835: FILE: fs/erofs/fs.c:224:
> > +#ifdef CONFIG_LIB_UUID
> > 
> > WARNING: Possible switch case/default not preceded by break or fallthrough
> > comment
> > #763: FILE: fs/erofs/zmap.c:489:
> > +       case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
> > 
> > erofs-utils is written according to the linux kernel coding style, I expect
> > this
> > part can be consistent in order to reduce maintenance burden and keep
> > with the latest feature.
> 
> Yes, please fix what can be easily fixed and still kept in sync with
> other projects.

Agreed, erofs-utils follows linux kernel style. Maybe we could fix both
together if easily fixed...

Thanks,
Gao Xiang

> 
> -- 
> Tom


