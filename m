Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2794B459D0B
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Nov 2021 08:50:16 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HyxBZ01rLz2yb3
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Nov 2021 18:50:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=C4kRWvZt;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=C4kRWvZt; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HyxBV030Hz2xRp
 for <linux-erofs@lists.ozlabs.org>; Tue, 23 Nov 2021 18:50:09 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 700C561002;
 Tue, 23 Nov 2021 07:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637653807;
 bh=yAowu60d38PEjPOK9PQeXvjFaIAXy17ieSbnErySBQ8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=C4kRWvZtpTMHGRRSlpPtPa0de+ngvx2GxEYjOjoJh2DFPO0XIekaNyrTe1JEZ9isZ
 CTrEjkuAZiKDr7UJK+zbUty4x4b9mlG4YEphiXx3iek6pDLW0I2KmEsRxANdlJQ9mo
 xA1SFGx2q0NBkpbgm5/Y8bSbbRt4mKIVl7gSz1xXlewvBRSe/qeu8kKT9bYZJCsO6q
 jo5kZ5z8vzWT6K/yE7LGTVEoarvoyHyi62KJfbBi1b2+fWPkK5VPbdonRPeC9EAZXL
 xePYscNmgWMEKu8hiwnVmUiuyNdaHHgf2MKyOa/GuTCXEWv7Whs1Xwp1caFvN1BNjv
 1isjsweTg5Oow==
Date: Tue, 23 Nov 2021 15:49:55 +0800
From: Gao Xiang <xiang@kernel.org>
To: Kelvin Zhang <zhangkelvin@google.com>
Subject: Re: [PATCH v1 1/4] Make erofs_devfd a parameter for most functions
Message-ID: <20211123074954.GA6460@hsiangkao-HP-ZHAN-66-Pro-G1>
Mail-Followup-To: Kelvin Zhang <zhangkelvin@google.com>,
 linux-erofs mailing list <linux-erofs@lists.ozlabs.org>,
 Li Guifu <bluce.liguifu@huawei.com>, Miao Xie <miaoxie@huawei.com>,
 Fang Wei <fangwei1@huawei.com>, Gao Xiang <xiang@kernel.org>,
 Chao Yu <yuchao0@huawei.com>
References: <20211121053920.2580751-1-zhangkelvin@google.com>
 <20211121053920.2580751-2-zhangkelvin@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211121053920.2580751-2-zhangkelvin@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>,
 Chao Yu <yuchao0@huawei.com>, Li Guifu <bluce.liguifu@huawei.com>,
 Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Kelvin,

On Sat, Nov 20, 2021 at 09:39:18PM -0800, Kelvin Zhang wrote:
> Test: extract system.img from
> aosp_cf_x86_64_phone-target_files-7731383.zip , mount it, mkfs.erofs to
> generate an EROFS image. Make sure the content is the same before/after
> this patch. (Except super block, which has an UUID)
> 
> target_files.zip can be downloaded from
> https://ci.android.com/builds/branches/aosp-master/grid?head=7934850&tail=7934850
> 
> Signed-off-by: Kelvin Zhang <zhangkelvin@google.com>

Thanks for your effort!

Just a quick glance, I'm not sure if we have to expose erofs_device to
most of the functions... Also it breaks some common functions argument
lists which was porting from the kernel side.

How about integrating struct erofs_device to struct erofs_sb_info? and
make inode->sb_info->dev chain workable?

Also it would be better to leave a descriptive commit message ;) it
would be helpful!

Thanks,
Gao Xiang

> ---
>  dump/main.c               | 61 +++++++++++++++--------------
>  fsck/main.c               | 65 ++++++++++++++++---------------
>  fuse/dir.c                |  7 +++-
>  fuse/main.c               | 18 +++++----
>  include/erofs/blobchunk.h |  7 +++-
>  include/erofs/cache.h     |  7 ++--
>  include/erofs/compress.h  |  8 +++-
>  include/erofs/config.h    | 15 ++++----
>  include/erofs/defs.h      | 21 ++++++++++
>  include/erofs/inode.h     |  6 ++-
>  include/erofs/internal.h  | 52 +++++++++----------------
>  include/erofs/io.h        | 48 ++++++++++++++---------
>  lib/blobchunk.c           | 11 ++++--
>  lib/cache.c               | 27 ++++++++-----
>  lib/compress.c            | 54 ++++++++++++++------------
>  lib/compressor_liblzma.c  |  2 +-
>  lib/config.c              | 63 ++++++++++++++++++------------
>  lib/data.c                | 30 +++++++++------
>  lib/decompress.c          |  2 +-
>  lib/inode.c               | 81 +++++++++++++++++++++++----------------
>  lib/io.c                  | 74 +++++++++++++++++++----------------
>  lib/namei.c               | 22 +++++------
>  lib/super.c               | 28 +++++++-------
>  lib/xattr.c               |  6 ++-
>  lib/zmap.c                | 74 +++++++++++++++++++++--------------
>  mkfs/main.c               | 39 ++++++++++---------
>  26 files changed, 476 insertions(+), 352 deletions(-)
>
 
