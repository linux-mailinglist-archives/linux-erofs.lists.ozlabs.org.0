Return-Path: <linux-erofs+bounces-1463-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C19CC95B44
	for <lists+linux-erofs@lfdr.de>; Mon, 01 Dec 2025 05:46:14 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dKWZD2hy8z2ypW;
	Mon, 01 Dec 2025 15:46:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764564372;
	cv=none; b=M8G/gurd+dbUXAdCCkL4e1PgCAX8anUYuygialP3U3dA8QpflnY17omNiAI+flWYw/L74ID/k2iQYsHrgm4BXvrh8gbFkpTj6n9lRI7LTCkD9dHZEwGmmni+/Uew0gxQZtDmGMIlZR5lQuR3Wr0whKo4eZHZ0tPcRcfw0jSaSzWPD1gDfV3j8L8ut1v+uBVekh1RcC6KVoZ5HU71s7znX5jwMoaRWp9uxT6o0O2s2Hp717oXUSDxMFxqgRXsm7ARljg6takZLUrCqW5WMTSHIfVz86sTucvPIx4U+hURymy7V57bungpE5MHOpFfuIEXIGn+06uOVYJvxPvwCYDG6w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764564372; c=relaxed/relaxed;
	bh=jUV/ITagNSNpa8eFJ52zJh7XUpgcDC6inobbMw8EeKQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ivOnhIuttVLJfn2XIoLDfHMiOgoJ4oL2QoT0oonWfGSi75owPMomJPCjsee1nwEi4DY06JejoS7bFQOJYHhuR9m9lVuHgK4mBMNPWADpkr0SI9Z9j7oa4V0EAJ6PfAcj63FuUymM/OwTazNoiNw4WmB+EpEn8glbYQcGo6+0H6pNbIuYQ9Nje8KC8py8HtsItc+fx8tVIU7u3rf/aAitKYmWzujoO7Q7dFtWdtMO5E3dBmz2YnSdIbbc/St+ZU3Hx+nmYoj7YhADFnKUASf/JlM4Ky2eDDDpJc+YHRqRcVVop/tkhncbwIzWnF0U5h8a6HpNcABa4G0Hlzv79gMbqg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ogINycyw; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ogINycyw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dKWZC28Kpz2yG3
	for <linux-erofs@lists.ozlabs.org>; Mon, 01 Dec 2025 15:46:11 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6C5326013D;
	Mon,  1 Dec 2025 04:46:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92829C4CEF1;
	Mon,  1 Dec 2025 04:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764564367;
	bh=S1AHz9TVZ4S8SoaaEbx7Ri9bh/YqDt2+f9if6viGKcw=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=ogINycywn6SceiEd0loeV37gX1VJoShrPp3BXiEBfYvt0yRcRPB1dfVc97PoN/fXA
	 sEIAQLNrozpHU2AEC4oMuqf+z+6+YN4IpfQBNkCw45qkgbhxYaxuIUfta/7jMA9RMP
	 Vppv4ffElTQkSx1uU4G18f+tk5cGYTRND2m2uqgy0wuYicxsxKjVF3Y2ADC8dzGYV5
	 /G8nQALPMqJl4YzfPtlXcsX8pMnzICa6A0rcgN8XphrUeD3TXnNVvIHF1wEnKJLUKI
	 XmQpuWSe/aVnpyjr8aOKUwdW/Yu2ZrS3cAWjuid1fQ99ybZ+eqGZnBrDgqGrvh2oJ/
	 hJ2Sw2wQUQQ6A==
Message-ID: <e81f2543-055b-4ffa-b4a6-7ecb70edb4d7@kernel.org>
Date: Mon, 1 Dec 2025 12:46:04 +0800
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
Cc: chao@kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] erofs: switch on-disk header `erofs_fs.h` to MIT license
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20251201023816.1045273-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251201023816.1045273-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 2025/12/1 10:38, Gao Xiang wrote:
> Switch to the permissive MIT license to make the EROFS on-disk format
> more interoperable across various use cases.
> 
> It was previously recommended by the Composefs folks, for example:
> https://github.com/composefs/composefs/pull/216#discussion_r1356409501
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Acked-by: Chao Yu <chao@kernel.org>

Thanks,

