Return-Path: <linux-erofs+bounces-59-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF1FA6332D
	for <lists+linux-erofs@lfdr.de>; Sun, 16 Mar 2025 02:27:21 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZFgSg1jFsz2ybQ;
	Sun, 16 Mar 2025 12:27:15 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742088435;
	cv=none; b=QtlbjvW9KPIJ09yzmSeWXUTDS8BY3ciBf6RcyvhWaj/05umbs25vD6Ma1CjPkx6byF/EIz5qD67HPZZLu/ojzJTulkB1aNfdHqwwf2H0Mf/BA43OISxEAkDH8/wk/i4D5ICWkilemLtqTeyF0XeIwqtds1V/5h3ReNByVWN55TWXxgBJ3CCLBS+gZ+05lw8nuV/1eoy2iH9j4JAky92erFk4Q8ya1+9Vyni4pNbXzMHbZGGCBsZWa3YWJeFUrfz7WLlHEtTJnCjSXLVDw6WheCDR8rAdsDaTcOCW+bWpHSZMDBr8cdNv8lLUjdDpNlqCc5dYlfaU3cpmLyZnsAVoTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742088435; c=relaxed/relaxed;
	bh=rg4hO5tOPw6wh5wrgZ25Fogocp3v+QbsS+RBMylXIY8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GT4R92V31fzvJRECkx65VCIP0jOyV0LHXwgsEtoUrpLGsuhSBD9ZAcfHPgZBJs8iuSM1hgVdRJBRBqNIhZnLC4MqVZpt1pjhQmKsyVBoIbk3r4KAftpLqQ7V0RhVAmCRXCsTVMHMWfMOtEz+kgqxSslRIx2VF/nUStmLzdld7dq0E5+mFuJaWApQs9vFelvEJ5lDUvNTS/Yl0v4c4XJVvFPwQVrU7YtJa28h0DMec4rSNX3veQEk+sx9hk6nRPxKgwvo2GNuQXD7SH5S/cJ/Gy7hHr3vF57MKd/R19eX3ugPkGHmxxS91DcFafM0X/NroNiTf5c1lssNQUhvcXE8Xg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=c1go6Nci; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=c1go6Nci;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZFgSf2hHNz2yS7
	for <linux-erofs@lists.ozlabs.org>; Sun, 16 Mar 2025 12:27:14 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 037225C4854;
	Sun, 16 Mar 2025 01:24:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43CCAC4CEEA;
	Sun, 16 Mar 2025 01:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742088430;
	bh=5TRRFLw+o6yMhZVEtsWaD2Ng0tfLzikBtpEkJuppsGA=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=c1go6NciCQrZbCxxUUqiEgYYtV8DlwNZGe2pRBX5Mcb++P44cYAk6qOi22rIwmGY2
	 toGaGXwaXSECYQdAkVSlR8oCoUQmYoweoqIhZJB92hAsAiCfsaxdaqV/UG60uBhCNE
	 qAVS2aVCME7BiDFJMzjOXznGxZKfynys1DMw6md8dXSg/2d3kHyalozDGc95fv2HKk
	 ZPX50C8RmmMj7P/o30xqdM7I5/79BLWdxbGX3JfYtEIId0HDEQt65H00/6ja/yVByj
	 H4SgldtldYdsaTlN1z01kOVwJtend8b1MzxtN1bHaPI0pf9G7VWGlU1QKSMZEXOP6R
	 cP9N8Kt73xpOw==
Message-ID: <e9b19fa0-4d07-445a-aed6-e041300425ef@kernel.org>
Date: Sun, 16 Mar 2025 09:27:08 +0800
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
Cc: chao@kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] erofs: allow 16-byte volume name again
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20250225033934.2542635-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250225033934.2542635-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 2025/2/25 11:39, Gao Xiang wrote:
> Actually, volume name doesn't need to include the NIL terminator if
> the string length matches the on-disk field size as mentioned in [1].
> 
> I tend to relax it together with the upcoming 48-bit block addressing
> (or stable kernels which backport this fix) so that we could have a
> chance to record a 16-byte volume name like ext4.
> 
> Since in-memory `volume_name` has no user, just get rid of the unneeded
> check for now.  `sbi->uuid` is useless and avoid it too.
> 
> Fixes: a64d9493f587 ("staging: erofs: refuse to mount images with malformed volume name")
> [1] https://lore.kernel.org/r/96efe46b-dcce-4490-bba1-a0b00932d1cc@linux.alibaba.com
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

