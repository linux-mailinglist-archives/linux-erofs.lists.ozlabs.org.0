Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B3479F83E
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Sep 2023 04:36:58 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RmM0R6Znwz3c5P
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Sep 2023 12:36:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RmM0N5JSTz2xdm
	for <linux-erofs@lists.ozlabs.org>; Thu, 14 Sep 2023 12:36:50 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Vs0W4GX_1694659003;
Received: from 30.97.48.222(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vs0W4GX_1694659003)
          by smtp.aliyun-inc.com;
          Thu, 14 Sep 2023 10:36:44 +0800
Message-ID: <7d5e0f81-4ccb-08f7-1e6f-e2d650a37f56@linux.alibaba.com>
Date: Thu, 14 Sep 2023 10:36:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v1 0/7] Misc fixes in erofs-utils
To: Sandeep Dhavale <dhavale@google.com>, linux-erofs@lists.ozlabs.org
References: <20230913221104.429825-1-dhavale@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230913221104.429825-1-dhavale@google.com>
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
Cc: kernel-team@android.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/9/14 06:10, Sandeep Dhavale wrote:
> Hi,
> Below series contains few small misc fixes found after running through clang
> static checker.

All these patches look good to me, will apply.

Thanks,
Gao Xiang

> 
> Sandeep Dhavale (7):
>    erofs-utils: fsck: Fix potential memory leak in error path
>    erofs-utils: lib: Remove redundant line to get padding
>    erofs-utils: lib: Fix memory leak if __erofs_battach() fails
>    erofs-utils: lib: Check for error from z_erofs_pack_file_from_fd()
>    erofs-utils: lib: Fix the memory leak in error path
>    erofs-utils: lib: Remove redundant assignment
>    erofs-utils: lib: tar: Initialize the variable to avoid using garbage
>      value
> 
>   fsck/main.c      | 4 +++-
>   lib/blobchunk.c  | 1 -
>   lib/cache.c      | 4 +++-
>   lib/compress.c   | 2 ++
>   lib/decompress.c | 4 +++-
>   lib/namei.c      | 1 -
>   lib/tar.c        | 2 +-
>   7 files changed, 12 insertions(+), 6 deletions(-)
> 
