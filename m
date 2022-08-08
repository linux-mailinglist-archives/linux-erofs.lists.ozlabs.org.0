Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B607558C163
	for <lists+linux-erofs@lfdr.de>; Mon,  8 Aug 2022 04:00:09 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4M1KCR5kr9z3056
	for <lists+linux-erofs@lfdr.de>; Mon,  8 Aug 2022 12:00:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.57; helo=out30-57.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4M1KCJ4jXcz2xGg
	for <linux-erofs@lists.ozlabs.org>; Mon,  8 Aug 2022 11:59:54 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VLbnUuS_1659923987;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VLbnUuS_1659923987)
          by smtp.aliyun-inc.com;
          Mon, 08 Aug 2022 09:59:50 +0800
Date: Mon, 8 Aug 2022 09:59:47 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Sheng Yong <shengyong2021@gmail.com>, Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v2] erofs-utils: fuse: set d_type for readdir
Message-ID: <YvBuE0RLLYasZI/x@B-P7TQMD6M-0146.local>
References: <d783aec4-4d1c-46d8-202e-27ae5fe3cc72@oppo.com>
 <20220807080835.4160209-1-shengyong@oppo.com>
 <6104f247-fe16-7ee2-99f4-06772ebf2e1c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6104f247-fe16-7ee2-99f4-06772ebf2e1c@kernel.org>
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
Cc: linux-erofs@lists.ozlabs.org, shengyong@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sun, Aug 07, 2022 at 06:26:16PM +0800, Chao Yu wrote:
> On 2022/8/7 16:08, Sheng Yong wrote:
> > From: Sheng Yong <shengyong@oppo.com>
> > 
> > Set inode mode for libfuse readdir filler so that readdir count get
> > correct d_type.
> > 
> > Signed-off-by: Sheng Yong <shengyong@oppo.com>
> 
> Reviewed-by: Chao Yu <chao@kernel.org>
> 

Thank all. Applied this time without problems

Thanks,
Gao Xiang

> Thanks,
