Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2DA91B757
	for <lists+linux-erofs@lfdr.de>; Fri, 28 Jun 2024 08:51:50 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KZodi984;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W9R1Z6Bwkz3cXC
	for <lists+linux-erofs@lfdr.de>; Fri, 28 Jun 2024 16:51:46 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KZodi984;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W9R1T2tV2z3cF6
	for <linux-erofs@lists.ozlabs.org>; Fri, 28 Jun 2024 16:51:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719557495; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=G2GS0ttnxk96DYFmlPzDna2bpcep+8CvGlmW7aCi9WQ=;
	b=KZodi984H2sBDpxQ5PCqOUcgsoUguiBlc7UOvpHeOsShivtodi+lHU6w2kyn92tVbtVHerea4aNx/jooQv+b1Hh6324bZJ808RiGb/MHlJro78LFeCYQen36POW1x772bD3vdUW/JmBnu5hZa5d6RKMwJxoNG9L9l5zDAYEhGoY=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W9PPCZf_1719557492;
Received: from 30.97.48.160(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W9PPCZf_1719557492)
          by smtp.aliyun-inc.com;
          Fri, 28 Jun 2024 14:51:33 +0800
Message-ID: <cd550919-a900-4de8-9bd3-f9041f6baeb9@linux.alibaba.com>
Date: Fri, 28 Jun 2024 14:51:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/9] cachefiles: stop sending new request when dropping
 object
To: libaokun@huaweicloud.com, netfs@lists.linux.dev, dhowells@redhat.com,
 jlayton@kernel.org
References: <20240628062930.2467993-1-libaokun@huaweicloud.com>
 <20240628062930.2467993-6-libaokun@huaweicloud.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240628062930.2467993-6-libaokun@huaweicloud.com>
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
Cc: brauner@kernel.org, yangerkun@huawei.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, yukuai3@huawei.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/6/28 14:29, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Added CACHEFILES_ONDEMAND_OBJSTATE_DROPPING indicates that the cachefiles
> object is being dropped, and is set after the close request for the dropped
> object completes, and no new requests are allowed to be sent after this
> state.
> 
> This prepares for the later addition of cancel_work_sync(). It prevents
> leftover reopen requests from being sent, to avoid processing unnecessary
> requests and to avoid cancel_work_sync() blocking by waiting for daemon to
> complete the reopen requests.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Acked-by: Jeff Layton <jlayton@kernel.org>

LGTM,
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
