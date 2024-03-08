Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB1187614C
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Mar 2024 10:53:40 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=QG1dOEGP;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TrhM61MT9z3fCg
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Mar 2024 20:53:38 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=QG1dOEGP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TrhM21jlmz3dLl
	for <linux-erofs@lists.ozlabs.org>; Fri,  8 Mar 2024 20:53:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709891607; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=SVLuV58Wf88RJz4QCYei0USy2gOFJ7vIuBSJPd4JPzE=;
	b=QG1dOEGP0AM81HMX5YvQCdCLyiEfSIxFCOGgYXWZnkKltwDbaa3JfLfHHD88tmogsG1XKHfSRPu4cZFaAW42zAgKHPI4zjLbg+B6SR40LPpJ3pzp4slmolU6d80+7oaXGohOy4L/ObBkHpwuFywgB7we0XyFtYML6WQweKujs5s=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W22PPMk_1709891605;
Received: from 30.97.48.168(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W22PPMk_1709891605)
          by smtp.aliyun-inc.com;
          Fri, 08 Mar 2024 17:53:27 +0800
Message-ID: <54e39ceb-834a-4f37-9dc3-7db84fa59927@linux.alibaba.com>
Date: Fri, 8 Mar 2024 17:53:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] erofs: make iov_iter describe target buffers over
 fscache
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
 chao@kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
References: <20240308094159.40547-1-jefflexu@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240308094159.40547-1-jefflexu@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/3/8 17:41, Jingbo Xu wrote:
> So far the fscache mode supports uncompressed data only, and the data
> read from fscache is put directly into the target page cache.  As the
> support for compressed data in fscache mode is going to be introduced,
> rework the fscache internals so that the following compressed part
> could make the raw data read from fscache be directed to the target
> buffer it wants, decompress the raw data, and finally fill the page
> cache with the decompressed data.
> 
> As the first step, a new structure, i.e. erofs_fscache_io (io), is
> introduced to describe a generic read request from the fscache, while
> the caller can specify the target buffer it wants in the iov_iter
> structure (io->iter).  Besides, the caller can also specify its
> completion callback and private data through erofs_fscache_io, which
> will be called to make further handling, e.g. unlocking the page cache
> for uncompressed data or decompressing the read raw data, when the read
> request from the fscache completes.  Now erofs_fscache_read_io_async()
> serves as a generic interface for reading raw data from fscache for both
> compressed and uncompressed data.
> 
> The erofs_fscache_rq structure is kept to describe a request to fill the
> page cache in the specified range.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

As we discussed offline, for the whole series:
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks for the work!

Thanks,
Gao Xiang
