Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2735A8BDF
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Sep 2022 05:21:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MJ5td1gTXz2xJF
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Sep 2022 13:21:45 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MJ5tZ1s54z2yZc
	for <linux-erofs@lists.ozlabs.org>; Thu,  1 Sep 2022 13:21:41 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VNuYo-Q_1662002491;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VNuYo-Q_1662002491)
          by smtp.aliyun-inc.com;
          Thu, 01 Sep 2022 11:21:33 +0800
Date: Thu, 1 Sep 2022 11:21:31 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Jia Zhu <zhujia.zj@bytedance.com>
Subject: Re: [RFC PATCH 0/5] Introduce erofs shared domain
Message-ID: <YxAlO/DHDrIAafR2@B-P7TQMD6M-0146.local>
Mail-Followup-To: Jia Zhu <zhujia.zj@bytedance.com>,
	linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	yinxin.x@bytedance.com, jefflexu@linux.alibaba.com,
	huyue2@coolpad.com
References: <20220831123125.68693-1-zhujia.zj@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220831123125.68693-1-zhujia.zj@bytedance.com>
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
Cc: linux-kernel@vger.kernel.org, huyue2@coolpad.com, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, yinxin.x@bytedance.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Jia,

On Wed, Aug 31, 2022 at 08:31:20PM +0800, Jia Zhu wrote:
> [Kernel Patchset]
> ===============
> Git tree:
> 	https://github.com/userzj/linux.git zhujia/shared-domain-v1
> Git web:
> 	https://github.com/userzj/linux/tree/zhujia/shared-domain-v1
> 
> [Background]
> ============
> In ondemand read mode, we use individual volume to present an erofs
> mountpoint, cookies to present bootstrap and data blobs.
> 
> In which case, since cookies can't be shared between fscache volumes,
> even if the data blobs between different mountpoints are exactly same,
> they can't be shared.
> 
> [Introduction]
> ==============
> Here we introduce erofs shared domain to resolve above mentioned case.
> Several erofs filesystems can belong to one domain, and data blobs can
> be shared among these erofs filesystems of same domain.

As we discussed in the previous community meeting, I agree that is useful
and it's the prerequisite of storage/page cache sharing between blocks
among different images (filesystems).

Thanks for your time and effort on this!

> 
> [Usage]
> Users could specify 'domain_id' mount option to create or join into a
> domain which reuses the same cookies(blobs).
> 
> [Design]
> ========
> 1. Use pseudo mnt to manage domain's lifecycle.
> 2. Use a linked list to maintain & traverse domains.
> 3. Use pseudo sb to create anonymous inode for recording cookie's info
>    and manage cookies lifecycle.
> 
> [Flow Path]
> ===========
> 1. User specify a new 'domain_id' in mount option.
>    1.1 Traverse domain list, compare domain_id with existing domain.[Miss]
>    1.2 Create a new domain(volume), add it to domain list.
>    1.3 Traverse pseudo sb's inode list, compare cookie name with
>        existing cookies.[Miss]
>    1.4 Alloc new anonymous inodes and cookies.
> 
> 2. User specify an existing 'domain_id' in mount option and the data
>    blob is existed in domain.
>    2.1 Traverse domain list, compare domain_id with existing domain.[Hit]
>    2.2 Reuse the domain and increase its refcnt.
>    2.3 Traverse pseudo sb's inode list, compare cookie name with
>    	   existing cookies.[Hit]
>    2.4 Reuse the cookie and increase its refcnt.
> 
> [Test]
> ======
> Git web: (More test cases will be added.)
> 	https://github.com/userzj/demand-read-cachefilesd/tree/shared-domain

I'd suggest integrating to erofs-utils testcases directly, see
https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/log/?h=experimental-tests-fscache 

Thanks,
Gao Xiang
