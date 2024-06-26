Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 166FA9176C9
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Jun 2024 05:29:00 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VRgeNR5r;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W86cS4NdMz30Wn
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Jun 2024 13:28:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VRgeNR5r;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W86cL30nzz30Vl
	for <linux-erofs@lists.ozlabs.org>; Wed, 26 Jun 2024 13:28:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719372523; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=0zrJpY1JkZv2ZzG/zVeUvi0maDu1O7pGTexPM9pzIs4=;
	b=VRgeNR5rXcDnij9xgUZd0EyBXCvpdJGk4rCmwH7j1Nq0bQnoEEUvclVYKnt1yVvPkMWDvwV2+quhZHvQWhCjgtR42gq1r3jKvmmCE5jw9sOSJSfxk/fc0/8+PkwFKiLDcaojYxQo1+MDv08x+yLHip5zoqoHqnEiXbq6v/krmAg=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068164191;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W9Hi27f_1719372519;
Received: from 30.97.48.205(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W9Hi27f_1719372519)
          by smtp.aliyun-inc.com;
          Wed, 26 Jun 2024 11:28:40 +0800
Message-ID: <c809cda4-57be-41b5-af2f-5ebac23e95e0@linux.alibaba.com>
Date: Wed, 26 Jun 2024 11:28:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] cachefiles: some bugfixes for clean object/send
 req/poll
To: Baokun Li <libaokun@huaweicloud.com>, netfs@lists.linux.dev,
 dhowells@redhat.com, jlayton@kernel.org
References: <20240515125136.3714580-1-libaokun@huaweicloud.com>
 <13b4dd18-8105-44e0-b383-8835fd34ac9e@huaweicloud.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <13b4dd18-8105-44e0-b383-8835fd34ac9e@huaweicloud.com>
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
Cc: yangerkun@huawei.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, yukuai3@huawei.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/6/26 11:04, Baokun Li wrote:
> A gentle ping.

Since it's been long time, I guess you could just resend
a new patchset with collected new tags instead of just
ping for the next round review?

Thanks,
Gao Xiang

