Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4183E976534
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Sep 2024 11:09:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1726132145;
	bh=HVXOLWyWNS1Std2abaKWJVXIf0uhECWSDcSunqXcH+g=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=ALHi9tGFmm98d1bLWUQmbyWRoFehj4H9P4CyCkVpuFHhn6JPtgaIMJ2uYanGwEe37
	 6v4apvko0ABGXptYKd3kWMmrjjM4qdG9UuOuB9h6ljBHYHFGTAQqkPYYOMDwSRGclF
	 F86BSVurOH+2v2QAWlWxi7c/7DaIe9BDO0BzRdXZ90CBWs+NhWENJInZ4Ftw9tiS3U
	 Pe7luDKtlAVHAXnoAmU+9l/w8Jrzyay9gQR7McpIrCZiC5YS3pfygxMPCF5fJ/G8uP
	 /CD5fxC0jlb8++a0HTAIR9CGFJj7oAEeMtacta6I3IMvgyk9OH/Hp5l3WYe0XYBZs8
	 Zdd9gWil3tAIQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X4BSx1YVtz2yVX
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Sep 2024 19:09:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726132142;
	cv=none; b=dmJ16Z/efoCmZI6HBmJigVNWcFic+QRlFPHp7dQQukHXky24CPXzbEq5Vm+JFPS1AjkUR7DU6CcKKOKn63Qd0EcZzjQOFC1HAUw6DiiAmtCGdtAVyGdvXaG+Jlm9awU81F/GUDcwu/7Ntj/xSOJfBHGh0d2eIWPONb5Ft10vtqRi1jkdOmbDDZYETNQrnbyxxVa8spuETZvepJ6lvigBx75bO/+tK5OIOJhNs1brMkeAlh3OqkmvEmzNWxiq4q8307uNvPEQMQ0g8zoyAB7JcwshvFpBEh2D7kJz+fzAlg3nqB9v2mm//cLIaPZ67uVIW1YKtYY8DakrX/7GMPSzpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726132142; c=relaxed/relaxed;
	bh=HVXOLWyWNS1Std2abaKWJVXIf0uhECWSDcSunqXcH+g=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q8F1rw0vnhgZebr5jYDQuU9S8+Q/GYOOskp+801EWUYAQ3OJgS3XivpWja7E3tE1n6ziZ7rPixq0Xtp9bHMfixiLWgGdxMcHKicmFH2EI+RqLoRX+hMBIMgccOua8TG5Fxh0H/88aBl4yHKm794gtB071qVIiEaCWJ0/BLgE286AzXZeDwxRsUNTmbB2ucBWv4/FoZ49q7YIpbuEVj+vgS2HCLoX7PmXhObBJytUaSdug/tVvWONAB0kwbC7f4gApwXOdGXE1i+p1wVxytKAW2UBgpkoNqNYsoT/gkIBKa5P1bLawYEKEgkjp8ogEZkwU1ncVX879DqWhCgzy1DYcQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=cxKbzOYe; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=cxKbzOYe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X4BSt5FvXz2yMF
	for <linux-erofs@lists.ozlabs.org>; Thu, 12 Sep 2024 19:09:02 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 10B635C59FA;
	Thu, 12 Sep 2024 09:08:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F023C4CEC3;
	Thu, 12 Sep 2024 09:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726132140;
	bh=d4ks9mtR7upiaSaXYwa6WztAU/vsuQg//2VO7mzJKYA=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=cxKbzOYemlPhxUsxRgFLiv7Zs6Xh5VAc8RTXYK1tTSP3I8UsSRXs6jEKKIMdAYtTa
	 +Lq95LF18D5hJMoc/NSkJCniAF2KFFuacM7s8zE4XtkSUV8mPeJ97K4+fQScH3mQGJ
	 XGebjkAWUaazVCIRAXZatCp63A4TPSUU6oJmUL2r7VDBcyEkmsj8+EsazUoTwn+9ox
	 kipAL3V4ny1OiDirGtM3sQXfVsmmZ4dTGOO2NGWyv80QJZgHO9Ey3UTm7CIlqQqPz3
	 CBfiaRHjwb1lCFixP2bLhtrLGqrIec7WMayAPxXa7byIoHVFf0RIp5mOE+lcox7r4z
	 nAVwuZCAk0Fdw==
Message-ID: <0600636f-ff01-4175-9de7-4a4fcf7e5669@kernel.org>
Date: Thu, 12 Sep 2024 17:08:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: reject inodes with negative i_size
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240912083538.3011860-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <20240912083538.3011860-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2024/9/12 16:35, Gao Xiang wrote:
> Negative i_size is never supported, although crafted images with inodes
> having negative i_size will not lead to security issues in our current
> codebase:
> 
> The following image can verify this (gzip+base64 encoded):
> 
> H4sICCmk4mYAA3Rlc3QuaW1nAGNgGAWjYBSMVPDo4dcH3jP2aTED2TwMKgxMUHHNJY/SQDQX
> LxcDIw3tZwXit44MDNpQ/n8gQJZ/vxjijosPuSyZ0DUDgQqcZoKzVYFsDShbHeh6PT29ktTi
> Eqz2g/y2pBFiLxDMh4lhs5+W4TAKRsEoGAWjYBSMglEwCkYBPQAAS2DbowAQAAA=
> 
> Mark as bad inodes for such corrupted inodes explicitly.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
