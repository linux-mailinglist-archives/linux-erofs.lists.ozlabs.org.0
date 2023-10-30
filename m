Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1291C7DBC54
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Oct 2023 16:04:14 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mJdyCBVb;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SJxPR6z1Mz3cNk
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Oct 2023 02:04:11 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mJdyCBVb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SJxPN65Rmz3bwj
	for <linux-erofs@lists.ozlabs.org>; Tue, 31 Oct 2023 02:04:08 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 075DCB8094D;
	Mon, 30 Oct 2023 15:04:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59E3C433C7;
	Mon, 30 Oct 2023 15:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698678245;
	bh=0d3/+GxGMdfOff0/hkwfnIJbNqj8qgEyQZNmJtkQDYA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mJdyCBVbD3Ow1xcl0bn96Gny34+Y0wRnViaDVV9tU9XqjRT4ZAqRr/dXVuU5w4bMn
	 8zxuF6ZjskjGvpzcRGNwyhPYz+Et0/Zl7F/jaq1kYtI9ksHwGpNv/lHtDBMqwPifCx
	 P/NZPic9P3Q4Chmxj/zrp04OWpIBxQLXoWZQy920m2Lo1yxaAbxH6OHNuD97DnYtXf
	 cb5Qw6vd2sAQUwaSbWpMfmmcPMdr/PGG8Qy8t/J6gKgnk5D1h7UMeHsOZbi+MnUD1b
	 /cLdbi1qyLsMFePON0KSbilKtsgIyFUTMByb9daofg39FthHsKPtoJ0DLGDqXg8dqT
	 b2X3IcOHHbN4A==
Message-ID: <a415467d-01a1-500e-130c-e240ffbbb00b@kernel.org>
Date: Mon, 30 Oct 2023 23:04:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/2] erofs: tidy up redundant includes
Content-Language: en-US
To: Ferry Meng <mengferry@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20231026021627.23284-1-mengferry@linux.alibaba.com>
 <20231026021627.23284-2-mengferry@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20231026021627.23284-2-mengferry@linux.alibaba.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2023/10/26 10:16, Ferry Meng wrote:
> - Remove unused includes like <linux/parser.h> and <linux/prefetch.h>;
> 
> - Move common includes into "internal.h".
> 
> Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>
