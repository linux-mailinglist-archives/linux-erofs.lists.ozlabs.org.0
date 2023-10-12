Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4AA7C6215
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Oct 2023 03:10:48 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lIlRMdV4;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4S5Wm55L4Hz3c5c
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Oct 2023 12:10:45 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lIlRMdV4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4S5Wlx72SWz2yVh
	for <linux-erofs@lists.ozlabs.org>; Thu, 12 Oct 2023 12:10:37 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2E38C616E4;
	Thu, 12 Oct 2023 01:10:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B22C433C7;
	Thu, 12 Oct 2023 01:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697073035;
	bh=gDcWvd8c83WQi7qJGHm8pS0oFCedA+sEFdt+1He8YaY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lIlRMdV4Ocyyam4qLfeDwCPtPPdzUdXgtqFQSwMMoEgqAcw6BMdxgC4TujVYPtS48
	 e/k+5OdxKzd243XfclE9qcObso99i+3k0kUzfCXH2XmyKUt/7RUk8scQUjfZKGpBw4
	 p3sIASpbPm8QNgjAftxjMEqz0X8veDr2e4iAm7/qx2sQ5Eq7Bv2pqZALx7huDf6zqE
	 vzN+OJXnLNoJcyVXjbt3RVomwvLf3dMQn2PB9rdzHrq2bUM1IUnmH4fuBfqSsUBjLA
	 u6i695+CrJ3VigSi9E4sdvKuZ/0iTuCQpFCzRgdcBjl6D53WZc6sNoLiMjI/cgryRv
	 KLB6M1ehLULqg==
Message-ID: <1a4d325b-d3a8-121b-1118-934fafcc8ebe@kernel.org>
Date: Thu, 12 Oct 2023 09:10:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] erofs: fix inode metadata space layout description in
 documentation
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>,
 Tiwei Bie <tiwei.btw@antgroup.com>, linux-erofs@lists.ozlabs.org,
 xiang@kernel.org
References: <20231010113915.436591-1-tiwei.btw@antgroup.com>
 <9a6ccef5-3a35-ae0d-2a9c-1703c5038c81@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <9a6ccef5-3a35-ae0d-2a9c-1703c5038c81@linux.alibaba.com>
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
Cc: Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, ayushranjan@google.com, Yue Hu <huyue2@coolpad.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2023/10/10 21:06, Gao Xiang wrote:
>> Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
> 
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Looks fine to me for the version in dev-test branch.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
