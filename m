Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7163F87C7A2
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Mar 2024 03:40:13 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=SKaVu0CU;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TwpPh38dTz3dRp
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Mar 2024 13:40:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=SKaVu0CU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TwpPW47GJz30fm
	for <linux-erofs@lists.ozlabs.org>; Fri, 15 Mar 2024 13:39:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710470393; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=zEy8W075luBy8ifAubr/Fv30yov9aR129TeKrpXesTs=;
	b=SKaVu0CUF7dAwkJpRDSqJ9jRhjprUf3bLfzSLXDwsoeJFHafIak7BdXt7SRssNgkWRFhS9olW1P46LaI9/3/IK44q2OTr+IzK/ISkG4IHRlxBQ/KnUojUfcnXyVwWWQPhOGOM8pIVxXwzM+I4NAbIrkFbifMinRZg6AMdQWeDLw=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W2UV3YJ_1710470390;
Received: from 30.221.132.166(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W2UV3YJ_1710470390)
          by smtp.aliyun-inc.com;
          Fri, 15 Mar 2024 10:39:51 +0800
Message-ID: <cf279f15-f094-47b4-aa5d-0948d43dbbee@linux.alibaba.com>
Date: Fri, 15 Mar 2024 10:39:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] erofs-utils: mkfs: introduce inner-file
 multi-threaded compression
To: Yifan Zhao <zhaoyifan@sjtu.edu.cn>, linux-erofs@lists.ozlabs.org
References: <20240314123754.1548878-1-zhaoyifan@sjtu.edu.cn>
 <20240314123754.1548878-6-zhaoyifan@sjtu.edu.cn>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240314123754.1548878-6-zhaoyifan@sjtu.edu.cn>
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



On 2024/3/14 20:37, Yifan Zhao wrote:
> Currently, the creation of EROFS compressed image creation is
> single-threaded, which suffers from performance issues. This patch
> attempts to address it by compressing the large file in parallel.
> 
> Specifically, each input file larger than 16MB is splited into segments,
> and each worker thread compresses a segment as if it were a separate
> file. Finally, the main thread merges all the compressed segments.
> 
> Multi-threaded compression is not compatible with -Ededupe,
> -E(all-)fragments and -Eztailpacking for now.
> 
> Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
> Co-authored-by: Tong Xin <xin_tong@sjtu.edu.cn>

I did some updates yesterday and I just posted v7.

BTW, I also found an issue that the output cannot be stablized with
"mkfs.erofs -zlz4hc,12 --worker=72" and enwik9 dataset.  I'm still
looking into that since it's an unexpected behavior.

Thanks,
Gao Xiang
