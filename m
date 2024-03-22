Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E732886545
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Mar 2024 03:50:10 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=i3BCXAbk;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V16J01gnKz3dTB
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Mar 2024 13:50:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=i3BCXAbk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V16Hr0WLnz3cVv
	for <linux-erofs@lists.ozlabs.org>; Fri, 22 Mar 2024 13:49:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711075793; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tDPIxInMDWamNBWonEbMpR/zByJDjmcKXf2lf9KXAXQ=;
	b=i3BCXAbkjobpM7vmIo+58W+n6nFLwwtsjaynNUbp0vrmJZSiQU662hHYZWwaRyZIcW0/98fC0EFk86rr/TMulPAXXDbIYYjkgYqunV/1mFd8/wdcfn9SKEmEefq1/KtJ/1zfrJD1pIzHDtYy/M2F4Dh0ADNHQl+oVU7Du7TL66M=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W30Nun6_1711075790;
Received: from 30.97.48.208(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W30Nun6_1711075790)
          by smtp.aliyun-inc.com;
          Fri, 22 Mar 2024 10:49:51 +0800
Message-ID: <6e58615b-b06e-4144-9a13-eea61c358a8f@linux.alibaba.com>
Date: Fri, 22 Mar 2024 10:49:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Slow concurrent reads on mounted loopback images
To: GRANGER Nicolas <nicolas.granger@cea.fr>,
 "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
References: <894a823bf73641e1a2f177cefea83dbd@cea.fr>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <894a823bf73641e1a2f177cefea83dbd@cea.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi GRANGER,

On 2024/3/22 01:49, GRANGER Nicolas wrote:
> Hi erofs team,
> 
> 
> I'm working on a small daemon that caches and mounts disk images containing datasets based on usage (https://github.com/CEA-LIST/scratch_manager <https://github.com/CEA-LIST/scratch_manager>).
> 
> My understanding is that this is a good use-case for EROFS. However, in my experience concurrent reads on loopback mounted disk images are rather slow.
> 
> I tested both squashfs and erofs images so I don't think it is specific to erofs, I just can't figure out where the bottleneck is. By any chance would you have any any tips to share on that subject?

Thanks for the information.  I don't know more about "scratch_manager",
but does "scratch_manager" really use loopback devices? if yes, which
kernel version are you using, and could you try with loop direct-io
mode?

Later the EROFS project will land native solutions for dataset and AI
models and we will evaluate this use cases formally.

Thanks,
Gao Xiang

> 
> 
> Best,
> 
> Nicolas Granger
> 
