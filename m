Return-Path: <linux-erofs+bounces-1059-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2B9B8FC75
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Sep 2025 11:39:16 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cVdNf2Xn7z2xdg;
	Mon, 22 Sep 2025 19:39:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758533954;
	cv=none; b=ifrIx3WA4eTLITiCo57ECLIAYCa2dom9m9WI/2geNihxPczt/vBqMK3DgX8zSYCj0PYriWlMhaJVov/9BRakYoEzblZsN/XByiEVaKQfxOcz3gUxRibsRP/BvrVTqtlsn9YvQ5JiKWL+b9vIoaLwgoRzHh0jK4A+R4A4LD17iiO7G9mAjcpWzbQBb+UgUhY9OMvZr/8lrybSNES7bxlRU/zt3FY7Nce31WoJjfY5jpRtDpzgP1wG5rRbcytUMj0HMtXH8Jidk2U66h28fhf672RlRAyRLBn9jnfe6BvwZN72QKCLI+5uEmMb1NmbCIIbkWAskGp+FT5C2DBFr2gJCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758533954; c=relaxed/relaxed;
	bh=VMTFYI9vtwS1lrOKpDkvU2sRpGsH6MvSV4MjItMsv0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hIaAiQLufEouN//s3ogbqgc1wLOA1KPXM1uqyNCcae6U754mcMrxdbX0F4rznoQA4WVxT9mn8UjL8b8ZHor9UWywwMPF8fNtHYt3c6EZNfaRL8sKE2qsDDiZLSruWqQ7rSQAnsA7/p36lA0H330+xJBvcBO1wAqnH15HnHATDnKlGg13h278TuNxCvv5o/89ZUtj79jUMqpK16DfqzHhRhEsEVal1w/JkWfayWHYkU7o7KrX03Dqs/bM1rs9VRnP8hFVxKt4e/7Hzpyj3z4qVG3P27gP6ZXXySn8M0t7Rms0vpzi4OxMmnQHkgxfeX4CBr/jghP88HhpoJtqr17Vdg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=PNU8W85N; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=PNU8W85N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cVdNc3XKxz2xck
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Sep 2025 19:39:11 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758533947; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=VMTFYI9vtwS1lrOKpDkvU2sRpGsH6MvSV4MjItMsv0g=;
	b=PNU8W85NKqXV7iP4JmQ4PBgLWz4N2VvKiE3ZDu5NIT1WjfyR9vHtVGRAZhkkAkixbuARpF8AZrVhhoh1qAcJ9/xrcVhr0aEMGbjDQebX1CO2cxDfwtRq8ZqG/Y5Vns7JvIETB6lvQ6BNi6Bxy8nBi/8mrfgWipMfJv6ay8Bg9Ns=
Received: from 30.221.131.10(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WoVFgT1_1758533944 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 22 Sep 2025 17:39:05 +0800
Message-ID: <f8d9a52f-0e06-4ed2-9729-db4658992fae@linux.alibaba.com>
Date: Mon, 22 Sep 2025 17:39:04 +0800
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
Subject: Re: [PATCH v4] erofs: Add support for FS_IOC_GETFSLABEL
To: Bo Liu <liubo03@inspur.com>, xiang@kernel.org, chao@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20250922092937.2055-1-liubo03@inspur.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250922092937.2055-1-liubo03@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/9/22 17:29, Bo Liu wrote:
> From: Bo Liu (OpenAnolis) <liubo03@inspur.com>
> 
> Add support for reading to the erofs volume label from the
> FS_IOC_GETFSLABEL ioctls.
> 
> Signed-off-by: Bo Liu (OpenAnolis) <liubo03@inspur.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

