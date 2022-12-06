Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C6E644583
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Dec 2022 15:22:26 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NRN0c2gdRz3bYD
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Dec 2022 01:22:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=C20jz1UP;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=C20jz1UP;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NRN0V4cDnz3bWv
	for <linux-erofs@lists.ozlabs.org>; Wed,  7 Dec 2022 01:22:18 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id B76BEB815A6;
	Tue,  6 Dec 2022 14:22:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35EFC433D6;
	Tue,  6 Dec 2022 14:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670336533;
	bh=TpKURkk+sASQmNIaZKp+Krx4lS0RDFgA3OYkx6AYYSI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=C20jz1UPh+YIQkWDZfE26I50SgijlSNRFakXXnU4ETUyKADHFhOzBFUyzidFKv6y+
	 msrJZmzoIEFsnCQ0fmR3568WPwUhsVY40sGV+WYvt1IqAa7RpDEcMMBzSTav2Zv+NX
	 KjrsoRHgqR0H4jg5LzC8vxbbzB7MSL/uduqyZOtVHJSev+2Xo6hCzNrWlhZGyfNrYq
	 vwuDJIywf0ffrEtWnVK4kBN6ZVTnKzON9ScsHTTTpSpQZ0xLKZ1W8EB9Wya06XKh8a
	 SIOMSNHSX+1Q0kP5WQQXNdm4OC1zUQi1q5fBAIxkyyrBVk5WImgBTm6NgDjuVQIr28
	 n0qxwXvZMMmHA==
Message-ID: <ea5b67c4-d7ab-199c-d4bd-c6d353145864@kernel.org>
Date: Tue, 6 Dec 2022 22:22:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] erofs: update documentation
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20221130095605.4656-1-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20221130095605.4656-1-hsiangkao@linux.alibaba.com>
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

On 2022/11/30 17:56, Gao Xiang wrote:
> - Refine highlights for main features;
> 
> - Add multi-reference pclusters and fragment description.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
