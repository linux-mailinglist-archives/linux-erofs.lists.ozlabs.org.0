Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD3243C88B
	for <lists+linux-erofs@lfdr.de>; Wed, 27 Oct 2021 13:27:46 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HfRJ00XCXz2yLm
	for <lists+linux-erofs@lfdr.de>; Wed, 27 Oct 2021 22:27:44 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.45;
 helo=out30-45.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-45.freemail.mail.aliyun.com
 (out30-45.freemail.mail.aliyun.com [115.124.30.45])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HfRHq13S2z2xvL
 for <linux-erofs@lists.ozlabs.org>; Wed, 27 Oct 2021 22:27:31 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=2; SR=0; TI=SMTPD_---0UttWC6L_1635334032; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UttWC6L_1635334032) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 27 Oct 2021 19:27:13 +0800
Date: Wed, 27 Oct 2021 19:27:12 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Todor Ivanov <t.i.ivanov@gmail.com>
Subject: Re: Question about mkfs.erofs and reproducible builds
Message-ID: <YXk3kK1+NLu2h9o1@B-P7TQMD6M-0146.local>
References: <CAOv4OrXs9-4o0JvCdSus=WBjPqUbm+YES_QrsuXkv13dt7SKjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOv4OrXs9-4o0JvCdSus=WBjPqUbm+YES_QrsuXkv13dt7SKjQ@mail.gmail.com>
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

Hi Todor,

On Wed, Oct 27, 2021 at 02:11:24PM +0300, Todor Ivanov wrote:
>         Hello,
> 
>         We are trying to replace squashfs with erofs and face an issue with
> reproducing the build from one and the same source folder. The source
> folder is "/etc" actually taken from an offline ubuntu 20.04 image and
> mounted as read-only.
>         I managed to narrow down the scope and it turns out that the issue
> is when you have a file starting with "." (dot) in this folder. I.e.:
> 
> etc/.anyfilename
> 
> If I remove this file the erofs image of "etc" is reproducible (-T and -U
> are used as well)
> 
> The issue is somehow related to the other 76 subfolders of etc and this
> file starting with dot. For example if I create such .anyfilename in usr or
> var, there is no issue. Also if I create this file under
> etc/xdg/.anyfilename, this is fine as well.
> I also tried with etc from debian10 and the result is the same. Removing
> any file that starts with dot directly under etc, makes the erofs build
> reproducible.
> Do you have any advice on this?

In principle filenames starting with '.' won't impact anything about
reproducible builds...

Let me investigate it now... But may I ask which erofs-utils version
is used? Does it still happen on the latest dev branch?

Thanks,
Gao Xiang

> 
> Regards,
> Todor
