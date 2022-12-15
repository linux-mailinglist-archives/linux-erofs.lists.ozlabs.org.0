Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E5ECC64D5D1
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Dec 2022 05:13:01 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NXf3G2bvtz3bym
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Dec 2022 15:12:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.42; helo=out30-42.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NXf365gjLz3bNB
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Dec 2022 15:12:49 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VXLGogC_1671077561;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VXLGogC_1671077561)
          by smtp.aliyun-inc.com;
          Thu, 15 Dec 2022 12:12:43 +0800
Date: Thu, 15 Dec 2022 12:12:41 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Khem Raj <raj.khem@gmail.com>
Subject: Re: [PATCH 2/3] erofs_fs.h: Make LFS mandatory for all usecases
Message-ID: <Y5qeuUqlvwVcbbEL@B-P7TQMD6M-0146.local>
References: <20221208085335.2884608-1-raj.khem@gmail.com>
 <20221208085335.2884608-2-raj.khem@gmail.com>
 <Y5HySDMzY8CSLQeJ@debian>
 <CAMKF1srO6o=RAt_HUTTJ5fQXHErUHJ=oZ2yjw5pE7B4tV6s7Gg@mail.gmail.com>
 <Y5SfrbgaHgFxk/Dg@debian>
 <CAMKF1spkK0e6CehNkx7003v=rsSWRcms8MARqedjsno-4dk-2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMKF1spkK0e6CehNkx7003v=rsSWRcms8MARqedjsno-4dk-2Q@mail.gmail.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Khem,

On Sat, Dec 10, 2022 at 11:49:25AM -0800, Khem Raj wrote:

...

> > >
> > > as said above if we are ok to pass it always then we can add -D
> > > _FILE_OFFSET_BITS=64 via toplevel Makefile.am
> > > it will only be needed on 32bit systems though, so maybe we do not
> > > define it and demand it from users via CFLAGS
> > > if they compile it for 32bit systems.
> > >
> >
> > I think use -D _FILE_OFFSET_BITS=64 would be a better choice...
> >
> 
> OK I will rework it in v3.

Do you still have some interest to work on this?
(I'm about to release erofs-utils 1.6 in a month.. It would be helpful
 to clean up such stuff in this version.)

Thanks,
Gao Xiang

> 
> > Thanks,
> > Gao Xiang
