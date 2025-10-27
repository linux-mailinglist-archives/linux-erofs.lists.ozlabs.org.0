Return-Path: <linux-erofs+bounces-1289-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E04CFC0BC56
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Oct 2025 05:00:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cw0C62jc9z2yyx;
	Mon, 27 Oct 2025 15:00:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761537602;
	cv=none; b=EaU/fwTJcpQjYHsPrlmh+PBe0z34eI7cYYRYeEDoeMtzlwg8X0ErnAZ/YRq/GldqcEHQa8F+ebaNIIeP4TBa0Gpn7QY/ZA4dMP4PcywEuZdbX/+FReSvCIm6NTaBM1WQoYGjFLjKUUislLJVNOGS3bWoRSNM7tssWnSufLIdkZAYnc69HCedWF17L4ZN0H+Z9WIyS17ix0IuNaKYOIbwmwhnkd/HFP1DMwxRyBzuViNLd3DWaChwdVoUiKAmyAfMwfJVcDt1fak1BYJuP/fNHCvzHc6sGMm+xBZvFJDdkPdkdQ+S3zgZZzijOP1SlN7KKBfnNW6YOm6UKoNCG39FKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761537602; c=relaxed/relaxed;
	bh=DQc31bFTrrVKy16VImjwIlP/bVKFQ1gKD56/5QESdXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E4eWJEEtsus3ah/sEGLOePjSaRlTJpH+1j6u3Z0N8vKkML96dlSWX0StOsHSrYVdZK7pRpv5CqoudIM6DBOjeuRememOxfU8AzyZsTHOkyTT8SFmg9PJWHZjYah8CCG70YJe5fTlI25wDQbHLPEmrLNCq/KM0Qv2jBFHEK2aaYE5/iqNCBUwPcmVluGmTMRQHbzGu/ArYzsYgLyDuiGLUr4/EA3cb4siR3GRo2w4zyC1ZIvsFX80BaCEzk+dh2P/EfjsMFC3LYoDDSJu7GJDaSnMivMm7mBQWDsQytp1ph8SSS/gljlu9MvTS4bEdK+jpXgnOj/8eu6y9oITTptoMg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=suYwg2kH; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=suYwg2kH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cw0C373tgz2yvk
	for <linux-erofs@lists.ozlabs.org>; Mon, 27 Oct 2025 14:59:57 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761537594; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=DQc31bFTrrVKy16VImjwIlP/bVKFQ1gKD56/5QESdXw=;
	b=suYwg2kHtZwO4I4zXYSHCl6D9OdaAfANcEf8wD7RrIMqAs/QWCJWmCILjCWl4zgmWbJP55vGNMmqVb/bUOQWKftDGPX3UjUSuHD/2TXz598FpI84U4DS0G2+PSTenJcvAmpmyvhEEVsJ6CVArHlqMo2quhqJuOvRQMxcu3G6nTg=
Received: from 30.221.131.236(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wr-t3iK_1761537591 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 27 Oct 2025 11:59:52 +0800
Message-ID: <162c9d5b-b959-41b6-9951-cd0d6d4f065b@linux.alibaba.com>
Date: Mon, 27 Oct 2025 11:59:51 +0800
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
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org, chao@kernel.org,
 zbestahu@gmail.com, jefflexu@linux.alibaba.com, dhavale@google.com,
 lihongbo22@huawei.com
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20251027025206.56082-1-guochunhai@vivo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251027025206.56082-1-guochunhai@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
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

Acked-by: Gao Xiang <hsiangkao@linux.alibaba.com>

I’m perfectly fine with having more eyes on EROFS development
if you have any extra time to review the future work.

Thanks,
Gao Xiang


