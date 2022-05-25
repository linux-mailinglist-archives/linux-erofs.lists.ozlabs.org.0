Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F07375339F3
	for <lists+linux-erofs@lfdr.de>; Wed, 25 May 2022 11:33:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L7QqM4dKxz3bdY
	for <lists+linux-erofs@lfdr.de>; Wed, 25 May 2022 19:33:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131;
 helo=out30-131.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4L7QqG0XPwz2xTj
 for <linux-erofs@lists.ozlabs.org>; Wed, 25 May 2022 19:33:24 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R331e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=alimailimapcm10staff010182156082;
 MF=hsiangkao@linux.alibaba.com; NM=1; PH=DS; RN=5; SR=0;
 TI=SMTPD_---0VEMuPXj_1653471193; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0VEMuPXj_1653471193) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 25 May 2022 17:33:15 +0800
Date: Wed, 25 May 2022 17:33:13 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH] erofs: leave compressed inodes unsupported in fscache
 mode for now
Message-ID: <Yo332UXnrZ+HVQZ7@B-P7TQMD6M-0146.local>
References: <20220525075950.21535-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220525075950.21535-1-jefflexu@linux.alibaba.com>
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Jeffle,

On Wed, May 25, 2022 at 03:59:50PM +0800, Jeffle Xu wrote:
> erofs over fscache doesn't support the compressed layout yet. It will
> cause NULL crash if there are compressed inodes contained when working
> in fscache mode.
> 
> So far in the erofs based container image distribution scenarios
> (RAFS v6), the compressed images are downloaded to local and then

... the compressed RAFS v6 images are downloaded and then decompressed
on demand as an uncompressed erofs image.

> decompressed as a erofs image of uncompressed layout. Then the erofs
> image is mounted in fscache mode and serves as the container image. Thus

... in fscache mode for containers to use. IOWs

> the current implementation won't break the container image distribution
> scenarios.

IOWs, currently compressed data is decompressed on the userspace side
instead and uncompressed erofs images will be finally cached.

> 
> The fscache support for the compressed layout is still under
> development. Anyway, to avoid the potential crash, let's leave the

The fscache support for the compressed layout is still under
development and it will be used for runtime decompression feature.
Anyway..

> compressed inodes unsupported in fscache mode until we support it later.
> 
> Fixes: 1442b02b66ad ("erofs: implement fscache-based data read for non-inline layout")

Otherwise looks good to me,

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
