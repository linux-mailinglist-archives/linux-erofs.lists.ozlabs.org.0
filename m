Return-Path: <linux-erofs+bounces-63-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9C1A63346
	for <lists+linux-erofs@lfdr.de>; Sun, 16 Mar 2025 03:03:56 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZFhGy05nWz2ybQ;
	Sun, 16 Mar 2025 13:03:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742090633;
	cv=none; b=eBLiW0UD6r9pLkp48z7S6M+LFIw/v1y+d7o/hV1LaEIbfpig7IjO+RTm9F8LzP03tAcv+0RP7ZB9eyiJw/nTIrFsn2LPLjFD33H1b9fBFn+EFO5L7uDeOTVVoo24bskG5WN1um2L1F+URbLjfFPENs2CMFKGBWb0Il+6N17STNFurIMXstlisvscRQd/rAtzCLx6DDpRJ4bW57GuTxM5Ktv3Y+/15Tttmw2n/d5P3iMPkTY3rFx5Hxu0Go6r1EbCpEuEammf0koqi3oFn6WTYltLPAmTz11UMw3bGlXam9tX2gAdUdlHsTe3Ldgsh6xit9u6fVefIZQ/a/MTCtWaEw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742090633; c=relaxed/relaxed;
	bh=co29WGQjETETdiu+W/HL6m3b3j1jmIVINI9yd+0GfBg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XwcDs2dgv6GhLIpNjY99StswxXS/wbj/uY5uQ31JFa5B/O76oinP6bbKUCE7lDzp6kX3hkgZnvHwXZuD2/eMEE5BPNGeA7Z/dgHBFWqvtH6Uor58Fszj74wZc83NnKNvHuF0y5j6HZn/amcQa4s8YWpi3hau4rRpfVqNekjFbNg68WXF9E/SFn2dJKFuuNVpY67g3W4wLM0vHddlklNNW3MDhLhE7o7iy1eha7tRD0EBxi1KuXh/E2Qs8iODYbwTZqGDKP7Y5cWvpehKUp2msVYhNH0VO9xBJDdXBU9l4i8OVItHudUGTVDmrzZA8qEY1Rj7xdaTjcIboCs3j3GObA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tyhqtU5s; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tyhqtU5s;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZFhGx17ghz2ySZ
	for <linux-erofs@lists.ozlabs.org>; Sun, 16 Mar 2025 13:03:53 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 77F2E5C4547;
	Sun, 16 Mar 2025 02:01:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5122C4CEE5;
	Sun, 16 Mar 2025 02:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742090631;
	bh=xdojLrL1ulbwn5kbc3SSUv+quj7A5W/B6BZ765yLndg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=tyhqtU5sk5lAyxI1ghX1c166pstdJpKQUCmMAo98ROEPYEnN3bBEiQ2fMpA97wap4
	 gnWTV/A6IDK+o9sHACMoljMwi5IXoQkqYVOqt6csjzlrGXTjOZq2ZplYpAEb4GJYs5
	 Cz9tmCii+6Nqcyla5G6t6dyBAqbsNqUjmjM22pjqgMXeUo4Wj2mRyabizk9N+8oCHS
	 lxNNRSo1xCOBZw+z6j+Jwl5vmL1wMxjqHGsku3aMCHTgn91JEzSR7wEJy1Hfqsi855
	 C7AQbf3yTqkbq8vC/B4pJS8uWFADKag5TpQUNnHxgVtR7PVTVxpAZWDNx1CSr/d1Lq
	 49ugKIXQeeK6g==
Message-ID: <d013939e-9a88-4d5d-960e-ab5f59192e19@kernel.org>
Date: Sun, 16 Mar 2025 10:03:49 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [v2] erofs: get rid of erofs_kmap_type
To: Bo Liu <liubo03@inspur.com>, xiang@kernel.org
References: <20250217093141.2659-1-liubo03@inspur.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250217093141.2659-1-liubo03@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 2025/2/17 17:31, Bo Liu wrote:
> Since EROFS_KMAP_ATOMIC is no longer valid, get rid of erofs_kmap_type too.
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

