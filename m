Return-Path: <linux-erofs+bounces-570-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F3BAFDFB6
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Jul 2025 07:55:20 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bcRys4Lmmz2y8p;
	Wed,  9 Jul 2025 15:55:17 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752040517;
	cv=none; b=YFQ02Ij/AvolvH/nNtByf7iSY3Up+FxPk4/u8q1jpk6+C8n/0h++cl7NZz6w38SOfqAy4ndOJoRRETDhcJIJgKQ36MiTvnBrzaARIvckDK5vqCSAGKlzZTEOZL4yoh6HpsY2C3pPe7FyLqJIYJLmRfqTfEV6efzL8mf88eNQyX/WsqLGj9BvHoOJKkhtr/arTTQxUY3gRm0Tu8uTL3n+KcNVrwd2sKIi2v2o6jgJcpX4P+qmguEVVZQpECV59AHpjOQ38QK55MfAYnPgxWoHmoMXOwcHeDCEKoFGNe2+3mUlPSSVNJURyJ1oPB+F/ZSJiI5HTpPIHYafG39j44LsdA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752040517; c=relaxed/relaxed;
	bh=AtmsbTFxBLE3ggp840g/o74/3MOXss/L8gwWoubJheQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AtGDmgKJQd1UJS/GBZkhj5WmvRP+TWV1AfNE0xO3vvcwX/OsBCzBcGteafJDPvji3f3EjKrFb90waLmN0k5e3HEHhmABvuGRPOhnq9Zcye5LsQGYY6Xf0w0Fyj0MM+WntICSCY4FnBPrKexzeWUsbq/oRvIDGqn74TiSqfpN1elzOVRbsbpPDqzsT3kPzBIn3NFp778O7IEIChnKSGU6/12G2KfYnehIFDeR5jv53d7YDPleL4GFKPK9t5lzUNZmoIT9wHRCFjzoq9B5x+w+Gfv8kvbqRMddNHYdbirphV23vtRKo/2oV5YQ47v2zX5b56E7gzZ7niNCj3hnNFllLw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=uLM/OiPF; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=uLM/OiPF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bcRyq4nZmz2xCW
	for <linux-erofs@lists.ozlabs.org>; Wed,  9 Jul 2025 15:55:14 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752040510; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=AtmsbTFxBLE3ggp840g/o74/3MOXss/L8gwWoubJheQ=;
	b=uLM/OiPF8CpLJtcG6hESb4Cjnp37OAp5FSzTrb795BOmaeg94DrtbZILGJKb4C70BDJoJ/5aufojg85Wv8Jnu6LVoElkLgTwS9OAFO/2pRK0ltbKEbwIIA6gmENvoqfA5Xo7oMG85Zwk0KEc3+782ByuV5X0WdXHO5sMCHUf+dc=
Received: from 30.221.130.130(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WiWaECA_1752040507 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 09 Jul 2025 13:55:08 +0800
Message-ID: <c7379b0e-ebe6-42d4-a779-7264e331335c@linux.alibaba.com>
Date: Wed, 9 Jul 2025 13:55:06 +0800
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
Subject: Re: [PATCH 2/2] erofs: address D-cache aliasing
To: Jan Kiszka <jan.kiszka@siemens.com>, linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Stefan Kerkmann <s.kerkmann@pengutronix.de>
References: <20250709034614.2780117-1-hsiangkao@linux.alibaba.com>
 <20250709034614.2780117-2-hsiangkao@linux.alibaba.com>
 <bbe6cac3-7792-4d85-b5ec-124f7eec20c5@siemens.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <bbe6cac3-7792-4d85-b5ec-124f7eec20c5@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/7/9 13:50, Jan Kiszka wrote:
> On 09.07.25 05:46, Gao Xiang wrote:

...

> 
> Tested-by: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Please make sure to address stable versions as well once this is merged.
> I've so far only checked 6.12 (besides top of tree) where this applies
> as-is. Other versions likely need extra effort.

Yes, I will address them manually one-by-one.

Thanks,
Gao Xiang

> 
> Jan
> 


