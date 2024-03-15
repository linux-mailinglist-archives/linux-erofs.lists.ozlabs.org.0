Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0525E87C7CA
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Mar 2024 04:00:19 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fcfKqZvb;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Twprw5V2Lz3vf4
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Mar 2024 14:00:16 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fcfKqZvb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TwpqZ2C7Yz3ddR
	for <linux-erofs@lists.ozlabs.org>; Fri, 15 Mar 2024 13:59:06 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id DCF8FCE1F52;
	Fri, 15 Mar 2024 02:59:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8AAC433C7;
	Fri, 15 Mar 2024 02:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710471540;
	bh=qXwkEeaqeKDKD2TfToeMulydtYdY4J94j5SABNK7Rcs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fcfKqZvb5UrJHQjPhuVJO4CleCyL+p3TZYKAsKfbcp3lvlbMgzG7HNZA8+c5MgU0y
	 OJM3MEWswFoRTuWsEjsy2g7k5TxYkgCZeLU30kvFscS5TamWw/060mP/6vEBdLZk2S
	 PKfoIYqe/yt+YUvY8do97prbAk3iAyPqJf4QJ8LLklMcLYaHrinM6V59QDnkpqv7Qw
	 VI07NO6yHDre02yHmFbPbYQBIpnQoKN2DumijMkIhtsXqzBbspGqfi7P/cFk1FeEd5
	 thXTsyWz/xC09T0E3HFD7gySqBfMJ/OQEj1UbH4o3VdXwqkzJgzfHUBOnpFlLy3Pu/
	 YsNc6tIeiK9Fw==
Message-ID: <e558d9ba-9444-4cd1-804c-fd678dac46a1@kernel.org>
Date: Fri, 15 Mar 2024 10:58:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: erofs: add myself as reviewer
Content-Language: en-US
To: Sandeep Dhavale <dhavale@google.com>
References: <20240314231407.1000541-1-dhavale@google.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240314231407.1000541-1-dhavale@google.com>
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
Cc: linux-erofs@lists.ozlabs.org, kernel-team@android.com, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2024/3/15 7:14, Sandeep Dhavale via Linux-erofs wrote:
> I have been contributing to erofs for sometime and I would like to help
> with code reviews as well.

Thank you for the effort and looks good to me. :)

> 
> Signed-off-by: Sandeep Dhavale <dhavale@google.com>

Acked-by: Chao Yu <chao@kernel.org>

Thanks,
