Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 401AD4D5A6B
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Mar 2022 06:24:59 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KFDs513hhz2yWH
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Mar 2022 16:24:57 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.54;
 helo=out30-54.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KFDs05xc4z2xXV
 for <linux-erofs@lists.ozlabs.org>; Fri, 11 Mar 2022 16:24:50 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=2; SR=0; TI=SMTPD_---0V6sIeHI_1646976281; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V6sIeHI_1646976281) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 11 Mar 2022 13:24:43 +0800
Date: Fri, 11 Mar 2022 13:24:41 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: David Anderson <dvander@google.com>
Subject: Re: [PATCH] erofs-utils: mkfs: Use extended inodes when ctime is set
Message-ID: <YirdGdAgbi9Y5NtS@B-P7TQMD6M-0146.local>
References: <20220301041037.2271718-1-dvander@google.com>
 <Yh2sc2TOmyBdV3b7@B-P7TQMD6M-0146.local>
 <CA+FmFJB0iDzcPLqAtZsqQFj+j-pvhqs9YXmhjkmCYyqPgHpxnA@mail.gmail.com>
 <Yh25yvTzxt0aK62a@B-P7TQMD6M-0146.local>
 <CA+FmFJB39G3vDSJQW+pbC+EQVe3u51uKoASF28asHAkp0WPXSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+FmFJB39G3vDSJQW+pbC+EQVe3u51uKoASF28asHAkp0WPXSw@mail.gmail.com>
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
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi David,

On Thu, Mar 10, 2022 at 07:53:07PM -0800, David Anderson via Linux-erofs wrote:
> On Mon, Feb 28, 2022 at 10:14 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> >
> >
> > (Or maybe just "--preserve-mtime" if it's supposed to be used frequently in
> >  specific use cases...)
> 
> Looking at this again - is a new flag needed?
> 
> If -T is specified, the build will be reproducible. All timestamps
> will be equal, and we'll never force an extended inode due to
> mismatching timestamps. The patch has no effect in this case.
> 
> If -T is *not* specified, inode mtime *could* be reproducible
> (depending on how the user creates the files), but sbi.build_time
> isn't. Any of these inodes that gets the compact layout will use the
> unreproducible build time instead. So, switching to extended inodes
> here strictly improves reproducibility and determinism.

Yeah, I know what's your main point here. Ok, that's fine we
could change the current behavior. Yet I still think the current
behavior may benefit some use cases (e.g. metadata size is sensible,
we need to avoid extended inodes no matter per-filetimestamp is)..

So instead, how about introducing --ignore-mtime instead for the
current behavior, and change the default behavior into using extended
inodes?

> 
> That said, it is a change in behavior, so maybe that warrants a flag anyway.
> 
> For what it's worth, in AOSP, "-T" is specified for production builds.
> Non-production builds have "mtime" preserved for pushing incremental
> changes.

Thanks for the information!

Thanks,
Gao Xiang

> 
> Best,
> 
> -David
