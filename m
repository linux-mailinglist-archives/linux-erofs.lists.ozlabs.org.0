Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 632A97E135D
	for <lists+linux-erofs@lfdr.de>; Sun,  5 Nov 2023 13:51:43 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SNZ9l5S2Rz3bWy
	for <lists+linux-erofs@lfdr.de>; Sun,  5 Nov 2023 23:51:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SNZ9h22bdz2xdq
	for <linux-erofs@lists.ozlabs.org>; Sun,  5 Nov 2023 23:51:35 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VveYEoj_1699188689;
Received: from 192.168.3.4(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VveYEoj_1699188689)
          by smtp.aliyun-inc.com;
          Sun, 05 Nov 2023 20:51:30 +0800
Message-ID: <43fc745e-581d-e0a5-7198-c070ae99a85b@linux.alibaba.com>
Date: Sun, 5 Nov 2023 20:51:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 0/3] erofs-utils: Address doc and flag-parsing snags
To: "Luke T. Shumaker" <lukeshu@lukeshu.com>, linux-erofs@lists.ozlabs.org
References: <20231102193122.140921-1-lukeshu@lukeshu.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20231102193122.140921-1-lukeshu@lukeshu.com>
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
Cc: "Luke T. Shumaker" <lukeshu@umorpha.io>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/11/3 03:31, Luke T. Shumaker wrote:
> From: "Luke T. Shumaker" <lukeshu@umorpha.io>
> 
> Hi all,
> 
> This patchset addresses snags that I hit while adopting erofs for our
> system images.
> 
>   - The first patch is really just setting a baseline for the next two.
> 
>   - The second patch is improving the --help text to address the snag
>     that I had to read the source code to understand how to use the
>     mkfs.erofs `-z` flag, and also setting the stage for the third
>     patch.  In doing this I broadly improved the --help text overall,
>     not just for mkfs.erofs.
> 
>   - The third patch is adding no-op `-a`, `-A`, and `-y` flags to
>     fsck.erofs, to address the snag that I was seeing errors in the
>     boot scroll.
> 
> I didn't touch erofsfuse in any of these, not because it isn't worthy
> of the changes from the first two patches, just that I decided it
> would have been too much work at the moment.

Thanks, applied for testing.

Thanks,
Gao Xiang

> 
> Luke T. Shumaker (3):
>    erofs-utils: have each non-fuse command take -h, --help, -V, and
>      --version
>    erofs-utils: improve the usage and version text of non-fuse commands
>    erofs-utils: fsck: Add -a, -A, and -y flags
> 
>   dump/main.c              |  47 +++++++------
>   fsck/main.c              |  81 ++++++++++++++--------
>   include/erofs/compress.h |   2 +-
>   lib/compressor.c         |  13 +---
>   lib/compressor.h         |   9 ++-
>   man/dump.erofs.1         |   5 +-
>   man/fsck.erofs.1         |   8 ++-
>   man/mkfs.erofs.1         |  15 ++--
>   mkfs/main.c              | 144 +++++++++++++++++++++++++--------------
>   9 files changed, 202 insertions(+), 122 deletions(-)
> 
