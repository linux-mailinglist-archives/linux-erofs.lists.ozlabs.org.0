Return-Path: <linux-erofs+bounces-1049-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BE5B87ECB
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Sep 2025 07:41:33 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cShFl1c1nz2yrK;
	Fri, 19 Sep 2025 15:41:31 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758260491;
	cv=none; b=CCMnoUzoKdAnlc26d/Dc8h44Yp/MTHqJa/A905sRB1YSoseuFZ+DCxFJYize0+majjpMsFmXZ9tGIINyjwIpmAG8ahivc2S7W6KZetFV7QVUpWs6AhLdKh8aY7hdjHKUvwh4CsxvvSHX0ssdO9NPUdD2wuI99qvNgDxhQgC1FL4PdP7zhsbrUQa2t9fcxiM1SRw3XIWEbsP9riDLPx2OkKVINPWdDpSLfbv2IP5uwg+nr8NO8EwSiSPcjEac7++eTNyvrTXxeEglR3FDMtCh8x4n/b9OHRxnix7jwsbJebJFUSPaNLNszHgkXhtvT4JoljhC3rqW4P1LsWh0s7CWaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758260491; c=relaxed/relaxed;
	bh=wPINJ4gIbW/ZAUs3cT5T6J+gpqiJy6X3GSNT/shpx14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YuHa7H0lnPZ0dDWogbiG+b/DgfBIqWUrWuugHvJJg3p1JG2QK0WQJhniChKtryq6ZDzvyVk5HfwYHs7axRcttH6+SfXyPK3LqREjlGM5SUgCRJckYF7koweFucSjEEWEEHSUJUjxYgz1aAlcFeuoNJwyICrOgNgA4xAC/we/RuJRyssnyHYDiBCsR/iDpDpgKbXaH5ITOBOmsLpQvSzfvIqVGKjpZaLcuRm8E5WdjdrQNmfoYEvBwtWhJ0xTXKjkzJpel+IocxSBRIcmvU6+0OEM/yDsMK7Bw/0431/9stoFPU8imhJ77hwTA6lVNcT02tCQJVUdrCWReFIHz97a+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ufHV0x1o; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ufHV0x1o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cShFj3pjNz2yQH
	for <linux-erofs@lists.ozlabs.org>; Fri, 19 Sep 2025 15:41:27 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758260483; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=wPINJ4gIbW/ZAUs3cT5T6J+gpqiJy6X3GSNT/shpx14=;
	b=ufHV0x1oz2MmIPlxZVBqA9fSZNb4xd1KWqu3rB/6A5tMvKxupsuqMBeQ/AK/96I1qXGIyiZT0bDMGG7rjIngT2eCQEonBMUlSrPbCDLOyJ3lyiftPD3EzVGU3bW82jCKcuXOdRooyHNmdrMAtfnWwoSWCoLimqXXwRZXv9J3D78=
Received: from 30.221.133.89(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WoIoRAA_1758260481 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 19 Sep 2025 13:41:22 +0800
Message-ID: <4da3115f-c09a-4c69-aeb6-763c6f1d1e76@linux.alibaba.com>
Date: Fri, 19 Sep 2025 13:41:21 +0800
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
Subject: Re: [PATCH 2/3] erofs-utils: lib: avoid using lseek in diskbuf
To: Yifan Zhao <zhaoyifan28@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: lihongbo22@huawei.com, jingrui@huawei.com, wayne.ma@huawei.com
References: <20250918151245.58786-1-zhaoyifan28@huawei.com>
 <20250918151245.58786-3-zhaoyifan28@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250918151245.58786-3-zhaoyifan28@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/9/18 23:12, Yifan Zhao wrote:
> From: zhaoyifan <zhaoyifan28@huawei.com>
> 
> The current `diskbuf` implementation uses `lseek` to operate file offset,
> preventing multiple streams from writing to the same file. Let's replace
> `write` + `lseek` with `pwrite` to enable this use pattern.
> 
> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>

The first two patches look good to me, I will apply them first.

Thanks,
Gao Xiang


