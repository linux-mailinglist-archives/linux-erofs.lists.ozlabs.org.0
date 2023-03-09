Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1326B26EE
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Mar 2023 15:33:27 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PXWrP4SNhz3cd2
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Mar 2023 01:33:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XXZHBnBo;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XXZHBnBo;
	dkim-atps=neutral
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PXWrJ0h2Jz2yRV
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Mar 2023 01:33:20 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id 319B0CE235D;
	Thu,  9 Mar 2023 14:33:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45809C433EF;
	Thu,  9 Mar 2023 14:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678372394;
	bh=w7AQnZqpeLl/SNOfri6RykY1AipM/QRAUfB90P6D5xc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XXZHBnBoDdhlZQXsfxKM881hFTUJ7D8ODeBfZwp6BS3wVxToeHOWrJYHS5XI/GTjG
	 uh13EYxvVj+RC2bEI7gcO2U5gmnAzio1QHhdEK7Nuz5DJhJjXYVA4Oj1KjkVERGyfn
	 5CtmMIwn23/81fzFpyBP9gI5it5MeaFyUOH9faCcxdvGzYIY3wuJrTlvSvUNtQ5lcH
	 h7IMvN3d/Sup1i9DrdVG9PQAJIy5rhnfNKS2kFTdhjwe4VwWwt27/SEH1RIaJIxAtH
	 D7ol5HAeHQPmHyEq/tAct7gntWO/rapt5HU7MN6ekX2OnMEtBOxwEKRBihXxgONqpR
	 9SOowHDhyI6xA==
Message-ID: <a238dca1-256f-ae2f-4a33-e54861fe4ffb@kernel.org>
Date: Thu, 9 Mar 2023 22:33:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] erofs: use wrapper i_blocksize() in
 erofs_file_read_iter()
Content-Language: en-US
To: Yue Hu <zbestahu@gmail.com>, xiang@kernel.org,
 jefflexu@linux.alibaba.com, linux-erofs@lists.ozlabs.org
References: <20230306075527.1338-1-zbestahu@gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230306075527.1338-1-zbestahu@gmail.com>
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
Cc: huyue2@coolpad.com, linux-kernel@vger.kernel.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2023/3/6 15:55, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> linux/fs.h has a wrapper for this operation.
> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
