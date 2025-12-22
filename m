Return-Path: <linux-erofs+bounces-1526-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96603CD4DFC
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Dec 2025 08:36:19 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dZVLn0hDHz2xl0;
	Mon, 22 Dec 2025 18:36:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766388977;
	cv=none; b=MGjQr5GV1R3ymwstNarqvPV+rceG/PREvNG/qnePh7ibsiPLvzgx9n6tREmcxIPlgAqGGdMkAoVo8QcDvybb+YNTcf3/9ZAHrJsYSV2lhDFtaODVYleM3tCYjB4oEmRTwv8tzqehGRPSem3M4BgWTy8nhgEVfDkVXapZNl/ksXYBXMao54OPi2fZjM+hI4SnfrQNBkU3gUvrHlJ7og44zmBhV7VRN1o+B4nLheOqy87l/Z57ZN+4hQ2xrYd3iuensy4w45Tg2OXshfJ6aqUvUODjL5Fj7izXSOaOE7cFEDycC1TYDqgqQruBvIjY0vLWv0UAc8P+w1UY+a393PQJyw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766388977; c=relaxed/relaxed;
	bh=sGcj9tx9QTKHNk0aurI3sQxAB9f+ekfO07VmVY47850=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jTqlY0AHZHk6G0bAc7jg9zgCcjXe9vEyyn0JGYwFHpYNhPvJ2vsObUs4otKxQmBp65tMgPS+9MRJYUP3H35cSEQ6KV9ygsUr+0FkZRMqngLqOvKkI+wznlKhtnu5sNGo/BksjJo1iJQP/nq5nSwSw86/t1rDaVQKS6U6JMJLnJfihSeS5458rJRiwOMi0xI3O6ncKAZI/Ny7ziaWLOq3/CLdH/lvaYnBzOtDiaKT/O0LH0+o8vkwmDHwdzJntlMmFjo6zs1moKgfC1hlJIMvG47CEQtfiLf6YwFz8WsLps9He4T26lXob/XpScM6qWCB+qMlaNLY3eG+A7cxBQZFag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=GMy49r1o; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=GMy49r1o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dZVLk5hdNz2xg3
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Dec 2025 18:36:12 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766388968; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=sGcj9tx9QTKHNk0aurI3sQxAB9f+ekfO07VmVY47850=;
	b=GMy49r1olgpG2pc+0o8oHrPnzMTnMCoJB37ULxhGJdGDsmTcSxC5xxX3RmiREYjchQBQIkQ1B1bQQy5VX9hjHN6wirY7DcFiT71dF8fPRlgcerJWrAbx7RcbtGb4MCJBpFaoLgWd+Nm7VnpIruIZRqxJ8gVT+bIEZSHbtIt6WDQ=
Received: from 30.221.132.255(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvNIPbv_1766388967 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 22 Dec 2025 15:36:07 +0800
Message-ID: <dd53ed4a-1baf-4774-bc02-9e857bce8e7b@linux.alibaba.com>
Date: Mon, 22 Dec 2025 15:36:06 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] erofs-utils: mount: add manpage and usage information
To: Yifan Zhao <zhaoyifan28@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: hudson@cyzhu.com, jingrui@huawei.com, wayne.ma@huawei.com
References: <20251130033516.86065-1-hudson@cyzhu.com>
 <20251222071635.169262-1-zhaoyifan28@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251222071635.169262-1-zhaoyifan28@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Yifan,

On 2025/12/22 15:16, Yifan Zhao wrote:
> From: Chengyu Zhu <hudsonzhu@tencent.com>
> 
> Add manpage, command-line usage help, and README for
> mount.erofs tool.
> 
> Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
> Link: https://lore.kernel.org/r/20251202110315.14656-1-hudson@cyzhu.com
> [ Gao Xiang: change the section number of the manpage to 8. ]
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> Hi Xiang,> 
> Note that you have merged this patch. Could you consider merging this
> patch instead for the experimental branch? The only difference is that
> it also covers the newly added `oci.insecure` documents, see below.
> 
> Thanks,
> Yifan Zhao

Can you just posting an incremental patch for this? since I
have two new patches relying on this too.

Thanks,
Gao Xiang

