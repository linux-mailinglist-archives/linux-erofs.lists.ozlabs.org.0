Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B621C917ACF
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Jun 2024 10:22:44 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OGDX6T8y;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W8F7M0jrKz3cGC
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Jun 2024 18:22:39 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OGDX6T8y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W8F7H0fdBz30VT
	for <linux-erofs@lists.ozlabs.org>; Wed, 26 Jun 2024 18:22:35 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 45A4C61977;
	Wed, 26 Jun 2024 08:22:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C54CC32789;
	Wed, 26 Jun 2024 08:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719390147;
	bh=uBkFsUSalWeUG7KdDMLqVksw2dCT8FElXIHNzMiTzXw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OGDX6T8yFD1Gd6yv2ZR6zpW8SxEqo27VR25cLqoDMyeJmkxF3LH48vMwqEo/nUxFC
	 iHa1m7JDmIrJH4yXmG4RBtY6C9TRlUFCFJcbvG3XZrM094Z5MLIYdzQY6XzhRByqPy
	 tMbBFKbpYY9BctE/3n7qn2dK7YV+hTEUErtW69oxFV21sDWigWlHYi4ibTrADnLmqB
	 nk5PA0eYSs/Qay8sSwfIuLI6fAhPcLaCeUXKtPwGp0fbrwezLzWC6HC+e/MPrUhFBM
	 mcz9pWIlVu+kgSv8j7Ds4KkGkzRTw4h4R3XDoQXgRgz86DrJsEmd1lZSy0yQ0SFHxi
	 2COLYX6rI+idg==
Message-ID: <89172538-f165-4b37-af83-942604d1baec@kernel.org>
Date: Wed, 26 Jun 2024 16:22:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] erofs: convert to use super_set_uuid to support for
 FS_IOC_GETFSUUID
To: Huang Xiaojia <huangxiaojia2@huawei.com>, xiang@kernel.org,
 huyue2@coolpad.com, jefflexu@linux.alibaba.com, dhavale@google.com,
 yuehaibing@huawei.com
References: <20240624063704.2476070-1-huangxiaojia2@huawei.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240624063704.2476070-1-huangxiaojia2@huawei.com>
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

On 2024/6/24 14:37, Huang Xiaojia wrote:
> FS_IOC_GETFSUUID ioctl exposes the uuid of a filesystem. To support
> the ioctl, init sb->s_uuid with super_set_uuid().
> 
> Signed-off-by: Huang Xiaojia <huangxiaojia2@huawei.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
