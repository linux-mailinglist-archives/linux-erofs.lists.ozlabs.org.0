Return-Path: <linux-erofs+bounces-1427-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 226B5C7EB8C
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Nov 2025 01:46:22 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dF6Zg6wRQz2yvP;
	Mon, 24 Nov 2025 11:46:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763945179;
	cv=none; b=jEZoJnPX8IEyyAxF7fl0GR8hVDPIR2+Vavsry1j8cssYFeL9VPDARSpAHOZB8smTAALY+iGqsihzYQOPoQsUX4YhBIzD2Hy25gRYA60DfOTrQVGdBu397qiroaadgMT+fzv9Ck0/b9Sgx4o+YTZf8dQT/zVxHN6qb72NHqlsVOioaF3aTFMSGx9A6mdEi8ng8CotFquLvKt/pnQhBbmZSMydsWyAG8Aqp4v9V5vuADzOS6v4jdMljQ7UidDAO4HiNYBm2walW/AXuNcc83wereCxz48w/cfFBP3Xwh2mzjxcPFBjfknLIpQxxWf9h9OFcsF5tV+mG+c0+fOhaBR2Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763945179; c=relaxed/relaxed;
	bh=f5CmlQcW+roGkv7AqTyRVJzhiGHghnuqi1k9mhdTZWE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Z7YsKUgKDhf96GbKuq1fS6cDbyOIpJBgwyDznDjSjNmyYnumNXEDh4V6JkM6ZtUxmgIbWoVvxrW9KQQjDnSNC9OyK0hV0K/RTo/qGT1hqDbBbtFEr7zlQGq3V1OGgSKkdUY9RDKuxJYX+uynUcn+Op99uR3+PAx9CMQS3Hi3frLt32xrbDcr2YEwU4c1z7j/fTJESvZixevuKONUk3eWZ/USN6RcDbN6sHICf3yDFXWFeAPxLKF8qtg7b+iXWq2G3n7hZkqQGQEg8bcKoAY3WvVlwkS4Oq/cWRhKKDfaUkJ6ZDV26kYBjsE4RBk9XDngz3Tr194f6iKI6UldvccB5g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mp9eRl6N; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mp9eRl6N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dF6Zg301Lz2xS2
	for <linux-erofs@lists.ozlabs.org>; Mon, 24 Nov 2025 11:46:19 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 360BE42BC6;
	Mon, 24 Nov 2025 00:46:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83463C113D0;
	Mon, 24 Nov 2025 00:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763945177;
	bh=vZ69h7RxiGdx/8SDpLCvIaJJ4DKYtE3ElxMBvbTSKCM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=mp9eRl6Nds74672lMNP123RvhPEDOvEUQGDsTyzzsIa3LEJPA5pUMIQt4EBVQN1ol
	 QcB5gS7F5OBmNnzsONtdd0k+egqWJxovs1qpfnSaQVE0OPHXuQlfBMiJaKmu6VK//T
	 t0wzKd4XBJ2tY7+B0F3NvDUXmXYxtgXsS+PL8aV4s6GRCGJ8XYpAVZRLE5B6oR+muf
	 vRUA7ImaRuxHLKb+RNrru6shO2UEz2Jeez7+9lTdxjt8V7ijz8tBBjN4Wyjn2djKPL
	 Smx9HOLhe+mNW8+PtwwEbrcbUJ8NtdzWI23iUzOJ5m1WU0JcprLD6w/N1tlKkpSTOp
	 umRyN+Ef6VSEw==
Message-ID: <acefd64d-b575-4da8-aeea-296eb210fb4c@kernel.org>
Date: Mon, 24 Nov 2025 08:46:20 +0800
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
Cc: chao@kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Sheng Yong <shengyong1@xiaomi.com>
Subject: Re: [PATCH v2] erofs: limit the level of fs stacking for file-backed
 mounts
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20251121134647.104354-1-hsiangkao@linux.alibaba.com>
 <20251122062332.1408580-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251122062332.1408580-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 11/22/2025 2:23 PM, Gao Xiang wrote:
> Otherwise, it could cause potential kernel stack overflow (e.g., EROFS
> mounting itself).
> 
> Reviewed-by: Sheng Yong <shengyong1@xiaomi.com>
> Fixes: fb176750266a ("erofs: add file-backed mount support")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

