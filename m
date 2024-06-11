Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FB59037BD
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Jun 2024 11:23:29 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bCMw+i0C;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Vz3BM1g3Lz3cNV
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Jun 2024 19:23:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bCMw+i0C;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Vz3BD4Ch4z30Wl
	for <linux-erofs@lists.ozlabs.org>; Tue, 11 Jun 2024 19:23:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718097789; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=AQR8Dmz2OhTysYzKd/4jbDwXZBuDxlV7rpSrGSosnlw=;
	b=bCMw+i0C0uEGrHy4AmbONci2P+5YEOVKULoWNEl3G0C0cOmkujRYvLE207lcV7dJInC7RRc5TPSrMa28nWdWN0ig2k21/f337HruWYy1qt+Yd2oMptZ43g87HUE7Fdnlvvp0kuzrlmjldY8RrnJ5xx6ydY/DSlScBe/HC6F09lQ=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W8FuAUB_1718097786;
Received: from 30.221.131.143(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W8FuAUB_1718097786)
          by smtp.aliyun-inc.com;
          Tue, 11 Jun 2024 17:23:07 +0800
Message-ID: <f190347b-17c5-4b3d-b3e8-d145157adb25@linux.alibaba.com>
Date: Tue, 11 Jun 2024 17:23:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] build: support building static library liberofsfuse
To: ComixHe <heyuming@deepin.org>
References: <64B0656069715534+20240606041826.46688-1-heyuming@deepin.org>
 <3399126AB01D5AB6+2bad5767fc035a7a2234408b0fffa53b3a07aa51.1717659178.git.heyuming@deepin.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <3399126AB01D5AB6+2bad5767fc035a7a2234408b0fffa53b3a07aa51.1717659178.git.heyuming@deepin.org>
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

On 2024/6/6 15:39, ComixHe wrote:
> add new option '--enable-static-fuse' so that we
> could import erofsfuse as a static library directly
> into other projects
> 
> Signed-off-by: ComixHe <heyuming@deepin.org>

...

> +
> +if ENABLE_STATIC_FUSE
> +lib_LIBRARIES = liberofsfuse.a
> +liberofsfuse_a_SOURCES = main.c
> +liberofsfuse_a_CFLAGS  = -Wall -I$(top_srcdir)/include
> +liberofsfuse_a_CFLAGS += -Dmain=erofsfuse_main ${libfuse2_CFLAGS} ${libfuse3_CFLAGS} ${libselinux_CFLAGS}
> +liberofsfuse_la_LIBADD  = $(top_builddir)/lib/liberofs.la ${libfuse2_LIBS} ${libfuse3_LIBS} ${liblz4_LIBS} \
> +	${libselinux_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} ${libzstd_LIBS}

I guess this line should be the following:

-liberofsfuse_la_LIBADD  = $(top_builddir)/lib/liberofs.la ${libfuse2_LIBS} ${libfuse3_LIBS} ${liblz4_LIBS} \
-       ${libselinux_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} ${libzstd_LIBS} ${libqpl_LIBS}
+liberofsfuse_a_LIBADD  = $(top_builddir)/lib/liberofs.la

Since we may not have all dependent libraries, so it's up to users to use liberofsfuse.a and
link static (or dynamic) dependencies themselves.

I will update this patch manually.

Thanks,
Gao Xiang

> +endif
