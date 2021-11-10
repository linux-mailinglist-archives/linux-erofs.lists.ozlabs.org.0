Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3460B44B9F7
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Nov 2021 02:36:16 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HpnW21KWvz2xsV
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Nov 2021 12:36:14 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HpnVt6Z5Tz2xsV
 for <linux-erofs@lists.ozlabs.org>; Wed, 10 Nov 2021 12:36:01 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=10; SR=0; TI=SMTPD_---0Uvq8JEE_1636508142; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0Uvq8JEE_1636508142) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 10 Nov 2021 09:35:44 +0800
Date: Wed, 10 Nov 2021 09:35:42 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Daeho Jeong <daeho43@gmail.com>
Subject: Re: [PATCH v3] erofs-utils: introduce fsck.erofs
Message-ID: <YYsh7h5IXeQd6xim@B-P7TQMD6M-0146.local>
References: <20211029171312.2189648-1-daeho43@gmail.com>
 <YYpaySr6vGEfwduR@B-P7TQMD6M-0146.local>
 <CACOAw_zJgxwQnQTgcU4DfsxN5gFCgAONU4B3A1dR79ccJSLBfA@mail.gmail.com>
 <CACOAw_wt+DX0D+Ps-K=oF+MgUxtVKbXpamShoZR7n4WwM+wODw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACOAw_wt+DX0D+Ps-K=oF+MgUxtVKbXpamShoZR7n4WwM+wODw@mail.gmail.com>
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
Cc: Daeho Jeong <daehojeong@google.com>, linux-erofs@lists.ozlabs.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, miaoxie@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Daeho,

On Tue, Nov 09, 2021 at 04:16:12PM -0800, Daeho Jeong wrote:
> Hi Gao,
> 
> After merging all the latest patches, the build fails now, since we
> don't have the lzma library on the build system now.
> 
> external/erofs-utils/lib/compressor_liblzma.c:8:10: fatal error:
> 'lzma.h' file not found
> #include <lzma.h>
>          ^~~~~~~~
> 1 error generated.
> 16:13:47 ninja failed with: exit status 1
> 
> Can you fix this to make it built without the lzma library?

I think it's mainly due to Android.bp configuration, because in
lib/Makefile.am it wrote as:

...
if ENABLE_LIBLZMA
liberofs_la_CFLAGS += ${liblzma_CFLAGS}
liberofs_la_SOURCES += compressor_liblzma.c
endif

I could add some macro in compressor_liblzma.c as well if needed.

btw, I suggest updating the patches when 1.4 is out (next week),
since I still do some cleanup work.

Thanks,
Gao Xiang

