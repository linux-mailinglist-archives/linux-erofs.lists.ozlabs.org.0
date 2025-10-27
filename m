Return-Path: <linux-erofs+bounces-1293-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D0EC0D089
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Oct 2025 12:00:39 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cw9XN5nQwz2yjr;
	Mon, 27 Oct 2025 22:00:36 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.187
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761562836;
	cv=none; b=R2noIcSYShABrPcJcH6+NHV4p7BZQkKhUHhqli78/LmQxmCrqKzpW7Wrnfj8vS1n3pJZTHJS568dhYFd8t9n1VxKGYseLQAeerl9GeDs1pPMQNWVE6ZG0jawyKGfVB+PtBSrtUJ5Ouz0YXaV+ssbW3cykAG3aLiDb8cPrQNmbRaItCqYjK6C1rK5t1FwuThSwn/4QkA0uHNBictONyEznFZ5Qav6b9oj1Ekr51OBx0eQ81OS+WimORxS8CGFW6h154pgVBTIT3eX1g/npuagRKt68fvX9saudRLOoXrU1O8sC2tRrJ6n64x8AkowUZnPtN9+8O9fyfTM0H6DNriiNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761562836; c=relaxed/relaxed;
	bh=oNtBAjGkhzZkwZC+rIvdBIoH1GOJbNr2aEotHhsyOEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Vmw67AJEYStEdCiP1oRAvAoCr5IIEFgPQ2Lz2xiVoLGkFTzc1ZAXNboxlp/mtEETv0XPX1w+ltFWZk9kZvSiuov8i+0wU7f00NOO8ubyIjbLcZu1DwpH8ORZBOBfj/+oIgzcg+57gV3TdMPrHbZgrQ860x2g4VwzSvZQBKAgBFsRDtheNXjX1myQ4guNllsCzYtdQIUdBy/Ccvy6WcihE79Al+i3tVHOd0d14RH5uM+dno0j+bDP0tG096VIPEqCM5YpuErb3tYUcXwT2DizjlrfcopM1hUhXt0GlTwYCXyq1musAgAbaU7DnSVQELvMqN5CkktGKL+0ZCRAZWmcdg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=fgIWNLYG; dkim-atps=neutral; spf=pass (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=fgIWNLYG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cw9XK5tKmz2yrl
	for <linux-erofs@lists.ozlabs.org>; Mon, 27 Oct 2025 22:00:31 +1100 (AEDT)
Received: from canpmsgout05.his.huawei.com (unknown [172.19.92.145])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cw9WY3CghzxXZr
	for <linux-erofs@lists.ozlabs.org>; Mon, 27 Oct 2025 18:59:53 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=oNtBAjGkhzZkwZC+rIvdBIoH1GOJbNr2aEotHhsyOEY=;
	b=fgIWNLYGFU+OeD9IGg5ucYpOfxSu6tSKhxggzQpspg+C+gC3U9sNQ87UQiPdxTItbottOYai1
	zLT3D2zsDekeKyuNyF4l45N9Kg8gbg2+1zcNey9nm0NHQvE7e5JRGzsjYTqhWtMN8PerVdiAwLy
	vLXlrbEyC5AU9nimVNOCKIg=
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4cw9WK3Rvzz12LFQ;
	Mon, 27 Oct 2025 18:59:41 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id C2AE518048F;
	Mon, 27 Oct 2025 19:00:19 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 27 Oct 2025 19:00:19 +0800
Message-ID: <346efa9b-5718-4963-842c-649ec2243453@huawei.com>
Date: Mon, 27 Oct 2025 19:00:20 +0800
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
Subject: Re: [PATCH] MAINTAINERS: erofs: add myself as reviewer
To: Chunhai Guo <guochunhai@vivo.com>, <xiang@kernel.org>, <chao@kernel.org>,
	<zbestahu@gmail.com>, <jefflexu@linux.alibaba.com>, <dhavale@google.com>
CC: <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
References: <20251027025206.56082-1-guochunhai@vivo.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20251027025206.56082-1-guochunhai@vivo.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/10/27 10:52, Chunhai Guo wrote:
> In the past two years, I have focused on EROFS and contributed features
> including the reserved buffer pool, configurable global buffer pool, and
> the ongoing direct I/O support for compressed data.
> 
> I would like to continue contributing to EROFS and help with code
> reviews. Please CC me on EROFS-related changes.
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>

Acked-by: Hongbo Li <lihongbo22@huawei.com>

Thanks,
Hongbo

> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 46126ce2f968..f482c7631dae 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9201,6 +9201,7 @@ R:	Yue Hu <zbestahu@gmail.com>
>   R:	Jeffle Xu <jefflexu@linux.alibaba.com>
>   R:	Sandeep Dhavale <dhavale@google.com>
>   R:	Hongbo Li <lihongbo22@huawei.com>
> +R:	Chunhai Guo <guochunhai@vivo.com>
>   L:	linux-erofs@lists.ozlabs.org
>   S:	Maintained
>   W:	https://erofs.docs.kernel.org

