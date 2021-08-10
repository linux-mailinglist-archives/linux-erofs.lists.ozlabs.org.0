Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 022013E8687
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Aug 2021 01:30:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gkq1w6gQsz309j
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Aug 2021 09:30:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rDBruIyd;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=rDBruIyd; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gkq1t1Zz4z3015
 for <linux-erofs@lists.ozlabs.org>; Wed, 11 Aug 2021 09:30:26 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF6AE60551;
 Tue, 10 Aug 2021 23:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628638224;
 bh=qXqqVuYjXKpXw5v4+PCrqbY1ZfFdvKd0EthNnRwHiiU=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=rDBruIydLEOrsMgZeC/KueX3urnTJSTmVoAI7jvjhjnCtJzCx8l8q9uyfKHeOlEUU
 QvL0vkLMUtULSjWKiHk3P5nzCYIZg8DfbuYetfU6U7UapaWD3RoPT0ZX5FqHOZY6IY
 dq+aH/+vl9dg9MaOHwtBXZz2xt2y7QBQBQJ8jtdzL2nasqjMHlUADDjDcYk44qDmio
 b6STbhE8wHmLtasZUzJHk0COCMu4Ueh+CLxZ+G9cSOiPxJZGCxBLBYiq/+6PksgMFL
 62yF2F2CRkBApYcSU3rHNUh/vs0LIAWdlc9upGxQdLWZ4XyjRUj2XF1QO/AQ4m7/sa
 r89XzH4PqHnGQ==
Subject: Re: [PATCH] erofs: remove the mapping parameter from
 erofs_try_to_free_cached_page()
To: Yue Hu <zbestahu@gmail.com>, xiang@kernel.org, linux-erofs@lists.ozlabs.org
References: <20210810072416.1392-1-zbestahu@gmail.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <1533fccf-f032-f390-3ec4-3f39612ab60d@kernel.org>
Date: Wed, 11 Aug 2021 07:30:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210810072416.1392-1-zbestahu@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
Cc: huyue2@yulong.com, linux-kernel@vger.kernel.org, zbestahu@163.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2021/8/10 15:24, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> The mapping is not used at all, remove it and update related code.
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

