Return-Path: <linux-erofs+bounces-618-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 286C4B04DDD
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Jul 2025 04:35:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bh3FX2DXJz3bwL;
	Tue, 15 Jul 2025 12:35:28 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752546928;
	cv=none; b=NVZN30N2A54js6f63xThmkX54aA1vYjbiy7+woFW2s5n2FGKZZKDQExo/GBoeGhszz6vCfWelUQuwHTCJ9H27aRTmS006zZi8fYcbI62Ubg2QkFIq/IYUgVSjKDeQ+tKxb6Nill4O3tLiUPM6DQMcdk6/XALmkHyVptzWgoVg4XhQ+3FUyLoqTofRK5ujtKhygiJt8FQ4pzVFy/9Fly/n7J/cVmhCersTllxt5GhRucB+lq2zlE2fU9XuqOCPTdxc7ZW9DoyGz+R2cxsN4X1yce+JZG1P48/xpBRWmC2QGHY7lDR1hhYWkK8zU+Nrt74oy+XJH+wVuOAGVzgSzwYOg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752546928; c=relaxed/relaxed;
	bh=plgSZwUsi7p9/9srE0O02dF9lLoHBqrr2fxdbxpAYdc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WdgPSgj5rfbTv9ek67kaNTHnqkq+SUt7U3W4ZD2/A5FYrXCH2Nun0BHgOC6HmjH0Spuj+yZ1sRUwhNzZHzxj8leuUlRpWgUFrgDKABenZtP7T4EIQmeT9j1gRkAJUvnJ6S+6oADEPfCZAEy7TJP0YokeMWg5Q1j0Wgsu957jsnedpVO0hTJ7OKJGLH2voD2Z1bn+nKe0DeRLbT+kvjqgR5Wb0u8RNCM+gSHZg2cb0SVrmpQYG5Y2QzQGM+ayMa61JEAa2WDAPrCQFxq4j+6btjYbpgOdDnQWS0DdOoqlroXaxTtvu5++gG0GpFM7+jGX0ME9pkf2TJ6huaz5FNwNOQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=m7+UXwy0; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=m7+UXwy0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bh3FW3pg9z30W9
	for <linux-erofs@lists.ozlabs.org>; Tue, 15 Jul 2025 12:35:27 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2506661475;
	Tue, 15 Jul 2025 02:35:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56EA8C4CEED;
	Tue, 15 Jul 2025 02:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752546924;
	bh=3rn5X2804zVLNExXY9lUnvlDzx6yI9nWMKAmgXGBuuI=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=m7+UXwy06qyrxWX+pLnP3KZaCuMcFX/M2DEK0SFQM+YtQEpPlIejmMINTF19ZorMO
	 c8PFrAWFLUi30MjoN6dUcGj9FakgyO0VivjaafzTaCBtAqJuWXuW/tmJ7Uaji4+uB8
	 XnQ5Un3rxS2koRRMg8e0HDJtKdP6k9GM5PvWDStl9mB+o5xUyiDzZlmJuQqfCDlutY
	 Gs0M64FxJbORRhRJ+7HavV6sa+Vaa7D94QvpyNbgOx2Uo+Smxr9g+V+n0Jv1IdA7kl
	 QRL11tYptJmSvLXhcETuodALybw7ftdjLfIKPfgGSgjIZozfceqKg6NGgy3yi+xLA4
	 Lm9fXALjHwoWQ==
Message-ID: <4c651095-7840-4015-acb0-1375ca428317@kernel.org>
Date: Tue, 15 Jul 2025 10:35:21 +0800
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
Cc: chao@kernel.org, xiang@kernel.org, hsiangkao@linux.alibaba.com,
 kernel-team@android.com
Subject: Re: [PATCH] erofs-utils: lib: fix memory leak in xattr handling
To: Sandeep Dhavale <dhavale@google.com>, linux-erofs@lists.ozlabs.org
References: <20250711233548.195561-1-dhavale@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250711233548.195561-1-dhavale@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 7/12/25 07:35, Sandeep Dhavale wrote:
> In android the LeakSanitizer reported memory leaks originating
> from functions like erofs_get_selabel_xattr.
> 
> The root cause is that the 'kvbuf' buffer, which is allocated to
> store xattr data, was not being freed when its owning
> 'xattr_item' struct was deallocated. The functions put_xattritem()
> and erofs_cleanxattrs() were freeing the xattr_item struct but
> neglected to free the kvbuf pointer within it.
> 
> This patch fixes the leak by adding the necessary free() calls for
> kvbuf in both functions.
> 
> Signed-off-by: Sandeep Dhavale <dhavale@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

