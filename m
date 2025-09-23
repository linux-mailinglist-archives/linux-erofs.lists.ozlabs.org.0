Return-Path: <linux-erofs+bounces-1083-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BA310B94D09
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Sep 2025 09:39:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cWBhC4DbYz2xcG;
	Tue, 23 Sep 2025 17:39:39 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758613179;
	cv=none; b=YEbxDwhiRPiFYyey+iGkZ9FccdJBn07WhudmpLpUokHwwHicmJxFUwhTZHFhHGqWGkSkh2eFYOzOjdVc5wyno/ICkDoa741xQr73L50YF12A55btEIwGMAYl7JGOZgd2x8MrZT0dLClgDAzeQR8fEyH6jgXgwxs/RrD4xikEvUPrg+J5ZXPdQ4x4RV0hDFqajJQSFN/ZYjs7+0qocC4uml3fuFUH3RCvWYYVSZTw2kJqwz+Z+f3aVx9KzMDGAIg84AQxjLbdfBpKTu28d9mXnlx/cuCBjYtGr8ukn3AVY5omsCrtIBruZQ5veK7JMsg+pYP4ellLD40LROrv2u11PA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758613179; c=relaxed/relaxed;
	bh=Zyzs6I3NcxKAkQmkUq0pekU0CYyxFyr0VGJJai0rJXM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Z7D4EeK3UATHooZAXYNT9L8u8U4Bv9JRZGhgkqrQW1aYvcUz+QZ/EfcMYwDNOJZkoMKOrOyO9qoxO47C4BnX2cl1pf2O93cE96Nw6cPtNdgrsIbiY718qovalrQ9CPOdkucyp/TXj8Kl3WjMNcFJ85598wjIUw0Uz/o5Ee2e5R549Or8umnSBzuD6PYKgnxyAioCB8dAJTnxTzam2NKQu6Ze9ig59s/F82tUyXnGyekspwgD0YqgMTnLK1naVAua95nQ+w2BmrnNLjT1BGWt7pHAlwjknfuRtKIL5m6Ppfjk80bsJ7Gwzvgz/8H1yEOXSJsRLh2DaV/h182Azw26Yg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lJ5OR6Dn; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lJ5OR6Dn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cWBhB6VBJz2xQ3
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Sep 2025 17:39:38 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 820B5601D9;
	Tue, 23 Sep 2025 07:39:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B4AC4CEF5;
	Tue, 23 Sep 2025 07:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758613176;
	bh=4LD+9tlazlAYecabznNJ1WYuNPYD1yZ/lQfKVw3iKtk=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=lJ5OR6Dnb7V7/Myws4odvsdC0WnZLsuS+NLc54W+QKkYmDIuuU2QgwZUnrnONeQRz
	 TMpZ9GQedfHihALvGkmrufqvPE4UV/h8ZaJGn4GYhgQZ/0tQLWvAVDSqdXXc70B1Ex
	 qfpUIQ6YnyGSSW4+sHezv4gMitLMUAorPvEe2lLNTOTzHndy482sAEmjpA0mHW+2Xf
	 NAD6Y32/IALEUHVfroobArKsgTtEqeQbcbKBF4nogRcZRxsZwd5bp8QhsrTKxBhn/d
	 2al5yvNGTvwUWEuzrTGUaEHwtvvubnqWc9H+JxsVsrfSCQnwRfFGw/CJn2AxCIVX8s
	 U68DX1hrQlgmA==
Message-ID: <f6f2c45d-39ae-4065-9b14-f0c94a41965d@kernel.org>
Date: Tue, 23 Sep 2025 15:39:31 +0800
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
 linux-kernel@vger.kernel.org, Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH v5] erofs: Add support for FS_IOC_GETFSLABEL
To: Bo Liu <liubo03@inspur.com>, xiang@kernel.org
References: <20250923070112.16644-1-liubo03@inspur.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250923070112.16644-1-liubo03@inspur.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 9/23/25 15:01, Bo Liu wrote:
> From: Bo Liu (OpenAnolis) <liubo03@inspur.com>
> 
> Add support for reading to the erofs volume label from the
> FS_IOC_GETFSLABEL ioctls.
> 
> Signed-off-by: Bo Liu (OpenAnolis) <liubo03@inspur.com>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

