Return-Path: <linux-erofs+bounces-870-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C2770B31000
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Aug 2025 09:11:24 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c7WZL33G6z30Vq;
	Fri, 22 Aug 2025 17:11:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.188
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755846682;
	cv=none; b=VQ1ZEqWHrXPBkYxFUWpcMlFQ1bltOPWZtSo74YTv8i+vydl+4qPS+XSBHiklYBh+xx9l4aBEmuZGbtCMBdWnQ+L8xtjkKMivSkvLIBxmqPf1DC/u30jxkMrUIJi/jGpxkdODprESgTu0sqPBbBr4ojS8z0dE4VRXgF4/UDEDV6WcxV1A5nN4ORuu9bHtOcDI0oNYQHU2XFd4pRZAVT6rT1wMVJ9VwAX0t/d19JNURvPqdmITYoaYS1JQ+7NQQ6wJiW2vGKjA7Asy3z37j9TVLOA0WlDJfKB4og7WevIdL5paurDPl8CfxgMOWZJQfJu12Vdz8qi+vXlgTv4EDZ6+QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755846682; c=relaxed/relaxed;
	bh=6+hVaYp1rRtdy3ai4ELVqktrvPh2lsps8yj4wGKqc24=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GDdFJpT0UDEqPtiav0Rtg6DNv7rFVp29h2iRmNUA6Qgv6Pm1ThjYOSlCuhanW4OMrTnygKLHT9bf7tG56txsWt64zeYcIyINzOnjC5gneadjUfeGok4ZrjFO615ReoanMY/TLrzJdQDcjvDH+bTGRabXyLc8KyHqaVZuZ6IYTfx16wC9DPNCkS0IwBObTkxKt1B/5VH1UdQOqJha4nh6BUWk5pjpuoUT8Rt1Q9BsJy7rvUQXe0XakdAC/KDB2CUB4s+jkzkJIhIFbd0BIVQQ4IpVaXLYJ0fT9BQ6Gu2K/YzmF4m8l0lY3luNbmZIiVdh4shuKKZFaIdO4Hqz0PRn9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.188; helo=szxga02-in.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.188; helo=szxga02-in.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c7WZK1zdfz30KY
	for <linux-erofs@lists.ozlabs.org>; Fri, 22 Aug 2025 17:11:19 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4c7WY35YBqztTB8;
	Fri, 22 Aug 2025 15:10:15 +0800 (CST)
Received: from kwepemp500007.china.huawei.com (unknown [7.202.195.151])
	by mail.maildlp.com (Postfix) with ESMTPS id 50E7414027A;
	Fri, 22 Aug 2025 15:11:14 +0800 (CST)
Received: from [100.103.109.96] (100.103.109.96) by
 kwepemp500007.china.huawei.com (7.202.195.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 22 Aug 2025 15:11:13 +0800
Message-ID: <4b685214-6983-4945-920d-d86a2d67498e@huawei.com>
Date: Fri, 22 Aug 2025 15:11:13 +0800
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
Subject: Re: [PATCH v4] erofs-utils: add OCI registry support
To: ChengyuZhu6 <hudson@cyzhu.com>, <linux-erofs@lists.ozlabs.org>
CC: <xiang@kernel.org>, <hsiangkao@linux.alibaba.com>, Changzhi Xie
	<sa.z@qq.com>
References: <20250821073258.89073-1-hudson@cyzhu.com>
 <20250822060025.14787-1-hudson@cyzhu.com>
From: "zhaoyifan (H)" <zhaoyifan28@huawei.com>
In-Reply-To: <20250822060025.14787-1-hudson@cyzhu.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [100.103.109.96]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemp500007.china.huawei.com (7.202.195.151)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org


On 2025/8/22 14:00, ChengyuZhu6 wrote:
> From: Chengyu Zhu <hudson@cyzhu.com>
>
> This patch adds support for building EROFS filesystems from
> OCI-compliant container registries, enabling users to create EROFS
> images directly from container images stored in registries like
> Docker Hub, Quay.io, etc.
>
> The implementation includes:
> - OCI remote backend with registry authentication support
> - Manifest parsing for Docker v2 and OCI v1 formats
> - Layer extraction and tar processing integration
> - Multi-platform image selection capability
> - Both anonymous and authenticated registry access
> - Comprehensive build system integration
>
> Configure: ./configure --enable-oci
> New mkfs.erofs option: --oci=registry/repo:tag[,options]
>
> Supported options:
> - platform=os/arch (default: linux/amd64)
> - layer=N (extract specific layer, default: all layers)
> - anonymous (use anonymous access)
> - username/password (basic authentication)
>
> e.g.:
> - mkfs.erofs \
>    --oci=quay.io/chengyuzhu6/golang:1.22.8 \
>    image.erofs /tmp/output
> - mkfs.erofs \
>    --oci=quay.io/chengyuzhu6/golang:1.22.8,anonymous \
>    image.erofs /tmp/output
> - mkfs.erofs \
>    --oci=zcy1234/test-private,username=zcy1234,password=PASSWD \
>    image.erofs /tmp/output
> - mkfs.erofs \
>    --oci=quay.io/chengyuzhu6/golang:1.22.8,layer=1 \
>    layer.erofs /tmp/output
> - mkfs.erofs \
>    --oci=quay.io/chengyuzhu6/golang:1.22.8,platform=linux/arm64 \
>    image.erofs /tmp/output

Hi Chengyu,


BTW, what does this `/tmp/output` do? I think this parameter is for 
<src_path>

and would it be weird to have `/tmp/output` here since the datasource is 
OCI registry?


Thanks,

Yifan Zhao

> Signed-off-by: Changzhi Xie <sa.z@qq.com>
> Signed-off-by: Chengyu Zhu <hudson@cyzhu.com>
>

