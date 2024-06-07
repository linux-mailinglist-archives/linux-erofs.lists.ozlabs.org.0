Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D428FFC8A
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Jun 2024 09:02:09 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=sFvWfN0k;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VwXF73GRPz3bs2
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Jun 2024 17:02:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=sFvWfN0k;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VwXDz2q6gz30VN
	for <linux-erofs@lists.ozlabs.org>; Fri,  7 Jun 2024 17:01:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717743708; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=I6OwWdYtiHfk3twYVfGLd3tqu4hsbyOA7TFCa0UDVkI=;
	b=sFvWfN0kXDWqGohTPlSspB7Kg8PJztcJout41Y4DhLgy+ZOCTYEjFuXpAb7F1pA03Wn/gB5XGubC4MwR/wfaVUWtHdvswxYI2qHDETwYazk2/PKyF9Qs+XsaP1ZRIAR5EX2CcZRwbLhpnk8C0AAeDAkypcc1yO+VoDAbbKmqmCk=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R351e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W8-FLfg_1717743706;
Received: from 30.97.48.175(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W8-FLfg_1717743706)
          by smtp.aliyun-inc.com;
          Fri, 07 Jun 2024 15:01:47 +0800
Message-ID: <c534d8b0-906e-4f98-9b23-cfc55b4a10e3@linux.alibaba.com>
Date: Fri, 7 Jun 2024 15:01:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] build: export liberofs
To: ComixHe <heyuming@deepin.org>
References: <1FBEA94A7D00D713+20240607064940.139007-1-heyuming@deepin.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <1FBEA94A7D00D713+20240607064940.139007-1-heyuming@deepin.org>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi,

On 2024/6/7 14:49, ComixHe wrote:
> export liberofs.a for linking to liberofsfuse in the project
> and provide pc files for developer's convenience.
> 
> Signed-off-by: ComixHe <heyuming@deepin.org>

Currently liberofs interface is still unstable. We tend
to address this in erofs-utils v1.9 cycle.  If you folks really
need that, I'd suggest leave this out-of-tree temporarily.

> ---

...

> --- a/lib/Makefile.am
> +++ b/lib/Makefile.am
> @@ -1,6 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
>   
> -noinst_LTLIBRARIES = liberofs.la
> +lib_LIBRARIES = liberofs.a

liberofs should work for both dynamic library and static library
in the future (v1.9), so liberofs.la is preferred.

Thanks,
Gao Xiang
