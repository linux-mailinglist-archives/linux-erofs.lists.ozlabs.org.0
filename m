Return-Path: <linux-erofs+bounces-276-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 34352AAAE46
	for <lists+linux-erofs@lfdr.de>; Tue,  6 May 2025 04:53:52 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Zs2yz2XSbz2yrr;
	Tue,  6 May 2025 12:53:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1746500027;
	cv=none; b=Cgf9RtbXbQb2dx8LPGn8EzH2FMM5M4IGj9BzvF4kLMn1RSai5LM98OaW6FwUm+Raqtdn5wOzJXed+qNdx304X9/AnGKATAgM6wgZc7v8KpjTkX1XZVVgeiYc34hMBP9hR/xdhMn70sJwb5b+F+olmYXLTkbDfOhYJXldrSi35afxh5/AYFfh+3k+vnLf/IEcAt2iLunfKAfFrrp3Rot0J4YyXbwXMPLAAwFtwhClyVZK0DY9+koIo8HzjS6LrHaBR0iKCc/XdYq8OSbSkWK9FNRgt6wEY4XGUyAES4diC++CNb2J8azD42+/OYWuqxmoh2pigb5OUz4MYBgcnjHhRw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1746500027; c=relaxed/relaxed;
	bh=ijxf7urQxomBdoTZNh6eVgnKD1mw+0I5D10YbpAhmt4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FbAMQHsMZIgLcBeDLtg8vmzrCec8CmWKNKPwpP9PnbSCACyx4l3Fcqr0waTivVor+aOA0CfFmtLn5LugoBjea1X5/KglxpOWraBPzTiJ74FhvBzybKbpv6CuA4liDT56NkcWJnfLf7c9/WalgerGeD9jdlgIIZQUJ41nffeEzpXNTiGgmJrw61tKw0SDPH01iY3Qqj0UIiHsRogRPHDuy9BvE/qrdFo+W+QNYc0QBdQRgcPpj5BBVKwYMqVSvuAd7rB8TLR9dhVwBg1DezXkr3Wg+Uir8EUyRdNPtnkY8RIiiArIyr0SoSdjE+Iy1+d4LeXYziz7rghIRwwjJ/+A+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TpscIeyc; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TpscIeyc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Zs2yy2kblz2yrf
	for <linux-erofs@lists.ozlabs.org>; Tue,  6 May 2025 12:53:46 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 21ABEA4AB2C;
	Tue,  6 May 2025 02:48:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96820C4CEE4;
	Tue,  6 May 2025 02:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746500022;
	bh=G70iaAf67I0fVy6Ne5IGZ1U6+i+Badhe5dvPxOfehnw=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=TpscIeycIQ2bWOXm/8mPMlmH8FWe8/LOZJyhuGGHDW+9RlTjjFm0vM76SyqPK9bn1
	 suOyi8yEyBcfuDnNTPth9MxL9oAuDPaudtIelNaIaVkzZSiBHltflYUiySuv8EEuyj
	 p2sxz9JKoC70iN2leH5lumytcWwlkzESTnGbxgbOrqfl8wydi5JI0uHmmBfNbO378Y
	 eI2pvvNbBO73QsVS6/uMVj9DpCl4TsPqcJXpetdW6fZcofJBuhbsjFS3s57EcQGkEA
	 Q9a3WUEHpjQa1Rqp7HV8fMgpnTyyvJ35zBcxNXUdjyEl+BVePj2bBcmGwp/8SmvyII
	 m5tWeTZ31tsuA==
Message-ID: <96b206b2-4808-4cbb-960c-016b07dec3bf@kernel.org>
Date: Tue, 6 May 2025 10:53:37 +0800
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
Cc: chao@kernel.org, hsiangkao@linux.alibaba.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] erofs: lazily initialize per-CPU workers and CPU
 hotplug hooks
To: Sandeep Dhavale <dhavale@google.com>, linux-erofs@lists.ozlabs.org,
 Gao Xiang <xiang@kernel.org>, Yue Hu <zbestahu@gmail.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>
References: <20250501183003.1125531-1-dhavale@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250501183003.1125531-1-dhavale@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 2025/5/2 2:30, Sandeep Dhavale wrote:
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

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

