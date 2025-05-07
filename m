Return-Path: <linux-erofs+bounces-289-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C4360AAD401
	for <lists+linux-erofs@lfdr.de>; Wed,  7 May 2025 05:20:58 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZsgWr332Zz2ydN;
	Wed,  7 May 2025 13:20:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1746588056;
	cv=none; b=AetYdH4zpc1TlCuzuDZTR0j0IFg07tDkqOMFoTbkpvfB3+7ZyHzHiDLPDE3nNtkJB4FUzKk6N9w6JOtIM+L9kTUqR8x/XUb8DK+5l+/B8Y0PUgu5vyi4ewcKfRc6XO8i0sBGjbO4F6M0JZASpfVVRUCbdSj3DaQdya41PxVRP24eCkZl8xgFhh/R/XDrZsKiycd0JT8IjRb2rLZcM/PsZ+BN2vlIbMpqoTIIJYajPZx+PGhwUxWOaLb8CcfJ0b2iU+KF+16k2y60QLvsxvzl1M1spuJFiwmJd3ToXQ2UyZeRVwWJw8MsAtCHciJQKve4ohYE1FBlwR/Dnq+uXwb78g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1746588056; c=relaxed/relaxed;
	bh=gQkijhP9xBXsa6mv/4CeSYnLUG5H7NYWHBmlNBuwIq0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YaQFYJptylC7s9QstW4Igk6wheRC3AhRRUl5+2KGuD/4spZgAk+v2Yg/O81CzF1rO0CPw/XpLkqvPOWbsqOV/DNIGb+N6+lAFPuZmtUWRlolGgl5Sunb9hs7l+5ksxF0/jRKDWhbeA6L/f1UACNI3ZYDN47ydpRoGt9FWpzSBrQ3db1gxVhdYY5xmue7FflEwcHVs30hM3QgDBxXgq7cUBTlTilBacP6O90epg1yzhqgHocyBJ+Q27L5yf48jC6WkOP+EZm5boEib8xN6RnImTjajdA6uEEGQT7qdAMaKAgDjBoW5u5KJpxxEhPWirR5V1rijdTvoIxRmogvyNlY/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tkhVW8Tc; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tkhVW8Tc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZsgWq4TcPz2yGx
	for <linux-erofs@lists.ozlabs.org>; Wed,  7 May 2025 13:20:55 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 302EE5C5932;
	Wed,  7 May 2025 03:18:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24C6C4CEE4;
	Wed,  7 May 2025 03:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746588052;
	bh=gcMNJz9YPaS5D5JY2/OC6sEBas2990lNVCdQwzme6Jw=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=tkhVW8TcblEVlJt9mjbkdcqGRsh/C5EjgOiw6tDn1fSvr/1usm+b8gImlgB9zX1cR
	 QuxDT4aOCLleN5nMNf3dSfKAkhJEhD/CYpKygJaYIhQRtrj9kndw4OOfdeX48CkCZ4
	 AGecGy8ABi/qirfz4EvhShvMbvGVZrRtq0vRC5SaE3EC+w82OnsNG1/kpmpXX4LBNi
	 uZY2rQWnyNxPLYDGvdTynDqXgU1zzs8P+DUEjEnfkmn+xZC1Dt01wKpJpa4hJwrJ0F
	 UFhir0xlM0bhPzs9l6+NRGGuUPFXdFnw5skP4RBO+/D7ygUSjvvXtikC4FC8Zh3jI4
	 FXWFM2ssvs9VA==
Message-ID: <4a70799a-ebca-44a4-bf8e-c47e54717dd7@kernel.org>
Date: Wed, 7 May 2025 11:20:47 +0800
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
Subject: Re: [PATCH v6] erofs: lazily initialize per-CPU workers and CPU
 hotplug hooks
To: Sandeep Dhavale <dhavale@google.com>, linux-erofs@lists.ozlabs.org,
 Gao Xiang <xiang@kernel.org>, Yue Hu <zbestahu@gmail.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>
References: <20250506225743.308517-1-dhavale@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250506225743.308517-1-dhavale@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 5/7/25 06:57, Sandeep Dhavale wrote:
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

