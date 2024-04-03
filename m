Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DB889657F
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Apr 2024 09:10:40 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=d8BfBe8A;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V8bW15hwVz3cZR
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Apr 2024 18:10:37 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=d8BfBe8A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V8bVs4WNGz30N8
	for <linux-erofs@lists.ozlabs.org>; Wed,  3 Apr 2024 18:10:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712128224; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=18xhFpEEmP70q6IAUCBAVvfI09DuqR5gxP2Zlq+wxL8=;
	b=d8BfBe8As9lonZNo4t9KKC76lg4FpE+yt+ecxFR6dEwNA6DII8igwsu0KcOK9pQL7+rxPFGdpWoracMFgunN30ma3trK7vsulu+7plnb7kJYk+3fU7qxJCN/QmCRbgti7vMaJZWNY51TYx+ATtJP/w22WSPA+WJTtBCSdDjYFHo=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W3qrrp._1712128222;
Received: from 30.97.48.165(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W3qrrp._1712128222)
          by smtp.aliyun-inc.com;
          Wed, 03 Apr 2024 15:10:23 +0800
Message-ID: <ff9feb33-bf02-4a03-bce9-f886574e63c1@linux.alibaba.com>
Date: Wed, 3 Apr 2024 15:10:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs-utils: lib: Fix calculation of minextblks when
 working with sparse files
To: Sandeep Dhavale <dhavale@google.com>, linux-erofs@lists.ozlabs.org
References: <20240403070700.1716252-1-dhavale@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240403070700.1716252-1-dhavale@google.com>
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



On 2024/4/3 15:07, Sandeep Dhavale wrote:
> When we work with sparse files (files with holes), we need to consider
> when the contiguous data block starts after each hole to correctly calculate
> minextblks so we can merge consecutive chunks later.
> Now that we need to recalculate minextblks multiple places, put the logic
> in helper function for avoiding repetition and easier reading.
> 
> Fixes: 7b46f7a0160a (erofs-utils: lib: merge consecutive chunks if possible)
> Signed-off-by: Sandeep Dhavale <dhavale@google.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
