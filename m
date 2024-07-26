Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C9993D0BB
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Jul 2024 12:00:02 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YPqvbJDR;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WVjsr3S7yz3dFm
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Jul 2024 20:00:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YPqvbJDR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WVjsn0L4xz2yvk
	for <linux-erofs@lists.ozlabs.org>; Fri, 26 Jul 2024 19:59:57 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id D5338CE1349;
	Fri, 26 Jul 2024 09:59:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0718CC32782;
	Fri, 26 Jul 2024 09:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721987995;
	bh=IL2mDob2D8AP07ZpmBAbnW1muMQg83LKgAZuHdRHSQA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YPqvbJDR8u/xItCvxqxH3MqoQ/XFcNswt9WTmb99d4OwT3SGO08q7/OlwAJp9qQ9h
	 wdnYw4XUXE7tXYUuvingrqpNHjK2C5x7OdwLIKyn/JyeoD2Od6vjo9m2r1w/XGpgED
	 VKU3Be4YqYpcUIrbuPq8OR0tZb+oyMVbqRn++nP7O+eyiSTAb4jRSr6FRUceF5i58a
	 +BadcJ9liT2EWVhHhSZFonca9lfEv5MCHwmbCTE+X8RNIMuUVOJ7eMA1cjwPQZKgNk
	 KI8IkH4f4snxO8B20xnMZo+s/TQ1khbfwCY8pqc6GSpGeaMOXpk9SzlzWbm8wnI7vV
	 eEP14XgJvWqNw==
Message-ID: <beffc700-da06-4584-b234-f5240f09cd5d@kernel.org>
Date: Fri, 26 Jul 2024 17:59:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v3] erofs: add support for FS_IOC_GETFSSYSFSPATH
To: Huang Xiaojia <huangxiaojia2@huawei.com>, xiang@kernel.org,
 huyue2@coolpad.com, jefflexu@linux.alibaba.com, dhavale@google.com,
 yuehaibing@huawei.com
References: <20240720082335.441563-1-huangxiaojia2@huawei.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240720082335.441563-1-huangxiaojia2@huawei.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2024/7/20 16:23, Huang Xiaojia wrote:
> FS_IOC_GETFSSYSFSPATH ioctl exposes /sys/fs path of a given filesystem,
> potentially standarizing sysfs reporting. This patch add support for
> FS_IOC_GETFSSYSFSPATH for erofs, "erofs/<dev>" will be outputted for bdev
> cases, "erofs/[domain_id,]<fs_id>" will be outputted for fscache cases.
> 
> Signed-off-by: Huang Xiaojia <huangxiaojia2@huawei.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
