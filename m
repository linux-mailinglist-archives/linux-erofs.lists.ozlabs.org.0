Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4B09EE93D
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Dec 2024 15:46:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1734014768;
	bh=rQkmPonXMI95Bua+3PtHEMunl7yre6ZV7GYraA6ndA4=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=DMNvvgbRYyEjl8IsU0vLVshUTGPgkk9F+KnUMzhjewcIfjb/PQOKfQZ77wuZsD81z
	 HjLrq92z1UaxXsC7ZuiMJiBLsGWTxPXtx/9Z6dEVDucuQ7i8JhNak6sAujJF8KE2Tr
	 DjAZu0+6Gh1vOZ66RULZUvBIMXoEznZrNTCjDEKOyhvGrfme/oai1RxedRvDdUZ8dT
	 wcSJPRe/MSgZhFnTZPcsXhSmxQnlipcvQ/DCLjjNvloXnlfypPOMQO2qdW1aqhSgIG
	 rWGYtP82blNWB95ujsjRtdofMHaNigAr29KWEYU9U8GbEheiTMomtMjvKXyqXGm24l
	 yt97gd6LAe29w==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8Fdr0XD6z30dt
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Dec 2024 01:46:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734014765;
	cv=none; b=cnlscattEdVFDRxP5zCWyl7m1ZHBf1gPC6UferGLT2+u01kvkln/8D2yAtliLuDtwfuPmP9ISr7ET5ZDbt9eMxttgK8FUlAXQ4LyprJWT/5CkgWnnmeblUn6hsLUSGm8gXHlYBoEJ9X0GZFHZJqhcgs0klOCvLd8j/sDNzPOa4LV4dhiVYrzepxcOoZuyn2zZIHg3rJxdK9HseUq2LX0b2rbUuj4rNakPieNKbR1mspuPLUHYjTT57pioF2/Li+k3dW2c+TIL8Fe5cXm13LDHqoX+E1daYIOwkxZ5PwKgFwWTGMorC+WuGJs5zyj5BHMD+PdVVps3BbXAhChOkpyEA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734014765; c=relaxed/relaxed;
	bh=rQkmPonXMI95Bua+3PtHEMunl7yre6ZV7GYraA6ndA4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=n+68m06gTqRiBUqlDRjhNu3MPcrbHo5MC9tl9HnVIz91l4f1igHCMwwqfCavXIMeoa/zBBFWIoWLeLhyv8FSDF+pvAGrC8a1BvEPcwLWdBjqWVzA3M8zWRsA/O6rvwcHXmWsBqXdFvMdUNIVVcdCePW6Mhqk2bFtPnmBZOgLlrDYm5CvZUw0c3/MO5SofxriAqolKUNAqJk2Q/80TtSKQnvqUjMBxFqHVE4TLTQ2yl1LyupWgxLWYESnpShOHOhlEwxTMv8d6SQ/ojqVEI1ZRFGSELfGKgRmmkjQ3W/RXc7Ajx5zn0oNc3B06/X6IEPTtEmwhY4QdpYhaZfM36a6mw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=StN5UwQE; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=StN5UwQE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y8Fdm4XZGz2yDx
	for <linux-erofs@lists.ozlabs.org>; Fri, 13 Dec 2024 01:46:04 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 161B0A42827;
	Thu, 12 Dec 2024 14:44:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01966C4CEDD;
	Thu, 12 Dec 2024 14:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734014762;
	bh=pfZdIL/6B+O8n6Ex2RE/C19Cex533Wk2zzc++OJm9dU=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=StN5UwQEn2K4VSc+bG/yQIwWzJAcyYPTAB0sh6uct/dp1j6OI8WmZiG1I4yE5y1HY
	 K3QsOZmEOO9D4V8uncuPjuxw3wU2ksZLQs5acIBVkNxDAM9jHBrHVt9uSdA9cZ+PfI
	 V1dfnfrDYk60XhLc6PiPYzL/f6nGebrAvqizwMibSUVs4hNG7MB1qFtHXDJ8LkYNhG
	 XdJHOllNZ/mY8P5Z/aNqEvf4bHwULZgVB9hz+RvAHR1GSSk3xqiVishzMWayqOUQvw
	 n60XBua3wQhTwW7Ra18RnE3jyzuK7RjTwXo1pYMZdpb6ywYEfEnFHFnZ38/ZyYgAsb
	 AwzktGXuKaDBA==
Message-ID: <d3ce3735-42c2-484a-84e1-8b70e5d53584@kernel.org>
Date: Thu, 12 Dec 2024 22:46:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] erofs: use buffered I/O for file-backed mounts by
 default
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20241212133504.2047178-4-hsiangkao@linux.alibaba.com>
 <20241212134336.2059899-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
Autocrypt: addr=chao@kernel.org; keydata=
 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
In-Reply-To: <20241212134336.2059899-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
From: Chao Yu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Chao Yu <chao@kernel.org>
Cc: Derek McGowan <derek@mcg.dev>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2024/12/12 21:43, Gao Xiang wrote:
> For many use cases (e.g. container images are just fetched from remote),
> performance will be impacted if underlay page cache is up-to-date but
> direct i/o flushes dirty pages first.
> 
> Instead, let's use buffered I/O by default to keep in sync with loop
> devices and add a (re)mount option to explicitly enable direct I/O
> if supported by the underlying files.
> 
> The container startup time is improved as below:
>                                       unpack        1st run  non-1st runs
> EROFS snapshotter buffered I/O file  4.586404265s  0.308s   0.198s
> EROFS snapshotter direct I/O file    4.581742849s  2.238s   0.222s
> EROFS snapshotter loop               4.596023152s  0.346s   0.201s
> Overlayfs snapshotter                5.382851037s  0.206s   0.214s
> 
> Fixes: fb176750266a ("erofs: add file-backed mount support")
> Cc: Derek McGowan <derek@mcg.dev>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
