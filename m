Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D123E8685
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Aug 2021 01:30:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gkq1j3jvdz309K
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Aug 2021 09:30:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pOsrZWHh;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=pOsrZWHh; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gkq1d67nQz3015
 for <linux-erofs@lists.ozlabs.org>; Wed, 11 Aug 2021 09:30:13 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 76C6960551;
 Tue, 10 Aug 2021 23:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628638209;
 bh=y3cWTqqjb1WsGKSlACTRwaVwEb56Zhd6VF470hJIM1g=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=pOsrZWHhre2TlMiHrkNqOgf5vclnE2Lcm/rvVBWryKYABEy5H6DQx7jaV9ohDqT3o
 gCM+tD/H9zwkwyL90PmNlf8EUMBnEqg8FKNyUHILaZFLWr+ECoDDVUwigYcsBCU85S
 OioOUaGGinQCnOA9RSNp0VHzditH43qXlqMwTNYFx6qApkO82YeLzKPDY1Ds0FCO0H
 bsFS3Eog2ww5boCV8iVaoPPwhBCpk3vA8HXmfxyyriIbTFEUkKT4SmdnLH+c6jlbqa
 Tv/oGkuUdFdvWKLcKMuembmBxL+cfehyLknY8JwWjyWKgY6WYtuxJHDqvg1+Omv4zv
 QJyPhgZQYUp8A==
Subject: Re: [PATCH] erofs: directly use wrapper erofs_page_is_managed() when
 shrinking
To: Yue Hu <zbestahu@gmail.com>, xiang@kernel.org, linux-erofs@lists.ozlabs.org
References: <20210810065450.1320-1-zbestahu@gmail.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <5d83c8be-b7d1-d359-61e0-04a4aed2febf@kernel.org>
Date: Wed, 11 Aug 2021 07:30:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210810065450.1320-1-zbestahu@gmail.com>
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

On 2021/8/10 14:54, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> We already have the wrapper function to identify managed page.
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
