Return-Path: <linux-erofs+bounces-267-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9050BAA0D78
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Apr 2025 15:28:54 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Zn1P026dcz30Vq;
	Tue, 29 Apr 2025 23:28:52 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745933332;
	cv=none; b=cluIa3N9AMJalbEVW0O1J8ykb9b9nVkKm8l8gJHVC3ye2R+wWJfyixxRxbU+KWrumHUKgY6DeveTu+SM2VkKoqu5XMD6CyL9HmpqU8XEVobUDX78kTpp4s2jmH3oQBvG1nKPAaybyt+R43dZNwrYIr46tkaiBsASi6BNP3IOYwzxrMv9DXnXnvEuJZv5/BbkL3Ulp3l7g8ZUNbtJDnGBllBTATmLsRxgUqkf6ntFIpZof++nGI7DEoFdzPmH4Rq4JMsYOtT5Z/0t6cfBbp4Piqb8H4kFrbYZJeq9DYgKlP9qk86GuxxhUb+ZyetFzVrUys3Sjyno+Vu0W+t+eqNx0A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745933332; c=relaxed/relaxed;
	bh=+ynYQ9mTGzbuU3A1Y5d1kj9HeKoSuUjtayY04YnKc1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWfzFuaO77XtL8fy51+eOAnCso+f3TCoomo9FZfB19IG5Fgx9nYIgG9Jw3TPsLGYbIiUOFnVCoMVThzdYQdONnpxZrU7eHCLw4khlW0IB7wb5EWxD/EcVbJblncGWZmvP+ICWCC6UCm+VA9mGFmwiPnW1J8c0+1n/D5lpSzqSRQX/uK66SwcV02mSccQI+NVvEbqP8baXD429DovU/9IKtQ/OCDae4iUWL77njvWLMiabjHDPD5m5qMQuvshGyi4aOAaL/DJDK7FIZPdUNxJxwd/JNMWg9A2usaBTKXmV0Af6pU2H3PdbLEh5n9J8HN2JwytnPMBlIN+o3QTKE351Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=X8MLGJA3; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=X8MLGJA3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 34441 seconds by postgrey-1.37 at boromir; Tue, 29 Apr 2025 23:28:51 AEST
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Zn1Nz3YL4z30Vn
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Apr 2025 23:28:51 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id CF52D61568;
	Tue, 29 Apr 2025 13:28:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85794C4CEE3;
	Tue, 29 Apr 2025 13:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745933328;
	bh=xsBsO/sjs+IIJB50V0/7metlk79FzVIvViIS88ZGBNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X8MLGJA30OvJcZ56T+sH+cvJU1823GqqTvbfrlRw5shX+cJD+Y9glWt1Y8O9gRxb1
	 0NDtCRlGQDUlUqR3s/QdZw4tFQVEuuVlxSYWIlstvKjVDKuTCtqUTmx1doEJ2FUfdt
	 L35utiH5jGWr/WA7Bp4qur745g1/S7bdF7GWQCUYz5kV1MhBzSed7ARckyQcg5kn0Q
	 ZbX5S232aK0EY4TitrEafEdm9kDH5YZKdE3IDUzzvbB+pQpBVie3HCBjkTPnX8rk28
	 l0XUHexl3KLMCFHknyiYnf7tu7aWY1+qyk/9a7mcymVcXjKkUBQ9Lyjw94DoRlxsYT
	 Ys3VwAhw+omfw==
Date: Tue, 29 Apr 2025 21:28:41 +0800
From: Gao Xiang <xiang@kernel.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: xiang@kernel.org, chao@kernel.org, zbestahu@gmail.com,
	jefflexu@linux.alibaba.com, dhavale@google.com,
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] erofs: remove unused enum type
Message-ID: <aBDUCS7rzDbB1OpZ@debian>
Mail-Followup-To: Hongbo Li <lihongbo22@huawei.com>, xiang@kernel.org,
	chao@kernel.org, zbestahu@gmail.com, jefflexu@linux.alibaba.com,
	dhavale@google.com, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
References: <20250429075056.689570-1-lihongbo22@huawei.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250429075056.689570-1-lihongbo22@huawei.com>
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Tue, Apr 29, 2025 at 07:50:56AM +0000, Hongbo Li wrote:
> Opt_err is not used in EROFS, we can remove it.
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

Reviewed-by: Gao Xiang <xiang@kernel.org>

Thanks,
Gao Xiang

