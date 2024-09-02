Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED53968162
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 10:08:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wy1bt5QPfz2yNR
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 18:08:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725264519;
	cv=none; b=Dg08kN5addhcCvP+nNBAF2mzAGMxyp/czj/Egxw8XSkDhpzkRrAyY3zwd8jdRtd9n9s8q24ErRdrKAKiuO6c0f2Tk6dT//+drF/0eQlV68g91b6qrqmjkSJ5pFMjkWp3w1wWTgJTW2dNnCF6gvJo7Tx1fyHGn37xcfauiVJg30hExWPJqNC/7Ymxo1i36MPnltxk5dN1C/kj3JCnkr/oiMY4szU0RH6XdXX3B+GcSkP9olk1tc3E4kwD+nPC/LxCXdy2YM32LN/+xftO/LchLRLnwHxa4taLmY39vYIzzmbUstyIRQsBDrbtWN5GBNiKnZfh7SV/OjlwDA8nBI5c+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725264519; c=relaxed/relaxed;
	bh=vOMkQ7uywlcV9asZwFsNs9q0kmLYDOxSpefUXZ4ipyE=;
	h=DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=gj5VFWy8c/CznThMAIBUiJJIwF0PhNGeICx6ZNR8yTCDU6A2W+dmrxsjNYYedvBCOcSxM/qzX9tUX2JO2Gpz2zbLGqAR9cdBexU7gxvclO4JXgl3OC9ZcO59G6j0axEtFbCP6wtDyRoI5woC0hF2D8XFXUy5ReGGivMzwGJAUfMZjeFhi1A1/xpGiuiRTLIiBJt5KfDZZmpchZwy5yNqWTSzZFrW1g6OhNcyYjnPpjY8oSW+0Q/ZLLeMNO6YOYhVQ51Hw0j4CFWQzgexKGTPG95gejt5xbZSb3y6Iz8B2a2M+q9RZCEvGfBnIggqA9XMvFDoCI5RseH7E2kp4qZFoQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=fzTMNd+6; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=fzTMNd+6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wy1bp16Gzz2xHK
	for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2024 18:08:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725264513; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=vOMkQ7uywlcV9asZwFsNs9q0kmLYDOxSpefUXZ4ipyE=;
	b=fzTMNd+6GjKsXOgLsHb+MrOu7qn5+UikL1TDOS07Gq6e1B45NqMLtJzGPlJ2PrjXqleuOTe8EZ2l7DkaqJdIn9buqz7pszWeOzudqArdGcw+nEKAsNzs0l/YObtZh2BIVWJhQeiKMjGDmdl6sOeY5jqIkl7CSTvyjpDwiN/8ouk=
Received: from 30.221.132.251(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WE5Mz5Z_1725264511)
          by smtp.aliyun-inc.com;
          Mon, 02 Sep 2024 16:08:32 +0800
Message-ID: <38095394-b7ea-4aaa-a209-07f4dd6afcd8@linux.alibaba.com>
Date: Mon, 2 Sep 2024 16:08:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/2] erofs: use kmemdup_nul in erofs_fill_symlink
To: Yiyang Wu <toolmanp@tlmp.cc>
References: <20240902080417.427993-1-toolmanp@tlmp.cc>
 <20240902080417.427993-2-toolmanp@tlmp.cc>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240902080417.427993-2-toolmanp@tlmp.cc>
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/9/2 16:04, Yiyang Wu wrote:
> Remove open coding in erofs_fill_symlink.
> 
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Link: https://lore.kernel.org/all/20240425222847.GN2118490@ZenIV
> Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
