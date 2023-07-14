Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D736753227
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Jul 2023 08:42:58 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R2MNt3TBTz3c2c
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Jul 2023 16:42:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R2MNl5Fw2z3bst
	for <linux-erofs@lists.ozlabs.org>; Fri, 14 Jul 2023 16:42:45 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VnKay68_1689316958;
Received: from 30.97.49.6(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VnKay68_1689316958)
          by smtp.aliyun-inc.com;
          Fri, 14 Jul 2023 14:42:39 +0800
Message-ID: <61dd1c83-ede6-06bf-21fc-2a71a4dc0d9e@linux.alibaba.com>
Date: Fri, 14 Jul 2023 14:42:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/2] erofs-utils: introduce tarerofs
To: Jingbo Xu <jefflexu@linux.alibaba.com>, chao@kernel.org,
 huyue2@coolpad.com, linux-erofs@lists.ozlabs.org, xiang@kernel.org
References: <20230713120015.93308-1-jefflexu@linux.alibaba.com>
 <20230713120015.93308-3-jefflexu@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230713120015.93308-3-jefflexu@linux.alibaba.com>
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



On 2023/7/13 20:00, Jingbo Xu wrote:
> From: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Let's try to add a new mode "tarerofs" for mkfs.erofs.
> 
> It mainly aims at two use cases:
>   - Convert a tarball (or later tarballs with a merged view) into
>     a full EROFS image [--tar=f];
> 
>   - Generate an EROFS manifest image to reuse tar data [--tar=i],
>     which also enables EROFS 512-byte blocks.
> 
> The second use case is mainly prepared for OCI direct mount without
> OCI blob unpacking.  This also adds another `--aufs` option to
> transform aufs special files into overlayfs metadata.
> 
> [ Note that `--tar=f` generates lots of temporary files for now which
>    can impact performance since the original tar stream(s) may be
>    non-seekable. ]
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

I got issues when applying this to any branch (-dev or -experimental),
also [PATCH 1/2] has been applied before, don't resend anymore.

Thanks,
Gao Xiang
