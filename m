Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6FC970DC4
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Sep 2024 08:15:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725862526;
	bh=gtzMvuYHU+I3M2CpLSGZgc5/yr8HXOjdAVV10rQJWls=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=bXp8R74q4Y7MTWNX6/VXwsWiLiUtXOybpwQp8uljXFQseo6ZvEyMFQxcnI7kO8Hqm
	 5leywCpb+Q36S/dr9W1D+mmj96Jv17xLLItle6KFLmscRZXlEaJovo1IW7Nt1GSQrj
	 So0HmxwXNIoyvQ7Y/7NAIsSY12buIBe8uECOPhuQn7McFAConITiY8VAuhDED4l9qw
	 DG7HQiGascfrmRVABrB6zwP22EI5DdUKjsi7lN3pJCVhh6ebKShb5JY9A3Nb5+/Ohi
	 W2poyIHoqgioePPpxTX/WbLuKPsPWmtuY1KOl6fAP5t2mqDj3sZa6WIbTgbJEpapKE
	 kBSDzyRgVOoGA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X2Gly32N3z2yN4
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Sep 2024 16:15:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725862525;
	cv=none; b=NZgLxExBuE0B+F67nTitudYiGOqBo0Ak8H962jPsfY6abkBTGZ/HDKAB95l3SADOgwjzgVhnBbSwII9lLeAS+XZ8uNshzUHH6KmfrsHAXl/i6R7bGFOsc7kG2cKNcHF5x0F+YJSUli4+aWEBOJ4RVQFyIKwH/DVnbPY/240Rew8xs+53YDbixv2j9HYWmU5LQUGrXmRdCI8xUpe/xS6WA2IB4kqAweUn85KiDUnqT2B4NmdfDZCxiGa2jZ0QqUaINtEWDInLIYwqwExwA0aTHJW5A+dOjuzQMtTPX0sqBCxLKh4UxRHYd2Ym7NlqgW9miaq+LoPv2dCeMbE3SlwrYw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725862525; c=relaxed/relaxed;
	bh=gtzMvuYHU+I3M2CpLSGZgc5/yr8HXOjdAVV10rQJWls=;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Cc:Subject:To:
	 References:From:In-Reply-To:Content-Type; b=D4FF9+Ye32a6BUho0MIoWD/BQdRmEYSIK60GQlNxGAv5xzw8QDF9Zs6yEf5zbKuQ5XuM3BnGiOOd96wlguEsYr0oBOOJB49b30TEG+ClANELhlWIhybDZVJm8OJXnX4zLPkmw/cQDf8okFnWAQxypWVHhdqws5vBmPaQa//UYmKhkmuEoXx/G6Jtuco8mXV1ZOyxkpzTi0cTvhU0l3Z/QakK22nxliYSKIxFRzW1O0ZqJZylxLV/kZ+/KrOVsSX+dFY3q7jW6DnIBL9Mlc3X5rVdUgGuRxO0kacGnT2K7aSo/LMdKoN+uGuOuJVpC6EHnphwIUi/EUzFnzisWKTANA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ozirto10; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ozirto10;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X2Glx0Rmqz2xZT
	for <linux-erofs@lists.ozlabs.org>; Mon,  9 Sep 2024 16:15:25 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 322DB5C53F3;
	Mon,  9 Sep 2024 06:15:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164FBC4CEC5;
	Mon,  9 Sep 2024 06:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725862521;
	bh=kUW/3P8daJz9MOQ31FwZmx4XcmtHFw1DBdfxm3pzJao=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=ozirto10lWutEbenUc0d7msd23goaNLIcYA2ZQZS6STgxns0VYUwodjtK2lUrkaZp
	 3YVS3NH4eBN6IpnX2uMXQcsLiBDQbIRjHFSFz7R7E9CbMlqtFycHIZll+ow45Fq/Pe
	 LXBJa5rZfcLlP0r3qU62FkY/JSwPBvHTuZyOhg7EbA0GBBufjmEtYhNP3FjV47b33W
	 dpWvXtAm1q+a2AX4rd2e3yZ3YF8Wuke5BREuwXhj15t8iwJjm3cxv2fcIHI3OthM7/
	 r7I5X+HFFQjq8wU+BCmkCF5u6drFXOZ1mammtiaZC2Z9UYlApZEGsEHAvtWNmaSKiq
	 LQlY+U1aY36pw==
Message-ID: <7ae3a417-19ed-4b02-ae17-c9cfe9c05438@kernel.org>
Date: Mon, 9 Sep 2024 14:15:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] erofs: fix error handling in z_erofs_init_decompressor
To: Sandeep Dhavale <dhavale@google.com>, linux-erofs@lists.ozlabs.org,
 Gao Xiang <xiang@kernel.org>, Yue Hu <huyue2@coolpad.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>
References: <20240905060027.2388893-1-dhavale@google.com>
Content-Language: en-US
In-Reply-To: <20240905060027.2388893-1-dhavale@google.com>
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
Cc: hsiangkao@linux.alibaba.com, kernel-team@android.com, liujinbao1 <liujinbao1@xiaomi.com>, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2024/9/5 14:00, Sandeep Dhavale wrote:
> If we get a failure at the first decompressor init (i = 0),
> the clean up while loop could enter infinite loop due to wrong while
> check. Check the value of i now to see if we need any clean up at all.
> 
> Fixes: 5a7cce827ee9 ("erofs: refine z_erofs_{init,exit}_subsystem()")
> Reported-by: liujinbao1 <liujinbao1@xiaomi.com>
> Signed-off-by: Sandeep Dhavale <dhavale@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
