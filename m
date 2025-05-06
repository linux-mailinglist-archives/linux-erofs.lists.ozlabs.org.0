Return-Path: <linux-erofs+bounces-284-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F425AAD1B8
	for <lists+linux-erofs@lfdr.de>; Wed,  7 May 2025 01:51:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZsZtH531Yz2yGx;
	Wed,  7 May 2025 09:51:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1746575495;
	cv=none; b=SyIVtcpP3pKmEVEDvtY7jk31Keb5dLnU3kuLZfpCOqbLEX1KwBEyF6qBRPDGSt2FWIN9sD6D6F3CITeqFfawpjvPCUugkvqTnHhqjEYAVwo83p+7oAaouNsfMvDX1Eg+emI/GBFVWrNm6ufWbfcl8LOPMSIghl9c9LOIAw9vdBc69Znoi3LKvgZ1GW2+HAO0JPZ4CA3iIH5lKlNCHz5n3x/Z0Ts1TX/gMUbIpTrdWXIIVleevVUMFaqJ7CY4IlPzQc1N9mlVByNXiylwSzgXvEK5kr8aEyMdFoj3cMPePgN9Xque0CjC6X63ghCwB9+EELM3+Z6Eg58mKyoIgNbN4A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1746575495; c=relaxed/relaxed;
	bh=obgOiUEY30Q4J8mYbgYf9xP5X544tH9xAhY2id3aTXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kv4U9jho+hxcCcrsh4RVhKqFS+l/t/EQ5xL+8WKmJR6OB9IyaxuaDNjQP9fdijhMS3Pphzz9by8AEVWPpZipyHmMmt0BsWFHnYpf4XAtqYpnNrw7Yv1R5bsQyzA1kjfyOFUu1hscroc3bukJSbPptw+C2J8Fn3kW63J2iDjmR9YfupU1Xyceh3bZEPzr5vVPaKlmhT+v/9kc9/ZyOiDXtCoE3I3HQgBS5fHdCZ0TQIltEfUvWKC6EAMxhCJMN6i4CalCOiRTRRh+XfDQdqWIzE1VZUb3zRTaHiyKTDdb7TkHHLY9PnVEbl2OJakAzNDIXdDtqbZk7HoqBaOL/mREwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=rCYZdtTU; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=rCYZdtTU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZsZtG0WTgz2y06
	for <linux-erofs@lists.ozlabs.org>; Wed,  7 May 2025 09:51:32 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1746575488; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=obgOiUEY30Q4J8mYbgYf9xP5X544tH9xAhY2id3aTXg=;
	b=rCYZdtTUh2bwZRAU4Pmj5JzG6L55/FQ0DONv26PEDcLiNQ4wg/aFGPfaHYlbw0Pp3M6A8tupzr9C6QByRv+p6GAB5zdP3sKDTCzKY16MufNHK1DrHKH2r6VvNIvIt2NFqkPmD/E+qmY9cRwaO+Syau4JROCZ9+Zy1T3CIV2khnQ=
Received: from 30.134.100.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WZfyYNB_1746575485 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 07 May 2025 07:51:26 +0800
Message-ID: <251b2875-6082-4d0e-a20e-201048ce7c4e@linux.alibaba.com>
Date: Wed, 7 May 2025 07:51:22 +0800
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
Subject: Re: [PATCH v6] erofs: lazily initialize per-CPU workers and CPU
 hotplug hooks
To: Sandeep Dhavale <dhavale@google.com>, linux-erofs@lists.ozlabs.org,
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org
References: <20250506225743.308517-1-dhavale@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250506225743.308517-1-dhavale@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/5/7 06:57, Sandeep Dhavale wrote:
> Currently, when EROFS is built with per-CPU workers, the workers are
> started and CPU hotplug hooks are registered during module initialization.
> This leads to unnecessary worker start/stop cycles during CPU hotplug
> events, particularly on Android devices that frequently suspend and resume.
> 
> This change defers the initialization of per-CPU workers and the
> registration of CPU hotplug hooks until the first EROFS mount. This
> ensures that these resources are only allocated and managed when EROFS is
> actually in use.
> 
> The tear down of per-CPU workers and unregistration of CPU hotplug hooks
> still occurs during z_erofs_exit_subsystem(), but only if they were
> initialized.
> 
> Signed-off-by: Sandeep Dhavale <dhavale@google.com>

Thanks, it looks good to me,
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

I will apply this later.

Thanks,
Gao Xiang

