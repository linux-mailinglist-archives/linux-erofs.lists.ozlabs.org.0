Return-Path: <linux-erofs+bounces-1290-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B123C0BFEE
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Oct 2025 07:52:51 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cw42S40rlz2yyx;
	Mon, 27 Oct 2025 17:52:48 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761547968;
	cv=none; b=Ql0MY4kFswTIhyQos/SjRcQVPx8Kj7zzzLV/woDdh+FBKdGztnSeT6rgV+oOV+046oivzGk9w8TP57SoMzYC2981cXBe8o7HcGnYXAyNilvIn67dgFxWhhREZCHvMVCHqPJEUMZoia4WVhxjCoUT1nsKwdR66MOrnwxWrMVLJrTUFsPX5Mbu+kY/XwDskinqtppXQjRQCAHVODlI7HXO2by9TbyitEUQSrfenIJfDWPJo7GzvApIygmzd92V1cg6eQDWa0CeDrv2AU0tBl9r2ZQMVrbahFXPy9uMue5rnp66oPklhG7XM9thJY1nM+N+TqL+9jj8bwXtUNoU4YGsYw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761547968; c=relaxed/relaxed;
	bh=FIf2cYC5u6Yz68/SkQuluMbkfPGQo2gtpwx6yVD5Des=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Uy56SCFXK1pNa4e6JQzVOXZ44DTuRAyHhynK2qeC+92swXkXPi+hqYaiKXx3/nf3WqvE/km2nGXD7NyEjOTf+iYpUbhOCxTHM61IfUe2xiDSb751DcQVv1BfuDh3I6qj2ZMUPClUKoMlCHhrhZIscHBTe8XgoL6ZwXok/xZ/SGhcubfvMxKZa8LKSBlPx/sI/Zd7UQyj5gSgeFVbvpLXJe/A9IyAWXmbSKWqFjauJgH0rPx3D0iLgBsm91W5HFkPnE7kZ1KxL4K7MX1RXeaMCs9XQi8swtPgwp2sQLcormLdrqNeSt1GrfURR7jU22/XSFi8dgQbp+UVgmvIXXM+/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IVIBGndc; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IVIBGndc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cw42R6Tw5z2yw7
	for <linux-erofs@lists.ozlabs.org>; Mon, 27 Oct 2025 17:52:47 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7CC896013A;
	Mon, 27 Oct 2025 06:52:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A903C4CEF1;
	Mon, 27 Oct 2025 06:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761547965;
	bh=jkXvY/rzdsI9gD+gbwG7VuCZ95vvr+WarH7/oglQXg0=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=IVIBGndcChwkGK8tmWxLKO4II4sp1e86nYBvFcCoDr+TE5fXbr88oqdM3lgUB9+3A
	 9eM2HMtZSOlNu8yy17DQtOqW+f4XNhZ8ZsFVU98tRZ0ervJdFSyJDP4iWruI3VirSN
	 aMKqgJj3ZF4ZMSlR+2U/g+uvgA9R1vUtw5fuVPGUWArmBgq5uBRNpIfDkeQCuXQZ1B
	 x3L08EKbmJQpMZGg8M6GCbVx0TJHmzssT1wToe3oN1O2zU9FAM+tAuOuvgkI9jjraj
	 YSVqdjE9NS8x1sJQ+wrKIfW3poRWKJnp2wwAEa2/gVysPTXq8sOnQb5Lc6Cr52vDRC
	 icAeRpwQiAM4w==
Message-ID: <7c983f4d-fd20-4b7e-8ae1-d4cbd6f5a6a8@kernel.org>
Date: Mon, 27 Oct 2025 14:52:41 +0800
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
Cc: chao@kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: erofs: add myself as reviewer
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org, zbestahu@gmail.com,
 jefflexu@linux.alibaba.com, dhavale@google.com, lihongbo22@huawei.com
References: <20251027025206.56082-1-guochunhai@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251027025206.56082-1-guochunhai@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 10/27/25 10:52, Chunhai Guo wrote:
> In the past two years, I have focused on EROFS and contributed features
> including the reserved buffer pool, configurable global buffer pool, and
> the ongoing direct I/O support for compressed data.
> 
> I would like to continue contributing to EROFS and help with code
> reviews. Please CC me on EROFS-related changes.
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>

Acked-by: Chao Yu <chao@kernel.org>

Thanks,

