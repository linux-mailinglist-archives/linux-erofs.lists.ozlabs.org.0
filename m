Return-Path: <linux-erofs+bounces-1685-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E1CCF69B2
	for <lists+linux-erofs@lfdr.de>; Tue, 06 Jan 2026 04:30:49 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dlcBb03k5z2xqr;
	Tue, 06 Jan 2026 14:30:47 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.221
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767670246;
	cv=none; b=Fw87dUt+azwUpqOzR40TeXMMWLWyJQ48HcWJBYAMszg4vtRonSvTzYvPL/HwefPPU+otuwpAnFWRWqRQNObWA7sCtwlwDoj+MKeTZIJp3Yy9A9wjD00JbvmZzylaLT6hDR+mDCDIBIRFP4OqFiK4FRZaRQ6Gq1eglY/ZXtK2kTDbD+t3eqTk02hKGjg6C6MchmK9XGnWaNSced7RZ+q9Eqfr5xE9b3kZdYPtToke0lPamlRxVhBlS2krf1csMMbb5AifEZz9bP64f+SIxUQaBflGSLS0x0v/nxLAjJk+wXatdliK0YCL/whoVCzNAaBjmtdmD+g4IW86TlpLcuSe7w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767670246; c=relaxed/relaxed;
	bh=fH5tAFDXoyQRCxCzKZzMPwXjTcOhHzQLMuR5OLTiTYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ABgmlfRjd25n2C95A0QCC3Sc32dcsMW+FaLB7Oe9OYn3rv6rZe0q8RdoRpIIMErwIITFhI0pev5gVvhyhSau4xXqcjIHjt7QZWpGR0WB5WdO9i2s9PnzS+/c8mlE9pgGxvJLXvcJeuuFm4HaaEm1rigfZ/KpPMPY5iWp4dXXgikw+ROIPI622671hzarLXrPD0L/Ap09NDZ5CAswRtRmVmr+fR6fjZcrbjOFaSF6eS+ghMInqGC/HmzkvF+yx5eelgQxXqfyNG0U7plXDrpcsSY4xgXqSGdVpyLNNlGVpy9HwfWnVDTw/OBI1LdIGsB2CC2Wvm/uEV/Z3IS4r9ES3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Ve26SldA; dkim-atps=neutral; spf=pass (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Ve26SldA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dlcBW5Cmfz2xRv
	for <linux-erofs@lists.ozlabs.org>; Tue, 06 Jan 2026 14:30:41 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=fH5tAFDXoyQRCxCzKZzMPwXjTcOhHzQLMuR5OLTiTYU=;
	b=Ve26SldAtsQg5RJxLicZ5Nsgeze4pQ8cFv4h1O9kXvMpaFUsg7/svzzgf/ZFNGIfOl+zsgtn9
	d1IbyP3iXQFZ8fCdDKE1LkmVyqoduMnV/31zzwOyYC5wbG5VLW5aCd+8fb85vecm3gwCCviJJnF
	OFBYH0pLe5Ss4NMXRWAzMbI=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4dlc6d1mQKzRhRZ;
	Tue,  6 Jan 2026 11:27:21 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 2DCF64056C;
	Tue,  6 Jan 2026 11:30:36 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 6 Jan 2026 11:30:35 +0800
Message-ID: <d5a5b58d-de3d-452a-86de-7e7fb71fe518@huawei.com>
Date: Tue, 6 Jan 2026 11:30:34 +0800
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
Subject: Re: [PATCH v1] erofs: Fix state inconsistency when updating
 fsid/domain_id
Content-Language: en-US
To: Baolin Liu <liubaolin12138@163.com>, <xiang@kernel.org>, <chao@kernel.org>
CC: <zbestahu@gmail.com>, <jefflexu@linux.alibaba.com>, <dhavale@google.com>,
	<guochunhai@vivo.com>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Baolin Liu <liubaolin@kylinos.cn>
References: <20260106025502.133470-1-liubaolin12138@163.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20260106025502.133470-1-liubaolin12138@163.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi,

On 2026/1/6 10:55, Baolin Liu wrote:
> From: Baolin Liu <liubaolin@kylinos.cn>
> 
> When updating fsid or domain_id, the code frees the old pointer before
> allocating a new one. If allocation fails, the pointer becomes NULL
> while the old value is already freed, causing state inconsistency.
> 
> Fix by allocating the new value first, and only freeing the old value
> on success.
> 
> Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>
> ---
>   fs/erofs/super.c | 18 ++++++++++++------
>   1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 937a215f626c..6e083d7e634c 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -509,16 +509,22 @@ static int erofs_fc_parse_param(struct fs_context *fc,
>   		break;
>   #ifdef CONFIG_EROFS_FS_ONDEMAND
>   	case Opt_fsid:
> -		kfree(sbi->fsid);
> -		sbi->fsid = kstrdup(param->string, GFP_KERNEL);
> -		if (!sbi->fsid)
> +		char *new_fsid;
> +
> +		new_fsid = kstrdup(param->string, GFP_KERNEL);

May be there is no need to keep the old pointer. Because
1) The fsid/domain_id is ignored in reconfiguration.
2) Even if memory allocation fails when the user first mounts with multi 
fsid/domain_id options (like -o fsid=xxx1,fsid=xxx2), the old fsid 
pointer would also need to be released in cleanup procedure.

so am I right?

Thanks,
Hongbo

> +		if (!new_fsid)
>   			return -ENOMEM;
> +		kfree(sbi->fsid);
> +		sbi->fsid = new_fsid;
>   		break;
>   	case Opt_domain_id:
> -		kfree(sbi->domain_id);
> -		sbi->domain_id = kstrdup(param->string, GFP_KERNEL);
> -		if (!sbi->domain_id)
> +		char *new_domain_id;
> +
> +		new_domain_id = kstrdup(param->string, GFP_KERNEL);
> +		if (!new_domain_id)
>   			return -ENOMEM;
> +		kfree(sbi->domain_id);
> +		sbi->domain_id = new_domain_id;
>   		break;
>   #else
>   	case Opt_fsid:

